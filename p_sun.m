function p = p_sun( time )
%输入当前时间，输出太阳能 36 秒集热量
    global piece

    if time > 9 & time < 17
        p = 5553.05 * piece
        %   0   1000     5553.05    7000
    else
        p = 0
    end

end

