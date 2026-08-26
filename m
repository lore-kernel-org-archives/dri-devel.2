Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ACE7C61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 14:56:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6770910E525;
	Wed, 26 Aug 2026 14:56:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="jOFE9EjY";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E15110E6E2
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 14:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1787756181;
 bh=h0iY7RXMC84U+N95Ae4aLa7SfZLR1bNVVmr975TyDnI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=jOFE9EjYxnkotAqGDnJ0LMbTWCnaI73NnqM+ryEV4gQWMNwUIXvTREomMVA4haVk5
 CziCYg/ES+D8WBqcSKl7EHWz0BGp1C5xGXJnyMTG13W+mJbmMdFNatirfpwfW2cjdg
 YU6P/MnDUfnHSrN0HZzlsItgbP5j/RME0zPvwvvk/QauyB/gAMD0OHu4cvP8CtZYE7
 bjRpOvJl28wDeczFk0zOvh2FCbma7HlLNhDJrZz5Wna9OSfFcBYJjfnZbwXDHmx9np
 jMKQBCsRyWIX/dwj/m2G5IYe9wzEHdjffv0pkeyEe2Y4tIZGhDHMjch5UQ1RQ2nAHC
 miQnQ8Rn2TnAg==
Received: from fedora-32.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id DB05A17E0E48;
 Wed, 26 Aug 2026 16:56:20 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Wed, 26 Aug 2026 16:56:02 +0200
Subject: [PATCH v4 03/18] drm/panthor: Make panthor_device::pm::state
 non-atomic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-panthor-unplug-fixes-v4-3-982cc8f4234b@collabora.com>
References: <20260826-panthor-unplug-fixes-v4-0-982cc8f4234b@collabora.com>
In-Reply-To: <20260826-panthor-unplug-fixes-v4-0-982cc8f4234b@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Chris Diamand <chris.diamand@arm.com>, Akash Goel <akash.goel@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787756178; l=8081;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=h0iY7RXMC84U+N95Ae4aLa7SfZLR1bNVVmr975TyDnI=;
 b=Zx1XPqJyU74o+uzjLykQdgEF2YJMDcwee89etbUxIUKzv70Mx7nkT52yne71Ke0VQF7f8tdMy
 GorrSANWAfsBi/HMwUZiLEUVxt31iUy9qVlk5n5Q14r1wNMIJFz2tTS
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

Now that the reset logic has been reworked to use disable/enable_work(),
there's no need for panthor_device::pm::state to be an atomic. It can
simply be accessed under the same lock we use to touch MMIO mappings.

While at it, rename the lock to make it clear it protects more than just
the MMIO logic, and transition locked sections to scoped_guard().

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_device.c | 97 +++++++++++++++++---------------
 drivers/gpu/drm/panthor/panthor_device.h | 16 ++++--
 2 files changed, 63 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index 2974f4bc0bb1..133e3895cd0a 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -147,8 +147,10 @@ static void panthor_device_reset_work(struct work_struct *work)
 	/* If the device is entering suspend, we don't reset. A slow reset will
 	 * be forced at resume time instead.
 	 */
-	if (atomic_read(&ptdev->pm.state) != PANTHOR_DEVICE_PM_STATE_ACTIVE)
-		return;
+	scoped_guard(mutex, &ptdev->pm.lock) {
+		if (ptdev->pm.state != PANTHOR_DEVICE_PM_STATE_ACTIVE)
+			return;
+	}
 
 	if (!drm_dev_enter(&ptdev->base, &cookie))
 		return;
@@ -204,7 +206,7 @@ int panthor_device_init(struct panthor_device *ptdev)
 	if (ret)
 		return ret;
 
-	ret = drmm_mutex_init(&ptdev->base, &ptdev->pm.mmio_lock);
+	ret = drmm_mutex_init(&ptdev->base, &ptdev->pm.lock);
 	if (ret)
 		return ret;
 
@@ -213,7 +215,7 @@ int panthor_device_init(struct panthor_device *ptdev)
 	INIT_LIST_HEAD(&ptdev->gems.node);
 #endif
 
-	atomic_set(&ptdev->pm.state, PANTHOR_DEVICE_PM_STATE_SUSPENDED);
+	ptdev->pm.state = PANTHOR_DEVICE_PM_STATE_SUSPENDED;
 	p = alloc_page(GFP_KERNEL | __GFP_ZERO);
 	if (!p)
 		return -ENOMEM;
