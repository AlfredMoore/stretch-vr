# Stretch-VR
Stretch ROS, Stretch Mujoco and VR for Unity.

## Getting Started

This repository holds ROS 2 Humble package to bridge Mujoco simulator with Stretch SE3 robot. 

### Environment Setup
#### OS 
 * Ubuntu >= 20.04

#### Container
 * [Docker](https://docs.docker.com/engine/install/ubuntu/)(optional but recommended), you can directly use [this docker repo](https://github.com/AlfredMoore/ros-docker-dev) for quick deploy a ROS Humble container.
```bash
git clone https://github.com/AlfredMoore/ros-docker-dev
cd ros-docker-dev
export ROS_DISTRO=humble
export CUDA=1
./enterpoint.sh
# Now you are in the container
```

#### Repository Setup
 * Clone this repo 
```bash
git clone https://github.com/AlfredMoore/stretch-vr.git
cd stretch-vr
```
 * Initialize submodules, it takes a while.
```bashs
git submodule update --init --recursive --remote
```
 * Install dependencies, selectively run the following scripts
```bash
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
cd ../

# Install Stretch ROS2 dependencies
cd stretch_ros2
rosdep update
rosdep install --from-paths . -r -y
cd ../

# Download assets
python robocasa/scripts/download_kitchen_assets.py
python robocasa/scripts/setup_macros.py   
```
**Note**: You would better only run `python robocasa/scripts/download_kitchen_assets.py` once, because they always download GBs of data even if the data already exists.
**Test**: You can run `python stretch_ros2/stretch_mujoco_ros2/tools/stretch_mujoco_test.py` to test if robocasa runs well.

#### Build Simulation Scene 
 * Build the simulation scene by runnning [robocasa_gen.py](./stretch_ros2/stretch_mujoco_ros2/tools/robocasa_gen.py), you are supposed to select options in the script.
```bash
python3 stretch_ros2/stretch_mujoco_ros2/tools/robocasa_gen.py
```
Options: `--task`, `--layout`, `--style`, `--write-to-file`

The generated scene will be saved to `stretch_ros2/stretch_mujoco_ros2/scene/scene.xml` by default.

#### Compile ROS packages
```bash
cd stretch_ros2
colcon build --symlink-install 
source install/setup.bash
```

### Try MuJoCo-ROS2
```bash
ros2 launch stretch_mujoco_ros2 stretch_sim.launch.py broadcast_odom_tf:=True
```
After launching, you will see MuJoCo simulation UI and RViz2. The odom frame is exactly the real stretch base IMU.

Then try the [simple IPython interface](./stretch_ros2/stretch_mujoco_ros2/stretch_mujoco_ros2/interaction_node.ipynb).

You could try difference CLI command through `os.system`, call service or publish topics. 