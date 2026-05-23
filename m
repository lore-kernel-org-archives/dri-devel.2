Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB12CD4F54
	for <dri-devel@archiver.kernel.org>; Sat, 23 May 2026 08:37:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AFC310E05D;
	Sat, 23 May 2026 08:37:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="naYPySXd";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6794B10E05D
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 08:37:49 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4891b0786beso54996915e9.1
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 01:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779525468; x=1780130268; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iEV8cV1mvF+DTLV7sE+V+FHTBiYla5IN8OnVepNF7IY=;
 b=naYPySXdSEoDGxvwksxfaLIHbb5mSdUpMFN45KAnLX53RbDO12pq8xW2kSKZs4TfRz
 aAOCPzhTXxs83r5a52qH1Q3pKOuEyoRcR26Mg0BDnaueL7Fzyp6xWfVz3j1FzYi0dzTC
 cLALBwyiiP8dP7M4XU2hAF9rNS6uLQStlyIAYKZgnY4JoeMdDaVvfl8d0+ey24HwFclo
 nSE0Iz5Tee+uMqFkO3ouxCmcaxLcJI6YY0a86XSGRBWvv7Cx2s0xmX7FpERx+vYJboui
 l17UZDzIijy5lqWraig6rHcix68tw9+Um7tB1fBLNx4OKWD0xSL9EzyV5d5N66VnFFbc
 cMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779525468; x=1780130268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iEV8cV1mvF+DTLV7sE+V+FHTBiYla5IN8OnVepNF7IY=;
 b=pn0KS/c4uOhPueQfW5bOkAi38bexhif6dyCJ5+9cFh0ng/16L+tM1t207s9SPLCyyN
 bk5TRi6qsvnw6HYz9kUtf1iBOODPd2pGKI0+b44/tvSSMqgM6yIu+iucbDIhgSJsptGx
 5rTfa6Nt54nBFcoE1/uuV6bnMf7sbhLlQVUYuRln3g7Jy3dQbvSwAk35fApcp0ajmZuj
 WaztRZNKyTRJq4E2rut0yqLIbFAXOq6vIWOeSY8aDAj+RGV3EgpdqI8XoJb/RLW9kjWU
 6vwdITr+GfjnXQ1o2aRHQG64zOkAxOq4oYoakx2nrpdg3x+XHeurUis6mVj+d9qmBqL+
 CctA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8CbBv5pKtAF5YchYUFrZgkqcbGkG1MLhqF9cZPpn/luLF8F/V9WOBqjXEfZOd8vdvWKnM50ZjjP6A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyIqdwVr58Z6p2h2VXoJ6tTMPxzJu6I1AABIhbnpf8sqyxyPWH+
 CpjQ9SOth8OBO1pBVrO8WFVfkwKI3GiXzzz5IjkdhfxzlkyTKO0U8g5T
X-Gm-Gg: Acq92OFCseOSn4Yc0W7P04W1xrKMpULBfJEkcgjR91W/E4CTOIwO+jFASdGdeYYpYX/
 OUFgEd7e+/CEcHQkWzvjcT1BasnKzxR/XB9jxzdpKqHKvc+sVM4sVParBwIo0U9GZp3FLbU8cn6
 r2v8vP6lvCERp1og7xPJxShGPmKx//BzQ+Gnk7pksrgBdP2fd/btTAyspjFg2dbLGJxSHFrr/gc
 1ovVCITpJ2l0tYCE4wLnlyk05obnt1YkTNYBj0ur2YRiI+kXhQtbMwohQlXhP8A7+3gsxLtUbcA
 VgjC0d7KrLX0RTKpP1nFJrnwd2pFA47yemv3x7+L2TPrkIWBtARpkhaHBuXLZ49KML/2g90VKHs
 qZo4BmA+rwTbV0Nyn6UkVp2NuFiU3xEom54XlW9NGU/lI2/f1inmms7hlP6YJt4J25DlGCzJNqH
 0Th36jNSizz+5hFAY3b+kdj8x3pdvBTvkV2NRN3qVUCtfumpejvy7i2zWS7kGqmt1bfFLWgz5PT
 VeS/DQptvh6K5mhvWOIfU+jLsHnu19Zhx9I2Vv6grZwb6FVyUJFpGFKk2AIGQQE1w==
X-Received: by 2002:a05:600c:3587:b0:48f:e230:2a20 with SMTP id
 5b1f17b1804b1-490428eb9eemr106245475e9.31.1779525467455; 
 Sat, 23 May 2026 01:37:47 -0700 (PDT)
Received: from alcachofa (172.red-88-20-155.staticip.rima-tde.net.
 [88.20.155.172]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904527dbf3sm93110265e9.6.2026.05.23.01.37.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 01:37:46 -0700 (PDT)
From: Tomeu Vizoso <tomeu.vizoso@gmail.com>
X-Google-Original-From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
To: "Rob Herring (Arm)" <robh@kernel.org>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-kernel@vger.kernel.org (open list),
 dri-devel@lists.freedesktop.org (open list:ARM ETHOS-U NPU DRIVER),
 linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by
 other areas):Keyword:\b__counted_by(_le|_be)?\b)
