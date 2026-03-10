% DRAWS CROSS SECTIONS BASED ON ELEVATION. X SPACING IS USER DEFINED IN
% ARCGIS. MUST RUN Puritan_XSEC_DataProcess.m FIRST

%% INPUT PROCESSED DATA 
clear all; close all; clc;

load("ArgyleAllData.mat")


%% RESISTIVITY AND WATER ZONES

% reszones.dropx = [c04w.surf_dist(29), (c02xw.surf_dist(48) + c02xw.surf_dist(49))/2, ...
%                   c03xw.surf_dist(60)+2.5];
% reszones.dropy = [10, 16, 40];
% 
% reszones.smoothdecx = [c04w.surf_dist(29), (c02xw.surf_dist(48) + c02xw.surf_dist(49))/2, ...
%                         c03xw.surf_dist(60)];
% reszones.smoothdecy = [-12, -10];
% 
% reszones.notsmoothdecx = [c04w.surf_dist(29), (c02xw.surf_dist(48) + c02xw.surf_dist(49))/2, ...
%                          c03xw.surf_dist(60)];
% reszones.notsmoothdecy = [30, 30];
% 
% reszones.variablelowqcx = [c04w.surf_dist(29), (c02xw.surf_dist(48) + c02xw.surf_dist(49))/2, ...
%                             c03xw.surf_dist(60)];
% reszones.variablelowqcy = [60, 30];
% 
waterzones.x = [c03xa.surf_dist(7), c01xa.surf_dist(12),  240, 330, 400];
waterzones.y = [c03xa.cpt_water, c01xa.cpt_water,  107.473, 107.834, 107.862];
% 
% postsurf.x = [360, 473, 473, 588, 592, 598];
% postsurf.y = [30.79, 38.7958, 38.7958, 65.7509, 65.7509, 84.67];
% 
% presurf.x = presurf(:, 2);
% presurf.y = presurf(:, 1);
%
slipsurf.x = [130, 140, 170, 270];
slipsurf.y = [134.762, 126.025, 101, 101];

%% Calculating pre and post slide area or mass of the slide block

perimeter.preblock = [130 134.762266000000
140 134.151563000000
150 131.412805000000
160 124.853434000000
170 121.024402000000
180 118.828447000000
190 116.219948000000
200 112.718523000000
210 109.914549000000
213 100.4930
140 100.4930
130 134.762266000000
];

perimeter.postblock = [
130 134.762266000000
140 126.025204164040
150 120.475938894600
160 115.134367201360
170 113.385695885560
180 112.829439306080
190 114.319262188400
200 115.226719566520
210 111.699691894600
220 113.848848787520
230 109.906847349040
240 107.473028373520
270 100.4930
140 100.4930
130 134.762266000000
];

area.preblock = polyarea(perimeter.preblock(:, 1), perimeter.preblock(:, 2));  % area of irregular polygon
area.postblock = polyarea(perimeter.postblock(:, 1), perimeter.postblock(:, 2));

areadiff = area.preblock-area.postblock; fprintf('areadiff, %.2f', areadiff);

% %% based on trial and error find the x and y that makes the post and pre
% % block area the same with respect to the slip surface chosen based on su
% % and ST
% 
% pre0 = perimeter.preblock;
% post0 = perimeter.postblock;
% 
% bestX = NaN;
% bestY = NaN;
% bestDiff = Inf;
% 
% for y = 98:0.001:102
%     for x = 210:240
%         pre = pre0;
%         post = post0;
% 
%         pre(pre(:,2)==101.035,2) = y;
%         post(post(:,2)==101.035,2) = y;
% 
%         pre(10,1) = x;
% 
%         Apre = polyarea(pre(:,1), pre(:,2));
%         Apost = polyarea(post(:,1), post(:,2));
% 
%         diff = Apre - Apost;
% 
%         if abs(diff) < abs(bestDiff)
%             bestDiff = diff;
%             bestX = x;
%             bestY = y;
%         end
%     end
% end
% 
% bestX
% bestY
% bestDiff

