Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEFBDC44507
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:55:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5093010F9BB;
	Fri, 10 Jul 2026 21:55:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="X5hTglC3";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B03110F9A9;
 Fri, 10 Jul 2026 21:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783720499; x=1815256499;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ru+ATVuJFd+0zN6zT4/mQ06WB0K0FLG3woOJ+d3JU5c=;
 b=X5hTglC3IASWgtbhmyQVuF/Fb44IwVQ/e8PM3EF/2xgg++exqvv7OQ12
 5tEACesTyYanDSu/pE9mMKzDjofC1N8xYMeI8ZRc9ETbeWSIbsaobco/f
 4bUJqa57EM6OOJ1hnkKWrp6NC14sNIUZMXDPf3fanxpricOJT+LPL3u8w
 G1bUKwdWLDX/vAxXoL3C5r9M6axtUw0rmvj8GuWyucnX+Qk/2ILby2jtB
 QrvY9oH4gS162yRMdt8MUGjwM5mF+4m3PHOFk+EniGkW6xPAEDLsfDdWZ
 3dwcU2hd+4hshkplw0+z8tsSqGy1fkwiXgUORCClCmW1AOhI3XY6a3BIc g==;
X-CSE-ConnectionGUID: e6KKeYqfS6+oxlR9djUVJA==
X-CSE-MsgGUID: hSQLaKUwSQGzZzzoJBB6zA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="83543293"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="83543293"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 14:54:58 -0700
X-CSE-ConnectionGUID: cubsGtOcR+6tYCdga07sgA==
X-CSE-MsgGUID: eCnTvJQQQE69qGTSVDjUZw==
X-ExtLoop1: 1
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 14:54:58 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Subject: [PATCH v2 33/33] drm/amdgpu: Preallocate system BO pages outside the
 reservation lock
Date: Fri, 10 Jul 2026 14:54:42 -0700
Message-Id: <20260710215442.2444235-34-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260710215442.2444235-1-matthew.brost@intel.com>
References: <20260710215442.2444235-1-matthew.brost@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Populating a GTT (system) buffer object under the reservation lock can
stall in reclaim and compaction while trying to satisfy beneficial-order
allocations, holding the lock for the duration.

Mirror the Xe out-of-lock preallocation for pure system BOs: when a
gem_create request targets AMDGPU_GEM_DOMAIN_GTT only, fill the full page
backing up front via ttm_pool_prealloc_fill_full() before taking the
reservation lock. The populate under the lock then simply installs these
pages instead of reclaiming and compacting in the critical section. The
fill is best-effort - a short fill falls back to the normal in-lock
allocation for the remaining pages, and any leftover pages are released
by ttm_pool_prealloc_fini() on all exit paths.

Unlike Xe, amdgpu has no background defragmenter, so the higher-order
reclaim backoff is left disabled (normal reclaim). If the pool uses
dma-alloc (swiotlb), the fill bails and the feature is a silent no-op.

Factor the tt pool selection into amdgpu_ttm_tt_pool_id() and
amdgpu_ttm_pool() so the preallocation targets the exact pool the
populate will consume, and thread an optional prealloc bag through
amdgpu_gem_object_create() and amdgpu_bo_param into the populate ctx.

Cc: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Carlos Santa <carlos.santa@intel.com>
Cc: Ryan Neph <ryanneph@google.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Assisted-by: GitHub_Copilot:claude-opus-4.8
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       | 45 +++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h       |  5 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |  4 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 39 +++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  3 ++
 8 files changed, 80 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 20831dbebc31..940f58848a97 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -345,7 +345,7 @@ create_dmamap_sg_bo(struct amdgpu_device *adev,
 
 	ret = amdgpu_gem_object_create(adev, mem->bo->tbo.base.size, 1,
 			AMDGPU_GEM_DOMAIN_CPU, AMDGPU_GEM_CREATE_PREEMPTIBLE | flags,
-			ttm_bo_type_sg, mem->bo->tbo.base.resv, &gem_obj, 0);
+			ttm_bo_type_sg, mem->bo->tbo.base.resv, &gem_obj, 0, NULL);
 
 	amdgpu_bo_unreserve(mem->bo);
 
