Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5F4606DA49
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RiDB9fTO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D990510E80F;
	Thu, 29 Oct 2026 13:37:05 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41DFE11229D
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:36:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2B08C422C4;
 Thu, 29 Oct 2026 13:36:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81B71F01825;
 Thu, 29 Oct 2026 13:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793280990;
 bh=4QT94RyaHPw6EM3Dp1dEOIctJpO/QfGuObnPzpqRrVM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=RiDB9fTOrSaRqHtFvF8kb8jvU0IuHbukl2G2LT6CLD0sEQGFYVhbPuMjMGjLL9qYG
 jkXa0Qapa3t3c4DqmlehcIMEw2Nj7TtFjIpYyAS37YHL+9eZg+WvrvWx4CO96BJbaq
 rkJQo9/6dnY5mJaBD4fqbkNU5jXKQhlTqSIVqAcBUQKCgMYGYep+D/xTEQ6iAZBU9h
 Rj1SiWwcUHXmCXUdQV/TtYPOfI0T+Ufsya846mNO4YMUAI6r+2KyTlbKY1m3S+4MrN
 gNgX9sg840kO/1ySI5+82Y8CAWpYX36CNFpqp2BCALE2IXtIW83OUL81XNHbG3ks/T
 3vf3adrWmFq3g==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 29 Oct 2026 08:35:57 -0500
Subject: [PATCH v4 10/31] accel: ethosu: Keep scheduler after unplug
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-ethosu-fixes-v4-10-4aa25e22578e@kernel.org>
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

Open DRM files retain scheduling entities after the device is unbound.
Defer scheduler teardown until the final DRM device reference is released.

Track open scheduling entities so removal can stop each entity and signal
the active job. Then leave the scheduler alive for postclose handling.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v4:
 - New patch
---
 drivers/accel/ethosu/ethosu_device.h |  4 ++
 drivers/accel/ethosu/ethosu_drv.c    | 12 ++---
 drivers/accel/ethosu/ethosu_drv.h    |  4 ++
 drivers/accel/ethosu/ethosu_job.c    | 98 +++++++++++++++++++++++++++++-------
 drivers/accel/ethosu/ethosu_job.h    |  5 +-
 5 files changed, 98 insertions(+), 25 deletions(-)