Cc: linux-kernel@vger.kernel.org (open list),
 dri-devel@lists.freedesktop.org (open list:ARM ETHOS-U NPU DRIVER),
 linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by
 other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH v3] accel: ethosu: Add performance counter support
Date: Sat, 23 May 2026 10:37:22 +0200
Message-ID: <20260523083730.255310-1-tomeu@tomeuvizoso.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515032625.1880618-1-robh@kernel.org>
References: <20260515032625.1880618-1-robh@kernel.org>
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

From: "Rob Herring (Arm)" <robh@kernel.org>

The Arm Ethos-U NPUs have a PMU with performance counters. The PMU h/w
supports up to 4 (U65) or 8 (U85) counters which can be programmed for
different events. There is also a dedicated cycle counter.

The ABI and implementation are copied from the V3D driver. The main
difference in the ABI is there is no query API for the the event list.
The events differ between the U65 and U85, so the events lists are
maintained in userspace along with other differences between the U65 and
U85.

The cycle counter is always enabled when the PMU is enabled. When the
user requests N events, reading the counters will return the N events
plus the cycle counter.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
---
v2:
 - Use XArray instead of idr
 - Rework locking to use per device spinlock to protect modifying active
   perfmon. Based on pending V3D changes:
   https://lore.kernel.org/all/20260508-v3d-perfmon-lifetime-v1-1-f5b5642c085f@igalia.com/
 - Add missing perfmon puts in ethosu_ioctl_perfmon_set_global() and
   ethosu_ioctl_perfmon_get_values() error paths.
 - Fix reading number of counters on U85.
 - Add defines NPU_REG_PMCCNTR_CFG

v3:
 - Add explicit padding to drm_ethosu_perfmon_destroy
 - Fix SPDX license expression
 - Fix comment typos
 - Convert perfmon lock from spinlock to mutex
 - Simplify switch_perfmon condition check
 - Remove unused ethosu_perfmon_init
 - Add lockdep_assert_held to ethosu_perfmon_stop_locked
---
 drivers/accel/ethosu/Makefile         |   2 +-
 drivers/accel/ethosu/ethosu_device.h  |  33 +++
 drivers/accel/ethosu/ethosu_drv.c     |  23 +-
 drivers/accel/ethosu/ethosu_drv.h     |  61 +++++-
 drivers/accel/ethosu/ethosu_job.c     |  39 +++-
 drivers/accel/ethosu/ethosu_job.h     |   2 +
 drivers/accel/ethosu/ethosu_perfmon.c | 298 ++++++++++++++++++++++++++
 include/uapi/drm/ethosu_accel.h       |  60 +++++-
 8 files changed, 504 insertions(+), 14 deletions(-)
 create mode 100644 drivers/accel/ethosu/ethosu_perfmon.c

diff --git a/drivers/accel/ethosu/Makefile b/drivers/accel/ethosu/Makefile
index 17db5a600416..598a388b7179 100644
--- a/drivers/accel/ethosu/Makefile
+++ b/drivers/accel/ethosu/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 obj-$(CONFIG_DRM_ACCEL_ARM_ETHOSU) := ethosu.o
-ethosu-y += ethosu_drv.o ethosu_gem.o ethosu_job.o
+ethosu-y += ethosu_drv.o ethosu_gem.o ethosu_job.o ethosu_perfmon.o
diff --git a/drivers/accel/ethosu/ethosu_device.h b/drivers/accel/ethosu/ethosu_device.h
index b189fa783d6a..3a1d07d94785 100644
--- a/drivers/accel/ethosu/ethosu_device.h
+++ b/drivers/accel/ethosu/ethosu_device.h
@@ -6,6 +6,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/mutex.h>
 #include <linux/types.h>
 
 #include <drm/drm_device.h>
@@ -43,6 +44,15 @@ struct gen_pool;
 #define NPU_REG_BASEP_HI(x)	(0x0084 + (x) * 8)
 #define NPU_BASEP_REGION_MAX	8
 
+#define NPU_REG_PMCR		0x0180
+#define NPU_REG_PMCNTENSET	0x0184
+#define NPU_REG_PMCNTENCLR	0x0188
+#define NPU_REG_PMCCNTR_LO	0x01A0
+#define NPU_REG_PMCCNTR_HI	0x01A4
+#define NPU_REG_PMCCNTR_CFG	0x01A8
+#define NPU_REG_PMU_EVCNTR(x)	(0x0300 + (x) * 4)
+#define NPU_REG_PMU_EVTYPER(x)	(0x0380 + (x) * 4)
+
 #define ID_ARCH_MAJOR_MASK	GENMASK(31, 28)
 #define ID_ARCH_MINOR_MASK	GENMASK(27, 20)
 #define ID_ARCH_PATCH_MASK	GENMASK(19, 16)
@@ -67,6 +77,15 @@ struct gen_pool;
 
 #define PROT_ACTIVE_CSL		BIT(1)
 
