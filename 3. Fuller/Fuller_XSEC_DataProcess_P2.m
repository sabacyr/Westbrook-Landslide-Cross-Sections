% PROCESSES CROSS SECTIONS CPT AND BORING DATA BASED ON ELEVATION. X SPACING IS USER DEFINED IN ARCGIS.

%% INPUT SPREADSHEETS 
clear all; close all; clc;

c07f_data = readtable("Fuller XS.xlsx","Sheet", 4);
c06xf_data = readtable("Fuller XS.xlsx","Sheet", 6);
c05f_data = readtable("Fuller XS.xlsx","Sheet", 13);

b06xf_data = readtable("Fuller XS.xlsx","Sheet", 7);

surf = table2array(readtable("Fuller XS.xlsx","Sheet", 14));
surf_dist = surf(:, 2); surf_elv = surf(:, 1);

%% INPUT CPT ELEVATION, SHEAR STRENGTH, & RESISTIVITY DATA

% C-07F ==================================================================

c07f_data = table2array(c07f_data(:, [1, 2, 4, 5, 6]));
cpt_elv = 68.68976 - c07f_data(:, 3) ; % hole's elevation - cpt depth values
cpt_su = (c07f_data(:, 4).*2000.*15)./19.5; % shear strength conversion from tsf to psf
cpt_res = c07f_data(:, 5); % resistivity
c07f = struct('raw', c07f_data, 'surf_elv', c07f_data(:, 1), ...
              'surf_dist', c07f_data(:, 2), 'cpt_elv', cpt_elv, ...
              'cpt_su', cpt_su, 'cpt_res', cpt_res);
cpt_midx = (surf_dist(50) + surf_dist(51))/2; % find on arcgis
c07f.cpt_stickx = [cpt_midx-5, cpt_midx-5, cpt_midx+5, cpt_midx+5];
c07f.cpt_sticky = [cpt_elv(1), cpt_elv(end), cpt_elv(end), cpt_elv(1)];
c07f.cpt_water = 68.68976 - 10; % find from ue cpt data
% offset = 9.15 ft N P2  % find on arcgis

% C-06XF ==================================================================

c06xf_data = table2array(c06xf_data(:, [1, 2, 4, 5, 6]));
cpt_elv = 58.95144 - c06xf_data(:, 3) ; % hole's elevation - cpt depth values
cpt_su = (c06xf_data(:, 4).*2000.*15)./19.5; % shear strength conversion from tsf to psf
cpt_res = c06xf_data(:, 5); % resistivity
c06xf = struct('raw', c06xf_data, 'surf_elv', c06xf_data(:, 1), ...
              'surf_dist', c06xf_data(:, 2), 'cpt_elv', cpt_elv, ...
              'cpt_su', cpt_su, 'cpt_res', cpt_res);
cpt_midx = (surf_dist(126)+surf_dist(127))/2; % find on arcgis
c06xf.cpt_stickx = [cpt_midx-5, cpt_midx-5, cpt_midx+5, cpt_midx+5];
c06xf.cpt_sticky = [cpt_elv(1), cpt_elv(end), cpt_elv(end), cpt_elv(1)];
c06xf.cpt_water = 58.95144 - 5; % find from ue cpt data didn't have the data
% offset = 76.10 ft S  % find on arcgis

% C-05F ===================================================================

c05f_data = table2array(c05f_data(:, [1, 2, 4, 5, 6]));
cpt_elv = 27.09936 - c05f_data(:, 3) ; % hole's elevation - cpt depth values
cpt_su = (c05f_data(:, 4).*2000.*15)./19.5; % shear strength conversion from tsf to psf
cpt_res = c05f_data(:, 5); % resistivity
c05f = struct('raw', c05f_data, 'surf_elv', c05f_data(:, 1), ...
              'surf_dist', c05f_data(:, 2), 'cpt_elv', cpt_elv, ...
              'cpt_su', cpt_su, 'cpt_res', cpt_res);
cpt_midx = surf_dist(214); % find on arcgis
c05f.cpt_stickx = [cpt_midx-5, cpt_midx-5, cpt_midx+5, cpt_midx+5];
c05f.cpt_sticky = [cpt_elv(1), cpt_elv(end), cpt_elv(end), cpt_elv(1)];
c05f.cpt_water = 27.09936 - 3; % find from ue cpt data didn't have the data
% offset = 155.14 ft N  % find on arcgis

