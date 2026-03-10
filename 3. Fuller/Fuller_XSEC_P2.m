% DRAWS CROSS SECTIONS BASED ON ELEVATION. X SPACING IS USER DEFINED IN
% ARCGIS. MUST RUN Puritan_XSEC_DataProcess.m FIRST

%% INPUT PROCESSED DATA 
clear all; close all; clc;

load("FullerAllDataP2.mat")

%% RESISTIVITY AND WATER ZONES

reszones.dropx = [(surf_dist(50) + surf_dist(51))/2, ...
                (surf_dist(126)+surf_dist(127))/2, ...
                surf_dist(214)];
reszones.dropy = [-31, -18, -30];

reszones.smoothdecx = [(surf_dist(50) + surf_dist(51))/2, ...
                (surf_dist(126)+surf_dist(127))/2, ...
                surf_dist(214)];
reszones.smoothdecy = [-20, -5, -20];

reszones.notsmoothdecx = [(surf_dist(50) + surf_dist(51))/2, ...
                (surf_dist(126)+surf_dist(127))/2, ...
                surf_dist(214)];
reszones.notsmoothdecy = [40, 30, -5];

reszones.variablelowqcx = [(surf_dist(50) + surf_dist(51))/2, ...
                (surf_dist(126)+surf_dist(127))/2, ...
                surf_dist(214)];
reszones.variablelowqcy = [53, 53, -5];

waterzones.x = [(surf_dist(50) + surf_dist(51))/2, ...
                (surf_dist(126)+surf_dist(127))/2, ...
                surf_dist(214), ...
                2240, 2300];

waterzones.y = [c07f.cpt_water, c06xf.cpt_water, c05f.cpt_water, 15.7526, 15.748];

slipsurf.x = [1880, 1950, 2130, 2240]; slipsurf.y = [39.67, 2.5, -5, -5];
slipsurf2.x = [1560, 1625, 2130, 2240]; slipsurf2.y = [62, 30, -5, -12];

presurf.x = [1880, 2200, 2240]; presurf.y = [39.6729, 39.6729, 15.75];
presurf2.x = [1560, 2200, 2240]; presurf2.y = [62, 39.6729, 15.75];

%% GENERATE FIGURE: CROSS SECTION AND SU

close all
fig1 = figure('Color','w', 'Position', [1921,49,1920,955]);
t = tiledlayout(fig1, 2, 8, 'TileSpacing', 'compact', 'Padding', 'compact');
ax1 = nexttile(t, [1 8]); % spans 1 row and 3 columns

% Plot surface ============================================================

plot(ax1, surf_dist, surf_elv, 'LineWidth', 2, 'Color', 'k')
hold on

% Plot CPT stick ==========================================================

patch(ax1, 'XData', c07f.cpt_stickx, 'YData', c07f.cpt_sticky, 'FaceColor', 'w');
patch(ax1, 'XData', c06xf.cpt_stickx, 'YData', c06xf.cpt_sticky, 'FaceColor', 'w');
patch(ax1, 'XData', c05f.cpt_stickx, 'YData', c05f.cpt_sticky, 'FaceColor', 'w');

% Plot Water in CPT ==============================================================

plot(ax1, [c05f.cpt_stickx(1), c05f.cpt_stickx(end)], [c05f.cpt_water, c05f.cpt_water], 'LineWidth', 2, 'Color', 'b')
plot(ax1, [c06xf.cpt_stickx(1), c06xf.cpt_stickx(end)], [c06xf.cpt_water, c06xf.cpt_water], 'LineWidth', 2, 'Color', 'b')
plot(ax1, [c07f.cpt_stickx(1), c07f.cpt_stickx(end)], [c07f.cpt_water, c07f.cpt_water], 'LineWidth', 2, 'Color', 'b')

% Main x-axis: distance along the profile =================================

