% PROCESSES CROSS SECTIONS CPT AND BORING DATA BASED ON ELEVATION. X SPACING IS USER DEFINED IN ARCGIS.

%% INPUT SPREADSHEETS 
clear all; close all; clc;

c01f_data = readtable("Fuller XS.xlsx","Sheet", 3);
c02f_data = readtable("Fuller XS.xlsx","Sheet", 5);
c03xf_data = readtable("Fuller XS.xlsx","Sheet", 8);
c04xf_data = readtable("Fuller XS.xlsx","Sheet", 11);

b03xf_data = readtable("Fuller XS.xlsx","Sheet", 9);
b04xf_data = readtable("Fuller XS.xlsx","Sheet", 12);

%% INPUT CPT ELEVATION, SHEAR STRENGTH, & RESISTIVITY DATA

% C-01F ==================================================================

c01f_data = table2array(c01f_data(:, [1, 2, 4, 5, 6]));
cpt_elv = 67.97144 - c01f_data(:, 3) ; % hole's elevation - cpt depth values
cpt_su = (c01f_data(:, 4).*2000.*15)./19.5; % shear strength conversion from tsf to psf
% for i = 1:length(cpt_su)
%     if cpt_su(i) >= 1000
%         cpt_su(i) = nan;
%     end
% end
cpt_res = c01f_data(:, 5); % resistivity
c01f = struct('raw', c01f_data, 'surf_elv', c01f_data(:, 1), ...
              'surf_dist', c01f_data(:, 2), 'cpt_elv', cpt_elv, ...
              'cpt_su', cpt_su, 'cpt_res', cpt_res);
cpt_midx = c01f.surf_dist(24); % find on arcgis
c01f.cpt_stickx = [cpt_midx-5, cpt_midx-5, cpt_midx+5, cpt_midx+5];
c01f.cpt_sticky = [cpt_elv(1), cpt_elv(end), cpt_elv(end), cpt_elv(1)];
c01f.cpt_water = 67.97144 - 15; % find from ue cpt data
% offset = 5.33 ft S P1 % find on arcgis

% C-02F ==================================================================

c02f_data = table2array(c02f_data(:, [1, 2, 4, 5, 6]));
cpt_elv = 52 - c02f_data(:, 3) ; % hole's elevation - cpt depth values
cpt_su = (c02f_data(:, 4).*2000.*15)./19.5; % shear strength conversion from tsf to psf
% for i = 1:length(cpt_su)
%     if cpt_su(i) >= 1000
%         cpt_su(i) = nan;
%     end
% end
cpt_res = c02f_data(:, 5); % resistivity
c02f = struct('raw', c02f_data, 'surf_elv', c02f_data(:, 1), ...
              'surf_dist', c02f_data(:, 2), 'cpt_elv', cpt_elv, ...
              'cpt_su', cpt_su, 'cpt_res', cpt_res);
cpt_midx = c02f.surf_dist(68); % find on arcgis
c02f.cpt_stickx = [cpt_midx-5, cpt_midx-5, cpt_midx+5, cpt_midx+5];
c02f.cpt_sticky = [cpt_elv(1), cpt_elv(end), cpt_elv(end), cpt_elv(1)];
c02f.cpt_water = 52 - 10; % find from ue cpt data didn't have the data
% offset = 37.59 ft N  % find on arcgis

% C-03XF ==================================================================

c03xf_data = table2array(c03xf_data(:, [1, 2, 4, 5, 6]));
cpt_elv = 45 - c03xf_data(:, 3) ; % hole's elevation - cpt depth values
cpt_su = (c03xf_data(:, 4).*2000.*15)./19.5; % shear strength conversion from tsf to psf
% for i = 1:length(cpt_su)
%     if cpt_su(i) >= 1000
%         cpt_su(i) = nan;
%     end
% end
cpt_res = c03xf_data(:, 5); % resistivity
c03xf = struct('raw', c03xf_data, 'surf_elv', c03xf_data(:, 1), ...
              'surf_dist', c03xf_data(:, 2), 'cpt_elv', cpt_elv, ...
              'cpt_su', cpt_su, 'cpt_res', cpt_res);
cpt_midx = c03xf.surf_dist(145); % find on arcgis
c03xf.cpt_stickx = [cpt_midx-5, cpt_midx-5, cpt_midx+5, cpt_midx+5];
c03xf.cpt_sticky = [cpt_elv(1), cpt_elv(874), cpt_elv(874), cpt_elv(1)];
c03xf.cpt_water = 45 - 11; % find from ue cpt data didn't have the data
% offset = 0  % find on arcgis

% C-04XF ==================================================================

