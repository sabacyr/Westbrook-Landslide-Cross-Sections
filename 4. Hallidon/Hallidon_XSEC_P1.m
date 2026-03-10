% DRAWS CROSS SECTIONS BASED ON ELEVATION. X SPACING IS USER DEFINED IN
% ARCGIS. MUST RUN Puritan_XSEC_DataProcess.m FIRST

%% INPUT PROCESSED DATA 
clear all; close all; clc;

load("HallidonAllData.mat")


%% RESISTIVITY AND WATER ZONES

reszones.dropx = [c01xh.surf_dist(31), c03h.surf_dist(83)];
reszones.dropy = [-25, -25];

reszones.smoothdecx = [c01xh.surf_dist(31), c03h.surf_dist(83)];
reszones.smoothdecy = [-12, -10];

reszones.notsmoothdecx = [c01xh.surf_dist(31), c03h.surf_dist(83)];
reszones.notsmoothdecy = [30, 30];

reszones.variablelowqcx = [c01xh.surf_dist(31), c03h.surf_dist(83)];
reszones.variablelowqcy = [60, 30];

waterzones.x = [c01xh.surf_dist(31), c03h.surf_dist(83), 1170, 1220];
waterzones.y = [c01xh.cpt_water, c03h.cpt_water, 15.8689, 15.748];

%% GENERATE FIGURE: CROSS SECTION AND SU

close all
fig1 = figure('Color','w', 'Position', [1921,49,1920,955]);
t = tiledlayout(fig1, 2, 8, 'TileSpacing', 'compact', 'Padding', 'compact');
ax1 = nexttile(t, [1 8]); % spans 1 row and 8 columns

% Plot surface ============================================================

plot(ax1, c01xh.surf_dist, c01xh.surf_elv, 'LineWidth', 2, 'Color', [0 0 0 1])
hold(ax1, 'on')

% Plot CPT stick ==========================================================

patch(ax1, 'XData', c01xh.cpt_stickx, 'YData', c01xh.cpt_sticky, 'FaceColor', 'w');
patch(ax1, 'XData', c03h.cpt_stickx, 'YData', c03h.cpt_sticky, 'FaceColor', 'w');

% Plot Water in CPT ==============================================================

plot(ax1, [c01xh.cpt_stickx(1), c01xh.cpt_stickx(end)], [c01xh.cpt_water, c01xh.cpt_water], 'LineWidth', 2, 'Color', 'b')
plot(ax1, [c03h.cpt_stickx(1), c03h.cpt_stickx(end)], [c03h.cpt_water, c03h.cpt_water], 'LineWidth', 2, 'Color', 'b')

% Main x-axis: distance along the profile =================================

ax1.YLim = [-90 90];
ax1.XLim = [0 1400];
ax1.FontName = 'Times New Roman';
ax1.FontSize = 14;
xlabel(ax1, 'Distance, [ft]', 'FontSize', 16);
ylabel(ax1, 'Elevation, [ft]', 'FontSize', 16);
title('Hallidon Profile 1', 'FontName', 'Times New Roman', 'FontSize', 16);
grid(ax1, 'minor'); box(ax1, 'on');
 
% CPT ID Texts ============================================================

