package com.hr.service;

import com.hr.entity.HrDepartment;

import java.util.List;
import java.util.Map;

public interface HrDepartmentService {

    public List<HrDepartment> countList();

    public List<HrDepartment> list(Map<String,Object> map);

    public HrDepartment findById(Integer id);

    public Long getTotal(Map<String,Object> map);

    public Integer add(HrDepartment hrDepartment);

    public Integer update(HrDepartment hrDepartment);

    public Integer delete(Integer id);

}
