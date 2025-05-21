function detectStain(input_img)
    glove = imread(input_img);

    %Image prepocessing
    img_gray = rgb2gray(glove);

    %Morphology filter
    se = strel('square', 10);
    img_close=imclose(img_gray,se);
    imshow(img_close),title('Closing');

    %Threshold
    s = size(img_close);
    y = zeros(s(1),s(2));
    for i=1:s(1)
        for j = 1:s(2)
            %if(img_close(i,j)>40)
            if(img_close(i,j)>80)
                y(i,j)=0;
            else
                y(i,j)=255;
            end
        end
    end
    img_bin = imbinarize(img_close,y);
    imshow(img_bin),title('bin');

    %Morphology
    se = strel('diamond', 15);
    img_open = imopen(img_bin,se);

    %Invert
    img_inv = imcomplement(img_open);

    %Filling
    img_fill=imfill(img_inv,'holes');

    %Morphology
    se = strel('square', 22);
    image_dilated = imdilate(img_fill, se);
    se = strel('square', 10);
    image_eroded = imerode(img_fill, se);
    
    %Find boundaries
    img_boundaries = image_dilated - image_eroded;
    result = imoverlay(glove, img_boundaries, [1 0 0]);
    
    %Find connecting points
    CC = bwconncomp(img_boundaries,8);

    % Use regionprops to compute the bounding box for each connected component
    stats = regionprops(CC, 'Area', 'BoundingBox');

    max_area = 100000;
    min_area = 5000;
    
    % Loop through each connected component and draw a bounding box around it
    figure; imshow(glove), title('Result'); hold on;
    for i = 1:CC.NumObjects
        if stats(i).Area<max_area && stats(i).Area>min_area
            rectangle('Position', stats(i).BoundingBox, 'EdgeColor', 'magenta', 'LineWidth', 2);
        % Add a label to the bounding box
        text(stats(i).BoundingBox(1)-20, stats(i).BoundingBox(2)-50, sprintf("Stain", i), ...
            'FontSize', 14, 'Color', 'magenta');
        end
    end
    hold off;
end