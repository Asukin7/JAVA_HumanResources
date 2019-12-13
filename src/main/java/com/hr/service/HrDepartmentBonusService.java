package com.hr.service;

import com.hr.entity.HrDepartmentBonus;

import java.util.List;
import java.util.Map;

public interface HrDepartmentBonusService {

    public List<HrDepartmentBonus> countList();

    public List<HrDepartmentBonus> list(Map<String,Object> map);

    public HrDepartmentBonus findById(Integer id);

    public Long getTotal(Map<String,Object> map);

    public Integer add(HrDepartmentBonus hrDepartmentBonus);

    public Integer update(HrDepartmentBonus hrDepartmentBonus);

    public Integer delete(Integer id);

}
