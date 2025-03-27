import { format, isBefore, isSameOrAfter, isSameOrBefore, isBetween, startOfDay, endOfDay } from 'date-fns-tz';
import { mutateLineItemModel } from '../helpers/errorHandling';
import { RTB_LI_VALIDATION_REASON_TYPES, DATE_FORMAT, DATE_TIME_FORMAT } from '../helpers/constants';

const formatDate = (date, formatStr) => format(new Date(date), formatStr);

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

      const periods = lineItemPeriods.reduce((acc, { start: lineItemStart, end: lineItemEnd }, index) => {
        const start = isBetween(new Date(lineItemStart), new Date(orderStartDate), new Date(orderEndDate)) ? formatDate(lineItemStart, DATE_TIME_FORMAT) : null;
        const end = isBetween(new Date(lineItemEnd), new Date(orderStartDate), new Date(orderEndDate)) ? formatDate(lineItemEnd, DATE_TIME_FORMAT) : null;

        if (start && !end && index === lineItemPeriods.length - 1) {
          end = orderEndDate;
        }

        if (!start && end && index === 0) {
          start = orderStartDate;
        }

        if (!start && end) {
          start = formatDate(new Date(lineItemEnd), DATE_TIME_FORMAT);
        }

        if (start && !end && isSame(new Date(lineItemEnd), new Date(orderEndDate))) {
          end = orderEndDate;
        }

        if (start || end) {
          acc.push({ start, end });
        }
        return acc;
      }, []);

      parent.periods = periods.length ? periods : [{ start: startDate, end: endDate }];
    },
  },
  budget: {
    Set: (parent, _property, _value, _config, context) => {
      const { order, order: { campaign: { timeZone } } } = context;
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
        .filter(({ endDate, startDate }) => isSameOrAfter(new Date(endDate), new Date(currentDate)) && isSameOrBefore(new Date(startDate), new Date(extendedOrderEndDate)));

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
        const newStartDate = () => {
          const budgetFlightStartsBeforeOrder = isBefore(new Date(startDate), new Date(formattedOrderStartDate));

          if (budgetFlightStartsBeforeOrder) {
            return isSameOrBefore(new Date(formattedOrderStartDate), new Date(currentDate)) ? currentDate : formattedOrderStartDate;
          }

          return isSameOrBefore(new Date(startDate), new Date(currentDate)) ? currentDate : startDate;
        };

        return {
          ...budgetFlight,
          startDate: newStartDate(),
        };
      });

      parent.budget.budgetFlights = modifiedBudgetFlights;
    },
  },
  impressionCappings: {
    Set: (parent) => {
      Object.values(parent.impressionCappings).forEach(({ id }) => {
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