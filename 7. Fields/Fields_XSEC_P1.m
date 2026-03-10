% DRAWS CROSS SECTIONS BASED ON ELEVATION. X SPACING IS USER DEFINED IN
% ARCGIS. MUST RUN Puritan_XSEC_DataProcess.m FIRST

%% INPUT PROCESSED DATA 
clear all; close all; clc;

load("FieldsAllData.mat")


%% RESISTIVITY AND WATER ZONES

% reszones.dropx = [c04w.surf_dist(29), (c02xw.surf_dist(48) + c02xw.surf_dist(49))/2, ...
%                   c03xw.surf_dist(60)+2.5];
% reszones.dropy = [10, 16, 40];

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

waterzones.x = [180, 280, (c01xwf.surf_dist(36)+c01xwf.surf_dist(37))/2, c01xff.surf_dist(57)];
waterzones.y = [39.6982, 39.7764, c01xwf.cpt_water, c01xff.cpt_water];

% postsurf.x = [360, 473, 473, 588, 592, 598];
% postsurf.y = [30.79, 38.7958, 38.7958, 65.7509, 65.7509, 84.67];

% slipsurf.x = []
%% GENERATE FIGURE: CROSS SECTION AND SU

close all
fig1 = figure('Color','w', 'Position', [1921,49,1920,955]);
t = tiledlayout(fig1, 2, 8, 'TileSpacing', 'compact', 'Padding', 'compact');
ax1 = nexttile(t, [1 8]); % spans 1 row and 8 columns

% Plot surface ============================================================

plot(ax1, c01xwf.surf_dist, c01xwf.surf_elv, 'LineWidth', 2, 'Color', [0 0 0 1])
hold(ax1, 'on')

% Plot CPT stick ==========================================================

patch(ax1, 'XData', c01xwf.cpt_stickx, 'YData', c01xwf.cpt_sticky, 'FaceColor', 'w');
patch(ax1, 'XData', c01xff.cpt_stickx, 'YData', c01xff.cpt_sticky, 'FaceColor', 'w');

% Plot Water in CPT ==============================================================

plot(ax1, [c01xwf.cpt_stickx(1), c01xwf.cpt_stickx(end)], [c01xwf.cpt_water, c01xwf.cpt_water], 'LineWidth', 2, 'Color', 'b')
plot(ax1, [c01xff.cpt_stickx(1), c01xff.cpt_stickx(end)], [c01xff.cpt_water, c01xff.cpt_water], 'LineWidth', 2, 'Color', 'b')

% Main x-axis: distance along the profile =================================

ax1.YLim = [-10, 70];
ax1.XLim = [0 600];
ax1.FontName = 'Times New Roman';
ax1.FontSize = 14;
xlabel(ax1, 'Distance, [ft]', 'FontSize', 16);
ylabel(ax1, 'Elevation, [ft]', 'FontSize', 16);
title('Warren and Fraiser Field Profile 1', 'FontName', 'Times New Roman', 'FontSize', 16);
grid(ax1, 'minor'); box(ax1, 'on');
 
% CPT ID Texts ============================================================

