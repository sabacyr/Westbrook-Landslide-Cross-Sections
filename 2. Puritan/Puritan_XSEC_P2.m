% DRAWS CROSS SECTIONS BASED ON ELEVATION. X SPACING IS USER DEFINED IN
% ARCGIS. MUST RUN Puritan_XSEC_DataProcess.m FIRSTbor_stickx

%% INPUT PROCESSED DATA 
close all; clc;

load("PuritanAllData.mat")

% this portion is because in the data process portion i processed assuming
% these were all going to be on one cross section but now i want these
% specific ones to be on another cross section so im recalculating.

crosssec_surf = table2array(readtable("Puritan XS.xlsx","Sheet", 16));
c07p.cpt_stickx = [crosssec_surf(50, 2)-5, crosssec_surf(50, 2)-5, crosssec_surf(50, 2)+5, crosssec_surf(50, 2)+5];
c08xp.cpt_stickx = [crosssec_surf(90, 2)-5, crosssec_surf(90, 2)-5, crosssec_surf(90, 2)+5, crosssec_surf(90, 2)+5];
b08xp.bor_stickx = [crosssec_surf(90, 2)+7.5, crosssec_surf(90, 2)+7.5, crosssec_surf(90, 2)+27.5, crosssec_surf(90, 2)+27.5];
c09p.cpt_stickx = [crosssec_surf(141, 2)-5, crosssec_surf(141, 2)-5, crosssec_surf(141, 2)+5, crosssec_surf(141, 2)+5];
c01p.cpt_stickx = [crosssec_surf(119, 2)-5, crosssec_surf(119, 2)-5, crosssec_surf(119, 2)+5, crosssec_surf(119, 2)+5];


b08xp.layer.x1 = b08xp.bor_stickx;
b08xp.layer.x2 = b08xp.bor_stickx;
b08xp.layer.x3 = b08xp.bor_stickx;
b08xp.layer.x4 = b08xp.bor_stickx;
b08xp.layer.x5 = b08xp.bor_stickx;
b08xp.layer.x6 = b08xp.bor_stickx;
b08xp.layer.x7 = b08xp.bor_stickx;
b08xp.layer.x8 = b08xp.bor_stickx;
b08xp.layer.x9 = b08xp.bor_stickx;
b08xp.layer.x10 = b08xp.bor_stickx;
b08xp.layer.x11 = b08xp.bor_stickx;


%% RESISTIVITY AND WATER ZONES

reszones.dropx = [crosssec_surf(50, 2), crosssec_surf(90, 2), crosssec_surf(141, 2)];
reszones.dropy = [-2.5, 15.5, -2.5];
reszones.smoothdecx = [crosssec_surf(50, 2), crosssec_surf(90, 2), crosssec_surf(141, 2)];
reszones.smoothdecy = [6, 15.5, -2.5];
reszones.notsmoothdecx = [crosssec_surf(50, 2), crosssec_surf(90, 2), crosssec_surf(141, 2)];
reszones.notsmoothdecy = [20, 15.5, -2.5];
reszones.variablelowqcx = [crosssec_surf(50, 2), crosssec_surf(90, 2), crosssec_surf(141, 2)];
reszones.variablelowqcy = [24, 29, 10];

waterzones.x = [crosssec_surf(50, 2), crosssec_surf(90, 2), crosssec_surf(141, 2), 1450, 1520];
waterzones.y = [c07p.cpt_water(1), c08xp.cpt_water(1), c09p.cpt_water(1), 15.01, 15.01];

%% GENERATE FIGURE: CROSS SECTION THROUGH 7P, 8P, 9P AND SU

close all
fig1 = figure('Color','w', 'Position', [1921,49,1920,955]);
t = tiledlayout(fig1, 2, 8, 'TileSpacing', 'compact', 'Padding', 'compact');
ax1 = nexttile(t, [1 8]); % spans 1 row and 3 columns

% Plot surface ============================================================

plot(ax1, crosssec_surf(:, 2), crosssec_surf(:, 1), 'LineWidth', 2, 'Color', [0 0 0 1])
hold(ax1, 'on')

% Plot CPT stick ==========================================================

