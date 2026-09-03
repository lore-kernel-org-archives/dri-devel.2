Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D89C624D6
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 13:44:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3595110F604;
	Thu,  3 Sep 2026 13:44:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iLBzzFzv";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94BC010F5EB
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 13:44:16 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-4843f205a5bso1667927f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 06:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788443055; x=1789047855; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TvvPru/b1ImfAEA1Rpo2uuTO4XOuyG3P4/UCVUEVeqU=;
 b=iLBzzFzvUnlQRVc6+sORWeUOILXjb3QytbldAaWnxBXjzq+rQxB/9N5bs+GLIXXpmk
 z9MWD0pgGeU8Bafi1RgZ04u8lCBpSj1jYEwmoE/98kQt099qgqPFUHizlqbXplB1cO6e
 Je9CYirSt9YwIZJeI16BUV2gxzbh8LuVpoK6Nrl0yBwcGKaHp3Ce3AwtT8vnTfnQ6qbp
 AzvkniQSDDW8LQfsCOcBzbaFjC1hD3cfhIvp12psownRcrfGRjnRhgEiu6nRNNyVqotk
 BhaAQFvT6USx9YuGBhyqdNUmkXKOjiz23LYrK53+MwAwOlGea/4ftdQUH3qB7mREFtn0
 Uitg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788443055; x=1789047855;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TvvPru/b1ImfAEA1Rpo2uuTO4XOuyG3P4/UCVUEVeqU=;
 b=EviNupuKm7ZSRi/tSyPd+1q6JMiFmKqk2bsiGzpHdGiAy1GwN58vNCVSFqEUXndz1c
 kkxm49aGHtmq5YAOgfUYINE1VfOPZbL+VlIU6UR/DZBclb/RsokOwruwSLjUei/0JnL0
 TJDWE4GvsYZlbvzFtgCWBYOYr2d3LPqOg4d23zJs+N63NdGP9AurCooAG9UFTVRCDLfK
 1ePuZ+wu69dnzQUphE9+5N9VR+5UzzfpUFJc8B7KAzBOBFP4StWfHwD80I1dM8YSUtDX
 MNR9oNyJRzgMrh4PQx/KXbVBPDQDrZyUjOWezIeauMgsY0RP5rzHQTY4Zv4SwLWG15LX
 M01g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwMx+7V3cM/wrkDABaV5ZA24yXcUtzPQFKv5xi8Da1NB1Oh8b6SzpdbGhnFRvjfyRCLo0OfYbtOZ5Q=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lx4wvyArE/rycflqUE5iyJHaBNpQN/AHJOMFILP8a2j1VnomIV
 i6ZJITxknazbT1aBp26ESzV0P8lpd+fiPqQvv5LWpsXNA71Ni5r4EaLX
X-Gm-Gg: AYBFou2a4tAMbTFKOIkDYxfnJUoqwLZrfulWuT75KY/Zv9vSrJD1AYbqPIRulYQGzN3
 CwuEPLfnixZf6UKVGqUIy5yP4ocXWcTOUSAD6YR1zw97gF8kSYjTFHAXrsQTzUbQ/1jjU2hnN27
 DVKld3jLMVx66jqx0M6Rfd1XihMIl+bLt2f+hNs4pWf08iM7gPyomgy3DsIIXssR6/RLY+MlpeE
 M0J+7GszXD4pQY6txA6Ad1PpUtbDBl3/gKU76E6SzX5ymqKrHPKLAwch/xnAGjNkiGu0t0G7Ttk
 iWPZlo7lxUU7tQ0yDxF22AB3RqeGQmOdxJkZIpOH6Z8oo6ej6EJp/RISq/f4H4zd8c6dFakjrO5
 r9MHphmeOtKUj+6fBH/Sp9HIKm584qQPie9VmEURRSu6zO25UKATzXjQ9GqzbSxDl/eId3WZlQd
 ww/kz15IiGeBLynWwonfW7x0LIe+TAeRXQ/ofkkH/XCxjpdOkq+w0ix1Y0lCVqqRXyLX6k6tfP6
 A==
