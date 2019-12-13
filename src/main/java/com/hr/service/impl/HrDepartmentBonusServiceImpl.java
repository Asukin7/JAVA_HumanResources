package com.hr.service.impl;

import com.hr.dao.HrDepartmentBonusDao;
import com.hr.entity.HrDepartmentBonus;
import com.hr.service.HrDepartmentBonusService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service("hrDepartmentBonusService")
public class HrDepartmentBonusServiceImpl implements HrDepartmentBonusService {

    @Resource
    private HrDepartmentBonusDao hrDepartmentBonusDao;

    @Override
    public List<HrDepartmentBonus> countList() {
        return hrDepartmentBonusDao.countList();
    }

    @Override
    public List<HrDepartmentBonus> list(Map<String, Object> map) {
        return hrDepartmentBonusDao.list(map);
    }

    @Override
    public HrDepartmentBonus findById(Integer id) {
        return hrDepartmentBonusDao.findById(id);
    }

    @Override
    public Long getTotal(Map<String, Object> map) {
        return hrDepartmentBonusDao.getTotal(map);
    }

    @Override
    public Integer add(HrDepartmentBonus hrDepartmentBonus) {
        return hrDepartmentBonusDao.add(hrDepartmentBonus);
    }

    @Override
    public Integer update(HrDepartmentBonus hrDepartmentBonus) {
        return hrDepartmentBonusDao.update(hrDepartmentBonus);
    }

    @Override
    public Integer delete(Integer id) {
        return hrDepartmentBonusDao.delete(id);
    }

}
