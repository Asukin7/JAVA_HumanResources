package com.hr.service;

import com.hr.entity.HrWages;

import java.util.List;
import java.util.Map;

public interface HrWagesService {

    public List<HrWages> countList();

    public List<HrWages> list(Map<String,Object> map);

    public HrWages findById(Integer id);

    public Long getTotal(Map<String,Object> map);

    public Integer add(HrWages hrWages);

    public Integer update(HrWages hrWages);

    public Integer delete(Integer id);

}
