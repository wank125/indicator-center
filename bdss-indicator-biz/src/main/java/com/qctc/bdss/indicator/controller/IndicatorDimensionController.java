package com.qctc.bdss.indicator.controller;

import com.qctc.bdss.indicator.dto.R;
import com.qctc.bdss.indicator.entity.Dimension;
import com.qctc.bdss.indicator.service.DimensionService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/qctc/indicator/dimensions")
@RequiredArgsConstructor
public class IndicatorDimensionController {

    private final DimensionService dimensionService;

    @GetMapping("/tree")
    public R<List<Dimension>> tree(@RequestParam String dimType,
                                   @RequestParam(required = false) Long tenantId) {
        return R.ok(dimensionService.treeByType(dimType, tenantId));
    }

    @GetMapping
    public R<List<Dimension>> list(@RequestParam String dimType,
                                   @RequestParam(required = false) Long tenantId) {
        return R.ok(dimensionService.listByType(dimType, tenantId));
    }

    @PostMapping
    public R<Void> add(@RequestBody Dimension dim) {
        dimensionService.save(dim);
        return R.ok();
    }

    @PutMapping("/{id}")
    public R<Void> update(@PathVariable Long id, @RequestBody Dimension dim) {
        dim.setId(id);
        dimensionService.updateById(dim);
        return R.ok();
    }

    @DeleteMapping("/{id}")
    public R<Void> remove(@PathVariable Long id) {
        dimensionService.removeById(id);
        return R.ok();
    }
}
