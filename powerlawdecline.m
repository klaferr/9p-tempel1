%the purpose of this script is to read in the txt file from each spitzer
%data, and plot a power law decline on top, starting from the peak value.

%first step, read in the txt file
content = fileread( '8_09_2016.txt');
data = textscan(content, '%f %f');
x = data{1};
y = data{2};
figure()
plot(x,y,'.')
%taking the xvalue from where y is at its max, we can find where to palce
%the origin for the power law decline plot.
[maxYvalue,indexatmaxy] = max(y);
xvalue = x(indexatmaxy(1));
finalx = size(x);
finalx = finalx(1);
%ymax = max(y);
x = x(xvalue:finalx); 
x = x-7;
y = y(xvalue:finalx); %selects the values that are in relation to x of 7-30
figure()
plot(x,y,'.')
hold on
%deteermine the power law decline equation
miny = min(y);
scale = max(y)-miny;
decline = (scale*exp(-x))+miny;
plot(decline)
