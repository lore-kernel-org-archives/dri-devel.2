Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F572C61DC6
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 14:56:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6692010E2EA;
	Wed, 26 Aug 2026 14:56:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Dx41kLsW";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A95010E525
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 14:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1787756182;
 bh=H1pT4no+VY1bci5jld31VUY/9dgFgYGHV8j1K67Sft0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Dx41kLsWemcKJ7mVFGjYaifrBPf51kX/vByzRhTilVar/wCXTVtzbIqnCJ16QL4X+
 2H47uZj/c/0Xylm+CixRYcz7bxDHMyQPmxOQBPGv+sFMZ78SUs0+zwrKvRVCQvz9SK
 RscVVVs94dMxQvnwPDjciOmWna5iq7K2ISyEGUYx2YyXFBm29985wNkpa1rVUt4/52
 ZRXY56FyOnpkA+saSvV9tYisBTe13aDU8Nm9bIgLxAI4khf7ZvwkDCc3NWCC8v/uXD
 9/7DveEGYMszaTnlYaym2VCTl4Hkexqg8G+JXy8BHeSS7e9pbakVb2OA9hftoRLfcI
 lNgYbMCm+ZQLw==
Received: from fedora-32.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 17BC517E0FD5;
 Wed, 26 Aug 2026 16:56:22 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Wed, 26 Aug 2026 16:56:04 +0200
Subject: [PATCH v4 05/18] drm/panthor: Make the page table cache and
 cleanup workqueue device-local
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-panthor-unplug-fixes-v4-5-982cc8f4234b@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787756178; l=11787;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=H1pT4no+VY1bci5jld31VUY/9dgFgYGHV8j1K67Sft0=;
 b=stBpItOhQ1voKhej/BfQq6TtqHqg9opAm8k2RW+iJ7uEuNDusD/KiKFMr+UzrW21yguXMbp96
 rYUhKs98tIyAfPoiM386AVL3oTK28K1xkKZ4DlLrRK1AsfK5Za0KzE4
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

There's no clue that we'll ever have an SoC with multiple Mali GPUs,
and even then, the gains of sharing the PT caches and cleanup workqueue
remains unclear.

On the other hand, binding those resources to the device allows us to
detect leaks or UAF at drm_device removal time instead of when the
module is removed.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_device.c | 17 ++++---
 drivers/gpu/drm/panthor/panthor_device.h |  8 ++++
 drivers/gpu/drm/panthor/panthor_drv.c    | 47 +------------------
 drivers/gpu/drm/panthor/panthor_mmu.c    | 78 +++++++++++++++-----------------
 drivers/gpu/drm/panthor/panthor_mmu.h    |  3 --
 drivers/gpu/drm/panthor/panthor_sched.c  |  4 +-
 6 files changed, 58 insertions(+), 99 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index 133e3895cd0a..08bb4d410941 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -131,12 +131,9 @@ static void panthor_device_unplug_work(struct work_struct *work)
 	panthor_device_unplug(ptdev);
 }
 
-static void panthor_device_reset_cleanup(struct drm_device *ddev, void *data)
+static void destroy_wq(struct drm_device *ddev, void *wq)
 {
-	struct panthor_device *ptdev = container_of(ddev, struct panthor_device, base);
-
-	disable_work_sync(&ptdev->reset.work);
-	destroy_workqueue(ptdev->reset.wq);
+	destroy_workqueue(wq);
 }
 
 static void panthor_device_reset_work(struct work_struct *work)
@@ -242,7 +239,15 @@ int panthor_device_init(struct panthor_device *ptdev)
 	if (!ptdev->reset.wq)
 		return -ENOMEM;
 
-	ret = drmm_add_action_or_reset(&ptdev->base, panthor_device_reset_cleanup, NULL);
+	ret = drmm_add_action_or_reset(&ptdev->base, destroy_wq, ptdev->reset.wq);
+	if (ret)
+		return ret;
+
+	ptdev->cleanup_wq =  alloc_workqueue("panthor-cleanup", WQ_UNBOUND, 0);
+	if (!ptdev->cleanup_wq)
+		return -ENOMEM;
+
+	ret = drmm_add_action_or_reset(&ptdev->base, destroy_wq, ptdev->cleanup_wq);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index 217eec811bdb..a7ea475fb407 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -327,6 +327,14 @@ struct panthor_device {
 		atomic_t recovery_needed;
 	} pm;
 
