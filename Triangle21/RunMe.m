%% Li and Shao Method [21]
% Reproduction of the collision avoidance method proposed by Li and Shao for
% the unified numerical comparison conducted in our survey.
%
% Reference:
% B. Li and Z. Shao, "A Unified Motion Planning Method for Parking an
% Autonomous Vehicle in the Presence of Irregularly Placed Obstacles,"
% Knowledge-Based Systems, vol. 86, pp. 11-20, 2015.
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
WriteInitialGuess(x, y, theta, v, a, phi, w, tf);
WriteObs();

SolveNLP();
if (IsCurSolValid())
    DrawTrajectory();
end