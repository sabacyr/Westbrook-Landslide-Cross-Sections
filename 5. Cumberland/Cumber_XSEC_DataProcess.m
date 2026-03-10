% PROCESSES CROSS SECTIONS CPT AND BORING DATA BASED ON ELEVATION. X SPACING IS USER DEFINED IN ARCGIS.

%% INPUT SPREADSHEETS 
clear all; close all; clc;

c01c_data = readtable("Cumber XS.xlsx","Sheet", 3);
c02xc_data = readtable("Cumber XS.xlsx","Sheet", 4);
c10c_data = readtable("Cumber XS.xlsx","Sheet", 6);
c09xc_data = readtable("Cumber XS.xlsx","Sheet", 7);
c08c_data = readtable("Cumber XS.xlsx","Sheet", 9);
c07c_data = readtable("Cumber XS.xlsx","Sheet", 12);
c06xc_data = readtable("Cumber XS.xlsx","Sheet", 13);

b02xc_data = readtable("Cumber XS.xlsx","Sheet", 5);
b09xc_data = readtable("Cumber XS.xlsx","Sheet", 8);
b06xc_data = readtable("Cumber XS.xlsx","Sheet", 14);

%% INPUT CPT ELEVATION, SHEAR STRENGTH, & RESISTIVITY DATA

% C-01C ==================================================================

c01c_data = table2array(c01c_data(:, [1, 2, 4, 5, 6]));
cpt_elv = 80.1 - c01c_data(:, 3) ; % hole's elevation - cpt depth values
cpt_su = (c01c_data(:, 4).*2000.*15)./19.5; % shear strength conversion from tsf to psf
cpt_res = c01c_data(:, 5); % resistivity
c01c = struct('raw', c01c_data, 'surf_elv', c01c_data(:, 1), ...
              'surf_dist', c01c_data(:, 2), 'cpt_elv', cpt_elv, ...
              'cpt_su', cpt_su, 'cpt_res', cpt_res);
cpt_midx = c01c.surf_dist(6); % find on arcgis
c01c.cpt_stickx = [cpt_midx-5, cpt_midx-5, cpt_midx+5, cpt_midx+5];
c01c.cpt_sticky = [cpt_elv(1), cpt_elv(end), cpt_elv(end), cpt_elv(1)];
c01c.cpt_water = 80.1 - 40; % find from ue cpt data
% offset = 2 ft S

% C-02XC ==================================================================

c02xc_data = table2array(c02xc_data(:, [1, 2, 4, 5, 6]));
cpt_elv = 68.0272 - c02xc_data(:, 3) ; % hole's elevation - cpt depth values
cpt_su = (c02xc_data(:, 4).*2000.*15)./19.5; % shear strength conversion from tsf to psf
cpt_res = c02xc_data(:, 5); % resistivity
c02xc = struct('raw', c02xc_data, 'surf_elv', c02xc_data(:, 1), ...
              'surf_dist', c02xc_data(:, 2), 'cpt_elv', cpt_elv, ...
              'cpt_su', cpt_su, 'cpt_res', cpt_res);
cpt_midx = c02xc.surf_dist(66); % find on arcgis
c02xc.cpt_stickx = [cpt_midx-5, cpt_midx-5, cpt_midx+5, cpt_midx+5];
c02xc.cpt_sticky = [cpt_elv(1), cpt_elv(end), cpt_elv(end), cpt_elv(1)];
c02xc.cpt_water = 68.0272 - 15; % find from ue cpt data
% offset = 273.9 ft S

% C-10c ==================================================================

c10c_data = table2array(c10c_data(:, [1, 2, 4, 5, 6]));
cpt_elv = 42.32184 - c10c_data(:, 3) ; % hole's elevation - cpt depth values
cpt_su = (c10c_data(:, 4).*2000.*15)./19.5; % shear strength conversion from tsf to psf
cpt_res = c10c_data(:, 5); % resistivity
c10c = struct('raw', c10c_data, 'surf_elv', c10c_data(:, 1), ...
              'surf_dist', c10c_data(:, 2), 'cpt_elv', cpt_elv, ...
              'cpt_su', cpt_su, 'cpt_res', cpt_res);
