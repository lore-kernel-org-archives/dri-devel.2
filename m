Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 987A9C43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 21:15:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0FAE10EE5C;
	Tue, 14 Jul 2026 21:15:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TUgWtS2X";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6C1210EE5C
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 21:15:50 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4953bc61ce2so1031825e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 14:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784063749; x=1784668549; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ErW2XZrL9ajZEHhy26UY4YmMhMbEwdTPLY3anMh4sIY=;
 b=TUgWtS2XeHjEh3YgF4FU9B06rya3b4Mq1Fy5ynY6JJGNe0J5JHJZOhCTORt3Qwsc07
 q5j7gLCO0fWixTdUcS9rvzxUdT2hwS8z3td4TcCzidVomj9y0jjnogh8og9yf1JRqzLM
 fBltjXsdMjVbXdRt5lIs6pHPjKUN179XsTG18U3jiBT8u35NQKUpKq693iN/R1JnFW3o
 89cXDiFKJFLRlJWcG3s214/PSsFficv0sMJ2DoWiEEEMj8SFVpgXZ+tYepl3kUgYM2gN
 SwYFwlP2rVv1w2gFZI+qU7yAavr3F+b2adnGmQrXjjvGn3Yc1B9JlyC724w4Fo6Pic0b
 hoXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784063749; x=1784668549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ErW2XZrL9ajZEHhy26UY4YmMhMbEwdTPLY3anMh4sIY=;
 b=tQTtRE23ajmJxdKE60s9IF3Ex1N/LdTIqPxmSaC1YJW33FpJUxoA8JxssdtL2NyR6p
 X3eQ8xUZgx2NCfmieU+58k4wA/HhYA6ZjXcrTu8ywr1RaeV7oOmUcd2VQdYOYtQ6XzNO
 iJT5TN/tIF23l9VHnfAifF7DGEY+/SGrYJJui6z+IlBjY7Ti48gPZNVgt9C3fq+mVF8U
 eBxHsH92iOWoVlaw26oqIvytDCXO3IGzU7b4jzj7KX7bhfBZXs1/eSGid0BoiNWckW/Z
 trTcQSq9v0aEAFfpzuUZAM24KK6l8+ofJA3Ooc+/RgNozxI27LgcF1XwKWxRptAV6GFh
 +rgg==
X-Gm-Message-State: AOJu0Yz5omcE4R7yMjDEF+LWnZ4WlotrKm8LwTn5mvIameCuYpVZkWnN
 nQi16C4JoWq9xovSkphpySlBj1mGhwBc/9dT3l9hLAE51dmOnrISrgpq
X-Gm-Gg: AfdE7ck/4xq/EDGXa0Can7pn+v8xxFBoSkx/j6UFJ4usd8fJmX6lSpdZhQ319riHZb1
 eZOsI5iaWnmU2qljdMsAJA45j11tbs7ApfQJS0Y6051DiDWkG5x5hVfwm1E6wQ8gtJAhNTD3hkW
 WS5WgFy+6b8BsBeEh9A5ubyIORFvkOwhz19KNPrqcUyhPYu96477zzA8khrD+ky/FsY80deSRID
 vB96ZhIrOYC7x+f9OTjnXS7S3HBPz2ZMLQxhoVorefbrob30vSGNgGfv8k2bPC/s38hIqoqXPfU
 y8WIzLBfiDb5Oh2tWmy6ksZ2Ql/e3ile46ed6p8TDnBRLerhDlTDVZiV6VoWqHrpeZqTWporIyb
 1P2QS8ScWgUSPtCUxCFgSUiHbm4/+O0oKuWrH0jdYdp8ripfwqNkMe3vEKyNYHC6NeGV/Uz1UZR
 bp2o2eSxOGZhJ49HiJ/L5H
X-Received: by 2002:a05:600c:5395:b0:493:df5d:6ca6 with SMTP id
 5b1f17b1804b1-493f881de70mr140472175e9.25.1784063748930; 
 Tue, 14 Jul 2026 14:15:48 -0700 (PDT)
