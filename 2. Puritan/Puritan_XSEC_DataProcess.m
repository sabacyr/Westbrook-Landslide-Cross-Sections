% PROCESSES CROSS SECTIONS CPT AND BORING DATA BASED ON ELEVATION. X./19.5 SPACING IS USER DEFINED IN ARCGIS.

%% INPUT SPREADSHEETS 
clear all; close all; clc;

c06xp_data = readtable("Puritan XS.xlsx","Sheet", 3);
c07p_data = readtable("Puritan XS.xlsx","Sheet", 5);
c05xp_data = readtable("Puritan XS.xlsx","Sheet", 6);
c08xp_data = readtable("Puritan XS.xlsx","Sheet", 8);
c04xp_data = readtable("Puritan XS.xlsx","Sheet", 10);
c09p_data = readtable("Puritan XS.xlsx","Sheet", 12);
c01p_data = readtable("Puritan XS.xlsx","Sheet", 13);
c02xp_data = readtable("Puritan XS.xlsx","Sheet", 14);

b06xp_data = readtable("Puritan XS.xlsx","Sheet", 4);
b05xp_data = readtable("Puritan XS.xlsx","Sheet", 7);
b08xp_data = readtable("Puritan XS.xlsx","Sheet", 9);
b04xp_data = readtable("Puritan XS.xlsx","Sheet", 11);
b02xp_data = readtable("Puritan XS.xlsx","Sheet", 15);

%% INPUT CPT ELEVATION, SHEAR STRENGTH, & RESISTIVITY DATA

% C-06XP ==================================================================

c06xp_data = table2array(c06xp_data(:, [1, 2, 4, 5, 6]));
cpt_elv = 44.69328 - c06xp_data(:, 3) ; % hole's elevation - cpt depth values
cpt_su = (c06xp_data(:, 4).*2000.*15)./19.5; % shear strength conversion from tsf to psf
% for i = 1:length(cpt_su)
%     if cpt_su(i) >= 1000
%         cpt_su(i) = nan;
%     end
% end
cpt_res = c06xp_data(:, 5); % resistivity
c06xp = struct('raw', c06xp_data, 'surf_elv', c06xp_data(:, 1), ...
              'surf_dist', c06xp_data(:, 2), 'cpt_elv', cpt_elv, ...
              'cpt_su', cpt_su, 'cpt_res', cpt_res);
cpt_midx = c06xp.surf_dist(10); % find on arcgis
c06xp.cpt_stickx = [cpt_midx-5, cpt_midx-5, cpt_midx+5, cpt_midx+5];
c06xp.cpt_sticky = [cpt_elv(1), cpt_elv(end), cpt_elv(end), cpt_elv(1)];
c06xp.cpt_water = 44.69328 - 20; % find from ue cpt data
% offset = 31.34 ft S Profile 1

% C-07P ==================================================================

c07p_data = table2array(c07p_data(:, [1, 2, 4, 5, 6]));
cpt_elv = 36.69336 - c07p_data(:, 3) ; % hole's elevation - cpt depth values
cpt_su = (c07p_data(:, 4).*2000.*15)./19.5; % shear strength conversion from tsf to psf
% for i = 1:length(cpt_su)
%     if cpt_su(i) >= 1000
%         cpt_su(i) = nan;
%     end
% end
cpt_res = c07p_data(:, 5); % resistivity
c07p = struct('raw', c07p_data, 'surf_elv', c07p_data(:, 1), ...
              'surf_dist', c07p_data(:, 2), 'cpt_elv', cpt_elv, ...
              'cpt_su', cpt_su, 'cpt_res', cpt_res);
cpt_midx = c07p.surf_dist(54); % find on arcgis
c07p.cpt_stickx = [cpt_midx-5, cpt_midx-5, cpt_midx+5, cpt_midx+5];
c07p.cpt_sticky = [cpt_elv(1), cpt_elv(end), cpt_elv(end), cpt_elv(1)];
c07p.cpt_water = 36.69336 - 10; % find from ue cpt data
% offset = 0 Profile 2

% C-05XP ==================================================================

