function controlador = projetarControladorArfagem(requisitos, planta)
% controlador = projetarControladorArfagem(requisitos, planta) projeta o
% controlador de arfagem. As entradas da funcao sao as structs requisitos e
% planta, que contem os requisitos e os parametros da planta,
% respectivamente. Os requisitos sao:
% requisitos.tr: tempo de subidade de 0 a 100%.
% requisitos.Mp: sobressinal.
% A planta eh dada por:
% planta.m: massa.
% planta.J: inercia.
% planta.l: distancia entre os rotores.
% planta.g: aceleracao da gravidade.
% A saida da funcao eh a struct controlador com:
% controlador.Kp: ganho proporcional.
% controlador.Kv: ganho de velocidade.

J = planta.J;

tr = requisitos.tr;
Mp = requisitos.Mp;

xi = sqrt( log(Mp)^2/(pi^2 + log(Mp)^2 ) );
wn = (pi - acos(xi))/(tr * sqrt(1 - xi^2));

controlador.Kv = 2*J*xi*wn;
controlador.Kp = J*wn^2/controlador.Kv;

end