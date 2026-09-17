function SolveNLP()
global params_
!ampl rr.run
[params_.opti.x, params_.opti.y, params_.opti.theta, params_.opti.v, params_.opti.a, params_.opti.phi, params_.opti.w, params_.opti.terminal_time] = LoadAmplSolution();
end

function [x, y, theta, v, a, phi, w, terminal_time] = LoadAmplSolution()
load([pwd, '\x.txt']);
load([pwd, '\y.txt']);
load([pwd, '\theta.txt']);
load([pwd, '\v.txt']);
load([pwd, '\a.txt']);
load([pwd, '\phi.txt']);
load([pwd, '\w.txt']);
load([pwd, '\terminal_time.txt']);
end