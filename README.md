# pyCEC
This is a work in-progress to build a minimal container to run [pyCEC](https://github.com/konikvranik/pyCEC) in order to run [Home Assistant](https://www.home-assistant.io/)'s [HDMI-CEC Integration](https://www.home-assistant.io/integrations/hdmi_cec/) over the network.

Currently this build should work with USB-based controllers by running:
```
docker run -itd \
  --restart always \
  --device /dev/ttyACM0 \
  -p 9526:9526 \
  --name pyCEC \
  ghcr.io/kevinreedy/pyCEC
```

This image does not yet support [Raspberry Pi](https://www.raspberrypi.org/)'s built-in CEC controller. For now, you can run [Home Assistant](https://www.home-assistant.io/)'s image to accomplish this:
```
docker run -itd \
  --restart always \
  --privileged \
  -p 9526:9526 \
  --name pyCEC \
  homeassistant/raspberrypi3-homeassistant:stable \
  python -m pycec
```
Note that you'll need to update the Docker container to match your hardware.
