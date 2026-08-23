% Lista 4
clc;
clear all;
close all;

%% Exercício 1 Sistema massa-mola-amortecedor - Caixa branca

% M = massa do corpo em kg
M = 2;

% B = coeficiente de amortecimento
B = 3;

% Constante elástica
K = 8;

% Numerador
num  = 1;

% Denominador da funcao de transferencia
den = [M B K]; % [sˆ2, sˆ1, sˆ0]

% Criando a funcao de transferencia do sistema
% G = 1/((M*sˆ2) + (B*s) + K)
G1 = tf(num, den);
disp('Função de tansferência: ');
display(G1);

% Resposta ao degrau

figure
step(G1, 100)
hold on

% Representacao da forca aplicada ao sistema
plot([0 0 100], [0 1 1], "r--", "LineWidth", 1)

grid on

xlabel("Tempo (s)")
ylabel("Posição (m)")
title("Sistema massa-mola - Caixa branca")


%% Exercício 2 - Sistema circuito RC - Caixa cinza

% R = resistencia eletrica em ohms
R = 1000;

% tau = constante de tempo desejada do circuito
tau = 2;

% C = capacitancia calculada a partir de tau = R*C
C = tau/R;
disp ('Capacitância: ')
display(C);

% Numerador da funcao de transferencia
num = 1;

% Denominador da funcao de transferencia
den = [R*C 1];

% Criando a funcao de transferencia do circuito
G1 = tf(num, den);
disp('Função de tansferência: ');
display(G1);


% Resposta ao degrau

figure
step(G1, 10)
grid on

xlabel("Tempo (s)")
ylabel("Tensao de saida (V)")
title("Circuito RC - Caixa cinza")

%% Exercício 3 - Sistema massa-atrito - Caixa cinza


M = 4; % M = massa do corpo em kg
F = 1; %Força aplicada
v = 0.5; %velocidade em regime permanente

% B = coeficiente de atrito é desconhecido
B = F/v;
disp(['O valor de B é: ', num2str(B)]);

% Numerador da funcao de transferencia
num = 1;

% Denominador da funcao de transferencia
den = [M B];

% Criando a funcao de transferencia do sistema
G1 = tf(num, den);
disp('A Função de tansferência é:');
display(G1);

% Resposta ao degrau

figure
step(G1, 100)
hold on

% Representacao da forca aplicada ao sistema
plot([0 0 100], [0 1 1], "r--", "LineWidth", 1)

grid on

xlabel("Tempo (s)")
ylabel("Velocidade (m/s)")
title("Sistema massa-atrito - Caixa Cinza")
legend("Velocidade do corpo", "Forca aplicada", "Location", "southeast")
