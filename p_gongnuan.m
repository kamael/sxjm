function p = p_gongnuan( t_house )
%输入房间温度， 输出锅炉每 36秒 发出的热量
    global is_gongnuan_on
    global piece
    p = 0
    p_work = 8400 * piece
    
    if is_gongnuan_on
        if t_house > 18     %供暖的时候，如果温度达到了 18 度，停止供暖
            is_gongnuan_on = false
        else                %否则继续供暖
            p = p_work
        end
    else
        if t_house < 5      %不供暖的时候，如果温度低于 5 度，开始供暖
            is_gongnuan_on = true
            p = p_work
        else
            p = 0           %否则不供暖
        end
end

