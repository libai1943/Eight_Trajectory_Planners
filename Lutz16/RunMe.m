%% Lutz-Meurer Method [16]
% Reproduction of the collision avoidance method proposed by Lutz and Meurer
% for the unified numerical comparison conducted in our survey.
%
% Reference:
% M. Lutz and T. Meurer, "Efficient Formulation of Collision Avoidance
% Constraints in Optimization-Based Trajectory Planning and Control," in
% Proc. 2021 IEEE Conference on Control Technology and Applications (CCTA),
% San Diego, CA, USA, pp. 228-233, 2021.
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
