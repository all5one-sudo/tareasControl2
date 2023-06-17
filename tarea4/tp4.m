%% Tarea 4: Profesor Laboret
% Para la tarea se elige la primer fila de la tabla de los valores de masa, 
% longitud, coeficiente de rozamiento y ángulo de referencia en grados del sistema 
% péndulo simple.

clear all; close all; clc
%% 
% Se comienza definiendo los parámetros a utilizar.

m = 3
b = 0.1
delta = 135
l = 1;
G = 10;
%% 
% Se obtiene el modelo en espacio de estado para el sistema del péndulo linealizado 
% a partir del modelo de Simulink.

[A,B,C,D] = linmod('pendulo_mod_tarea',delta*pi/180)
%% 
% Los autovalores de la matriz A, que son los polos del sistema, son:

eig(A)
%% 
% El rango  de la matriz de controlabilidad es el siguiente:

rank(ctrb(A,B))
%% 
% Se amplían las matrices, de modo de obtener la acción integral del controlador.

Aa = [[A;C] zeros(3,1)]
Ba = [B;0]
eig(Aa)
rank(ctrb(Aa,Ba))
%% 
% Polo triple en -4.

p = -4
K = acker(Aa,Ba,[p p p])
k1 = K(1)
k2 = K(2)
k3 = K(3)
eig(Aa-Ba*K) 
tscalc = 7.5/(-p) 
sim('pendulo_pid_tarea')
ym1 = yout;
vel1 = velocidad;
tor1 = torque;
int1 = accint;
plot(tout,yout, 'LineWidth',1.5)
grid on
title('Salida')
xlabel('Tiempo [seg]'); 
ylabel('Desplazamiento [grados]')
plot(yout,velocidad, 'LineWidth',1.5) 
grid 
title('Plano de fases');
xlabel('Angulo'); 
ylabel('Velocidad angular')
plot(tout,torque, 'LineWidth',1.5) 
grid on, 
title('Torque'); 
xlabel('Tiempo [seg]'); 
ylabel('Torque [Nm]')
plot(tout,-accint, 'LineWidth',1.5) 
grid  
title('Accion integral'); 
xlabel('Tiempo [seg]'); 
ymax = max(yout) 
S = (ymax-delta)/delta*100 
erel = (delta-yout)/delta; 
efinal = erel(end)
ind = find(abs(erel)>.02); 
tss = tout(ind(end)) 
yte = yout(ind(end)) 
uf = torque(end) 
Intf = -accint(end) 
%% 
% Para probar la robustez del controlador, se simulará con variaciones de 10% 
% en el valor de masa.

m = 3*1.1
b = 0.1
delta = 135
l = 1;
G = 10;
[A,B,C,D] = linmod('pendulo_mod_tarea',delta*pi/180)
eig(A)
rank(ctrb(A,B))
Aa = [[A;C] zeros(3,1)]
Ba = [B;0]
eig(Aa)
rank(ctrb(Aa,Ba))
p = -4
K = acker(Aa,Ba,[p p p])
k1 = K(1)
k2 = K(2)
k3 = K(3)
eig(Aa-Ba*K) 
tscalc = 7.5/(-p) 
sim('pendulo_pid_tarea')
ym2 = yout;
vel2 = velocidad;
tor2 = torque;
int2 = accint;
plot(tout,yout, 'LineWidth',1.5)
grid on
title('Salida')
xlabel('Tiempo [seg]'); 
ylabel('Desplazamiento [grados]')
plot(yout,velocidad, 'LineWidth',1.5) 
grid 
title('Plano de fases');
xlabel('Angulo'); 
ylabel('Velocidad angular')
plot(tout,torque, 'LineWidth',1.5) 
grid on, 
title('Torque'); 
xlabel('Tiempo [seg]'); 
ylabel('Torque [Nm]')
plot(tout,-accint, 'LineWidth',1.5) 
grid  
title('Accion integral'); 
xlabel('Tiempo [seg]'); 
ymax = max(yout) 
S = (ymax-delta)/delta*100 
erel = (delta-yout)/delta; 
efinal = erel(end)
ind = find(abs(erel)>.02); 
tss = tout(ind(end)) 
yte = yout(ind(end)) 
uf = torque(end) 
Intf = -accint(end)
m = 3*0.9
b = 0.1
delta = 135
l = 1;
G = 10;
[A,B,C,D] = linmod('pendulo_mod_tarea',delta*pi/180)
eig(A)
rank(ctrb(A,B))
Aa = [[A;C] zeros(3,1)]
Ba = [B;0]
eig(Aa)
rank(ctrb(Aa,Ba))
p = -4
K = acker(Aa,Ba,[p p p])
k1 = K(1)
k2 = K(2)
k3 = K(3)
eig(Aa-Ba*K) 
tscalc = 7.5/(-p) 
sim('pendulo_pid_tarea')
ym3 = yout;
vel3 = velocidad;
tor3 = torque;
int3 = accint;
plot(tout,yout, 'LineWidth',1.5)
grid on
title('Salida')
xlabel('Tiempo [seg]'); 
ylabel('Desplazamiento [grados]')
plot(yout,velocidad, 'LineWidth',1.5) 
grid 
title('Plano de fases');
xlabel('Angulo'); 
ylabel('Velocidad angular')
plot(tout,torque, 'LineWidth',1.5) 
grid on, 
title('Torque'); 
xlabel('Tiempo [seg]'); 
ylabel('Torque [Nm]')
plot(tout,-accint, 'LineWidth',1.5) 
grid  
title('Accion integral'); 
xlabel('Tiempo [seg]'); 
ymax = max(yout) 
S = (ymax-delta)/delta*100 
erel = (delta-yout)/delta; 
efinal = erel(end)
ind = find(abs(erel)>.02); 
tss = tout(ind(end)) 
yte = yout(ind(end)) 
uf = torque(end) 
Intf = -accint(end)
%% 
% Se comparan las señales obtenidas:

plot(tout,ym1,"LineWidth",1.5)
hold on;
plot(tout,ym2,"LineWidth",1.5)
plot(tout,ym3,"LineWidth",1.5)
grid;
hold off;
title('Salida del sistema')
xlabel('Tiempo [seg]')
legend('m = 3','m = 3.3','m = 2.7')
plot(ym1,vel1,"LineWidth",1.5)
hold on;
plot(ym2,vel2,"LineWidth",1.5)
plot(ym2,vel2,"LineWidth",1.5)
grid;
hold off;
title('Planos de fases')
xlabel('Tiempo [seg]')
legend('m = 3','m = 3.3','m = 2.7')
plot(tout,tor1,"LineWidth",1.5)
hold on;
plot(tout,tor2,"LineWidth",1.5)
plot(tout,tor3,"LineWidth",1.5)
grid;
hold off;
title('Torques')
xlabel('Tiempo [seg]')
legend('m = 3','m = 3.3','m = 2.7')
plot(tout,-int1,"LineWidth",1.5)
hold on;
plot(tout,-int2,"LineWidth",1.5)
plot(tout,-int3,"LineWidth",1.5)
grid;
hold off;
title('Acciones integrales')
xlabel('Tiempo [seg]')
legend('m = 3','m = 3.3','m = 2.7')