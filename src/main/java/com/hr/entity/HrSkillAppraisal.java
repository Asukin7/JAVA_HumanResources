package com.hr.entity;

import java.io.Serializable;
import java.util.Date;

public class HrSkillAppraisal implements Serializable {

    private static final long serialVersionUID = 1L;
    /**id*/
    private Integer id;
    /**档案---外键关联[id]*/
    private HrFiles hrFiles;
    /**内容*/
    private String content;
    /**提交日期*/
    private Date submitDate;
    /**是否合格0未审核 -1不合格 1合格*/
    private Integer isPass;
    /**审核日期*/
    private Date auditDate;

    /**提交日期Str*/
    private String submitDateStr;
    /**审核日期Str*/
    private String auditDateStr;

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

    public Date getSubmitDate() {
        return submitDate;
    }

    public void setSubmitDate(Date submitDate) {
        this.submitDate = submitDate;
    }

    public Integer getIsPass() {
        return isPass;
    }

    public void setIsPass(Integer isPass) {
        this.isPass = isPass;
    }

    public Date getAuditDate() {
        return auditDate;
    }

    public void setAuditDate(Date auditDate) {
        this.auditDate = auditDate;
    }

    public String getSubmitDateStr() {
        return submitDateStr;
    }

    public void setSubmitDateStr(String submitDateStr) {
        this.submitDateStr = submitDateStr;
    }

    public String getAuditDateStr() {
        return auditDateStr;
    }

    public void setAuditDateStr(String auditDateStr) {
        this.auditDateStr = auditDateStr;
    }

}
