% ----------------------------------------------------------------------------------------------------------
% Created as part of TACTICS v2.x Toolbox under BSD License
% TACTICS (Totally Automated Cell Tracking In Confinement Systems) is a Matlab toolbox for High Content Analysis (HCA) of fluorescence tagged proteins organization within tracked cells. It designed to provide a platform for analysis of Multi-Channel Single-Cell Tracking and High-Trough Output Quantification of Imaged lymphocytes in Microfabricated grids arrays.
% We wish to make TACTICS V2.x available, in executable form, free for academic research use distributed under BSD License.
% IN ADDITION, SINCE TACTICS USE THIRD OPEN-CODE LIBRARY (I.E TRACKING ALGORITHEMS, FILTERS, GUI TOOLS, ETC) APPLICABLE ACKNOLEDMENTS HAVE TO BE SAVED TO ITS AUTHORS.
% ----------------------------------------------------------------------------------------------------------
% Copyright (c) 2010-2013, Raz Shimoni
% All rights reserved.
% Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
% Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
% Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE
% ----------------------------------------------------------------------------------------------------------
%
% NOTES-
% Although TACTICS is free it does require Matlab commercial license.
% We do not expect co-authorship for any use of TACTICS. However, we would appreciate if TACTICS would be mentioned in the acknowledgments when it used for publications and/or including the next citation: [enter our Bioinformatics]
% We are looking for collaborations and wiling to setup new components customized by the requirements in exchange to co-authorship.
%  Support and feedbacks
% TACTICS is supported trough Matlab file exchange forums or contact us directly. Updates are expected regularly. We are happy to accept any suggestions to improve the automation capability and the quality of the analysis.
%
% For more information please contact:
% Centre for Micro-Photonics (CMP)
% The Faculty of Engineering and Industrial Sciences (FEIS)
% Swinburne University of Technology, Melbourne, Australia
% URL: http://www.swinburne.edu.au/engineering/cmp/
% Email: RShimoni@groupwise.swin.edu.au
% ----------------------------------------------------------------------------------------------------------
% Note for developers- Future version will include better structure and documentation.
% Sorrry, Raz.
% Code starts here:
function varargout = select_cell_lineage_GUI(varargin)
% SELECT_CELL_LINEAGE_GUI MATLAB code for select_cell_lineage_GUI.fig
%      SELECT_CELL_LINEAGE_GUI, by itself, creates a new SELECT_CELL_LINEAGE_GUI or raises the existing
%      singleton*.
%
%      H = SELECT_CELL_LINEAGE_GUI returns the handle to a new SELECT_CELL_LINEAGE_GUI or the handle to
%      the existing singleton*.
%
%      SELECT_CELL_LINEAGE_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SELECT_CELL_LINEAGE_GUI.M with the given input arguments.
%
%      SELECT_CELL_LINEAGE_GUI('Property','Value',...) creates a new SELECT_CELL_LINEAGE_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before select_cell_lineage_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to select_cell_lineage_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help select_cell_lineage_GUI

% Last Modified by GUIDE v2.5 09-Jan-2013 23:07:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @select_cell_lineage_GUI_OpeningFcn, ...
    'gui_OutputFcn',  @select_cell_lineage_GUI_OutputFcn, ...
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


% --- Executes just before select_cell_lineage_GUI is made visible.
function select_cell_lineage_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to h_cell_lineage_window.Untitled_1
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to select_cell_lineage_GUI (see VARARGIN)

movegui(gcf,'center')
if nargin <4
    handles.output = hObject;
    handles.data_out=[];
    guidata(hObject, handles);
    
else
    
    %  select_cell_lineage_GUI(handles.Position,handles.cell_lineage_index,handles.cell_index,handles.p4,handles.p5)
    
    handles.Position =varargin{1};
    handles.cell_lineage_index=varargin{2};
    handles.cell_index=varargin{3};
    handles.p4=varargin{4};
    handles.p5=varargin{5};
    handles.X=varargin{6};
    handles.Y=varargin{7};
    handles.strX=varargin{8};
    handles.strY=varargin{9};
    
    guidata(hObject, handles);
    Position=unique(handles.Position)
    for ii=1:length(Position)
        pos_list(ii)={ num2str(ii)};
    end
    set(handles.listbox1,'string',pos_list)
    listbox1_Callback(hObject, eventdata, handles)
end

uiwait
clc

% Choose default command line output for select_cell_lineage_GUI
handles.output = hObject;


