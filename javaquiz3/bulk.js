import moment from 'moment-timezone';

import { mutateLineItemModel } from '../helpers/errorHandling';
import { RTB_LI_VALIDATION_REASON_TYPES, DATE_FORMAT, DATE_TIME_FORMAT } from '../helpers/constants';

export const transformations = {
  periods: {
    Set: (parent, _property, _value, _config, context) => {
      const { timeZone } = context.order.campaign;
      const { order } = context;
      const { periods: lineItemPeriods } = parent;
      const startDate = moment(order.startDate.substring(0, 10)).startOf('day').format(DATE_TIME_FORMAT);
      const endDate = moment(order.endDate.substring(0, 10)).startOf('day').format(DATE_TIME_FORMAT);
      const currentDate = moment().tz(timeZone, true).startOf('day').format(DATE_TIME_FORMAT);
      const orderStartDate = moment(startDate).isBefore(currentDate) ? currentDate : startDate;
      const orderEndDate = moment(endDate).endOf('day').seconds(0).format(DATE_TIME_FORMAT);

      const periods = [];
      lineItemPeriods.forEach(({ start: currentLineItemStart, end: currentLineItemEnd }, index) => {
        const isLineItemStartBetweenOrderDates = moment(currentLineItemStart)
          .isBetween(moment(orderStartDate), moment(orderEndDate));
        const isLineItemEndBetweenOrderDates = moment(currentLineItemEnd)
          .isBetween(moment(orderStartDate), moment(orderEndDate));

        let start = isLineItemStartBetweenOrderDates ? moment(currentLineItemStart).format(DATE_TIME_FORMAT) : null;

        let end = isLineItemEndBetweenOrderDates ? moment(currentLineItemEnd).format(DATE_TIME_FORMAT) : null;

        if (start && !end && index === lineItemPeriods.length - 1) {
          end = orderEndDate;
        }

        if (!start && end && index === 0) {
          start = orderStartDate;
        }

        if (!start && end) {
          start = moment(currentLineItemEnd).tz(timeZone, true).startOf('day').format(DATE_TIME_FORMAT);
        }

        if (start && !end && moment(currentLineItemEnd).isSame(moment(orderEndDate))) {
          end = orderEndDate;
        }
        if (start || end) {
          periods.push({ start, end });
        }
      });
      parent.periods = periods.length ? periods : [{ start: startDate, end: endDate }];
    },
  },
  budget: {
    Set: (parent, _property, _value, _config, context) => {
      const { order } = context;
      const { timeZone } = context.order.campaign;
      const { budgetFlights } = parent.budget;
      const currentDate = moment().tz(timeZone).format(DATE_FORMAT);
      const formattedOrderStartDate = (order.startDate).substring(0, 10);
      const formattedOrderEndDate = (order.endDate).substring(0, 10);
      const extendedOrderEndDate = moment(formattedOrderEndDate).add(1, 'year').format(DATE_FORMAT);

      const pendingBudgetFlights = budgetFlights
        .map((budgetFlight) => ({
          ...budgetFlight,
          startDate: (budgetFlight.startDate).substring(0, 10),
          endDate: (budgetFlight.endDate).substring(0, 10),
        }))
        .filter(({ endDate, startDate }) => moment(endDate).isSameOrAfter(currentDate)
            && moment(startDate).isSameOrBefore(extendedOrderEndDate));

      if (pendingBudgetFlights.length === 0) {
        const { start } = parent.periods[0];
        const { end } = parent.periods[parent.periods.length - 1];
        parent.budget.budgetFlights = {
          startDate: moment(start).format(DATE_FORMAT),
          endDate: moment(end).format(DATE_FORMAT),
          budget: 0,
          periodType: 'total',
          locked: false,
          useParentBudget: false,
          pacingType: 'asap',
        };
        return;
      }
      const modifiedBudgetFlights = pendingBudgetFlights.map((budgetFlight) => {
        const { startDate } = budgetFlight;
        const newStartDate = () => {
          const budgetFlightStartsBeforeOrder = moment(startDate).isBefore(formattedOrderStartDate);

          if (budgetFlightStartsBeforeOrder) {
            return moment(formattedOrderStartDate).isSameOrBefore(currentDate) ? currentDate
              : formattedOrderStartDate;
          }

          return moment(startDate).isSameOrBefore(currentDate)
            ? currentDate
            : startDate;
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
      if (mutateLineItemModel()[error.reason]) {
        mutateLineItemModel()[error.reason]({
          path,
          lineItemToMutate: parent,
          error,
          copyToOrder: context.order,
        });
      } else {
        mutateLineItemModel()[RTB_LI_VALIDATION_REASON_TYPES.ValidationFailed]({
          path,
          lineItemToMutate: parent,
        });
      }
    },
  },
};
