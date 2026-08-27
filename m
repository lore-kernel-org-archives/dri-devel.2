Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E6DCC61DCD
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 12:49:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A8EF10F014;
	Thu, 27 Aug 2026 12:49:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kgFNoNtU";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3A3810F014
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 12:49:19 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-49b392ccaacso9373675e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 05:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787834958; x=1788439758; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mh/zwXkHRTO1ZcwyZeUA8wt6r1gcb/RE08QlWDZfpok=;
 b=kgFNoNtU8EWkdNTOPDWpMUjDrFhLHn+jbvBPUhlaTb5nYRD48dzMy/FZpZeQ13iuwc
 j1gzZEW511hgZ4dlBYLv2F8rZdX6+3shkpnZnuFUKjnnoaKRncrt+F/9hp7cJPQ8PDqo
 cnR8LO2TFTbzLxC41P4k5saEWm2Isr1hKx0DcEbQJJ+bDhXeQp4Ndv66vy+CkTfrZOru
 nH+Q+Tlwun7XiObGUHpbyMZOuTQgBK4emgXIYSslX812SzDgwNpLrpSeQmc4cczlpPHR
 wOkVde5gCMmnBWugS5pjP+7c/qUSJwh2pQRM4fnnDeNQKrK3qPMyZOZzxWH32e2PbORA
 pwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787834958; x=1788439758;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mh/zwXkHRTO1ZcwyZeUA8wt6r1gcb/RE08QlWDZfpok=;
 b=g7ARmT2RWbcybPfxQlW0stH5ucCuCdMCGkSw0ehakf4QZv5CXx28/G3ZeTQL0pc4rt
 wLpTalT8WDlMmHx2B/q6Ylhqi3ryaq/tDMIE3l8rw4L3u/hJPb2Tv9iwuAh7FurwWndh
 B9IK08FyWYMbyxxFPH6DxMmmjgEdA5u/l+RKl09Sk15AguMZmZh2nGBEaydCVcqjPD8t
 6FjibotWG+gB/CvC9aXYwgDE/Dlq+zRVxiZxfFkCHxHJZeDfRHs9Ocsc4RjxSNSbdCEV
 kipRCmPseMqCpZvkgisBsjErHi9KAwEn2JZ3/EdC0fBN2or+QYCSq1zUS27vgxyx8A9/
 sm4g==
X-Forwarded-Encrypted: i=1;
 AHgh+RqSOpOaneiWYdP+eHUS1EYQYAej6KJ7KTsNsdhb7C6+T06/hM4msVliHOvscDWjw5vEE6SwziF5Npg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lCe9k8MPHBkEuegl6ckPdCjOOoIji7DseHYMEDzVXxxq+a7r6t
 n08tm9OHXHadxFuZoDrChdG3jIaWIFK/YOQuOe8Wumc5gKEQAvf4JOXp
X-Gm-Gg: AR+sD1118ynBfQnnaP2CtbsIz7d+enap9sTh7qFFrg0PcLmAYRSbTrB51cOa/fLCdgA
 SrDYNPcbon34fefrb+GtR3w7uyfHrTyQzTnNkHvOe7HsSfvH0U4BJYmWTV2VubwvTILbdPhfwW3
 WyWaDWLTg9cxjd+ngwiE+RnvZ4UhAVxc72xlS9i4fhOwQdNWtRdS+T/wKFcwCCkW+nClDTkCdwM
 P/3+Y5ZHNO59jKWBL28rHFkDuK5GUdy2rKvvE+TkB26mdmSEhZniTC3N6zekdVAxA4EVxy7d4nh
 0ztkNNMsudg6sXkBpv32ZY/KSsqG0f3IF20dvEIHVVf/TuzHBN93lL254Lec2SJWSWGMc/NcUO1
 lQABeIl+xHKlcEkda5rJakgSzYm0GLCmYWLi1Vu5h1fD0MElEugnZIhIppo0zHjecxGZpsm4t0C
 Lx7YL5PO1vYC1Ob2ZtwgERgtP4dC74jxv8Ptrunm8GAwxNnk4l+d95zP7+pm4GGu/U6c5oGflWp
 g==
X-Received: by 2002:a05:600c:4752:b0:49b:9113:e03c with SMTP id
 5b1f17b1804b1-49b9113e110mr1824445e9.8.1787834957953; 
 Thu, 27 Aug 2026 05:49:17 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1524:4300:a4b8:720e:f64f:4778])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b465226d8sm52089985e9.0.2026.08.27.05.49.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 05:49:17 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: thomas.hellstrom@linux.intel.com, dakr@kernel.org, ecourtney@nvidia.com,
 matthew.brost@intel.com, nat@pixelcluster.dev,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/10] drm/gem: Convert drm_gem_private_object_init to return
 error code
Date: Thu, 27 Aug 2026 14:38:52 +0200
Message-ID: <20260827124910.2245-5-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827124910.2245-1-christian.koenig@amd.com>
References: <20260827124910.2245-1-christian.koenig@amd.com>
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
Reply-To: christian.koenig@amd.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Change drm_gem_private_object_init() to return an int instead of void,
allowing it to report errors instead of crashing the kernel with BUG_ON.
The function now returns -EINVAL if the size parameter is not page-aligned,
rather than using BUG_ON to crash the system.

This change improves error handling throughout the DRM subsystem by
replacing a kernel panic with graceful error propagation. All 60+ call
sites across the DRM and accelerator drivers have been updated to check
the return value and handle errors appropriately.

Updated components:
- Core: drm_gem.c, drm_gem_shmem_helper.c, drm_gem_dma_helper.c, drm_gpuvm.c
- AMD: amdgpu, radeon
- Intel: i915 (multiple modules), xe, gvt
- ARM/Mobile: armada, etnaviv, gma500, msm, omapdrm, panthor, imagination
- Virtual: virtio, vmwgfx
- Other: renesas/rcar-du
- Accelerators: qaic, amdxdna
- Tests: drm_exec_test, ttm_bo_validate_test, i915 selftests

Each caller now properly checks the return value and either propagates
the error up the call stack or handles it with appropriate cleanup.

