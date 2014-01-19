function [ classes, images, ids ] = getImages( directory )
classes = dir(directory);
classes = classes([classes.isdir]) ;
classes = {classes(3:length(classes)).name} ;
images = {} ;
ids = {};
for ci = 1:length(classes)
  ims = dir(fullfile(directory, classes{ci}, '*.jpg'))';
  ims = fullfile(directory, classes(ci),{ ims.name}) ;
  images = {images{:} ims{:}};
  ids{end+1} = ci * ones(1,length(ims)) ;
end
ids = cat(2, ids{:}) ;

