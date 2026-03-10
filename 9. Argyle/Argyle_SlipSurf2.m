% DRAWS CROSS SECTIONS BASED ON ELEVATION. X SPACING IS USER DEFINED IN
% ARCGIS. MUST RUN Puritan_XSEC_DataProcess.m FIRST

%% INPUT PROCESSED DATA

clear all; clc; close all

load("ArgyleAllData.mat")

%% GENERATE THE PRE AND POST BLOCKS WITH UNKNOWNS

% First NaN set is the base of the slip surface at the bathymetry line and
% the second NaN set is the break point of the slip surface beneath the block.

preblock_unk = [130, 135.072; 140, 134.152; 150, 131.413; 160, 124.853; ...
    170, 121.024; 180, 118.828; 190, 116.22; 200, 112.719; 210, 109.915; ...
    NaN, NaN; NaN, NaN; 130, 135.072]; 

% Same idea for post block, but with different known vertices.

postblock_unk = [130, 135.072; 140, 126.025; 150, 120.476; 160, 115.134; ...
    170, 113.386; 180, 112.829; 190, 114.319; 200, 115.227; 210, 111.7; ... 
    220, 113.849; 230, 109.907; 240, 107.473; ...
    NaN, NaN; NaN, NaN; 130, 135.072];

%% GENERATE SLIP SURFACES: "WALL" & "BASE"

% The base's unknowns are two points: one where it intersects pre bathymetry
% and one where it intersects the wall. The base is horizontal at elevation b.

% y values for the base lines (baselines)
b = linspace(110, 80, 400); 

% x values for the base lines. Extend past the post block bathymetry.
x = linspace(130, 280, 400); 

% Pre-slide bathymetry as a sloped line
x1_prebathy = 210; y1_prebathy = 109.915;
x2_prebathy = 230; y2_prebathy = 100.493;

% Post-slide bathymetry as a sloped line
x1_postbathy = 230; y1_postbathy = 109.473;
x2_postbathy = 270; y2_postbathy = 101.035; 

% Make baselines as polylines (for polyxpoly intersections)
baseline = cell(400,1);

