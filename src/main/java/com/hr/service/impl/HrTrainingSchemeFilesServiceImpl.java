package com.hr.service.impl;

import com.hr.dao.HrTrainingSchemeFilesDao;
import com.hr.entity.HrTrainingSchemeFiles;
import com.hr.service.HrTrainingSchemeFilesService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service("hrTrainingSchemeFilesService")
public class HrTrainingSchemeFilesServiceImpl implements HrTrainingSchemeFilesService {

    @Resource
    private HrTrainingSchemeFilesDao hrTrainingSchemeFilesDao;

    @Override
    public List<HrTrainingSchemeFiles> list(Map<String, Object> map) {
        return hrTrainingSchemeFilesDao.list(map);
    }

    @Override
    public Long getTotal(Map<String, Object> map) {
        return hrTrainingSchemeFilesDao.getTotal(map);
    }

    @Override
    public Integer add(HrTrainingSchemeFiles hrTrainingSchemeFiles) {
        return hrTrainingSchemeFilesDao.add(hrTrainingSchemeFiles);
    }

    @Override
    public Integer delete(HrTrainingSchemeFiles hrTrainingSchemeFiles) {
        return hrTrainingSchemeFilesDao.delete(hrTrainingSchemeFiles);
    }

}
