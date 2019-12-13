package com.hr.service.impl;

import com.hr.dao.HrSkillAppraisalDao;
import com.hr.entity.HrSkillAppraisal;
import com.hr.service.HrSkillAppraisalService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service("hrSkillAppraisalService")
public class HrSkillAppraisalServiceImpl implements HrSkillAppraisalService {

    @Resource
    private HrSkillAppraisalDao hrSkillAppraisalDao;

    @Override
    public List<HrSkillAppraisal> countList() {
        return hrSkillAppraisalDao.countList();
    }

    @Override
    public List<HrSkillAppraisal> list(Map<String, Object> map) {
        return hrSkillAppraisalDao.list(map);
    }

    @Override
    public HrSkillAppraisal findById(Integer id) {
        return hrSkillAppraisalDao.findById(id);
    }

    @Override
    public Long getTotal(Map<String, Object> map) {
        return hrSkillAppraisalDao.getTotal(map);
    }

    @Override
    public Integer add(HrSkillAppraisal hrSkillAppraisal) {
        return hrSkillAppraisalDao.add(hrSkillAppraisal);
    }

    @Override
    public Integer update(HrSkillAppraisal hrSkillAppraisal) {
        return hrSkillAppraisalDao.update(hrSkillAppraisal);
    }

    @Override
    public Integer delete(Integer id) {
        return hrSkillAppraisalDao.delete(id);
    }

}
