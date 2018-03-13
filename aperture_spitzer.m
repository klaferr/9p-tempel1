%to determine size and brightness of 9P in each observation run
    % this observation, labelled post1.54, is from August 9th, 2016 at 1.54 AU for heliocentric, past perihelion,
    % quality good, integration time 60s.

irac36_long = rfits('9p-post2.06-irac3.6-long.fits')
%%irac36_short = rfits('9p-post1.54-irac3.6-short.fits')
%irac36_hdr = rfits('if there is an hdr file.fits')

%using transpose: need to rotate images, matlab for a strange reason puts rfits files in 9
%deg clockwise, for rnow, the naming convention is going to be long and
%short once rotated for simplicity, and because there is only on
%Heliocentric data and filter in so far
a = rot90(irac36_long.data);
%%b = rot90(irac36_short.data);

%plotting them
figure()
scale = [-0.06,0.055]
imagesc(a,scale),colorbar(); %rotates 90 degrees clockwise
title('post 2.06, irac3.6, long')
%%figure()
%%imagesc(b, [-4,5.6]),colorbar();
%%title('post 1.54, irac3.6, short')

%next, lets use aperE to create aperatures: can make ellipses and circles,
%not fan shapes. may need to edit or create new for that shape
%this was not working well, attempting a new solution. problem described in
%feb notes
%figure()
%[flux,err] = aperE(a,545,380, 10, 7, 100,100,115,115,0.5) %not sure what to do about kccd value,
%figure()
%[flux,err] = newaperE(a,545,380, 10, 7, 275, 500,10,20,0.5)

%New attempt
[sky,ssig] = skyAP(a,450,275,10,scale)
[flx,err] = targetAP(a,747,508,8,10,sky,scale) %sky is median sky value in ADU, not sure how to find
%colorbar must be decided inside skyAP and targetAP, err is the total error
%now, lets try for the short time exposure
%%[sky,ssig] = skyAP(b,455,270,5,[-4,5.6])
%%[flx,err] = targetAP(b,546,387,5,5,sky,[-4,5.6])
