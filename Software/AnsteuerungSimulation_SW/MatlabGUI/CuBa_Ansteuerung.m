function varargout = CuBa_Ansteuerung(varargin)
% CUBA_ANSTEUERUNG MATLAB code for CuBa_Ansteuerung.fig
%      CUBA_ANSTEUERUNG, by itself, creates a new CUBA_ANSTEUERUNG or raises the existing
%      singleton*.
%
%      H = CUBA_ANSTEUERUNG returns the handle to a new CUBA_ANSTEUERUNG or the handle to
%      the existing singleton*.
%
%      CUBA_ANSTEUERUNG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CUBA_ANSTEUERUNG.M with the given input arguments.
%
%      CUBA_ANSTEUERUNG('Property','Value',...) creates a new CUBA_ANSTEUERUNG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CuBa_Ansteuerung_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CuBa_Ansteuerung_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CuBa_Ansteuerung

% Last Modified by GUIDE v2.5 24-May-2016 19:48:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CuBa_Ansteuerung_OpeningFcn, ...
                   'gui_OutputFcn',  @CuBa_Ansteuerung_OutputFcn, ...
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


% --- Executes just before CuBa_Ansteuerung is made visible.
function CuBa_Ansteuerung_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CuBa_Ansteuerung (see VARARGIN)

% Choose default command line output for CuBa_Ansteuerung
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CuBa_Ansteuerung wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CuBa_Ansteuerung_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function COMInput_Callback(hObject, eventdata, handles)
% hObject    handle to COMInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of COMInput as text
%        str2double(get(hObject,'String')) returns contents of COMInput as a double


% --- Executes during object creation, after setting all properties.
function COMInput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to COMInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in okButton.
function okButton_Callback(hObject, eventdata, handles)
    import CCuBaControl
    comPort = handles.COMInput.String;
    serialInterface = serial(comPort, 'Terminator', '');
    CuBa = CCuBaControl(serialInterface);
    CuBa_Configuration(CuBa);
    close(handles.figure1);
% hObject    handle to okButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