diff --git a/drivers/accel/ethosu/ethosu_device.h b/drivers/accel/ethosu/ethosu_device.h
index 51d5bc5d6137..1a90d0ebe5d9 100644
--- a/drivers/accel/ethosu/ethosu_device.h
+++ b/drivers/accel/ethosu/ethosu_device.h
@@ -6,6 +6,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
@@ -197,6 +198,8 @@ struct ethosu_device {
 	struct drm_ethosu_npu_info npu_info;
 
 	struct ethosu_job *in_flight_job;
+	/* Protects @in_flight_job. */
+	spinlock_t job_lock;
 
 	/* For dma_fence */
 	spinlock_t fence_lock;
@@ -204,6 +207,7 @@ struct ethosu_device {
 	struct drm_gpu_scheduler sched;
 	/* For ethosu_job_do_push() */
 	struct mutex sched_lock;
+	struct list_head sched_entities;
 	u64 fence_context;
 	u64 emit_seqno;
 
diff --git a/drivers/accel/ethosu/ethosu_drv.c b/drivers/accel/ethosu/ethosu_drv.c
index 91b2c2ab0a03..ee50e7db36ad 100644
--- a/drivers/accel/ethosu/ethosu_drv.c
+++ b/drivers/accel/ethosu/ethosu_drv.c
@@ -271,7 +271,7 @@ static int ethosu_device_resume(struct device *dev)
 	return ret;
 }
 
-static int ethosu_device_suspend(struct device *dev)
+int ethosu_device_suspend(struct device *dev)
 {
 	struct ethosu_device *ethosudev = dev_get_drvdata(dev);
 
@@ -377,7 +377,7 @@ static int ethosu_probe(struct platform_device *pdev)
 
 	ret = ethosu_init(ethosudev);
 	if (ret)
-		goto err_job_fini;
+		return ret;
 
 	ret = drm_dev_register(&ethosudev->base, 0);
 	if (ret)
@@ -389,20 +389,18 @@ static int ethosu_probe(struct platform_device *pdev)
 	if (ethosudev->sram)
 		gen_pool_free(ethosudev->srampool, (unsigned long)ethosudev->sram,
 			      ethosudev->npu_info.sram_size);
-err_job_fini:
-	ethosu_job_fini(ethosudev);
 	return ret;
 }
 
 static void ethosu_remove(struct platform_device *pdev)
 {
 	struct ethosu_device *ethosudev = dev_get_drvdata(&pdev->dev);
+	bool clocks_disabled;
 
 	drm_dev_unplug(&ethosudev->base);
-	ethosu_job_fini(ethosudev);
-
 	pm_runtime_barrier(&pdev->dev);
-	if (!pm_runtime_status_suspended(&pdev->dev))
+	clocks_disabled = ethosu_job_stop(ethosudev);
+	if (!clocks_disabled && !pm_runtime_status_suspended(&pdev->dev))
 		ethosu_device_suspend(&pdev->dev);
 
 	if (ethosudev->sram)
diff --git a/drivers/accel/ethosu/ethosu_drv.h b/drivers/accel/ethosu/ethosu_drv.h
index f59c845c758b..6d4ef8ce9378 100644
--- a/drivers/accel/ethosu/ethosu_drv.h
+++ b/drivers/accel/ethosu/ethosu_drv.h
@@ -4,18 +4,22 @@
 #define __ETHOSU_DRV_H__
 
 #include <linux/mutex.h>
+#include <linux/list.h>
 #include <linux/xarray.h>
 #include <drm/gpu_scheduler.h>
 
 struct ethosu_device;
+struct device;
 struct drm_device;
 struct drm_file;
 
 int ethosu_device_reset(struct ethosu_device *ethosudev);
+int ethosu_device_suspend(struct device *dev);
 
 struct ethosu_file_priv {
 	struct ethosu_device *edev;
 	struct drm_sched_entity sched_entity;
+	struct list_head sched_entity_list;
 	struct xarray perfmons;
 };
 
diff --git a/drivers/accel/ethosu/ethosu_job.c b/drivers/accel/ethosu/ethosu_job.c
index 8ffdc83d06f9..ef95a8abd61e 100644
--- a/drivers/accel/ethosu/ethosu_job.c
+++ b/drivers/accel/ethosu/ethosu_job.c
@@ -6,6 +6,7 @@
 #include <linux/genalloc.h>
 #include <linux/interrupt.h>
 #include <linux/iopoll.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 
@@ -13,6 +14,7 @@
 #include <drm/drm_drv.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_gem_dma_helper.h>
+#include <drm/drm_managed.h>
 #include <drm/drm_print.h>
 #include <drm/ethosu_accel.h>
 
@@ -149,6 +151,15 @@ static int ethosu_job_push(struct ethosu_job *job)
 
 	ret = pm_runtime_resume_and_get(job->dev->base.dev);
 	if (!ret) {
+		if (!try_module_get(THIS_MODULE)) {
+			pm_runtime_put_autosuspend(job->dev->base.dev);
+			ret = -ENODEV;
+			goto out;
+		}
+
+		drm_dev_get(&job->dev->base);
+		job->keep_device = true;
+
 		guard(mutex)(&job->dev->sched_lock);
 
 		drm_sched_job_arm(&job->base);
@@ -188,12 +199,19 @@ static void ethosu_job_cleanup(struct kref *ref)
 {
 	struct ethosu_job *job = container_of(ref, struct ethosu_job,
 						refcount);
+	struct drm_device *ddev = &job->dev->base;
+	bool keep_device = job->keep_device;
 
 	pm_runtime_put_autosuspend(job->dev->base.dev);
 
 	dma_fence_put(job->inference_done_fence);
 
 	ethosu_job_err_cleanup(job);
+
+	if (keep_device) {
+		drm_dev_put(ddev);
+		module_put(THIS_MODULE);
+	}
 }
 
 static void ethosu_job_put(struct ethosu_job *job)
@@ -357,6 +375,8 @@ static const struct drm_sched_backend_ops ethosu_sched_ops = {
 	.cancel_job = ethosu_job_cancel,
 };
 
+static void ethosu_job_fini(struct drm_device *ddev, void *data);
+
 int ethosu_job_init(struct ethosu_device *edev)
 {
 	struct device *dev = edev->base.dev;
@@ -372,7 +392,20 @@ int ethosu_job_init(struct ethosu_device *edev)
 
 	spin_lock_init(&edev->fence_lock);
 	spin_lock_init(&edev->job_lock);
-	ret = devm_mutex_init(dev, &edev->sched_lock);
+	ret = drmm_mutex_init(&edev->base, &edev->sched_lock);
+	if (ret)
+		return ret;
+	INIT_LIST_HEAD(&edev->sched_entities);
+
+	edev->fence_context = dma_fence_context_alloc(1);
+
+	ret = drm_sched_init(&edev->sched, &args);
+	if (ret) {
+		dev_err(dev, "Failed to create scheduler: %d\n", ret);
+		return ret;
+	}
+
+	ret = drmm_add_action_or_reset(&edev->base, ethosu_job_fini, edev);
 	if (ret)
 		return ret;
 
@@ -388,45 +421,76 @@ int ethosu_job_init(struct ethosu_device *edev)
 	if (ret)
 		return ret;
 
-	edev->fence_context = dma_fence_context_alloc(1);
+	return 0;
+}
 
-	ret = drm_sched_init(&edev->sched, &args);
-	if (ret) {
-		dev_err(dev, "Failed to create scheduler: %d\n", ret);
-		return ret;
-	}
+static void ethosu_job_fini(struct drm_device *ddev, void *data)
+{
+	struct ethosu_device *dev = to_ethosu_device(ddev);
 
-	return 0;
+	(void)data;
+	drm_sched_fini(&dev->sched);
 }
 
-void ethosu_job_fini(struct ethosu_device *dev)
+bool ethosu_job_stop(struct ethosu_device *dev)
 {
+	struct ethosu_file_priv *priv;
+	struct ethosu_job *job;
+	bool clocks_disabled = false;
+
+	guard(mutex)(&dev->sched_lock);
 	drm_sched_wqueue_stop(&dev->sched);
+	disable_irq(dev->irq);
 	cancel_delayed_work_sync(&dev->sched.work_tdr);
 
-	if (READ_ONCE(dev->in_flight_job)) {
-		WRITE_ONCE(dev->in_flight_job, NULL);
-		ethosu_device_reset(dev);
+	scoped_guard(mutex, &dev->perfmon_state.lock)
+		ethosu_perfmon_stop_locked(dev, dev->perfmon_state.active, false);
+
+	list_for_each_entry(priv, &dev->sched_entities, sched_entity_list)
+		drm_sched_entity_kill(&priv->sched_entity);
+
+	job = ethosu_job_clear_in_flight(dev);
+	if (job && ethosu_device_reset(dev)) {
+		ethosu_device_suspend(dev->base.dev);
+		clocks_disabled = true;
 	}
 
-	synchronize_irq(dev->irq);
-	drm_sched_fini(&dev->sched);
+	if (job)
+		ethosu_job_cancel(&job->base);
+
+	/* Let drm-sched release the cancelled in-flight job. */
+	drm_sched_wqueue_start(&dev->sched);
+	flush_work(&dev->sched.work_free_job);
+	drm_sched_wqueue_stop(&dev->sched);
+
+	return clocks_disabled;
 }
 
 int ethosu_job_open(struct ethosu_file_priv *ethosu_priv)
 {
 	struct ethosu_device *dev = ethosu_priv->edev;
 	struct drm_gpu_scheduler *sched = &dev->sched;
+	int ret;
 
-	return drm_sched_entity_init(&ethosu_priv->sched_entity,
-				     DRM_SCHED_PRIORITY_NORMAL,
-				     &sched, 1, NULL);
+	guard(mutex)(&dev->sched_lock);
+	ret = drm_sched_entity_init(&ethosu_priv->sched_entity,
+				    DRM_SCHED_PRIORITY_NORMAL,
+				    &sched, 1, NULL);
+	if (!ret)
+		list_add(&ethosu_priv->sched_entity_list, &dev->sched_entities);
+
+	return ret;
 }
 
 void ethosu_job_close(struct ethosu_file_priv *ethosu_priv)
 {
+	struct ethosu_device *dev = ethosu_priv->edev;
 	struct drm_sched_entity *entity = &ethosu_priv->sched_entity;
 
+	scoped_guard(mutex, &dev->sched_lock) {
+		drm_sched_entity_kill(entity);
+		list_del(&ethosu_priv->sched_entity_list);
+	}
 	drm_sched_entity_destroy(entity);
 }
 
diff --git a/drivers/accel/ethosu/ethosu_job.h b/drivers/accel/ethosu/ethosu_job.h
index 8988edd00eed..6d4622dfac43 100644
--- a/drivers/accel/ethosu/ethosu_job.h
+++ b/drivers/accel/ethosu/ethosu_job.h
@@ -29,13 +29,16 @@ struct ethosu_job {
 	/* Fence to be signaled by IRQ handler when the job is complete. */
 	struct dma_fence *done_fence;
 
+	/* Keep driver state alive while a killed job waits on dependencies. */
+	bool keep_device;
+
 	struct kref refcount;
 };
 
 int ethosu_ioctl_submit(struct drm_device *dev, void *data, struct drm_file *file);
 
 int ethosu_job_init(struct ethosu_device *dev);
-void ethosu_job_fini(struct ethosu_device *dev);
+bool ethosu_job_stop(struct ethosu_device *dev);
 int ethosu_job_open(struct ethosu_file_priv *ethosu_priv);
 void ethosu_job_close(struct ethosu_file_priv *ethosu_priv);
 

-- 
2.53.0

