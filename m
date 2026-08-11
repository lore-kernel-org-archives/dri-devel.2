Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68200C5CFDB
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 10:18:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B7E410EB29;
	Tue, 11 Aug 2026 10:18:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="fsbyNBaw";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6A4410E2C5
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 10:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1786443475;
 bh=TviPz1FlyvJV94lktEvYQlU3XjvzrR+5TgVN0dnYaaA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=fsbyNBawvhx9uVRd8WyNcZ1osgZw2bNt2CehNVtH78wW/c0U5Cj6gxTpRf+kmktcK
 bSFwHxptzipOHLYz2GVzRnj+SHnt3PANjRAQg4d8Uk8ktqpKJ5qzkm+eLRwVL6Un8o
 6UDDK25mA8TB++wC+JC8I9pml/RBl3rT5nL6SZOCoYVsiRg7xGldFXlioLUD7TRT7j
 t4zTS+si81aVgrTKz+oYj6RxxDO6GxWb6F3HeAVHZRHDKgLiaOrIeOZN6AGgcsBw0r
 9EXR/D6rx1R8WwXofhCRgohORE63D8zYNmYbbHZyqH8KHESQ5kjS6m12jPC4OVb752
 dLq6+XaAoxZWw==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 1B80D17E12A2;
 Tue, 11 Aug 2026 12:17:55 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Tue, 11 Aug 2026 12:17:49 +0200
Subject: [PATCH v2 15/17] drm/panthor: Fix the unplug logic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-panthor-unplug-fixes-v2-15-6b583e37f9ae@collabora.com>
References: <20260811-panthor-unplug-fixes-v2-0-6b583e37f9ae@collabora.com>
In-Reply-To: <20260811-panthor-unplug-fixes-v2-0-6b583e37f9ae@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786443467; l=25271;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=TviPz1FlyvJV94lktEvYQlU3XjvzrR+5TgVN0dnYaaA=;
 b=ib+33whB7cbiV9hSWrqP9tEX4FYjsvAVwH8+D3oniyLF1oh7G51r2abB6rJtzpL/KPCdTwD/P
 eFfghv+XcdtCmFDQ/ry2SGJUUCID3DUZbCCTSazcjaZEzNgOMukK5bE
X-Developer-Key: i=boris.brezillon@collabora.com; a=ed25519;
 pk=eN+ORdOgQY7d5U+0kA8h5bf67XdD8bhKbjD/TCHexSY=
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

The current unplug logic is broken in multiple subtle ways:

1. it assumes that the HW is still accessible in multiple places,
   which goes against the very concept of hot-unplug
2. it doesn't take into account the fact the stop is a failible
   operation, and that we theoretically have no guarantee that the HW
   is actually stopped after we've released the resources

Those issues are hard to reason about because Mali GPUs are on a
platform bus, which is not hot-pluggable, so they are in practice
always accessible as long as we can enable their dependencies (clocks,
power-domain, ...). The problem is, if the GPU is in such a bad state
it can't properly reset/resume, there are various operations that can't
be done properly, and the unplug logic is clearly not ready for that.
And more importantly, if we can't guarantee the reset was effective,
we have to assume the HW still has access to the resource we passed to
it, meaning we can't return these resources to the system without
risking a UAF.

This patch does several things:

- it resets the GPU before calling the <component>_unplug() functions
- it drops the pm_get/put that around the sub-component unplug calls
  (no longer needed if we assume the HW is gone and can't be accessed
  anymore)
- it changes the _unplug() implementations to not touch the HW anymore
- it let's each component know whether it should leak resources the HW
  might have its hands on at the time the unplug happens
- it releases all resources at unplug time even if open FDs exist. This
  is needed otherwise we could have deferred cleanup work accessing
  objects that have been freed

