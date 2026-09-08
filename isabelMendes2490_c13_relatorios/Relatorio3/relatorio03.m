%% Relatório 3
clc;
clear all;
close all;

%% Exercício 1 - Identificação de sistema de primeira ordem
%Resposta a um degrau unitário (amplitude 1), o valor final = ganho do sistema.

K = 1.8;
T = 1.2;

% G(s) = K/(Ts + 1) -> Forma padrao
G = tf(K, [T 1])

%Polo, tempo de subida, tempo de acomodação e ganho:
info = stepinfo(G);
polo = pole(G)
tempos_subida = [info.RiseTime]
tempos_acomodacao = [info.SettlingTime]
ganho = K

%Resposta ao degrau
t = 0:8;

figure(1)
step(G, t); 
grid on; 
title('Resposta ao Degrau do Sistema de Primeira Ordem');
xlabel('Tempo (s)');
ylabel('Amplitude');

% Amplitude aumentou
A = 2.5;
G2 = tf(A*K, [T 1])
info = stepinfo(G2);


figure(2)
step(G2, t);
grid on;
title('Resposta ao Degrau do Sistema Aumentado');
xlabel('Tempo (s)');
ylabel('Amplitude');

% Mudando a amplitude do sistema, a resposta atinge um patamar mais alto, 
% o sistema não fica mais lento nem mais rápido para estabilizar, nem a
% posição do polo é alterada.

%% Exercício 2 - 3 Sistemas de segunda ordem
% zeta = coeficiente de amortecimento (zeta = 3/(2*wn))
% wn = frequencia natural
% polos
% tipo de resposta quanto ao amortecimento
% ganho em regime permanente

%Classificar por tipo de amortecimento - depende do zeta
classifyZeta = @(z) disp_tipo(z);

%Sistema A

G_A = tf(25, [1 3 25])
[wn_polos, zeta_polos, polos] = damp(G_A);
wnA = wn_polos(1);
zetaA = zeta_polos(1);
polosA = polos
ganhoGA = dcgain(G_A);
tipoA = obterTipo(zetaA);
fprintf('Sistema A: wn=%.3f, zeta=%.3f -> %s, ganho DC=%.3f\n', wnA, zetaA, tipoA, ganhoGA)


%Sistema B

G_B = tf(25, [1 10 25])
[wn_polos, zeta_polos, polos] = damp(G_B);
wnB = wn_polos(1);
zetaB = zeta_polos(1);
polosB = polos
ganhoGB = dcgain(G_B);
tipoB = obterTipo(zetaB);
fprintf('Sistema B: wn=%.3f, zeta=%.3f -> %s, ganho DC=%.3f\n', wnB, zetaB, tipoB, ganhoGB)


%Sistema C

G_C = tf(25, [1 16 25])
[wn_polos, zeta_polos, polos] = damp(G_C);
wnC = wn_polos(1);
zetaC = zeta_polos(1);
polosC = polos
ganhoGC = dcgain(G_C);
tipoC = obterTipo(zetaC);
fprintf('Sistema C: wn=%.3f, zeta=%.3f -> %s, ganho DC=%.3f\n', wnC, zetaC, tipoC, ganhoGC)


% Função para classificar o tipo de amortecimento
function tipo = obterTipo(z)
    if z < 1
        tipo = 'Subamortecido';
    elseif z == 1
        tipo = 'Criticamente amortecido';
    else
        tipo = 'Superamortecido';
    end
end



% Comparação dos três sistemas
t = 0:0.01:8; 
figure (1)
step(G_A, G_B, G_C, t);
grid on
title('Comparacao entre sistemas de segunda ordem')
xlabel('Tempo (s)');
ylabel('Amplitude');
legend('SistA', 'SistB', 'SistC','Location','best')

hold off

% Figura com os polos
figure(2);
pzmap(G_A, G_B, G_C);
grid on;
title('Polos dos Sistemas de Segunda Ordem');
xlabel('Parte Real');
ylabel('Parte Imaginária');
legend('SistA', 'SistB', 'SistC', 'Location', 'best');

% Sobressinal não permitido e com resposta mais rápida
% Análise do sobressinal e tempo de acomodação para cada sistema
infoA = stepinfo(G_A);
sobressinalA = infoA.Overshoot
tolerancia_acomodacaoA = infoA.SettlingTime

infoB = stepinfo(G_B);
sobressinalB = infoB.Overshoot
tolerancia_acomodacaoB = infoB.SettlingTime

