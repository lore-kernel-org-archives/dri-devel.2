Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54160C79F95
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 13:44:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DD6A10F624;
	Thu,  3 Sep 2026 13:44:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CyhYZt75";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4CD310F618
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 13:44:23 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-49b8ce9b733so17747245e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 06:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788443062; x=1789047862; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+D94IVhV0jPQG1E/Q7YgWF8UlhHboHO5XUp1Tpas8v4=;
 b=CyhYZt75KMQ8l0w75wDdgotZyEmqP5hG1LOPxxVM0PrPzFMe8XHxsMFVuwJ+or/EcR
 oFrXHWGb8ctZq5YUK/QQlN9fasqa/ROYVEGKVhXXmJqI/GMJ8XlEcLOk9e88FJfthyET
 gohP9v8TX3u7y1+qNh/bQkf8xm0DA3SGqg8FtxxaXyMWP9D/0lVABkMcIpa6eYn7apun
 yh0uQxOig41aWRxRVcggu5Hr3Iz9xeg2JnBt3Jwjvrey93wAPFXdPXZb2GTpFJEev5BH
 YSZ05nLdpmGd3Di9fNfza+h5T+JaOIDiKeZYGy90DzAvMrxfHOiywVL4OVNJzFJnqOm0
 ulTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788443062; x=1789047862;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+D94IVhV0jPQG1E/Q7YgWF8UlhHboHO5XUp1Tpas8v4=;
 b=jYoJ0qvyIy+Ri+U3Wuek0P9hjWEX7PDNvC6B1OYqafqDZ4CpCGfOBAbEUen1ulfmSP
 WMbkIOZOGWKlEjlGYQkn17IYyBW0caFvyxFcpoVPxDdZQR5tcrkoxvfP/jb8a8EgOz5r
 CUAnPwdCnhQaGaVPQtcSKdQEm3AksL73ZiZk/raPB3+AC8TIFB9CJSKe2DkE3/opLBvw
 reXWngJzlMReXRCmL0DjOpr/m6v3IdtvcrfhCOY0r/wQSNBzPAmOYcFGxOoH2Jtq9p3g
 XZjE5e/SBPck72Y0aM3vn2EGnC8cpUtAtxsn/ePZ1bM1GqvFK+Wo9CevoaLM+3A6nXJ7
 OEqQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByq3rOUtmf07YhJcO7D1PIkWFnZ9XRkYrtaPX0YSadBwi1PVnHl0nSrw1fDRq5LnMI1RbqWosBBfsw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mbiAKhrvL5YqeVjl641JR71dVL50Ppx5ygBacGReUg+FWDjlb5
 kaIGAUIBHqD8F437PKaZwFJJHMP57aSD3vSpemFkKHPhLuwYk1vWO96Z
X-Gm-Gg: AYBFou0GrJHpylh5/mevlsZ29gRBKWwNQLk4FKGqcWe+AjzedlaYO7xCzIz2DsSSx9c
 0eLBjmgaY2G9eUIND4yFl9gT+XTHd5CFOwkyNiGlEaDzI+ysTJBhOn4wL1sp9P0m7SmiMXoOon5
 uX321i/IPLmtwQ8d3r27Z/Db/++qdeDEsx1VtBlNLnh1AjMHGFBHQkw3B0ZlxQTMncxpTRNZ79t
 o4U9C/80gMnmhGyv+zyQB8qqTfTZ0D0gFstZgiiTq+aEc/5+dLkhn0yMqM7+baiTxEinK3wZ+BH
 4GEEJeczcVXKwG+Z2aUAznQSB2wo+IHMJQFOd58mdY23qh8/08Dhij+Kq1Sxgp0dw2zIaFUDFsF
 OVvB4s4OIH7n4zyXTG3uJmtZV2emLoDLMM69FGkUwBfLtoC3cmtOmAPqJAarr+rzDJBQ7sC4qVC
 0lRbWQmCQnXIUfRCUTS3tNDWTknEG8ohVYGSovZas2qmidej5Ih5Lc2+ShTrDs/kQQbvrSTLQyZ
 EwTrHBsH7fP
