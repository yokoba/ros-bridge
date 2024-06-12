import time

import roslibpy

# rosbridgeサーバに接続
ros = roslibpy.Ros(host="localhost", port=9090)
ros.run()

# トピックの設定
topic = roslibpy.Topic(ros, "/example_topic", "std_msgs/String")


# パブリッシュ関数
def publish_message():
    message = roslibpy.Message({"data": "Hello, ROS!"})
    topic.publish(message)
    print("Published message:", message)


# サブスクライブコールバック関数
def subscription_callback(message):
    print("Received message:", message["data"])


# トピックのサブスクライブ
topic.subscribe(subscription_callback)

try:
    while ros.is_connected:
        publish_message()
        time.sleep(1)
except KeyboardInterrupt:
    pass

# クリーンアップ
topic.unsubscribe()
ros.terminate()
