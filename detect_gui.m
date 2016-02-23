function varargout = detect_gui(varargin)
% DETECT_GUI MATLAB code for detect_gui.fig
%      DETECT_GUI, by itself, creates a new DETECT_GUI or raises the existing
%      singleton*.
%
%      H = DETECT_GUI returns the handle to a new DETECT_GUI or the handle to
%      the existing singleton*.
%
%      DETECT_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DETECT_GUI.M with the given input arguments.
%
%      DETECT_GUI('Property','Value',...) creates a new DETECT_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before detect_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to detect_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help detect_gui

% Last Modified by GUIDE v2.5 24-Feb-2016 02:38:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @detect_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @detect_gui_OutputFcn, ...
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


% --- Executes just before detect_gui is made visible.
function detect_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to detect_gui (see VARARGIN)

% Choose default command line output for detect_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes detect_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = detect_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in buttonDetect.
function buttonDetect_Callback(hObject, eventdata, handles)
% hObject    handle to buttonDetect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if(isfield(handles,'img')),
    boxes = acfDetect(handles.img,handles.detector);
    axes(handles.axeImage);
    imshow(handles.img);
    bbApply('draw',boxes);
    set(handles.textDetectRes,'String',['Person  :  ' num2str(size(boxes,1))]);
end



function editPath_Callback(hObject, eventdata, handles)
% hObject    handle to editPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editPath as text
%        str2double(get(hObject,'String')) returns contents of editPath as a double
handles.imgFullPath = get(hObject,'String');
[pathname,filename,ext] = fileparts(handles.imgFullPath);
handles.imgName = [filename ext];
handles.pathName= pathname;
if(~exist(handles.imgFullPath,'file') || ~(strcmp(ext,'.jpg') || strcmp(ext,'.png')))
    disp('Error image path');
    return;
end

handles = initDirInfo(handles);
disp(handles.curIdx);

handles.img = imread(handles.imgFullPath);
axes(handles.axeImage);
imshow(handles.img);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function editPath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in buttonSelectFile.
function buttonSelectFile_Callback(hObject, eventdata, handles)
% hObject    handle to buttonSelectFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.imgName, handles.pathName] = uigetfile({'*.jpg','all jpg (*.jpg)';'*.png','all png (*.png)';'*.*','all file(*.*)'}, 'Pick A file');
filename = handles.imgName;
pathname =  handles.pathName;
handles.imgFullPath = [pathname filename];

handles = initDirInfo(handles);
disp(handles.curIdx);

set(handles.editPath,'String',handles.imgFullPath);
handles.img = imread(handles.imgFullPath);
axes(handles.axeImage);
imshow(handles.img);
guidata(hObject, handles);

% --- Executes on button press in buttonNext.
function buttonNext_Callback(hObject, eventdata, handles)
% hObject    handle to buttonNext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if(isfield(handles,'curIdx')),
    handles.curIdx = handles.curIdx+1;
    if(handles.curIdx<=size(handles.allFiles,1))
        handles.imgName = handles.allFiles(handles.curIdx).name;
        handles.imgFullPath = [handles.pathName filesep handles.imgName];
        set(handles.editPath,'String',handles.imgFullPath);
        handles.img = imread(handles.imgFullPath);
    else
        handles.curIdx = handles.curIdx-1;
    end
    boxes = acfDetect(handles.img,handles.detector);
    axes(handles.axeImage);
    imshow(handles.img);
    bbApply('draw',boxes);
    set(handles.textDetectRes,'String',['Person  :  ' num2str(size(boxes,1))]);
    guidata(hObject, handles);
end


% --- Executes during object creation, after setting all properties.
function buttonDetect_CreateFcn(hObject, eventdata, handles)
% hObject    handle to buttonDetect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
classifierModel = './detector/models/AcfInriaDetector.mat';
load(classifierModel);
handles.detector = detector;
guidata(hObject, handles);

% init the folder all files and store current image idx
function handles = initDirInfo(handles)
    [~,~,ext] = fileparts(handles.imgFullPath);
    handles.allFiles = dir([handles.pathName filesep '*' ext]);
    for i=1:size(handles.allFiles,1)
        if(strcmp(handles.allFiles(i).name,handles.imgName)),
            handles.curIdx = i;
        end
    end


% --- Executes on button press in buttonPrev.
function buttonPrev_Callback(hObject, eventdata, handles)
% hObject    handle to buttonPrev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(isfield(handles,'curIdx')),
    handles.curIdx = handles.curIdx-1;
    if(handles.curIdx>=1)
        handles.imgName = handles.allFiles(handles.curIdx).name;
        handles.imgFullPath = [handles.pathName filesep handles.imgName];
        set(handles.editPath,'String',handles.imgFullPath);
        handles.img = imread(handles.imgFullPath);
    else
        handles.curIdx = handles.curIdx+1;
    end
    boxes = acfDetect(handles.img,handles.detector);
    axes(handles.axeImage);
    imshow(handles.img);
    bbApply('draw',boxes);
    set(handles.textDetectRes,'String',['Person  :  ' num2str(size(boxes,1))]);
    guidata(hObject, handles);
end

