package com.hr.entity;

import java.io.Serializable;

public class HrDepartment implements Serializable {

    private static final long serialVersionUID = 1L;
    /**id*/
    private Integer id;
    /**部门名称*/
    private String name;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

}
