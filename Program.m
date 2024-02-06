clc
clear
close all
%%
%Load Image
I1=imread('Image1.jpg');
I2=rgb2gray(I1);
I3=im2bw(I2,.78);
%%
%Find Pelak
[B,L] = bwboundaries(I3,'noholes');
n1=0;
for i1=1:length(B)
    if length(B{i1})>200
        n1=n1+1;
        B1{n1}=B{i1};
    end
end
for i1 = 1:length(B1)
    k1=B1{i1};
    A1=[min(k1(:,1)),max(k1(:,1));min(k1(:,2)),max(k1(:,2))];
    A2=[A1(1,2)-A1(1,1);A1(2,2)-A1(2,1)];
    if A2(2)/A2(1)>3 & A2(2)/A2(1)<4 
       P1=A1;
    end
end
D1=P1(2,2)-P1(2,1);
P2=[P1(1,1),P1(1,2);P1(2,2)+1,P1(2,2)+D1/3];
D1_x=P1(2,2)-P1(2,1);
D1_y=P1(1,2)-P1(1,1);
D2_x=P2(2,2)-P2(2,1);
D2_y=P2(1,2)-P2(1,1);
I4=I1(P1(1,1)+D1_y/15:P1(1,2)-D1_y/15,P1(2,1)+D1_x/60:P1(2,2)-D1_x/60,:);
I5=I1(P2(1,1)+D2_y/13:P2(1,2),P2(2,1)+D2_x/20:P2(2,2)-D2_x/10,:);
%%
%Show Image
%1
figure
subplot(3,1,1)
imshow(I1)
title('Main Image')
subplot(3,1,2)
imshow(I2)
title('Grayscale Image')
subplot(3,1,3)
imshow(I3)
title('Binery Image')
%2
figure
subplot(2,1,1)
imshow(I4)
title('Part 1 Pelak')
subplot(2,1,2)
imshow(I5)
title('Part 2 Pelak')
%%
%Find character
%Part1
figure
I4_1 = im2bw(I4,.6);
[B,L] = bwboundaries(I4_1);
imshow(I4_1)
hold on
for i1=1:length(B)
    k2(i1,:)=[length(B{i1}),i1];
end

for i1=1:7
    [m1,m2]=max(k2(:,1));
    if i1>1
        B2{i1-1}=B{m2};
    end
    k2(m2,1)=0;
end
for i1 = 1:length(B2)
    boundary = B2{i1};
    plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth', 2)
end
title('Part 1 pelak & Character')
%Part2
figure
I5_1 = im2bw(I5,.6);
[B,L] = bwboundaries(I5_1);
imshow(I5_1)
hold on
for i1=1:length(B)
    k2(i1,:)=[length(B{i1}),i1];
end
for i1=1:3
    [m1,m2]=max(k2(:,1));
    if i1>1
        B3{i1-1}=B{m2};
    end
    k2(m2,1)=0;
end
for i1 = 1:length(B3)
    boundary = B3{i1};
    plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth', 2)
end
title('Part 2 pelak & Character')
%%
%Detection character
%Part1
for i1=1:length(B2)
    k1=B2{i1};
    k2=I4_1(min(k1(:,1)):max(k1(:,1)),min(k1(:,2)):max(k1(:,2)));
    Ch1{i1}=imresize(k2,[50 50]);
end
%Part2
for i1=1:length(B3)
    k1=B3{i1};
    k2=I5_1(min(k1(:,1)):max(k1(:,1)),min(k1(:,2)):max(k1(:,2)));
    Ch2{i1}=imresize(k2,[50 50]);
end
%part1
for i1=1:length(B2)
    k1=B2{i1};
    m1(i1)=min(k1(:,2));
end
for i1=1:length(m1)
    [m2 m3]=min(m1);
    f1(i1)=m3;
    m1(m3)=1000000;
end
for i1=1:length(Ch1)
    Ch{i1}=Ch1{f1(i1)};
end
%part2
clear m1 f1
for i1=1:length(B3)
    k1=B3{i1};
    m1(i1)=min(k1(:,2));
end
for i1=1:length(m1)
    [m2 m3]=min(m1);
    f1(i1)=m3;
    m1(m3)=1000000;
end
for i1=1:length(Ch2)
    Ch{i1+6}=Ch2{f1(i1)};
end
%Network
load Network
for i1=1:length(Ch)
    k1=Ch{i1};
    k2=sim(Network,k1');
    [m1 m2]=max(mean(k2'));
    f3(i1)=m2;
end
%
switch f3(3)
    case 10
        H='D';
    case 11
        H='A';
    case 12
        H='h';
    case 13
        H='E';
    case 14
        H='H';
    case 15
        H='K';
    case 16
        H='L';
    case 17
        H='M';
    case 18
        H='R';
    case 19
        H='T';
    case 20
        H='S';
    otherwise
        H='NN'
end    
clc
disp(['Pelak is=',num2str(f3(1:2)),'     ',H,'     ',num2str(f3(4:6)),'     Iran     ',num2str(f3(7:8))])







