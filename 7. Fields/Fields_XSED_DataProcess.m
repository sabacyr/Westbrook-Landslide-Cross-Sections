% PROCESSES CROSS SECTIONS CPT AND BORING DATA BASED ON ELEVATION. X SPACING IS USER DEFINED IN ARCGIS.

%% INPUT SPREADSHEETS 
clear all; close all; clc;

c01xwf_data = readtable("Fields XS.xlsx","Sheet", 3);
c01xff_data = readtable("Fields XS.xlsx","Sheet", 5);

b01xwf_data = readtable("Fields XS.xlsx", 'Sheet', 4);
b01xff_data = readtable("Fields XS.xlsx", 'Sheet', 6);

%% INPUT CPT ELEVATION, SHEAR STRENGTH, & RESISTIVITY DATA

% C-01XWF ==================================================================

c01xwf_data = table2array(c01xwf_data(:, [1, 2, 4, 5, 6]));
cpt_elv = 45.42144 - c01xwf_data(:, 3) ; % hole's elevation - cpt depth values
cpt_su = (c01xwf_data(:, 4).*2000.*15)./19.5; % shear strength conversion from tsf to psf
cpt_res = c01xwf_data(:, 5); % resistivity
c01xwf = struct('raw', c01xwf_data, 'surf_elv', c01xwf_data(:, 1), ...
              'surf_dist', c01xwf_data(:, 2), 'cpt_elv', cpt_elv, ...
              'cpt_su', cpt_su, 'cpt_res', cpt_res);
cpt_midx = (c01xwf.surf_dist(36)+c01xwf.surf_dist(37))/2; % find on arcgis
c01xwf.cpt_stickx = [cpt_midx-2, cpt_midx-2, cpt_midx+2, cpt_midx+2];
c01xwf.cpt_sticky = [cpt_elv(1), cpt_elv(end), cpt_elv(end), cpt_elv(1)];
c01xwf.cpt_water = 45.42144 - 14; % find from ue cpt data didn't have the data
% offset =  3.98 ft S % find on arcgis

% C-01XFF ==================================================================

c01xff_data = table2array(c01xff_data(:, [1, 2, 4, 5, 6]));
cpt_elv = 47.98968 - c01xff_data(:, 3) ; % hole's elevation - cpt depth values
cpt_su = (c01xff_data(:, 4).*2000.*15)./19.5; % shear strength conversion from tsf to psf
cpt_res = c01xff_data(:, 5); % resistivity
c01xff = struct('raw', c01xff_data, 'surf_elv', c01xff_data(:, 1), ...
              'surf_dist', c01xff_data(:, 2), 'cpt_elv', cpt_elv, ...
              'cpt_su', cpt_su, 'cpt_res', cpt_res);
cpt_midx = c01xff.surf_dist(57); % find on arcgis
c01xff.cpt_stickx = [cpt_midx-2, cpt_midx-2, cpt_midx+2, cpt_midx+2];
c01xff.cpt_sticky = [cpt_elv(1), cpt_elv(end), cpt_elv(end), cpt_elv(1)];
c01xff.cpt_water = 47.98968 - 10; % find from ue cpt data didn't have the data
% offset =  261.93 ft N % find on arcgis

clear  c01xwf_data c01xff_data cpt_elv cpt_su cpt_res cpt_midx ans i; 

%% INPUT BORING ELEVATION & SOIL TYPE

% B-01XWF ==================================================================

surf_elv = table2array(b01xwf_data(2:end, 1));
surf_dist = table2array(b01xwf_data(2:end, 2));
boring_elv = 45.42144 - table2array(b01xwf_data(1:9, 4));
boring_class = string(table2cell(b01xwf_data(1:9, 5)));
b01xwf = struct('raw', b01xwf_data, 'surf_elv', surf_elv, ...
               'surf_dist', surf_dist, 'boring_elv', boring_elv, ...
               'boring_class', boring_class);
