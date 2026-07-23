Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD5AC531D0
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 00:01:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F52010E62A;
	Fri, 24 Jul 2026 00:01:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="P4m6fT4k";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A98010E612
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 00:01:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1784851259; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=CkQbxsmz96nG66Ta+rTKHlHj7qsnpZZOH/r8/UGMIUt6uf5bbdTuvGSOsNrbDDf0/KYgaFiAgFhQ3v+SDblUC5MyBWG6+txFGaavgIdAsRF0CmlEWy5sj7w546e7yXZBjFicT9Bff5/nqOM1e0YJfsELbC51NXvSya9RxLcvsr4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784851259;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=DmZtT6kwrFG5BgWbgw0NLlVeNDiHnpyQcTrEnyxm964=; 
 b=X5mqbsYgtSHa45tK2Da7v5ioE6Gw+X9hj2zZ0ixgTBkHGo0+TV0dzt50Bg01HI5ltxoKkR++niFBBTJclMOk3hiqygSHEmFUcXlMjxk6sYrG+bPLo2UIigD8hgCkNrzeQKuduqocwg7jkOWJ69W65DaJhd7ZOisrapAdHK8aCBI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784851259; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=DmZtT6kwrFG5BgWbgw0NLlVeNDiHnpyQcTrEnyxm964=;
 b=P4m6fT4k6dXozIiMOBbBmb0k1oa8hWxAkVz87LwDgWAG6OTzBKKCMFV4B6zENpDJ
 PgHaD3R66whLvzWPwYER6HTxHCOCYLDUd1aQ/Z3hVa66snf6w2/ZG1XqnVR2ZQlgDgB
 8AWvIph+Un97KxMtVyr4+2pgPcIFyYDtP0MG0aQM=
Received: by mx.zohomail.com with SMTPS id 1784851257277990.4925539614621;
 Thu, 23 Jul 2026 17:00:57 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Fri, 24 Jul 2026 00:59:05 +0100
Subject: [PATCH v3 12/13] drm/panfrost: Fix races between perfcnt and reset
 sequence
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260724-claude-fixes-v3-12-542af61abd0f@collabora.com>
References: <20260724-claude-fixes-v3-0-542af61abd0f@collabora.com>
In-Reply-To: <20260724-claude-fixes-v3-0-542af61abd0f@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>, 
 "Marty E. Plummer" <hanetzer@startmail.com>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>, 
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=12692;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=ZQVtgbIlObc6kA/k0j/xqw2dNF/CaFJE1JMxBRIX3Jg=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqYqrpLnIGwAaUSHumpmq8aIDfxzAye/y9Wfo7Q
 IoX9GIPwzqJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCamKq6QAKCRAOJn5M7lND
 PWQbC/9mLqoPuy1Le+CITjSFIVnL0OX1V5ukFc6ktrbYmcPWEWj6m1nArX1eNw/Cn1oJTOpzuxE
 D4pVY1Ma9oCbW2xlqfHwNMt4ki88GzJr7VFLLjsoN6EqB9gnVmBZ1xgzTigdUcLJLi5+6YSXNRW
 8S82S+N6noVpLh0THkWx2W78ZyHQV5UMfvX+kNdDGI4LRckxFS0NhoXlxEsxpL3Xydi/TZm6foy
 AqozVwA7V0YoTHzRI4tH2rg+N7jswL31XBf2WDIaBO8uz/5VYfNhRMT32g4WR7dLGCWEUsJD1Uo
 wqbhuxavKOOHdFx13V8nRLaBS3wV69NM5me741uJk1w9twjUY7wyY7SHc0t0UdKbcS3bSK74TZy
 rPj2dg7aA7YDReb8D69vSpp8eiwKbilR/bXXHzUFg4VJCk6fqe7b08hIQ8tdzA8PDAEBf9Rcw0d
 NR28xAg2GV6pgQDPaMPANzAlot+IP69HYNHOIbaW6rR94ymnPuRXFsfocP8kL6ywihyxw=
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

