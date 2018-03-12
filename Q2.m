clear 
close all

t = 30000:35000;
x = load('Data.txt');
noise = abs(x(500:800));
N = 20;
K = 2;
ht = int32(-N/2:N/2);
x = x(t);
rectified_data = abs(x);
moving_avg = hsmooth(rectified_data, N);

id = int32(peak(moving_avg, 3*std(noise), N) - (N-1)/2);
I = bsxfun(@plus, id, ht);
[~, i] = max(x(I), [], 2);
id = id + ht(i)';
I = bsxfun(@plus, id, ht);
idx = hkMeans(x(id), K);

figure
hold on
plot(t, x)
colors = {'ro', 'go'};
for k=1:K
plot(id(idx == k)+t(1)-1, x(id(idx == k)), colors{k})
end
hold off

titles = {'MUAP1', 'MUAP2'};
for k=1:K
  figure
  plot(mean(x(I(idx == k, :))))
  title(titles{k})
end
