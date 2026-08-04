Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90103C5518F
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 10:10:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 256F410E99A;
	Tue,  4 Aug 2026 10:10:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="E2BnaHun";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B56FA10E99A
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 10:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785838200;
 bh=AG99yjnzL0NwoPzc/SWSz0vsk8WoacIHE0yhynRxAM8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=E2BnaHun/3nHNL7ZHo9l9xP1cThZdQ5aALpEGaGeK7w4vDct8GGamPFdwEYuqECNJ
 pIOSJ90vaDQgHX7rrZ7T+o+VznlIzwtH4+P7C2ne42/vhius7ruAktlntyK8Hr4Smx
 mS26dcFxkzCuj2OHh1o3BAhKmvcLT/6YFcM1NgDnzQSki7FXvGlf4Tv7ZivaRShDRs
 dqs/OlGkgmS5/GjHEDH6GO3C/Zah875PdGPr6l1640eboXu18sF5oNidnVHkxn3V77
 IhoOObSPbfF5+Xj1arrcj5+1l7LO2swiUoiXm4472pYeiC3maeVGM3kROpX7ce7Ep6
 Tlc337HpAFbeQ==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 27E4A17E11E4;
 Tue, 04 Aug 2026 12:10:00 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Tue, 04 Aug 2026 12:09:50 +0200
Subject: [PATCH 11/12] drm/panthor: Make the unplug logic more robust
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-panthor-unplug-fixes-v1-11-abbbd2d41b13@collabora.com>
References: <20260804-panthor-unplug-fixes-v1-0-abbbd2d41b13@collabora.com>
In-Reply-To: <20260804-panthor-unplug-fixes-v1-0-abbbd2d41b13@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785838194; l=13095;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=AG99yjnzL0NwoPzc/SWSz0vsk8WoacIHE0yhynRxAM8=;
 b=YXHe3jYuqwR3dET2Vey4nkp9/tYEpw0yuIWgQ4kTvSsAOLK6uI8+8swNyJdb/OiEiwNs8wf9f
 JbIKnSQaJv+AMSiP3bhsiz7KNGgZ1nHDPAMAkXI9rQhSVTkPyEyMYlB
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

1. It assumes that the HW is still accessible in multiple places,
   which goes against the very concept of hot-unplug
2. It doesn't take into account the fact the stop is a failible
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
- it changes the _unplug() implementations to not touch the HW anymore
- it let's each component know whether it should leak resources the HW
  might have its hands on at the time the unplug happens

Unfortunately, those can't be split into multiple commits without
breaking bisectability.

Failures to reset the GPU in the unplug can be simulated with the new
fake_unplug_failure debugfs knob:

  # echo 1 > /sys/kernel/debug/dri/128/fake_unplug_failure
  # <start-some-GPU-workload>
  # echo fb000000.gpu > /sys/module/panthor/drivers/platform\:panthor/unbind
  # <stop-the-GPU-workload>

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_device.c | 68 ++++++++++++++++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_device.h | 23 +++++++++++
 drivers/gpu/drm/panthor/panthor_fw.c     |  9 +----
 drivers/gpu/drm/panthor/panthor_mmu.c    | 53 ++++++++++++++++++-------
 drivers/gpu/drm/panthor/panthor_mmu.h    |  1 +
 drivers/gpu/drm/panthor/panthor_sched.c  | 17 ++++++++
 6 files changed, 149 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index b7c55a6f4f08..425990369b99 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -4,6 +4,7 @@
 /* Copyright 2023 Collabora ltd. */
 /* Copyright 2025 ARM Limited. All rights reserved. */
 
+#include <linux/debugfs.h>
 #include <linux/clk.h>
 #include <linux/mm.h>
 #include <linux/platform_device.h>
@@ -62,8 +63,40 @@ static int panthor_init_power(struct device *dev)
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
+	if (ret)
+		goto err_disable_core_clk;
+
+	return ptdev->unplug.fake_failure ? -EIO : 0;
+
+
+err_disable_core_clk:
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
@@ -90,6 +123,16 @@ void panthor_device_unplug(struct panthor_device *ptdev)
 	/* Make sure we're not interrupted by resets while we're unplugging. */
 	disable_work_sync(&ptdev->reset.work);
 
