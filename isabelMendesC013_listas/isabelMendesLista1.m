%% Sempre faça
clc;
clear all;
close all;

%% Operações básicas
a = 12;
b = 5;
% Realizar adição e subtração
soma = a + b;
subtracao = a - b;
% Realizar multiplicação e divisão
multiplicacao = a * b;
divisao = a / b;

%% Raiz, arredondamento e resto
raiz = sqrt(144);
arredondado = round(7.6);
resto = mod(250, 17);

%% MDC e MMC
% Calcular o Máximo Divisor Comum (MDC) e o Mínimo Múltiplo Comum (MMC)
mdc = gcd(24, 36);
mmc = (12 * 18) / mdc;
%% Exponenciação e trigonometria

exponencial = exp(2);
% Lembrar de transformar
% em radianos ou usar a fórmula para ângulo em graus.
seno_deg = sind(30);
coseno_deg = cosd(60);
tangente_deg = tand(45);
% ou
x = pi/6;
y = pi/3;
z = pi/4;
% Calcular o seno, cosseno e tangente dos ângulos em radianos
seno_rad = sin(x);
coseno_rad = cos(y);
tangente_rad = tan(z);
%% Criando vetores

v1 = 1:10;
v2 = 10:-1:1;
v3 = 0:2:20;
v4 = linspace(0, 100, 5);

%% Acessando posições de um vetor
v = [4 8 15 16 23 42];
primeiroElemento = v(1);
ultimoElemento = v(end);
elementoSelecionados = v(2:4);
elementosEspecificos = v([1 3 6]);

%% Informações de um vetor
v = [5 10 15 20 25];
quantidade = length(v);
dimensao = size(v);
somaElementos = sum(v);
mediaElementos = mean(v);
maiorValor = max(v);
menorValor = min(v);
%% Vetor linha, vetor coluna
v = [10 20 30 40];
vColuna = transpose(v);
dimensao = size(v);
dimensaoColuna = size (vColuna);

%% Criando e acessando uma matriz
A = [3 6 9; 2 4 8; 1 5 7];
% mostre:
elementoEspecifico = A(2, 3);
primeiraLinha = A(1,:);
segundaColuna = A(:,2);
dimensaoA = size(A);

%% Operações com matrizes
A = [1 2; 3 4];
B = [2 0; 1 5];
% Operações
somaMatriz = A + B;
multiplicacaoMatriz = A * B;
A_transposta = transpose(A);

%% Outras operações com matriz
m1 = zeros(3, 3);
m2 = ones(2, 4);
m3 = rand(3, 3);






