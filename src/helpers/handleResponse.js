const sendResponse = (res, msgKey, code, payload) => {
    const data = payload ? payload?.data : undefined;
    return res.status(code).json({
        success: code >= 200 && code < 300,
        code: code,
        msg: msgKey,
        data
    });
};

module.exports = sendResponse;