txt = sprintf('C-01XWF (3.98 ft S)');
text(340, 52, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring
txt = sprintf('C-01XFF (261.93 ft N)');
text(550, 52, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring

% Plot Boring stick ==========================================================

patch(ax1, 'XData', b01xwf.bor_stickx, 'YData', b01xwf.bor_sticky, 'FaceColor', 'w');
patch(ax1, 'XData', b01xff.bor_stickx, 'YData', b01xff.bor_sticky, 'FaceColor', 'w');

% B-01XWF Soil Class ==========================================================

l1 = patch(ax1, 'XData', b01xwf.layer.x1, 'YData', b01xwf.layer.y1, 'FaceColor', col.topsoil);
hatchfill2(l1, 'fill');
pg1 = polyshape(b01xwf.layer.x1, b01xwf.layer.y1); [cx1, cy1] = centroid(pg1);
text(ax1, 373, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10, 'Color', 'k');

l2 = patch(ax1, 'XData', b01xwf.layer.x2, 'YData', b01xwf.layer.y2, 'FaceColor', col.fill);
hatchfill2(l2, 'fill');
pg1 = polyshape(b01xwf.layer.x2, b01xwf.layer.y2); [cx1, cy1] = centroid(pg1);
text(ax1, 373, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10, 'Color', 'k');

l3 = patch(ax1, 'XData', b01xwf.layer.x3, 'YData', b01xwf.layer.y3, 'FaceColor', col.clay);
hatchfill2(l3, 'fill');
pg1 = polyshape(b01xwf.layer.x3, b01xwf.layer.y3); [cx1, cy1] = centroid(pg1);
text(ax1, 373, cy1, '> 0.5', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10, 'Color', 'k');

l4 = patch(ax1, 'XData', b01xwf.layer.x4, 'YData', b01xwf.layer.y4, 'FaceColor', col.sand);
hatchfill2(l4, 'fill');
pg1 = polyshape(b01xwf.layer.x4, b01xwf.layer.y4); [cx1, cy1] = centroid(pg1);
text(ax1, 373, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10, 'Color', 'k');

l5 = patch(ax1, 'XData', b01xwf.layer.x5, 'YData', b01xwf.layer.y5, 'FaceColor', col.clay);
hatchfill2(l5, 'fill');
pg1 = polyshape(b01xwf.layer.x5, b01xwf.layer.y5); [cx1, cy1] = centroid(pg1);
text(ax1, 373, cy1, '0.28-0.36', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10, 'Color', 'k');

l6 = patch(ax1, 'XData', b01xwf.layer.x6, 'YData', b01xwf.layer.y6, 'FaceColor', col.clay);
hatchfill2(l6, 'fill');
pg1 = polyshape(b01xwf.layer.x6, b01xwf.layer.y6); [cx1, cy1] = centroid(pg1);
text(ax1, 373, cy1, '0.28-0.34', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10, 'Color', 'k');

l7 = patch(ax1, 'XData', b01xwf.layer.x7, 'YData', b01xwf.layer.y7, 'FaceColor', col.sand);
hatchfill2(l7, 'fill');
pg1 = polyshape(b01xwf.layer.x7, b01xwf.layer.y7); [cx1, cy1] = centroid(pg1);
text(ax1, 373, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10, 'Color', 'k');

% B-01XFF Soil Class ==========================================================

l1 = patch(ax1, 'XData', b01xff.layer.x1, 'YData', b01xff.layer.y1, 'FaceColor', col.topsoil);
hatchfill2(l1, 'fill');
pg1 = polyshape(b01xff.layer.x1, b01xff.layer.y1); [cx1, cy1] = centroid(pg1);
text(ax1, 543, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10, 'Color', 'k');

l2 = patch(ax1, 'XData', b01xff.layer.x2, 'YData', b01xff.layer.y2, 'FaceColor', col.sand);
hatchfill2(l2, 'fill');
pg1 = polyshape(b01xff.layer.x2, b01xff.layer.y2); [cx1, cy1] = centroid(pg1);
text(ax1, 543, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10, 'Color', 'k');

l3 = patch(ax1, 'XData', b01xff.layer.x3, 'YData', b01xff.layer.y3, 'FaceColor', col.clay);
hatchfill2(l3, 'fill');
pg1 = polyshape(b01xff.layer.x3, b01xff.layer.y3); [cx1, cy1] = centroid(pg1);
text(ax1, 543, cy1, '> 0.5', 'Rotation', 0, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10, 'Color', 'k');

l4 = patch(ax1, 'XData', b01xff.layer.x4, 'YData', b01xff.layer.y4, 'FaceColor', col.sand);
hatchfill2(l4, 'fill');
pg1 = polyshape(b01xff.layer.x4, b01xff.layer.y4); [cx1, cy1] = centroid(pg1);
text(ax1, 543, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10, 'Color', 'k');

l5 = patch(ax1, 'XData', b01xff.layer.x5, 'YData', b01xff.layer.y5, 'FaceColor', col.clay);
hatchfill2(l5, 'single', 'LineWidth', 1, 'HatchAngle', 90, 'HatchDensity', 500);
pg1 = polyshape(b01xff.layer.x5, b01xff.layer.y5); [cx1, cy1] = centroid(pg1);
text(ax1, 543, cy1, '0.3-0.5', 'Rotation', 0, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10, 'Color', 'k');

l6 = patch(ax1, 'XData', b01xff.layer.x6, 'YData', b01xff.layer.y6, 'FaceColor', col.clay);
hatchfill2(l6, 'fill');
pg1 = polyshape(b01xff.layer.x6, b01xff.layer.y6); [cx1, cy1] = centroid(pg1);
text(ax1, 543, cy1, '0.2-0.5', 'Rotation', 0, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10, 'Color', 'k');

l7 = patch(ax1, 'XData', b01xff.layer.x7, 'YData', b01xff.layer.y7, 'FaceColor', col.clay);
hatchfill2(l7,  'single', 'LineWidth', 1, 'HatchAngle', 90, 'HatchDensity', 500);
pg1 = polyshape(b01xff.layer.x7, b01xff.layer.y7); [cx1, cy1] = centroid(pg1);
text(ax1, 543, cy1, '> 0.5', 'Rotation', 0, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10, 'Color', 'k');

% Plot Water in boring ==============================================================

% plot(ax1, [b01xwf.bor_stickx(1), b01xwf.bor_stickx(end)], [b01xwf.bor_water, b01xwf.bor_water], 'LineWidth', 2, 'Color', 'b')
% plot(ax1, [b01xff.bor_stickx(1), b01xff.bor_stickx(end)], [b01xff.bor_water, b01xff.bor_water], 'LineWidth', 2, 'Color', 'b')

% Plot shelby tube samples ================================================

% B01XWF
x = [b01xwf.bor_stickx(1), b01xwf.bor_stickx(end)];
plot(ax1, x, [b01xwf.samples(1), b01xwf.samples(1)], 'LineWidth', 2, 'Color', 'g')
plot(ax1, x, [b01xwf.samples(2), b01xwf.samples(2)], 'LineWidth', 2, 'Color', 'g')

% B01XFF
x = [b01xff.bor_stickx(1), b01xff.bor_stickx(end)];
plot(ax1, x, [b01xff.samples(1), b01xff.samples(1)], 'LineWidth', 2, 'Color', 'g')
plot(ax1, x, [b01xff.samples(2), b01xff.samples(2)], 'LineWidth', 2, 'Color', 'g')

% Boring ID Texts ============================================================

txt = sprintf('B-01XWF');
text(360, 55, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring
txt = sprintf('B-01XFF (253.22 ft N)');
text(530, 55, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring

% % Plot post slide surface =================================================
% line(ax1, 'XData', postsurf.x, 'YData', postsurf.y, 'LineWidth', 2, 'Color', [0 0 0 1])

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
legend(ax1, 'Current Surface', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ...
    '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '','', '', '', '', '', ...
    '', 'Water', 'Location', 'southwest')

% C-01XWF plot: su ==========================================================

ax2 = nexttile(t, 11); % next tiles in second row
plot(c01xwf.cpt_su, c01xwf.cpt_elv, 'k')
hold on
yline(c01xwf.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
scatter(b01xwf.mdotsu.peakx, b01xwf.mdotsu.peaky, 15, 'filled', 'Marker', 'o', 'MarkerEdgeColor','m', 'MarkerFaceColor','m')
scatter(b01xwf.mdotsu.remoldedx, b01xwf.mdotsu.remoldedy, 15, 'Marker', 'o', 'MarkerEdgeColor', 'm', 'LineWidth', 1, 'MarkerFaceColor', 'w')
ax2.YLim = [0, 60];
ax2.XLim = [0 1000];
ax2.FontName = 'Times New Roman';
ax2.FontSize = 14;
xlabel(ax2, 's_u, [psf]', 'FontSize', 16);
ylabel(ax2, 'Elevation, [ft]', 'FontSize', 16);
title(ax2, 'C-01XWF')
grid(ax2, 'minor'); box(ax2, 'on');

% C-01XFF plot: su =========================================================

ax3 = nexttile(t, 12); % next tiles in second row
plot(c01xff.cpt_su, c01xff.cpt_elv, 'k')
hold on
yline(c01xff.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
scatter(b01xff.mdotsu.peakx, b01xff.mdotsu.peaky, 15, 'filled', 'Marker', 'o', 'MarkerEdgeColor','m', 'MarkerFaceColor','m')
scatter(b01xff.mdotsu.remoldedx, b01xff.mdotsu.remoldedy, 15, 'Marker', 'o', 'MarkerEdgeColor', 'm', 'LineWidth', 1, 'MarkerFaceColor', 'w')
ax3.YLim = [0, 60];
ax3.XLim = [0 1000];
ax3.FontName = 'Times New Roman';
ax3.FontSize = 14;
xlabel(ax3, 's_u, [psf]', 'FontSize', 16);
ylabel(ax3, 'Elevation, [ft]', 'FontSize', 16);
title(ax3, 'C-01XFF')
grid(ax3, 'minor'); box(ax3, 'on');

% C-01XWF plot: res =========================================================

ax5 = nexttile(t, 13); % next tiles in second row
plot(c01xwf.cpt_res, c01xwf.cpt_elv, 'k')
yline(c01xwf.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
ax5.YLim = [0, 60];
ax5.XLim = [0 100];
ax5.FontName = 'Times New Roman';
ax5.FontSize = 14;
xlabel(ax5, 'Res, [ohm-m]', 'FontSize', 16);
ylabel(ax5, 'Elevation, [ft]', 'FontSize', 16);
title(ax5, 'C-01XWF')
grid(ax5, 'minor'); box(ax5, 'on');

% C-01XFF plot: res =========================================================

ax6 = nexttile(t, 14); % next tiles in second row
plot(c01xff.cpt_res, c01xff.cpt_elv, 'k')
yline(c01xff.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
ax6.YLim = [0, 60];
ax6.XLim = [0 100];
ax6.FontName = 'Times New Roman';
ax6.FontSize = 14;
xlabel(ax6, 'Res, [ohm-m]', 'FontSize', 16);
ylabel(ax6, 'Elevation, [ft]', 'FontSize', 16);
title(ax6, 'C-01XFF')
grid(ax6, 'minor'); box(ax6, 'on');
