package com.hr.util;

import java.util.HashMap;
import java.util.Map;

public class JSONMap extends HashMap<String, Object> {

    @Override
    public String toString() {
        String str = "";
        for (Map.Entry<String, Object> entry : entrySet()) {
            str += "\"" + entry.getKey() + "\":" + entry.getValue() + ",";
        }
        if (str == "" || str == null) {
            return "{}";
        }
        str = "{" + str.substring(0, str.length() - 1) + "}";
        return str;
    }

}
