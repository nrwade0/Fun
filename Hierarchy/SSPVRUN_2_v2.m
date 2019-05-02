% Missile Airframe Validation Hierarchy 2.3
% Code originally created by Dr. Jeremy Pinier, June 2017
%
% Version 2: Repurposed April 2-3, 2019 for Validation Hierarchy
%            - Changed some connections and controlled flow to the right.
%              Originally, it flowed into column 4 with only 5 columns.
%            - Updated code to generalize connections.
%
% Version 2.1: Small changes to textboxes and column headers, April 8, 2019
%              - Automated the editing of textboxes and headers; this works
%                  as long as there is enough checkboxes & textboxes in 
%                  .fig file (using GUIDE). This is automatically found in
%                  the Build Column section of SSPVRUN_2_v2.
%              - Looking for easiest way to show the textboxes without
%                  clutter or a lot of keystrokes.
%
% Version 2.2: Updated wiring and added clear all button, April 20, 2019
%              - Updated faulty wiring in third column. Changed the way the
%                program reads connections, should be easier.
%              - Clean uped .fig file for GUI - making it easier to read.
%              - CLEAR ALL button needs to also clear the checkboxes.
%                 Looking for a different way that doesn't use eval on
%                 each box. (This buttons was later repurposed into a NEW
%                 WINDOW button - 04/22/2019)
%
% Version 2.3: Implemented right to left connections, April 25, 2019
%              - Condensed all checkbox callbacks into a single function.
%                 Now, it should be easier to change all at once.
%              - Condensed the column header checkbox, as well.
%              - Fixed small quiver positioning error in cols 4, 5
%              - Right to left connections can be displayed by toggling a
%                 checkbox in the bottom corner. This is done by just
%                 transposing the connection matrices and using quiver in
%                 the opposite direction.
%              - Thorough documentation of each callback. A major effort!
%                 Added 'instructions for use' for next user.
%
% FUTURE:
%   Limit the number of evals and for loops in both program and gui files.
%   Change variable names to something easier.
%
% INSTRUCTIONS FOR USE:
%   - To change labels: change cell arrays in COLUMN DATA section in
%     SSPVRUN_2_v2.m, the number of checkboxes in each column catches it
%     automatically.
%   - To change textbox/checkbox information: change data in each
%     column for loop in BUILD COLUMNS section. For more general changes
%     (ie to all columns), change in COLUMN SPACING DATA section.
%   - To change connections: Go to CONNECTIONS section and read how
%     the connections are set up. It should be straightforward from
%     there.
%   - To add new checkboxes: open .fig file in GUIDE ("guide" in command
%     window) and copy-paste a checkbox and textbox pair. Open their
%     properties and change the String and Tag values to textbox# and
%     checkbox# (# is the next no. in the list). This lets the .m file
%     recognize and change them as it needs.
%   - To add new columns: same as adding new checkboxes. The col-to-col 
%     connections would have to be built and the for-loops in the checkbox
%     callback would need to be manually added as well.
%
%% ---------------------------- PROGRAM PREAMBLE ---------------------------%

tic;
disp(datestr(now));
clear

%% ------------------------------ COLUMN DATA ------------------------------%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Currently applicable to:     AVT-297_flow physics tiers_v6.pptx
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Cell arrays of text values from left -> right or top -> bottom

% Header information
% Ncols: # of columns
col_headers={'Airframe Functional Subsystems';
             'Flow Regimes';
             'Primary Flow Features';
             'Primary Flow Feature Interactions';
             'Canonical Cases';
             'Unit Cases'};
Ncols = length(col_headers);

% Column 1 information
% nmd: # of checkboxes in column 1
col1_labels={'Radar Signature';
             'Structures';
             'Aerodynamic Loading & Heating'};
nmd = length(col1_labels);

% Column 2 information
% nst: # of checkboxes in column 2
col2_labels={'Attached Laminar Flow';
             'Attached Transitional Flow';
             'Attached Turbulent Flow';
             'Separated Laminar Flow';
             'Separated Transitional Flow';
             'Separated Turbulent Flow'};
nst = length(col2_labels);

% Column 3 information
% no: # of checkboxes in column 3
col3_labels={'Boundary Layers';
             'Shocks';
             'Vortices';
             'Wakes';
             'Jets'};
no = length(col3_labels);

