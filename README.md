# ROS-dj
Dockerized ROS with jupyter

## Getting started

### Pull the image

    docker pull robinlab/ros-dj
    
### Build the image locally

    git clone https://github.com/RobInLabUJI/ROS-dj.git
    cd ROS-dj
    docker build -t ros-dj .

### Run the image

    docker run --name ros-dj --rm -p 8888:8888 ros-dj
    
### Open this URL in your browser

    http://localhost:8888
    
Note: If you are using Docker Toolbox on Windows, use the Docker Machine IP instead of ``localhost``. For example, http://192.168.99.100:8888. To find the IP address, use the command ``docker-machine ip``.

### Stop the container

Press `Ctrl-C` in the docker terminal.
If needed, run:

    docker container stop ros-dj
