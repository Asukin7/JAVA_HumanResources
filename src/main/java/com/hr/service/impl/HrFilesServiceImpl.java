package com.hr.service.impl;

import com.hr.dao.HrFilesDao;
import com.hr.entity.HrFiles;
import com.hr.service.HrFilesService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service("hrFilesService")
public class HrFilesServiceImpl implements HrFilesService {

    @Resource
    private HrFilesDao hrFilesDao;

    @Override
    public List<HrFiles> countList() {
        return hrFilesDao.countList();
    }

    @Override
    public List<HrFiles> list(Map<String, Object> map) {
        return hrFilesDao.list(map);
    }

    @Override
    public HrFiles findById(Integer id) {
        return hrFilesDao.findById(id);
    }

    @Override
    public Long getTotal(Map<String, Object> map) {
        return hrFilesDao.getTotal(map);
    }

    @Override
    public Integer add(HrFiles hrFiles) {
        return hrFilesDao.add(hrFiles);
    }

    @Override
    public Integer update(HrFiles hrFiles) {
        return hrFilesDao.update(hrFiles);
    }

    @Override
    public Integer delete(Integer id) {
        return hrFilesDao.delete(id);
    }

}
