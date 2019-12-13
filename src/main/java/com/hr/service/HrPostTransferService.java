package com.hr.service;

import com.hr.entity.HrPostTransfer;

import java.util.List;
import java.util.Map;

public interface HrPostTransferService {

    public List<HrPostTransfer> countList();

    public List<HrPostTransfer> list(Map<String,Object> map);

    public HrPostTransfer findById(Integer id);

    public Long getTotal(Map<String,Object> map);

    public Integer add(HrPostTransfer hrPostTransfer);

    public Integer update(HrPostTransfer hrPostTransfer);

    public Integer delete(Integer id);

}