Use the reset r/w semaphore to govern access to the hardware at reset
time. On top of that, expand the DRM uAPI for the perfcnt DUMP operation
so that userspace can be made aware of a reset having happened, because
that means counters will go back to 0 and can no longer be accumulated
to values previously kept in user space.

The new perfcnt-aware reset sequence also takes care to reestablish
perfcnt to its original configuration if there was an enabled session.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c  |   5 +-
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 196 ++++++++++++++++++++--------
 drivers/gpu/drm/panfrost/panfrost_perfcnt.h |   2 +
 include/uapi/drm/panfrost_drm.h             |   3 +-
 4 files changed, 146 insertions(+), 60 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 46c6e911e562..2ee8d9584c36 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -618,8 +618,10 @@ void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_job_int)
 	int ret;
 
 	/* Pre-reset */
-	if (panfrost_device_is_initialized(pfdev))
+	if (panfrost_device_is_initialized(pfdev)) {
 		down_write(&pfdev->reset.lock);
+		panfrost_perfcnt_reset(pfdev);
+	}
 
 	/* Do the actual device reset */
 	ret = panfrost_gpu_soft_reset(pfdev);
@@ -634,6 +636,7 @@ void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_job_int)
 		panfrost_jm_reset_interrupts(pfdev);
 		if (enable_job_int)
 			panfrost_jm_enable_interrupts(pfdev);
+		panfrost_perfcnt_postreset(pfdev);
 		up_write(&pfdev->reset.lock);
 	}
 }
diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
index ad1156678e91..a6f1b0b961fc 100644
--- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
+++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
@@ -11,6 +11,7 @@
 #include <drm/drm_file.h>
 #include <drm/drm_gem_shmem_helper.h>
 #include <drm/panfrost_drm.h>
+#include <drm/drm_print.h>
 
 #include "panfrost_device.h"
 #include "panfrost_features.h"
@@ -25,14 +26,17 @@
 #define BYTES_PER_COUNTER		4
 #define BLOCKS_PER_COREGROUP		8
 #define V4_SHADERS_PER_COREGROUP	4
+#define PERFCNT_DUMP_MAX_RETRIES	5
 
 struct panfrost_perfcnt {
 	struct panfrost_gem_mapping *mapping;
+	unsigned int counterset;
 	size_t bosize;
 	void *buf;
 	struct panfrost_file_priv *user;
 	struct mutex lock;
 	struct completion dump_comp;
+	atomic_t reset_happened;
 };
 
 static void panfrost_perfcnt_gpu_disable(struct panfrost_device *pfdev)
@@ -55,38 +59,98 @@ void panfrost_perfcnt_sample_done(struct panfrost_device *pfdev)
 	gpu_write(pfdev, GPU_CMD, GPU_CMD_CLEAN_CACHES);
 }
 
-static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev)
+static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev,
+					u64 *reset_happened)
 {
+	struct panfrost_perfcnt *perfcnt = pfdev->perfcnt;
+	u64 retries = PERFCNT_DUMP_MAX_RETRIES;
+	bool previous_reset;
 	u64 gpuva;
 	int ret;
 
 	reinit_completion(&pfdev->perfcnt->dump_comp);
 	gpuva = pfdev->perfcnt->mapping->mmnode.start << PAGE_SHIFT;
-	gpu_write(pfdev, GPU_PERFCNT_BASE_LO, lower_32_bits(gpuva));
-	gpu_write(pfdev, GPU_PERFCNT_BASE_HI, upper_32_bits(gpuva));
-	gpu_write(pfdev, GPU_INT_CLEAR,
-		  GPU_IRQ_CLEAN_CACHES_COMPLETED |
-		  GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
-	gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_SAMPLE);
+	previous_reset = atomic_read(&perfcnt->reset_happened);
+
+dump_retry:
+	scoped_guard(rwsem_read, &pfdev->reset.lock) {
+		gpu_write(pfdev, GPU_PERFCNT_BASE_LO, lower_32_bits(gpuva));
+		gpu_write(pfdev, GPU_PERFCNT_BASE_HI, upper_32_bits(gpuva));
+		gpu_write(pfdev, GPU_INT_CLEAR, GPU_IRQ_CLEAN_CACHES_COMPLETED |
+						GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
+		gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_SAMPLE);
+	}
+
 	ret = wait_for_completion_interruptible_timeout(&pfdev->perfcnt->dump_comp,
 							msecs_to_jiffies(1000));
-	if (!ret)
-		ret = -ETIMEDOUT;
-	else if (ret > 0)
-		ret = 0;
+	if (retries == PERFCNT_DUMP_MAX_RETRIES)
+		*reset_happened = previous_reset || atomic_read(&perfcnt->reset_happened);
+
+	if (atomic_cmpxchg(&perfcnt->reset_happened, 1, 0)) {
+		if (--retries >= 0)
+			goto dump_retry;
+		ret = -EBUSY;
+	} else {
+		if (!ret)
+			ret = -ETIMEDOUT;
+		else if (ret > 0)
+			ret = 0;
+	}
 
 	return ret;
 }
 
