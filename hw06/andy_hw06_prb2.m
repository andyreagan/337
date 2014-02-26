a=linspace(0,.1,100);
c=(1/8*(4+4*a.^2+a.^4+sqrt(16-32*a.^2+24*a.^4+8*a.^6+a.^8)))./(1/8*(4+4*a.^2+a.^4-sqrt(16-32*a.^2+24*a.^4+8*a.^6+a.^8)));
plot(a,c);
xlabel('\epsilon','FontSize',20)
ylabel('Condition number','FontSize',20)
saveas(gcf,'andy_hw06_prb2_01.png')