for k = 1:400
    baseline{k} = [x', repmat(b(k), 400, 1)]; 
end

% Wall: inclined part of the slip surface, defined by angle alpha

x0 = 130; y0 = 135.072;             % origin point from geometry
alpha = linspace(-89, -41.14, 400); % alpha range (deg)
L = 100;                             % length along the wall
npts = 400;                         % number of points per wall line

wallline = cell(length(alpha), 1);

for k = 1:length(alpha)
    a = alpha(k);
    s = linspace(0, L, npts);
    linex = x0 + s .* cosd(a);
    liney = y0 + s .* sind(a);
    wallline{k} = [linex', liney']; 
end

% PLOT RANDOM SAMPLE OF BASELINES AND WALL LINES

figure(1); hold on;

% pick 10 random baselines and 10 random wall lines
rand_base_idx = randperm(400, 10);
rand_wall_idx = randperm(400, 10);

% plot the 10 random baselines (horizontal lines)
for i = rand_base_idx
    bl = baseline{i};
    plot(bl(:,1), bl(:,2), 'Color', [0.3 0.3 1 0.4], 'LineWidth', 1); % light blue
end

% plot the 10 random wall lines (inclined slip surfaces)
for j = rand_wall_idx
    wl = wallline{j};
    plot(wl(:,1), wl(:,2), 'Color', [1 0.3 0.3 0.6], 'LineWidth', 1.5); % light red
end

plot(c01xa.surf_dist, c01xa.surf_elv, 'LineWidth', 2, 'Color', [0 0 0 1])
plot(presurf(:, 2), presurf(:, 1), 'LineWidth', 2, 'Color', [0 0 0 0.3])
plot(bathymetry.post(:, 3), bathymetry.post(:, 1), 'LineWidth', 2, ...
    'Color', [150, 0, 110, 255]./255, 'LineStyle','--')
plot(bathymetry.pre(:, 3),  bathymetry.pre(:, 1),  'LineWidth', 2, ...
    'Color', [150, 0, 110, 100]./255, 'LineStyle','--')

xlabel('x'); ylabel('y');
title('Random 10 Wall Lines and 10 Base Lines');
grid on; xlim([120 300]); ylim([70 150]); 
hold off;

%% INTERSECTIONS BETWEEN: "WALL" & "BASE"

nB = numel(b);
nW = numel(alpha);

wallbase_pre_xi = NaN(nB, nW);   % wall–base x intersection
wallbase_pre_yi = NaN(nB, nW);   % wall–base y intersection
wallbase_pre_alphai = NaN(nB, nW); % alpha value for each wall line
s_mat = NaN(nB, nW);   % s parameter for each pair

x_min = 130; x_max = 250;

for j = 1:nW
    a = alpha(j);
    sina = sind(a);
    cosa = cosd(a);
    
    % skip if wall would be horizontal (not expected here)
    if abs(sina) < 1e-6
        continue
    end

    for i = 1:nB
        % wall: y = y0 + s*sina, base: y = b(i)
        s_val = (b(i) - y0) / sina;
        x_val = x0 + s_val * cosa;

        if (s_val >= 0) && (s_val <= L) && (x_val >= x_min) && (x_val <= x_max)
            wallbase_pre_xi(i, j) = x_val;
            wallbase_pre_yi(i, j) = b(i);
            wallbase_pre_alphai(i, j) = a;
            s_mat(i, j) = s_val;

            fprintf('Wall line %d, Baseline %d, Intersection stored in (%d, %d)\n', ...
                    j, i, i, j);
        end

    end

end

% PLOT 10 RANDOM WALL–BASELINE PAIRS WITH INTERSECTIONS

% find all valid intersections
[Ib, Jw] = find(~isnan(wallbase_pre_xi));

if isempty(Ib)
    warning('No valid wall–base intersections found.');
else
    % choose 10 random valid intersections
    Nplot = min(10, numel(Ib));
    rand_sel = randperm(numel(Ib), Nplot);

    figure(2); hold on;

    for k = 1:Nplot
        
        i_rand = Ib(rand_sel(k));   % baseline index
        j_rand = Jw(rand_sel(k));   % wall index
        
        % grab the geometry
        bl = baseline{i_rand};     % baseline polyline
        wl = wallline{j_rand};     % wall line polyline
        
        xi = wallbase_pre_xi(i_rand, j_rand);
        yi = wallbase_pre_yi(i_rand, j_rand);

        % plot baseline
        plot(bl(:,1), bl(:,2), 'Color', [0 0 1 0.3], 'LineWidth', 1)

        % plot wall line
        plot(wl(:,1), wl(:,2), 'Color', [1 0 0 0.3], 'LineWidth', 1)

        % plot intersection point
        plot(xi, yi, 'ko', 'MarkerSize', 6, 'MarkerFaceColor', 'y')

        fprintf('Pair %d: Baseline %d, Wall %d → Intersection (%.3f, %.3f)\n', ...
                k, i_rand, j_rand, xi, yi);

    end

    plot(c01xa.surf_dist, c01xa.surf_elv, 'LineWidth', 2, 'Color', [0 0 0 1])
    plot(presurf(:, 2), presurf(:, 1), 'LineWidth', 2, 'Color', [0 0 0 0.3])
    plot(bathymetry.post(:, 3), bathymetry.post(:, 1), 'LineWidth', 2, ...
        'Color', [150, 0, 110, 255]./255, 'LineStyle','--')
    plot(bathymetry.pre(:, 3),  bathymetry.pre(:, 1),  'LineWidth', 2, ...
        'Color', [150, 0, 110, 100]./255, 'LineStyle','--')


    xlabel('x'); ylabel('y');
    title('10 Random Wall–Baseline Intersections');
    grid on; xlim([120 300]); ylim([70 150]); 
    hold off;
end

% PLOT WALL LINE 400, ALL BASELINES, AND THEIR INTERSECTIONS WITH WALL 400

j_sel = 400;   % wall line index to inspect

% grab wall line 400
wl = wallline{j_sel};

figure(3); hold on;

% plot all baselines
for i = 1:nB
    bl = baseline{i};
    plot(bl(:,1), bl(:,2), 'Color', [0 0 1 0.2], 'LineWidth', 1); % faint blue
end

% plot wall line 400
plot(wl(:,1), wl(:,2), 'r-', 'LineWidth', 2);  % red, thicker

% plot intersections of wall line 400 with all baselines
for i = 1:nB
    xi = wallbase_pre_xi(i, j_sel);
    yi = wallbase_pre_yi(i, j_sel);

    if ~isnan(xi) && ~isnan(yi)
        plot(xi, yi, 'ko', 'MarkerSize', 6, 'MarkerFaceColor', 'y');
    end
end

plot(c01xa.surf_dist, c01xa.surf_elv, 'LineWidth', 2, 'Color', [0 0 0 1])
plot(presurf(:, 2), presurf(:, 1), 'LineWidth', 2, 'Color', [0 0 0 0.3])
plot(bathymetry.post(:, 3), bathymetry.post(:, 1), 'LineWidth', 2, ...
    'Color', [150, 0, 110, 255]./255, 'LineStyle','--')
plot(bathymetry.pre(:, 3),  bathymetry.pre(:, 1),  'LineWidth', 2, ...
    'Color', [150, 0, 110, 100]./255, 'LineStyle','--')

xlabel('x');
ylabel('y');
title(sprintf('Wall line %d with all baselines and intersections', j_sel));
grid on; xlim([120 300]); ylim([70 150]); 
hold off;

%% INTERSECTIONS BETWEEN: "BASE" & "BATHY" OF PRE BLOCK 

pre_bathy_xi = NaN(nB, 1);
pre_bathy_yi = NaN(nB, 1);

for i = 1:nB
    bl = baseline{i};
    bx = bl(:,1);
    by = bl(:,2);

    wx = [x1_prebathy x2_prebathy];
    wy = [y1_prebathy y2_prebathy];

    [xi_tmp, yi_tmp] = polyxpoly(bx, by, wx, wy);

    if ~isempty(xi_tmp)
        pre_bathy_xi(i) = xi_tmp(1);
        pre_bathy_yi(i) = yi_tmp(1);

        fprintf('Pre bathy: Baseline %d: xi = %.3f, yi = %.3f, b = %.3f\n', ...
                i, xi_tmp(1), yi_tmp(1), b(i));
    else
        fprintf('Pre bathy: No intersection for baseline %d was found\n', i);
    end
end

basebathy_pre_xi = repmat(pre_bathy_xi, 1, nW);
basebathy_pre_yi = repmat(pre_bathy_yi, 1, nW);

% PLOT 10 RANDOM BASE–PRE-BATHY INTERSECTIONS

% valid intersections
valid = ~isnan(pre_bathy_xi);
idx_all = find(valid);

if isempty(idx_all)
    warning('No valid base–pre-bathy intersections found.');
else
    Nplot = min(10, numel(idx_all));
    idx_rand = idx_all(randperm(numel(idx_all), Nplot));

    figure(4); hold on;

    for k = 1:Nplot
        i_rand = idx_rand(k);

        bl = baseline{i_rand};
        xi = pre_bathy_xi(i_rand);
        yi = pre_bathy_yi(i_rand);

        % baseline in stronger color
        plot(bl(:,1), bl(:,2), 'Color', [0 0 1 0.5], 'LineWidth', 1.5);

        % intersection point
        plot(xi, yi, 'ko', 'MarkerSize', 7, 'MarkerFaceColor', 'y');

        fprintf('Pre-bathy pair %d: Baseline %d → Intersection (%.3f, %.3f)\n', ...
                k, i_rand, xi, yi);
    end

    plot(c01xa.surf_dist, c01xa.surf_elv, 'LineWidth', 2, 'Color', [0 0 0 1])
    plot(presurf(:, 2), presurf(:, 1), 'LineWidth', 2, 'Color', [0 0 0 0.3])
    plot(bathymetry.post(:, 3), bathymetry.post(:, 1), 'LineWidth', 2, ...
        'Color', [150, 0, 110, 255]./255, 'LineStyle','--')
    plot(bathymetry.pre(:, 3),  bathymetry.pre(:, 1),  'LineWidth', 2, ...
        'Color', [150, 0, 110, 100]./255, 'LineStyle','--')

    xlabel('x'); ylabel('y');
    title('10 Random Base–Pre-Bathymetry Intersections');
    grid on; xlim([120 300]); ylim([70 150]);
    axis equal;
    hold off;
end


%% INTERSECTIONS BETWEEN: "BASE" & "BATHY" OF POST BLOCK

post_bathy_xi = NaN(nB, 1);
post_bathy_yi = NaN(nB, 1);

for i = 1:nB
    bl = baseline{i};
    bx = bl(:,1);
    by = bl(:,2);

    wx = [x1_postbathy x2_postbathy];
    wy = [y1_postbathy y2_postbathy];

    [xi_tmp, yi_tmp] = polyxpoly(bx, by, wx, wy);

    if ~isempty(xi_tmp)
        post_bathy_xi(i) = xi_tmp(1);
        post_bathy_yi(i) = yi_tmp(1);

        fprintf('Post bathy: Baseline %d: xi = %.3f, yi = %.3f, b = %.3f\n', ...
                i, xi_tmp(1), yi_tmp(1), b(i));
    else
        fprintf('Post bathy: No intersection for baseline %d was found\n', i);
    end

end

% Copy pre wall–base intersections to post wall–base intersections
wallbase_post_xi = wallbase_pre_xi;
wallbase_post_yi = wallbase_pre_yi;

% Repeat base–bathy intersections across columns
basebathy_post_xi = repmat(post_bathy_xi, 1, nW);
basebathy_post_yi = repmat(post_bathy_yi, 1, nW);

% PLOT 10 RANDOM BASE–POST-BATHY INTERSECTIONS

valid = ~isnan(post_bathy_xi);
idx_all = find(valid);

if isempty(idx_all)
    warning('No valid base–post-bathy intersections found.');
else
    Nplot = min(10, numel(idx_all));
    idx_rand = idx_all(randperm(numel(idx_all), Nplot));

    figure(5); hold on;

    for k = 1:Nplot
        i_rand = idx_rand(k);

        bl = baseline{i_rand};
        xi = post_bathy_xi(i_rand);
        yi = post_bathy_yi(i_rand);

        % baseline in stronger color
        plot(bl(:,1), bl(:,2), 'Color', [0 0 1 0.5], 'LineWidth', 1.5);

        % intersection point
        plot(xi, yi, 'ko', 'MarkerSize', 7, 'MarkerFaceColor', 'y');

        fprintf('Post-bathy pair %d: Baseline %d → Intersection (%.3f, %.3f)\n', ...
                k, i_rand, xi, yi);
    end

    % background geom
    plot(c01xa.surf_dist, c01xa.surf_elv, 'LineWidth', 2, 'Color', [0 0 0 1])
    plot(presurf(:, 2), presurf(:, 1), 'LineWidth', 2, 'Color', [0 0 0 0.3])
    plot(bathymetry.post(:, 3), bathymetry.post(:, 1), 'LineWidth', 2, ...
        'Color', [150, 0, 110, 255]./255, 'LineStyle','--')
    plot(bathymetry.pre(:, 3),  bathymetry.pre(:, 1),  'LineWidth', 2, ...
        'Color', [150, 0, 110, 100]./255, 'LineStyle','--')

    xlabel('x'); ylabel('y');
    title('10 Random Base–Post-Bathymetry Intersections');
    grid on; xlim([120 300]); ylim([70 150]);
    axis equal;
    hold off;
end


%% CREATE THE COMPLETED PRE AND POST BLOCKS

preblock_solutions  = cell(nB, nW);
postblock_solutions = cell(nB, nW);

for j = 1:nW

    for i = 1:nB

        if any(isnan([basebathy_pre_xi(i, j), basebathy_pre_yi(i, j), ...
                      wallbase_pre_xi(i, j),  wallbase_pre_yi(i, j), ...
                      basebathy_post_xi(i, j), basebathy_post_yi(i, j), ...
                      wallbase_post_xi(i, j),  wallbase_post_yi(i, j)]))
            continue
        end

        % work on temporary copies so templates are not permanently overwritten
        preB_tmp  = preblock_unk;
        postB_tmp = postblock_unk;

        % pre block: base–bathy and wall–base intersections
        preB_tmp(10, 1) = basebathy_pre_xi(i, j);
        preB_tmp(10, 2) = basebathy_pre_yi(i, j);
        preB_tmp(11, 1) = wallbase_pre_xi(i, j);
        preB_tmp(11, 2) = wallbase_pre_yi(i, j);
        preblock_solutions{i, j} = preB_tmp;

        % post block: base–bathy and wall–base intersections
        postB_tmp(13, 1) = basebathy_post_xi(i, j);
        postB_tmp(13, 2) = basebathy_post_yi(i, j);
        postB_tmp(14, 1) = wallbase_post_xi(i, j);
        postB_tmp(14, 2) = wallbase_post_yi(i, j);
        postblock_solutions{i, j} = postB_tmp;

        fprintf('Stored block for wall line %d and baseline %d in solutions (%d, %d)\n', ...
                j, i, i, j);
    end

end

% PLOT 3 RANDOM PRE/POST BLOCK PAIRS (SAME BASELINE AND ALPHA)

% find all (i,j) where both pre and post blocks exist
valid_pairs = ~cellfun(@isempty, preblock_solutions) & ...
              ~cellfun(@isempty, postblock_solutions);

[Ivalid, Jvalid] = find(valid_pairs);

if isempty(Ivalid)
    warning('No valid pre/post block pairs found.');
else
    Nplot = min(3, numel(Ivalid));
    sel = randperm(numel(Ivalid), Nplot);

    figure(6); hold on;

    % plot background geom
    plot(c01xa.surf_dist, c01xa.surf_elv, 'LineWidth', 2, 'Color', [0 0 0 1])
    plot(presurf(:, 2), presurf(:, 1), 'LineWidth', 2, 'Color', [0 0 0 0.3])
    plot(bathymetry.post(:, 3), bathymetry.post(:, 1), 'LineWidth', 2, ...
        'Color', [150, 0, 110, 255]./255, 'LineStyle','--')
    plot(bathymetry.pre(:, 3),  bathymetry.pre(:, 1),  'LineWidth', 2, ...
        'Color', [150, 0, 110, 100]./255, 'LineStyle','--')

    cmap = lines(Nplot);  % distinct colors

    for k = 1:Nplot
        i_k = Ivalid(sel(k));
        j_k = Jvalid(sel(k));

        preB  = preblock_solutions{i_k, j_k};
        postB = postblock_solutions{i_k, j_k};

        % plot pre block (solid) and post block (dashed) for this pair
        plot(preB(:,1),  preB(:,2),  '-',  'LineWidth', 2, 'Color', cmap(k,:));
        plot(postB(:,1), postB(:,2), '--', 'LineWidth', 2, 'Color', cmap(k,:));

        fprintf('Pair %d: i = %d (b = %.3f), j = %d (alpha = %.3f deg)\n', ...
                k, i_k, b(i_k), j_k, alpha(j_k));
    end

    xlabel('x'); ylabel('y');
    title('3 Random Pre/Post Block Pairs (solid = pre, dashed = post)');
    grid on; xlim([120 300]); ylim([70 150]);
    axis equal;
    hold off;
end

%% PLOT PRE/POST BLOCKS FOR SPECIFIC i AND j
i_list = [10, 20, 30, 40, 50, 60];   % baselines
j_sel = 90;                    % wall index (alpha index)

figure(7);
tiledlayout(2, 3);

for k = 1:length(i_list)
    i_k = i_list(k);

    % extract block solutions
    preB  = preblock_solutions{i_k, j_sel};
    postB = postblock_solutions{i_k, j_sel};

    nexttile;
    hold on;

    % plot pre and post blocks
    plot(preB(:,1),  preB(:,2),  'b-',  'LineWidth', 2);
    plot(postB(:,1), postB(:,2), 'r--', 'LineWidth', 2);

    % context: ground surface + bathymetry lines
    plot(c01xa.surf_dist, c01xa.surf_elv, 'k', 'LineWidth', 1.5);
    plot(bathymetry.pre(:,3),  bathymetry.pre(:,1),  'Color', [0.5 0 1], 'LineWidth', 1);
    plot(bathymetry.post(:,3), bathymetry.post(:,1), 'Color', [1 0 1], 'LineWidth', 1);

    title(sprintf('Baseline i = %d (b = %.2f), j = %d (alpha = %.2f°)', ...
                  i_k, b(i_k), j_sel, alpha(j_sel)));

    xlabel('x'); ylabel('y');
    grid on;
    xlim([120 300]); ylim([70 150]);
    hold off;
end

sgtitle(sprintf('Pre/Post Blocks for i = [20 50 100 150] and j = %d (alpha = %.2f°)', ...
                 j_sel, alpha(j_sel)), 'FontSize', 14);



%% Compute areas for each block and area differences

area_diff = NaN(nB, nW);

for j = 1:nW
    for i = 1:nB
        fprintf('Calculating differences in block pair %d (%d, %d)\n', ...
                (i-1)*nW+j, i, j);

        if isempty(preblock_solutions{i,j}) || isempty(postblock_solutions{i,j})
            fprintf('Block pair %d is empty, skipped to next pair\n', (i-1)*nW+j);
            continue
        end

        preB  = preblock_solutions{i, j};
        postB = postblock_solutions{i, j};

        areapre   = polyarea(preB(:,1),  preB(:,2));
        areapost  = polyarea(postB(:,1), postB(:,2));
        area_diff(i, j) = areapre - areapost;                   
    end
end

[~, best] = min(abs(area_diff(:)), [], 'omitnan');
[i_best, j_best] = ind2sub([nB, nW], best);

fprintf('Best block pair: (i = %d, j = %d), area_diff = %.6f\n', ...
        i_best, j_best, area_diff(i_best, j_best));

fprintf('Pre block unknowns:\n bathymetry intersection x = %.2f, y = %.2f\n wall and base intersection x = %.2f, y = %.2f\n', ...
    basebathy_pre_xi(i_best, j_best), basebathy_pre_yi(i_best, j_best), ...
    wallbase_pre_xi(i_best, j_best),  wallbase_pre_yi(i_best, j_best));

fprintf('Post block unknowns:\n bathymetry intersection x = %.2f, y = %.2f\n wall and base intersection x = %.2f, y = %.2f\n alpha %.2f\n', ...
    basebathy_post_xi(i_best, j_best), basebathy_post_yi(i_best, j_best), ...
    wallbase_post_xi(i_best, j_best),  wallbase_post_yi(i_best, j_best), ...
    wallbase_pre_alphai(i_best, j_best));

postB = postblock_solutions{i_best, j_best};
preB  = preblock_solutions{i_best, j_best};

%% PLOT BEST SOLUTION

figure(8);
ax2 = axes;
hold(ax2, "on");
plot(ax2, c01xa.surf_dist, c01xa.surf_elv, 'LineWidth', 2, 'Color', [0 0 0 1])
plot(ax2, presurf(:, 2), presurf(:, 1), 'LineWidth', 2, 'Color', [0 0 0 0.3])
plot(ax2, bathymetry.post(:, 3), bathymetry.post(:, 1), 'LineWidth', 2, ...
    'Color', [150, 0, 110, 255]./255, 'LineStyle','--')
plot(ax2, bathymetry.pre(:, 3),  bathymetry.pre(:, 1),  'LineWidth', 2, ...
    'Color', [150, 0, 110, 100]./255, 'LineStyle','--')
plot(ax2, preB(:, 1),  preB(:, 2),  'LineWidth', 2, 'Color', 'c')
plot(ax2, postB(:, 1), postB(:, 2), 'LineWidth', 2, 'Color', 'm')
xlim(ax2, [0 400]);
xlabel('x');
ylabel('y');
title('Solution Blocks');
grid(ax2, 'on');
hold(ax2, 'off');

% Compute slope and angle of the last segment of the post block slip surface
x1 = postB(end-1, 1); 
y1 = postB(end-1, 2);
x2 = postB(end, 1);   
y2 = postB(end, 2);

m = (y2 - y1) / (x2 - x1);
thetad = atan(m) * (180/pi);

fprintf('Slope m = %.3f\n', m);
fprintf('Angle of the slip surface (deg) = %.3f\n', -thetad);
fprintf('Active wedge alpha (deg) for phi 27 = %.3f\n', 45 + 28/2);


%%

figure;
imagesc(alpha, b, area_diff./areapre);  % x: alpha, y: baseline depth
set(gca, 'YDir', 'normal');
colormap redblue
colorbar
xlabel('\alpha (deg)');
ylabel('b (baseline elevation)');
title('area\_diff(i,j) = A_{pre} - A_{post}');
