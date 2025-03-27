import { format, isBefore, isSameOrAfter, isSameOrBefore, isBetween, startOfDay, endOfDay, addYears } from 'date-fns-tz';
import { mutateLineItemModel } from '../helpers/errorHandling';
import { RTB_LI_VALIDATION_REASON_TYPES, DATE_FORMAT, DATE_TIME_FORMAT } from '../helpers/constants';

export const transformations = {
  periods: {
    Set: (parent, _property, _value, _config, context) => {
      const { timeZone } = context.order.campaign;
      const { order } = context;
      const { periods: lineItemPeriods } = parent;

      const startDate = startOfDay(new Date(order.startDate)).toISOString();
      const endDate = endOfDay(new Date(order.endDate)).toISOString();
      const currentDate = startOfDay(new Date()).toISOString();

      const orderStartDate = isBefore(new Date(startDate), new Date(currentDate)) ? currentDate : startDate;
      const orderEndDate = endOfDay(new Date(endDate)).toISOString();

      const periods = lineItemPeriods.map(({ start, end }, index) => {
        const isStartValid = isBetween(new Date(start), new Date(orderStartDate), new Date(orderEndDate));
        const isEndValid = isBetween(new Date(end), new Date(orderStartDate), new Date(orderEndDate));

        let newStart = isStartValid ? start : null;
        let newEnd = isEndValid ? end : null;

        if (newStart && !newEnd && index === lineItemPeriods.length - 1) {
          newEnd = orderEndDate;
        }

        if (!newStart && newEnd && index === 0) {
          newStart = orderStartDate;
        }

        if (!newStart && newEnd) {
          newStart = endOfDay(new Date(end)).toISOString();
        }

        if (newStart && !newEnd && isSameOrAfter(new Date(end), new Date(orderEndDate))) {
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
      const currentDate = new Date().toISOString();
      const formattedOrderStartDate = order.startDate.substring(0, 10);
      const formattedOrderEndDate = order.endDate.substring(0, 10);
      const extendedOrderEndDate = addYears(new Date(formattedOrderEndDate), 1).toISOString();

      const pendingBudgetFlights = budgetFlights
        .map(budgetFlight => ({
          ...budgetFlight,
          startDate: budgetFlight.startDate.substring(0, 10),
          endDate: budgetFlight.endDate.substring(0, 10),
        }))
        .filter(({ endDate, startDate }) => isSameOrAfter(new Date(endDate), new Date(currentDate))
            && isSameOrBefore(new Date(startDate), new Date(extendedOrderEndDate)));

      if (pendingBudgetFlights.length === 0) {
        const { start } = parent.periods[0];
        const { end } = parent.periods[parent.periods.length - 1];
        parent.budget.budgetFlights = {
          startDate: format(new Date(start), DATE_FORMAT),
          endDate: format(new Date(end), DATE_FORMAT),
          budget: 0,
          periodType: 'total',
          locked: false,
          useParentBudget: false,
          pacingType: 'asap',
        };
        return;
      }

      const modifiedBudgetFlights = pendingBudgetFlights.map(budgetFlight => {
        const { startDate } = budgetFlight;
        const newStartDate = isBefore(new Date(startDate), new Date(formattedOrderStartDate))
          ? (isSameOrBefore(new Date(formattedOrderStartDate), new Date(currentDate)) ? currentDate : formattedOrderStartDate)
          : (isSameOrBefore(new Date(startDate), new Date(currentDate)) ? currentDate : startDate);

        return {
          ...budgetFlight,
          startDate: newStartDate,
        };
      });

      parent.budget.budgetFlights = modifiedBudgetFlights;
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
      const mutationFunction = mutateLineItemModel()[error.reason] || mutateLineItemModel()[RTB_LI_VALIDATION_REASON_TYPES.ValidationFailed];
      mutationFunction({
        path,
        lineItemToMutate: parent,
        error,
        copyToOrder: context.order,
      });
    },
  },
};