% UIWAIT makes select_cell_lineage_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = select_cell_lineage_GUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    varargout{1}=handles.data_out;
    guidata(hObject, handles);
    close
    clc
end


function Y_lim_end1_Callback(hObject, eventdata, handles)
% hObject    handle to Y_lim_end1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Y_lim_end1 as text
%        str2double(get(hObject,'String')) returns contents of Y_lim_end1 as a double


% --- Executes during object creation, after setting all properties.
function Y_lim_end1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Y_lim_end1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Y_lim_start1_Callback(hObject, eventdata, handles)
% hObject    handle to Y_lim_start1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Y_lim_start1 as text
%        str2double(get(hObject,'String')) returns contents of Y_lim_start1 as a double


% --- Executes during object creation, after setting all properties.
function Y_lim_start1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Y_lim_start1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
index=1


eval( strcat('Ylim(1)=str2num(get(handles.Y_lim_start1,','''string''))'))
eval( strcat('Ylim(2)=str2num(get(handles.Y_lim_end1,','''string''))'))


eval(strcat('axes(handles.axes',num2str(index),')'));
eval(strcat('set(handles.axes',num2str(index),',','[','''','y','''',',','''','lim','''','],Ylim);'))


% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)


Pos = get(handles.listbox1,'value')
Index=find(ismember(handles.Position,Pos))
cell_lineage_index=handles.cell_lineage_index(Index)
cell_index=handles.cell_index(Index)
p4=handles.p4(Index)
p5=handles.p5(Index)

[cell_index_unique,Index]=unique(cell_index);
for ii=1:length(cell_index_unique)
    Lineage_data(ii,1)=cell_lineage_index(Index(ii));
    Lineage_data(ii,2)={num2str(p4(Index(ii)))};
    Lineage_data(ii,3)={num2str(p5(Index(ii)))};
end
maxi=zeros(1,size(Lineage_data,1))
for ii=1:size(Lineage_data,1)
    temp=strfind(char(Lineage_data(ii,1)),'.')
    try
        maxi(ii)=  length(temp)
    end
end


n= max(maxi);
Cell=1
new_Div_Cells= Lineage_data

temp=1; vector1(1)=1
for ii=2:n
    temp=temp*2+1;
    vector1(ii)=temp;
end

temp=1; vector2(1)=1
for ii=1:n
    temp=temp*2+1;
    vector2(ii)=temp;
end