@@ -1811,7 +1811,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 		 domain_string(alloc_domain), xcp_id);
 
 	ret = amdgpu_gem_object_create(adev, aligned_size, 1, alloc_domain, alloc_flags,
-				       bo_type, NULL, &gobj, xcp_id + 1);
+				       bo_type, NULL, &gobj, xcp_id + 1, NULL);
 	if (ret) {
 		pr_debug("Failed to create BO on domain %s. ret %d\n",
 			 domain_string(alloc_domain), ret);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index b33c300e26e2..51510e831129 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -435,7 +435,7 @@ amdgpu_dma_buf_create_obj(struct drm_device *dev, struct dma_buf *dma_buf)
 
 	ret = amdgpu_gem_object_create(adev, dma_buf->size, PAGE_SIZE,
 				       AMDGPU_GEM_DOMAIN_CPU, flags,
-				       ttm_bo_type_sg, resv, &gobj, 0);
+				       ttm_bo_type_sg, resv, &gobj, 0, NULL);
 	if (ret)
 		goto error;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 6a0699746fbc..bef8b5bc8b89 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -39,6 +39,7 @@
 #include <drm/drm_exec.h>
 #include <drm/drm_gem_ttm_helper.h>
 #include <drm/ttm/ttm_tt.h>
+#include <drm/ttm/ttm_pool.h>
 #include <drm/drm_syncobj.h>
 
 #include "amdgpu.h"
@@ -168,7 +169,8 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long size,
 			     int alignment, u32 initial_domain,
 			     u64 flags, enum ttm_bo_type type,
 			     struct dma_resv *resv,
-			     struct drm_gem_object **obj, int8_t xcp_id_plus1)
+			     struct drm_gem_object **obj, int8_t xcp_id_plus1,
+			     struct ttm_pool_prealloc *prealloc)
 {
 	struct amdgpu_bo *bo;
 	struct amdgpu_bo_user *ubo;
@@ -188,6 +190,7 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long size,
 	bp.domain = initial_domain;
 	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
 	bp.xcp_id_plus1 = xcp_id_plus1;
+	bp.prealloc = prealloc;
 
 	r = amdgpu_bo_create_user(adev, &bp, &ubo);
 	if (r)
@@ -412,6 +415,8 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 	struct dma_resv *resv = NULL;
 	struct drm_gem_object *gobj;
 	uint32_t handle, initial_domain;
+	struct ttm_pool_prealloc prealloc = {};
+	struct ttm_pool *prealloc_pool = NULL;
 	int r;
 
 	/* reject invalid gem flags */
@@ -443,10 +448,29 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 		flags |= AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
 	}
 
+	/*
+	 * For system-only (pure GTT) BOs, preallocate the whole page backing
+	 * up front, outside the reservation lock. Populate under the lock then
+	 * just installs these pages instead of reclaiming/compacting in the
+	 * critical section. Best-effort: a short fill falls back to the normal
+	 * in-lock allocation for the missing pages.
+	 */
+	if (args->in.domains == AMDGPU_GEM_DOMAIN_GTT) {
+		int32_t xcp_id = adev->gmc.mem_partitions ? fpriv->xcp_id : 0;
+		int32_t pool_id = amdgpu_ttm_tt_pool_id(adev, xcp_id);
+		enum ttm_caching caching =
+			(flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC) ?
+			ttm_write_combined : ttm_cached;
+
+		prealloc_pool = amdgpu_ttm_pool(adev, pool_id);
+		ttm_pool_prealloc_fill_full(prealloc_pool, caching, &prealloc,
+					    PFN_UP(size), false);
+	}
+
 	if (flags & AMDGPU_GEM_CREATE_VM_ALWAYS_VALID) {
 		r = amdgpu_bo_reserve(vm->root.bo, false);
 		if (r)
-			return r;
+			goto out_prealloc;
 
 		resv = vm->root.bo->tbo.base.resv;
 	}