@@ -432,40 +434,39 @@ static vm_fault_t panthor_mmio_vm_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct panthor_device *ptdev = vma->vm_private_data;
-	u64 offset = (u64)vma->vm_pgoff << PAGE_SHIFT;
-	unsigned long pfn;
-	pgprot_t pgprot;
 	vm_fault_t ret;
-	bool active;
 	int cookie;
 
 	if (!drm_dev_enter(&ptdev->base, &cookie))
 		return VM_FAULT_SIGBUS;
 
-	mutex_lock(&ptdev->pm.mmio_lock);
-	active = atomic_read(&ptdev->pm.state) == PANTHOR_DEVICE_PM_STATE_ACTIVE;
+	scoped_guard(mutex, &ptdev->pm.lock) {
+		bool active = ptdev->pm.state == PANTHOR_DEVICE_PM_STATE_ACTIVE;
+		u64 offset = (u64)vma->vm_pgoff << PAGE_SHIFT;
+		unsigned long pfn;
+		pgprot_t pgprot;
 
-	switch (offset) {
-	case DRM_PANTHOR_USER_FLUSH_ID_MMIO_OFFSET:
+		switch (offset) {
+		case DRM_PANTHOR_USER_FLUSH_ID_MMIO_OFFSET:
+			if (active)
+				pfn = __phys_to_pfn(ptdev->phys_addr + CSF_GPU_LATEST_FLUSH_ID);
+			else
+				pfn = page_to_pfn(ptdev->pm.dummy_latest_flush);
+			break;
+
+		default:
+			ret = VM_FAULT_SIGBUS;
+			goto out_dev_exit;
+		}
+
+		pgprot = vma->vm_page_prot;
 		if (active)
-			pfn = __phys_to_pfn(ptdev->phys_addr + CSF_GPU_LATEST_FLUSH_ID);
-		else
-			pfn = page_to_pfn(ptdev->pm.dummy_latest_flush);
-		break;
+			pgprot = pgprot_noncached(pgprot);
 
-	default:
-		ret = VM_FAULT_SIGBUS;
-		goto out_unlock;
+		ret = vmf_insert_pfn_prot(vma, vmf->address, pfn, pgprot);
 	}
 
-	pgprot = vma->vm_page_prot;
-	if (active)
-		pgprot = pgprot_noncached(pgprot);
-
-	ret = vmf_insert_pfn_prot(vma, vmf->address, pfn, pgprot);
-
-out_unlock:
-	mutex_unlock(&ptdev->pm.mmio_lock);
+out_dev_exit:
 	drm_dev_exit(cookie);
 	return ret;
 }
@@ -526,10 +527,13 @@ int panthor_device_resume(struct device *dev)
 	struct panthor_device *ptdev = dev_get_drvdata(dev);
 	int ret, cookie;
 
-	if (atomic_read(&ptdev->pm.state) != PANTHOR_DEVICE_PM_STATE_SUSPENDED)
-		return -EINVAL;
+	scoped_guard(mutex, &ptdev->pm.lock) {
+		if (ptdev->pm.state != PANTHOR_DEVICE_PM_STATE_SUSPENDED)
+			return -EINVAL;
+
+		ptdev->pm.state = PANTHOR_DEVICE_PM_STATE_RESUMING;
+	}
 
-	atomic_set(&ptdev->pm.state, PANTHOR_DEVICE_PM_STATE_RESUMING);
 
 	ret = clk_prepare_enable(ptdev->clks.core);
 	if (ret)
@@ -574,11 +578,11 @@ int panthor_device_resume(struct device *dev)
 	 * are removed and the real iomem mapping will be restored on next
 	 * access.
 	 */
-	mutex_lock(&ptdev->pm.mmio_lock);
+	mutex_lock(&ptdev->pm.lock);
 	unmap_mapping_range(ptdev->base.anon_inode->i_mapping,
 			    DRM_PANTHOR_USER_MMIO_OFFSET, 0, 1);
