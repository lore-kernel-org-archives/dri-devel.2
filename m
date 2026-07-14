Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94DB0C43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 21:16:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F12DC10E0D1;
	Tue, 14 Jul 2026 21:16:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U20UI22J";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A83610E0D1
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 21:16:00 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-493ba701891so11210025e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 14:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784063759; x=1784668559; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gAMd/NRs9uTxhooK/w/pqk0SiEg4/0a/jbKWZhfbWqU=;
 b=U20UI22JxzF6sDYx5tQ+C0yBC0/LMi2/LlVQnWb/xIjRJoG6ylvxr8glrC/LIdMpd1
 6/fSF+9P6VwMYgJvqX2lVXxmCl9j81XhwRbwzkgokCL45l8VawTe7eJeQGWD9TSbPbWh
 YMpyD23El5xzc8NYTFxXMH5Va2KBhmKCUp4ZGL9maxl/qIejFfxOcRxJWGGKUqKCRrtZ
 2DpDbngQELEcU3nOk3Yc4GE2xMWgGOYIuQ1I7piOsqAnCmepuPzatjYpjDI+TNnvHY5p
 +xBecCbuOlAaqz4pf6X2Sic6lwbNHfQymJHI9V9lB5Roe9VZJJvMAYbY+Zc8jJXvqN2r
 iDQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784063759; x=1784668559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gAMd/NRs9uTxhooK/w/pqk0SiEg4/0a/jbKWZhfbWqU=;
 b=dFA87+K/a1U02EpoWZOdy3YRj3kBBcl36qHNEu2oq1c4sV0wHpu9/vi7EBDNvojeUX
 aAIOc+CnGWVZuHdF/wsWwF/4CJNA6LrGzbPWut5Ph43hAmR71dIXCFlCmMr9aTGacGnJ
 jJjZtSQ0HDDlfYcvrNG9zcpXxuq5SAAtUYVaHKYmFQvclFX2wCFoQo74uOrQyiVjNsdi
 rhIy2TKGCXx4Ynw2ui+2SOUR/ktW6a78T2Wy1WCsv3EbgmfnahFMwmux8JpUSghFE33B
 Zs7wPc5XeuWqkUTkCjsHECdDxsPDPnf/qvxeKza2t7wdSDV7ksTCLIinum+ftGmjOdQ/
 WeRg==
X-Gm-Message-State: AOJu0Yy0O0ozfVeO8TFZi+3pJVY29UmqBURgdj8ZYFuGBuQwWWrBZ9u1
 pfFzRHlWZUCNGQceUigdvQY+GUevDhSDdZqFPHz0609/qCoxzW/2CPXf
X-Gm-Gg: AfdE7cnu3Syny4e6LaOVi98AMXvpvM6wwQB1jJGd/Hh03vGgrVx5K/wXbmbwMGlBjco
 jzNBK18G9OFwJfTinBI4F7P6R45pAD8SEFYgI1LMSc/yWvN/BmKxbWgoWCN6O5vSnZmQikfYOV1
 56Bkg6HeecP5kAwHl4psXr26HVZ2Py34hQ5erliSZyDR0v7S7lrhslrvxuqnITXy7bin+Xroipn
 4lYBNQe/xEE9ssPDxvWcM/kouqd24LrWovwUS0pipyv8aU8YkSFrU0nnZAt7MoebP0WDSYIYoXl
 u48JgllAy3JM5a9GzydHxRMYjDMyOPfLpWX3yuM6Fig2gmD99jplMTyy7jkBO+eAJvW4QyJTMJt
 dysP3+MzzJCiMbzMtZxaO3nYK5WQZsIj7f/xneZFP3SWFthlib8ZHIWL8VEx394D1F1+aBCJZM8
 dldDHj2vOGLnUs/fmUhVNwGGdZls5q8x8=
X-Received: by 2002:a05:600c:8b29:b0:493:c337:db0e with SMTP id
 5b1f17b1804b1-493f881d069mr148624165e9.18.1784063758496; 
 Tue, 14 Jul 2026 14:15:58 -0700 (PDT)
Received: from fedora ([94.205.182.68]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4950a32a2casm149843875e9.12.2026.07.14.14.15.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 14:15:57 -0700 (PDT)
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
Subject: [PATCH 2/6] drm/nouveau/gsp: add RUSD telemetry support
Date: Wed, 15 Jul 2026 01:14:25 +0400
Message-ID: <20260714211429.238355-3-mohamedahmedegypt2001@gmail.com>
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

Allocate the RUSD shared-data buffer and ask GSP-RM to poll telemetry
into it, following OpenRM's call sequence
(gpuCreateRusdMemory_IMPL, 570.144): allocate a zero-filled, physically
contiguous, coherent sysmem buffer, hand its bus address to the
firmware with INIT_USER_SHARED_DATA, then program the poll group mask
and interval with USER_SHARED_DATA_SET_DATA_POLL. Both controls go
over the existing internal subdevice object.

Readers copy sections out under the RUSD timestamp protocol: a
section's leading u64 is 0 while invalid/unsupported, ~0 while the
firmware is mid-write, and a timestamp otherwise. Reads fail with
-ENODATA for sections the firmware never fills (e.g. HBM temperature on
GDDR boards).

Polling is completely demand driven, each read enables its data group's
poll bit on demand, and an idle worker drops a group's bit once it has
gone unread for R570_RUSD_IDLE_MS. This idle backoff is what stops
polling when nothing reads the sensors. The window is kept above a
typical monitoring cadence so "sensors" in a loop doesn't switch
the poll on and off.

Tracking is per group and each group has independent deadlines, so reading
only temperatures doesn't keep the power section polled for example.
A single delayed_work recomputes the wanted mask from the per-group
last-access timestamps and issues one SET_DATA_POLL.

The vendored layout only matches the firmware's on 64-bit (32-bit u64
alignment shrinks segments and shifts every section), so init fails
closed with -ENODEV on 32-bit kernels rather than misinterpreting
telemetry or leading to GSP OOB writes.

Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
---
 .../gpu/drm/nouveau/include/nvkm/subdev/gsp.h |  33 ++
 .../drm/nouveau/include/nvkm/subdev/rusd.h    | 114 ++++
 .../drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c |  26 +
 .../drm/nouveau/nvkm/subdev/gsp/rm/r535/rm.c  |   1 +
 .../nouveau/nvkm/subdev/gsp/rm/r570/Kbuild    |   1 +
 .../drm/nouveau/nvkm/subdev/gsp/rm/r570/rm.c  |   1 +
 .../nouveau/nvkm/subdev/gsp/rm/r570/rusd.c    | 531 ++++++++++++++++++
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h   |   7 +
 8 files changed, 714 insertions(+)
 create mode 100644 drivers/gpu/drm/nouveau/include/nvkm/subdev/rusd.h
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/rusd.c

