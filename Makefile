# Target mobile architecture parameters
TARGET := iphone:clang:latest:15.0
ARCHS := arm64 arm64e

# Include standard framework configurations
include $(THEOS)/makefiles/common.mk

# Tweak Project Definition
TWEAK_NAME := CustomBatteryUI

# Deployment source files linked for compilation
CustomBatteryUI_FILES := SBUIControllerHook.x
CustomBatteryUI_CFLAGS := -fobjc-arc
CustomBatteryUI_FRAMEWORKS := UIKit

include $(THEOS_MAKE_PATH)/tweak.mk
