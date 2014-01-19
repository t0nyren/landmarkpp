function [ output_args ] = faceppDetect( input_dir, output_dir )

[classes, images, ids] = getImages(input_dir);

API_KEY = 'd45344602f6ffd77baeab05b99fb7730';
API_SECRET = 'jKb9XJ_GQ5cKs0QOk6Cj1HordHFBWrgL';
api = facepp(API_KEY, API_SECRET);
img = '../data/tiny/rola/rola.jpg';
for i = 1:length(images)
    rst = detect_file(api, images{i}, 'all');
    img_width = rst{1}.img_width;
    img_height = rst{1}.img_height;
    face = rst{1}.face;
    fprintf('Image %d: Totally %d faces detected!\n', i, length(face));
end

