% DRAWS CROSS SECTIONS BASED ON ELEVATION. X SPACING IS USER DEFINED IN
% ARCGIS. MUST RUN Puritan_XSEC_DataProcess.m FIRSTbor_stickx

%% INPUT PROCESSED DATA 
close all; clc;

load("PuritanAllData.mat")

%% RESISTIVITY AND WATER ZONES

reszones.dropx = [(c02xp.surf_dist(166) + c02xp.surf_dist(167))/2, ...
                0.95*c04xp.surf_dist(126), 1.1*c05xp.surf_dist(65), c06xp.surf_dist(10)];
reszones.dropy = [0, 12, -18, -30];
reszones.smoothdecx = [(c02xp.surf_dist(166) + c02xp.surf_dist(167))/2, ...
                0.95*c04xp.surf_dist(126), 1.1*c05xp.surf_dist(65), c06xp.surf_dist(10)];
reszones.smoothdecy = [7, 20, -6, -15];
reszones.notsmoothdecx = [(c02xp.surf_dist(166) + c02xp.surf_dist(167))/2, ...
                0.95*c04xp.surf_dist(126), 1.1*c05xp.surf_dist(65), c06xp.surf_dist(10)];
reszones.notsmoothdecy = [17, 40, 30, 20];
reszones.variablelowqcx = [(c02xp.surf_dist(166) + c02xp.surf_dist(167))/2, ...
                0.95*c04xp.surf_dist(126), 1.1*c05xp.surf_dist(65), c06xp.surf_dist(10)];
reszones.variablelowqcy = [20, 50, 40, 28];

waterzones.x = [1900, 1800, (c02xp.surf_dist(166) + c02xp.surf_dist(167))/2, ...
                 0.95*c04xp.surf_dist(126), ...
                 1.1*c05xp.surf_dist(65), ...
                 c06xp.surf_dist(10)];
waterzones.y = [15.06, 15.1, c02xp.cpt_water, ...
                c04xp.cpt_water, c05xp.cpt_water, c06xp.cpt_water];

%% GENERATE FIGURE: CROSS SECTION THROUGH 6P, 5P, 4P, 2P AND SU

close all
fig1 = figure('Color','w', 'Position', [1921,49,1920,955]);
t = tiledlayout(fig1, 2, 8, 'TileSpacing', 'compact', 'Padding', 'compact');
ax1 = nexttile(t, [1 8]); % spans 1 row and 8 columns

% Plot surface ============================================================

plot(ax1, c06xp.surf_dist, c06xp.surf_elv, 'LineWidth', 2, 'Color', [0 0 0 1])
hold(ax1, 'on')

% Plot CPT stick ==========================================================

patch(ax1, 'XData', c06xp.cpt_stickx, 'YData', c06xp.cpt_sticky, 'FaceColor', 'w');
patch(ax1, 'XData', c02xp.cpt_stickx, 'YData', c02xp.cpt_sticky, 'FaceColor', 'w');
patch(ax1, 'XData', c04xp.cpt_stickx, 'YData', c04xp.cpt_sticky, 'FaceColor', 'w');
patch(ax1, 'XData', c05xp.cpt_stickx, 'YData', c05xp.cpt_sticky, 'FaceColor', 'w');

% Plot Water in CPT ==============================================================

plot(ax1, [c06xp.cpt_stickx(1), c06xp.cpt_stickx(end)], [c06xp.cpt_water, c06xp.cpt_water], 'LineWidth', 2, 'Color', 'b')
plot(ax1, [c02xp.cpt_stickx(1), c02xp.cpt_stickx(end)], [c02xp.cpt_water, c02xp.cpt_water], 'LineWidth', 2, 'Color', 'b')
plot(ax1, [c04xp.cpt_stickx(1), c04xp.cpt_stickx(end)], [c04xp.cpt_water, c04xp.cpt_water], 'LineWidth', 2, 'Color', 'b')
plot(ax1, [c05xp.cpt_stickx(1), c05xp.cpt_stickx(end)], [c05xp.cpt_water, c05xp.cpt_water], 'LineWidth', 2, 'Color', 'b')

