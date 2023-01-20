# Closed Loop Insulin Delivery

This is a collection of simulations done in order to test a closed loop insulin therapy using different configurations of patients (Type 1 Diabetes Mellitus) and controllers (MPC and PID) with 24 hours of simulations with meals and exercise. 

# Insulin Predictor
This project is a web application built with Django that uses machine learning to predict insulin dosage for patients with diabetes. The model for insulin-dependent patients was generated using the Bergman minimal model in Matlab, simulating the exercise as a disturbance that occurs in the morning before breakfast, and the meals were a disturbance that occurred three times a day.

# Getting Started
These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

# Prerequisites
You will need to have the following software installed on your machine:
Python 3.x
Django 3.x
Pip
Virtualenv (optional, but recommended)
Matlab (if you want to re-train the model)

# Installing

1. Clone the repository to your local machine
```
git clone https://github.com/EstherMatamoros/CloosedLoopInsulinDelivery.git
```
2. Navigate to the project directory
```
cd insulin-predictor
```
3. Create a virtual environment and activate it (if using virtualenv)
```
virtualenv env
source env/bin/activate
```

4. Run the migration command to create the necessary database tables
```
python manage.py makemigrations
python manage.py migrate
```
5. Start the development server
```
python manage.py runserver
```
The application will be available at http://127.0.0.1:8000/

# Usage

Input your glucose levels, setpoint of glucose, day, effort made during exercise, carbohydrates in your meal.
The machine learning model will predict the insulin dosage for you

# Built With

Django - The web framework used
Scikit-learn - Machine learning library
Matlab - Used to generate the insulin-dependent patients model using the Bergman minimal model

# Authors
Esther Matamoros - EstherMatamoros

# License
This project is licensed under the MIT License - see the LICENSE.md file for details