cpt_midx = c10c.surf_dist(142); % find on arcgis
c10c.cpt_stickx = [cpt_midx-5, cpt_midx-5, cpt_midx+5, cpt_midx+5];
c10c.cpt_sticky = [cpt_elv(1), cpt_elv(end), cpt_elv(end), cpt_elv(1)];
c10c.cpt_water = 42.32184 - 10; % find from ue cpt data didn't have the data
% offset = 27.57 ft S

% C-09XC ==================================================================

c09xc_data = table2array(c09xc_data(:, [1, 2, 4, 5, 6]));
cpt_elv = 37.47728 - c09xc_data(:, 3) ; % hole's elevation - cpt depth values
cpt_su = (c09xc_data(:, 4).*2000.*15)./19.5; % shear strength conversion from tsf to psf
cpt_res = c09xc_data(:, 5); % resistivity
c09xc = struct('raw', c09xc_data, 'surf_elv', c09xc_data(:, 1), ...
              'surf_dist', c09xc_data(:, 2), 'cpt_elv', cpt_elv, ...
              'cpt_su', cpt_su, 'cpt_res', cpt_res);
cpt_midx = (c09xc.surf_dist(177) + c09xc.surf_dist(178))/2; % find on arcgis
c09xc.cpt_stickx = [cpt_midx-5, cpt_midx-5, cpt_midx+5, cpt_midx+5];
c09xc.cpt_sticky = [cpt_elv(1), cpt_elv(end), cpt_elv(end), cpt_elv(1)];
c09xc.cpt_water = 37.47728 - 10; % find from ue cpt data didn't have the data
% offset = 38.22 ft S

% C-08C ==================================================================

c08c_data = table2array(c08c_data(:, [1, 2, 4, 5, 6]));
cpt_elv = 33.3576 - c08c_data(:, 3) ; % hole's elevation - cpt depth values
cpt_su = (c08c_data(:, 4).*2000.*15)./19.5; % shear strength conversion from tsf to psf
cpt_res = c08c_data(:, 5); % resistivity
c08c = struct('raw', c08c_data, 'surf_elv', c08c_data(:, 1), ...
              'surf_dist', c08c_data(:, 2), 'cpt_elv', cpt_elv, ...
              'cpt_su', cpt_su, 'cpt_res', cpt_res);
cpt_midx = c08c.surf_dist(227); % find on arcgis
c08c.cpt_stickx = [cpt_midx-5, cpt_midx-5, cpt_midx+5, cpt_midx+5];
c08c.cpt_sticky = [cpt_elv(1), cpt_elv(end), cpt_elv(end), cpt_elv(1)];
c08c.cpt_water = 33.3576 - 10; % find from ue cpt data didn't have the data
% offset = 61.10 ft S

% C-07C ==================================================================

c07c_data = table2array(c07c_data(:, [1, 2, 4, 5, 6]));
cpt_elv = 30.61552 - c07c_data(:, 3) ; % hole's elevation - cpt depth values
cpt_su = (c07c_data(:, 4).*2000.*15)./19.5; % shear strength conversion from tsf to psf
cpt_res = c07c_data(:, 5); % resistivity
c07c = struct('raw', c07c_data, 'surf_elv', c07c_data(:, 1), ...
              'surf_dist', c07c_data(:, 2), 'cpt_elv', cpt_elv, ...
              'cpt_su', cpt_su, 'cpt_res', cpt_res);
cpt_midx = (c07c.surf_dist(265) + c07c.surf_dist(266))/2; % find on arcgis
c07c.cpt_stickx = [cpt_midx-5, cpt_midx-5, cpt_midx+5, cpt_midx+5];
c07c.cpt_sticky = [cpt_elv(1), cpt_elv(end), cpt_elv(end), cpt_elv(1)];
c07c.cpt_water = 30.61552 - 10; % find from ue cpt data didn't have the data
% offset = 5.28 ft S

% C-06XC ==================================================================

c06xc_data = table2array(c06xc_data(:, [1, 2, 4, 5, 6]));
cpt_elv = 25.0264 - c06xc_data(:, 3) ; % hole's elevation - cpt depth values
cpt_su = (c06xc_data(:, 4).*2000.*15)./19.5; % shear strength conversion from tsf to psf

