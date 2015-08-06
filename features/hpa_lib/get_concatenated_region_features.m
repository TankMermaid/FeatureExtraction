function [features, feature_names, feature_computation_time, cell_regions , nuc_regions] = get_concatenated_region_features(...
  image_path, storage_path, base_naming_convention, label_name, optimize, use_segmentation_suffix_in_list,resolution)

  start_time = tic;

%   addpath(genpath('./HPA_lib'));
%   addpath(genpath('./DataHash'));
  warning('off', 'MATLAB:MKDIR:DirectoryExists'); 
  % warning('off', 'Images:imfeature:obsoleteFunction');


% $$$   mask_path = [storage_path, 'segmentation/'];
  mask_path = storage_path;
  metadata_path = [storage_path, '/metadata/'];
  
  mkdir(storage_path)
  mkdir(mask_path)
  mkdir(metadata_path)
  
  if ~exist('label_name', 'var')
    label_name = ''; 
  end
  
  if ~exist('optimize', 'var')
    optimize = false; 
  end
  
  if ~exist('use_segmentation_suffix_in_list', 'var')
    use_segmentation_suffix_in_list = false; 
  end
  
  if nargout > 2
    feature_computation_time = 0; 
  end
  disp('segmenting fields') 
  [cell_regions, nuc_regions] = segmentFields(image_path, mask_path, base_naming_convention,resolution);
%   figure;imshow(label2rgb(bwlabel(cell_regions)));
%   figure;imshow(label2rgb(bwlabel(nuc_regions)));
  disp('getting nuclear region feats')
  nucstats_seg = regionprops(bwlabel(nuc_regions),'Centroid','BoundingBox');
  
  if use_segmentation_suffix_in_list
      base_naming_convention2 = base_naming_convention;
      base_naming_convention2.protein_channel = base_naming_convention2.segmentation_suffix;
    imagelist = listImages(image_path, storage_path, base_naming_convention2)'; 
  else
    imagelist = listImages(image_path, storage_path, base_naming_convention)'; 
  end
  label_list = repmat({label_name}, length(imagelist), 1); 

  feature_set_directories = {...
    ''...
    ; '/original_nuc-as-prot'...
    ; '/nucStats'...
    ; '/nucStats_prot-as-nuc'...
    ; '/original_tub-as-prot'...
    ; '/nucStats_tub-as-nuc'...
    ; '/total_protein'...
    ; '/total_dapi'}

  number_feature_sets = length(feature_set_directories)
  disp('setting naming conventions')
  feature_set_naming_conventions = repmat({base_naming_convention}, size(feature_set_directories));
  feature_set_naming_conventions = repmat({base_naming_convention}, size(feature_set_directories));
  feature_set_naming_conventions{2}.protein_channel = base_naming_convention.nuclear_channel;
  %DPS 05,08,2015 - resetting the 'blank' channel each feature set screws
  %things up if a channel is actually missing. We need to ADD the blank
  %name to the base naming convention! 
%   feature_set_naming_conventions{2}.blank_channels = {'nuclear'};
  feature_set_naming_conventions{2}.blank_channels = [base_naming_convention.blank_channels,{'nuclear'}];
  feature_set_naming_conventions{4}.nuclear_channel = base_naming_convention.protein_channel;
  feature_set_naming_conventions{5}.protein_channel = base_naming_convention.tubulin_channel;
  %DPS 05,08,2015 - resetting the 'blank' channel each feature set screws
  %things up if a channel is actually missing. We need to ADD the blank
  %name to the base naming convention! 
%   feature_set_naming_conventions{5}.blank_channels = {'tubulin'};
  feature_set_naming_conventions{5}.blank_channels = [base_naming_convention.blank_channels,{'tubulin'}];
  feature_set_naming_conventions{6}.nuclear_channel = base_naming_convention.tubulin_channel;
  
  % new code
  feature_set_naming_conventions{7}.protein_channel = base_naming_convention.protein_channel;
  feature_set_naming_conventions{8}.protein_channel = base_naming_convention.nuclear_channel;

  
  feature_set_feature_names = repmat({[]}, size(feature_set_directories));
  feature_set_feature_names{3} = {'nucStats'};
  feature_set_feature_names{4} = {'nucStats'};
  feature_set_feature_names{6} = {'nucStats'};
  
  % new code
  feature_set_feature_names{7} = {'protTotalIntensity'};
  feature_set_feature_names{8} = {'protTotalIntensity'};
  
  feature_set_naming_conventions{:}
  feature_set_feature_names{:}
  
  features = cell(1, 0); 
  feature_names = cell(1, 0); 
% $$$   for index = 1:20
% $$$     warning('DEBUG: feature_set_index = 5')
% $$$   end
% $$$   for feature_set_index = 5
  for feature_set_index = 1:number_feature_sets
    %feature_set_index
    % Compute features:
    %feature_set_subdirectory = [storage_path(1:end - 1), feature_set_directories{feature_set_index}, filesep];
		feature_set_subdirectory = storage_path
		%image_path
		%mask_path
    disp(['calculating features on set index ', num2str(feature_set_index),'.'])
    calcRegionFeat(image_path, mask_path, feature_set_subdirectory, ...
                   feature_set_naming_conventions{feature_set_index}, ...
                   feature_set_feature_names{feature_set_index}, ...
                   optimize); 
    
    % Dummy metadata needed for Jieyue's HPA_lib code:
    classlabels = label_list; 
    staining = repmat({'2:Moderate'}, size(label_list)); 
    specificity = ones(size(label_list)); 
    cellabels = ones(size(label_list)); 
    antibodyids = -ones(size(label_list)); 
    save([metadata_path, 'hpalistsall.mat'], ...
         'imagelist','antibodyids','classlabels','cellabels','specificity','staining');

    % Combine features into one file:
    data_filename = [feature_set_subdirectory, '/features/regionfeatures_all.mat'];
    [data_filename, computation_time] = ...
        loadAllRegionFeatures(...
          [feature_set_subdirectory, '/features/region/'], metadata_path, image_path, ...
          data_filename, feature_set_feature_names{feature_set_index});
    if exist('feature_computation_time', 'var')
      feature_computation_time = feature_computation_time + computation_time; 
    end
    
    % Load features:
    data = load(data_filename); 
    features{1, feature_set_index} = data.allfeatures; 
    feature_names = [feature_names, strcat(num2str(feature_set_index, 'feature_set%d:'), data.names)];
    %whos feature*
    
  end
  disp('making feature matrix') 
  %features
  features = cell2mat(features);
  %whos feature*
  %feature_names
  
  %error('Implementation yet unfinished below this line!')
  
  warning('on', 'MATLAB:MKDIR:DirectoryExists');
  warning('on', 'Images:imfeature:obsoleteFunction');

end
