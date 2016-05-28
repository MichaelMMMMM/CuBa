function varargout = CuBa_Configuration(varargin)
% CUBA_CONFIGURATION MATLAB code for CuBa_Configuration.fig
%      CUBA_CONFIGURATION, by itself, creates a new CUBA_CONFIGURATION or raises the existing
%      singleton*.
%
%      H = CUBA_CONFIGURATION returns the handle to a new CUBA_CONFIGURATION or the handle to
%      the existing singleton*.
%
%      CUBA_CONFIGURATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CUBA_CONFIGURATION.M with the given input arguments.
%
%      CUBA_CONFIGURATION('Property','Value',...) creates a new CUBA_CONFIGURATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CuBa_Configuration_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CuBa_Configuration_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CuBa_Configuration

% Last Modified by GUIDE v2.5 25-May-2016 10:43:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CuBa_Configuration_OpeningFcn, ...
                   'gui_OutputFcn',  @CuBa_Configuration_OutputFcn, ...
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



% --- Executes just before CuBa_Configuration is made visible.
function CuBa_Configuration_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CuBa_Configuration (see VARARGIN)

% Choose default command line output for CuBa_Configuration
handles.output = hObject;

% Update handles structure
handles.CuBa = varargin{1};
guidata(hObject, handles);
handles.timer = timer('ExecutionMode', 'fixedRate',...
                      'Period', 0.01, ...
                      'TimerFcn', {@timerCallback, hObject});
start(handles.timer);
guidata(hObject, handles);


function timerCallback(hObject,eventdata,hfigure)
    handles = guidata(hfigure);
    handles.CuBa.pollCOM();

% UIWAIT makes CuBa_Configuration wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CuBa_Configuration_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function jumpVelocityInput_Callback(hObject, eventdata, handles)
% hObject    handle to jumpVelocityInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of jumpVelocityInput as text
%        str2double(get(hObject,'String')) returns contents of jumpVelocityInput as a double


% --- Executes during object creation, after setting all properties.
function jumpVelocityInput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to jumpVelocityInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in jumpVelocityUpdateButton.
function jumpVelocityUpdateButton_Callback(hObject, eventdata, handles)
    velocity = str2num(handles.jumpVelocityInput.String);
    if(size(velocity,1) == 1)
        handles.CuBa.setJumpVelocity(velocity);
        handles.jumpVelocityInput.ForegroundColor = [0 0 0];
    else
        handles.jumpVelocityInput.ForegroundColor = [1 0 0];
    end
% hObject    handle to jumpVelocityUpdateButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function pValueInput_Callback(hObject, eventdata, handles)
% hObject    handle to pValueInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pValueInput as text
%        str2double(get(hObject,'String')) returns contents of pValueInput as a double


% --- Executes during object creation, after setting all properties.
function pValueInput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pValueInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pValueUpdateButton.
function pValueUpdateButton_Callback(hObject, eventdata, handles)
    pValue = str2num(handles.pValueInput.String);
    if(size(pValue,1) == 1)
        handles.CuBa.setPID_P_Value(pValue);
        handles.pValueInput.ForegroundColor = [0 0 0];
    else
        handles.pValueInput.ForegroundColor = [1 0 0];
    end
% hObject    handle to pValueUpdateButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function iValueInput_Callback(hObject, eventdata, handles)
% hObject    handle to iValueInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of iValueInput as text
%        str2double(get(hObject,'String')) returns contents of iValueInput as a double


% --- Executes during object creation, after setting all properties.
function iValueInput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to iValueInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in iValueUpdateButton.
function iValueUpdateButton_Callback(hObject, eventdata, handles)
    iValue = str2num(handles.iValueInput.String);
    if(size(iValue,1) == 1)
        handles.CuBa.setPID_I_Value(iValue);
        handles.iValueInput.ForegroundColor = [0 0 0];
    else
        handles.iValueInput.ForegroundColor = [1 0 0];
    end
% hObject    handle to iValueUpdateButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function dValueInput_Callback(hObject, eventdata, handles)
% hObject    handle to dValueInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dValueInput as text
%        str2double(get(hObject,'String')) returns contents of dValueInput as a double


% --- Executes during object creation, after setting all properties.
function dValueInput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dValueInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in dValueUpdateButton.
function dValueUpdateButton_Callback(hObject, eventdata, handles)
    dValue = str2num(handles.dValueInput.String);
    if(size(dValue,1) == 1)
        handles.CuBa.setPID_D_Value(dValue);
        handles.dValueInput.ForegroundColor = [0 0 0];
    else
        handles.dValueInput.ForegroundColor = [1 0 0];
    end
% hObject    handle to dValueUpdateButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in transmitFlagCheckbox.
function transmitFlagCheckbox_Callback(hObject, eventdata, handles)
    handles.CuBa.setTransmitFlag(handles.transmitFlagCheckbox.Value);
% hObject    handle to transmitFlagCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of transmitFlagCheckbox


% --- Executes on button press in jumpFlagCheckbox.
function jumpFlagCheckbox_Callback(hObject, eventdata, handles)
    handles.CuBa.setJumpFlag(handles.jumpFlagCheckbox.Value);
% hObject    handle to jumpFlagCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of jumpFlagCheckbox


% --- Executes on button press in balanceFlagCheckbox.
function balanceFlagCheckbox_Callback(hObject, eventdata, handles)
    handles.CuBa.setBalanceFlag(handles.balanceFlagCheckbox.Value);
% hObject    handle to balanceFlagCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of balanceFlagCheckbox


% --- Executes on button press in startButton.
function startButton_Callback(hObject, eventdata, handles)
    handles.CuBa.start();
    CuBa = handles.CuBa;
    CuBa_Running(CuBa);
    close(handles.figure1);

% hObject    handle to startButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
