clear all; close all;clc

t=linspace(0,6000);
y0=0;
u=40; 
z= ode45(@(t,y)exercise(t,y,u),t,y0);
time = z.x;
y=z.y;

plot(time,y)