c05xp_data = table2array(c05xp_data(:, [1, 2, 4, 5, 6]));
cpt_elv = 57.02936 - c05xp_data(:, 3) ; % hole's elevation - cpt depth values
cpt_su = (c05xp_data(:, 4).*2000.*15)./19.5; % shear strength conversion from tsf to psf
% for i = 1:length(cpt_su)
%     if cpt_su(i) >= 1000
%         cpt_su(i) = nan;
%     end
% end
cpt_res = c05xp_data(:, 5); % resistivity
c05xp = struct('raw', c05xp_data, 'surf_elv', c05xp_data(:, 1), ...
              'surf_dist', c05xp_data(:, 2), 'cpt_elv', cpt_elv, ...
              'cpt_su', cpt_su, 'cpt_res', cpt_res);
cpt_midx = 1.1*c05xp.surf_dist(65); % find on arcgis
c05xp.cpt_stickx = [cpt_midx-5, cpt_midx-5, cpt_midx+5, cpt_midx+5];
c05xp.cpt_sticky = [cpt_elv(1), cpt_elv(end), cpt_elv(end), cpt_elv(1)];
c05xp.cpt_water = 57.02936 - 29; % find from ue cpt data didn't have the data
% offset = 16.5 ft S Profile 1

% C-08XP ==================================================================

c08xp_data = table2array(c08xp_data(:, [1, 2, 4, 5, 6]));
cpt_elv = 43.132 - c08xp_data(:, 3) ; % hole's elevation - cpt depth values
cpt_su = (c08xp_data(:, 4).*2000.*15)./19.5; % shear strength conversion from tsf to psf
% for i = 1:length(cpt_su)
%     if cpt_su(i) >= 1000
%         cpt_su(i) = nan;
%     end
% end
cpt_res = c08xp_data(:, 5); % resistivity
c08xp = struct('raw', c08xp_data, 'surf_elv', c08xp_data(:, 1), ...
              'surf_dist', c08xp_data(:, 2), 'cpt_elv', cpt_elv, ...
              'cpt_su', cpt_su, 'cpt_res', cpt_res);
cpt_midx = c08xp.surf_dist(92); % find on arcgis
c08xp.cpt_stickx = [cpt_midx-5, cpt_midx-5, cpt_midx+5, cpt_midx+5];
c08xp.cpt_sticky = [cpt_elv(1), cpt_elv(end), cpt_elv(end), cpt_elv(1)];
c08xp.cpt_water = 43.132 - 20; % find from ue cpt data didn't have the data
% offset = 10.75 ft S Profile 2

% C-04XP ==================================================================

c04xp_data = table2array(c04xp_data(:, [1, 2, 4, 5, 6]));
cpt_elv = 59.95512 - c04xp_data(:, 3) ; % hole's elevation - cpt depth values
cpt_su = (c04xp_data(:, 4).*2000.*15)./19.5; % shear strength conversion from tsf to psf
% for i = 1:length(cpt_su)
%     if cpt_su(i) >= 1000
%         cpt_su(i) = nan;
%     end
% end
cpt_res = c04xp_data(:, 5); % resistivity
c04xp = struct('raw', c04xp_data, 'surf_elv', c04xp_data(:, 1), ...
              'surf_dist', c04xp_data(:, 2), 'cpt_elv', cpt_elv, ...
              'cpt_su', cpt_su, 'cpt_res', cpt_res);
cpt_midx = 0.95*c04xp.surf_dist(126); % find on arcgis
c04xp.cpt_stickx = [cpt_midx-5, cpt_midx-5, cpt_midx+5, cpt_midx+5];
c04xp.cpt_sticky = [cpt_elv(1), cpt_elv(end), cpt_elv(end), cpt_elv(1)];
c04xp.cpt_water = 59.95512 - 25; % find from ue cpt data didn't have the data
% offset = 0 Profile 1

% C-09P ==================================================================

c09p_data = table2array(c09p_data(:, [1, 2, 4, 5, 6]));
cpt_elv = 24.15064 - c09p_data(:, 3) ; % hole's elevation - cpt depth values
cpt_su = (c09p_data(:, 4).*2000.*15)./19.5; % shear strength conversion from tsf to psf
% for i = 1:length(cpt_su)
%     if cpt_su(i) >= 1000
%         cpt_su(i) = nan;
%     end
% end
cpt_res = c09p_data(:, 5); % resistivity
c09p = struct('raw', c09p_data, 'surf_elv', c09p_data(:, 1), ...
              'surf_dist', c09p_data(:, 2), 'cpt_elv', cpt_elv, ...
              'cpt_su', cpt_su, 'cpt_res', cpt_res);
