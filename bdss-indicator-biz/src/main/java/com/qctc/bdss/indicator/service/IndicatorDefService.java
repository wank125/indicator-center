package com.qctc.bdss.indicator.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.qctc.bdss.indicator.dto.request.IndicatorQueryReq;
import com.qctc.bdss.indicator.entity.IndicatorDef;
import com.qctc.bdss.indicator.mapper.IndicatorDefMapper;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

@Service
public class IndicatorDefService extends ServiceImpl<IndicatorDefMapper, IndicatorDef> {

    public IPage<IndicatorDef> pageQuery(IndicatorQueryReq req) {
        LambdaQueryWrapper<IndicatorDef> wrapper = new LambdaQueryWrapper<>();
        if (StringUtils.hasText(req.getIndicatorCode())) {
            wrapper.like(IndicatorDef::getIndicatorCode, req.getIndicatorCode());
        }
        if (StringUtils.hasText(req.getIndicatorName())) {
            wrapper.like(IndicatorDef::getIndicatorName, req.getIndicatorName());
        }
        if (StringUtils.hasText(req.getMarketType())) {
            wrapper.eq(IndicatorDef::getMarketType, req.getMarketType());
        }
        if (StringUtils.hasText(req.getCategoryL1())) {
            wrapper.eq(IndicatorDef::getCategoryL1, req.getCategoryL1());
        }
        if (StringUtils.hasText(req.getCategoryL2())) {
            wrapper.eq(IndicatorDef::getCategoryL2, req.getCategoryL2());
        }
        if (req.getIndicatorType() != null) {
            wrapper.eq(IndicatorDef::getIndicatorType, req.getIndicatorType());
        }
        if (req.getCalcLayer() != null) {
            wrapper.eq(IndicatorDef::getCalcLayer, req.getCalcLayer());
        }
        if (req.getStatus() != null) {
            wrapper.eq(IndicatorDef::getStatus, req.getStatus());
        }
        if (req.getTenantId() != null) {
            wrapper.eq(IndicatorDef::getTenantId, req.getTenantId());
        }
        wrapper.orderByAsc(IndicatorDef::getCalcLayer, IndicatorDef::getIndicatorCode);
        return page(new Page<>(req.getPageNum(), req.getPageSize()), wrapper);
    }

    public IndicatorDef getByCode(String code, Long tenantId) {
        return lambdaQuery()
                .eq(IndicatorDef::getIndicatorCode, code)
                .eq(tenantId != null, IndicatorDef::getTenantId, tenantId)
                .one();
    }
}
