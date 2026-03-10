% 1. Create the data for the main plot
x1 = linspace(0, 10);
y1 = sin(x1) .* exp(-x1/5);

% 2. Create the data for the inset plot (a zoomed-in section)
x2 = linspace(7, 8);
y2 = sin(x2) .* exp(-x2/5);

% 3. Plot the main graph
figure; % Open a new figure window
plot(x1, y1, 'b-', 'LineWidth', 2);
title('Main Plot');
xlabel('x');
ylabel('y');
grid on;

% 4. Create new axes for the inset plot
% 'Position' is a vector: [left, bottom, width, height]
inset_axes = axes('Position', [0.65, 0.65, 0.25, 0.25]);

% 5. Plot the zoomed-in data inside the new axes
plot(inset_axes, x2, y2, 'r-', 'LineWidth', 2);
title(inset_axes, 'Inset');
grid(inset_axes, 'on');
box(inset_axes, 'on');