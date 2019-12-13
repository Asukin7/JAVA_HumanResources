package com.hr.service.impl;

import com.hr.dao.HrAccountDao;
import com.hr.entity.HrAccount;
import com.hr.service.HrAccountService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service("hrAccountService")
public class HrAccountServiceImpl implements HrAccountService {

    @Resource
    private HrAccountDao hrAccountDao;

    @Override
    public List<HrAccount> list(Map<String, Object> map) {
        return hrAccountDao.list(map);
    }

    @Override
    public Long getTotal(Map<String, Object> map) {
        return hrAccountDao.getTotal(map);
    }

    @Override
    public HrAccount getByAccount(String account) {
        return hrAccountDao.getByAccount(account);
    }

    @Override
    public Integer add(HrAccount hrAccount) {
        return hrAccountDao.add(hrAccount);
    }

    @Override
    public Integer update(HrAccount hrAccount) {
        return hrAccountDao.update(hrAccount);
    }

    @Override
    public Integer delete(HrAccount hrAccount) {
        return hrAccountDao.delete(hrAccount);
    }

}
