% Determine the size of nebula in pixels.
% 
% Dependencies: skyAP, adapted from Caleb's nebsize
% 

%to determine size and brightness of 9P in each observation run
    % this observation, labelled post1.54, is from August 9th, 2016 at 1.54 AU for heliocentric, past perihelion,
    % quality good, integration time 60s.

irac36_long = rfits('9p-post1.54-irac3.6-long.fits')
%irac36_short = rfits('9p-post1.54-irac3.6-short-copy.fits')
%irac36_hdr = rfits('if there is an hdr file.fits')

%using transpose: need to rotate images, matlab for a strange reason puts rfits files in 9
%deg clockwise, for rnow, the naming convention is going to be long and
%short once rotated for simplicity, and because there is only on
%Heliocentric data and filter in so far
a = rot90(irac36_long.data);
%b = rot90(irac36_short.data);

%%plotting them
figure()
scale = [-0.06,0.055]
imagesc(a,scale),colorbar(); %rotates 90 degrees clockwise
title('post 1.54, irac4.5, long')
%figure()
%imagesc(b, [-4,5.6]),colorbar();
%title('post 1.54, irac3.6, short')

%next, lets use aperE to create aperatures: can make ellipses and circles,
%not fan shapes. may need to edit or create new for that shape
%this was not working well, attempting a new solution. problem described in
%feb notes
%figure()
%[flux,err] = aperE(a,545,380, 10, 7, 100,100,115,115,0.5) %not sure what to do about kccd value,
%figure()
%[flux,err] = newaperE(a,545,380, 10, 7, 275, 500,10,20,0.5)

%New attempt

promptMessage = sprintf('Click the center');
[xcent,ycent] = ginput(1);

x_sky = 275;    % pixel coords of center of sky aperture
y_sky = 450;

[sky,ssig] = skyAP(a,y_sky,x_sky,10,scale)
[flx,err] = targetAP(a,ycent,xcent,8,10,sky,scale) %sky is median sky value in ADU, not sure how to find
%colorbar must be decided inside skyAP and targetAP, err is the total error
%now, lets try for the short time exposure
%[skyb,ssigb] = skyAP(b,455,270,5,[-4,5.6])
%[flx,err] = targetAP(b,546,387,5,5,sky,[-4,5.6])

%%% working with a right now


xvalues = a(1:end, ycent);      % x pixels
%xstars = find(xvalues > 0.1);   % clip pixels exceeding this value (stars)
%for i = xstars
%    xvalues(i) = nan;
%end
%image is very differnt that that of m31, stars not as problematic, instead
%need to compare to overall sky background 
x = (1:length(xvalues));
xsky = sky * ones(length(xvalues)) + 2*ssig; %gives us a array for plotting with 

yvalues = a(xcent,1:end); %helpful: 1:800
%ystars = find(yvalues > 0.1);
%for i = ystars
 %   yvalues(i) = nan;
%end
y = (1:length(yvalues));
ysky = sky * ones(length(yvalues)) + 2*ssig;


% figure();
% hold on
% line(yvalues,y,'Color','r')
% ax1 = gca;
% set(ax1,'XColor','r','YColor','r')
% ax2 = axes('Position',get(ax1,'Position'),...
%     'XAxisLocation','top',...
%     'YAxisLocation','right',...
%     'Color','none',...
%     'XColor','k','YColor','k');
% line(x,xvalues,'Color','k','Parent',ax2)

figure();
set(gcf, 'Position', [50, 50, 600, 400]) %puts image in lower left corner

pos1 = [.12 .12 .6 .6]; %puts subplots on same image but above
subplot('Position',pos1);
imagesc(a,scale)%scale)%[sky-10*ssig,sky+10*ssig]),colorbar();
xlabel('x (pix)')
ylabel('y (pix)')
%set(gca,'YDir','normal')
set(gca,'dataAspectRatio',[1 1 1])
%xlim([ycent-100,ycent+100]) %axis are confusing rn, x in the color bar images are the up and down axis, while in the graph one, x is the right to left
%ylim([0,xcent+100])
%colormap(gray)

%since all of the axis are flipped
pos2 = [0.12 0.73 0.6 0.21];
subplot('Position',pos2)
hold on
%plot(x,xvalues,'r-')
plot(y,yvalues,'r-')
plot(y,ysky,'b--')
%plot(x,xsky,'b--')
set(gca,'Color',[.95; .95; .95])
hold off
set(gca,'xtick',[1 2 3 4 5], 'xticklabel',{})
xlim([1,length(yvalues)]) %previously, [1,length(xvalues)]
ylim([-0.5,1.0])
ylabel('Counts (ADU)')

%since the axis are flipped.. 
pos3 = [0.73 0.12 0.21 0.6];
subplot('Position',pos3)
hold on
%plot(yvalues,y,'r-')
%plot(ysky,y,'b--')
plot(xvalues,x,'r-')
plot(xsky,x,'b--')
set(gca,'Color',[.95; .95; .95])
set(gca, 'Ydir','reverse')
hold off
set(gca,'ytick',[1 2 3 4 5], 'yticklabel',{})
xlim([-0.5,1.0])
ylim([1,length(xvalues)])
xlabel('Counts (ADU)')