package com.qctc.bdss.indicator.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.qctc.bdss.indicator.dto.R;
import com.qctc.bdss.indicator.entity.IndDataSource;
import com.qctc.bdss.indicator.mapper.IndDataSourceMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/qctc/indicator/source")
@RequiredArgsConstructor
public class IndDataSourceController {

    private final IndDataSourceMapper indDataSourceMapper;

    @GetMapping("/list")
    public R<List<IndDataSource>> list(@RequestParam(required = false) String indicatorCode) {
        LambdaQueryWrapper<IndDataSource> wrapper = new LambdaQueryWrapper<IndDataSource>()
                .eq(indicatorCode != null, IndDataSource::getIndicatorCode, indicatorCode)
                .orderByDesc(IndDataSource::getCreateTime);
        return R.ok(indDataSourceMapper.selectList(wrapper));
    }

    @GetMapping("/{id}")
    public R<IndDataSource> getById(@PathVariable Long id) {
        return R.ok(indDataSourceMapper.selectById(id));
    }

    @PostMapping
    public R<Void> save(@RequestBody IndDataSource dataSource) {
        indDataSourceMapper.insert(dataSource);
        return R.ok();
    }

    @PutMapping("/{id}")
    public R<Void> update(@PathVariable Long id, @RequestBody IndDataSource dataSource) {
        dataSource.setId(id);
        indDataSourceMapper.updateById(dataSource);
        return R.ok();
    }

    @DeleteMapping("/{id}")
    public R<Void> delete(@PathVariable Long id) {
        indDataSourceMapper.deleteById(id);
        return R.ok();
    }

    @PostMapping("/{id}/test")
    public R<Boolean> test(@PathVariable Long id) {
        return R.ok(true);
    }
}
