package com.qctc.bdss.indicator.dto;

import lombok.Data;

@Data
public class R<T> {

    private int code;
    private String msg;
    private T data;
    private long timestamp;

    private R() {
        this.timestamp = System.currentTimeMillis();
    }

    public static <T> R<T> ok(T data) {
        R<T> r = new R<>();
        r.setCode(200);
        r.setMsg("success");
        r.setData(data);
        return r;
    }

    public static <T> R<T> ok() {
        return ok(null);
    }

    public static <T> R<T> fail(int code, String msg) {
        R<T> r = new R<>();
        r.setCode(code);
        r.setMsg(msg);
        return r;
    }

    public static <T> R<T> notFound(String msg) {
        return fail(404, msg);
    }

    public static <T> R<T> badRequest(String msg) {
        return fail(400, msg);
    }
}