patch(ax1, 'XData', c07p.cpt_stickx, 'YData', c07p.cpt_sticky, 'FaceColor', 'w');
patch(ax1, 'XData', c08xp.cpt_stickx, 'YData', c08xp.cpt_sticky, 'FaceColor', 'w');
patch(ax1, 'XData', c09p.cpt_stickx, 'YData', c09p.cpt_sticky, 'FaceColor', 'w');

% Plot Water in CPT ==============================================================

plot(ax1, [c07p.cpt_stickx(1), c07p.cpt_stickx(end)], [c07p.cpt_water, c07p.cpt_water], 'LineWidth', 2, 'Color', 'b')
plot(ax1, [c08xp.cpt_stickx(1), c08xp.cpt_stickx(end)], [c08xp.cpt_water, c08xp.cpt_water], 'LineWidth', 2, 'Color', 'b')
plot(ax1, [c09p.cpt_stickx(1), c09p.cpt_stickx(end)], [c09p.cpt_water, c09p.cpt_water], 'LineWidth', 2, 'Color', 'b')

% Main x-axis: distance along the profile =================================

ax1.YLim = [-90 90];
ax1.XLim = [0 2000];
ax1.FontName = 'Times New Roman';
ax1.FontSize = 14;
xlabel(ax1, 'Distance, [ft]', 'FontSize', 16);
ylabel(ax1, 'Elevation, [ft]', 'FontSize', 16);
title('Puritan Profile 2', 'FontName', 'Times New Roman', 'FontSize', 16);
grid(ax1, 'minor'); box(ax1, 'on');
 
