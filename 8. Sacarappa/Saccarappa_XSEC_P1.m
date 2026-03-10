% DRAWS CROSS SECTIONS BASED ON ELEVATION. X SPACING IS USER DEFINED IN
% ARCGIS. MUST RUN Puritan_XSEC_DataProcess.m FIRST

%% INPUT PROCESSED DATA 
clear all; close all; clc;

load("SaccarappaAllData.mat")


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

waterzones.x = [490, 730, c01s.surf_dist(78), c02s.surf_dist(83), c02bp.surf_dist(246)];
waterzones.y = [39.6982, 39.6982, c01s.cpt_water, c02s.cpt_water, c02bp.cpt_water];

% postsurf.x = [360, 473, 473, 588, 592, 598];
% postsurf.y = [30.79, 38.7958, 38.7958, 65.7509, 65.7509, 84.67];

% slipsurf.x = []
%% GENERATE FIGURE: CROSS SECTION AND SU

close all
fig1 = figure('Color','w', 'Position', [1921,49,1920,955]);
t = tiledlayout(fig1, 2, 8, 'TileSpacing', 'compact', 'Padding', 'compact');
ax1 = nexttile(t, [1 8]); % spans 1 row and 8 columns

% Plot surface ============================================================

plot(ax1, c01s.surf_dist, c01s.surf_elv, 'LineWidth', 2, 'Color', [0 0 0 1])
hold(ax1, 'on')

% Plot CPT stick ==========================================================

patch(ax1, 'XData', c01s.cpt_stickx, 'YData', c01s.cpt_sticky, 'FaceColor', 'w');
patch(ax1, 'XData', c02s.cpt_stickx, 'YData', c02s.cpt_sticky, 'FaceColor', 'w');
patch(ax1, 'XData', c02bp.cpt_stickx, 'YData', c02bp.cpt_sticky, 'FaceColor', 'w');

% Plot Water in CPT ==============================================================

plot(ax1, [c01s.cpt_stickx(1), c01s.cpt_stickx(end)], [c01s.cpt_water, c01s.cpt_water], 'LineWidth', 2, 'Color', 'b')
plot(ax1, [c02s.cpt_stickx(1), c02s.cpt_stickx(end)], [c02s.cpt_water, c02s.cpt_water], 'LineWidth', 2, 'Color', 'b')
plot(ax1, [c02bp.cpt_stickx(1), c02bp.cpt_stickx(end)], [c02bp.cpt_water, c02bp.cpt_water], 'LineWidth', 2, 'Color', 'b')

% Main x-axis: distance along the profile =================================

ax1.YLim = [-50, 120];
ax1.XLim = [0 2800];
ax1.FontName = 'Times New Roman';
ax1.FontSize = 14;
xlabel(ax1, 'Distance, [ft]', 'FontSize', 16);
ylabel(ax1, 'Elevation, [ft]', 'FontSize', 16);
title('Saccarappa Profile 1', 'FontName', 'Times New Roman', 'FontSize', 16);
grid(ax1, 'minor'); box(ax1, 'on');
 
% CPT ID Texts ============================================================

txt = sprintf('C-01S (384.55 ft E)');
text(735, 65, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring
txt = sprintf('C-02S');
text(800, 72, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring
txt = sprintf('C-02BP');
text(2420, 90, txt, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter','latex', 'Color', 'k') % Name of the boring

% Plot Boring stick ==========================================================


% B- Soil Class ==========================================================


% Plot Water in boring ==============================================================


% Plot shelby tube samples ================================================

% B

% Boring ID Texts ============================================================


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
legend(ax1, 'Current Surface', '', '', '', '', '', '', 'Water')

% C-01S plot: su ==========================================================

ax2 = nexttile(t, 10); % next tiles in second row
plot(c01s.cpt_su, c01s.cpt_elv, 'k')
yline(c01s.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
ax2.YLim = [-30, 90];
ax2.XLim = [0 2000];
ax2.FontName = 'Times New Roman';
ax2.FontSize = 14;
xlabel(ax2, 's_u, [psf]', 'FontSize', 16);
ylabel(ax2, 'Elevation, [ft]', 'FontSize', 16);
title(ax2, 'C-01S')
grid(ax2, 'minor'); box(ax2, 'on');

% C-02S plot: su =========================================================

ax3 = nexttile(t, 11); % next tiles in second row
plot(c02s.cpt_su, c02s.cpt_elv, 'k')
yline(c02s.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
ax3.YLim = [-30, 90];
ax3.XLim = [0 2000];
ax3.FontName = 'Times New Roman';
ax3.FontSize = 14;
xlabel(ax3, 's_u, [psf]', 'FontSize', 16);
ylabel(ax3, 'Elevation, [ft]', 'FontSize', 16);
title(ax3, 'C-02S')
grid(ax3, 'minor'); box(ax3, 'on');

% C-02BP plot: su =========================================================

ax4 = nexttile(t, 12); % next tiles in second row
plot(c02bp.cpt_su, c02bp.cpt_elv, 'k')
yline(c02bp.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
ax4.YLim = [-30, 90];
ax4.XLim = [0 2000];
ax4.FontName = 'Times New Roman';
ax4.FontSize = 14;
xlabel(ax4, 's_u, [psf]', 'FontSize', 16);
ylabel(ax4, 'Elevation, [ft]', 'FontSize', 16);
title(ax4, 'C-02BP')
grid(ax4, 'minor'); box(ax4, 'on');

% C-01S plot: res =========================================================

ax5 = nexttile(t, 13); % next tiles in second row
plot(c01s.cpt_res, c01s.cpt_elv, 'k')
yline(c01s.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
ax5.YLim = [-30, 90];
ax5.XLim = [0 150];
ax5.FontName = 'Times New Roman';
ax5.FontSize = 14;
xlabel(ax5, 'Res, [ohm-m]', 'FontSize', 16);
ylabel(ax5, 'Elevation, [ft]', 'FontSize', 16);
title(ax5, 'C-01S')
grid(ax5, 'minor'); box(ax5, 'on');

% C-02S plot: res =========================================================

ax6 = nexttile(t, 14); % next tiles in second row
plot(c02s.cpt_res, c02s.cpt_elv, 'k')
yline(c02s.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
ax6.YLim = [-30, 90];
ax6.XLim = [0 150];
ax6.FontName = 'Times New Roman';
ax6.FontSize = 14;
xlabel(ax6, 'Res, [ohm-m]', 'FontSize', 16);
ylabel(ax6, 'Elevation, [ft]', 'FontSize', 16);
title(ax6, 'C-02S')
grid(ax6, 'minor'); box(ax6, 'on');

% C-02BP plot: res =========================================================

ax7 = nexttile(t, 15); % next tiles in second row
plot(c02bp.cpt_res, c02bp.cpt_elv, 'k')
yline(c02bp.cpt_water, 'LineWidth', 1.5, 'Color', 'b')
ax7.YLim = [-30, 90];
ax7.XLim = [0 150];
ax7.FontName = 'Times New Roman';
ax7.FontSize = 14;
xlabel(ax7, 'Res, [ohm-m]', 'FontSize', 16);
ylabel(ax7, 'Elevation, [ft]', 'FontSize', 16);
title(ax7, 'C-02BP')
grid(ax7, 'minor'); box(ax7, 'on');