-	atomic_set(&ptdev->pm.state, PANTHOR_DEVICE_PM_STATE_ACTIVE);
-	mutex_unlock(&ptdev->pm.mmio_lock);
+	ptdev->pm.state = PANTHOR_DEVICE_PM_STATE_ACTIVE;
+	mutex_unlock(&ptdev->pm.lock);
 
 	/* Now that everything is resumed, we can re-enable the reset work. */
 	enable_resets(ptdev);
@@ -595,7 +599,9 @@ int panthor_device_resume(struct device *dev)
 	clk_disable_unprepare(ptdev->clks.core);
 
 err_set_suspended:
-	atomic_set(&ptdev->pm.state, PANTHOR_DEVICE_PM_STATE_SUSPENDED);
+	scoped_guard(mutex, &ptdev->pm.lock)
+		ptdev->pm.state = PANTHOR_DEVICE_PM_STATE_SUSPENDED;
+
 	atomic_set(&ptdev->pm.recovery_needed, 1);
 	return ret;
 }
@@ -605,21 +611,21 @@ int panthor_device_suspend(struct device *dev)
 	struct panthor_device *ptdev = dev_get_drvdata(dev);
 	int cookie;
 
-	if (atomic_read(&ptdev->pm.state) != PANTHOR_DEVICE_PM_STATE_ACTIVE)
-		return -EINVAL;
-
 	/* Clear all IOMEM mappings pointing to this device before we
 	 * shutdown the power-domain and clocks. Failing to do that results
 	 * in external aborts when the process accesses the iomem region.
 	 * We change the state and call unmap_mapping_range() with the
-	 * mmio_lock held to make sure the vm_fault handler won't set up
+	 * lock held to make sure the vm_fault handler won't set up
 	 * invalid mappings.
 	 */
-	mutex_lock(&ptdev->pm.mmio_lock);
-	atomic_set(&ptdev->pm.state, PANTHOR_DEVICE_PM_STATE_SUSPENDING);
-	unmap_mapping_range(ptdev->base.anon_inode->i_mapping,
-			    DRM_PANTHOR_USER_MMIO_OFFSET, 0, 1);
-	mutex_unlock(&ptdev->pm.mmio_lock);
+	scoped_guard(mutex, &ptdev->pm.lock) {
+		if (ptdev->pm.state != PANTHOR_DEVICE_PM_STATE_ACTIVE)
+			return -EINVAL;
+
+		ptdev->pm.state = PANTHOR_DEVICE_PM_STATE_SUSPENDING;
+		unmap_mapping_range(ptdev->base.anon_inode->i_mapping,
+				    DRM_PANTHOR_USER_MMIO_OFFSET, 0, 1);
+	}
 
 	/* Make sure we're not interrupted by resets after that point
 	 * until the GPU is resumed.
@@ -644,6 +650,9 @@ int panthor_device_suspend(struct device *dev)
 	clk_disable_unprepare(ptdev->clks.coregroup);
 	clk_disable_unprepare(ptdev->clks.stacks);
 	clk_disable_unprepare(ptdev->clks.core);
-	atomic_set(&ptdev->pm.state, PANTHOR_DEVICE_PM_STATE_SUSPENDED);
+
+	scoped_guard(mutex, &ptdev->pm.lock)
+		ptdev->pm.state = PANTHOR_DEVICE_PM_STATE_SUSPENDED;
+
 	return 0;
 }
diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index f55baa21b25e..217eec811bdb 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -298,18 +298,22 @@ struct panthor_device {
 
 	/** @pm: Power management related data. */
 	struct {
-		/** @state: Power state. */
-		atomic_t state;
+		/**
+		 * @state: Power state.
+		 *
+		 * Must be accessed with the panthor_device::pm::lock held.
+		 */
+		enum panthor_device_pm_state state;
 
 		/**
-		 * @mmio_lock: Lock protecting MMIO userspace CPU mappings.
+		 * @lock: Lock protecting PM related fields.
 		 *
 		 * This is needed to ensure we map the dummy IO pages when
 		 * the device is being suspended, and the real IO pages when
-		 * the device is being resumed. We can't just do with the
-		 * state atomicity to deal with this race.
+		 * the device is being resumed. We can't just do with an
+		 * atomic state to deal with this race.
 		 */
-		struct mutex mmio_lock;
+		struct mutex lock;
 
 		/**
 		 * @dummy_latest_flush: Dummy LATEST_FLUSH page.

-- 
2.55.0

