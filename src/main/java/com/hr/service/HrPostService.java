package com.hr.service;

import com.hr.entity.HrPost;

import java.util.List;
import java.util.Map;

public interface HrPostService {

    public List<HrPost> countList();

    public List<HrPost> list(Map<String,Object> map);

    public HrPost findById(Integer id);

    public Long getTotal(Map<String,Object> map);

    public Integer add(HrPost hrPost);

    public Integer update(HrPost hrPost);

    public Integer delete(Integer id);

}
