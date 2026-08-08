%% Sempre faça
clc;
clear all;
close all;

%% Entrada e saída
nomeCidade  = input('Digite o nome da cidade: ', 's');
disp(nomeCidade);
fprintf('Cidade escolhida é: %s\n', nomeCidade);

%% if, elseif e else
x = input('Digite o valor de x: ');
disp(x);

if x > 10
    disp('Maior que 10');
elseif x == 10
    disp('Igual a 10');
else
    disp('Menor que 10');
end

%% for
for i = 1:5
     resultado = i*3;
     disp(resultado);
end


%% while
x = 0;
i = 0;
while i < 5
    x = x + 1;
    i = i + 1;
    disp(['Valor de x: ', num2str(x)]);
end

%% switch e função
opcao = 2;
switch opcao
    case 1
        disp('Opção A');
    case 2
        disp('Opção B');
    case 3
        disp('Opção C');
    otherwise
        disp('Opção inválida');
end

%% Chamar função 
z = 5;
resultado = funcao_triplo(z);
fprintf('Triplo de %g é %g\n', z, resultado);
