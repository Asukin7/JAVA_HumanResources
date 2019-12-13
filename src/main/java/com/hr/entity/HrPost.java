package com.hr.entity;

import java.io.Serializable;

public class HrPost implements Serializable {

    private static final long serialVersionUID = 1L;
    /**id*/
    private Integer id;
    /**部门---外键关联[id]*/
    private HrDepartment hrDepartment;
    /**岗位名称*/
    private String name;
    /**时薪*/
    private Float hourlyWage;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public HrDepartment getHrDepartment() {
        return hrDepartment;
    }

    public void setHrDepartment(HrDepartment hrDepartment) {
        this.hrDepartment = hrDepartment;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Float getHourlyWage() {
        return hourlyWage;
    }

    public void setHourlyWage(Float hourlyWage) {
        this.hourlyWage = hourlyWage;
    }

}
