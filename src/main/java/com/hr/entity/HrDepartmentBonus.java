package com.hr.entity;

import java.io.Serializable;
import java.util.Date;

public class HrDepartmentBonus implements Serializable {

    private static final long serialVersionUID = 1L;
    /**id*/
    private Integer id;
    /**部门---外键关联[id]*/
    private HrDepartment hrDepartment;
    /**奖金名称*/
    private String name;
    /**奖金*/
    private Float bonus;
    /**人数*/
    private Integer number;
    /**日期*/
    private Date date;

    /**日期Str*/
    private String dateStr;

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

    public Float getBonus() {
        return bonus;
    }

    public void setBonus(Float bonus) {
        this.bonus = bonus;
    }

    public Integer getNumber() {
        return number;
    }

    public void setNumber(Integer number) {
        this.number = number;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getDateStr() {
        return dateStr;
    }

    public void setDateStr(String dateStr) {
        this.dateStr = dateStr;
    }

}