cpt_midx = c09p.surf_dist(148); % find on arcgis
c09p.cpt_stickx = [cpt_midx-5, cpt_midx-5, cpt_midx+5, cpt_midx+5];
c09p.cpt_sticky = [cpt_elv(1), cpt_elv(end), cpt_elv(end), cpt_elv(1)];
c09p.cpt_water = 24.15064 - 5; % find from ue cpt data didn't have the data
% offset = 0 Profile 2

% C-01P ==================================================================

c01p_data = table2array(c01p_data(:, [1, 2, 4, 5, 6]));
cpt_elv = 27.18464 - c01p_data(:, 3) ; % hole's elevation - cpt depth values
cpt_su = (c01p_data(:, 4).*2000.*15)./19.5; % shear strength conversion from tsf to psf
% for i = 1:length(cpt_su)
%     if cpt_su(i) >= 1000
%         cpt_su(i) = nan;
%     end
% end
cpt_res = c01p_data(:, 5); % resistivity
c01p = struct('raw', c01p_data, 'surf_elv', c01p_data(:, 1), ...
              'surf_dist', c01p_data(:, 2), 'cpt_elv', cpt_elv, ...
              'cpt_su', cpt_su, 'cpt_res', cpt_res);
cpt_midx = (c01p.surf_dist(162) + c01p.surf_dist(163))/2; % find on arcgis
c01p.cpt_stickx = [cpt_midx-5, cpt_midx-5, cpt_midx+5, cpt_midx+5];
c01p.cpt_sticky = [cpt_elv(1), cpt_elv(end), cpt_elv(end), cpt_elv(1)];
c01p.cpt_water = 27.18464 - 5; % find from ue cpt data didn't have the data
% offset = 510 ft S

% C-02XP ==================================================================

c02xp_data = table2array(c02xp_data(:, [1, 2, 4, 5, 6]));
cpt_elv = 28.85088 - c02xp_data(:, 3) ; % hole's elevation - cpt depth values
cpt_su = (c02xp_data(:, 4).*2000.*15)./19.5; % shear strength conversion from tsf to psf
% for i = 1:length(cpt_su)
%     if cpt_su(i) >= 1000
%         cpt_su(i) = nan;
%     end
% end
cpt_res = c02xp_data(:, 5); % resistivity
c02xp = struct('raw', c02xp_data, 'surf_elv', c02xp_data(:, 1), ...
              'surf_dist', c02xp_data(:, 2), 'cpt_elv', cpt_elv, ...
              'cpt_su', cpt_su, 'cpt_res', cpt_res);
cpt_midx = (c02xp.surf_dist(166) + c02xp.surf_dist(167))/2; % find on arcgis
c02xp.cpt_stickx = [cpt_midx-5, cpt_midx-5, cpt_midx+5, cpt_midx+5];
c02xp.cpt_sticky = [cpt_elv(1), cpt_elv(end), cpt_elv(end), cpt_elv(1)];
c02xp.cpt_water = 28.85088 - 5; % find from ue cpt data didn't have the data
% offset = 81.25 ft S

clear c01p_data c02xp_data c04xp_data c05xp_data c06xp_data c07p_data;
clear c08xp_data c09p_data cpt_elv cpt_su cpt_res cpt_midx ans i; 

%% INPUT BORING ELEVATION & SOIL TYPE

% B-06XP ==================================================================

surf_elv = table2array(b06xp_data(2:end, 1));
surf_dist = table2array(b06xp_data(2:end, 2));
boring_elv = 46.3628 - table2array(b06xp_data(1:6, 4));
boring_class = string(table2cell(b06xp_data(1:6, 5)));
b06xp = struct('raw', b06xp_data, 'surf_elv', surf_elv, ...
               'surf_dist', surf_dist, 'boring_elv', boring_elv, ...
               'boring_class', boring_class);
