LOCAL_PATH := $(call my-dir)/libopus
include $(CLEAR_VARS)
LOCAL_MODULE := opus
LOCAL_OPUS_VERSION := '"1.5.2"'
LOCAL_CFLAGS := -DPACKAGE_VERSION=$(LOCAL_OPUS_VERSION)
# Fix for Windows, not related to opus: https://stackoverflow.com/questions/12598933
LOCAL_SHORT_COMMANDS := true
APP_SHORT_COMMANDS := true

# The variable declarations in this file is based on
# https://android.googlesource.com/platform/external/libopus/+/5ba9953ee4045966d61fe4b65a307fb80679bbd8/Android.bp
# Note that in LOCAL_CFLAGS += instead of := is used!

# export_include_dirs and local_include_dirs
LOCAL_C_INCLUDES := \
$(LOCAL_PATH)/include \
$(LOCAL_PATH)/src \
$(LOCAL_PATH)/silk \
$(LOCAL_PATH)/celt \
$(LOCAL_PATH)/silk/fixed

# srcs
LOCAL_SRC_FILES := \
$(LOCAL_PATH)/celt/bands.c \
$(LOCAL_PATH)/celt/celt.c \
$(LOCAL_PATH)/celt/celt_encoder.c \
$(LOCAL_PATH)/celt/celt_decoder.c \
$(LOCAL_PATH)/celt/cwrs.c \
$(LOCAL_PATH)/celt/entcode.c \
$(LOCAL_PATH)/celt/entdec.c \
$(LOCAL_PATH)/celt/entenc.c \
$(LOCAL_PATH)/celt/kiss_fft.c \
$(LOCAL_PATH)/celt/laplace.c \
$(LOCAL_PATH)/celt/mathops.c \
$(LOCAL_PATH)/celt/mdct.c \
$(LOCAL_PATH)/celt/modes.c \
$(LOCAL_PATH)/celt/pitch.c \
$(LOCAL_PATH)/celt/celt_lpc.c \
$(LOCAL_PATH)/celt/quant_bands.c \
$(LOCAL_PATH)/celt/rate.c \
$(LOCAL_PATH)/celt/vq.c \
$(LOCAL_PATH)/silk/CNG.c \
$(LOCAL_PATH)/silk/code_signs.c \
$(LOCAL_PATH)/silk/init_decoder.c \
$(LOCAL_PATH)/silk/decode_core.c \
$(LOCAL_PATH)/silk/decode_frame.c \
$(LOCAL_PATH)/silk/decode_parameters.c \
$(LOCAL_PATH)/silk/decode_indices.c \
$(LOCAL_PATH)/silk/decode_pulses.c \
$(LOCAL_PATH)/silk/decoder_set_fs.c \
$(LOCAL_PATH)/silk/dec_API.c \
$(LOCAL_PATH)/silk/enc_API.c \
$(LOCAL_PATH)/silk/encode_indices.c \
$(LOCAL_PATH)/silk/encode_pulses.c \
$(LOCAL_PATH)/silk/gain_quant.c \
$(LOCAL_PATH)/silk/interpolate.c \
$(LOCAL_PATH)/silk/LP_variable_cutoff.c \
$(LOCAL_PATH)/silk/NLSF_decode.c \
$(LOCAL_PATH)/silk/NSQ.c \
$(LOCAL_PATH)/silk/NSQ_del_dec.c \
$(LOCAL_PATH)/silk/PLC.c \
$(LOCAL_PATH)/silk/shell_coder.c \
$(LOCAL_PATH)/silk/tables_gain.c \
$(LOCAL_PATH)/silk/tables_LTP.c \
$(LOCAL_PATH)/silk/tables_NLSF_CB_NB_MB.c \
$(LOCAL_PATH)/silk/tables_NLSF_CB_WB.c \
$(LOCAL_PATH)/silk/tables_other.c \
$(LOCAL_PATH)/silk/tables_pitch_lag.c \
$(LOCAL_PATH)/silk/tables_pulses_per_block.c \
$(LOCAL_PATH)/silk/VAD.c \
$(LOCAL_PATH)/silk/control_audio_bandwidth.c \
$(LOCAL_PATH)/silk/quant_LTP_gains.c \
$(LOCAL_PATH)/silk/VQ_WMat_EC.c \
$(LOCAL_PATH)/silk/HP_variable_cutoff.c \
$(LOCAL_PATH)/silk/NLSF_encode.c \
$(LOCAL_PATH)/silk/NLSF_VQ.c \
$(LOCAL_PATH)/silk/NLSF_unpack.c \
$(LOCAL_PATH)/silk/NLSF_del_dec_quant.c \
$(LOCAL_PATH)/silk/process_NLSFs.c \
$(LOCAL_PATH)/silk/stereo_LR_to_MS.c \
$(LOCAL_PATH)/silk/stereo_MS_to_LR.c \
$(LOCAL_PATH)/silk/check_control_input.c \
$(LOCAL_PATH)/silk/control_SNR.c \
$(LOCAL_PATH)/silk/init_encoder.c \
$(LOCAL_PATH)/silk/control_codec.c \
$(LOCAL_PATH)/silk/A2NLSF.c \
$(LOCAL_PATH)/silk/ana_filt_bank_1.c \
$(LOCAL_PATH)/silk/biquad_alt.c \
$(LOCAL_PATH)/silk/bwexpander_32.c \
$(LOCAL_PATH)/silk/bwexpander.c \
$(LOCAL_PATH)/silk/debug.c \
$(LOCAL_PATH)/silk/decode_pitch.c \
$(LOCAL_PATH)/silk/inner_prod_aligned.c \
$(LOCAL_PATH)/silk/lin2log.c \
$(LOCAL_PATH)/silk/log2lin.c \
$(LOCAL_PATH)/silk/LPC_analysis_filter.c \
$(LOCAL_PATH)/silk/LPC_fit.c \
$(LOCAL_PATH)/silk/LPC_inv_pred_gain.c \
$(LOCAL_PATH)/silk/table_LSF_cos.c \
$(LOCAL_PATH)/silk/NLSF2A.c \
$(LOCAL_PATH)/silk/NLSF_stabilize.c \
$(LOCAL_PATH)/silk/NLSF_VQ_weights_laroia.c \
$(LOCAL_PATH)/silk/pitch_est_tables.c \
$(LOCAL_PATH)/silk/resampler.c \
$(LOCAL_PATH)/silk/resampler_down2_3.c \
$(LOCAL_PATH)/silk/resampler_down2.c \
$(LOCAL_PATH)/silk/resampler_private_AR2.c \
$(LOCAL_PATH)/silk/resampler_private_down_FIR.c \
$(LOCAL_PATH)/silk/resampler_private_IIR_FIR.c \
$(LOCAL_PATH)/silk/resampler_private_up2_HQ.c \
$(LOCAL_PATH)/silk/resampler_rom.c \
$(LOCAL_PATH)/silk/sigm_Q15.c \
$(LOCAL_PATH)/silk/sort.c \
$(LOCAL_PATH)/silk/sum_sqr_shift.c \
$(LOCAL_PATH)/silk/stereo_decode_pred.c \
$(LOCAL_PATH)/silk/stereo_encode_pred.c \
$(LOCAL_PATH)/silk/stereo_find_predictor.c \
$(LOCAL_PATH)/silk/stereo_quant_pred.c \
$(LOCAL_PATH)/silk/fixed/LTP_analysis_filter_FIX.c \
$(LOCAL_PATH)/silk/fixed/LTP_scale_ctrl_FIX.c \
$(LOCAL_PATH)/silk/fixed/corrMatrix_FIX.c \
$(LOCAL_PATH)/silk/fixed/encode_frame_FIX.c \
$(LOCAL_PATH)/silk/fixed/find_LPC_FIX.c \
$(LOCAL_PATH)/silk/fixed/find_LTP_FIX.c \
$(LOCAL_PATH)/silk/fixed/find_pitch_lags_FIX.c \
$(LOCAL_PATH)/silk/fixed/find_pred_coefs_FIX.c \
$(LOCAL_PATH)/silk/fixed/noise_shape_analysis_FIX.c \
$(LOCAL_PATH)/silk/fixed/process_gains_FIX.c \
$(LOCAL_PATH)/silk/fixed/regularize_correlations_FIX.c \
$(LOCAL_PATH)/silk/fixed/residual_energy16_FIX.c \
$(LOCAL_PATH)/silk/fixed/residual_energy_FIX.c \
$(LOCAL_PATH)/silk/fixed/warped_autocorrelation_FIX.c \
$(LOCAL_PATH)/silk/fixed/apply_sine_window_FIX.c \
$(LOCAL_PATH)/silk/fixed/autocorr_FIX.c \
$(LOCAL_PATH)/silk/fixed/burg_modified_FIX.c \
$(LOCAL_PATH)/silk/fixed/k2a_FIX.c \
$(LOCAL_PATH)/silk/fixed/k2a_Q16_FIX.c \
$(LOCAL_PATH)/silk/fixed/pitch_analysis_core_FIX.c \
$(LOCAL_PATH)/silk/fixed/vector_ops_FIX.c \
$(LOCAL_PATH)/silk/fixed/schur64_FIX.c \
$(LOCAL_PATH)/silk/fixed/schur_FIX.c \
$(LOCAL_PATH)/src/mapping_matrix.c \
$(LOCAL_PATH)/src/opus.c \
$(LOCAL_PATH)/src/opus_decoder.c \
$(LOCAL_PATH)/src/opus_encoder.c \
$(LOCAL_PATH)/src/opus_multistream.c \
$(LOCAL_PATH)/src/opus_multistream_encoder.c \
$(LOCAL_PATH)/src/opus_multistream_decoder.c \
$(LOCAL_PATH)/src/opus_projection_encoder.c \
$(LOCAL_PATH)/src/opus_projection_decoder.c \
$(LOCAL_PATH)/src/repacketizer.c \
$(LOCAL_PATH)/src/extensions.c \
$(LOCAL_PATH)/src/analysis.c \
$(LOCAL_PATH)/src/mlp.c \
$(LOCAL_PATH)/src/mlp_data.c

