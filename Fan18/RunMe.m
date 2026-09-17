%% Fan et al. Method [18]
% Reproduction of the collision avoidance method proposed by Fan et al. for
% the unified numerical comparison conducted in our survey.
%
% Reference:
% J. Fan, N. Murgovski, and J. Liang, "Efficient Optimization-Based
% Trajectory Planning for Unmanned Systems in Confined Environments,"
% IEEE Transactions on Intelligent Transportation Systems, vol. 25, no. 11,
% pp. 18547-18560, Nov. 2024.
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
