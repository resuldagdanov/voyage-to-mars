# Voyage to Mars

Final project of the lecture UUM517E - Spacecraft Dynamics.

# Course Materials
* Anton H.J. de Ruiter, Christopher J. Damaren and James R. Forbes, **Spacecraft Dynamics and Control: An Introduction**, First Edition, John Wiley & Sons, Ltd., 2013.
* F. Landis Markley, John L. Crassidis, **Fundamentals of Spacecraft Attitude Determination and Control**, Space Technology Library, 2014
* David A. Vallado, **Fundamentals of Astrodynamics and Applications**, Fourth Edition, Microcosm Press, 2013.
* Howard D. Curtis, **Orbital Mechanics for Engineering Students**, Revised Fourth Edition, Elsevier, Aerospace Engineering Series, 2021.

# Project Description

## Part I
### Designing a trajectory to Mars
(assume Earth and Mars are at the ecliptic plane with circular orbits around Sun)
1. Select a suitable date and time starting from this year in order to send your spacecraft to Mars
2. Determine the launch characteristics to send your spacecraft to a parking orbit at 500 km, and then to escape from the Earth’s sphere of influence
3. Design an interplanetary Hohmann transfer orbit between Earth and Mars
4. Let the spacecraft have a circular Mars parking orbit at 300 km altitude when it reached to Mars
5. Determine the minimum time necessary before leaving Mars and coming back to Earth using an interplanetary Hohmann transfer orbit

## Part II
### Estimating Sun’s direction in the parking orbit of Mars
(use your project part 1 outputs for the position information –if necessary, use planet ephemeris)
(assume that you have a three-axis sun sensor)
1. Design an extended Kalman filter (EKF) for estimating the direction of the Sun using the onboard sensor
2. Determine the periods of being in eclipse. In case that the filter diverges in eclipse, reinitialize your code after eclipse