X-Received: by 2002:a05:600c:4693:b0:499:484a:81d0 with SMTP id
 5b1f17b1804b1-49ce5817d63mr188523005e9.9.1788443061988; 
 Thu, 03 Sep 2026 06:44:21 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15d9:4700:e712:9f38:603a:54e4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448e736a6sm13597080f8f.5.2026.09.03.06.44.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 06:44:21 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: thomas.hellstrom@linux.intel.com, dakr@kernel.org, ecourtney@nvidia.com,
 matthew.brost@intel.com, nat@pixelcluster.dev,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/11] drm/gem: Use dynamic allocation for GEM object dma_resv
Date: Thu,  3 Sep 2026 15:28:05 +0200
Message-ID: <20260903134408.105317-11-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903134408.105317-1-christian.koenig@amd.com>
References: <20260903134408.105317-1-christian.koenig@amd.com>
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

Remove the embedded dma_resv (_resv) from struct drm_gem_object and use
dynamically allocated reservations instead. This change aligns with the
new reference counted dma_resv infrastructure and reduces the size of
drm_gem_object.

In drm_gem_private_object_init(), when no external resv is provided,
allocate a new dma_resv using dma_resv_alloc() instead of initializing
the embedded _resv field. This allows proper error handling if the
allocation fails, returning -ENOMEM to the caller.

The corresponding cleanup in drm_gem_private_object_fini() is simplified
to only put the resv pointer, removing the redundant put on _resv.

For TTM buffer objects, add an individual_resv field to track the
dynamically allocated reservation object for proper cleanup during
destruction. This ensures we can distinguish between shared and
individual reservations when freeing resources.

This change builds on the previous work to make drm_gem_private_object_init()
return an error code, now utilizing that capability to handle allocation
failures properly.

Signed-off-by: Christian König <christian.koenig@amd.com>
Assisted-by: Claude:Sonnet 4
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    | 12 ++---
 drivers/gpu/drm/drm_gem.c                     |  9 ++--
 drivers/gpu/drm/i915/gem/i915_gem_object.c    |  1 -
 drivers/gpu/drm/nouveau/nouveau_bo.c          |  3 --
 .../gpu/drm/ttm/tests/ttm_bo_validate_test.c  |  2 +-
 drivers/gpu/drm/ttm/ttm_bo.c                  | 26 ++++++-----
 drivers/gpu/drm/ttm/ttm_bo_util.c             | 44 +++++++++++++------
 drivers/gpu/drm/xe/xe_bo.c                    |  8 ++--
 include/drm/drm_gem.h                         |  9 ----
 include/drm/ttm/ttm_bo.h                      |  2 +
 11 files changed, 65 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 20831dbebc31..a168083edab2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -397,7 +397,7 @@ static int amdgpu_amdkfd_remove_eviction_fence(struct amdgpu_bo *bo,
  */
 void amdgpu_amdkfd_remove_all_eviction_fences(struct amdgpu_bo *bo)
 {
-	struct dma_resv *resv = &bo->tbo.base._resv;
+	struct dma_resv *resv = bo->tbo.individual_resv;
 	struct dma_fence *fence, *stub;
 	struct dma_resv_iter cursor;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 6c5182d54f7d..026821f6da7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1319,7 +1319,7 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
 	 * So when this locking here fails something is wrong with the reference
 	 * counting.
 	 */
-	if (WARN_ON_ONCE(!dma_resv_trylock(&bo->base._resv)))
+	if (WARN_ON_ONCE(!dma_resv_trylock(bo->individual_resv)))
 		return;
 
 	amdgpu_amdkfd_remove_all_eviction_fences(abo);
@@ -1329,22 +1329,22 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
 	    adev->in_suspend || drm_dev_is_unplugged(adev_to_drm(adev)))
 		goto out;
 
-	r = dma_resv_reserve_fences(&bo->base._resv, 1);
+	r = dma_resv_reserve_fences(bo->individual_resv, 1);
 	if (r)
 		goto out;
 
 	r = amdgpu_ttm_clear_buffer(amdgpu_ttm_next_clear_entity(adev),
-				    abo, &bo->base._resv, &fence,
-				    false, AMDGPU_KERNEL_JOB_ID_CLEAR_ON_RELEASE);
+				    abo, bo->individual_resv, &fence, false,
+				    AMDGPU_KERNEL_JOB_ID_CLEAR_ON_RELEASE);
 	if (WARN_ON(r))
 		goto out;
 
 	amdgpu_vram_mgr_set_cleared(bo->resource);
