error_RK4 = yAnal-yNumRK4;
error_RKF = yAnalRKF-yNumRKF;
error_ode45 = yAnalode45-ode45y';

plot(tNumRKF,error_RKF,'b');
hold on;
plot(x,error_RK4,'r');
plot(ode45t,error_ode45,'k');
legend({'RKF','RK4','ode45'})