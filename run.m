t_house = 2         %房间的初始温度
t_sunroom = 2       %太阳能房的初始温度
t_of_day = get_t_of_day()

house_w = 7
house_l = 10
house_h = 3
house_surface_out = house_w * house_l + 2 * house_w * house_h
                        + house_l * house_h
%房间墙壁（包括屋顶）散热面积
house_v = house_w * house_l * house_h

house_surface_sunroom = house_l * house_h
%房子与太阳房共面的面积

sunroom_w = 3
sunroom_l = 10
sunroom_h = 3
sunroom_surface_out = sunroom_w * sunroom_l + 2 * sunroom_w * sunroom_h
                        + sunroom_l * sunroom_h
sunroom_v = sunroom_h * sunroom_w * sunroom_l


% 为了求解精确，这里不从开尔文0度算起，因为方程中计算的都是能量变化值，
% 因此不影响结果
e_house = 1305.48 * house_v * t_house               %房子的热能
e_sunroom = 1305.48 * sunroom_v * t_sunroom         %太阳能房的热能

max_e_sunroom = 1305.48 * sunroom_v * 50

global is_fan_on
global is_gongnuan_on

is_fan_on = false
is_gongnuan_on = false
global piece

t_house_a_day = []
t_sunroom_a_day = []

eg = 0.1
piece = 3600 * eg
i = 0
for v = 0:eg:24
%计算各个时刻点独立房间，太阳能房间的温度
%时刻单位为 36秒
    i = i + 1
    t_out = t_of_day(i)
    t_house = e_house / (1305.48 * house_v)
    t_sunroom = e_sunroom / (1305.48 * sunroom_v)
    
    t_house_a_day(i) = t_house
    t_sunroom_a_day(i) = t_sunroom
    
    %房子能量的总量的变化
    e_house = e_house + p_gongnuan(t_house) ...
                - p_qiang(house_surface_out, t_house - t_out)   ...
                + p_qiang(house_surface_sunroom, t_sunroom - t_house)   ...
                + p_fan(t_sunroom, t_sunroom - t_house)
    
    %太阳能房内能量的变化        
    e_sunroom = e_sunroom + p_sun(v)    ...
                - p_qiang(sunroom_surface_out, t_sunroom - t_out)   ...
                - p_qiang(house_surface_sunroom, t_sunroom - t_house)   ...
                - p_fan(t_sunroom, t_sunroom - t_house)
    
   if e_sunroom > max_e_sunroom
       e_sunroom = max_e_sunroom
   end
    
end

