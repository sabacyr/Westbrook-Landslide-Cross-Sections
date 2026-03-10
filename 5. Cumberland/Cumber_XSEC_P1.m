% DRAWS CROSS SECTIONS BASED ON ELEVATION. X SPACING IS USER DEFINED IN
% ARCGIS. MUST RUN Puritan_XSEC_DataProcess.m FIRST

%% INPUT PROCESSED DATA 
clear all; close all; clc;

load("CumberAllData.mat")

%% RESISTIVITY AND WATER ZONES

reszones.dropx = [c01c.surf_dist(6), c02xc.surf_dist(66), ...
                  c10c.surf_dist(142), (c09xc.surf_dist(177) + c09xc.surf_dist(178))/2, ...
                  c08c.surf_dist(227), (c07c.surf_dist(265) + c07c.surf_dist(266))/2, ...
                  c06xc.surf_dist(297)];
reszones.dropy = [65, -30, -34, -24, -25, -15, -15];

reszones.smoothdecx = [c01c.surf_dist(6), c02xc.surf_dist(66), ...
                  c10c.surf_dist(142), (c09xc.surf_dist(177) + c09xc.surf_dist(178))/2, ...
                  c08c.surf_dist(227), (c07c.surf_dist(265) + c07c.surf_dist(266))/2, ...
                  c06xc.surf_dist(297)];
reszones.smoothdecy = [65, -20, -24, -13, -12, -5, -5];

reszones.notsmoothdecx = [c01c.surf_dist(6), c02xc.surf_dist(66), ...
                  c10c.surf_dist(142), (c09xc.surf_dist(177) + c09xc.surf_dist(178))/2, ...
                  c08c.surf_dist(227), (c07c.surf_dist(265) + c07c.surf_dist(266))/2, ...
                  c06xc.surf_dist(297)];
reszones.notsmoothdecy = [65, -12, -12, -2, -5, -5, -5];

reszones.variablelowqcx = [c01c.surf_dist(6), c02xc.surf_dist(66), ...
                  c10c.surf_dist(142), (c09xc.surf_dist(177) + c09xc.surf_dist(178))/2, ...
                  c08c.surf_dist(227), (c07c.surf_dist(265) + c07c.surf_dist(266))/2, ...
                  c06xc.surf_dist(297)];
reszones.variablelowqcy = [65, 20, 10, -2, -5, -5, -5];

waterzones.x = [c01c.surf_dist(6), c02xc.surf_dist(66), ...
                  c10c.surf_dist(142), (c09xc.surf_dist(177) + c09xc.surf_dist(178))/2, ...
                  c08c.surf_dist(227), (c07c.surf_dist(265) + c07c.surf_dist(266))/2, ...
                  c06xc.surf_dist(297), ...
                  3090, 3140];

waterzones.y = [c01c.cpt_water,  c02xc.cpt_water, ...
               c10c.cpt_water, c09xc.cpt_water,  ...
               c08c.cpt_water, c07c.cpt_water,  ...
               c06xc.cpt_water,  ...
               15.7624, 15.748];

slipsurf.x = [210, 270, 300, 650, 1410, 1765, 2260, 2685, 2960, 3090];
slipsurf.y = [78.49, 55.72, 45, 20, 10, -2, -5, -5, -5, -5];

presurf.x = [210, 3050, 3090];
presurf.y = [78.49, 78.49, 15.76];

%% GENERATE FIGURE: CROSS SECTION AND SU AND RES

close all
fig1 = figure('Color','w', 'Position',[1921,49,1920,955]);
t = tiledlayout(fig1, 2, 8, 'TileSpacing', 'compact', 'Padding', 'compact');
ax1 = nexttile(t, [1 8]); % spans 1 row and 3 columns

% Plot surface ============================================================

plot(ax1, c01c.surf_dist, c01c.surf_elv, 'LineWidth', 2, 'Color', [0 0 0 1])
hold(ax1, 'on')

% Plot CPT stick ==========================================================

patch(ax1, 'XData', c01c.cpt_stickx, 'YData', c01c.cpt_sticky, 'FaceColor', 'w');
patch(ax1, 'XData', c02xc.cpt_stickx, 'YData', c02xc.cpt_sticky, 'FaceColor', 'w');
patch(ax1, 'XData', c10c.cpt_stickx, 'YData', c10c.cpt_sticky, 'FaceColor', 'w');
patch(ax1, 'XData', c09xc.cpt_stickx, 'YData', c09xc.cpt_sticky, 'FaceColor', 'w');
patch(ax1, 'XData', c08c.cpt_stickx, 'YData', c08c.cpt_sticky, 'FaceColor', 'w');
patch(ax1, 'XData', c07c.cpt_stickx, 'YData', c07c.cpt_sticky, 'FaceColor', 'w');
patch(ax1, 'XData', c06xc.cpt_stickx, 'YData', c06xc.cpt_sticky, 'FaceColor', 'w');

% Plot Water in CPT ==============================================================

plot(ax1, [c01c.cpt_stickx(1), c01c.cpt_stickx(end)], [c01c.cpt_water, c01c.cpt_water], 'LineWidth', 2, 'Color', 'b')
plot(ax1, [c02xc.cpt_stickx(1), c02xc.cpt_stickx(end)], [c02xc.cpt_water, c02xc.cpt_water], 'LineWidth', 2, 'Color', 'b')
plot(ax1, [c10c.cpt_stickx(1), c10c.cpt_stickx(end)], [c10c.cpt_water, c10c.cpt_water], 'LineWidth', 2, 'Color', 'b')
plot(ax1, [c09xc.cpt_stickx(1), c09xc.cpt_stickx(end)], [c09xc.cpt_water, c09xc.cpt_water], 'LineWidth', 2, 'Color', 'b')
plot(ax1, [c08c.cpt_stickx(1), c08c.cpt_stickx(end)], [c08c.cpt_water, c08c.cpt_water], 'LineWidth', 2, 'Color', 'b')
plot(ax1, [c07c.cpt_stickx(1), c07c.cpt_stickx(end)], [c07c.cpt_water, c07c.cpt_water], 'LineWidth', 2, 'Color', 'b')
plot(ax1, [c06xc.cpt_stickx(1), c06xc.cpt_stickx(end)], [c06xc.cpt_water, c06xc.cpt_water], 'LineWidth', 2, 'Color', 'b')