X-Received: by 2002:a05:6000:4819:b0:484:41fb:5341 with SMTP id
 ffacd0b85a97d-484914b901cmr23508500f8f.25.1788443054821; 
 Thu, 03 Sep 2026 06:44:14 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15d9:4700:e712:9f38:603a:54e4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448e736a6sm13597080f8f.5.2026.09.03.06.44.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 06:44:14 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: thomas.hellstrom@linux.intel.com, dakr@kernel.org, ecourtney@nvidia.com,
 matthew.brost@intel.com, nat@pixelcluster.dev,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/11] drm/gem: Add helper for drm_gem_object resv assignment
 v2
Date: Thu,  3 Sep 2026 15:27:59 +0200
Message-ID: <20260903134408.105317-5-christian.koenig@amd.com>
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

Introduce drm_gem_object_set_resv() to safely assign reservation objects
to GEM objects with proper reference counting. This helper replaces all
direct assignments to drm_gem_object.resv throughout the DRM subsystem.

The function:
- Acquires a reference to the new resv via dma_resv_get()
- Assigns it to obj->resv
- Releases the old resv reference via dma_resv_put()

This ensures proper reference counting when sharing reservation objects
between GEM objects or when importing dma-bufs, preventing reference
leaks and use-after-free bugs.

Update all drivers to use the new helper:
- drm_prime: dma-buf import path
- drm_gem_shmem_helper: shmem prime import
- i915: dmabuf import
- msm: MSM_BO_NO_SHARE case
- panthor: exclusive_vm case
- virtio: dma-buf import
- xe: dummy object creation
- ttm: external resv assignment
- ttm/tests: test cases

v2: fix cases Sonnet has missed in amdxdna_gem_prime_import(),
    qaic_gem_prime_import(), intel_gtt/alloc_pt_lmem() and shmem.rs.
    add missing dma_resv_put() into i915_gem_object_fini().
    fix error handling in virtgpu_gem_prime_import().

Signed-off-by: Christian König <christian.koenig@amd.com>
Assisted-by: Claude:Sonnet 4
---
 drivers/accel/amdxdna/amdxdna_gem.c           |  2 +-
 drivers/accel/qaic/qaic_data.c                |  2 +-
 drivers/gpu/drm/drm_gem.c                     | 31 ++++++++++++++++++-
 drivers/gpu/drm/drm_gem_shmem_helper.c        |  2 +-
 drivers/gpu/drm/drm_prime.c                   |  2 +-
 drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c    |  2 +-
 drivers/gpu/drm/i915/gem/i915_gem_object.c    |  1 +
 drivers/gpu/drm/i915/gt/intel_gtt.c           |  2 +-
 drivers/gpu/drm/msm/msm_gem.c                 |  2 +-
 drivers/gpu/drm/panthor/panthor_gem.c         |  2 +-
 drivers/gpu/drm/ttm/tests/ttm_bo_test.c       |  2 +-
 drivers/gpu/drm/ttm/tests/ttm_kunit_helpers.c |  2 +-
 drivers/gpu/drm/ttm/ttm_bo.c                  |  7 ++---
 drivers/gpu/drm/ttm/ttm_bo_util.c             |  1 +
 drivers/gpu/drm/virtio/virtgpu_prime.c        |  2 +-
 drivers/gpu/drm/xe/xe_dma_buf.c               |  2 +-
 include/drm/drm_gem.h                         |  2 ++
 rust/kernel/drm/gem/shmem.rs                  |  9 ++++--
 18 files changed, 55 insertions(+), 20 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index 1f190b319bb6..a3e8da88683f 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -886,7 +886,7 @@ amdxdna_gem_prime_import(struct drm_device *dev, struct dma_buf *dma_buf)
 	abo->attach = attach;
 	abo->dma_buf = dma_buf;
 	abo->type = AMDXDNA_BO_SHARE;
-	gobj->resv = dma_buf->resv;
+	drm_gem_object_set_resv(gobj, dma_buf->resv);
 
 	return gobj;
 