# cflags
LOCAL_CFLAGS += \
-DNULL=0 \
-DSOCKLEN_T=socklen_t \
-DLOCALE_NOT_USED \
-D_LARGEFILE_SOURCE=1 \
-D_FILE_OFFSET_BITS=64 \
-Drestrict= \
-D__EMX__ \
-DOPUS_BUILD \
-DFIXED_POINT \
-DUSE_ALLOCA \
-DSIMD_EXTRA_ALLOC_BYTES=16 \
-DHAVE_LRINT \
-DHAVE_LRINTF \
-DENABLE_HARDENING \
-O2 \
-fno-math-errno \
-Wall \
-Werror

# cppflags
LOCAL_CPPFLAGS := \
-DBSD=1 \
-ffast-math \
-O2 \
-funroll-loops

# arch.arm.srcs
LOCAL_ARM_SRCS := \
$(LOCAL_PATH)/celt/arm/armcpu.c \
$(LOCAL_PATH)/celt/arm/arm_celt_map.c \
$(LOCAL_PATH)/celt/arm/celt_pitch_xcorr_arm_gnu.s \
$(LOCAL_PATH)/celt/arm/armopts_gnu.s \
$(LOCAL_PATH)/celt/arm/celt_neon_intr.c \
$(LOCAL_PATH)/celt/arm/pitch_neon_intr.c \
$(LOCAL_PATH)/silk/arm/arm_silk_map.c \
$(LOCAL_PATH)/silk/arm/biquad_alt_neon_intr.c \
$(LOCAL_PATH)/silk/arm/LPC_inv_pred_gain_neon_intr.c \
$(LOCAL_PATH)/silk/arm/NSQ_del_dec_neon_intr.c \
$(LOCAL_PATH)/silk/arm/NSQ_neon.c \
$(LOCAL_PATH)/silk/fixed/arm/warped_autocorrelation_FIX_neon_intr.c