% Column 4 information
% ntc: # of checkboxes in column 4
col4_labels={'BL-BL';
             'Shock-BL';
             'Vortex-BL';
             'Wake-BL';
             'Jet-BL';
             'Shock-Shock';
             'Shock-Vortex';
             'Shock-Wake';
             'Shock-Jet';
             'Vortex-Vortex';
             'Vortex-Wake';
             'Vortex-Jet';
             'Wake-Wake';
             'Wake-Jet';
             'Jet-Jet'};
ntc = length(col4_labels);

% Column 5 information
% np: # of checkboxes in column 5
col5_labels={'2D Normal Shock';
             '2D Oblique Shock';
             '2D Ramp';
             '3D Forward Facing Step';
             '3D Sharp Unswept Fin';
             '3D Sharp Swept Fin';
             '3D Semi Cone';
             '3D Blunt Fin';
             'Vortex Encountered Normal Shock';
             'Vortex Encountered Oblique Shock';
             'Vortex Induced Shock Domain 1';
             'Vortex Induced Shock Domain 2';
             'Vortex Induced Shock Etc.';
             'Unmerged Co-rotating Vortices';
             'Unmerged Counter-rotating Vortices';
             'Conv. Merging Co-rotating Vortices';
             'Conv. Merging Counter-rotating Vortices';
             'Visc. Merging Co-rotating Vortices';
             'Visc. Merging Counter-rotating Vortices'};
np = length(col5_labels);

% Column 6 information
% npro: # of checkboxes in column 6
col6_labels={'No Boundary Layer';
             'Boundary Layer (Zero Pressure Gradient)';
             'BL (Favorable Pressure Gradient)';
             'BL (Adverse Pressure Gradient)';
             'Steady Symmetric (Mod a)';
             'Steady Asymmetric (High a)';
             'Unsteady Asymmetric (Higher a)';
             'Steady Symmetric (Low a)';
             'Steady Symmetric (Mod a)';
             'Steady Symmetric (High a)'};
npro = length(col6_labels);

% Display total number of checkboxes
disp(nmd + nst + no + ntc + np + npro);

%% ------------------------------ CONNECTIONS ------------------------------%
% Connections between columns: 
% md2st = --------- 
%        | 1  1  0 | checkbox 1 in col 1 -> checkbox 1 and 2 in col 2
%        | 0  0  0 | checkbox 2 in col 1 -> none              
%        | 1  1  1 | checkbox 3 in col 1 -> checkbox 1, 2, 3 in col 2
%        | 0  0  1 | checkbox 4 in col 1 -> checkbox 3 in col 2
%         ---------
% "md2st(3, [1,2,3]) = 1;" is read as, "checkbox 3 in column 1 is 
%     connected to checkbox 1, 2, and 3 in column 2."

% Column 1 -> 2 connections
md2st = zeros(nmd,nst);
md2st(3, 1:6) = 1;

% Column 2 -> 3 connections
st2o = zeros(nst,no);
st2o(1, [1,2]) = 1;
st2o(2, [1,2]) = 1;
st2o(3, [1,2]) = 1;
st2o(4, 1:5) = 1;
st2o(5, 1:5) = 1;
st2o(6, 1:5) = 1;

% Column 3 -> 4 connections
o2tc = zeros(no,ntc);
o2tc(1, 1:5) = 1;
o2tc(2, [2,6:9]) = 1;
o2tc(3, [3,7,10:12]) = 1;
o2tc(4, [4,8,11,13,14]) = 1;
o2tc(5, [5,9,12,14,15]) = 1;

% Column 4 -> 5 connections
pro2p = zeros(ntc,np);
pro2p(2, 1:8) = 1;
pro2p(7, 9:13) = 1;
pro2p(10, 14:19) = 1;

% Column 5 -> 6 connections
p2tc = zeros(np,npro);
p2tc(2, 1:4) = 1;
p2tc(14, 8) = 1;
p2tc(15, 5) = 1;
p2tc(16, 9) = 1;
p2tc(17, 6:7) = 1;
p2tc(18, 10) = 1;


%% ------------------------ COLUMN SPACING DATA ----------------------------%
% xs divides column spacing horizontally
% ys divides column spacing vertically
% xm adds spacing between arrows for checkboxes
xs = 0.96-0.022;
ys = 0.85-0.03;
xm = 0.01;

