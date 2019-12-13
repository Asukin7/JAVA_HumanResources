package com.hr.entity;

import java.io.Serializable;
import java.util.Date;

public class HrWages implements Serializable {

    private static final long serialVersionUID = 1L;
    /**id*/
    private Integer id;
    /**档案---外键关联[id]*/
    private HrFiles hrFiles;
    /**部门奖金---外键关联[id]*/
    private HrDepartmentBonus hrDepartmentBonus;
    /**出勤时长*/
    private Integer attendanceLength;
    /**基础工资*/
    private Float basicWage;
    /**时薪*/
    private Float hourlyWage;
    /**个人奖金*/
    private Float personalBonus;
    /**总奖金*/
    private Float totalWages;
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

    public HrFiles getHrFiles() {
        return hrFiles;
    }

    public void setHrFiles(HrFiles hrFiles) {
        this.hrFiles = hrFiles;
    }

    public HrDepartmentBonus getHrDepartmentBonus() {
        return hrDepartmentBonus;
    }

    public void setHrDepartmentBonus(HrDepartmentBonus hrDepartmentBonus) {
        this.hrDepartmentBonus = hrDepartmentBonus;
    }

    public Integer getAttendanceLength() {
        return attendanceLength;
    }

    public void setAttendanceLength(Integer attendanceLength) {
        this.attendanceLength = attendanceLength;
    }

    public Float getBasicWage() {
        return basicWage;
    }

    public void setBasicWage(Float basicWage) {
        this.basicWage = basicWage;
    }

    public Float getHourlyWage() {
        return hourlyWage;
    }

    public void setHourlyWage(Float hourlyWage) {
        this.hourlyWage = hourlyWage;
    }

    public Float getPersonalBonus() {
        return personalBonus;
    }

    public void setPersonalBonus(Float personalBonus) {
        this.personalBonus = personalBonus;
    }

    public Float getTotalWages() {
        return totalWages;
    }

    public void setTotalWages(Float totalWages) {
        this.totalWages = totalWages;
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
