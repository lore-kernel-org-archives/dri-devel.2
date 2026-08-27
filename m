Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC032C61DD4
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 12:49:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D25A910F011;
	Thu, 27 Aug 2026 12:49:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bGk5W3Mf";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E197410F00A
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 12:49:18 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4980fe6b3beso6342235e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 05:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787834957; x=1788439757; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cwMtyZdX8f3BBoJM15ozQtdf/lDryCW2jt5h1lUmsxg=;
 b=bGk5W3MfAaqsAUELVFyHLC0lLq1N4c0FNPjtXjE3Utl7p6xGuwTKnqjKAocO9/A/67
 UmWXMjk8D8H0ScozQqaDM0yMeUhL2mYX9cN4yPPLIv2r9BNeyuPL7b56j3jZBxw31KXG
 eULivjI4kF84Mug4dKfZOGEFrHw6tBzRV6Qz5j3ee5aXT0HRqnzvOo90rV2Q2aXM1kFb
 F2f1i9uxDvxd7V9FsCIvI3QqCG3K2538vQRz7GjTMQ2HdppckBHx5FieFZIYRgYaG4e8
 iKb1qKQ9KksqORKTtav8FNXJPkHhbYafhkJ0ofeU3WldkyFdkx9iv580GFSApv5Cdgg1
 0SBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787834957; x=1788439757;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cwMtyZdX8f3BBoJM15ozQtdf/lDryCW2jt5h1lUmsxg=;
 b=eL0/W1xsgy7B+QBd4KbtpIXTWt5f6gwBqjdmIZGQSw0W2syaZirtTOrhr+Ed2L1p7c
 Cyov2fMVzP/V5++R/ApW7lPTNA/mNBoXWsDCB5DpAqDLv9Q9rkWmeM57rq7xus045KFH
 juJyEVth0Haj4d1X3PnAK2J0lvdJMRSDHflSzq3jsqnnrumP9TILwT5QO+RNNUgw3JhV
 LKpE9rWWGmMu/Y2EqK98RB0PoRmWFEm1VBXmNW8VnGB8ZhJ7F4F9AjuXmCHci/UDJylH
 vUAt5YYi5Wirk5QqSPG99YfJlg1KSMVC/cMKnjkKnvbuG0wJSgOFKgwIB8Xap8gDbXJn
 dqLQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpCLcaMoIFgF1SPYBwgGxXpaeaUheUvuosWEmIeQYsRT8HDEbuuwF5qXPaiLvT95qiT/p9GXQscIfU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lWY0NZsQSbdFZ14d9Qk6Vm0AhA3VB7MtpxlJMv6Sh7xHW7wVut
 QuwVelNG8BBC3gcsoup/g32AJ8Tb0aGbRiZ3gJ1Lw76FCf4dscDn5RR0
X-Gm-Gg: AR+sD11gaTFgCBHxv6KSPmb/ZQQHuGID+quWTSPLV5QRfDMEbKyvjO7fG4g8JlQBqX4
 mSd5CYVm14hAUqOrXRX7MSEcDGLGh1Lck2mTGxmed5CTzY2eEII9AEOniHnrv5OqobDBqFi3azI
 S925Nc2+7HDWDdvLer217fNEOR4k8F9Qe9LP0P8vTGxLY062wP8AHxnngGSBP7Uz+gyfTMrXVFc
 nIyv7wRGtsl34aA8iN1KCpj6aUnYJ/MbxV8lekBkz8EaZPWSFlGon6bAQZLOKoedLcpazvK7UKV
 1vbLw0TR8Ns7egI0knWqwzNeR7zQGBpgVL4vS/7clhq68Mwh1sCCOsjaFEY6Ai4uXlXSgQBaL5X
 4thzYbmZGZeNgMUcEUxhn6aF7bL0Deu1WVJ3kunaDrGDduuoJlwwNe6YXugKx5vEvMdm/LD4y5L
 /JkSkp+8zkcMhuZPNIxc/CTj2Ao6Hs4LjXTF2kNgVGJVhB16NKvj8L3TCMsIMiMxGfOpS0gg==
X-Received: by 2002:a05:600c:3b25:b0:493:f783:c46a with SMTP id
 5b1f17b1804b1-49b0dfcd4c2mr65895455e9.6.1787834956789; 
 Thu, 27 Aug 2026 05:49:16 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1524:4300:a4b8:720e:f64f:4778])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b465226d8sm52089985e9.0.2026.08.27.05.49.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 05:49:16 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: thomas.hellstrom@linux.intel.com, dakr@kernel.org, ecourtney@nvidia.com,
 matthew.brost@intel.com, nat@pixelcluster.dev,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/10] drm/gem: Add helper for drm_gem_object resv assignment
Date: Thu, 27 Aug 2026 14:38:51 +0200
Message-ID: <20260827124910.2245-4-christian.koenig@amd.com>
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

Signed-off-by: Christian König <christian.koenig@amd.com>
Assisted-by: Claude:Sonnet 4
---
 drivers/gpu/drm/drm_gem.c                     | 31 ++++++++++++++++++-
 drivers/gpu/drm/drm_gem_shmem_helper.c        |  2 +-
 drivers/gpu/drm/drm_prime.c                   |  2 +-
 drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c    |  2 +-
 drivers/gpu/drm/msm/msm_gem.c                 |  2 +-
 drivers/gpu/drm/panthor/panthor_gem.c         |  2 +-
 drivers/gpu/drm/ttm/tests/ttm_bo_test.c       |  2 +-
 drivers/gpu/drm/ttm/tests/ttm_kunit_helpers.c |  2 +-
 drivers/gpu/drm/ttm/ttm_bo.c                  |  7 ++---
 drivers/gpu/drm/virtio/virtgpu_prime.c        |  2 +-
 drivers/gpu/drm/xe/xe_dma_buf.c               |  2 +-
 include/drm/drm_gem.h                         |  2 ++
 12 files changed, 43 insertions(+), 15 deletions(-)

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
-- 
2.43.0