txt = sprintf('C-01XH (6.53 ft S)');
text(220, 80, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring
txt = sprintf('C-03H (892.45 ft N)');
text(800, 45, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring

% Plot Boring stick ==========================================================

patch(ax1, 'XData', b01xh.bor_stickx, 'YData', b01xh.bor_sticky, 'FaceColor', 'w');

% B-01XH Soil Class ==========================================================

l1 = patch(ax1, 'XData', b01xh.layer.x1, 'YData', b01xh.layer.y1, 'FaceColor', col.asphalt);
hatchfill2(l1, 'cross', 'LineWidth', 1, 'HatchAngle', 45, 'HatchDensity', 100);
pg1 = polyshape(b01xh.layer.x1, b01xh.layer.y1); [cx1, cy1] = centroid(pg1);
text(ax1, 335, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l2 = patch(ax1, 'XData', b01xh.layer.x2, 'YData', b01xh.layer.y2, 'FaceColor', col.sand);
hatchfill2(l2, 'fill');
pg1 = polyshape(b01xh.layer.x2, b01xh.layer.y2); [cx1, cy1] = centroid(pg1);
text(ax1, 335, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l3 = patch(ax1, 'XData', b01xh.layer.x3, 'YData', b01xh.layer.y3, 'FaceColor', col.sand);
hatchfill2(l3, 'single', 'LineWidth', 1, 'HatchAngle', 45, 'HatchDensity', 100);
pg1 = polyshape(b01xh.layer.x3, b01xh.layer.y3); [cx1, cy1] = centroid(pg1);
text(ax1, 335, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l4 = patch(ax1, 'XData', b01xh.layer.x4, 'YData', b01xh.layer.y4, 'FaceColor', col.clay);
hatchfill2(l4, 'fill');
pg1 = polyshape(b01xh.layer.x4, b01xh.layer.y4); [cx1, cy1] = centroid(pg1);
text(ax1, 335, cy1, '0.2-0.32', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l5 = patch(ax1, 'XData', b01xh.layer.x5, 'YData', b01xh.layer.y5, 'FaceColor', col.sand);
hatchfill2(l5, 'single', 'LineWidth', 1, 'HatchAngle', 45, 'HatchDensity', 100);
pg1 = polyshape(b01xh.layer.x5, b01xh.layer.y5); [cx1, cy1] = centroid(pg1);
text(ax1, 335, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l6 = patch(ax1, 'XData', b01xh.layer.x6, 'YData', b01xh.layer.y6, 'FaceColor', col.clay);
hatchfill2(l6, 'fill');
pg1 = polyshape(b01xh.layer.x6, b01xh.layer.y6); [cx1, cy1] = centroid(pg1);
text(ax1, 335, cy1, '1.6-0.2', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

% Plot Water in boring ==============================================================

plot(ax1, [b01xh.bor_stickx(1), b01xh.bor_stickx(end)], [b01xh.bor_water, b01xh.bor_water], 'LineWidth', 2, 'Color', 'b')

% Plot shelby tube samples ================================================

% B01XH
x = [b01xh.bor_stickx(1), b01xh.bor_stickx(end)];
plot(ax1, x, [b01xh.samples(1), b01xh.samples(1)], 'LineWidth', 2, 'Color', 'g')
plot(ax1, x, [b01xh.samples(2), b01xh.samples(2)], 'LineWidth', 2, 'Color', 'g')
plot(ax1, x, [b01xh.samples(3), b01xh.samples(3)], 'LineWidth', 2, 'Color', 'r')
plot(ax1, x, [b01xh.samples(4), b01xh.samples(4)], 'LineWidth', 2, 'Color', 'g')
plot(ax1, x, [b01xh.samples(5), b01xh.samples(5)], 'LineWidth', 2, 'Color', 'g')

% Boring ID Texts ============================================================

txt = sprintf('B-01XH (3.02 ft S)');
text(320, 80, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring

% Plot resistivity zones ==================================================

line(ax1, 'XData', reszones.dropx, 'YData', reszones.dropy, 'LineWidth', 1, 'Color', 'k', 'LineStyle', '--')
line(ax1, 'XData', reszones.smoothdecx, 'YData', reszones.smoothdecy, 'LineWidth', 1, 'Color', 'k', 'LineStyle', '--')
line(ax1, 'XData', reszones.notsmoothdecx, 'YData', reszones.notsmoothdecy, 'LineWidth', 1, 'Color', 'k', 'LineStyle', '--')
line(ax1, 'XData', reszones.variablelowqcx, 'YData', reszones.variablelowqcy, 'LineWidth', 1, 'Color', 'k', 'LineStyle', '--')
hold on

% Plot water table? =======================================================

line(ax1, 'XData', waterzones.x, 'YData', waterzones.y, 'LineWidth', 2, 'Color', 'b', 'LineStyle', ':')

% Plot legend =============================================================
legend(ax1, 'Current Surface', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ...
    '', '', '', '', '', '', '', '', '', '', '', '', '', 'Water')

% C-01XH plot: su ==========================================================

ax2 = nexttile(t, 11); % next tiles in second row
plot(c01xh.cpt_su, c01xh.cpt_elv, 'k')
hold on
yline(c01xh.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
yline([60, 30, -12, -25], 'LineWidth', 1.5, 'Color', 'k', 'LineStyle', '-.')
scatter(b01xh.mdotsu.peakx, b01xh.mdotsu.peaky, 15, 'filled', 'Marker', 'o', 'MarkerEdgeColor','m', 'MarkerFaceColor','m')
scatter(b01xh.mdotsu.remoldedx, b01xh.mdotsu.remoldedy, 15, 'Marker', 'o', 'MarkerEdgeColor', 'm', 'LineWidth', 1, 'MarkerFaceColor', 'w')
ax2.YLim = [-90 90];
ax2.XLim = [0 2000];
ax2.FontName = 'Times New Roman';
ax2.FontSize = 14;
xlabel(ax2, 's_u, [psf]', 'FontSize', 16);
ylabel(ax2, 'Elevation, [ft]', 'FontSize', 16);
title(ax2, 'C-01XH')
grid(ax2, 'minor'); box(ax2, 'on');

% C-03H plot: su =========================================================

ax3 = nexttile(t, 12); % next tiles in second row
plot(c03h.cpt_su, c03h.cpt_elv, 'k')
yline(c03h.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
yline([30, -10, -25], 'LineWidth', 1.5, 'Color', 'k', 'LineStyle', '-.')
ax3.YLim = [-90 90];
ax3.XLim = [0 2000];
ax3.FontName = 'Times New Roman';
ax3.FontSize = 14;
xlabel(ax3, 's_u, [psf]', 'FontSize', 16);
ylabel(ax3, 'Elevation, [ft]', 'FontSize', 16);
title(ax3, 'C-03H')
grid(ax3, 'minor'); box(ax3, 'on');

% C-01XH plot: res =========================================================

ax4 = nexttile(t, 13); % next tiles in second row
plot(c01xh.cpt_res, c01xh.cpt_elv, 'k')
yline(c01xh.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
yline([60, 30, -12, -25], 'LineWidth', 1.5, 'Color', 'k', 'LineStyle', '-.')
ax4.YLim = [-90 90];
ax4.XLim = [0 100];
ax4.FontName = 'Times New Roman';
ax4.FontSize = 14;
xlabel(ax4, 'Res, [ohm-m]', 'FontSize', 16);
ylabel(ax4, 'Elevation, [ft]', 'FontSize', 16);
title(ax4, 'C-01XH')
grid(ax4, 'minor'); box(ax4, 'on');

% C-03H plot: res =========================================================

ax5 = nexttile(t, 14); % next tiles in second row
plot(c03h.cpt_res, c03h.cpt_elv, 'k')
yline(c03h.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
yline([30, -10, -25], 'LineWidth', 1.5, 'Color', 'k', 'LineStyle', '-.')
ax5.YLim = [-90 90];
ax5.XLim = [0 100];
ax5.FontName = 'Times New Roman';
ax5.FontSize = 14;
xlabel(ax5, 'Res, [ohm-m]', 'FontSize', 16);
ylabel(ax5, 'Elevation, [ft]', 'FontSize', 16);
title(ax5, 'C-03H')
grid(ax5, 'minor'); box(ax5, 'on');
