package com.hr.entity;

import java.io.Serializable;

public class HrTrainingSchemeFiles implements Serializable {

    private static final long serialVersionUID = 1L;
    /**培训方案ID*/
    private Integer hrTrainingSchemeID;
    /**档案---外键关联[id]*/
    private HrFiles hrFiles;

    public Integer getHrTrainingSchemeID() {
        return hrTrainingSchemeID;
    }

    public void setHrTrainingSchemeID(Integer hrTrainingSchemeID) {
        this.hrTrainingSchemeID = hrTrainingSchemeID;
    }

    public HrFiles getHrFiles() {
        return hrFiles;
    }

    public void setHrFiles(HrFiles hrFiles) {
        this.hrFiles = hrFiles;
    }

}