Signed-off-by: Christian König <christian.koenig@amd.com>
Assisted-by: Claude:Sonnet 4
---
 drivers/accel/amdxdna/amdxdna_gem.c           |  6 ++-
 drivers/accel/qaic/qaic_data.c                | 10 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |  6 ++-
 drivers/gpu/drm/armada/armada_gem.c           |  7 ++-
 drivers/gpu/drm/drm_gem.c                     | 17 ++++--
 drivers/gpu/drm/drm_gem_dma_helper.c          |  2 +-
 drivers/gpu/drm/drm_gem_shmem_helper.c        |  2 +-
 drivers/gpu/drm/drm_gpuvm.c                   |  7 ++-
 drivers/gpu/drm/etnaviv/etnaviv_gem.c         |  6 ++-
 drivers/gpu/drm/gma500/gem.c                  |  4 +-
 drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c    |  7 ++-
 drivers/gpu/drm/i915/gem/i915_gem_internal.c  |  8 ++-
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c     |  5 +-
 drivers/gpu/drm/i915/gem/i915_gem_stolen.c    |  5 +-
 drivers/gpu/drm/i915/gem/i915_gem_ttm.c       |  5 +-
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c   |  7 ++-
 .../drm/i915/gem/selftests/huge_gem_object.c  |  8 ++-
 .../gpu/drm/i915/gem/selftests/huge_pages.c   | 15 +++++-
 drivers/gpu/drm/i915/gvt/dmabuf.c             |  8 ++-
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c |  6 ++-
 drivers/gpu/drm/i915/selftests/mock_region.c  |  6 ++-
 drivers/gpu/drm/imagination/pvr_vm.c          |  8 ++-
 drivers/gpu/drm/msm/msm_gem.c                 |  6 ++-
 drivers/gpu/drm/omapdrm/omap_gem.c            |  4 +-
 drivers/gpu/drm/panthor/panthor_gem.c         |  6 ++-
 drivers/gpu/drm/radeon/radeon_object.c        |  6 ++-
 drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c |  6 ++-
 drivers/gpu/drm/tests/drm_exec_test.c         | 18 ++++---
 .../gpu/drm/ttm/tests/ttm_bo_validate_test.c  | 54 ++++++++++++-------
 drivers/gpu/drm/virtio/virtgpu_prime.c        |  6 ++-
 drivers/gpu/drm/virtio/virtgpu_vram.c         |  6 ++-
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c            |  4 +-
 drivers/gpu/drm/xe/xe_bo.c                    |  4 +-
 drivers/gpu/drm/xe/xe_mmio_gem.c              |  6 ++-
 include/drm/drm_gem.h                         |  4 +-
 35 files changed, 222 insertions(+), 63 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index 1f190b319bb6..f4c017f496fa 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -1023,7 +1023,11 @@ amdxdna_drm_create_dev_bo(struct drm_device *dev,
 		return ERR_PTR(ret);
 	}
 
-	drm_gem_private_object_init(dev, gobj, aligned_sz);
+	ret = drm_gem_private_object_init(dev, gobj, aligned_sz);
+	if (ret) {
+		amdxdna_gem_destroy_obj(abo);
+		return ERR_PTR(ret);
+	}
 
 	return abo;
 }
diff --git a/drivers/accel/qaic/qaic_data.c b/drivers/accel/qaic/qaic_data.c
index 4d55531bf1c9..dcd21faaef4a 100644
--- a/drivers/accel/qaic/qaic_data.c
+++ b/drivers/accel/qaic/qaic_data.c
@@ -770,7 +770,11 @@ int qaic_create_bo_ioctl(struct drm_device *dev, void *data, struct drm_file *fi
 	}
 	obj = &bo->base;
 
-	drm_gem_private_object_init(dev, obj, size);
+	ret = drm_gem_private_object_init(dev, obj, size);
+	if (ret) {
+		kfree(bo);
+		goto unlock_dev_srcu;
+	}
 
 	obj->funcs = &qaic_gem_funcs;
 	ret = create_sgt(qdev, &bo->sgt, size);
@@ -867,7 +871,9 @@ struct drm_gem_object *qaic_gem_prime_import(struct drm_device *dev, struct dma_
 		goto size_align_fail;
 	}
 
-	drm_gem_private_object_init(dev, obj, attach->dmabuf->size);
+	ret = drm_gem_private_object_init(dev, obj, attach->dmabuf->size);
+	if (ret)
+		goto size_align_fail;
 	/*
 	 * skipping dma_buf_map_attachment() as we do not know the direction
 	 * just yet. Once the direction is known in the subsequent IOCTL to
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index f98bfba59a2c..6c5182d54f7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -663,7 +663,11 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
 	bo = kvzalloc(bp->bo_ptr_size, GFP_KERNEL);
 	if (bo == NULL)
 		return -ENOMEM;
-	drm_gem_private_object_init(adev_to_drm(adev), &bo->tbo.base, size);
+	r = drm_gem_private_object_init(adev_to_drm(adev), &bo->tbo.base, size);
+	if (r) {
+		kvfree(bo);
+		return r;
+	}
 	bo->tbo.base.funcs = &amdgpu_gem_object_funcs;
 	bo->vm_bo = NULL;
 	bo->preferred_domains = bp->preferred_domain ? bp->preferred_domain :
diff --git a/drivers/gpu/drm/armada/armada_gem.c b/drivers/gpu/drm/armada/armada_gem.c
index da7335cbe82d..da6f5506743e 100644
--- a/drivers/gpu/drm/armada/armada_gem.c
+++ b/drivers/gpu/drm/armada/armada_gem.c
@@ -197,6 +197,7 @@ struct armada_gem_object *
 armada_gem_alloc_private_object(struct drm_device *dev, size_t size)
 {
 	struct armada_gem_object *obj;
+	int ret;
 
 	size = roundup_gem_size(size);
 
@@ -206,7 +207,11 @@ armada_gem_alloc_private_object(struct drm_device *dev, size_t size)
 
 	obj->obj.funcs = &armada_gem_object_funcs;
 
-	drm_gem_private_object_init(dev, &obj->obj, size);
+	ret = drm_gem_private_object_init(dev, &obj->obj, size);
+	if (ret) {
+		kfree(obj);
+		return NULL;
+	}
 
 	DRM_DEBUG_DRIVER("alloc private obj %p size %zu\n", obj, size);
 
diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index bbcbd25f014f..d2ce18bbddea 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -187,8 +187,11 @@ int drm_gem_object_init(struct drm_device *dev, struct drm_gem_object *obj,
 	struct vfsmount *huge_mnt;
 	struct file *filp;
 	const vma_flags_t flags = mk_vma_flags(VMA_NORESERVE_BIT);
+	int ret;
 
-	drm_gem_private_object_init(dev, obj, size);
+	ret = drm_gem_private_object_init(dev, obj, size);
+	if (ret)
+		return ret;
 
 	huge_mnt = drm_gem_get_huge_mnt(dev);
 	if (huge_mnt)
@@ -215,11 +218,15 @@ EXPORT_SYMBOL(drm_gem_object_init);
  * Initialize an already allocated GEM object of the specified size with
  * no GEM provided backing store. Instead the caller is responsible for
  * backing the object and handling it.
+ *
+ * Returns:
+ * 0 on success, or a negative error code on failure.
  */
