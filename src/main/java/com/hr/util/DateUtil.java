package com.hr.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtil {

    public static String toString(Date date) {
        if(date == null) return null;
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        return simpleDateFormat.format(date);
    }

}
