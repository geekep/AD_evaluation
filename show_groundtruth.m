%   Distribution code Version 1.0 -- Oct 12, 2013 by Cewu Lu 
%
%   The Code can be used to show our grond truth in our Avenue Dataset, build based on  
%   [1] "Abnormal Event Detection at 150 FPS in Matlab" , Cewu Lu, Jianping Shi, Jiaya Jia, 
%   International Conference on Computer Vision, (ICCV), 2013
%   
%   The code and the algorithm are for non-comercial use only.

videoCount = 21;
videoIdx = 1;

for videoIdx = 1 : videoCount
    
    obj = VideoReader(['testing_videos\', sprintf('%02d', videoIdx), '.avi']);
    numFrames = get(obj, 'NumberOfFrames');
    load(['testing_label_mask\', num2str(videoIdx), '_label']);

    for i = 1 : numFrames
        mask = volLabel{i};
        curFrame = im2double(read(obj, i));
        curFrame(:, :, 1) = min(curFrame(:, :, 1) + 0.5 * double(mask), 1); 
        imshow(curFrame);
        imwrite(curFrame, ['output\', sprintf('%03d', i), '.bmp']);
        getframe;
    end
    
end