cpt_res = c06xc_data(:, 5); % resistivity
c06xc = struct('raw', c06xc_data, 'surf_elv', c06xc_data(:, 1), ...
              'surf_dist', c06xc_data(:, 2), 'cpt_elv', cpt_elv, ...
              'cpt_su', cpt_su, 'cpt_res', cpt_res);
cpt_midx = c06xc.surf_dist(297); % find on arcgis
c06xc.cpt_stickx = [cpt_midx-5, cpt_midx-5, cpt_midx+5, cpt_midx+5];
c06xc.cpt_sticky = [cpt_elv(1), cpt_elv(end), cpt_elv(end), cpt_elv(1)];
c06xc.cpt_water = 25.0264 - 6; % find from ue cpt data didn't have the data
% offset = 404.37 ft N

clear c07c_data c06xc_data c08c_data c10c_data c01c_data c02xc_data;
clear c09xc_data cpt_elv cpt_su cpt_res cpt_midx ans i; 

%% INPUT BORING ELEVATION & SOIL TYPE

% B-02XC ==================================================================

surf_elv = table2array(b02xc_data(2:end, 1));
surf_dist = table2array(b02xc_data(2:end, 2));
boring_elv = 66.96448 - table2array(b02xc_data(1:7, 4));
boring_class = string(table2cell(b02xc_data(1:7, 5)));
b02xc = struct('raw', b02xc_data, 'surf_elv', surf_elv, ...
               'surf_dist', surf_dist, 'boring_elv', boring_elv, ...
               'boring_class', boring_class);
bor_midx = c01c.surf_dist(64); % find on arcgis
b02xc.bor_stickx = [bor_midx-10, bor_midx-10, bor_midx+10, bor_midx+10];
b02xc.bor_sticky = [boring_elv(1), boring_elv(end), boring_elv(end), boring_elv(1)];
b02xc.bor_water = 66.96448 - 11; % find from boring log
b02xc.layer.x1 = b02xc.bor_stickx; % TOPSOIL
b02xc.layer.y1 = [b02xc.boring_elv(1), b02xc.boring_elv(2), b02xc.boring_elv(2), b02xc.boring_elv(1)];
b02xc.layer.x2 = b02xc.bor_stickx; % ''SW'
b02xc.layer.y2 = [b02xc.boring_elv(2), b02xc.boring_elv(3), b02xc.boring_elv(3), b02xc.boring_elv(2)];
b02xc.layer.x3 = b02xc.bor_stickx; % 'SM'
b02xc.layer.y3 = [b02xc.boring_elv(3), b02xc.boring_elv(4), b02xc.boring_elv(4), b02xc.boring_elv(3)];
b02xc.layer.x4 = b02xc.bor_stickx; % 'VERY SOFT CL W SAND'
b02xc.layer.y4 = [b02xc.boring_elv(4), b02xc.boring_elv(5), b02xc.boring_elv(5), b02xc.boring_elv(4)];
b02xc.layer.x5 = b02xc.bor_stickx; % 'SM'
b02xc.layer.y5 = [b02xc.boring_elv(5), b02xc.boring_elv(6), b02xc.boring_elv(6), b02xc.boring_elv(5)];
b02xc.layer.x6 = b02xc.bor_stickx; % 'MEDIUM STIFF CL'
b02xc.layer.y6 = [b02xc.boring_elv(6), b02xc.boring_elv(7), b02xc.boring_elv(7), b02xc.boring_elv(6)];
b02xc.samples = 66.96448 - [30, 40, 60, 85];
% offset 273.75 ft S
b02xc.mdotsu.peakx = [0.73, 0.72, 0.64, 0.72, 0.63, 0.70].*1000;
b02xc.mdotsu.peaky = 66.96448 - [33, 34, 43, 44, 63, 64];
b02xc.mdotsu.remoldedx = [0.14, 0.10, 0.10, 0.11, 0.0, 0.0].*1000;
b02xc.mdotsu.remoldedy = b02xc.mdotsu.peaky;
b02xc.gzasu.peakx = [783, 814, 814, 764, 783, 634, 879, 1180];
b02xc.gzasu.peaky = 66.96448 - [53.9, 57.5, 60, 64, 74, 80, 90, 100];
b02xc.gzasu.remoldedx = [34, 24, 23, 34, 23, 34, 23, NaN];
b02xc.gzasu.remoldedy = b02xc.gzasu.peaky;

