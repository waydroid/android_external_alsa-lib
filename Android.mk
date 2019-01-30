# external/alsa-lib/Android.mk
#
# Copyright 2008 Wind River Systems
#

#ifeq ($(strip $(BOARD_USES_ALSA_AUDIO)),true)

LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

##
## Copy ALSA configuration files to rootfs
##
alsa_conf_files := \
	alsa.conf \
	pcm/dsnoop.conf \
	pcm/modem.conf \
	pcm/dpl.conf \
	pcm/default.conf \
	pcm/surround51.conf \
	pcm/surround41.conf \
	pcm/surround50.conf \
	pcm/dmix.conf \
	pcm/center_lfe.conf \
	pcm/surround40.conf \
	pcm/side.conf \
	pcm/iec958.conf \
	pcm/rear.conf \
	pcm/surround71.conf \
	pcm/front.conf \
	cards/aliases.conf

include $(CLEAR_VARS)
LOCAL_MODULE       := alsa-conf
LOCAL_MODULE_TAGS  := optional eng
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH  := $(TARGET_OUT)/usr/share/alsa
LOCAL_SRC_FILES    := src/conf/alsa.conf
include $(BUILD_PREBUILT)

$(LOCAL_INSTALLED_MODULE):
	mkdir -p $(TARGET_OUT)/usr/share/alsa
	cd $(@D) && tar xvfz $(abspath $<)

$(LOCAL_BUILT_MODULE):
	mkdir -p $(@D)
	cd external/alsa-lib/src/conf && tar cvfz $(abspath $@) $(alsa_conf_files)

include $(CLEAR_VARS)

LOCAL_MODULE := libasound

LOCAL_MODULE_TAGS := optional eng
LOCAL_PRELINK_MODULE := false
LOCAL_ARM_MODE := arm

LOCAL_C_INCLUDES += $(LOCAL_PATH)/include

# libasound must be compiled with -fno-short-enums, as it makes extensive
# use of enums which are often type casted to unsigned ints.
LOCAL_CFLAGS := \
	-fPIC -DPIC -D_POSIX_SOURCE \
	-DALSA_CONFIG_DIR=\"/system/usr/share/alsa\" \
	-DALSA_DEVICE_DIRECTORY=\"/dev/snd/\" \
	-Wno-error

LOCAL_LDFLAGS := \
	-Wl,--no-fatal-warnings

LOCAL_SRC_FILES := src/seq/seq_old.c \
    src/seq/seq_midi_event.c \
    src/seq/seq_hw.c \
    src/seq/seqmid.c \
    src/seq/seq.c \
    src/seq/seq_symbols.c \
    src/seq/seq_event.c \
    src/timer/timer_symbols.c \
    src/timer/timer_query_hw.c \
    src/timer/timer_query.c \
    src/timer/timer_hw.c \
    src/timer/timer.c \
    src/confmisc.c \
    src/control/setup.c \
    src/control/control_shm.c \
    src/control/hcontrol.c \
    src/control/control_hw.c \
    src/control/control_ext.c \
    src/control/namehint.c \
    src/control/control.c \
    src/control/control_symbols.c \
    src/control/tlv.c \
    src/control/ctlparse.c \
    src/control/cards.c \
    src/async.c \
    src/dlmisc.c \
    src/input.c \
    src/error.c \
    src/mixer/simple_none.c \
    src/mixer/bag.c \
    src/mixer/simple_abst.c \
    src/mixer/simple.c \
    src/mixer/mixer.c \
    src/conf.c \
    src/hwdep/hwdep_symbols.c \
    src/hwdep/hwdep.c \
    src/hwdep/hwdep_hw.c \
    src/pcm/pcm_softvol.c \
    src/pcm/pcm_lfloat.c \
    src/pcm/pcm_plug.c \
    src/pcm/pcm_null.c \
    src/pcm/pcm_iec958.c \
    src/pcm/pcm_share.c \
    src/pcm/pcm_ioplug.c \
    src/pcm/pcm_route.c \
    src/pcm/pcm_mmap.c \
    src/pcm/pcm_multi.c \
    src/pcm/pcm_params.c \
    src/pcm/pcm_extplug.c \
    src/pcm/pcm_misc.c \
    src/pcm/pcm_mmap_emul.c \
    src/pcm/pcm_meter.c \
    src/pcm/pcm_hw.c \
    src/pcm/pcm_simple.c \
    src/pcm/pcm_asym.c \
    src/pcm/pcm_adpcm.c \
    src/pcm/pcm_mulaw.c \
    src/pcm/interval.c \
    src/pcm/pcm_file.c \
    src/pcm/pcm_rate_linear.c \
    src/pcm/pcm_empty.c \
    src/pcm/pcm.c \
    src/pcm/pcm_symbols.c \
    src/pcm/pcm_linear.c \
    src/pcm/pcm_alaw.c \
    src/pcm/mask.c \
    src/pcm/pcm_generic.c \
    src/pcm/pcm_hooks.c \
    src/pcm/pcm_rate.c \
    src/pcm/pcm_plugin.c \
    src/pcm/pcm_copy.c \
    src/socket.c \
    src/names.c \
    src/userfile.c \
    src/ucm/parser.c \
    src/ucm/main.c \
    src/ucm/utils.c \
    src/topology/dapm.c \
    src/topology/text.c \
    src/topology/parser.c \
    src/topology/data.c \
    src/topology/elem.c \
    src/topology/channel.c \
    src/topology/ops.c \
    src/topology/builder.c \
    src/topology/ctl.c \
    src/topology/pcm.c \
    src/rawmidi/rawmidi_virt.c \
    src/rawmidi/rawmidi.c \
    src/rawmidi/rawmidi_symbols.c \
    src/rawmidi/rawmidi_hw.c \
    src/output.c \
    src/shmarea.c

LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/include

LOCAL_SHARED_LIBRARIES := \
    libdl

include $(BUILD_SHARED_LIBRARY)

#endif

