Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 888B1C88E4D
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 23:29:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBE7B10F72E;
	Fri, 11 Sep 2026 23:29:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="cF32SGVA";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0B8B10F72C
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 23:29:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1789169365; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=EkOTKZRxOXjzDpcrkWFdJ6r6aX9NvJCA4yzFVmUgGc4Zp/CLsiVw47IW+h/Qy1curw2BZ+qgY/OyNZyVGN0Iy59ViEn6zCXfx5FIexCuo/Z3NXQnsfB9m6nS39tVS4zJ5lb/aINIIwLYjFoW8x657xS5h7BsdIGA8L9IZW5I0U8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1789169365;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=XgYQZioWss+0W6RIBexnHpTxemvT1PwUX0wSSrz/SkQ=; 
 b=fcZJWbiKOoaQkXTkiVBGNS3Wro4AlaHV75tkzNq3C6d6YkDscG96w4UEs6/cqn9dyYXTWOLi5HnQ4v7XHkvAmU4NvjhmYrMOqsY53sUpgvF4Ragetx8QGd500eC3+GeeKUnVx3g5y+qZ94odzBathoBKkh3lwRN/viZQaP9RFr4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789169365; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=XgYQZioWss+0W6RIBexnHpTxemvT1PwUX0wSSrz/SkQ=;
 b=cF32SGVAHZ0+UFlaZYTMU9hoOedWtBYhbjxuEfeedAdjkb5jaloyYJUNsoSBhNz/
 j6G9h4tC3iIynP5b6IduDGX8xaXTCS9hUHj+HRNWWsxX5zw6UQ2iV8Q2gNrE5pf7mB2
 mbONNs1U+zFfWglBYxJCD5OP9PtYes6AnOT9CaBY=
Received: by mx.zohomail.com with SMTPS id 1789169364823122.63552077689667;
 Fri, 11 Sep 2026 16:29:24 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Sat, 12 Sep 2026 00:28:16 +0100
Subject: [PATCH v9 15/16] drm/panfrost: Fix races between perfcnt and reset
 sequence
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260912-claude-fixes-v9-15-e588feaa61ef@collabora.com>
References: <20260912-claude-fixes-v9-0-e588feaa61ef@collabora.com>
In-Reply-To: <20260912-claude-fixes-v9-0-e588feaa61ef@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=12794;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=YeKXUZ93Q9F5vUdhNp7eaVwO8Q8g+ZJVdxDLh+Ohxco=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqpI6Eb1PKC16MsvgQnHvQbMoeExPRU9iobjm/W
 NxSv2TeuuKJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCaqSOhAAKCRAOJn5M7lND
 PbDpDAC4qylXhHx3PXIAtcNeSEXzNZk5GN2djVUEfSzxenuhRqvQSFchwPpNRuhHUf1+YEocepz
 XSGsv7+9wHHg7k+mEXF1hCqIP1Q0N4yKZSbmo76SNgh2gm+D2Tq5malXkBCSLqN6FkPZKCtVkRO
 ukNEstt9M1A4DfWWgXNani9xkoVOlErdQOR4/2R2WvzrR5SbDhHl6Lj0B2PvojzHfByLq1W22Hk
 zE62bF7k0t/zDbpxC17iAymYCPs0RKi0HOtkHjY4pUxujprkKgQgyA9p17nTIT/GtHP2Z5q3pAC
 XkLCTCCTICaQbDsh3bHbktyO7u2dQ7GQqOX4bh41K8M08aXy1DRPCqiKDcf0Pg1gd5q7KRziUow
 9eFvwVxrf6+Aoht5BdWWEskGmGz6wyhYTFphslcY+4ZEQAsOBfkyyNWpVSYqS5dBWobvv+hD7zb
 oivtfGnFrAzQyw+pbhK/0SLzPZhYlehHpqEmQWpzxfakK5Fobug2ptjn3hl+1mY1KNBkU=
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
perfcnt to its original configuration if there was an enabled session,
or else flags the current session as dead if that failed.

Fixes: 73e467f60acd ("drm/panfrost: Consolidate reset handling")
Fixes: 7786fd108777 ("drm/panfrost: Expose performance counters through unstable ioctls")
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c  |   2 +
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 201 +++++++++++++++++++---------
 drivers/gpu/drm/panfrost/panfrost_perfcnt.h |   1 +
 include/uapi/drm/panfrost_drm.h             |   8 +-
 4 files changed, 151 insertions(+), 61 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 6c65feae63aa..e774f61c642b 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -479,6 +479,8 @@ void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_job_int)
 	panfrost_jm_reset_interrupts(pfdev);
 	if (enable_job_int)
 		panfrost_jm_enable_interrupts(pfdev);
+
+	panfrost_perfcnt_reset(pfdev);
 }
 
 static int panfrost_device_runtime_resume(struct device *dev)
diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
index b3f71d7fd82a..9847657179a5 100644
--- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
+++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
@@ -11,6 +11,7 @@
 #include <drm/drm_file.h>
 #include <drm/drm_gem_shmem_helper.h>
 #include <drm/panfrost_drm.h>
