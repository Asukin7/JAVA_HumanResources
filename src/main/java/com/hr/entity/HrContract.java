package com.hr.entity;

import java.io.Serializable;
import java.util.Date;

public class HrContract implements Serializable {

    private static final long serialVersionUID = 1L;
    /**id*/
    private Integer id;
    /**档案---外键关联[id]*/
    private HrFiles hrFiles;
    /**内容*/
    private String content;
    /**开始日期*/
    private Date startDate;
    /**结束日期*/
    private Date endDate;

    /**开始日期Str*/
    private String startDateStr;
    /**结束日期Str*/
    private String endDateStr;

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

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public String getStartDateStr() {
        return startDateStr;
    }

    public void setStartDateStr(String startDateStr) {
        this.startDateStr = startDateStr;
    }

    public String getEndDateStr() {
        return endDateStr;
    }

    public void setEndDateStr(String endDateStr) {
        this.endDateStr = endDateStr;
    }

}
