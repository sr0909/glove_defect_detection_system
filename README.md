# 🧤 Glove Defect Detection System

A MATLAB-based image processing system for detecting defects in gloves—such as **holes, stains, tears, missing fingers,** and **thin spots** using morphological operations and automated segmentation techniques. This project features a custom GUI and processing pipelines for different glove types (cloth, latex, nitrile, and rubber).

---

## 🧪 Technologies Used

### 🧠 MATLAB & Image Processing Toolbox
- **MATLAB GUI (.mlapp)** built for interactive usage
- Image read & write: `imread`, `imshow`, `imoverlay`
- Grayscale conversion: `rgb2gray`
- Thresholding: `graythresh`, `imbinarize`
- Morphology: `imdilate`, `imerode`, `bwareaopen`
- Boundary extraction & region properties: `bwlabel`, `regionprops`
- Overlay visualization and bounding box annotation

---

## 🧩 Core Features

### 🔍 Defect Detection Capabilities
- **Hole Detection** (based on morphological gaps)
- **Tear Detection**
- **Stain Detection** (via color space and texture analysis)
- **Thin Material Detection**
- **Missing Finger Detection**

### 📊 Techniques Applied
- Adaptive thresholding with Otsu’s method
- Binary segmentation and masking
- Structural elements (`strel`) for dilation and erosion
- Area filtering using `regionprops`
- GUI integration for image input, result display, and user interaction

---

## 🖥 System Interface

The system includes a graphical interface (`GUI.mlapp`) built using MATLAB App Designer, allowing users to:

- Upload glove images
- Trigger specific defect detection methods (e.g., holes)
- Visualize output images with overlaid detection
- Display result summaries and defect localization