+	/* Do anything we can to stop the HW. If we can't guarantee that the HW
+	 * is fully stopped, we also can't guarantee the resources it had access
+	 * too won't be touched after the device is gone (clocks and regulators
+	 * can be shared, and the HW might still be running behind our back).
+	 */
+	ret = panthor_device_stop_before_unplug(ptdev);
+	if (drm_WARN(&ptdev->base, ret,
+		     "Couldn't stop the device, this might lead to resource leaks"))
+		ptdev->unplug.leak_active_resources = true;
+
 	/* We do the rest of the unplug with the unplug lock released,
 	 * future callers will wait on ptdev->unplug.done anyway.
 	 */
@@ -631,8 +674,33 @@ int panthor_device_suspend(struct device *dev)
 }
 
 #ifdef CONFIG_DEBUG_FS
+static int panthor_device_fake_unplug_failure_get(void *data, u64 *val)
+{
+	struct panthor_device *ptdev = data;
+
+	*val = ptdev->unplug.fake_failure ? 1 : 0;
+	return 0;
+}
+
+static int panthor_device_fake_unplug_failure_set(void *data, u64 val)
+{
+	struct panthor_device *ptdev = data;
+
+	ptdev->unplug.fake_failure = val ? true : false;
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(panthor_device_fake_unplug_failure_fops,
+			 panthor_device_fake_unplug_failure_get,
+			 panthor_device_fake_unplug_failure_set, "%llu\n");
+
 void panthor_device_debugfs_init(struct drm_minor *minor)
 {
+	struct panthor_device *ptdev = container_of(minor->dev, struct panthor_device, base);
+
+	debugfs_create_file("fake_unplug_failure", 0644,
+			    minor->debugfs_root, ptdev,
+			    &panthor_device_fake_unplug_failure_fops);
 	panthor_mmu_debugfs_init(minor);
 	panthor_gem_debugfs_init(minor);
 }
diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index a6b1a2a5fca4..f960109f4b5b 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -264,6 +264,29 @@ struct panthor_device {
 		 * operation is done.
 		 */
 		struct completion done;
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
+
+		/**
+		 * @fake_failure: When true, pretend the SOFT_RESET in the unplug path failed.
+		 *
+		 * This is important to check that we're doing the right thing in this very
+		 * unlikely case.
+		 */
+		bool fake_failure;
 	} unplug;
 
 	/** @reset: Reset related fields. */
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
index de242ff124ed..9252a279a47b 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -2094,11 +2094,12 @@ static void mmu_post_reset_cleanup(struct panthor_device *ptdev, bool on_unplug)
 
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
@@ -2195,8 +2196,19 @@ static bool vm_prep_for_cleanup(struct panthor_vm *vm)
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
@@ -3538,6 +3550,27 @@ panthor_mmu_reclaim_priv_bos(struct panthor_device *ptdev,
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
 /**
  * panthor_mmu_unplug() - Unplug the MMU logic
  * @ptdev: Device.
@@ -3550,17 +3583,7 @@ void panthor_mmu_unplug(struct panthor_device *ptdev)
 	if (!IS_ENABLED(CONFIG_PM) || pm_runtime_active(ptdev->base.dev))
 		panthor_mmu_irq_suspend(&ptdev->mmu->irq);
 
-	mutex_lock(&ptdev->mmu->as.slots_lock);
-	for (u32 i = 0; i < ARRAY_SIZE(ptdev->mmu->as.slots); i++) {
-		struct panthor_as *as = ptdev->mmu->as.slots[i].as;
-
-		if (as) {
-			drm_WARN_ON(&ptdev->base,
-				    panthor_mmu_as_disable(ptdev, i, false));
-			panthor_as_release_hw_slot_locked(as);
-		}
-	}
-	mutex_unlock(&ptdev->mmu->as.slots_lock);
+	mmu_post_reset_cleanup(ptdev, true);
 }
 
 static void panthor_mmu_release_wq(struct drm_device *ddev, void *res)
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
index 5832dccfc093..adc2c05251e9 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -4069,6 +4069,23 @@ void panthor_sched_unplug(struct panthor_device *ptdev)
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
+		group_put(group);
+	}
+
 	if (sched->pm.has_ref) {
 		pm_runtime_put(ptdev->base.dev);
 		sched->pm.has_ref = false;

-- 
2.55.0

