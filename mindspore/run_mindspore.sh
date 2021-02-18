set -x

prefix_path="mindspore-lite-1.1.0-inference-android-aarch32"

#$ADB shell rm -rf /data/local/tmp/mindspore
$ADB mkdir -p /data/local/tmp/mindspore

$ADB push ./${prefix_path}/benchmark/benchmark /data/local/tmp/mindspore/benchmark
$ADB push ./${prefix_path}/lib/libmindspore-lite.so /data/local/tmp/mindspore/libmindspore-lite.so
$ADB push ./${prefix_path}/lib/liboptimize.so /data/local/tmp/mindspore/liboptimize.so
$ADB push ./${prefix_path}/lib/libc++_shared.so /data/local/tmp/mindspore/libc++_shared.so

$ADB push ./tf_mobilenetv1.ms /data/local/tmp/mindspore/tf_mobilenetv1.ms
$ADB push ./tf_mobilenetv2.ms /data/local/tmp/mindspore/tf_mobilenetv2.ms
$ADB push ./caffe_mobilenetv1.ms /data/local/tmp/mindspore/caffe_mobilenetv1.ms
$ADB push ./caffe_mobilenetv2.ms /data/local/tmp/mindspore/caffe_mobilenetv2.ms


$ADB shell chmod +x /data/local/tmp/mindspore/benchmark
$ADB shell /data/local/tmp/mindspore/benchmark

# https://www.mindspore.cn/lite/tutorial/zh-CN/master/use/evaluating_the_model.html
#$ADB shell "export LD_LIBRARY_PATH=/data/local/tmp/mindspore/; \
#  /data/local/tmp/mindspore/benchmark \
#  --bleFp16mbleFp16odelPath=<xxx> \
#  --device=<CPU|GPU> \
#  --cpuBindMode=<-1:midcore, 1: bigcore, 0:nobind> \
#  --numThreads=<2> \
#  --loopCount=10 \
#  --warmUpLoopCount=3 \
#  --enableFp16=<false|true>"

$ADB shell "export LD_LIBRARY_PATH=/data/local/tmp/mindspore/; \
  /data/local/tmp/mindspore/benchmark \
  --modelFile=/data/local/tmp/mindspore/tf_mobilenetv1.ms \
  --device=GPU \
  --cpuBindMode=1 \
  --numThreads=1 \
  --loopCount=1000 \
  --warmUpLoopCount=20 \
  --enableFp16=true"

$ADB shell "export LD_LIBRARY_PATH=/data/local/tmp/mindspore/; \
  /data/local/tmp/mindspore/benchmark \
  --modelFile=/data/local/tmp/mindspore/tf_mobilenetv2.ms \
  --device=GPU \
  --cpuBindMode=1 \
  --numThreads=1 \
  --loopCount=1000 \
  --warmUpLoopCount=20 \
  --enableFp16=true"

$ADB shell "export LD_LIBRARY_PATH=/data/local/tmp/mindspore/; \
  /data/local/tmp/mindspore/benchmark \
  --modelFile=/data/local/tmp/mindspore/caffe_mobilenetv1.ms \
  --device=GPU \
  --cpuBindMode=1 \
  --numThreads=1 \
  --loopCount=1000 \
  --warmUpLoopCount=20 \
  --enableFp16=true"

$ADB shell "export LD_LIBRARY_PATH=/data/local/tmp/mindspore/; \
  /data/local/tmp/mindspore/benchmark \
  --modelFile=/data/local/tmp/mindspore/caffe_mobilenetv2.ms \
  --device=GPU \
  --cpuBindMode=1 \
  --numThreads=1 \
  --loopCount=1000 \
  --warmUpLoopCount=20 \
  --enableFp16=true"