+#define PMCR_NUM_EVENT_CNT_MASK	GENMASK(15, 11)
+#define PMCR_CYCLE_CNT_RST	BIT(2)
+#define PMCR_EVENT_CNT_RST	BIT(1)
+#define PMCR_CNT_EN		BIT(0)
+
+#define PMU_EV_TYPE_NONE	0
+#define PMU_EV_TYPE_CYCLES	0x11
+#define PMU_EV_TYPE_IDLE	0x20
+
 enum ethosu_cmds {
 	NPU_OP_CONV = 0x2,
 	NPU_OP_DEPTHWISE = 0x3,
@@ -152,6 +171,8 @@ enum ethosu_cmds {
 
 #define ETHOSU_SRAM_REGION	2	/* Matching Vela compiler */
 
+struct ethosu_perfmon;
+
 /**
  * struct ethosu_device - Ethosu device
  */
@@ -161,6 +182,7 @@ struct ethosu_device {
 
 	/** @iomem: CPU mapping of the registers. */
 	void __iomem *regs;
+	void __iomem *pmu_regs;
 
 	void __iomem *sram;
 	struct gen_pool *srampool;
@@ -184,6 +206,17 @@ struct ethosu_device {
 	struct mutex sched_lock;
 	u64 fence_context;
 	u64 emit_seqno;
+
+	/* Tracks the performance monitor state. */
+	struct {
+		/* Protects @active. */
+		struct mutex lock;
+
+		/* Perfmon currently programmed in HW (or NULL if none). */
+		struct ethosu_perfmon *active;
+	} perfmon_state;
+
+	struct ethosu_perfmon *global_perfmon;
 };
 
 #define to_ethosu_device(drm_dev) \
diff --git a/drivers/accel/ethosu/ethosu_drv.c b/drivers/accel/ethosu/ethosu_drv.c
index 9992193d7338..105517e700e2 100644
--- a/drivers/accel/ethosu/ethosu_drv.c
+++ b/drivers/accel/ethosu/ethosu_drv.c
@@ -155,6 +155,7 @@ static int ethosu_open(struct drm_device *ddev, struct drm_file *file)
 	if (ret)
 		goto err_put_mod;
 
+	ethosu_perfmon_open_file(priv);
 	file->driver_priv = no_free_ptr(priv);
 	return 0;
 
@@ -166,6 +167,7 @@ static int ethosu_open(struct drm_device *ddev, struct drm_file *file)
 static void ethosu_postclose(struct drm_device *ddev, struct drm_file *file)
 {
 	ethosu_job_close(file->driver_priv);
+	ethosu_perfmon_close_file(file->driver_priv);
 	kfree(file->driver_priv);
 	module_put(THIS_MODULE);
 }
@@ -180,6 +182,10 @@ static const struct drm_ioctl_desc ethosu_drm_driver_ioctls[] = {
 	ETHOSU_IOCTL(BO_MMAP_OFFSET, bo_mmap_offset, 0),
 	ETHOSU_IOCTL(CMDSTREAM_BO_CREATE, cmdstream_bo_create, 0),
 	ETHOSU_IOCTL(SUBMIT, submit, 0),
+	ETHOSU_IOCTL(PERFMON_CREATE, perfmon_create, 0),
+	ETHOSU_IOCTL(PERFMON_DESTROY, perfmon_destroy, 0),
+	ETHOSU_IOCTL(PERFMON_GET_VALUES, perfmon_get_values, 0),
+	ETHOSU_IOCTL(PERFMON_SET_GLOBAL, perfmon_set_global, 0),
 };
 
 DEFINE_DRM_ACCEL_FOPS(ethosu_drm_driver_fops);
@@ -312,11 +318,16 @@ static int ethosu_init(struct ethosu_device *ethosudev)
 
 	ethosudev->npu_info.id = id = readl_relaxed(ethosudev->regs + NPU_REG_ID);
 	ethosudev->npu_info.config = config = readl_relaxed(ethosudev->regs + NPU_REG_CONFIG);
-
 	ethosu_sram_init(ethosudev);
 
+	if (!ethosu_is_u65(ethosudev))
+		ethosudev->pmu_regs += 0x1000;
+
+	ethosudev->npu_info.pmu_counters = FIELD_GET(PMCR_NUM_EVENT_CNT_MASK,
+		readl_relaxed(ethosudev->pmu_regs + NPU_REG_PMCR));
+
 	dev_info(ethosudev->base.dev,
-		 "Ethos-U NPU, arch v%ld.%ld.%ld, rev r%ldp%ld, cmd stream ver%ld, %d MACs, %dKB SRAM\n",
+		 "Ethos-U NPU, arch v%ld.%ld.%ld, rev r%ldp%ld, cmd stream ver%ld, %d MACs, %dKB SRAM, %d PMU cntrs\n",
 		 FIELD_GET(ID_ARCH_MAJOR_MASK, id),
 		 FIELD_GET(ID_ARCH_MINOR_MASK, id),
 		 FIELD_GET(ID_ARCH_PATCH_MASK, id),
@@ -324,7 +335,8 @@ static int ethosu_init(struct ethosu_device *ethosudev)
 		 FIELD_GET(ID_VER_MINOR_MASK, id),
 		 FIELD_GET(CONFIG_CMD_STREAM_VER_MASK, config),
 		 1 << FIELD_GET(CONFIG_MACS_PER_CC_MASK, config),
-		 ethosudev->npu_info.sram_size / 1024);
+		 ethosudev->npu_info.sram_size / 1024,
+		 ethosudev->npu_info.pmu_counters);
 
 	return 0;
 }
@@ -343,11 +355,16 @@ static int ethosu_probe(struct platform_device *pdev)
 	dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(40));
 
 	ethosudev->regs = devm_platform_ioremap_resource(pdev, 0);
