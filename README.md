# ros-bridge

### ROS Bridge Server

```sh
docker build -t ros_noetic_bridge .
docker run -d --name ros_noetic_bridge_container -p 9090:9090 ros_noetic_bridge
docker exec -it ros_noetic_bridge_container bash -c "source /opt/ros/noetic/setup.bash && roslaunch rosbridge_server rosbridge_websocket.launch"
```


### sample

```sh
rye sync
cd ros_bridge
python ros-sample.py
```