@@ -455,7 +479,8 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 retry:
 	r = amdgpu_gem_object_create(adev, size, args->in.alignment,
 				     initial_domain,
-				     flags, ttm_bo_type_device, resv, &gobj, fpriv->xcp_id + 1);
+				     flags, ttm_bo_type_device, resv, &gobj,
+				     fpriv->xcp_id + 1, prealloc_pool ? &prealloc : NULL);
 	if (r && r != -ERESTARTSYS) {
 		if (flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED) {
 			flags &= ~AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
@@ -479,17 +504,21 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 		amdgpu_bo_unreserve(vm->root.bo);
 	}
 	if (r)
-		return r;
+		goto out_prealloc;
 
 	r = drm_gem_handle_create(filp, gobj, &handle);
 	/* drop reference from allocate - handle holds it now */
 	drm_gem_object_put(gobj);
 	if (r)
-		return r;
+		goto out_prealloc;
 
 	memset(args, 0, sizeof(*args));
 	args->out.handle = handle;
-	return 0;
+
+out_prealloc:
+	if (prealloc_pool)
+		ttm_pool_prealloc_fini(prealloc_pool, &prealloc);
+	return r;
 }
 
 int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
@@ -528,7 +557,7 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
 
 	/* create a gem object to contain this object in */
 	r = amdgpu_gem_object_create(adev, args->size, 0, AMDGPU_GEM_DOMAIN_CPU,
-				     0, ttm_bo_type_device, NULL, &gobj, fpriv->xcp_id + 1);
+				     0, ttm_bo_type_device, NULL, &gobj, fpriv->xcp_id + 1, NULL);
 	if (r)
 		return r;
 
@@ -1298,7 +1327,7 @@ int amdgpu_mode_dumb_create(struct drm_file *file_priv,
 	domain = amdgpu_bo_get_preferred_domain(adev,
 				amdgpu_display_supported_domains(adev, flags));
 	r = amdgpu_gem_object_create(adev, args->size, 0, domain, flags,
-				     ttm_bo_type_device, NULL, &gobj, fpriv->xcp_id + 1);
+				     ttm_bo_type_device, NULL, &gobj, fpriv->xcp_id + 1, NULL);
 	if (r)
 		return -ENOMEM;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
index b558336bc4c6..706aeca011f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
@@ -35,6 +35,8 @@
 
 extern const struct drm_gem_object_funcs amdgpu_gem_object_funcs;
 
+struct ttm_pool_prealloc;
+
 unsigned long amdgpu_gem_timeout(uint64_t timeout_ns);
 
 /*
@@ -45,7 +47,8 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long size,
 			     int alignment, u32 initial_domain,
 			     u64 flags, enum ttm_bo_type type,
 			     struct dma_resv *resv,
-			     struct drm_gem_object **obj, int8_t xcp_id_plus1);
+			     struct drm_gem_object **obj, int8_t xcp_id_plus1,
+			     struct ttm_pool_prealloc *prealloc);
 int amdgpu_mode_dumb_create(struct drm_file *file_priv,
 			    struct drm_device *dev,
 			    struct drm_mode_create_dumb *args);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index f98bfba59a2c..18c4cf3f35a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -632,7 +632,8 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
 		/* We opt to avoid OOM on system pages allocations */
 		.gfp_retry_mayfail = true,
 		.allow_res_evict = bp->type != ttm_bo_type_kernel,
-		.resv = bp->resv
+		.resv = bp->resv,
+		.prealloc = bp->prealloc,
 	};
 	struct amdgpu_bo *bo;
 	unsigned long page_align, size = bp->size;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index ff11a0903499..11f1d403f152 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -45,6 +45,8 @@
 #define to_amdgpu_bo_user(abo) container_of((abo), struct amdgpu_bo_user, bo)
 #define to_amdgpu_bo_vm(abo) container_of((abo), struct amdgpu_bo_vm, bo)
 
