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
% =================================================================== --
function [XY_data]= Find_L(handles,track_what,box_Raw,start_track,end_track,str_parameter)

if nargin==5
    XY_data=handles.data_file(4).cdata.L(track_what).cdata;
    pathname_Raw=handles.data_file(2).cdata(track_what,1)
    pathname_Segmentation=handles.data_file(2).cdata(track_what,3)
    h=timebar_TACWrapper('Label cells. Please wait....');
    set(h,'color','w');
    for ii=start_track:end_track %2 Procced only if the complimantory Segmented file was found
        timebar_TACWrapper(h,ii/(end_track-start_track))
        filename_Segmentation=box_Raw(ii) ;
        full_filename_Segmentation= strcat(pathname_Segmentation,filename_Segmentation,'_ch0',num2str(track_what-1),'_Segmented.tif') ;
        full_filename_Segmentation=char(full_filename_Segmentation) ;
        temp_Segmentation=imread( full_filename_Segmentation,1);
        temp_Segmentation=flipdim(temp_Segmentation,1);
        temp_Segmentation2=zeros(size(temp_Segmentation));
        position= handles.data_file(6).cdata ;
        temp_Segmentation2(position(2):(position(2)+position(4)-1),position(1):(position(1)+position(3)-1))  =  temp_Segmentation(position(2):(position(2)+position(4)-1),position(1):(position(1)+position(3)-1));
        L=bwlabel(temp_Segmentation2,4);
        XY_data(ii).cdata= regionprops(L,'Area','BoundingBox','Centroid','PixelList','Orientation','Eccentricity','Perimeter','Extent','Solidity','Majoraxislength','Minoraxislength','EquivDiameter');
        
        pause(0.1);  %let the computer time to cool itself
    end
    for ii=start_track:end_track
        for iii=1:size(XY_data(ii).cdata,1)
            XY_data(ii).cdata(iii).Centroid= round(XY_data(ii).cdata(iii).Centroid*100)/100;
        end
    end
    close(h)
end
if nargin==6
    XY_data=handles.data_file(4).cdata.L(track_what).cdata;
    pathname_Raw=handles.data_file(2).cdata(track_what,1)
    pathname_Segmentation=handles.data_file(2).cdata(track_what,3)
    h=timebar_TACWrapper('Label cells. Please wait....');
    set(h,'color','w');
    for ii=start_track:end_track %2 Procced only if the complimantory Segmented file was found
        timebar_TACWrapper(h,ii/(end_track-start_track))
        filename_Segmentation=box_Raw(ii) ;
        full_filename_Segmentation= strcat(pathname_Segmentation,filename_Segmentation,'_ch0',num2str(track_what-1),'_Segmented.tif') ;
        full_filename_Segmentation=char(full_filename_Segmentation) ;
        temp_Segmentation=imread( full_filename_Segmentation,1);
        temp_Segmentation=flipdim(temp_Segmentation,1);
        temp_Segmentation2=zeros(size(temp_Segmentation));
        position= handles.data_file(6).cdata ;
        temp_Segmentation2(position(2):(position(2)+position(4)-1),position(1):(position(1)+position(3)-1))  =  temp_Segmentation(position(2):(position(2)+position(4)-1),position(1):(position(1)+position(3)-1));
        L=bwlabel(temp_Segmentation2,4);
        eval(char(strcat('XY_data(',num2str(ii),').cdata=regionprops(L,', str_parameter,');')))
        pause(0.1);  %let the computer time to cool itself
    end
    for ii=start_track:end_track
        for iii=1:size(XY_data(ii).cdata,1)
            XY_data(ii).cdata(iii).Centroid= round(XY_data(ii).cdata(iii).Centroid*100)/100;
        end
    end
    close(h)
end
end