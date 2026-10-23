Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE4760A2634
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 06:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Rwauuu3Q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D55EA10E57A;
	Fri, 23 Oct 2026 06:40:07 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75E9B10E574
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 06:39:58 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-48c4d870d54so301979f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 23:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792737597; x=1793342397; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TWdIdFxhUJ1iIwpDHWoU67/6tKdl3mAvnjm9aEzD0nM=;
 b=Rwauuu3QaiP8dS5Abx/LmJlwQJol+tV9rChoi9WzLVBmDEkfbRDo3uDntEXHBsY94d
 CwN/lWOmtB0QEEDyjSgzBLsN6pSSdJTNsaRIem/u1vVRK2WEE8h0CHVXTmNpe5DUk+9R
 rMC44dwxO3SE31k3D6ba1f8HWj54FgO8mspl9cCyyBUZqCY3mnlgoWZQQABtUld9f08Z
 GsrNoB40lOraXHP4IqMy/cGmvRFAo7ULadggGkx6Tn+wOQCxDsyZd+3sg66ZQ3O6DeAF
 HZp+9dUtBGp0ujklOVzGsl4y/GaNqAu/DcLJtoTtfibX1nS1LGafAfPu8qPV+cWmqR7n
 9WIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792737597; x=1793342397;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TWdIdFxhUJ1iIwpDHWoU67/6tKdl3mAvnjm9aEzD0nM=;
 b=Zr06JpKC/lNlMg8/w8z2mPvUqBZV9onC4Qkf0uBFkmwwb2aZV2Sijb8ZOIOK6LTXz6
 b98b6OYcHCh7QXEtb496GkNzVtRtstNMADE3nzi06RRSPjY5u98mHVazv1RhBUWBuS6Z
 pbXW5ACEcgVm3i25HwhtBwuE3/b5akNGj1mX7TNkDbSinxNh9sIVRdoPVBYT3c8aU+cP
 b/CxZ50fe7iCkcDr1Kvf9zUEz5nVoW0LH0q6tlCv8yU0BpzO24KqN80T9emVe5fxLb4H
 RztKDEsVhb9XHX4fJAIe9XvyGrlPDC8WKpdQ2wJNXSccw2z+hM+LV9tMSMfxiRsrexrj
 YXrA==
X-Forwarded-Encrypted: i=1;
 AKwUvByCAEDJvWn+/vtdoQecXuc+sxG/y7FX+1DWsrdF7hIR/1SlcfL107JDv/dVW1TvZd7D9nqnmYUMQL8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKPwwE0YGNz+nSyTRjsbFQNBDRC1S9jIO/nfUJqX1nXIcndXNfp
 ero6fsm19JekYt33DuOg6pPTIaYnx7FBgtxhleUxVLH+n+VYWIbS6X+N
X-Gm-Gg: AYBFou3iGw8kvtOlf0bw4aSrQHOUsazeB6VUajOYIDP8AX+oUAP4U5q6Z5tCgndP07n
 9T4/CyexS9cuA/Tw642JSRXqeXEz3Dwbru5Wmx0dVAvXgllmIhK4w4eUEhIyehQmFT8Hc1XzUJx
 i15OatoIPS/ZK977jQyhJkmdLS9XcTuYXwhHQfrSyNtKgjBTEgn3DILjTDJaMnHD2QyN+liQStr
 Tlhk4RlduhVrmBoX3KR07w83IN3XnmZipxTxkqbRK4QTICtVpMlI/ccR44ff8AkBxItIFKLmyuD
 7YyZ/4IjV8jeyHn7SsbaUK9j/eCLzHLrJ5CQBMYG5jJ17MgRC/ha9uHM5Eo+ggnUhmn7qOje/SP
 ywJsosC3R8PcMZUcMNU4tftl7gwgzW1RHiwX91Od0drunbBHQGkbAVSqZIk0YnEMrFNaysqPA0F
 yyuiShHiysI4AOtnK4MEG4ow5Tcjr8fq5wAHBReKxbdQY/mDJL1PCuj8n7K7vxJo7nLv/C7iclR
 djHKYUdoxT+R4bv43sqm3lCQahVfzLbLdKXXYYvmSHMG03T3Tq235SsoPvb6uP54CmJ93MotkAs
 yl2JCAVuluOXWBD/q2dWpQFCtq0TEhGsSXmVQwJEv6EvBfSdIDIIiIWcpW07CsBCyG47Duz0UNA
 bHRY=
X-Received: by 2002:a05:6000:310c:b0:48e:10a7:438 with SMTP id
 ffacd0b85a97d-48e387d620emr1633716f8f.36.1792737596519; 
 Thu, 22 Oct 2026 23:39:56 -0700 (PDT)
