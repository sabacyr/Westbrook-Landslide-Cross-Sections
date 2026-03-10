% PROCESSES CROSS SECTIONS CPT AND BORING DATA BASED ON ELEVATION. X SPACING IS USER DEFINED IN ARCGIS.

%% INPUT SPREADSHEETS 
clear all; close all; clc;

c04w_data = readtable("Warren XS.xlsx","Sheet", 3);
c02xw_data = readtable("Warren XS.xlsx","Sheet", 5);
c03xw_data = readtable("Warren XS.xlsx","Sheet", 7);

b02xw_data = readtable("Warren XS.xlsx", 'Sheet', 4);
b03xw_data = readtable("Warren XS.xlsx", 'Sheet', 6);

%% INPUT CPT ELEVATION, SHEAR STRENGTH, & RESISTIVITY DATA

% C-04W ==================================================================

c04w_data = table2array(c04w_data(:, [1, 2, 4, 5, 6]));
cpt_elv = 28.60816 - c04w_data(:, 3) ; % hole's elevation - cpt depth values
cpt_su = (c04w_data(:, 4).*2000.*15)./19.5; % shear strength conversion from tsf to psf
cpt_res = c04w_data(:, 5); % resistivity
c04w = struct('raw', c04w_data, 'surf_elv', c04w_data(:, 1), ...
              'surf_dist', c04w_data(:, 2), 'cpt_elv', cpt_elv, ...
              'cpt_su', cpt_su, 'cpt_res', cpt_res);
cpt_midx = c04w.surf_dist(29); % find on arcgis
c04w.cpt_stickx = [cpt_midx-2, cpt_midx-2, cpt_midx+2, cpt_midx+2];
c04w.cpt_sticky = [cpt_elv(1), cpt_elv(end), cpt_elv(end), cpt_elv(1)];
c04w.cpt_water = 28.60816 - 2; % find from ue cpt data didn't have the data
% offset = 192.95 ft N  % find on arcgis

% C-02XW ==================================================================

c02xw_data = table2array(c02xw_data(:, [1, 2, 4, 5, 6]));
cpt_elv = 38.87784 - c02xw_data(:, 3) ; % hole's elevation - cpt depth values
cpt_su = (c02xw_data(:, 4).*2000.*15)./19.5; % shear strength conversion from tsf to psf
cpt_res = c02xw_data(:, 5); % resistivity
c02xw = struct('raw', c02xw_data, 'surf_elv', c02xw_data(:, 1), ...
              'surf_dist', c02xw_data(:, 2), 'cpt_elv', cpt_elv, ...
              'cpt_su', cpt_su, 'cpt_res', cpt_res);
cpt_midx = (c02xw.surf_dist(48) + c02xw.surf_dist(49))/2; % find on arcgis
c02xw.cpt_stickx = [cpt_midx-2, cpt_midx-2, cpt_midx+2, cpt_midx+2];
c02xw.cpt_sticky = [cpt_elv(1), cpt_elv(end), cpt_elv(end), cpt_elv(1)];
c02xw.cpt_water = 38.87784 - 17; % find from ue cpt data didn't have the data
% offset = 0

% C-03XW ==================================================================

c03xw_data = table2array(c03xw_data(:, [1, 2, 4, 5, 6]));
cpt_elv = 65.83288 - c03xw_data(:, 3) ; % hole's elevation - cpt depth values
cpt_su = (c03xw_data(:, 4).*2000.*15)./19.5; % shear strength conversion from tsf to psf
cpt_res = c03xw_data(:, 5); % resistivity
c03xw = struct('raw', c03xw_data, 'surf_elv', c03xw_data(:, 1), ...
              'surf_dist', c03xw_data(:, 2), 'cpt_elv', cpt_elv, ...
              'cpt_su', cpt_su, 'cpt_res', cpt_res);
