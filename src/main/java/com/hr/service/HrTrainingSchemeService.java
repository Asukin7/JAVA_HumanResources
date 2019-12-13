package com.hr.service;

import com.hr.entity.HrTrainingScheme;

import java.util.List;
import java.util.Map;

public interface HrTrainingSchemeService {

    public List<HrTrainingScheme> countList();

    public List<HrTrainingScheme> list(Map<String,Object> map);

    public HrTrainingScheme findById(Integer id);

    public Long getTotal(Map<String,Object> map);

    public Integer add(HrTrainingScheme hrTrainingScheme);

    public Integer update(HrTrainingScheme hrTrainingScheme);

    public Integer delete(Integer id);

}