Received: from [192.168.1.22] (cst-prg-49-173.cust.vodafone.cz.
 [46.135.49.173]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e38030c47sm3104782f8f.21.2026.10.22.23.39.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 23:39:54 -0700 (PDT)
From: Tomeu Vizoso <tomeu.vizoso@gmail.com>
X-Google-Original-From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Fri, 23 Oct 2026 08:39:31 +0200
Subject: [PATCH v3 06/16] accel/thames: Create a context per client on
 device open
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-thames-v3-6-3ab40aa17157@tomeuvizoso.net>
References: <20261023-thames-v3-0-3ab40aa17157@tomeuvizoso.net>
In-Reply-To: <20261023-thames-v3-0-3ab40aa17157@tomeuvizoso.net>
To: Nishanth Menon <nm@ti.com>, "Andrew F. Davis" <afd@ti.com>, 
 Randolph Sapp <rs@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>, 
 Andrei Aldea <a-aldea@ti.com>, Chirag Shilwant <c-shilwant@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Beleswar Padhi <b-padhi@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Oded Gabbay <ogabbay@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Robert Nelson <robertcnelson@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Markus Elfring <Markus.Elfring@web.de>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, Suman Anna <s-anna@ti.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-doc@vger.kernel.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, Tomeu Vizoso <tomeu@tomeuvizoso.net>, 
 linux-remoteproc@vger.kernel.org, linux-hardening@vger.kernel.org
X-Mailer: b4 0.15.2
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

And manage a page table for each, using IOMMU_IO_PGTABLE_LPAE.

The firmware will switch to this page table when executing a user DSP
kernel, in the DSP core's MMU.

Each Context gets an ASID, allocated cyclically so a freed one is not
handed out again at once, and an entry in the IPC Context table with
its page table base and a mapping generation, which the firmware
compares before a Job to invalidate the core's TLB when the mappings
changed. Context serials and generations start from the boot clock,
above every number a previous load of the module handed out, so the
firmware never takes a stale entry for the current one. Every Context
maps the three windows (the L2 main and auxiliary SRAM, and the DRU's
Kernel channels as device memory) and the Kernels' stack and save page
at the fixed user-region addresses. Page tables and the per-Context
pages come from a driver allocator of physically contiguous memory,
2 MiB aligned from 2 MiB up so they can be mapped as blocks. There are
63 Contexts, the table's 64 entries less entry 0.

Assisted-by: LLM
Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
---
 drivers/accel/thames/Kconfig         |   1 +
 drivers/accel/thames/Makefile        |   3 +-
 drivers/accel/thames/thames_core.c   |   2 +
 drivers/accel/thames/thames_device.h |  17 ++
 drivers/accel/thames/thames_drv.c    |  51 ++++
 drivers/accel/thames/thames_drv.h    |  18 ++
 drivers/accel/thames/thames_gem.c    | 546 +++++++++++++++++++++++++++++++++++
 drivers/accel/thames/thames_gem.h    |  52 ++++
 8 files changed, 689 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/thames/Kconfig b/drivers/accel/thames/Kconfig
index c621002d8efa..9362b9274075 100644
--- a/drivers/accel/thames/Kconfig
+++ b/drivers/accel/thames/Kconfig
@@ -6,6 +6,7 @@ config DRM_ACCEL_THAMES
 	depends on TI_K3_DSP_REMOTEPROC
 	depends on REMOTEPROC
 	depends on MAILBOX
+	select IOMMU_IO_PGTABLE_LPAE
 	help
 	  Choose this option if you have a Texas Instruments J722S and want to
 	  use its C7x DSP cores as compute accelerators.
diff --git a/drivers/accel/thames/Makefile b/drivers/accel/thames/Makefile
index 175247b31cb2..bb81fcd58927 100644
--- a/drivers/accel/thames/Makefile
+++ b/drivers/accel/thames/Makefile
@@ -4,4 +4,5 @@ obj-$(CONFIG_DRM_ACCEL_THAMES) := thames.o
 
 thames-y := \
 	thames_core.o \
-	thames_drv.o
+	thames_drv.o \
+	thames_gem.o
diff --git a/drivers/accel/thames/thames_core.c b/drivers/accel/thames/thames_core.c
index d74c74b8f8eb..1c983580b62a 100644
--- a/drivers/accel/thames/thames_core.c
+++ b/drivers/accel/thames/thames_core.c
@@ -24,6 +24,7 @@
 #include "thames_abi.h"
 #include "thames_core.h"
 #include "thames_device.h"
+#include "thames_gem.h"
 
 #define THAMES_RESTART_TIMEOUT_MS	5000
 
@@ -616,6 +617,7 @@ int thames_core_resume(struct thames_core *core)
 	}
 	core->ring_tail = head;
 
