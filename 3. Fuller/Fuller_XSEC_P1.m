% DRAWS CROSS SECTIONS BASED ON ELEVATION. X SPACING IS USER DEFINED IN
% ARCGIS. MUST RUN Puritan_XSEC_DataProcess.m FIRST

%% INPUT PROCESSED DATA 
clear all; close all; clc;

load("FullerAllDataP1.mat")


%% RESISTIVITY AND WATER ZONES

reszones.dropx = [c01f.surf_dist(24), c02f.surf_dist(68), c03xf.surf_dist(145), c04xf.surf_dist(225)];
reszones.dropy = [-43, -32, -12, -12];

reszones.smoothdecx = [c01f.surf_dist(24), c02f.surf_dist(68), c03xf.surf_dist(145), c04xf.surf_dist(225)];
reszones.smoothdecy = [-29, -20, -6, -12];

reszones.notsmoothdecx = [c01f.surf_dist(24), c02f.surf_dist(68), c03xf.surf_dist(145), c04xf.surf_dist(225)];
reszones.notsmoothdecy = [40, 35, 15, 0];

reszones.variablelowqcx = [c01f.surf_dist(24), c02f.surf_dist(68), c03xf.surf_dist(145), c04xf.surf_dist(225)];
reszones.variablelowqcy = [48, 40, 25, 15];

waterzones.x = [c01f.surf_dist(24), c02f.surf_dist(68), c03xf.surf_dist(145), ...
                c04xf.surf_dist(225), 2290, 2400];

waterzones.y = [c01f.cpt_water, c02f.cpt_water, c03xf.cpt_water, ...
               c04xf.cpt_water, 15.748, 15.748];

slipsurf.x = [360, 400, 500, 1420, 2260];
slipsurf.y = [68, 59, 37, 18.63, -3.5];

presurf.x = [360, 2240, 2290];
presurf.y = [68.9, 68, 15.75];


%% GENERATE FIGURE: CROSS SECTION AND SU

close all
fig1 = figure('Color','w', 'Position', [1921,49,1920,955]);
t = tiledlayout(fig1, 2, 8, 'TileSpacing', 'compact', 'Padding', 'compact');
ax1 = nexttile(t, [1 8]); % spans 1 row and 8 columns

% Plot surface ============================================================

plot(ax1, c01f.surf_dist, c01f.surf_elv, 'LineWidth', 2, 'Color', [0 0 0 1])
hold(ax1, 'on')

% Plot CPT stick ==========================================================

patch(ax1, 'XData', c01f.cpt_stickx, 'YData', c01f.cpt_sticky, 'FaceColor', 'w');
patch(ax1, 'XData', c02f.cpt_stickx, 'YData', c02f.cpt_sticky, 'FaceColor', 'w');
patch(ax1, 'XData', c03xf.cpt_stickx, 'YData', c03xf.cpt_sticky, 'FaceColor', 'w');
patch(ax1, 'XData', c04xf.cpt_stickx, 'YData', c04xf.cpt_sticky, 'FaceColor', 'w');

% Plot Water in CPT ==============================================================

plot(ax1, [c01f.cpt_stickx(1), c01f.cpt_stickx(end)], [c01f.cpt_water, c01f.cpt_water], 'LineWidth', 2, 'Color', 'b')
plot(ax1, [c02f.cpt_stickx(1), c02f.cpt_stickx(end)], [c02f.cpt_water, c02f.cpt_water], 'LineWidth', 2, 'Color', 'b')
plot(ax1, [c03xf.cpt_stickx(1), c03xf.cpt_stickx(end)], [c03xf.cpt_water, c03xf.cpt_water], 'LineWidth', 2, 'Color', 'b')
plot(ax1, [c04xf.cpt_stickx(1), c04xf.cpt_stickx(end)], [c04xf.cpt_water, c04xf.cpt_water], 'LineWidth', 2, 'Color', 'b')

% Main x-axis: distance along the profile =================================

ax1.YLim = [-90 90];
ax1.XLim = [0 2600];
ax1.FontName = 'Times New Roman';
ax1.FontSize = 14;
xlabel(ax1, 'Distance, [ft]', 'FontSize', 16);
ylabel(ax1, 'Elevation, [ft]', 'FontSize', 16);
title('Fuller Profile 1', 'FontName', 'Times New Roman', 'FontSize', 16);
grid(ax1, 'minor'); box(ax1, 'on');
 
% CPT ID Texts ============================================================