cpt_midx = c03xw.surf_dist(60); % find on arcgis
c03xw.cpt_stickx = [cpt_midx-2, cpt_midx-2, cpt_midx+2, cpt_midx+2];
c03xw.cpt_sticky = [cpt_elv(1), cpt_elv(end), cpt_elv(end), cpt_elv(1)];
c03xw.cpt_water = 65.83288 - 21; % find from ue cpt data didn't have the data
% offset = 104.25 ft N  % find on arcgis

clear  c04w_data c03xw_data c02xw_data cpt_elv cpt_su cpt_res cpt_midx ans i; 

%% INPUT BORING ELEVATION & SOIL TYPE

% B-02XW ==================================================================

surf_elv = table2array(b02xw_data(2:end, 1));
surf_dist = table2array(b02xw_data(2:end, 2));
boring_elv = 36.24728 - table2array(b02xw_data(1:6, 4));
boring_class = string(table2cell(b02xw_data(1:6, 5)));
b02xw = struct('raw', b02xw_data, 'surf_elv', surf_elv, ...
               'surf_dist', surf_dist, 'boring_elv', boring_elv, ...
               'boring_class', boring_class);
bor_midx = b02xw.surf_dist(49); % find on arcgis
b02xw.bor_stickx = [bor_midx, bor_midx, bor_midx+7.5, bor_midx+7.5];
b02xw.bor_sticky = [boring_elv(1), boring_elv(end), boring_elv(end), boring_elv(1)];
b02xw.bor_water = 36.24728 - 7; % find from boring log
b02xw.layer.x1 = b02xw.bor_stickx; % gravel
b02xw.layer.y1 = [b02xw.boring_elv(1), b02xw.boring_elv(2), b02xw.boring_elv(2), b02xw.boring_elv(1)];
b02xw.layer.x2 = b02xw.bor_stickx; % 'CL MEDIUM STIFF'
b02xw.layer.y2 = [b02xw.boring_elv(2), b02xw.boring_elv(3), b02xw.boring_elv(3), b02xw.boring_elv(2)];
b02xw.layer.x3 = b02xw.bor_stickx; % 'CL VERY SOFT'
b02xw.layer.y3 = [b02xw.boring_elv(3), b02xw.boring_elv(4), b02xw.boring_elv(4), b02xw.boring_elv(3)];
b02xw.layer.x4 = b02xw.bor_stickx; % 'CL SOFT'
b02xw.layer.y4 = [b02xw.boring_elv(4), b02xw.boring_elv(5), b02xw.boring_elv(5), b02xw.boring_elv(4)];
b02xw.layer.x5 = b02xw.bor_stickx; % 'CL MEDIUM STIFF'
b02xw.layer.y5 = [b02xw.boring_elv(5), b02xw.boring_elv(6), b02xw.boring_elv(6), b02xw.boring_elv(5)];
b02xw.samples = 36.24728 - [25, 35, 45]; 
% offset = 0 ft S
b02xw.mdotsu.peakx = [0.34, 0.58, 0.54, 0.55, 0.43, 0.46, 0.46, 0.52, 0.60, 0.55, 0.68, 0.56, ...
                      0.70, 0.56, 0.62, 0.80].*1000;
b02xw.mdotsu.peaky = 36.24728 - [21, 22, 28, 29, 31, 32, 38, 39, 41, 42, 48, 49, ...
                                51, 52, 56, 57];
b02xw.mdotsu.remoldedx = [0.04, 0.03, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, ...
                          0.04, 0.00, 0.00, 0.00].*1000;
b02xw.mdotsu.remoldedy = b02xw.mdotsu.peaky;

% B-03XW ==================================================================

surf_elv = table2array(b03xw_data(2:end, 1));
surf_dist = table2array(b03xw_data(2:end, 2));
boring_elv = 63.16624 - table2array(b03xw_data(1:9, 4));
boring_class = string(table2cell(b03xw_data(1:9, 5)));
b03xw = struct('raw', b03xw_data, 'surf_elv', surf_elv, ...
               'surf_dist', surf_dist, 'boring_elv', boring_elv, ...
               'boring_class', boring_class);
