% PROCESSES CROSS SECTIONS CPT AND BORING DATA BASED ON ELEVATION. X SPACING IS USER DEFINED IN ARCGIS.

%% INPUT SPREADSHEETS 
clear all; close all; clc;

c01xh_data = readtable("Hallidon XS.xlsx","Sheet", 3);
c03h_data = readtable("Hallidon XS.xlsx","Sheet", 5);

b01xh_data = readtable("Hallidon XS.xlsx", 'Sheet', 4);
%% INPUT CPT ELEVATION, SHEAR STRENGTH, & RESISTIVITY DATA

% C-01XH ==================================================================

c01xh_data = table2array(c01xh_data(:, [1, 2, 4, 5, 6]));
cpt_elv = 73.37688 - c01xh_data(:, 3) ; % hole's elevation - cpt depth values
cpt_su = (c01xh_data(:, 4).*2000.*15)./19.5; % shear strength conversion from tsf to psf
cpt_res = c01xh_data(:, 5); % resistivity
c01xh = struct('raw', c01xh_data, 'surf_elv', c01xh_data(:, 1), ...
              'surf_dist', c01xh_data(:, 2), 'cpt_elv', cpt_elv, ...
              'cpt_su', cpt_su, 'cpt_res', cpt_res);
cpt_midx = c01xh.surf_dist(31); % find on arcgis
c01xh.cpt_stickx = [cpt_midx-5, cpt_midx-5, cpt_midx+5, cpt_midx+5];
c01xh.cpt_sticky = [cpt_elv(1), cpt_elv(end), cpt_elv(end), cpt_elv(1)];
c01xh.cpt_water = 73.37688 - 39; % find from ue cpt data didn't have the data
% offset = 6.53 ft S  % find on arcgis

% C-03H ==================================================================

c03h_data = table2array(c03h_data(:, [1, 2, 4, 5, 6]));
cpt_elv = 32.49168 - c03h_data(:, 3) ; % hole's elevation - cpt depth values
cpt_su = (c03h_data(:, 4).*2000.*15)./19.5; % shear strength conversion from tsf to psf
cpt_res = c03h_data(:, 5); % resistivity
c03h = struct('raw', c03h_data, 'surf_elv', c03h_data(:, 1), ...
              'surf_dist', c03h_data(:, 2), 'cpt_elv', cpt_elv, ...
              'cpt_su', cpt_su, 'cpt_res', cpt_res);
cpt_midx = c03h.surf_dist(83); % find on arcgis
c03h.cpt_stickx = [cpt_midx-5, cpt_midx-5, cpt_midx+5, cpt_midx+5];
c03h.cpt_sticky = [cpt_elv(1), cpt_elv(end), cpt_elv(end), cpt_elv(1)];
c03h.cpt_water = 32.49168 - 5; % find from ue cpt data didn't have the data
% offset = 892.45 ft N  % find on arcgis

clear  c01xh_data c03h_data cpt_elv cpt_su cpt_res cpt_midx ans i; 

%% INPUT BORING ELEVATION & SOIL TYPE

% B-01XH ==================================================================

surf_elv = table2array(b01xh_data(2:end, 1));
surf_dist = table2array(b01xh_data(2:end, 2));
boring_elv = 70.26416 - table2array(b01xh_data(1:8, 4));
boring_class = string(table2cell(b01xh_data(1:8, 5)));
b01xh = struct('raw', b01xh_data, 'surf_elv', surf_elv, ...
               'surf_dist', surf_dist, 'boring_elv', boring_elv, ...
               'boring_class', boring_class);
bor_midx = b01xh.surf_dist(32); % find on arcgis
b01xh.bor_stickx = [bor_midx, bor_midx, bor_midx+20, bor_midx+20];
b01xh.bor_sticky = [boring_elv(1), boring_elv(end), boring_elv(end), boring_elv(1)];
b01xh.bor_water = 70.26416 - 10; % find from boring log
b01xh.layer.x1 = b01xh.bor_stickx; % asphalt
b01xh.layer.y1 = [b01xh.boring_elv(1), b01xh.boring_elv(2), b01xh.boring_elv(2), b01xh.boring_elv(1)];
b01xh.layer.x2 = b01xh.bor_stickx; % sw
b01xh.layer.y2 = [b01xh.boring_elv(2), b01xh.boring_elv(3), b01xh.boring_elv(3), b01xh.boring_elv(2)];
b01xh.layer.x3 = b01xh.bor_stickx; % 'SM'
b01xh.layer.y3 = [b01xh.boring_elv(3), b01xh.boring_elv(5), b01xh.boring_elv(5), b01xh.boring_elv(3)];
b01xh.layer.x4 = b01xh.bor_stickx; % 'VERY SOFT CL'
b01xh.layer.y4 = [b01xh.boring_elv(5), b01xh.boring_elv(6), b01xh.boring_elv(6), b01xh.boring_elv(5)];
b01xh.layer.x5 = b01xh.bor_stickx; % 'SM'
b01xh.layer.y5 = [b01xh.boring_elv(6), b01xh.boring_elv(7), b01xh.boring_elv(7), b01xh.boring_elv(6)];
b01xh.layer.x6 = b01xh.bor_stickx; % 'MEDIUM STIFF CL'
b01xh.layer.y6 = [b01xh.boring_elv(7), b01xh.boring_elv(8), b01xh.boring_elv(8), b01xh.boring_elv(7)];
b01xh.samples = 70.26416 - [30, 40, 60, 65, 80]; % 60 was dropped flag as red
% offset = 3.02 ft S
b01xh.mdotsu.peakx = [0.81, 0.68, 0.76, 0.77, ...
                      0.81, 0.61, 0.73, NaN].*1000;
b01xh.mdotsu.peaky = 70.26416 - [33, 34, 43, 44, ...
                                 51, 52, 63, 64];
b01xh.mdotsu.remoldedx = [0.09, 0.13, 0.04, 0.07, ...
                          0.03, 0.00, 0.00, NaN].*1000;
b01xh.mdotsu.remoldedy = b01xh.mdotsu.peaky;

clear surf_elv surf_dist boring_elv boring_class bor_midx;
clear b01xh_data;

% Colors ==================================================================
% have to change it to geotechnical symbols or whatever liek lean clay or
% clean sand

col.asphalt = [82, 82, 82]./255;
col.topsoil = [129, 148, 124]./255;
col.fill = [166, 129, 91]./255;
col.sand = [214, 161, 62]./255;
col.clay = [134, 159, 166]./255;
