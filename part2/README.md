# Extended Kalman Filter (EKF)

Final project part 2 of the lecture UUM517E - Spacecraft Dynamics.

# Course Materials
* Anton H.J. de Ruiter, Christopher J. Damaren and James R. Forbes, **Spacecraft Dynamics and Control: An Introduction**, First Edition, John Wiley & Sons, Ltd., 2013.
* F. Landis Markley, John L. Crassidis, **Fundamentals of Spacecraft Attitude Determination and Control**, Space Technology Library, 2014
* David A. Vallado, **Fundamentals of Astrodynamics and Applications**, Fourth Edition, Microcosm Press, 2013.
* Howard D. Curtis, **Orbital Mechanics for Engineering Students**, Revised Fourth Edition, Elsevier, Aerospace Engineering Series, 2021.

# Project Description

### Estimating Sun’s direction in the parking orbit of Mars
(use your project part 1 outputs for the position information –if necessary, use planet ephemeris)
(assume that you have a three-axis sun sensor)
1. Design an extended Kalman filter (EKF) for estimating the direction of the Sun using the onboard sensor
2. Determine the periods of being in eclipse. In case that the filter diverges in eclipse, reinitialize your code after eclipse
