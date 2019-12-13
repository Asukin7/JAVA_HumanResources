package com.hr.service.impl;

import com.hr.dao.HrPostTransferDao;
import com.hr.entity.HrPostTransfer;
import com.hr.service.HrPostTransferService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service("hrPostTransferService")
public class HrPostTransferServiceImpl implements HrPostTransferService {

    @Resource
    private HrPostTransferDao hrPostTransferDao;

    @Override
    public List<HrPostTransfer> countList() {
        return hrPostTransferDao.countList();
    }

    @Override
    public List<HrPostTransfer> list(Map<String, Object> map) {
        return hrPostTransferDao.list(map);
    }

    @Override
    public HrPostTransfer findById(Integer id) {
        return hrPostTransferDao.findById(id);
    }

    @Override
    public Long getTotal(Map<String, Object> map) {
        return hrPostTransferDao.getTotal(map);
    }

    @Override
    public Integer add(HrPostTransfer hrPostTransfer) {
        return hrPostTransferDao.add(hrPostTransfer);
    }

    @Override
    public Integer update(HrPostTransfer hrPostTransfer) {
        return hrPostTransferDao.update(hrPostTransfer);
    }

    @Override
    public Integer delete(Integer id) {
        return hrPostTransferDao.delete(id);
    }

}