+static int panfrost_perfcnt_hw_enable(struct panfrost_device *pfdev)
+{
+	struct panfrost_perfcnt *perfcnt = pfdev->perfcnt;
+	u32 cfg, as;
+	int ret;
+
+	/* TODO: could keeping the as somehow race with perfcnt_disable? */
+	ret = panfrost_mmu_as_get(pfdev, perfcnt->mapping->mmu);
+	if (ret < 0)
+		return ret;
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
 static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
 					  struct drm_file *file_priv,
 					  unsigned int counterset)
 {
 	struct panfrost_file_priv *user = file_priv->driver_priv;
 	struct panfrost_perfcnt *perfcnt = pfdev->perfcnt;
-	struct iosys_map map;
 	struct drm_gem_shmem_object *bo;
-	u32 cfg, as;
+	struct iosys_map map;
 	int ret;
 
 	if (user == perfcnt->user)
@@ -127,57 +191,37 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
 	 * Invalidate the cache and clear the counters to start from a fresh
 	 * state.
 	 */
-	reinit_completion(&pfdev->perfcnt->dump_comp);
-	gpu_write(pfdev, GPU_INT_CLEAR,
-		  GPU_IRQ_CLEAN_CACHES_COMPLETED |
-		  GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
-	gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_CLEAR);
-	gpu_write(pfdev, GPU_CMD, GPU_CMD_CLEAN_INV_CACHES);
+	scoped_guard(rwsem_read, &pfdev->reset.lock) {
+		reinit_completion(&pfdev->perfcnt->dump_comp);
+		gpu_write(pfdev, GPU_INT_CLEAR,
+			  GPU_IRQ_CLEAN_CACHES_COMPLETED |
+			  GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
+		gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_CLEAR);
+		gpu_write(pfdev, GPU_CMD, GPU_CMD_CLEAN_INV_CACHES);
+	}
+
+	/*
+	 * If a reset happens during the wait for the IRQ notification that caches
+	 * are clean and invalidated, then we know the reset sequence did the job
+	 * for us, even if resetting IRQs means the completion might time out.
+	 */
 	ret = wait_for_completion_timeout(&pfdev->perfcnt->dump_comp,
 					  msecs_to_jiffies(1000));
-	if (!ret) {
+	if (!ret && !atomic_read(&perfcnt->reset_happened)) {
 		ret = -ETIMEDOUT;
 		goto err_vunmap;
 	}
 
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
-
-	gpu_write(pfdev, GPU_PERFCNT_CFG, cfg);
-
-	if (panfrost_has_hw_issue(pfdev, HW_ISSUE_8186))
-		gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0xffffffff);
+	scoped_guard(rwsem_read, &pfdev->reset.lock) {
+		perfcnt->counterset = counterset;
+		perfcnt->user = user;
+		atomic_set(&perfcnt->reset_happened, 0);
+		panfrost_perfcnt_hw_enable(pfdev);
+	}
 
 	/* The BO ref is retained by the mapping. */
 	drm_gem_object_put(&bo->base);
 
-	perfcnt->user = user;
-
 	return 0;
 
 err_vunmap:
@@ -203,13 +247,15 @@ static int panfrost_perfcnt_disable_locked(struct panfrost_device *pfdev,
 	if (user != perfcnt->user)
 		return -EINVAL;
 
-	panfrost_perfcnt_gpu_disable(pfdev);
+	scoped_guard(rwsem_read, &pfdev->reset.lock) {
+		panfrost_mmu_as_put(pfdev, perfcnt->mapping->mmu);
+		panfrost_perfcnt_gpu_disable(pfdev);
+		perfcnt->user = NULL;
+	}
 
-	perfcnt->user = NULL;
 	drm_gem_vunmap(&perfcnt->mapping->obj->base.base, &map);
 	perfcnt->buf = NULL;
 	panfrost_gem_close(&perfcnt->mapping->obj->base.base, file_priv);
-	panfrost_mmu_as_put(pfdev, perfcnt->mapping->mmu);
 	panfrost_gem_mapping_put(perfcnt->mapping);
 	perfcnt->mapping = NULL;
 	pm_runtime_put_autosuspend(pfdev->base.dev);
@@ -263,7 +309,7 @@ int panfrost_ioctl_perfcnt_dump(struct drm_device *dev, void *data,
 		goto out;
 	}
 
-	ret = panfrost_perfcnt_dump_locked(pfdev);
+	ret = panfrost_perfcnt_dump_locked(pfdev, &req->hw_reset);
 	if (ret)
 		goto out;
 
@@ -346,3 +392,37 @@ void panfrost_perfcnt_fini(struct panfrost_device *pfdev)
 	/* Disable everything before leaving. */
 	panfrost_perfcnt_gpu_disable(pfdev);
 }
+
+void panfrost_perfcnt_reset(struct panfrost_device *pfdev)
+{
+	struct panfrost_perfcnt *perfcnt = pfdev->perfcnt;
+
+	/* Could a reset somehow race with perfcnt_fini? */
+	if (drm_WARN_ON(&pfdev->base, !perfcnt))
+		return;
+
+	lockdep_assert_held(&pfdev->reset.lock);
+
+	if (!perfcnt->user)
+		return;
+
+	atomic_set(&perfcnt->reset_happened, 1);
+	synchronize_irq(pfdev->gpu_irq);
+	complete(&perfcnt->dump_comp);
+	panfrost_perfcnt_gpu_disable(pfdev);
+}
+
+void panfrost_perfcnt_postreset(struct panfrost_device *pfdev)
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
+	panfrost_perfcnt_hw_enable(pfdev);
+}
diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.h b/drivers/gpu/drm/panfrost/panfrost_perfcnt.h
index 8bbcf5f5fb33..e14e760641fd 100644
--- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.h
+++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.h
@@ -14,5 +14,7 @@ int panfrost_ioctl_perfcnt_enable(struct drm_device *dev, void *data,
 				  struct drm_file *file_priv);
 int panfrost_ioctl_perfcnt_dump(struct drm_device *dev, void *data,
 				struct drm_file *file_priv);
+void panfrost_perfcnt_reset(struct panfrost_device *pfdev);
+void panfrost_perfcnt_postreset(struct panfrost_device *pfdev);
 
 #endif
diff --git a/include/uapi/drm/panfrost_drm.h b/include/uapi/drm/panfrost_drm.h
index 50d5337f35ef..3bbf9220103d 100644
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
@@ -272,6 +272,7 @@ struct drm_panfrost_perfcnt_enable {
 
 struct drm_panfrost_perfcnt_dump {
 	__u64 buf_ptr;
+	__u64 hw_reset;
 };
 
 /* madvise provides a way to tell the kernel in case a buffers contents

-- 
2.55.0

