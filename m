Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454B5606A324
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mfd6s3A6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9246810E7FC;
	Thu, 29 Oct 2026 13:37:37 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0325A1122B0
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:36:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E0E8042D9D;
 Thu, 29 Oct 2026 13:36:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8182B1F01825;
 Thu, 29 Oct 2026 13:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793280988;
 bh=UY96nz1SrOKc6lMTmgOl71KWjiRDeKiEX/i+sjoZhIo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Mfd6s3A6KjtX8WcXOWYoI7Ic2lPyFMxOnsJdvhqJUKIEKd7oMZ++A0c7UOTXVpSJO
 05ZDKnoAtXKszoPXQiDBWMhDPcfXj6XY0ADAufoUeknj+G6UL9NDwTRg/DtpsVtEgQ
 d1MS20WXdIbgr+E0X/zU+D+K7BUCGRkfJCQDxuzkCwShkHInvtmOxZ5aDaw7FzC5r6
 zhcfLpgmollfB9hVT2rLjo7Tib2W+TVgQso71BTaTcy6QRmqivDRzsZN5Czqvs+fCf
 sjIK2pzGE3/zU0/UWwQbFo35guqNDHqRvXXDoi1VozLaiLDyIgFJJ4hMeRM9WkqwHE
 OK2LR2NWjbpwQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 29 Oct 2026 08:35:56 -0500
Subject: [PATCH v4 09/31] accel: ethosu: Guard operations after unplug
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-ethosu-fixes-v4-9-4aa25e22578e@kernel.org>
References: <20261029-ethosu-fixes-v4-0-4aa25e22578e@kernel.org>
In-Reply-To: <20261029-ethosu-fixes-v4-0-4aa25e22578e@kernel.org>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16-dev
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

drm_dev_is_unplugged() only checks the device state and can race with
removal. Use drm_dev_enter() around open and all private operations which
access driver state, and use drm_dev_unplug() during removal to wait for
them to complete.

Drop the drm_dev_enter() from the BO wait ioctl as that could
unnecessarily delay stopping the scheduler by waiting on a BO fence
signal timeout.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v4:
 - New patch
---
 drivers/accel/ethosu/ethosu_drv.c     |  28 ++++----
 drivers/accel/ethosu/ethosu_job.c     |  21 ++++--
 drivers/accel/ethosu/ethosu_perfmon.c | 117 ++++++++++++++++++++++------------
 3 files changed, 107 insertions(+), 59 deletions(-)

