package com.hr.service;

import com.hr.entity.HrSkillAppraisal;

import java.util.List;
import java.util.Map;

public interface HrSkillAppraisalService {

    public List<HrSkillAppraisal> countList();

    public List<HrSkillAppraisal> list(Map<String,Object> map);

    public HrSkillAppraisal findById(Integer id);

    public Long getTotal(Map<String,Object> map);

    public Integer add(HrSkillAppraisal hrSkillAppraisal);

    public Integer update(HrSkillAppraisal hrSkillAppraisal);

    public Integer delete(Integer id);

}
