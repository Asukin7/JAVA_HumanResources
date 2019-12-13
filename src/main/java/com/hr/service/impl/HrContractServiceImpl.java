package com.hr.service.impl;

import com.hr.dao.HrContractDao;
import com.hr.entity.HrContract;
import com.hr.service.HrContractService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service("hrContractService")
public class HrContractServiceImpl implements HrContractService {

    @Resource
    private HrContractDao hrContractDao;

    @Override
    public List<HrContract> countList() {
        return hrContractDao.countList();
    }

    @Override
    public List<HrContract> list(Map<String, Object> map) {
        return hrContractDao.list(map);
    }

    @Override
    public HrContract findById(Integer id) {
        return hrContractDao.findById(id);
    }

    @Override
    public Long getTotal(Map<String, Object> map) {
        return hrContractDao.getTotal(map);
    }

    @Override
    public Integer add(HrContract hrContract) {
        return hrContractDao.add(hrContract);
    }

    @Override
    public Integer update(HrContract hrContract) {
        return hrContractDao.update(hrContract);
    }

    @Override
    public Integer delete(Integer id) {
        return hrContractDao.delete(id);
    }

}
