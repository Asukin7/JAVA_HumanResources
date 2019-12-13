package com.hr.util;

import org.apache.shiro.crypto.hash.Md5Hash;

public class CryptographyUtil {

    /**
     * md5加密
     */
    public static String md5(String str, String salt) {
        return new Md5Hash(str, salt).toString();
    }

}