diff --git a/drivers/accel/ethosu/ethosu_drv.c b/drivers/accel/ethosu/ethosu_drv.c
index 6875ed17a004..91b2c2ab0a03 100644
--- a/drivers/accel/ethosu/ethosu_drv.c
+++ b/drivers/accel/ethosu/ethosu_drv.c
@@ -80,19 +80,12 @@ static int ethosu_ioctl_bo_wait(struct drm_device *ddev, void *data,
 				struct drm_file *file)
 {
 	struct drm_ethosu_bo_wait *args = data;
-	int cookie, ret;
 	unsigned long timeout = drm_timeout_abs_to_jiffies(args->timeout_ns);
 
 	if (args->pad)
 		return -EINVAL;
 
-	if (!drm_dev_enter(ddev, &cookie))
-		return -ENODEV;
-
-	ret = drm_gem_dma_resv_wait(file, args->handle, true, timeout);
-
-	drm_dev_exit(cookie);
-	return ret;
+	return drm_gem_dma_resv_wait(file, args->handle, true, timeout);
 }
 
 static int ethosu_ioctl_bo_mmap_offset(struct drm_device *ddev, void *data,
@@ -139,27 +132,34 @@ static int ethosu_ioctl_cmdstream_bo_create(struct drm_device *ddev, void *data,
 
 static int ethosu_open(struct drm_device *ddev, struct drm_file *file)
 {
-	int ret = 0;
+	struct ethosu_file_priv __free(kfree) * priv = NULL;
+	int cookie, ret;
 
 	if (!try_module_get(THIS_MODULE))
 		return -EINVAL;
+	if (!drm_dev_enter(ddev, &cookie)) {
+		module_put(THIS_MODULE);
+		return -ENODEV;
+	}
 
-	struct ethosu_file_priv __free(kfree) *priv = kzalloc_obj(*priv);
+	priv = kzalloc_obj(*priv);
 	if (!priv) {
 		ret = -ENOMEM;
-		goto err_put_mod;
+		goto err_dev_exit;
 	}
 	priv->edev = to_ethosu_device(ddev);
 
 	ret = ethosu_job_open(priv);
 	if (ret)
-		goto err_put_mod;
+		goto err_dev_exit;
 
 	ethosu_perfmon_open_file(priv);
 	file->driver_priv = no_free_ptr(priv);
+	drm_dev_exit(cookie);
 	return 0;
 
-err_put_mod:
+err_dev_exit:
+	drm_dev_exit(cookie);
 	module_put(THIS_MODULE);
 	return ret;
 }
@@ -398,7 +398,7 @@ static void ethosu_remove(struct platform_device *pdev)
 {
 	struct ethosu_device *ethosudev = dev_get_drvdata(&pdev->dev);
 
-	drm_dev_unregister(&ethosudev->base);
+	drm_dev_unplug(&ethosudev->base);
 	ethosu_job_fini(ethosudev);
 
 	pm_runtime_barrier(&pdev->dev);
diff --git a/drivers/accel/ethosu/ethosu_job.c b/drivers/accel/ethosu/ethosu_job.c
index f22cacb19e3d..8ffdc83d06f9 100644
--- a/drivers/accel/ethosu/ethosu_job.c
+++ b/drivers/accel/ethosu/ethosu_job.c
@@ -10,6 +10,7 @@
 #include <linux/pm_runtime.h>
 
 #include <drm/drm_file.h>
+#include <drm/drm_drv.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_gem_dma_helper.h>
 #include <drm/drm_print.h>
@@ -557,26 +558,34 @@ static int ethosu_ioctl_submit_job(struct drm_device *dev, struct drm_file *file
 int ethosu_ioctl_submit(struct drm_device *dev, void *data, struct drm_file *file)
 {
 	struct drm_ethosu_submit *args = data;
-	int ret = 0;
+	int cookie, ret = 0;
 	unsigned int i = 0;
 
+	if (!drm_dev_enter(dev, &cookie))
+		return -ENODEV;
+
 	struct drm_ethosu_job __free(kvfree) *jobs =
 		kvmalloc_objs(*jobs, args->job_count);
-	if (!jobs)
-		return -ENOMEM;
+	if (!jobs) {
+		ret = -ENOMEM;
+		goto out_dev_exit;
+	}
 
 	if (copy_from_user(jobs,
 			   (void __user *)(uintptr_t)args->jobs,
 			   args->job_count * sizeof(*jobs))) {
 		drm_dbg(dev, "Failed to copy incoming job array\n");
-		return -EFAULT;
+		ret = -EFAULT;
+		goto out_dev_exit;
 	}
 
 	for (i = 0; i < args->job_count; i++) {
 		ret = ethosu_ioctl_submit_job(dev, file, &jobs[i], args->perfmon_id);
 		if (ret)
-			return ret;
+			goto out_dev_exit;
 	}
 
-	return 0;
+out_dev_exit:
+	drm_dev_exit(cookie);
+	return ret;
 }
diff --git a/drivers/accel/ethosu/ethosu_perfmon.c b/drivers/accel/ethosu/ethosu_perfmon.c
index 2a9b3cc1447b..8d3635ba3347 100644
--- a/drivers/accel/ethosu/ethosu_perfmon.c
+++ b/drivers/accel/ethosu/ethosu_perfmon.c
@@ -10,6 +10,7 @@
 #include <linux/uaccess.h>
 
 #include <drm/drm_file.h>
+#include <drm/drm_drv.h>
 #include <drm/drm_ioctl.h>
 
 #include <uapi/drm/ethosu_accel.h>
@@ -162,27 +163,36 @@ int ethosu_ioctl_perfmon_create(struct drm_device *dev, void *data,
 	struct ethosu_device *ethosu = to_ethosu_device(dev);
 	struct ethosu_perfmon *perfmon;
 	unsigned int i, event_max;
-	int ret;
+	int cookie, ret;
 	u32 id;
 
+	if (!drm_dev_enter(dev, &cookie))
+		return -ENODEV;
+
 	/* Number of monitored counters cannot exceed HW or UAPI limits. */
 	if (req->ncounters > ethosu->npu_info.pmu_counters ||
-	    req->ncounters > DRM_ETHOSU_MAX_PERF_EVENT_COUNTERS)
-		return -EINVAL;
+	    req->ncounters > DRM_ETHOSU_MAX_PERF_EVENT_COUNTERS) {
+		ret = -EINVAL;
+		goto out_dev_exit;
+	}
 
 	/* Make sure all counters are valid. */
 	event_max = ethosu_is_u65(ethosu) ? 433 : 671;
 	for (i = 0; i < req->ncounters; i++) {
-		if (req->counters[i] > event_max)
-			return -EINVAL;
+		if (req->counters[i] > event_max) {
+			ret = -EINVAL;
+			goto out_dev_exit;
+		}
 	}
 
 	/* Add 1 more counter for cycle counter */
 	req->ncounters++;
 
 	perfmon = kzalloc_flex(*perfmon, values, req->ncounters);
-	if (!perfmon)
-		return -ENOMEM;
+	if (!perfmon) {
+		ret = -ENOMEM;
+		goto out_dev_exit;
+	}
 
 	for (i = 0; i < req->ncounters - 1; i++)
 		perfmon->counters[i] = req->counters[i];
@@ -196,12 +206,14 @@ int ethosu_ioctl_perfmon_create(struct drm_device *dev, void *data,
 
 	if (ret < 0) {
 		kfree(perfmon);
-		return ret;
+		goto out_dev_exit;
 	}
 
 	req->id = id;
 
-	return 0;
+out_dev_exit:
+	drm_dev_exit(cookie);
+	return ret;
 }
 
 int ethosu_ioctl_perfmon_destroy(struct drm_device *dev, void *data,
@@ -210,14 +222,22 @@ int ethosu_ioctl_perfmon_destroy(struct drm_device *dev, void *data,
 	struct ethosu_file_priv *ethosu_priv = file_priv->driver_priv;
 	struct drm_ethosu_perfmon_destroy *req = data;
 	struct ethosu_perfmon *perfmon;
+	int cookie, ret = 0;
+
+	if (!drm_dev_enter(dev, &cookie))
+		return -ENODEV;
 
 	perfmon = xa_erase(&ethosu_priv->perfmons, req->id);
-	if (!perfmon)
-		return -EINVAL;
+	if (!perfmon) {
+		ret = -EINVAL;
+		goto out_dev_exit;
+	}
 
 	ethosu_perfmon_delete(ethosu_priv, perfmon);
 
-	return 0;
+out_dev_exit:
+	drm_dev_exit(cookie);
+	return ret;
 }
 
 int ethosu_ioctl_perfmon_get_values(struct drm_device *dev, void *data,
@@ -227,19 +247,26 @@ int ethosu_ioctl_perfmon_get_values(struct drm_device *dev, void *data,
 	struct ethosu_file_priv *ethosu_priv = file_priv->driver_priv;
 	struct drm_ethosu_perfmon_get_values *req = data;
 	struct ethosu_perfmon *perfmon;
-	int ret = 0;
+	int cookie, ret = 0;
 
-	if (req->pad != 0)
-		return -EINVAL;
+	if (!drm_dev_enter(dev, &cookie))
+		return -ENODEV;
+
+	if (req->pad != 0) {
+		ret = -EINVAL;
+		goto out_dev_exit;
+	}
 
 	perfmon = ethosu_perfmon_find(ethosu_priv, req->id);
-	if (!perfmon)
-		return -EINVAL;
+	if (!perfmon) {
+		ret = -EINVAL;
+		goto out_dev_exit;
+	}
 
 	ret = pm_runtime_resume_and_get(dev->dev);
 	if (ret) {
 		ethosu_perfmon_put(perfmon);
-		return ret;
+		goto out_dev_exit;
 	}
 	ethosu_perfmon_stop(ethosu, perfmon, true);
 
@@ -251,6 +278,8 @@ int ethosu_ioctl_perfmon_get_values(struct drm_device *dev, void *data,
 
 	ethosu_perfmon_put(perfmon);
 
+out_dev_exit:
+	drm_dev_exit(cookie);
 	return ret;
 }
 
@@ -260,44 +289,54 @@ int ethosu_ioctl_perfmon_set_global(struct drm_device *dev, void *data,
 	struct ethosu_file_priv *ethosu_priv = file_priv->driver_priv;
 	struct drm_ethosu_perfmon_set_global *req = data;
 	struct ethosu_device *ethosu = to_ethosu_device(dev);
-	struct ethosu_perfmon *perfmon;
+	struct ethosu_perfmon *old = NULL, *perfmon;
+	int cookie, ret = 0;
 
-	if (req->flags & ~DRM_ETHOSU_PERFMON_CLEAR_GLOBAL)
-		return -EINVAL;
+	if (!drm_dev_enter(dev, &cookie))
+		return -ENODEV;
+
+	if (req->flags & ~DRM_ETHOSU_PERFMON_CLEAR_GLOBAL) {
+		ret = -EINVAL;
+		goto out_dev_exit;
+	}
 
 	perfmon = ethosu_perfmon_find(ethosu_priv, req->id);
-	if (!perfmon)
-		return -EINVAL;
+	if (!perfmon) {
+		ret = -EINVAL;
+		goto out_dev_exit;
+	}
 
 	/* If the request is to clear the global performance monitor */
 	if (req->flags & DRM_ETHOSU_PERFMON_CLEAR_GLOBAL) {
-		struct ethosu_perfmon *old;
-
 		scoped_guard(mutex, &ethosu->perfmon_state.lock) {
 			old = ethosu->global_perfmon;
-			if (!old) {
-				ethosu_perfmon_put(perfmon);
-				return -EINVAL;
+			if (old) {
+				ethosu->global_perfmon = NULL;
+				ethosu_perfmon_stop_locked(ethosu, old, true);
 			}
+		}
 
-			ethosu->global_perfmon = NULL;
-			ethosu_perfmon_stop_locked(ethosu, old, true);
+		ethosu_perfmon_put(perfmon);
+		if (!old) {
+			ret = -EINVAL;
+			goto out_dev_exit;
 		}
 
 		ethosu_perfmon_put(old);
-		ethosu_perfmon_put(perfmon);
 
-		return 0;
+		goto out_dev_exit;
 	}
 
 	scoped_guard(mutex, &ethosu->perfmon_state.lock) {
-		if (ethosu->perfmon_state.active || ethosu->global_perfmon) {
-			ethosu_perfmon_put(perfmon);
-			return -EBUSY;
-		}
-
-		ethosu->global_perfmon = perfmon;
+		if (ethosu->perfmon_state.active || ethosu->global_perfmon)
+			ret = -EBUSY;
+		else
+			ethosu->global_perfmon = perfmon;
 	}
+	if (ret)
+		ethosu_perfmon_put(perfmon);
 
-	return 0;
+out_dev_exit:
+	drm_dev_exit(cookie);
+	return ret;
 }

-- 
2.53.0

