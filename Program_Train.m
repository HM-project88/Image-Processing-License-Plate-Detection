clc
clear
close all
load Input
for i1=1:20
    Output((i1-1)*50+1:i1*50,i1)=1;
end
Output(1001:1050,2)=1;
Output(1051:1100,7)=1;
Output(1101:1150,1)=1;
Output(1151:1200,2)=1;
Output(1201:1250,3)=1;
Output(1251:1300,3)=1;
Output(1301:1350,6)=1;
Output(1351:1400,2)=1;
Output(1401:1450,7)=1;
Output(1451:1500,3)=1;
Output(1501:1550,2)=1;
Output(1551:1600,20)=1;
Output(1601:1650,1)=1;

net=newff(Input',Output',10);
Network=train(net,Input',Output');



