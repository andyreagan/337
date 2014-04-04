% andy_hw13_prb05_q5.m
%
% Plot log(rho_pi ^(tmax/kappa)) as a function of r,
%     r in 1/(4h), 1/(2h)

h = 0.05;
rvec = linspace(1/(4*h),1/(2*h),100);
kvec = h^2*rvec;
tmax = .5;
theta = 1;
zvec = -4.*rvec;
rhopivec = (1+(1-theta).*zvec)./(1-theta.*zvec);

figure(130510);
subplot(221);
plot(rvec,log(abs(rhopivec).^(tmax./kvec)),'LineWidth',2);
xlabel('r','FontSize',16);
ylabel('log(|\rho _\pi| ^{t_{max}/\kappa})','FontSize',18);
title('\theta = 1','FontSize',18)
theta = 1/2;
rhopivec = (1+(1-theta).*zvec)./(1-theta.*zvec);
subplot(222);
plot(rvec,log(abs(rhopivec).^(tmax./kvec)),'LineWidth',2);
xlabel('r','FontSize',16);
ylabel('log(|\rho _\pi| ^{t_{max}/\kappa})','FontSize',18);
title('\theta = 1/2','FontSize',18)

%% with log
% figure(130511);
subplot(223);
theta = 1;
rhopivec = (1+(1-theta).*zvec)./(1-theta.*zvec);
plot(rvec,abs(rhopivec).^(tmax./kvec),'LineWidth',2);
xlabel('r','FontSize',16);
ylabel('|\rho _\pi| ^{t_{max}/\kappa}','FontSize',18);
title('\theta = 1','FontSize',18)
theta = 1/2;
rhopivec = (1+(1-theta).*zvec)./(1-theta.*zvec);
subplot(224);
plot(rvec,abs(rhopivec).^(tmax./kvec),'LineWidth',2);
xlabel('r','FontSize',16);
ylabel('|\rho _\pi| ^{t_{max}/\kappa}','FontSize',18);
title('\theta = 1/2','FontSize',18)