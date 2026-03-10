% DRAWS CROSS SECTIONS BASED ON ELEVATION. X SPACING IS USER DEFINED IN
% ARCGIS. MUST RUN Puritan_XSEC_DataProcess.m FIRST

%% INPUT PROCESSED DATA 
clear all; close all; clc;

load("WarrenAllData.mat")


%% RESISTIVITY AND WATER ZONES

reszones.dropx = [c04w.surf_dist(29), (c02xw.surf_dist(48) + c02xw.surf_dist(49))/2, ...
                  c03xw.surf_dist(60)+2.5];
reszones.dropy = [10, 16, 40];

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

waterzones.x = [140, 200, (c02xw.surf_dist(48) + c02xw.surf_dist(49))/2, c03xw.surf_dist(60)];
waterzones.y = [15.748, 15.755, c02xw.cpt_water, c03xw.cpt_water ];

% postsurf.x = [360, 473, 473, 588, 592, 598];
% postsurf.y = [30.79, 38.7958, 38.7958, 65.7509, 65.7509, 84.67];


postsurf2.x(1:37) = postsurf.x(1:37); postsurf2.x(38:44) = [360, 473, 473, 588, 592, 630, 700];
postsurf2.y(1:37) = postsurf.y(1:37); postsurf2.y(38:44) = [30.79, 38.7958, 38.7958, 65.7509, 65.7509, 71, 71];

slipsurf.x = [c04w.surf_dist(29), (c02xw.surf_dist(48) + c02xw.surf_dist(49))/2, ...
                  c03xw.surf_dist(60)+2.5, 630];
slipsurf.y = [1, 8, 32, 71];
%% GENERATE FIGURE: CROSS SECTION AND SU

close all
fig1 = figure('Color','w', 'Position', [1921,49,1920,955]);
t = tiledlayout(fig1, 2, 8, 'TileSpacing', 'compact', 'Padding', 'compact');
ax1 = nexttile(t, [1 8]); % spans 1 row and 8 columns

% Plot surface ============================================================

plot(ax1, c04w.surf_dist, c04w.surf_elv, 'LineWidth', 1, 'Color', [0 0 0 0.5])
hold(ax1, 'on')

% Plot CPT stick ==========================================================

patch(ax1, 'XData', c04w.cpt_stickx, 'YData', c04w.cpt_sticky, 'FaceColor', 'w');
patch(ax1, 'XData', c02xw.cpt_stickx, 'YData', c02xw.cpt_sticky, 'FaceColor', 'w');
patch(ax1, 'XData', c03xw.cpt_stickx, 'YData', c03xw.cpt_sticky, 'FaceColor', 'w');

% Plot Water in CPT ==============================================================

plot(ax1, [c04w.cpt_stickx(1), c04w.cpt_stickx(end)], [c04w.cpt_water, c04w.cpt_water], 'LineWidth', 2, 'Color', 'b')
plot(ax1, [c02xw.cpt_stickx(1), c02xw.cpt_stickx(end)], [c02xw.cpt_water, c02xw.cpt_water], 'LineWidth', 2, 'Color', 'b')
plot(ax1, [c03xw.cpt_stickx(1), c03xw.cpt_stickx(end)], [c03xw.cpt_water, c03xw.cpt_water], 'LineWidth', 2, 'Color', 'b')

% Main x-axis: distance along the profile =================================

ax1.YLim = [-90 90];
ax1.XLim = [0 700];
ax1.FontName = 'Times New Roman';
ax1.FontSize = 14;
xlabel(ax1, 'Distance, [ft]', 'FontSize', 16);
ylabel(ax1, 'Elevation, [ft]', 'FontSize', 16);
title('Warren Avenue Profile 1', 'FontName', 'Times New Roman', 'FontSize', 16);
grid(ax1, 'minor'); box(ax1, 'on');
 
% CPT ID Texts ============================================================

