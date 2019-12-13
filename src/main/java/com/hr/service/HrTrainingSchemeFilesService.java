package com.hr.service;

import com.hr.entity.HrTrainingSchemeFiles;

import java.util.List;
import java.util.Map;

public interface HrTrainingSchemeFilesService {

    public List<HrTrainingSchemeFiles> list(Map<String,Object> map);

    public Long getTotal(Map<String,Object> map);

    public Integer add(HrTrainingSchemeFiles hrTrainingSchemeFiles);

    public Integer delete(HrTrainingSchemeFiles hrTrainingSchemeFiles);

}
