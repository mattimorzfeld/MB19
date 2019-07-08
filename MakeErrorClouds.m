%%
clear
close all
clc
load HF_NoiseModel.mat
load CALS10kpsd.mat
colors

nos = 5000;
X10k = zeros(length(m),nos);
for kk=1:nos
    go = 1;
    while go == 1
        tmp = m+L*randn(length(m),1); 
        if sum(tmp>0)==length(m)
            X10k(:,kk) = tmp;
            go = 0;
        end
    end
end

figure(1)
% plot(fCALS10k(inds),X10k,'Color',Color(:,1))
set(gca,'YScale','log')
set(gca,'XScale','log')

MX10k = mean(X10k,2);
stdX10k = std(X10k')';
% hold on,plot(fCALS10k(inds),MX10k+2*stdX10k','k--')
% hold on,plot(fCALS10k(inds),max(MX10k-2*stdX10k',1e-9*ones(size(MX10k))),'k--')
myerrorCloud(MX10k,2*stdX10k,fCALS10k(inds),Color(:,2))

f_HF_ErrorCloud = fCALS10k(inds);
save('HFErrorCloud.mat','MX10k','stdX10k','f_HF_ErrorCloud')


%%
clear
colors
load HF_NoiseModel.mat
load CALS10kpsd.mat
figure(1)
% hold on,plot(fCALS10k,psdCALS10k,'--','Color',Color(:,3),'LineWidth',1)
% hold on,plot(fCALS10k(inds),psdCALS10k(inds),'Color',Color(:,3),'LineWidth',2)

clear
load LF_NoiseModel.mat
colors
nos = 5000;
X2M = zeros(length(m),nos);
for kk=1:nos
    go = 1;
    while go == 1
        tmp = m+L*randn(length(m),1); 
        if sum(tmp>0)==length(m)
            X2M(:,kk) = tmp;
            go = 0;
        end
    end
end

figure(1)
% plot(f,X2M,'Color',Color(:,1))

f(1) = 1e-8;
f_LF_ErrorCloud = f;
MX2M = mean(X2M,2);
stdX2M = std(X2M')';
% hold on,plot(fCALS10k(inds),MX10k+2*stdX10k','k--')
% hold on,plot(fCALS10k(inds),max(MX10k-2*stdX10k',1e-9*ones(size(MX10k))),'k--')
myerrorCloud(MX2M,2*stdX2M,f,Color(:,2))

save('LFErrorCloud.mat','MX2M','stdX2M','f_LF_ErrorCloud')


