function dinamica = obterMalhaHorizontal(controladorX, controladorTheta, planta)
% dinamica = obterMalhaHorizontal(controladorX, controladorTheta, planta)
% obtem a dinamica da malha horizontal. As structs controladorX e 
% controladorTheta possuem a seguinte estrutura:
% controlador.Kp: ganho proporcional.
% controlador.Ki: ganho integrativo.
% controlador.Kd: ganho derivativo.
% A struct planta tem os seguintes parametros:
% planta.m: massa.
% planta.J: inercia.
% planta.l: distancia entre os rotores.
% planta.g: aceleracao da gravidade.
% A saida dinamica eh a dinamica da malha horizontal na forma de funcao de
% transferencia.

Kix = controladorX.Ki;
Kpx = controladorX.Kp;
Kdx = controladorX.Kd;

Kvtheta = controladorTheta.Kv;
Kptheta = controladorTheta.Kp;

g = planta.g;
J = planta.J;

aux = Kvtheta.*Kptheta.*g.*[Kdx, Kpx, Kix];
num = aux(3);
denom = [J, Kvtheta, Kvtheta*Kptheta, aux];
dinamica = tf(num, denom);

end