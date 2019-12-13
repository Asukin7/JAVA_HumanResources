package com.hr.service.impl;

import com.hr.dao.HrWagesDao;
import com.hr.entity.HrWages;
import com.hr.service.HrWagesService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service("hrWagesService")
public class HrWagesServiceImpl implements HrWagesService {

    @Resource
    private HrWagesDao hrWagesDao;

    @Override
    public List<HrWages> countList() {
        return hrWagesDao.countList();
    }

    @Override
    public List<HrWages> list(Map<String, Object> map) {
        return hrWagesDao.list(map);
    }

    @Override
    public HrWages findById(Integer id) {
        return hrWagesDao.findById(id);
    }

    @Override
    public Long getTotal(Map<String, Object> map) {
        return hrWagesDao.getTotal(map);
    }

    @Override
    public Integer add(HrWages hrWages) {
        return hrWagesDao.add(hrWages);
    }

    @Override
    public Integer update(HrWages hrWages) {
        return hrWagesDao.update(hrWages);
    }

    @Override
    public Integer delete(Integer id) {
        return hrWagesDao.delete(id);
    }

}
