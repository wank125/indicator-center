package com.qctc.bdss.indicator.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.qctc.bdss.indicator.entity.Dimension;
import com.qctc.bdss.indicator.mapper.DimensionMapper;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class DimensionService extends ServiceImpl<DimensionMapper, Dimension> {

    public List<Dimension> listByType(String dimType, Long tenantId) {
        LambdaQueryWrapper<Dimension> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Dimension::getDimType, dimType);
        if (tenantId != null) {
            wrapper.eq(Dimension::getTenantId, tenantId);
        }
        wrapper.orderByAsc(Dimension::getSortOrder);
        return list(wrapper);
    }

    public List<Dimension> treeByType(String dimType, Long tenantId) {
        List<Dimension> all = listByType(dimType, tenantId);
        Map<Long, List<Dimension>> childrenMap = all.stream()
                .filter(d -> d.getParentId() != null)
                .collect(Collectors.groupingBy(Dimension::getParentId));

        List<Dimension> roots = all.stream()
                .filter(d -> d.getParentId() == null || d.getParentId() == 0)
                .collect(Collectors.toList());

        for (Dimension root : roots) {
            fillChildren(root, childrenMap);
        }
        return roots;
    }

    private void fillChildren(Dimension parent, Map<Long, List<Dimension>> childrenMap) {
        List<Dimension> children = childrenMap.getOrDefault(parent.getId(), new ArrayList<>());
        parent.setChildren(children);
        for (Dimension child : children) {
            fillChildren(child, childrenMap);
        }
    }
}