for ii=1:n
    
    seq=ones(vector1(ii),1);
    seq(end+1)=0;
    seq(end+1:end+length(seq))=seq*2;
    try
        matrix(:,ii)= repmat(seq,[ 0.5*(vector2(end)+1)/(vector1(ii)+1) 1]) ;
    catch
        matrix(:,ii)= repmat(seq',[ 0.5*(vector2(end)+1)/(vector1(ii)+1) 1]) ;
        
    end
end

matrix=rot90(matrix)';
matrix2=ones(size(matrix,1) ,size(matrix,2)+1)*Cell;
matrix2(:,2:end)=matrix;


jjj=1;
for ii=1:size(matrix2,1)
    matrix2_temp=num2str(matrix2(ii,:)) ;
    matrix2_temp=regexprep(matrix2_temp, ' ', '') ;
    matrix2_temp=regexprep(matrix2_temp, '0', '') ;
    if   isempty(str2num(matrix2_temp))~=1
        Generations(jjj)=str2num(matrix2_temp)  ; jjj=jjj+1;
    end
end

Generations(end)=[];
matrix=[];



for ii=1:size(new_Div_Cells,1)
    temp=char(new_Div_Cells(ii,1));
    temp(findstr(temp,'.'))=[];
    matrix(ii,3)=str2num(temp);
    matrix(ii,1)=str2num(char(new_Div_Cells(ii,2)));
    matrix(ii,2)=str2num(char(new_Div_Cells(ii,3)));
end
V=matrix(:,3);

for ii=1:length(V)
    Index(ii)=find(ismember(Generations,V(ii)));
end

matrix(:,4)=Index;
matrix=sortrows(matrix,4);




sel_typ = get(gcbf,'SelectionType')
point1 = get(hObject,'CurrentPoint')

save all


ii=round(point1(1))
matrix(ii,1)







if isempty(handles.temp_line_collection)
    handles.temp_line_collection= matrix(ii,3);
    if  point1(3)>  matrix(ii,1)
        plot(ones(1,matrix(ii,2)-matrix(ii,1)+1)*ii, matrix(ii,1):matrix(ii,2) ,'linewidth',3,'color',[0 0 1],'Hittest','Off');
    end
else
    temp_line_collection=handles.temp_line_collection;
    Index=find(ismember((temp_line_collection-matrix(ii,3)),0))
    if isempty(Index)~=1
        handles.temp_line_collection(Index)=[] ;
        if  point1(3)>  matrix(ii,1)
            plot(ones(1,matrix(ii,2)-matrix(ii,1)+1)*ii, matrix(ii,1):matrix(ii,2) ,'linewidth',3,'color',[1 0 0],'Hittest','Off');
        end
        
    else
        handles.temp_line_collection(end+1)=matrix(ii,3);
        if  point1(3)>  matrix(ii,1)
            plot(ones(1,matrix(ii,2)-matrix(ii,1)+1)*ii, matrix(ii,1):matrix(ii,2) ,'linewidth',3,'color',[0 0 1],'Hittest','Off');
        end
    end
end

guidata(hObject, handles);

%  maxi=zeros(1,size(Lineage_data,1))
% for ii=1:size(Lineage_data,1)
%   temp=strfind(char(Lineage_data(ii,1)),'.')
%   try
%     maxi(ii)=  length(temp)
%   end
% end


%
% View=get(handles.popupmenu1,'value');
% n= max(maxi);
%
% plot_lineage(handles,3,1,Lineage_data,1,View)
%


function X_lim_start1_Callback(hObject, eventdata, handles)
% hObject    handle to X_lim_start1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of X_lim_start1 as text
%        str2double(get(hObject,'String')) returns contents of X_lim_start1 as a double


% --- Executes during object creation, after setting all properties.
function X_lim_start1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to X_lim_start1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function X_lim_end1_Callback(hObject, eventdata, handles)
% hObject    handle to X_lim_end1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of X_lim_end1 as text
%        str2double(get(hObject,'String')) returns contents of X_lim_end1 as a double


% --- Executes during object creation, after setting all properties.
function X_lim_end1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to X_lim_end1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
index=1


eval( strcat('Xlim(1)=str2num(get(handles.X_lim_start1,','''string''))'))
eval( strcat('Xlim(2)=str2num(get(handles.X_lim_end1,','''string''))'))


eval(strcat('axes(handles.axes',num2str(index),')'));
eval(strcat('set(handles.axes',num2str(index),',','[','''','X','''',',','''','lim','''','],Xlim);'))


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
global h_cell_lineage_window
h_cell_lineage_window=handles;

global h_TAC_Cell_Tracking_Module;



track_what=get(h_TAC_Cell_Tracking_Module.track_what2,'value');


MATRIX=h_TAC_Cell_Tracking_Module.data_file(5).cdata.Tracks(track_what ).cdata;


Div_Cells=get(h_TAC_Cell_Tracking_Module.Div_Cells,'string');



Cell=get(h_TAC_Cell_Tracking_Module.Div_Cells,'value');
Cell2=char(Div_Cells(Cell));
Point=findstr(Cell2,'.') ;
if isempty(Point)~=1
    Cell=str2num(Cell2(1:Point-1));
else
    Cell=str2num(Cell2);
end







jj=1;max_Points=0;
for ii=1:size(Div_Cells,1)
    temp_Div_Cells=char(Div_Cells(ii)) ;
    Point=findstr(temp_Div_Cells,'.');
    if max_Points<length(Point)
        max_Points=length(Point);
    end
    if isempty(Point)~=1
        temp_Cell=temp_Div_Cells(1:Point(1)-1);
        if  str2num(temp_Cell)==Cell
            new_Div_Cells(jj,1)=  Div_Cells(ii);
            %%
            cell_index= ii
            V=MATRIX(:,cell_index*2-1);
            V=V(find(V, 1 ):find(V, 1, 'last' ));
            for start_XY=1:size(MATRIX,1)
                if MATRIX(start_XY,cell_index*2 -1)>0
                    break
                end
            end
            V=cumsum(V); Index=find(ismember(V,max(max(V)))); end_XY=Index(1);
            %%
            new_Div_Cells(jj,2)=  {num2str(start_XY)};  new_Div_Cells(jj,3)= { num2str(end_XY+start_XY-1)};
            jj=jj+1;
        end
    else
        if  str2num(temp_Div_Cells)==Cell
            new_Div_Cells(jj,1)= Div_Cells(ii);
            %%
            cell_index= ii
            V=MATRIX(:,cell_index*2-1);
            V=V(find(V, 1 ):find(V, 1, 'last' ));
            for start_XY=1:size(MATRIX,1)
                if MATRIX(start_XY,cell_index*2 -1)>0
                    break
                end
            end
            V=cumsum(V); Index=find(ismember(V,max(max(V)))); end_XY=Index(1);
            %%
            new_Div_Cells(jj,2)=  {num2str(start_XY)};  new_Div_Cells(jj,3)= { num2str(end_XY+start_XY-1)};
            jj=jj+1;
        end
    end
end



n= max_Points;
View=get(handles.popupmenu1,'value');



plot_lineage(handles,n,Cell,new_Div_Cells,1,View)



% --------------------------------------------------------------------
function uitoggletool3_ClickedCallback(hObject, eventdata, handles)

Pos = get(handles.listbox1,'value')
Index=find(ismember(handles.Position,Pos))
cell_lineage_index=handles.cell_lineage_index(Index)
cell_index=handles.cell_index(Index)
p4=handles.p4(Index)
p5=handles.p5(Index)

[cell_index_unique,Index]=unique(cell_index);
for ii=1:length(cell_index_unique)
    Lineage_data(ii,1)=cell_lineage_index(Index(ii));
    Lineage_data(ii,2)={num2str(p4(Index(ii)))};
    Lineage_data(ii,3)={num2str(p5(Index(ii)))};
end
maxi=zeros(1,size(Lineage_data,1))
for ii=1:size(Lineage_data,1)
    temp=strfind(char(Lineage_data(ii,1)),'.')
    try
        maxi(ii)=  length(temp)
    end
end



View=get(handles.popupmenu1,'value');
n= max(maxi);
plot_lineage(handles,3,1,Lineage_data,2,View)




% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
if get( hObject ,'value')==1
    set(handles.text1,'string','Frames')
    set(handles.text2,'string','Cell')
else
    set(handles.text2,'string','Frames')
    set(handles.text1,'string','Cell')
end
Untitled_1_Callback(hObject, eventdata, handles)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
handles.temp_line_collection=[];
guidata(hObject, handles);


Pos = get(handles.listbox1,'value')
Index=find(ismember(handles.Position,Pos))


cell_lineage_index=handles.cell_lineage_index(Index)
cell_index=handles.cell_index(Index)
p4=handles.p4(Index)
p5=handles.p5(Index)

[cell_index_unique,Index]=unique(cell_index);
for ii=1:length(cell_index_unique)
    Lineage_data(ii,1)=cell_lineage_index(Index(ii));
    Lineage_data(ii,2)={num2str(p4(Index(ii)))};
    Lineage_data(ii,3)={num2str(p5(Index(ii)))};
end
maxi=zeros(1,size(Lineage_data,1))
for ii=1:size(Lineage_data,1)
    temp=strfind(char(Lineage_data(ii,1)),'.')
    try
        maxi(ii)=  length(temp)
    end
end



View=get(handles.popupmenu1,'value');
n= max(maxi);

plot_lineage(handles,3,1,Lineage_data,1,View)


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)


Pos = get(handles.listbox1,'value')

Index=find(ismember(handles.Position,Pos))
cell_lineage_index=handles.cell_lineage_index(Index)
X=handles.X(Index);Y=handles.Y(Index);
temp_line_collection=handles.temp_line_collection



for ii=1:length(cell_lineage_index)
    t=char(cell_lineage_index(ii));
    I= findstr(t, '.') ;
    t(I)=[] ;
    vec_t(ii)=str2num(t);
end





figure

Max=0;
for ii=1:length(temp_line_collection)
    temp_index=find(ismember( vec_t,temp_line_collection(ii)));
    
    data.X(ii).cdata =(X(temp_index))';
    data.Y(ii).cdata =(Y(temp_index))';
    
    
    if max(data.Y(ii).cdata)>Max
        Max=max(data.Y(ii).cdata);
    end
end



for ii=1:length(temp_line_collection)
    
    subplot(1,length(temp_line_collection) ,ii);
    scatter(data.X(ii).cdata,data.Y(ii).cdata)
    title(num2str(temp_line_collection(ii)))
    xlabel(handles.strX); ylabel(handles.strY);
    ylim([0 Max])
end

set(gcf,'userdata',data)


uiresume
