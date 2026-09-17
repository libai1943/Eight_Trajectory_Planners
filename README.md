# Eight Trajectory Planners

Reproducible implementations accompanying the survey

## A Survey of Collision Avoidance Constraint Modeling Strategies in Optimization-based Trajectory Planning for Autonomous Driving

This repository provides the source code used for the unified numerical comparison in our survey manuscript:

**"A Survey of Collision Avoidance Constraint Modeling Strategies in Optimization-based Trajectory Planning for Autonomous Driving," IEEE Intelligent Transportation Systems Magazine (ITSM), 2026.**

The survey focuses on **collision avoidance constraint modeling for optimization-based trajectory planning**, which directly affects planning quality, computational efficiency, numerical robustness, and practical deployability. From a geometric perspective, the survey organizes representative methods into three major groups and six modeling categories, including polygon-to-polygon distance-based models, polygon-to-polygon separation-plane-based models, vertex-to-polygon separation-based models, vertex-to-frontier separation-based models, corridor-based models, and disk-based models.

Beyond the literature review and taxonomy, the survey contains a unified numerical study of representative collision avoidance formulations. The purpose of this repository is to make these experiments reproducible and to provide compact implementations that allow different formulations to be examined under the same trajectory-planning framework.

---

## Unified Numerical Comparison

A direct numerical comparison between collision avoidance formulations is difficult when different papers use different vehicle models, objectives, discretization schemes, solvers, scenarios, and initialization strategies.

In this repository, the representative methods are therefore reimplemented within a common framework. The implementations use the same:

- vehicle model;
- trajectory-planning task;
- objective function;
- temporal discretization;
- solver settings;
- obstacle scenario;
- initial-guess definitions; and
- solution-validity check.

The main methodological difference between the individual folders is the **collision avoidance constraint formulation**.

Three initial-guess conditions are supported:

| Mode | Initial guess |
|---|---|
| `0` | Static initial guess |
| `1` | Conflicting straight-line initial guess |
| `2` | Completely feasible initial trajectory |

These settings are used in the survey to investigate the feasibility/success behavior, computational performance, convergence characteristics, and solution quality of different collision avoidance models.

---

## Implemented Methods

The repository currently contains eight implementations.

| Folder | Survey Ref. | Method | Main collision-avoidance modeling idea |
|---|---:|---|---|
| [`OBCA14`](./OBCA14) | [14] | Basic OBCA | Convex polygon-to-polygon distance represented through dual variables and embedded directly into the trajectory optimization problem. |
| [`sdOBCA14`](./sdOBCA14) | [14] | sd-OBCA | Signed-distance version of OBCA using a normalized dual certificate for polygon-to-polygon separation. |
| [`BOMP15`](./BOMP15) | [15] | BOMP | Bilevel collision evaluation represented through auxiliary primal/dual variables and approximate KKT conditions, together with an iterative continuation procedure. |
| [`Lutz16`](./Lutz16) | [16] | Lutz-Meurer method | Smooth lower-bound approximation of polygonal signed distance using log-sum-exp operations over geometric separation measures. |
| [`Fan18`](./Fan18) | [18] | Fan et al. method | Explicit separating-hyperplane formulation with an optimized unit normal and hyperplane offset between the vehicle and obstacle polygons. |
| [`Liu20`](./Liu20) | [20] | Liu et al. method | Polygon nonintersection represented through a Farkas-lemma-based dual feasibility certificate. |
| [`Triangle21`](./Triangle21) | [21] | Li-Shao method | Triangle-area-based point-outside-polygon conditions applied to the vehicle and obstacle vertices. |
| [`Fan22`](./Fan22) | [22] | Fan et al. method | Polygonal collision avoidance represented using continuous auxiliary variables that enforce mutual geometric separation between the vehicle and obstacle polygons. |

These implementations are **independent research reimplementations** of the collision avoidance formulations described in the corresponding papers. They are not the official source codes released by the original authors. Method-specific formulations are retained, while the surrounding trajectory-planning problem is unified for comparison.

---

## Original References

**[14]** X. Zhang, A. Liniger, and F. Borrelli, "Optimization-Based Collision Avoidance," *IEEE Transactions on Control Systems Technology*, vol. 29, no. 3, pp. 972-983, 2021.

**[15]** S. Shi, Y. Xiong, J. Chen, and C. Xiong, "A Bilevel Optimal Motion Planning (BOMP) Model With Application to Autonomous Parking," *International Journal of Intelligent Robotics and Applications*, vol. 3, pp. 370-382, 2019.

