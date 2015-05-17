function p_of_qiang = get_p_of_qiang( t0, t1 )
%输入两个温度值，返回墙壁在这种温差下的散热功率



p_of_qiang = 1.27 * S * (t0 - t1)
end