diff --git a/drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h b/drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h
index 64fed208e4cf..6202be91125f 100644
--- a/drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h
+++ b/drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h
@@ -4,6 +4,7 @@
 #include <core/subdev.h>
 #include <core/falcon.h>
 #include <core/firmware.h>
+#include <subdev/rusd.h>
 
 #include <linux/debugfs.h>
 
@@ -233,6 +234,23 @@ struct nvkm_gsp {
 		u8 tpcs;
 	} gr;
 
+	/* RM User Shared Data telemetry buffer, polled by GSP-RM (r570+).
+	 *
+	 * GSP only polls the groups nouveau currently wants: a sensor read
+	 * enables that group's poll bit on demand, and @work disables a group
+	 * again once it has gone unread for a while.  @mutex serialises @mask
+	 * changes (and the SET_DATA_POLL RPC that carries them) against @work.
+	 */
+	struct {
+		struct nvkm_gsp_mem mem;
+		u32 poll_ms;
+		bool valid;
+		struct mutex mutex;
+		u64 mask;
+		unsigned long group_access[NVKM_GSP_RUSD_GROUP_COUNT];
+		struct delayed_work work;
+	} rusd;
+
 	struct nvkm_rm *rm;
 
 	struct {
@@ -275,6 +293,21 @@ nvkm_gsp_rm(struct nvkm_gsp *gsp)
 
 #include <rm/rm.h>
 
+static inline bool
+nvkm_gsp_rusd(struct nvkm_gsp *gsp)
+{
+	return nvkm_gsp_rm(gsp) && gsp->rusd.valid;
+}
+
+static inline int
+nvkm_gsp_rusd_read(struct nvkm_gsp *gsp, enum nvkm_gsp_rusd_item item, s64 *val)
+{
+	if (!nvkm_gsp_rusd(gsp) || !gsp->rm->api->rusd)
+		return -ENODEV;
+
+	return gsp->rm->api->rusd->read(gsp, item, val);
+}
+
 static inline void *
 nvkm_gsp_rpc_get(struct nvkm_gsp *gsp, u32 fn, u32 argc)
 {
diff --git a/drivers/gpu/drm/nouveau/include/nvkm/subdev/rusd.h b/drivers/gpu/drm/nouveau/include/nvkm/subdev/rusd.h
new file mode 100644
index 000000000000..20fe5b94b1ca
--- /dev/null
+++ b/drivers/gpu/drm/nouveau/include/nvkm/subdev/rusd.h
@@ -0,0 +1,114 @@
+/* SPDX-License-Identifier: MIT */
+
+#ifndef __NVKM_SUBDEV_GSP_RUSD_H__
+#define __NVKM_SUBDEV_GSP_RUSD_H__
+
+/*
+ * Nouveau NVKM API/ABI for the RUSD interface. This is the core our RUSD
+ * design rests on: layering such that the firmware ABI doesn't leak into the
+ * rest of DRM.
+ */
+
+/* RUSD poll groups nouveau drives on demand; each maps to one NV00DE_RUSD_POLL_* bit. */
+enum nvkm_gsp_rusd_group {
+	NVKM_GSP_RUSD_GROUP_THERMAL,
+	NVKM_GSP_RUSD_GROUP_POWER,
+	NVKM_GSP_RUSD_GROUP_CLOCK,
+	NVKM_GSP_RUSD_GROUP_PERF,
+	NVKM_GSP_RUSD_GROUP_MEMORY,
+	NVKM_GSP_RUSD_GROUP_PCI,
+	NVKM_GSP_RUSD_GROUP_COUNT
+};
+
+/*
+ * Telemetry items read from the RM User Shared Data (RUSD) buffer. Each is a
+ * single decoded scalar; nvkm owns the units/conversions, callers stay dumb.
+ *
+ * The clock, video-engine and PCIe items are read with index arithmetic in
+ * rusd.c, so the marked runs must stay contiguous and in the noted order.
+ */
+enum nvkm_gsp_rusd_item {
+	NVKM_GSP_RUSD_TEMP_GPU,
+	NVKM_GSP_RUSD_TEMP_HBM,
+
+	NVKM_GSP_RUSD_POWER_GPU,
+	NVKM_GSP_RUSD_POWER_GPU_AVG,
+	NVKM_GSP_RUSD_POWER_BOARD,
+	NVKM_GSP_RUSD_POWER_BOARD_AVG,
+	NVKM_GSP_RUSD_POWER_VRAM_AVG,
+	NVKM_GSP_RUSD_POWER_CAP,
+	NVKM_GSP_RUSD_POWER_CPU,
+	NVKM_GSP_RUSD_POWER_LIMIT_REQUESTED,
+
+	/* contiguous, order = RUSD_CLK_PUBLIC_DOMAIN_* */
+	NVKM_GSP_RUSD_CLOCK_GRAPHICS,	/* MHz */
+	NVKM_GSP_RUSD_CLOCK_MEMORY,
+	NVKM_GSP_RUSD_CLOCK_VIDEO,
+	NVKM_GSP_RUSD_CLOCK_SM,
+
+	NVKM_GSP_RUSD_UTIL_GPU,		/* percent */
+	NVKM_GSP_RUSD_UTIL_MEMORY,
+	/* contiguous, order = RUSD_ENG_UTILIZATION_VID_ENG_* */
+	NVKM_GSP_RUSD_UTIL_NVENC,	/* percent */
+	NVKM_GSP_RUSD_UTIL_NVDEC,
+	NVKM_GSP_RUSD_UTIL_NVJPG,
+	NVKM_GSP_RUSD_UTIL_NVOFA,
+	/* contiguous, same engine order */
+	NVKM_GSP_RUSD_UTIL_NVENC_PERIOD,	/* microseconds */
+	NVKM_GSP_RUSD_UTIL_NVDEC_PERIOD,
+	NVKM_GSP_RUSD_UTIL_NVJPG_PERIOD,
+	NVKM_GSP_RUSD_UTIL_NVOFA_PERIOD,
+
+	NVKM_GSP_RUSD_PSTATE,		/* P-state index */
+
+	NVKM_GSP_RUSD_THROTTLE_MASK,	/* RUSD_CLK_THROTTLE_REASON_* bitmask */
+	NVKM_GSP_RUSD_THROTTLE_GPU_IDLE,	/* the rest: 0/1 */
+	NVKM_GSP_RUSD_THROTTLE_APP_CLOCK,
+	NVKM_GSP_RUSD_THROTTLE_SW_POWER_CAP,
+	NVKM_GSP_RUSD_THROTTLE_HW_SLOWDOWN,
+	NVKM_GSP_RUSD_THROTTLE_SYNC_BOOST,
+	NVKM_GSP_RUSD_THROTTLE_SW_THERMAL,
+	NVKM_GSP_RUSD_THROTTLE_HW_THERMAL,
+	NVKM_GSP_RUSD_THROTTLE_HW_POWER_BRAKE,
+	NVKM_GSP_RUSD_THROTTLE_DISPLAY_CLOCK,
+
+	/*
+	 * contiguous, order = {TOTAL,DRAM,SRAM} x {ce,ue} x {volatile,aggregate};
+	 * ce = correctable error, ue = uncorrectable error.
+	 */
+	NVKM_GSP_RUSD_ECC_TOTAL_CE_VOL,		/* error count */
+	NVKM_GSP_RUSD_ECC_TOTAL_CE_AGG,
+	NVKM_GSP_RUSD_ECC_TOTAL_UE_VOL,
+	NVKM_GSP_RUSD_ECC_TOTAL_UE_AGG,
+	NVKM_GSP_RUSD_ECC_DRAM_CE_VOL,
+	NVKM_GSP_RUSD_ECC_DRAM_CE_AGG,
+	NVKM_GSP_RUSD_ECC_DRAM_UE_VOL,
+	NVKM_GSP_RUSD_ECC_DRAM_UE_AGG,
+	NVKM_GSP_RUSD_ECC_SRAM_CE_VOL,
+	NVKM_GSP_RUSD_ECC_SRAM_CE_AGG,
+	NVKM_GSP_RUSD_ECC_SRAM_UE_VOL,
+	NVKM_GSP_RUSD_ECC_SRAM_UE_AGG,
+
+	NVKM_GSP_RUSD_ROWREMAP_HIST_MAX,	/* bank count */
+	NVKM_GSP_RUSD_ROWREMAP_HIST_HIGH,
+	NVKM_GSP_RUSD_ROWREMAP_HIST_PARTIAL,
+	NVKM_GSP_RUSD_ROWREMAP_HIST_LOW,
+	NVKM_GSP_RUSD_ROWREMAP_HIST_NONE,
+	NVKM_GSP_RUSD_ROWREMAP_CORRECTABLE,	/* row count */
+	NVKM_GSP_RUSD_ROWREMAP_UNCORRECTABLE,
+	NVKM_GSP_RUSD_ROWREMAP_PENDING,		/* 0/1 */
+	NVKM_GSP_RUSD_ROWREMAP_FAILURE,		/* 0/1 */
+
+	/* contiguous, order = RUSD_BUS_DATA_* */
+	NVKM_GSP_RUSD_PCIE_GEN,			/* packed gen/width bitfield */
+	NVKM_GSP_RUSD_PCIE_LINECODE_ERRORS,	/* the rest: counters */
+	NVKM_GSP_RUSD_PCIE_CRC_ERRORS,
+	NVKM_GSP_RUSD_PCIE_NAKS_RECEIVED,
+	NVKM_GSP_RUSD_PCIE_FAILED_L0S_EXITS,
+	NVKM_GSP_RUSD_PCIE_CORRECTABLE_ERRORS,
+	NVKM_GSP_RUSD_PCIE_NONFATAL_ERRORS,
+	NVKM_GSP_RUSD_PCIE_FATAL_ERRORS,
+	NVKM_GSP_RUSD_PCIE_UNSUPPORTED_REQUESTS,
+};
+
+#endif
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
index f544afa12b6b..c75652b39f81 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
@@ -322,6 +322,9 @@ r535_gsp_postinit(struct nvkm_gsp *gsp)
 	nvkm_gsp_mem_dtor(&gsp->boot.fw);
 	nvkm_gsp_mem_dtor(&gsp->libos);
 
+	if (rmapi->rusd)
+		rmapi->rusd->init(gsp);
+
 	return ret;
 }
 
@@ -1727,6 +1730,19 @@ r535_gsp_fini(struct nvkm_gsp *gsp, enum nvkm_suspend_state suspend)
 	struct nvkm_rm *rm = gsp->rm;
 	int ret;
 
+	/* Stop demand-poll management before tearing the firmware down. Mark
+	 * RUSD inactive under the lock first: gsp->running is still true
+	 * throughout fini, so the flag is what stops an in-flight request
+	 * from enabling a group (and issuing a SET_DATA_POLL) once teardown
+	 * has begun. Then cancel the worker.
+	 */
+	if (gsp->rusd.mem.data) {
+		mutex_lock(&gsp->rusd.mutex);
+		gsp->rusd.valid = false;
+		mutex_unlock(&gsp->rusd.mutex);
+		cancel_delayed_work_sync(&gsp->rusd.work);
+	}
+
 	if (suspend) {
 		u32 len = rm->api->gsp->sr_data_size(gsp);
 		GspFwSRMeta *sr;
@@ -1801,6 +1817,9 @@ r535_gsp_init(struct nvkm_gsp *gsp)
 		nvkm_gsp_mem_dtor(&gsp->sr.meta);
 		nvkm_gsp_radix3_dtor(gsp, &gsp->sr.radix3);
 		nvkm_gsp_sg_free(gsp->subdev.device, &gsp->sr.sgt);
+
+		if (ret == 0 && gsp->rm->api->rusd)
+			gsp->rm->api->rusd->resume(gsp);
 		return ret;
 	}
 
@@ -2120,6 +2139,13 @@ r535_gsp_dtor(struct nvkm_gsp *gsp)
 	nvkm_gsp_mem_dtor(&gsp->loginit);
 	nvkm_gsp_mem_dtor(&gsp->logintr);
 	nvkm_gsp_mem_dtor(&gsp->logrm);
+
+	gsp->rusd.valid = false;
+	if (gsp->rusd.mem.data) {
+		cancel_delayed_work_sync(&gsp->rusd.work);
+		mutex_destroy(&gsp->rusd.mutex);
+	}
+	nvkm_gsp_mem_dtor(&gsp->rusd.mem);
 }
 
 static void
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rm.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rm.c
index a4190676e1ad..babddeeee065 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rm.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rm.c
@@ -37,6 +37,7 @@ r535_api = {
 	.nvenc = &r535_nvenc,
 	.nvjpg = &r535_nvjpg,
 	.ofa = &r535_ofa,
+	.rusd = NULL,
 };
 
 const struct nvkm_rm_impl
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/Kbuild b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/Kbuild
index 5db0e7009e1f..5bd3c6538010 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/Kbuild
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/Kbuild
@@ -7,3 +7,4 @@ nvkm-y += nvkm/subdev/gsp/rm/r570/disp.o
 nvkm-y += nvkm/subdev/gsp/rm/r570/fifo.o
 nvkm-y += nvkm/subdev/gsp/rm/r570/gr.o
 nvkm-y += nvkm/subdev/gsp/rm/r570/ofa.o
