%% Liu et al. Method [20]
% Reproduction of the collision avoidance method proposed by Liu et al. for
% the unified numerical comparison conducted in our survey.
%
% Reference:
% C. Liu, S. Lee, S. Varnhagen, and H. E. Tseng, "Path Planning for
% Autonomous Vehicles Using Model Predictive Control," in Proc. 2017 IEEE
% Intelligent Vehicles Symposium (IV), Los Angeles, CA, USA, pp. 174-179,
% Jun. 2017.
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
WriteBasicParameterFile();
WriteObs();
WriteInitialGuess(x, y, theta, v, a, phi, w, tf);

SolveNLP();
if (IsCurSolValid())
    DrawTrajectory();
end