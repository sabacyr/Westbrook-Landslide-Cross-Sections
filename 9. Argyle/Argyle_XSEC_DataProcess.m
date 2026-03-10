% PROCESSES CROSS SECTIONS CPT AND BORING DATA BASED ON ELEVATION. X SPACING IS USER DEFINED IN ARCGIS.

%% INPUT SPREADSHEETS 
clear all; close all; clc;

c01xa_data = readtable("Argyle XS.xlsx","Sheet", 1);
c02xa_data = readtable("Argyle XS.xlsx","Sheet", 2);
c03xa_data = readtable("Argyle XS.xlsx","Sheet", 3);
presurf = table2array(readtable("Argyle XS.xlsx", 'Sheet', 4));
b01xa_data = readtable("Argyle XS.xlsx","Sheet", 5);
b02xa_data = readtable("Argyle XS.xlsx","Sheet", 6);
b03xa_data = readtable("Argyle XS.xlsx","Sheet", 7);
post_bathymetry = table2array(readtable("Argyle XS.xlsx", 'Sheet', 8));



%% INPUT CPT ELEVATION, SHEAR STRENGTH, & RESISTIVITY DATA

% C-01XA ==================================================================

c01xa_data = table2array(c01xa_data(:, [1, 2, 4, 5, 6]));
cpt_elv = 135.7899813794 - c01xa_data(:, 3) ; % hole's elevation - cpt depth values converted to ft
cpt_su = c01xa_data(:, 4); % shear strength is already in psf Nk is 15
cpt_res = c01xa_data(:, 5); % resistivity
c01xa = struct('raw', c01xa_data, 'surf_elv', c01xa_data(:, 1), ...
              'surf_dist', c01xa_data(:, 2), 'cpt_elv', cpt_elv, ...
              'cpt_su', cpt_su, 'cpt_res', cpt_res);
cpt_midx = c01xa.surf_dist(12); % find on arcgis
c01xa.cpt_stickx = [cpt_midx-0.75, cpt_midx-0.75, cpt_midx+0.75, cpt_midx+0.75];
c01xa.cpt_sticky = [cpt_elv(1), cpt_elv(end), cpt_elv(end), cpt_elv(1)];
c01xa.cpt_water = 135.7899813794 - 14.5; % find from ue cpt data didn't have the data
% offset =  0 % find on arcgis

% C-02XA ==================================================================

c02xa_data = table2array(c02xa_data(:, [1, 2, 4, 5, 6]));
cpt_elv = 133.038062 - c02xa_data(:, 3) ; % hole's elevation - cpt depth values
cpt_su = c02xa_data(:, 4); % shear strength is already in psf Nk is 15
cpt_res = c02xa_data(:, 5); % resistivity
c02xa = struct('raw', c02xa_data, 'surf_elv', c02xa_data(:, 1), ...
              'surf_dist', c02xa_data(:, 2), 'cpt_elv', cpt_elv, ...
              'cpt_su', cpt_su, 'cpt_res', cpt_res);
cpt_midx = c01xa.surf_dist(10); % find on arcgis
c02xa.cpt_stickx = [cpt_midx-0.75, cpt_midx-0.75, cpt_midx+0.75, cpt_midx+0.75];
c02xa.cpt_sticky = [cpt_elv(1), cpt_elv(end), cpt_elv(end), cpt_elv(1)];
c02xa.cpt_water = 133.038062 - 14; % find from ue cpt data didn't have the data
% offset =  0 % find on arcgis

% C-03XA ==================================================================

c03xa_data = table2array(c03xa_data(:, [1, 2, 4, 5, 6]));
cpt_elv = 135.08690392908 - c03xa_data(:, 3) ; % hole's elevation - cpt depth values
cpt_su = c03xa_data(:, 4); % shear strength is already in psf Nk is 15
cpt_res = c03xa_data(:, 5); % resistivity
c03xa = struct('raw', c03xa_data, 'surf_elv', c03xa_data(:, 1), ...
              'surf_dist', c03xa_data(:, 2), 'cpt_elv', cpt_elv, ...
              'cpt_su', cpt_su, 'cpt_res', cpt_res);
cpt_midx = c03xa.surf_dist(7); % find on arcgis
c03xa.cpt_stickx = [cpt_midx-0.75, cpt_midx-0.75, cpt_midx+0.75, cpt_midx+0.75];
c03xa.cpt_sticky = [cpt_elv(1), cpt_elv(end), cpt_elv(end), cpt_elv(1)];
c03xa.cpt_water = 135.08690392908 - 12.5; % find from ue cpt data didn't have the data
% offset =   % find on arcgis

clear  c01xa_data c02xa_data c03xa_data c03xa_data cpt_elv cpt_su cpt_res cpt_midx ans i; 

%% INPUT BORING ELEVATION & SOIL TYPE

% B-01XA ==================================================================

