function [sky,ssig]=skyAP(im,col,row,rad,value)

%{
Based on aperE.m function, originally created by Professor Andrew Harris.
im -- fits image data,
col -- column of center pixel,
row -- row of center pixel,
rad -- aperture radius (pix)
value - used in plotting, min to max for colorbar
%}

[a,b]=size(im);
[xx,yy]=meshgrid(1:b,1:a);

ixsky=(((xx-col)./rad).^2)+(((yy-row)./rad).^2)<=1;

sky=median(im(ixsky));                        % sky value
ssig=std(im(ixsky))/sqrt(length(ixsky));      % sky noise in average

figure()
imagesc(im,[value]),colorbar();
axis image
p=(0:360)*pi/180;
xc=(cos(p));
yc=sin(p);
hold on
plot(col+rad*xc,row+rad*yc,'r');
plot(col+rad*xc,row+rad*yc,'r');

% fw=rad;
% ix=find((xx>=(col-2*fw))&(xx<=(col+2*fw))&(yy>=(row-2*fw))&(yy<=(row+2*fw)));
% aa=length(find((xx(1,:)>=(col-2*fw))&(xx(1,:)<=(col+2*fw))));
% bb=length(find((yy(:,1)>=(row-2*fw))&(yy(:,1)<=(row+2*fw))));
% px=reshape(xx(ix),bb,aa);
% py=reshape(yy(ix),bb,aa);
% pz=reshape(im(ix),bb,aa);
% clf;
% imagesc(px(1,:),py(:,1),pz,[2000,3000]);
% 
% axis image
% p=(0:360)*pi/180;
% xc=(cos(p));
% yc=sin(p);
% hold on
% plot(col+rad*xc,row+rad*yc,'w','LineWidth',2);
% set(gca,'Ydir','Normal');
% xlabel('x (pix)');
% ylabel('y (pix)');
% colormap gray;
% cb = colorbar;
% ylabel(cb, 'Counts (ADU)');