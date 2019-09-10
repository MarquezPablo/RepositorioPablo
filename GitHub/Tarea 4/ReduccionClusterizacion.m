function varargout = ReduccionClusterizacion(varargin)
% REDUCCIONCLUSTERIZACION MATLAB code for ReduccionClusterizacion.fig
%      REDUCCIONCLUSTERIZACION, by itself, creates a new REDUCCIONCLUSTERIZACION or raises the existing
%      singleton*.
%
%      H = REDUCCIONCLUSTERIZACION returns the handle to a new REDUCCIONCLUSTERIZACION or the handle to
%      the existing singleton*.
%
%      REDUCCIONCLUSTERIZACION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REDUCCIONCLUSTERIZACION.M with the given input arguments.
%
%      REDUCCIONCLUSTERIZACION('Property','Value',...) creates a new REDUCCIONCLUSTERIZACION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ReduccionClusterizacion_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ReduccionClusterizacion_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ReduccionClusterizacion

% Last Modified by GUIDE v2.5 10-Sep-2019 12:56:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ReduccionClusterizacion_OpeningFcn, ...
                   'gui_OutputFcn',  @ReduccionClusterizacion_OutputFcn, ...
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


% --- Executes just before ReduccionClusterizacion is made visible.
function ReduccionClusterizacion_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ReduccionClusterizacion (see VARARGIN)

% Choose default command line output for ReduccionClusterizacion
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ReduccionClusterizacion wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ReduccionClusterizacion_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function InputReduccion_Callback(hObject, eventdata, handles)
% hObject    handle to InputReduccion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
inputReduccion = str2double(get(hObject,'String'));
if inputReduccion<1 || inputReduccion>2
    disp('Elige un numero entre 1 y 2')
end
set(hObject,'String',inputReduccion)
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of InputReduccion as text
%        str2double(get(hObject,'String')) returns contents of InputReduccion as a double


% --- Executes during object creation, after setting all properties.
function InputReduccion_CreateFcn(hObject, eventdata, handles)
% hObject    handle to InputReduccion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function InputCluster_Callback(hObject, eventdata, handles)
% hObject    handle to InputCluster (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
inputcluster = str2double(get(hObject,'String'));
if inputcluster<1 || inputcluster>2
    disp('Elige un numero entre 1 y 2')
end
set(hObject,'String',inputcluster)
guidata(hObject, handles);

% Hints: get(hObject,'String') returns contents of InputCluster as text
%        str2double(get(hObject,'String')) returns contents of InputCluster as a double


% --- Executes during object creation, after setting all properties.
function InputCluster_CreateFcn(hObject, eventdata, handles)
% hObject    handle to InputCluster (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function nombreArchivo_Callback(hObject, eventdata, handles)
% hObject    handle to nombreArchivo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
inputArchivo =get(hObject,'String');
set(hObject,'String',inputArchivo)
guidata(hObject, handles);

% Hints: get(hObject,'String') returns contents of nombreArchivo as text
%        str2double(get(hObject,'String')) returns contents of nombreArchivo as a double


% --- Executes during object creation, after setting all properties.
function nombreArchivo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nombreArchivo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function InputVariable_Callback(hObject, eventdata, handles)
% hObject    handle to InputVariable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
inputVariable=get(hObject,'string');
set(hObject,'String',inputVariable)
guidata(hObject, handles);

% Hints: get(hObject,'String') returns contents of InputVariable as text
%        str2double(get(hObject,'String')) returns contents of InputVariable as a double


% --- Executes during object creation, after setting all properties.
function InputVariable_CreateFcn(hObject, eventdata, handles)
% hObject    handle to InputVariable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in CorrerFuncion.
function CorrerFuncion_Callback(hObject, eventdata, handles)
% hObject    handle to CorrerFuncion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load(get(handles.nombreArchivo,'String'))
a=get(handles.InputReduccion,'String');
b=get(handles.InputCluster,'String');
c=get(handles.InputVariable,'String');
ReduccionCluster(eval(c),str2double(a),str2double(b));
