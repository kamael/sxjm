function p = p_fan( t_sunroom, d_t)
%输入太阳房温度, 温度差， 输出风扇每 36秒 运送的热量
    global is_fan_on    
    global piece
    p = 0
    p_work = 145 * piece * d_t
    
    
    max_t = 32
    min_t = max_t - 7
    
    if is_fan_on
        if t_sunroom < min_t       %工作的时候，如果温度低于 32 - 7 度，停止工作
            is_fan_on = false
            p = 0
        else
            p = p_work              %否则正常工作
        end
    else
        if t_sunroom > max_t    %风扇工作的时候，如果温度达到了 32 度，开始工作
            p = p_work
            is_fan_on = true
        else                %否则保持不工作
            p = 0
        end

end