% B-09XC ==================================================================

surf_elv = table2array(b09xc_data(2:end, 1));
surf_dist = table2array(b09xc_data(2:end, 2));
boring_elv = 37.47728 - table2array(b09xc_data(1:15, 4));
boring_class = string(table2cell(b09xc_data(1:15, 5)));
b09xc = struct('raw', b09xc_data, 'surf_elv', surf_elv, ...
               'surf_dist', surf_dist, 'boring_elv', boring_elv, ...
               'boring_class', boring_class);
bor_midx = c10c.surf_dist(178); % find on arcgis
b09xc.bor_stickx = [bor_midx+5, bor_midx+5, bor_midx+25, bor_midx+25];
b09xc.bor_sticky = [boring_elv(1), boring_elv(end), boring_elv(end), boring_elv(1)];
b09xc.bor_water = 37.47728 - 4; % find from boring log
b09xc.layer.x1 = b09xc.bor_stickx; % topsoil
b09xc.layer.y1 = [b09xc.boring_elv(1), b09xc.boring_elv(2), b09xc.boring_elv(2), b09xc.boring_elv(1)];
b09xc.layer.x2 = b09xc.bor_stickx; % 'SW'
b09xc.layer.y2 = [b09xc.boring_elv(2), b09xc.boring_elv(4), b09xc.boring_elv(4), b09xc.boring_elv(2)];
b09xc.layer.x3 = b09xc.bor_stickx; % SM
b09xc.layer.y3 = [b09xc.boring_elv(4), b09xc.boring_elv(5), b09xc.boring_elv(5), b09xc.boring_elv(4)];
b09xc.layer.x4 = b09xc.bor_stickx; % 'VERY SOFT CL'
b09xc.layer.y4 = [b09xc.boring_elv(5), b09xc.boring_elv(6), b09xc.boring_elv(6), b09xc.boring_elv(5)];
b09xc.layer.x5 = b09xc.bor_stickx; % 'SOFT CL WITH SAND'
b09xc.layer.y5 = [b09xc.boring_elv(6), b09xc.boring_elv(7), b09xc.boring_elv(7), b09xc.boring_elv(6)];
b09xc.layer.x6 = b09xc.bor_stickx; %  MEDIUM STIFF CL
b09xc.layer.y6 = [b09xc.boring_elv(7), b09xc.boring_elv(8), b09xc.boring_elv(8), b09xc.boring_elv(7)];
b09xc.layer.x7 = b09xc.bor_stickx; % 'MEDIUM STIFF CL WITH SAND'
b09xc.layer.y7 = [b09xc.boring_elv(8), b09xc.boring_elv(9), b09xc.boring_elv(9), b09xc.boring_elv(8)];
b09xc.layer.x8 = b09xc.bor_stickx; % 'STIFF CL'
b09xc.layer.y8 = [b09xc.boring_elv(9), b09xc.boring_elv(10), b09xc.boring_elv(10), b09xc.boring_elv(9)];
b09xc.layer.x9 = b09xc.bor_stickx; % 'SW'
b09xc.layer.y9 = [b09xc.boring_elv(10), b09xc.boring_elv(11), b09xc.boring_elv(11), b09xc.boring_elv(10)];
b09xc.layer.x10 = b09xc.bor_stickx; % 'SOFT CL'
b09xc.layer.y10 = [b09xc.boring_elv(11), b09xc.boring_elv(12), b09xc.boring_elv(12), b09xc.boring_elv(11)];
b09xc.layer.x11 = b09xc.bor_stickx; % 'MEDIUM STIFF CL'
b09xc.layer.y11 = [b09xc.boring_elv(12), b09xc.boring_elv(13), b09xc.boring_elv(13), b09xc.boring_elv(12)];
b09xc.layer.x12 = b09xc.bor_stickx; % 'STIFF CL'
b09xc.layer.y12 = [b09xc.boring_elv(13), b09xc.boring_elv(15), b09xc.boring_elv(15), b09xc.boring_elv(13)];
b09xc.samples = 37.47728 - [45, 60, 72, 85];
% offset 31.80 ft S
b09xc.mdotsu.peakx = [0.9, 0.83, 0.87, 0.88, 1.04, 0.97, 1.09, 1.15, ...
                      1.12, 1.09, 1.34, 1.08].*1000;
