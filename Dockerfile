# ベースイメージとしてUbuntu 20.04を使用
FROM ubuntu:20.04

# 環境変数の設定
ENV DEBIAN_FRONTEND=noninteractive

# 基本パッケージのインストールと更新
RUN apt-get update && apt install -y curl gnupg lsb-release

# ROSのキーを追加
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -

# # ROSのソースリストを追加
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

# パッケージリストを更新し、ROS Noeticのデスクトップフルバージョンをインストール
RUN apt-get update && apt-get install -y \
    ros-noetic-ros-base \
    && rm -rf /var/lib/apt/lists/*


RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc 

RUN apt-get update && apt install -y \
    python3-rosdep \
    python3-rosinstall \
    python3-rosinstall-generator \
    python3-wstool \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt install -y \
    python3-rosdep \
    && rm -rf /var/lib/apt/lists/*

RUN rosdep init && rosdep update


# rosbridge_suiteのインストール
RUN apt-get update && apt-get install -y \
    ros-noetic-rosbridge-suite \
    && rm -rf /var/lib/apt/lists/*

# デフォルトのコマンドをroscoreに設定
CMD ["bash", "-c", "source /opt/ros/noetic/setup.bash && roscore"]