bathymetry.post = post_bathymetry;
bathymetry.pre = [109.914549000000, -20, 210
100.493000000000          -10       230
101.035176    0        270
100.935251   10        280
101.228481   20        300
101.524130   30        330
101.859026   40        370
102.343972   50        420
102.983440   60        480
103.492608   70        550
103.868390   80        630
104.144299   90        720
104.365300  100        820
104.542328  110        930
104.714744  120       1050
104.830286  130       1180
104.918982  140       1320
104.939422  150       1470
104.948042  160       1630
104.980564  170       1800
104.940205  180       1980
104.876326  190       2170
104.799864  200       2370
104.831717  210       2580
104.882867  220       2800
104.837250  230       3030
104.648801  240       3270
104.464903  250       3520
104.429714  260       3780
104.394488  270       4050
104.369129  280       4330
104.391258  290       4620
104.404436  300       4920
104.360496  310       5230
104.343589  320       5550
104.384081  330       5880
104.460814  340       6220
104.542446  350       6570
104.625964  360       6930
104.767470  370       7300
104.892277  380       7680
105.031219  390       8070
105.132388  400       8470
105.184306  410       8880
105.166680  420       9300
105.050214  430       9730
104.898893  440      10170
104.783440  450      10620
104.706234  460      11080
104.579517  470      11550
104.382473  480      12030
104.180754  490      12520
104.008865  500      13020
103.865368  510      13530
103.781886  520      14050
103.777630  530      14580
103.746847  540      15120
103.573925  550      15670
103.406138  560      16230
103.340840  570      16800
103.402371  580      17380
103.463673  590      17970
103.455173  600      18570
103.459463  610      19180
103.317494  620      19800
103.169074  630      20430
103.149432  640      21070
103.124877  650      21720
103.084108  660      22380
102.999013  670      23050
102.888178  680      23730
102.776130  690      24420
102.703157  700      25120
102.711261  710      25830
102.846573  720      26550
103.055310  730      27280
103.206930  740      28020
103.191872  750      28770
103.219645  760      29530
103.325483  770      30300
103.423027  780      31080
103.496042  790      31870
103.556976  800      32670
103.635771  810      33480
103.772483  820      34300
103.927306  830      35130
104.064236  840      35970
104.155886  850      36820
104.314893  860      37680
104.491797  870      38550
104.701554  880      39430
104.947983  890      40320
105.170541  900      41220
105.345581  910      42130
105.386203  920      43050
105.345057  930      43980
105.253562  940      44920
105.155246  950      45870
105.066448  960      46830
104.963691  970      47800
104.881455  980      48780
104.776324  990      49770
104.683315 1000      50770
104.591177 1010      51780
NaN        1020      52800
NaN        1030      53830
NaN        1040      54870
NaN      1048.45767100000 55918.4576710000
];


%% GENERATE FIGURE: CROSS SECTION AND SU

close all
fig1 = figure('Color','w', 'Position', [1921,49,1920,955]);
t = tiledlayout(fig1, 2, 8, 'TileSpacing', 'compact', 'Padding', 'compact');
ax1 = nexttile(t, [1 8]); % spans 1 row and 8 columns

% Plot surface ============================================================

plot(ax1, c01xa.surf_dist, c01xa.surf_elv, 'LineWidth', 2, 'Color', [0 0 0 1])
hold(ax1, 'on')
%plot(ax1, c02xa.surf_dist, c02xa.surf_elv, 'LineWidth', 2, 'Color', [0 0 0 1])
plot(ax1, presurf(:, 2), presurf(:, 1), 'LineWidth', 2, 'Color', [0 0 0 0.3])
plot(ax1, bathymetry.post(:, 3), bathymetry.post(:, 1), 'LineWidth', 2, 'Color', [150, 0, 110, 255]./255, 'LineStyle','--')
plot(ax1, bathymetry.pre(:, 3), bathymetry.pre(:, 1), 'LineWidth', 2, 'Color', [150, 0, 110, 100]./255, 'LineStyle','--')

% Plot CPT stick ==========================================================

