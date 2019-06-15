%基于BP网络的短时通信流量预测
clc
clear
close all

%% 输入输出数据归一化
load traffic_flux input input_test output output_test

[inputn,inputps]=mapminmax(input');
[outputn,outputps]=mapminmax(output'); 
% inputn=inputn';
% outputn=outputn';

%预测输入归一化
x=mapminmax('apply',input_test',inputps);
x=x';
% y=mapminmax('apply',output_test',outputps);
k=0;


%% 建立网络并训练
rand('state',0);
net=newff(inputn,outputn,{5},{'tansig','purelin'},'traingd');
% ,{'tansig','purelin'},'traingd'
net.trainParam.epochs = 1000;     % 最大训练次数 
net.trainParam.goal = 0.05;         % 最小均方误差 
net.trainParam.min_grad = 1e-10;    % 最小梯度 
net.trainParam.show = 200;          % 训练显示间隔 
net.trainParam.time = inf;          % 最大训练时间 
net.trainParam.max_fail = 20;         %检验步数
net=train(net,inputn,outputn);

%% 预测
yuce=sim(net,x');

%预测输出反归一化
ybp=mapminmax('reverse',yuce,outputps);

perf=perform(net,ybp,output_test')

ape=abs((output_test'-ybp)./output_test');
l=length(ape);
mape=0;
for z=1:l
    mape=mape+ape(z);
end
mape=mape/92


%% 结果分析
figure(1)
plot(ybp)
hold on
plot(output_test','k*:')
line([0,100],[75,75],'color','r','linestyle','--');
title('基于BP的通信流量预测图','fontsize',12)
legend('预测流量','实际流量')
xlabel('时间点')
ylabel('流量')
figure(2)
plot(ape)