# arch.arm.cflags
LOCAL_ARM_CFLAGS := \
-DOPUS_ARM_ASM \
-DOPUS_ARM_INLINE_ASM \
-DOPUS_ARM_MAY_HAVE_EDSP \
-DOPUS_ARM_INLINE_EDSP \
-DOPUS_ARM_MAY_HAVE_MEDIA \
-DOPUS_ARM_INLINE_MEDIA \
-DOPUS_ARM_MAY_HAVE_NEON \
-DOPUS_ARM_MAY_HAVE_NEON_INTR \
-DOPUS_ARM_PRESUME_NEON \
-DOPUS_ARM_INLINE_NEON \
-DOPUS_HAVE_RTCD

# arch.arm64
# TODO: opus 1.5 has support for arm64 (AARCH64) too.
 
# arch.x86.ssse3.srcs
LOCAL_X86_SSSE3_SRCS := \
$(LOCAL_PATH)/celt/x86/x86cpu.c \
$(LOCAL_PATH)/celt/x86/x86_celt_map.c \
$(LOCAL_PATH)/celt/x86/pitch_sse.c \
$(LOCAL_PATH)/celt/x86/pitch_sse2.c \
$(LOCAL_PATH)/celt/x86/vq_sse2.c

# arch.x86.ssse3.cflags
LOCAL_X86_SSSE3_CFLAGS := \
-DOPUS_X86_MAY_HAVE_SSE \
-DOPUS_X86_PRESUME_SSE \
-DOPUS_X86_MAY_HAVE_SSE2 \
-DOPUS_X86_PRESUME_SSE2

