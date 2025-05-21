function detectTornGloves(input_img)
    % Load the image
    img = imread(input_img);
    %img = imread('Images\Torn\torn5.png');

    % Convert the image to the YCbCr color space
    img_ycbcr = rgb2ycbcr(img);
    
    % Extract the Cb and Cr channels
    cb = img_ycbcr(:,:,2);
    cr = img_ycbcr(:,:,3);
    
    % Define a skin color model in the YCbCr color space
    skin_model = cb >= 77 & cb <= 127 & cr >= 133 & cr <= 173;
    
    % Use morphological opening to remove noise and smooth the image
    se = strel('disk', 5); % adjust structuring element size as needed
    skin_model = imopen(skin_model, se);
    
    %Invert
    img_inv = imcomplement(skin_model);
    
    %Morphology
    se = strel('square', 20);
    image_dilated = imdilate(img_inv, se);
    se = strel('square', 10);
    image_eroded = imerode(img_inv, se);
    
    %Find boundaries
    img_boundaries = image_dilated - image_eroded;
    result = imoverlay(img, img_boundaries, [1 0 0]);
    
    %Find connecting points
    CC = bwconncomp(img_boundaries,8);

    % Use regionprops to compute the bounding box for each connected component
    stats = regionprops(CC, 'Area', 'BoundingBox');

    max_area = 100000;
    min_area = 50;
    
    % Loop through each connected component and draw a bounding box around it
    figure; imshow(img), title('Result'); hold on;
    for i = 1:CC.NumObjects
        if stats(i).Area<max_area && stats(i).Area>min_area
            rectangle('Position', stats(i).BoundingBox, 'EdgeColor', 'magenta', 'LineWidth', 2);
        % Add a label to the bounding box
        text(stats(i).BoundingBox(1)-20, stats(i).BoundingBox(2)-50, sprintf("Torn", i), ...
            'FontSize', 14, 'Color', 'magenta');
        end
    end
    hold off;
end