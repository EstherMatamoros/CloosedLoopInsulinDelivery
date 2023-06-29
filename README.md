# Closed Loop Insulin Delivery

This is a collection of simulations done in order to test a closed-loop insulin therapy using different configurations of patients (Type 1 Diabetes Mellitus) and controllers (MPC and PID) with 24 hours of simulations with meals and exercise. 

# Insulin Predictor
The model for insulin-dependent patients was generated using the Bergman minimal model in Matlab, simulating the exercise as a disturbance that occurs in the morning before breakfast, and the meals were a disturbance that happened three times a day.

# Getting Started
These instructions will get you a copy of the project up and running on your local machine for development and testing.

# Prerequisites
You will need to have the following software installed on your machine:
Matlab.

# Installing

1. Clone the repository to your local machine
```
git clone https://github.com/EstherMatamoros/CloosedLoopInsulinDelivery.git
```
2. Navigate to the project directory
```
cd CloosedLoopInsulinDelivery
```
3. Open in Matlab environment and run on the diabetic.m file  
# Usage

Input your glucose levels, set the point of glucose, day, the effort made during exercise, and carbohydrates in the meal in the diabetes_3pid.slx.
There will be a modeling of the glucose throughout the day according to this data

# Built With
Matlab - Used to generate the insulin-dependent patients model using the Bergman minimal model and model for meal and exercise effect. 

# Authors
Esther Matamoros - EstherMatamoros

# License
This project is licensed under the MIT License - see the LICENSE.md file for details



