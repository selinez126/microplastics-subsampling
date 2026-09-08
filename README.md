# microplastics-subsampling
The 2 files included are relevant to the paper "Sampling Smart: Rethinking Subsampling Layouts for Representative Microplastic Analysis". They were used in conjunction in the code in this repository (https://github.com/Isaac0047/Microplastic_Detection) which performs microplastics detection via k-means clustering.

(1) `subsampling_layouts.m` - Creates 4160 pixels x 4160 pixels .PNG files that serve as the subsampling layout masks (grid, wedges, rings, random boxes, spirals, strips).

(2) `do_subsampling.m` - Performs subsampling using the layouts created in step (1) on a set of imaged samples and does some image preprocessing. Yields subsampling errors (defined in paper).