**[16]** M. Lutz and T. Meurer, "Efficient Formulation of Collision Avoidance Constraints in Optimization-Based Trajectory Planning and Control," in *Proc. 2021 IEEE Conference on Control Technology and Applications (CCTA)*, San Diego, CA, USA, pp. 228-233, 2021.

**[18]** J. Fan, N. Murgovski, and J. Liang, "Efficient Optimization-Based Trajectory Planning for Unmanned Systems in Confined Environments," *IEEE Transactions on Intelligent Transportation Systems*, vol. 25, no. 11, pp. 18547-18560, Nov. 2024.

**[20]** C. Liu, S. Lee, S. Varnhagen, and H. E. Tseng, "Path Planning for Autonomous Vehicles Using Model Predictive Control," in *Proc. 2017 IEEE Intelligent Vehicles Symposium (IV)*, Los Angeles, CA, USA, pp. 174-179, Jun. 2017.

**[21]** B. Li and Z. Shao, "A Unified Motion Planning Method for Parking an Autonomous Vehicle in the Presence of Irregularly Placed Obstacles," *Knowledge-Based Systems*, vol. 86, pp. 11-20, 2015.

**[22]** J. Fan, N. Murgovski, and J. Liang, "Efficient Collision Avoidance for Autonomous Vehicles in Polygonal Domains," *IEEE Transactions on Transportation Electrification*, vol. 11, no. 2, pp. 5396-5406, Jun. 2025.

The reference numbers above follow the numbering used in the survey.

---

## Software Structure

Each method is provided in an independent folder and can be executed separately. A typical folder contains:

```text
RunMe.m
InitializeParams.m
LoadCase.m
GenerateInitialGuess.m
WriteBasicParameterFile.m
WriteObs.m
WriteInitialGuess.m
SolveNLP.m
IsCurSolValid.m
DrawTrajectory.m
NLP.mod
rr.run
```

`RunMe.m` is the main entry point.

MATLAB is used for experiment configuration, initial-guess generation, data exchange, validity checking, and visualization. The nonlinear programming problem is formulated in AMPL and solved using IPOPT.

The collision avoidance constraints themselves can be found mainly in:

```text
NLP.mod
```

This file is therefore the most direct place to inspect the mathematical differences among the eight implementations.

---

## Running an Example

Enter one of the method folders in MATLAB, for example:

```matlab
cd OBCA14
RunMe
```

The initial-guess condition can be selected in `RunMe.m`:

```matlab
initial_guess_mode = 0;   % static initial guess
initial_guess_mode = 1;   % conflicting straight-line initial guess
initial_guess_mode = 2;   % completely feasible initial trajectory
```

The test case is generated or loaded through:

```matlab
LoadCase();
```

After optimization, the solution is checked by:

```matlab
IsCurSolValid()
```

and a valid trajectory is visualized using:

```matlab
DrawTrajectory();
```

---

## Solver

The current implementation uses **IPOPT** to solve the resulting nonlinear programming problems. The MATLAB code calls AMPL through the corresponding `rr.run` file.

The current scripts are prepared primarily for a Windows environment. Users running the code on other operating systems may need to modify system-dependent commands in the AMPL run files.

---

## Purpose of This Repository

The numerical experiments are intended to complement the theoretical analysis in the survey.

The repository allows readers to directly inspect how representative geometric collision avoidance models are translated into optimization constraints and to study how different formulations behave when the surrounding trajectory-planning problem is kept consistent.

The code is intended primarily for:

- reproducing the comparative experiments reported in the survey;
- understanding the implementation details of representative collision avoidance formulations;
- studying numerical behavior under different initial guesses;
- comparing modeling complexity and auxiliary-variable requirements; and
- serving as a reference implementation for future research on optimization-based trajectory planning.

For a complete discussion of the mathematical formulations, taxonomy, advantages, limitations, and experimental observations, please refer to the survey:

> **A Survey of Collision Avoidance Constraint Modeling Strategies in Optimization-based Trajectory Planning for Autonomous Driving**  
> *IEEE Intelligent Transportation Systems Magazine (ITSM), 2026.*

---

## Citation

If this repository is useful for your research, please cite both the survey and the original paper corresponding to the collision avoidance formulation being used.

The complete bibliographic information and DOI of the survey will be updated here after final publication.

---

## Repository

https://github.com/libai1943/Eight_Trajectory_Planners
