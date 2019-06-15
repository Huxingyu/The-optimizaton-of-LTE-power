%����BP����Ķ�ʱͨ������Ԥ��
clc
clear
close all

%% ����������ݹ�һ��
load traffic_flux input input_test output output_test

[inputn,inputps]=mapminmax(input');
[outputn,outputps]=mapminmax(output'); 
% inputn=inputn';
% outputn=outputn';

%Ԥ�������һ��
x=mapminmax('apply',input_test',inputps);
x=x';
% y=mapminmax('apply',output_test',outputps);
k=0;


%% �������粢ѵ��
rand('state',0);
net=newff(inputn,outputn,{5},{'tansig','purelin'},'traingd');
% ,{'tansig','purelin'},'traingd'
net.trainParam.epochs = 1000;     % ���ѵ������ 
net.trainParam.goal = 0.05;         % ��С������� 
net.trainParam.min_grad = 1e-10;    % ��С�ݶ� 
net.trainParam.show = 200;          % ѵ����ʾ��� 
net.trainParam.time = inf;          % ���ѵ��ʱ�� 
net.trainParam.max_fail = 20;         %���鲽��
net=train(net,inputn,outputn);

%% Ԥ��
yuce=sim(net,x');

%Ԥ���������һ��
ybp=mapminmax('reverse',yuce,outputps);

perf=perform(net,ybp,output_test')

ape=abs((output_test'-ybp)./output_test');
l=length(ape);
mape=0;
for z=1:l
    mape=mape+ape(z);
end
mape=mape/92


%% �������
figure(1)
plot(ybp)
hold on
plot(output_test','k*:')
line([0,100],[75,75],'color','r','linestyle','--');
title('����BP��ͨ������Ԥ��ͼ','fontsize',12)
legend('Ԥ������','ʵ������')
xlabel('ʱ���')
ylabel('����')
figure(2)
plot(ape)