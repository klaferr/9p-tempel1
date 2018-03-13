%to determine size and brightness of 9P in each observation run
    % this observation, 
    %dependent on rfits,targetAP, skyAP

long = rfits('9p-post1.54-irac4.5-long.fits');
%irac36_hdr = rfits('if there is an hdr file.fits')

%using transpose: need to rotate images, matlab for a strange reason puts rfits files in 9
%deg clockwise, for rnow, the naming convention is going to be long and
%short once rotated for simplicity, and because there is only on
%Heliocentric data and filter in so far
image = rot90(long.data);
scale = [-.15,0.2]; %SCALE MUST BE CHANGED

%plotting them
figure()
imagesc(image,scale), colorbar();
title('post 1.54, irac 4.5, long')
%picking the center
promptMessage = sprintf('Click the center');
[xcent,ycent] = ginput(1);


%next, lets use aperE to create aperatures: can make ellipses and circles,
%not fan shapes. may need to edit or create new for that shape
%this was not working well, attempting a new solution. problem described in
%feb notes
%figure()
%[flux,err] = aperE(a,545,380, 10, 7, 100,100,115,115,0.5) %not sure what to do about kccd value,
%figure()
%[flux,err] = newaperE(a,545,380, 10, 7, 275, 500,10,20,0.5)

%New attempt
[sky,ssig] = skyAP(image,850,150,5,scale);

%need to create a loop: how to do that?
tend = 10;
flux = zeros(1,tend);
error = zeros(1,tend);
fluxperarea = zeros(1,tend);
xvalue = zeros(1,tend);
for_txt = zeros(1,tend);
for a = 1:1:100;
    for b = a+12;
        xvalue(a)=a;
        [flx,err] = targetAP(image,xcent,ycent,a,b,sky,ssig,scale);
        flux(a)=flx;
        fluxperarea(a)=flux(a)/(pi*a*b);
        error(a)=sqrt((err/(pi*a*b))^2);
    end
end
figure()
plot(xvalue,fluxperarea,'.');
errorbar(fluxperarea,error);
figure1 = figure();
plot(xvalue,fluxperarea,'.');

title('radial profile')
xlabel('distance from center in pixels')
xlim([0 inf]);
ylabel('flux value per area')
saveas(figure1,'8_09_2016_4.5.fig'); %NAME MUST BE CHANGED
%goal rn: write into a txt file the xvalues in relation to the fluxperarea
%values
for_txt2 = [xvalue(:), fluxperarea(:)];
dlmwrite('8_09_2016_4.5.txt',for_txt2,'delimiter',' ') %NAME MUST BE CHANGED

%type('8_09_2016.txt')

%sky is median sky value in ADU, not sure how to find
%colorbar must be decided inside skyAP and targetAP, err is the total error
%hold on
%power = (1/xvalue).^2;
%fplot(@(xvalue) (1/(xvalue^2)),xvalue,'--')
%hold off


figure()
imagesc(image,scale),colorbar();
axis image
p=(0:360)*pi/180;
xc=(cos(p));
yc=sin(p);
hold on
plot(xcent+a*xc,ycent+b*yc,'w');
