# Content-Aware-Image-Resizing
Seam Carving Algorithm for content aware image resizing and object removal

## Importance/Cost Matrix
two types of cost functions are implemented
- ![get_cost_gradient.m](get_cost_gradient.m) computes image gradient as cost
- ![get_cost_entropy.m](get_cost_entropy.m) computes cost as per pixel entropy considering 9-by-9 neighbourhood

| original image | gradient cost |
| -- | -- |
| ![images/broadway_tower/Broadway_tower_edit.jpg](images/broadway_tower/Broadway_tower_edit.jpg) | ![images/broadway_tower/Broadway_tower_edit.jpg](images/broadway_tower/cost_function.jpg) |
| ![images/lake/lake_seamcut.jpg](images/lake/lake_seamcut.jpg) | ![images/lake/cost.jpg](images/lake/cost.jpg) |

## Image Downsizing
- ![seam_carving.m](seam_carving.m) does reduction in width using seam carving
- results below are for gradient cost matrix

| original width : 1428 pixels | reduced width : 1128 pixels | reduced width : 714 pixels | reduced width : 476 pixels |
| -- | -- | -- | -- |
| ![images/broadway_tower/Broadway_tower_edit.jpg](images/broadway_tower/Broadway_tower_edit.jpg) | ![images/broadway_tower/Broadway_tower_edit.jpg](images/broadway_tower/Broadway_tower_edit_width_300.jpg) | ![images/broadway_tower/Broadway_tower_edit.jpg](images/broadway_tower/Broadway_tower_edit_width_half.jpg) | ![images/broadway_tower/Broadway_tower_edit.jpg](images/broadway_tower/Broadway_tower_edit_width_one_third.jpg) |

- per pixel entropy generally works better than gradient but it is computationally expensive

| original width : 470 pixels | gradient cost, reduced width : 235 pixels | entropy cost, reduced width : 235 pixels |
| -- | -- | -- |
| ![images/lake/lake_seamcut.jpg](images/lake/lake_seamcut.jpg) | ![images/lake/lake_seamcut_width_half.jpg](images/lake/lake_seamcut_width_half.jpg) | ![images/lake/lake_seamcut_width_half_entropy.jpg](images/lake/lake_seamcut_width_half_entropy.jpg) |

## Image Upsizing
- ![expand.m](expand.m) does increment in width using seam carving
- if width is to be increased by `x` pixels, then width is reduced by `x` pixels first using normal seam carving and the deleted seams are duplicated in original image to get the resultant image with width increased by `x` pixels

| original width : 1428 pixels | increased width : 2142 pixels |
| -- | -- |
| ![images/broadway_tower/Broadway_tower_edit.jpg](images/broadway_tower/Broadway_tower_edit.jpg) | ![images/broadway_tower/width_plus_700.jpg](images/broadway_tower/width_plus_700.jpg) |

| original width : 464 pixels | increased width : 696 pixels |
| -- | -- |
| ![images/street/street.jpg](images/street/street.jpg) | ![images/street/street_width_plus_230.jpg](images/street/street_width_plus_230.jpg) |

| original width : 520 pixels | increased width : 2128 pixels |
| -- | -- |
| ![images/wave/wave.jpg](images/wave/wave.jpg) | ![images/wave/wave_width_plus_230.jpg](images/wave/wave_width_plus_230.jpg) |

## Object Removal
- ![object_removal.m](object_removal.m) resize the image in such a way that specific object in the image is removed smoothly
- bounding box over the object is given and the cost values of the pixels in the bounding box are made negative infinite to make every seam pass through the object

| original | object removed |
| -- | -- |
| ![images/broadway_tower/Broadway_tower_edit.jpg](images/broadway_tower/Broadway_tower_edit.jpg) | ![images/broadway_tower/Broadway_tower_edit.jpg](images/broadway_tower/person_removed.jpg) |

| original | object removed |
| -- | -- |
| ![images/dog/dog.jpg](images/dog/dog.jpg) | ![images/dog/remove.jpg](images/dog/remove.jpg) |
