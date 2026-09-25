Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F08C98321
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 18:47:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34CD110FC17;
	Fri, 25 Sep 2026 18:47:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="iuk+Xlrw";
	dkim-atps=neutral
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C376D10FC17
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 18:47:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790362020; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=LzrcidUfvPu7Z3MD2iyQGh9G1jj0J7e5NQikBfmE0Gg8D4N9eaJgEjjEmO1+NvOw8zFCqlBkB0jtcO0qga2U2oQTOmGpkd0IYSuB1yPIJ/m/gTLVP5J+9i+fTh7C54U/O6u4oEl6wDU6jp4nk0+HFyC/GIPtm9QLfYTPgs70WWw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790362020;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=2j/XDEQYBQPWvnF+R0015ux6PTdOoccDGg4JPjjEpKE=; 
 b=dGOFnPp0zhlj8vg70v4PlKQy8rcObJOd9pq+iYeN+cUmu79n6zsamEhcSkmXFw4ucHIv0rE5BZI9sAsNEO+ogeg0ibI8DMhU2un0nSoyMyKtwb1qQjaVZJVa7ULW2RN+YIjcVjbPUQtI6/el+akJmPl0eGZH6W+kZzh8QcOU+68=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790362020; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=2j/XDEQYBQPWvnF+R0015ux6PTdOoccDGg4JPjjEpKE=;
 b=iuk+XlrwcipyOuF6t0qWAQgptvIJP8mEqwYnJVzF9MNEY5m7D6srGgSRJhYenwjB
 2/gOU4vjRqVU52IyFB0128a1e+bZhT4MiaK5gXyDS+/AwXOeGfqYceLB4aG6u6rd7gf
 GLSb/PhfodfzyG1S9l+C5XYGv8rskQl5hcqCFdjg=
Received: by smtp.zohomail.com with SMTPS id 1790362019971733.6308922549051;
 Fri, 25 Sep 2026 11:46:59 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Fri, 25 Sep 2026 19:45:36 +0100
Subject: [PATCH v11 15/15] drm/panfrost: Fix races between perfcnt and
 reset sequence
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260925-claude-fixes-v11-15-0dbf5a58e7ce@collabora.com>
References: <20260925-claude-fixes-v11-0-0dbf5a58e7ce@collabora.com>
In-Reply-To: <20260925-claude-fixes-v11-0-0dbf5a58e7ce@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=17148;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=rHn+SUNSdVHN6V4P0XZnyv78wrYj+JjOWLWbT77mX9w=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqtsFEvHrfuljkf/oxOyJkWn9Xg3AtJVlTygWYp
 9vq+z+qkm+JAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCarbBRAAKCRAOJn5M7lND
 PQs2C/wNU7k+llD2kgp6dwq3/lV3JB7xM+M8hVEUsm/O0lvj2gmahFt8w1BHs53WqSnHVcSEJNb
 De9DP/o8CqpVfEh6arDVBaK9YdEO1e+ne8/hjjX9jvCEeWLE+EElkPyY6G1u/Pywino4TXWI4ZN
 Z3Wl7OPKJ1hB0zr+sRxen1RMcRJYLokwYkdX9st5ojxtwErysrgoBbhIkxgXhh827pmSVI2zxPI
 o8lvdAlcn/+6+zofhVFFxu9nqoTVTKoZm83M/P1z+rHKfEXLxbwMyFH/K47i51ty6E7JcWvI8+9
 kOc+i8WIoiUFVzM6f+6y9U8K1GCne836w+ZgmRuIrhHH8xHwH8qdlmdI7tQzHAGp/GPLpHeIfTy
 Sm1gc9do2c0Ex61tfGpg8y39jgzmLURMcEoupaqyTkGAF+ufCOSk5Q8M1QCIq7rJmi7a/BuKwFL
 4b+RJRV04Hdn5IXEuuZu2YrSj43rvR87OGnnpb7yfP9I2IO33MFr1RYzOpmCiXmjZrrms=
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

Fixes: 73e467f60acd ("drm/panfrost: Consolidate reset handling")
Fixes: 7786fd108777 ("drm/panfrost: Expose performance counters through unstable ioctls")
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c  |   2 +
 drivers/gpu/drm/panfrost/panfrost_drv.c     |   3 +-
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 261 +++++++++++++++++++---------
 drivers/gpu/drm/panfrost/panfrost_perfcnt.h |   1 +
 include/uapi/drm/panfrost_drm.h             |  29 +++-
 5 files changed, 213 insertions(+), 83 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 0cbd25607fb9..3e46c75ada99 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -488,6 +488,8 @@ void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_job_int)
 	panfrost_jm_reset_interrupts(pfdev);
 	if (enable_job_int)
 		panfrost_jm_enable_interrupts(pfdev);
+
+	panfrost_perfcnt_reset(pfdev);
 }
 
 static int panfrost_device_runtime_resume(struct device *dev)
diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 571a26b84126..de9b1c115181 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -808,6 +808,7 @@ static const struct file_operations panfrost_drm_driver_fops = {
  * - 1.6 - adds PANFROST_BO_MAP_WB, PANFROST_IOCTL_SYNC_BO,
  *	   PANFROST_IOCTL_QUERY_BO_INFO and
  *	   DRM_PANFROST_PARAM_SELECTED_COHERENCY
+ * - 1.7 - adds PERFCNT_DUMP req state field
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
index b3f71d7fd82a..96c3c41cd269 100644
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
@@ -58,44 +70,154 @@ void panfrost_perfcnt_sample_done(struct panfrost_device *pfdev)
 		complete(&pfdev->perfcnt->dump_comp);
 }
 
-static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev)
+static int panfrost_perfcnt_hw_enable(struct panfrost_device *pfdev)
+{
+	struct panfrost_perfcnt *perfcnt = pfdev->perfcnt;
+	u32 cfg, as;
+	int ret;
+
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
+	/* A reset might come through in the gap between the completion returning and the following
+	 * check, but because no sample was produced, we don't care to relay the state back to UM.
+	 */
 	if (!ret)
-		ret = -ETIMEDOUT;
-	else if (ret > 0)
+		return -ETIMEDOUT;
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
+
+		/* Only when we know no re-eanble or re-dump is required, we can afford
+		 * to reset the internal state. Otherwise it must be kept so that later
+		 * ioctls know about error situations in this DUMP and work around it.
+		 */
+		perfcnt->state = 0;
+	}
+
+	if (ret > 0)
 		ret = 0;
 
 	return ret;
 }
 
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
 
-	if (user == perfcnt->user)
-		return 0;
-	else if (perfcnt->user)
-		return -EBUSY;
+	if (perfcnt->user) {
+		if (perfcnt->user != user)
+			return -EBUSY;
+
+		if (perfcnt->state & PANFROST_PERFCNT_SESSION_DEAD)
+			drm_WARN_ON(&pfdev->base,
+				    panfrost_perfcnt_disable_locked(pfdev, file_priv));
+	}
 
 	ret = pm_runtime_get_sync(pfdev->base.dev);
 	if (ret < 0)
@@ -122,54 +244,30 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
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
@@ -185,30 +283,6 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
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
@@ -249,13 +323,16 @@ int panfrost_ioctl_perfcnt_dump(struct drm_device *dev, void *data,
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
 
@@ -338,3 +415,25 @@ void panfrost_perfcnt_fini(struct panfrost_device *pfdev)
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

