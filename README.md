# License Plate Extraction Project

This project is part of a Numerical Analysis course that I undertook, and I wanted to share it with you in this repository. The code is written in MATLAB, and it processes an image to extract license plates step by step.

## Description

The main functionality of this project involves reading an image of a license plate, processing it to isolate and enhance the plate's features, and finally extracting the plate for further analysis. Below are the steps the code follows:

1. **Read and Convert Image**: The original RGB image is read, and then it is converted to grayscale for further processing.
2. **Image Smoothing and Edge Detection**: The grayscale image is smoothed using a Gaussian filter to reduce noise. Edges are then detected using the Sobel operator, followed by morphological operations (dilation and erosion) to enhance the edges.
3. **Identify Largest Region**: The code analyzes the connected regions in the binary image and identifies the largest region, which is assumed to be the license plate.
4. **Crop Original Image and Process**: The original image is cropped based on the bounding box of the largest region. This cropped image is then converted to grayscale and undergoes contrast stretching to enhance visibility.
5. **Correct Orientation of the Plate**: If the orientation of the detected region is available, the image is rotated accordingly to ensure the plate is upright.
6. **Morphological Refinement**: Additional morphological operations are applied to refine the isolated plate features further.
7. **Remove Noise Based on Region Properties**: Small objects are filtered out based on the area of the detected regions, resulting in a cleaner image of the plate.
8. **Display All Results in One Figure**: Finally, all processed images, including the original, cropped, contrast-stretched, and noise-free images, are displayed in a single figure for comparison.

This project is highly suitable for practicing image processing techniques and understanding the fundamental concepts involved in feature extraction.

## Contribution

If anyone wishes to modify or improve the code, we would be delighted to see your contributions and enhancements. Feel free to fork the repository, make changes, and submit pull requests. Your input is valuable!

## Example

Alongside the code, there is an example image (`1.jpg`) that the MATLAB code reads to extract the license plate step by step.
