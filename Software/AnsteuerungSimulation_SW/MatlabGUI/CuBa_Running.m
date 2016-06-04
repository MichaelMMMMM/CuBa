function varargout = CuBa_Running(varargin)
% CUBA_RUNNING MATLAB code for CuBa_Running.fig
%      CUBA_RUNNING, by itself, creates a new CUBA_RUNNING or raises the existing
%      singleton*.
%
%      H = CUBA_RUNNING returns the handle to a new CUBA_RUNNING or the handle to
%      the existing singleton*.
%
%      CUBA_RUNNING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CUBA_RUNNING.M with the given input arguments.
%
%      CUBA_RUNNING('Property','Value',...) creates a new CUBA_RUNNING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CuBa_Running_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CuBa_Running_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CuBa_Running

% Last Modified by GUIDE v2.5 25-May-2016 12:48:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CuBa_Running_OpeningFcn, ...
                   'gui_OutputFcn',  @CuBa_Running_OutputFcn, ...
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


% --- Executes just before CuBa_Running is made visible.
function CuBa_Running_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CuBa_Running (see VARARGIN)

% Choose default command line output for CuBa_Running
handles.output = hObject;
handles.CuBa   = varargin{1};
guidata(hObject, handles);
plot(handles.phiKPlot, handles.CuBa.mPhiKTime, handles.CuBa.mPhiKValues);
grid(handles.phiKPlot, 'on');
xlabel(handles.phiKPlot, 'Zeit in Sekunden');
ylabel(handles.phiKPlot, '\phi_K in Grad');
plot(handles.phiKDPlot, handles.CuBa.mPhiKDTime, handles.CuBa.mPhiKDValues);
grid(handles.phiKDPlot, 'on');
xlabel(handles.phiKDPlot, 'Zeit in Sekunden');
ylabel(handles.phiKDPlot, '\phi_D_K in Grad/Sekunde');
plot(handles.phiRDPlot, handles.CuBa.mPhiRDTime, handles.CuBa.mPhiRDValues);
grid(handles.phiRDPlot, 'on');
xlabel(handles.phiRDPlot, 'Zeit in Sekunden');
ylabel(handles.phiRDPlot, '\phi_D_R in Grad/Sekunde');
plot(handles.TMPlot, handles.CuBa.mTMTime, handles.CuBa.mTMValues);
grid(handles.TMPlot, 'on');
xlabel(handles.TMPlot, 'Zeit in Sekunden');
ylabel(handles.TMPlot, 'Motormoment in mNm');
guidata(hObject, handles);
handles.timer = timer('ExecutionMode', 'fixedRate',...
                      'Period', 0.01, ...
                      'TimerFcn', {@timerCallback, hObject});
guidata(hObject, handles);
start(handles.timer);


function timerCallback(hObject,eventdata,hfigure)
    handles = guidata(hfigure);
    handles.CuBa.pollCOM();
    handles.currentStateOutput.String = char(EState(handles.CuBa.mState));
    handles.currentSubstateOutput.String = char(EState(handles.CuBa.mSubstate));
    handles.phiKPlot.Children.XData = handles.CuBa.mPhiKTime;
    handles.phiKPlot.Children.YData = radtodeg(handles.CuBa.mPhiKValues);
    handles.phiKDPlot.Children.XData = handles.CuBa.mPhiKDTime;
    handles.phiKDPlot.Children.YData = radtodeg(handles.CuBa.mPhiKDValues);
    handles.phiRDPlot.Children.XData = handles.CuBa.mPhiRDTime;
    handles.phiRDPlot.Children.YData = radtodeg(handles.CuBa.mPhiRDValues);
    handles.TMPlot.Children.XData = handles.CuBa.mTMTime;
    handles.TMPlot.Children.YData = (handles.CuBa.mTMValues);

% UIWAIT makes CuBa_Running wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CuBa_Running_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in stopButton.
function stopButton_Callback(hObject, eventdata, handles)
    handles.CuBa.stop();
    CuBa_Configuration(handles.CuBa);
    close(handles.figure1);
% hObject    handle to stopButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in jumpButton.
function jumpButton_Callback(hObject, eventdata, handles)
    handles.CuBa.jumpCommand();
% hObject    handle to jumpButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
