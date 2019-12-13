package com.hr.service;

import com.hr.entity.HrContract;

import java.util.List;
import java.util.Map;

public interface HrContractService {

    public List<HrContract> countList();

    public List<HrContract> list(Map<String,Object> map);

    public HrContract findById(Integer id);

    public Long getTotal(Map<String,Object> map);

    public Integer add(HrContract hrContract);

    public Integer update(HrContract hrContract);

    public Integer delete(Integer id);

}
