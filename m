Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E44C79F8C
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 13:44:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4998710F60E;
	Thu,  3 Sep 2026 13:44:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O+IiQajM";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D49C410F5F9
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 13:44:14 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-482e4998d28so1770010f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 06:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788443053; x=1789047853; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YF2dBg7VqdrD6bEdT5nmZf9EuyKgTiJN3OVROK0s5RI=;
 b=O+IiQajMbcxtkXkmhp/280/IBRj1Sog9Ag/tjZGcmevhJ6UJt3eZpHzF7G4I9csXlD
 WL9jqAq6+Ejhi3XVsLI3oP64dQUuobqmR878CauhO5biowNeohhu2lQEncqIqQUa6zns
 AjnHS9CwLqZysSoT8c7J+eNkS6srKBOcvKjrYAdtC6l4aziZHvE0no1uxa1K+NIIUw45
 qAbUKjmCUqYwyiT+6ABBqMCC8zxeWbVyfAssoTqKI9FVa+Mi6hKVfMs6BQ8cuP+l+X4L
 i7RHN94fo8Vstyr8vHglIQaXMzRJNFH9KVY6ycd5A6TAxNZ/UFf0blQEOEPj3Xpct+Y5
 DgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788443053; x=1789047853;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YF2dBg7VqdrD6bEdT5nmZf9EuyKgTiJN3OVROK0s5RI=;
 b=Xhw9DLWZ/DXk+gyEVIXwxAHa+pX4w4cHX0EKhdfEftafwSdKqCy5rSVc3DBrqhhIIu
 BcoBoIi10d/Dp0cW7ynTi+If5IghbHPOsQg/xi9eGTVbJmW0rVKTz3Gh/7Uv9kSy01GE
 CPL7KVJEj1wxgBvTxRwrAHb1H/4zKRfmslMBP4dMnISMrnE3S44yUnmS4h4mrVFfAxhq
 mgNavy1Jv9NJtdg4sT/MAPJlD0rd47h3vUkROckx7DuFn9WJW6ZPemr2UqEe3GxiMYpS
 4q2esA9K0dagGuRmAbpxfbzILprJ56gGXYf3UL49zH74U2FR5S0BNxFV+o0u5tOAk022
 3VWA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwZE6XzBAVt9XbkOqiE5uLmvkR8ulJn0w7Wo1cxn/tQo0fKQl8tgMUkx4PJgsBWyDVauqEktA01NFo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lkRSDiLviQ3xY8K3Q44LDNknFM7Zvrc899dI4i3cOZ0oTi9fpR
 gnhrm+U8G+bh8u5EGWzV845rheQGdxkvIf+FihPSZNKk+hIVL+fOLYA8
X-Gm-Gg: AYBFou0qyeRSJmoMblQKKZbE7CkbwzoEwikaYEN1zaKrHbIG/r3vfcn5ge4UyXIJxng
 +I8Ww82uEJmhBDysZGlKo731wv2Cn5ntwY+p0whH1CdSVpca/AgkGlsDxIZR20GDfyPspVwrpG3
 4E0b36N6O4pZi1VkeuPJKPmSrGxIC3hxysebb3k3TZToi0sfbz+rJtfoRcrK6u5p/XErZLuz9sQ
 U5BYaCRE7mGNMJniiDiE2YiFykoEsZKFwqJn0CGOqOfZxc23vA0qjakfvC/v66WoXoYziya7cOg
 MMRHoAGAsRpAU0cD7p2S9SEgfTBq8qqEQkhVJt4IWaxDEigJ01jyw2ywFHWTzMpCVLaqSYjiTVD
 BdB3RtYtSVSsD9QQmuuvj44uTS7lD181i7IdttyUb8wpUa09WDDDfepJmHpdbwPONr1NLQMGMI+
 79UICLEgomcxmvlbJYhGHaDAB+4+wUscSDzxl4e7GXnmswl2O6IMhhqqnjaT+AZw6FX4wbJtKW+
 MoHzEyAa1WW
X-Received: by 2002:a05:6000:4304:b0:485:d61:65b1 with SMTP id
 ffacd0b85a97d-4858609d1a1mr805274f8f.19.1788443053025; 
 Thu, 03 Sep 2026 06:44:13 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15d9:4700:e712:9f38:603a:54e4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448e736a6sm13597080f8f.5.2026.09.03.06.44.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 06:44:12 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: thomas.hellstrom@linux.intel.com, dakr@kernel.org, ecourtney@nvidia.com,
 matthew.brost@intel.com, nat@pixelcluster.dev,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/11] dma-buf: Add reference counting to dma_resv v2
Date: Thu,  3 Sep 2026 15:27:57 +0200
Message-ID: <20260903134408.105317-3-christian.koenig@amd.com>
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

v2: keep and fix comments Sonnet removed (why the heck?), document that the
    allocated flag is only temporary

Signed-off-by: Christian König <christian.koenig@amd.com>
Assisted-by: Claude:Sonnet 4
---
 drivers/dma-buf/dma-buf.c                  | 24 +++----
 drivers/dma-buf/dma-resv.c                 | 78 ++++++++++++++++++++--
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
 12 files changed, 119 insertions(+), 33 deletions(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index d504c636dc29..53e428fdaf6b 100644
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
index 2365a6d8ca15..5ae5a4b40ae6 100644
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
@@ -137,26 +138,93 @@ static void dma_resv_list_free(struct dma_resv_list *list)
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
+	struct dma_resv *obj = container_of(kref, struct dma_resv, refcount);
+
 	/*
 	 * This object should be dead and all references must have
 	 * been released to it, so no need to be protected with rcu.
 	 */
 	dma_resv_list_free(rcu_dereference_protected(obj->fences, true));
 	ww_mutex_destroy(&obj->lock);
+
+	/* TODO: Only as temporary workaround till dma_fence_init() is removed */
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
+ * count reaches zero, the object is cleaned up with dma_resv_release() and freed
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
index 0b96136bbd54..2c43d2d2b016 100644
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
index 018df97d590d..48176a11d552 100644
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
index 3bcc7bf0900c..312d5e9675f0 100644
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
index 9e01f8b2079a..1340e8898a86 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_object.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_object.c
@@ -89,7 +89,7 @@ struct drm_i915_gem_object *i915_gem_object_alloc(void)
 
 void i915_gem_object_free(struct drm_i915_gem_object *obj)
 {
-	dma_resv_fini(&obj->base._resv);
+	dma_resv_put(&obj->base._resv);
 	return kmem_cache_free(slab_objects, obj);
 }
 
diff --git a/drivers/gpu/drm/i915/gt/intel_ggtt.c b/drivers/gpu/drm/i915/gt/intel_ggtt.c
index 64ca5bbc53c6..3cc8df7b8fad 100644
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
index afbc5c769308..7b1bdb121c88 100644
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
index 0e8de6d4b36f..67c9d32f4f27 100644
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
index f3103307b5df..49b0b48c6c2a 100644
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
index bd0b23ac2cc4..af5732f9e489 100644
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
index c5ab6fd9ebe8..4d12519df34e 100644
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

