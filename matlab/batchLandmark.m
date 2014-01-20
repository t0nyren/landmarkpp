function [  ] = faceppDetect( input_dir, output_file )

[classes, images, ids] = getImages(input_dir);

API_KEY = 'd45344602f6ffd77baeab05b99fb7730';
API_SECRET = 'jKb9XJ_GQ5cKs0QOk6Cj1HordHFBWrgL';
api = facepp(API_KEY, API_SECRET);

fid = fopen(output_file,'w');
fprintf(fid, 'file\t x,y,w,h\t left_eye\t right_eye\t mouth_left\t mouth_right\t nose');
landmark_names = {'contour_chin';'contour_left1';'contour_left2';'contour_left3';'contour_left4';'contour_left5';'contour_left6';'contour_left7';'contour_left8';'contour_left9';'contour_right1';'contour_right2';'contour_right3';'contour_right4';'contour_right5';'contour_right6';'contour_right7';'contour_right8';'contour_right9';'left_eye_bottom';'left_eye_center';'left_eye_left_corner';'left_eye_lower_left_quarter';'left_eye_lower_right_quarter';'left_eye_pupil';'left_eye_right_corner';'left_eye_top';'left_eye_upper_left_quarter';'left_eye_upper_right_quarter';'left_eyebrow_left_corner';'left_eyebrow_lower_left_quarter';'left_eyebrow_lower_middle';'left_eyebrow_lower_right_quarter';'left_eyebrow_right_corner';'left_eyebrow_upper_left_quarter';'left_eyebrow_upper_middle';'left_eyebrow_upper_right_quarter';'mouth_left_corner';'mouth_lower_lip_bottom';'mouth_lower_lip_left_contour1';'mouth_lower_lip_left_contour2';'mouth_lower_lip_left_contour3';'mouth_lower_lip_right_contour1';'mouth_lower_lip_right_contour2';'mouth_lower_lip_right_contour3';'mouth_lower_lip_top';'mouth_right_corner';'mouth_upper_lip_bottom';'mouth_upper_lip_left_contour1';'mouth_upper_lip_left_contour2';'mouth_upper_lip_left_contour3';'mouth_upper_lip_right_contour1';'mouth_upper_lip_right_contour2';'mouth_upper_lip_right_contour3';'mouth_upper_lip_top';'nose_contour_left1';'nose_contour_left2';'nose_contour_left3';'nose_contour_lower_middle';'nose_contour_right1';'nose_contour_right2';'nose_contour_right3';'nose_left';'nose_right';'nose_tip';'right_eye_bottom';'right_eye_center';'right_eye_left_corner';'right_eye_lower_left_quarter';'right_eye_lower_right_quarter';'right_eye_pupil';'right_eye_right_corner';'right_eye_top';'right_eye_upper_left_quarter';'right_eye_upper_right_quarter';'right_eyebrow_left_corner';'right_eyebrow_lower_left_quarter';'right_eyebrow_lower_middle';'right_eyebrow_lower_right_quarter';'right_eyebrow_right_corner';'right_eyebrow_upper_left_quarter';'right_eyebrow_upper_middle';'right_eyebrow_upper_right_quarter'};
for i = 1:length(landmark_names)
    fprintf(fid,'%s\t',landmark_names{i});
end
fprintf(fid,'\n');

for i = 1:length(images)
    rst = detect_file(api, images{i}, 'all');
    img_width = rst{1}.img_width;
    img_height = rst{1}.img_height;
    face = rst{1}.face;
    fprintf('%s Image %d: Totally %d faces detected!\n', classes{ids(i)}, i, length(face));
    
    for j = 1 : length(face)
        % Face rectangles
        face_i = face{j};
        fprintf(fid, '%s\t', images{i});
        center = face_i.position.center;
        w = face_i.position.width / 100 * img_width;
        h = face_i.position.height / 100 * img_height;
        fprintf(fid,'%f,%f,%f,%f\t', center.x * img_width / 100 -  w/2,center.y * img_height / 100 - h/2, w, h);

        % Facial key points
        rst2 = api.landmark(face_i.face_id, '83p');
        landmark_points = rst2{1}.result{1}.landmark;
        landmark_names = fieldnames(landmark_points);
        for k = 1 : length(landmark_names)
            point = getfield(landmark_points,landmark_names{k});
            fprintf(fid,'%f,%f\t', point.x,point.y);
        end
        fprintf(fid,'\n');
    end
end
fclose(fid);