txt = sprintf('C-04W (192.95 ft N)');
text(250, 40, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring
txt = sprintf('C-02XW');
text(465, 45, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring
txt = sprintf('C-03XW (104.25 ft N)');
text(575, 72, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring

% Plot Boring stick ==========================================================

patch(ax1, 'XData', b02xw.bor_stickx, 'YData', b02xw.bor_sticky, 'FaceColor', 'w');
patch(ax1, 'XData', b03xw.bor_stickx, 'YData', b03xw.bor_sticky, 'FaceColor', 'w');

% B-02XW Soil Class ==========================================================

l1 = patch(ax1, 'XData', b02xw.layer.x1, 'YData', b02xw.layer.y1, 'FaceColor', col.fill);
hatchfill2(l1, 'fill');
pg1 = polyshape(b02xw.layer.x1, b02xw.layer.y1); [cx1, cy1] = centroid(pg1);
text(ax1, 490, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10, 'Color', 'k');

l2 = patch(ax1, 'XData', b02xw.layer.x2, 'YData', b02xw.layer.y2, 'FaceColor', col.clay);
hatchfill2(l2, 'fill');
pg1 = polyshape(b02xw.layer.x2, b02xw.layer.y2); [cx1, cy1] = centroid(pg1);
text(ax1, 490, cy1, '0.34-0.5', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10, 'Color', 'k');

l3 = patch(ax1, 'XData', b02xw.layer.x3, 'YData', b02xw.layer.y3, 'FaceColor', col.clay);
hatchfill2(l3, 'fill');
pg1 = polyshape(b02xw.layer.x3, b02xw.layer.y3); [cx1, cy1] = centroid(pg1);
text(ax1, 490, cy1, '0.2-0.34', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10, 'Color', 'k');

l4 = patch(ax1, 'XData', b02xw.layer.x4, 'YData', b02xw.layer.y4, 'FaceColor', col.clay);
hatchfill2(l4, 'fill');
pg1 = polyshape(b02xw.layer.x4, b02xw.layer.y4); [cx1, cy1] = centroid(pg1);
text(ax1, 490, cy1, '0.22-0.3', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10, 'Color', 'k');

l5 = patch(ax1, 'XData', b02xw.layer.x5, 'YData', b02xw.layer.y5, 'FaceColor', col.clay);
hatchfill2(l5, 'fill');
pg1 = polyshape(b02xw.layer.x5, b02xw.layer.y5); [cx1, cy1] = centroid(pg1);
text(ax1, 490, cy1, '0.16-0.22', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10, 'Color', 'k');

% B-03XW Soil Class ==========================================================

l1 = patch(ax1, 'XData', b03xw.layer.x1, 'YData', b03xw.layer.y1, 'FaceColor', col.sand);
hatchfill2(l1, 'single', 'LineWidth', 1, 'HatchAngle', 45, 'HatchDensity', 100);
pg1 = polyshape(b03xw.layer.x1, b03xw.layer.y1); [cx1, cy1] = centroid(pg1);
text(ax1, 575, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10, 'Color', 'k');

l2 = patch(ax1, 'XData', b03xw.layer.x2, 'YData', b03xw.layer.y2, 'FaceColor', col.clay);
hatchfill2(l2, 'fill');
pg1 = polyshape(b03xw.layer.x2, b03xw.layer.y2); [cx1, cy1] = centroid(pg1);
text(ax1, 575, cy1+5, '', 'Rotation', 0, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10, 'Color', 'k');

l3 = patch(ax1, 'XData', b03xw.layer.x3, 'YData', b03xw.layer.y3, 'FaceColor', col.sand);
hatchfill2(l3, 'single', 'LineWidth', 1, 'HatchAngle', 45, 'HatchDensity', 100);
pg1 = polyshape(b03xw.layer.x3, b03xw.layer.y3); [cx1, cy1] = centroid(pg1);
text(ax1, 575, cy1+2.5, '', 'Rotation', 0, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10, 'Color', 'k');

l4 = patch(ax1, 'XData', b03xw.layer.x4, 'YData', b03xw.layer.y4, 'FaceColor', col.clay);
hatchfill2(l4, 'fill');
pg1 = polyshape(b03xw.layer.x4, b03xw.layer.y4); [cx1, cy1] = centroid(pg1);
text(ax1, 575, cy1, '> 0.5', 'Rotation', 0, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10, 'Color', 'k');

l5 = patch(ax1, 'XData', b03xw.layer.x5, 'YData', b03xw.layer.y5, 'FaceColor', col.sand);
hatchfill2(l5, 'fill');
pg1 = polyshape(b03xw.layer.x5, b03xw.layer.y5); [cx1, cy1] = centroid(pg1);
text(ax1, 575, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10, 'Color', 'k');

l6 = patch(ax1, 'XData', b03xw.layer.x6, 'YData', b03xw.layer.y6, 'FaceColor', col.sand);
hatchfill2(l6,  'single', 'LineWidth', 1, 'HatchAngle', 45, 'HatchDensity', 100);
pg1 = polyshape(b03xw.layer.x6, b03xw.layer.y6); [cx1, cy1] = centroid(pg1);
text(ax1, 575, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10, 'Color', 'k');

l7 = patch(ax1, 'XData', b03xw.layer.x7, 'YData', b03xw.layer.y7, 'FaceColor', col.clay);
hatchfill2(l7, 'single', 'LineWidth', 1, 'HatchAngle', 90, 'HatchDensity', 500);
pg1 = polyshape(b03xw.layer.x7, b03xw.layer.y7); [cx1, cy1] = centroid(pg1);
text(ax1, 575, cy1, '0.2-0.38', 'Rotation', 0, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10, 'Color', 'k');

l8 = patch(ax1, 'XData', b03xw.layer.x8, 'YData', b03xw.layer.y8, 'FaceColor', col.clay);
hatchfill2(l8, 'fill');
pg1 = polyshape(b03xw.layer.x8, b03xw.layer.y8); [cx1, cy1] = centroid(pg1);
text(ax1, 575, cy1, '0.16', 'Rotation', 0, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10, 'Color', 'k');

% Plot Water in boring ==============================================================

plot(ax1, [b02xw.bor_stickx(1), b02xw.bor_stickx(end)], [b02xw.bor_water, b02xw.bor_water], 'LineWidth', 2, 'Color', 'b')
plot(ax1, [b03xw.bor_stickx(1), b03xw.bor_stickx(end)], [b03xw.bor_water, b03xw.bor_water], 'LineWidth', 2, 'Color', 'b')

% Plot shelby tube samples ================================================

% B02XW
x = [b02xw.bor_stickx(1), b02xw.bor_stickx(end)];
plot(ax1, x, [b02xw.samples(1), b02xw.samples(1)], 'LineWidth', 2, 'Color', 'g')
plot(ax1, x, [b02xw.samples(2), b02xw.samples(2)], 'LineWidth', 2, 'Color', 'g')
plot(ax1, x, [b02xw.samples(3), b02xw.samples(3)], 'LineWidth', 2, 'Color', 'g')

% B03XW
x = [b03xw.bor_stickx(1), b03xw.bor_stickx(end)];
plot(ax1, x, [b03xw.samples(1), b03xw.samples(1)], 'LineWidth', 2, 'Color', 'g')
plot(ax1, x, [b03xw.samples(2), b03xw.samples(2)], 'LineWidth', 2, 'Color', 'r')
plot(ax1, x, [b03xw.samples(3), b03xw.samples(3)], 'LineWidth', 2, 'Color', 'g')
plot(ax1, x, [b03xw.samples(4), b03xw.samples(4)], 'LineWidth', 2, 'Color', 'g')

% Boring ID Texts ============================================================

txt = sprintf('B-02XW');
text(473, 50, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring
txt = sprintf('B-03XW (105.96 ft N)');
text(560, 79, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring

% Plot post slide surface =================================================
%line(ax1, 'XData', postsurf.x, 'YData', postsurf.y, 'LineWidth', 2, 'Color', [0 0 0 1])
line(ax1, 'XData', postsurf2.x, 'YData', postsurf2.y, 'LineWidth', 2, 'Color', [0 0 0 1])

% Plot slide surface =================================================
line(ax1, 'XData', slipsurf.x, 'YData', slipsurf.y, 'LineWidth', 1, 'Color', [1 0 0 1])

% Plot resistivity zones ==================================================

line(ax1, 'XData', reszones.dropx, 'YData', reszones.dropy, 'LineWidth', 1, 'Color', 'k', 'LineStyle', '--')
% line(ax1, 'XData', reszones.smoothdecx, 'YData', reszones.smoothdecy, 'LineWidth', 1, 'Color', 'k', 'LineStyle', '--')
% line(ax1, 'XData', reszones.notsmoothdecx, 'YData', reszones.notsmoothdecy, 'LineWidth', 1, 'Color', 'k', 'LineStyle', '--')
% line(ax1, 'XData', reszones.variablelowqcx, 'YData', reszones.variablelowqcy, 'LineWidth', 1, 'Color', 'k', 'LineStyle', '--')
% hold on
% 
% Plot water table? =======================================================

line(ax1, 'XData', waterzones.x, 'YData', waterzones.y, 'LineWidth', 2, 'Color', 'b', 'LineStyle', ':')

% Plot legend =============================================================
legend(ax1, 'Previous Surface', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ...
    '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ...
    '', '', '', '', '', '', '', '', 'Current Surface', 'Slip Surface', '', 'Water', 'Location', 'southwest')

% C-04W plot: su ==========================================================

ax2 = nexttile(t, 10); % next tiles in second row
plot(c04w.cpt_su, c04w.cpt_elv, 'k')
yline(c04w.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
yline(10, 'LineWidth', 1.5, 'LineStyle', '-.', 'Color', 'k')
yline(1, 'LineWidth', 1.5, 'Color', 'r', 'LineStyle','--')
ax2.YLim = [-90 90];
ax2.XLim = [0 1000];
ax2.FontName = 'Times New Roman';
ax2.FontSize = 14;
xlabel(ax2, 's_u, [psf]', 'FontSize', 16);
ylabel(ax2, 'Elevation, [ft]', 'FontSize', 16);
title(ax2, 'C-04W')
grid(ax2, 'minor'); box(ax2, 'on');

% C-02XW plot: su =========================================================

ax3 = nexttile(t, 11); % next tiles in second row
plot(c02xw.cpt_su, c02xw.cpt_elv, 'k')
hold on
yline(c02xw.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
scatter(b02xw.mdotsu.peakx, b02xw.mdotsu.peaky, 15, 'filled', 'Marker', 'o', 'MarkerEdgeColor','m', 'MarkerFaceColor','m')
scatter(b02xw.mdotsu.remoldedx, b02xw.mdotsu.remoldedy, 15, 'Marker', 'o', 'MarkerEdgeColor', 'm', 'LineWidth', 1, 'MarkerFaceColor', 'w')
yline(16, 'LineWidth', 1.5, 'LineStyle', '-.', 'Color', 'k')
yline(8, 'LineWidth', 1.5, 'Color', 'r', 'LineStyle','--')
ax3.YLim = [-90 90];
ax3.XLim = [0 1000];
ax3.FontName = 'Times New Roman';
ax3.FontSize = 14;
xlabel(ax3, 's_u, [psf]', 'FontSize', 16);
ylabel(ax3, 'Elevation, [ft]', 'FontSize', 16);
title(ax3, 'C-02XW')
grid(ax3, 'minor'); box(ax3, 'on');

% C-03XW plot: su =========================================================

ax4 = nexttile(t, 12); % next tiles in second row
plot(c03xw.cpt_su, c03xw.cpt_elv, 'k')
hold on
yline(c03xw.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
scatter(b03xw.mdotsu.peakx, b03xw.mdotsu.peaky, 15, 'filled', 'Marker', 'o', 'MarkerEdgeColor','m', 'MarkerFaceColor','m')
scatter(b03xw.mdotsu.remoldedx, b03xw.mdotsu.remoldedy, 15, 'Marker', 'o', 'MarkerEdgeColor', 'm', 'LineWidth', 1, 'MarkerFaceColor', 'w')
yline(40, 'LineWidth', 1.5, 'LineStyle', '-.', 'Color', 'k')
yline(32, 'LineWidth', 1.5, 'Color', 'r', 'LineStyle','--')
ax4.YLim = [-90 90];
ax4.XLim = [0 1000];
ax4.FontName = 'Times New Roman';
ax4.FontSize = 14;
xlabel(ax4, 's_u, [psf]', 'FontSize', 16);
ylabel(ax4, 'Elevation, [ft]', 'FontSize', 16);
title(ax4, 'C-03XW')
grid(ax4, 'minor'); box(ax4, 'on');

% C-04W plot: res =========================================================

ax5 = nexttile(t, 13); % next tiles in second row
plot(c04w.cpt_res, c04w.cpt_elv, 'k')
yline(c04w.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
yline(10, 'LineWidth', 1.5, 'LineStyle', '-.', 'Color', 'k')
yline(1, 'LineWidth', 1.5, 'Color', 'r', 'LineStyle','--')
ax5.YLim = [-90 90];
ax5.XLim = [0 100];
ax5.FontName = 'Times New Roman';
ax5.FontSize = 14;
xlabel(ax5, 'Res, [ohm-m]', 'FontSize', 16);
ylabel(ax5, 'Elevation, [ft]', 'FontSize', 16);
title(ax5, 'C-04W')
grid(ax5, 'minor'); box(ax5, 'on');

% C-02XW plot: res =========================================================

ax6 = nexttile(t, 14); % next tiles in second row
plot(c02xw.cpt_res, c02xw.cpt_elv, 'k')
yline(c02xw.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
yline(16, 'LineWidth', 1.5, 'LineStyle', '-.', 'Color', 'k')
yline(8, 'LineWidth', 1.5, 'Color', 'r', 'LineStyle','--')
ax6.YLim = [-90 90];
ax6.XLim = [0 100];
ax6.FontName = 'Times New Roman';
ax6.FontSize = 14;
xlabel(ax6, 'Res, [ohm-m]', 'FontSize', 16);
ylabel(ax6, 'Elevation, [ft]', 'FontSize', 16);
title(ax6, 'C-02XW')
grid(ax6, 'minor'); box(ax6, 'on');

% C-03XW plot: res =========================================================

ax7 = nexttile(t, 15); % next tiles in second row
plot(c03xw.cpt_res, c03xw.cpt_elv, 'k')
yline(c03xw.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
yline(40, 'LineWidth', 1.5, 'LineStyle', '-.', 'Color', 'k')
yline(32, 'LineWidth', 1.5, 'Color', 'r', 'LineStyle','--')
ax7.YLim = [-90 90];
ax7.XLim = [0 100];
ax7.FontName = 'Times New Roman';
ax7.FontSize = 14;
xlabel(ax7, 'Res, [ohm-m]', 'FontSize', 16);
ylabel(ax7, 'Elevation, [ft]', 'FontSize', 16);
title(ax7, 'C-03XW')
grid(ax7, 'minor'); box(ax7, 'on');