b09xc.mdotsu.peaky = 37.47728 - [50, 51, 58, 59, 63, 64, 70, 71, ...
                                 75, 76, 78, 79];
b09xc.mdotsu.remoldedx = [0.07, 0.04, 0.06, 0.04, 0.11, 0.07, 0.06, 0.04, ...
                          0.07, 0.09, 0.10, 0.07].*1000;
b09xc.mdotsu.remoldedy = b09xc.mdotsu.peaky;
b09xc.gzasu.peakx = [919, 845, 995, 1146, 1199, 1199];
b09xc.gzasu.peaky = 37.47728 - [46.5, 50, 51, 63, 74, 86];
b09xc.gzasu.remoldedx = [105, 118, NaN, 80, 68, 93];
b09xc.gzasu.remoldedy = b09xc.gzasu.peaky;

% B-06XC ==================================================================

surf_elv = table2array(b06xc_data(2:end, 1));
surf_dist = table2array(b06xc_data(2:end, 2));
boring_elv = 26.27608 - table2array(b06xc_data(1:7, 4));
boring_class = string(table2cell(b06xc_data(1:7, 5)));
b06xc = struct('raw', b06xc_data, 'surf_elv', surf_elv, ...
               'surf_dist', surf_dist, 'boring_elv', boring_elv, ...
               'boring_class', boring_class);
bor_midx = c08c.surf_dist(298); % find on arcgis
b06xc.bor_stickx = [bor_midx, bor_midx, bor_midx+20, bor_midx+20];
b06xc.bor_sticky = [boring_elv(1), boring_elv(end), boring_elv(end), boring_elv(1)];
b06xc.bor_water = 26.27608 - 5; % find from boring log
b06xc.layer.x1 = b06xc.bor_stickx; % SW
b06xc.layer.y1 = [b06xc.boring_elv(1), b06xc.boring_elv(2), b06xc.boring_elv(2), b06xc.boring_elv(1)];
b06xc.layer.x2 = b06xc.bor_stickx; % VERY STIFF CL W SAND
b06xc.layer.y2 = [b06xc.boring_elv(2), b06xc.boring_elv(3), b06xc.boring_elv(3), b06xc.boring_elv(2)];
b06xc.layer.x3 = b06xc.bor_stickx; % SM
b06xc.layer.y3 = [b06xc.boring_elv(3), b06xc.boring_elv(4), b06xc.boring_elv(4), b06xc.boring_elv(3)];
b06xc.layer.x4 = b06xc.bor_stickx; % 'SW'
b06xc.layer.y4 = [b06xc.boring_elv(4), b06xc.boring_elv(5), b06xc.boring_elv(5), b06xc.boring_elv(4)];
b06xc.layer.x5 = b06xc.bor_stickx; % 'MEDIM STIFF CL'
b06xc.layer.y5 = [b06xc.boring_elv(5), b06xc.boring_elv(7), b06xc.boring_elv(7), b06xc.boring_elv(5)];
b06xc.samples = 26.27608 - [40, 50, 60];
% offset 403.96 ft N
b06xc.mdotsu.peakx = [0.63, 0.61, 0.59, 0.52, 0.54, 0.6, 0.67, ...
                      0.56, 0.63, 0.65, 0.77, 0.75, 0.92].*1000;
b06xc.mdotsu.peaky = 26.27608 - [30, 36, 37, 43, 44, 48, 49, ...
                                 53, 54, 58, 59, 63, 64];
b06xc.mdotsu.remoldedx = [0.13, 0.06, 0.05, 0.07, 0.02, 0.02, 0.03, ...
                          0.02, 0.03, 0.05, 0.05, 0.05, 0.03].*1000;
b06xc.mdotsu.remoldedy = b06xc.mdotsu.peaky;

clear surf_elv surf_dist boring_elv boring_class bor_midx;
clear b02xc_data b09xc_data b06xc_data;

% Colors ==================================================================
% have to change it to geotechnical symbols or whatever liek lean clay or
% clean sand

col.asphalt = [82, 82, 82]./255;
col.topsoil = [129, 148, 124]./255;
col.fill = [166, 129, 91]./255;
col.sand = [214, 161, 62]./255;
col.clay = [134, 159, 166]./255;