-void drm_gem_private_object_init(struct drm_device *dev,
-				 struct drm_gem_object *obj, size_t size)
+int drm_gem_private_object_init(struct drm_device *dev,
+				struct drm_gem_object *obj, size_t size)
 {
-	BUG_ON((size & (PAGE_SIZE - 1)) != 0);
+	if ((size & (PAGE_SIZE - 1)) != 0)
+		return -EINVAL;
 
 	obj->dev = dev;
 	obj->filp = NULL;
@@ -236,6 +243,8 @@ void drm_gem_private_object_init(struct drm_device *dev,
 
 	drm_vma_node_reset(&obj->vma_node);
 	INIT_LIST_HEAD(&obj->lru_node);
+
+	return 0;
 }
 EXPORT_SYMBOL(drm_gem_private_object_init);
 
diff --git a/drivers/gpu/drm/drm_gem_dma_helper.c b/drivers/gpu/drm/drm_gem_dma_helper.c
index 1c00a71ab3c9..fa354a36640b 100644
--- a/drivers/gpu/drm/drm_gem_dma_helper.c
+++ b/drivers/gpu/drm/drm_gem_dma_helper.c
@@ -92,7 +92,7 @@ __drm_gem_dma_create(struct drm_device *drm, size_t size, bool private)
 		gem_obj->funcs = &drm_gem_dma_default_funcs;
 
 	if (private) {
-		drm_gem_private_object_init(drm, gem_obj, size);
+		ret = drm_gem_private_object_init(drm, gem_obj, size);
 
 		/* Always use writecombine for dma-buf mappings */
 		dma_obj->map_noncoherent = false;
diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 76a8d7f252e0..9f910b0ed0b0 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -61,7 +61,7 @@ static int __drm_gem_shmem_init(struct drm_device *dev, struct drm_gem_shmem_obj
 		obj->funcs = &drm_gem_shmem_funcs;
 
 	if (private) {
-		drm_gem_private_object_init(dev, obj, size);
+		ret = drm_gem_private_object_init(dev, obj, size);
 		shmem->map_wc = false; /* dma-buf mappings use always writecombine */
 	} else {
 		ret = drm_gem_object_init(dev, obj, size);
diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
index d1c80ad3dead..ac1be020c6df 100644
--- a/drivers/gpu/drm/drm_gpuvm.c
+++ b/drivers/gpu/drm/drm_gpuvm.c
@@ -1060,13 +1060,18 @@ struct drm_gem_object *
 drm_gpuvm_resv_object_alloc(struct drm_device *drm)
 {
 	struct drm_gem_object *obj;
+	int ret;
 
 	obj = kzalloc_obj(*obj);
 	if (!obj)
 		return NULL;
 
 	obj->funcs = &drm_gpuvm_object_funcs;
-	drm_gem_private_object_init(drm, obj, 0);
+	ret = drm_gem_private_object_init(drm, obj, 0);
+	if (ret) {
+		kfree(obj);
+		return NULL;
+	}
 
 	return obj;
 }
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
index b0436a1e103f..94fa4d49f3fc 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
@@ -656,7 +656,11 @@ int etnaviv_gem_new_private(struct drm_device *dev, size_t size, u32 flags,
 	if (ret)
 		return ret;
 
-	drm_gem_private_object_init(dev, obj, size);
+	ret = drm_gem_private_object_init(dev, obj, size);
+	if (ret) {
+		kfree(to_etnaviv_bo(obj));
+		return ret;
+	}
 
 	*res = to_etnaviv_bo(obj);
 
diff --git a/drivers/gpu/drm/gma500/gem.c b/drivers/gpu/drm/gma500/gem.c
index 88f1e86c8903..11d0bb01f005 100644
--- a/drivers/gpu/drm/gma500/gem.c
+++ b/drivers/gpu/drm/gma500/gem.c
@@ -168,7 +168,9 @@ psb_gem_create(struct drm_device *dev, u64 size, const char *name, bool stolen,
 	obj->funcs = &psb_gem_object_funcs;
 
 	if (stolen) {
-		drm_gem_private_object_init(dev, obj, size);
+		ret = drm_gem_private_object_init(dev, obj, size);
+		if (ret)
+			goto err_release_resource;
 	} else {
 		ret = drm_gem_object_init(dev, obj, size);
 		if (ret)
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c b/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
index c824606497d2..65ce865a80e2 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
@@ -316,7 +316,10 @@ struct drm_gem_object *i915_gem_prime_import(struct drm_device *dev,
 		goto fail_detach;
 	}
 
-	drm_gem_private_object_init(dev, &obj->base, dma_buf->size);
+	ret = drm_gem_private_object_init(dev, &obj->base, dma_buf->size);
+	if (ret)
+		goto fail_free_obj;
+
 	i915_gem_object_init(obj, &i915_gem_object_dmabuf_ops, &lock_class,
 			     I915_BO_ALLOC_USER);
 	obj->base.import_attach = attach;
@@ -334,6 +337,8 @@ struct drm_gem_object *i915_gem_prime_import(struct drm_device *dev,
 
 	return &obj->base;
 
+fail_free_obj:
+	i915_gem_object_free(obj);
 fail_detach:
 	dma_buf_detach(dma_buf, attach);
 	dma_buf_put(dma_buf);
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_internal.c b/drivers/gpu/drm/i915/gem/i915_gem_internal.c
index 37d286ecb99b..191d63aaf0a9 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_internal.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_internal.c
@@ -142,6 +142,7 @@ __i915_gem_object_create_internal(struct drm_i915_private *i915,
 	static struct lock_class_key lock_class;
 	struct drm_i915_gem_object *obj;
 	unsigned int cache_level;
+	int ret;
 
 	GEM_BUG_ON(!size);
 	GEM_BUG_ON(!IS_ALIGNED(size, PAGE_SIZE));
@@ -153,7 +154,12 @@ __i915_gem_object_create_internal(struct drm_i915_private *i915,
 	if (!obj)
 		return ERR_PTR(-ENOMEM);
 
-	drm_gem_private_object_init(&i915->drm, &obj->base, size);
+	ret = drm_gem_private_object_init(&i915->drm, &obj->base, size);
+	if (ret) {
+		i915_gem_object_free(obj);
+		return ERR_PTR(ret);
+	}
+
 	i915_gem_object_init(obj, ops, &lock_class, 0);
 	obj->mem_flags |= I915_BO_FLAG_STRUCT_PAGE;
 
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index 06543ae60706..d1a6d72c57ec 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -508,8 +508,11 @@ static int __create_shmem(struct drm_i915_private *i915,
 	const vma_flags_t shmem_flags = mk_vma_flags(VMA_NORESERVE_BIT);
 	struct vfsmount *huge_mnt;
 	struct file *filp;
+	int ret;
 
-	drm_gem_private_object_init(&i915->drm, obj, size);
+	ret = drm_gem_private_object_init(&i915->drm, obj, size);
+	if (ret)
+		return ret;
 
 	/* XXX: The __shmem_file_setup() function returns -EINVAL if size is
 	 * greater than MAX_LFS_FILESIZE.
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_stolen.c b/drivers/gpu/drm/i915/gem/i915_gem_stolen.c
index 1cfdcf5c1118..e39e82ec9237 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_stolen.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_stolen.c
@@ -737,7 +737,10 @@ static int __i915_gem_object_create_stolen(struct intel_memory_region *mem,
 	 */
 	flags = I915_BO_ALLOC_CONTIGUOUS;
 
-	drm_gem_private_object_init(&mem->i915->drm, &obj->base, stolen->size);
+	err = drm_gem_private_object_init(&mem->i915->drm, &obj->base, stolen->size);
+	if (err)
+		return err;
+
 	i915_gem_object_init(obj, &i915_gem_object_stolen_ops, &lock_class, flags);
 
 	obj->stolen = stolen;
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
index df3fcc2b1248..ae7394be54a0 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
@@ -1301,7 +1301,10 @@ int __i915_gem_ttm_object_init(struct intel_memory_region *mem,
 	enum ttm_bo_type bo_type;
 	int ret;
 
-	drm_gem_private_object_init(&i915->drm, &obj->base, size);
+	ret = drm_gem_private_object_init(&i915->drm, &obj->base, size);
+	if (ret)
+		return ret;
+
 	i915_gem_object_init(obj, &i915_gem_ttm_obj_ops, &lock_class, flags);
 
 	obj->bo_offset = offset;
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
index 043095f93ac6..1a2f9a058d55 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
@@ -521,7 +521,12 @@ i915_gem_userptr_ioctl(struct drm_device *dev,
 	if (obj == NULL)
 		return -ENOMEM;
 
-	drm_gem_private_object_init(dev, &obj->base, args->user_size);
+	ret = drm_gem_private_object_init(dev, &obj->base, args->user_size);
+	if (ret) {
+		i915_gem_object_free(obj);
+		return ret;
+	}
+
 	i915_gem_object_init(obj, &i915_gem_userptr_ops, &lock_class,
 			     I915_BO_ALLOC_USER);
 	obj->mem_flags = I915_BO_FLAG_STRUCT_PAGE;
diff --git a/drivers/gpu/drm/i915/gem/selftests/huge_gem_object.c b/drivers/gpu/drm/i915/gem/selftests/huge_gem_object.c
index 8caaf325e56a..fdc0186e8045 100644
--- a/drivers/gpu/drm/i915/gem/selftests/huge_gem_object.c
+++ b/drivers/gpu/drm/i915/gem/selftests/huge_gem_object.c
@@ -105,6 +105,7 @@ huge_gem_object(struct drm_i915_private *i915,
 	static struct lock_class_key lock_class;
 	struct drm_i915_gem_object *obj;
 	unsigned int cache_level;
+	int ret;
 
 	GEM_BUG_ON(!phys_size || phys_size > dma_size);
 	GEM_BUG_ON(!IS_ALIGNED(phys_size, PAGE_SIZE));
@@ -117,7 +118,12 @@ huge_gem_object(struct drm_i915_private *i915,
 	if (!obj)
 		return ERR_PTR(-ENOMEM);
 
-	drm_gem_private_object_init(&i915->drm, &obj->base, dma_size);
+	ret = drm_gem_private_object_init(&i915->drm, &obj->base, dma_size);
+	if (ret) {
+		i915_gem_object_free(obj);
+		return ERR_PTR(ret);
+	}
+
 	i915_gem_object_init(obj, &huge_ops, &lock_class, 0);
 	obj->mem_flags |= I915_BO_FLAG_STRUCT_PAGE;
 
diff --git a/drivers/gpu/drm/i915/gem/selftests/huge_pages.c b/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
index 44718e728291..a76f38ae9335 100644
--- a/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
+++ b/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
@@ -178,6 +178,7 @@ huge_pages_object(struct drm_i915_private *i915,
 	static struct lock_class_key lock_class;
 	struct drm_i915_gem_object *obj;
 	unsigned int cache_level;
+	int ret;
 
 	GEM_BUG_ON(!size);
 	GEM_BUG_ON(!IS_ALIGNED(size, BIT(__ffs(page_mask))));
@@ -192,7 +193,12 @@ huge_pages_object(struct drm_i915_private *i915,
 	if (!obj)
 		return ERR_PTR(-ENOMEM);
 
-	drm_gem_private_object_init(&i915->drm, &obj->base, size);
+	ret = drm_gem_private_object_init(&i915->drm, &obj->base, size);
+	if (ret) {
+		i915_gem_object_free(obj);
+		return ERR_PTR(ret);
+	}
+
 	i915_gem_object_init(obj, &huge_page_ops, &lock_class, 0);
 	obj->mem_flags |= I915_BO_FLAG_STRUCT_PAGE;
 	i915_gem_object_set_volatile(obj);
@@ -329,6 +335,7 @@ fake_huge_pages_object(struct drm_i915_private *i915, u64 size, bool single)
 {
 	static struct lock_class_key lock_class;
 	struct drm_i915_gem_object *obj;
+	int ret;
 
 	GEM_BUG_ON(!size);
 	GEM_BUG_ON(!IS_ALIGNED(size, I915_GTT_PAGE_SIZE));
@@ -343,7 +350,11 @@ fake_huge_pages_object(struct drm_i915_private *i915, u64 size, bool single)
 	if (!obj)
 		return ERR_PTR(-ENOMEM);
 
-	drm_gem_private_object_init(&i915->drm, &obj->base, size);
+	ret = drm_gem_private_object_init(&i915->drm, &obj->base, size);
+	if (ret) {
+		i915_gem_object_free(obj);
+		return ERR_PTR(ret);
+	}
 
 	if (single)
 		i915_gem_object_init(obj, &fake_ops_single, &lock_class, 0);
diff --git a/drivers/gpu/drm/i915/gvt/dmabuf.c b/drivers/gpu/drm/i915/gvt/dmabuf.c
index 8a1d6c5636c2..5b198162c588 100644
--- a/drivers/gpu/drm/i915/gvt/dmabuf.c
+++ b/drivers/gpu/drm/i915/gvt/dmabuf.c
@@ -202,13 +202,19 @@ static struct drm_i915_gem_object *vgpu_create_gem(struct drm_device *dev,
 	static struct lock_class_key lock_class;
 	struct drm_i915_private *dev_priv = to_i915(dev);
 	struct drm_i915_gem_object *obj;
+	int ret;
 
 	obj = i915_gem_object_alloc();
 	if (obj == NULL)
 		return NULL;
 
-	drm_gem_private_object_init(dev, &obj->base,
+	ret = drm_gem_private_object_init(dev, &obj->base,
 		roundup(info->size, PAGE_SIZE));
+	if (ret) {
+		i915_gem_object_free(obj);
+		return NULL;
+	}
+
 	i915_gem_object_init(obj, &intel_vgpu_gem_ops, &lock_class, 0);
 	i915_gem_object_set_readonly(obj);
 
diff --git a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
index e6bd06774816..7eb254a0be57 100644
--- a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
+++ b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
@@ -128,7 +128,11 @@ fake_dma_object(struct drm_i915_private *i915, u64 size)
 	if (!obj)
 		goto err;
 
-	drm_gem_private_object_init(&i915->drm, &obj->base, size);
+	if (drm_gem_private_object_init(&i915->drm, &obj->base, size)) {
+		i915_gem_object_free(obj);
+		goto err;
+	}
+
 	i915_gem_object_init(obj, &fake_ops, &lock_class, 0);
 
 	i915_gem_object_set_volatile(obj);
diff --git a/drivers/gpu/drm/i915/selftests/mock_region.c b/drivers/gpu/drm/i915/selftests/mock_region.c
index 6324eb32d4dd..8bee0df1def9 100644
--- a/drivers/gpu/drm/i915/selftests/mock_region.c
+++ b/drivers/gpu/drm/i915/selftests/mock_region.c
@@ -66,11 +66,15 @@ static int mock_object_init(struct intel_memory_region *mem,
 {
 	static struct lock_class_key lock_class;
 	struct drm_i915_private *i915 = mem->i915;
+	int ret;
 
 	if (size > resource_size(&mem->region))
 		return -E2BIG;
 
-	drm_gem_private_object_init(&i915->drm, &obj->base, size);
+	ret = drm_gem_private_object_init(&i915->drm, &obj->base, size);
+	if (ret)
+		return ret;
+
 	i915_gem_object_init(obj, &mock_region_obj_ops, &lock_class, flags);
 
 	obj->bo_offset = offset;
diff --git a/drivers/gpu/drm/imagination/pvr_vm.c b/drivers/gpu/drm/imagination/pvr_vm.c
index 396d349fb6ce..a3bc64e56728 100644
--- a/drivers/gpu/drm/imagination/pvr_vm.c
+++ b/drivers/gpu/drm/imagination/pvr_vm.c
@@ -585,7 +585,10 @@ pvr_vm_create_context(struct pvr_device *pvr_dev, bool is_userspace_context)
 			goto err_page_table_destroy;
 	}
 
-	drm_gem_private_object_init(&pvr_dev->base, &vm_ctx->dummy_gem, 0);
+	err = drm_gem_private_object_init(&pvr_dev->base, &vm_ctx->dummy_gem, 0);
+	if (err)
+		goto err_fw_object_destroy;
+
 	drm_gpuvm_init(&vm_ctx->gpuvm_mgr,
 		       is_userspace_context ? "PowerVR-user-VM" : "PowerVR-FW-VM",
 		       0, &pvr_dev->base, &vm_ctx->dummy_gem,
@@ -596,6 +599,9 @@ pvr_vm_create_context(struct pvr_device *pvr_dev, bool is_userspace_context)
 
 	return vm_ctx;
 
+err_fw_object_destroy:
+	if (is_userspace_context)
+		pvr_fw_object_destroy(vm_ctx->fw_mem_ctx_obj);
 err_page_table_destroy:
 	pvr_mmu_context_destroy(vm_ctx->mmu_ctx);
 
diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 81ebb1e1094c..c3e95194b24f 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -1296,7 +1296,11 @@ struct drm_gem_object *msm_gem_import(struct drm_device *dev,
 	if (ret)
 		return ERR_PTR(ret);
 
-	drm_gem_private_object_init(dev, obj, size);
+	ret = drm_gem_private_object_init(dev, obj, size);
+	if (ret) {
+		kfree(to_msm_bo(obj));
+		return ERR_PTR(ret);
+	}
 
 	npages = size / PAGE_SIZE;
 
diff --git a/drivers/gpu/drm/omapdrm/omap_gem.c b/drivers/gpu/drm/omapdrm/omap_gem.c
index 8e013e4f2c6b..364d29686c46 100644
--- a/drivers/gpu/drm/omapdrm/omap_gem.c
+++ b/drivers/gpu/drm/omapdrm/omap_gem.c
@@ -1348,7 +1348,9 @@ struct drm_gem_object *omap_gem_new(struct drm_device *dev,
 
 	/* Initialize the GEM object. */
 	if (!(flags & OMAP_BO_MEM_SHMEM)) {
-		drm_gem_private_object_init(dev, obj, size);
+		ret = drm_gem_private_object_init(dev, obj, size);
+		if (ret)
+			goto err_free;
 	} else {
 		ret = drm_gem_object_init(dev, obj, size);
 		if (ret)
diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
index 2de24f1b6018..cb3935ace1e6 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.c
+++ b/drivers/gpu/drm/panthor/panthor_gem.c
@@ -1047,7 +1047,11 @@ panthor_gem_prime_import_sg_table(struct drm_device *dev,
 	if (IS_ERR(bo))
 		return ERR_CAST(bo);
 
-	drm_gem_private_object_init(dev, &bo->base, attach->dmabuf->size);
+	ret = drm_gem_private_object_init(dev, &bo->base, attach->dmabuf->size);
+	if (ret) {
+		kfree(bo);
+		return ERR_PTR(ret);
+	}
 
 	ret = drm_gem_create_mmap_offset(&bo->base);
 	if (ret)
diff --git a/drivers/gpu/drm/radeon/radeon_object.c b/drivers/gpu/drm/radeon/radeon_object.c
index a0fc0801abb0..c7557c39ead0 100644
--- a/drivers/gpu/drm/radeon/radeon_object.c
+++ b/drivers/gpu/drm/radeon/radeon_object.c
@@ -150,7 +150,11 @@ int radeon_bo_create(struct radeon_device *rdev,
 	bo = kzalloc(sizeof(struct radeon_bo), GFP_KERNEL);
 	if (bo == NULL)
 		return -ENOMEM;
-	drm_gem_private_object_init(rdev_to_drm(rdev), &bo->tbo.base, size);
+	r = drm_gem_private_object_init(rdev_to_drm(rdev), &bo->tbo.base, size);
+	if (r) {
+		kfree(bo);
+		return r;
+	}
 	bo->tbo.base.funcs = &radeon_gem_object_funcs;
 	bo->rdev = rdev;
 	bo->surface_reg = -1;
diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c
index 9228a7ad0dfa..977ceb4462bd 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c
@@ -389,7 +389,11 @@ struct drm_gem_object *rcar_du_gem_prime_import_sg_table(struct drm_device *dev,
 	gem_obj = &dma_obj->base;
 	gem_obj->funcs = &rcar_du_gem_funcs;
 
-	drm_gem_private_object_init(dev, gem_obj, attach->dmabuf->size);
+	ret = drm_gem_private_object_init(dev, gem_obj, attach->dmabuf->size);
+	if (ret) {
+		kfree(dma_obj);
+		return ERR_PTR(ret);
+	}
 	dma_obj->map_noncoherent = false;
 
 	ret = drm_gem_create_mmap_offset(gem_obj);
diff --git a/drivers/gpu/drm/tests/drm_exec_test.c b/drivers/gpu/drm/tests/drm_exec_test.c
index 2fc47f3b463b..b4427484da26 100644
--- a/drivers/gpu/drm/tests/drm_exec_test.c
+++ b/drivers/gpu/drm/tests/drm_exec_test.c
@@ -56,7 +56,8 @@ static void test_lock(struct kunit *test)
 	struct drm_exec exec;
 	int ret;
 
-	drm_gem_private_object_init(priv->drm, &gobj, PAGE_SIZE);
+	ret = drm_gem_private_object_init(priv->drm, &gobj, PAGE_SIZE);
+	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
 	drm_exec_until_all_locked(&exec) {
@@ -76,7 +77,8 @@ static void test_lock_unlock(struct kunit *test)
 	struct drm_exec exec;
 	int ret;
 
-	drm_gem_private_object_init(priv->drm, &gobj, PAGE_SIZE);
+	ret = drm_gem_private_object_init(priv->drm, &gobj, PAGE_SIZE);
+	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
 	drm_exec_until_all_locked(&exec) {
@@ -103,7 +105,8 @@ static void test_duplicates(struct kunit *test)
 	struct drm_exec exec;
 	int ret;
 
-	drm_gem_private_object_init(priv->drm, &gobj, PAGE_SIZE);
+	ret = drm_gem_private_object_init(priv->drm, &gobj, PAGE_SIZE);
+	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
 	drm_exec_until_all_locked(&exec) {
@@ -130,7 +133,8 @@ static void test_prepare(struct kunit *test)
 	struct drm_exec exec;
 	int ret;
 
-	drm_gem_private_object_init(priv->drm, &gobj, PAGE_SIZE);
+	ret = drm_gem_private_object_init(priv->drm, &gobj, PAGE_SIZE);
+	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
 	drm_exec_until_all_locked(&exec) {
@@ -162,8 +166,10 @@ static void test_prepare_array(struct kunit *test)
 		return;
 	}
 
-	drm_gem_private_object_init(priv->drm, gobj1, PAGE_SIZE);
-	drm_gem_private_object_init(priv->drm, gobj2, PAGE_SIZE);
+	ret = drm_gem_private_object_init(priv->drm, gobj1, PAGE_SIZE);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	ret = drm_gem_private_object_init(priv->drm, gobj2, PAGE_SIZE);
+	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
 	drm_exec_until_all_locked(&exec)
diff --git a/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c b/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
index 56ad8ef32584..bb430763e7a5 100644
--- a/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
+++ b/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
@@ -119,7 +119,8 @@ static void ttm_bo_init_reserved_sys_man(struct kunit *test)
 	place = ttm_place_kunit_init(test, TTM_PL_SYSTEM, 0);
 	placement = ttm_placement_kunit_init(test, place, 1);
 
-	drm_gem_private_object_init(priv->drm, &bo->base, size);
+	err = drm_gem_private_object_init(priv->drm, &bo->base, size);
+	KUNIT_ASSERT_EQ(test, err, 0);
 
 	err = ttm_bo_init_reserved(priv->ttm_dev, bo, bo_type, placement,
 				   PAGE_SIZE, &ctx, NULL, NULL,
@@ -168,7 +169,8 @@ static void ttm_bo_init_reserved_mock_man(struct kunit *test)
 	place = ttm_place_kunit_init(test, mem_type, 0);
 	placement = ttm_placement_kunit_init(test, place, 1);
 
-	drm_gem_private_object_init(priv->drm, &bo->base, size);
+	err = drm_gem_private_object_init(priv->drm, &bo->base, size);
+	KUNIT_ASSERT_EQ(test, err, 0);
 
 	err = ttm_bo_init_reserved(priv->ttm_dev, bo, bo_type, placement,
 				   PAGE_SIZE, &ctx, NULL, NULL,
@@ -208,7 +210,8 @@ static void ttm_bo_init_reserved_resv(struct kunit *test)
 	place = ttm_place_kunit_init(test, TTM_PL_SYSTEM, 0);
 	placement = ttm_placement_kunit_init(test, place, 1);
 
-	drm_gem_private_object_init(priv->drm, &bo->base, size);
+	err = drm_gem_private_object_init(priv->drm, &bo->base, size);
+	KUNIT_ASSERT_EQ(test, err, 0);
 	dma_resv_init(&resv);
 	dma_resv_lock(&resv, NULL);
 
@@ -244,7 +247,8 @@ static void ttm_bo_validate_basic(struct kunit *test)
 	bo = kunit_kzalloc(test, sizeof(*bo), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, bo);
 
-	drm_gem_private_object_init(priv->drm, &bo->base, size);
+	err = drm_gem_private_object_init(priv->drm, &bo->base, size);
+	KUNIT_ASSERT_EQ(test, err, 0);
 
 	err = ttm_bo_init_reserved(priv->ttm_dev, bo, params->bo_type,
 				   fst_placement, PAGE_SIZE, &ctx_init, NULL,
@@ -390,7 +394,8 @@ static void ttm_bo_validate_same_placement(struct kunit *test)
 	bo = kunit_kzalloc(test, sizeof(*bo), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, bo);
 
-	drm_gem_private_object_init(priv->drm, &bo->base, size);
+	err = drm_gem_private_object_init(priv->drm, &bo->base, size);
+	KUNIT_ASSERT_EQ(test, err, 0);
 
 	err = ttm_bo_init_reserved(priv->ttm_dev, bo, params->bo_type,
 				   placement, PAGE_SIZE, &ctx_init, NULL,
@@ -431,7 +436,8 @@ static void ttm_bo_validate_busy_placement(struct kunit *test)
 	bo = kunit_kzalloc(test, sizeof(*bo), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, bo);
 
-	drm_gem_private_object_init(priv->drm, &bo->base, size);
+	err = drm_gem_private_object_init(priv->drm, &bo->base, size);
+	KUNIT_ASSERT_EQ(test, err, 0);
 
 	err = ttm_bo_init_reserved(priv->ttm_dev, bo, bo_type, placement_init,
 				   PAGE_SIZE, &ctx_init, NULL, NULL,
@@ -478,7 +484,8 @@ static void ttm_bo_validate_multihop(struct kunit *test)
 	bo = kunit_kzalloc(test, sizeof(*bo), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, bo);
 
-	drm_gem_private_object_init(priv->drm, &bo->base, size);
+	err = drm_gem_private_object_init(priv->drm, &bo->base, size);
+	KUNIT_ASSERT_EQ(test, err, 0);
 
 	err = ttm_bo_init_reserved(priv->ttm_dev, bo, params->bo_type,
 				   placement_init, PAGE_SIZE, &ctx_init, NULL,
@@ -717,7 +724,8 @@ static void ttm_bo_validate_move_fence_not_signaled(struct kunit *test)
 	bo = kunit_kzalloc(test, sizeof(*bo), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, bo);
 
-	drm_gem_private_object_init(priv->drm, &bo->base, size);
+	err = drm_gem_private_object_init(priv->drm, &bo->base, size);
+	KUNIT_ASSERT_EQ(test, err, 0);
 
 	err = ttm_bo_init_reserved(priv->ttm_dev, bo, bo_type, placement_init,
 				   PAGE_SIZE, &ctx_init, NULL, NULL,
@@ -782,7 +790,8 @@ static void ttm_bo_validate_swapout(struct kunit *test)
 	bo = kunit_kzalloc(test, sizeof(*bo), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, bo);
 
-	drm_gem_private_object_init(priv->drm, &bo->base, MANAGER_SIZE);
+	err = drm_gem_private_object_init(priv->drm, &bo->base, MANAGER_SIZE);
+	KUNIT_ASSERT_EQ(test, err, 0);
 	err = ttm_bo_init_reserved(priv->ttm_dev, bo, bo_type, placement,
 				   PAGE_SIZE, &ctx_init, NULL, NULL,
 				   &dummy_ttm_bo_destroy);
@@ -826,7 +835,8 @@ static void ttm_bo_validate_happy_evict(struct kunit *test)
 
 	memset(bos, 0, sizeof(*bos) * bo_no);
 	for (i = 0; i < bo_no; i++) {
-		drm_gem_private_object_init(priv->drm, &bos[i].base, bo_sizes[i]);
+		err = drm_gem_private_object_init(priv->drm, &bos[i].base, bo_sizes[i]);
+		KUNIT_ASSERT_EQ(test, err, 0);
 		err = ttm_bo_init_reserved(priv->ttm_dev, &bos[i], bo_type, placement,
 					   PAGE_SIZE, &ctx_init, NULL, NULL,
 					   &dummy_ttm_bo_destroy);
@@ -875,7 +885,8 @@ static void ttm_bo_validate_all_pinned_evict(struct kunit *test)
 	bo_big = kunit_kzalloc(test, sizeof(*bo_big), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, bo_big);
 
-	drm_gem_private_object_init(priv->drm, &bo_big->base, MANAGER_SIZE);
+	err = drm_gem_private_object_init(priv->drm, &bo_big->base, MANAGER_SIZE);
+	KUNIT_ASSERT_EQ(test, err, 0);
 	err = ttm_bo_init_reserved(priv->ttm_dev, bo_big, bo_type, placement,
 				   PAGE_SIZE, &ctx_init, NULL, NULL,
 				   &dummy_ttm_bo_destroy);
@@ -926,7 +937,8 @@ static void ttm_bo_validate_allowed_only_evict(struct kunit *test)
 	bo_pinned = kunit_kzalloc(test, sizeof(*bo_pinned), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, bo_pinned);
 
-	drm_gem_private_object_init(priv->drm, &bo_pinned->base, size);
+	err = drm_gem_private_object_init(priv->drm, &bo_pinned->base, size);
+	KUNIT_ASSERT_EQ(test, err, 0);
 	err = ttm_bo_init_reserved(priv->ttm_dev, bo_pinned, bo_type, placement,
 				   PAGE_SIZE, &ctx_init, NULL, NULL,
 				   &dummy_ttm_bo_destroy);
@@ -937,7 +949,8 @@ static void ttm_bo_validate_allowed_only_evict(struct kunit *test)
 	bo_evictable = kunit_kzalloc(test, sizeof(*bo_evictable), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, bo_evictable);
 
-	drm_gem_private_object_init(priv->drm, &bo_evictable->base, size);
+	err = drm_gem_private_object_init(priv->drm, &bo_evictable->base, size);
+	KUNIT_ASSERT_EQ(test, err, 0);
 	err = ttm_bo_init_reserved(priv->ttm_dev, bo_evictable, bo_type, placement,
 				   PAGE_SIZE, &ctx_init, NULL, NULL,
 				   &dummy_ttm_bo_destroy);
@@ -991,7 +1004,8 @@ static void ttm_bo_validate_deleted_evict(struct kunit *test)
 	bo_big = kunit_kzalloc(test, sizeof(*bo_big), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, bo_big);
 
-	drm_gem_private_object_init(priv->drm, &bo_big->base, big);
+	err = drm_gem_private_object_init(priv->drm, &bo_big->base, big);
+	KUNIT_ASSERT_EQ(test, err, 0);
 	err = ttm_bo_init_reserved(priv->ttm_dev, bo_big, bo_type, placement,
 				   PAGE_SIZE, &ctx_init, NULL, NULL,
 				   &dummy_ttm_bo_destroy);
@@ -1048,7 +1062,8 @@ static void ttm_bo_validate_busy_domain_evict(struct kunit *test)
 	bo_init = kunit_kzalloc(test, sizeof(*bo_init), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, bo_init);
 
-	drm_gem_private_object_init(priv->drm, &bo_init->base, MANAGER_SIZE);
+	err = drm_gem_private_object_init(priv->drm, &bo_init->base, MANAGER_SIZE);
+	KUNIT_ASSERT_EQ(test, err, 0);
 	err = ttm_bo_init_reserved(priv->ttm_dev, bo_init, bo_type, placement,
 				   PAGE_SIZE, &ctx_init, NULL, NULL,
 				   &dummy_ttm_bo_destroy);
@@ -1092,7 +1107,8 @@ static void ttm_bo_validate_evict_gutting(struct kunit *test)
 	bo_evict = kunit_kzalloc(test, sizeof(*bo_evict), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, bo_evict);
 
-	drm_gem_private_object_init(priv->drm, &bo_evict->base, MANAGER_SIZE);
+	err = drm_gem_private_object_init(priv->drm, &bo_evict->base, MANAGER_SIZE);
+	KUNIT_ASSERT_EQ(test, err, 0);
 	err = ttm_bo_init_reserved(priv->ttm_dev, bo_evict, bo_type, placement,
 				   PAGE_SIZE, &ctx_init, NULL, NULL,
 				   &dummy_ttm_bo_destroy);
@@ -1143,14 +1159,16 @@ static void ttm_bo_validate_recrusive_evict(struct kunit *test)
 	bo_mock = kunit_kzalloc(test, sizeof(*bo_mock), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, bo_mock);
 
-	drm_gem_private_object_init(priv->drm, &bo_tt->base, MANAGER_SIZE);
+	err = drm_gem_private_object_init(priv->drm, &bo_tt->base, MANAGER_SIZE);
+	KUNIT_ASSERT_EQ(test, err, 0);
 	err = ttm_bo_init_reserved(priv->ttm_dev, bo_tt, bo_type, placement_tt,
 				   PAGE_SIZE, &ctx_init, NULL, NULL,
 				   &dummy_ttm_bo_destroy);
 	KUNIT_EXPECT_EQ(test, err, 0);
 	dma_resv_unlock(bo_tt->base.resv);
 
-	drm_gem_private_object_init(priv->drm, &bo_mock->base, MANAGER_SIZE);
+	err = drm_gem_private_object_init(priv->drm, &bo_mock->base, MANAGER_SIZE);
+	KUNIT_ASSERT_EQ(test, err, 0);
 	err = ttm_bo_init_reserved(priv->ttm_dev, bo_mock, bo_type, placement_mock,
 				   PAGE_SIZE, &ctx_init, NULL, NULL,
 				   &dummy_ttm_bo_destroy);
diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c b/drivers/gpu/drm/virtio/virtgpu_prime.c
index 79964b436243..752f2369d73b 100644
--- a/drivers/gpu/drm/virtio/virtgpu_prime.c
+++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
@@ -363,7 +363,11 @@ struct drm_gem_object *virtgpu_gem_prime_import(struct drm_device *dev,
 	obj = &bo->base.base;
 	drm_gem_object_set_resv(obj, buf->resv);
 	obj->funcs = &virtgpu_gem_dma_buf_funcs;
-	drm_gem_private_object_init(dev, obj, buf->size);
+	ret = drm_gem_private_object_init(dev, obj, buf->size);
+	if (ret) {
+		kfree(bo);
+		return ERR_PTR(ret);
+	}
 
 	attach = dma_buf_dynamic_attach(buf, dev->dev,
 					&virtgpu_dma_buf_attach_ops, obj);
diff --git a/drivers/gpu/drm/virtio/virtgpu_vram.c b/drivers/gpu/drm/virtio/virtgpu_vram.c
index e2e799b42c61..eec843f6701f 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vram.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vram.c
@@ -211,7 +211,11 @@ int virtio_gpu_vram_create(struct virtio_gpu_device *vgdev,
 	INIT_LIST_HEAD(&vram->base.restore_node);
 
 	params->size = PAGE_ALIGN(params->size);
-	drm_gem_private_object_init(vgdev->ddev, obj, params->size);
+	ret = drm_gem_private_object_init(vgdev->ddev, obj, params->size);
+	if (ret) {
+		kfree(vram);
+		return ret;
+	}
 
 	/* Create fake offset */
 	ret = drm_gem_create_mmap_offset(obj);
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
index 9c7a73c0b0dc..e4e4b87e738d 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
@@ -426,7 +426,9 @@ static int vmw_bo_init(struct vmw_private *dev_priv,
 	atomic_set(&vmw_bo->map_count, 0);
 
 	params->size = ALIGN(params->size, PAGE_SIZE);
-	drm_gem_private_object_init(vdev, &vmw_bo->tbo.base, params->size);
+	ret = drm_gem_private_object_init(vdev, &vmw_bo->tbo.base, params->size);
+	if (ret)
+		return ret;
 
 	vmw_bo_placement_set(vmw_bo, params->domain, params->busy_domain);
 	ret = ttm_bo_init_reserved(bdev, &vmw_bo->tbo, params->bo_type,
diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 85e6d9a0f575..41b404cdd680 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -2363,7 +2363,9 @@ struct xe_bo *xe_bo_init_locked(struct xe_device *xe, struct xe_bo *bo,
 	/* Initialize purge advisory state */
 	bo->purgeable.state = XE_MADV_PURGEABLE_WILLNEED;
 
-	drm_gem_private_object_init(&xe->drm, &bo->ttm.base, size);
+	err = drm_gem_private_object_init(&xe->drm, &bo->ttm.base, size);
+	if (err)
+		return ERR_PTR(err);
 
 	if (resv) {
 		ctx.allow_res_evict = !(flags & XE_BO_FLAG_NO_RESV_EVICT);
diff --git a/drivers/gpu/drm/xe/xe_mmio_gem.c b/drivers/gpu/drm/xe/xe_mmio_gem.c
index 8c803ef233cc..c1fb4da22f03 100644
--- a/drivers/gpu/drm/xe/xe_mmio_gem.c
+++ b/drivers/gpu/drm/xe/xe_mmio_gem.c
@@ -86,7 +86,11 @@ struct xe_mmio_gem *xe_mmio_gem_create(struct xe_device *xe, struct drm_file *fi
 	base->funcs = &xe_mmio_gem_funcs;
 	obj->phys_addr = phys_addr;
 
-	drm_gem_private_object_init(&xe->drm, base, size);
+	err = drm_gem_private_object_init(&xe->drm, base, size);
+	if (err) {
+		kfree(obj);
+		return ERR_PTR(err);
+	}
 
 	err = drm_gem_create_mmap_offset(base);
 	if (err)
diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index 09f5ec28218a..f889232e8525 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -526,8 +526,8 @@ void drm_gem_object_release(struct drm_gem_object *obj);
 void drm_gem_object_free(struct kref *kref);
 int drm_gem_object_init(struct drm_device *dev,
 			struct drm_gem_object *obj, size_t size);
-void drm_gem_private_object_init(struct drm_device *dev,
-				 struct drm_gem_object *obj, size_t size);
+int drm_gem_private_object_init(struct drm_device *dev,
+				struct drm_gem_object *obj, size_t size);
 void drm_gem_private_object_fini(struct drm_gem_object *obj);
 struct dma_resv *drm_gem_object_set_resv(struct drm_gem_object *obj,
 					  struct dma_resv *resv);
-- 
2.43.0

