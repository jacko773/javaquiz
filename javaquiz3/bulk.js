import { formatDate, formatDateTime } from '../helpers/dateUtils'; // New utility functions
import { mutateLineItemModel } from '../helpers/errorHandling';
import { RTB_LI_VALIDATION_REASON_TYPES, DATE_FORMAT, DATE_TIME_FORMAT } from '../helpers/constants';

export const transformations = {
  periods: {
    Set: (parent, _property, _value, _config, context) => {
      const { timeZone } = context.order.campaign;
      const { order } = context;
      const { periods: lineItemPeriods } = parent;

      const startDate = formatDateTime(order.startDate);
      const endDate = formatDateTime(order.endDate);
      const currentDate = formatDateTime(new Date(), timeZone);
      const orderStartDate = moment(startDate).isBefore(currentDate) ? currentDate : startDate;
      const orderEndDate = moment(endDate).endOf('day').seconds(0).format(DATE_TIME_FORMAT);

      const periods = lineItemPeriods.map(({ start, end }, index) => {
        const isStartValid = moment(start).isBetween(orderStartDate, orderEndDate);
        const isEndValid = moment(end).isBetween(orderStartDate, orderEndDate);

        let newStart = isStartValid ? formatDateTime(start) : null;
        let newEnd = isEndValid ? formatDateTime(end) : null;

        if (newStart && !newEnd && index === lineItemPeriods.length - 1) {
          newEnd = orderEndDate;
        }

        if (!newStart && newEnd && index === 0) {
          newStart = orderStartDate;
        }

        if (!newStart && newEnd) {
          newStart = formatDateTime(end, timeZone);
        }

        if (newStart && !newEnd && moment(end).isSame(moment(orderEndDate))) {
          newEnd = orderEndDate;
        }

        return (newStart || newEnd) ? { start: newStart, end: newEnd } : null;
      }).filter(Boolean);

      parent.periods = periods.length ? periods : [{ start: startDate, end: endDate }];
    },
  },
  budget: {
    Set: (parent, _property, _value, _config, context) => {
      const { order } = context;
      const { timeZone } = context.order.campaign;
      const { budgetFlights } = parent.budget;
      const currentDate = formatDate(new Date(), timeZone);
      const formattedOrderStartDate = order.startDate.substring(0, 10);
      const formattedOrderEndDate = order.endDate.substring(0, 10);
      const extendedOrderEndDate = formatDate(moment(formattedOrderEndDate).add(1, 'year'));

      const pendingBudgetFlights = budgetFlights
        .map(budgetFlight => ({
          ...budgetFlight,
          startDate: budgetFlight.startDate.substring(0, 10),
          endDate: budgetFlight.endDate.substring(0, 10),
        }))
        .filter(({ endDate, startDate }) => moment(endDate).isSameOrAfter(currentDate) &&
            moment(startDate).isSameOrBefore(extendedOrderEndDate));

      if (pendingBudgetFlights.length === 0) {
        const { start } = parent.periods[0];
        const { end } = parent.periods[parent.periods.length - 1];
        parent.budget.budgetFlights = {
          startDate: formatDate(start),
          endDate: formatDate(end),
          budget: 0,
          periodType: 'total',
          locked: false,
          useParentBudget: false,
          pacingType: 'asap',
        };
        return;
      }

      parent.budget.budgetFlights = pendingBudgetFlights.map(budgetFlight => {
        const { startDate } = budgetFlight;
        const newStartDate = moment(startDate).isBefore(formattedOrderStartDate) 
          ? (moment(formattedOrderStartDate).isSameOrBefore(currentDate) ? currentDate : formattedOrderStartDate)
          : (moment(startDate).isSameOrBefore(currentDate) ? currentDate : startDate);

        return {
          ...budgetFlight,
          startDate: newStartDate,
        };
      });
    },
  },
  impressionCappings: {
    Set: (parent) => {
      Object.keys(parent.impressionCappings).forEach(id => {
        delete parent.impressionCappings[id];
      });
    },
  },
  modifyLineItem: {
    Set: (parent, _property, value, _config, context) => {
      const { path, error } = value;
      const mutation = mutateLineItemModel()[error.reason] || mutateLineItemModel()[RTB_LI_VALIDATION_REASON_TYPES.ValidationFailed];
      mutation({
        path,
        lineItemToMutate: parent,
        error,
        copyToOrder: context.order,
      });
    },
  },
};