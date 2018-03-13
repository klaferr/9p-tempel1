function [flx,err]=newaperE(im,col,row,rad1,rad2,srow,scol,innerrad,outerrad,Kccd)

%{
Original code by Professor Andrew Harris. Edited by Alyssa Pagan. then by
Kris Laferriere

Changes from original aperE: Inner and outer sky ellipses are no longer
centered around object aperature. 

APER(im,col,row,rad1,rad2,innerrow,innercol,innerrad, outerrad,Kccd) Do aperture photometry of image "im"
for a star, galaxy or nebula centered at the "row,col" coordinates, For an circle 
with center "innerrow, innercolumn", and radius "innerrad" and an outer sky circle with a 
radius of "outerrad" with CCD
gain of Kccd ADU/electron. 

%} 

if (nargin==10), saturation=Inf; end

[a,b]=size(im);
[xx,yy]=meshgrid(1:b,1:a);

ixsrc=(((xx-col)./rad1).^2)+(((yy-row)./rad2).^2)<=1;
ixsky=(((xx-scol)./outerrad).^2)+(((yy-srow)./outerrad).^2)<=1 &(((xx-scol)./innerrad).^2)+(((yy-srow)./innerrad).^2)>=1;

sky=median(im(ixsky));                        % sky value
pix=im(ixsrc)-sky;                            % source without sky
sig=sqrt(im(ixsrc)/Kccd);                     % photon noise per pixel
ssig=std(im(ixsky))/sqrt(length(ixsky))/Kccd; % sky noise in average
flx=sum(pix)/Kccd;                            % flux
err=sqrt(sum(sig).^2+ssig^2);                 % total error
issat=0;
if (max(im(ixsrc))>saturation), issat=1; end

fw=scol;
ix=find((xx>=(col-2*fw))&(xx<=(col+2*fw))&(yy>=(row-2*fw))&(yy<=(row+2*fw)));
aa=length(find((xx(1,:)>=(col-2*fw))&(xx(1,:)<=(col+2*fw))));
bb=length(find((yy(:,1)>=(row-2*fw))&(yy(:,1)<=(row+2*fw))));

px=reshape(xx(ix),bb,aa);
py=reshape(yy(ix),bb,aa);
pz=reshape(im(ix),bb,aa);
clf;
imagesc(px(1,:),py(:,1),pz);
if (~isempty(im(ixsrc))),
  caxis([sky max(im(ixsrc))]); 
end

axis image
p=(0:360)*pi/180;
xc=(cos(p));
yc=sin(p);
hold on
plot(col+rad1*xc,row+rad2*yc,'w');
plot(scol+innerrad*xc,srow+innerrad*yc,'r');
plot(scol+outerrad*xc,srow+outerrad*yc,'r');
hold off