patch(ax1, 'XData', c01xa.cpt_stickx, 'YData', c01xa.cpt_sticky, 'FaceColor', 'w');
patch(ax1, 'XData', c02xa.cpt_stickx, 'YData', c02xa.cpt_sticky, 'FaceColor', 'w');
patch(ax1, 'XData', c03xa.cpt_stickx, 'YData', c03xa.cpt_sticky, 'FaceColor', 'w');

% Plot Water in CPT ==============================================================

plot(ax1, [c01xa.cpt_stickx(1), c01xa.cpt_stickx(end)], [c01xa.cpt_water, c01xa.cpt_water], 'LineWidth', 2, 'Color', 'b')
plot(ax1, [c02xa.cpt_stickx(1), c02xa.cpt_stickx(end)], [c02xa.cpt_water, c02xa.cpt_water], 'LineWidth', 2, 'Color', 'b')
plot(ax1, [c03xa.cpt_stickx(1), c03xa.cpt_stickx(end)], [c03xa.cpt_water, c03xa.cpt_water], 'LineWidth', 2, 'Color', 'b')

% Main x-axis: distance along the profile =================================

ax1.YLim = [80, 150];
ax1.XLim = [0 400];
ax1.FontName = 'Times New Roman';
ax1.FontSize = 14;
xlabel(ax1, 'Distance, [ft]', 'FontSize', 16);
ylabel(ax1, 'Elevation, [ft]', 'FontSize', 16);
title('Argyle Profile 2', 'FontName', 'Times New Roman', 'FontSize', 16);
grid(ax1, 'minor'); box(ax1, 'on');
 
% CPT ID Texts ============================================================