+nvkm-y += nvkm/subdev/gsp/rm/r570/rusd.o
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/rm.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/rm.c
index 498658d0c60c..5c091e80cd56 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/rm.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/rm.c
@@ -66,6 +66,7 @@ r570_api = {
 	.nvenc = &r535_nvenc,
 	.nvjpg = &r535_nvjpg,
 	.ofa = &r570_ofa,
+	.rusd = &r570_rusd,
 };
 
 const struct nvkm_rm_impl
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/rusd.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/rusd.c
new file mode 100644
index 000000000000..d20dda07596a
--- /dev/null
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/rusd.c
@@ -0,0 +1,531 @@
+/* SPDX-License-Identifier: MIT
+ *
+ * Copyright (c) 2026 Valve Corp.
+ */
+
+#include <rm/rm.h>
+
+#include "nvrm/rusd.h"
+
+/*
+ * The period the GSP polls the telemetry in. Less frequent is better for power
+ * efficiency; OpenRM sets it to 500ms for GeForce and 100ms for the enterprise
+ * parts, so we mirror that by setting to 500ms.
+ */
+#define R570_RUSD_POLL_MS 500
+/*
+ * Keep polling a group for this long after its last read. This idle backoff
+ * is the primary thing that stops polling when nothing reads the sensors.
+ * This should be kept above a typical monitoring cadence (~1-2s) so monitoring
+ * tools that query the telemetry in a loop don't flip the poll on and off.
+ * Beyond that the value just trades idle power against SET_DATA_POLL churn.
+ */
+#define R570_RUSD_IDLE_MS 10000
+
+/* Each group nouveau manages corresponds to one NV00DE_RUSD_POLL_* bit. */
+static const u64 r570_rusd_group_mask[NVKM_GSP_RUSD_GROUP_COUNT] = {
+	[NVKM_GSP_RUSD_GROUP_THERMAL] = NV00DE_RUSD_POLL_THERMAL,
+	[NVKM_GSP_RUSD_GROUP_POWER]   = NV00DE_RUSD_POLL_POWER,
+	[NVKM_GSP_RUSD_GROUP_CLOCK]   = NV00DE_RUSD_POLL_CLOCK,
+	[NVKM_GSP_RUSD_GROUP_PERF]    = NV00DE_RUSD_POLL_PERF,
+	[NVKM_GSP_RUSD_GROUP_MEMORY]  = NV00DE_RUSD_POLL_MEMORY,
+	[NVKM_GSP_RUSD_GROUP_PCI]     = NV00DE_RUSD_POLL_PCI,
+};
+
+static enum nvkm_gsp_rusd_group
+r570_rusd_item_group(enum nvkm_gsp_rusd_item item)
+{
+	switch (item) {
+	case NVKM_GSP_RUSD_TEMP_GPU:
+	case NVKM_GSP_RUSD_TEMP_HBM:
+		return NVKM_GSP_RUSD_GROUP_THERMAL;
+	case NVKM_GSP_RUSD_CLOCK_GRAPHICS ... NVKM_GSP_RUSD_CLOCK_SM:
+		return NVKM_GSP_RUSD_GROUP_CLOCK;
+	case NVKM_GSP_RUSD_UTIL_GPU ... NVKM_GSP_RUSD_PSTATE:
+	case NVKM_GSP_RUSD_THROTTLE_MASK ... NVKM_GSP_RUSD_THROTTLE_DISPLAY_CLOCK:
+		return NVKM_GSP_RUSD_GROUP_PERF;
+	case NVKM_GSP_RUSD_ECC_TOTAL_CE_VOL ... NVKM_GSP_RUSD_ROWREMAP_FAILURE:
+		return NVKM_GSP_RUSD_GROUP_MEMORY;
+	case NVKM_GSP_RUSD_PCIE_GEN ... NVKM_GSP_RUSD_PCIE_UNSUPPORTED_REQUESTS:
+		return NVKM_GSP_RUSD_GROUP_PCI;
+	default:
+		return NVKM_GSP_RUSD_GROUP_POWER;
+	}
+}
+
+/*
+ * Program GSP's poll mask. Caller holds gsp->rusd.mutex.
+ *
+ * Mirrors OpenRM: the poll interval is established once at init with an empty
+ * mask (_gpushareddataInitPollingFrequency), and every following mask change
+ * is sent with pollFrequencyMs == 0, which signals to keep the current
+ * interval (_gpushareddataSendDataPollRpc), deduped against the last mask
+ * sent.
+ */
+static int
+r570_rusd_set_mask(struct nvkm_gsp *gsp, u64 mask)
+{
+	NV2080_CTRL_INTERNAL_USER_SHARED_DATA_SET_DATA_POLL_PARAMS *poll;
+	struct nvkm_gsp_object *subdevice = &gsp->internal.device.subdevice;
+	int ret;
+
+	if (mask == gsp->rusd.mask)
+		return 0;
+
+	poll = nvkm_gsp_rm_ctrl_get(subdevice,
+				    NV2080_CTRL_CMD_INTERNAL_USER_SHARED_DATA_SET_DATA_POLL,
+				    sizeof(*poll));
+	if (IS_ERR(poll))
+		return PTR_ERR(poll);
+
+	poll->polledDataMask = mask;
+	poll->pollFrequencyMs = 0;
+
+	ret = nvkm_gsp_rm_ctrl_wr(subdevice, poll);
+	if (ret)
+		return ret;
+
+	gsp->rusd.mask = mask;
+	return 0;
+}
+
+/*
+ * Mark a group as consumed: refresh its idle deadline, make sure GSP is
+ * polling it, and keep the idle worker armed. Best-effort; if the enable
+ * RPC fails the worker retries from the refreshed deadline.
+ */
+static void
+r570_rusd_poke(struct nvkm_gsp *gsp, enum nvkm_gsp_rusd_group group)
+{
+	mutex_lock(&gsp->rusd.mutex);
+	/* @valid (not gsp->running) is the teardown fence: it is cleared under
+	 * this mutex at the very start of fini, while gsp->running is still
+	 * true, so checking it here stops a read from enabling a group and
+	 * issuing a SET_DATA_POLL to a firmware that is being unloaded.
+	 */
+	if (gsp->rusd.valid) {
+		gsp->rusd.group_access[group] = jiffies;
+		r570_rusd_set_mask(gsp, gsp->rusd.mask | r570_rusd_group_mask[group]);
+		if (gsp->rusd.mask)
+			schedule_delayed_work(&gsp->rusd.work,
+					      msecs_to_jiffies(R570_RUSD_IDLE_MS));
+	}
+	mutex_unlock(&gsp->rusd.mutex);
+}
+
+/* Drop the groups that haven't been read within the idle window. */
+static void
+r570_rusd_work_drop_idle(struct work_struct *work)
+{
+	struct nvkm_gsp *gsp = container_of(to_delayed_work(work),
+					    struct nvkm_gsp, rusd.work);
+	unsigned long idle = msecs_to_jiffies(R570_RUSD_IDLE_MS);
+	u64 mask = 0;
+	int g;
+
+	mutex_lock(&gsp->rusd.mutex);
+	if (gsp->rusd.valid) {
+		for (g = 0; g < NVKM_GSP_RUSD_GROUP_COUNT; g++) {
+			if (gsp->rusd.group_access[g] &&
+			    time_before(jiffies, gsp->rusd.group_access[g] + idle))
+				mask |= r570_rusd_group_mask[g];
+		}
+
+		r570_rusd_set_mask(gsp, mask);
+
+		/* Re-check until every group has gone idle. */
+		if (mask)
+			schedule_delayed_work(&gsp->rusd.work, idle);
+	}
+	mutex_unlock(&gsp->rusd.mutex);
+}
+
+static int
+r570_rusd_rpc_init(struct nvkm_gsp *gsp)
+{
+	NV2080_CTRL_INTERNAL_USER_SHARED_DATA_SET_DATA_POLL_PARAMS *poll;
+	NV2080_CTRL_INTERNAL_INIT_USER_SHARED_DATA_PARAMS *init;
+	struct nvkm_gsp_object *subdevice = &gsp->internal.device.subdevice;
+	int ret;
+
+	init = nvkm_gsp_rm_ctrl_get(subdevice,
+				    NV2080_CTRL_CMD_INTERNAL_INIT_USER_SHARED_DATA,
+				    sizeof(*init));
+	if (IS_ERR(init))
+		return PTR_ERR(init);
+
+	init->physAddr = gsp->rusd.mem.addr;
+
+	ret = nvkm_gsp_rm_ctrl_wr(subdevice, init);
+	if (ret)
+		return ret;
+
+	/* Polling costs power, so we establish the poll interval up front with an
+	 * empty mask and groups are added later on demand.
+	 */
+	poll = nvkm_gsp_rm_ctrl_get(subdevice,
+				    NV2080_CTRL_CMD_INTERNAL_USER_SHARED_DATA_SET_DATA_POLL,
+				    sizeof(*poll));
+	if (IS_ERR(poll))
+		return PTR_ERR(poll);
+
+	poll->polledDataMask = 0;
+	poll->pollFrequencyMs = gsp->rusd.poll_ms;
+
+	ret = nvkm_gsp_rm_ctrl_wr(subdevice, poll);
+	if (ret)
+		return ret;
+
+	/* Nothing is being polled yet; reads will enable groups as needed.
+	 * Runs single-threaded (cold init, or resume with @work cancelled and
+	 * reads gated), so it needs no lock.
+	 */
+	memset(gsp->rusd.group_access, 0, sizeof(gsp->rusd.group_access));
+	gsp->rusd.mask = 0;
+	return 0;
+}
+
+static int
+r570_rusd_init(struct nvkm_gsp *gsp)
+{
+	int g, ret;
+
+	/* The RUSD struct doesn't have a size field, and the GSP writes at its
+	 * firmware-defined offsets. With 32-bit u64 alignment, our copy of the
+	 * layout shrinks which would leave GSP writing past the end of the
+	 * buffer we hand it so fail closed on 32-bit builds.
+	 */
+	if (!IS_ENABLED(CONFIG_64BIT))
+		return -ENODEV;
+
+	if (!gsp->rusd.mem.data) {
+		ret = nvkm_gsp_mem_ctor(gsp, sizeof(NV00DE_SHARED_DATA),
+					&gsp->rusd.mem);
+		if (ret)
+			return ret;
+
+		mutex_init(&gsp->rusd.mutex);
+		INIT_DELAYED_WORK(&gsp->rusd.work, r570_rusd_work_drop_idle);
+	}
+
+	gsp->rusd.poll_ms = R570_RUSD_POLL_MS;
+
+	ret = r570_rusd_rpc_init(gsp);
+	if (ret) {
+		nvkm_warn(&gsp->subdev, "rusd: init failed, %d\n", ret);
+		return ret;
+	}
+
+	gsp->rusd.valid = true;
+
+	/* Warm every group up once so hwmon registration can probe which
+	 * sensors the GPU actually supports without stalling a poll cycle,
+	 * and the first userspace read is instant.
+	 */
+	for (g = 0; g < NVKM_GSP_RUSD_GROUP_COUNT; g++)
+		r570_rusd_poke(gsp, g);
+
+	return 0;
+}
+
+/* Re-register the buffer and re-establish the idle interval on resume. */
+static void
+r570_rusd_resume(struct nvkm_gsp *gsp)
+{
+	if (!gsp->rusd.mem.data)
+		return;
+
+	gsp->rusd.valid = r570_rusd_rpc_init(gsp) == 0;
+	if (!gsp->rusd.valid)
+		nvkm_warn(&gsp->subdev, "rusd: resume failed\n");
+}
+
+/*
+ * Copy one section out of the shared buffer, untorn. Every section starts
+ * with a u64 timestamp GSP-RM sets to WRITE_IN_PROGRESS while updating it.
+ */
+static int
+r570_rusd_read_section(struct nvkm_gsp *gsp, size_t offset, size_t size, void *data)
+{
+	const void *sect = gsp->rusd.mem.data + offset;
+	u64 seq0, seq1;
+	int retries;
+
+	for (retries = 10; retries; retries--) {
+		seq0 = READ_ONCE(*(const u64 *)sect);
+		if (seq0 == RUSD_TIMESTAMP_INVALID)
+			return -ENODATA;
+		if (seq0 == RUSD_TIMESTAMP_WRITE_IN_PROGRESS)
+			continue;
+		/* Sequence counters appear only in sections written by the kernel and
+		 * never in GSP-polled ones.
+		 */
+		if (seq0 >= RUSD_SEQ_START)
+			return -ENODATA;
+
+		dma_rmb();
+		memcpy(data, sect, size);
+		dma_rmb();
+
+		seq1 = READ_ONCE(*(const u64 *)sect);
+		if (seq1 == seq0)
+			return 0;
+	}
+
+	return -EAGAIN;
+}
+
+static int
+r570_rusd_read(struct nvkm_gsp *gsp, enum nvkm_gsp_rusd_item item, s64 *val)
+{
+	size_t offset;
+	u32 mw;
+	int ret;
+
+	if (!gsp->running)
+		return -EINVAL;
+
+	/* Demand the item's poll group. If it was idle this enables polling
+	 * but the section won't be filled for up to one poll interval, so the
+	 * first read after idle returns -ENODATA; the next one has data.
+	 */
+	r570_rusd_poke(gsp, r570_rusd_item_group(item));
+
+	switch (item) {
+	case NVKM_GSP_RUSD_TEMP_GPU:
+	case NVKM_GSP_RUSD_TEMP_HBM: {
+		RUSD_TEMPERATURE temp;
+
+		offset = offsetof(NV00DE_SHARED_DATA, temperatures);
+		if (item == NVKM_GSP_RUSD_TEMP_HBM)
+			offset += RUSD_TEMPERATURE_TYPE_HBM * sizeof(temp);
+
+		ret = r570_rusd_read_section(gsp, offset, sizeof(temp), &temp);
+		if (ret)
+			return ret;
+
+		/* NvTemp is signed 24.8 fixed-point degrees Celsius. */
+		*val = ((s64)temp.temperature * 1000) >> 8;
+		return 0;
+	}
+	case NVKM_GSP_RUSD_POWER_GPU:
+	case NVKM_GSP_RUSD_POWER_BOARD:
+	case NVKM_GSP_RUSD_POWER_CPU: {
+		RUSD_INST_POWER_USAGE inst;
+
+		ret = r570_rusd_read_section(gsp,
+					     offsetof(NV00DE_SHARED_DATA, instPowerUsage),
+					     sizeof(inst), &inst);
+		if (ret)
+			return ret;
+
+		if (item == NVKM_GSP_RUSD_POWER_GPU)
+			mw = inst.info.instGpuPower;
+		else if (item == NVKM_GSP_RUSD_POWER_BOARD)
+			mw = inst.info.instModulePower;
+		else
+			mw = inst.info.instCpuPower;
+		break;
+	}
+	case NVKM_GSP_RUSD_POWER_GPU_AVG:
+	case NVKM_GSP_RUSD_POWER_BOARD_AVG:
+	case NVKM_GSP_RUSD_POWER_VRAM_AVG: {
+		RUSD_AVG_POWER_USAGE avg;
+
+		ret = r570_rusd_read_section(gsp,
+					     offsetof(NV00DE_SHARED_DATA, avgPowerUsage),
+					     sizeof(avg), &avg);
+		if (ret)
+			return ret;
+
+		if (item == NVKM_GSP_RUSD_POWER_GPU_AVG)
+			mw = avg.info.averageGpuPower;
+		else if (item == NVKM_GSP_RUSD_POWER_BOARD_AVG)
+			mw = avg.info.averageModulePower;
+		else
+			mw = avg.info.averageMemoryPower;
+		break;
+	}
+	case NVKM_GSP_RUSD_POWER_CAP:
+	case NVKM_GSP_RUSD_POWER_LIMIT_REQUESTED: {
+		RUSD_POWER_LIMITS limits;
+
+		ret = r570_rusd_read_section(gsp,
+					     offsetof(NV00DE_SHARED_DATA, powerLimitGpu),
+					     sizeof(limits), &limits);
+		if (ret)
+			return ret;
+
+		mw = item == NVKM_GSP_RUSD_POWER_CAP ? limits.info.enforcedmW :
+						       limits.info.requestedmW;
+		break;
+	}
+	case NVKM_GSP_RUSD_CLOCK_GRAPHICS ... NVKM_GSP_RUSD_CLOCK_SM: {
+		RUSD_CLK_PUBLIC_DOMAIN_INFOS clk;
+
+		int idx = item - NVKM_GSP_RUSD_CLOCK_GRAPHICS;
+
+		ret = r570_rusd_read_section(gsp,
+					     offsetof(NV00DE_SHARED_DATA, clkPublicDomainInfos),
+					     sizeof(clk), &clk);
+		if (ret)
+			return ret;
+
+		*val = clk.info[idx].targetClkMHz;
+		return 0;
+	}
+	case NVKM_GSP_RUSD_UTIL_GPU:
+	case NVKM_GSP_RUSD_UTIL_MEMORY:
+	case NVKM_GSP_RUSD_UTIL_NVENC ... NVKM_GSP_RUSD_UTIL_NVOFA_PERIOD: {
+		RUSD_PERF_DEVICE_UTILIZATION util;
+		RUSD_PERF_DEVICE_UTILIZATION_INFO *u = &util.info;
+
+		ret = r570_rusd_read_section(gsp,
+					     offsetof(NV00DE_SHARED_DATA, perfDevUtil),
+					     sizeof(util), &util);
+		if (ret)
+			return ret;
+
+		if (item == NVKM_GSP_RUSD_UTIL_GPU)
+			*val = u->gpuPercentBusy;
+		else if (item == NVKM_GSP_RUSD_UTIL_MEMORY)
+			*val = u->memoryPercentBusy;
+		else if (item <= NVKM_GSP_RUSD_UTIL_NVOFA)
+			*val = u->engUtil[item - NVKM_GSP_RUSD_UTIL_NVENC].clkPercentBusy;
+		else
+			*val = u->engUtil[item - NVKM_GSP_RUSD_UTIL_NVENC_PERIOD].samplingPeriodUs;
+		return 0;
+	}
+	case NVKM_GSP_RUSD_PSTATE: {
+		RUSD_PERF_CURRENT_PSTATE pstate;
+
+		ret = r570_rusd_read_section(gsp,
+					     offsetof(NV00DE_SHARED_DATA, perfCurrentPstate),
+					     sizeof(pstate), &pstate);
+		if (ret)
+			return ret;
+
+		*val = pstate.currentPstate;
+		return 0;
+	}
+	case NVKM_GSP_RUSD_THROTTLE_MASK ... NVKM_GSP_RUSD_THROTTLE_DISPLAY_CLOCK: {
+		static const u32 bits[] = {
+			RUSD_CLK_THROTTLE_REASON_GPU_IDLE,
+			RUSD_CLK_THROTTLE_REASON_APPLICATION_CLOCK_SETTING,
+			RUSD_CLK_THROTTLE_REASON_SW_POWER_CAP,
+			RUSD_CLK_THROTTLE_REASON_HW_SLOWDOWN,
+			RUSD_CLK_THROTTLE_REASON_SYNC_BOOST,
+			RUSD_CLK_THROTTLE_REASON_SW_THERMAL_SLOWDOWN,
+			RUSD_CLK_THROTTLE_REASON_HW_THERMAL_SLOWDOWN,
+			RUSD_CLK_THROTTLE_REASON_HW_POWER_BRAKES_SLOWDOWN,
+			RUSD_CLK_THROTTLE_REASON_DISPLAY_CLOCK_SETTING,
+		};
+
+		RUSD_CLK_THROTTLE_REASON thr;
+
+		ret = r570_rusd_read_section(gsp,
+					     offsetof(NV00DE_SHARED_DATA, clkThrottleReason),
+					     sizeof(thr), &thr);
+		if (ret)
+			return ret;
+
+		if (item == NVKM_GSP_RUSD_THROTTLE_MASK)
+			*val = thr.reasonMask;
+		else
+			*val = !!(thr.reasonMask &
+				  bits[item - NVKM_GSP_RUSD_THROTTLE_GPU_IDLE]);
+		return 0;
+	}
+	case NVKM_GSP_RUSD_ECC_TOTAL_CE_VOL ... NVKM_GSP_RUSD_ECC_SRAM_UE_AGG: {
+		int n = item - NVKM_GSP_RUSD_ECC_TOTAL_CE_VOL;
+
+		RUSD_MEM_ECC ecc;
+		u64 counts[4];
+
+		ret = r570_rusd_read_section(gsp,
+					     offsetof(NV00DE_SHARED_DATA, memEcc),
+					     sizeof(ecc), &ecc);
+		if (ret)
+			return ret;
+
+		counts[0] = ecc.count[n / 4].correctedVolatile;
+		counts[1] = ecc.count[n / 4].correctedAggregate;
+		counts[2] = ecc.count[n / 4].uncorrectedVolatile;
+		counts[3] = ecc.count[n / 4].uncorrectedAggregate;
+		*val = counts[n % 4];
+		return 0;
+	}
+	case NVKM_GSP_RUSD_ROWREMAP_HIST_MAX ... NVKM_GSP_RUSD_ROWREMAP_FAILURE: {
+		RUSD_MEM_ROW_REMAP remap;
+
+		ret = r570_rusd_read_section(gsp,
+					     offsetof(NV00DE_SHARED_DATA, memRowRemap),
+					     sizeof(remap), &remap);
+		if (ret)
+			return ret;
+
+		switch (item) {
+		case NVKM_GSP_RUSD_ROWREMAP_HIST_MAX:
+			*val = remap.info.histogramMax;
+			break;
+		case NVKM_GSP_RUSD_ROWREMAP_HIST_HIGH:
+			*val = remap.info.histogramHigh;
+			break;
+		case NVKM_GSP_RUSD_ROWREMAP_HIST_PARTIAL:
+			*val = remap.info.histogramPartial;
+			break;
+		case NVKM_GSP_RUSD_ROWREMAP_HIST_LOW:
+			*val = remap.info.histogramLow;
+			break;
+		case NVKM_GSP_RUSD_ROWREMAP_HIST_NONE:
+			*val = remap.info.histogramNone;
+			break;
+		case NVKM_GSP_RUSD_ROWREMAP_CORRECTABLE:
+			*val = remap.info.correctableRows;
+			break;
+		case NVKM_GSP_RUSD_ROWREMAP_UNCORRECTABLE:
+			*val = remap.info.uncorrectableRows;
+			break;
+		case NVKM_GSP_RUSD_ROWREMAP_PENDING:
+			*val = remap.info.isPending;
+			break;
+		default: /* NVKM_GSP_RUSD_ROWREMAP_FAILURE */
+			*val = remap.info.hasFailureOccurred;
+			break;
+		}
+		return 0;
+	}
+	case NVKM_GSP_RUSD_PCIE_GEN ... NVKM_GSP_RUSD_PCIE_UNSUPPORTED_REQUESTS: {
+		RUSD_PCIE_DATA pcie;
+
+		int idx = item - NVKM_GSP_RUSD_PCIE_GEN;
+
+		ret = r570_rusd_read_section(gsp,
+					     offsetof(NV00DE_SHARED_DATA, pciBusData),
+					     sizeof(pcie), &pcie);
+		if (ret)
+			return ret;
+
+		*val = pcie.info.data[idx];
+		return 0;
+	}
+	default:
+		return -EINVAL;
+	}
+
+	/* A reading of 0 mW is indistinguishable from "not supported on this
+	 * board" (e.g. module power on Ampere/Hopper).
+	 */
+	if (!mw)
+		return -ENODATA;
+
+	*val = (s64)mw * 1000;
+	return 0;
+}
+
+const struct nvkm_rm_api_rusd
+r570_rusd = {
+	.init = r570_rusd_init,
+	.resume = r570_rusd_resume,
+	.read = r570_rusd_read,
+};
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h
index a9af94adf9ef..1338b4a88f95 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h
@@ -130,6 +130,12 @@ struct nvkm_rm_api {
 			void (*fini)(struct r535_gr *);
 		} scrubber;
 	} *gr;
+
+	const struct nvkm_rm_api_rusd {
+		int (*init)(struct nvkm_gsp *);
+		void (*resume)(struct nvkm_gsp *);
+		int (*read)(struct nvkm_gsp *, enum nvkm_gsp_rusd_item, s64 *);
+	} *rusd;
 };
 
 extern const struct nvkm_rm_impl r535_rm_tu102;
@@ -188,4 +194,5 @@ extern const struct nvkm_rm_api_gr r570_gr;
 int r570_gr_gpc_mask(struct nvkm_gsp *, u32 *mask);
 int r570_gr_tpc_mask(struct nvkm_gsp *, int gpc, u32 *mask);
 extern const struct nvkm_rm_api_engine r570_ofa;
+extern const struct nvkm_rm_api_rusd r570_rusd;
 #endif
-- 
2.55.0

