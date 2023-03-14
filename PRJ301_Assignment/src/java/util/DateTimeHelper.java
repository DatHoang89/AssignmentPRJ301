/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;

/**
 *
 * @author LEGION
 */
public class DateTimeHelper {

    public static ArrayList<Date> getListDate(Date from, Date to) {
        ArrayList<Date> dates = new ArrayList<>();
        Date loop = from;
        while(loop.compareTo(to) <= 0)
        {
            dates.add(loop);
            java.util.Date loop_util = toUtilDate(loop);
            loop = toSQLDate(addDays(loop_util, 1));
        }
        return dates;
    }

    public static java.sql.Date toSQLDate(java.util.Date value) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(value);
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);
        return new java.sql.Date(cal.getTimeInMillis());
    }

    public static java.util.Date addDays(java.util.Date date, int days) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.add(Calendar.DATE, days);
        return cal.getTime();
    }

    public static java.util.Date toUtilDate(java.sql.Date value) {
        return new java.util.Date(value.getTime());
    }

}