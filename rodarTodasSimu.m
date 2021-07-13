simus = ['a', 'b', 'c', 'd', 'e', 'f', 'g'];
planta = obterPlantaMulticoptero();
requisitos = obterRequisitos();
controlador = projetarControladorMulticoptero(requisitos, planta);

% gerar graficos
for char = simus
    simulacao = simularExperimentoMulticoptero(controlador, planta, char);
    tracarGraficosSimulacao(simulacao);
end

% gerar animaçoes
% cada uma demora 10s, rode por sua conta e risco
% for char = simus(4:6)
%     simulacao = simularExperimentoMulticoptero(controlador, planta, char);
%     fazerAnimacaoMulticoptero(simulacao, planta);
% end