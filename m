Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74AE7C44501
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 19:08:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C242C10F933;
	Fri, 10 Jul 2026 19:07:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DIJhkv5i";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3688310E226
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 19:07:58 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-493c5220cb7so9747785e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 12:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783710476; x=1784315276; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fSMI1XBLbz6lmlvGbD7NB+rfZu1D+kepFbsYfFhRvGc=;
 b=DIJhkv5im2z5+/+BJOeH3itA0zetBuxTbCxj/JRzsEXuORcZLhzP7Yp880rqQh3YXb
 T2q5UuyRRHRBQmNvEqWjAAAEqoOr9j1PYYKuwWIZ+YvysbxUlXSdwJ14ye+yyRbchL0z
 ccZYwu5AI4RP6k0aOvjasvFtcdvVWGUjuQMLTXzWSdsYhoWA7zqDl7i6EW2UpLpjj+om
 tfpe2WrRdexm2K8aT7uCtSPSd0sf7BEZeK5KVPUWjg9MoALFUi2fqG2+o10c8e+dJmW7
 CUVL2mO1sLH2SM8SMcvcShc+CeSGE+FJMnCXpCOTjmsHofWl1SACxMqRjQ3oo5whnLLS
 GhCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783710476; x=1784315276;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fSMI1XBLbz6lmlvGbD7NB+rfZu1D+kepFbsYfFhRvGc=;
 b=ZCd99JgYIXfLP0kEd172gbY7SYUJoaj1jgMyqzALSsR3/iqrsQDJL0aUfdodihPjY+
 rOuHmm9flKO+TBefdWe/lXH3yqmW1GUiq+ctdqoX8Y8GXMBnNSkEz3Fl2Eyy0PB3fENa
 UZ7mJqU4AM8lAmW1JhE3FVCEwcQm1WE8gAg/mSqz+r45s/B+4RbahYO5/C5EUg920uk+
 WwwtkWc7kl1p9zodC5pl4oMQdgAOZm4n6TAqyUeR/7gJzBD82T16lBfnkiO4hlO8z6zw
 zg4VyB5SURIz2I/FWA+78VZx5iEspfxwWDx6O7Hzk8srODETzmMoYhGply70Tt9R/91M
 iGtA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpXwUf0PPWLze/STXQWbHM7mGHStR57H4ie6xv3+Lr8tz5TybG2ZMtoIeJ6BlmiPSZ4t6yOVjN0SlA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxN1LNNeEqQuBrh6m1Zx6spyk6jGCB4ZyemGhvEo807dpnt1Yyz
 9i/G41p5p907HBKZf/H5vabJd7T3xb0/KefVFDasIUcRI/s7xFovLSO0
X-Gm-Gg: AfdE7cnWwXSfxCQVOT59jKNCd3m1aPvkiBi2vNIbAsGteXS233wXjNKAd16HMiJU++5
 Dx0aLIsNRg5XXuhUDPIKivP1fXe3UK2g0EflKkZqrbdy3xEWiinx9MaZH3dOLlV4ZbeE7X8az51
 /5iyVrNbDeRV2blnjmWXv/zT+5+pQYC0JYgtF/gDOnqLT3oKxNaAaE3UOiT31uo02t1S9irPkGI
 t7Nw4OwFdH8KRg5M0wjTQjuRkIhuC8hWmFJC5qzQDYvvzvix9oVhtnqelKBK2ukxLs58eBeorrY
 B2HzU/rRv8x4lYBnqKZ5PobzaOS/1UKp1ejhXIHTnffFx6XbQP2Yl3dy5snfoFWupIxDBrTmvqL
 uKjJ4NFXFJZsKpAQeiIbz+lSCYK+7yBiRo93vanjoJIylTwLECwWfFjmh+4YrJwc96C8qekykRI
 zBtG2gHBygB+dJLdzAtxprCsXxSZOPzIXeuB3Z
X-Received: by 2002:a05:600c:3b0e:b0:490:c032:ae92 with SMTP id
 5b1f17b1804b1-493f882a31amr952785e9.33.1783710476283; 
 Fri, 10 Jul 2026 12:07:56 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:154f:ec00:aa08:de24:db33:4496])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f567eadfsm55000755e9.6.2026.07.10.12.07.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 12:07:55 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: thomas.hellstrom@linux.intel.com, dakr@kernel.org, ecourtney@nvidia.com,
 simona@ffwll.ch, matthew.brost@intel.com, nat@pixelcluster.dev,
 airlied@gmail.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/12] dma-buf: Add reference counting to dma_resv
