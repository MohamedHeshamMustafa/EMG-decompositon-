clear 
close all

t = 30000:35000;
x = load('Data.txt');
noise = abs(x(500:800));
N = 20;
x = x(t);
rectified_data = abs(x);
moving_avg = hsmooth(rectified_data, N);
id = int32(peak(moving_avg, 3*std(noise), N) - (N-1)/2);

moving_avg = hsmooth(rectified_data, 4);
T = 20;
DiffTher = 12.65e+05;
templates_matrix = hdetection(moving_avg,id,T,DiffTher);

figure
hold on
plot(t, x);
title('Detected MUAP')
for i = 1:size(templates_matrix)
    template = templates_matrix(i,:);
    template = template(template~=0);
    template = template';
    plot(id(template)+ t(1) - 1, repmat(1000, 1, length(template)), 'ro','color',rand(1,3));
end
hold off
%print('DetectedMUAP.jpg','-djpeg')

t = 1:78125;
x = load('Data.txt');
x = x(t);
rectified_data = abs(x);
moving_avg = hsmooth(rectified_data, N);
id = int32(peak(moving_avg, 3*std(noise), N) - (N-1)/2);
moving_avg = hsmooth(rectified_data, 4);
T = 20;
DiffTher = 12.65e+05;
templates_matrix = hdetection(moving_avg,id,T,DiffTher);

t = 1:T+1;
for i = 1:size(templates_matrix)
    template_mean = [];
    
    for e=-T/2:T/2
    template = templates_matrix(i,:);
    template = template(template~=0);
    template = moving_avg(id(template)+e);
    template_mean = [template_mean mean(template)];
    end
    figure
    plot(t,template_mean)
    title(['MUAP', int2str(i), '   -   Number of MUAPs = ', int2str(size(template))]);
end