txt = sprintf('C-01F (5.33 ft S)');
text(175, 80, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring
txt = sprintf('C-02F (37.59 ft N)');
text(600, 60, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring
txt = sprintf('C-03XF');
text(1430, 55, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring
txt = sprintf('C-04XF (159.51 ft S)');
text(2200, 45, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring

% Plot Boring stick ==========================================================

patch(ax1, 'XData', b03xf.bor_stickx, 'YData', b03xf.bor_sticky, 'FaceColor', 'w');
patch(ax1, 'XData', b04xf.bor_stickx, 'YData', b04xf.bor_sticky, 'FaceColor', 'w');

% B-03XF Soil Class ==========================================================

l1 = patch(ax1, 'XData', b03xf.layer.x1, 'YData', b03xf.layer.y1, 'FaceColor', col.sand);
hatchfill2(l1, 'fill');
pg1 = polyshape(b03xf.layer.x1, b03xf.layer.y1); [cx1, cy1] = centroid(pg1);
text(ax1, cx1-25, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l2 = patch(ax1, 'XData', b03xf.layer.x2, 'YData', b03xf.layer.y2, 'FaceColor', col.clay);
hatchfill2(l2, 'fill');
pg1 = polyshape(b03xf.layer.x2, b03xf.layer.y2); [cx1, cy1] = centroid(pg1);
text(ax1, cx1-25, cy1, '0.4', 'Rotation', 0, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l3 = patch(ax1, 'XData', b03xf.layer.x3, 'YData', b03xf.layer.y3, 'FaceColor', col.sand);
hatchfill2(l3, 'fill');
pg1 = polyshape(b03xf.layer.x3, b03xf.layer.y3); [cx1, cy1] = centroid(pg1);
text(ax1, cx1-25, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l4 = patch(ax1, 'XData', b03xf.layer.x4, 'YData', b03xf.layer.y4, 'FaceColor', col.clay);
hatchfill2(l4, 'fill');
pg1 = polyshape(b03xf.layer.x4, b03xf.layer.y4); [cx1, cy1] = centroid(pg1);
text(ax1, cx1-25, cy1, '> 0.5', 'Rotation', 0, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l5 = patch(ax1, 'XData', b03xf.layer.x5, 'YData', b03xf.layer.y5, 'FaceColor', col.sand);
hatchfill2(l5, 'fill');
pg1 = polyshape(b03xf.layer.x5, b03xf.layer.y5); [cx1, cy1] = centroid(pg1);
text(ax1, cx1-25, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l6 = patch(ax1, 'XData', b03xf.layer.x6, 'YData', b03xf.layer.y6, 'FaceColor', col.sand);
hatchfill2(l6, 'single', 'LineWidth', 1, 'HatchAngle', 45, 'HatchDensity', 100);
pg1 = polyshape(b03xf.layer.x6, b03xf.layer.y6); [cx1, cy1] = centroid(pg1);
text(ax1, cx1-25, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l7 = patch(ax1, 'XData', b03xf.layer.x7, 'YData', b03xf.layer.y7, 'FaceColor', col.clay);
hatchfill2(l7, 'single', 'LineWidth', 1, 'HatchAngle', 90, 'HatchDensity', 500);
pg1 = polyshape(b03xf.layer.x7, b03xf.layer.y7); [cx1, cy1] = centroid(pg1);
text(ax1, cx1-25, cy1, '0.32', 'Rotation', 0, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l8 = patch(ax1, 'XData', b03xf.layer.x8, 'YData', b03xf.layer.y8, 'FaceColor', col.clay);
hatchfill2(l8, 'fill');
pg1 = polyshape(b03xf.layer.x8, b03xf.layer.y8); [cx1, cy1] = centroid(pg1);
text(ax1, cx1-25, cy1, '0.26', 'Rotation', 0, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l9 = patch(ax1, 'XData', b03xf.layer.x9, 'YData', b03xf.layer.y9, 'FaceColor', col.clay);
hatchfill2(l9, 'fill');
pg1 = polyshape(b03xf.layer.x9, b03xf.layer.y9); [cx1, cy1] = centroid(pg1);
text(ax1, cx1-25, cy1, '0.2', 'Rotation', 0, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

% B-04XF Soil Class ==========================================================

l1 = patch(ax1, 'XData', b04xf.layer.x1, 'YData', b04xf.layer.y1, 'FaceColor', col.topsoil);
hatchfill2(l1, 'cross', 'LineWidth', 1, 'HatchAngle', 45, 'HatchDensity', 100);
pg1 = polyshape(b04xf.layer.x1, b04xf.layer.y1); [cx1, cy1] = centroid(pg1);
text(ax1, cx1+25, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l2 = patch(ax1, 'XData', b04xf.layer.x2, 'YData', b04xf.layer.y2, 'FaceColor', col.sand);
hatchfill2(l2, 'fill');
pg1 = polyshape(b04xf.layer.x2, b04xf.layer.y2); [cx1, cy1] = centroid(pg1);
text(ax1, cx1+25, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l3 = patch(ax1, 'XData', b04xf.layer.x3, 'YData', b04xf.layer.y3, 'FaceColor', col.sand);
hatchfill2(l3, 'single', 'LineWidth', 1, 'HatchAngle', 45, 'HatchDensity', 100);
pg1 = polyshape(b04xf.layer.x3, b04xf.layer.y3); [cx1, cy1] = centroid(pg1);
text(ax1, cx1+25, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l4 = patch(ax1, 'XData', b04xf.layer.x4, 'YData', b04xf.layer.y4, 'FaceColor', col.clay);
hatchfill2(l4, 'single', 'LineWidth', 1, 'HatchAngle', 90, 'HatchDensity', 500);
pg1 = polyshape(b04xf.layer.x4, b04xf.layer.y4); [cx1, cy1] = centroid(pg1);
text(ax1, cx1+25, cy1, '0.24-0.36', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l5 = patch(ax1, 'XData', b04xf.layer.x5, 'YData', b04xf.layer.y5, 'FaceColor', col.clay);
hatchfill2(l5, 'single', 'LineWidth', 1, 'HatchAngle', 90, 'HatchDensity', 500);
pg1 = polyshape(b04xf.layer.x5, b04xf.layer.y5); [cx1, cy1] = centroid(pg1);
text(ax1, cx1+25, cy1, '0.12-0.18', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l6 = patch(ax1, 'XData', b04xf.layer.x6, 'YData', b04xf.layer.y6, 'FaceColor', col.sand);
hatchfill2(l6, 'single', 'LineWidth', 1, 'HatchAngle', 45, 'HatchDensity', 100);
pg1 = polyshape(b04xf.layer.x6, b04xf.layer.y6); [cx1, cy1] = centroid(pg1);
text(ax1, cx1+25, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l7 = patch(ax1, 'XData', b04xf.layer.x7, 'YData', b04xf.layer.y7, 'FaceColor', col.clay);
hatchfill2(l7, 'fill');
pg1 = polyshape(b04xf.layer.x7, b04xf.layer.y7); [cx1, cy1] = centroid(pg1);
text(ax1, cx1+25, cy1, '0.18-0.22', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l8 = patch(ax1, 'XData', b04xf.layer.x8, 'YData', b04xf.layer.y8, 'FaceColor', col.clay);
hatchfill2(l8, 'fill');
pg1 = polyshape(b04xf.layer.x8, b04xf.layer.y8); [cx1, cy1] = centroid(pg1);
text(ax1, cx1+25, cy1, '0.2', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

% Plot Water in boring ==============================================================

plot(ax1, [b03xf.bor_stickx(1), b03xf.bor_stickx(end)], [b03xf.bor_water, b03xf.bor_water], 'LineWidth', 2, 'Color', 'b')
plot(ax1, [b04xf.bor_stickx(1), b04xf.bor_stickx(end)], [b04xf.bor_water, b04xf.bor_water], 'LineWidth', 2, 'Color', 'b')

% Plot shelby tube samples ================================================

% B03XF
x = [b03xf.bor_stickx(1), b03xf.bor_stickx(end)];
plot(ax1, x, [b03xf.samples(1), b03xf.samples(1)], 'LineWidth', 2, 'Color', 'g')
plot(ax1, x, [b03xf.samples(2), b03xf.samples(2)], 'LineWidth', 2, 'Color', 'g')
plot(ax1, x, [b03xf.samples(3), b03xf.samples(3)], 'LineWidth', 2, 'Color', 'g')
plot(ax1, x, [b03xf.samples(4), b03xf.samples(4)], 'LineWidth', 2, 'Color', 'g')

% B04XF
x = [b04xf.bor_stickx(1), b04xf.bor_stickx(end)];
plot(ax1, x, [b04xf.samples(1), b04xf.samples(1)], 'LineWidth', 2, 'Color', 'r')
plot(ax1, x, [b04xf.samples(2), b04xf.samples(2)], 'LineWidth', 2, 'Color', 'g')
plot(ax1, x, [b04xf.samples(3), b04xf.samples(3)], 'LineWidth', 2, 'Color', 'g')
plot(ax1, x, [b04xf.samples(4), b04xf.samples(4)], 'LineWidth', 2, 'Color', 'g')
% plot(ax1, x, [b04xf.samples(5), b04xf.samples(5)], 'LineWidth', 2,
% 'Color', 'g') not on the boring logs???

% Boring ID Texts ============================================================

txt = sprintf('B-04XF (163.63 ft S)');
text(2250, 37, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring
txt = sprintf('B-03XF');
text(1400, 64, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring

% Plot resistivity zones ==================================================

line(ax1, 'XData', reszones.dropx, 'YData', reszones.dropy, 'LineWidth', 1, 'Color', 'k', 'LineStyle', '--')
line(ax1, 'XData', reszones.smoothdecx, 'YData', reszones.smoothdecy, 'LineWidth', 1, 'Color', 'k', 'LineStyle', '--')
line(ax1, 'XData', reszones.notsmoothdecx, 'YData', reszones.notsmoothdecy, 'LineWidth', 1, 'Color', 'k', 'LineStyle', '--')
line(ax1, 'XData', reszones.variablelowqcx, 'YData', reszones.variablelowqcy, 'LineWidth', 1, 'Color', 'k', 'LineStyle', '--')
hold on

% Plot slip surface and previous surface  =================================

line(ax1, 'XData', slipsurf.x, 'YData', slipsurf.y, 'LineWidth', 1, 'Color', 'r')
line(ax1, 'XData', presurf.x, 'YData', presurf.y, 'LineWidth', 1, 'Color', [0, 0, 0, 0.4])

% Plot water table? =======================================================

line(ax1, 'XData', waterzones.x, 'YData', waterzones.y, 'LineWidth', 2, 'Color', 'b', 'LineStyle', ':')

% Plot legend =============================================================
legend(ax1, 'Current Surface', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ...
    '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '' , '', '', '', '', '', '', '', '', ...
    '', '', '', '', '', '', 'Slip Surface', 'Previous Surface', 'Water', 'Location', 'southeast')

% C-01F plot: su ==========================================================

ax2 = nexttile(t, 9); % next tiles in second row
plot(c01f.cpt_su, c01f.cpt_elv, 'k')
yline(c01f.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
yline([47, 40, -29, -43], 'LineWidth', 1.5, 'Color', 'k', 'LineStyle','-.')
ax2.YLim = [-90 90];
ax2.XLim = [0 1000];
ax2.FontName = 'Times New Roman';
ax2.FontSize = 14;
xlabel(ax2, 's_u, [psf]', 'FontSize', 16);
ylabel(ax2, 'Elevation, [ft]', 'FontSize', 16);
title(ax2, 'C-01F')
grid(ax2, 'minor'); box(ax2, 'on');

% C-02F plot: su =========================================================

ax3 = nexttile(t, 10); % next tiles in second row
plot(c02f.cpt_su, c02f.cpt_elv, 'k')
yline(c02f.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
yline([40, 25, -20, -32], 'LineWidth', 1.5, 'Color', 'k', 'LineStyle','-.')
ax3.YLim = [-90 90];
ax3.XLim = [0 1000];
ax3.FontName = 'Times New Roman';
ax3.FontSize = 14;
xlabel(ax3, 's_u, [psf]', 'FontSize', 16);
ylabel(ax3, 'Elevation, [ft]', 'FontSize', 16);
title(ax3, 'C-02F')
grid(ax3, 'minor'); box(ax3, 'on');

% C-03XF plot: su =========================================================

ax4 = nexttile(t, 11); % next tiles in second row
plot(c03xf.cpt_su, c03xf.cpt_elv, 'k')
hold on
yline(c03xf.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
yline([25, 15, -6, -12], 'LineWidth', 1.5, 'Color', 'k', 'LineStyle','-.')
yline(18.63, 'LineWidth', 1.5, 'Color', 'r', 'LineStyle','--')
scatter(b03xf.mdotsu.peakx, b03xf.mdotsu.peaky, 15, 'filled', 'Marker', 'o', 'MarkerEdgeColor','m', 'MarkerFaceColor','m')
scatter(b03xf.mdotsu.remoldedx, b03xf.mdotsu.remoldedy, 15, 'Marker', 'o', 'MarkerEdgeColor', 'm', 'LineWidth', 1, 'MarkerFaceColor', 'w')
ax4.YLim = [-90 90];
ax4.XLim = [0 1000];
ax4.FontName = 'Times New Roman';
ax4.FontSize = 14;
xlabel(ax4, 's_u, [psf]', 'FontSize', 16);
ylabel(ax4, 'Elevation, [ft]', 'FontSize', 16);
title(ax4, 'C-03XF')
grid(ax4, 'minor'); box(ax4, 'on');

% C-04XF plot: su =========================================================

ax5 = nexttile(t, 12); % next tiles in second row
plot(c04xf.cpt_su, c04xf.cpt_elv, 'k')
hold on
yline(c04xf.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
yline([15, 0, -12], 'LineWidth', 1.5, 'Color', 'k', 'LineStyle','-.')
yline(-3.5, 'LineWidth', 1.5, 'Color', 'r', 'LineStyle','--')
scatter(b04xf.mdotsu.peakx, b04xf.mdotsu.peaky, 15, 'filled', 'Marker', 'o', 'MarkerEdgeColor','m', 'MarkerFaceColor','m')
scatter(b04xf.mdotsu.remoldedx, b04xf.mdotsu.remoldedy, 15, 'Marker', 'o', 'MarkerEdgeColor', 'm', 'LineWidth', 1, 'MarkerFaceColor', 'w')
ax5.YLim = [-90 90];
ax5.XLim = [0 1000];
ax5.FontName = 'Times New Roman';
ax5.FontSize = 14;
xlabel(ax5, 's_u, [psf]', 'FontSize', 16);
ylabel(ax5, 'Elevation, [ft]', 'FontSize', 16);
title(ax5, 'C-04XF')
grid(ax5, 'minor'); box(ax5, 'on');

% C-01F plot: res =========================================================

ax6 = nexttile(t, 13); % next tiles in second row
plot(c01f.cpt_res, c01f.cpt_elv, 'k')
yline(c01f.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
yline([47, 40, -29, -43], 'LineWidth', 1.5, 'Color', 'k', 'LineStyle','-.')
ax6.YLim = [-90 90];
ax6.XLim = [0 100];
ax6.FontName = 'Times New Roman';
ax6.FontSize = 14;
xlabel(ax6, 'Res, [ohm-m]', 'FontSize', 16);
ylabel(ax6, 'Elevation, [ft]', 'FontSize', 16);
title(ax6, 'C-01F')
grid(ax6, 'minor'); box(ax6, 'on');

% C-02F plot: res =========================================================

ax7 = nexttile(t, 14); % next tiles in second row
plot(c02f.cpt_res, c02f.cpt_elv, 'k')
yline(c02f.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
yline([40, 25, -20, -32], 'LineWidth', 1.5, 'Color', 'k', 'LineStyle','-.')
ax7.YLim = [-90 90];
ax7.XLim = [0 100];
ax7.FontName = 'Times New Roman';
ax7.FontSize = 14;
xlabel(ax7, 'Res, [ohm-m]', 'FontSize', 16);
ylabel(ax7, 'Elevation, [ft]', 'FontSize', 16);
title(ax7, 'C-02F')
grid(ax7, 'minor'); box(ax7, 'on');

% C-03XF plot: res =========================================================

ax8 = nexttile(t, 15); % next tiles in second row
plot(c03xf.cpt_res, c03xf.cpt_elv, 'k')
yline(c03xf.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
yline([25, 15, -6, -12], 'LineWidth', 1.5, 'Color', 'k', 'LineStyle','-.')
yline(18.63, 'LineWidth', 1.5, 'Color', 'r', 'LineStyle','--')
ax8.YLim = [-90 90];
ax8.XLim = [0 100];
ax8.FontName = 'Times New Roman';
ax8.FontSize = 14;
xlabel(ax8, 'Res, [ohm-m]', 'FontSize', 16);
ylabel(ax8, 'Elevation, [ft]', 'FontSize', 16);
title(ax8, 'C-03XF')
grid(ax8, 'minor'); box(ax8, 'on');

% C-04XF plot: res =========================================================

ax9 = nexttile(t, 16); % next tiles in second row
plot(c04xf.cpt_res, c04xf.cpt_elv, 'k')
yline(c04xf.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
yline([15, 0, -12], 'LineWidth', 1.5, 'Color', 'k', 'LineStyle','-.')
yline(-3.5, 'LineWidth', 1.5, 'Color', 'r', 'LineStyle','--')
ax9.YLim = [-90 90];
ax9.XLim = [0 100];
ax9.FontName = 'Times New Roman';
ax9.FontSize = 14;
xlabel(ax9, 'Res, [ohm-m]', 'FontSize', 16);
ylabel(ax9, 'Elevation, [ft]', 'FontSize', 16);
title(ax9, 'C-04XF')
grid(ax9, 'minor'); box(ax9, 'on');