-	dma_resv_add_fence(&bo->base._resv, fence, DMA_RESV_USAGE_KERNEL);
+	dma_resv_add_fence(bo->individual_resv, fence, DMA_RESV_USAGE_KERNEL);
 	dma_fence_put(fence);
 
 out:
-	dma_resv_unlock(&bo->base._resv);
+	dma_resv_unlock(bo->individual_resv);
 }
 
 /**
diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index d2ce18bbddea..480391df556d 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -235,9 +235,11 @@ int drm_gem_private_object_init(struct drm_device *dev,
 	obj->handle_count = 0;
 	obj->size = size;
 	mutex_init(&obj->gpuva.lock);
-	dma_resv_init(&obj->_resv);
-	if (!obj->resv)
-		obj->resv = dma_resv_get(&obj->_resv);
+	if (!obj->resv) {
+		obj->resv = dma_resv_alloc();
+		if (!obj->resv)
+			return -ENOMEM;
+	}
 
 	drm_gem_gpuva_init(obj);
 
@@ -259,7 +261,6 @@ void drm_gem_private_object_fini(struct drm_gem_object *obj)
 	WARN_ON(obj->dma_buf);
 
 	dma_resv_put(obj->resv);
-	dma_resv_put(&obj->_resv);
 	mutex_destroy(&obj->gpuva.lock);
 }
 EXPORT_SYMBOL(drm_gem_private_object_fini);
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.c b/drivers/gpu/drm/i915/gem/i915_gem_object.c
index 3f37b0cbb70f..1c73f15d0315 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_object.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_object.c
@@ -90,7 +90,6 @@ struct drm_i915_gem_object *i915_gem_object_alloc(void)
 void i915_gem_object_free(struct drm_i915_gem_object *obj)
 {
 	dma_resv_put(obj->base.resv);
-	dma_resv_put(&obj->base._resv);
 	return kmem_cache_free(slab_objects, obj);
 }
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
index 67c9d32f4f27..65e1f0c2f984 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bo.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
@@ -159,8 +159,6 @@ nouveau_bo_del_ttm(struct ttm_buffer_object *bo)
 			drm_gem_object_put(nvbo->r_obj);
 
 		drm_gem_object_release(&bo->base);
-	} else {
-		dma_resv_put(&bo->base._resv);
 	}
 
 	kfree(nvbo);
@@ -385,7 +383,6 @@ nouveau_bo_new(struct nouveau_cli *cli, u64 size, int align,
 		return PTR_ERR(nvbo);
 
 	nvbo->bo.base.size = size;
-	dma_resv_init(&nvbo->bo.base._resv);
 	drm_vma_node_reset(&nvbo->bo.base.vma_node);
 
 	/* This must be called before ttm_bo_init_reserved(). Subsequent
diff --git a/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c b/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
index e0ecadccccf8..4559352e7115 100644
--- a/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
+++ b/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
@@ -640,7 +640,7 @@ static void ttm_bo_validate_no_placement_not_signaled(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, ctx.bytes_moved, 0);
 
 	if (bo->type != ttm_bo_type_sg)
-		KUNIT_ASSERT_PTR_EQ(test, bo->base.resv, &bo->base._resv);
+		KUNIT_ASSERT_PTR_EQ(test, bo->base.resv, &bo->individual_resv);
 
 	/* Make sure we have an idle object at this point */
 	dma_resv_wait_timeout(bo->base.resv, usage, false, MAX_SCHEDULE_TIMEOUT);
diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 999c24251fb7..ecb5f55a0dd1 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -193,13 +193,13 @@ static int ttm_bo_individualize_resv(struct ttm_buffer_object *bo)
 {
 	int r;
 
-	if (bo->base.resv == &bo->base._resv)
+	if (bo->base.resv == bo->individual_resv)
 		return 0;
 
-	BUG_ON(!dma_resv_trylock(&bo->base._resv));
+	BUG_ON(!dma_resv_trylock(bo->individual_resv));
 
-	r = dma_resv_copy_fences(&bo->base._resv, bo->base.resv);
-	dma_resv_unlock(&bo->base._resv);
+	r = dma_resv_copy_fences(bo->individual_resv, bo->base.resv);
+	dma_resv_unlock(bo->individual_resv);
 	if (r)
 		return r;
 
@@ -209,7 +209,7 @@ static int ttm_bo_individualize_resv(struct ttm_buffer_object *bo)
 		 * the resv object while holding the lru_lock.
 		 */
 		spin_lock(&bo->bdev->lru_lock);
-		drm_gem_object_set_resv(&bo->base, &bo->base._resv);
+		drm_gem_object_set_resv(&bo->base, bo->individual_resv);
 		spin_unlock(&bo->bdev->lru_lock);
 	}
 
@@ -218,7 +218,7 @@ static int ttm_bo_individualize_resv(struct ttm_buffer_object *bo)
 
 static void ttm_bo_flush_all_fences(struct ttm_buffer_object *bo)
 {
-	struct dma_resv *resv = &bo->base._resv;
+	struct dma_resv *resv = bo->individual_resv;
 	struct dma_resv_iter cursor;
 	struct dma_fence *fence;
 
@@ -238,8 +238,8 @@ static void ttm_bo_delayed_delete(struct work_struct *work)
 
 	bo = container_of(work, typeof(*bo), delayed_delete);
 
-	dma_resv_wait_timeout(&bo->base._resv, DMA_RESV_USAGE_BOOKKEEP, false,
-			      MAX_SCHEDULE_TIMEOUT);
+	dma_resv_wait_timeout(bo->individual_resv, DMA_RESV_USAGE_BOOKKEEP,
+			      false, MAX_SCHEDULE_TIMEOUT);
 	dma_resv_lock(bo->base.resv, NULL);
 	ttm_bo_cleanup_memtype_use(bo);
 	dma_resv_unlock(bo->base.resv);
@@ -273,7 +273,7 @@ static void ttm_bo_release(struct kref *kref)
 		drm_vma_offset_remove(bdev->vma_manager, &bo->base.vma_node);
 		ttm_mem_io_free(bdev, bo->resource);
 
-		if (!dma_resv_test_signaled(&bo->base._resv,
+		if (!dma_resv_test_signaled(bo->individual_resv,
 					    DMA_RESV_USAGE_BOOKKEEP) ||
 		    (want_init_on_free() && (bo->ttm != NULL)) ||
 		    bo->type == ttm_bo_type_sg ||
@@ -316,6 +316,8 @@ static void ttm_bo_release(struct kref *kref)
 	}
 
 	atomic_dec(&ttm_glob.bo_count);
+	dma_resv_put(bo->individual_resv);
+	bo->individual_resv = NULL;
 	bo->destroy(bo);
 }
 
@@ -1197,7 +1199,11 @@ int ttm_bo_init_reserved(struct ttm_device *bdev, struct ttm_buffer_object *bo,
 	bo->pin_count = 0;
 	bo->sg = sg;
 	bo->bulk_move = NULL;
-	drm_gem_object_set_resv(&bo->base, resv ?: &bo->base._resv);
+
+	/* Save the original resv object before overwriting it */
+	bo->individual_resv = dma_resv_get(bo->base.resv);
+	if (resv)
+		drm_gem_object_set_resv(&bo->base, resv);
 	atomic_inc(&ttm_glob.bo_count);
 
 	/*
diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
index e080ce60933e..e39448a5015e 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -208,7 +208,7 @@ static void ttm_transfered_destroy(struct ttm_buffer_object *bo)
 
 	fbo = container_of(bo, struct ttm_transfer_obj, base);
 	dma_resv_put(fbo->base.base.resv);
-	dma_resv_put(&fbo->base.base._resv);
+	dma_resv_put(fbo->base.individual_resv);
 	ttm_bo_put(fbo->bo);
 	kfree(fbo);
 }
@@ -238,12 +238,23 @@ static int ttm_buffer_object_transfer(struct ttm_buffer_object *bo,
 	if (!fbo)
 		return -ENOMEM;
 
-	fbo->base = *bo;
 
 	/**
 	 * Fix up members that we shouldn't copy directly:
 	 * TODO: Explicit member copy would probably be better here.
 	 */
+	fbo->base = *bo;
+
+	fbo->base.individual_resv = dma_resv_alloc();
+	if (!fbo->base.individual_resv) {
+		ret = -ENOMEM;
+		goto error_free;
+	}
+
+	if (bo->type != ttm_bo_type_sg)
+		fbo->base.base.resv = dma_resv_get(fbo->base.individual_resv);
+	else
+		dma_resv_get(fbo->base.base.resv);
 
 	atomic_inc(&ttm_glob.bo_count);
 	drm_vma_node_reset(&fbo->base.base.vma_node);
@@ -251,19 +262,16 @@ static int ttm_buffer_object_transfer(struct ttm_buffer_object *bo,
 	kref_init(&fbo->base.kref);
 	fbo->base.destroy = &ttm_transfered_destroy;
 	fbo->base.pin_count = 0;
-	if (bo->type != ttm_bo_type_sg)
-		fbo->base.base.resv = &fbo->base.base._resv;
 
-	dma_resv_init(&fbo->base.base._resv);
 	fbo->base.base.dev = NULL;
-	ret = dma_resv_trylock(&fbo->base.base._resv);
+	ret = dma_resv_trylock(fbo->base.individual_resv);
 	WARN_ON(!ret);
 
-	ret = dma_resv_reserve_fences(&fbo->base.base._resv, TTM_NUM_MOVE_FENCES);
+	ret = dma_resv_reserve_fences(fbo->base.individual_resv,
+				      TTM_NUM_MOVE_FENCES);
 	if (ret) {
-		dma_resv_unlock(&fbo->base.base._resv);
-		kfree(fbo);
-		return ret;
+		dma_resv_unlock(fbo->base.individual_resv);
+		goto error_unref;
 	}
 
 	if (fbo->base.resource) {
@@ -281,6 +289,14 @@ static int ttm_buffer_object_transfer(struct ttm_buffer_object *bo,
 
 	*new_obj = &fbo->base;
 	return 0;
+
+error_unref:
+	dma_resv_put(fbo->base.individual_resv);
+	dma_resv_put(fbo->base.base.resv);
+
+error_free:
+	kfree(fbo);
+	return ret;
 }
 
 /**
@@ -618,7 +634,7 @@ static int ttm_bo_move_to_ghost(struct ttm_buffer_object *bo,
 	if (ret)
 		return ret;
 
-	dma_resv_add_fence(&ghost_obj->base._resv, fence,
+	dma_resv_add_fence(ghost_obj->individual_resv, fence,
 			   DMA_RESV_USAGE_KERNEL);
 
 	/**
@@ -632,7 +648,7 @@ static int ttm_bo_move_to_ghost(struct ttm_buffer_object *bo,
 	else
 		bo->ttm = NULL;
 
-	dma_resv_unlock(&ghost_obj->base._resv);
+	dma_resv_unlock(ghost_obj->individual_resv);
 	ttm_bo_put(ghost_obj);
 	return 0;
 }
@@ -802,14 +818,14 @@ int ttm_bo_pipeline_gutting(struct ttm_buffer_object *bo)
 	if (ret)
 		goto error_destroy_tt;
 
-	ret = dma_resv_copy_fences(&ghost->base._resv, bo->base.resv);
+	ret = dma_resv_copy_fences(ghost->individual_resv, bo->base.resv);
 	/* Last resort, wait for the BO to be idle when we are OOM */
 	if (ret) {
 		dma_resv_wait_timeout(bo->base.resv, DMA_RESV_USAGE_BOOKKEEP,
 				      false, MAX_SCHEDULE_TIMEOUT);
 	}
 
-	dma_resv_unlock(&ghost->base._resv);
+	dma_resv_unlock(ghost->individual_resv);
 	ttm_bo_put(ghost);
 	bo->ttm = ttm;
 	return 0;
diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 6df7ef07ec0b..422fe4bddf00 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -1660,7 +1660,7 @@ static bool xe_ttm_bo_lock_in_destructor(struct ttm_buffer_object *ttm_bo)
 	 * always succeed here, as long as we hold the lru lock.
 	 */
 	spin_lock(&ttm_bo->bdev->lru_lock);
-	locked = dma_resv_trylock(&ttm_bo->base._resv);
+	locked = dma_resv_trylock(ttm_bo->individual_resv);
 	spin_unlock(&ttm_bo->bdev->lru_lock);
 	xe_assert(xe, locked);
 
@@ -1689,14 +1689,14 @@ static void xe_ttm_bo_release_notify(struct ttm_buffer_object *ttm_bo)
 	 * TODO: Don't do this for external bos once we scrub them after
 	 * unbind.
 	 */
-	dma_resv_for_each_fence(&cursor, &ttm_bo->base._resv,
+	dma_resv_for_each_fence(&cursor, ttm_bo->individual_resv,
 				DMA_RESV_USAGE_BOOKKEEP, fence) {
 		if (xe_fence_is_xe_preempt(fence) &&
 		    !dma_fence_is_signaled(fence)) {
 			if (!replacement)
 				replacement = dma_fence_get_stub();
 
-			dma_resv_replace_fences(&ttm_bo->base._resv,
+			dma_resv_replace_fences(ttm_bo->individual_resv,
 						fence->context,
 						replacement,
 						DMA_RESV_USAGE_BOOKKEEP);
@@ -1704,7 +1704,7 @@ static void xe_ttm_bo_release_notify(struct ttm_buffer_object *ttm_bo)
 	}
 	dma_fence_put(replacement);
 
-	dma_resv_unlock(&ttm_bo->base._resv);
+	dma_resv_unlock(ttm_bo->individual_resv);
 }
 
 static void xe_ttm_bo_delete_mem_notify(struct ttm_buffer_object *ttm_bo)
diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index f889232e8525..8aed680bfca2 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -385,15 +385,6 @@ struct drm_gem_object {
 	 */
 	struct dma_resv *resv;
 
-	/**
-	 * @_resv:
-	 *
-	 * A reservation object for this GEM object.
-	 *
-	 * This is unused for imported GEM objects.
-	 */
-	struct dma_resv _resv;
-
 	/**
 	 * @gpuva: Fields used by GPUVM to manage mappings pointing to this GEM object.
 	 *
diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
index 32791c4db2a9..f132caa9647f 100644
--- a/include/drm/ttm/ttm_bo.h
+++ b/include/drm/ttm/ttm_bo.h
@@ -77,6 +77,7 @@ enum ttm_bo_type {
  * @bdev: Pointer to the buffer object device structure.
  * @type: The bo type.
  * @page_alignment: Page alignment.
+ * @individual_resv: Individual resv for destruction
  * @destroy: Destruction function. If NULL, kfree is used.
  * @kref: Reference count of this buffer object. When this refcount reaches
  * zero, the object is destroyed or put on the delayed delete list.
@@ -107,6 +108,7 @@ struct ttm_buffer_object {
 	struct ttm_device *bdev;
 	enum ttm_bo_type type;
 	uint32_t page_alignment;
+	struct dma_resv *individual_resv;
 	void (*destroy) (struct ttm_buffer_object *);
 
 	/*
-- 
2.43.0