+	/**
+	 * @cleanup_wq: Workqueue used for cleanup operations.
+	 *
+	 * We create a dedicated workqueue so we can flush on unplug and
+	 * make sure all resources are freed before we finish the unplug.
+	 */
+	struct workqueue_struct *cleanup_wq;
+
 	/** @profile_mask: User-set profiling flags for job accounting. */
 	u32 profile_mask;
 
diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index 46a3080b0b20..67db6701699b 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -1904,52 +1904,7 @@ static struct platform_driver panthor_driver = {
 		.dev_groups = panthor_groups,
 	},
 };
-
-/*
- * Workqueue used to cleanup stuff.
- *
- * We create a dedicated workqueue so we can drain on unplug and
- * make sure all resources are freed before the module is unloaded.
- */
-struct workqueue_struct *panthor_cleanup_wq;
-
-static int __init panthor_init(void)
-{
-	int ret;
-
-	ret = panthor_mmu_pt_cache_init();
-	if (ret)
-		return ret;
-
-	panthor_cleanup_wq = alloc_workqueue("panthor-cleanup", WQ_UNBOUND, 0);
-	if (!panthor_cleanup_wq) {
-		pr_err("panthor: Failed to allocate the workqueues");
-		ret = -ENOMEM;
-		goto err_mmu_pt_cache_fini;
-	}
-
-	ret = platform_driver_register(&panthor_driver);
-	if (ret)
-		goto err_destroy_cleanup_wq;
-
-	return 0;
-
-err_destroy_cleanup_wq:
-	destroy_workqueue(panthor_cleanup_wq);
-
-err_mmu_pt_cache_fini:
-	panthor_mmu_pt_cache_fini();
-	return ret;
-}
-module_init(panthor_init);
-
-static void __exit panthor_exit(void)
-{
-	platform_driver_unregister(&panthor_driver);
-	destroy_workqueue(panthor_cleanup_wq);
-	panthor_mmu_pt_cache_fini();
-}
-module_exit(panthor_exit);
+module_platform_driver(panthor_driver);
 
 MODULE_AUTHOR("Panthor Project Developers");
 MODULE_DESCRIPTION("Panthor DRM Driver");
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 1385ee28bee5..b4e41556247a 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -61,6 +61,16 @@ struct panthor_mmu {
 	/** @irq: The MMU irq. */
 	struct panthor_irq irq;
 
+	/**
+	 * @pt_cache: Cache used to allocate MMU page tables.
+	 *
+	 * The pre-allocation pattern forces us to over-allocate to plan for
+	 * the worst case scenario, and return the pages we didn't use.
+	 *
+	 * Having a kmem_cache allows us to speed allocations.
+	 */
+	struct kmem_cache *pt_cache;
+
 	/**
 	 * @as: Address space related fields.
 	 *
@@ -440,16 +450,6 @@ struct panthor_vm_bind_job {
 	struct panthor_vm_op_ctx ctx;
 };
 
-/*
- * @pt_cache: Cache used to allocate MMU page tables.
- *
- * The pre-allocation pattern forces us to over-allocate to plan for
- * the worst case scenario, and return the pages we didn't use.
- *
- * Having a kmem_cache allows us to speed allocations.
- */
-static struct kmem_cache *pt_cache;
-
 /**
  * alloc_pt() - Custom page table allocator
  * @cookie: Cookie passed at page table allocation time.
@@ -530,7 +530,7 @@ static void free_pt(void *cookie, void *data, size_t size)
 		return;
 
 	/* Return the page to the pt_cache. */
-	kmem_cache_free(pt_cache, data);
+	kmem_cache_free(vm->ptdev->mmu->pt_cache, data);
 }
 
 static int wait_ready(struct panthor_device *ptdev, u32 as_nr)
