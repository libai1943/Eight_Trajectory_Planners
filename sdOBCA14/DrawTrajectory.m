function DrawTrajectory()
global params_
close all;
set(0, 'DefaultLineLineWidth', 1);
hold on;

plot(params_.ig.x, params_.ig.y, 'b');
plot(params_.opti.x, params_.opti.y, 'r');
legend('Initial guess', 'Optimal trajectory', 'AutoUpdate', 'off');

box on;
grid minor;
axis equal;
axis([params_.scenario.xmin, params_.scenario.xmax, params_.scenario.ymin, params_.scenario.ymax]);
set(gcf, 'outerposition', get(0,'screensize'));
fill(params_.obs.x, params_.obs.y, [0.5 0.5 0.5]);

xlabel('x / m', 'FontSize', 22, 'FontName', 'Arial Narrow', 'FontWeight', 'Bold');
ylabel('y / m', 'FontSize', 22, 'FontName', 'Arial Narrow', 'FontWeight', 'Bold');

for ii = 1 : params_.opti.nfe
    V = CreateVehiclePolygon(params_.opti.x(ii), params_.opti.y(ii), params_.opti.theta(ii), 2);
    plot(V.x, V.y, 'Color', params_.utility.ego_vehicle_rgb);
end

Arrow([params_.task.x0, params_.task.y0], [params_.task.x0 + cos(params_.task.theta0), params_.task.y0 + sin(params_.task.theta0)], 'Length', 16, 'BaseAngle', 90, 'TipAngle', 16, 'Width', 2);
Arrow([params_.task.xf, params_.task.yf], [params_.task.xf + cos(params_.task.thetaf), params_.task.yf + sin(params_.task.thetaf)], 'Length', 16, 'BaseAngle', 90, 'TipAngle', 16, 'Width', 2);

axis([params_.scenario.xmin params_.scenario.xmax params_.scenario.ymin params_.scenario.ymax]);
end