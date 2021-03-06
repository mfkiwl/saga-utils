function fig_handle = pltnmpos(auto_mode)

% Example function to plot position data obtained from NMEA data.
% The data are loaded from the file demonmea.mat
% which is generated by the example function ex_nmea with a subset of the
% data saved for the demo.
% Input:
%   auto_mode = optional flag (only include when in auto mode)

% Written by: Jimmy LaMance 9/6/97
% Copyright (c) 1998 by Constell, Inc.

% load in the data
load demonmea;

if nargin < 1,
  % Get the screen size in pixels to use for location of plots
  set(0,'units','pixels');
  screen_size = get(0,'screensize');
  y_max = screen_size(2) + screen_size(4) - 60;
  x_max = screen_size(1) + screen_size(3) - 50;
  x_step = 110;
  y_step = 60 + y_max;

  % set the figure colors to be black background like Matlab 4
  colordef none;                               

  % Determine the location for the plot in upper right corner
  x_min = x_max / 10;
  y_min = y_max / 10;

  % generate the position error figure
  fig_handle = figure('color','black', ...
   'position',[x_min y_min x_max/1.25 y_max/1.25],  ...
   'NumberTitle','off', ...
   'Name','NMEA Data: Positions', ...
   'Tag','fign');
end;

% compute the standard deviations of the d_ned data
sigma = std(d_ned);

% build strings for the statistics legend
n_string = sprintf('North \\sigma = %4.2f (m)',sigma(1));
e_string = sprintf('East \\sigma = %4.2f (m)',sigma(2));
d_string = sprintf('Down \\sigma = %4.2f (m)',sigma(3));


fig_title_cell={'Position Data Analysis';};
x = hours_pos;
y = d_ned;
axis_label_cell = {'Hours Past Start (UTC)'; 'NED Position Variation (m)'; ...
  'North, East, Down Position Variations Using NMEA Data';};

legend_cell = {n_string,e_string,d_string};

descriptive_text_cell = ...
 {'The NMEA data from a GPS receiver provides the user with a wealth of ';
  'information about the navigation solution and the current tracking status.  An';
  'example of this information is the position information provided in the $GPGGA';
  'message.  Position data from this message can be analyzed and plotted using';
  'the Constellation Toolbox functions for coordinate conversions and other built-in Matlab';
  'functions. This data was collected using ProComm and a Garmin 12XL receiver on July 4, 1997.'};

if nargin < 1,
  text_win(fig_title_cell,x,y,axis_label_cell,legend_cell, ...
      descriptive_text_cell,1);
else,
  fig_handle = gcf;
  text_win(fig_title_cell,x,y,axis_label_cell,legend_cell, ...
      descriptive_text_cell);
end;

% set the axis to show the number of satellites (add +/-1 to the y-axis)
vs = axis;
axis([vs(1) vs(2) vs(3)-1 vs(4)+1]);

% end of PLTDOPER