surf_elv = table2array(b01xa_data(2:end, 1));
surf_dist = table2array(b01xa_data(2:end, 2));
boring_elv = 135.7899813794 - table2array(b01xa_data(1:6, 4));
boring_class = string(table2cell(b01xa_data(1:6, 5)));
b01xa = struct('raw', b01xa_data, 'surf_elv', surf_elv, ...
               'surf_dist', surf_dist, 'boring_elv', boring_elv, ...
               'boring_class', boring_class);
bor_midx = c01xa.surf_dist(12)+5; % find on arcgis
b01xa.bor_stickx = [bor_midx-2.5, bor_midx-2.5, bor_midx+2.5, bor_midx+2.5];
b01xa.bor_sticky = [boring_elv(1), boring_elv(end), boring_elv(end), boring_elv(1)];
b01xa.bor_water = 135.7899813794 - 14.5; % find from boring log
b01xa.layer.x1 = b01xa.bor_stickx; % topsoil
b01xa.layer.y1 = [b01xa.boring_elv(1), b01xa.boring_elv(2), b01xa.boring_elv(2), b01xa.boring_elv(1)];
b01xa.layer.x2 = b01xa.bor_stickx; % 'FILL'
b01xa.layer.y2 = [b01xa.boring_elv(2), b01xa.boring_elv(3), b01xa.boring_elv(3), b01xa.boring_elv(2)];
b01xa.layer.x3 = b01xa.bor_stickx; % 'silty sand'
b01xa.layer.y3 = [b01xa.boring_elv(3), b01xa.boring_elv(4), b01xa.boring_elv(4), b01xa.boring_elv(3)];
b01xa.layer.x4 = b01xa.bor_stickx; % 'Very soft CL'
b01xa.layer.y4 = [b01xa.boring_elv(4), b01xa.boring_elv(5), b01xa.boring_elv(5), b01xa.boring_elv(4)];
% offset = 0 ft S
b01xa.samples = 135.7899813794 - [22, 26, 30, 34]; % 34 has zero recovery
b01xa.mdotsu.peakx = [1329, 481, 489, 470, 527, 516, 505, 514, 590, 610]; % these are already in psf
b01xa.mdotsu.peaky = 135.7899813794 - [20, 22, 25, 26, 29, 30, 33, 34, 37, 38];
b01xa.mdotsu.remoldedx = [110, 96, 118, 82, 96, 102, 107, 113, 74, 66];
b01xa.mdotsu.remoldedy = b01xa.mdotsu.peaky;

% B-02XA ==================================================================

surf_elv = table2array(b02xa_data(2:end, 1));
surf_dist = table2array(b02xa_data(2:end, 2));
boring_elv = 133.038062 - table2array(b02xa_data(1:7, 4));
boring_class = string(table2cell(b02xa_data(1:7, 5)));
b02xa = struct('raw', b02xa_data, 'surf_elv', surf_elv, ...
               'surf_dist', surf_dist, 'boring_elv', boring_elv, ...
               'boring_class', boring_class);
bor_midx = c01xa.surf_dist(10)+5; % find on arcgis
b02xa.bor_stickx = [bor_midx-2.5, bor_midx-2.5, bor_midx+2.5, bor_midx+2.5];
b02xa.bor_sticky = [boring_elv(1), boring_elv(end), boring_elv(end), boring_elv(1)];
b02xa.bor_water = 133.038062 - 14; % find from boring log
b02xa.layer.x1 = b02xa.bor_stickx; % topsoil
b02xa.layer.y1 = [b02xa.boring_elv(1), b02xa.boring_elv(2), b02xa.boring_elv(2), b02xa.boring_elv(1)];
b02xa.layer.x2 = b02xa.bor_stickx; % silty sand SW
b02xa.layer.y2 = [b02xa.boring_elv(2), b02xa.boring_elv(3), b02xa.boring_elv(3), b02xa.boring_elv(2)];
b02xa.layer.x3 = b02xa.bor_stickx; % clay w sand
b02xa.layer.y3 = [b02xa.boring_elv(3), b02xa.boring_elv(4), b02xa.boring_elv(4), b02xa.boring_elv(3)];
b02xa.layer.x4 = b02xa.bor_stickx; % clay
b02xa.layer.y4 = [b02xa.boring_elv(4), b02xa.boring_elv(5), b02xa.boring_elv(5), b02xa.boring_elv(4)];
% offset = 0
b02xa.samples = 133.038062 - [25, 30]; % 28 has zero recovery
b02xa.mdotsu.peakx = [330, 393, 508, 558];
b02xa.mdotsu.peaky = 133.038062 - [23, 24, 27, 28];
b02xa.mdotsu.remoldedx = [85, 96, 126, 121];
b02xa.mdotsu.remoldedy = b02xa.mdotsu.peaky;

clear surf_elv surf_dist boring_elv boring_class bor_midx;
clear b01xa_data b02xa_data;

% Colors ==================================================================
% have to change it to geotechnical symbols or whatever liek lean clay or
% clean sand

col.asphalt = [82, 82, 82]./255;
col.topsoil = [129, 148, 124]./255;
col.fill = [166, 129, 91]./255;
col.sand = [214, 161, 62]./255;
col.clay = [134, 159, 166]./255;