Date: Fri, 10 Jul 2026 20:52:41 +0200
Message-ID: <20260710190752.2355-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710190752.2355-1-christian.koenig@amd.com>
References: <20260710190752.2355-1-christian.koenig@amd.com>
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

Introduce reference counting for dma_resv objects to better manage their
lifecycle. This replaces the previous approach where dma_buf would either
embed a dma_resv or allocate it inline using a size trick.

Add three new functions:
- dma_resv_alloc(): allocates and initializes a dma_resv with refcount
- dma_resv_get(): acquires a reference to a dma_resv
- dma_resv_put(): releases a reference, freeing when count reaches zero

Update all callers to use dma_resv_put() instead of dma_resv_fini(),
which now becomes an internal cleanup function. The dma_buf export path
now explicitly allocates the dma_resv when needed rather than using
pointer arithmetic tricks.

This provides clearer ownership semantics and makes the code more
maintainable by removing the embedded allocation hack.

Signed-off-by: Christian König <christian.koenig@amd.com>
Assisted-by: Claude:Sonnet 4
---
 drivers/dma-buf/dma-buf.c                  | 24 +++----
 drivers/dma-buf/dma-resv.c                 | 80 +++++++++++++++++++---
 drivers/dma-buf/st-dma-resv.c              | 10 +--
 drivers/gpu/drm/drm_gem.c                  |  2 +-
 drivers/gpu/drm/drm_mode_config.c          |  2 +-
 drivers/gpu/drm/i915/gem/i915_gem_object.c |  2 +-
 drivers/gpu/drm/i915/gt/intel_ggtt.c       |  4 +-
 drivers/gpu/drm/i915/gt/intel_gtt.c        |  2 +-
 drivers/gpu/drm/nouveau/nouveau_bo.c       |  2 +-
 drivers/gpu/drm/ttm/tests/ttm_bo_test.c    |  2 +-
 drivers/gpu/drm/ttm/ttm_bo_util.c          |  2 +-
 include/linux/dma-resv.h                   | 22 +++++-
 12 files changed, 117 insertions(+), 37 deletions(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index d504c636dc294..53e428fdaf6bd 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -182,8 +182,7 @@ static void dma_buf_release(struct dentry *dentry)
 
 	dmabuf->ops->release(dmabuf);
 
-	if (dmabuf->resv == (struct dma_resv *)&dmabuf[1])
-		dma_resv_fini(dmabuf->resv);
+	dma_resv_put(dmabuf->resv);
 
 	WARN_ON(!list_empty(&dmabuf->attachments));
 	module_put(dmabuf->owner);
@@ -707,10 +706,9 @@ static struct file *dma_buf_getfile(size_t size, int flags)
  */
 struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
 {
-	struct dma_buf *dmabuf;
 	struct dma_resv *resv = exp_info->resv;
+	struct dma_buf *dmabuf;
 	struct file *file;
-	size_t alloc_size = sizeof(struct dma_buf);
 	int ret;
 
 	if (WARN_ON(!exp_info->priv || !exp_info->ops
@@ -731,12 +729,7 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
 		goto err_module;
 	}
 
-	if (!exp_info->resv)
-		alloc_size += sizeof(struct dma_resv);
-	else
-		/* prevent &dma_buf[1] == dma_buf->resv */
-		alloc_size += 1;
-	dmabuf = kzalloc(alloc_size, GFP_KERNEL);
+	dmabuf = kzalloc_obj(*dmabuf);
 	if (!dmabuf) {
 		ret = -ENOMEM;
 		goto err_file;
@@ -754,10 +747,13 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
 	INIT_LIST_HEAD(&dmabuf->attachments);
 
 	if (!resv) {
-		dmabuf->resv = (struct dma_resv *)&dmabuf[1];
-		dma_resv_init(dmabuf->resv);
+		dmabuf->resv = dma_resv_alloc();
+		if (!dmabuf->resv) {
+			ret = -ENOMEM;
+			goto err_dmabuf;
+		}
 	} else {
-		dmabuf->resv = resv;
+		dmabuf->resv = dma_resv_get(resv);
 	}
 
 	file->private_data = dmabuf;
@@ -770,6 +766,8 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
 
 	return dmabuf;
 
+err_dmabuf:
+	kfree(dmabuf);
 err_file:
 	fput(file);
 err_module:
diff --git a/drivers/dma-buf/dma-resv.c b/drivers/dma-buf/dma-resv.c
index 39a92d9f24136..1251b18e1b540 100644
--- a/drivers/dma-buf/dma-resv.c
+++ b/drivers/dma-buf/dma-resv.c
@@ -36,6 +36,7 @@
 #include <linux/dma-resv.h>
 #include <linux/dma-fence-array.h>
 #include <linux/export.h>
+#include <linux/kref.h>
 #include <linux/mm.h>
 #include <linux/sched/mm.h>
 #include <linux/mmu_notifier.h>
@@ -137,26 +138,87 @@ static void dma_resv_list_free(struct dma_resv_list *list)
  */
 void dma_resv_init(struct dma_resv *obj)
 {
+	kref_init(&obj->refcount);
+	obj->allocated = false;
 	ww_mutex_init(&obj->lock, &reservation_ww_class);
 
 	RCU_INIT_POINTER(obj->fences, NULL);
 }
 EXPORT_SYMBOL(dma_resv_init);
 
-/**
- * dma_resv_fini - destroys a reservation object
- * @obj: the reservation object
+/*
+ * dma_resv_release - release function for kref
+ * @kref: the kref inside the dma_resv object
+ *
+ * This is called when the last reference to a dma_resv object is released.
+ * Cleans up the object and frees it if it was allocated by dma_resv_alloc().
  */
-void dma_resv_fini(struct dma_resv *obj)
+static void dma_resv_release(struct kref *kref)
 {
-	/*
-	 * This object should be dead and all references must have
-	 * been released to it, so no need to be protected with rcu.
-	 */
+	struct dma_resv *obj = container_of(kref, struct dma_resv, refcount);
+
 	dma_resv_list_free(rcu_dereference_protected(obj->fences, true));
 	ww_mutex_destroy(&obj->lock);
+	if (obj->allocated)
+		kfree(obj);
+}
+
+/**
+ * dma_resv_alloc - allocate and initialize a reservation object
+ *
+ * Allocates a new dma_resv object, initializes it, and returns it with a
+ * reference count of 1. The object must be freed with dma_resv_put() when
+ * no longer needed.
+ *
+ * Returns:
+ * A pointer to the allocated dma_resv object, or NULL on allocation failure.
+ */
+struct dma_resv *dma_resv_alloc(void)
+{
+	struct dma_resv *obj;
+
+	obj = kzalloc_obj(*obj);
+	if (!obj)
+		return NULL;
+
+	dma_resv_init(obj);
+	obj->allocated = true;
+
+	return obj;
+}
+EXPORT_SYMBOL(dma_resv_alloc);
+
+/**
+ * dma_resv_get - acquire a reference to a reservation object
+ * @obj: the reservation object
+ *
+ * Increments the reference count on the dma_resv object.
+ *
+ * Returns:
+ * The dma_resv object pointer for convenience.
+ */
+struct dma_resv *dma_resv_get(struct dma_resv *obj)
+{
+	if (obj)
+		kref_get(&obj->refcount);
+	return obj;
+}
+EXPORT_SYMBOL(dma_resv_get);
+
+/**
+ * dma_resv_put - release a reference to a reservation object
+ * @obj: the reservation object
+ *
+ * Decrements the reference count on the dma_resv object. When the reference
+ * count reaches zero, the object is cleaned up with dma_resv_fini() and freed
+ * if it was allocated by dma_resv_alloc().
+ */
+void dma_resv_put(struct dma_resv *obj)
+{
+	if (obj)
+		kref_put(&obj->refcount, dma_resv_release);
 }
-EXPORT_SYMBOL(dma_resv_fini);
+EXPORT_SYMBOL(dma_resv_put);
 
 /* Dereference the fences while ensuring RCU rules */
 static inline struct dma_resv_list *dma_resv_fences_list(struct dma_resv *obj)
diff --git a/drivers/dma-buf/st-dma-resv.c b/drivers/dma-buf/st-dma-resv.c
index 0b96136bbd546..2c43d2d2b0169 100644
--- a/drivers/dma-buf/st-dma-resv.c
+++ b/drivers/dma-buf/st-dma-resv.c
@@ -59,7 +59,7 @@ static void test_sanitycheck(struct kunit *test)
 		KUNIT_FAIL(test, "Resv locking failed\n");
 	else
 		dma_resv_unlock(&resv);
-	dma_resv_fini(&resv);
+	dma_resv_put(&resv);
 }
 
 static void test_signaling(struct kunit *test)
@@ -101,7 +101,7 @@ static void test_signaling(struct kunit *test)
 err_unlock:
 	dma_resv_unlock(&resv);
 err_free:
-	dma_resv_fini(&resv);
+	dma_resv_put(&resv);
 	dma_fence_put(f);
 }
 
@@ -160,7 +160,7 @@ static void test_for_each(struct kunit *test)
 err_unlock:
 	dma_resv_unlock(&resv);
 err_free:
-	dma_resv_fini(&resv);
+	dma_resv_put(&resv);
 	dma_fence_put(f);
 }
 
@@ -231,7 +231,7 @@ static void test_for_each_unlocked(struct kunit *test)
 	dma_resv_iter_end(&cursor);
 	dma_fence_signal(f);
 err_free:
-	dma_resv_fini(&resv);
+	dma_resv_put(&resv);
 	dma_fence_put(f);
 }
 