infoC = stepinfo(G_C);
sobressinalC = infoC.Overshoot
tolerancia_acomodacaoC = infoC.SettlingTime


% O Sistema A possui sobressinal.
%O Sistema B apresenta o menor tempo de acomodação entre os sistemas, logo
% é o mais adequado para a aplicação
% Já o Sistema C terá um tempo significativamente maior devido ao efeito de
% lentidão do superamortecimento

%% Exercício 3 - Avaliação de desempenho de dois sistemas
t = 0:0.01:8; 

%Características do sistema 1
G_1 = tf(16, [1 2.8 16])

[wn_polos, zeta_polos, polos] = damp(G_1);
wnG_1 = wn_polos(1)
zetaG_1 = zeta_polos(1)
polosG_1 = polos


% Valor final e resposta ao degrau
valor_final = dcgain(G_1)
[y, t] = step(G_1, t);

% Tempo de atraso: instante em que a resposta atinge 50% do valor final
indice_atrasoG_1 = find(y >= 0.5*valor_final, 1);

tdG_1 = t(indice_atrasoG_1)

% Configuracoes utilizadas pelo stepinfo
limites_subidaG_1 = [0 1];
tolerancia_acomodacaoG_1 = 0.02; % 2%


infoG_1 = stepinfo(y, t, valor_final, 'RiseTimeLimits', limites_subidaG_1, ...
    'SettlingTimeThreshold', tolerancia_acomodacaoG_1);

%info = stepinfo(y, t, valor_final, 'RiseTimeLimits', limites_subida, ...
%   'SettlingTimeThreshold', 0.02);


tempoSubidaG_1 = infoG_1.RiseTime
tempoPicoG_1 = infoG_1.PeakTime
picoG_1 = infoG_1.Peak
sobresinalG_1 = infoG_1.Overshoot
tempoAcomodacaoG_1 = infoG_1.SettlingTime

%------------------------------------------------------------------------
%Características do sistema 2
G_2 = tf(25, [1 6.5 25])

[wn_polos, zeta_polos, polos] = damp(G_2);
wnG_2 = wn_polos(1)
zetaG_2 = zeta_polos(1)
polosG_2 = polos


% Valor final e resposta ao degrau
valor_final = dcgain(G_2)
[y, t] = step(G_2, t);

% Tempo de atraso: instante em que a resposta atinge 50% do valor final
indice_atrasoG_2 = find(y >= 0.5*valor_final, 1);

tdG_2 = t(indice_atrasoG_2)

% Configuracoes utilizadas pelo stepinfo
limites_subidaG_2 = [0 1];
tolerancia_acomodacaoG_2 = 0.02; % 2%


infoG_2 = stepinfo(y, t, valor_final, 'RiseTimeLimits', limites_subidaG_2, ...
    'SettlingTimeThreshold', tolerancia_acomodacaoG_2);

%info = stepinfo(y, t, valor_final, 'RiseTimeLimits', limites_subida, ...
%   'SettlingTimeThreshold', 0.02);


tempoSubidaG_2 = infoG_2.RiseTime
tempoPicoG_2 = infoG_2.PeakTime
picoG_2 = infoG_2.Peak
sobresinalG_2 = infoG_2.Overshoot
tempoAcomodacaoG_2 = infoG_2.SettlingTime
%------------------------------------------------------------------------

% Validação do Sistema 1
if sobresinalG_1 < 10 && tempoAcomodacaoG_1 < 1.5
    fprintf('Sistema 1: APROVADO (Overshoot = %.2f%%, Ts = %.2fs)\n', sobresinalG_1, tempoAcomodacaoG_1);
else
    fprintf('Sistema 1: REPROVADO (Overshoot = %.2f%%, Ts = %.2fs)\n', sobresinalG_1, tempoAcomodacaoG_1);
end

% Validação do Sistema 2
if sobresinalG_2 < 10 && tempoAcomodacaoG_2 < 1.5
    fprintf('Sistema 2: APROVADO (Overshoot = %.2f%%, Ts = %.2fs)\n', sobresinalG_2, tempoAcomodacaoG_2);
else
    fprintf('Sistema 2: REPROVADO (Overshoot = %.2f%%, Ts = %.2fs)\n', sobresinalG_2, tempoAcomodacaoG_2);
end
fprintf('=======================================================\n\n');


%Resposta ao degrau

figure(1);
step(G_1, G_2, t);
grid on;
title('Resposta ao Degrau dos Sistemas 1 e 2');
xlabel('Tempo (s)');
ylabel('Amplitude');
legend('Sistema 1', 'Sistema 2', 'Location', 'best');

