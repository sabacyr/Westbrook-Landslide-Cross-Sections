% DRAWS CROSS SECTIONS BASED ON ELEVATION. X SPACING IS USER DEFINED IN ARCGIS.

%% INPUT SPREADSHEETS 
clear all; close all; clc;

c01b_data = readtable("Bridge St XS.xlsx","Sheet", 3);
c02b_data = readtable("Bridge St XS.xlsx","Sheet", 4);
c03b_data = readtable("Bridge St XS.xlsx","Sheet", 5);

reszones.dropx = [85, 256, 395.2];
reszones.dropy = [21, 20, 19.12];

slipsurf.x = [120, 256, 395.2, 440];
slipsurf.y = [56.9, 20, 13, 13];
%% INPUT CPT ELEVATION, SHEAR STRENGTH, & RESISTIVITY DATA

% C-01B ==================================================================

c01b_data = table2array(c01b_data(:, [1, 2, 4, 5, 6]));
cpt_elv = 54.6 - c01b_data(:, 3) ; % hole's elevation - cpt depth values
cpt_su = (c01b_data(:, 4).*2000.*15)./21; % shear strength conversion from tsf to psf
% for i = 1:length(cpt_su)
%     if cpt_su(i) >= 1000
%         cpt_su(i) = nan;
%     end
% end
cpt_res = c01b_data(:, 5); % resistivity
c01b = struct('raw', c01b_data, 'surf_elv', c01b_data(:, 1), ...
              'surf_dist', c01b_data(:, 2), 'cpt_elv', cpt_elv, ...
              'cpt_su', cpt_su, 'cpt_res', cpt_res);
cpt_midx = (c01b.surf_dist(9) + c01b.surf_dist(10))/2; % find on arcgis
c01b.cpt_stickx = [cpt_midx-2, cpt_midx-2, cpt_midx+2, cpt_midx+2];
c01b.cpt_sticky = [cpt_elv(1), cpt_elv(end), cpt_elv(end), cpt_elv(1)];
c01b.cpt_water = 54.6 - 34.5; % find from ue cpt data

% C-02B ==================================================================

c02b_data = table2array(c02b_data(:, [1, 2, 4, 5, 6]));
cpt_elv = 30.85824 - c02b_data(:, 3) ; % hole's elevation - cpt depth values
cpt_su = (c02b_data(:, 4).*2000.*15)./21; % shear strength conversion from tsf to psf
% for i = 1:length(cpt_su)
%     if cpt_su(i) >= 1000
%         cpt_su(i) = nan;
%     end
% end
cpt_res = c02b_data(:, 5); % resistivity
c02b = struct('raw', c02b_data, 'surf_elv', c02b_data(:, 1), ...
              'surf_dist', c02b_data(:, 2), 'cpt_elv', cpt_elv, ...
              'cpt_su', cpt_su, 'cpt_res', cpt_res);
cpt_midx = 1.04*c02b.surf_dist(39); % find on arcgis
c02b.cpt_stickx = [cpt_midx-2, cpt_midx-2, cpt_midx+2, cpt_midx+2];
c02b.cpt_sticky = [cpt_elv(1), cpt_elv(end), cpt_elv(end), cpt_elv(1)];
c02b.cpt_water = 30.85824 - 11; % find from ue cpt data

% C-03B ==================================================================

c03b_data = table2array(c03b_data(:, [1, 2, 4, 5, 6]));
cpt_elv = 41.41656 - c03b_data(:, 3) ; % hole's elevation - cpt depth values
cpt_su = (c03b_data(:, 4).*2000.*15)./21; % shear strength conversion from tsf to psf
% for i = 1:length(cpt_su)
%     if cpt_su(i) >= 1000
%         cpt_su(i) = nan;
%     end
% end
cpt_res = c03b_data(:, 5); % resistivity
c03b = struct('raw', c03b_data, 'surf_elv', c03b_data(:, 1), ...
              'surf_dist', c03b_data(:, 2), 'cpt_elv', cpt_elv, ...
              'cpt_su', cpt_su, 'cpt_res', cpt_res);
cpt_midx = 0.8*c03b.surf_dist(33); % find on arcgis
c03b.cpt_stickx = [cpt_midx-2, cpt_midx-2, cpt_midx+2, cpt_midx+2];
c03b.cpt_sticky = [cpt_elv(1), cpt_elv(59), cpt_elv(59), cpt_elv(1)];
%c03b.cpt_water = cpt_elv(139); % find from ue cpt data didn't have the data