bor_midx = c06xp.surf_dist(11)+5; % find on arcgis
b06xp.bor_stickx = [bor_midx-10, bor_midx-10, bor_midx+10, bor_midx+10];
b06xp.bor_sticky = [boring_elv(1), boring_elv(end), boring_elv(end), boring_elv(1)];
b06xp.bor_water = 46.3628 - 6; % find from boring log
b06xp.layer.x1 = b06xp.bor_stickx; % asphalt
b06xp.layer.y1 = [b06xp.boring_elv(1), b06xp.boring_elv(2), b06xp.boring_elv(2), b06xp.boring_elv(1)];
b06xp.layer.x2 = b06xp.bor_stickx; % 'SW'
b06xp.layer.y2 = [b06xp.boring_elv(2), b06xp.boring_elv(3), b06xp.boring_elv(3), b06xp.boring_elv(2)];
b06xp.layer.x3 = b06xp.bor_stickx; % 'Very stiff CL'
b06xp.layer.y3 = [b06xp.boring_elv(3), b06xp.boring_elv(4), b06xp.boring_elv(4), b06xp.boring_elv(3)];
b06xp.layer.x4 = b06xp.bor_stickx; % 'Very soft CL'
b06xp.layer.y4 = [b06xp.boring_elv(4), b06xp.boring_elv(6), b06xp.boring_elv(6), b06xp.boring_elv(4)];
% offset = 34.34 ft S
b06xp.samples = 46.3628 - [30, 50, 60, 80];
b06xp.mdotsu.peakx = [0.46, 0.38, 0.47, 0.48, 0.49, 0.48, 0.56, 0.67, 0.49, 0.58, ...
                  0.81, 0.67, 0.87, 0.87, 0.7, 1.02, 0.97, 0.95].*1000;
b06xp.mdotsu.peaky = 46.3628 - [33, 34, 36, 37, 41, 42, 46, 47, 53, 54, ...
                  56, 57, 63, 64, 76, 77, 83, 84];
b06xp.mdotsu.remoldedx = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...
                     0, 0, 0.02, 0.02, 0.03, 0.04, 0, 0.02].*1000;
b06xp.mdotsu.remoldedy = b06xp.mdotsu.peaky;

% B-05XP ==================================================================

surf_elv = table2array(b05xp_data(2:end, 1));
surf_dist = table2array(b05xp_data(2:end, 2));
boring_elv = 59.57792 - table2array(b05xp_data(1:7, 4));
boring_class = string(table2cell(b05xp_data(1:7, 5)));
b05xp = struct('raw', b05xp_data, 'surf_elv', surf_elv, ...
               'surf_dist', surf_dist, 'boring_elv', boring_elv, ...
               'boring_class', boring_class);
bor_midx = c05xp.surf_dist(65); % find on arcgis
b05xp.bor_stickx = [bor_midx-10, bor_midx-10, bor_midx+10, bor_midx+10];
b05xp.bor_sticky = [boring_elv(1), boring_elv(end), boring_elv(end), boring_elv(1)];
b05xp.bor_water = 59.57792 - 5; % find from boring log
b05xp.layer.x1 = b05xp.bor_stickx; % topsoil
b05xp.layer.y1 = [b05xp.boring_elv(1), b05xp.boring_elv(2), b05xp.boring_elv(2), b05xp.boring_elv(1)];
b05xp.layer.x2 = b05xp.bor_stickx; % silty sand SW
b05xp.layer.y2 = [b05xp.boring_elv(2), b05xp.boring_elv(3), b05xp.boring_elv(3), b05xp.boring_elv(2)];
b05xp.layer.x3 = b05xp.bor_stickx; % medium stiff CL with sand
b05xp.layer.y3 = [b05xp.boring_elv(3), b05xp.boring_elv(4), b05xp.boring_elv(4), b05xp.boring_elv(3)];
b05xp.layer.x4 = b05xp.bor_stickx; % soft CL
b05xp.layer.y4 = [b05xp.boring_elv(4), b05xp.boring_elv(6), b05xp.boring_elv(6), b05xp.boring_elv(4)];
b05xp.layer.x5 = b05xp.bor_stickx; % medium stiff CL
b05xp.layer.y5 = [b05xp.boring_elv(6), b05xp.boring_elv(7), b05xp.boring_elv(7), b05xp.boring_elv(6)];
% offset = 0
b05xp.samples = 59.57792 - [30, 40, 50, 60, 70];
b05xp.mdotsu.peakx = [0.32, 0.32, 0.40, 0.31, 0.32, 0.39, 0.30, 0.40, 0.33, 0.42, ...
                      0.34, 0.48, 0.34, 0.37, 0.68, 0.51, 0.53, 0.57, 0.68, 0.58, ...
                      0.63, 0.6, 0.62, 0.89, 0.72, 0.8, 0.77, 0.83].*1000;