Unfortunately, I couldn't find a way to break things into multiple
commits while preserving bisectability.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_device.c |  45 +++++++++---
 drivers/gpu/drm/panthor/panthor_device.h |  15 ++++
 drivers/gpu/drm/panthor/panthor_drv.c    | 114 ++++++++++++++++++++++++-------
 drivers/gpu/drm/panthor/panthor_fw.c     |   9 +--
 drivers/gpu/drm/panthor/panthor_mmu.c    |  96 +++++++++++++++++++++-----
 drivers/gpu/drm/panthor/panthor_mmu.h    |   1 +
 drivers/gpu/drm/panthor/panthor_sched.c  |  83 +++++++++++++++++++++-
 7 files changed, 301 insertions(+), 62 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index d9eab6021145..d037c89e6198 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -62,8 +62,34 @@ static int panthor_init_power(struct device *dev)
 	return devm_pm_domain_attach_list(dev, NULL, &pd_list);
 }
 
+static int panthor_device_stop_before_unplug(struct panthor_device *ptdev)
+{
+	int ret;
+
+	/* Make sure any further modification to the existing VMs are blocked
+	 * before proceeding with the SOFT_RESET.
+	 */
+	panthor_mmu_freeze_before_unplug(ptdev);
+
+	/* Core clock should be enough to issue a reset. */
+	ret = clk_prepare_enable(ptdev->clks.core);
+	if (ret)
+		return ret;
+
+	/* A successful soft-reset should guarantee that all components of the
+	 * HW are off, meaning we can proceed with the rest of the unplug
+	 * procedure.
+	 */
+	ret = panthor_hw_soft_reset(ptdev);
+
+	clk_disable_unprepare(ptdev->clks.core);
+	return ret;
+}
+
 void panthor_device_unplug(struct panthor_device *ptdev)
 {
+	int ret;
+
 	/* This function can be called from two different path: the reset work
 	 * and the platform device remove callback. drm_dev_unplug() doesn't
 	 * deal with concurrent callers, so we have to protect drm_dev_unplug()
@@ -80,8 +106,6 @@ void panthor_device_unplug(struct panthor_device *ptdev)
 		return;
 	}
 
-	drm_WARN_ON(&ptdev->base, pm_runtime_get_sync(ptdev->base.dev) < 0);
-
 	/* Call drm_dev_unplug() so any access to HW blocks happening after
 	 * that point get rejected.
 	 */
@@ -102,6 +126,16 @@ void panthor_device_unplug(struct panthor_device *ptdev)
 	/* Make sure we're not interrupted by resets while we're unplugging. */
 	disable_work_sync(&ptdev->reset.work);
 
+	/* Do anything we can to stop the HW. If we can't guarantee that the HW
+	 * is fully stopped, we also can't guarantee the resources it had access
+	 * to won't be touched after the device is gone (clocks and regulators
+	 * can be shared, and the HW might still be running behind our back).
+	 */
+	ret = panthor_device_stop_before_unplug(ptdev);
+	if (drm_WARN(&ptdev->base, ret,
+		     "Couldn't stop the device, this might lead to resource leaks"))
+		ptdev->unplug.leak_active_resources = true;
+
 	/* Now, try to cleanly shutdown the GPU before the device resources
 	 * get reclaimed.
 	 */
@@ -112,13 +146,6 @@ void panthor_device_unplug(struct panthor_device *ptdev)
 	panthor_gpu_unplug(ptdev);
 	panthor_pwr_unplug(ptdev);
 
-	pm_runtime_dont_use_autosuspend(ptdev->base.dev);
-	pm_runtime_put_sync_suspend(ptdev->base.dev);
-
-	/* If PM is disabled, we need to call the suspend handler manually. */
-	if (!IS_ENABLED(CONFIG_PM))
-		panthor_device_suspend(ptdev->base.dev);
-
 	/* Report the unplug operation as done to unblock concurrent
 	 * panthor_device_unplug() callers.
 	 */
diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index 10c96abf9cff..8c9177cf5da2 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -267,6 +267,21 @@ struct panthor_device {
 
 		/** @work: Unplug work. */
 		struct work_struct work;
+
+		/**
+		 * @leak_active_resources: Sub-components should leak resources HW has
+		 * access to.
+		 *
+		 * This is set to true when we can guarantee the HW has been fully stopped
+		 * in the unplug path. In that case, we'd rather leak resource than return
+		 * them to the system with the risk that they might be accessed by the
+		 * HW behind our back.
+		 *
+		 * This is particularly important for any piece of memory used by the GPU
+		 * (MMU page tables, FW sections, group resources shared with the FW,
+		 * any BO attached to an active VM, ...).
+		 */
+		bool leak_active_resources;
 	} unplug;
 
 	/** @reset: Reset related fields. */
diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index 924a7ecd3733..bdbda7f5a8bd 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -1025,11 +1025,21 @@ static int panthor_ioctl_vm_destroy(struct drm_device *ddev, void *data,
 {
 	struct panthor_file *pfile = file->driver_priv;
 	struct drm_panthor_vm_destroy *args = data;
+	int cookie, ret;
 
-	if (args->pad)
-		return -EINVAL;
+	if (!drm_dev_enter(ddev, &cookie))
+		return -ENODEV;
 
-	return panthor_vm_pool_destroy_vm(pfile->vms, args->id);
+	if (args->pad) {
+		ret = -EINVAL;
+		goto out_dev_exit;
+	}
+
+	ret = panthor_vm_pool_destroy_vm(pfile->vms, args->id);
+
+out_dev_exit:
+	drm_dev_exit(cookie);
+	return ret;
 }
 
 #define PANTHOR_BO_FLAGS		(DRM_PANTHOR_BO_NO_MMAP | \
@@ -1219,11 +1229,21 @@ static int panthor_ioctl_group_destroy(struct drm_device *ddev, void *data,
 {
 	struct panthor_file *pfile = file->driver_priv;
 	struct drm_panthor_group_destroy *args = data;
+	int cookie, ret;
 
-	if (args->pad)
-		return -EINVAL;
+	if (!drm_dev_enter(ddev, &cookie))
+		return -ENODEV;
 
-	return panthor_group_destroy(pfile, args->group_handle);
+	if (args->pad) {
+		ret = -EINVAL;
+		goto out_dev_exit;
+	}
+
+	ret = panthor_group_destroy(pfile, args->group_handle);
+
+out_dev_exit:
+	drm_dev_exit(cookie);
+	return ret;
 }
 
 static int panthor_ioctl_group_create(struct drm_device *ddev, void *data,
@@ -1232,27 +1252,36 @@ static int panthor_ioctl_group_create(struct drm_device *ddev, void *data,
 	struct panthor_file *pfile = file->driver_priv;
 	struct drm_panthor_group_create *args = data;
 	struct drm_panthor_queue_create *queue_args;
-	int ret;
+	int cookie, ret;
 
-	if (!args->queues.count || args->queues.count > MAX_CS_PER_CSG)
-		return -EINVAL;
+	if (!drm_dev_enter(ddev, &cookie))
+		return -ENODEV;
+
+	if (!args->queues.count || args->queues.count > MAX_CS_PER_CSG) {
+		ret = -EINVAL;
+		goto out_dev_exit;
+	}
 
 	ret = PANTHOR_UOBJ_GET_ARRAY(queue_args, &args->queues);
 	if (ret)
-		return ret;
+		goto out_dev_exit;
 
 	ret = group_priority_permit(file, args->priority);
 	if (ret)
-		goto out;
+		goto out_free_args;
 
 	ret = panthor_group_create(pfile, args, queue_args, file->client_id);
 	if (ret < 0)
-		goto out;
+		goto out_free_args;
+
 	args->group_handle = ret;
 	ret = 0;
 
-out:
+out_free_args:
 	kvfree(queue_args);
+
+out_dev_exit:
+	drm_dev_exit(cookie);
 	return ret;
 }
 
@@ -1261,8 +1290,15 @@ static int panthor_ioctl_group_get_state(struct drm_device *ddev, void *data,
 {
 	struct panthor_file *pfile = file->driver_priv;
 	struct drm_panthor_group_get_state *args = data;
+	int cookie, ret;
 
-	return panthor_group_get_state(pfile, args);
+	if (!drm_dev_enter(ddev, &cookie))
+		return -ENODEV;
+
+	ret = panthor_group_get_state(pfile, args);
+
+	drm_dev_exit(cookie);
+	return ret;
 }
 
 static int panthor_ioctl_tiler_heap_create(struct drm_device *ddev, void *data,
@@ -1272,11 +1308,16 @@ static int panthor_ioctl_tiler_heap_create(struct drm_device *ddev, void *data,
 	struct drm_panthor_tiler_heap_create *args = data;
 	struct panthor_heap_pool *pool;
 	struct panthor_vm *vm;
-	int ret;
+	int cookie, ret;
+
+	if (!drm_dev_enter(ddev, &cookie))
+		return -ENODEV;
 
 	vm = panthor_vm_pool_get_vm(pfile->vms, args->vm_id);
-	if (!vm)
-		return -EINVAL;
+	if (!vm) {
+		ret = -EINVAL;
+		goto out_dev_exit;
+	}
 
 	pool = panthor_vm_get_heap_pool(vm, true);
 	if (IS_ERR(pool)) {
@@ -1305,6 +1346,9 @@ static int panthor_ioctl_tiler_heap_create(struct drm_device *ddev, void *data,
 
 out_put_vm:
 	panthor_vm_put(vm);
+
+out_dev_exit:
+	drm_dev_exit(cookie);
 	return ret;
 }
 
@@ -1315,14 +1359,21 @@ static int panthor_ioctl_tiler_heap_destroy(struct drm_device *ddev, void *data,
 	struct drm_panthor_tiler_heap_destroy *args = data;
 	struct panthor_heap_pool *pool;
 	struct panthor_vm *vm;
-	int ret;
+	int cookie, ret;
 
-	if (args->pad)
-		return -EINVAL;
+	if (!drm_dev_enter(ddev, &cookie))
+		return -ENODEV;
+
+	if (args->pad) {
+		ret = -EINVAL;
+		goto out_dev_exit;
+	}
 
 	vm = panthor_vm_pool_get_vm(pfile->vms, args->handle >> 16);
-	if (!vm)
-		return -EINVAL;
+	if (!vm) {
+		ret = -EINVAL;
+		goto out_dev_exit;
+	}
 
 	pool = panthor_vm_get_heap_pool(vm, false);
 	if (IS_ERR(pool)) {
@@ -1335,6 +1386,9 @@ static int panthor_ioctl_tiler_heap_destroy(struct drm_device *ddev, void *data,
 
 out_put_vm:
 	panthor_vm_put(vm);
+
+out_dev_exit:
+	drm_dev_exit(cookie);
 	return ret;
 }
 
@@ -1466,10 +1520,16 @@ static int panthor_ioctl_vm_get_state(struct drm_device *ddev, void *data,
 	struct panthor_file *pfile = file->driver_priv;
 	struct drm_panthor_vm_get_state *args = data;
 	struct panthor_vm *vm;
+	int cookie, ret;
+
+	if (!drm_dev_enter(ddev, &cookie))
+		return -ENODEV;
 
 	vm = panthor_vm_pool_get_vm(pfile->vms, args->vm_id);
-	if (!vm)
-		return -EINVAL;
+	if (!vm) {
+		ret = -EINVAL;
+		goto out_dev_exit;
+	}
 
 	if (panthor_vm_is_unusable(vm))
 		args->state = DRM_PANTHOR_VM_STATE_UNUSABLE;
@@ -1477,7 +1537,11 @@ static int panthor_ioctl_vm_get_state(struct drm_device *ddev, void *data,
 		args->state = DRM_PANTHOR_VM_STATE_USABLE;
 
 	panthor_vm_put(vm);
-	return 0;
+	ret = 0;
+
+out_dev_exit:
+	drm_dev_exit(cookie);
+	return ret;
 }
 
 static int panthor_ioctl_bo_set_label(struct drm_device *ddev, void *data,
diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index fc1a423e48a8..8d9fdc3202a1 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -1285,11 +1285,9 @@ void panthor_fw_unplug(struct panthor_device *ptdev)
 
 	disable_delayed_work_sync(&ptdev->fw->watchdog.ping_work);
 
-	if (!IS_ENABLED(CONFIG_PM) || pm_runtime_active(ptdev->base.dev)) {
-		/* Make sure the IRQ handler cannot be called after that point. */
+	/* Make sure the IRQ handler cannot be called after that point. */
+	if (!IS_ENABLED(CONFIG_PM) || pm_runtime_active(ptdev->base.dev))
 		panthor_job_irq_suspend(&ptdev->fw->irq);
-		panthor_fw_stop(ptdev);
-	}
 
 	list_for_each_entry(section, &ptdev->fw->sections, node)
 		panthor_kernel_bo_destroy(section->mem);
@@ -1301,9 +1299,6 @@ void panthor_fw_unplug(struct panthor_device *ptdev)
 	 */
 	panthor_vm_put(ptdev->fw->vm);
 	ptdev->fw->vm = NULL;
-
-	if (!IS_ENABLED(CONFIG_PM) || pm_runtime_active(ptdev->base.dev))
-		panthor_hw_l2_power_off(ptdev);
 }
 
 /**
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 5672d437d52d..56ca23580d21 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -1787,17 +1787,27 @@ panthor_vm_pool_get_vm(struct panthor_vm_pool *pool, u32 handle)
  */
 void panthor_vm_pool_destroy(struct panthor_file *pfile)
 {
+	struct panthor_device *ptdev = pfile->ptdev;
 	struct panthor_vm *vm;
 	unsigned long i;
+	int cookie;
 
 	if (!pfile->vms)
 		return;
 
-	xa_for_each(&pfile->vms->xa, i, vm)
-		panthor_vm_destroy(vm);
+	/* If device is gone VMs have been destroyed already, and the XArray
+	 * contains pointers to objects that have been freed.
+	 */
+	if (drm_dev_enter(&ptdev->base, &cookie)) {
+		xa_for_each(&pfile->vms->xa, i, vm)
+			panthor_vm_destroy(vm);
+
+		drm_dev_exit(cookie);
+	}
 
 	if (pfile->vms->dummy)
 		drm_gem_object_put(&pfile->vms->dummy->base);
+
 	xa_destroy(&pfile->vms->xa);
 	kfree(pfile->vms);
 }
@@ -2040,7 +2050,7 @@ void panthor_mmu_suspend(struct panthor_device *ptdev)
 	panthor_mmu_irq_suspend(&ptdev->mmu->irq);
 }
 
-static void mmu_post_reset_cleanup(struct panthor_device *ptdev)
+static void mmu_post_reset_cleanup(struct panthor_device *ptdev, bool on_unplug)
 {
 	guard(mutex)(&ptdev->mmu->as.slots_lock);
 
@@ -2058,11 +2068,12 @@ static void mmu_post_reset_cleanup(struct panthor_device *ptdev)
 
 		panthor_as_release_hw_slot_locked(as);
 
-		/* FIXME: We shouldn't drop the no-unmap restriction if
-		 * we're in the unplug path and the device wasn't properly
-		 * stopped with a SOFT_RESET.
+		/* If this is an unplug situation and leak_active_resources is
+		 * true, we have to keep the no-unmap restriction to force a
+		 * resource leak.
 		 */
-		atomic_and(~PANTHOR_AS_FORBID_UNMAP, &as->restrictions);
+		if (!on_unplug || !ptdev->unplug.leak_active_resources)
+			atomic_and(~PANTHOR_AS_FORBID_UNMAP, &as->restrictions);
 	}
 
 	if (!list_empty(&ptdev->mmu->as.cleanup_list))
@@ -2080,7 +2091,7 @@ static void mmu_post_reset_cleanup(struct panthor_device *ptdev)
  */
 void panthor_mmu_resume(struct panthor_device *ptdev)
 {
-	mmu_post_reset_cleanup(ptdev);
+	mmu_post_reset_cleanup(ptdev, false);
 	panthor_mmu_irq_resume(&ptdev->mmu->irq);
 }
 
@@ -2118,7 +2129,7 @@ void panthor_mmu_post_reset(struct panthor_device *ptdev)
 {
 	struct panthor_vm *vm;
 
-	mmu_post_reset_cleanup(ptdev);
+	mmu_post_reset_cleanup(ptdev, false);
 
 	panthor_mmu_irq_resume(&ptdev->mmu->irq);
 
@@ -2197,8 +2208,19 @@ static bool vm_prep_for_cleanup(struct panthor_vm *vm)
 	}
 
 	if (!drm_dev_enter(&ptdev->base, &cookie)) {
+		/* Device is gone, take the unplug lock to make sure
+		 * panthor_device_stop_before_unplug() has run and
+		 * ::leak_active_resources is valid.
+		 */
+		guard(mutex)(&ptdev->unplug.lock);
 		guard(mutex)(&ptdev->mmu->as.slots_lock);
 
+		/* If we're not asked to leak resources, drop the
+		 * no-unmap restriction.
+		 */
+		if (!ptdev->unplug.leak_active_resources)
+			atomic_and(~PANTHOR_AS_FORBID_UNMAP, &as->restrictions);
+
 		/* We're in the unplug path and can't recover from
 		 * that, so we just forcibly evict the pgtable. The
 		 * no-unmap restriction will leak resources if
@@ -3552,6 +3574,41 @@ panthor_mmu_reclaim_priv_bos(struct panthor_device *ptdev,
 	return freed;
 }
 
+void panthor_mmu_freeze_before_unplug(struct panthor_device *ptdev)
+{
+	struct panthor_vm *vm;
+
+	guard(mutex)(&ptdev->mmu->vm.lock);
+	guard(mutex)(&ptdev->mmu->as.slots_lock);
+	list_for_each_entry(vm, &ptdev->mmu->vm.list, node) {
+		/* We intentionally don't use panthor_vm_restrict_usage_locked() here
+		 * because we don't want the AS eviction to happen, otherwise we
+		 * won't be able to know which VMs were active at the time the
+		 * unplug happened. Unmap is forbidden to make sure any modification
+		 * to the VM is blocked after that point. This way, if the reset
+		 * fails, we're able to flag VMs that need to leak their resources.
+		 */
+		atomic_or(PANTHOR_AS_FORBID_USE |
+			  PANTHOR_AS_FORBID_MAP |
+			  PANTHOR_AS_FORBID_UNMAP,
+			  &vm->as->restrictions);
+	}
+}
+
+static struct panthor_vm *
+pop_user_owned_vm(struct panthor_device *ptdev)
+{
+	struct panthor_vm *vm;
+
+	guard(mutex)(&ptdev->mmu->vm.lock);
+	vm = list_first_entry_or_null(&ptdev->mmu->vm.user_owned,
+				      struct panthor_vm, user_node);
+	if (vm)
+		list_del_init(&vm->user_node);
+
+	return vm;
+}
+
 /**
  * panthor_mmu_unplug() - Unplug the MMU logic
  * @ptdev: Device.
@@ -3564,17 +3621,18 @@ void panthor_mmu_unplug(struct panthor_device *ptdev)
 	if (!IS_ENABLED(CONFIG_PM) || pm_runtime_active(ptdev->base.dev))
 		panthor_mmu_irq_suspend(&ptdev->mmu->irq);
 
-	mutex_lock(&ptdev->mmu->as.slots_lock);
-	for (u32 i = 0; i < ARRAY_SIZE(ptdev->mmu->as.slots); i++) {
-		struct panthor_as *as = ptdev->mmu->as.slots[i].as;
+	mmu_post_reset_cleanup(ptdev, true);
 
-		if (as) {
-			drm_WARN_ON(&ptdev->base,
-				    panthor_mmu_as_disable(ptdev, i, false));
-			panthor_as_release_hw_slot_locked(as);
-		}
+	/* Collect non-destroyed user VMs so we can return the ref owned by the
+	 * XArray. If we don't do that, we leak all user VMs that were still
+	 * alive at the point drm_dev_unplug() was called, because
+	 * panthor_ioctl_vm_destroy() bails out early if the device is
+	 * unplugged.
+	 */
+	for (struct panthor_vm *vm = pop_user_owned_vm(ptdev); vm;
+	     vm = pop_user_owned_vm(ptdev)) {
+		panthor_vm_destroy(vm);
 	}
-	mutex_unlock(&ptdev->mmu->as.slots_lock);
 
 	/* Make sure pending VM cleanups are processed before leaving. Those
 	 * cleanups might schedule vm_bind_job cleanups, so keep this
@@ -3582,6 +3640,8 @@ void panthor_mmu_unplug(struct panthor_device *ptdev)
 	 */
 	flush_work(&ptdev->mmu->vm.cleanup_work);
 	drm_WARN_ON(&ptdev->base, !list_empty(&ptdev->mmu->as.cleanup_list));
+	drm_WARN_ON(&ptdev->base, !list_empty(&ptdev->mmu->vm.list));
+	drm_WARN_ON(&ptdev->base, !list_empty(&ptdev->mmu->vm.user_owned));
 
 	/* Ensure any pending job cleanup work are executed before returning,
 	 * otherwise those might access objects that are gone if the work is
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.h b/drivers/gpu/drm/panthor/panthor_mmu.h
index 3522fbbce369..efe6e07936a0 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.h
+++ b/drivers/gpu/drm/panthor/panthor_mmu.h
@@ -18,6 +18,7 @@ struct panthor_vma;
 struct panthor_mmu;
 
 int panthor_mmu_init(struct panthor_device *ptdev);
+void panthor_mmu_freeze_before_unplug(struct panthor_device *ptdev);
 void panthor_mmu_unplug(struct panthor_device *ptdev);
 void panthor_mmu_pre_reset(struct panthor_device *ptdev);
 void panthor_mmu_post_reset(struct panthor_device *ptdev);
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 756c3fa7a242..e834fca11070 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -3049,12 +3049,17 @@ static void update_fdinfo_stats(struct panthor_job *job)
 void panthor_fdinfo_gather_group_samples(struct panthor_file *pfile)
 {
 	struct panthor_group_pool *gpool = pfile->groups;
+	struct panthor_device *ptdev = pfile->ptdev;
 	struct panthor_group *group;
 	unsigned long i;
+	int cookie;
 
 	if (IS_ERR_OR_NULL(gpool))
 		return;
 
+	if (!drm_dev_enter(&ptdev->base, &cookie))
+		return;
+
 	xa_lock(&gpool->xa);
 	xa_for_each_marked(&gpool->xa, i, group, GROUP_REGISTERED) {
 		guard(spinlock)(&group->fdinfo.lock);
@@ -3064,6 +3069,8 @@ void panthor_fdinfo_gather_group_samples(struct panthor_file *pfile)
 		group->fdinfo.data.time = 0;
 	}
 	xa_unlock(&gpool->xa);
+
+	drm_dev_exit(cookie);
 }
 
 static bool queue_check_job_completion(struct panthor_queue *queue)
@@ -3893,14 +3900,23 @@ int panthor_group_pool_create(struct panthor_file *pfile)
 void panthor_group_pool_destroy(struct panthor_file *pfile)
 {
 	struct panthor_group_pool *gpool = pfile->groups;
+	struct panthor_device *ptdev = pfile->ptdev;
 	struct panthor_group *group;
 	unsigned long i;
+	int cookie;
 
 	if (IS_ERR_OR_NULL(gpool))
 		return;
 
-	xa_for_each(&gpool->xa, i, group)
-		panthor_group_destroy(pfile, i);
+	/* If device is gone groups have been destroyed already, and the XArray
+	 * contains pointers to objects that have been freed.
+	 */
+	if (drm_dev_enter(&ptdev->base, &cookie)) {
+		xa_for_each(&gpool->xa, i, group)
+			panthor_group_destroy(pfile, i);
+
+		drm_dev_exit(cookie);
+	}
 
 	xa_destroy(&gpool->xa);
 	kfree(gpool);
@@ -3919,11 +3935,16 @@ panthor_fdinfo_gather_group_mem_info(struct panthor_file *pfile,
 				     struct drm_memory_stats *stats)
 {
 	struct panthor_group_pool *gpool = pfile->groups;
+	struct panthor_device *ptdev = pfile->ptdev;
 	struct panthor_group *group;
 	unsigned long i;
+	int cookie;
+
+	if (!drm_dev_enter(&ptdev->base, &cookie))
+		return;
 
 	if (IS_ERR_OR_NULL(gpool))
-		return;
+		goto out_dev_exit;
 
 	xa_lock(&gpool->xa);
 	xa_for_each_marked(&gpool->xa, i, group, GROUP_REGISTERED) {
@@ -3932,6 +3953,9 @@ panthor_fdinfo_gather_group_mem_info(struct panthor_file *pfile,
 			stats->active += group->fdinfo.kbo_sizes;
 	}
 	xa_unlock(&gpool->xa);
+
+out_dev_exit:
+	drm_dev_exit(cookie);
 }
 
 static void job_release(struct kref *ref)
@@ -4077,23 +4101,76 @@ void panthor_job_update_resvs(struct drm_exec *exec, struct drm_sched_job *sched
 void panthor_sched_unplug(struct panthor_device *ptdev)
 {
 	struct panthor_scheduler *sched = ptdev->scheduler;
+	struct panthor_group *group, *tmp_group;
+	LIST_HEAD(groups);
 
 	disable_delayed_work_sync(&sched->tick_work);
 	disable_work_sync(&sched->fw_events_work);
 	disable_work_sync(&sched->sync_upd_work);
 
 	mutex_lock(&sched->lock);
+
+	/* Do a pass on the on-slot groups, and schedule termination. */
+	for (u32 i = 0; i < sched->csg_slot_count; i++) {
+		struct panthor_csg_slot *csg_slot = &sched->csg_slots[i];
+		struct panthor_group *group = csg_slot->group;
+
+		if (!group)
+			continue;
+
+		group_get(group);
+		group->state = PANTHOR_CS_GROUP_TERMINATED;
+		group_unbind_locked(group);
+		list_del_init(&group->wait_node);
+		group_queue_work(group, term);
+
+		group_put(group);
+	}
+
+	/* Now take care of the non-resident groups. */
+	for (u32 i = 0; i < ARRAY_SIZE(sched->groups.runnable); i++)
+		list_splice_init(&sched->groups.runnable[i], &groups);
+
+	for (u32 i = 0; i < ARRAY_SIZE(sched->groups.idle); i++)
+		list_splice_init(&sched->groups.idle[i], &groups);
+
+	list_for_each_entry_safe(group, tmp_group, &groups, run_node) {
+		list_del_init(&group->run_node);
+		list_del_init(&group->wait_node);
+		group_queue_work(group, term);
+	}
+
+	/* All groups that still have a user handle need a group_put()
+	 * because after drm_dev_unplug() has been called those handles
+	 * can't be released through the GROUP_DESTROY IOCTL anymore.
+	 */
+	list_for_each_entry_safe(group, tmp_group, &sched->groups.user_owned, user_node) {
+		list_del_init(&group->user_node);
+		group_put(group);
+	}
+
 	if (sched->pm.has_ref) {
 		pm_runtime_put(ptdev->base.dev);
 		sched->pm.has_ref = false;
 	}
 	mutex_unlock(&sched->lock);
 
+	/* Ensure all term work are done. */
+	flush_workqueue(sched->wq);
+
 	/* Ensure any pending group release work are executed before returning,
 	 * otherwise those might access objects that are gone if the work is
 	 * executed after other components are unplugged.
 	 */
 	flush_workqueue(panthor_cleanup_wq);
+
+	/* After we've flushed the workqueues, all lists should be empty. */
+	drm_WARN_ON(&ptdev->base, !list_empty(&sched->groups.user_owned));
+	for (u32 i = 0; i < ARRAY_SIZE(sched->groups.runnable); i++)
+		drm_WARN_ON(&ptdev->base, !list_empty(&sched->groups.runnable[i]));
+
+	for (u32 i = 0; i < ARRAY_SIZE(sched->groups.idle); i++)
+		drm_WARN_ON(&ptdev->base, !list_empty(&sched->groups.idle[i]));
 }
 
 static void panthor_sched_fini(struct drm_device *ddev, void *res)

-- 
2.55.0