clear cpt_elv cpt_su cpt_res cpt_midx ans i; 

%% INPUT BORING ELEVATION & SOIL TYPE

% Colors:
% _col_asphalt = [82, 82, 82]./255;
% _col_topsoil = [129, 148, 124]./255;
% _col_fill = [166, 129, 91]./255;
% _col_sand = [214, 161, 62]./255;
% _col_clay = [134, 159, 166]./255;

% No borings at these locations

%% INPUT WATER ZONE AND RES ZONES

% no res zone noticable between all three cpt

waterzones.x = [(c01b.surf_dist(9) + c01b.surf_dist(10))/2, 1.04*c02b.surf_dist(39), 440, 500];
waterzones.y = [c01b.cpt_water, c02b.cpt_water, 14.9355, 14.9336];


%% GENERATE FIGURE: CROSS SECTION AND SU AND RES

close all

fig1 = figure('Color','w', 'Position',[1921,49,1920,955]);
t = tiledlayout(fig1, 2, 8, 'TileSpacing', 'compact', 'Padding', 'compact');
ax1 = nexttile(t, [1 8]); % spans 1 row and 3 columns

% Plot surface ============================================================

plot(ax1, c01b.surf_dist, c01b.surf_elv, 'LineWidth', 2, 'Color', [0 0 0 1])
hold(ax1, 'on')
% plot(c02b.surf_dist, c02b.surf_elv, 'LineWidth', 2, 'Color', [0 0 1 0.6])
% plot(c03b.surf_dist, c03b.surf_elv, 'LineWidth', 2, 'Color', [1 0 0 0.6])

% Plot CPT stick ==========================================================

patch(ax1, 'XData', c01b.cpt_stickx, 'YData', c01b.cpt_sticky, 'FaceColor', 'w');
patch(ax1, 'XData', c02b.cpt_stickx, 'YData', c02b.cpt_sticky, 'FaceColor', 'w');
patch(ax1, 'XData', c03b.cpt_stickx, 'YData', c03b.cpt_sticky, 'FaceColor', 'w');

% Plot Water ==============================================================

plot(ax1, [c01b.cpt_stickx(1), c01b.cpt_stickx(end)], [c01b.cpt_water, c01b.cpt_water], 'LineWidth', 2, 'Color', 'b')
plot(ax1, [c02b.cpt_stickx(1), c02b.cpt_stickx(end)], [c02b.cpt_water, c02b.cpt_water], 'LineWidth', 2, 'Color', 'b')
%plot(ax1, [c03b.cpt_stickx(1), c03b.cpt_stickx(end)], [c03b.cpt_water, c03b.cpt_water], 'LineWidth', 2, 'Color', 'b')
%plot(ax1, waterzones.x, waterzones.y, 'LineWidth', 1.5, 'Color', 'b')

% Main x-axis: distance along the profile =================================

ax1.YLim = [-90 90];
ax1.XLim = [0 600];
ax1.FontName = 'Times New Roman';
ax1.FontSize = 14;
xlabel(ax1, 'Distance, [ft]', 'FontSize', 16);
ylabel(ax1, 'Elevation, [ft]', 'FontSize', 16);
title(ax1, 'Bridge St Profile 1', 'FontName', 'Times New Roman', 'FontSize', 16)
grid(ax1, 'minor'); box(ax1, 'on');
 
