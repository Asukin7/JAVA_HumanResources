package com.hr.service;

import com.hr.entity.HrAccount;

import java.util.List;
import java.util.Map;

public interface HrAccountService {

    public List<HrAccount> list(Map<String,Object> map);

    public Long getTotal(Map<String,Object> map);

    public HrAccount getByAccount(String account);

    public Integer add(HrAccount hrAccount);

    public Integer update(HrAccount hrAccount);

    public Integer delete(HrAccount hrAccount);

}
