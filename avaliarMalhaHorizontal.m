function avaliarMalhaHorizontal()
% avaliarMalhaHorizontal() avalia o projeto da malha horizontal.

requisitos.x.tr = 1.0;
requisitos.x.Mp = 0.1;
requisitos.theta.tr = 0.1;
requisitos.theta.Mp = 0.05;

planta = obterPlantaMulticoptero();

controladorXAnalitico = projetarControladorHorizontalAnalitico(requisitos.x, planta);
controladorXIterativo = projetarControladorHorizontalBusca(requisitos.x, requisitos.theta, planta);
controladorCMAES = projetarControladorHorizontalCMAES(requisitos.x, planta);
controladorTheta = projetarControladorArfagem(requisitos.theta, planta);

malhaAnalitico = obterMalhaHorizontal(controladorXAnalitico, controladorTheta, planta);
malhaBusca = obterMalhaHorizontal(controladorXIterativo, controladorTheta, planta);
malhaCMAESx = obterMalhaHorizontal(controladorCMAES,controladorTheta, planta);

t = 0:1e-3:5;

xAnalitico = step(malhaAnalitico, t);
xIterativo = step(malhaBusca, t);
xCMAES = step(malhaCMAESx, t);

figure;
hold on;

plot(t, xAnalitico, 'LineWidth', 2);
plot(t, xIterativo, 'LineWidth', 2);
plot(t, xCMAES, 'LineWidth', 2);

grid on;

xlabel('Tempo (s)', 'FontSize', 14);
ylabel('X (m)', 'FontSize', 14);
set(gca, 'FontSize', 14);
legend('Analitico', 'Iterativo','CMA-ES', 'FontSize', 14, 'Location', 'Southeast');

% print -depsc2 ./figures/resposta_horizontal.eps
print -dpng -r400 ./figures/resposta_horizontal.png

end