clear c05f_data c07f_data;
clear c06xf_data c03h_data cpt_elv cpt_su cpt_res cpt_midx ans i; 

%% INPUT BORING ELEVATION & SOIL TYPE

% B-06XF ==================================================================

% surf_elv = table2array(b06xf_data(2:end, 1));
% surf_dist = table2array(b06xf_data(2:end, 2));
boring_elv = 58.54472 - table2array(b06xf_data(1:8, 4));
boring_class = string(table2cell(b06xf_data(1:8, 5)));
b06xf = struct('raw', b06xf_data, 'surf_elv', surf_elv, ...
               'surf_dist', surf_dist, 'boring_elv', boring_elv, ...
               'boring_class', boring_class);
bor_midx = (surf_dist(125) + surf_dist(126))/2; % find on arcgis
b06xf.bor_stickx = [bor_midx-18, bor_midx-18, bor_midx+2, bor_midx+2];
b06xf.bor_sticky = [boring_elv(1), boring_elv(end), boring_elv(end), boring_elv(1)];
b06xf.bor_water = 58.54472 - 5; % find from boring log
b06xf.layer.x1 = b06xf.bor_stickx; % asphalt
b06xf.layer.y1 = [b06xf.boring_elv(1), b06xf.boring_elv(2), b06xf.boring_elv(2), b06xf.boring_elv(1)];
b06xf.layer.x2 = b06xf.bor_stickx; % 'SW'
b06xf.layer.y2 = [b06xf.boring_elv(2), b06xf.boring_elv(3), b06xf.boring_elv(3), b06xf.boring_elv(2)];
b06xf.layer.x3 = b06xf.bor_stickx; % 'VERY SOFT CL W SAND'
b06xf.layer.y3 = [b06xf.boring_elv(3), b06xf.boring_elv(4), b06xf.boring_elv(4), b06xf.boring_elv(3)];
b06xf.layer.x4 = b06xf.bor_stickx; % 'VERY SOFT CL'
b06xf.layer.y4 = [b06xf.boring_elv(4), b06xf.boring_elv(5), b06xf.boring_elv(5), b06xf.boring_elv(4)];
b06xf.layer.x5 = b06xf.bor_stickx; % 'SM'
b06xf.layer.y5 = [b06xf.boring_elv(5), b06xf.boring_elv(6), b06xf.boring_elv(6), b06xf.boring_elv(5)];
b06xf.layer.x6 = b06xf.bor_stickx; % 'SOFT CLAY'
b06xf.layer.y6 = [b06xf.boring_elv(6), b06xf.boring_elv(7), b06xf.boring_elv(7), b06xf.boring_elv(6)];
b06xf.layer.x7 = b06xf.bor_stickx; % 'MEDIUM STIFF CLAY'
b06xf.layer.y7 = [b06xf.boring_elv(7), b06xf.boring_elv(8), b06xf.boring_elv(8), b06xf.boring_elv(7)];
b06xf.samples = 58.54472 - [35, 45, 48, 60, 76, 85]; % 45, 48 has zero recovery
% offset 75.76 ft S
b06xf.mdotsu.peakx = [0.40, 0.38, 0.42, 0.50, 0.53, 0.46 ...
                      0.52, 0.44, 0.59, 0.60, 0.46, 0.6, 0.76, 0.71, 0.95, 0.77].*1000;
b06xf.mdotsu.peaky = 58.54472 - [38, 39, 41, 42, 48, 49, ...
                                 53, 54, 56, 57, 63, 64, 66, 67, 79, 80];
b06xf.mdotsu.remoldedx = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0 ...
                          0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.02].*1000;
b06xf.mdotsu.remoldedy = b06xf.mdotsu.peaky;

clear boring_elv boring_class bor_midx;
clear b06xf_data;

% Colors ==================================================================
% have to change it to geotechnical symbols or whatever liek lean clay or
% clean sand

col.asphalt = [82, 82, 82]./255;
col.topsoil = [129, 148, 124]./255;
col.fill = [166, 129, 91]./255;
col.sand = [214, 161, 62]./255;
col.clay = [134, 159, 166]./255;