+	ethosudev->pmu_regs = ethosudev->regs;
 
 	ethosudev->num_clks = devm_clk_bulk_get_all(&pdev->dev, &ethosudev->clks);
 	if (ethosudev->num_clks < 0)
 		return ethosudev->num_clks;
 
+	ret = devm_mutex_init(&pdev->dev, &ethosudev->perfmon_state.lock);
+	if (ret)
+		return ret;
+
 	ret = ethosu_job_init(ethosudev);
 	if (ret)
 		return ret;
diff --git a/drivers/accel/ethosu/ethosu_drv.h b/drivers/accel/ethosu/ethosu_drv.h
index 9e21dfe94184..2193bc51d425 100644
--- a/drivers/accel/ethosu/ethosu_drv.h
+++ b/drivers/accel/ethosu/ethosu_drv.h
@@ -1,15 +1,74 @@
 /* SPDX-License-Identifier: GPL-2.0-only OR MIT */
-/* Copyright 2025 Arm, Ltd. */
+/* Copyright 2025-2026 Arm, Ltd. */
 #ifndef __ETHOSU_DRV_H__
 #define __ETHOSU_DRV_H__
 
+#include <linux/mutex.h>
+#include <linux/xarray.h>
 #include <drm/gpu_scheduler.h>
 
 struct ethosu_device;
+struct drm_device;
+struct drm_file;
 
 struct ethosu_file_priv {
 	struct ethosu_device *edev;
 	struct drm_sched_entity sched_entity;
+	struct xarray perfmons;
 };
 
+/* Performance monitor object. The perfmon lifetime is controlled by userspace
+ * using perfmon related ioctls. A perfmon can be attached to a DRM_ETHOSU_SUBMIT
+ * request, and when this is the case, HW perf counters will be activated just
+ * before the job is submitted to the NPU and disabled when the job is
+ * done. This way, only events related to a specific job will be counted.
+ */
+struct ethosu_perfmon {
+	/* Tracks the number of users of the perfmon, when this counter reaches
+	 * zero the perfmon is destroyed.
+	 */
+	refcount_t refcnt;
+
+	/* Number of counters activated in this perfmon instance
+	 * (should be less than or equal to DRM_ETHOSU_MAX_PERF_COUNTERS).
+	 */
+	u8 ncounters;
+
+	/* Events counted by the HW perf counters. */
+	u16 counters[DRM_ETHOSU_MAX_PERF_EVENT_COUNTERS];
+
+	/*
+	 * Storage for counter values. Counters are incremented by the HW
+	 * perf counter values every time the perfmon is attached to an
+	 * NPU job. This way, perfmon users don't have to retrieve the
+	 * results after each job if they want to track events covering
+	 * several submissions. Note that counter values can't be reset,
+	 * but you can fake a reset by destroying the perfmon and
+	 * creating a new one.
+	 */
+	u64 values[] __counted_by(ncounters);
+};
+
+/* ethosu_perfmon.c */
+void ethosu_perfmon_get(struct ethosu_perfmon *perfmon);
+void ethosu_perfmon_put(struct ethosu_perfmon *perfmon);
+void ethosu_perfmon_start(struct ethosu_device *ethosu,
+			  struct ethosu_perfmon *perfmon);
+void ethosu_perfmon_stop(struct ethosu_device *ethosu,
+			 struct ethosu_perfmon *perfmon, bool capture);
+void ethosu_perfmon_stop_locked(struct ethosu_device *ethosu, struct ethosu_perfmon *perfmon,
+				bool capture);
+struct ethosu_perfmon *ethosu_perfmon_find(struct ethosu_file_priv *ethosu_priv,
+					   int id);
+void ethosu_perfmon_open_file(struct ethosu_file_priv *ethosu_priv);
+void ethosu_perfmon_close_file(struct ethosu_file_priv *ethosu_priv);
+int ethosu_ioctl_perfmon_create(struct drm_device *dev, void *data,
+				struct drm_file *file_priv);
+int ethosu_ioctl_perfmon_destroy(struct drm_device *dev, void *data,
+				 struct drm_file *file_priv);
+int ethosu_ioctl_perfmon_get_values(struct drm_device *dev, void *data,
+				    struct drm_file *file_priv);
+int ethosu_ioctl_perfmon_set_global(struct drm_device *dev, void *data,
+				    struct drm_file *file_priv);
+
 #endif
