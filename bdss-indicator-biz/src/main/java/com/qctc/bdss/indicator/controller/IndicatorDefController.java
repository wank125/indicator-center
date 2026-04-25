package com.qctc.bdss.indicator.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.qctc.bdss.indicator.dto.R;
import com.qctc.bdss.indicator.dto.request.IndicatorQueryReq;
import com.qctc.bdss.indicator.entity.IndicatorDef;
import com.qctc.bdss.indicator.service.IndicatorDefService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/qctc/indicator/definitions")
@RequiredArgsConstructor
public class IndicatorDefController {

    private final IndicatorDefService indicatorDefService;

    @GetMapping
    public R<IPage<IndicatorDef>> list(IndicatorQueryReq req) {
        return R.ok(indicatorDefService.pageQuery(req));
    }

    @GetMapping("/{code}")
    public R<IndicatorDef> getByCode(@PathVariable String code,
                                     @RequestParam(required = false) Long tenantId) {
        IndicatorDef def = indicatorDefService.getByCode(code, tenantId);
        if (def == null) {
            return R.notFound("指标不存在: " + code);
        }
        return R.ok(def);
    }

    @PostMapping
    public R<Void> add(@RequestBody IndicatorDef def) {
        IndicatorDef existing = indicatorDefService.getByCode(def.getIndicatorCode(), def.getTenantId());
        if (existing != null) {
            return R.badRequest("指标编码已存在: " + def.getIndicatorCode());
        }
        indicatorDefService.save(def);
        return R.ok();
    }

    @PutMapping("/{code}")
    public R<Void> update(@PathVariable String code, @RequestBody IndicatorDef def) {
        IndicatorDef existing = indicatorDefService.getByCode(code, def.getTenantId());
        if (existing == null) {
            return R.notFound("指标不存在: " + code);
        }
        def.setId(existing.getId());
        def.setIndicatorCode(code);
        indicatorDefService.updateById(def);
        return R.ok();
    }

    @DeleteMapping("/{code}")
    public R<Void> remove(@PathVariable String code,
                          @RequestParam(required = false) Long tenantId) {
        IndicatorDef existing = indicatorDefService.getByCode(code, tenantId);
        if (existing == null) {
            return R.notFound("指标不存在: " + code);
        }
        indicatorDefService.removeById(existing.getId());
        return R.ok();
    }
}