% Open gui and transfer this data
f = openfig('SSPV_2_v2.fig');
vars = {md2st,st2o,o2tc,pro2p,p2tc,nmd,nst,no,ntc,np,npro,ys,xm,Ncols};
data = guihandles(f); % initialize it to contain handles

% Build columns headers (columnheader_x) and set spacing between columns (col_x)
% How to find x-spacing for columns:
columnheader_x = linspace(5, 195, Ncols);
col_x = linspace(0.08, 0.92, Ncols);
textbox_w = 0.10;
textbox_h = 0.07;


%% ---------------------------- BUILD COLUMNS -------------------------------%

% Build column headers
for i = 1:Ncols
    % Fix column header strings
    eval(['set(data.colheader' num2str(i) ',''Position'',[' num2str(columnheader_x(i)) ', 53, 25, 5])']);
    eval(['set(data.colheader' num2str(i) ',''String'', ''' col_headers{i} ''')']);
    
    % column header checkboxes positions
    eval(['set(data.text' num2str(i) ',''Units'', '' normalized '')']);
    eval(['set(data.checkboxcol' num2str(i) ',''Position'',[' num2str(col_x(i)) ', 0.87, 0.015, 0.020])']);
end


% Build column 1
for i = 1:nmd
    % positioning
    y_temp = num2str(0.03+(0.85-0.03)/(nmd+1)*(nmd+1-i)); % y-value for current checkbox
    eval(['set(data.checkbox' num2str(i) ',''Position'',[' num2str(col_x(1)) ', ' y_temp ', 0.015, 0.020])']);
    
    % strings
    eval(['set(data.checkbox' num2str(i) ',''String'', ''' col1_labels{i} ''')']);
    eval(['data.checkbox' num2str(i) '.TooltipString = ''' col1_labels{i} ''';']);
    
    % textbox
    boxw = num2str(textbox_w - 0.03); % Edit textbox dimensions
    boxh = num2str(textbox_h - 0.00);
    eval(['set(data.text' num2str(i) ',''Units'', '' normalized '')']);
    eval(['set(data.text' num2str(i) ',''Position'',[' num2str(col_x(1) + 0.02) ', ' 0.1 + y_temp ', ' boxw ', ' boxh '])']);
    eval(['set(data.text' num2str(i) ',''String'', ''' col1_labels{i} ''')']);
end


% Build column 2
for i = 1:nst
    % Current checkbox j
    j = nmd+i;
    
    % positioning
    y_temp = num2str(0.03+(0.85-0.03)/(nst+1)*(nst+1-i));
    eval(['set(data.checkbox' num2str(j) ',''Position'',[' num2str(col_x(2)) ', ' y_temp ', 0.015, 0.020])']);
    
    % strings
    eval(['set(data.checkbox' num2str(j) ',''String'', ''' col2_labels{i} ''')']);
    eval(['data.checkbox' num2str(j) '.TooltipString = ''' col2_labels{i} ''';']);
    
    % textbox
    boxw = num2str(textbox_w - 0.02);
    boxh = num2str(textbox_h - 0.01);
    eval(['set(data.text' num2str(j) ',''Units'', '' normalized '')']);
    eval(['set(data.text' num2str(j) ',''Position'',[' num2str(col_x(2) + 0.02) ', ' 0.1 + y_temp ', ' boxw ', ' boxh '])']);
    eval(['set(data.text' num2str(j) ',''String'', ''' col2_labels{i} ''')']);
end


% Build column 3
for i = 1:no
    % Current checkbox j
    j = nmd+nst+i;
    
    % positioning
    y_temp = num2str( 0.03+(0.85-0.03)/(no+1)*(no+1-i));
    eval(['set(data.checkbox' num2str(j) ',''Position'',[' num2str(col_x(3)) ', ' y_temp ', 0.015, 0.020])']);

    % strings
    eval(['set(data.checkbox' num2str(j) ',''String'', ''' col3_labels{i} ''')']);
    eval(['data.checkbox' num2str(j) '.TooltipString = ''' col3_labels{i} ''';']);
    
    % textbox
    boxw = num2str(textbox_w - 0.03);
    boxh = num2str(textbox_h - 0.03);
    eval(['set(data.text' num2str(j) ',''Units'', '' normalized '')']);
    eval(['set(data.text' num2str(j) ',''Position'',[' num2str(col_x(3) + 0.02) ', ' 0.1 + y_temp ', ' boxw ', ' boxh '])']);
    eval(['set(data.text' num2str(j) ',''String'', ''' col3_labels{i} ''')']);
end


% Build column 4
for i = 1:ntc
    % Current checkbox j
    j = nmd+nst+no+i;
    
    % positioning
    y_temp = num2str(0.03+(0.85-0.03)/(ntc+1)*(ntc+1-i));
    eval(['set(data.checkbox' num2str(j) ',''Position'',[' num2str(col_x(4)) ', ' y_temp ', 0.015, 0.020])']);
    
    % strings
    eval(['set(data.checkbox' num2str(j) ',''String'', ''' col4_labels{i} ''')']);
    eval(['data.checkbox' num2str(j) '.TooltipString = ''' col4_labels{i} ''';']);
    
    % textbox
    boxw = num2str(textbox_w - 0.03);
    boxh = num2str(textbox_h - 0.05);
    eval(['set(data.text' num2str(j) ',''Units'', '' normalized '')']);
    eval(['set(data.text' num2str(j) ',''Position'',[' num2str(col_x(4) + 0.02) ', ' 0.1 + y_temp ', ' boxw ', ' boxh '])']);
    eval(['set(data.text' num2str(j) ',''String'', ''' col4_labels{i} ''')']);
end


% Build column 5
for i = 1:np
    % Current checkbox j
    j = nmd+nst+no+ntc+i;
    
    % positioning of checkboxes
    y_temp = num2str(0.03+(0.85-0.03)/(np+1)*(np+1-i) );
    eval(['set(data.checkbox' num2str(j) ',''Position'',[' num2str(col_x(5)) ', ' y_temp ', 0.015, 0.020])']);

    % strings
    eval(['set(data.checkbox' num2str(j) ',''String'', ''' col5_labels{i} ''')']);
    eval(['data.checkbox' num2str(j) '.TooltipString = ''' col5_labels{i} ''';']);
    
    % textbox
    boxw = num2str(textbox_w - 0.00);
    boxh = num2str(textbox_h - 0.04);
    eval(['set(data.text' num2str(j) ',''Units'', '' normalized '')']);
    eval(['set(data.text' num2str(j) ',''FontSize'', 7)']);
    eval(['set(data.text' num2str(j) ',''Position'',[' num2str(col_x(5) + 0.02) ', ' y_temp ', ' boxw ', ' boxh '])']);
    eval(['set(data.text' num2str(j) ',''String'', ''' col5_labels{i} ''')']);
end


% Build column 6
for i = 1:npro
    % Current check box j
    j = nmd+nst+no+ntc+np+i;
    
    % positioning
    y_temp = num2str(0.03+(0.85-0.03)/(npro+1)*(npro+1-i));
    eval(['set(data.checkbox' num2str(nmd+nst+no+ntc+np+i) ',''Position'',[' num2str(col_x(6)) ', ' y_temp ', 0.015, 0.020])']);
    
    % strings
    eval(['set(data.checkbox' num2str(j) ',''String'', ''' col6_labels{i} ''')']);
    eval(['data.checkbox' num2str(j) '.TooltipString = ''' col6_labels{i} ''';']);
    
    % textbox
	boxw = num2str(textbox_w - 0.035);
    boxh = num2str(textbox_h - 0.02);
    eval(['set(data.text' num2str(j) ',''Units'', '' normalized '')']);
    eval(['set(data.text' num2str(j) ',''FontSize'', 7)']);
    eval(['set(data.text' num2str(j) ',''Position'',[0.015+' num2str(col_x(6)) ', ' y_temp ', ' boxw ', ' boxh '])']);
    eval(['set(data.text' num2str(j) ',''String'', ''' col6_labels{i} ''')']);
end


% Build the CLEAR ALL button
% Placed manually for now.
%eval(['set(data.pushbutton2, ''Position'', [0.50 0.50 0.08 0.04]), ''Visible'', ''on''']);



%% ------------------------------ SEND TO GUI ------------------------------%
data.allhandles = guihandles(f);
data.dir = false;   % Sets default direction to L -> R
data.allvariables = vars;
guidata(f,data);
h1 = data.figure1.CurrentAxes;
axis(h1,[0 1 0 1]);
hold(h1);
set(h1,'XTickLabel','','YTickLabel','','XTick','','YTick','','Box','on');






 