package com.hr.entity;

import java.io.Serializable;

public class HrAccount implements Serializable {

    private static final long serialVersionUID = 1L;
    /**账号*/
    private String account;
    /**档案ID*/
    private Integer filesId;
    /**密码*/
    private String password;

    private Integer admin;
    private Integer files;
    private Integer post;
    private Integer wages;
    private Integer train;

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public Integer getFilesId() {
        return filesId;
    }

    public void setFilesId(Integer filesId) {
        this.filesId = filesId;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Integer getAdmin() {
        return admin;
    }

    public void setAdmin(Integer admin) {
        this.admin = admin;
    }

    public Integer getFiles() {
        return files;
    }

    public void setFiles(Integer files) {
        this.files = files;
    }

    public Integer getPost() {
        return post;
    }

    public void setPost(Integer post) {
        this.post = post;
    }

    public Integer getWages() {
        return wages;
    }

    public void setWages(Integer wages) {
        this.wages = wages;
    }

    public Integer getTrain() {
        return train;
    }

    public void setTrain(Integer train) {
        this.train = train;
    }

}
