THEOS_DEVICE_IP=192.168.2.14

INSTALL_TARGET_PROCESSES = WeChat

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = wechatplusplus

wechatplusplus_FILES = Tweak.xm
wechatplusplus_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
