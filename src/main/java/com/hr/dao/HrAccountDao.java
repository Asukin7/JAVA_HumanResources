package com.hr.dao;

import com.hr.entity.HrAccount;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface HrAccountDao {

    /**带参数查询账号列表*/
    public List<HrAccount> list(Map<String,Object> map);

    /**带参数查询账号数量*/
    public Long getTotal(Map<String,Object> map);

    /**根据账号查询账号对象*/
    public HrAccount getByAccount(@Param("account") String account);

    /**添加一个账号*/
    public Integer add(HrAccount hrAccount);

    /**修改一个账号*/
    public Integer update(HrAccount hrAccount);

    /**删除一个账号*/
    public Integer delete(HrAccount hrAccount);

}
