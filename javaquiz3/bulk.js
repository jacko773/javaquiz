import { mutateLineItemModel } from '../helpers/errorHandling';
import { RTB_LI_VALIDATION_REASON_TYPES, DATE_FORMAT, DATE_TIME_FORMAT } from '../helpers/constants';
import { formatDate, parseDate } from '../helpers/dateUtils'; // New utility functions

export const transformations = {
  periods: {
    Set: (parent, _property, _value, _config, context) => {
      const { timeZone } = context.order.campaign;
      const { order } = context;
      const { periods: lineItemPeriods } = parent;

      const startDate = parseDate(order.startDate).startOf('day');
      const endDate = parseDate(order.endDate).endOf('day');
      const currentDate = parseDate().tz(timeZone).startOf('day');

      const orderStartDate = startDate.isBefore(currentDate) ? currentDate : startDate;
      const orderEndDate = endDate;

      const periods = lineItemPeriods.map(({ start: currentLineItemStart, end: currentLineItemEnd }, index) => {
        const start = moment(currentLineItemStart).isBetween(orderStartDate, orderEndDate) 
          ? formatDate(currentLineItemStart) 
          : null;

        const end = moment(currentLineItemEnd).isBetween(orderStartDate, orderEndDate) 
          ? formatDate(currentLineItemEnd) 
          : null;

        if (start && !end && index === lineItemPeriods.length - 1) {
          return { start, end: formatDate(orderEndDate) };
        }

        if (!start && end && index === 0) {
          return { start: formatDate(orderStartDate), end };
        }

        return { start, end };
      }).filter(period => period.start || period.end);

      parent.periods = periods.length ? periods : [{ start: formatDate(startDate), end: formatDate(endDate) }];
    },
  },
  budget: {
    Set: (parent, _property, _value, _config, context) => {
      const { order } = context;
      const { timeZone } = context.order.campaign;
      const { budgetFlights } = parent.budget;
      const currentDate = parseDate().tz(timeZone).format(DATE_FORMAT);
      const formattedOrderStartDate = order.startDate.substring(0, 10);
      const extendedOrderEndDate = parseDate(order.endDate).add(1, 'year').format(DATE_FORMAT);

      const pendingBudgetFlights = budgetFlights
        .map(budgetFlight => ({
          ...budgetFlight,
          startDate: budgetFlight.startDate.substring(0, 10),
          endDate: budgetFlight.endDate.substring(0, 10),
        }))
        .filter(({ endDate, startDate }) => parseDate(endDate).isSameOrAfter(currentDate) &&
                                             parseDate(startDate).isSameOrBefore(extendedOrderEndDate));

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
        const newStartDate = () => {
          if (moment(startDate).isBefore(formattedOrderStartDate)) {
            return moment(formattedOrderStartDate).isSameOrBefore(currentDate) ? currentDate : formattedOrderStartDate;
          }
          return moment(startDate).isSameOrBefore(currentDate) ? currentDate : startDate;
        };
        return {
          ...budgetFlight,
          startDate: newStartDate(),
        };
      });
    },
  },
  impressionCappings: {
    Set: (parent) => {
      parent.impressionCappings = {};
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