b05xp.mdotsu.peaky = 59.57792 - [21, 22, 26, 27, 28, 29, 33, 34, 36, 37, ...
                      43, 44, 46, 47, 53, 54, 56, 57, 63, 64, ...
                      66, 67, 73, 74, 76, 77, 81, 82];
b05xp.mdotsu.remoldedx = [0.02, 0.04, 0.03, 0.02, 0, 0.02, 0.02, 0.02, 0.02, 0.02, ...
                          0.02, 0.02, 0.02, 0.02, 0.02, 0.0, 0.02, 0.0, 0.04, 0.04, ...
                          0.02, 0.04, 0.04, 0.03, 0.02, 0.04, 0.06, 0.04].*1000;
b05xp.mdotsu.remoldedy = b05xp.mdotsu.peaky;

% B-08XP ==================================================================

surf_elv = table2array(b08xp_data(2:end, 1));
surf_dist = table2array(b08xp_data(2:end, 2));
boring_elv = 44.92944 - table2array(b08xp_data(1:10, 4));
boring_class = string(table2cell(b08xp_data(1:10, 5)));
b08xp = struct('raw', b08xp_data, 'surf_elv', surf_elv, ...
               'surf_dist', surf_dist, 'boring_elv', boring_elv, ...
               'boring_class', boring_class);
bor_midx = c08xp.surf_dist(93)+5; % find on arcgis
b08xp.bor_stickx = [bor_midx-10, bor_midx-10, bor_midx+10, bor_midx+10];
b08xp.bor_sticky = [boring_elv(1), boring_elv(end), boring_elv(end), boring_elv(1)];
b08xp.bor_water = 44.92944 - 5; % find from boring log
b08xp.layer.x1 = b08xp.bor_stickx; % asphalt
b08xp.layer.y1 = [b08xp.boring_elv(1), b08xp.boring_elv(2), b08xp.boring_elv(2), b08xp.boring_elv(1)];
b08xp.layer.x2 = b08xp.bor_stickx; % sw
b08xp.layer.y2 = [b08xp.boring_elv(2), b08xp.boring_elv(3), b08xp.boring_elv(3), b08xp.boring_elv(2)];
b08xp.layer.x3 = b08xp.bor_stickx; % 'medium stiff CL'
b08xp.layer.y3 = [b08xp.boring_elv(3), b08xp.boring_elv(4), b08xp.boring_elv(4), b08xp.boring_elv(3)];
b08xp.layer.x4 = b08xp.bor_stickx; % 'Stiff CL with sand'
b08xp.layer.y4 = [b08xp.boring_elv(4), b08xp.boring_elv(5), b08xp.boring_elv(5), b08xp.boring_elv(4)];
b08xp.layer.x5 = b08xp.bor_stickx; % 'soft CL'
b08xp.layer.y5 = [b08xp.boring_elv(5), b08xp.boring_elv(6), b08xp.boring_elv(6), b08xp.boring_elv(5)];
b08xp.layer.x6 = b08xp.bor_stickx; % 'medium stiff CL'
b08xp.layer.y6 = [b08xp.boring_elv(6), b08xp.boring_elv(7), b08xp.boring_elv(7), b08xp.boring_elv(6)];
b08xp.layer.x7 = b08xp.bor_stickx; % 'soft CL'
b08xp.layer.y7 = [b08xp.boring_elv(7), b08xp.boring_elv(8), b08xp.boring_elv(8), b08xp.boring_elv(7)];
b08xp.layer.x8 = b08xp.bor_stickx; % 'medium stiff CL'
b08xp.layer.y8 = [b08xp.boring_elv(8), b08xp.boring_elv(9), b08xp.boring_elv(9), b08xp.boring_elv(8)];
b08xp.layer.x9 = b08xp.bor_stickx; % 'medium stiff CL'
b08xp.layer.y9 = [b08xp.boring_elv(9), b08xp.boring_elv(10), b08xp.boring_elv(10), b08xp.boring_elv(9)];
% offset = 17.78 ft S
b08xp.samples = 44.92944 - [25, 35, 45, 55];
b08xp.mdotsu.peakx = [0.22, 0.43, 0.46, 0.48, 0.48, 0.50, 0.51, 0.46, 0.53, 0.70, ...
                      0.63, 0.68, 0.61, 0.70, 0.56].*1000;
b08xp.mdotsu.peaky = 44.92944 - [28, 29, 30, 31, 38, 39, 40, 41, 48, 49, ...
                      51, 52, 58, 61, 62];
