#!/usr/bin/bash

# git submodule update --init --recursive --remote        # Update submodules

python3 -m pip install  -U hello-robot-stretch-urdf     # Stretch URDF


# Install Stretch Mujoco
pip3 install mujoco
cd stretch_mujoco
pip install -e .
cd ..

# Install Robosuite
cd robosuite
pip install -e .
cd ../

# Install Robocasa and assets
cd robocasa
pip install -e .
pip install numba

# Download assets
python robocasa/scripts/download_kitchen_assets.py
python robocasa/scripts/setup_macros.py   