+	thames_context_rewrite_entries(core);
 	goto restart;
 
 offline:
diff --git a/drivers/accel/thames/thames_device.h b/drivers/accel/thames/thames_device.h
index f1cf79f2c2e4..e89e0dfd89b8 100644
--- a/drivers/accel/thames/thames_device.h
+++ b/drivers/accel/thames/thames_device.h
@@ -41,6 +41,23 @@ struct thames_device {
 
 	struct thames_caps caps;
 
+	struct ida ctx_ida;
+
+	/*
+	 * Seeded from the boot clock at load, so no serial repeats an earlier
+	 * load's.
+	 */
+	atomic64_t last_context_serial;
+
+	atomic64_t mapping_generation;
+
+	struct ida asid_ida;
+	u32 asid_next;
+	struct mutex asid_lock;
+
+	struct list_head contexts;
+	struct mutex contexts_lock;
+
 };
 
 #define to_thames_device(drm_dev) \
diff --git a/drivers/accel/thames/thames_drv.c b/drivers/accel/thames/thames_drv.c
index de93bc87756c..cb0287430d25 100644
--- a/drivers/accel/thames/thames_drv.c
+++ b/drivers/accel/thames/thames_drv.c
@@ -22,6 +22,7 @@
 
 #include "thames_core.h"
 #include "thames_drv.h"
+#include "thames_gem.h"
 
 static struct platform_device *drm_dev;
 static struct thames_device *tdev;
@@ -48,12 +49,19 @@ static int thames_open(struct drm_device *dev, struct drm_file *file)
 
 	thames_priv->tdev = tdev;
 	kref_init(&thames_priv->refcount);
+	mutex_init(&thames_priv->mm_lock);
 
 	file->driver_priv = thames_priv;
 
+	ret = thames_context_create(thames_priv);
+	if (ret)
+		goto err_close_job;
+
 	drm_dev_exit(idx);
 	return 0;
 
+err_close_job:
+	kfree(thames_priv);
 err_exit:
 	drm_dev_exit(idx);
 	return ret;
@@ -63,6 +71,9 @@ static void thames_file_priv_release(struct kref *kref)
 {
 	struct thames_file_priv *priv = container_of(kref, struct thames_file_priv, refcount);
 
+	thames_context_destroy(priv);
+	thames_context_va_fini(priv);
+	mutex_destroy(&priv->mm_lock);
 	kfree(priv);
 }
 
@@ -76,6 +87,9 @@ static void thames_postclose(struct drm_device *dev, struct drm_file *file)
 {
 	struct thames_file_priv *thames_priv = file->driver_priv;
 
+	dev_dbg(dev->dev, "Context %u: file closed, %u references left\n",
+		thames_priv->context_id, kref_read(&thames_priv->refcount) - 1);
+
 	thames_file_priv_put(thames_priv);
 }
 
@@ -174,17 +188,36 @@ static const struct drm_driver thames_drm_driver = {
 	.minor = THAMES_DRIVER_MINOR,
 };
 