+struct ttm_pool_prealloc;
+
 struct amdgpu_bo_param {
 	unsigned long			size;
 	int				byte_align;
@@ -58,6 +60,8 @@ struct amdgpu_bo_param {
 	void				(*destroy)(struct ttm_buffer_object *bo);
 	/* xcp partition number plus 1, 0 means any partition */
 	int8_t				xcp_id_plus1;
+	/* optional out-of-lock preallocated backing (system/GTT only) */
+	struct ttm_pool_prealloc	*prealloc;
 };
 
 /* bo virtual addresses in a vm */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index b10b0878df37..c9cd4714f515 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1173,6 +1173,30 @@ void amdgpu_ttm_mmio_remap_free_sgt(struct device *dev,
 	kfree(sgt);
 }
 
+/*
+ * amdgpu_ttm_tt_pool_id - compute the ttm pool id backing a given xcp
+ *
+ * Mirrors the mapping used when creating the gtt ttm_tt, so callers that only
+ * have an xcp id (e.g. an out-of-lock preallocation before the bo exists) pick
+ * the same pool the populate will use.
+ */
+int32_t amdgpu_ttm_tt_pool_id(struct amdgpu_device *adev, int32_t xcp_id)
+{
+	if (adev->gmc.mem_partitions && xcp_id >= 0)
+		return KFD_XCP_MEM_ID(adev, xcp_id);
+
+	return xcp_id;
+}
+
+/* amdgpu_ttm_pool - select the ttm pool for a given pool id */
+struct ttm_pool *amdgpu_ttm_pool(struct amdgpu_device *adev, int32_t pool_id)
+{
+	if (adev->mman.ttm_pools && pool_id >= 0)
+		return &adev->mman.ttm_pools[pool_id];
+
+	return &adev->mman.bdev.pool;
+}
+
 /**
  * amdgpu_ttm_tt_create - Create a ttm_tt object for a given BO
  *
@@ -1194,10 +1218,7 @@ static struct ttm_tt *amdgpu_ttm_tt_create(struct ttm_buffer_object *bo,
 		return NULL;
 
 	gtt->gobj = &bo->base;
-	if (adev->gmc.mem_partitions && abo->xcp_id >= 0)
-		gtt->pool_id = KFD_XCP_MEM_ID(adev, abo->xcp_id);
-	else
-		gtt->pool_id = abo->xcp_id;
+	gtt->pool_id = amdgpu_ttm_tt_pool_id(adev, abo->xcp_id);
 
 	if (abo->flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC)
 		caching = ttm_write_combined;
@@ -1239,10 +1260,7 @@ static int amdgpu_ttm_tt_populate(struct ttm_device *bdev,
 	if (ttm->page_flags & TTM_TT_FLAG_EXTERNAL)
 		return 0;
 
-	if (adev->mman.ttm_pools && gtt->pool_id >= 0)
-		pool = &adev->mman.ttm_pools[gtt->pool_id];
-	else
-		pool = &adev->mman.bdev.pool;
+	pool = amdgpu_ttm_pool(adev, gtt->pool_id);
 	ret = ttm_pool_alloc(pool, ttm, ctx);
 	if (ret)
 		return ret;
@@ -1284,10 +1302,7 @@ static void amdgpu_ttm_tt_unpopulate(struct ttm_device *bdev,
 
 	adev = amdgpu_ttm_adev(bdev);
 
-	if (adev->mman.ttm_pools && gtt->pool_id >= 0)
-		pool = &adev->mman.ttm_pools[gtt->pool_id];
-	else
-		pool = &adev->mman.bdev.pool;
+	pool = amdgpu_ttm_pool(adev, gtt->pool_id);
 
 	return ttm_pool_free(pool, ttm);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index ff9e2e346609..f90844937b73 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -207,6 +207,9 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
 void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
 uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
 
+int32_t amdgpu_ttm_tt_pool_id(struct amdgpu_device *adev, int32_t xcp_id);
+struct ttm_pool *amdgpu_ttm_pool(struct amdgpu_device *adev, int32_t pool_id);
+
 #if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
 int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
 				 struct amdgpu_hmm_range *range);
-- 
2.34.1