c04xf_data = table2array(c04xf_data(:, [1, 2, 4, 5, 6]));
cpt_elv = 37.76592 - c04xf_data(:, 3) ; % hole's elevation - cpt depth values
cpt_su = (c04xf_data(:, 4).*2000.*15)./19.5; % shear strength conversion from tsf to psf
% for i = 1:length(cpt_su)
%     if cpt_su(i) >= 1000
%         cpt_su(i) = nan;
%     end
% end
cpt_res = c04xf_data(:, 5); % resistivity
c04xf = struct('raw', c04xf_data, 'surf_elv', c04xf_data(:, 1), ...
              'surf_dist', c04xf_data(:, 2), 'cpt_elv', cpt_elv, ...
              'cpt_su', cpt_su, 'cpt_res', cpt_res);
cpt_midx = c04xf.surf_dist(225); % find on arcgis
c04xf.cpt_stickx = [cpt_midx-5, cpt_midx-5, cpt_midx+5, cpt_midx+5];
c04xf.cpt_sticky = [cpt_elv(1), cpt_elv(end), cpt_elv(end), cpt_elv(1)];
c04xf.cpt_water = 37.76592 - 10; % find from ue cpt data didn't have the data
% offset = 159.51 ft S  % find on arcgis

clear c04xf_data c03xf_data c02f_data c01f_data;
clear cpt_elv cpt_su cpt_res cpt_midx ans i; 

%% INPUT BORING ELEVATION & SOIL TYPE

% B-03XF ==================================================================

surf_elv = table2array(b03xf_data(2:end, 1));
surf_dist = table2array(b03xf_data(2:end, 2));
boring_elv = 45.2968 - table2array(b03xf_data(1:10, 4));
boring_class = string(table2cell(b03xf_data(1:10, 5)));
b03xf = struct('raw', b03xf_data, 'surf_elv', surf_elv, ...
               'surf_dist', surf_dist, 'boring_elv', boring_elv, ...
               'boring_class', boring_class);
bor_midx = surf_dist(143); % find on arcgis
b03xf.bor_stickx = [bor_midx-10, bor_midx-10, bor_midx+10, bor_midx+10];
b03xf.bor_sticky = [boring_elv(1), boring_elv(end), boring_elv(end), boring_elv(1)];
b03xf.bor_water = 45.2968 - 5; % find from boring log
b03xf.layer.x1 = b03xf.bor_stickx; % 'SM'
b03xf.layer.y1 = [b03xf.boring_elv(1), b03xf.boring_elv(2), b03xf.boring_elv(2), b03xf.boring_elv(1)];
b03xf.layer.x2 = b03xf.bor_stickx; % 'VERY SOFT CL'
b03xf.layer.y2 = [b03xf.boring_elv(2), b03xf.boring_elv(3), b03xf.boring_elv(3), b03xf.boring_elv(2)];
b03xf.layer.x3 = b03xf.bor_stickx; % 'SM'
b03xf.layer.y3 = [b03xf.boring_elv(3), b03xf.boring_elv(4), b03xf.boring_elv(4), b03xf.boring_elv(3)];
b03xf.layer.x4 = b03xf.bor_stickx; % 'VERY SOFT CL'
b03xf.layer.y4 = [b03xf.boring_elv(4), b03xf.boring_elv(5), b03xf.boring_elv(5), b03xf.boring_elv(4)];
b03xf.layer.x5 = b03xf.bor_stickx; % 'SW'
b03xf.layer.y5 = [b03xf.boring_elv(5), b03xf.boring_elv(6), b03xf.boring_elv(6), b03xf.boring_elv(5)];
b03xf.layer.x6 = b03xf.bor_stickx; % 'SM'
b03xf.layer.y6 = [b03xf.boring_elv(6), b03xf.boring_elv(7), b03xf.boring_elv(7), b03xf.boring_elv(6)];
b03xf.layer.x7 = b03xf.bor_stickx; % 'SOFT CL WITH SAND'
b03xf.layer.y7 = [b03xf.boring_elv(7), b03xf.boring_elv(8), b03xf.boring_elv(8), b03xf.boring_elv(7)];
b03xf.layer.x8 = b03xf.bor_stickx; % 'SOFT CL'
b03xf.layer.y8 = [b03xf.boring_elv(8), b03xf.boring_elv(9), b03xf.boring_elv(9), b03xf.boring_elv(8)];
b03xf.layer.x9 = b03xf.bor_stickx; % 'MEDIUM STIFF CL'
b03xf.layer.y9 = [b03xf.boring_elv(9), b03xf.boring_elv(10), b03xf.boring_elv(10), b03xf.boring_elv(9)];
b03xf.samples = 45.2968 - [30, 40, 50, 60];
% offset = 0
b03xf.mdotsu.peakx = [0.51, 0.45, 0.54, 0.49, 0.47, 0.67, 0.56, 0.62, ...
                      0.67, 0.58, 0.6, 0.77, 0.85, 0.84].*1000;