@@ -1179,7 +1179,8 @@ static void panthor_vm_cleanup_op_ctx(struct panthor_vm_op_ctx *op_ctx,
 				     !op_ctx->map.bo;
 
 	if (remaining_pt_count) {
-		kmem_cache_free_bulk(pt_cache, remaining_pt_count,
+		kmem_cache_free_bulk(vm->ptdev->mmu->pt_cache,
+				     remaining_pt_count,
 				     op_ctx->rsvd_page_tables.pages +
 				     op_ctx->rsvd_page_tables.ptr);
 	}
@@ -1279,7 +1280,8 @@ static void panthor_vm_init_op_ctx(struct panthor_vm_op_ctx *op_ctx,
 	op_ctx->va.addr = va;
 }
 
-static int panthor_vm_op_ctx_prealloc_pts(struct panthor_vm_op_ctx *op_ctx)
+static int panthor_vm_op_ctx_prealloc_pts(struct panthor_device *ptdev,
+					  struct panthor_vm_op_ctx *op_ctx)
 {
 	u64 size = op_ctx->va.range;
 	u64 va = op_ctx->va.addr;
@@ -1298,7 +1300,7 @@ static int panthor_vm_op_ctx_prealloc_pts(struct panthor_vm_op_ctx *op_ctx)
 	if (!op_ctx->rsvd_page_tables.pages)
 		return -ENOMEM;
 
-	if (!kmem_cache_alloc_bulk(pt_cache, GFP_KERNEL, pt_count,
+	if (!kmem_cache_alloc_bulk(ptdev->mmu->pt_cache, GFP_KERNEL, pt_count,
 				   op_ctx->rsvd_page_tables.pages)) {
 		op_ctx->rsvd_page_tables.count = 0;
 		return -ENOMEM;
@@ -1385,7 +1387,7 @@ static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
 	op_ctx->map.vm_bo = drm_gpuvm_bo_obtain_prealloc(preallocated_vm_bo);
 	op_ctx->map.bo_offset = op->bo_offset;
 
-	ret = panthor_vm_op_ctx_prealloc_pts(op_ctx);
+	ret = panthor_vm_op_ctx_prealloc_pts(vm->ptdev, op_ctx);
 	if (ret)
 		goto err_cleanup;
 
@@ -1444,8 +1446,9 @@ static int panthor_vm_prepare_unmap_op_ctx(struct panthor_vm_op_ctx *op_ctx,
 			goto err_cleanup;
 		}
 
-		if (!kmem_cache_alloc_bulk(pt_cache, GFP_KERNEL, pt_count,
-				op_ctx->rsvd_page_tables.pages)) {
+		if (!kmem_cache_alloc_bulk(vm->ptdev->mmu->pt_cache,
+					   GFP_KERNEL, pt_count,
+					   op_ctx->rsvd_page_tables.pages)) {
 			ret = -ENOMEM;
 			goto err_cleanup;
 		}
@@ -2580,7 +2583,7 @@ static int remap_evicted_vma(struct drm_gpuvm_bo *vm_bo,
 	bool found = false;
 	int ret;
 
-	ret = panthor_vm_op_ctx_prealloc_pts(op_ctx);
+	ret = panthor_vm_op_ctx_prealloc_pts(vm->ptdev, op_ctx);
 	if (ret)
 		goto out_cleanup;
 
@@ -2821,7 +2824,7 @@ panthor_vm_bind_free_job(struct drm_sched_job *sched_job)
 	/* Do the heavy cleanups asynchronously, so we're out of the
 	 * dma-signaling path and can acquire dma-resv locks safely.
 	 */
-	queue_work(panthor_cleanup_wq, &job->cleanup_op_ctx_work);
+	queue_work(job->vm->ptdev->cleanup_wq, &job->cleanup_op_ctx_work);
 }
 
 static enum drm_gpu_sched_stat
@@ -3372,7 +3375,7 @@ void panthor_mmu_unplug(struct panthor_device *ptdev)
 	 * otherwise those might access objects that are gone if the work is
 	 * executed after other components are unplugged.
 	 */
-	flush_workqueue(panthor_cleanup_wq);
+	flush_workqueue(ptdev->cleanup_wq);
 }
 
 static void panthor_mmu_release_wq(struct drm_device *ddev, void *res)
@@ -3385,6 +3388,11 @@ static void panthor_mmu_info_init(struct panthor_device *ptdev)
 	ptdev->mmu_info.page_size_bitmap = SZ_4K | SZ_2M;
 }
 
+static void free_pt_cache(struct drm_device *, void *pt_cache)
+{
+	kmem_cache_destroy(pt_cache);
+}
+
 /**
  * panthor_mmu_init() - Initialize the MMU logic.
  * @ptdev: Device.
@@ -3414,6 +3422,14 @@ int panthor_mmu_init(struct panthor_device *ptdev)
 	if (ret)
 		return ret;
 
+	mmu->pt_cache = kmem_cache_create("panthor-mmu-pt", SZ_4K, SZ_4K, 0, NULL);
+	if (!mmu->pt_cache)
+		return -ENOMEM;
+
+	ret = drmm_add_action_or_reset(&ptdev->base, free_pt_cache, mmu->pt_cache);
+	if (ret)
+		return ret;
+
 	mmu->iomem = ptdev->iomem + MMU_AS_BASE;
 	ptdev->mmu = mmu;
 
@@ -3498,25 +3514,3 @@ void panthor_mmu_debugfs_init(struct drm_minor *minor)
 				 minor->debugfs_root, minor);
 }
 #endif /* CONFIG_DEBUG_FS */
-
-/**
- * panthor_mmu_pt_cache_init() - Initialize the page table cache.
- *
- * Return: 0 on success, a negative error code otherwise.
- */
-int panthor_mmu_pt_cache_init(void)
-{
-	pt_cache = kmem_cache_create("panthor-mmu-pt", SZ_4K, SZ_4K, 0, NULL);
-	if (!pt_cache)
-		return -ENOMEM;
-
-	return 0;
-}
-
-/**
- * panthor_mmu_pt_cache_fini() - Destroy the page table cache.
- */
-void panthor_mmu_pt_cache_fini(void)
-{
-	kmem_cache_destroy(pt_cache);
-}
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.h b/drivers/gpu/drm/panthor/panthor_mmu.h
index 3522fbbce369..de6b4ee4e41a 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.h
+++ b/drivers/gpu/drm/panthor/panthor_mmu.h
@@ -104,9 +104,6 @@ void panthor_vm_update_resvs(struct panthor_vm *vm, struct drm_exec *exec,
 			     enum dma_resv_usage private_usage,
 			     enum dma_resv_usage extobj_usage);
 
-int panthor_mmu_pt_cache_init(void);
-void panthor_mmu_pt_cache_fini(void);
-
 #ifdef CONFIG_DEBUG_FS
 void panthor_mmu_debugfs_init(struct drm_minor *minor);
 #endif
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index a6d57dc1b43e..4ea16b40d6b9 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -972,7 +972,7 @@ static void group_release(struct kref *kref)
 	drm_WARN_ON(&ptdev->base, !list_empty(&group->run_node));
 	drm_WARN_ON(&ptdev->base, !list_empty(&group->wait_node));
 
-	queue_work(panthor_cleanup_wq, &group->release_work);
+	queue_work(ptdev->cleanup_wq, &group->release_work);
 }
 
 static void group_put(struct panthor_group *group)
@@ -4054,7 +4054,7 @@ void panthor_sched_unplug(struct panthor_device *ptdev)
 	 * otherwise those might access objects that are gone if the work is
 	 * executed after other components are unplugged.
 	 */
-	flush_workqueue(panthor_cleanup_wq);
+	flush_workqueue(ptdev->cleanup_wq);
 }
 
 static void panthor_sched_fini(struct drm_device *ddev, void *res)

-- 
2.55.0

