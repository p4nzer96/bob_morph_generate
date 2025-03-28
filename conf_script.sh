mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm ~/miniconda3/miniconda.sh

. ~/miniconda3/bin/activate

conda init --all

conda env create -f environment.yml -n bob_env

conda activate bob_env

bob config set sg2_morph.dlib_lmd_path $(pwd)/models/dlib/landmark/detector.dat
bob config set sg2_morph.sg2_path $(pwd)/models/stylegan2/pretrained/model.pkl
bob config set sg2_morph.vgg16_path $(pwd)/vgg16/pretrained/model.pkl

python download_models.py
