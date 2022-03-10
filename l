[1mdiff --git a/README.rst b/README.rst[m
[1mindex ba0572a..ee31738 100644[m
[1m--- a/README.rst[m
[1m+++ b/README.rst[m
[36m@@ -25,6 +25,7 @@[m [mThen, you can create and activate the required conda environment with the follow[m
     $ cd bob.paper.icassp2022_morph_generate[m
     $ conda install -n base -c conda-forge mamba[m
     $ mamba env create -f environment.yml -n bob.paper.icassp2022_morph_generate[m
[32m+[m[32m    $ conda activate bob.paper.icassp2021_morph[m
 [m
 This will install all the required software to generate the morphing attacks.[m
 [m
[36m@@ -39,6 +40,7 @@[m [mThe projection process relies on several pre-existing models:[m
 [m
 [m
 In order to download those models, one must specify the destination path of choice in the ``~/.bobrc`` file, through the following commands::[m
[32m+[m
     $ bob config set sg2_morph.dlib_lmd_path /path/to/dlib/landmark/detector.dat[m
     $ bob config set sg2_morph.sg2_path /path/to/stylegan2/pretrained/model.pkl[m
     $ bob config set sg2_morph.vgg16_path /path/to/vgg16/pretrained/model.pkl[m
[36m@@ -53,6 +55,7 @@[m [mGenerating Morphs[m
 [m
 The script options can be viewed with::[m
 [m
[32m+[m[32m    $ conda activate bob.paper.icassp2021_morph[m
     $ python gen_morphs.py -h[m
 [m
 The morphs of the following types of morphs can be generated at different alphas:[m
[36m@@ -64,7 +67,6 @@[m [mThe morphs of the following types of morphs can be generated at different alphas[m
 [m
 Typical usage::[m
 [m
[31m-    $ conda activate bob.paper.icassp2021_morph[m
     $ python gen_morphs.py --opencv --facemorpher --stylegan2 --mipgan2 -s path/to/folder/of/images/ -l path/to/csv/of/pairs.csv -d path/to/destination/folder --latents path/to/latent/vectors --alphas 0.3 0.5 0.7[m
 [m
 The ``pairs.csv`` file should simply be a 2 column `.csv` file **without a header** containing only the filenames of the 2 images you want to morph:[m
[36m@@ -92,7 +94,6 @@[m [mdevelopment team by asking your question on `stackoverflow`_  and with the tag *[m
 [m
 .. _author: eklavya.sarkar@idiap.ch[m
 .. _bob: https://www.idiap.ch/software/bob[m
[31m-.. _installation: https://www.idiap.ch/software/bob/install[m
 .. _conda: https://conda.io[m
 .. _stackoverflow: https://stackoverflow.com/questions/tagged/python-bob[m
 .. _example: http://dlib.net/face_landmark_detection.py.html[m
