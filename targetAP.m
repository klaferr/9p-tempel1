function [flx,err]=targetAP(im,col,row,rad1,rad2,sky,ssig, value)

%{
Based on aperE.m function, originally created by Professor Andrew Harris.
im -- fits image data,
col -- column of center pixel,
row -- row of center pixel,
rad -- aperture radius (pix),
sky -- median sky value (ADU)
ssig -- sigma of sky values 
%}

[a,b]=size(im);
[xx,yy]=meshgrid(1:b,1:a);

ixsrc=(((xx-col)./rad1).^2)+(((yy-row)./rad2).^2)<=1;

pix=im(ixsrc); %pix = image within boundraries % source with sky
sig=sqrt(abs(pix));                          % photon noise per pixel
flx=sum(pix - sky);                          % raw flux
prop=sqrt((sum(sig))^ + (ssig)^2);           % error propogation
err=sum(prop); %istead of sig,use prop       % total photon noise (Poisson)


%figure()
%imagesc(im,[value]),colorbar();
%axis image
%p=(0:360)*pi/180;
%xc=(cos(p));
%yc=sin(p);
%hold on
%plot(col+rad1*xc,row+rad2*yc,'w');


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
% plot(col+rad*xc,row+rad*yc,'r');