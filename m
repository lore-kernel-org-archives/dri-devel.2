Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 384D9C5CFC1
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 21:43:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C73210EDA7;
	Tue, 11 Aug 2026 21:43:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="XlpNFFKc";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1754610EDAC
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 21:43:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786484597; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=NojG6MrD0O/P9pwJnk1BhHHkYiCF8PZR8xp1sScsXW85GRmGaQrSflrLSIxn8ck+uHv7QVRtT/FknoFSoJfM4UqwX5jLB9gY4eJRwpyhRRIMILk/vv40mRBDbip9mcDWrMryQNBSRIO/Xw3SwTAUDesZ1ubijtMpmC2s1ZlGlxs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786484597;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=HLsTIc9JfSAzsAvmUET69mlJyKvP0OeN/tZxOutSzA0=; 
 b=Iwjx9gpASuvUBJ7wWXOcvFRzGi4//wNpbqxT0aqttp6kawUfDdOHF/pikC3iTsR9jBC8gOw+CwbJqhudpmJ7l0YHSkiuBAa8AOsfy+bzJIjKe81zB9Xprumx+TJtAwVTDAyqrU+ayM222BMyocLiYTRn5yQwfYeRnLLq+O/VUOQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786484597; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=HLsTIc9JfSAzsAvmUET69mlJyKvP0OeN/tZxOutSzA0=;
 b=XlpNFFKcQP5dSgI+4kh5FrGjyhBo0JdjxGfrD0QKS/+cM7pkVNExe4joZ/jXa3Qe
 wN1M7Y/49OBUrZtTRrdoiKGNivbJfd9JbaDaCO2Okj8T2JRuxReAX5JLEoNZbSdqZDU
 NPB0Se8+DZ8Ef+VU0MdIk0b1pyXyuxJ0avpQK12k=
Received: by mx.zohomail.com with SMTPS id 1786484594946195.06879384466333;
 Tue, 11 Aug 2026 14:43:14 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Tue, 11 Aug 2026 22:42:19 +0100
Subject: [PATCH v5 10/11] drm/panfrost: Fix races between perfcnt and reset
 sequence
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260811-claude-fixes-v5-10-3d692c9e98c2@collabora.com>
References: <20260811-claude-fixes-v5-0-3d692c9e98c2@collabora.com>
In-Reply-To: <20260811-claude-fixes-v5-0-3d692c9e98c2@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=13366;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=mfN1IbtfhlWpuSwaADCXDdwVC39lESIzPQKiTGDMRkw=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqe5czltpB8JDVVAZY5r9skHGj4ygCQ9y2tmJXB
 doRWn/JNz6JAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCanuXMwAKCRAOJn5M7lND
 PViwC/9MdB5IOb49oYQylpeSZsr++nUOnpnqfyGyJKk+YjFI1aqfhgHYbCHFpb/Ni2jUIMd42fc
 MzvIDeD7Km4TeQHli5cXto2e94diZgQWqHTSQ9H9/IMLM6QuZcjWvpLIDweH9bZuKByA2D6llkp
 t4X0gl057RaBgvldJUFXCX2MiLhV7/LXLOHt1lDGwfNxR3VLne1myJjx39GvUQ1s/oDVHsyyiI9
 1CnlzqSNDswNRljPsNx9+PAa6by+gfnZzerQzwUhlDmMnQhSS/WYQ+azTlBeTsvpyLXh1LdfVDR
 09Q6EtXdwW0AfYyN3L19CBeIzzUhk4CJDbqbWqQj1WWS0K15lI0RN3iLTLdQRCCNuxHjMyyjCZt
 T2k9gRH+uTIUr59LdL5Z2AYquHm181r+zUs6VUhy7f31L+4hS+1ZUtAakT2He5yoN/K4GDdxV+r
 ABVZwfwPiiKKBga0wRnYg3B5j+FbbvOsYFZbRWoGCWVLNmD0ExEfFBh+Fs0gslNWYRxf0=
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
 drivers/gpu/drm/panfrost/panfrost_device.c  |   9 +-
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 220 ++++++++++++++++++++--------
 drivers/gpu/drm/panfrost/panfrost_perfcnt.h |   2 +
 include/uapi/drm/panfrost_drm.h             |   3 +-
 4 files changed, 171 insertions(+), 63 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index e0390b6c0d22..c81d8ca67ae4 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -602,14 +602,21 @@ bool panfrost_exception_needs_reset(const struct panfrost_device *pfdev,
 
 void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_job_int)
 {
-	guard(rwsem_read)(&pfdev->reset.lock);
+	guard(rwsem_write)(&pfdev->reset.lock);
 
+	/* Pre-reset */
+	panfrost_perfcnt_reset(pfdev);
+
+	/* Do the actual device reset */
 	panfrost_gpu_soft_reset(pfdev);
 	panfrost_gpu_power_on(pfdev);
+
+	/* Post-reset */
 	panfrost_mmu_reset(pfdev);
 	panfrost_jm_reset_interrupts(pfdev);
 	if (enable_job_int)
 		panfrost_jm_enable_interrupts(pfdev);
+	panfrost_perfcnt_postreset(pfdev);
 }
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
index ad1156678e91..01d477f7fce0 100644
--- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
+++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
@@ -11,6 +11,7 @@
 #include <drm/drm_file.h>
 #include <drm/drm_gem_shmem_helper.h>
 #include <drm/panfrost_drm.h>