%O Sistema 2 é o escolhido por ser o único a cumprir as metas exigidas, 
% garantindo sobressinal de ~4.5% (<10%) e acomodação em ~1.2s (<1.5s).


%% Exercício 4 - Seleção de parâmetro para sistema de segunda ordem
t = 0:0.01:8;
% Configuracoes utilizadas pelo stepinfo
indice_atraso = find(y >= 0.5*valor_final, 1);
td = t(indice_atraso);
limites_subida = [0 1];
tolerancia_acomodacao = 0.02; % 2%


%Configuração A
zetaA = 0.35;
wnA = 6;

% Funcao de transferencia na forma padrao
GA = tf(wnA^2, [1 2*zetaA*wnA wnA^2]);

polosA = pole(GA);
% Valor final e resposta ao degrau
valor_finalA = dcgain(GA);
[y, t] = step(GA, t);


infoA = stepinfo(y, t, valor_finalA, 'RiseTimeLimits', limites_subida, ...
    'SettlingTimeThreshold', tolerancia_acomodacao);

tempoSubidaA = infoA.RiseTime;
tempoPicoA = infoA.PeakTime;
picoA = infoA.Peak;
sobresinalA = infoA.Overshoot;
tempoAcomodacaoA = infoA.SettlingTime;

%Configuração B
zetaB = 0.55;
wnB = 5;

% Funcao de transferencia na forma padrao
GB = tf(wnB^2, [1 2*zetaB*wnB wnB^2]);

polosB = pole(GB);
% Valor final e resposta ao degrau
valor_finalB = dcgain(GB);
[y, t] = step(GB, t);


infoB = stepinfo(y, t, valor_finalB, 'RiseTimeLimits', limites_subida, ...
    'SettlingTimeThreshold', tolerancia_acomodacao);

tempoSubidaB = infoB.RiseTime;
tempoPicoB = infoB.PeakTime;
picoB = infoB.Peak;
sobresinalB = infoB.Overshoot;
tempoAcomodacaoB = infoB.SettlingTime;

%Configuração C
zetaC = 0.70;
wnC = 4;

% Funcao de transferencia na forma padrao
GC = tf(wnC^2, [1 2*zetaC*wnC wnC^2]);

polosC = pole(GC);
% Valor final e resposta ao degrau
valor_finalC = dcgain(GC);
[y, t] = step(GC, t);


infoC = stepinfo(y, t, valor_finalC, 'RiseTimeLimits', limites_subida, ...
    'SettlingTimeThreshold', tolerancia_acomodacao);

tempoSubidaC = infoC.RiseTime;
tempoPicoC = infoC.PeakTime;
picoC = infoC.Peak;
sobresinalC = infoC.Overshoot;
tempoAcomodacaoC = infoC.SettlingTime;

%Configuração D
zetaD = 0.80;
wnD = 3.2;

% Funcao de transferencia na forma padrao
GD = tf(wnD^2, [1 2*zetaD*wnD wnD^2]);

polosD = pole(GD);
% Valor final e resposta ao degrau
valor_finalD = dcgain(GD);
[y, t] = step(GD, t);


infoD = stepinfo(y, t, valor_finalD, 'RiseTimeLimits', limites_subida, ...
    'SettlingTimeThreshold', tolerancia_acomodacao);

tempoSubidaD = infoD.RiseTime;
tempoPicoD = infoD.PeakTime;
picoD = infoD.Peak;
sobresinalD = infoD.Overshoot;
tempoAcomodacaoD = infoD.SettlingTime;

%Resposta ao degrau

figure(1);
step(GA, GB, GC, GD, t);
grid on;
title('Resposta ao Degrau das Configurações A, B, C e D');
xlabel('Tempo (s)');
ylabel('Amplitude');
legend('Configuração A', 'Configuração B','Configuração C', 'Configuração D', 'Location', 'best');



% Usando for 

configuracoes = {'configuração A', 'configuração B', 'configuração C', 'configuração D'};
sobressinais = [sobresinalA, sobresinalB, sobresinalC, sobresinalD];
acomodacoes  = [tempoAcomodacaoA, tempoAcomodacaoB, tempoAcomodacaoC, tempoAcomodacaoD];
subidas      = [tempoSubidaA, tempoSubidaB, tempoSubidaC, tempoSubidaD];

% variáveis de decisão
melhor_tr = Inf;
indice_escolhido = 0;

