load data.mat

time  = diabetic(1,:);
glucose_sp = diabetic(2,:);
insulin = diabetic(3,:);
meals = diabetic(4,:);
PVO = diabetic (5,:);
glucose = diabetic(6,:);
%Ggly = diabetic(6,:);

figure(1)
hold off

subplot(4,1,1)
hold off
plot(time,insulin,'b-','LineWidth',2)
axis([min(time) max(time) 0 15]);
legend('Insulin Injection')
ylabel('Insulin (\muU/min)')
xlabel('Time (hr)')


subplot(4,1,2)
hold off
plot(time,PVO,'k-','LineWidth',2)
legend('Exercise intensity')
axis([min(time) max(time) 0 100]);
ylabel('Exercise Intensity')
xlabel('Time (hr)')
% 
% subplot(4,1,3)
% hold off
% plot(time,Ggly,'k-','LineWidth',2)
% legend('Rate of Glyconeolysis')
% axis([min(time) max(time) -0.015 0.20]);
% ylabel('Rate of Glyconeolysis')

subplot(4,1,3)
hold off
plot(time,glucose_sp,'m-','LineWidth',2)
hold on
plot(time,glucose,'b:','LineWidth',2)
legend('Glucose SP','Blood Glucose')
axis([min(time) max(time) ...
    min(min(glucose),min(glucose_sp))-10 ...
    max(max(glucose),max(glucose_sp))+10]);
ylabel('Glucose (mg/dl)')
xlabel('Time (hr)')

subplot(4,1,4)
hold off
plot(time,meals,'k-','LineWidth',2)
legend('Glucose Digestion')
axis([min(time) max(time) 0 110]);
ylabel('Glucose Digestion')
xlabel('Time (hr)')

% save data to text file
data = diabetic';

save -ascii 'data.txt' data