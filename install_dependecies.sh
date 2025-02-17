#!/usr/bin/bash

git submodule update --init --recursive --remote        # Update submodules

python3 -m pip install  -U hello-robot-stretch-urdf     # Stretch URDF


# Install Stretch Mujoco
pip3 install mujoco
cd stretch_mujoco
pip install -e .
cd ..

# Install Robosuite
# git clone https://github.com/ARISE-Initiative/robosuite -b robocasa_v0.1
# cd robosuite
# pip install -e .
# cd ../
# git clone https://github.com/robocasa/robocasa
# cd robocasa
# pip install -e .
# conda install -c numba numba -y
# python robocasa/scripts/download_kitchen_assets.py  
# python robocasa/scripts/setup_macros.py   