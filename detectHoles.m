function detectHoles(input_img)
    glove = imread(input_img);

    %glove = imread('Images\Holes\latexHoles4.JPG');
    
    glove_gray = rgb2gray(glove);

    threshold = graythresh(glove_gray);
    glove_bw = imbinarize(glove_gray, threshold);

    glove_inv = imcomplement(glove_bw);

    %Morphology
    se = strel('square', 20);
    image_dilated = imdilate(glove_inv, se);
    se = strel('square', 10);
    image_eroded = imerode(glove_inv, se);
    
    %Find boundaries
    img_boundaries = image_dilated - image_eroded;
    result = imoverlay(glove, img_boundaries, [1 0 0]);

    glove_clean = bwareaopen(img_boundaries, 100);

    [label, num] = bwlabel(glove_clean);

    props = regionprops(label, 'Area', 'BoundingBox');

    min_area = 100;
    max_area = 20000;

    idx = find([props.Area] > min_area & [props.Area] < max_area);

    % Plot the original image with bounding boxes around the detected holes
    figure;
    imshow(glove);
    hold on;
    for i = 1:length(idx)
        bb = props(idx(i)).BoundingBox;
        rectangle('Position', bb, 'EdgeColor', 'r', 'LineWidth', 2);

        % Add a label to the bounding box
        text(props(i).BoundingBox(1)-20, props(i).BoundingBox(2)-50, sprintf("Hole", i), ...
            'FontSize', 14, 'Color', 'r');
    end
    hold off;
end