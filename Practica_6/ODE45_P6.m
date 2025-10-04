clear;
close all;
clc;

% Parámetros del circuito
L = 2e-3;
R = 10;
C = 10e-6;
Vin = 32;
Duty = 0.4;

% Parámetros de la simulación
t_final = 0.01;
PWM = 100e3;
T_pwm = 1 / PWM;

% Condiciones iniciales
x0 = [0; 0];
tspan = [0 0.01];

A = [0, -1; 1/C, -1/(R*C)];
B = [Vin/L; 0];

[t, x] = ode45(@(t, x) Espacio_Estado(t, x, L, C, R, Vin, Duty), tspan, x0);

figure;
plot(t, x(:,1), 'b', 'LineWidth', 1.5, 'DisplayName', 'Corriente i_L');
hold on;
plot(t, x(:,2), 'r', 'LineWidth', 1.5, 'DisplayName', 'Voltaje V_c'); 
hold off;

xlabel('Tiempo (s)');
ylabel('Magnitud');
grid on;
title('Corriente en el inductor y voltaje en el capacitor');
legend('show');


function dx = Espacio_Estado(t, x, L, C, R, Vin, Duty)
    d = Duty;

    A = [0, -1/L; 1/C, -1/(R*C)];
    B = [Vin/L; 0];

    dx = A*x + B*d;
end