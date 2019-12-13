package com.hr.service;

import com.hr.entity.HrFiles;

import java.util.List;
import java.util.Map;

public interface HrFilesService {

    public List<HrFiles> countList();

    public List<HrFiles> list(Map<String,Object> map);

    public HrFiles findById(Integer id);

    public Long getTotal(Map<String,Object> map);

    public Integer add(HrFiles hrFiles);

    public Integer update(HrFiles hrFiles);

    public Integer delete(Integer id);

}
