function avaliarMalhaVertical()
% avaliarMalhaVertical() avalia o projeto da malha vertical.

requisitos.tr = 1.0;
requisitos.Mp = 0.1;

planta = obterPlantaMulticoptero();

controladorAnalitico = projetarControladorVerticalAnalitico(requisitos, planta);
controladorBusca = projetarControladorVerticalBusca(requisitos, planta);
[controladorA,~] = projetarControladoresCMAES(requisitos, planta);

malhaAnalitico = obterMalhaVertical(controladorAnalitico, planta);
malhaBusca = obterMalhaVertical(controladorBusca, planta);
malhaCMAESz = obterMalhaVertical(controladorA, planta);

t = 0:1e-3:5;

zAnalitico = step(malhaAnalitico, t);
zBusca = step(malhaBusca, t);
zCMAES = step(malhaCMAESz, t);

figure;
hold on;

plot(t, zAnalitico, 'LineWidth', 2);
plot(t, zBusca, 'LineWidth', 2);
plot(t, zCMAES, 'LineWidth', 2);

grid on;

xlabel('Tempo (s)', 'FontSize', 14);
ylabel('Z (m)', 'FontSize', 14);
set(gca, 'FontSize', 14);
legend('Analitico', 'Iterativo','CMA-ES', 'FontSize', 14, 'Location', 'Southeast');

% mostrar as informações na command window
% disp('analitico:');
% disp(stepinfo(malhaAnalitico, 'RiseTimeLimits', [0, 1]));
% disp('busca:');
% disp(stepinfo(malhaBusca, 'RiseTimeLimits', [0, 1]));

% print -depsc2 ./figures/resposta_vertical.eps
print -dpng -r400 ./figures/resposta_vertical.png

end