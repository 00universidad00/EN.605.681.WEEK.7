package controller;

import model.BookingDay;
import model.Rates;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

@WebServlet("/price")
public class CalculatePrice extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // This Method Is Called By The Servlet Container To Process A 'GET' Request.
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        handleRequest(request, response);
    }

    // This Method Is Called By The Servlet Container To Process A 'POST' Request.
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        handleRequest(request, response);
    }

    // method used to handle request to display homepage or calculator
    private void handleRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {

        // define params
        final String CONTENT_TYPE = "text/plain";
        final String OPEN_CALCULATOR = "open_calculator";
        final String DISPLAY_CALCULATOR = "display_calculator";
        final String OPEN_HOME = "open_home";

        // set response to text
        response.setContentType(CONTENT_TYPE);

        // check user selection
        final String OPEN_CALCULATOR_PARAM = request.getParameter(OPEN_CALCULATOR);
        final String OPEN_HOME_PARAM = request.getParameter(OPEN_HOME);

        // verify if user navigated to homepage
        if (OPEN_HOME_PARAM != null) {
            // reset session values
            request.getSession().invalidate();
            // reload page (Go home)
            response.sendRedirect(request.getContextPath());
        }
        // verify if user navigated to calculator
        else if (OPEN_CALCULATOR_PARAM != null) {
            // set variable to display calculator
            request.getSession().setAttribute(DISPLAY_CALCULATOR, true);
            // reload page
            response.sendRedirect(request.getContextPath());
        } else {
            // prepare view to calculate prices
            calculatePrice(request, response);
        }

    }

    private void calculatePrice(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // define page param names
        final String DATE_FORMAT = "MM/dd/yyyy";
        final String HIKE_ID = "hike_id";
        final String HIKE_DATE = "hike_dates";
        final String HIKE_PRICE = "hike_price";
        final String HIKE_DURATION = "hike_duration";
        final String HIKE_MEMBERS = "hike_members";
        final String ERROR = "error";
        final String DISPLAY_ERROR = "display_error";
        final String CLEAR_ERROR = "clear_error";

        // define page variables
        final String RESULT_HIKE_LOCATION = "result_hike_location";
        final String RESULT_HIKE_START = "result_hike_start";
        final String RESULT_HIKE_END = "result_hike_end";
        final String RESULT_HIKE_DURATION = "result_hike_duration";
        final String RESULT_HIKE_WEEKDAYS = "result_hike_weekdays";
        final String RESULT_HIKE_WEEKENDS = "result_hike_weekends";
        final String RESULT_HIKE_PRICE = "result_hike_price";
        final String RESULT_HIKE_MEMBERS = "result_hike_members";
        final String RESULT_HIKE_TOTAL_PRICE = "result_hike_total";
        final String DISPLAY_CALCULATOR = "display_calculator";

        // get error value stored in session
        final String CLEAR_ERROR_PARAM = request.getParameter(CLEAR_ERROR);

        // if an error occur clean view and load calculator again else load calculator
        if (CLEAR_ERROR_PARAM == null) {
            //get values from jsp
            final int HIKE_ID_PARAM = Integer.parseInt(request.getParameter(HIKE_ID));
            final String HIKE_DATE_PARAM = request.getParameter(HIKE_DATE);
            final String HIKE_DURATION_PARAM = request.getParameter(HIKE_DURATION);
            final int HIKE_MEMBERS_PARAM = Integer.parseInt(request.getParameter(HIKE_MEMBERS));

            try {
                // convert start date to calendar date
                Date start = new SimpleDateFormat(DATE_FORMAT).parse(HIKE_DATE_PARAM);
                GregorianCalendar start_date_calendar = new GregorianCalendar();
                start_date_calendar.setTime(start);
                int start_date_year = start_date_calendar.get(Calendar.YEAR);
                int start_date_month = start_date_calendar.get(Calendar.MONTH) + 1;
                int start_date_day = start_date_calendar.get(Calendar.DAY_OF_MONTH);
                BookingDay booking_start_day = new BookingDay(start_date_year, start_date_month, start_date_day);

                // calculate rates
                Rates rates = new Rates(Rates.HIKE.values()[HIKE_ID_PARAM]);
                rates.setBeginDate(booking_start_day);

                // validate trip duration and trip dates
                boolean validStartDate = booking_start_day.isValidDate();
                boolean validDuration = rates.setDuration(Integer.parseInt(HIKE_DURATION_PARAM));
                boolean validDates = rates.isValidDates();

                // validate for errors
                if (validStartDate && validDates && validDuration) {
                    request.getSession().setAttribute(RESULT_HIKE_LOCATION, Rates.HIKE.values()[HIKE_ID_PARAM]);
                    request.getSession().setAttribute(RESULT_HIKE_START, rates.getBeginBookingDay());
                    request.getSession().setAttribute(RESULT_HIKE_END, rates.getEndBookingDay());
                    request.getSession().setAttribute(RESULT_HIKE_DURATION, HIKE_DURATION_PARAM);
                    request.getSession().setAttribute(RESULT_HIKE_WEEKDAYS, rates.getNormalDays());
                    request.getSession().setAttribute(RESULT_HIKE_WEEKENDS, rates.getPremiumDays());
                    request.getSession().setAttribute(RESULT_HIKE_PRICE, rates.getCost());
                    request.getSession().setAttribute(RESULT_HIKE_TOTAL_PRICE, rates.getCost() * HIKE_MEMBERS_PARAM);
                    request.getSession().setAttribute(RESULT_HIKE_MEMBERS, HIKE_MEMBERS_PARAM);
                } else {
                    // build error message
                    String error_message =
                            String.format("<strong>Error details:</strong> %s <br />", rates.getDetails()) +
                                    String.format("<strong>Season start:</strong>  %s/%s<br />", rates.getSeasonStartDay(), rates.getSeasonStartMonth()) +
                                    String.format("<strong>Season end:</strong>  %s/%s <br />", rates.getSeasonEndDay(), rates.getSeasonEndMonth());
                    // set price value to null
                    request.getSession().setAttribute(HIKE_PRICE, null);
                    // display error message
                    request.getSession().setAttribute(DISPLAY_ERROR, true);
                    // populate error window
                    request.getSession().setAttribute(ERROR, error_message);
                }
            } catch (ParseException e) {
                e.printStackTrace();
            } finally {
                // reload the page to display updated information
                response.sendRedirect(request.getContextPath());
            }
        } else {
            // reset session values
            request.getSession().invalidate();
            // set variable to display calculator
            request.getSession().setAttribute(DISPLAY_CALCULATOR, true);
            // reload page
            response.sendRedirect(request.getContextPath());
        }
    }
}