diff --git a/drivers/accel/ethosu/ethosu_job.c b/drivers/accel/ethosu/ethosu_job.c
index b76924645aaa..99dec33f526b 100644
--- a/drivers/accel/ethosu/ethosu_job.c
+++ b/drivers/accel/ethosu/ethosu_job.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only OR MIT
 /* Copyright 2024-2025 Tomeu Vizoso <tomeu@tomeuvizoso.net> */
-/* Copyright 2025 Arm, Ltd. */
+/* Copyright 2025-2026 Arm, Ltd. */
 
 #include <linux/bitfield.h>
 #include <linux/genalloc.h>
@@ -147,6 +147,8 @@ static void ethosu_job_err_cleanup(struct ethosu_job *job)
 {
 	unsigned int i;
 
+	ethosu_perfmon_put(job->perfmon);
+
 	for (i = 0; i < job->region_cnt; i++)
 		drm_gem_object_put(job->region_bo[i]);
 
@@ -181,6 +183,26 @@ static void ethosu_job_free(struct drm_sched_job *sched_job)
 	ethosu_job_put(job);
 }
 
+static void
+ethosu_switch_perfmon(struct ethosu_device *ethosu, struct ethosu_job *job)
+{
+	struct ethosu_perfmon *perfmon;
+
+	guard(mutex)(&ethosu->perfmon_state.lock);
+
+	perfmon = ethosu->global_perfmon;
+	if (!perfmon)
+		perfmon = job->perfmon;
+
+	if (perfmon == ethosu->perfmon_state.active)
+		return;
+
+	ethosu_perfmon_stop_locked(ethosu, ethosu->perfmon_state.active, true);
+
+	if (perfmon)
+		ethosu_perfmon_start(ethosu, perfmon);
+}
+
 static struct dma_fence *ethosu_job_run(struct drm_sched_job *sched_job)
 {
 	struct ethosu_job *job = to_ethosu_job(sched_job);
@@ -194,6 +216,8 @@ static struct dma_fence *ethosu_job_run(struct drm_sched_job *sched_job)
 		       dev->fence_context, ++dev->emit_seqno);
 	dma_fence_get(fence);
 
