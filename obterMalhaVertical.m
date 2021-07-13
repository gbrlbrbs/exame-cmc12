function dinamica = obterMalhaVertical(controlador, planta)
% dinamica = obterMalhaVertical(controlador, planta) obtem a dinamica da
% malha vertical. A struct controlador possui os seguintes parametros:
% controlador.Kp: ganho proporcional.
% controlador.Ki: ganho integrativo.
% controlador.Kd: ganho derivativo.
% A struct planta tem os seguintes parametros:
% planta.m: massa.
% planta.J: inercia.
% planta.l: distancia entre os rotores.
% planta.g: aceleracao da gravidade.
% A saida dinamica eh a dinamica da malha vertical na forma de funcao de
% transferencia.

%% sem pre-filtro

% num = [controlador.Kd, controlador.Kp, controlador.Kp];
% denom = [planta.m, num];
% dinamica = tf(num, denom);

%% com pre-filtro

num = controlador.Ki;
denom = [planta.m, controlador.Kd, controlador.Kp, num];
dinamica = tf(num, denom);

end