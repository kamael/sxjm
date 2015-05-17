function t = get_t_of_day()
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
x = [2, 5, 8, 11, 14, 17, 20, 23]
y = [0.6, -1.4, -1.1, 5.4, 6.4, 5.0, 4.8, 0.9]
% 时间-温度抽样值

v = 0:0.01:24          %把一天分为个时刻点
f_x = polyfit(x, y, 3)   %模拟函数的系数
t = f_x(1) * v.^3 + f_x(2) * v.^2 + f_x(3) * v + f_x(4)
%返回这240个时刻点的温度
end

