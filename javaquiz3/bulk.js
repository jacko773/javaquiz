import { format, isBefore, isSameOrAfter, isSame, startOfDay, endOfDay } from 'date-fns-tz';
import { mutateLineItemModel } from '../helpers/errorHandling';
import { RTB_LI_VALIDATION_REASON_TYPES, DATE_FORMAT, DATE_TIME_FORMAT } from '../helpers/constants';

const formatDate = (date, formatString) => format(new Date(date), formatString);

export const transformations = {
  periods: {
    Set: (parent, _property, _value, _config, context) => {
      const { timeZone } = context.order.campaign;
      const { order } = context;
      const { periods: lineItemPeriods } = parent;

      const startDate = formatDate(order.startDate.substring(0, 10), DATE_TIME_FORMAT);
      const endDate = formatDate(order.endDate.substring(0, 10), DATE_TIME_FORMAT);
      const currentDate = formatDate(new Date(), DATE_TIME_FORMAT);

      const orderStartDate = isBefore(new Date(startDate), new Date(currentDate)) ? currentDate : startDate;
      const orderEndDate = endOfDay(new Date(endDate)).toISOString();

      const periods = lineItemPeriods.map(({ start: currentLineItemStart, end: currentLineItemEnd }, index) => {
        const start = isSameOrAfter(new Date(currentLineItemStart), new Date(orderStartDate)) ? formatDate(currentLineItemStart, DATE_TIME_FORMAT) : null;
        const end = isSameOrAfter(new Date(currentLineItemEnd), new Date(orderEndDate)) ? formatDate(currentLineItemEnd, DATE_TIME_FORMAT) : null;

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
      const currentDate = formatDate(new Date(), DATE_FORMAT);
      const formattedOrderStartDate = order.startDate.substring(0, 10);
      const formattedOrderEndDate = order.endDate.substring(0, 10);
      const extendedOrderEndDate = formatDate(new Date(formattedOrderEndDate).setFullYear(new Date(formattedOrderEndDate).getFullYear() + 1), DATE_FORMAT);

      const pendingBudgetFlights = budgetFlights
        .map(budgetFlight => ({
          ...budgetFlight,
          startDate: budgetFlight.startDate.substring(0, 10),
          endDate: budgetFlight.endDate.substring(0, 10),
        }))
        .filter(({ endDate, startDate }) => isSameOrAfter(new Date(endDate), new Date(currentDate)) && isSameOrAfter(new Date(startDate), new Date(extendedOrderEndDate)));

      if (pendingBudgetFlights.length === 0) {
        const { start } = parent.periods[0];
        const { end } = parent.periods[parent.periods.length - 1];
        parent.budget.budgetFlights = {
          startDate: formatDate(start, DATE_FORMAT),
          endDate: formatDate(end, DATE_FORMAT),
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
          ? (isSameOrAfter(new Date(formattedOrderStartDate), new Date(currentDate)) ? currentDate : formattedOrderStartDate) 
          : (isSameOrAfter(new Date(startDate), new Date(currentDate)) ? currentDate : startDate);

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