% CPT ID Texts ============================================================
txt = sprintf('C-01B');
text(c01b.cpt_stickx(1)-9, c01b.cpt_sticky(1)+5, txt, 'FontSize', 14, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring

txt = sprintf('C-02B (122.3 ft S)');
text(c02b.cpt_stickx(1)-9, c02b.cpt_sticky(1)+5.5, txt, 'FontSize', 14, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring

txt = sprintf('C-03B (307.4 ft N)');
text(c03b.cpt_stickx(1)-9, c03b.cpt_sticky(1)+5.5, txt, 'FontSize', 14, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring

% Plot Boring stick ==========================================================


% B- Soil Class ==========================================================


% Plot Water in boring ==============================================================


% Plot shelby tube samples ================================================

% B

% Boring ID Texts ============================================================


% Plot post slide/slip/pre slide surface =================================================
% line(ax1, 'XData', postsurf.x, 'YData', postsurf.y, 'LineWidth', 2, 'Color', [0 0 0 1])
line(ax1, 'XData', slipsurf.x, 'YData', slipsurf.y, 'LineWidth', 1, 'Color', 'r')

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
legend(ax1, 'Current Surface', '', '', '', '', '', 'Slip Surface', '', 'Water', 'Location','southwest')

% C-01B plot: su =========================================================

ax2 = nexttile(t, 10); % next tiles in second row
plot(c01b.cpt_su, c01b.cpt_elv, 'k')
hold on
yline(ax2, c01b.cpt_water, 'LineWidth', 1, 'Color', 'b')
ax2.YLim = [-40 60];
ax2.XLim = [0 1000];
ax2.FontName = 'Times New Roman';
ax2.FontSize = 14;
xlabel(ax2, 's_u, [psf]', 'FontSize', 16);
ylabel(ax2, 'Elevation, [ft]', 'FontSize', 16);
title(ax2, 'C-01B')
grid(ax2, 'minor'); box(ax2, 'on');

% C-02B plot: su =========================================================

ax3 = nexttile(t, 11); % next tiles in second row
plot(c02b.cpt_su, c02b.cpt_elv, 'k')
hold on
yline(ax3, c02b.cpt_water, 'LineWidth', 1, 'Color', 'b')
yline(13, 'LineWidth', 1.5, 'Color', 'r', 'LineStyle','--')
ax3.YLim = [-40 60];
ax3.XLim = [0 1000];
ax3.FontName = 'Times New Roman';
ax3.FontSize = 14;
xlabel(ax3, 's_u, [psf]', 'FontSize', 16);
ylabel(ax3, 'Elevation, [ft]', 'FontSize', 16);
title(ax3, 'C-02B')
grid(ax3, 'minor'); box(ax3, 'on');

% C-03B plot: su =========================================================

ax4 = nexttile(t, 12); % next tiles in second row
plot(c03b.cpt_su, c03b.cpt_elv, 'k')
ax4.YLim = [-40 60];
ax4.XLim = [0 1000];
ax4.FontName = 'Times New Roman';
ax4.FontSize = 14;
xlabel(ax4, 's_u, [psf]', 'FontSize', 16);
ylabel(ax4, 'Elevation, [ft]', 'FontSize', 16);
title(ax4, 'C-03B')
grid(ax4, 'minor'); box(ax4, 'on');

% C-01B plot: res =========================================================
ax5 = nexttile(t, 13); % next tiles in second row
plot(c01b.cpt_res, c01b.cpt_elv, 'k')
hold on
yline(ax5, c01b.cpt_water, 'LineWidth', 1, 'Color', 'b')
ax5.YLim = [-40 60];
ax5.XLim = [0 100];
ax5.FontName = 'Times New Roman';
ax5.FontSize = 14;
xlabel(ax5, 'Res, [ohm-m]', 'FontSize', 16);
ylabel(ax5, 'Elevation, [ft]', 'FontSize', 16);
title(ax5, 'C-01B')
grid(ax5, 'minor'); box(ax5, 'on');

% C-02B plot: res =========================================================

ax6 = nexttile(t, 14); % next tiles in second row
plot(c02b.cpt_res, c02b.cpt_elv, 'k')
hold on
yline(ax6, c02b.cpt_water, 'LineWidth', 1, 'Color', 'b')
yline(13, 'LineWidth', 1.5, 'Color', 'r', 'LineStyle','--')
ax6.YLim = [-40 60];
ax6.XLim = [0 100];
ax6.FontName = 'Times New Roman';
ax6.FontSize = 14;
xlabel(ax6, 'Res, [ohm-m]', 'FontSize', 16);
ylabel(ax6, 'Elevation, [ft]', 'FontSize', 16);
title(ax6, 'C-02B')
grid(ax6, 'minor'); box(ax6, 'on');

% C-03B plot: res =========================================================

ax7 = nexttile(t, 15); % next tiles in second row
plot(c03b.cpt_res, c03b.cpt_elv, 'k')
ax7.YLim = [-40 60];
ax7.XLim = [0 100];
ax7.FontName = 'Times New Roman';
ax7.FontSize = 14;
xlabel(ax7, 'Res, [ohm-m]', 'FontSize', 16);
ylabel(ax7, 'Elevation, [ft]', 'FontSize', 16);
title(ax7, 'C-03B')
grid(ax7, 'minor'); box(ax7, 'on');
