package com.hr.service.impl;

import com.hr.dao.HrDepartmentDao;
import com.hr.entity.HrDepartment;
import com.hr.service.HrDepartmentService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service("hrDepartmentService")
public class HrDepartmentServiceImpl implements HrDepartmentService {

    @Resource
    private HrDepartmentDao hrDepartmentDao;

    @Override
    public List<HrDepartment> countList() {
        return hrDepartmentDao.countList();
    }

    @Override
    public List<HrDepartment> list(Map<String, Object> map) {
        return hrDepartmentDao.list(map);
    }

    @Override
    public HrDepartment findById(Integer id) {
        return hrDepartmentDao.findById(id);
    }

    @Override
    public Long getTotal(Map<String, Object> map) {
        return hrDepartmentDao.getTotal(map);
    }

    @Override
    public Integer add(HrDepartment hrDepartment) {
        return hrDepartmentDao.add(hrDepartment);
    }

    @Override
    public Integer update(HrDepartment hrDepartment) {
        return hrDepartmentDao.update(hrDepartment);
    }

    @Override
    public Integer delete(Integer id) {
        return hrDepartmentDao.delete(id);
    }

}
