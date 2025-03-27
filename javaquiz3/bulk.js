import { formatDate, formatDateTime } from '../helpers/dateUtils'; // Assuming these utility functions are created
import { mutateLineItemModel } from '../helpers/errorHandling';
import { RTB_LI_VALIDATION_REASON_TYPES } from '../helpers/constants';

export const transformations = {
  periods: {
    Set: (parent, _property, _value, _config, context) => {
      const { timeZone } = context.order.campaign;
      const { order } = context;
      const { periods: lineItemPeriods } = parent;

      const startDate = formatDateTime(order.startDate);
      const endDate = formatDateTime(order.endDate);
      const currentDate = formatDate(new Date(), timeZone);
      const orderStartDate = new Date(startDate) < new Date(currentDate) ? currentDate : startDate;
      const orderEndDate = formatDate(new Date(endDate).setHours(23, 59, 59));

      const periods = lineItemPeriods.map(({ start: currentLineItemStart, end: currentLineItemEnd }, index) => {
        const start = new Date(currentLineItemStart) >= new Date(orderStartDate) ? formatDateTime(currentLineItemStart) : null;
        const end = new Date(currentLineItemEnd) <= new Date(orderEndDate) ? formatDateTime(currentLineItemEnd) : null;

        if (start && !end && index === lineItemPeriods.length - 1) {
          return { start, end: orderEndDate };
        }
        if (!start && end && index === 0) {
          return { start: orderStartDate, end };
        }
        return { start, end };
      }).filter(period => period.start || period.end);

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
      const extendedOrderEndDate = formatDate(new Date(formattedOrderEndDate).setFullYear(new Date(formattedOrderEndDate).getFullYear() + 1));

      const pendingBudgetFlights = budgetFlights
        .map(budgetFlight => ({
          ...budgetFlight,
          startDate: budgetFlight.startDate.substring(0, 10),
          endDate: budgetFlight.endDate.substring(0, 10),
        }))
        .filter(({ endDate, startDate }) => new Date(endDate) >= new Date(currentDate) && new Date(startDate) <= new Date(extendedOrderEndDate));

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
        const newStartDate = (() => {
          const budgetFlightStartsBeforeOrder = new Date(budgetFlight.startDate) < new Date(formattedOrderStartDate);
          if (budgetFlightStartsBeforeOrder) {
            return new Date(formattedOrderStartDate) <= new Date(currentDate) ? currentDate : formattedOrderStartDate;
          }
          return new Date(budgetFlight.startDate) <= new Date(currentDate) ? currentDate : budgetFlight.startDate;
        })();
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