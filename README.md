# Are GAN-based Morphs Threatening Face Recognition?

This repository is a fork of the work proposed in the paper _"Are GAN-based Morphs Threatening Face Recognition?"_ by Eklavya Sarkar, Pavel Korshunov, Laurent Colbois and Sébastien Marcel. The original work was presented at ICASSP 2022. The original repository is available at https://gitlab.idiap.ch/bob/bob.paper.icassp2022_morph_generate.

```
    @INPROCEEDINGS{Sarkar_ICASSP_2022,
        author    = {Sarkar, Eklavya and Korshunov, Pavel and Colbois, Laurent and Marcel, Sébastien},
        booktitle = {ICASSP 2022 - 2022 IEEE International Conference on Acoustics, Speech and Signal Processing (ICASSP)}, 
        title     = {Are GAN-based morphs threatening face recognition?},
        projects  = {Idiap, Biometrics Center},
        year      = {2022},
        pages     = {2959-2963},
        doi       = {10.1109/ICASSP43922.2022.9746477},
        note      = {Accepted for Publication in ICASSP2022},
        pdf       = {http://publications.idiap.ch/attachments/papers/2022/Sarkar_ICASSP_2022.pdf}
    }
``` 

## Basic installation

### Requirements

This section provides a quick installation guide for the tool. In order to correct install the packages, you must meet the following requirements:

* **Anaconda** or **Miniconda** distribution (w/ **Python** 3.7 or higher)

* **NVIDIA CUDA Toolkit** 10.x (with a compatible **gcc** version, i.e prior to 8). Please refer to https://developer.nvidia.com/cuda-10.0-download-archive

> Note: the installation process may work with other versions of CUDA, but it is not guaranteed

### Environment setup

Download the source code of this paper and unpack it. 
Then, you can create and activate the required conda environment with the following commands:

```bash
    $ cd bob_morph_generate # or the path where you cloned the code
    $ conda env create -f environment.yml -n <environment_name>    
    $ conda activate <environment_name>
```
This will install all the required software to generate the morphing attacks.

### Downloading Models

The projection process relies on several pre-existing models:

* **DLIB Face Landmark detector** for cropping and aligning the projected faces exactly as in FFHQ
* **StyleGAN2** as the main face synthesis network. We fork the official [repository](https://github.com/NVlabs/stylegan2). The Config-F, trained on FFHQ at resolution 1024 x 1024, is employed.
* A pretrained **VGG16** model, used to compute a perceptual loss between projected and target image.


In order to download those models, one must specify the destination path of choice in the ```~/.bobrc``` file, through the following commands:

```bash
    $ bob config set sg2_morph.dlib_lmd_path </path/to/dlib/landmark/detector.dat>
    $ bob config set sg2_morph.sg2_path </path/to/stylegan2/pretrained/model.pkl>
    $ bob config set sg2_morph.vgg16_path </path/to/vgg16/pretrained/model.pkl>
```

Finally, all the models can be downloaded by running:

```bash
    $ python download_models.py
```

## Installation with Docker

### Requirements

The installation process described above can be simplified by using Docker. The Dockerfile is provided in the repository. In order to build the Docker image, you must meet the following requirements:

* **Docker** installed on your machine. Please refer to https://docs.docker.com/get-docker/

* **NVIDIA Container Toolkit** installed on your machine. Please refer to https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html

### Build the Docker image
To build the Docker image, run the following command in the root directory of the repository:

```bash
    $ docker build -t <image_name> .
```
### Run the Docker container
To run the Docker container, use the following command:

```bash
    $ docker run -i --runtime=nvidia --gpus all -v <path_to_your_data>:/data -t <image_name>
```

> Note: in order to run the container as non-roor user please refere to the post installation steps in the links above.

Once you access the container, you will be in directory `/bob_mgen`, which is the working directory of the repository. Before running the code, you need to activate the conda environment by running the following command:

```bash
    $ conda activate bob_env
```

### Troubleshooting
If you encounter the following error when running the Docker container:

```bash
    Failed to initialize NVML: Unknown Error
```

you can try to fix it by running the following command:

```bash
$ sudo nano /etc/nvidia-container-runtime/config.toml
```
and setting the parameter `no-cgroups` to `false` inside the file:

```text
    no-cgroups = false
```

## Generating Morphs

**Note**: StyleGAN2 requires custom GPU-only operations, and at least 12 GB of GPU RAM. Therefore, to run all following examples and perform additional experiments, it is necessary to run this code on a GPU.

The script options can be viewed with

```bash
    $ conda activate <environment_name>
    $ python gen_morphs.py -h
```

The morphs of the following types of morphs can be generated at different alphas:

* OpenCV
* FaceMorpher
* StyleGAN2
* MIPGAN-II

**Typical usage:**

```bash
    $ python gen_morphs.py --opencv --facemorpher --stylegan2 --mipgan2 -s path/to/folder/of/images/ -l path/to/csv/of/pairs.csv -d path/to/destination/folder --latents path/to/latent/vectors --alphas 0.3 0.5 0.7
```

The ```pairs.csv``` file should simply be a 2 column `.csv` file **without a header** containing only the filenames of the 2 images you want to morph:

```csv
image1.png, image2.png
image1.png, image3.png
```

**Note**: Keep in mind that for the ```--stylegan2``` and ```--mipgan2``` arguments, it is necessary to have the latent vectors of all required images generated **beforehand**.

This can be done with the ```gen_latents.py```. 

**Typical usage:**

```bash
    $ python gen_latents.py -s <path/to/folder/of/images/>
```

License
-------

This package uses some components from the `official release of the StyleGAN2 model <https://github.com/NVlabs/stylegan2>`_, which is itself released under the `Nvidia Source Code License-NC <https://gitlab.idiap.ch/bob/bob.paper.icassp2022_morph_generate/-/blob/master/modules/LICENSE.txt>`_, as well as from `OpenCV <https://github.com/spmallick/learnopencv>`_ and `Facemorpher <https://github.com/alyssaq/face_morpher>`_ repositories, both of which are released under a "Non-Commercial Research and Educational Use Only" license.