+#include <drm/drm_print.h>
 
 #include "panfrost_device.h"
 #include "panfrost_features.h"
@@ -25,14 +26,18 @@
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
+	bool reset_happened;
+	bool reset_failed;
 };
 
 static void panfrost_perfcnt_gpu_disable(struct panfrost_device *pfdev)
@@ -55,25 +60,93 @@ void panfrost_perfcnt_sample_done(struct panfrost_device *pfdev)
 	gpu_write(pfdev, GPU_CMD, GPU_CMD_CLEAN_CACHES);
 }
 
-static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev)
+static int panfrost_perfcnt_hw_enable(struct panfrost_device *pfdev)
 {
-	u64 gpuva;
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
+}
+
+static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev,
+					u64 *reset_happened)
+{
+	struct panfrost_perfcnt *perfcnt = pfdev->perfcnt;
+	u64 gpuva = perfcnt->mapping->mmnode.start << PAGE_SHIFT;
+	s64 retries = PERFCNT_DUMP_MAX_RETRIES;
 	int ret;
 
-	reinit_completion(&pfdev->perfcnt->dump_comp);
-	gpuva = pfdev->perfcnt->mapping->mmnode.start << PAGE_SHIFT;
-	gpu_write(pfdev, GPU_PERFCNT_BASE_LO, lower_32_bits(gpuva));
-	gpu_write(pfdev, GPU_PERFCNT_BASE_HI, upper_32_bits(gpuva));
-	gpu_write(pfdev, GPU_INT_CLEAR,
-		  GPU_IRQ_CLEAN_CACHES_COMPLETED |
-		  GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
-	gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_SAMPLE);
+dump_retry:
+	scoped_guard(rwsem_read, &pfdev->reset.lock) {
+		*reset_happened = perfcnt->reset_happened;
+		perfcnt->reset_happened = false;
+		if (perfcnt->reset_failed) {
+			ret = panfrost_perfcnt_hw_enable(pfdev);
+			if (ret)
+				return ret;
+			perfcnt->reset_failed = false;
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
 	ret = wait_for_completion_interruptible_timeout(&pfdev->perfcnt->dump_comp,
 							msecs_to_jiffies(1000));
-	if (!ret)
-		ret = -ETIMEDOUT;
-	else if (ret > 0)
-		ret = 0;
+
+	scoped_guard(rwsem_read, &pfdev->reset.lock) {
+		if (ret > 0) {
+			if (perfcnt->reset_happened) {
+				if (--retries >= 0)
+					goto dump_retry;
+				else
+					ret = -EBUSY;
+			} else {
+				ret = 0;
+			}
+		} else if (!ret) {
+			ret = -ETIMEDOUT;
+		}
+	}
 
 	return ret;
 }
@@ -84,9 +157,8 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
 {
 	struct panfrost_file_priv *user = file_priv->driver_priv;
 	struct panfrost_perfcnt *perfcnt = pfdev->perfcnt;
-	struct iosys_map map;
 	struct drm_gem_shmem_object *bo;
-	u32 cfg, as;
+	struct iosys_map map;
 	int ret;
 
 	if (user == perfcnt->user)
@@ -119,7 +191,9 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
 	ret = drm_gem_vmap(&bo->base, &map);
 	if (ret)
 		goto err_put_mapping;
+
 	perfcnt->buf = map.vaddr;
+	perfcnt->counterset = counterset;
 
 	panfrost_gem_internal_set_label(&bo->base, "Perfcnt sample buffer");
 
@@ -127,60 +201,47 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
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
+		perfcnt->reset_happened = false;
+		perfcnt->user = user;
+	}
+
+	/*
+	 * If a reset happens during the wait for the IRQ notification that caches
+	 * are clean and invalidated, then we know the reset sequence did the job
+	 * for us, even if it takes long enough for the completion to time out.
+	 */
 	ret = wait_for_completion_timeout(&pfdev->perfcnt->dump_comp,
 					  msecs_to_jiffies(1000));
-	if (!ret) {
+	if (!ret && !perfcnt->reset_happened) {
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
+		if (!perfcnt->reset_happened || perfcnt->reset_failed) {
+			ret = panfrost_perfcnt_hw_enable(pfdev);
+			if (ret)
+				goto err_vunmap;
+		}
+		perfcnt->reset_happened = false;
+		perfcnt->reset_failed = false;
+	}
 
 	/* The BO ref is retained by the mapping. */
 	drm_gem_object_put(&bo->base);
 
-	perfcnt->user = user;
-
 	return 0;
 
 err_vunmap:
+	scoped_guard(rwsem_read, &pfdev->reset.lock)
+		perfcnt->user = NULL;
 	drm_gem_vunmap(&bo->base, &map);
 err_put_mapping:
 	panfrost_gem_mapping_put(perfcnt->mapping);
@@ -203,13 +264,15 @@ static int panfrost_perfcnt_disable_locked(struct panfrost_device *pfdev,
 	if (user != perfcnt->user)
 		return -EINVAL;
 
-	panfrost_perfcnt_gpu_disable(pfdev);
+	scoped_guard(rwsem_read, &pfdev->reset.lock) {
+		panfrost_perfcnt_gpu_disable(pfdev);
+		panfrost_mmu_as_put(pfdev, perfcnt->mapping->mmu);
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
@@ -263,7 +326,7 @@ int panfrost_ioctl_perfcnt_dump(struct drm_device *dev, void *data,
 		goto out;
 	}
 
-	ret = panfrost_perfcnt_dump_locked(pfdev);
+	ret = panfrost_perfcnt_dump_locked(pfdev, &req->hw_reset);
 	if (ret)
 		goto out;
 
@@ -346,3 +409,38 @@ void panfrost_perfcnt_fini(struct panfrost_device *pfdev)
 	/* Disable everything before leaving. */
 	panfrost_perfcnt_gpu_disable(pfdev);
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
+	perfcnt->reset_happened = true;
+	complete(&perfcnt->dump_comp);
+	panfrost_perfcnt_gpu_disable(pfdev);
+}
+
+void panfrost_perfcnt_postreset(struct panfrost_device *pfdev)
+{
+	struct panfrost_perfcnt *perfcnt = pfdev->perfcnt;
+	int ret;
+
+	if (drm_WARN_ON(&pfdev->base, !perfcnt))
+		return;
+
+	lockdep_assert_held(&pfdev->reset.lock);
+
+	if (!perfcnt->user)
+		return;
+
+	ret = panfrost_perfcnt_hw_enable(pfdev);
+	if (ret)
+		perfcnt->reset_failed = true;
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