bor_midx = b03xw.surf_dist(59); % find on arcgis
b03xw.bor_stickx = [bor_midx-2.5, bor_midx-2.5, bor_midx+5, bor_midx+5];
b03xw.bor_sticky = [boring_elv(1), boring_elv(end), boring_elv(end), boring_elv(1)];
b03xw.bor_water = 63.16624 - 5; % find from boring log
b03xw.layer.x1 = b03xw.bor_stickx; % 'SW-SM'
b03xw.layer.y1 = [b03xw.boring_elv(1), b03xw.boring_elv(2), b03xw.boring_elv(2), b03xw.boring_elv(1)];
b03xw.layer.x2 = b03xw.bor_stickx; % 'CL VERY SOFT'
b03xw.layer.y2 = [b03xw.boring_elv(2), b03xw.boring_elv(3), b03xw.boring_elv(3), b03xw.boring_elv(2)];
b03xw.layer.x3 = b03xw.bor_stickx; % 'SW-SM'
b03xw.layer.y3 = [b03xw.boring_elv(3), b03xw.boring_elv(4), b03xw.boring_elv(4), b03xw.boring_elv(3)];
b03xw.layer.x4 = b03xw.bor_stickx; % 'VERY SOFT CL'
b03xw.layer.y4 = [b03xw.boring_elv(4), b03xw.boring_elv(5), b03xw.boring_elv(5), b03xw.boring_elv(4)];
b03xw.layer.x5 = b03xw.bor_stickx; % 'SW'
b03xw.layer.y5 = [b03xw.boring_elv(5), b03xw.boring_elv(6), b03xw.boring_elv(6), b03xw.boring_elv(5)];
b03xw.layer.x6 = b03xw.bor_stickx; % 'SW-SM'
b03xw.layer.y6 = [b03xw.boring_elv(6), b03xw.boring_elv(7), b03xw.boring_elv(7), b03xw.boring_elv(6)];
b03xw.layer.x7 = b03xw.bor_stickx; % 'CL SOFT W SAND'
b03xw.layer.y7 = [b03xw.boring_elv(7), b03xw.boring_elv(8), b03xw.boring_elv(8), b03xw.boring_elv(7)];
b03xw.layer.x8 = b03xw.bor_stickx; % 'CL MEDIUM STIFF'
b03xw.layer.y8 = [b03xw.boring_elv(8), b03xw.boring_elv(9), b03xw.boring_elv(9), b03xw.boring_elv(8)];
b03xw.samples = 63.16624 - [30, 40, 45, 50]; % 40 has zero recovery 
% offset = 107.25 ft N
b03xw.mdotsu.peakx = [0.74, 0.74, 0.63, 0.56, 0.45, 0.46, 0.51, 0.41, NaN, 0.57, 0.57, 0.46, ...
                      0.66, 0.78, 0.46, 0.79].*1000;
b03xw.mdotsu.peaky = 63.16624 - [21, 22, 26, 27, 33, 34, 36, 37, 43, 44, 48, 49, ... 
                                 53, 54, 56, 57];
b03xw.mdotsu.remoldedx = [0.12, 0.12, 0.05, 0.03, 0.0, 0.0, 0.0, 0.0, NaN, 0.0, 0.0, 0.0, ...
                          0.0, 0.0, 0.0, 0.02].*1000;
b03xw.mdotsu.remoldedy = b03xw.mdotsu.peaky;

clear surf_elv surf_dist boring_elv boring_class bor_midx;
clear b02xw_data b03xw_data;

% Colors ==================================================================
% have to change it to geotechnical symbols or whatever liek lean clay or
% clean sand

col.asphalt = [82, 82, 82]./255;
col.topsoil = [129, 148, 124]./255;
col.fill = [166, 129, 91]./255;
col.sand = [214, 161, 62]./255;
col.clay = [134, 159, 166]./255;