b08xp.mdotsu.remoldedx = [0.03, 0.02, 0.03, 0.02, 0, 0, 0.04, 0.03, 0.04, 0.04, ...
                          0.03, 0, 0.05, 0, 0.04].*1000;
b08xp.mdotsu.remoldedy = b08xp.mdotsu.peaky;

% B-04XP ==================================================================

surf_elv = table2array(b04xp_data(2:end, 1));
surf_dist = table2array(b04xp_data(2:end, 2));
boring_elv = 57.42296 - table2array(b04xp_data(1:12, 4));
boring_class = string(table2cell(b04xp_data(1:12, 5)));
b04xp = struct('raw', b04xp_data, 'surf_elv', surf_elv, ...
               'surf_dist', surf_dist, 'boring_elv', boring_elv, ...
               'boring_class', boring_class);
bor_midx = c04xp.surf_dist(126); % find on arcgis
b04xp.bor_stickx = [bor_midx-10, bor_midx-10, bor_midx+10, bor_midx+10];
b04xp.bor_sticky = [boring_elv(1), boring_elv(end), boring_elv(end), boring_elv(1)];
b04xp.bor_water = 57.42296 - 2; % find from boring log
b04xp.layer.x1 = b04xp.bor_stickx; % asphalt
b04xp.layer.y1 = [b04xp.boring_elv(1), b04xp.boring_elv(2), b04xp.boring_elv(2), b04xp.boring_elv(1)];
b04xp.layer.x2 = b04xp.bor_stickx; % 'SW'
b04xp.layer.y2 = [b04xp.boring_elv(2), b04xp.boring_elv(3), b04xp.boring_elv(3), b04xp.boring_elv(2)];
b04xp.layer.x3 = b04xp.bor_stickx; % 'SW-SM'
b04xp.layer.y3 = [b04xp.boring_elv(3), b04xp.boring_elv(4), b04xp.boring_elv(4), b04xp.boring_elv(3)];
b04xp.layer.x4 = b04xp.bor_stickx; % 'Medium stiff CL'
b04xp.layer.y4 = [b04xp.boring_elv(4), b04xp.boring_elv(5), b04xp.boring_elv(5), b04xp.boring_elv(4)];
b04xp.layer.x5 = b04xp.bor_stickx; % 'SW'
b04xp.layer.y5 = [b04xp.boring_elv(5), b04xp.boring_elv(6), b04xp.boring_elv(6), b04xp.boring_elv(5)];
b04xp.layer.x6 = b04xp.bor_stickx; % 'very soft CL'
b04xp.layer.y6 = [b04xp.boring_elv(6), b04xp.boring_elv(7), b04xp.boring_elv(7), b04xp.boring_elv(6)];
b04xp.layer.x7 = b04xp.bor_stickx; % 'very soft CL with sand'
b04xp.layer.y7 = [b04xp.boring_elv(7), b04xp.boring_elv(8), b04xp.boring_elv(8), b04xp.boring_elv(7)];
b04xp.layer.x8 = b04xp.bor_stickx; % 'very soft CL'
b04xp.layer.y8 = [b04xp.boring_elv(8), b04xp.boring_elv(9), b04xp.boring_elv(9), b04xp.boring_elv(8)];
b04xp.layer.x9 = b04xp.bor_stickx; % 'very soft CL with sand'
b04xp.layer.y9 = [b04xp.boring_elv(9), b04xp.boring_elv(10), b04xp.boring_elv(10), b04xp.boring_elv(9)];
b04xp.layer.x10 = b04xp.bor_stickx; % 'soft CL'
b04xp.layer.y10 = [b04xp.boring_elv(10), b04xp.boring_elv(11), b04xp.boring_elv(11), b04xp.boring_elv(10)];
b04xp.layer.x11 = b04xp.bor_stickx; % 'Medium stiff CL'
b04xp.layer.y11 = [b04xp.boring_elv(11), b04xp.boring_elv(12), b04xp.boring_elv(12), b04xp.boring_elv(11)];
% offset = 0 ft
b04xp.samples = 57.42296 - [35, 40, 50, 60, 70]; % 35 has 0 recovery
b04xp.mdotsu.peakx = [0.34, 0.35, 0.29, 0.37, 0.48, 0.42, 0.42, 0.49, 0.61, 0.57, ...
                      0.69, 0.71, 0.71, 0.59].*1000;