txt = sprintf('C-01XA');
text(107, 140, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring
txt = sprintf('C-02XA (89.76 ft S)');
text(75, 140, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring
txt = sprintf('C-03XA (65.25 ft S)');
text(40, 140, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring

% Plot Boring stick ==========================================================

patch(ax1, 'XData', b01xa.bor_stickx, 'YData', b01xa.bor_sticky, 'FaceColor', 'w');
patch(ax1, 'XData', b02xa.bor_stickx, 'YData', b02xa.bor_sticky, 'FaceColor', 'w');

% B-01XA Soil Class ==========================================================

l1 = patch(ax1, 'XData', b01xa.layer.x1, 'YData', b01xa.layer.y1, 'FaceColor', col.topsoil);
hatchfill2(l1, 'cross', 'LineWidth', 1, 'HatchAngle', 45, 'HatchDensity', 100);
pg1 = polyshape(b01xa.layer.x1, b01xa.layer.y1); [cx1, cy1] = centroid(pg1);
text(ax1, 120, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10, 'Color', 'k');

l2 = patch(ax1, 'XData', b01xa.layer.x2, 'YData', b01xa.layer.y2, 'FaceColor', col.fill);
hatchfill2(l2, 'cross', 'LineWidth', 1, 'HatchAngle', 45, 'HatchDensity', 100);
pg1 = polyshape(b01xa.layer.x2, b01xa.layer.y2); [cx1, cy1] = centroid(pg1);
text(ax1, 120, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10, 'Color', 'k');

l3 = patch(ax1, 'XData', b01xa.layer.x3, 'YData', b01xa.layer.y3, 'FaceColor', col.sand);
hatchfill2(l3, 'single', 'LineWidth', 1, 'HatchAngle', 45, 'HatchDensity', 100);
pg1 = polyshape(b01xa.layer.x3, b01xa.layer.y3); [cx1, cy1] = centroid(pg1);
text(ax1, 120, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10, 'Color', 'k');

l4 = patch(ax1, 'XData', b01xa.layer.x4, 'YData', b01xa.layer.y4, 'FaceColor', col.clay);
hatchfill2(l4, 'fill');
pg1 = polyshape(b01xa.layer.x4, b01xa.layer.y4); [cx1, cy1] = centroid(pg1);
text(ax1, 120, cy1, '0.22-0.32', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10, 'Color', 'k');

% B-02XA
l1 = patch(ax1, 'XData', b02xa.layer.x1, 'YData', b02xa.layer.y1, 'FaceColor', col.topsoil);
hatchfill2(l1, 'cross', 'LineWidth', 1, 'HatchAngle', 45, 'HatchDensity', 100);
pg1 = polyshape(b02xa.layer.x1, b02xa.layer.y1); [cx1, cy1] = centroid(pg1);
text(ax1, 87, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10, 'Color', 'k');

l2 = patch(ax1, 'XData', b02xa.layer.x2, 'YData', b02xa.layer.y2, 'FaceColor', col.sand);
hatchfill2(l2, 'single', 'LineWidth', 1, 'HatchAngle', 45, 'HatchDensity', 100);
pg1 = polyshape(b02xa.layer.x2, b02xa.layer.y2); [cx1, cy1] = centroid(pg1);
text(ax1, 87, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10, 'Color', 'k');

l3 = patch(ax1, 'XData', b02xa.layer.x3, 'YData', b02xa.layer.y3, 'FaceColor', col.clay);
hatchfill2(l3, 'single', 'LineWidth', 1, 'HatchAngle', 90, 'HatchDensity', 500);
pg1 = polyshape(b02xa.layer.x3, b02xa.layer.y3); [cx1, cy1] = centroid(pg1);
text(ax1, 87, cy1, '> 0.5', 'Rotation', 0, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10, 'Color', 'k');

l4 = patch(ax1, 'XData', b02xa.layer.x4, 'YData', b02xa.layer.y4, 'FaceColor', col.clay);
hatchfill2(l4, 'fill');
pg1 = polyshape(b02xa.layer.x4, b02xa.layer.y4); [cx1, cy1] = centroid(pg1);
text(ax1, 87, cy1, '0.35-0.4', 'Rotation', 0, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10, 'Color', 'k');

% Plot Water in boring ====================================================

plot(ax1, [b01xa.bor_stickx(1), b01xa.bor_stickx(end)], [b01xa.bor_water, b01xa.bor_water], 'LineWidth', 2, 'Color', 'b')
plot(ax1, [b02xa.bor_stickx(1), b02xa.bor_stickx(end)], [b02xa.bor_water, b02xa.bor_water], 'LineWidth', 2, 'Color', 'b')

% Plot shelby tube samples ================================================

% B01XA
x = [b01xa.bor_stickx(1), b01xa.bor_stickx(end)];
plot(ax1, x, [b01xa.samples(1), b01xa.samples(1)], 'LineWidth', 2, 'Color', 'g')
plot(ax1, x, [b01xa.samples(2), b01xa.samples(2)], 'LineWidth', 2, 'Color', 'g')
plot(ax1, x, [b01xa.samples(3), b01xa.samples(3)], 'LineWidth', 2, 'Color', 'g')
plot(ax1, x, [b01xa.samples(4), b01xa.samples(4)], 'LineWidth', 2, 'Color', 'r')

% B02XA
x = [b02xa.bor_stickx(1), b02xa.bor_stickx(end)];
plot(ax1, x, [b02xa.samples(1), b02xa.samples(1)], 'LineWidth', 2, 'Color', 'g')
plot(ax1, x, [b02xa.samples(2), b02xa.samples(2)], 'LineWidth', 2, 'Color', 'r')

% Boring ID Texts =========================================================

txt = sprintf('B-01XA');
text(113, 143, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring
txt = sprintf('B-02XA (89.71 ft S)');
text(80, 143, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring

% % Plot post slide surface =================================================

% line(ax1, 'XData', postsurf.x, 'YData', postsurf.y, 'LineWidth', 2, 'Color', [0 0 0 1])

% Plot slip surface =======================================================

line(ax1, 'XData', slipsurf.x, 'YData', slipsurf.y, 'LineWidth', 1, 'Color', 'r')

% % Plot resistivity zones ==================================================

% line(ax1, 'XData', reszones.dropx, 'YData', reszones.dropy, 'LineWidth', 1, 'Color', 'k', 'LineStyle', '--')
% line(ax1, 'XData', reszones.smoothdecx, 'YData', reszones.smoothdecy, 'LineWidth', 1, 'Color', 'k', 'LineStyle', '--')
% line(ax1, 'XData', reszones.notsmoothdecx, 'YData', reszones.notsmoothdecy, 'LineWidth', 1, 'Color', 'k', 'LineStyle', '--')
% line(ax1, 'XData', reszones.variablelowqcx, 'YData', reszones.variablelowqcy, 'LineWidth', 1, 'Color', 'k', 'LineStyle', '--')
% hold on
% 
% Plot water table? =======================================================

line(ax1, 'XData', waterzones.x, 'YData', waterzones.y, 'LineWidth', 2, 'Color', 'b', 'LineStyle', ':')


% Plot legend =============================================================
legend(ax1, 'Current Surface', 'Previous Surface', 'Current Bathymetry', 'Previous Bathymetry', '', '', '', '', ...
    '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ...
    '', '', '', '', '', '', '', '', '', '', ...
    'Slip Surface', 'Water', 'Location', 'southwest')

% C-01XA plot: su ==========================================================

ax2 = nexttile(t, 11); % next tiles in second row
plot(c01xa.cpt_su, c01xa.cpt_elv, 'k')
hold on
yline(c01xa.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
yline(101, 'LineWidth', 1.5, 'Color', 'r', 'LineStyle', '--')
scatter(b01xa.mdotsu.peakx, b01xa.mdotsu.peaky, 15, 'filled', 'Marker', 'o', 'MarkerEdgeColor','m', 'MarkerFaceColor','m')
scatter(b01xa.mdotsu.remoldedx, b01xa.mdotsu.remoldedy, 15, 'Marker', 'o', 'MarkerEdgeColor', 'm', 'LineWidth', 1, 'MarkerFaceColor', 'w')
ax2.YLim = [90, 140];
ax2.XLim = [0 2000];
ax2.FontName = 'Times New Roman';
ax2.FontSize = 14;
xlabel(ax2, 's_u, [psf]', 'FontSize', 16);
ylabel(ax2, 'Elevation, [ft]', 'FontSize', 16);
title(ax2, 'C-01XA')
grid(ax2, 'minor'); box(ax2, 'on');

% C-02XA plot: su =========================================================

ax3 = nexttile(t, 12); % next tiles in second row
plot(c02xa.cpt_su, c02xa.cpt_elv, 'k')
hold on
yline(c02xa.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
yline(101, 'LineWidth', 1.5, 'Color', 'r', 'LineStyle', '--')
scatter(b02xa.mdotsu.peakx, b02xa.mdotsu.peaky, 15, 'filled', 'Marker', 'o', 'MarkerEdgeColor','m', 'MarkerFaceColor','m')
scatter(b02xa.mdotsu.remoldedx, b02xa.mdotsu.remoldedy, 15, 'Marker', 'o', 'MarkerEdgeColor', 'm', 'LineWidth', 1, 'MarkerFaceColor', 'w')
ax3.YLim = [90, 140];
ax3.XLim = [0 2000];
ax3.FontName = 'Times New Roman';
ax3.FontSize = 14;
xlabel(ax3, 's_u, [psf]', 'FontSize', 16);
ylabel(ax3, 'Elevation, [ft]', 'FontSize', 16);
title(ax3, 'C-02XA')
grid(ax3, 'minor'); box(ax3, 'on');

% C-03XA plot: su =========================================================

ax4 = nexttile(t, 13); % next tiles in second row
plot(c03xa.cpt_su, c03xa.cpt_elv, 'k')
yline(c03xa.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
yline(101, 'LineWidth', 1.5, 'Color', 'r', 'LineStyle', '--')
ax4.YLim = [90, 140];
ax4.XLim = [0 2000];
ax4.FontName = 'Times New Roman';
ax4.FontSize = 14;
xlabel(ax4, 's_u, [psf]', 'FontSize', 16);
ylabel(ax4, 'Elevation, [ft]', 'FontSize', 16);
title(ax4, 'C-03XA')
grid(ax4, 'minor'); box(ax4, 'on');

