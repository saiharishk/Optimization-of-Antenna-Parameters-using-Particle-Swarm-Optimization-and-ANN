# Optimization-of-Antenna-Parameters-using-Particle-Swarm-Optimization-and-ANN
This repo is based on my undergrad thesis at VR Siddhartha Engineering College

Wireless communication systems have changed the way of interaction throughout the world.
As antenna is a key component of any wireless device, it plays significant role in defining the
performance and characteristics of these devices. Therefore, the design of an antenna for
wireless system has become popular research topic among researchers and experts from
industries and universities.

Specifications of antennas usually involve many conflicting objectives related to directivity,
impedance matching, cross-polarization, and frequency range, gain, these can be formulated,
solved and analysed by using evolutionary optimization algorithms. Optimization Algorithms
shall be used for Parameter fine-tuning, Topology exploration and Radiation pattern shaping.
Evolutionary algorithms include Particle Swarm Optimization algorithm, genetic algorithm,
Ant Colony optimization etc. In this project, we use PSO as the main algorithm to build the neural network model of the Antenna.

We have used double PSO optimization - i.e. the first time is for creating the NN model with least error and the second time while optimizing the NN_model to get the best output parameters.
The NN model behaves as the antenna, and since antenna had to be optimized we have taken this NN model and done the optimization of parameters by feeding different objective and fitness values.
