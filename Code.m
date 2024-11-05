originalImage = imread('1.jpg');
figure; imshow(originalImage); title('Original RGB Image');

grayImage = rgb2gray(originalImage);
doubleGrayImage = im2double(grayImage);

gaussianFilter = fspecial('gaussian');
smoothedImage = imfilter(doubleGrayImage, gaussianFilter, 'replicate');

edgesImage = edge(smoothedImage, 'sobel');

dilatedImage = imdilate(edgesImage, strel('diamond', 1));
erodedImage = imerode(dilatedImage, strel('diamond', 1));
filledImage = imfill(erodedImage, 'holes');

regionProps = regionprops(filledImage, 'Area', 'BoundingBox', 'Image');
if ~isempty(regionProps)
    largestRegionIndex = find([regionProps.Area] == max([regionProps.Area]));
    largestRegionImage = regionProps(largestRegionIndex).Image;
else
    disp('No regions found.');
    return;
end

boundingBox = regionProps(largestRegionIndex).BoundingBox;
x1 = floor(boundingBox(1));
y1 = floor(boundingBox(2));
width = ceil(boundingBox(3));
height = ceil(boundingBox(4));

croppedImage = imcrop(originalImage, [x1, y1, width, height]);

grayCroppedImage = rgb2gray(croppedImage);
contrastStretchedImage = imadjust(grayCroppedImage, stretchlim(grayCroppedImage), [0 1]);


binaryImage = im2bw(im2double(contrastStretchedImage));

if isfield(regionProps(largestRegionIndex), 'Orientation')
    orientationAngle = regionProps(largestRegionIndex).Orientation;
    if abs(orientationAngle) >= 1
        orientedImage = imrotate(binaryImage, -orientationAngle);
    else  
        orientedImage = binaryImage;
        disp('*** The image does not need rotation ***');
    end
else
    orientedImage = binaryImage;
end

dilatedRefinedImage = imdilate(orientedImage, strel('diamond', 1));  
erodedRefinedImage = imerode(dilatedRefinedImage, strel('diamond', 1));  
filledRefinedImage = imfill(erodedRefinedImage, 'holes');  

xorImage = xor(filledRefinedImage, erodedRefinedImage);  

finalImage = imresize(xorImage, [44, 250]);  

finalRegions = regionprops(logical(finalImage), 'Area', 'Image');
if ~isempty(finalRegions)
    largestCharacterIndex = find([finalRegions.Area] == max([finalRegions.Area]));
    maxArea = finalRegions(largestCharacterIndex).Area;
    noiseFreeImage = bwareaopen(finalImage, maxArea - 200);
else
    noiseFreeImage = finalImage;
end

figure; 
subplot(4, 2, 1); imshow(originalImage); title('Original RGB Image');
subplot(4, 2, 2); imshow(largestRegionImage); title('Largest Region');
subplot(4, 2, 3); imshow(croppedImage); title('Cropped Region');
subplot(4, 2, 4); imshow(contrastStretchedImage); title('Contrast Stretched Image');
subplot(4, 2, 5); imshow(orientedImage); title('Corrected Orientation of the Plate');
subplot(4, 2, 6); imshow(noiseFreeImage); title('Image without Noise');
subplot(4, 2, 7); imshow(finalImage); title('Resized Image of the Plate');

sgtitle('Image Processing Results');