ax1.YLim = [-90 90];
ax1.XLim = [0 2600];
ax1.FontName = 'Times New Roman';
ax1.FontSize = 14;
xlabel(ax1, 'Distance, [ft]', 'FontSize', 16);
ylabel(ax1, 'Elevation, [ft]', 'FontSize', 16);
title('Fuller Profile 2', 'FontName', 'Times New Roman', 'FontSize', 16);
grid(ax1, 'minor'); box(ax1, 'on');
 
% CPT ID Texts ============================================================
txt = sprintf('C-07F (9.15 ft N)');
text(440, 75, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring
txt = sprintf('C-06XF (76.10 ft S)');
text(1230, 70, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring
txt = sprintf('C-05F (155.14 ft N)');
text(2050, 45, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring

% Plot Boring stick ==========================================================

patch(ax1, 'XData', b06xf.bor_stickx, 'YData', b06xf.bor_sticky, 'FaceColor', 'w');

% B-06XF Soil Class ==========================================================

l1 = patch(ax1, 'XData', b06xf.layer.x1, 'YData', b06xf.layer.y1, 'FaceColor', col.asphalt);
hatchfill2(l1, 'cross', 'LineWidth', 1, 'HatchAngle', 45, 'HatchDensity', 100);
pg1 = polyshape(b06xf.layer.x1, b06xf.layer.y1); [cx1, cy1] = centroid(pg1);
text(ax1, 1215, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l2 = patch(ax1, 'XData', b06xf.layer.x2, 'YData', b06xf.layer.y2, 'FaceColor', col.sand);
hatchfill2(l2, 'fill');
pg1 = polyshape(b06xf.layer.x2, b06xf.layer.y2); [cx1, cy1] = centroid(pg1);
text(ax1, 1215, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l3 = patch(ax1, 'XData', b06xf.layer.x3, 'YData', b06xf.layer.y3, 'FaceColor', col.clay);
hatchfill2(l3, 'single', 'LineWidth', 1, 'HatchAngle', 90, 'HatchDensity', 500);
pg1 = polyshape(b06xf.layer.x3, b06xf.layer.y3); [cx1, cy1] = centroid(pg1);
text(ax1, 1215, cy1, '0.28-0.36', 'Rotation', 0, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l4 = patch(ax1, 'XData', b06xf.layer.x4, 'YData', b06xf.layer.y4, 'FaceColor', col.clay);
hatchfill2(l4, 'fill');
pg1 = polyshape(b06xf.layer.x4, b06xf.layer.y4); [cx1, cy1] = centroid(pg1);
text(ax1, 1215, cy1, '0.24-0.28', 'Rotation', 0, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l5 = patch(ax1, 'XData', b06xf.layer.x5, 'YData', b06xf.layer.y5, 'FaceColor', col.sand);
hatchfill2(l5, 'single', 'LineWidth', 1, 'HatchAngle', 45, 'HatchDensity', 100);
pg1 = polyshape(b06xf.layer.x5, b06xf.layer.y5); [cx1, cy1] = centroid(pg1);
text(ax1, 1215, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l6 = patch(ax1, 'XData', b06xf.layer.x6, 'YData', b06xf.layer.y6, 'FaceColor', col.clay);
hatchfill2(l6, 'fill');
pg1 = polyshape(b06xf.layer.x6, b06xf.layer.y6); [cx1, cy1] = centroid(pg1);
text(ax1, 1215, cy1, '0.16-0.22', 'Rotation', 0, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l7 = patch(ax1, 'XData', b06xf.layer.x7, 'YData', b06xf.layer.y7, 'FaceColor', col.clay);
hatchfill2(l7, 'fill');
pg1 = polyshape(b06xf.layer.x7, b06xf.layer.y7); [cx1, cy1] = centroid(pg1);
text(ax1, 1215, cy1, '0.16', 'Rotation', 0, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

% Plot Water in boring ==============================================================

plot(ax1, [b06xf.bor_stickx(1), b06xf.bor_stickx(end)], [b06xf.bor_water, b06xf.bor_water], 'LineWidth', 2, 'Color', 'b')

% Plot shelby tube samples ================================================

% B06XF
x = [b06xf.bor_stickx(1), b06xf.bor_stickx(end)];
plot(ax1, x, [b06xf.samples(1), b06xf.samples(1)], 'LineWidth', 2, 'Color', 'g')
plot(ax1, x, [b06xf.samples(2), b06xf.samples(2)], 'LineWidth', 2, 'Color', 'r')
plot(ax1, x, [b06xf.samples(3), b06xf.samples(3)], 'LineWidth', 2, 'Color', 'r')
plot(ax1, x, [b06xf.samples(4), b06xf.samples(4)], 'LineWidth', 2, 'Color', 'g')
plot(ax1, x, [b06xf.samples(5), b06xf.samples(5)], 'LineWidth', 2, 'Color', 'g')
plot(ax1, x, [b06xf.samples(6), b06xf.samples(6)], 'LineWidth', 2, 'Color', 'g')

% Boring ID Texts ============================================================
txt = sprintf('B-06XF (75.76 ft S)');
text(1150, 80, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring

% Plot resistivity zones ==================================================

line(ax1, 'XData', reszones.dropx, 'YData', reszones.dropy, 'LineWidth', 1, 'Color', 'k', 'LineStyle', '--')
line(ax1, 'XData', reszones.smoothdecx, 'YData', reszones.smoothdecy, 'LineWidth', 1, 'Color', 'k', 'LineStyle', '--')
line(ax1, 'XData', reszones.notsmoothdecx, 'YData', reszones.notsmoothdecy, 'LineWidth', 1, 'Color', 'k', 'LineStyle', '--')
line(ax1, 'XData', reszones.variablelowqcx, 'YData', reszones.variablelowqcy, 'LineWidth', 1, 'Color', 'k', 'LineStyle', '--')
hold on

% Plot slip surface and previous surface  =================================
% drawn by MGS
line(ax1, 'XData', slipsurf.x, 'YData', slipsurf.y, 'LineWidth', 1, 'Color', [1, 0, 0, 1])
line(ax1, 'XData', presurf.x, 'YData', presurf.y, 'LineWidth', 1, 'Color', [0, 0, 0, 0.4])

% % My take
% line(ax1, 'XData', slipsurf2.x, 'YData', slipsurf2.y, 'LineWidth', 1, 'Color', [1, 0, 0, 1])
% line(ax1, 'XData', presurf2.x, 'YData', presurf2.y, 'LineWidth', 1, 'Color', [0, 0, 0, 0.5])

% Plot water table? ==================================================

line(ax1, 'XData', waterzones.x, 'YData', waterzones.y, 'LineWidth', 2, 'Color', 'b', 'LineStyle', ':')

% Plot legend =============================================================
legend(ax1, 'Current Surface', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ...
    '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ...
    'Slip Surface (MGS)', 'Previous Surface (MGS)', 'Slip Surface', 'Previous Surface', 'Water', ...
    'Location', 'southwest')

% C-07F plot: su =========================================================

ax2 = nexttile(t, 10); % next tiles in second row
plot(c07f.cpt_su, c07f.cpt_elv, 'k')
yline(c07f.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
yline([53, 40, -20, -31], 'LineWidth', 1.5, 'Color', 'k', 'LineStyle', '-.')
ax2.YLim = [-90 90];
ax2.XLim = [0 1000];
ax2.FontName = 'Times New Roman';
ax2.FontSize = 14;
xlabel(ax2, 's_u, [psf]', 'FontSize', 16);
ylabel(ax2, 'Elevation, [ft]', 'FontSize', 16);
title(ax2, 'C-07F')
grid(ax2, 'minor'); box(ax2, 'on');

% C-06XF plot: su =========================================================

ax3 = nexttile(t, 11); % next tiles in second row
plot(c06xf.cpt_su, c06xf.cpt_elv, 'k')
hold on
yline(c06xf.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
yline([53, 30, -5, -18], 'LineWidth', 1.5, 'Color', 'k', 'LineStyle', '-.')
scatter(b06xf.mdotsu.peakx, b06xf.mdotsu.peaky, 15, 'filled', 'Marker', 'o', 'MarkerEdgeColor','m', 'MarkerFaceColor','m')
scatter(b06xf.mdotsu.remoldedx, b06xf.mdotsu.remoldedy, 15, 'Marker', 'o', 'MarkerEdgeColor', 'm', 'LineWidth', 1, 'MarkerFaceColor', 'w')
ax3.YLim = [-90 90];
ax3.XLim = [0 1000];
ax3.FontName = 'Times New Roman';
ax3.FontSize = 14;
xlabel(ax3, 's_u, [psf]', 'FontSize', 16);
ylabel(ax3, 'Elevation, [ft]', 'FontSize', 16);
title(ax3, 'C-06XF')
grid(ax3, 'minor'); box(ax3, 'on');

% C-05F plot: su =========================================================

ax4 = nexttile(t, 12); % next tiles in second row
plot(c05f.cpt_su, c05f.cpt_elv, 'k')
yline(c05f.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
yline([-5, -20, -30], 'LineWidth', 1.5, 'Color', 'k', 'LineStyle', '-.')
yline(-5, 'LineWidth', 1.5, 'Color', 'r', 'LineStyle','--')
ax4.YLim = [-90 90];
ax4.XLim = [0 1000];
ax4.FontName = 'Times New Roman';
ax4.FontSize = 14;
xlabel(ax4, 's_u, [psf]', 'FontSize', 16);
ylabel(ax4, 'Elevation, [ft]', 'FontSize', 16);
title(ax4, 'C-05F')
grid(ax4, 'minor'); box(ax4, 'on');

% C-07F plot: res =========================================================

ax5 = nexttile(t, 13); % next tiles in second row
plot(c07f.cpt_res, c07f.cpt_elv, 'k')
yline(c07f.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
yline([53, 40, -20, -31], 'LineWidth', 1.5, 'Color', 'k', 'LineStyle', '-.')
ax5.YLim = [-90 90];
ax5.XLim = [0 100];
ax5.FontName = 'Times New Roman';
ax5.FontSize = 14;
xlabel(ax5, 'Res, [ohm-m]', 'FontSize', 16);
ylabel(ax5, 'Elevation, [ft]', 'FontSize', 16);
title(ax5, 'C-07F')
grid(ax5, 'minor'); box(ax5, 'on');

% C-06XF plot: res =========================================================

ax6 = nexttile(t, 14); % next tiles in second row
plot(c06xf.cpt_res, c06xf.cpt_elv, 'k')
yline(c06xf.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
yline([53, 30, -5, -18], 'LineWidth', 1.5, 'Color', 'k', 'LineStyle', '-.')
ax6.YLim = [-90 90];
ax6.XLim = [0 100];
ax6.FontName = 'Times New Roman';
ax6.FontSize = 14;
xlabel(ax6, 'Res, [ohm-m]', 'FontSize', 16);
ylabel(ax6, 'Elevation, [ft]', 'FontSize', 16);
title(ax6, 'C-06XF')
grid(ax6, 'minor'); box(ax6, 'on');

% C-05F plot: res =========================================================

ax7 = nexttile(t, 15); % next tiles in second row
plot(c05f.cpt_res, c05f.cpt_elv, 'k')
yline(c05f.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
yline([-5, -20, -30], 'LineWidth', 1.5, 'Color', 'k', 'LineStyle', '-.')
yline(-5, 'LineWidth', 1.5, 'Color', 'r', 'LineStyle','--')
ax7.YLim = [-90 90];
ax7.XLim = [0 100];
ax7.FontName = 'Times New Roman';
ax7.FontSize = 14;
xlabel(ax7, 'Res, [ohm-m]', 'FontSize', 16);
ylabel(ax7, 'Elevation, [ft]', 'FontSize', 16);
title(ax7, 'C-05F')
grid(ax7, 'minor'); box(ax7, 'on');