+static void thames_device_release(struct drm_device *ddev, void *data)
+{
+	struct thames_device *tdev = to_thames_device(ddev);
+
+	ida_destroy(&tdev->ctx_ida);
+	ida_destroy(&tdev->asid_ida);
+}
+
 static struct thames_device *thames_device_init(struct platform_device *pdev,
 						const struct drm_driver *thames_drm_driver)
 {
 	struct device *dev = &pdev->dev;
 	struct thames_device *tdev;
+	u64 seed;
 	int err;
 
 	tdev = devm_drm_dev_alloc(dev, thames_drm_driver, struct thames_device, ddev);
 	if (IS_ERR(tdev))
 		return tdev;
 
+	/*
+	 * Live as long as the DRM device: a client's buffers and last Jobs
+	 * reach them after an unbind.
+	 */
+	ida_init(&tdev->ctx_ida);
+	ida_init(&tdev->asid_ida);
+	err = drmm_add_action_or_reset(&tdev->ddev, thames_device_release, NULL);
+	if (err)
+		return ERR_PTR(err);
+
 	dev_set_drvdata(dev, tdev);
 
 	dma_set_max_seg_size(dev, UINT_MAX);
@@ -193,6 +226,24 @@ static struct thames_device *thames_device_init(struct platform_device *pdev,
 	if (err)
 		return ERR_PTR(err);
 
+	err = drmm_mutex_init(&tdev->ddev, &tdev->asid_lock);
+	if (err)
+		return ERR_PTR(err);
+
+	err = drmm_mutex_init(&tdev->ddev, &tdev->contexts_lock);
+	if (err)
+		return ERR_PTR(err);
+
+	INIT_LIST_HEAD(&tdev->contexts);
+
+	tdev->asid_next = 1;
+	/*
+	 * Above every number the previous load handed out, which counted up by
+	 * one from an earlier reading of the same clock.
+	 */
+	seed = ktime_get_boottime_ns();
+	atomic64_set(&tdev->last_context_serial, seed);
+	atomic64_set(&tdev->mapping_generation, seed);
 
 	return tdev;
 }
diff --git a/drivers/accel/thames/thames_drv.h b/drivers/accel/thames/thames_drv.h
index 2678abc2e2de..f4536078e02f 100644
--- a/drivers/accel/thames/thames_drv.h
+++ b/drivers/accel/thames/thames_drv.h
@@ -25,6 +25,24 @@ struct thames_file_priv {
 	 */
 	struct kref refcount;
 
+	struct io_pgtable_ops *pgtbl_ops[THAMES_MAX_CORES];
+	u64 page_table_base[THAMES_MAX_CORES];
+	u32 asid;
+
+	struct list_head context_node;
+
+	struct drm_mm mm;
+	struct mutex mm_lock;
+	struct drm_mm_node first_page;
+	struct drm_mm_node user_region;
+	struct drm_mm_node window_nodes[THAMES_NUM_WINDOWS];
+
+	u32 context_id;
+
+	u64 context_serial;
+
+	struct drm_gem_dma_object *user_stack;
+	struct drm_gem_dma_object *save_area;
 };
 
 void thames_file_priv_put(struct thames_file_priv *priv);
diff --git a/drivers/accel/thames/thames_gem.c b/drivers/accel/thames/thames_gem.c
new file mode 100644
index 000000000000..b98e0fe203b0
--- /dev/null
+++ b/drivers/accel/thames/thames_gem.c
@@ -0,0 +1,546 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright 2026 Texas Instruments Incorporated - https://www.ti.com/ */
+
+#include <linux/bits.h>
+#include <linux/dma-mapping.h>
+#include <linux/dma-resv.h>
+#include <linux/idr.h>
+#include <linux/io-pgtable.h>
+#include <linux/iommu.h>
+#include <linux/minmax.h>
+#include <linux/scatterlist.h>
+#include <linux/sizes.h>
+
+#include <drm/drm_device.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_gem_dma_helper.h>
+#include <drm/drm_print.h>
+#include <drm/drm_timeout.h>
+#include <drm/thames_accel.h>
+
+#include "thames_abi.h"
+#include "thames_device.h"
+#include "thames_drv.h"
+#include "thames_gem.h"
+
+static size_t thames_pgsize(u64 addr, size_t size, size_t *count)
+{
+	size_t blk_offset = -addr % SZ_2M;
+
+	if (blk_offset || size < SZ_2M) {
+		*count = min_not_zero(blk_offset, size) / SZ_4K;
+		return SZ_4K;
+	}
+
+	*count = size / SZ_2M;
+	return SZ_2M;
+}
+
+static void thames_pgtable_unmap(struct io_pgtable_ops *ops, u64 dsp_va, u64 size)
+{
+	u64 offset = 0;
+
+	while (offset < size) {
+		size_t pgcount, unmapped;
+		size_t pgsize = thames_pgsize(dsp_va + offset, size - offset, &pgcount);
+
+		unmapped = ops->unmap_pages(ops, dsp_va + offset, pgsize, pgcount, NULL);
+		if (WARN_ON(!unmapped))
+			break;
+
+		offset += unmapped;
+	}
+}
+
+static int thames_pgtable_map(struct io_pgtable_ops *ops, u64 dsp_va, int prot,
+			      phys_addr_t paddr, size_t size)
+{
+	size_t offset = 0;
+
+	while (offset < size) {
+		size_t pgcount, mapped = 0;
+		size_t pgsize = thames_pgsize((dsp_va + offset) | (paddr + offset),
+					      size - offset, &pgcount);
+		int ret = ops->map_pages(ops, dsp_va + offset, paddr + offset, pgsize, pgcount,
+					 prot, GFP_KERNEL, &mapped);
+
+		if (!ret && !mapped)
+			ret = -ENOMEM;
+		if (ret) {
+			thames_pgtable_unmap(ops, dsp_va, offset);
+			return ret;
+		}
+
+		offset += mapped;
+	}
+
+	return 0;
+}
+
+static int thames_context_map(struct thames_file_priv *priv, u64 dsp_va, int prot,
+			      phys_addr_t paddr, size_t size)
+{
+	unsigned int c;
+	int ret;
+
+	for (c = 0; c < priv->tdev->num_cores; c++) {
+		ret = thames_pgtable_map(priv->pgtbl_ops[c], dsp_va, prot, paddr, size);
+		if (ret) {
+			while (c--)
+				thames_pgtable_unmap(priv->pgtbl_ops[c], dsp_va, size);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+/* Cyclic, so a freed ASID is not handed out again at once. */
+static int thames_asid_alloc(struct thames_device *tdev)
+{
+	u32 max = BIT(tdev->caps.asid_bits) - 1;
+	int asid = -ENOSPC;
+
+	guard(mutex)(&tdev->asid_lock);
+
+	if (tdev->asid_next <= max)
+		asid = ida_alloc_range(&tdev->asid_ida, tdev->asid_next, max, GFP_KERNEL);
+	if (asid == -ENOSPC)
+		asid = ida_alloc_range(&tdev->asid_ida, 1, max, GFP_KERNEL);
+	if (asid < 0)
+		return asid;
+
+	tdev->asid_next = asid + 1;
+
+	return asid;
+}
+
+/*
+ * The device has no IOMMU, so a DMA address is the physical address the page
+ * tables hold.  The firmware programs a MAIR with these attribute indexes,
+ * which the page table entries must use; this word is what io-pgtable-arm
+ * expects, its cacheable attribute 0xff where the firmware's is 0x7d.
+ */
+#define THAMES_PGTABLE_MAIR_LOW	0xf404ff44u
+
+static void thames_context_pgtable_fini(struct thames_file_priv *priv)
+{
+	unsigned int c;
+
+	for (c = 0; c < THAMES_MAX_CORES; c++) {
+		if (priv->pgtbl_ops[c])
+			free_io_pgtable_ops(priv->pgtbl_ops[c]);
+		priv->pgtbl_ops[c] = NULL;
+	}
+}
+
+/*
+ * Also for offline cores, so a core a reset brings back finds its page table.
+ */
+static int thames_context_pgtable_init(struct thames_file_priv *priv)
+{
+	struct thames_device *tdev = priv->tdev;
+	unsigned int c;
+
+	for (c = 0; c < tdev->num_cores; c++) {
+		struct io_pgtable_cfg cfg = {
+			.pgsize_bitmap = SZ_4K | SZ_2M,
+			.ias = 48,
+			.oas = 40,
+			.coherent_walk = false,
+			.iommu_dev = tdev->ddev.dev,
+		};
+		struct io_pgtable *iop;
+
+		priv->pgtbl_ops[c] = alloc_io_pgtable_ops(ARM_64_LPAE_S1, &cfg, priv);
+		if (!priv->pgtbl_ops[c])
+			return -ENOMEM;
+
+		iop = io_pgtable_ops_to_pgtable(priv->pgtbl_ops[c]);
+		if (WARN_ON((iop->cfg.arm_lpae_s1_cfg.mair & 0xffffffffU) !=
+			    THAMES_PGTABLE_MAIR_LOW))
+			return -EINVAL;
+
+		priv->page_table_base[c] = iop->cfg.arm_lpae_s1_cfg.ttbr;
+	}
+
+	return 0;
+}
+
+static struct thames_context_entry *thames_context_entry(struct thames_core *core,
+							 struct thames_file_priv *priv)
+{
+	return &core->ipc->context_table[priv->context_id];
+}
+
+/*
+ * Offline cores included: a reset brings a core back to the entries in its IPC
+ * memory.
+ */
+#define for_each_core(tdev, core) \
+	for ((core) = (tdev)->cores; (core) < (tdev)->cores + (tdev)->num_cores; (core)++)
+
+static int thames_context_map_core_regions(struct thames_file_priv *priv)
+{
+	struct thames_device *tdev = priv->tdev;
+	unsigned int c, i;
+	int ret;
+
+	for (c = 0; c < tdev->num_cores; c++) {
+		const struct thames_core *core = &tdev->cores[c];
+
+		for (i = 0; i < THAMES_NUM_WINDOWS; i++) {
+			const struct resource *window = thames_core_window(core, i);
+			int prot = IOMMU_READ | IOMMU_WRITE | IOMMU_NOEXEC;
+			phys_addr_t paddr = window->start;
+			u64 size = resource_size(window);
+
+			if (i == THAMES_WINDOW_DRU) {
+				prot |= IOMMU_MMIO;
+				paddr += (u64)core->dru_kernel_channel_first *
+					 tdev->caps.dru_channel_stride;
+				size = tdev->caps.window_sizes[THAMES_WINDOW_DRU];
+			} else {
+				prot |= IOMMU_CACHE;
+			}
+
+			ret = thames_pgtable_map(priv->pgtbl_ops[c], thames_window_va(tdev, i),
+						 prot, paddr, size);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+static const struct drm_gem_object_funcs thames_gem_funcs;
+
+/*
+ * The allocator zeroes through the cache: clean it before the DSP can reach the
+ * memory, so no dirty line is written back over the DSP's data later.
+ */
+static struct drm_gem_dma_object *thames_gem_create(struct drm_device *ddev, size_t size)
+{
+	struct device *dev = drm_dev_dma_dev(ddev);
+	struct thames_gem_object *bo;
+	struct drm_gem_object *obj;
+	size_t offset = 0;
+	int ret;
+
+	size = PAGE_ALIGN(size);
+
+	bo = kzalloc_obj(*bo, GFP_KERNEL);
+	if (!bo)
+		return ERR_PTR(-ENOMEM);
+
+	obj = &bo->base.base;
+	obj->funcs = &thames_gem_funcs;
+	bo->base.map_noncoherent = true;
+
+	ret = drm_gem_object_init(ddev, obj, size);
+	if (ret) {
+		kfree(bo);
+		return ERR_PTR(ret);
+	}
+
+	ret = drm_gem_create_mmap_offset(obj);
+	if (ret)
+		goto err_put;
+
+	bo->alloc_size = size >= SZ_2M ? size + SZ_2M - PAGE_SIZE : size;
+	bo->alloc_vaddr = dma_alloc_noncoherent(dev, bo->alloc_size, &bo->alloc_dma,
+						DMA_TO_DEVICE, GFP_KERNEL | __GFP_NOWARN);
+	if (!bo->alloc_vaddr) {
+		ret = -ENOMEM;
+		goto err_put;
+	}
+
+	if (size >= SZ_2M)
+		offset = ALIGN(bo->alloc_dma, SZ_2M) - bo->alloc_dma;
+
+	bo->base.vaddr = bo->alloc_vaddr + offset;
+	bo->base.dma_addr = bo->alloc_dma + offset;
+
+	dma_sync_single_for_device(dev, bo->alloc_dma, bo->alloc_size, DMA_TO_DEVICE);
+
+	return &bo->base;
+
+err_put:
+	drm_gem_object_put(obj);
+	return ERR_PTR(ret);
+}
+
+static struct drm_gem_dma_object *thames_context_alloc_user_pages(struct thames_file_priv *priv,
+								  u64 dsp_va, size_t size)
+{
+	int prot = IOMMU_READ | IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_CACHE;
+	struct drm_gem_dma_object *dma_obj;
+	int ret;
+
+	dma_obj = thames_gem_create(&priv->tdev->ddev, size);
+	if (IS_ERR(dma_obj))
+		return dma_obj;
+
+	ret = thames_context_map(priv, dsp_va, prot, dma_obj->dma_addr, dma_obj->base.size);
+	if (ret) {
+		drm_gem_object_put(&dma_obj->base);
+		return ERR_PTR(ret);
+	}
+
+	return dma_obj;
+}
+
+static int thames_context_map_user_pages(struct thames_file_priv *priv)
+{
+	struct drm_gem_dma_object *dma_obj;
+
+	dma_obj = thames_context_alloc_user_pages(priv, THAMES_USER_STACK_BASE,
+						  THAMES_USER_STACK_SIZE);
+	if (IS_ERR(dma_obj))
+		return PTR_ERR(dma_obj);
+	priv->user_stack = dma_obj;
+
+	dma_obj = thames_context_alloc_user_pages(priv, THAMES_USER_SAVE_AREA_BASE,
+						  THAMES_USER_SAVE_AREA_SIZE);
+	if (IS_ERR(dma_obj))
+		return PTR_ERR(dma_obj);
+	priv->save_area = dma_obj;
+
+	return 0;
+}
+
+/* Only after the page tables are freed, so none maps a page given back. */
+static void thames_context_free_user_pages(struct thames_file_priv *priv)
+{
+	if (priv->save_area)
+		drm_gem_object_put(&priv->save_area->base);
+	if (priv->user_stack)
+		drm_gem_object_put(&priv->user_stack->base);
+	priv->save_area = NULL;
+	priv->user_stack = NULL;
+}
+
+/* Every core's entry: a removed mapping may still sit in either core's TLB. */
+static void thames_context_bump_generation(struct thames_file_priv *priv)
+{
+	u64 generation = atomic64_inc_return(&priv->tdev->mapping_generation);
+	struct thames_core *core;
+	int idx;
+
+	if (!drm_dev_enter(&priv->tdev->ddev, &idx))
+		return;
+
+	for_each_core(priv->tdev, core)
+		WRITE_ONCE(thames_context_entry(core, priv)->mapping_generation, generation);
+	/* Order the generation before the next submission. */
+	wmb();
+
+	drm_dev_exit(idx);
+}
+
+static void thames_context_write_entry(struct thames_file_priv *priv)
+{
+	struct thames_core *core;
+
+	for_each_core(priv->tdev, core) {
+		struct thames_context_entry *entry = thames_context_entry(core, priv);
+
+		entry->page_table_base = priv->page_table_base[core->index];
+		entry->asid = priv->asid;
+	}
+	thames_context_bump_generation(priv);
+}
+
+/*
+ * A new generation, so the restarted firmware invalidates its TLB whatever it
+ * remembers.
+ */
+void thames_context_rewrite_entries(struct thames_core *core)
+{
+	struct thames_device *tdev = core->tdev;
+	struct thames_file_priv *priv;
+
+	guard(mutex)(&tdev->contexts_lock);
+
+	list_for_each_entry(priv, &tdev->contexts, context_node) {
+		struct thames_context_entry *entry = thames_context_entry(core, priv);
+
+		entry->page_table_base = priv->page_table_base[core->index];
+		entry->asid = priv->asid;
+		thames_context_bump_generation(priv);
+	}
+}
+
+/* Offline cores too: their entry would otherwise name a freed page table. */
+static void thames_context_clear_entry(struct thames_file_priv *priv)
+{
+	struct thames_core *core;
+	int idx;
+
+	if (!drm_dev_enter(&priv->tdev->ddev, &idx))
+		return;
+
+	for_each_core(priv->tdev, core)
+		memset(thames_context_entry(core, priv), 0, sizeof(struct thames_context_entry));
+	/* Order the cleared entry before the id is freed. */
+	wmb();
+
+	drm_dev_exit(idx);
+}
+
+#define THAMES_DSP_VA_SIZE (1ULL << 47)
+
+static int thames_context_reserve(struct thames_file_priv *priv, struct drm_mm_node *node,
+				  u64 start, u64 size)
+{
+	node->start = start;
+	node->size = size;
+
+	return drm_mm_reserve_node(&priv->mm, node);
+}
+
+void thames_context_va_fini(struct thames_file_priv *priv)
+{
+	unsigned int i;
+
+	for (i = 0; i < THAMES_NUM_WINDOWS; i++) {
+		if (drm_mm_node_allocated(&priv->window_nodes[i]))
+			drm_mm_remove_node(&priv->window_nodes[i]);
+	}
+	if (drm_mm_node_allocated(&priv->user_region))
+		drm_mm_remove_node(&priv->user_region);
+	if (drm_mm_node_allocated(&priv->first_page))
+		drm_mm_remove_node(&priv->first_page);
+
+	drm_mm_takedown(&priv->mm);
+}
+
+static int thames_context_va_init(struct thames_file_priv *priv)
+{
+	struct thames_device *tdev = priv->tdev;
+	unsigned int i;
+	int ret;
+
+	drm_mm_init(&priv->mm, 0, THAMES_DSP_VA_SIZE);
+
+	ret = thames_context_reserve(priv, &priv->first_page, 0, PAGE_SIZE);
+	if (ret)
+		goto err_fini;
+
+	ret = thames_context_reserve(priv, &priv->user_region, THAMES_USER_REGION_BASE,
+				     THAMES_USER_REGION_SIZE);
+	if (ret)
+		goto err_fini;
+
+	for (i = 0; i < THAMES_NUM_WINDOWS; i++) {
+		ret = thames_context_reserve(priv, &priv->window_nodes[i],
+					     thames_window_va(tdev, i),
+					     resource_size(thames_core_window(&tdev->cores[0], i)));
+		if (ret)
+			goto err_fini;
+	}
+
+	return 0;
+
+err_fini:
+	thames_context_va_fini(priv);
+	return ret;
+}
+
+int thames_context_create(struct thames_file_priv *priv)
+{
+	struct thames_device *tdev = priv->tdev;
+	int ret, asid;
+
+	ret = ida_alloc_range(&tdev->ctx_ida, 1, THAMES_MAX_CONTEXTS - 1, GFP_KERNEL);
+	if (ret < 0)
+		return ret;
+
+	priv->context_id = ret;
+	priv->context_serial = atomic64_inc_return(&tdev->last_context_serial);
+
+	ret = thames_context_va_init(priv);
+	if (ret)
+		goto err_free_id;
+
+	ret = thames_context_pgtable_init(priv);
+	if (ret)
+		goto err_free_pgtable;
+
+	ret = thames_context_map_core_regions(priv);
+	if (ret)
+		goto err_free_pgtable;
+
+	ret = thames_context_map_user_pages(priv);
+	if (ret)
+		goto err_free_pgtable;
+
+	asid = thames_asid_alloc(tdev);
+	if (asid < 0) {
+		ret = asid;
+		goto err_free_pgtable;
+	}
+	priv->asid = asid;
+	dev_dbg(tdev->ddev.dev, "Context %u: ASID %d\n", priv->context_id, asid);
+
+	thames_context_write_entry(priv);
+
+	scoped_guard(mutex, &tdev->contexts_lock)
+		list_add_tail(&priv->context_node, &tdev->contexts);
+
+	return 0;
+
+err_free_pgtable:
+	thames_context_pgtable_fini(priv);
+	thames_context_free_user_pages(priv);
+	thames_context_va_fini(priv);
+err_free_id:
+	ida_free(&tdev->ctx_ida, priv->context_id);
+	return ret;
+}
+
+void thames_context_destroy(struct thames_file_priv *priv)
+{
+	struct thames_device *tdev = priv->tdev;
+
+	/*
+	 * The Context goes after its last pushed Job completed, so no Job runs
+	 * on mappings removed here.
+	 */
+	scoped_guard(mutex, &tdev->contexts_lock)
+		list_del(&priv->context_node);
+
+	thames_context_clear_entry(priv);
+
+	thames_context_pgtable_fini(priv);
+	thames_context_free_user_pages(priv);
+	ida_free(&tdev->asid_ida, priv->asid);
+	ida_free(&tdev->ctx_ida, priv->context_id);
+
+	dev_dbg(tdev->ddev.dev, "Context %u: destroyed, ASID %u back in the pool\n",
+		priv->context_id, priv->asid);
+}
+
+static void thames_gem_bo_free(struct drm_gem_object *obj)
+{
+	struct thames_gem_object *bo = to_thames_bo(obj);
+
+	if (bo->alloc_vaddr)
+		dma_free_noncoherent(drm_dev_dma_dev(obj->dev), bo->alloc_size, bo->alloc_vaddr,
+				     bo->alloc_dma, DMA_TO_DEVICE);
+
+	drm_gem_free_mmap_offset(obj);
+	drm_gem_object_release(obj);
+	kfree(bo);
+}
+
+static const struct drm_gem_object_funcs thames_gem_funcs = {
+	.free = thames_gem_bo_free,
+	.print_info = drm_gem_dma_object_print_info,
+	.get_sg_table = drm_gem_dma_object_get_sg_table,
+	.vmap = drm_gem_dma_object_vmap,
+	.mmap = drm_gem_dma_object_mmap,
+	.vm_ops = &drm_gem_dma_vm_ops,
+};
+
diff --git a/drivers/accel/thames/thames_gem.h b/drivers/accel/thames/thames_gem.h
new file mode 100644
index 000000000000..09ac1b50d21a
--- /dev/null
+++ b/drivers/accel/thames/thames_gem.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright 2026 Texas Instruments Incorporated - https://www.ti.com/ */
+
+#ifndef __THAMES_GEM_H__
+#define __THAMES_GEM_H__
+
+#include <linux/sizes.h>
+
+#include <drm/drm_gem_dma_helper.h>
+#include <drm/drm_gem_shmem_helper.h>
+#include <drm/drm_mm.h>
+
+#include "thames_abi.h"
+
+struct thames_core;
+struct thames_device;
+struct thames_file_priv;
+
+struct thames_gem_object {
+	/*
+	 * Both start with their drm_gem_object, so base.base is the GEM object
+	 * either way.
+	 */
+	union {
+		struct drm_gem_dma_object base;
+		struct drm_gem_shmem_object shmem;
+	};
+
+	/*
+	 * base.vaddr and base.dma_addr are the 2 MiB-aligned part of this
+	 * allocation when the buffer is 2 MiB or more.
+	 */
+	void *alloc_vaddr;
+	dma_addr_t alloc_dma;
+	size_t alloc_size;
+
+};
+
+
+int thames_context_create(struct thames_file_priv *priv);
+
+void thames_context_destroy(struct thames_file_priv *priv);
+void thames_context_rewrite_entries(struct thames_core *core);
+
+void thames_context_va_fini(struct thames_file_priv *priv);
+
+static inline struct thames_gem_object *to_thames_bo(struct drm_gem_object *obj)
+{
+	return container_of(obj, struct thames_gem_object, base.base);
+}
+
+#endif

-- 
2.54.0

