function p = p_sun( time )
%输入当前时间，输出太阳能 36 秒集热量
    global piece

    if time > 9 & time < 17
        p = 5560.6 * piece
    else
        p = 0
    end

end