% Main x-axis: distance along the profile =================================

ax1.YLim = [-90 90];
ax1.XLim = [0 2000];
ax1.FontName = 'Times New Roman';
ax1.FontSize = 14;
xlabel(ax1, 'Distance, [ft]', 'FontSize', 16);
ylabel(ax1, 'Elevation, [ft]', 'FontSize', 16);
title('Puritan Profile 1', 'FontName', 'Times New Roman', 'FontSize', 16);
grid(ax1, 'minor'); box(ax1, 'on');
 
% CPT ID Texts ============================================================
txt = sprintf('C-06XP (31.34 ft S)');
text(50, 55, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring
txt = sprintf('C-05XP (16.5 ft S)');
text(675, 70, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring
txt = sprintf('C-04XP');
text(1160, 65, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring
txt = sprintf('C-02XP (81.25 ft S)');
text(1625, 40, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring

% Plot Boring stick ==========================================================

patch(ax1, 'XData', b06xp.bor_stickx, 'YData', b06xp.bor_sticky, 'FaceColor', 'w');
patch(ax1, 'XData', b02xp.bor_stickx, 'YData', b02xp.bor_sticky, 'FaceColor', 'w');
patch(ax1, 'XData', b04xp.bor_stickx, 'YData', b04xp.bor_sticky, 'FaceColor', 'w');
patch(ax1, 'XData', b05xp.bor_stickx, 'YData', b05xp.bor_sticky, 'FaceColor', 'w');

% B-06XP Soil Class ==========================================================

l1 = patch(ax1, 'XData', b06xp.layer.x1, 'YData', b06xp.layer.y1, 'FaceColor', col.asphalt);
hatchfill2(l1, 'cross', 'LineWidth', 1, 'HatchAngle', 45, 'HatchDensity', 100);
pg1 = polyshape(b06xp.layer.x1, b06xp.layer.y1); [cx1, cy1] = centroid(pg1);
text(ax1, 120, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10, 'Color', 'k');

l2 = patch(ax1, 'XData', b06xp.layer.x2, 'YData', b06xp.layer.y2, 'FaceColor', col.sand);
hatchfill2(l2, 'fill');
pg1 = polyshape(b06xp.layer.x2, b06xp.layer.y2); [cx1, cy1] = centroid(pg1);
text(ax1, 120, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10, 'Color', 'k');

l3 = patch(ax1, 'XData', b06xp.layer.x3, 'YData', b06xp.layer.y3, 'FaceColor', col.clay);
hatchfill2(l3, 'fill');
pg1 = polyshape(b06xp.layer.x3, b06xp.layer.y3); [cx1, cy1] = centroid(pg1);
text(ax1, 120, cy1, '0.35', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10, 'Color', 'k');

l4 = patch(ax1, 'XData', b06xp.layer.x4, 'YData', b06xp.layer.y4, 'FaceColor', col.clay);
hatchfill2(l4, 'fill');
pg1 = polyshape(b06xp.layer.x4, b06xp.layer.y4); [cx1, cy1] = centroid(pg1);
text(ax1, 120, cy1, '0.14-0.2', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10, 'Color', 'k');

% B-05XP Soil Class ==========================================================

l1 = patch(ax1, 'XData', b05xp.layer.x1, 'YData', b05xp.layer.y1, 'FaceColor', col.topsoil);
hatchfill2(l1, 'cross', 'LineWidth', 1, 'HatchAngle', 45, 'HatchDensity', 100);
pg1 = polyshape(b05xp.layer.x1, b05xp.layer.y1); [cx1, cy1] = centroid(pg1);
text(ax1, 615, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10, 'Color', 'k');

l2 = patch(ax1, 'XData', b05xp.layer.x2, 'YData', b05xp.layer.y2, 'FaceColor', col.sand);
hatchfill2(l2, 'single', 'LineWidth', 1, 'HatchAngle', 45, 'HatchDensity', 100);
pg1 = polyshape(b05xp.layer.x2, b05xp.layer.y2); [cx1, cy1] = centroid(pg1);
text(ax1, 615, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10, 'Color', 'k');

l3 = patch(ax1, 'XData', b05xp.layer.x3, 'YData', b05xp.layer.y3, 'FaceColor', col.clay);
hatchfill2(l3, 'single', 'LineWidth', 1, 'HatchAngle', 90, 'HatchDensity', 500);
pg1 = polyshape(b05xp.layer.x3, b05xp.layer.y3); [cx1, cy1] = centroid(pg1);
text(ax1, 615, cy1, '0.22-0.26', 'Rotation', 0, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10, 'Color', 'k');

l4 = patch(ax1, 'XData', b05xp.layer.x4, 'YData', b05xp.layer.y4, 'FaceColor', col.clay);
hatchfill2(l4, 'fill');
pg1 = polyshape(b05xp.layer.x4, b05xp.layer.y4); [cx1, cy1] = centroid(pg1);
text(ax1, 615, cy1, '0.18', 'Rotation', 0, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10, 'Color', 'k');

l5 = patch(ax1, 'XData', b05xp.layer.x5, 'YData', b05xp.layer.y5, 'FaceColor', col.clay);
hatchfill2(l5, 'fill');
pg1 = polyshape(b05xp.layer.x5, b05xp.layer.y5); [cx1, cy1] = centroid(pg1);
text(ax1, 615, cy1, '0.16', 'Rotation', 0, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10, 'Color', 'k');

% B-04XP Soil Class ==========================================================

l1 = patch(ax1, 'XData', b04xp.layer.x1, 'YData', b04xp.layer.y1, 'FaceColor', col.asphalt);
hatchfill2(l1, 'cross', 'LineWidth', 1, 'HatchAngle', 45, 'HatchDensity', 100);
pg1 = polyshape(b04xp.layer.x1, b04xp.layer.y1); [cx1, cy1] = centroid(pg1);
text(ax1, 1270, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10, 'Color', 'k');

l2 = patch(ax1, 'XData', b04xp.layer.x2, 'YData', b04xp.layer.y2, 'FaceColor', col.sand);
hatchfill2(l2, 'fill');
pg1 = polyshape(b04xp.layer.x2, b04xp.layer.y2); [cx1, cy1] = centroid(pg1);
text(ax1, 1270, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l3 = patch(ax1, 'XData', b04xp.layer.x3, 'YData', b04xp.layer.y3, 'FaceColor', col.sand);
hatchfill2(l3, 'single', 'LineWidth', 1, 'HatchAngle', 45, 'HatchDensity', 100);
pg1 = polyshape(b04xp.layer.x3, b04xp.layer.y3); [cx1, cy1] = centroid(pg1);
text(ax1, 1270, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l4 = patch(ax1, 'XData', b04xp.layer.x4, 'YData', b04xp.layer.y4, 'FaceColor', col.clay);
hatchfill2(l4, 'fill');
pg1 = polyshape(b04xp.layer.x4, b04xp.layer.y4); [cx1, cy1] = centroid(pg1);
text(ax1, 1270, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l5 = patch(ax1, 'XData', b04xp.layer.x5, 'YData', b04xp.layer.y5, 'FaceColor', col.sand);
hatchfill2(l5, 'fill');
pg1 = polyshape(b04xp.layer.x5, b04xp.layer.y5); [cx1, cy1] = centroid(pg1);
text(ax1, 1270, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l6 = patch(ax1, 'XData', b04xp.layer.x6, 'YData', b04xp.layer.y6, 'FaceColor', col.clay);
hatchfill2(l6, 'fill');
pg1 = polyshape(b04xp.layer.x6, b04xp.layer.y6); [cx1, cy1] = centroid(pg1);
text(ax1, 1270, cy1, '0.32', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l7 = patch(ax1, 'XData', b04xp.layer.x7, 'YData', b04xp.layer.y7, 'FaceColor', col.clay);
hatchfill2(l7, 'single', 'LineWidth', 1, 'HatchAngle', 90, 'HatchDensity', 500);
pg1 = polyshape(b04xp.layer.x7, b04xp.layer.y7); [cx1, cy1] = centroid(pg1);
text(ax1, 1270, cy1, '0.26', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l8 = patch(ax1, 'XData', b04xp.layer.x8, 'YData', b04xp.layer.y8, 'FaceColor', col.clay);
hatchfill2(l8, 'fill');
pg1 = polyshape(b04xp.layer.x8, b04xp.layer.y8); [cx1, cy1] = centroid(pg1);
text(ax1, 1270, cy1, '0.22', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l9 = patch(ax1, 'XData', b04xp.layer.x9, 'YData', b04xp.layer.y9, 'FaceColor', col.clay);
hatchfill2(l9, 'single', 'LineWidth', 1, 'HatchAngle', 90, 'HatchDensity', 500);
pg1 = polyshape(b04xp.layer.x9, b04xp.layer.y9); [cx1, cy1] = centroid(pg1);
text(ax1, 1270, cy1, '0.18-0.22', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l10 = patch(ax1, 'XData', b04xp.layer.x10, 'YData', b04xp.layer.y10, 'FaceColor', col.clay);
hatchfill2(l10, 'fill');
pg1 = polyshape(b04xp.layer.x10, b04xp.layer.y10); [cx1, cy1] = centroid(pg1);
text(ax1, 1270, cy1, '0.18', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

l11 = patch(ax1, 'XData', b04xp.layer.x11, 'YData', b04xp.layer.y11, 'FaceColor', col.clay);
hatchfill2(l11, 'fill');
pg1 = polyshape(b04xp.layer.x11, b04xp.layer.y11); [cx1, cy1] = centroid(pg1);
text(ax1, 1270, cy1, '0.18', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10,'Color', 'k');

% B-02XP Soil Class ==========================================================

l1 = patch(ax1, 'XData', b02xp.layer.x1, 'YData', b02xp.layer.y1, 'FaceColor', col.fill);
hatchfill2(l1, 'cross', 'LineWidth', 1, 'HatchAngle', 45, 'HatchDensity', 100);
pg1 = polyshape(b02xp.layer.x1, b02xp.layer.y1); [cx1, cy1] = centroid(pg1);
text(ax1, 1700, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10, 'Color', 'k');

l2 = patch(ax1, 'XData', b02xp.layer.x2, 'YData', b02xp.layer.y2, 'FaceColor', col.sand);
hatchfill2(l2, 'single', 'LineWidth', 1, 'HatchAngle', 45, 'HatchDensity', 100);
pg1 = polyshape(b02xp.layer.x2, b02xp.layer.y2); [cx1, cy1] = centroid(pg1);
text(ax1, 1700, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10, 'Color', 'k');

l3 = patch(ax1, 'XData', b02xp.layer.x3, 'YData', b02xp.layer.y3, 'FaceColor', col.clay);
hatchfill2(l3, 'single', 'LineWidth', 1, 'HatchAngle', 90, 'HatchDensity', 500);
pg1 = polyshape(b02xp.layer.x3, b02xp.layer.y3); [cx1, cy1] = centroid(pg1);
text(ax1, 1700, cy1, '0.32-0.38', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10, 'Color', 'k');

l4 = patch(ax1, 'XData', b02xp.layer.x4, 'YData', b02xp.layer.y4, 'FaceColor', col.clay);
hatchfill2(l4, 'fill');
pg1 = polyshape(b02xp.layer.x4, b02xp.layer.y4); [cx1, cy1] = centroid(pg1);
text(ax1, 1700, cy1, '0.2-0.32', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10, 'Color', 'k');

l5 = patch(ax1, 'XData', b02xp.layer.x5, 'YData', b02xp.layer.y5, 'FaceColor', col.clay);
hatchfill2(l5, 'fill');
pg1 = polyshape(b02xp.layer.x5, b02xp.layer.y5); [cx1, cy1] = centroid(pg1);
text(ax1, 1700, cy1, '0.2', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10, 'Color', 'k');

l6 = patch(ax1, 'XData', b02xp.layer.x6, 'YData', b02xp.layer.y6, 'FaceColor', col.sand);
hatchfill2(l6, 'fill');
pg1 = polyshape(b02xp.layer.x6, b02xp.layer.y6); [cx1, cy1] = centroid(pg1);
text(ax1, 1700, cy1, '', 'Rotation', 0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
    'FontName', 'Times New Roman','FontSize', 10, 'Color', 'k');

% Plot Water in boring ====================================================

plot(ax1, [b06xp.bor_stickx(1), b06xp.bor_stickx(end)], [b06xp.bor_water, b06xp.bor_water], 'LineWidth', 2, 'Color', 'b')
plot(ax1, [b02xp.bor_stickx(1), b02xp.bor_stickx(end)], [b02xp.bor_water, b02xp.bor_water], 'LineWidth', 2, 'Color', 'b')
plot(ax1, [b04xp.bor_stickx(1), b04xp.bor_stickx(end)], [b04xp.bor_water, b04xp.bor_water], 'LineWidth', 2, 'Color', 'b')
plot(ax1, [b05xp.bor_stickx(1), b05xp.bor_stickx(end)], [b05xp.bor_water, b05xp.bor_water], 'LineWidth', 2, 'Color', 'b')

% Plot shelby tube samples ================================================

% B06XP
x = [b06xp.bor_stickx(1), b06xp.bor_stickx(end)];
plot(ax1, x, [b06xp.samples(1), b06xp.samples(1)], 'LineWidth', 2, 'Color', 'g')
plot(ax1, x, [b06xp.samples(2), b06xp.samples(2)], 'LineWidth', 2, 'Color', 'g')
plot(ax1, x, [b06xp.samples(3), b06xp.samples(3)], 'LineWidth', 2, 'Color', 'g')
plot(ax1, x, [b06xp.samples(4), b06xp.samples(4)], 'LineWidth', 2, 'Color', 'g')

% B05XP
x = [b05xp.bor_stickx(1), b05xp.bor_stickx(end)];
plot(ax1, x, [b05xp.samples(1), b05xp.samples(1)], 'LineWidth', 2, 'Color', 'g')
plot(ax1, x, [b05xp.samples(2), b05xp.samples(2)], 'LineWidth', 2, 'Color', 'g')
plot(ax1, x, [b05xp.samples(3), b05xp.samples(3)], 'LineWidth', 2, 'Color', 'g')
plot(ax1, x, [b05xp.samples(4), b05xp.samples(4)], 'LineWidth', 2, 'Color', 'g')
plot(ax1, x, [b05xp.samples(5), b05xp.samples(5)], 'LineWidth', 2, 'Color', 'g')

% B04XP
x = [b04xp.bor_stickx(1), b04xp.bor_stickx(end)];
plot(ax1, x, [b04xp.samples(1), b04xp.samples(1)], 'LineWidth', 2, 'Color', 'r')
plot(ax1, x, [b04xp.samples(2), b04xp.samples(2)], 'LineWidth', 2, 'Color', 'g')
plot(ax1, x, [b04xp.samples(3), b04xp.samples(3)], 'LineWidth', 2, 'Color', 'g')
plot(ax1, x, [b04xp.samples(4), b04xp.samples(4)], 'LineWidth', 2, 'Color', 'g')
plot(ax1, x, [b04xp.samples(5), b04xp.samples(5)], 'LineWidth', 2, 'Color', 'g')

% B02XP
x = [b02xp.bor_stickx(1), b02xp.bor_stickx(end)];
plot(ax1, x, [b02xp.samples(1), b02xp.samples(1)], 'LineWidth', 2, 'Color', 'g')
plot(ax1, x, [b02xp.samples(2), b02xp.samples(2)], 'LineWidth', 2, 'Color', 'g')
plot(ax1, x, [b02xp.samples(3), b02xp.samples(3)], 'LineWidth', 2, 'Color', 'g')

% Boring ID Texts =========================================================

txt = sprintf('B-06XP (31.34 ft S)');
text(100, 65, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring
txt = sprintf('B-05XP');
text(610, 70, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring
txt = sprintf('B-04XP');
text(1225, 70, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring
txt = sprintf('B-02XP (81.76 ft S)');
text(1675, 50, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring

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
    '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ...
    '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ...
    '', '', '', '', '', '', '', '', '', '', '', '', '', '', '','', '', '', '', '', '','', '', '', ...
    'Water', 'Location','southwest')

% C-06XP plot: su =========================================================

ax2 = nexttile(t, 9); % next tiles in second row
plot(c06xp.cpt_su, c06xp.cpt_elv, 'k')
hold on
yline(c06xp.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
yline([28, 20, -15, -30], 'LineWidth', 1.5, 'Color', 'k', 'LineStyle','-.')
scatter(b06xp.mdotsu.peakx, b06xp.mdotsu.peaky, 15, 'filled', 'Marker', 'o', 'MarkerEdgeColor','m', 'MarkerFaceColor','m')
scatter(b06xp.mdotsu.remoldedx, b06xp.mdotsu.remoldedy, 15, 'Marker', 'o', 'MarkerEdgeColor', 'm', 'LineWidth', 1, 'MarkerFaceColor', 'w')
ax2.YLim = [-60 60];
ax2.XLim = [0 1000];
ax2.FontName = 'Times New Roman';
ax2.FontSize = 14;
xlabel(ax2, 's_u, [psf]', 'FontSize', 16);
ylabel(ax2, 'Elevation, [ft]', 'FontSize', 16);
title(ax2, 'C-06XP');
grid(ax2, 'minor'); box(ax2, 'on');

% C-05XP plot: su =========================================================

ax3 = nexttile(t, 10); % next tiles in second row
plot(c05xp.cpt_su, c05xp.cpt_elv, 'k')
hold on
yline(c05xp.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
yline([40, 30, -6, -18], 'LineWidth', 1.5, 'Color', 'k', 'LineStyle','-.')
scatter(b05xp.mdotsu.peakx, b05xp.mdotsu.peaky, 15, 'filled', 'Marker', 'o', 'MarkerEdgeColor','m', 'MarkerFaceColor','m')
scatter(b05xp.mdotsu.remoldedx, b05xp.mdotsu.remoldedy, 15, 'Marker', 'o', 'MarkerEdgeColor', 'm', 'LineWidth', 1, 'MarkerFaceColor', 'w')
ax3.YLim = [-60 60];
ax3.XLim = [0 1000];
ax3.FontName = 'Times New Roman';
ax3.FontSize = 14;
xlabel(ax3, 's_u, [psf]', 'FontSize', 16);
ylabel(ax3, 'Elevation, [ft]', 'FontSize', 16);
title(ax3, 'C-05XP');
grid(ax3, 'minor'); box(ax3, 'on');

% C-04XP plot: su =========================================================

ax4 = nexttile(t, 11); % next tiles in second row
plot(c04xp.cpt_su, c04xp.cpt_elv, 'k')
hold on
yline(c04xp.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
yline([50, 40, 20, 12], 'LineWidth', 1.5, 'Color', 'k', 'LineStyle','-.')
scatter(b04xp.mdotsu.peakx, b04xp.mdotsu.peaky, 15, 'filled', 'Marker', 'o', 'MarkerEdgeColor','m', 'MarkerFaceColor','m')
scatter(b04xp.mdotsu.remoldedx, b04xp.mdotsu.remoldedy, 15, 'Marker', 'o', 'MarkerEdgeColor', 'm', 'LineWidth', 1, 'MarkerFaceColor', 'w')
ax4.YLim = [-60 60];
ax4.XLim = [0 1000];
ax4.FontName = 'Times New Roman';
ax4.FontSize = 14;
xlabel(ax4, 's_u, [psf]', 'FontSize', 16);
ylabel(ax4, 'Elevation, [ft]', 'FontSize', 16);
title(ax4, 'C-04XP');
grid(ax4, 'minor'); box(ax4, 'on');

% C-02XP plot: su =========================================================

ax5 = nexttile(t, 12); % next tiles in second row
plot(c02xp.cpt_su, c02xp.cpt_elv, 'k')
hold on
yline(c02xp.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
yline([20, 17, 7, 0], 'LineWidth', 1.5, 'Color', 'k', 'LineStyle','-.')
scatter(b02xp.mdotsu.peakx, b02xp.mdotsu.peaky, 15, 'filled', 'Marker', 'o', 'MarkerEdgeColor','m', 'MarkerFaceColor','m')
scatter(b02xp.mdotsu.remoldedx, b02xp.mdotsu.remoldedy, 15, 'Marker', 'o', 'MarkerEdgeColor', 'm', 'LineWidth', 1, 'MarkerFaceColor', 'w')
ax5.YLim = [-60 60];
ax5.XLim = [0 1000];
ax5.FontName = 'Times New Roman';
ax5.FontSize = 14;
xlabel(ax5, 's_u, [psf]', 'FontSize', 16);
ylabel(ax5, 'Elevation, [ft]', 'FontSize', 16);
title(ax5, 'C-02XP');
grid(ax5, 'minor'); box(ax5, 'on');

% C-06XP plot: res =========================================================

ax6 = nexttile(t, 13); % next tiles in second row
plot(c06xp.cpt_res, c06xp.cpt_elv, 'k')
yline(c06xp.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
yline([28, 20, -15, -30], 'LineWidth', 1.5, 'Color', 'k', 'LineStyle','-.')
ax6.YLim = [-60 60];
ax6.XLim = [0 100];
ax6.FontName = 'Times New Roman';
ax6.FontSize = 14;
xlabel(ax6, 'Res, [ohm-m]', 'FontSize', 16);
ylabel(ax6, 'Elevation, [ft]', 'FontSize', 16);
title(ax6, 'C-06XP');
grid(ax6, 'minor'); box(ax6, 'on');

% C-05XP plot: res =========================================================

ax7 = nexttile(t, 14); % next tiles in second row
plot(c05xp.cpt_res, c05xp.cpt_elv, 'k')
yline(c05xp.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
yline([40, 30, -6, -18], 'LineWidth', 1.5, 'Color', 'k', 'LineStyle','-.')
ax7.YLim = [-60 60];
ax7.XLim = [0 100];
ax7.FontName = 'Times New Roman';
ax7.FontSize = 14;
xlabel(ax7, 'Res, [ohm-m]', 'FontSize', 16);
ylabel(ax7, 'Elevation, [ft]', 'FontSize', 16);
title(ax7, 'C-05XP');
grid(ax7, 'minor'); box(ax7, 'on');

% C-04XP plot: res =========================================================

ax8 = nexttile(t, 15); % next tiles in second row
plot(c04xp.cpt_res, c04xp.cpt_elv, 'k')
yline([50, 40, 20, 12], 'LineWidth', 1.5, 'Color', 'k', 'LineStyle','-.')
yline(c04xp.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
ax8.YLim = [-60 60];
ax8.XLim = [0 100];
ax8.FontName = 'Times New Roman';
ax8.FontSize = 14;
xlabel(ax8, 'Res, [ohm-m]', 'FontSize', 16);
ylabel(ax8, 'Elevation, [ft]', 'FontSize', 16);
title(ax8, 'C-04XP');
grid(ax8, 'minor'); box(ax8, 'on');

% C-02XP plot: res =========================================================

ax9 = nexttile(t, 16); % next tiles in second row
plot(c02xp.cpt_res, c02xp.cpt_elv, 'k')
yline(c02xp.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
yline([20, 17, 7, 0], 'LineWidth', 1.5, 'Color', 'k', 'LineStyle','-.')
ax9.YLim = [-60 60];
ax9.XLim = [0 100];
ax9.FontName = 'Times New Roman';
ax9.FontSize = 14;
xlabel(ax9, 'Res, [ohm-m]', 'FontSize', 16);
ylabel(ax9, 'Elevation, [ft]', 'FontSize', 16);
title(ax9, 'C-02XP');
grid(ax9, 'minor'); box(ax9, 'on');