@@ -282,7 +282,7 @@ static void test_get_fences(struct kunit *test)
 		dma_fence_put(fences[i]);
 	kfree(fences);
 err_resv:
-	dma_resv_fini(&resv);
+	dma_resv_put(&resv);
 	dma_fence_put(f);
 }
 
diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 018df97d590dc..48176a11d5520 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -249,7 +249,7 @@ void drm_gem_private_object_fini(struct drm_gem_object *obj)
 {
 	WARN_ON(obj->dma_buf);
 
-	dma_resv_fini(&obj->_resv);
+	dma_resv_put(&obj->_resv);
 	mutex_destroy(&obj->gpuva.lock);
 }
 EXPORT_SYMBOL(drm_gem_private_object_fini);
diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
index f432f485a914c..b2d98eab380bf 100644
--- a/drivers/gpu/drm/drm_mode_config.c
+++ b/drivers/gpu/drm/drm_mode_config.c
@@ -681,7 +681,7 @@ int drmm_mode_config_init(struct drm_device *dev)
 
 		drm_modeset_drop_locks(&modeset_ctx);
 		drm_modeset_acquire_fini(&modeset_ctx);
-		dma_resv_fini(&resv);
+		dma_resv_put(&resv);
 	}
 
 	return drmm_add_action_or_reset(dev, drm_mode_config_init_release,
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.c b/drivers/gpu/drm/i915/gem/i915_gem_object.c
index 5172d39826548..384c74794fdc1 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_object.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_object.c
@@ -144,7 +144,7 @@ void __i915_gem_object_fini(struct drm_i915_gem_object *obj)
 {
 	mutex_destroy(&obj->mm.get_page.lock);
 	mutex_destroy(&obj->mm.get_dma_page.lock);
-	dma_resv_fini(&obj->base._resv);
+	dma_resv_put(&obj->base._resv);
 }
 
 /**
diff --git a/drivers/gpu/drm/i915/gt/intel_ggtt.c b/drivers/gpu/drm/i915/gt/intel_ggtt.c
index 64ca5bbc53c68..3cc8df7b8fad1 100644
--- a/drivers/gpu/drm/i915/gt/intel_ggtt.c
+++ b/drivers/gpu/drm/i915/gt/intel_ggtt.c
@@ -1140,7 +1140,7 @@ void i915_ggtt_driver_late_release(struct drm_i915_private *i915)
 	struct i915_ggtt *ggtt = to_gt(i915)->ggtt;
 
 	GEM_WARN_ON(kref_read(&ggtt->vm.resv_ref) != 1);
-	dma_resv_fini(&ggtt->vm._resv);
+	dma_resv_put(&ggtt->vm._resv);
 }
 
 static unsigned int gen6_get_total_gtt_size(u16 snb_gmch_ctl)
@@ -1524,7 +1524,7 @@ static int ggtt_probe_hw(struct i915_ggtt *ggtt, struct intel_gt *gt)
 		ret = intel_ggtt_gmch_probe(ggtt);
 
 	if (ret) {
-		dma_resv_fini(&ggtt->vm._resv);
+		dma_resv_put(&ggtt->vm._resv);
 		return ret;
 	}
 
diff --git a/drivers/gpu/drm/i915/gt/intel_gtt.c b/drivers/gpu/drm/i915/gt/intel_gtt.c
index afbc5c7693089..7b1bdb121c88d 100644
--- a/drivers/gpu/drm/i915/gt/intel_gtt.c
+++ b/drivers/gpu/drm/i915/gt/intel_gtt.c
@@ -225,7 +225,7 @@ void i915_vm_resv_release(struct kref *kref)
 	struct i915_address_space *vm =
 		container_of(kref, typeof(*vm), resv_ref);
 
-	dma_resv_fini(&vm->_resv);
+	dma_resv_put(&vm->_resv);
 	mutex_destroy(&vm->mutex);
 
 	kfree(vm);
diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
index 0e8de6d4b36f7..67c9d32f4f27b 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bo.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
@@ -160,7 +160,7 @@ nouveau_bo_del_ttm(struct ttm_buffer_object *bo)
 
 		drm_gem_object_release(&bo->base);
 	} else {
-		dma_resv_fini(&bo->base._resv);
+		dma_resv_put(&bo->base._resv);
 	}
 
 	kfree(nvbo);
diff --git a/drivers/gpu/drm/ttm/tests/ttm_bo_test.c b/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
index f3103307b5df9..49b0b48c6c2ac 100644
--- a/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
+++ b/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
@@ -376,7 +376,7 @@ static void ttm_bo_unreserve_bulk(struct kunit *test)
 	ttm_resource_free(bo1, &res1);
 	ttm_resource_free(bo2, &res2);
 
-	dma_resv_fini(resv);
+	dma_resv_put(resv);
 }
 
 static void ttm_bo_fini_basic(struct kunit *test)
diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
index 3e3c201a02226..029c218f9fb47 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -207,7 +207,7 @@ static void ttm_transfered_destroy(struct ttm_buffer_object *bo)
 	struct ttm_transfer_obj *fbo;
 
 	fbo = container_of(bo, struct ttm_transfer_obj, base);
-	dma_resv_fini(&fbo->base.base._resv);
+	dma_resv_put(&fbo->base.base._resv);
 	ttm_bo_put(fbo->bo);
 	kfree(fbo);
 }
diff --git a/include/linux/dma-resv.h b/include/linux/dma-resv.h
index c5ab6fd9ebe8c..4d12519df34e1 100644
--- a/include/linux/dma-resv.h
+++ b/include/linux/dma-resv.h
@@ -44,6 +44,7 @@
 #include <linux/slab.h>
 #include <linux/seqlock.h>
 #include <linux/rcupdate.h>
+#include <linux/kref.h>
 
 extern struct ww_class reservation_ww_class;
 
@@ -153,6 +154,23 @@ static inline enum dma_resv_usage dma_resv_usage_rw(bool write)
  * drm_gem_object with the same scheme.
  */
 struct dma_resv {
+	/**
+	 * @refcount:
+	 *
+	 * Reference count for this reservation object. The object is freed
+	 * when the reference count reaches zero via dma_resv_put().
+	 */
+	struct kref refcount;
+
+	/**
+	 * @allocated:
+	 *
+	 * True if this object was allocated by dma_resv_alloc(), false if
+	 * embedded in another structure. Used to determine whether to free
+	 * the object memory in the release function.
+	 */
+	bool allocated;
+
 	/**
 	 * @lock:
 	 *
@@ -465,7 +483,9 @@ static inline void dma_resv_unlock(struct dma_resv *obj)
 }
 
 void dma_resv_init(struct dma_resv *obj);
-void dma_resv_fini(struct dma_resv *obj);
+struct dma_resv *dma_resv_alloc(void);
+struct dma_resv *dma_resv_get(struct dma_resv *obj);
+void dma_resv_put(struct dma_resv *obj);
 int dma_resv_reserve_fences(struct dma_resv *obj, unsigned int num_fences);
 void dma_resv_add_fence(struct dma_resv *obj, struct dma_fence *fence,
 			enum dma_resv_usage usage);
-- 
2.43.0