+	ethosu_switch_perfmon(dev, job);
+
 	scoped_guard(mutex, &dev->job_lock) {
 		dev->in_flight_job = job;
 		ethosu_job_hw_submit(dev, job);
@@ -365,7 +389,8 @@ void ethosu_job_close(struct ethosu_file_priv *ethosu_priv)
 }
 
 static int ethosu_ioctl_submit_job(struct drm_device *dev, struct drm_file *file,
-				   struct drm_ethosu_job *job)
+				   struct drm_ethosu_job *job,
+				   int perfmon_id)
 {
 	struct ethosu_device *edev = to_ethosu_device(dev);
 	struct ethosu_file_priv *file_priv = file->driver_priv;
@@ -389,6 +414,9 @@ static int ethosu_ioctl_submit_job(struct drm_device *dev, struct drm_file *file
 	ejob->dev = edev;
 	ejob->sram_size = job->sram_size;
 
+	if (perfmon_id)
+		ejob->perfmon = ethosu_perfmon_find(file_priv, perfmon_id);
+
 	ejob->done_fence = kzalloc_obj(*ejob->done_fence);
 	if (!ejob->done_fence) {
 		ret = -ENOMEM;
@@ -491,11 +519,6 @@ int ethosu_ioctl_submit(struct drm_device *dev, void *data, struct drm_file *fil
 	int ret = 0;
 	unsigned int i = 0;
 
-	if (args->pad) {
-		drm_dbg(dev, "Reserved field in drm_ethosu_submit struct should be 0.\n");
-		return -EINVAL;
-	}
-
 	struct drm_ethosu_job __free(kvfree) *jobs =
 		kvmalloc_objs(*jobs, args->job_count);
 	if (!jobs)
@@ -509,7 +532,7 @@ int ethosu_ioctl_submit(struct drm_device *dev, void *data, struct drm_file *fil
 	}
 
 	for (i = 0; i < args->job_count; i++) {
-		ret = ethosu_ioctl_submit_job(dev, file, &jobs[i]);
+		ret = ethosu_ioctl_submit_job(dev, file, &jobs[i], args->perfmon_id);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/accel/ethosu/ethosu_job.h b/drivers/accel/ethosu/ethosu_job.h
index ff1cf448d094..8988edd00eed 100644
--- a/drivers/accel/ethosu/ethosu_job.h
+++ b/drivers/accel/ethosu/ethosu_job.h
@@ -21,6 +21,8 @@ struct ethosu_job {
 	u8 region_cnt;
 	u32 sram_size;
 
+	struct ethosu_perfmon *perfmon;
+
 	/* Fence to be signaled by drm-sched once its done with the job */
 	struct dma_fence *inference_done_fence;
 
diff --git a/drivers/accel/ethosu/ethosu_perfmon.c b/drivers/accel/ethosu/ethosu_perfmon.c
new file mode 100644
index 000000000000..d1380e3f2ea3
--- /dev/null
+++ b/drivers/accel/ethosu/ethosu_perfmon.c
@@ -0,0 +1,298 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/* Copyright 2026 Arm, Ltd. */
+/* Based on v3d_perfmon.c, Copyright (C) 2021 Raspberry Pi */
+
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/pm_runtime.h>
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+
+#include <drm/drm_file.h>
+#include <drm/drm_ioctl.h>
+
+#include <uapi/drm/ethosu_accel.h>
+
+#include "ethosu_drv.h"
+#include "ethosu_device.h"
+
+void ethosu_perfmon_get(struct ethosu_perfmon *perfmon)
+{
+	if (perfmon)
+		refcount_inc(&perfmon->refcnt);
+}
+
+void ethosu_perfmon_put(struct ethosu_perfmon *perfmon)
+{
+	if (perfmon && refcount_dec_and_test(&perfmon->refcnt)) {
+		kfree(perfmon);
+	}
+}
+
+void ethosu_perfmon_start(struct ethosu_device *ethosu, struct ethosu_perfmon *perfmon)
+{
+	unsigned int i;
+	u8 ncounters;
+	u32 mask;
+
+	if (WARN_ON_ONCE(!perfmon || ethosu->perfmon_state.active))
+		return;
+
+	writel_relaxed(PMCR_CNT_EN, ethosu->pmu_regs + NPU_REG_PMCR);
+	writel_relaxed(PMU_EV_TYPE_CYCLES, ethosu->pmu_regs + NPU_REG_PMCCNTR_CFG);
+
+	mask = 0x80000000;
+	ncounters = perfmon->ncounters - 1;
+	if (ncounters)
+		mask |= GENMASK(ncounters - 1, 0);
+
+	for (i = 0; i < ncounters; i++)
+		writel_relaxed(perfmon->counters[i], ethosu->pmu_regs + NPU_REG_PMU_EVTYPER(i));
+
+	writel_relaxed(mask, ethosu->pmu_regs + NPU_REG_PMCNTENSET);
+	writel_relaxed(PMCR_CNT_EN | PMCR_EVENT_CNT_RST | PMCR_CYCLE_CNT_RST,
+		ethosu->pmu_regs + NPU_REG_PMCR);
+	ethosu->perfmon_state.active = perfmon;
+}
+
+void ethosu_perfmon_stop_locked(struct ethosu_device *ethosu, struct ethosu_perfmon *perfmon,
+				bool capture)
+{
+	unsigned int i;
+	u8 ncounters;
+	u32 mask;
+
+	lockdep_assert_held(&ethosu->perfmon_state.lock);
+
+	if (!perfmon || perfmon != ethosu->perfmon_state.active)
+		return;
+
+	ncounters = perfmon->ncounters - 1;
+
+	if (!pm_runtime_get_if_active(ethosu->base.dev)) {
+		ethosu->perfmon_state.active = NULL;
+		return;
+	}
+
+	if (capture) {
+		for (i = 0; i < ncounters; i++)
+			perfmon->values[i] += readl_relaxed(ethosu->pmu_regs + NPU_REG_PMU_EVCNTR(i));
+		perfmon->values[ncounters] +=
+			readl_relaxed(ethosu->pmu_regs + NPU_REG_PMCCNTR_LO) |
+			(u64)readl_relaxed(ethosu->pmu_regs + NPU_REG_PMCCNTR_HI) << 32;
+	}
+
+	mask = 0x80000000;
+	if (ncounters)
+		mask |= GENMASK(ncounters - 1, 0);
+	writel_relaxed(mask, ethosu->pmu_regs + NPU_REG_PMCNTENCLR);
+
+	writel_relaxed(0, ethosu->pmu_regs + NPU_REG_PMCR);
+	ethosu->perfmon_state.active = NULL;
+
+	pm_runtime_put(ethosu->base.dev);
+}
+
+void ethosu_perfmon_stop(struct ethosu_device *ethosu, struct ethosu_perfmon *perfmon,
+			 bool capture)
+{
+	if (!perfmon)
+		return;
+
+	guard(mutex)(&ethosu->perfmon_state.lock);
+	ethosu_perfmon_stop_locked(ethosu, perfmon, capture);
+}
+
+struct ethosu_perfmon *ethosu_perfmon_find(struct ethosu_file_priv *ethosu_priv, int id)
+{
+	struct ethosu_perfmon *perfmon;
+
+	xa_lock(&ethosu_priv->perfmons);
+	perfmon = xa_load(&ethosu_priv->perfmons, id);
+	ethosu_perfmon_get(perfmon);
+	xa_unlock(&ethosu_priv->perfmons);
+
+	return perfmon;
+}
+
+void ethosu_perfmon_open_file(struct ethosu_file_priv *ethosu_priv)
+{
+	xa_init_flags(&ethosu_priv->perfmons, XA_FLAGS_ALLOC1);
+}
+
+static void ethosu_perfmon_delete(struct ethosu_file_priv *ethosu_priv,
+				 struct ethosu_perfmon *perfmon)
+{
+	struct ethosu_device *ethosu = ethosu_priv->edev;
+
+	/* If the active perfmon is being destroyed, stop it first */
+	scoped_guard(mutex, &ethosu->perfmon_state.lock) {
+		/* If the global perfmon is being destroyed, set it to NULL */
+		if (ethosu->global_perfmon == perfmon) {
+			ethosu->global_perfmon = NULL;
+			ethosu_perfmon_put(perfmon);
+		}
+
+		ethosu_perfmon_stop_locked(ethosu, perfmon, false);
+	}
+
+	ethosu_perfmon_put(perfmon);
+}
+
+void ethosu_perfmon_close_file(struct ethosu_file_priv *ethosu_priv)
+{
+	struct ethosu_perfmon *perfmon;
+	unsigned long id;
+
+	xa_for_each(&ethosu_priv->perfmons, id, perfmon)
+		ethosu_perfmon_delete(ethosu_priv, perfmon);
+
+	xa_destroy(&ethosu_priv->perfmons);
+}
+
+int ethosu_ioctl_perfmon_create(struct drm_device *dev, void *data,
+			     struct drm_file *file_priv)
+{
+	struct ethosu_file_priv *ethosu_priv = file_priv->driver_priv;
+	struct drm_ethosu_perfmon_create *req = data;
+	struct ethosu_device *ethosu = to_ethosu_device(dev);
+	struct ethosu_perfmon *perfmon;
+	unsigned int i, event_max;
+	int ret;
+	u32 id;
+
+	/* Number of monitored counters cannot exceed HW limits. */
+	if (req->ncounters > ethosu->npu_info.pmu_counters)
+		return -EINVAL;
+
+	/* Make sure all counters are valid. */
+	event_max = ethosu_is_u65(ethosu) ? 433 : 671;
+	for (i = 0; i < req->ncounters; i++) {
+		if (req->counters[i] > event_max)
+			return -EINVAL;
+	}
+
+	/* Add 1 more counter for cycle counter */
+	req->ncounters++;
+
+	perfmon = kzalloc_flex(*perfmon, values, req->ncounters);
+	if (!perfmon)
+		return -ENOMEM;
+
+	for (i = 0; i < req->ncounters - 1; i++)
+		perfmon->counters[i] = req->counters[i];
+
+	perfmon->ncounters = req->ncounters;
+
+	refcount_set(&perfmon->refcnt, 1);
+
+	ret = xa_alloc(&ethosu_priv->perfmons, &id, perfmon, xa_limit_32b,
+		       GFP_KERNEL);
+
+	if (ret < 0) {
+		kfree(perfmon);
+		return ret;
+	}
+
+	req->id = id;
+
+	return 0;
+}
+
+int ethosu_ioctl_perfmon_destroy(struct drm_device *dev, void *data,
+				 struct drm_file *file_priv)
+{
+	struct ethosu_file_priv *ethosu_priv = file_priv->driver_priv;
+	struct drm_ethosu_perfmon_destroy *req = data;
+	struct ethosu_perfmon *perfmon;
+
+	perfmon = xa_erase(&ethosu_priv->perfmons, req->id);
+	if (!perfmon)
+		return -EINVAL;
+
+	ethosu_perfmon_delete(ethosu_priv, perfmon);
+
+	return 0;
+}
+
+int ethosu_ioctl_perfmon_get_values(struct drm_device *dev, void *data,
+				 struct drm_file *file_priv)
+{
+	struct ethosu_device *ethosu = to_ethosu_device(dev);
+	struct ethosu_file_priv *ethosu_priv = file_priv->driver_priv;
+	struct drm_ethosu_perfmon_get_values *req = data;
+	struct ethosu_perfmon *perfmon;
+	int ret = 0;
+
+	if (req->pad != 0)
+		return -EINVAL;
+
+	perfmon = ethosu_perfmon_find(ethosu_priv, req->id);
+	if (!perfmon)
+		return -EINVAL;
+
+	ret = pm_runtime_resume_and_get(dev->dev);
+	if (ret) {
+		ethosu_perfmon_put(perfmon);
+		return ret;
+	}
+	ethosu_perfmon_stop(ethosu, perfmon, true);
+
+	pm_runtime_put_autosuspend(dev->dev);
+
+	if (copy_to_user(u64_to_user_ptr(req->values_ptr), perfmon->values,
+			 perfmon->ncounters * sizeof(u64)))
+		ret = -EFAULT;
+
+	ethosu_perfmon_put(perfmon);
+
+	return ret;
+}
+
+int ethosu_ioctl_perfmon_set_global(struct drm_device *dev, void *data,
+				 struct drm_file *file_priv)
+{
+	struct ethosu_file_priv *ethosu_priv = file_priv->driver_priv;
+	struct drm_ethosu_perfmon_set_global *req = data;
+	struct ethosu_device *ethosu = to_ethosu_device(dev);
+	struct ethosu_perfmon *perfmon;
+
+	if (req->flags & ~DRM_ETHOSU_PERFMON_CLEAR_GLOBAL)
+		return -EINVAL;
+
+	perfmon = ethosu_perfmon_find(ethosu_priv, req->id);
+	if (!perfmon)
+		return -EINVAL;
+
+	/* If the request is to clear the global performance monitor */
+	if (req->flags & DRM_ETHOSU_PERFMON_CLEAR_GLOBAL) {
+		struct ethosu_perfmon *old;
+		scoped_guard(mutex, &ethosu->perfmon_state.lock) {
+			old = ethosu->global_perfmon;
+			if (!old) {
+				ethosu_perfmon_put(perfmon);
+				return -EINVAL;
+			}
+
+			ethosu->global_perfmon = NULL;
+			ethosu_perfmon_stop_locked(ethosu, old, true);
+		}
+
+		ethosu_perfmon_put(old);
+		ethosu_perfmon_put(perfmon);
+
+		return 0;
+	}
+
+	scoped_guard(mutex, &ethosu->perfmon_state.lock) {
+		if (ethosu->perfmon_state.active || ethosu->global_perfmon) {
+			ethosu_perfmon_put(perfmon);
+			return -EBUSY;
+		}
+
+		ethosu->global_perfmon = perfmon;
+	}
+
+	return 0;
+}
diff --git a/include/uapi/drm/ethosu_accel.h b/include/uapi/drm/ethosu_accel.h
index af78bb4686d7..5b97d59a7806 100644
--- a/include/uapi/drm/ethosu_accel.h
+++ b/include/uapi/drm/ethosu_accel.h
@@ -43,6 +43,11 @@ enum drm_ethosu_ioctl_id {
 
 	/** @DRM_ETHOSU_SUBMIT: Submit a job and BOs to run. */
 	DRM_ETHOSU_SUBMIT,
+
+	DRM_ETHOSU_PERFMON_CREATE,
+	DRM_ETHOSU_PERFMON_DESTROY,
+	DRM_ETHOSU_PERFMON_GET_VALUES,
+	DRM_ETHOSU_PERFMON_SET_GLOBAL,
 };
 
 /**
@@ -79,6 +84,7 @@ struct drm_ethosu_npu_info {
 	__u32 config;
 
 	__u32 sram_size;
+	__u32 pmu_counters;
 };
 
 /**
@@ -220,10 +226,54 @@ struct drm_ethosu_submit {
 	/** Input: Number of jobs passed in. */
 	__u32 job_count;
 
-	/** Reserved, must be zero. */
+	/** Input: Id returned by DRM_ETHOSU_PERFMON_CREATE */
+	__u32 perfmon_id;
+};
+
+#define DRM_ETHOSU_MAX_PERF_EVENT_COUNTERS	8
+#define DRM_ETHOSU_MAX_PERF_COUNTERS \
+	(DRM_ETHOSU_MAX_PERF_EVENT_COUNTERS + 1)
+
+struct drm_ethosu_perfmon_create {
+	__u32 id;
+	__u32 ncounters;
+	__u16 counters[DRM_ETHOSU_MAX_PERF_EVENT_COUNTERS];
+};
+
+struct drm_ethosu_perfmon_destroy {
+	__u32 id;
 	__u32 pad;
 };
 
+/*
+ * Returns the values of the performance counters tracked by this
+ * perfmon (as an array of (ncounters + 1) u64 values).
+ *
+ * No implicit synchronization is performed, so the user has to
+ * guarantee that any jobs using this perfmon have already been
+ * completed.
+ */
+struct drm_ethosu_perfmon_get_values {
+	__u32 id;
+	__u32 pad;
+	__u64 values_ptr;
+};
+
+#define DRM_ETHOSU_PERFMON_CLEAR_GLOBAL    0x0001
+
+/**
+ * struct drm_ethosu_perfmon_set_global - ioctl to define a global performance
+ * monitor
+ *
+ * The global performance monitor will be used for all jobs. If a global
+ * performance monitor is defined, jobs with a self-defined performance
+ * monitor won't be allowed.
+ */
+struct drm_ethosu_perfmon_set_global {
+	__u32 flags;
+	__u32 id;
+};
+
 /**
  * DRM_IOCTL_ETHOSU() - Build a ethosu IOCTL number
  * @__access: Access type. Must be R, W or RW.
@@ -252,6 +302,14 @@ enum {
 		DRM_IOCTL_ETHOSU(WR, CMDSTREAM_BO_CREATE, cmdstream_bo_create),
 	DRM_IOCTL_ETHOSU_SUBMIT =
 		DRM_IOCTL_ETHOSU(WR, SUBMIT, submit),
+	DRM_IOCTL_ETHOSU_PERFMON_CREATE =
+		DRM_IOCTL_ETHOSU(WR, PERFMON_CREATE, perfmon_create),
+	DRM_IOCTL_ETHOSU_PERFMON_DESTROY =
+		DRM_IOCTL_ETHOSU(WR, PERFMON_DESTROY, perfmon_destroy),
+	DRM_IOCTL_ETHOSU_PERFMON_GET_VALUES =
+		DRM_IOCTL_ETHOSU(WR, PERFMON_GET_VALUES, perfmon_get_values),
+	DRM_IOCTL_ETHOSU_PERFMON_SET_GLOBAL =
+		DRM_IOCTL_ETHOSU(WR, PERFMON_SET_GLOBAL, perfmon_set_global),
 };
 
 #if defined(__cplusplus)
-- 
2.54.0

