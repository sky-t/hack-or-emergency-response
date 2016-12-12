#!/bin/bash

echo 'Installing miniconda'
#check to see if the file's already been downloaded (this step could be skiped)
if [ ! -f ~/proj/Miniconda3-latest-Linux-x86_64.sh ]
then
  #if the file hasn't been downlaoded, go get it.
  wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/proj/Miniconda3-latest-Linux-x86_64.sh
fi

#execute the install program in batch mode (it won't ask for prompts and won't modify the path)
bash ~/proj/Miniconda3-latest-Linux-x86_64.sh -b

#modify the path in profile
echo 'export PATH=~/miniconda3/bin:${PATH}' >> ~/.profile

#modify the path for the rest of this scripts
export PATH=~/miniconda3/bin:${PATH}

echo 'setting up Jupyter'
conda install -y jupyter

echo 'setting up cvdjango'
conda create -y -n cvdjango python django psycopg2
source activate cvdjango
pip install djangorestframework

source deactivate cvdjango

echo 'setting up data analysis tools'
pip install psycopg2
pip install numpy
pip install matplotlib
pip install pandas
pip install seaborn

