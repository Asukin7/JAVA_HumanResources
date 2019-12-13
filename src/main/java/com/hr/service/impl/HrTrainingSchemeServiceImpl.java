package com.hr.service.impl;

import com.hr.dao.HrTrainingSchemeDao;
import com.hr.entity.HrTrainingScheme;
import com.hr.service.HrTrainingSchemeService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service("hrTrainingSchemeService")
public class HrTrainingSchemeServiceImpl implements HrTrainingSchemeService {

    @Resource
    private HrTrainingSchemeDao hrTrainingSchemeDao;

    @Override
    public List<HrTrainingScheme> countList() {
        return hrTrainingSchemeDao.countList();
    }

    @Override
    public List<HrTrainingScheme> list(Map<String, Object> map) {
        return hrTrainingSchemeDao.list(map);
    }

    @Override
    public HrTrainingScheme findById(Integer id) {
        return hrTrainingSchemeDao.findById(id);
    }

    @Override
    public Long getTotal(Map<String, Object> map) {
        return hrTrainingSchemeDao.getTotal(map);
    }

    @Override
    public Integer add(HrTrainingScheme hrTrainingScheme) {
        return hrTrainingSchemeDao.add(hrTrainingScheme);
    }

    @Override
    public Integer update(HrTrainingScheme hrTrainingScheme) {
        return hrTrainingSchemeDao.update(hrTrainingScheme);
    }

    @Override
    public Integer delete(Integer id) {
        return hrTrainingSchemeDao.delete(id);
    }

}
