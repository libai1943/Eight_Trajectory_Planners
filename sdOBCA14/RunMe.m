%% sd-OBCA
% Reproduction of the signed-distance optimization-based collision avoidance
% (sd-OBCA) method for the unified numerical comparison conducted in our survey.
%
% Reference:
% X. Zhang, A. Liniger, and F. Borrelli, "Optimization-Based Collision
% Avoidance," IEEE Transactions on Control Systems Technology, vol. 29,
% no. 3, pp. 972-983, 2021.
%
% This implementation follows the signed-distance collision avoidance
% formulation proposed in the above reference, while using the unified vehicle
% model, test case, objective function, discretization, solver settings, and
% initial guesses adopted in our comparative experiments of survey entitled
% "A Survey of Collision Avoidance Constraint Modeling Strategies in
% Optimization-based Trajectory Planning for Autonomous Driving" in IEEE ITSM
% 2026.

close all; clc; clear all;
global params_

InitializeParams();
LoadCase(); % This function generates a random case each time it is executed

initial_guess_mode = 2; % 0: static initial guess; 1: conflicting line; 2: completely feasible trajectory
[x, y, theta, v, a, phi, w, tf] = GenerateInitialGuess(initial_guess_mode);
WriteBasicParameterFile();
WriteObs();
WriteInitialGuess(x, y, theta, v, a, phi, w, tf);

SolveNLP();
if (IsCurSolValid())
    DrawTrajectory();
end