% Main x-axis: distance along the profile =================================

ax1.YLim = [-90 90];
ax1.XLim = [0 3300];
ax1.FontName = 'Times New Roman';
ax1.FontSize = 14;
xlabel(ax1, 'Distance, [ft]', 'FontSize', 16);
ylabel(ax1, 'Elevation, [ft]', 'FontSize', 16);
title('Cumberland Mill Profile 1-1', 'FontName', 'Times New Roman', 'FontSize', 16);
grid(ax1, 'minor'); box(ax1, 'on');
 
% CPT ID Texts ============================================================
txt = sprintf('C-01C (2 ft S)');
text(30, 85, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring
txt = sprintf('C-02XC (273.9 ft S)');
text(630, 72, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring
txt = sprintf('C-10C (27.57 ft S)');
text(1380, 50, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring
txt = sprintf('C-09XC (38.22 ft S)');
text(1720, 45, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring
txt = sprintf('C-08C (61.10 ft S)');
text(2230, 45, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring
txt = sprintf('C-07C (5.28 ft S)');
text(2610, 40, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring
txt = sprintf('C-06XC (404.37 ft N)');
text(2910, 40, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring

% Plot Boring stick ==========================================================

patch(ax1, 'XData', b02xc.bor_stickx, 'YData', b02xc.bor_sticky, 'FaceColor', 'w');
patch(ax1, 'XData', b09xc.bor_stickx, 'YData', b09xc.bor_sticky, 'FaceColor', 'w');
patch(ax1, 'XData', b06xc.bor_stickx, 'YData', b06xc.bor_sticky, 'FaceColor', 'w');

% B-02XC Soil Class ==========================================================

l1 = patch(ax1, 'XData', b02xc.layer.x1, 'YData', b02xc.layer.y1, 'FaceColor', col.topsoil);
hatchfill2(l1, 'cross', 'LineWidth', 1, 'HatchAngle', 45, 'HatchDensity', 100);
pg1 = polyshape(b02xc.layer.x1, b02xc.layer.y1); [cx1, cy1] = centroid(pg1);
text(ax1, 610, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l2 = patch(ax1, 'XData', b02xc.layer.x2, 'YData', b02xc.layer.y2, 'FaceColor', col.sand);
hatchfill2(l2, 'fill');
pg1 = polyshape(b02xc.layer.x2, b02xc.layer.y2); [cx1, cy1] = centroid(pg1);
text(ax1, 610, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l3 = patch(ax1, 'XData', b02xc.layer.x3, 'YData', b02xc.layer.y3, 'FaceColor', col.sand);
hatchfill2(l3, 'single', 'LineWidth', 1, 'HatchAngle', 45, 'HatchDensity', 100);
pg1 = polyshape(b02xc.layer.x3, b02xc.layer.y3); [cx1, cy1] = centroid(pg1);
text(ax1, 610, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l4 = patch(ax1, 'XData', b02xc.layer.x4, 'YData', b02xc.layer.y4, 'FaceColor', col.clay);
hatchfill2(l4, 'single', 'LineWidth', 1, 'HatchAngle', 90, 'HatchDensity', 500);
pg1 = polyshape(b02xc.layer.x4, b02xc.layer.y4); [cx1, cy1] = centroid(pg1);
text(ax1, 610, cy1, '> 0.5', 'Rotation', 0, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l5 = patch(ax1, 'XData', b02xc.layer.x5, 'YData', b02xc.layer.y5, 'FaceColor', col.sand);
hatchfill2(l5, 'single', 'LineWidth', 1, 'HatchAngle', 45, 'HatchDensity', 100);
pg1 = polyshape(b02xc.layer.x5, b02xc.layer.y5); [cx1, cy1] = centroid(pg1);
text(ax1, 610, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l6 = patch(ax1, 'XData', b02xc.layer.x6, 'YData', b02xc.layer.y6, 'FaceColor', col.clay);
hatchfill2(l6, 'fill');
pg1 = polyshape(b02xc.layer.x6, b02xc.layer.y6); [cx1, cy1] = centroid(pg1);
text(ax1, 610, cy1, '0.16-0.2', 'Rotation', 0, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

% B-09XC Soil Class ==========================================================

l1 = patch(ax1, 'XData', b09xc.layer.x1, 'YData', b09xc.layer.y1, 'FaceColor', col.topsoil);
hatchfill2(l1, 'cross', 'LineWidth', 1, 'HatchAngle', 45, 'HatchDensity', 100);
pg1 = polyshape(b09xc.layer.x1, b09xc.layer.y1); [cx1, cy1] = centroid(pg1);
text(ax1, 1810, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l2 = patch(ax1, 'XData', b09xc.layer.x2, 'YData', b09xc.layer.y2, 'FaceColor', col.sand);
hatchfill2(l2, 'fill');
pg1 = polyshape(b09xc.layer.x2, b09xc.layer.y2); [cx1, cy1] = centroid(pg1);
text(ax1, 1810, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l3 = patch(ax1, 'XData', b09xc.layer.x3, 'YData', b09xc.layer.y3, 'FaceColor', col.sand);
hatchfill2(l3, 'single', 'LineWidth', 1, 'HatchAngle', 45, 'HatchDensity', 100);
pg1 = polyshape(b09xc.layer.x3, b09xc.layer.y3); [cx1, cy1] = centroid(pg1);
text(ax1, 1810, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l4 = patch(ax1, 'XData', b09xc.layer.x4, 'YData', b09xc.layer.y4, 'FaceColor', col.clay);
hatchfill2(l4, 'fill');
pg1 = polyshape(b09xc.layer.x4, b09xc.layer.y4); [cx1, cy1] = centroid(pg1);
text(ax1, 1810, cy1, '> 0.5', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l5 = patch(ax1, 'XData', b09xc.layer.x5, 'YData', b09xc.layer.y5, 'FaceColor', col.clay);
hatchfill2(l5, 'single', 'LineWidth', 1, 'HatchAngle', 90, 'HatchDensity', 500);
pg1 = polyshape(b09xc.layer.x5, b09xc.layer.y5); [cx1, cy1] = centroid(pg1);
text(ax1, 1810, cy1, '0.28-0.5', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l6 = patch(ax1, 'XData', b09xc.layer.x6, 'YData', b09xc.layer.y6, 'FaceColor', col.clay);
hatchfill2(l6, 'fill');
pg1 = polyshape(b09xc.layer.x6, b09xc.layer.y6); [cx1, cy1] = centroid(pg1);
text(ax1, 1810, cy1, '0.28-0.5', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l7 = patch(ax1, 'XData', b09xc.layer.x7, 'YData', b09xc.layer.y7, 'FaceColor', col.clay);
hatchfill2(l7, 'single', 'LineWidth', 1, 'HatchAngle', 90, 'HatchDensity', 500);
pg1 = polyshape(b09xc.layer.x7, b09xc.layer.y7); [cx1, cy1] = centroid(pg1);
text(ax1, 1810, cy1, '0.22-0.5', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l8 = patch(ax1, 'XData', b09xc.layer.x8, 'YData', b09xc.layer.y8, 'FaceColor', col.clay);
hatchfill2(l8, 'fill');
pg1 = polyshape(b09xc.layer.x8, b09xc.layer.y8); [cx1, cy1] = centroid(pg1);
text(ax1, 1810, cy1, '> 0.5', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l9 = patch(ax1, 'XData', b09xc.layer.x9, 'YData', b09xc.layer.y9, 'FaceColor', col.sand);
hatchfill2(l9, 'fill');
pg1 = polyshape(b09xc.layer.x9, b09xc.layer.y9); [cx1, cy1] = centroid(pg1);
text(ax1, 1810, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l10 = patch(ax1, 'XData', b09xc.layer.x10, 'YData', b09xc.layer.y10, 'FaceColor', col.clay);
hatchfill2(l10, 'fill');
pg1 = polyshape(b09xc.layer.x10, b09xc.layer.y10); [cx1, cy1] = centroid(pg1);
text(ax1, 1810, cy1, '0.26', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l11 = patch(ax1, 'XData', b09xc.layer.x11, 'YData', b09xc.layer.y11, 'FaceColor', col.clay);
hatchfill2(l11, 'fill');
pg1 = polyshape(b09xc.layer.x11, b09xc.layer.y11); [cx1, cy1] = centroid(pg1);
text(ax1, 1810, cy1, '0.22-0.26', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l12 = patch(ax1, 'XData', b09xc.layer.x12, 'YData', b09xc.layer.y12, 'FaceColor', col.clay);
hatchfill2(l12, 'fill');
pg1 = polyshape(b09xc.layer.x12, b09xc.layer.y12); [cx1, cy1] = centroid(pg1);
text(ax1, 1810, cy1, '0.22-0.24', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

% B-06XC Soil Class ==========================================================

l1 = patch(ax1, 'XData', b06xc.layer.x1, 'YData', b06xc.layer.y1, 'FaceColor', col.sand);
hatchfill2(l1, 'fill');
pg1 = polyshape(b06xc.layer.x1, b06xc.layer.y1); [cx1, cy1] = centroid(pg1);
text(ax1, 3005, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l2 = patch(ax1, 'XData', b06xc.layer.x2, 'YData', b06xc.layer.y2, 'FaceColor', col.clay);
hatchfill2(l2, 'single', 'LineWidth', 1, 'HatchAngle', 90, 'HatchDensity', 500);
pg1 = polyshape(b06xc.layer.x2, b06xc.layer.y2); [cx1, cy1] = centroid(pg1);
text(ax1, 3005, cy1, '> 0.5', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l3 = patch(ax1, 'XData', b06xc.layer.x3, 'YData', b06xc.layer.y3, 'FaceColor', col.sand);
hatchfill2(l3, 'single', 'LineWidth', 1, 'HatchAngle', 45, 'HatchDensity', 100);
pg1 = polyshape(b06xc.layer.x3, b06xc.layer.y3); [cx1, cy1] = centroid(pg1);
text(ax1, 3005, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l4 = patch(ax1, 'XData', b06xc.layer.x4, 'YData', b06xc.layer.y4, 'FaceColor', col.sand);
hatchfill2(l4, 'fill');
pg1 = polyshape(b06xc.layer.x4, b06xc.layer.y4); [cx1, cy1] = centroid(pg1);
text(ax1, 3005, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l5 = patch(ax1, 'XData', b06xc.layer.x5, 'YData', b06xc.layer.y5, 'FaceColor', col.clay);
hatchfill2(l5, 'fill');
pg1 = polyshape(b06xc.layer.x5, b06xc.layer.y5); [cx1, cy1] = centroid(pg1);
text(ax1, 3005, cy1, '0.18-0.22', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

% Plot Water in boring ==============================================================

plot(ax1, [b02xc.bor_stickx(1), b02xc.bor_stickx(end)], [b02xc.bor_water, b02xc.bor_water], 'LineWidth', 2, 'Color', 'b')
plot(ax1, [b09xc.bor_stickx(1), b09xc.bor_stickx(end)], [b09xc.bor_water, b09xc.bor_water], 'LineWidth', 2, 'Color', 'b')
plot(ax1, [b06xc.bor_stickx(1), b06xc.bor_stickx(end)], [b06xc.bor_water, b06xc.bor_water], 'LineWidth', 2, 'Color', 'b')

% Plot shelby tube samples ================================================

% B02XC
x = [b02xc.bor_stickx(1), b02xc.bor_stickx(end)];
plot(ax1, x, [b02xc.samples(1), b02xc.samples(1)], 'LineWidth', 2, 'Color', 'g')
plot(ax1, x, [b02xc.samples(2), b02xc.samples(2)], 'LineWidth', 2, 'Color', 'g')
plot(ax1, x, [b02xc.samples(3), b02xc.samples(3)], 'LineWidth', 2, 'Color', 'g')
plot(ax1, x, [b02xc.samples(4), b02xc.samples(4)], 'LineWidth', 2, 'Color', 'g')

% B09XC
x = [b09xc.bor_stickx(1), b09xc.bor_stickx(end)];
plot(ax1, x, [b09xc.samples(1), b09xc.samples(1)], 'LineWidth', 2, 'Color', 'g')
plot(ax1, x, [b09xc.samples(2), b09xc.samples(2)], 'LineWidth', 2, 'Color', 'g')
plot(ax1, x, [b09xc.samples(3), b09xc.samples(3)], 'LineWidth', 2, 'Color', 'g')
plot(ax1, x, [b09xc.samples(4), b09xc.samples(4)], 'LineWidth', 2, 'Color', 'g')

% B06XC
x = [b06xc.bor_stickx(1), b06xc.bor_stickx(end)];
plot(ax1, x, [b06xc.samples(1), b06xc.samples(1)], 'LineWidth', 2, 'Color', 'g')
plot(ax1, x, [b06xc.samples(2), b06xc.samples(2)], 'LineWidth', 2, 'Color', 'g')
plot(ax1, x, [b06xc.samples(3), b06xc.samples(3)], 'LineWidth', 2, 'Color', 'g')

% Boring ID Texts ============================================================
txt = sprintf('B-02XC (273.75 ft S)');
text(590, 82, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring
txt = sprintf('B-09XC (31.80 ft S)');
text(1770, 55, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring
txt = sprintf('B-06XC (403.96 ft N)');
text(2950, 50, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring

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
legend(ax1, 'Current Surface', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '',  ...
    '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '' , '', '', '', '', '', '', '', '', ...
    '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '',  ...
    '', '', '', 'Slip Surface', 'Previous Surface', 'Water', 'Location', 'southwest')

% C-01C plot: su =========================================================

ax2 = nexttile(t, 9); % next tiles in second row
plot(c01c.cpt_su, c01c.cpt_elv, 'k')
yline(c01c.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
yline(65, 'LineWidth', 1.5, 'LineStyle', '-.', 'Color', 'k')
ax2.YLim = [-90 90];
ax2.XLim = [0 2000];
ax2.FontName = 'Times New Roman';
ax2.FontSize = 14;
xlabel(ax2, 's_u, [psf]', 'FontSize', 16);
ylabel(ax2, 'Elevation, [ft]', 'FontSize', 16);
title(ax2, 'C-01C')
grid(ax2, 'minor'); box(ax2, 'on');

% C-02XC plot: su =========================================================

ax3 = nexttile(t, 10); % next tiles in second row
plot(c02xc.cpt_su, c02xc.cpt_elv, 'k')
hold on
yline(c02xc.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
yline([20, -12, -20, -30], 'LineWidth', 1.5, 'LineStyle', '-.', 'Color', 'k')
yline(20, 'LineWidth', 1.5, 'Color', 'r', 'LineStyle','--')
scatter(b02xc.mdotsu.peakx, b02xc.mdotsu.peaky, 15, 'filled', 'Marker', 'o', 'MarkerEdgeColor','m', 'MarkerFaceColor','m')
scatter(b02xc.mdotsu.remoldedx, b02xc.mdotsu.remoldedy, 15, 'Marker', 'o', 'MarkerEdgeColor', 'm', 'LineWidth', 1, 'MarkerFaceColor', 'w')
scatter(b02xc.gzasu.peakx, b02xc.gzasu.peaky, 15, 'filled', 'Marker', 's', 'MarkerEdgeColor',[1 0.5 0], 'MarkerFaceColor',[1 0.5 0])
scatter(b02xc.gzasu.remoldedx, b02xc.gzasu.remoldedy, 15, 'Marker', 's', 'MarkerEdgeColor', [1 0.5 0], 'LineWidth', 1, 'MarkerFaceColor', 'w')
ax3.YLim = [-90 90];
ax3.XLim = [0 2000];
ax3.FontName = 'Times New Roman';
ax3.FontSize = 14;
xlabel(ax3, 's_u, [psf]', 'FontSize', 16);
ylabel(ax3, 'Elevation, [ft]', 'FontSize', 16);
title(ax3, 'C-02XC')
grid(ax3, 'minor'); box(ax3, 'on');

% C-10C plot: su =========================================================

ax4 = nexttile(t, 11); % next tiles in second row
plot(c10c.cpt_su, c10c.cpt_elv, 'k')
yline(c10c.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
yline([10, -12, -24, -34], 'LineWidth', 1.5, 'LineStyle', '-.', 'Color', 'k')
yline(10, 'LineWidth', 1.5, 'Color', 'r', 'LineStyle','--')
ax4.YLim = [-90 90];
ax4.XLim = [0 2000];
ax4.FontName = 'Times New Roman';
ax4.FontSize = 14;
xlabel(ax4, 's_u, [psf]', 'FontSize', 16);
ylabel(ax4, 'Elevation, [ft]', 'FontSize', 16);
title(ax4, 'C-10C')
grid(ax4, 'minor'); box(ax4, 'on');

% C-09XC plot: su =========================================================

ax5 = nexttile(t, 12); % next tiles in second row
plot(c09xc.cpt_su, c09xc.cpt_elv, 'k')
hold on
yline(c09xc.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
yline([-2, -13, -24], 'LineWidth', 1.5, 'LineStyle', '-.', 'Color', 'k')
yline(-2, 'LineWidth', 1.5, 'Color', 'r', 'LineStyle','--')
scatter(b09xc.mdotsu.peakx, b09xc.mdotsu.peaky, 15, 'filled', 'Marker', 'o', 'MarkerEdgeColor','m', 'MarkerFaceColor','m')
scatter(b09xc.mdotsu.remoldedx, b09xc.mdotsu.remoldedy, 15, 'Marker', 'o', 'MarkerEdgeColor', 'm', 'LineWidth', 1, 'MarkerFaceColor', 'w')
scatter(b09xc.gzasu.peakx, b09xc.gzasu.peaky, 15, 'filled', 'Marker', 's', 'MarkerEdgeColor',[1 0.5 0], 'MarkerFaceColor',[1 0.5 0])
scatter(b09xc.gzasu.remoldedx, b09xc.gzasu.remoldedy, 15, 'Marker', 's', 'MarkerEdgeColor', [1 0.5 0], 'LineWidth', 1, 'MarkerFaceColor', 'w')
ax5.YLim = [-90 90];
ax5.XLim = [0 2000];
ax5.FontName = 'Times New Roman';
ax5.FontSize = 14;
xlabel(ax5, 's_u, [psf]', 'FontSize', 16);
ylabel(ax5, 'Elevation, [ft]', 'FontSize', 16);
title(ax5, 'C-09XC')
grid(ax5, 'minor'); box(ax5, 'on');

% C-01C plot: res =========================================================

ax6 = nexttile(t, 13); % next tiles in second row
plot(c01c.cpt_res, c01c.cpt_elv, 'k')
yline(c01c.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
yline(65, 'LineWidth', 1.5, 'LineStyle', '-.', 'Color', 'k')
ax6.YLim = [-90 90];
ax6.XLim = [0 100];
ax6.FontName = 'Times New Roman';
ax6.FontSize = 14;
xlabel(ax6, 'Res, [ohm-m]', 'FontSize', 16);
ylabel(ax6, 'Elevation, [ft]', 'FontSize', 16);
title(ax6, 'C-01C')
grid(ax6, 'minor'); box(ax6, 'on');

% C-02XC plot: res =========================================================

ax7 = nexttile(t, 14); % next tiles in second row
plot(c02xc.cpt_res, c02xc.cpt_elv, 'k')
yline(c02xc.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
yline([20, -12, -20, -30], 'LineWidth', 1.5, 'LineStyle', '-.', 'Color', 'k')
yline(20, 'LineWidth', 1.5, 'Color', 'r', 'LineStyle','--')
ax7.YLim = [-90 90];
ax7.XLim = [0 100];
ax7.FontName = 'Times New Roman';
ax7.FontSize = 14;
xlabel(ax7, 'Res, [ohm-m]', 'FontSize', 16);
ylabel(ax7, 'Elevation, [ft]', 'FontSize', 16);
title(ax7, 'C-02XC')
grid(ax7, 'minor'); box(ax7, 'on');

% C-10C plot: res =========================================================

ax8 = nexttile(t, 15); % next tiles in second row
plot(c10c.cpt_res, c10c.cpt_elv, 'k')
yline(c10c.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
yline([10, -12, -24, -34], 'LineWidth', 1.5, 'LineStyle', '-.', 'Color', 'k')
yline(10, 'LineWidth', 1.5, 'Color', 'r', 'LineStyle','--')
ax8.YLim = [-90 90];
ax8.XLim = [0 100];
ax8.FontName = 'Times New Roman';
ax8.FontSize = 14;
xlabel(ax8, 'Res, [ohm-m]', 'FontSize', 16);
ylabel(ax8, 'Elevation, [ft]', 'FontSize', 16);
title(ax8, 'C-10C')
grid(ax8, 'minor'); box(ax8, 'on');

% C-09XC plot: res =========================================================

ax9 = nexttile(t, 16); % next tiles in second row
plot(c09xc.cpt_res, c09xc.cpt_elv, 'k')
yline(c09xc.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
yline([-2, -13, -24], 'LineWidth', 1.5, 'LineStyle', '-.', 'Color', 'k')
yline(-2, 'LineWidth', 1.5, 'Color', 'r', 'LineStyle','--')
ax9.YLim = [-90 90];
ax9.XLim = [0 100];
ax9.FontName = 'Times New Roman';
ax9.FontSize = 14;
xlabel(ax9, 'Res, [ohm-m]', 'FontSize', 16);
ylabel(ax9, 'Elevation, [ft]', 'FontSize', 16);
title(ax9, 'C-09XC')
grid(ax9, 'minor'); box(ax9, 'on');


%% ANOTHER PLOT ON THE SAME PROFILE FOR THE REST OF THE DATASET

fig2 = figure('Color','w', 'Position',[1921,49,1920,955]);
t = tiledlayout(fig2, 2, 8, 'TileSpacing', 'compact', 'Padding', 'compact');
ax1 = nexttile(t, [1 8]); % spans 1 row and 3 columns

% Plot surface ============================================================

plot(ax1, c01c.surf_dist, c01c.surf_elv, 'LineWidth', 2, 'Color', [0 0 0 1])
hold(ax1, 'on')
% plot(ax1, crosssec_surf(:, 2), crosssec_surf(:, 1), 'LineWidth', 2, 'Color', [0 0 0 0.1])

% Plot CPT stick ==========================================================

patch(ax1, 'XData', c01c.cpt_stickx, 'YData', c01c.cpt_sticky, 'FaceColor', 'w');
patch(ax1, 'XData', c02xc.cpt_stickx, 'YData', c02xc.cpt_sticky, 'FaceColor', 'w');
patch(ax1, 'XData', c10c.cpt_stickx, 'YData', c10c.cpt_sticky, 'FaceColor', 'w');
patch(ax1, 'XData', c09xc.cpt_stickx, 'YData', c09xc.cpt_sticky, 'FaceColor', 'w');
patch(ax1, 'XData', c08c.cpt_stickx, 'YData', c08c.cpt_sticky, 'FaceColor', 'w');
patch(ax1, 'XData', c07c.cpt_stickx, 'YData', c07c.cpt_sticky, 'FaceColor', 'w');
patch(ax1, 'XData', c06xc.cpt_stickx, 'YData', c06xc.cpt_sticky, 'FaceColor', 'w');

% Plot Water in CPT ==============================================================

plot(ax1, [c01c.cpt_stickx(1), c01c.cpt_stickx(end)], [c01c.cpt_water, c01c.cpt_water], 'LineWidth', 2, 'Color', 'b')
plot(ax1, [c02xc.cpt_stickx(1), c02xc.cpt_stickx(end)], [c02xc.cpt_water, c02xc.cpt_water], 'LineWidth', 2, 'Color', 'b')
plot(ax1, [c10c.cpt_stickx(1), c10c.cpt_stickx(end)], [c10c.cpt_water, c10c.cpt_water], 'LineWidth', 2, 'Color', 'b')
plot(ax1, [c09xc.cpt_stickx(1), c09xc.cpt_stickx(end)], [c09xc.cpt_water, c09xc.cpt_water], 'LineWidth', 2, 'Color', 'b')
plot(ax1, [c08c.cpt_stickx(1), c08c.cpt_stickx(end)], [c08c.cpt_water, c08c.cpt_water], 'LineWidth', 2, 'Color', 'b')
plot(ax1, [c07c.cpt_stickx(1), c07c.cpt_stickx(end)], [c07c.cpt_water, c07c.cpt_water], 'LineWidth', 2, 'Color', 'b')
plot(ax1, [c06xc.cpt_stickx(1), c06xc.cpt_stickx(end)], [c06xc.cpt_water, c06xc.cpt_water], 'LineWidth', 2, 'Color', 'b')

% Main x-axis: distance along the profile =================================

ax1.YLim = [-90 90];
ax1.XLim = [0 3300];
ax1.FontName = 'Times New Roman';
ax1.FontSize = 14;
xlabel(ax1, 'Distance, [ft]', 'FontSize', 16);
ylabel(ax1, 'Elevation, [ft]', 'FontSize', 16);
title('Cumberland Mill Profile 1-2', 'FontName', 'Times New Roman', 'FontSize', 16);
grid(ax1, 'minor'); box(ax1, 'on');
 
% CPT ID Texts ============================================================
txt = sprintf('C-01C (2 ft S)');
text(30, 85, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring
txt = sprintf('C-02XC (273.9 ft S)');
text(630, 72, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring
txt = sprintf('C-10C (27.57 ft S)');
text(1380, 50, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring
txt = sprintf('C-09XC (38.22 ft S)');
text(1720, 45, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring
txt = sprintf('C-08C (61.10 ft S)');
text(2230, 45, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring
txt = sprintf('C-07C (5.28 ft S)');
text(2610, 40, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring
txt = sprintf('C-06XC (404.37 ft N)');
text(2910, 40, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring

% Plot Boring stick ==========================================================

patch(ax1, 'XData', b02xc.bor_stickx, 'YData', b02xc.bor_sticky, 'FaceColor', 'w');
patch(ax1, 'XData', b09xc.bor_stickx, 'YData', b09xc.bor_sticky, 'FaceColor', 'w');
patch(ax1, 'XData', b06xc.bor_stickx, 'YData', b06xc.bor_sticky, 'FaceColor', 'w');

% B-02XC Soil Class ==========================================================

l1 = patch(ax1, 'XData', b02xc.layer.x1, 'YData', b02xc.layer.y1, 'FaceColor', col.topsoil);
hatchfill2(l1, 'cross', 'LineWidth', 1, 'HatchAngle', 45, 'HatchDensity', 100);
pg1 = polyshape(b02xc.layer.x1, b02xc.layer.y1); [cx1, cy1] = centroid(pg1);
text(ax1, 610, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l2 = patch(ax1, 'XData', b02xc.layer.x2, 'YData', b02xc.layer.y2, 'FaceColor', col.sand);
hatchfill2(l2, 'fill');
pg1 = polyshape(b02xc.layer.x2, b02xc.layer.y2); [cx1, cy1] = centroid(pg1);
text(ax1, 610, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l3 = patch(ax1, 'XData', b02xc.layer.x3, 'YData', b02xc.layer.y3, 'FaceColor', col.sand);
hatchfill2(l3, 'single', 'LineWidth', 1, 'HatchAngle', 45, 'HatchDensity', 100);
pg1 = polyshape(b02xc.layer.x3, b02xc.layer.y3); [cx1, cy1] = centroid(pg1);
text(ax1, 610, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l4 = patch(ax1, 'XData', b02xc.layer.x4, 'YData', b02xc.layer.y4, 'FaceColor', col.clay);
hatchfill2(l4, 'single', 'LineWidth', 1, 'HatchAngle', 90, 'HatchDensity', 500);
pg1 = polyshape(b02xc.layer.x4, b02xc.layer.y4); [cx1, cy1] = centroid(pg1);
text(ax1, 610, cy1, '> 0.5', 'Rotation', 0, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l5 = patch(ax1, 'XData', b02xc.layer.x5, 'YData', b02xc.layer.y5, 'FaceColor', col.sand);
hatchfill2(l5, 'single', 'LineWidth', 1, 'HatchAngle', 45, 'HatchDensity', 100);
pg1 = polyshape(b02xc.layer.x5, b02xc.layer.y5); [cx1, cy1] = centroid(pg1);
text(ax1, 610, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l6 = patch(ax1, 'XData', b02xc.layer.x6, 'YData', b02xc.layer.y6, 'FaceColor', col.clay);
hatchfill2(l6, 'fill');
pg1 = polyshape(b02xc.layer.x6, b02xc.layer.y6); [cx1, cy1] = centroid(pg1);
text(ax1, 610, cy1, '0.16-0.2', 'Rotation', 0, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

% B-09XC Soil Class ==========================================================

l1 = patch(ax1, 'XData', b09xc.layer.x1, 'YData', b09xc.layer.y1, 'FaceColor', col.topsoil);
hatchfill2(l1, 'cross', 'LineWidth', 1, 'HatchAngle', 45, 'HatchDensity', 100);
pg1 = polyshape(b09xc.layer.x1, b09xc.layer.y1); [cx1, cy1] = centroid(pg1);
text(ax1, 1810, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l2 = patch(ax1, 'XData', b09xc.layer.x2, 'YData', b09xc.layer.y2, 'FaceColor', col.sand);
hatchfill2(l2, 'fill');
pg1 = polyshape(b09xc.layer.x2, b09xc.layer.y2); [cx1, cy1] = centroid(pg1);
text(ax1, 1810, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l3 = patch(ax1, 'XData', b09xc.layer.x3, 'YData', b09xc.layer.y3, 'FaceColor', col.sand);
hatchfill2(l3, 'single', 'LineWidth', 1, 'HatchAngle', 45, 'HatchDensity', 100);
pg1 = polyshape(b09xc.layer.x3, b09xc.layer.y3); [cx1, cy1] = centroid(pg1);
text(ax1, 1810, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l4 = patch(ax1, 'XData', b09xc.layer.x4, 'YData', b09xc.layer.y4, 'FaceColor', col.clay);
hatchfill2(l4, 'fill');
pg1 = polyshape(b09xc.layer.x4, b09xc.layer.y4); [cx1, cy1] = centroid(pg1);
text(ax1, 1810, cy1, '> 0.5', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l5 = patch(ax1, 'XData', b09xc.layer.x5, 'YData', b09xc.layer.y5, 'FaceColor', col.clay);
hatchfill2(l5, 'single', 'LineWidth', 1, 'HatchAngle', 90, 'HatchDensity', 500);
pg1 = polyshape(b09xc.layer.x5, b09xc.layer.y5); [cx1, cy1] = centroid(pg1);
text(ax1, 1810, cy1, '0.28-0.5', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l6 = patch(ax1, 'XData', b09xc.layer.x6, 'YData', b09xc.layer.y6, 'FaceColor', col.clay);
hatchfill2(l6, 'fill');
pg1 = polyshape(b09xc.layer.x6, b09xc.layer.y6); [cx1, cy1] = centroid(pg1);
text(ax1, 1810, cy1, '0.28-0.5', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l7 = patch(ax1, 'XData', b09xc.layer.x7, 'YData', b09xc.layer.y7, 'FaceColor', col.clay);
hatchfill2(l7, 'single', 'LineWidth', 1, 'HatchAngle', 90, 'HatchDensity', 500);
pg1 = polyshape(b09xc.layer.x7, b09xc.layer.y7); [cx1, cy1] = centroid(pg1);
text(ax1, 1810, cy1, '0.22-0.5', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l8 = patch(ax1, 'XData', b09xc.layer.x8, 'YData', b09xc.layer.y8, 'FaceColor', col.clay);
hatchfill2(l8, 'fill');
pg1 = polyshape(b09xc.layer.x8, b09xc.layer.y8); [cx1, cy1] = centroid(pg1);
text(ax1, 1810, cy1, '> 0.5', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l9 = patch(ax1, 'XData', b09xc.layer.x9, 'YData', b09xc.layer.y9, 'FaceColor', col.sand);
hatchfill2(l9, 'fill');
pg1 = polyshape(b09xc.layer.x9, b09xc.layer.y9); [cx1, cy1] = centroid(pg1);
text(ax1, 1810, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l10 = patch(ax1, 'XData', b09xc.layer.x10, 'YData', b09xc.layer.y10, 'FaceColor', col.clay);
hatchfill2(l10, 'fill');
pg1 = polyshape(b09xc.layer.x10, b09xc.layer.y10); [cx1, cy1] = centroid(pg1);
text(ax1, 1810, cy1, '0.26', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l11 = patch(ax1, 'XData', b09xc.layer.x11, 'YData', b09xc.layer.y11, 'FaceColor', col.clay);
hatchfill2(l11, 'fill');
pg1 = polyshape(b09xc.layer.x11, b09xc.layer.y11); [cx1, cy1] = centroid(pg1);
text(ax1, 1810, cy1, '0.22-0.26', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l12 = patch(ax1, 'XData', b09xc.layer.x12, 'YData', b09xc.layer.y12, 'FaceColor', col.clay);
hatchfill2(l12, 'fill');
pg1 = polyshape(b09xc.layer.x12, b09xc.layer.y12); [cx1, cy1] = centroid(pg1);
text(ax1, 1810, cy1, '0.22-0.24', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

% B-06XC Soil Class ==========================================================

l1 = patch(ax1, 'XData', b06xc.layer.x1, 'YData', b06xc.layer.y1, 'FaceColor', col.sand);
hatchfill2(l1, 'fill');
pg1 = polyshape(b06xc.layer.x1, b06xc.layer.y1); [cx1, cy1] = centroid(pg1);
text(ax1, 3005, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l2 = patch(ax1, 'XData', b06xc.layer.x2, 'YData', b06xc.layer.y2, 'FaceColor', col.clay);
hatchfill2(l2, 'single', 'LineWidth', 1, 'HatchAngle', 90, 'HatchDensity', 500);
pg1 = polyshape(b06xc.layer.x2, b06xc.layer.y2); [cx1, cy1] = centroid(pg1);
text(ax1, 3005, cy1, '> 0.5', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l3 = patch(ax1, 'XData', b06xc.layer.x3, 'YData', b06xc.layer.y3, 'FaceColor', col.sand);
hatchfill2(l3, 'single', 'LineWidth', 1, 'HatchAngle', 45, 'HatchDensity', 100);
pg1 = polyshape(b06xc.layer.x3, b06xc.layer.y3); [cx1, cy1] = centroid(pg1);
text(ax1, 3005, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l4 = patch(ax1, 'XData', b06xc.layer.x4, 'YData', b06xc.layer.y4, 'FaceColor', col.sand);
hatchfill2(l4, 'fill');
pg1 = polyshape(b06xc.layer.x4, b06xc.layer.y4); [cx1, cy1] = centroid(pg1);
text(ax1, 3005, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l5 = patch(ax1, 'XData', b06xc.layer.x5, 'YData', b06xc.layer.y5, 'FaceColor', col.clay);
hatchfill2(l5, 'fill');
pg1 = polyshape(b06xc.layer.x5, b06xc.layer.y5); [cx1, cy1] = centroid(pg1);
text(ax1, 3005, cy1, '0.18-0.22', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

% Plot Water in boring ==============================================================

plot(ax1, [b02xc.bor_stickx(1), b02xc.bor_stickx(end)], [b02xc.bor_water, b02xc.bor_water], 'LineWidth', 2, 'Color', 'b')
plot(ax1, [b09xc.bor_stickx(1), b09xc.bor_stickx(end)], [b09xc.bor_water, b09xc.bor_water], 'LineWidth', 2, 'Color', 'b')
plot(ax1, [b06xc.bor_stickx(1), b06xc.bor_stickx(end)], [b06xc.bor_water, b06xc.bor_water], 'LineWidth', 2, 'Color', 'b')

% Plot shelby tube samples ================================================

% B02XC
x = [b02xc.bor_stickx(1), b02xc.bor_stickx(end)];
plot(ax1, x, [b02xc.samples(1), b02xc.samples(1)], 'LineWidth', 2, 'Color', 'g')
plot(ax1, x, [b02xc.samples(2), b02xc.samples(2)], 'LineWidth', 2, 'Color', 'g')
plot(ax1, x, [b02xc.samples(3), b02xc.samples(3)], 'LineWidth', 2, 'Color', 'g')
plot(ax1, x, [b02xc.samples(4), b02xc.samples(4)], 'LineWidth', 2, 'Color', 'g')

% B09XC
x = [b09xc.bor_stickx(1), b09xc.bor_stickx(end)];
plot(ax1, x, [b09xc.samples(1), b09xc.samples(1)], 'LineWidth', 2, 'Color', 'g')
plot(ax1, x, [b09xc.samples(2), b09xc.samples(2)], 'LineWidth', 2, 'Color', 'g')
plot(ax1, x, [b09xc.samples(3), b09xc.samples(3)], 'LineWidth', 2, 'Color', 'g')
plot(ax1, x, [b09xc.samples(4), b09xc.samples(4)], 'LineWidth', 2, 'Color', 'g')

% B06XC
x = [b06xc.bor_stickx(1), b06xc.bor_stickx(end)];
plot(ax1, x, [b06xc.samples(1), b06xc.samples(1)], 'LineWidth', 2, 'Color', 'g')
plot(ax1, x, [b06xc.samples(2), b06xc.samples(2)], 'LineWidth', 2, 'Color', 'g')
plot(ax1, x, [b06xc.samples(3), b06xc.samples(3)], 'LineWidth', 2, 'Color', 'g')

% Boring ID Texts ============================================================
txt = sprintf('B-02XC (273.75 ft S)');
text(590, 82, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring
txt = sprintf('B-09XC (31.80 ft S)');
text(1770, 55, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring
txt = sprintf('B-06XC (403.96 ft N)');
text(2950, 50, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring

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
legend(ax1, 'Current Surface', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '',  ...
    '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '' , '', '', '', '', '', '', '', '', ...
    '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '',  ...
    '', '', '', 'Slip Surface', 'Previous Surface', 'Water', 'Location', 'southwest')

% C-08C plot: su =========================================================

ax2 = nexttile(t, 10); % next tiles in second row
plot(c08c.cpt_su, c08c.cpt_elv, 'k')
yline(c08c.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
yline([-5, -12, -25], 'LineWidth', 1.5, 'LineStyle', '-.', 'Color', 'k')
yline(-5, 'LineWidth', 1.5, 'Color', 'r', 'LineStyle','--')
ax2.YLim = [-90 90];
ax2.XLim = [0 2000];
ax2.FontName = 'Times New Roman';
ax2.FontSize = 14;
xlabel(ax2, 's_u, [psf]', 'FontSize', 16);
ylabel(ax2, 'Elevation, [ft]', 'FontSize', 16);
title(ax2, 'C-08C')
grid(ax2, 'minor'); box(ax2, 'on');

% C-07C plot: su =========================================================

ax3 = nexttile(t, 11); % next tiles in second row
plot(c07c.cpt_su, c07c.cpt_elv, 'k')
yline(c07c.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
yline([-5, -15], 'LineWidth', 1.5, 'LineStyle', '-.', 'Color', 'k')
yline(-5, 'LineWidth', 1.5, 'Color', 'r', 'LineStyle','--')
ax3.YLim = [-90 90];
ax3.XLim = [0 2000];
ax3.FontName = 'Times New Roman';
ax3.FontSize = 14;
xlabel(ax3, 's_u, [psf]', 'FontSize', 16);
ylabel(ax3, 'Elevation, [ft]', 'FontSize', 16);
title(ax3, 'C-07C')
grid(ax3, 'minor'); box(ax3, 'on');

% C-06XC plot: su =========================================================

ax4 = nexttile(t, 12); % next tiles in second row
plot(c06xc.cpt_su, c06xc.cpt_elv, 'k')
hold on
yline(c06xc.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
yline([-5, -15], 'LineWidth', 1.5, 'LineStyle', '-.', 'Color', 'k')
yline(-5, 'LineWidth', 1.5, 'Color', 'r', 'LineStyle','--')
scatter(b06xc.mdotsu.peakx, b06xc.mdotsu.peaky, 15, 'filled', 'Marker', 'o', 'MarkerEdgeColor','m', 'MarkerFaceColor','m')
scatter(b06xc.mdotsu.remoldedx, b06xc.mdotsu.remoldedy, 15, 'Marker', 'o', 'MarkerEdgeColor', 'm', 'LineWidth', 1, 'MarkerFaceColor', 'w')
ax4.YLim = [-90 90];
ax4.XLim = [0 2000];
ax4.FontName = 'Times New Roman';
ax4.FontSize = 14;
xlabel(ax4, 's_u, [psf]', 'FontSize', 16);
ylabel(ax4, 'Elevation, [ft]', 'FontSize', 16);
title(ax4, 'C-06XC')
grid(ax4, 'minor'); box(ax4, 'on');

% C-08C plot: res =========================================================

ax5 = nexttile(t, 13); % next tiles in second row
plot(c08c.cpt_res, c08c.cpt_elv, 'k')
yline(c08c.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
yline(-5, 'LineWidth', 1.5, 'Color', 'r', 'LineStyle','--')
ax5.YLim = [-90 90];
ax5.XLim = [0 100];
ax5.FontName = 'Times New Roman';
ax5.FontSize = 14;
xlabel(ax5, 'Res [ohm-m]', 'FontSize', 16);
ylabel(ax5, 'Elevation, [ft]', 'FontSize', 16);
title(ax5, 'C-08C')
grid(ax5, 'minor'); box(ax5, 'on');

% C-07C plot: res =========================================================

ax6 = nexttile(t, 14); % next tiles in second row
plot(c07c.cpt_res, c07c.cpt_elv, 'k')
yline(c07c.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
yline(-5, 'LineWidth', 1.5, 'Color', 'r', 'LineStyle','--')
ax6.YLim = [-90 90];
ax6.XLim = [0 100];
ax6.FontName = 'Times New Roman';
ax6.FontSize = 14;
xlabel(ax6, 'Res [ohm-m]', 'FontSize', 16);
ylabel(ax6, 'Elevation, [ft]', 'FontSize', 16);
title(ax6, 'C-07C')
grid(ax6, 'minor'); box(ax6, 'on');

% C-06XC plot: res =========================================================

ax7 = nexttile(t, 15); % next tiles in second row
plot(c06xc.cpt_res, c06xc.cpt_elv, 'k')
yline(c06xc.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
yline(-5, 'LineWidth', 1.5, 'Color', 'r', 'LineStyle','--')
ax7.YLim = [-90 90];
ax7.XLim = [0 100];
ax7.FontName = 'Times New Roman';
ax7.FontSize = 14;
xlabel(ax7, 'Res [ohm-m]', 'FontSize', 16);
ylabel(ax7, 'Elevation, [ft]', 'FontSize', 16);
title(ax7, 'C-06XC')
grid(ax7, 'minor'); box(ax7, 'on');

