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
        return R.ok(indicatorDefService.getByCode(code, tenantId));
    }

    @PostMapping
    public R<Void> add(@RequestBody IndicatorDef def) {
        indicatorDefService.save(def);
        return R.ok();
    }

    @PutMapping("/{code}")
    public R<Void> update(@PathVariable String code, @RequestBody IndicatorDef def) {
        IndicatorDef existing = indicatorDefService.getByCode(code, def.getTenantId());
        if (existing == null) {
            return R.fail("指标不存在: " + code);
        }
        def.setId(existing.getId());
        indicatorDefService.updateById(def);
        return R.ok();
    }

    @DeleteMapping("/{code}")
    public R<Void> remove(@PathVariable String code,
                          @RequestParam(required = false) Long tenantId) {
        IndicatorDef existing = indicatorDefService.getByCode(code, tenantId);
        if (existing == null) {
            return R.fail("指标不存在: " + code);
        }
        indicatorDefService.removeById(existing.getId());
        return R.ok();
    }
}