+#include <drm/drm_print.h>
 
 #include "panfrost_device.h"
 #include "panfrost_features.h"
@@ -28,11 +29,15 @@
 
 struct panfrost_perfcnt {
 	struct panfrost_gem_mapping *mapping;
+	unsigned int counterset;
 	size_t bosize;
 	void *buf;
 	struct panfrost_file_priv *user;
 	struct mutex lock;
 	struct completion dump_comp;
+	bool reset_happened;
+	bool dump_finished;
+	bool owns_as_ref;
 };
 
 static void panfrost_perfcnt_hw_disable(struct panfrost_device *pfdev)
@@ -47,36 +52,113 @@ static void panfrost_perfcnt_hw_disable(struct panfrost_device *pfdev)
 
 void panfrost_perfcnt_clean_cache_done(struct panfrost_device *pfdev)
 {
+	pfdev->perfcnt->dump_finished = true;
 	complete(&pfdev->perfcnt->dump_comp);
 }
 
 void panfrost_perfcnt_sample_done(struct panfrost_device *pfdev)
 {
-	if (pfdev->features.selected_coherency != COHERENCY_ACE)
+	if (pfdev->features.selected_coherency != COHERENCY_ACE) {
 		gpu_write(pfdev, GPU_CMD, GPU_CMD_CLEAN_CACHES);
-	else
+	} else {
+		pfdev->perfcnt->dump_finished = true;
 		complete(&pfdev->perfcnt->dump_comp);
+	}
+}
+
+static int panfrost_perfcnt_hw_enable(struct panfrost_device *pfdev)
+{
+	struct panfrost_perfcnt *perfcnt = pfdev->perfcnt;
+	u32 cfg, as;
+	int ret;
+
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
 }
 
-static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev)
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
+		perfcnt->dump_finished = false;
+		*state = 0;
+
+		if (!perfcnt->owns_as_ref) {
+			*state = PANFROST_PERFCNT_SESSION_DEAD;
+			return -EIO;
+		}
+
+		if (perfcnt->reset_happened) {
+			*state = PANFROST_PERFCNT_SESSION_INTERRUPTED_BY_RESET;
+			perfcnt->reset_happened = false;
+		}
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
-	if (!ret)
-		ret = -ETIMEDOUT;
-	else if (ret > 0)
-		ret = 0;
+
+	scoped_guard(rwsem_read, &pfdev->reset.lock) {
+		/* Either sample finished or reset happened */
+		if (ret > 0) {
+			ret = perfcnt->dump_finished ? 0 :
+			      perfcnt->owns_as_ref ? -EAGAIN : -EIO;
+
+		} else if (!ret) {
+			ret = -ETIMEDOUT;
+		}
+
+		if (perfcnt->reset_happened)
+			*state |= PANFROST_PERFCNT_SESSION_INTERRUPTED_BY_RESET;
+		if (!perfcnt->owns_as_ref)
+			*state |= PANFROST_PERFCNT_SESSION_DEAD;
+	}
 
 	return ret;
 }
@@ -87,9 +169,8 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
 {
 	struct panfrost_file_priv *user = file_priv->driver_priv;
 	struct panfrost_perfcnt *perfcnt = pfdev->perfcnt;
-	struct iosys_map map;
 	struct drm_gem_shmem_object *bo;
-	u32 cfg, as;
+	struct iosys_map map;
 	int ret;
 
 	if (user == perfcnt->user)
@@ -122,54 +203,31 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
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
+		perfcnt->reset_happened = false;
+		perfcnt->owns_as_ref = true;
+		perfcnt->user = user;
+	}
 
 	/* The BO ref is retained by the mapping. */
 	drm_gem_object_put(&bo->base);
 
-	perfcnt->user = user;
-
 	return 0;
 
 err_vunmap:
@@ -195,13 +253,16 @@ static int panfrost_perfcnt_disable_locked(struct panfrost_device *pfdev,
 	if (user != perfcnt->user)
 		return -EINVAL;
 
-	panfrost_perfcnt_hw_disable(pfdev);
+	scoped_guard(rwsem_read, &pfdev->reset.lock) {
+		panfrost_perfcnt_hw_disable(pfdev);
+		if (perfcnt->owns_as_ref)
+			panfrost_mmu_as_put(pfdev, perfcnt->mapping->mmu);
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
@@ -249,13 +310,16 @@ int panfrost_ioctl_perfcnt_dump(struct drm_device *dev, void *data,
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
 
@@ -338,3 +402,20 @@ void panfrost_perfcnt_fini(struct panfrost_device *pfdev)
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
+	perfcnt->owns_as_ref = !panfrost_perfcnt_hw_enable(pfdev);
+	perfcnt->reset_happened = true;
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
index 50d5337f35ef..97e001040543 100644
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
@@ -270,8 +270,14 @@ struct drm_panfrost_perfcnt_enable {
 	__u32 counterset;
 };
 
+/* Perfcnt dump state as influenced by a HW reset */
+#define PANFROST_PERFCNT_SESSION_DEAD                 (1 << 0)
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

