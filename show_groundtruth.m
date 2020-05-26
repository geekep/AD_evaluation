%% Avenue
videoCount = 21;
videoIdx = 1;

for videoIdx = 1 : 1
    
    obj = VideoReader(['testing_videos\', sprintf('%02d', videoIdx), '.avi']);
    numFrames = get(obj, 'NumberOfFrames');
    load(['testing_label_mask\', num2str(videoIdx), '_label']);

    for i = 1 : numFrames
        mask = volLabel{i};
        if any(any(mask))
            curFrame = im2double(read(obj, i));
            curFrame(:, :, 1) = min(curFrame(:, :, 1) + 0.5 * double(mask), 1); 
            imshow(curFrame);
            imwrite(curFrame, ['detection\', num2str(i), '.bmp']);
            getframe;
        end
    end
    
end

%% UCSD Ped1
videoFolder = 'testing_videos';
gtFolder = 'testing_label_mask';
gtList = dir(fullfile(gtFolder, '*_gt'));

for k = 1:length(gtList)
    
    video = fullfile(videoFolder, gtList(k).name(1:end-3));
    objList = dir(fullfile(video, '*.tif'));
    maskList = dir(fullfile(gtFolder, gtList(k).name, '*.bmp'));
    
    for i = 1:length(maskList)
        
        obj = imread(fullfile(video, objList(i).name));
        obj = repmat(obj, [1,1,3]);
        mask = imread(fullfile(gtFolder, gtList(k).name, maskList(i).name));
        mask = repmat(mask, [1,1,3]);
        
        if any(any(mask))
            
            obj = im2double(obj);
            mask = im2double(mask);
            obj(:,:,1) = min(obj(:,:,1) + 0.5 * mask(:,:,1), 1);
            imshow(obj);
            imwrite(obj, ['detection\', num2str(i), '.bmp']);
            getframe;
        end
    end
        
end
    
%% UCSD Ped2
videoCount = 21;
videoIdx = 1;

for videoIdx = 7 : 7
    
    obj = VideoReader(['testing_videos\', sprintf('%02d', videoIdx), '.avi']);
    gt = VideoReader(['testing_label_mask\', sprintf('%02d', videoIdx), '_gt.avi']);
    numFrames = get(obj, 'NumberOfFrames');

    for i = 1 : numFrames
        mask = im2double(read(gt, i));
        if any(any(mask))
            curFrame = im2double(read(obj, i));
            curFrame(:, :, 1) = min(curFrame(:, :, 1) + 0.5 * mask(:, :, 1), 1); 
            imshow(curFrame);
            imwrite(curFrame, ['detection\', num2str(i), '.bmp']);
            getframe;
        end
    end
    
end

%% LV
gtList = dir(['testing_label_mask\', '*.mp4']);

for k = 1:length(gtList)
    obj = VideoReader(['testing_videos\', gtList(k).name(2:end)]);
    gt = VideoReader(['testing_label_mask\', gtList(k).name]);
    numFrames = get(obj, 'NumberOfFrames');

    for i = 1 : numFrames
        mask = im2double(read(gt, i));
        if any(any(mask))
            curFrame = im2double(read(obj, i));
            curFrame(:, :, 1) = min(curFrame(:, :, 1) + 0.5 * mask(:, :, 1), 1); 
            imshow(curFrame);
            imwrite(curFrame, ['detection\', num2str(i), '.bmp']);
            getframe;
        end
    end

end

