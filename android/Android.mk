LOCAL_PATH := $(call my-dir)/libopus
include $(CLEAR_VARS)
include $(LOCAL_PATH)/celt_sources.mk
include $(LOCAL_PATH)/opus_sources.mk
include $(LOCAL_PATH)/silk_sources.mk
LOCAL_MODULE    := opus
LOCAL_OPUS_VERSION :='"1.3.1"'
# To use fixed instead of floating point arithmetic, set this to true
LOCAL_FIXED := false

ifeq ($(TARGET_ARCH_ABI),$(filter $(TARGET_ARCH_ABI), armeabi-v7a))
	LOCAL_ARM_NEON := true
	# it seems that if we want to use neon optimizations we always need fixed
	LOCAL_FIXED := true
endif

LOCAL_C_INCLUDES += $(LOCAL_PATH)/include \
					$(LOCAL_PATH)/src $(LOCAL_PATH)/silk \
                    $(LOCAL_PATH)/celt $(OGG_DIR)/include
LOCAL_SRC_FILES := $(CELT_SOURCES) $(SILK_SOURCES) \
                   $(OPUS_SOURCES) $(OPUS_SOURCES_FLOAT)
LOCAL_CFLAGS        := -DPACKAGE_VERSION=$(LOCAL_OPUS_VERSION) \
					   -DNULL=0 -DSOCKLEN_T=socklen_t -DLOCALE_NOT_USED \
                       -D_LARGEFILE_SOURCE=1 -D_FILE_OFFSET_BITS=64 \
                       -Drestrict='' -D__EMX__ -DOPUS_BUILD \
                       -DUSE_ALLOCA -DHAVE_LRINT -DHAVE_LRINTF -O2 -fno-math-errno
LOCAL_CPPFLAGS      := -DBSD=1 -ffast-math -O2 -funroll-loops


ifeq ($(LOCAL_FIXED),true)
	LOCAL_C_INCLUDES += $(LOCAL_PATH)/silk/fixed
	LOCAL_SRC_FILES += $(SILK_SOURCES_FIXED)
	LOCAL_CFLAGS        += -DFIXED_POINT
else
	LOCAL_C_INCLUDES += $(LOCAL_PATH)/silk/float
	LOCAL_SRC_FILES += $(SILK_SOURCES_FLOAT)
endif

# Note: OPUS enhanced DSP/NEON implementation is not yet compatible with arm64.
# Only add the appropriate defines for 32-bit arm architecture.
ifeq ($(LOCAL_ARM_NEON),true)
	LOCAL_SRC_FILES += $(CELT_SOURCES_ARM)
	LOCAL_CFLAGS += -DOPUS_ARM_ASM -DOPUS_ARM_INLINE_ASM \
						-DOPUS_ARM_MAY_HAVE_EDSP -DOPUS_ARM_INLINE_EDSP \
						-DOPUS_ARM_MAY_HAVE_MEDIA -DOPUS_ARM_INLINE_MEDIA \
						-DOPUS_HAVE_RTCD
	# DSP, MEDIA and NEON instructions are in the same assembler file - thus we
	# need to include it even if NEON is not supported on target platform.
	LOCAL_SRC_FILES += $(subst .s,_gnu.s,$(CELT_SOURCES_ARM_ASM))

	LOCAL_SRC_FILES += $(CELT_SOURCES_ARM_NEON_INTR) \
					   $(SILK_SOURCES_ARM_NEON_INTR) \
					   $(SILK_SOURCES_FIXED_ARM_NEON_INTR)

	LOCAL_CFLAGS += -DOPUS_ARM_MAY_HAVE_NEON -DOPUS_ARM_MAY_HAVE_NEON_INTR \
						-DOPUS_ARM_PRESUME_NEON -DOPUS_ARM_INLINE_NEON
endif

ifeq ($(TARGET_ARCH_ABI),$(filter $(TARGET_ARCH_ABI), x86 x86_64))
	ifeq ($(ARCH_X86_HAVE_SSSE3),true)
		LOCAL_SRC_FILES += $(CELT_SOURCES_SSE) $(CELT_SOURCES_SSE2)
		LOCAL_CFLAGS += -DOPUS_X86_MAY_HAVE_SSE -DOPUS_X86_PRESUME_SSE \
							-DOPUS_X86_MAY_HAVE_SSE2 -DOPUS_X86_PRESUME_SSE2
	endif
	ifeq ($(ARCH_X86_HAVE_SSE4_1),true)
		LOCAL_SRC_FILES += $(CELT_SOURCES_SSE4_1) \
						   $(SILK_SOURCES_SSE4_1)
		ifeq ($(LOCAL_FIXED),true)
			LOCAL_SRC_FILES += $(SILK_SOURCES_FIXED_SSE4_1)
		endif
		LOCAL_CFLAGS += -DOPUS_X86_MAY_HAVE_SSE4_1 -DOPUS_X86_PRESUME_SSE4_1
	endif
endif

include $(BUILD_SHARED_LIBRARY)