b04xp.mdotsu.peaky = 57.42296 - [33, 34, 38, 39, 43, 44, 48, 49, 53, 54, ...
                      58, 59, 63, 64];
b04xp.mdotsu.remoldedx = [0, 0, 0, 0, 0, 0.02, 0.02, 0, 0, 0, ...
                          0.0, 0.02, 0, 0.02].*1000;
b04xp.mdotsu.remoldedy = b04xp.mdotsu.peaky;

% B-02XP ==================================================================

surf_elv = table2array(b02xp_data(2:end, 1));
surf_dist = table2array(b02xp_data(2:end, 2));
boring_elv = 28.85088 - table2array(b02xp_data(1:10, 4));
boring_class = string(table2cell(b02xp_data(1:10, 5)));
b02xp = struct('raw', b02xp_data, 'surf_elv', surf_elv, ...
               'surf_dist', surf_dist, 'boring_elv', boring_elv, ...
               'boring_class', boring_class);
bor_midx = c02xp.surf_dist(169); % find on arcgis
b02xp.bor_stickx = [bor_midx-10, bor_midx-10, bor_midx+10, bor_midx+10];
b02xp.bor_sticky = [boring_elv(1), boring_elv(end), boring_elv(end), boring_elv(1)];
b02xp.bor_water = 28.85088 - 7; % find from boring log
b02xp.layer.x1 = b02xp.bor_stickx; % sw
b02xp.layer.y1 = [b02xp.boring_elv(1), b02xp.boring_elv(2), b02xp.boring_elv(2), b02xp.boring_elv(1)];
b02xp.layer.x2 = b02xp.bor_stickx; % 'sw-sm'
b02xp.layer.y2 = [b02xp.boring_elv(2), b02xp.boring_elv(4), b02xp.boring_elv(4), b02xp.boring_elv(2)];
b02xp.layer.x3 = b02xp.bor_stickx; % 'soft cl with sand'
b02xp.layer.y3 = [b02xp.boring_elv(4), b02xp.boring_elv(5), b02xp.boring_elv(5), b02xp.boring_elv(4)];
b02xp.layer.x4 = b02xp.bor_stickx; % 'soft CL'
b02xp.layer.y4 = [b02xp.boring_elv(5), b02xp.boring_elv(8), b02xp.boring_elv(8), b02xp.boring_elv(5)];
b02xp.layer.x5 = b02xp.bor_stickx; % 'medium stiff cl'
b02xp.layer.y5 = [b02xp.boring_elv(8), b02xp.boring_elv(9), b02xp.boring_elv(9), b02xp.boring_elv(8)];
b02xp.layer.x6 = b02xp.bor_stickx; % 'sw'
b02xp.layer.y6 = [b02xp.boring_elv(9), b02xp.boring_elv(10), b02xp.boring_elv(10), b02xp.boring_elv(9)];
% offset = 81.76 ft S
b02xp.samples = 28.85088 - [28, 38, 48];
b02xp.mdotsu.peakx = [0.39, 0.45, 0.38, 0.39, 0.44, 0.34, 0.50, 0.42, 0.53, 0.49, ...
                      0.44, 0.34, 0.50, 0.47, 0.59, 0.65, 0.37, 0.83].*1000;
b02xp.mdotsu.peaky = 28.85088 - [16, 17, 21, 22, 26, 27, 31, 32, 36, 37, ...
                      41, 42, 46, 47, 51, 52, 56, 57];
b02xp.mdotsu.remoldedx = [0.04, 0.03, 0.03, 0.02, 0.02, 0.02, 0.02, 0.02, 0, 0, ...
                          0, 0, 0.03, 0.02, 0.03, 0.03, 0.02, 0.02].*1000;
b02xp.mdotsu.remoldedy = b02xp.mdotsu.peaky;

clear surf_elv surf_dist boring_elv boring_class bor_midx;
clear b06xp_data b05xp_data b08xp_data b04xp_data b02xp_data;

% Colors ==================================================================
% have to change it to geotechnical symbols or whatever liek lean clay or
% clean sand

col.asphalt = [82, 82, 82]./255;
col.topsoil = [129, 148, 124]./255;
col.fill = [166, 129, 91]./255;
col.sand = [214, 161, 62]./255;
col.clay = [134, 159, 166]./255;

