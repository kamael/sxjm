function p = p_qiang( surface, d_t )
%输入墙体面积，温差，输出 36秒 散的热量
    global piece
    p = 1.2 * surface * d_t * piece
end

