package com.hr.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class StringUtil {

    /**
     * 在字符串前后加%
     */
    public static String formatLike(String str) {
        if(isNotEmpty(str)) {
            return "%" + str + "%";
        }
        return null;
    }

    /**
     * 判断字符串是否不为空
     */
    public static boolean isNotEmpty(String str) {
        if(str != null && !"".equals(str.trim())) {
            return true;
        }
        return false;
    }

    /**
     * String(yyyy-MM-dd)转Date
     */
    public static Date stringToDate(String str) throws Exception {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date date = simpleDateFormat.parse(str);
        return date;
    }

}
