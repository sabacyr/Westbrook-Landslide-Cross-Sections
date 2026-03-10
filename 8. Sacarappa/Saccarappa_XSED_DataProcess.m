% PROCESSES CROSS SECTIONS CPT AND BORING DATA BASED ON ELEVATION. X SPACING IS USER DEFINED IN ARCGIS.

%% INPUT SPREADSHEETS 
clear all; close all; clc;

c01s_data = readtable("Saccarappa XS.xlsx","Sheet", 3);
c02s_data = readtable("Saccarappa XS.xlsx","Sheet", 4);
c02bp_data = readtable("Saccarappa XS.xlsx","Sheet", 5);


%% INPUT CPT ELEVATION, SHEAR STRENGTH, & RESISTIVITY DATA

% C-01S ==================================================================

c01s_data = table2array(c01s_data(:, [1, 2, 4, 5, 6]));
cpt_elv = 55.7 - c01s_data(:, 3) ; % hole's elevation - cpt depth values
cpt_su = (c01s_data(:, 4).*2000.*15)./19; % shear strength conversion from tsf to psf
cpt_res = c01s_data(:, 5); % resistivity
c01s = struct('raw', c01s_data, 'surf_elv', c01s_data(:, 1), ...
              'surf_dist', c01s_data(:, 2), 'cpt_elv', cpt_elv, ...
              'cpt_su', cpt_su, 'cpt_res', cpt_res);
cpt_midx = c01s.surf_dist(78); % find on arcgis
c01s.cpt_stickx = [cpt_midx-5, cpt_midx-5, cpt_midx+5, cpt_midx+5];
c01s.cpt_sticky = [cpt_elv(1), cpt_elv(end), cpt_elv(end), cpt_elv(1)];
c01s.cpt_water = 55.7 - 12; % find from ue cpt data didn't have the data
% offset =  384.55 ft E % find on arcgis

% C-02S ==================================================================

c02s_data = table2array(c02s_data(:, [1, 2, 4, 5, 6]));
cpt_elv = 58.3 - c02s_data(:, 3) ; % hole's elevation - cpt depth values
cpt_su = (c02s_data(:, 4).*2000.*15)./19; % shear strength conversion from tsf to psf
cpt_res = c02s_data(:, 5); % resistivity
c02s = struct('raw', c02s_data, 'surf_elv', c02s_data(:, 1), ...
              'surf_dist', c02s_data(:, 2), 'cpt_elv', cpt_elv, ...
              'cpt_su', cpt_su, 'cpt_res', cpt_res);
cpt_midx = c02s.surf_dist(83); % find on arcgis
c02s.cpt_stickx = [cpt_midx-5, cpt_midx-5, cpt_midx+5, cpt_midx+5];
c02s.cpt_sticky = [cpt_elv(1), cpt_elv(end), cpt_elv(end), cpt_elv(1)];
c02s.cpt_water = 58.3 - 16; % find from ue cpt data didn't have the data
% offset =   % find on arcgis

% C-02BP ==================================================================

c02bp_data = table2array(c02bp_data(:, [1, 2, 4, 5, 6]));
cpt_elv = 83.63136 - c02bp_data(:, 3) ; % hole's elevation - cpt depth values
cpt_su = (c02bp_data(:, 4).*2000.*15)./19; % shear strength conversion from tsf to psf
cpt_res = c02bp_data(:, 5); % resistivity
c02bp = struct('raw', c02bp_data, 'surf_elv', c02bp_data(:, 1), ...
              'surf_dist', c02bp_data(:, 2), 'cpt_elv', cpt_elv, ...
              'cpt_su', cpt_su, 'cpt_res', cpt_res);
cpt_midx = c02bp.surf_dist(246); % find on arcgis
c02bp.cpt_stickx = [cpt_midx-5, cpt_midx-5, cpt_midx+5, cpt_midx+5];
c02bp.cpt_sticky = [cpt_elv(1), cpt_elv(end), cpt_elv(end), cpt_elv(1)];
c02bp.cpt_water = 83.63136 - 30; % find from ue cpt data didn't have the data
% offset =   % find on arcgis

clear  c01s_data c02s_data c02bp_data c02bp_data cpt_elv cpt_su cpt_res cpt_midx ans i; 

%% INPUT BORING ELEVATION & SOIL TYPE


% Colors ==================================================================
% have to change it to geotechnical symbols or whatever liek lean clay or
% clean sand

col.asphalt = [82, 82, 82]./255;
col.topsoil = [129, 148, 124]./255;
col.fill = [166, 129, 91]./255;
col.sand = [214, 161, 62]./255;
col.clay = [134, 159, 166]./255;
