% 文件列表
file_list = {'../../Datas/折线图/定位轨迹1.csv','../../Datas/折线图/定位轨迹2.csv'};

% 初始化图形
figure;
hold on;

% ===========================数据处理===========================


% 读取CSV文件
data = readtable(file_list{1});

% 提取数据
true_distance = data.true_distance;
error = data.error;

% 插值拟合
frame_num_interp = linspace(min(true_distance), max(true_distance), 500); % 创建插值点
error_interp = interp1(true_distance, error, frame_num_interp, 'spline'); % 使用样条插值

% 读取CSV文件
data2 = readtable(file_list{2});
% 提取数据
true_distance2 = data2.true_distance;
error2 = data2.error;
% 插值拟合
frame_num_interp2 = linspace(min(true_distance2), max(true_distance2), 500); % 创建插值点
error_interp2 = interp1(true_distance, error2, frame_num_interp, 'spline'); % 使用样条插值


% ===========================绘图===========================
%线条样式设置，粗细设置，样式设置，颜色设置
line_width={1,2};
line_styles = {'-.', '-'}; % 定义不同的线型
% 定义颜色 (十六进制)
hex_colors = {'#00adb5', '#9f86c0', '#231942'};
% 配色网https://www.peisebiao.com/

% 将十六进制颜色转换为 RGB 三元组
colors = cellfun(@(x) hex2rgb(x), hex_colors, 'UniformOutput', false);


% ==================xy轴配置============================
xlim([0, 9000]); % 设置 x 轴范围
ylim([0, 50]);   % 设置 y 轴范围

% 添加图形标签和标题
xlabel('航行距离/m', 'FontSize', 20);
ylabel('误差/m', 'FontSize', 20);

% 添加标题
title('航线2前后端误差统计', 'FontSize', 28);

% 设置坐标轴文字大小
set(gca, 'FontSize', 16);

% 确保标签和标题的字体大小生效
set(get(gca, 'XLabel'), 'FontSize', 20);
set(get(gca, 'YLabel'), 'FontSize', 20);
set(get(gca, 'Title'), 'FontSize', 24);





% 绘制图形
% 画曲线
plot(frame_num_interp, error_interp, 'Color', colors{1}, 'LineWidth', line_width{1}, 'LineStyle', line_styles{1});
% 画散点
scatter(true_distance, error, 36, 'MarkerEdgeColor', colors{1}, 'MarkerFaceColor', colors{1}, 'LineWidth',2);
% -------------------第二条线-------------------
% 绘制图形
plot(frame_num_interp2, error_interp2, 'Color', colors{2}, 'LineWidth', line_width{2}, 'LineStyle', line_styles{2});
% 画散点
scatter(true_distance2, error2, 70,'^', 'MarkerEdgeColor', colors{2}, 'MarkerFaceColor', colors{2}, 'LineWidth',1);




% =================其他配置=======================

% 添加图例，后面几个参数分别是图例的内容，字体大小，位置，边框是否显示
legend({'','纯前端定位结果','纯后端定位失败', '','纯后端定位结果'}, 'FontSize', 18, 'Box', 'off');

grid on; % 显示网格
% 设置网格密度
set(gca, 'GridLineStyle', ':', 'XGrid', 'on', 'YGrid', 'on', 'GridAlpha', 1);












% ====================读取颜色函数实现====================

function rgb = hex2rgb(hex)
    hex = char(hex);
    if hex(1) == '#'
        hex = hex(2:end);
    end
    if numel(hex) ~= 6
        error('输入的十六进制颜色代码无效');
    end
    r = hex2dec(hex(1:2)) / 255;
    g = hex2dec(hex(3:4)) / 255;
    b = hex2dec(hex(5:6)) / 255;
    rgb = [r, g, b];
end