Received: from fedora ([94.205.182.68]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4950a32a2casm149843875e9.12.2026.07.14.14.15.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 14:15:48 -0700 (PDT)
From: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Mary Guillemard <mary@mary.zone>,
 Milos Tijanic <mtijanic@nvidia.com>, nouveau@lists.freedesktop.org,
 Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Subject: [PATCH 1/6] drm/nouveau/gsp: vendor the RUSD header
Date: Wed, 15 Jul 2026 01:14:24 +0400
Message-ID: <20260714211429.238355-2-mohamedahmedegypt2001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714211429.238355-1-mohamedahmedegypt2001@gmail.com>
References: <20260714211429.238355-1-mohamedahmedegypt2001@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

RM User Shared Data (RUSD) is GSP-RM's telemetry channel: the kernel
hands the firmware a buffer and the firmware fills it with telemetry
data (temperatures, power draw, power limits, clocks, utilizations,
etc) on its own timer, with a per-section timestamp/seqlock protocol
for lock-free reads.

Vendor the ABI needed to use it from the 570.144 tag of NVIDIA's
open-gpu-kernel-modules, matching the r570 firmware nouveau ships:

 - NV00DE_SHARED_DATA and its section structs, the RUSD_TIMESTAMP_*
   read-protocol values and the NV00DE_RUSD_POLL_* group mask bits
   (src/common/sdk/nvidia/inc/class/cl00de.h),
 - the two internal subdevice controls that drive it,
   NV2080_CTRL_CMD_INTERNAL_INIT_USER_SHARED_DATA (0x20800afe) and
   NV2080_CTRL_CMD_INTERNAL_USER_SHARED_DATA_SET_DATA_POLL (0x20800aff)
   (src/common/sdk/nvidia/inc/ctrl/ctrl2080/ctrl2080internal.h),
 - the NvTemp signed 24.8 fixed-point temperature typedef chain
   (src/common/sdk/nvidia/inc/nvfixedtypes.h), with NvS32 added to
   nvtypes.h to support it.

There is no version, magic or size field anywhere in the buffer or the
INIT params and the layout is pinned solely by the cl00de.h the firmware
binary was built with, which does change (more items get added) between
firmware branches. So this header must be re-derived from the exact tag
of any future firmware bump.

Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
---
 .../gpu/drm/nouveau/include/nvrm/nvtypes.h    |   3 +
 .../nvkm/subdev/gsp/rm/r570/nvrm/rusd.h       | 303 ++++++++++++++++++
 2 files changed, 306 insertions(+)
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/rusd.h

diff --git a/drivers/gpu/drm/nouveau/include/nvrm/nvtypes.h b/drivers/gpu/drm/nouveau/include/nvrm/nvtypes.h
index af11648ad9c8..ea232b765b7e 100644
--- a/drivers/gpu/drm/nouveau/include/nvrm/nvtypes.h
+++ b/drivers/gpu/drm/nouveau/include/nvrm/nvtypes.h
@@ -4,6 +4,7 @@
 
 #define NV_ALIGN_BYTES(a) __attribute__ ((__aligned__(a)))
 #define NV_DECLARE_ALIGNED(f,a) f __attribute__ ((__aligned__(a)))
+#define NVBIT(b) (1U << (b))
 
 typedef u32 NvV32;
 
@@ -12,6 +13,8 @@ typedef u16 NvU16;
 typedef u32 NvU32;
 typedef u64 NvU64;
 
+typedef s32 NvS32;
+
 typedef void* NvP64;
 
 typedef NvU8 NvBool;
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/rusd.h b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/rusd.h
new file mode 100644
index 000000000000..9f1099a06430
--- /dev/null
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/rusd.h
@@ -0,0 +1,303 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright (c) 2026, NVIDIA CORPORATION. All rights reserved. */
+
+#ifndef __NVRM_RUSD_H__
+#define __NVRM_RUSD_H__
+
+#include <nvif/os.h>
+#include <nvrm/nvtypes.h>
+
+/* Excerpt of RM headers from https://github.com/NVIDIA/open-gpu-kernel-modules/tree/570.144.
+ * Note that in case of GSP upgrades, we will need a different rusd.h as the struct changes.
+ */
+
+typedef NvS32 NvSFXP32;
+typedef NvSFXP32 NvSFXP24_8;
+typedef NvSFXP24_8 NvTemp;
+
+#define RM_USER_SHARED_DATA (0x000000de)
+
+#define RUSD_TIMESTAMP_WRITE_IN_PROGRESS (0xFFFFFFFFFFFFFFFFULL)
+#define RUSD_TIMESTAMP_INVALID 0
+
+#define RUSD_SEQ_START (0xFF00000000000000LLU)
+
+enum {
+   RUSD_CLK_PUBLIC_DOMAIN_GRAPHICS = 0,
+   RUSD_CLK_PUBLIC_DOMAIN_MEMORY,
+   RUSD_CLK_PUBLIC_DOMAIN_VIDEO,
+
+   // Put at the end. See bug 1000230 NVML doesn't report SM frequency on Kepler
+   RUSD_CLK_PUBLIC_DOMAIN_SM,
+   RUSD_CLK_PUBLIC_DOMAIN_MAX_TYPE,
+};
+
+enum {
+   RUSD_CLK_THROTTLE_REASON_GPU_IDLE                         = NVBIT(0),
+   RUSD_CLK_THROTTLE_REASON_APPLICATION_CLOCK_SETTING        = NVBIT(1),
+   RUSD_CLK_THROTTLE_REASON_SW_POWER_CAP                     = NVBIT(2),
+   RUSD_CLK_THROTTLE_REASON_HW_SLOWDOWN                      = NVBIT(3),
+   RUSD_CLK_THROTTLE_REASON_SYNC_BOOST                       = NVBIT(4),
+   RUSD_CLK_THROTTLE_REASON_SW_THERMAL_SLOWDOWN              = NVBIT(5),
+   RUSD_CLK_THROTTLE_REASON_HW_THERMAL_SLOWDOWN              = NVBIT(6),
+   RUSD_CLK_THROTTLE_REASON_HW_POWER_BRAKES_SLOWDOWN         = NVBIT(7),
+   RUSD_CLK_THROTTLE_REASON_DISPLAY_CLOCK_SETTING            = NVBIT(8),
+};
+
+typedef struct RUSD_BAR1_MEMORY_INFO {
+   volatile NvU64 lastModifiedTimestamp;
+   //
+   // Non-polled data, not tied to any specific RM API
+   // Total size and available memory in Bar1
+   //
+   NvU32 bar1Size;
+   NvU32 bar1AvailSize;
+} RUSD_BAR1_MEMORY_INFO;
+
+typedef struct RUSD_PMA_MEMORY_INFO {
+   volatile NvU64 lastModifiedTimestamp;
+   //
+   // Non-polled data, not tied to any specific RM API
+   // Total size and available memory in PMA
+   //
+   NvU64 totalPmaMemory;
+   NvU64 freePmaMemory;
+} RUSD_PMA_MEMORY_INFO;
+
+typedef struct RUSD_CLK_PUBLIC_DOMAIN_INFO {
+   NvU32 targetClkMHz;
+} RUSD_CLK_PUBLIC_DOMAIN_INFO;
+
+typedef struct RUSD_CLK_PUBLIC_DOMAIN_INFOS {
+   volatile NvU64 lastModifiedTimestamp;
+   RUSD_CLK_PUBLIC_DOMAIN_INFO info[RUSD_CLK_PUBLIC_DOMAIN_MAX_TYPE];
+} RUSD_CLK_PUBLIC_DOMAIN_INFOS;
+
+typedef struct RUSD_ENG_UTILIZATION {
+   NvU32 clkPercentBusy;
+   NvU32 samplingPeriodUs;
+} RUSD_ENG_UTILIZATION;
+
+#define RUSD_ENG_UTILIZATION_VID_ENG_NVENC 0
+#define RUSD_ENG_UTILIZATION_VID_ENG_NVDEC 1
+#define RUSD_ENG_UTILIZATION_VID_ENG_NVJPG 2
+#define RUSD_ENG_UTILIZATION_VID_ENG_NVOFA 3
+#define RUSD_ENG_UTILIZATION_COUNT 4
+
+typedef struct RUSD_PERF_DEVICE_UTILIZATION_INFO {
+   NvU32 gpuPercentBusy;
+   NvU32 memoryPercentBusy;
+   RUSD_ENG_UTILIZATION engUtil[RUSD_ENG_UTILIZATION_COUNT];
+} RUSD_PERF_DEVICE_UTILIZATION_INFO;
+
+typedef struct RUSD_PERF_DEVICE_UTILIZATION {
+   volatile NvU64 lastModifiedTimestamp;
+   RUSD_PERF_DEVICE_UTILIZATION_INFO info;
+} RUSD_PERF_DEVICE_UTILIZATION;
+
+typedef struct RUSD_PERF_CURRENT_PSTATE {
+   volatile NvU64 lastModifiedTimestamp;
+   // Provided from NV2080_CTRL_CMD_PERF_GET_CURRENT_PSTATE
+   NvU32 currentPstate;
+} RUSD_PERF_CURRENT_PSTATE;
+
+typedef struct RUSD_CLK_THROTTLE_REASON {
+   volatile NvU64 lastModifiedTimestamp;
+   NvU32 reasonMask; // Bitmask of RUSD_CLK_THROTTLE_REASON_*
+} RUSD_CLK_THROTTLE_REASON;
+
+typedef struct RUSD_MEM_ERROR_COUNTS {
+   NvU64 correctedVolatile;
+   NvU64 correctedAggregate;
+   NvU64 uncorrectedVolatile;
+   NvU64 uncorrectedAggregate;
+} RUSD_MEM_ERROR_COUNTS;
+
+#define RUSD_MEMORY_ERROR_TYPE_TOTAL 0
+#define RUSD_MEMORY_ERROR_TYPE_DRAM  1
+#define RUSD_MEMORY_ERROR_TYPE_SRAM  2
+#define RUSD_MEMORY_ERROR_TYPE_COUNT 3
+
+typedef struct RUSD_MEM_ECC {
+   volatile NvU64 lastModifiedTimestamp;
+   // Provided from NV2080_CTRL_CMD_GPU_QUERY_ECC_STATUS
+   RUSD_MEM_ERROR_COUNTS count[RUSD_MEMORY_ERROR_TYPE_COUNT];
+} RUSD_MEM_ECC;
+
+typedef struct RUSD_POWER_LIMIT_INFO {
+   NvU32 requestedmW;
+   NvU32 enforcedmW;
+} RUSD_POWER_LIMIT_INFO;
+
+typedef struct RUSD_POWER_LIMITS {
+   volatile NvU64 lastModifiedTimestamp;
+   RUSD_POWER_LIMIT_INFO info;
+} RUSD_POWER_LIMITS;
+
+typedef enum RUSD_TEMPERATURE_TYPE {
+   RUSD_TEMPERATURE_TYPE_GPU,
+   RUSD_TEMPERATURE_TYPE_HBM,
+   RUSD_TEMPERATURE_TYPE_MAX
+} RUSD_TEMPERATURE_TYPE;
+
+typedef struct RUSD_TEMPERATURE {
+   volatile NvU64 lastModifiedTimestamp;
+   NvTemp temperature;
+} RUSD_TEMPERATURE;
+
+typedef struct RUSD_MEM_ROW_REMAP_INFO {
+   // Provided from NV2080_CTRL_CMD_FB_GET_ROW_REMAPPER_HISTOGRAM
+   NvU32 histogramMax;     // No remapped row is used.
+   NvU32 histogramHigh;    // One remapped row is used.
+   NvU32 histogramPartial; // More than one remapped rows are used.
+   NvU32 histogramLow;     // One remapped row is available.
+   NvU32 histogramNone;    // All remapped rows are used.
+
+   NvU32 correctableRows;
+   NvU32 uncorrectableRows;
+   NvBool isPending;
+   NvBool hasFailureOccurred;
+} RUSD_MEM_ROW_REMAP_INFO;
+
+typedef struct RUSD_MEM_ROW_REMAP {
+   volatile NvU64 lastModifiedTimestamp;
+   RUSD_MEM_ROW_REMAP_INFO info;
+} RUSD_MEM_ROW_REMAP;
+
+typedef struct RUSD_AVG_POWER_INFO {
+   NvU32 averageGpuPower;      // mW
+   NvU32 averageModulePower;   // mW
+   NvU32 averageMemoryPower;   // mW
+} RUSD_AVG_POWER_INFO;
+
+typedef struct RUSD_AVG_POWER_USAGE {
+   volatile NvU64 lastModifiedTimestamp;
+   RUSD_AVG_POWER_INFO info;
+} RUSD_AVG_POWER_USAGE;
+
+typedef struct RUSD_INST_POWER_INFO {
+   NvU32 instGpuPower;         // mW
+   NvU32 instModulePower;      // mW
+   NvU32 instCpuPower;         // mW
+} RUSD_INST_POWER_INFO;
+
+typedef struct RUSD_INST_POWER_USAGE {
+   volatile NvU64 lastModifiedTimestamp;
+   RUSD_INST_POWER_INFO info;
+} RUSD_INST_POWER_USAGE;
+
+typedef struct RUSD_SHADOW_ERR_CONT {
+   volatile NvU64 lastModifiedTimestamp;
+   //
+   // Non-polled data, not tied to any specific RM API
+   // Shadowed ERR_CONT register value
+   //
+   NvU32 shadowErrContVal;
+} RUSD_SHADOW_ERR_CONT;
+
+// Each RUSD_BUS_DATA_* define corresponds to the equivalent NV2080_CTRL_BUS_INFO_INDEX_*
+#define RUSD_BUS_DATA_PCIE_GEN_INFO                              0
+#define RUSD_BUS_DATA_PCIE_GPU_LINK_LINECODE_ERRORS              1
+#define RUSD_BUS_DATA_PCIE_GPU_LINK_CRC_ERRORS                   2
+#define RUSD_BUS_DATA_PCIE_GPU_LINK_NAKS_RECEIVED                3
+#define RUSD_BUS_DATA_PCIE_GPU_LINK_FAILED_L0S_EXITS             4
+#define RUSD_BUS_DATA_PCIE_GPU_LINK_CORRECTABLE_ERRORS           5
+#define RUSD_BUS_DATA_PCIE_GPU_LINK_NONFATAL_ERRORS              6
+#define RUSD_BUS_DATA_PCIE_GPU_LINK_FATAL_ERRORS                 7
+#define RUSD_BUS_DATA_PCIE_GPU_LINK_UNSUPPORTED_REQUESTS         8
+#define RUSD_BUS_DATA_COUNT                                      9
+
+typedef struct RUSD_PCIE_DATA_INFO {
+   // Provided from NV2080_CTRL_CMD_BUS_GET_INFO_V2
+   NvU32 data[RUSD_BUS_DATA_COUNT];
+} RUSD_PCIE_DATA_INFO;
+
+typedef struct RUSD_PCIE_DATA {
+   volatile NvU64 lastModifiedTimestamp;
+   RUSD_PCIE_DATA_INFO info;
+} RUSD_PCIE_DATA;
+
+typedef struct RUSD_GR_INFO
+{
+   volatile NvU64 lastModifiedTimestamp;
+   NvBool bCtxswLoggingEnabled;
+} RUSD_GR_INFO;
+
+typedef struct NV00DE_SHARED_DATA {
+   NV_DECLARE_ALIGNED(RUSD_BAR1_MEMORY_INFO bar1MemoryInfo, 8);
+
+   NV_DECLARE_ALIGNED(RUSD_PMA_MEMORY_INFO pmaMemoryInfo, 8);
+
+   NV_DECLARE_ALIGNED(RUSD_SHADOW_ERR_CONT shadowErrCont, 8);
+
+   NV_DECLARE_ALIGNED(RUSD_GR_INFO grInfo, 8);
+
+   // gpuUpdateUserSharedData is sensitive to these two sections being contiguous
+
+   //
+   // Polled data section
+   // All data structs are a volatile NvU64 timestamp followed by data contents.
+   // Access by reading timestamp, then copying the struct contents, then reading the timestamp again.
+   // If time0 matches time1, data has not changed during the read, and contents are valid.
+   // If timestamp is RUSD_TIMESTAMP_WRITE_IN_PROGRESS, data was edited during the read, retry.
+   // If timestamp is RUSD_TIMESTAMP_INVALID, data is not available or not supported on this platform.
+   //
+
+   // POLL_CLOCK
+   NV_DECLARE_ALIGNED(RUSD_CLK_PUBLIC_DOMAIN_INFOS clkPublicDomainInfos, 8);
+
+   // POLL_PERF
+   NV_DECLARE_ALIGNED(RUSD_CLK_THROTTLE_REASON clkThrottleReason, 8);
+
+   // POLL_PERF
+   NV_DECLARE_ALIGNED(RUSD_PERF_DEVICE_UTILIZATION perfDevUtil, 8);
+
+   // POLL_MEMORY
+   NV_DECLARE_ALIGNED(RUSD_MEM_ECC memEcc, 8);
+
+   // POLL_PERF
+   NV_DECLARE_ALIGNED(RUSD_PERF_CURRENT_PSTATE perfCurrentPstate, 8);
+
+   // POLL_POWER
+   // Module Limit is not supported on Ampere/Hopper
+   NV_DECLARE_ALIGNED(RUSD_POWER_LIMITS powerLimitGpu, 8);
+
+   // POLL_THERMAL
+   NV_DECLARE_ALIGNED(RUSD_TEMPERATURE temperatures[RUSD_TEMPERATURE_TYPE_MAX], 8);
+
+   // POLL_MEMORY
+   NV_DECLARE_ALIGNED(RUSD_MEM_ROW_REMAP memRowRemap, 8);
+
+   // POLL_POWER
+   NV_DECLARE_ALIGNED(RUSD_AVG_POWER_USAGE avgPowerUsage, 8);
+
+   // POLL_POWER
+   NV_DECLARE_ALIGNED(RUSD_INST_POWER_USAGE instPowerUsage, 8);
+
+   // POLL_PCI
+   NV_DECLARE_ALIGNED(RUSD_PCIE_DATA pciBusData, 8);
+} NV00DE_SHARED_DATA;
+
+//
+// Polling mask bits, pass into ALLOC_PARAMETERS or NV00DE_CTRL_REQEUSET_DATA_POLL
+// to request above polled data to be provided
+//
+#define NV00DE_RUSD_POLL_CLOCK     0x1
+#define NV00DE_RUSD_POLL_PERF      0x2
+#define NV00DE_RUSD_POLL_MEMORY    0x4
+#define NV00DE_RUSD_POLL_POWER     0x8
+#define NV00DE_RUSD_POLL_THERMAL   0x10
+#define NV00DE_RUSD_POLL_PCI       0x20
+
+typedef struct NV2080_CTRL_INTERNAL_INIT_USER_SHARED_DATA_PARAMS {
+   NV_DECLARE_ALIGNED(NvU64 physAddr, 8);
+} NV2080_CTRL_INTERNAL_INIT_USER_SHARED_DATA_PARAMS;
+#define NV2080_CTRL_CMD_INTERNAL_INIT_USER_SHARED_DATA (0x20800afe) /* finn: Evaluated from "(FINN_NV20_SUBDEVICE_0_INTERNAL_INTERFACE_ID << 8) | NV2080_CTRL_INTERNAL_INIT_USER_SHARED_DATA_PARAMS_MESSAGE_ID" */
+
+typedef struct NV2080_CTRL_INTERNAL_USER_SHARED_DATA_SET_DATA_POLL_PARAMS {
+   NV_DECLARE_ALIGNED(NvU64 polledDataMask, 8);
+   NvU32 pollFrequencyMs;
+} NV2080_CTRL_INTERNAL_USER_SHARED_DATA_SET_DATA_POLL_PARAMS;
+#define NV2080_CTRL_CMD_INTERNAL_USER_SHARED_DATA_SET_DATA_POLL (0x20800aff) /* finn: Evaluated from "(FINN_NV20_SUBDEVICE_0_INTERNAL_INTERFACE_ID << 8) | NV2080_CTRL_INTERNAL_USER_SHARED_DATA_SET_DATA_POLL_PARAMS_MESSAGE_ID" */
+
+#endif
-- 
2.55.0

