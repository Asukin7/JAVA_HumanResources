package com.hr.service.impl;

import com.hr.dao.HrPostDao;
import com.hr.entity.HrPost;
import com.hr.service.HrPostService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service("hrPostService")
public class HrPostServiceImpl implements HrPostService {

    @Resource
    private HrPostDao hrPostDao;

    @Override
    public List<HrPost> countList() {
        return hrPostDao.countList();
    }

    @Override
    public List<HrPost> list(Map<String, Object> map) {
        return hrPostDao.list(map);
    }

    @Override
    public HrPost findById(Integer id) {
        return hrPostDao.findById(id);
    }

    @Override
    public Long getTotal(Map<String, Object> map) {
        return hrPostDao.getTotal(map);
    }

    @Override
    public Integer add(HrPost hrPost) {
        return hrPostDao.add(hrPost);
    }

    @Override
    public Integer update(HrPost hrPost) {
        return hrPostDao.update(hrPost);
    }

    @Override
    public Integer delete(Integer id) {
        return hrPostDao.delete(id);
    }

}