diff --git a/drivers/accel/qaic/qaic_data.c b/drivers/accel/qaic/qaic_data.c
index 4d55531bf1c9..26c23b70c13a 100644
--- a/drivers/accel/qaic/qaic_data.c
+++ b/drivers/accel/qaic/qaic_data.c
@@ -876,7 +876,7 @@ struct drm_gem_object *qaic_gem_prime_import(struct drm_device *dev, struct dma_
 
 	obj->funcs = &qaic_gem_funcs;
 	obj->import_attach = attach;
-	obj->resv = dma_buf->resv;
+	drm_gem_object_set_resv(obj, dma_buf->resv);
 
 	return obj;
 
diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 48176a11d552..bbcbd25f014f 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -230,7 +230,7 @@ void drm_gem_private_object_init(struct drm_device *dev,
 	mutex_init(&obj->gpuva.lock);
 	dma_resv_init(&obj->_resv);
 	if (!obj->resv)
-		obj->resv = &obj->_resv;
+		obj->resv = dma_resv_get(&obj->_resv);
 
 	drm_gem_gpuva_init(obj);
 
@@ -249,11 +249,40 @@ void drm_gem_private_object_fini(struct drm_gem_object *obj)
 {
 	WARN_ON(obj->dma_buf);
 
+	dma_resv_put(obj->resv);
 	dma_resv_put(&obj->_resv);
 	mutex_destroy(&obj->gpuva.lock);
 }
 EXPORT_SYMBOL(drm_gem_private_object_fini);
 
+/**
+ * drm_gem_object_set_resv - Set the reservation object for a GEM object
+ * @obj: GEM object
+ * @resv: reservation object to assign
+ *
+ * This function safely assigns a new reservation object to a GEM object.
+ * It releases the old reservation object reference (if any) and acquires
+ * a reference to the new one.
+ *
+ * This should be used when changing the reservation object of an already
+ * initialized GEM object, for example when importing a dma-buf or sharing
+ * a reservation object with another object.
+ *
+ * Returns:
+ * The new reservation object pointer for convenience.
+ */
+struct dma_resv *drm_gem_object_set_resv(struct drm_gem_object *obj,
+					  struct dma_resv *resv)
+{
+	struct dma_resv *old_resv = obj->resv;
+
+	obj->resv = dma_resv_get(resv);
+	dma_resv_put(old_resv);
+
+	return obj->resv;
+}
+EXPORT_SYMBOL(drm_gem_object_set_resv);
+
 static void drm_gem_object_handle_get(struct drm_gem_object *obj)
 {
 	struct drm_device *dev = obj->dev;
diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 22ec52e2ffb8..76a8d7f252e0 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -977,7 +977,7 @@ struct drm_gem_object *drm_gem_shmem_prime_import_no_map(struct drm_device *dev,
 	drm_dbg_prime(dev, "size = %zu\n", size);
 
 	shmem->base.import_attach = attach;
-	shmem->base.resv = dma_buf->resv;
+	drm_gem_object_set_resv(&shmem->base, dma_buf->resv);
 
 	return &shmem->base;
 
diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index 9b44c78cd77f..6cfeca347faf 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -1006,7 +1006,7 @@ struct drm_gem_object *drm_gem_prime_import_dev(struct drm_device *dev,
 	}
 
 	obj->import_attach = attach;
-	obj->resv = dma_buf->resv;
+	drm_gem_object_set_resv(obj, dma_buf->resv);
 
 	return obj;
 
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c b/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
index b43d34c7d641..c824606497d2 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
@@ -320,7 +320,7 @@ struct drm_gem_object *i915_gem_prime_import(struct drm_device *dev,
 	i915_gem_object_init(obj, &i915_gem_object_dmabuf_ops, &lock_class,
 			     I915_BO_ALLOC_USER);
 	obj->base.import_attach = attach;
-	obj->base.resv = dma_buf->resv;
+	drm_gem_object_set_resv(&obj->base, dma_buf->resv);
 
 	/* We use GTT as shorthand for a coherent domain, one that is
 	 * neither in the GPU cache nor in the CPU cache, where all
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.c b/drivers/gpu/drm/i915/gem/i915_gem_object.c
index 1340e8898a86..3f37b0cbb70f 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_object.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_object.c
@@ -89,6 +89,7 @@ struct drm_i915_gem_object *i915_gem_object_alloc(void)
 
 void i915_gem_object_free(struct drm_i915_gem_object *obj)
 {
+	dma_resv_put(obj->base.resv);
 	dma_resv_put(&obj->base._resv);
 	return kmem_cache_free(slab_objects, obj);
 }
diff --git a/drivers/gpu/drm/i915/gt/intel_gtt.c b/drivers/gpu/drm/i915/gt/intel_gtt.c
index 7b1bdb121c88..161e4b73b3df 100644
--- a/drivers/gpu/drm/i915/gt/intel_gtt.c
+++ b/drivers/gpu/drm/i915/gt/intel_gtt.c
@@ -62,7 +62,7 @@ struct drm_i915_gem_object *alloc_pt_lmem(struct i915_address_space *vm, int sz)
 	 * them all at once.
 	 */
 	if (!IS_ERR(obj)) {
-		obj->base.resv = i915_vm_resv_get(vm);
+		drm_gem_object_set_resv(&obj->base, i915_vm_resv_get(vm));
 		obj->shares_resv_from = vm;
 
 		if (vm->fpriv)
diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index efd3d3c9a449..81ebb1e1094c 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -1151,7 +1151,7 @@ int msm_gem_new_handle(struct drm_device *dev, struct drm_file *file,
 
 		drm_gem_object_get(r_obj);
 
-		obj->resv = r_obj->resv;
+		drm_gem_object_set_resv(obj, r_obj->resv);
 	}
 
 	ret = drm_gem_handle_create(file, obj, handle);
diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
index 9855df738194..2de24f1b6018 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.c
+++ b/drivers/gpu/drm/panthor/panthor_gem.c
@@ -1024,7 +1024,7 @@ panthor_gem_create(struct drm_device *dev, size_t size, uint32_t flags,
 	if (exclusive_vm) {
 		bo->exclusive_vm_root_gem = panthor_vm_root_gem(exclusive_vm);
 		drm_gem_object_get(bo->exclusive_vm_root_gem);
-		bo->base.resv = bo->exclusive_vm_root_gem->resv;
+		drm_gem_object_set_resv(&bo->base, bo->exclusive_vm_root_gem->resv);
 	}
 
 	panthor_gem_debugfs_set_usage_flags(bo, usage_flags);
diff --git a/drivers/gpu/drm/ttm/tests/ttm_bo_test.c b/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
index 49b0b48c6c2a..3aff1c427cd1 100644
--- a/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
+++ b/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
@@ -461,7 +461,7 @@ static void ttm_bo_fini_shared_resv(struct kunit *test)
 
 	bo = ttm_bo_kunit_init(test, test->priv, BO_SIZE, NULL);
 	bo->type = ttm_bo_type_device;
-	bo->base.resv = external_resv;
+	drm_gem_object_set_resv(&bo->base, external_resv);
 
 	ttm_bo_fini(bo);
 }
diff --git a/drivers/gpu/drm/ttm/tests/ttm_kunit_helpers.c b/drivers/gpu/drm/ttm/tests/ttm_kunit_helpers.c
index 5cfe8f3f80d7..1146cc9ae522 100644
--- a/drivers/gpu/drm/ttm/tests/ttm_kunit_helpers.c
+++ b/drivers/gpu/drm/ttm/tests/ttm_kunit_helpers.c
@@ -181,7 +181,7 @@ struct ttm_buffer_object *ttm_bo_kunit_init(struct kunit *test,
 	bo->base = gem_obj;
 
 	if (obj)
-		bo->base.resv = obj;
+		drm_gem_object_set_resv(&bo->base, obj);
 
 	err = drm_gem_object_init(devs->drm, &bo->base, size);
 	KUNIT_ASSERT_EQ(test, err, 0);
diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 1b9477381a1d..999c24251fb7 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -209,7 +209,7 @@ static int ttm_bo_individualize_resv(struct ttm_buffer_object *bo)
 		 * the resv object while holding the lru_lock.
 		 */
 		spin_lock(&bo->bdev->lru_lock);
-		bo->base.resv = &bo->base._resv;
+		drm_gem_object_set_resv(&bo->base, &bo->base._resv);
 		spin_unlock(&bo->bdev->lru_lock);
 	}
 
@@ -1197,10 +1197,7 @@ int ttm_bo_init_reserved(struct ttm_device *bdev, struct ttm_buffer_object *bo,
 	bo->pin_count = 0;
 	bo->sg = sg;
 	bo->bulk_move = NULL;
-	if (resv)
-		bo->base.resv = resv;
-	else
-		bo->base.resv = &bo->base._resv;
+	drm_gem_object_set_resv(&bo->base, resv ?: &bo->base._resv);
 	atomic_inc(&ttm_glob.bo_count);
 
 	/*
diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
index af5732f9e489..e080ce60933e 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -207,6 +207,7 @@ static void ttm_transfered_destroy(struct ttm_buffer_object *bo)
 	struct ttm_transfer_obj *fbo;
 
 	fbo = container_of(bo, struct ttm_transfer_obj, base);
+	dma_resv_put(fbo->base.base.resv);
 	dma_resv_put(&fbo->base.base._resv);
 	ttm_bo_put(fbo->bo);
 	kfree(fbo);
diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c b/drivers/gpu/drm/virtio/virtgpu_prime.c
index 216c77cd0d21..79964b436243 100644
--- a/drivers/gpu/drm/virtio/virtgpu_prime.c
+++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
@@ -361,7 +361,7 @@ struct drm_gem_object *virtgpu_gem_prime_import(struct drm_device *dev,
 	INIT_LIST_HEAD(&bo->restore_node);
 
 	obj = &bo->base.base;
-	obj->resv = buf->resv;
+	drm_gem_object_set_resv(obj, buf->resv);
 	obj->funcs = &virtgpu_gem_dma_buf_funcs;
 	drm_gem_private_object_init(dev, obj, buf->size);
 
diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c b/drivers/gpu/drm/xe/xe_dma_buf.c
index 8a920e58245c..33bebf85ac62 100644
--- a/drivers/gpu/drm/xe/xe_dma_buf.c
+++ b/drivers/gpu/drm/xe/xe_dma_buf.c
@@ -293,7 +293,7 @@ xe_dma_buf_create_obj(struct drm_device *dev, struct dma_buf *dma_buf)
 	if (!dummy_obj)
 		return ERR_PTR(-ENOMEM);
 
-	dummy_obj->resv = resv;
+	drm_gem_object_set_resv(dummy_obj, resv);
 	xe_validation_guard(&ctx, &xe->val, &exec, (struct xe_val_flags) {}, ret) {
 		ret = drm_exec_lock_obj(&exec, dummy_obj);
 		drm_exec_retry_on_contention(&exec);
diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index 885244e375d3..09f5ec28218a 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -529,6 +529,8 @@ int drm_gem_object_init(struct drm_device *dev,
 void drm_gem_private_object_init(struct drm_device *dev,
 				 struct drm_gem_object *obj, size_t size);
 void drm_gem_private_object_fini(struct drm_gem_object *obj);
+struct dma_resv *drm_gem_object_set_resv(struct drm_gem_object *obj,
+					  struct dma_resv *resv);
 void drm_gem_vm_open(struct vm_area_struct *vma);
 void drm_gem_vm_close(struct vm_area_struct *vma);
 int drm_gem_mmap_obj(struct drm_gem_object *obj, unsigned long obj_size,
diff --git a/rust/kernel/drm/gem/shmem.rs b/rust/kernel/drm/gem/shmem.rs
index 34af402899a0..19a1459a8aca 100644
--- a/rust/kernel/drm/gem/shmem.rs
+++ b/rust/kernel/drm/gem/shmem.rs
@@ -146,8 +146,13 @@ pub fn new(
         // Start filling out values from `config`
         if let Some(parent_resv) = config.parent_resv_obj {
             // SAFETY: We have yet to expose the new gem object outside of this function, so it is
-            // safe to modify this field.
-            unsafe { (*obj.obj.get()).base.resv = parent_resv.raw_dma_resv() };
+            // safe to call this function to update the resv reference.
+            unsafe {
+                bindings::drm_gem_object_set_resv(
+                    &mut (*obj.obj.get()).base,
+                    parent_resv.raw_dma_resv(),
+                )
+            };
         }
 
         // SAFETY: We have yet to expose this object outside of this function, so we're guaranteed
-- 
2.43.0

