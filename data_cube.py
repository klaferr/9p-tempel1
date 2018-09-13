
# coding: utf-8

# In[ ]:


#the goal of this code is to open a multidimensional data cude fits file for research with Dr. Lori Feaga
#does not seem possible in matlab, so changing languages


# In[75]:


#first, import astropy and matplotlib
import matplotlib.pyplot as plt
from astropy.io import fits
import numpy as np

#assign each image data to a different array

with fits.open('9p-pre1.58-irac3.6-long.fits') as hdul:
    hdul.info()
    header = hdul[0].header
    #xcent = hdul[0].xc
    #ycent = hdul[0].yc
    primary = hdul[0].data
    unc  = hdul[1].data
    cov = hdul['COV'].data
    bggrad = hdul['BGGRAD'].data
hdr = hdul[0].header;
xcent = hdr['XC']
ycent = hdr['YC']


# In[65]:


#plot array
ymax = len(primary);
ymin = 0;
plt.imshow(primary,vmin=-0.02,vmax=0.2); #-0.055,0.0450
plt.colorbar()
plt.ylim(ymax,ymin)
plt.gca().invert_yaxis()
plt.show()


# In[61]:


plt.imshow(unc,vmin=0.0,vmax=0.4); #-0.055,0.0450
plt.colorbar()
plt.ylim(ymax,ymin)
plt.gca().invert_yaxis()
plt.show()


# In[60]:


plt.imshow(cov,vmin=0,vmax=14); #-0.055,0.0450
plt.colorbar()
plt.ylim(ymax,ymin)
plt.gca().invert_yaxis()
plt.show()

plt.imshow(bggrad,vmin=-0.02,vmax=0.02); #-0.055,0.0450
plt.colorbar()
plt.ylim(ymax,ymin)
plt.gca().invert_yaxis()
plt.show()


# In[76]:


#matlab code


sky = cov;
#ssig =  hdr.bgsig;

'''
tend = 11;
flux = zeros(1,tend);
error = zeros(1,tend);
fluxperarea = zeros(1,tend);
xvalue = zeros(1,tend);
for_txt = zeros(1,tend);
for a = 1:5:50;
    for b = a;
        xvalue(a)=a;
        [flx,err] = targetAP(image,xcent,ycent,a,b,sky,ssig,scale);
        flux(a)=flx;
        fluxperarea(a)=flux(a)/(pi*a*b);
        error(a)=sqrt((err/(pi*a*b))^2);
    end
end

%figure()
%plot(xvalue,fluxperarea,'.');
%set(gca,'Ydir','normal');
%errorbar(fluxperarea,error);
figure1 = figure();
plot(xvalue,fluxperarea,'.');

title('radial profile')
xlabel('distance from center in pixels')
xlim([1 inf]);
ylabel('flux value per area')
set(gca,'Ydir','normal');

%saveas(figure1,'01162017_4.5_not_calib.fig'); %NAME MUST BE CHANGED
for_txt2 = [xvalue(:), fluxperarea(:)];
%dlmwrite('01162017_4.5_not_calib.txt',for_txt2,'delimiter',' ') %NAME MUST BE CHANGED



figure()
imagesc(image,scale),colorbar();
set(gca,'Ydir','normal');
axis image
p=(0:360)*pi/180;
xc=(cos(p));
yc=sin(p);
hold on
plot(xcent+a*xc,ycent+b*yc,'w');

%%%
%{
kmperpix = 2920;
xvalue_km = xvalue*kmperpix;
fluxperarea_km = fluxperarea * (1/(kmperpix)^2);
figure()
imagesc(xvalue_km,fluxperarea_km,'.');
xlabel('distance from center of comet (km)');
ylabel('flux per area (1/km^2)');
saveas(figure1,'km_01162017_4.5_not_calib.fig'); %NAME MUST BE CHANGED
%goal rn: write into a txt file the xvalues in relation to the fluxperarea
%values
for_txt2 = [xvalue_km(:), fluxperarea_km(:)];
dlmwrite('km_01162017_4.5_not_calib.txt',for_txt2,'delimiter',' ') 
%}
'''


# In[66]:




