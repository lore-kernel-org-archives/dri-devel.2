Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BFE3CA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 14:49:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6689610F19C;
	Mon, 12 Oct 2026 14:49:41 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 681E210F1AC
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 14:49:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791816570; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=QnHVvTxg6mY+VATzPF6WrelBq/3Rmv83yQ9p55GUK9rYQRb0xhaRuF4ppbAL/N+u6wuybIca7ZUzq/UOsdXH7q1jWEl7rDueAhMaaEzKKvXWzxQ3G261Z8M1jGIHd3BM0ggVqxYrxeUDJRclDVlgDRKkB7ENHy4lJ+yZ9IL0tpw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791816570;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=HiEN5Oh2V34vQTLpNmzpNbICsHGfMtJDu40fzHuXpDM=; 
 b=g1t055zL8RQHptWtK99Ey/4UQbu1znlLKdivNAgtJxExTHeuOwvYnizgT9dOhiHkWvrdTR0h1RAyhoq9OWdglr8Ci8wuFzv7u2dTPp6iQM9t8a0PclNe244bKzkQG5RzxPiqmWeVFTRhWPBPbNmRMTh56qotNGMGc83l1HIEJVU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791816570; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=HiEN5Oh2V34vQTLpNmzpNbICsHGfMtJDu40fzHuXpDM=;
 b=ZPfvB3G7nhZKBR+qVVl16563EEpzplhUYLOndZnvyTCmd1ZZaxM5+biOkgxjNXLg
 utb5W/cke1Hdi8foLKlv/GyFe4h9qE0fVEvgllUOOSGZyuxpfYOT0cWSUiUxPl0DZXo
 j5gnr8v+YL0R0QP5BriDkCJbZF1AWLqpTIDWx9uw=
Received: by smtp.zohomail.com with SMTPS id 1791816569561903.5970852231529;
 Mon, 12 Oct 2026 07:49:29 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Mon, 12 Oct 2026 15:48:07 +0100
Subject: [PATCH v15 15/15] drm/panfrost: Fix races between perfcnt and
 reset sequence
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261012-claude-fixes-v15-15-bc0a6c498553@collabora.com>
References: <20261012-claude-fixes-v15-0-bc0a6c498553@collabora.com>
In-Reply-To: <20261012-claude-fixes-v15-0-bc0a6c498553@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>, 
 "Marty E. Plummer" <hanetzer@startmail.com>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>, 
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=17682;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=QIyA65BnBDE7mcCWCxCy7AcClWIFIjMdnzhpOwDlocc=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqzPMb02rPltmQQaAihT3kPjk/rof0kC3Lfg6VK
 /m4PkDJnWyJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCaszzGwAKCRAOJn5M7lND
 Pc4NC/9o87G342ZTYxuTv27UYJG85bOe8JqwwRGr07iPDWZnGWo0LZeiiM+ChRq3yXpdo6dCJXV
 ONe7p6i8pdGpfvVGWokNqqblvBiIlHDcf+gNY1WPitIX3xJVnbQbbyLIyD4n/1A0wUyjoydaW9f
 3XsvtLq+BZpT6QFWofi2OEaGbDuFs0yLvXu3fquhtRcBFC5J0Kpq/WOJpPpS/XcifXfxHR+qUcv
 nO7Yhj+7QeIb2Xm0VIJmSzop/qgR8yKSnhHknxfEzU9ycnYWk6sGpTZ+if4Mv34s+6+u06e8XGG
 XIEQG1RAqfOOHAQE1VsqeXogxMN5TVZKyAjzSL+Q/sVnR6xy0PKVIT9ZXjFEYAhDEi6Wm3aL2te
 VXmuNC40AzUTusT37fEmS2Fx2r1vuUbTuPJfkQ7Eq/7b+S2ffJ8RzGmQYDJfKOMrzQtOX3W97jB
 zK9YnPYPpJwCZk4+f2s4Hr3egis8h8OfVtW4N8AwR6U9LYnnRmu39zQH9mC+pQLwY16gY=
X-Developer-Key: i=adrian.larumbe@collabora.com; a=openpgp;
 fpr=324030E8C005175DF93707A40E267E4CEE53433D
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

Formerly, the reset sequence would race with panfrost_mmu_as_put()
when tearing down a perfcnt session. On top of that, poking GPU
registers to program a perfcnt session or obtaining a dump might lead to
undefined behaviour when done at the same time a reset was ongoing.

Use the reset r/w semaphore when disabling and re-enabling perfcnt
configuration, and also in the sections inside the 'enable'and 'dump'
ioctls where device registers are being accessed.

On top of that, expand the DRM uAPI for the perfcnt DUMP operation
so that user space can be made aware of a reset having happened,
whether it succeeded or failed to restore the original configuration.
UM needs to know about this condition because counter data is inaccurate
after a reset, so the best approach might be simply to try again.

Finally, update driver uAPI documentation to explain the meaning of the
new perfcnt dump ioctl's state flags, and bump DRM driver minor number
to reflect the new DUMP IOCTL req field.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Fixes: 73e467f60acd ("drm/panfrost: Consolidate reset handling")
Fixes: 7786fd108777 ("drm/panfrost: Expose performance counters through unstable ioctls")
Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c  |   2 +
 drivers/gpu/drm/panfrost/panfrost_drv.c     |   3 +-
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 274 +++++++++++++++++++---------
 drivers/gpu/drm/panfrost/panfrost_perfcnt.h |   1 +
 include/uapi/drm/panfrost_drm.h             |  29 ++-
 5 files changed, 223 insertions(+), 86 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 5718e8185427..fb0a1b45007b 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -519,6 +519,8 @@ void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_job_int)
 	panfrost_jm_reset_interrupts(pfdev);
 	if (enable_job_int)
 		panfrost_jm_enable_interrupts(pfdev);
+
+	panfrost_perfcnt_reset(pfdev);
 }
 
 static int panfrost_device_runtime_resume(struct device *dev)
diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index a141a41e224b..7c348a0bf1ee 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -808,6 +808,7 @@ static const struct file_operations panfrost_drm_driver_fops = {
  * - 1.6 - adds PANFROST_BO_MAP_WB, PANFROST_IOCTL_SYNC_BO,
  *	   PANFROST_IOCTL_QUERY_BO_INFO and
  *	   DRM_PANFROST_PARAM_SELECTED_COHERENCY
+ * - 1.7 - adds PERFCNT_DUMP state field
  */
 static const struct drm_driver panfrost_drm_driver = {
 	.driver_features	= DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ,
@@ -820,7 +821,7 @@ static const struct drm_driver panfrost_drm_driver = {
 	.name			= "panfrost",
 	.desc			= "panfrost DRM",
 	.major			= 1,
-	.minor			= 6,
+	.minor			= 7,
 
 	.gem_create_object	= panfrost_gem_create_object,
 	.gem_prime_import	= panfrost_gem_prime_import,
diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
index b3f71d7fd82a..a9def452d5ef 100644
--- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
+++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright 2019 Collabora Ltd */
 
+#include "asm-generic/errno-base.h"
 #include <linux/completion.h>
 #include <linux/iopoll.h>
 #include <linux/iosys-map.h>
@@ -11,6 +12,7 @@
 #include <drm/drm_file.h>
 #include <drm/drm_gem_shmem_helper.h>
 #include <drm/panfrost_drm.h>
+#include <drm/drm_print.h>
 
 #include "panfrost_device.h"
 #include "panfrost_features.h"
@@ -28,21 +30,31 @@
 
 struct panfrost_perfcnt {
 	struct panfrost_gem_mapping *mapping;
+	unsigned int counterset;
 	size_t bosize;
 	void *buf;
 	struct panfrost_file_priv *user;
 	struct mutex lock;
 	struct completion dump_comp;
+	u32 state;
+	bool owns_as_ref;
 };
 
 static void panfrost_perfcnt_hw_disable(struct panfrost_device *pfdev)
 {
+	struct panfrost_perfcnt *perfcnt = pfdev->perfcnt;
+
 	gpu_write(pfdev, GPU_PERFCNT_CFG,
 		  GPU_PERFCNT_CFG_MODE(GPU_PERFCNT_CFG_MODE_OFF));
 	gpu_write(pfdev, GPU_PRFCNT_JM_EN, 0x0);
 	gpu_write(pfdev, GPU_PRFCNT_SHADER_EN, 0x0);
 	gpu_write(pfdev, GPU_PRFCNT_MMU_L2_EN, 0x0);
 	gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0);
+
+	if (perfcnt->owns_as_ref) {
+		panfrost_mmu_as_put(pfdev, perfcnt->mapping->mmu);
+		perfcnt->owns_as_ref = false;
+	}
 }
 
 void panfrost_perfcnt_clean_cache_done(struct panfrost_device *pfdev)
@@ -58,27 +70,130 @@ void panfrost_perfcnt_sample_done(struct panfrost_device *pfdev)
 		complete(&pfdev->perfcnt->dump_comp);
 }
 
-static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev)
+static int panfrost_perfcnt_hw_enable(struct panfrost_device *pfdev)
+{
+	struct panfrost_perfcnt *perfcnt = pfdev->perfcnt;
+	u32 cfg, as;
+	int ret;
+
+	lockdep_assert_held(&pfdev->reset.lock);
+	drm_WARN_ON(&pfdev->base, perfcnt->owns_as_ref);
+
+	ret = panfrost_mmu_as_get(pfdev, perfcnt->mapping->mmu);
+	if (ret < 0)
+		return ret;
+
+	perfcnt->owns_as_ref = true;
+
+	as = ret;
+	cfg = GPU_PERFCNT_CFG_AS(as) |
+	      GPU_PERFCNT_CFG_MODE(GPU_PERFCNT_CFG_MODE_MANUAL);
+
+	/*
+	 * Bifrost GPUs have 2 set of counters, but we're only interested by
+	 * the first one for now.
+	 */
+	if (panfrost_model_is_bifrost(pfdev))
+		cfg |= GPU_PERFCNT_CFG_SETSEL(perfcnt->counterset);
+
+	gpu_write(pfdev, GPU_PRFCNT_JM_EN, 0xffffffff);
+	gpu_write(pfdev, GPU_PRFCNT_SHADER_EN, 0xffffffff);
+	gpu_write(pfdev, GPU_PRFCNT_MMU_L2_EN, 0xffffffff);
+
+	/*
+	 * Due to PRLAM-8186 we need to disable the Tiler before we enable HW
+	 * counters.
+	 */
+	if (panfrost_has_hw_issue(pfdev, HW_ISSUE_8186))
+		gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0);
+	else
+		gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0xffffffff);
+
+	gpu_write(pfdev, GPU_PERFCNT_CFG, cfg);
+
+	if (panfrost_has_hw_issue(pfdev, HW_ISSUE_8186))
+		gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0xffffffff);
+
+	return 0;
+}
+
+static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev, u32 *state)
 {
-	u64 gpuva;
+	struct panfrost_perfcnt *perfcnt = pfdev->perfcnt;
+	u64 gpuva = perfcnt->mapping->mmnode.start << PAGE_SHIFT;
 	int ret;
 
-	reinit_completion(&pfdev->perfcnt->dump_comp);
-	gpuva = pfdev->perfcnt->mapping->mmnode.start << PAGE_SHIFT;
-	gpu_write(pfdev, GPU_PERFCNT_BASE_LO, lower_32_bits(gpuva));
-	gpu_write(pfdev, GPU_PERFCNT_BASE_HI, upper_32_bits(gpuva));
-	gpu_write(pfdev, GPU_INT_CLEAR,
-		  GPU_IRQ_CLEAN_CACHES_COMPLETED |
-		  GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
-	gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_SAMPLE);
+	scoped_guard(rwsem_read, &pfdev->reset.lock) {
+		*state = perfcnt->state;
+		if (perfcnt->state & PANFROST_PERFCNT_SESSION_DEAD)
+			return -EIO;
+
+		perfcnt->state = 0;
+
+		reinit_completion(&pfdev->perfcnt->dump_comp);
+
+		gpu_write(pfdev, GPU_PERFCNT_BASE_LO, lower_32_bits(gpuva));
+		gpu_write(pfdev, GPU_PERFCNT_BASE_HI, upper_32_bits(gpuva));
+		gpu_write(pfdev, GPU_INT_CLEAR, GPU_IRQ_CLEAN_CACHES_COMPLETED |
+						GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
+		gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_SAMPLE);
+	}
+
+	/*
+	 * Here we release the reset semaphore because perfcnt should not get in the way
+	 * of a HW reset. Besides, a legitimate reset might be issued during the wait.
+	 */
 	ret = wait_for_completion_interruptible_timeout(&pfdev->perfcnt->dump_comp,
 							msecs_to_jiffies(1000));
+
 	if (!ret)
 		ret = -ETIMEDOUT;
-	else if (ret > 0)
-		ret = 0;
 
-	return ret;
+	/* We need to restore perfcnt state so the next successful dump can relay it to UM */
+	if (ret < 0) {
+		perfcnt->state |= *state;
+		*state = 0;
+		return ret;
+	}
+
+	scoped_guard(rwsem_read, &pfdev->reset.lock) {
+		*state |= perfcnt->state;
+
+		/* UM must re-enable their session before requesting new dumps. */
+		if (perfcnt->state & PANFROST_PERFCNT_SESSION_DEAD)
+			return -EIO;
+
+		/* If we faced a reset during our SAMPLE, the user needs to try again. */
+		if (perfcnt->state & PANFROST_PERFCNT_SESSION_INTERRUPTED_BY_RESET)
+			return -EAGAIN;
+	}
+
+	return 0;
+}
+
+static int panfrost_perfcnt_disable_locked(struct panfrost_device *pfdev,
+					   struct drm_file *file_priv)
+{
+	struct panfrost_file_priv *user = file_priv->driver_priv;
+	struct panfrost_perfcnt *perfcnt = pfdev->perfcnt;
+	struct iosys_map map = IOSYS_MAP_INIT_VADDR(perfcnt->buf);
+
+	if (user != perfcnt->user)
+		return -EINVAL;
+
+	scoped_guard(rwsem_read, &pfdev->reset.lock) {
+		panfrost_perfcnt_hw_disable(pfdev);
+		perfcnt->user = NULL;
+	}
+
+	drm_gem_vunmap(&perfcnt->mapping->obj->base.base, &map);
+	perfcnt->buf = NULL;
+	panfrost_gem_close(&perfcnt->mapping->obj->base.base, file_priv);
+	panfrost_gem_mapping_put(perfcnt->mapping);
+	perfcnt->mapping = NULL;
+	pm_runtime_put_autosuspend(pfdev->base.dev);
+
+	return 0;
 }
 
 static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
@@ -87,14 +202,29 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
 {
 	struct panfrost_file_priv *user = file_priv->driver_priv;
 	struct panfrost_perfcnt *perfcnt = pfdev->perfcnt;
-	struct iosys_map map;
 	struct drm_gem_shmem_object *bo;
-	u32 cfg, as;
+	struct iosys_map map;
 	int ret;
 
-	if (user == perfcnt->user)
+	if (perfcnt->user == user) {
+		scoped_guard(rwsem_read, &pfdev->reset.lock) {
+			if (perfcnt->state & PANFROST_PERFCNT_SESSION_DEAD) {
+				/* A successful reset might've come through in the time gap
+				 * between the last failed one and this re-enable attempt.
+				 */
+				ret = (perfcnt->owns_as_ref) ? 0 :
+					panfrost_perfcnt_hw_enable(pfdev);
+				if (!ret)
+					perfcnt->state = 0;
+
+				return ret;
+			}
+		}
+
 		return 0;
-	else if (perfcnt->user)
+	}
+
+	if (perfcnt->user)
 		return -EBUSY;
 
 	ret = pm_runtime_get_sync(pfdev->base.dev);
@@ -122,54 +252,30 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
 	ret = drm_gem_vmap(&bo->base, &map);
 	if (ret)
 		goto err_put_mapping;
+
 	perfcnt->buf = map.vaddr;
+	perfcnt->counterset = counterset;
 
 	panfrost_gem_internal_set_label(&bo->base, "Perfcnt sample buffer");
 
-	/*
-	 * Clear the counters to start from a fresh state.
-	 */
-	gpu_write(pfdev, GPU_INT_CLEAR, GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
-	gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_CLEAR);
-
-	ret = panfrost_mmu_as_get(pfdev, perfcnt->mapping->mmu);
-	if (ret < 0)
-		goto err_vunmap;
-
-	as = ret;
-	cfg = GPU_PERFCNT_CFG_AS(as) |
-	      GPU_PERFCNT_CFG_MODE(GPU_PERFCNT_CFG_MODE_MANUAL);
-
-	/*
-	 * Bifrost GPUs have 2 set of counters, but we're only interested by
-	 * the first one for now.
-	 */
-	if (panfrost_model_is_bifrost(pfdev))
-		cfg |= GPU_PERFCNT_CFG_SETSEL(counterset);
-
-	gpu_write(pfdev, GPU_PRFCNT_JM_EN, 0xffffffff);
-	gpu_write(pfdev, GPU_PRFCNT_SHADER_EN, 0xffffffff);
-	gpu_write(pfdev, GPU_PRFCNT_MMU_L2_EN, 0xffffffff);
-
-	/*
-	 * Due to PRLAM-8186 we need to disable the Tiler before we enable HW
-	 * counters.
-	 */
-	if (panfrost_has_hw_issue(pfdev, HW_ISSUE_8186))
-		gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0);
-	else
-		gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0xffffffff);
+	scoped_guard(rwsem_read, &pfdev->reset.lock) {
+		/*
+		 * Clear the counters to start from a fresh state.
+		 */
+		gpu_write(pfdev, GPU_INT_CLEAR, GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
+		gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_CLEAR);
 
-	gpu_write(pfdev, GPU_PERFCNT_CFG, cfg);
+		ret = panfrost_perfcnt_hw_enable(pfdev);
+		if (ret)
+			goto err_vunmap;
 
-	if (panfrost_has_hw_issue(pfdev, HW_ISSUE_8186))
-		gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0xffffffff);
+		perfcnt->user = user;
+		perfcnt->state = 0;
+	}
 
 	/* The BO ref is retained by the mapping. */
 	drm_gem_object_put(&bo->base);
 
-	perfcnt->user = user;
-
 	return 0;
 
 err_vunmap:
@@ -185,30 +291,6 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
 	return ret;
 }
 
-static int panfrost_perfcnt_disable_locked(struct panfrost_device *pfdev,
-					   struct drm_file *file_priv)
-{
-	struct panfrost_file_priv *user = file_priv->driver_priv;
-	struct panfrost_perfcnt *perfcnt = pfdev->perfcnt;
-	struct iosys_map map = IOSYS_MAP_INIT_VADDR(perfcnt->buf);
-
-	if (user != perfcnt->user)
-		return -EINVAL;
-
-	panfrost_perfcnt_hw_disable(pfdev);
-
-	perfcnt->user = NULL;
-	drm_gem_vunmap(&perfcnt->mapping->obj->base.base, &map);
-	perfcnt->buf = NULL;
-	panfrost_gem_close(&perfcnt->mapping->obj->base.base, file_priv);
-	panfrost_mmu_as_put(pfdev, perfcnt->mapping->mmu);
-	panfrost_gem_mapping_put(perfcnt->mapping);
-	perfcnt->mapping = NULL;
-	pm_runtime_put_autosuspend(pfdev->base.dev);
-
-	return 0;
-}
-
 int panfrost_ioctl_perfcnt_enable(struct drm_device *dev, void *data,
 				  struct drm_file *file_priv)
 {
@@ -249,13 +331,16 @@ int panfrost_ioctl_perfcnt_dump(struct drm_device *dev, void *data,
 	if (ret)
 		return ret;
 
+	if (req->pad)
+		return -EINVAL;
+
 	mutex_lock(&perfcnt->lock);
 	if (perfcnt->user != file_priv->driver_priv) {
 		ret = -EINVAL;
 		goto out;
 	}
 
-	ret = panfrost_perfcnt_dump_locked(pfdev);
+	ret = panfrost_perfcnt_dump_locked(pfdev, &req->state);
 	if (ret)
 		goto out;
 
@@ -322,14 +407,13 @@ int panfrost_perfcnt_init(struct panfrost_device *pfdev)
 		return -ENOMEM;
 
 	perfcnt->bosize = size;
+	pfdev->perfcnt = perfcnt;
+	mutex_init(&perfcnt->lock);
+	init_completion(&perfcnt->dump_comp);
 
 	/* Start with everything disabled. */
 	panfrost_perfcnt_hw_disable(pfdev);
 
-	init_completion(&perfcnt->dump_comp);
-	mutex_init(&perfcnt->lock);
-	pfdev->perfcnt = perfcnt;
-
 	return 0;
 }
 
@@ -338,3 +422,25 @@ void panfrost_perfcnt_fini(struct panfrost_device *pfdev)
 	/* Disable everything before leaving. */
 	panfrost_perfcnt_hw_disable(pfdev);
 }
+
+void panfrost_perfcnt_reset(struct panfrost_device *pfdev)
+{
+	struct panfrost_perfcnt *perfcnt = pfdev->perfcnt;
+
+	if (drm_WARN_ON(&pfdev->base, !perfcnt))
+		return;
+
+	lockdep_assert_held(&pfdev->reset.lock);
+
+	if (!perfcnt->user)
+		return;
+
+	/* All active AS are released during the MMU post_reset. */
+	perfcnt->owns_as_ref = false;
+	perfcnt->state |= PANFROST_PERFCNT_SESSION_INTERRUPTED_BY_RESET;
+	if (panfrost_perfcnt_hw_enable(pfdev))
+		perfcnt->state |= PANFROST_PERFCNT_SESSION_DEAD;
+
+	/* Unblock pending sample requests. */
+	complete(&perfcnt->dump_comp);
+}
diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.h b/drivers/gpu/drm/panfrost/panfrost_perfcnt.h
index 8bbcf5f5fb33..8b9bc704b634 100644
--- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.h
+++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.h
@@ -14,5 +14,6 @@ int panfrost_ioctl_perfcnt_enable(struct drm_device *dev, void *data,
 				  struct drm_file *file_priv);
 int panfrost_ioctl_perfcnt_dump(struct drm_device *dev, void *data,
 				struct drm_file *file_priv);
+void panfrost_perfcnt_reset(struct panfrost_device *pfdev);
 
 #endif
diff --git a/include/uapi/drm/panfrost_drm.h b/include/uapi/drm/panfrost_drm.h
index 50d5337f35ef..7831c48c59c0 100644
--- a/include/uapi/drm/panfrost_drm.h
+++ b/include/uapi/drm/panfrost_drm.h
@@ -47,7 +47,7 @@ extern "C" {
  * them for anything but debugging purpose.
  */
 #define DRM_IOCTL_PANFROST_PERFCNT_ENABLE	DRM_IOW(DRM_COMMAND_BASE + DRM_PANFROST_PERFCNT_ENABLE, struct drm_panfrost_perfcnt_enable)
-#define DRM_IOCTL_PANFROST_PERFCNT_DUMP		DRM_IOW(DRM_COMMAND_BASE + DRM_PANFROST_PERFCNT_DUMP, struct drm_panfrost_perfcnt_dump)
+#define DRM_IOCTL_PANFROST_PERFCNT_DUMP		DRM_IOWR(DRM_COMMAND_BASE + DRM_PANFROST_PERFCNT_DUMP, struct drm_panfrost_perfcnt_dump)
 
 #define PANFROST_JD_REQ_FS (1 << 0)
 #define PANFROST_JD_REQ_CYCLE_COUNT (1 << 1)
@@ -270,8 +270,35 @@ struct drm_panfrost_perfcnt_enable {
 	__u32 counterset;
 };
 
+/*
+ * The next two flags describe the state of a perfcnt dump request
+ * as influenced by a device reset. They are the only values the
+ * perfcnt_dump ioctl state field can take on.
+ * Only certain state and ioctl retval combinations are legitimate.
+ */
+
+/* A new perfcnt_enable ioctl should be issued before requesting
+ * more dumps, because a HW reset failed to recreate perfcnt's
+ * original state. Otherwise further perfcnt_dump's will fail.
+ * This flag being set means ioctl's retval is always -EIO.
+ */
+#define PANFROST_PERFCNT_SESSION_DEAD (1 << 0)
+
+/* A HW reset happened before or during a sample request, and
+ * perfcnt's internal state was successfully restored. There
+ * are two possible outcomes depending on the ioctl's retval:
+ *	0: A reset happened before a dump was requested, but did
+ * nonetheless succeed. Counter values are relative to last reset.
+ *	-EAGAIN: A reset happened when a counter values sampling
+ * request was ongoing. Values are undefined so a new dump ioctl
+ * should be issued.
+ */
+#define PANFROST_PERFCNT_SESSION_INTERRUPTED_BY_RESET (1 << 1)
+
 struct drm_panfrost_perfcnt_dump {
 	__u64 buf_ptr;
+	__u32 state;
+	__u32 pad;		/* MBZ */
 };
 
 /* madvise provides a way to tell the kernel in case a buffers contents

-- 
2.55.0

