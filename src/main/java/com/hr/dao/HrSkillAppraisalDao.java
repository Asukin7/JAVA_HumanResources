package com.hr.dao;

import com.hr.entity.HrSkillAppraisal;

import java.util.List;
import java.util.Map;

public interface HrSkillAppraisalDao {

    /**无参数查询所有技能鉴定列表*/
    public List<HrSkillAppraisal> countList();

    /**带参数查询技能鉴定列表*/
    public List<HrSkillAppraisal> list(Map<String,Object> map);

    /**根据主键查询一份技能鉴定*/
    public HrSkillAppraisal findById(Integer id);

    /**带参数查询技能鉴定数量*/
    public Long getTotal(Map<String,Object> map);

    /**添加一份技能鉴定*/
    public Integer add(HrSkillAppraisal hrSkillAppraisal);

    /**修改一份技能鉴定*/
    public Integer update(HrSkillAppraisal hrSkillAppraisal);

    /**根据主键删除一份技能鉴定*/
    public Integer delete(Integer id);

}