% CPT ID Texts ============================================================
txt = sprintf('C-07P');
text(470, 50, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring
txt = sprintf('C-08XP (10.75 ft S)');
text(850, 55, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring
txt = sprintf('C-09P');
text(1380, 35, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring

% Plot Boring stick ==========================================================

patch(ax1, 'XData', b08xp.bor_stickx, 'YData', b08xp.bor_sticky, 'FaceColor', 'w');

% B-08XP Soil Class ==========================================================

l1 = patch(ax1, 'XData', b08xp.layer.x1, 'YData', b08xp.layer.y1, 'FaceColor', col.asphalt);
hatchfill2(l1, 'cross', 'LineWidth', 1, 'HatchAngle', 45, 'HatchDensity', 100);
pg1 = polyshape(b08xp.layer.x1, b08xp.layer.y1); [cx1, cy1] = centroid(pg1);
text(ax1, 925, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l2 = patch(ax1, 'XData', b08xp.layer.x2, 'YData', b08xp.layer.y2, 'FaceColor', col.sand);
hatchfill2(l2, 'fill');
pg1 = polyshape(b08xp.layer.x2, b08xp.layer.y2); [cx1, cy1] = centroid(pg1);
text(ax1, 925, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l3 = patch(ax1, 'XData', b08xp.layer.x3, 'YData', b08xp.layer.y3, 'FaceColor', col.clay);
hatchfill2(l3, 'fill');
pg1 = polyshape(b08xp.layer.x3, b08xp.layer.y3); [cx1, cy1] = centroid(pg1);
text(ax1, 925, cy1, '> 0.5', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l4 = patch(ax1, 'XData', b08xp.layer.x4, 'YData', b08xp.layer.y4, 'FaceColor', col.clay);
hatchfill2(l4, 'single', 'LineWidth', 1, 'HatchAngle', 90, 'HatchDensity', 500);
pg1 = polyshape(b08xp.layer.x4, b08xp.layer.y4); [cx1, cy1] = centroid(pg1);
text(ax1, 925, cy1, '0.28', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l5 = patch(ax1, 'XData', b08xp.layer.x5, 'YData', b08xp.layer.y5, 'FaceColor', col.clay);
hatchfill2(l5, 'fill');
pg1 = polyshape(b08xp.layer.x5, b08xp.layer.y5); [cx1, cy1] = centroid(pg1);
text(ax1, 925, cy1, '0.16-0.26', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l6 = patch(ax1, 'XData', b08xp.layer.x6, 'YData', b08xp.layer.y6, 'FaceColor', col.clay);
hatchfill2(l6, 'fill');
pg1 = polyshape(b08xp.layer.x6, b08xp.layer.y6); [cx1, cy1] = centroid(pg1);
text(ax1, 925, cy1, '0.2', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l7 = patch(ax1, 'XData', b08xp.layer.x7, 'YData', b08xp.layer.y7, 'FaceColor', col.clay);
hatchfill2(l7, 'fill');
pg1 = polyshape(b08xp.layer.x7, b08xp.layer.y7); [cx1, cy1] = centroid(pg1);
text(ax1, 925, cy1, '0.16', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l8 = patch(ax1, 'XData', b08xp.layer.x8, 'YData', b08xp.layer.y8, 'FaceColor', col.clay);
hatchfill2(l8, 'fill');
pg1 = polyshape(b08xp.layer.x8, b08xp.layer.y8); [cx1, cy1] = centroid(pg1);
text(ax1, 925, cy1, '0.16', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l9 = patch(ax1, 'XData', b08xp.layer.x9, 'YData', b08xp.layer.y9, 'FaceColor', col.clay);
hatchfill2(l9, 'single', 'LineWidth', 1, 'HatchAngle', 90, 'HatchDensity', 500);
pg1 = polyshape(b08xp.layer.x9, b08xp.layer.y9); [cx1, cy1] = centroid(pg1);
text(ax1, 925, cy1, '0.16', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

% Plot Water in boring ==============================================================

plot(ax1, [b08xp.bor_stickx(1), b08xp.bor_stickx(end)], [b08xp.bor_water, b08xp.bor_water], 'LineWidth', 2, 'Color', 'b')

% Plot shelby tube samples ================================================

% B08XP
x = [b08xp.bor_stickx(1), b08xp.bor_stickx(end)];
plot(ax1, x, [b08xp.samples(1), b08xp.samples(1)], 'LineWidth', 2, 'Color', 'g')
plot(ax1, x, [b08xp.samples(2), b08xp.samples(2)], 'LineWidth', 2, 'Color', 'g')
plot(ax1, x, [b08xp.samples(3), b08xp.samples(3)], 'LineWidth', 2, 'Color', 'g')
plot(ax1, x, [b08xp.samples(4), b08xp.samples(4)], 'LineWidth', 2, 'Color', 'g')

% Boring ID Texts ============================================================
txt = sprintf('B-08XP (17.75 ft N)');
text(900, 65, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring

% Plot resistivity zones ==================================================

line(ax1, 'XData', reszones.dropx, 'YData', reszones.dropy, 'LineWidth', 1, 'Color', 'k', 'LineStyle', '--')
line(ax1, 'XData', reszones.smoothdecx, 'YData', reszones.smoothdecy, 'LineWidth', 1, 'Color', 'k', 'LineStyle', '--')
line(ax1, 'XData', reszones.notsmoothdecx, 'YData', reszones.notsmoothdecy, 'LineWidth', 1, 'Color', 'k', 'LineStyle', '--')
line(ax1, 'XData', reszones.variablelowqcx, 'YData', reszones.variablelowqcy, 'LineWidth', 1, 'Color', 'k', 'LineStyle', '--')
hold on

% Plot water table? ==================================================

line(ax1, 'XData', waterzones.x, 'YData', waterzones.y, 'LineWidth', 2, 'Color', 'b', 'LineStyle', ':')

% Plot legend =============================================================
legend(ax1, 'Current Surface', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ...
    '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ...
    'Water', 'Location','southwest')

% C-07P plot: su =========================================================

ax2 = nexttile(t, 10); % next tiles in second row
plot(c07p.cpt_su, c07p.cpt_elv, 'k')
yline(c07p.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
yline([24, 20, 6, -2.5], 'LineWidth', 1.5, 'Color', 'k', 'LineStyle','-.')
ax2.YLim = [-60 60];
ax2.XLim = [0 1000];
ax2.FontName = 'Times New Roman';
ax2.FontSize = 14;
xlabel(ax2, 's_u, [psf]', 'FontSize', 16);
ylabel(ax2, 'Elevation, [ft]', 'FontSize', 16);
title(ax2, 'C-07P')
grid(ax2, 'minor'); box(ax2, 'on');

% C-08XP plot: su =========================================================

ax3 = nexttile(t, 11); % next tiles in second row
plot(c08xp.cpt_su, c08xp.cpt_elv, 'k')
hold on
yline(c08xp.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
yline([29, 15.5], 'LineWidth', 1.5, 'Color', 'k', 'LineStyle','-.')
scatter(b08xp.mdotsu.peakx, b08xp.mdotsu.peaky, 15, 'filled', 'Marker', 'o', 'MarkerEdgeColor','m', 'MarkerFaceColor','m')
scatter(b08xp.mdotsu.remoldedx, b08xp.mdotsu.remoldedy, 15, 'Marker', 'o', 'MarkerEdgeColor', 'm', 'LineWidth', 1, 'MarkerFaceColor', 'w')
ax3.YLim = [-60 60];
ax3.XLim = [0 1000];
ax3.FontName = 'Times New Roman';
ax3.FontSize = 14;
xlabel(ax3, 's_u, [psf]', 'FontSize', 16);
ylabel(ax3, 'Elevation, [ft]', 'FontSize', 16);
title(ax3, 'C-08XP')
grid(ax3, 'minor'); box(ax3, 'on');

% C-09P plot: su =========================================================

ax4 = nexttile(t, 12); % next tiles in second row
plot(c09p.cpt_su, c09p.cpt_elv, 'k')
yline(c09p.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
yline([10, -2.5], 'LineWidth', 1.5, 'Color', 'k', 'LineStyle','-.')
ax4.YLim = [-60 60];
ax4.XLim = [0 1000];
ax4.FontName = 'Times New Roman';
ax4.FontSize = 14;
xlabel(ax4, 's_u, [psf]', 'FontSize', 16);
ylabel(ax4, 'Elevation, [ft]', 'FontSize', 16);
title(ax4, 'C-09P')
grid(ax4, 'minor'); box(ax4, 'on');

% C-07P plot: res =========================================================

ax5 = nexttile(t, 13); % next tiles in second row
plot(c07p.cpt_res, c07p.cpt_elv, 'k')
yline(c07p.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
yline([24, 20, 6, -2.5], 'LineWidth', 1.5, 'Color', 'k', 'LineStyle','-.')
ax5.YLim = [-60 60];
ax5.XLim = [0 100];
ax5.FontName = 'Times New Roman';
ax5.FontSize = 14;
xlabel(ax5, 'Res, [ohm-m]', 'FontSize', 16);
ylabel(ax5, 'Elevation, [ft]', 'FontSize', 16);
title(ax5, 'C-07P')
grid(ax5, 'minor'); box(ax5, 'on');

% C-08XP plot: res =========================================================

ax6 = nexttile(t, 14); % next tiles in second row
plot(c08xp.cpt_res, c08xp.cpt_elv, 'k')
yline(c08xp.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
yline([29, 15.5], 'LineWidth', 1.5, 'Color', 'k', 'LineStyle','-.')
ax6.YLim = [-60 60];
ax6.XLim = [0 100];
ax6.FontName = 'Times New Roman';
ax6.FontSize = 14;
xlabel(ax6, 'Res, [ohm-m]', 'FontSize', 16);
ylabel(ax6, 'Elevation, [ft]', 'FontSize', 16);
title(ax6, 'C-08XP')
grid(ax6, 'minor'); box(ax6, 'on');

% C-09P plot: res =========================================================

ax7 = nexttile(t, 15); % next tiles in second row
plot(c09p.cpt_res, c09p.cpt_elv, 'k')
yline(c09p.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
yline([10, -2.5], 'LineWidth', 1.5, 'Color', 'k', 'LineStyle','-.')
ax7.YLim = [-60 60];
ax7.XLim = [0 100];
ax7.FontName = 'Times New Roman';
ax7.FontSize = 14;
xlabel(ax7, 'Res, [ohm-m]', 'FontSize', 16);
ylabel(ax7, 'Elevation, [ft]', 'FontSize', 16);
title(ax7, 'C-09P')
grid(ax7, 'minor'); box(ax7, 'on');

