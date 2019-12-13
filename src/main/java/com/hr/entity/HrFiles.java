package com.hr.entity;

import java.io.Serializable;
import java.util.Date;

public class HrFiles implements Serializable {

    private static final long serialVersionUID = 1L;
    /**id*/
    private Integer id;
    /**岗位---外键关联[id]*/
    private HrPost hrPost;
    /**姓名*/
    private String name;
    /**性别*/
    private String sex;
    /**联系方式*/
    private String phone;
    /**备注*/
    private String remark;
    /**加入日期*/
    private Date joinDate;
    /**基础工资*/
    private Float basicWage;

    /**加入日期Str*/
    private String joinDateStr;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public HrPost getHrPost() {
        return hrPost;
    }

    public void setHrPost(HrPost hrPost) {
        this.hrPost = hrPost;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public Date getJoinDate() {
        return joinDate;
    }

    public void setJoinDate(Date joinDate) {
        this.joinDate = joinDate;
    }

    public Float getBasicWage() {
        return basicWage;
    }

    public void setBasicWage(Float basicWage) {
        this.basicWage = basicWage;
    }

    public String getJoinDateStr() {
        return joinDateStr;
    }

    public void setJoinDateStr(String joinDateStr) {
        this.joinDateStr = joinDateStr;
    }

}