bor_midx = b01xwf.surf_dist(36); % find on arcgis
b01xwf.bor_stickx = [bor_midx+10, bor_midx+10, bor_midx+20, bor_midx+20];
b01xwf.bor_sticky = [boring_elv(1), boring_elv(end), boring_elv(end), boring_elv(1)];
b01xwf.bor_water = 45.42144 - 16; % find from boring log
b01xwf.layer.x1 = b01xwf.bor_stickx; % 'TOPSOIL'
b01xwf.layer.y1 = [b01xwf.boring_elv(1), b01xwf.boring_elv(2), b01xwf.boring_elv(2), b01xwf.boring_elv(1)];
b01xwf.layer.x2 = b01xwf.bor_stickx; % 'FILL'
b01xwf.layer.y2 = [b01xwf.boring_elv(2), b01xwf.boring_elv(3), b01xwf.boring_elv(3), b01xwf.boring_elv(2)];
b01xwf.layer.x3 = b01xwf.bor_stickx; % 'VERY STIFF CL'
b01xwf.layer.y3 = [b01xwf.boring_elv(3), b01xwf.boring_elv(4), b01xwf.boring_elv(4), b01xwf.boring_elv(3)];
b01xwf.layer.x4 = b01xwf.bor_stickx; % 'SAND'
b01xwf.layer.y4 = [b01xwf.boring_elv(4), b01xwf.boring_elv(6), b01xwf.boring_elv(6), b01xwf.boring_elv(4)];
b01xwf.layer.x5 = b01xwf.bor_stickx; % 'SOFT CL'
b01xwf.layer.y5 = [b01xwf.boring_elv(6), b01xwf.boring_elv(7), b01xwf.boring_elv(7), b01xwf.boring_elv(6)];
b01xwf.layer.x6 = b01xwf.bor_stickx; % 'MEDIUM STIFF CL'
b01xwf.layer.y6 = [b01xwf.boring_elv(7), b01xwf.boring_elv(8), b01xwf.boring_elv(8), b01xwf.boring_elv(7)];
b01xwf.layer.x7 = b01xwf.bor_stickx; % 'SAND'
b01xwf.layer.y7 = [b01xwf.boring_elv(8), b01xwf.boring_elv(9), b01xwf.boring_elv(9), b01xwf.boring_elv(8)];
b01xwf.samples = 45.42144 - [25, 30]; 
% offset = 0 ft S
b01xwf.mdotsu.peakx = [0.61, 0.69, 0.03, 0.75].*1000;
b01xwf.mdotsu.peaky = 45.42144 - [28, 29, 33, 34];
b01xwf.mdotsu.remoldedx = [0.07, 0.09, 0, 0.10].*1000;
b01xwf.mdotsu.remoldedy = b01xwf.mdotsu.peaky;

% B-01XFF ==================================================================

surf_elv = table2array(b01xff_data(2:end, 1));
surf_dist = table2array(b01xff_data(2:end, 2));
boring_elv = 47.98968 - table2array(b01xff_data(1:8, 4));
boring_class = string(table2cell(b01xff_data(1:8, 5)));
b01xff = struct('raw', b01xff_data, 'surf_elv', surf_elv, ...
               'surf_dist', surf_dist, 'boring_elv', boring_elv, ...
               'boring_class', boring_class);
bor_midx = b01xff.surf_dist(56); % find on arcgis
b01xff.bor_stickx = [bor_midx-5, bor_midx-5, bor_midx+5, bor_midx+5];
b01xff.bor_sticky = [boring_elv(1), boring_elv(end), boring_elv(end), boring_elv(1)];
b01xff.bor_water = 47.98968 - 11.5; % find from boring log
b01xff.layer.x1 = b01xff.bor_stickx; % 'TOPSOIL'
b01xff.layer.y1 = [b01xff.boring_elv(1), b01xff.boring_elv(2), b01xff.boring_elv(2), b01xff.boring_elv(1)];
b01xff.layer.x2 = b01xff.bor_stickx; % 'SAND'
b01xff.layer.y2 = [b01xff.boring_elv(2), b01xff.boring_elv(3), b01xff.boring_elv(3), b01xff.boring_elv(2)];
b01xff.layer.x3 = b01xff.bor_stickx; % 'MEDIUM STIFF CL'
b01xff.layer.y3 = [b01xff.boring_elv(3), b01xff.boring_elv(4), b01xff.boring_elv(4), b01xff.boring_elv(3)];
b01xff.layer.x4 = b01xff.bor_stickx; % 'SAND'
b01xff.layer.y4 = [b01xff.boring_elv(4), b01xff.boring_elv(5), b01xff.boring_elv(5), b01xff.boring_elv(4)];
b01xff.layer.x5 = b01xff.bor_stickx; % 'MEDIUM STIFF CL W SAND'
b01xff.layer.y5 = [b01xff.boring_elv(5), b01xff.boring_elv(6), b01xff.boring_elv(6), b01xff.boring_elv(5)];
b01xff.layer.x6 = b01xff.bor_stickx; % 'SOFT CL'
b01xff.layer.y6 = [b01xff.boring_elv(6), b01xff.boring_elv(7), b01xff.boring_elv(7), b01xff.boring_elv(6)];
b01xff.layer.x7 = b01xff.bor_stickx; % 'SOFT CL WITH SAND'
b01xff.layer.y7 = [b01xff.boring_elv(7), b01xff.boring_elv(8), b01xff.boring_elv(8), b01xff.boring_elv(7)];
b01xff.samples = 47.98968 - [13, 19]; 
% offset = 253.22 ft N
b01xff.mdotsu.peakx = [0.38, 0.42, 0.28, 0.42].*1000;
b01xff.mdotsu.peaky = 47.98968 - [16, 17, 22, 23];
b01xff.mdotsu.remoldedx = [0.11, 0.15, 0.05, 0.02].*1000;
b01xff.mdotsu.remoldedy = b01xff.mdotsu.peaky;

clear surf_elv surf_dist boring_elv boring_class bor_midx;
clear b01xwf_data b01xff_data;

% Colors ==================================================================
% have to change it to geotechnical symbols or whatever liek lean clay or
% clean sand

col.asphalt = [82, 82, 82]./255;
col.topsoil = [129, 148, 124]./255;
col.fill = [166, 129, 91]./255;
col.sand = [214, 161, 62]./255;
col.clay = [134, 159, 166]./255;
