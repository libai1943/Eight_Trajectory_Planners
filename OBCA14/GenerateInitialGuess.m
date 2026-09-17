function [x, y, theta, v, a, phi, w, tf] = GenerateInitialGuess(mode)
global params_

nfe = params_.opti.nfe;
x0 = params_.task.x0;
y0 = params_.task.y0;
theta0 = params_.task.theta0;
xf = params_.task.xf;
yf = params_.task.yf;
thetaf = params_.task.thetaf;

%% Mode 2: perfect initial guess
if mode == 2
    load perfect_ig
    tf = terminal_time;
    return;
end

%% Mode 0: completely stationary
if mode == 0
    tf = 10.0;
    x = ones(1,nfe)*x0;
    y = ones(1,nfe)*y0;
    theta = ones(1,nfe)*theta0;
    v = zeros(1,nfe);
    a = zeros(1,nfe);
    phi = zeros(1,nfe);
    w = zeros(1,nfe);
    return;
end

%% Mode 1: minimum-time straight-line motion
dx = xf - x0;
dy = yf - y0;
D = hypot(dx,dy);

if D < 1e-10
    tf = 10.0;
    x = ones(1,nfe)*x0;
    y = ones(1,nfe)*y0;
    theta = ones(1,nfe)*theta0;
    v = zeros(1,nfe);
    a = zeros(1,nfe);
    phi = zeros(1,nfe);
    w = zeros(1,nfe);
    return;
end

vmax = params_.vehicle.vmax;
a_acc = params_.vehicle.amax;
a_dec = -params_.vehicle.amin;

v_peak = sqrt(2*D/(1/a_acc + 1/a_dec));

if v_peak <= vmax
    v_peak = v_peak;
    t_acc = v_peak/a_acc;
    t_dec = v_peak/a_dec;
    t_cruise = 0;
    tf = t_acc + t_dec;
    s_acc = 0.5*a_acc*t_acc^2;
    s_cruise = 0;
else
    v_peak = vmax;
    t_acc = v_peak/a_acc;
    t_dec = v_peak/a_dec;
    s_acc = 0.5*a_acc*t_acc^2;
    s_dec = 0.5*a_dec*t_dec^2;
    s_cruise = D - s_acc - s_dec;
    t_cruise = s_cruise/v_peak;
    tf = t_acc + t_cruise + t_dec;
end

t = linspace(0,tf,nfe);
s = zeros(1,nfe);
v = zeros(1,nfe);
a = zeros(1,nfe);

for ii = 1:nfe
    ti = t(ii);

    if ti <= t_acc
        a(ii) = a_acc;
        v(ii) = a_acc*ti;
        s(ii) = 0.5*a_acc*ti^2;
    elseif ti <= t_acc + t_cruise
        tau = ti - t_acc;
        a(ii) = 0;
        v(ii) = v_peak;
        s(ii) = s_acc + v_peak*tau;
    else
        tau = ti - t_acc - t_cruise;
        a(ii) = -a_dec;
        v(ii) = v_peak - a_dec*tau;
        s(ii) = s_acc + s_cruise + v_peak*tau - 0.5*a_dec*tau^2;
    end
end

s(1) = 0;
s(end) = D;
v(1) = 0;
v(end) = 0;

ux = dx/D;
uy = dy/D;
x = x0 + ux*s;
y = y0 + uy*s;

theta = ones(1,nfe)*theta0;
theta(1) = theta0;
theta(end) = thetaf;

phi = zeros(1,nfe);
w = zeros(1,nfe);
end