# arch.x86.sse4_1.srcs
LOCAL_X86_SSE4_1_SRCS := \
$(LOCAL_PATH)/celt/x86/celt_lpc_sse4_1.c \
$(LOCAL_PATH)/celt/x86/pitch_sse4_1.c \
$(LOCAL_PATH)/silk/x86/NSQ_sse4_1.c \
$(LOCAL_PATH)/silk/x86/NSQ_del_dec_sse4_1.c \
$(LOCAL_PATH)/silk/x86/x86_silk_map.c \
$(LOCAL_PATH)/silk/x86/VAD_sse4_1.c \
$(LOCAL_PATH)/silk/x86/VQ_WMat_EC_sse4_1.c \
$(LOCAL_PATH)/silk/fixed/x86/vector_ops_FIX_sse4_1.c \
$(LOCAL_PATH)/silk/fixed/x86/burg_modified_FIX_sse4_1.c

# arch.x86.sse4_1.cflags
LOCAL_X86_SSE4_1_CFLAGS := \
-DOPUS_X86_MAY_HAVE_SSE4_1 \
-DOPUS_X86_PRESUME_SSE4_1

# arch.x86_64.ssse3.srcs
LOCAL_X86_64_SSSE3_SRCS := \
$(LOCAL_PATH)/celt/x86/x86cpu.c \
$(LOCAL_PATH)/celt/x86/x86_celt_map.c \
$(LOCAL_PATH)/celt/x86/pitch_sse.c \
$(LOCAL_PATH)/celt/x86/pitch_sse2.c \
$(LOCAL_PATH)/celt/x86/vq_sse2.c

# arch.x86_64.ssse3.cflags
LOCAL_X86_64_SSSE3_CFLAGS := \
-DOPUS_X86_MAY_HAVE_SSE \
-DOPUS_X86_PRESUME_SSE \
-DOPUS_X86_MAY_HAVE_SSE2 \
-DOPUS_X86_PRESUME_SSE2

# arch.x86_64.sse4_1.srcs
LOCAL_X86_64_SSE4_1_SRCS := \
$(LOCAL_PATH)/celt/x86/celt_lpc_sse4_1.c \
$(LOCAL_PATH)/celt/x86/pitch_sse4_1.c \
$(LOCAL_PATH)/silk/x86/NSQ_sse4_1.c \
$(LOCAL_PATH)/silk/x86/NSQ_del_dec_sse4_1.c \
$(LOCAL_PATH)/silk/x86/x86_silk_map.c \
$(LOCAL_PATH)/silk/x86/VAD_sse4_1.c \
$(LOCAL_PATH)/silk/x86/VQ_WMat_EC_sse4_1.c \
$(LOCAL_PATH)/silk/fixed/x86/vector_ops_FIX_sse4_1.c \
$(LOCAL_PATH)/silk/fixed/x86/burg_modified_FIX_sse4_1.c

# arch.x86_64.sse4_1.cflags
LOCAL_X86_64_SSE4_1_CFLAGS := \
-DOPUS_X86_MAY_HAVE_SSE4_1 \
-DOPUS_X86_PRESUME_SSE4_1


# Apply files for each abi based on https://developer.android.com/ndk/guides/android_mk
ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
    LOCAL_SRC_FILES += $(LOCAL_ARM_SRCS)
    LOCAL_CFLAGS += $(LOCAL_ARM_CFLAGS)
endif
# Since in the current release, the Android.bp this .mk file is based
# on does not support arm64-v8a yet, this block is empty
ifeq ($(TARGET_ARCH_ABI),arm64-v8a)
endif
# Acording to https://developer.android.com/ndk/guides/abis...
# ...Android x86 supports SSSE3
ifeq ($(TARGET_ARCH_ABI),x86)
    LOCAL_SRC_FILES += $(LOCAL_X86_SSSE3_SRCS)
    LOCAL_CFLAGS += $(LOCAL_X86_SSSE3_CFLAGS)
endif
# ...and Android x86_64 supports SSSE3 and SSE4.1
ifeq ($(TARGET_ARCH_ABI),x86_64)
    LOCAL_SRC_FILES += $(LOCAL_X86_64_SSSE3_SRCS) $(LOCAL_X86_64_SSE4_1_SRCS)
    LOCAL_CFLAGS += $(LOCAL_X86_64_SSSE3_CFLAGS) $(LOCAL_X86_64_SSE4_1_CFLAGS)
endif

include $(BUILD_SHARED_LIBRARY)