b03xf.mdotsu.peaky = 45.2968 - [33, 34, 36, 37, 43, 44, 46, 47, ...
                      53, 54, 56, 57, 63, 64];
b03xf.mdotsu.remoldedx = [0.02, 0.02, 0, 0.02, 0.02, 0.03, 0.0, 0.02, ...
                          0, 0, 0, 0, 0.02, 0].*1000;
b03xf.mdotsu.remoldedy = b03xf.mdotsu.peaky;

% B-04XF ==================================================================

surf_elv = table2array(b04xf_data(2:end, 1));
surf_dist = table2array(b04xf_data(2:end, 2));
boring_elv = 31.47816 - table2array(b04xf_data(1:10, 4));
boring_class = string(table2cell(b04xf_data(1:10, 5)));
b04xf = struct('raw', b04xf_data, 'surf_elv', surf_elv, ...
               'surf_dist', surf_dist, 'boring_elv', boring_elv, ...
               'boring_class', boring_class);
bor_midx = surf_dist(227); % find on arcgis
b04xf.bor_stickx = [bor_midx-10, bor_midx-10, bor_midx+10, bor_midx+10];
b04xf.bor_sticky = [boring_elv(1), boring_elv(end), boring_elv(end), boring_elv(1)];
b04xf.bor_water = 31.47816 - 5; % find from boring log
b04xf.layer.x1 = b04xf.bor_stickx; % 'topsoil'
b04xf.layer.y1 = [b04xf.boring_elv(1), b04xf.boring_elv(2), b04xf.boring_elv(2), b04xf.boring_elv(1)];
b04xf.layer.x2 = b04xf.bor_stickx; % 'SW'
b04xf.layer.y2 = [b04xf.boring_elv(2), b04xf.boring_elv(3), b04xf.boring_elv(3), b04xf.boring_elv(2)];
b04xf.layer.x3 = b04xf.bor_stickx; % 'SM'
b04xf.layer.y3 = [b04xf.boring_elv(3), b04xf.boring_elv(5), b04xf.boring_elv(5), b04xf.boring_elv(3)];
b04xf.layer.x4 = b04xf.bor_stickx; % 'SOFT CL WITH SAND'
b04xf.layer.y4 = [b04xf.boring_elv(5), b04xf.boring_elv(6), b04xf.boring_elv(6), b04xf.boring_elv(5)];
b04xf.layer.x5 = b04xf.bor_stickx; % 'MEDIUM STIFF CLAY WITH SAND'
b04xf.layer.y5 = [b04xf.boring_elv(6), b04xf.boring_elv(7), b04xf.boring_elv(7), b04xf.boring_elv(6)];
b04xf.layer.x6 = b04xf.bor_stickx; % 'SM'
b04xf.layer.y6 = [b04xf.boring_elv(7), b04xf.boring_elv(8), b04xf.boring_elv(8), b04xf.boring_elv(7)];
b04xf.layer.x7 = b04xf.bor_stickx; % 'VERY SOFT CL'
b04xf.layer.y7 = [b04xf.boring_elv(8), b04xf.boring_elv(9), b04xf.boring_elv(9), b04xf.boring_elv(8)];
b04xf.layer.x8 = b04xf.bor_stickx; % 'MEDIUM STIFF CL'
b04xf.layer.y8 = [b04xf.boring_elv(9), b04xf.boring_elv(10), b04xf.boring_elv(10), b04xf.boring_elv(9)];
b04xf.samples = 31.47816 - [35, 40, 50, 60, 70]; % 35 has zero recovery
% offset = 163.63 ft S
b04xf.mdotsu.peakx = [0.13, 0.28, 0.69, 0.51, 0.59, 0.72, ...
                      0.86, 0.72, 0.59, 0.59, 0.74, 0.82].*1000;
b04xf.mdotsu.peaky = 31.47816 - [38, 39, 42, 43, 48, 49, ...
                                 53, 54, 56, 57, 63, 64];
b04xf.mdotsu.remoldedx = [0.02, 0.04, 0.02, 0.0, 0.02, 0.02, ...
                          0.03, 0.02, 0.02, 0.03, 0.02, 0.05].*1000;
b04xf.mdotsu.remoldedy = b04xf.mdotsu.peaky;

clear surf_elv surf_dist boring_elv boring_class bor_midx;
clear b03xf_data b04xf_data;

% Colors ==================================================================
% have to change it to geotechnical symbols or whatever liek lean clay or
% clean sand

col.asphalt = [82, 82, 82]./255;
col.topsoil = [129, 148, 124]./255;
col.fill = [166, 129, 91]./255;
col.sand = [214, 161, 62]./255;
col.clay = [134, 159, 166]./255;
