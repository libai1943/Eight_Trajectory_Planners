%% BOMP
% Reproduction of the bilevel optimal motion planning (BOMP) method for the
% unified numerical comparison conducted in our survey.
%
% Reference:
% S. Shi, Y. Xiong, J. Chen, and C. Xiong, "A Bilevel Optimal Motion Planning
% (BOMP) Model With Application to Autonomous Parking," International Journal
% of Intelligent Robotics and Applications, vol. 3, pp. 370-382, 2019.
%
% This implementation follows the collision avoidance formulation proposed
% in the above reference, while using the unified vehicle model, test case,
% objective function, discretization, solver settings, and initial guesses
% adopted in our comparative experiments of survey entitled "A Survey of
% Collision Avoidance Constraint Modeling Strategies in Optimization-based
% Trajectory Planning for Autonomous Driving" in IEEE ITSM 2026.

close all; clc; clear all;

global params_
InitializeParams();
LoadCase();

initial_guess_mode = 2;
[x, y, theta, v, a, phi, w, tf] = GenerateInitialGuess(initial_guess_mode);

params_.solver.epsilon = 1.0;
params_.solver.max_iter = 10;
tf_history = +Inf;
WriteInitialGuess(x, y, theta, v, a, phi, w, tf);
WriteObs();
iter = 0;
while (iter <= params_.solver.max_iter)
    iter = iter + 1;
    params_.solver.epsilon = params_.solver.epsilon * 0.1;
    WriteBasicParameterFile();
    SolveNLP();
    if (abs(params_.opti.terminal_time - tf_history) <= 0.001)
        break;
    end
    tf_history = params_.opti.terminal_time;
    WriteNewInitialGuess();
end

if (IsCurSolValid())
    DrawTrajectory();
end