for i = 1:4
    % Verifica se o sistema atende aos limites de segurança trabalhados em aula
    atende_requisitos = (sobressinais(i) < 10) && (acomodacoes(i) < 1.5);

    if atende_requisitos
        fprintf('%s: APROVADO nos requisitos base (tempoSubida = %.3fs, Overshoot = %.2f%%, tempoAcomodação = %.2fs).\n', ...
            configuracoes{i}, subidas(i), sobressinais(i), acomodacoes(i));

        % Critério de desempate: menor tempo de subida
        if subidas(i) < melhor_tr
            melhor_tr = subidas(i);
            indice_escolhido = i;
        end
    else
        fprintf('%s: REPROVADO (Overshoot = %.2f%% [Máx: 10%%] ou Ts = %.2fs [Máx: 1.5s]).\n', ...
            configuracoes{i}, sobressinais(i), acomodacoes(i));
    end
end
if indice_escolhido > 0
    fprintf('CONFIGURAÇÃO SELECIONADA FINAL: %s (Menor tempo de subida aprovado: %.3fs)\n', configuracoes{indice_escolhido}, melhor_tr);
else
    fprintf('CONFIGURAÇÃO SELECIONADA FINAL: Nenhum sistema atendeu a todos os requisitos.\n');
end


% Observando os gráficos e o loop do for, a configuração B apresenta o menor tempo de subida
% com overshoot aceitável, o que garante resposta rápida sem comprometimento de estabilidade.

% Já a configuração A com maior overshoot e aquelas com acomodação longa
% foram descartadas porque aumentam risco de oscilações indesejadas ou resposta lenta.


%% Exercício 5 - Comparação entre sistemas

t = 0:0.01:8;
limites_subida = [0 1];
tolerancia_acomodacao = 0.02; 


%Sistema de primeira ordem
G_A = tf(2, [1.2 1]);
valor_finalA = dcgain(G_A);

infoA = stepinfo(G_A, 'RiseTimeLimits', [0.1 0.9], ...
    'SettlingTimeThreshold', tolerancia_acomodacao);

tempoSubidaA = infoA.RiseTime;
poloA = pole(G_A);
tempoSubidaA = infoA.RiseTime
sobresinalA = infoA.Overshoot
tempoAcomodacaoA = infoA.SettlingTime



%Sistema de segunda ordem
G_B = tf(32, [1 5.6 16]);
[wn_polos, zeta_polos, polos] = damp(G_B);
wnG_B = wn_polos(1);
zetaG_B = zeta_polos(1);
polosB = pole(G_B);
% Valor final e resposta ao degrau
valor_finalB = dcgain(G_B);
[y, t_sim] = step(G_B, t); 


infoB = stepinfo(y, t_sim, valor_finalB, 'RiseTimeLimits', limites_subida, ...
    'SettlingTimeThreshold', tolerancia_acomodacao);

tempoSubidaB = infoB.RiseTime
tempoPicoB = infoB.PeakTime;
picoB = infoB.Peak;
sobresinalB = infoB.Overshoot
tempoAcomodacaoB = infoB.SettlingTime;




% Resposta ao degrau dos sistemas
figure(1);
step(G_A, G_B, t);
grid on;
title('Resposta ao Degrau dos Sistemas de Primeira e Segunda Ordem');
xlabel('Tempo (s)');
ylabel('Amplitude');
legend('Sistema de Primeira Ordem', 'Sistema de Segunda Ordem', 'Location', 'best');

% Resposta para degrau de amplitude 1.5
A = 1.5;
valor_finalA_ampliado = A * dcgain(G_A);

valor_finalB_ampliado = A * dcgain(G_B);

figure(2)
step(A*G_A, A*G_B, t);
grid on
title("Resposta ao degrau de amplitude 1.5")
xlabel("Tempo (s)")
ylabel("Amplitude")
legend('Sistema de Primeira Ordem', 'Sistema de Segunda Ordem', 'Location', 'best');

%Rapidez: O equipamento B possui um tempo de subida menor e reage mais 
% rápido ao estímulo inicial que o equipamento A.

%Sobressinal: O equipamento A não oscila e não possui sobressinal, 
% enquanto o equipamento B apresenta sobressinal devido ao amortecimento.

%Regime Permanente: Ambos os equipamentos possuem ganho estático igual
% a 2, logo atingem exatamente o mesmo valor final na saída para as mesmas 
% entradas (1.5 no degrau ampliado).