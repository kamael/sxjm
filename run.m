clear

t_house = 2         %房间的初始温度
t_sunroom = 2       %太阳能房的初始温度
t_of_day = get_t_of_day()

%独立房间长，宽，高
house_w = 7
house_l = 10
house_h = 3

%房间墙壁散热面积
house_surface_out = 2 * house_w * house_h + house_l * house_h

%房子的体积
house_v = house_w * house_l * house_h

%房子与太阳房共面的面积
house_surface_sunroom = house_l * house_h

%太阳能房的长，宽，高
sunroom_w = 3
sunroom_l = 10
sunroom_h = 3

%太阳能房墙壁面积
sunroom_surface_out = 2 * sunroom_w * sunroom_h + sunroom_l * sunroom_h
%太阳能房体积
sunroom_v = sunroom_h * sunroom_w * sunroom_l


% 为了求解精确，这里不从开尔文0度算起，因为方程中计算的都是能量变化值，
% 因此不影响结果
e_house = 1305.48 * house_v * t_house               %房子的热能
e_sunroom = 1305.48 * sunroom_v * t_sunroom         %太阳能房的热能


global is_fan_on        %风扇是否开关
global is_gongnuan_on   %锅炉是否开关

is_fan_on = false
is_gongnuan_on = false

global piece            %程序中使用的时间片，比如 piece = 36， 即 36秒为一单元

t_house_a_day = []      %房子一天各个时间点的温度，用于绘图
t_sunroom_a_day = []    %太阳房一天各个时间点的温度，用于绘图

global eg
eg = 0.01                %一小时分成的份数的倒数，比如 eg = 0.1，即一小时分为10个单元
piece = 3600 * eg       %每份的秒数

e_max_sunroom_t = 1305.48 * sunroom_v * 50

i = 0
for v = 0:eg:24
%计算各个时刻点独立房间，太阳能房间的温度
%时刻单位为 36秒
    i = i + 1
    t_out = t_of_day(i)                             %外界温度
    t_house = e_house / (1305.48 * house_v)         %房间内温度
    t_sunroom = e_sunroom / (1305.48 * sunroom_v)   %太阳房温度
    
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
   
    %限制太阳能房最高温度 50 度
    if e_sunroom > e_max_sunroom_t
        e_sunroom = e_max_sunroom_t
    end     
end

%绘图 
v = 0:eg:24
hold on
plot(v, t_of_day)
plot(v, t_house_a_day)
plot(v, t_sunroom_a_day)
axis([0 24 -10 50])
set(gca,'XTick',0:1:24);
set(gca,'YTick',-10:10:50);
xlabel('时间'),ylabel('温度'),title('温度对比');
legend('室外温度曲线', '独立房间温度曲线', '太阳房温度曲线')






