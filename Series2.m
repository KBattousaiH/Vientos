close all
clear all
clc
%% Vientos
%
D40323=importdata('john2.d04.TS.20230323'); % 72 horas (23 24 25)
D40325=importdata('john2.d04.TS.20230325'); % 120 horas(25 26 27 28 29)
D40327=importdata('john2.d04.TS.20230327'); % 120 horas(27 28 29 30 31)
D40328=importdata('john2.d04.TS.20230328'); % 120 horas(28 29 30 31 01)
D40329=importdata('john2.d04.TS.20230329'); % 120 horas(29 30 31 01 02)
%
data=xlsread('viento_johnson2_20230101_20230329.xlsx');
wskmh=data(:,2);
theta_dat=data(23055-8:end,4);
ws_kmh=wskmh(23055-8:end); % 23 24 25 26 27 28 29
t1_dat = datetime(2023,03,23,0,0,0);
t2_dat = datetime(2023,03,29,20,45,0);
t_dat=linspace(t1_dat,t2_dat,length(ws_kmh));
tdat=datenum(t_dat');
%
u_dat=ws_kmh.*cos(theta_dat);
v_dat=ws_kmh.*sin(theta_dat);
%
% 1     2    3          4           5      6    7
% Nudos Km/h Prom-Nudos Dir. viento Nombre Temp Pres
%
u23=D40323.data(:,8);
u25=D40325.data(:,8);
u27=D40327.data(:,8);
u28=D40328.data(:,8);
u29=D40329.data(:,8);
%
% V
v23=D40323.data(:,9);
v25=D40325.data(:,9);
v27=D40327.data(:,9);
v28=D40328.data(:,9);
v29=D40329.data(:,9);
%
% Mag (ws)
ws23=sqrt(u23.^2 + v23.^2);
ws25=sqrt(u25.^2 + v25.^2);
ws27=sqrt(u27.^2 + v27.^2);
ws28=sqrt(u28.^2 + v28.^2);
ws29=sqrt(u29.^2 + v29.^2);
%
% % Vectores de tiempo
% t1_23 = datetime(2023,03,23,0,0,0);
% t2_23 = datetime(2023,03,25,0,0,0);
% t_23=linspace(t1_23,t2_23,length(u23));
% t23=datenum(t_23');
% %
% t1_25 = datetime(2023,03,25,0,0,0);
% t2_25 = datetime(2023,03,29,0,0,0);
% t_25=linspace(t1_25,t2_25,length(u25));
% t25=datenum(t_25');
% %
% t1_27 = datetime(2023,03,27,0,0,0);
% t2_27 = datetime(2023,03,31,0,0,0);
% t_27=linspace(t1_27,t2_27,length(u27));
% t27=datenum(t_27');
% %
% t1_28 = datetime(2023,03,28,0,0,0);
% t2_28 = datetime(2023,04,01,0,0,0);
% t_28=linspace(t1_28,t2_28,length(u28));
% t28=datenum(t_28');
% %
% t1_29 = datetime(2023,03,29,0,0,0);
% t2_29 = datetime(2023,04,02,0,0,0);
% t_29=linspace(t1_29,t2_29,length(u29));
% t29=datenum(t_29');
%
%% Series horarias
% Datos
WS_dat=xhr(ws_kmh,12);
U_dat=xhr(u_dat,12);
V_dat=xhr(v_dat,12);
%
U23=xhr(u23,1620); %1620 son los pasos de tiempo que hacen una hora en el Dom4
U25=xhr(u25,1620);
U27=xhr(u27,1620);
U28=xhr(u28,1620);
U29=xhr(u29,1620);
%
V23=xhr(v23,1620); 
V25=xhr(v25,1620);
V27=xhr(v27,1620);
V28=xhr(v28,1620);
V29=xhr(v29,1620);
%
WS23=sqrt(U23.^2 + V23.^2);
WS25=sqrt(U25.^2 + V25.^2);
WS27=sqrt(U27.^2 + V27.^2);
WS28=sqrt(U28.^2 + V28.^2);
WS29=sqrt(U29.^2 + V29.^2);
%
t1_dat = datetime(2023,03,23,0,0,0); tdat = t1_dat + hours(1:length(WS_dat));
fdat=datenum(tdat');
t1_23 = datetime(2023,03,23,0,0,0); t23 = t1_23 + hours(1:length(WS23));
f23=datenum(t23');
t1_25 = datetime(2023,03,25,0,0,0); t25 = t1_25 + hours(1:length(WS25));
f25=datenum(t25');
t1_27 = datetime(2023,03,27,0,0,0); t27 = t1_27 + hours(1:length(WS27));
f27=datenum(t27');
t1_28 = datetime(2023,03,28,0,0,0); t28 = t1_28 + hours(1:length(WS28));
f28=datenum(t28');
t1_29 = datetime(2023,03,29,0,0,0); t29 = t1_29 + hours(1:length(WS29));
f29=datenum(t29');
%
%%
%*1000/3600
fp=figure();
subplot(3,1,1)
hold on
plot(f23,WS23,'LineWidth',1.2)
plot(f25,WS25,'LineWidth',1.2)
plot(f27,WS27,'LineWidth',1.2)
plot(f28,WS28,'LineWidth',1.2)
plot(f29,WS29,'LineWidth',1.2)
plot(fdat,WS_dat*1000/3600,'k','LineWidth',1.5)
legend('03/23-03/25','03/25-03/29','03/27-03/31','03/28-04/01','03/29-04/02','Est. Johnson2')
grid on
datetick
title('Rapidez del viento','Fontsize',22)
ylabel('m/s')
%
subplot(3,1,2)
hold on
plot(f23,U23,'LineWidth',1.2)
plot(f25,U25,'LineWidth',1.2)
plot(f27,U27,'LineWidth',1.2)
plot(f28,U28,'LineWidth',1.2)
plot(f29,U29,'LineWidth',1.2)
plot(fdat,U_dat*1000/3600,'k','LineWidth',1.5)
legend('03/23-03/25','03/25-03/29','03/27-03/31','03/28-04/01','03/29-04/02','Est. Johnson2')
grid on
datetick
title('U','Fontsize',22)
ylabel('m/s')
ylim([-10 10])
%
subplot(3,1,3)
hold on
plot(f23,V23,'LineWidth',1.2)
plot(f25,V25,'LineWidth',1.2)
plot(f27,V27,'LineWidth',1.2)
plot(f28,V28,'LineWidth',1.2)
plot(f29,V29,'LineWidth',1.2)
plot(fdat,V_dat*1000/3600,'k','LineWidth',1.5)
legend('03/23-03/25','03/25-03/29','03/27-03/31','03/28-04/01','03/29-04/02','Est. Johnson2')
grid on
datetick
title('V','Fontsize',22)
ylabel('m/s')
ylim([-10 10])
xlabel('Fechas')

set(gcf,'position',[10,10,2000,1000]);
saveas(fp,'D4_M_U_V','png');

% %%
% figure()
% feather(U_dat,V_dat)
% hold on
% feather(u23,v23)
% set(gca, 'XLim',[0 numel(u_dat)])                                       % Set X-Axis Limits
% xt = get(gca,'XTick') ;                                              % Get X-Tick Values
% xt(1) = 1;
% txt = t_dat(xt);                                                        % Define ‘t’ Using ‘xt’
% set(gca, 'XTick',xt, 'XTickLabel',datestr(txt,'dd/mm'))%, 'XTickLabelRotation',30)
% 
