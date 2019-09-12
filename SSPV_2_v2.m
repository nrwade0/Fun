%% ----------------------------- PREAMBLE -----------------------------------%
% Code originally created by Dr. Jeremy Pinier, June 2017
% Repurposed April 2019 for Validation Hierarchy
% 
% Code history can be found in SSPVRUN_2_v2.m
% 
% Supress unused parameters and callback errors
%#ok<*DEFNU>
%#ok<*INUSL>
%
%% -----------------
function varargout = SSPV_2_v2(varargin)
    %function varargout = SSPV_2_v2.3(varargin)
    % SSPV_2_v2.3 MATLAB code for SSPV_2_v2.3.fig
    %      SSPV_2_v2, by itself, creates a new SSPV_2_v2 or raises the existing
    %      singleton*.
    %
    %      H = SSPV_2_v2 returns the handle to a new SSPV_2_v2 or the handle to
    %      the existing singleton*.
    %
    %      SSPV_2_v2('CALLBACK',hObject,eventData,handles,...) calls the local
    %      function named CALLBACK in SSPV_2_v2.3.m with the given input arguments.
    %
    %      SSPV_2_v2('Property','Value',...) creates a new SSPV_2_v2.3 or raises the
    %      existing singleton*.  Starting from the left, property value pairs are
    %      applied to the GUI before SSPV_2_v2.3_OpeningFcn gets called.  An
    %      unrecognized property name or invalid value makes property application
    %      stop.  All inputs are passed to SSPV_2_v2.3_OpeningFcn via varargin.
    %
    %      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
    %      instance to run (singleton)".
    %
    % See also: GUIDE, GUIDATA, GUIHANDLES

    % Edit the above text to modify the response to help SSPV_2_v2.3

    % Last Modified by GUIDE v2.5 24-Apr-2019 09:43:31

    % Begin initialization code - DO NOT EDIT
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @SSPV_2_v2_OpeningFcn, ...
                       'gui_OutputFcn',  @SSPV_2_v2_OutputFcn, ...
                       'gui_LayoutFcn',  [] , ...
                       'gui_Callback',   []);
    if nargin && ischar(varargin{1})
        gui_State.gui_Callback = str2func(varargin{1});
    end

    if nargout
        [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
    else
        gui_mainfcn(gui_State, varargin{:});
    end
    % End initialization code - DO NOT EDIT
end

% --- Executes just before SSPV_2_v2 is made visible.
function SSPV_2_v2_OpeningFcn(hObject, eventdata, handles, varargin)
    % This function has no output args, see OutputFcn.
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    % varargin   command line arguments to SSPV_2_v2 (see VARARGIN)
    
    % Choose default command line output for SSPV_2_v2
    handles.output = hObject;

    % Update handles structure
    guidata(hObject, handles);
    
%     global dir
%     dir = false;
%     disp(dir)

    % UIWAIT makes SSPV_2_v2 wait for user response (see UIRESUME)
    % uiwait(handles.figure1);
end

% --- Outputs from this function are returned to the command line.
function varargout = SSPV_2_v2_OutputFcn(hObject, eventdata, handles) 
    % varargout  cell array for returning output args (see VARARGOUT);
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Get default command line output from handles structure
    varargout{1} = handles.output;
end


%% ---------------------------- DIRECTION CHECKBOX ------------------------%
% Callback for direction checkbox
%   Determines the direction of flow
%      if check, flow is R -> L
%      else, flow is L -> R
%   This is saved in the handles structure under 'dir'
%   Saved using guidata so the current value can be accessed in other
%    callbacks.
function checkbox_direction_Callback(hObject, eventdata, handles)

    % if checkbox is toggled
    if (get(hObject,'Value') == get(hObject,'Max'))
        % Sets direction handle to true if checked (R -> L)
        handles.dir = true;
    else
        % Sets direction handle to false if unchecked (L -> R)
        handles.dir = false;
    end
    
    % Updates the handles structure with the direction
    guidata(hObject,handles)
    
end



%% --------------------------- CHECKBOX CALLBACK ---------------------------%
% Callback for all the checkboxes
%   Initializes variables
%   Determines the column of the checkbox 
%   Runs the appropriate flow loops to draw connection
function checkbox_Callback(hObject, eventdata, handles)
    %% ----------------------------- INITIALIZE ----------------------------%
    % h = current handle object, str is the tag = 'checkboxi'
    % i stores the number of the checkbox.
    h = gcbo;
    str = h.Tag;
    i = sscanf(str,'checkbox%d');
    
    % A: connections between columns 1 and 2
    % B: connections between columns 2 and 3
    % C: connections between columns 3 and 4
    % D: connections between columns 4 and 5
    % E: connections between columns 5 and 6
    A = handles.allvariables{1}(:,:);
    B = handles.allvariables{2}(:,:);
    C = handles.allvariables{3}(:,:);
    D = handles.allvariables{4}(:,:);
    E = handles.allvariables{5}(:,:);
    
    % nmd:  number of items in column 1
    % nst:  number of items in column 2
    % no:   number of items in column 3
    % ntc:  number of items in column 4
    % np:   number of items in column 5
    % npro: number of items in column 6
    nmd  = handles.allvariables{6}(:,:);
    nst  = handles.allvariables{7}(:,:);
    no   = handles.allvariables{8}(:,:);
    ntc  = handles.allvariables{9}(:,:);
    np   = handles.allvariables{10}(:,:);
    npro = handles.allvariables{11}(:,:);
    
    % ys: divisor in many position arguments, slices up the y-space evenly
    % xm: a dummy value to add a but more x-space across all arrows
    % Ncols: Number of columns
    % h1: current axes
    % dir: boolean determining the direction of flow
    ys = handles.allvariables{12}(:,:);
    xm = handles.allvariables{13}(:,:);
    Ncols = handles.allvariables{14}(:,:);
    h1 = handles.allhandles.figure1.CurrentAxes;
    dir = handles.dir;
    guidata(hObject,handles) % update handles structure
    
    % determine x's by column number
    xspace = linspace(0.06, 0.96, Ncols);
    
    %% ----------------------------- COLUMN NUMBER -------------------------%
    % Find col_num to determine how to draw connections
    % initialize checkbox column number
    col_num = 0;
    
    % is in the first column
    if (i > 0) && (i <= nmd) 
        col_num = 1;
    
    % is in the second column
    elseif (i > nmd) && (i <= nmd+nst)   
        col_num = 2;
        
    % is in the third column
    elseif (i > nmd+nst) && (i <= nmd+nst+no)   
        col_num = 3;
        
    % is in the fourth column
    elseif (i > nmd+nst+no) && (i <= nmd+nst+no+ntc)   
        col_num = 4;
        
    % is in the fifth column
    elseif (i > nmd+nst+no+ntc) && (i <= nmd+nst+no+ntc+np)   
        col_num = 5;
        
    % is in the sixth column
    elseif (i > nmd+nst+no+ntc+np) && (i <= nmd+nst+no+ntc+np+npro)   
        col_num = 6;
    end
    
    
    %% ---------------------------- DRAW CONNECTIONS -----------------------%
    % Draw connections based on column number, only write specific ways.
    %  E.g. Column 6 only writes to the left.
    % col_num = 0: Was not changed, checkbox not found in any column, error
    %         = 1: Column 1, write connections (right = 5, left = 0)
    %         = 2: Column 2, write connections (right = 4, left = 1)
    %         = 3: Column 3, write connections (right = 3, left = 2)
    %         = 4: Column 4, write connections (right = 2, left = 3)
    %         = 5: Column 5, write connections (right = 1, left = 4)
    %         = 6: Column 6, write connections (right = 0, left = 5)
    switch col_num
        
        case 0 % -------------------------------------------- Error
            errordlg('Column = 0 error - checkbox not found','Draw Error');
            %disp('Column error - checkbox not found')
            return;
            
            
        case 1 % -------------------------------------------- First column
            if (dir == true) % R -> L
                % check if textbox is toggled
                if (get(hObject,'Value') == get(hObject,'Max')) 
                    % Display text if this checkbox is toggled
                    eval(['set(handles.text' num2str(i) ', ''Visible'', ''on'');']);
                else
                    % Hide text if this checkbox is not toggled
                    eval(['set(handles.text' num2str(i) ', ''Visible'', ''off'');']);
                end
                
            else % L -> R
                if (get(hObject,'Value') == get(hObject,'Max')) % toggled
                    % Display text if this checkbox is toggled
                    eval(['set(handles.text' num2str(i) ', ''Visible'', ''on'');']);

                    % first column (i = current checkbox in column 1)
                    for j = 1:nst % check if connection exists to each checkbox in col 2 
                        % (j = some checkbox in col 2)
                        if A(i,j) == 1 % if a connection exists...

                            % starting quiver point coordinates
                            p1x = xspace(1) + xm;
                            p1y = (0.85-0.04)/(nmd+1)*(nmd+1-i)/ys;

                            % ending quiver points coordinates
                            p2x = xspace(2) - xm;
                            p2y = (0.85-0.04)*(nst+1-j)/((nst+1)*ys);

                            % calculate quiver positioning
                            p1 = [p1x p1y];
                            p2 = [p2x p2y];
                            dp = p2 - p1;

                            % draw arrow from col 1 to col 2
                            quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','b','MaxHeadSize',0.025/norm(dp));

                            % second column (j = current checkbox in column 2)
                            for k = 1:size(B,2) % check if connection exists to each checkbox in col 3
                                % (k = some checkbox in col 3)
                                if B(j,k) == 1 % if a connection exists...

                                    % starting quiver point coordinates
                                    p1x = xspace(2) + xm;
                                    p1y = (0.85-0.04)/(nst+1)*(nst+1-j)/ys;

                                    % ending quiver points coordinates
                                    p2x = xspace(3) - xm;
                                    p2y = (0.85-0.04)*(no+1-k)/((no+1)*ys);

                                    % calculate quiver positioning
                                    p1 = [p1x p1y];
                                    p2 = [p2x p2y];
                                    dp = p2-p1;

                                    % draw arrow from col 2 to col 3
                                    quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','b','MaxHeadSize',0.025/norm(dp));

                                    % third column (k = current checkbox in column 3)
                                    for l = 1:size(C,2) % check if connection exists to each checkbox in col 4
                                        % (l = some checkbox in col 4)
                                        if C(k,l) == 1 % if a connection exists...
                                            % starting quiver point coordinates
                                            p1x = xspace(3) + xm;
                                            p1y = (0.85-0.04)/(no+1)*(no+1-k)/ys;

                                            % ending quiver points coordinates
                                            p2x = xspace(4) - xm;
                                            p2y = (0.85-0.04)*(ntc+1-l)/((ntc+1)*ys);

                                            % calculate quiver positioning
                                            p1 = [p1x p1y];
                                            p2 = [p2x p2y];
                                            dp = p2 - p1;

                                            % draw arrow from col 3 to col 4
                                            quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','b','MaxHeadSize',0.025/norm(dp));

                                            % fourth column (l = current checkbox in column 4)
                                            for m = 1:size(D,2) % check if connection exists to each checkbox in col 5
                                                % (m = some checkbox in col 5)
                                                if D(l,m) == 1 % if a connection exists...

                                                    % starting quiver point coordinates
                                                    p1x = xspace(4) + xm;
                                                    p1y = (0.85-0.04)/(ntc+1)*(ntc+1-l)/ys;

                                                    % ending quiver points coordinates
                                                    p2x = xspace(5) - xm;
                                                    p2y = (0.85-0.04)*(np+1-m)/((np+1)*ys);

                                                    % calculate quiver positioning
                                                    p1 = [p1x p1y];
                                                    p2 = [p2x p2y];
                                                    dp = p2 - p1;

                                                    % draw arrow from col 4 to col 5
                                                    quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','b','MaxHeadSize',0.025/norm(dp));

                                                    % fifth column (m = current checkbox in column 5)
                                                    for n = 1:size(E,2) % check if connection exists to each checkbox in col 6
                                                        % (n = some checkbox in col 6)
                                                        if E(m,n) == 1 % if a connection exists...

                                                            % starting quiver point coordinates
                                                            p1x = xspace(5) + xm;
                                                            p1y = (0.85-0.04)/(np+1)*(np+1-m)/ys;

                                                            % ending quiver points coordinates
                                                            p2x = xspace(6) - xm;
                                                            p2y = (0.85-0.04)*(npro+1-n)/((npro+1)*ys);

                                                            % calculate quiver positioning
                                                            p1 = [p1x p1y];
                                                            p2 = [p2x p2y];
                                                            dp = p2 - p1;

                                                            % draw arrow from col 5 to col 6
                                                            quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','b','MaxHeadSize',0.025/norm(dp));
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                else
                    % Hide text if this checkbox is not toggled
                    eval(['set(handles.text' num2str(i) ', ''Visible'', ''off'');']);

                    % first column (i = current checkbox in column 1)
                    for j = 1:nst % check if connection exists to each checkbox in col 2 
                        % (j = some checkbox in col 2)
                        if A(i,j) == 1 % if a connection exists...

                            % starting quiver point coordinates
                            p1x = xspace(1) + xm;
                            p1y = (0.85-0.04)/(nmd+1)*(nmd+1-i)/ys;

                            % ending quiver points coordinates
                            p2x = xspace(2) - xm;
                            p2y = (0.85-0.04)*(nst+1-j)/((nst+1)*ys);

                            % calculate quiver positioning
                            p1 = [p1x p1y];
                            p2 = [p2x p2y];
                            dp = p2 - p1;

                            % draw arrow from col 1 to col 2
                            quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','w','MaxHeadSize',0.025/norm(dp));

                            % second column (j = current checkbox in column 2)
                            for k = 1:size(B,2) % check if connection exists to each checkbox in col 3
                                % (k = some checkbox in col 3)
                                if B(j,k) == 1 % if a connection exists...

                                    % starting quiver point coordinates
                                    p1x = xspace(2) + xm;
                                    p1y = (0.85-0.04)/(nst+1)*(nst+1-j)/ys;

                                    % ending quiver points coordinates
                                    p2x = xspace(3) - xm;
                                    p2y = (0.85-0.04)*(no+1-k)/((no+1)*ys);

                                    % calculate quiver positioning
                                    p1 = [p1x p1y];
                                    p2 = [p2x p2y];
                                    dp = p2-p1;

                                    % draw arrow from col 2 to col 3
                                    quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','w','MaxHeadSize',0.025/norm(dp));

                                    % third column (k = current checkbox in column 3)
                                    for l = 1:size(C,2) % check if connection exists to each checkbox in col 4
                                        % (l = some checkbox in col 4)
                                        if C(k,l) == 1 % if a connection exists...
                                            % starting quiver point coordinates
                                            p1x = xspace(3) + xm;
                                            p1y = (0.85-0.04)/(no+1)*(no+1-k)/ys;

                                            % ending quiver points coordinates
                                            p2x = xspace(4) - xm;
                                            p2y = (0.85-0.04)*(ntc+1-l)/((ntc+1)*ys);

                                            % calculate quiver positioning
                                            p1 = [p1x p1y];
                                            p2 = [p2x p2y];
                                            dp = p2 - p1;

                                            % draw arrow from col 3 to col 4
                                            quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','w','MaxHeadSize',0.025/norm(dp));

                                            % fourth column (l = current checkbox in column 4)
                                            for m = 1:size(D,2) % check if connection exists to each checkbox in col 5
                                                % (m = some checkbox in col 5)
                                                if D(l,m) == 1 % if a connection exists...

                                                    % starting quiver point coordinates
                                                    p1x = xspace(4) + xm;
                                                    p1y = (0.85-0.04)/(ntc+1)*(ntc+1-l)/ys;

                                                    % ending quiver points coordinates
                                                    p2x = xspace(5) - xm;
                                                    p2y = (0.85-0.04)*(np+1-m)/((np+1)*ys);

                                                    % calculate quiver positioning
                                                    p1 = [p1x p1y];
                                                    p2 = [p2x p2y];
                                                    dp = p2 - p1;

                                                    % draw arrow from col 4 to col 5
                                                    quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','w','MaxHeadSize',0.025/norm(dp));

                                                    % fifth column (m = current checkbox in column 5)
                                                    for n = 1:size(E,2) % check if connection exists to each checkbox in col 6
                                                        % (n = some checkbox in col 6)
                                                        if E(m,n) == 1 % if a connection exists...

                                                            % starting quiver point coordinates
                                                            p1x = xspace(5) + xm;
                                                            p1y = (0.85-0.04)/(np+1)*(np+1-m)/ys;

                                                            % ending quiver points coordinates
                                                            p2x = xspace(6) - xm;
                                                            p2y = (0.85-0.04)*(npro+1-n)/((npro+1)*ys);

                                                            % calculate quiver positioning
                                                            p1 = [p1x p1y];
                                                            p2 = [p2x p2y];
                                                            dp = p2 - p1;

                                                            % draw arrow from col 5 to col 6
                                                            quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','w','MaxHeadSize',0.025/norm(dp));
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
           
        
        case 2 % -------------------------------------------- Second column
            % current checkbox in this column
            j = i - nmd;
            
            if (dir == true) % R -> L
                % Transpose of connection matrices, going right to left
                At = A.'; 

                if (get(hObject,'Value') == get(hObject,'Max')) % toggled
                    % Display text if this checkbox is toggled
                    eval(['set(handles.text' num2str(i) ', ''Visible'', ''on'');']);

                    % second column (j = current checkbox in column 2)
                    for i = 1:nmd % check if connection exists to each checkbox in col 1
                        % (i = some checkbox in col 1)

                        if At(j,i) == 1 % if a connection exists...

                            % starting quiver point coordinates col 2
                            p1x = xspace(2) - xm;
                            p1y = (0.85-0.04)/(nst+1)*(nst+1-j)/ys;

                            % ending quiver points coordinates col 1
                            p2x = xspace(1) + xm;
                            p2y = (0.85-0.04)*(nmd+1-i)/((nmd+1)*ys);

                            % calculate quiver positioning
                            p1 = [p1x p1y];
                            p2 = [p2x p2y];
                            dp = p2 - p1;

                            % draw arrow from col 3 to col 2
                            quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','r','MaxHeadSize',0.025/norm(dp));
                        end
                    end
                else
                    % Hide text if this checkbox is not toggled
                    eval(['set(handles.text' num2str(i) ', ''Visible'', ''off'');']);

                    % second column (j = current checkbox in column 2)
                    for i = 1:nmd % check if connection exists to each checkbox in col 1
                        % (i = some checkbox in col 1)

                        if At(j,i) == 1 % if a connection exists...

                            % starting quiver point coordinates col 2
                            p1x = xspace(2) - xm;
                            p1y = (0.85-0.04)/(nst+1)*(nst+1-j)/ys;

                            % ending quiver points coordinates col 1
                            p2x = xspace(1) + xm;
                            p2y = (0.85-0.04)*(nmd+1-i)/((nmd+1)*ys);

                            % calculate quiver positioning
                            p1 = [p1x p1y];
                            p2 = [p2x p2y];
                            dp = p2 - p1;

                            % draw arrow from col 3 to col 2
                            quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','w','MaxHeadSize',0.025/norm(dp));
                        end
                    end
                end
                
            else % L -> R
                if (get(hObject,'Value') == get(hObject,'Max')) % toggled
                    % Display text if this checkbox is toggled
                    eval(['set(handles.text' num2str(i) ', ''Visible'', ''on'');']);

                    % second column (j = current checkbox in column 2)
                    for k = 1:no % check if connection exists to each checkbox in col 3
                        % (k = some checkbox in col 3)
                        if B(j,k) == 1 % if a connection exists...

                            % starting quiver point coordinates
                            p1x = xspace(2) + xm;
                            p1y = (0.85-0.04)/(nst+1)*(nst+1-j)/ys;

                            % ending quiver points coordinates
                            p2x = xspace(3) - xm;
                            p2y = (0.85-0.04)*(no+1-k)/((no+1)*ys);

                            % calculate quiver positioning
                            p1 = [p1x p1y];
                            p2 = [p2x p2y];
                            dp = p2-p1;

                            % draw arrow from col 2 to col 3
                            quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','b','MaxHeadSize',0.025/norm(dp));

                            % third column (k = current checkbox in column 3)
                            for l = 1:size(C,2) % check if connection exists to each checkbox in col 4
                                % (l = some checkbox in col 4)
                                if C(k,l) == 1 % if a connection exists...
                                    % starting quiver point coordinates
                                    p1x = xspace(3) + xm;
                                    p1y = (0.85-0.04)/(no+1)*(no+1-k)/ys;

                                    % ending quiver points coordinates
                                    p2x = xspace(4) - xm;
                                    p2y = (0.85-0.04)*(ntc+1-l)/((ntc+1)*ys);

                                    % calculate quiver positioning
                                    p1 = [p1x p1y];
                                    p2 = [p2x p2y];
                                    dp = p2 - p1;

                                    % draw arrow from col 3 to col 4
                                    quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','b','MaxHeadSize',0.025/norm(dp));

                                    % fourth column (l = current checkbox in column 4)
                                    for m = 1:size(D,2) % check if connection exists to each checkbox in col 5
                                        % (m = some checkbox in col 5)
                                        if D(l,m) == 1 % if a connection exists...

                                            % starting quiver point coordinates
                                            p1x = xspace(4) + xm;
                                            p1y = (0.85-0.04)/(ntc+1)*(ntc+1-l)/ys;

                                            % ending quiver points coordinates
                                            p2x = xspace(5) - xm;
                                            p2y = (0.85-0.04)*(np+1-m)/((np+1)*ys);

                                            % calculate quiver positioning
                                            p1 = [p1x p1y];
                                            p2 = [p2x p2y];
                                            dp = p2 - p1;

                                            % draw arrow from col 4 to col 5
                                            quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','b','MaxHeadSize',0.025/norm(dp));

                                            % fifth column (m = current checkbox in column 5)
                                            for n = 1:size(E,2) % check if connection exists to each checkbox in col 6
                                                % (n = some checkbox in col 6)
                                                if E(m,n) == 1 % if a connection exists...

                                                    % starting quiver point coordinates
                                                    p1x = xspace(5) + xm;
                                                    p1y = (0.85-0.04)/(np+1)*(np+1-m)/ys;

                                                    % ending quiver points coordinates
                                                    p2x = xspace(6) - xm;
                                                    p2y = (0.85-0.04)*(npro+1-n)/((npro+1)*ys);

                                                    % calculate quiver positioning
                                                    p1 = [p1x p1y];
                                                    p2 = [p2x p2y];
                                                    dp = p2 - p1;

                                                    % draw arrow from col 5 to col 6
                                                    quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','b','MaxHeadSize',0.025/norm(dp));
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                else
                    % Hide text if this checkbox is not toggled
                    eval(['set(handles.text' num2str(i) ', ''Visible'', ''off'');']);

                    % second column (j = current checkbox in column 2)
                    for k = 1:no % check if connection exists to each checkbox in col 3
                        % (k = some checkbox in col 3)
                        if B(j,k) == 1 % if a connection exists...

                            % starting quiver point coordinates
                            p1x = xspace(2) + xm;
                            p1y = (0.85-0.04)/(nst+1)*(nst+1-j)/ys;

                            % ending quiver points coordinates
                            p2x = xspace(3) - xm;
                            p2y = (0.85-0.04)*(no+1-k)/((no+1)*ys);

                            % calculate quiver positioning
                            p1 = [p1x p1y];
                            p2 = [p2x p2y];
                            dp = p2-p1;

                            % draw arrow from col 2 to col 3
                            quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','w','MaxHeadSize',0.025/norm(dp));

                            % third column (k = current checkbox in column 3)
                            for l = 1:size(C,2) % check if connection exists to each checkbox in col 4
                                % (l = some checkbox in col 4)
                                if C(k,l) == 1 % if a connection exists...
                                    % starting quiver point coordinates
                                    p1x = xspace(3) + xm;
                                    p1y = (0.85-0.04)/(no+1)*(no+1-k)/ys;

                                    % ending quiver points coordinates
                                    p2x = xspace(4) - xm;
                                    p2y = (0.85-0.04)*(ntc+1-l)/((ntc+1)*ys);

                                    % calculate quiver positioning
                                    p1 = [p1x p1y];
                                    p2 = [p2x p2y];
                                    dp = p2 - p1;

                                    % draw arrow from col 3 to col 4
                                    quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','w','MaxHeadSize',0.025/norm(dp));

                                    % fourth column (l = current checkbox in column 4)
                                    for m = 1:size(D,2) % check if connection exists to each checkbox in col 5
                                        % (m = some checkbox in col 5)
                                        if D(l,m) == 1 % if a connection exists...

                                            % starting quiver point coordinates
                                            p1x = xspace(4) + xm;
                                            p1y = (0.85-0.04)/(ntc+1)*(ntc+1-l)/ys;

                                            % ending quiver points coordinates
                                            p2x = xspace(5) - xm;
                                            p2y = (0.85-0.04)*(np+1-m)/((np+1)*ys);

                                            % calculate quiver positioning
                                            p1 = [p1x p1y];
                                            p2 = [p2x p2y];
                                            dp = p2 - p1;

                                            % draw arrow from col 4 to col 5
                                            quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','w','MaxHeadSize',0.025/norm(dp));

                                            % fifth column (m = current checkbox in column 5)
                                            for n = 1:size(E,2) % check if connection exists to each checkbox in col 6
                                                % (n = some checkbox in col 6)
                                                if E(m,n) == 1 % if a connection exists...

                                                    % starting quiver point coordinates
                                                    p1x = xspace(5) + xm;
                                                    p1y = (0.85-0.04)/(np+1)*(np+1-m)/ys;

                                                    % ending quiver points coordinates
                                                    p2x = xspace(6) - xm;
                                                    p2y = (0.85-0.04)*(npro+1-n)/((npro+1)*ys);

                                                    % calculate quiver positioning
                                                    p1 = [p1x p1y];
                                                    p2 = [p2x p2y];
                                                    dp = p2 - p1;

                                                    % draw arrow from col 5 to col 6
                                                    quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','w','MaxHeadSize',0.025/norm(dp));
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
            
            
        case 3 % -------------------------------------------- Third column
            % current checkbox in this column
            k = i - nmd - nst;

            if (dir == true) % R -> L
                % Transpose of connection matrices, going right to left
                At = A.'; 
                Bt = B.';

                if (get(hObject,'Value') == get(hObject,'Max')) % toggled
                    % Display text if this checkbox is toggled
                    eval(['set(handles.text' num2str(i) ', ''Visible'', ''on'');']);

                    % third column (k = current checkbox in column 3)
                    for j = 1:nst % check if connection exists to each checkbox in col 2
                        % (j = some checkbox in col 2)

                        if Bt(k,j) == 1 % if a connection exists...

                            % starting quiver point coordinates col 3
                            p1x = xspace(3) - xm;
                            p1y = (0.85-0.04)/(no+1)*(no+1-k)/ys;

                            % ending quiver points coordinates col 2
                            p2x = xspace(2) + xm;
                            p2y = (0.85-0.04)*(nst+1-j)/((nst+1)*ys);

                            % calculate quiver positioning
                            p1 = [p1x p1y];
                            p2 = [p2x p2y];
                            dp = p2 - p1;

                            % draw arrow from col 3 to col 2
                            quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','r','MaxHeadSize',0.025/norm(dp));

                            % second column (j = current checkbox in column 2)
                            for i = 1:nmd % check if connection exists to each checkbox in col 1
                                % (i = some checkbox in col 1)

                                if At(j,i) == 1 % if a connection exists...

                                    % starting quiver point coordinates col 2
                                    p1x = xspace(2) - xm;
                                    p1y = (0.85-0.04)/(nst+1)*(nst+1-j)/ys;

                                    % ending quiver points coordinates col 1
                                    p2x = xspace(1) + xm;
                                    p2y = (0.85-0.04)*(nmd+1-i)/((nmd+1)*ys);

                                    % calculate quiver positioning
                                    p1 = [p1x p1y];
                                    p2 = [p2x p2y];
                                    dp = p2 - p1;

                                    % draw arrow from col 3 to col 2
                                    quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','r','MaxHeadSize',0.025/norm(dp));
                                end
                            end
                        end
                    end
                else
                    % Hide text if this checkbox is not toggled
                    eval(['set(handles.text' num2str(i) ', ''Visible'', ''off'');']);

                    % third column (k = current checkbox in column 3)
                    for j = 1:nst % check if connection exists to each checkbox in col 2
                        % (j = some checkbox in col 2)

                        if Bt(k,j) == 1 % if a connection exists...

                            % starting quiver point coordinates col 3
                            p1x = xspace(3) - xm;
                            p1y = (0.85-0.04)/(no+1)*(no+1-k)/ys;

                            % ending quiver points coordinates col 2
                            p2x = xspace(2) + xm;
                            p2y = (0.85-0.04)*(nst+1-j)/((nst+1)*ys);

                            % calculate quiver positioning
                            p1 = [p1x p1y];
                            p2 = [p2x p2y];
                            dp = p2 - p1;

                            % draw arrow from col 3 to col 2
                            quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','w','MaxHeadSize',0.025/norm(dp));

                            % second column (j = current checkbox in column 2)
                            for i = 1:nmd % check if connection exists to each checkbox in col 1
                                % (i = some checkbox in col 1)

                                if At(j,i) == 1 % if a connection exists...

                                    % starting quiver point coordinates col 2
                                    p1x = xspace(2) - xm;
                                    p1y = (0.85-0.04)/(nst+1)*(nst+1-j)/ys;

                                    % ending quiver points coordinates col 1
                                    p2x = xspace(1) + xm;
                                    p2y = (0.85-0.04)*(nmd+1-i)/((nmd+1)*ys);

                                    % calculate quiver positioning
                                    p1 = [p1x p1y];
                                    p2 = [p2x p2y];
                                    dp = p2 - p1;

                                    % draw arrow from col 3 to col 2
                                    quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','w','MaxHeadSize',0.025/norm(dp));
                                end
                            end
                        end
                    end
                end
                
            else % L -> R
                if (get(hObject,'Value') == get(hObject,'Max')) % toggled
                    % Display text if this checkbox is toggled
                    eval(['set(handles.text' num2str(i) ', ''Visible'', ''on'');']);

                    % third column (k = current checkbox in column 3)
                    for l = 1:ntc % check if connection exists to each checkbox in col 4
                        % (l = some checkbox in col 4)
                        if C(k,l) == 1 % if a connection exists...
                            % starting quiver point coordinates
                            p1x = xspace(3) + xm;
                            p1y = (0.85-0.04)/(no+1)*(no+1-k)/ys;

                            % ending quiver points coordinates
                            p2x = xspace(4) - xm;
                            p2y = (0.85-0.04)*(ntc+1-l)/((ntc+1)*ys);

                            % calculate quiver positioning
                            p1 = [p1x p1y];
                            p2 = [p2x p2y];
                            dp = p2 - p1;

                            % draw arrow from col 3 to col 4
                            quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','b','MaxHeadSize',0.025/norm(dp));

                            % fourth column (l = current checkbox in column 4)
                            for m = 1:size(D,2) % check if connection exists to each checkbox in col 5
                                % (m = some checkbox in col 5)
                                if D(l,m) == 1 % if a connection exists...

                                    % starting quiver point coordinates
                                    p1x = xspace(4) + xm;
                                    p1y = (0.85-0.04)/(ntc+1)*(ntc+1-l)/ys;

                                    % ending quiver points coordinates
                                    p2x = xspace(5) - xm;
                                    p2y = (0.85-0.04)*(np+1-m)/((np+1)*ys);

                                    % calculate quiver positioning
                                    p1 = [p1x p1y];
                                    p2 = [p2x p2y];
                                    dp = p2 - p1;

                                    % draw arrow from col 4 to col 5
                                    quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','b','MaxHeadSize',0.025/norm(dp));

                                    % fifth column (m = current checkbox in column 5)
                                    for n = 1:size(E,2) % check if connection exists to each checkbox in col 6
                                        % (n = some checkbox in col 6)
                                        if E(m,n) == 1 % if a connection exists...

                                            % starting quiver point coordinates
                                            p1x = xspace(5) + xm;
                                            p1y = (0.85-0.04)/(np+1)*(np+1-m)/ys;

                                            % ending quiver points coordinates
                                            p2x = xspace(6) - xm;
                                            p2y = (0.85-0.04)*(npro+1-n)/((npro+1)*ys);

                                            % calculate quiver positioning
                                            p1 = [p1x p1y];
                                            p2 = [p2x p2y];
                                            dp = p2 - p1;

                                            % draw arrow from col 5 to col 6
                                            quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','b','MaxHeadSize',0.025/norm(dp));
                                        end
                                    end
                                end
                            end
                        end
                    end
                else
                    % Hide text if this checkbox is not toggled
                    eval(['set(handles.text' num2str(i) ', ''Visible'', ''off'');']);

                    % third column (k = current checkbox in column 3)
                    for l = 1:ntc % check if connection exists to each checkbox in col 4
                        % (l = some checkbox in col 4)
                        if C(k,l) == 1 % if a connection exists...
                            % starting quiver point coordinates
                            p1x = xspace(3) + xm;
                            p1y = (0.85-0.04)/(no+1)*(no+1-k)/ys;

                            % ending quiver points coordinates
                            p2x = xspace(4) - xm;
                            p2y = (0.85-0.04)*(ntc+1-l)/((ntc+1)*ys);

                            % calculate quiver positioning
                            p1 = [p1x p1y];
                            p2 = [p2x p2y];
                            dp = p2 - p1;

                            % draw arrow from col 3 to col 4
                            quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','w','MaxHeadSize',0.025/norm(dp));

                            % fourth column (l = current checkbox in column 4)
                            for m = 1:size(D,2) % check if connection exists to each checkbox in col 5
                                % (m = some checkbox in col 5)
                                if D(l,m) == 1 % if a connection exists...

                                    % starting quiver point coordinates
                                    p1x = xspace(4) + xm;
                                    p1y = (0.85-0.04)/(ntc+1)*(ntc+1-l)/ys;

                                    % ending quiver points coordinates
                                    p2x = xspace(5) - xm;
                                    p2y = (0.85-0.04)*(np+1-m)/((np+1)*ys);

                                    % calculate quiver positioning
                                    p1 = [p1x p1y];
                                    p2 = [p2x p2y];
                                    dp = p2 - p1;

                                    % draw arrow from col 4 to col 5
                                    quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','w','MaxHeadSize',0.025/norm(dp));

                                    % fifth column (m = current checkbox in column 5)
                                    for n = 1:size(E,2) % check if connection exists to each checkbox in col 6
                                        % (n = some checkbox in col 6)
                                        if E(m,n) == 1 % if a connection exists...

                                            % starting quiver point coordinates
                                            p1x = xspace(5) + xm;
                                            p1y = (0.85-0.04)/(np+1)*(np+1-m)/ys;

                                            % ending quiver points coordinates
                                            p2x = xspace(6) - xm;
                                            p2y = (0.85-0.04)*(npro+1-n)/((npro+1)*ys);

                                            % calculate quiver positioning
                                            p1 = [p1x p1y];
                                            p2 = [p2x p2y];
                                            dp = p2 - p1;

                                            % draw arrow from col 5 to col 6
                                            quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','w','MaxHeadSize',0.025/norm(dp));
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
            
            
        case 4 % -------------------------------------------- Fourth column
            % current checkbox in this column
            l = i - nmd - nst - no;

            if (dir == true) % R -> L
                % Transpose of connection matrices, going right to left
                At = A.'; 
                Bt = B.';
                Ct = C.';

                if (get(hObject,'Value') == get(hObject,'Max')) % toggled
                    % Display text if this checkbox is toggled
                    eval(['set(handles.text' num2str(i) ', ''Visible'', ''on'');']);

                    % fourth column (l = current checkbox in column 4)
                    for k = 1:no % check if connection exists to each checkbox in col 3
                        % (k = some checkbox in col 3)

                        if Ct(l,k) == 1 % if a connection exists...

                            % starting quiver point coordinates col 4
                            p1x = xspace(4) - xm;
                            p1y = (0.85-0.04)/(ntc+1)*(ntc+1-l)/ys;

                            % ending quiver points coordinates col 3 
                            p2x = xspace(3) + xm;
                            p2y = (0.85-0.04)*(no+1-k)/((no+1)*ys);

                            % calculate quiver positioning
                            p1 = [p1x p1y];
                            p2 = [p2x p2y];
                            dp = p2 - p1;

                            % draw arrow from col 4 to col 3
                            quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','r','MaxHeadSize',0.025/norm(dp));

                            % third column (k = current checkbox in column 3)
                            for j = 1:nst % check if connection exists to each checkbox in col 2
                                % (j = some checkbox in col 2)

                                if Bt(k,j) == 1 % if a connection exists...

                                    % starting quiver point coordinates col 3
                                    p1x = xspace(3) - xm;
                                    p1y = (0.85-0.04)/(no+1)*(no+1-k)/ys;

                                    % ending quiver points coordinates col 2
                                    p2x = xspace(2) + xm;
                                    p2y = (0.85-0.04)*(nst+1-j)/((nst+1)*ys);

                                    % calculate quiver positioning
                                    p1 = [p1x p1y];
                                    p2 = [p2x p2y];
                                    dp = p2 - p1;

                                    % draw arrow from col 3 to col 2
                                    quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','r','MaxHeadSize',0.025/norm(dp));

                                    % second column (j = current checkbox in column 2)
                                    for i = 1:nmd % check if connection exists to each checkbox in col 1
                                        % (i = some checkbox in col 1)

                                        if At(j,i) == 1 % if a connection exists...

                                            % starting quiver point coordinates col 2
                                            p1x = xspace(2) - xm;
                                            p1y = (0.85-0.04)/(nst+1)*(nst+1-j)/ys;

                                            % ending quiver points coordinates col 1
                                            p2x = xspace(1) + xm;
                                            p2y = (0.85-0.04)*(nmd+1-i)/((nmd+1)*ys);

                                            % calculate quiver positioning
                                            p1 = [p1x p1y];
                                            p2 = [p2x p2y];
                                            dp = p2 - p1;

                                            % draw arrow from col 3 to col 2
                                            quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','r','MaxHeadSize',0.025/norm(dp));
                                        end
                                    end
                                end
                            end
                        end
                    end
                else
                    % Hide text if this checkbox is not toggled
                    eval(['set(handles.text' num2str(i) ', ''Visible'', ''off'');']);

                    % fourth column (l = current checkbox in column 4)
                    for k = 1:no % check if connection exists to each checkbox in col 3
                        % (k = some checkbox in col 3)

                        if Ct(l,k) == 1 % if a connection exists...

                            % starting quiver point coordinates col 4
                            p1x = xspace(4) - xm;
                            p1y = (0.85-0.04)/(ntc+1)*(ntc+1-l)/ys;

                            % ending quiver points coordinates col 3 
                            p2x = xspace(3) + xm;
                            p2y = (0.85-0.04)*(no+1-k)/((no+1)*ys);

                            % calculate quiver positioning
                            p1 = [p1x p1y];
                            p2 = [p2x p2y];
                            dp = p2 - p1;

                            % draw arrow from col 4 to col 3
                            quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','w','MaxHeadSize',0.025/norm(dp));

                            % third column (k = current checkbox in column 3)
                            for j = 1:nst % check if connection exists to each checkbox in col 2
                                % (j = some checkbox in col 2)

                                if Bt(k,j) == 1 % if a connection exists...

                                    % starting quiver point coordinates col 3
                                    p1x = xspace(3) - xm;
                                    p1y = (0.85-0.04)/(no+1)*(no+1-k)/ys;

                                    % ending quiver points coordinates col 2
                                    p2x = xspace(2) + xm;
                                    p2y = (0.85-0.04)*(nst+1-j)/((nst+1)*ys);

                                    % calculate quiver positioning
                                    p1 = [p1x p1y];
                                    p2 = [p2x p2y];
                                    dp = p2 - p1;

                                    % draw arrow from col 3 to col 2
                                    quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','w','MaxHeadSize',0.025/norm(dp));

                                    % second column (j = current checkbox in column 2)
                                    for i = 1:nmd % check if connection exists to each checkbox in col 1
                                        % (i = some checkbox in col 1)

                                        if At(j,i) == 1 % if a connection exists...

                                            % starting quiver point coordinates col 2
                                            p1x = xspace(2) - xm;
                                            p1y = (0.85-0.04)/(nst+1)*(nst+1-j)/ys;

                                            % ending quiver points coordinates col 1
                                            p2x = xspace(1) + xm;
                                            p2y = (0.85-0.04)*(nmd+1-i)/((nmd+1)*ys);

                                            % calculate quiver positioning
                                            p1 = [p1x p1y];
                                            p2 = [p2x p2y];
                                            dp = p2 - p1;

                                            % draw arrow from col 3 to col 2
                                            quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','w','MaxHeadSize',0.025/norm(dp));
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                
            else % L -> R
                if (get(hObject,'Value') == get(hObject,'Max')) % toggled
                    % Display text if this checkbox is toggled
                    eval(['set(handles.text' num2str(i) ', ''Visible'', ''on'');']);

                    % fourth column (l = current checkbox in column 4)
                    for m = 1:size(D,2) % check if connection exists to each checkbox in col 5
                        % (m = some checkbox in col 5)
                        if D(l,m) == 1 % if a connection exists...

                            % starting quiver point coordinates
                            p1x = xspace(4) + xm;
                            p1y = (0.85-0.04)/(ntc+1)*(ntc+1-l)/ys;

                            % ending quiver points coordinates
                            p2x = xspace(5) - xm;
                            p2y = (0.85-0.04)*(np+1-m)/((np+1)*ys);

                            % calculate quiver positioning
                            p1 = [p1x p1y];
                            p2 = [p2x p2y];
                            dp = p2 - p1;

                            % draw arrow from col 4 to col 5
                            quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','b','MaxHeadSize',0.025/norm(dp));

                            % fifth column (m = current checkbox in column 5)
                            for n = 1:size(E,2) % check if connection exists to each checkbox in col 6
                                % (n = some checkbox in col 6)
                                if E(m,n) == 1 % if a connection exists...

                                    % starting quiver point coordinates
                                    p1x = xspace(5) + xm;
                                    p1y = (0.85-0.04)/(np+1)*(np+1-m)/ys;

                                    % ending quiver points coordinates
                                    p2x = xspace(6) - xm;
                                    p2y = (0.85-0.04)*(npro+1-n)/((npro+1)*ys);

                                    % calculate quiver positioning
                                    p1 = [p1x p1y];
                                    p2 = [p2x p2y];
                                    dp = p2 - p1;

                                    % draw arrow from col 5 to col 6
                                    quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','b','MaxHeadSize',0.025/norm(dp));
                                end
                            end
                        end
                    end
                else
                    % Hide text if this checkbox is not toggled
                    eval(['set(handles.text' num2str(i) ', ''Visible'', ''off'');']);

                    % fourth column (l = current checkbox in column 4)
                    for m = 1:size(D,2) % check if connection exists to each checkbox in col 5
                        % (m = some checkbox in col 5)
                        if D(l,m) == 1 % if a connection exists...
                            
                            % starting quiver point coordinates
                            p1x = xspace(4) + xm;
                            p1y = (0.85-0.04)/(ntc+1)*(ntc+1-l)/ys;

                            % ending quiver points coordinates
                            p2x = xspace(5) - xm;
                            p2y = (0.85-0.04)*(np+1-m)/((np+1)*ys);

                            % calculate quiver positioning
                            p1 = [p1x p1y];
                            p2 = [p2x p2y];
                            dp = p2 - p1;

                            % draw arrow from col 4 to col 5
                            quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','w','MaxHeadSize',0.025/norm(dp));

                            % fifth column (m = current checkbox in column 5)
                            for n = 1:size(E,2) % check if connection exists to each checkbox in col 6
                                % (n = some checkbox in col 6)
                                if E(m,n) == 1 % if a connection exists...

                                    % starting quiver point coordinates
                                    p1x = xspace(5) + xm;
                                    p1y = (0.85-0.04)/(np+1)*(np+1-m)/ys;

                                    % ending quiver points coordinates
                                    p2x = xspace(6) - xm;
                                    p2y = (0.85-0.04)*(npro+1-n)/((npro+1)*ys);

                                    % calculate quiver positioning
                                    p1 = [p1x p1y];
                                    p2 = [p2x p2y];
                                    dp = p2 - p1;

                                    % draw arrow from col 5 to col 6
                                    quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','w','MaxHeadSize',0.025/norm(dp));
                                end
                            end
                        end
                    end
                end
            end
        
        
        case 5 % -------------------------------------------- Fifth column
            % current checkbox in this column
            m = i - nmd - nst - no - ntc;

            if (dir == true) % R -> L
                % Transpose of connection matrices, going right to left
                At = A.'; 
                Bt = B.';
                Ct = C.';
                Dt = D.';

                if (get(hObject,'Value') == get(hObject,'Max')) % toggled
                    % Display text if this checkbox is toggled
                    eval(['set(handles.text' num2str(i) ', ''Visible'', ''on'');']);
                    % fifth column (n = current checkbox in column 5)
                    for l = 1:ntc % check if connection exists to each checkbox in col 4
                        % (l = some checkbox in col 4)

                        if Dt(m,l) == 1 % if a connection exists...

                            % starting quiver point coordinates col 5
                            p1x = xspace(5) - xm;
                            p1y = (0.85-0.04)/(np+1)*(np+1-m)/ys;

                            % ending quiver points coordinates col 4
                            p2x = xspace(4) + xm;
                            p2y = (0.85-0.04)*(ntc+1-l)/((ntc+1)*ys);

                            % calculate quiver positioning
                            p1 = [p1x p1y];
                            p2 = [p2x p2y];
                            dp = p2 - p1;

                            % draw arrow from col 5 to col 4
                            quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','r','MaxHeadSize',0.025/norm(dp));

                            % fourth column (l = current checkbox in column 4)
                            for k = 1:no % check if connection exists to each checkbox in col 3
                                % (k = some checkbox in col 3)

                                if Ct(l,k) == 1 % if a connection exists...

                                    % starting quiver point coordinates col 4
                                    p1x = xspace(4) - xm;
                                    p1y = (0.85-0.04)/(ntc+1)*(ntc+1-l)/ys;

                                    % ending quiver points coordinates col 3 
                                    p2x = xspace(3) + xm;
                                    p2y = (0.85-0.04)*(no+1-k)/((no+1)*ys);

                                    % calculate quiver positioning
                                    p1 = [p1x p1y];
                                    p2 = [p2x p2y];
                                    dp = p2 - p1;

                                    % draw arrow from col 4 to col 3
                                    quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','r','MaxHeadSize',0.025/norm(dp));

                                    % third column (k = current checkbox in column 3)
                                    for j = 1:nst % check if connection exists to each checkbox in col 2
                                        % (j = some checkbox in col 2)

                                        if Bt(k,j) == 1 % if a connection exists...

                                            % starting quiver point coordinates col 3
                                            p1x = xspace(3) - xm;
                                            p1y = (0.85-0.04)/(no+1)*(no+1-k)/ys;

                                            % ending quiver points coordinates col 2
                                            p2x = xspace(2) + xm;
                                            p2y = (0.85-0.04)*(nst+1-j)/((nst+1)*ys);

                                            % calculate quiver positioning
                                            p1 = [p1x p1y];
                                            p2 = [p2x p2y];
                                            dp = p2 - p1;

                                            % draw arrow from col 3 to col 2
                                            quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','r','MaxHeadSize',0.025/norm(dp));

                                            % second column (j = current checkbox in column 2)
                                            for i = 1:nmd % check if connection exists to each checkbox in col 1
                                                % (i = some checkbox in col 1)

                                                if At(j,i) == 1 % if a connection exists...

                                                    % starting quiver point coordinates col 2
                                                    p1x = xspace(2) - xm;
                                                    p1y = (0.85-0.04)/(nst+1)*(nst+1-j)/ys;

                                                    % ending quiver points coordinates col 1
                                                    p2x = xspace(1) + xm;
                                                    p2y = (0.85-0.04)*(nmd+1-i)/((nmd+1)*ys);

                                                    % calculate quiver positioning
                                                    p1 = [p1x p1y];
                                                    p2 = [p2x p2y];
                                                    dp = p2 - p1;

                                                    % draw arrow from col 3 to col 2
                                                    quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','r','MaxHeadSize',0.025/norm(dp));
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                else
                    % Hide text if this checkbox is not toggled
                    eval(['set(handles.text' num2str(i) ', ''Visible'', ''off'');']);

                    % fifth column (n = current checkbox in column 5)
                    for l = 1:ntc % check if connection exists to each checkbox in col 4
                        % (l = some checkbox in col 4)

                        if Dt(m,l) == 1 % if a connection exists...

                            % starting quiver point coordinates col 5
                            p1x = xspace(5) - xm;
                            p1y = (0.85-0.04)/(np+1)*(np+1-m)/ys;

                            % ending quiver points coordinates col 4
                            p2x = xspace(4) + xm;
                            p2y = (0.85-0.04)*(ntc+1-l)/((ntc+1)*ys);

                            % calculate quiver positioning
                            p1 = [p1x p1y];
                            p2 = [p2x p2y];
                            dp = p2 - p1;

                            % draw arrow from col 5 to col 4
                            quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','w','MaxHeadSize',0.025/norm(dp));

                            % fourth column (l = current checkbox in column 4)
                            for k = 1:no % check if connection exists to each checkbox in col 3
                                % (k = some checkbox in col 3)

                                if Ct(l,k) == 1 % if a connection exists...

                                    % starting quiver point coordinates col 4
                                    p1x = xspace(4) - xm;
                                    p1y = (0.85-0.04)/(ntc+1)*(ntc+1-l)/ys;

                                    % ending quiver points coordinates col 3 
                                    p2x = xspace(3) + xm;
                                    p2y = (0.85-0.04)*(no+1-k)/((no+1)*ys);

                                    % calculate quiver positioning
                                    p1 = [p1x p1y];
                                    p2 = [p2x p2y];
                                    dp = p2 - p1;

                                    % draw arrow from col 4 to col 3
                                    quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','w','MaxHeadSize',0.025/norm(dp));

                                    % third column (k = current checkbox in column 3)
                                    for j = 1:nst % check if connection exists to each checkbox in col 2
                                        % (j = some checkbox in col 2)

                                        if Bt(k,j) == 1 % if a connection exists...

                                            % starting quiver point coordinates col 3
                                            p1x = xspace(3) - xm;
                                            p1y = (0.85-0.04)/(no+1)*(no+1-k)/ys;

                                            % ending quiver points coordinates col 2
                                            p2x = xspace(2) + xm;
                                            p2y = (0.85-0.04)*(nst+1-j)/((nst+1)*ys);

                                            % calculate quiver positioning
                                            p1 = [p1x p1y];
                                            p2 = [p2x p2y];
                                            dp = p2 - p1;

                                            % draw arrow from col 3 to col 2
                                            quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','w','MaxHeadSize',0.025/norm(dp));

                                            % second column (j = current checkbox in column 2)
                                            for i = 1:nmd % check if connection exists to each checkbox in col 1
                                                % (i = some checkbox in col 1)

                                                if At(j,i) == 1 % if a connection exists...

                                                    % starting quiver point coordinates col 2
                                                    p1x = xspace(2) - xm;
                                                    p1y = (0.85-0.04)/(nst+1)*(nst+1-j)/ys;

                                                    % ending quiver points coordinates col 1
                                                    p2x = xspace(1) + xm;
                                                    p2y = (0.85-0.04)*(nmd+1-i)/((nmd+1)*ys);

                                                    % calculate quiver positioning
                                                    p1 = [p1x p1y];
                                                    p2 = [p2x p2y];
                                                    dp = p2 - p1;

                                                    % draw arrow from col 3 to col 2
                                                    quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','w','MaxHeadSize',0.025/norm(dp));
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            else % L -> R

                if (get(hObject,'Value') == get(hObject,'Max')) % toggled
                    % Display text if this checkbox is toggled
                    eval(['set(handles.text' num2str(i) ', ''Visible'', ''on'');']);

                    % fifth column (m = current checkbox in column 5)
                    for n = 1:npro % check if connection exists to each checkbox in col 6
                        % (n = some checkbox in col 6)
                        if E(m,n) == 1 % if a connection exists...

                            % starting quiver point coordinates
                            p1x = xspace(5) + xm;
                            p1y = (0.85-0.04)/(np+1)*(np+1-m)/ys;

                            % ending quiver points coordinates
                            p2x = xspace(6) - xm;
                            p2y = (0.85-0.04)*(npro+1-n)/((npro+1)*ys);

                            % calculate quiver positioning
                            p1 = [p1x p1y];
                            p2 = [p2x p2y];
                            dp = p2 - p1;

                            % draw arrow from col 5 to col 6
                            quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','b','MaxHeadSize',0.025/norm(dp));
                        end
                    end

                else
                    % Hide text if this checkbox is not toggled
                    eval(['set(handles.text' num2str(i) ', ''Visible'', ''off'');']);

                    % fifth column (m = current checkbox in column 5)
                    for n = 1:npro % check if connection exists to each checkbox in col 6
                        % (n = some checkbox in col 6)
                        if E(m,n) == 1 % if a connection exists...
                            
                            % starting quiver point coordinates
                            p1x = xspace(5) + xm;
                            p1y = (0.85-0.04)/(np+1)*(np+1-m)/ys;

                            % ending quiver points coordinates
                            p2x = xspace(6) - xm;
                            p2y = (0.85-0.04)*(npro+1-n)/((npro+1)*ys);

                            % calculate quiver positioning
                            p1 = [p1x p1y];
                            p2 = [p2x p2y];
                            dp = p2 - p1;

                            % draw arrow from col 5 to col 6
                            quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','w','MaxHeadSize',0.025/norm(dp));
                        end
                    end
                end
            end
            
            
        case 6 % -------------------------------------------- Sixth column
            % current checkbox in this column
            n = i - nmd - nst - no - ntc - np;

            if (dir == true) % R -> L
                % Transpose of connection matrices, going right to left
                At = A.'; 
                Bt = B.';
                Ct = C.';
                Dt = D.';
                Et = E.';
                
                if (get(hObject,'Value') == get(hObject,'Max')) % toggled
                    % Display text if this checkbox is toggled
                    eval(['set(handles.text' num2str(i) ', ''Visible'', ''on'');']);
                    
                    % sixth column (m = current checkbox in column 6)
                    for m = 1:np % check if connection exists to each checkbox in col 5
                        % (n = some checkbox in col 5)

                        if Et(n,m) == 1 % if a connection exists...
                            
                            % starting quiver point coordinates col 6
                            p1x = xspace(6) - xm;
                            p1y = (0.85-0.04)/(npro+1)*(npro+1-n)/ys;

                            % ending quiver points coordinates col 5
                            p2x = xspace(5) + xm;
                            p2y = (0.85-0.04)*(np+1-m)/((np+1)*ys);

                            % calculate quiver positioning
                            p1 = [p1x p1y];
                            p2 = [p2x p2y];
                            dp = p2 - p1;

                            % draw arrow from col 6 to col 5
                            quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','r','MaxHeadSize',0.025/norm(dp));

                            % fifth column (n = current checkbox in column 5)
                            for l = 1:ntc % check if connection exists to each checkbox in col 4
                                % (l = some checkbox in col 4)

                                if Dt(m,l) == 1 % if a connection exists...

                                    % starting quiver point coordinates col 5
                                    p1x = xspace(5) - xm;
                                    p1y = (0.85-0.04)/(np+1)*(np+1-m)/ys;

                                    % ending quiver points coordinates col 4
                                    p2x = xspace(4) + xm;
                                    p2y = (0.85-0.04)*(ntc+1-l)/((ntc+1)*ys);

                                    % calculate quiver positioning
                                    p1 = [p1x p1y];
                                    p2 = [p2x p2y];
                                    dp = p2 - p1;

                                    % draw arrow from col 5 to col 4
                                    quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','r','MaxHeadSize',0.025/norm(dp));

                                    % fourth column (l = current checkbox in column 4)
                                    for k = 1:no % check if connection exists to each checkbox in col 3
                                        % (k = some checkbox in col 3)

                                        if Ct(l,k) == 1 % if a connection exists...

                                            % starting quiver point coordinates col 4
                                            p1x = xspace(4) - xm;
                                            p1y = (0.85-0.04)/(ntc+1)*(ntc+1-l)/ys;

                                            % ending quiver points coordinates col 3 
                                            p2x = xspace(3) + xm;
                                            p2y = (0.85-0.04)*(no+1-k)/((no+1)*ys);

                                            % calculate quiver positioning
                                            p1 = [p1x p1y];
                                            p2 = [p2x p2y];
                                            dp = p2 - p1;

                                            % draw arrow from col 4 to col 3
                                            quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','r','MaxHeadSize',0.025/norm(dp));

                                            % third column (k = current checkbox in column 3)
                                            for j = 1:nst % check if connection exists to each checkbox in col 2
                                                % (j = some checkbox in col 2)

                                                if Bt(k,j) == 1 % if a connection exists...

                                                    % starting quiver point coordinates col 3
                                                    p1x = xspace(3) - xm;
                                                    p1y = (0.85-0.04)/(no+1)*(no+1-k)/ys;

                                                    % ending quiver points coordinates col 2
                                                    p2x = xspace(2) + xm;
                                                    p2y = (0.85-0.04)*(nst+1-j)/((nst+1)*ys);

                                                    % calculate quiver positioning
                                                    p1 = [p1x p1y];
                                                    p2 = [p2x p2y];
                                                    dp = p2 - p1;

                                                    % draw arrow from col 3 to col 2
                                                    quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','r','MaxHeadSize',0.025/norm(dp));

                                                    % second column (j = current checkbox in column 2)
                                                    for i = 1:nmd % check if connection exists to each checkbox in col 1
                                                        % (i = some checkbox in col 1)

                                                        if At(j,i) == 1 % if a connection exists...

                                                            % starting quiver point coordinates col 2
                                                            p1x = xspace(2) - xm;
                                                            p1y = (0.85-0.04)/(nst+1)*(nst+1-j)/ys;

                                                            % ending quiver points coordinates col 1
                                                            p2x = xspace(1) + xm;
                                                            p2y = (0.85-0.04)*(nmd+1-i)/((nmd+1)*ys);

                                                            % calculate quiver positioning
                                                            p1 = [p1x p1y];
                                                            p2 = [p2x p2y];
                                                            dp = p2 - p1;

                                                            % draw arrow from col 3 to col 2
                                                            quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','r','MaxHeadSize',0.025/norm(dp));
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                    
                else
                    % Hide text if this checkbox is not toggled
                    eval(['set(handles.text' num2str(i) ', ''Visible'', ''off'');']);
                    
                    % sixth column (m = current checkbox in column 6)
                    for m = 1:np % check if connection exists to each checkbox in col 5
                        % (n = some checkbox in col 5)

                        if Et(n,m) == 1 % if a connection exists...

                            % starting quiver point coordinates col 6
                            p1x = xspace(6) - xm;
                            p1y = (0.85-0.04)/(npro+1)*(npro+1-n)/ys;

                            % ending quiver points coordinates col 5
                            p2x = xspace(5) + xm;
                            p2y = (0.85-0.04)*(np+1-m)/((np+1)*ys);

                            % calculate quiver positioning
                            p1 = [p1x p1y];
                            p2 = [p2x p2y];
                            dp = p2 - p1;

                            % draw arrow from col 6 to col 5
                            quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','w','MaxHeadSize',0.025/norm(dp));

                            % fifth column (n = current checkbox in column 5)
                            for l = 1:ntc % check if connection exists to each checkbox in col 4
                                % (l = some checkbox in col 4)

                                if Dt(m,l) == 1 % if a connection exists...

                                    % starting quiver point coordinates col 5
                                    p1x = xspace(5) - xm;
                                    p1y = (0.85-0.04)/(np+1)*(np+1-m)/ys;

                                    % ending quiver points coordinates col 4
                                    p2x = xspace(4) + xm;
                                    p2y = (0.85-0.04)*(ntc+1-l)/((ntc+1)*ys);

                                    % calculate quiver positioning
                                    p1 = [p1x p1y];
                                    p2 = [p2x p2y];
                                    dp = p2 - p1;

                                    % draw arrow from col 5 to col 4
                                    quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','w','MaxHeadSize',0.025/norm(dp));

                                    % fourth column (l = current checkbox in column 4)
                                    for k = 1:no % check if connection exists to each checkbox in col 3
                                        % (k = some checkbox in col 3)

                                        if Ct(l,k) == 1 % if a connection exists...

                                            % starting quiver point coordinates col 4
                                            p1x = xspace(4) - xm;
                                            p1y = (0.85-0.04)/(ntc+1)*(ntc+1-l)/ys;

                                            % ending quiver points coordinates col 3 
                                            p2x = xspace(3) + xm;
                                            p2y = (0.85-0.04)*(no+1-k)/((no+1)*ys);

                                            % calculate quiver positioning
                                            p1 = [p1x p1y];
                                            p2 = [p2x p2y];
                                            dp = p2 - p1;

                                            % draw arrow from col 4 to col 3
                                            quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','w','MaxHeadSize',0.025/norm(dp));

                                            % third column (k = current checkbox in column 3)
                                            for j = 1:nst % check if connection exists to each checkbox in col 2
                                                % (j = some checkbox in col 2)

                                                if Bt(k,j) == 1 % if a connection exists...

                                                    % starting quiver point coordinates col 3
                                                    p1x = xspace(3) - xm;
                                                    p1y = (0.85-0.04)/(no+1)*(no+1-k)/ys;

                                                    % ending quiver points coordinates col 2
                                                    p2x = xspace(2) + xm;
                                                    p2y = (0.85-0.04)*(nst+1-j)/((nst+1)*ys);

                                                    % calculate quiver positioning
                                                    p1 = [p1x p1y];
                                                    p2 = [p2x p2y];
                                                    dp = p2 - p1;

                                                    % draw arrow from col 3 to col 2
                                                    quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','w','MaxHeadSize',0.025/norm(dp));

                                                    % second column (j = current checkbox in column 2)
                                                    for i = 1:nmd % check if connection exists to each checkbox in col 1
                                                        % (i = some checkbox in col 1)

                                                        if At(j,i) == 1 % if a connection exists...

                                                            % starting quiver point coordinates col 2
                                                            p1x = xspace(2) - xm;
                                                            p1y = (0.85-0.04)/(nst+1)*(nst+1-j)/ys;

                                                            % ending quiver points coordinates col 1
                                                            p2x = xspace(1) + xm;
                                                            p2y = (0.85-0.04)*(nmd+1-i)/((nmd+1)*ys);

                                                            % calculate quiver positioning
                                                            p1 = [p1x p1y];
                                                            p2 = [p2x p2y];
                                                            dp = p2 - p1;

                                                            % draw arrow from col 3 to col 2
                                                            quiver(h1,p1(1),p1(2),dp(1),dp(2),0,'Color','w','MaxHeadSize',0.025/norm(dp));
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                
            else % L -> R
                if (get(hObject,'Value') == get(hObject,'Max')) % toggled
                    
                    % Display text if this checkbox is toggled
                    eval(['set(handles.text' num2str(i) ', ''Visible'', ''on'');']);
                    
                else
                    
                    % Hide text if this checkbox is not toggled
                    eval(['set(handles.text' num2str(i) ', ''Visible'', ''off'');']);
                end

            end
            
    end
    
end



%% ---------------------------- COLUMN CHECKBOX ----------------------------%
% Callback to the column header checkboxes.
%  Determines the column number of the toggled checkbox and opens all the
%   textboxes of that column. Also hides them when unchecked.
function checkboxcol_Callback(hObject, eventdata, handles)
    %% -------------------------- INITIALIZE -------------------------------%
    % h = current handle object, str is the tag = 'checkboxi'
    % i stores the number of the checkbox.
    h = gcbo;
    str = h.Tag;
    col_num = sscanf(str,'checkboxcol%d');
    
    % nmd:  number of items in column 1
    % nst:  number of items in column 2
    % no:   number of items in column 3
    % ntc:  number of items in column 4
    % np:   number of items in column 5
    % npro: number of items in column 6
    nmd  = handles.allvariables{6}(:,:);
    nst  = handles.allvariables{7}(:,:);
    no   = handles.allvariables{8}(:,:);
    ntc  = handles.allvariables{9}(:,:);
    np   = handles.allvariables{10}(:,:);
    npro = handles.allvariables{11}(:,:);
    
    
    %% --------------------------- OPEN/CLEAR LABELS -----------------------%
    % Open labels on each column.
    switch col_num
        
        % column 1
        case 1
            for i = 1:nmd
                if (get(hObject,'Value') == get(hObject,'Max'))
                    % Display text if this checkbox is toggled
                    eval(['set(handles.text' num2str(i) ', ''Visible'', ''on'');']);
                else
                    % Hide text if this checkbox is not toggled
                    eval(['set(handles.text' num2str(i) ', ''Visible'', ''off'');']);
                end
            end
            
        
        % column 2
        case 2
            for i = 1+nmd : nmd+nst
                if (get(hObject,'Value') == get(hObject,'Max'))
                    % Display text if this checkbox is toggled
                    eval(['set(handles.text' num2str(i) ', ''Visible'', ''on'');']);
                else
                    % Hide text if this checkbox is not toggled
                    eval(['set(handles.text' num2str(i) ', ''Visible'', ''off'');']);
                end
            end
        
            
        % column 3
        case 3
            for i = 1+nmd+nst : nmd+nst+no
                if (get(hObject,'Value') == get(hObject,'Max'))
                    % Display text if this checkbox is toggled
                    eval(['set(handles.text' num2str(i) ', ''Visible'', ''on'');']);
                else
                    % Hide text if this checkbox is not toggled
                    eval(['set(handles.text' num2str(i) ', ''Visible'', ''off'');']);
                end
            end
        
            
        % column 4
        case 4
            for i = 1+nmd+nst+no : nmd+nst+no+ntc
                if (get(hObject,'Value') == get(hObject,'Max'))
                    % Display text if this checkbox is toggled
                    eval(['set(handles.text' num2str(i) ', ''Visible'', ''on'');']);
                else
                    % Hide text if this checkbox is not toggled
                    eval(['set(handles.text' num2str(i) ', ''Visible'', ''off'');']);
                end
            end
        
            
        % column 5
        case 5
            for i = 1+nmd+nst+no+ntc : nmd+nst+no+ntc+np
                if (get(hObject,'Value') == get(hObject,'Max'))
                    % Display text if this checkbox is toggled
                    eval(['set(handles.text' num2str(i) ', ''Visible'', ''on'');']);
                else
                    % Hide text if this checkbox is not toggled
                    eval(['set(handles.text' num2str(i) ', ''Visible'', ''off'');']);
                end
            end
        
            
        % column 6
        case 6
            for i = 1+nmd+nst+no+ntc+np : nmd+nst+no+ntc+np+npro
                if (get(hObject,'Value') == get(hObject,'Max'))
                    % Display text if this checkbox is toggled
                    eval(['set(handles.text' num2str(i) ', ''Visible'', ''on'');']);
                else
                    % Hide text if this checkbox is not toggled
                    eval(['set(handles.text' num2str(i) ', ''Visible'', ''off'');']);
                end
            end
            
    end
end



%% ----------------------------- NEW WINDOW BUTTON -------------------------%
% Closes and reopens the GUI.
% Could be converted to a reset button (uncheck all boxes, hide labels,
%  etc.)
function pushbutton2_Callback(hObject, eventdata, handles)
    % get the handle of figure and close it (close program)
    close(gcbf)
    % reopen program
    SSPVRUN_2_v2
end


