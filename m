Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2484BFF885C
	for <dri-devel@archiver.kernel.org>; Sun, 26 Apr 2026 10:38:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BD5E10E012;
	Sun, 26 Apr 2026 10:38:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i1UyPsO7";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C69FD10E012
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 10:38:35 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2b788a98557so41904905ad.2
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 03:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777199915; x=1777804715; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gRIYnBpWA24QfNeeW5zuWFSB7co7+n6A75Ah4Y5MXZE=;
 b=i1UyPsO74k72WfvKd470Gtf52Ro0ITAJ3IFKTLP7n7y9YTvoY43stTZmtO8IGUxG1B
 F0XseC+k3VmAJPrFYT0tJIHpI6hrZ9pJWObjORtKdHnilaxPVJEdFQDZflsD7zDXxEBY
 hxMTXrteKVQBZsXjvzq4zYQLazNmXZZg0EXRS9ilf5xxyZxZmQg/7eVp36q3Kf3GgufB
 /HtTswgMIlqRIE5fCZxu5WFUDoztPA+GaN00Z6Uf1Di/VfNML1b9k9oDb8bWidxmKThF
 TZtdkPPVhc8myBtLMThmYSdaacdmhkMVjU2V5IvP8ZA9Abi6vC6dDPAVTFUZ2D/a0KO5
 JCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777199915; x=1777804715;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gRIYnBpWA24QfNeeW5zuWFSB7co7+n6A75Ah4Y5MXZE=;
 b=FJLOiF1JhdI+61DYewvY0sSX2KDnR+sYyOL2nAczKAC4mcn1RuC/O9/r3co2fKlU2m
 Z+o10g/MqpAu8mUtge4n137BLCDmYn5jiJlCaHjmbJQ+1UlorzG072w1A6YwbXzOcs0C
 5SAC1Wj3FgqRPf64C9Jpp06TVOQkmm+A2pv8enwT8m+d+B3dQGwKfp4rgLuGGZSj5rF/
 yKNxd5T48y5bsWNZ8KrL9Q7mzHThCKnzZJS0KeKn8/i/ZjVUhg3Absb8hDrcEmTdCG2y
 zKY1L1m7/DbBP3HGWi6cSB4/+2oSvcI6ETEIt+RS5gu8B3stEb1Q1h5Bpb2Gm2HUFwfk
 coGA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9B1+x6Rnclyyy34TW8u4tFRyhPGOGs7E4HVjH3YMH86ZHr5cjy6TWQieDvKlmek3LbcoEiFY0jYGE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx+1vVo6PvIhZ5h4uX1nvNasoUZk5YfLcsQYy96EVb/gtpgPm46
 YahfYLIWayk3Somn2PBdcLt2LJgaSBuAdYxyQFOg8BGDT7Pvm+S9fmGN
X-Gm-Gg: AeBDietHWiRe2k2s4/IaPNx/GgrPosptXTBF22CdvN4uTeCOe2PhMUUIVC/HBdB8cQY
 Mg/4EwUj5KhNdxdK3R19e2OMwbEXdyGu81FeNby5a625TM165EtVaF0droptjfC1zdY3GjYDXva
 HK6qt0B8W3fui4FpPpbJs/2P5E4uLPjfNhpxrJw3549Sj0ZZ8yZ+mq/7eXf1m7qbbqOvm8Ub8mF
 Na/1/18sxGEdd57XTF9839icWZRGHFS5yTWnvuaR7sppIXRT0qitzXULnAdo42W1mo8LuWYhIrB
 okaqu/2Ppxb9fZP8hsSrqEdzQs08oKRMT2C/mfvRsuFjjTxC9/IfI3IvzT/QM6tlBVu/cC9x9w8
 tY1G8NmcI54wXPl4Mx78+O5+0is/5vesGTyhEzObHLOHgCxQUnqSot1+P1jKQiy99gOkovuDx0a
 38yXVyWXtSWWbQC5k/ZwDocmudJg==
X-Received: by 2002:a17:902:f54b:b0:2b0:c90f:449c with SMTP id
 d9443c01a7336-2b5f9ea99fbmr405337915ad.9.1777199915152; 
 Sun, 26 Apr 2026 03:38:35 -0700 (PDT)
Received: from gye-SER8.. ([1.243.227.27]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab208d4sm296020455ad.55.2026.04.26.03.38.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 03:38:34 -0700 (PDT)
From: gyeyoung baek <gye976@gmail.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: gyeyoung baek <gye976@gmail.com>
Subject: [PATCH] accel/rocket: Fix drm_mm UAF on close vs in-flight job
Date: Sun, 26 Apr 2026 19:37:56 +0900
Message-ID: <20260426103758.1373137-1-gye976@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
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

The drm_mm and its mutex live in rocket_file_priv, which
rocket_postclose() frees on fd close.  But a BO held by an
in-flight job needs to access them later -- when its destructor
runs from the drm_sched free_job worker after the NPU IRQ --
and that access hits freed memory.

  BUG: KASAN: slab-use-after-free in __mutex_trylock_common+0x90/0x1e8
  Workqueue: <NPU>.npu drm_sched_free_job_work [gpu_sched]
  Call trace:
    __mutex_lock
    rocket_gem_bo_free
    rocket_job_cleanup
    rocket_job_free
    drm_sched_free_job_work [gpu_sched]

Move drm_mm and the mutex out of rocket_file_priv into the
kref-managed rocket_iommu_domain (renamed to rocket_vm).
Their lifetime now follows the vm: while any job references
the vm, the address-space state stays alive.

Fixes: ed98261b4168 ("accel/rocket: Add a new driver for Rockchip's NPU")
Signed-off-by: gyeyoung baek <gye976@gmail.com>
---
 drivers/accel/rocket/rocket_drv.c | 74 +++++++++++++++----------------
 drivers/accel/rocket/rocket_drv.h | 13 +++---
 drivers/accel/rocket/rocket_gem.c | 29 ++++++------
 drivers/accel/rocket/rocket_gem.h |  4 +-
 drivers/accel/rocket/rocket_job.c |  6 +--
 drivers/accel/rocket/rocket_job.h |  2 +-
 6 files changed, 63 insertions(+), 65 deletions(-)

diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/rocket_drv.c
index 8bbbce594..bddcfc0ff 100644
--- a/drivers/accel/rocket/rocket_drv.c
+++ b/drivers/accel/rocket/rocket_drv.c
@@ -26,46 +26,54 @@ static struct platform_device *drm_dev;
 static struct rocket_device *rdev;
 
 static void
-rocket_iommu_domain_destroy(struct kref *kref)
+rocket_vm_destroy(struct kref *kref)
 {
-	struct rocket_iommu_domain *domain = container_of(kref, struct rocket_iommu_domain, kref);
+	struct rocket_vm *vm = container_of(kref, struct rocket_vm, kref);
 
-	iommu_domain_free(domain->domain);
-	domain->domain = NULL;
-	kfree(domain);
+	drm_mm_takedown(&vm->mm);
+	mutex_destroy(&vm->lock);
+	iommu_domain_free(vm->domain);
+	vm->domain = NULL;
+	kfree(vm);
 }
 
-static struct rocket_iommu_domain*
-rocket_iommu_domain_create(struct device *dev)
+static struct rocket_vm *
+rocket_vm_create(struct device *dev)
 {
-	struct rocket_iommu_domain *domain = kmalloc_obj(*domain);
+	struct rocket_vm *vm = kmalloc_obj(*vm);
+	u64 start, end;
 	void *err;
 
-	if (!domain)
+	if (!vm)
 		return ERR_PTR(-ENOMEM);
 
-	domain->domain = iommu_paging_domain_alloc(dev);
-	if (IS_ERR(domain->domain)) {
-		err = ERR_CAST(domain->domain);
-		kfree(domain);
+	vm->domain = iommu_paging_domain_alloc(dev);
+	if (IS_ERR(vm->domain)) {
+		err = ERR_CAST(vm->domain);
+		kfree(vm);
 		return err;
 	}
-	kref_init(&domain->kref);
 
-	return domain;
+	start = vm->domain->geometry.aperture_start;
+	end = vm->domain->geometry.aperture_end;
+	drm_mm_init(&vm->mm, start, end - start + 1);
+	mutex_init(&vm->lock);
+	kref_init(&vm->kref);
+
+	return vm;
 }
 
-struct rocket_iommu_domain *
-rocket_iommu_domain_get(struct rocket_file_priv *rocket_priv)
+struct rocket_vm *
+rocket_vm_get(struct rocket_file_priv *rocket_priv)
 {
-	kref_get(&rocket_priv->domain->kref);
-	return rocket_priv->domain;
+	kref_get(&rocket_priv->vm->kref);
+	return rocket_priv->vm;
 }
 
 void
-rocket_iommu_domain_put(struct rocket_iommu_domain *domain)
+rocket_vm_put(struct rocket_vm *vm)
 {
-	kref_put(&domain->kref, rocket_iommu_domain_destroy);
+	kref_put(&vm->kref, rocket_vm_destroy);
 }
 
 static int
@@ -73,7 +81,6 @@ rocket_open(struct drm_device *dev, struct drm_file *file)
 {
 	struct rocket_device *rdev = to_rocket_device(dev);
 	struct rocket_file_priv *rocket_priv;
-	u64 start, end;
 	int ret;
 
 	if (!try_module_get(THIS_MODULE))
@@ -86,29 +93,22 @@ rocket_open(struct drm_device *dev, struct drm_file *file)
 	}
 
 	rocket_priv->rdev = rdev;
-	rocket_priv->domain = rocket_iommu_domain_create(rdev->cores[0].dev);
-	if (IS_ERR(rocket_priv->domain)) {
-		ret = PTR_ERR(rocket_priv->domain);
+	rocket_priv->vm = rocket_vm_create(rdev->cores[0].dev);
+	if (IS_ERR(rocket_priv->vm)) {
+		ret = PTR_ERR(rocket_priv->vm);
 		goto err_free;
 	}
 
 	file->driver_priv = rocket_priv;
 
-	start = rocket_priv->domain->domain->geometry.aperture_start;
-	end = rocket_priv->domain->domain->geometry.aperture_end;
-	drm_mm_init(&rocket_priv->mm, start, end - start + 1);
-	mutex_init(&rocket_priv->mm_lock);
-
 	ret = rocket_job_open(rocket_priv);
 	if (ret)
-		goto err_mm_takedown;
+		goto err_vm_put;
 
 	return 0;
 
-err_mm_takedown:
-	mutex_destroy(&rocket_priv->mm_lock);
-	drm_mm_takedown(&rocket_priv->mm);
-	rocket_iommu_domain_put(rocket_priv->domain);
+err_vm_put:
+	rocket_vm_put(rocket_priv->vm);
 err_free:
 	kfree(rocket_priv);
 err_put_mod:
@@ -122,9 +122,7 @@ rocket_postclose(struct drm_device *dev, struct drm_file *file)
 	struct rocket_file_priv *rocket_priv = file->driver_priv;
 
 	rocket_job_close(rocket_priv);
-	mutex_destroy(&rocket_priv->mm_lock);
-	drm_mm_takedown(&rocket_priv->mm);
-	rocket_iommu_domain_put(rocket_priv->domain);
+	rocket_vm_put(rocket_priv->vm);
 	kfree(rocket_priv);
 	module_put(THIS_MODULE);
 }
diff --git a/drivers/accel/rocket/rocket_drv.h b/drivers/accel/rocket/rocket_drv.h
index 2c673bb99..2754f46f1 100644
--- a/drivers/accel/rocket/rocket_drv.h
+++ b/drivers/accel/rocket/rocket_drv.h
@@ -11,22 +11,23 @@
 
 extern const struct dev_pm_ops rocket_pm_ops;
 
-struct rocket_iommu_domain {
+struct rocket_vm {
 	struct iommu_domain *domain;
+	struct drm_mm mm;
+	/* protects @mm */
+	struct mutex lock;
 	struct kref kref;
 };
 
 struct rocket_file_priv {
 	struct rocket_device *rdev;
 
-	struct rocket_iommu_domain *domain;
-	struct drm_mm mm;
-	struct mutex mm_lock;
+	struct rocket_vm *vm;
 
 	struct drm_sched_entity sched_entity;
 };
 
-struct rocket_iommu_domain *rocket_iommu_domain_get(struct rocket_file_priv *rocket_priv);
-void rocket_iommu_domain_put(struct rocket_iommu_domain *domain);
+struct rocket_vm *rocket_vm_get(struct rocket_file_priv *rocket_priv);
+void rocket_vm_put(struct rocket_vm *vm);
 
 #endif
diff --git a/drivers/accel/rocket/rocket_gem.c b/drivers/accel/rocket/rocket_gem.c
index b6a385d2e..7f64134fd 100644
--- a/drivers/accel/rocket/rocket_gem.c
+++ b/drivers/accel/rocket/rocket_gem.c
@@ -14,20 +14,20 @@
 static void rocket_gem_bo_free(struct drm_gem_object *obj)
 {
 	struct rocket_gem_object *bo = to_rocket_bo(obj);
-	struct rocket_file_priv *rocket_priv = bo->driver_priv;
+	struct rocket_vm *vm = bo->vm;
 	size_t unmapped;
 
 	drm_WARN_ON(obj->dev, refcount_read(&bo->base.pages_use_count) > 1);
 
-	unmapped = iommu_unmap(bo->domain->domain, bo->mm.start, bo->size);
+	unmapped = iommu_unmap(vm->domain, bo->mm.start, bo->size);
 	drm_WARN_ON(obj->dev, unmapped != bo->size);
 
-	mutex_lock(&rocket_priv->mm_lock);
+	mutex_lock(&vm->lock);
 	drm_mm_remove_node(&bo->mm);
-	mutex_unlock(&rocket_priv->mm_lock);
+	mutex_unlock(&vm->lock);
 
-	rocket_iommu_domain_put(bo->domain);
-	bo->domain = NULL;
+	rocket_vm_put(vm);
+	bo->vm = NULL;
 
 	drm_gem_shmem_free(&bo->base);
 }
@@ -64,6 +64,7 @@ int rocket_ioctl_create_bo(struct drm_device *dev, void *data, struct drm_file *
 	struct drm_gem_shmem_object *shmem_obj;
 	struct rocket_gem_object *rkt_obj;
 	struct drm_gem_object *gem_obj;
+	struct rocket_vm *vm;
 	struct sg_table *sgt;
 	int ret;
 
@@ -74,8 +75,8 @@ int rocket_ioctl_create_bo(struct drm_device *dev, void *data, struct drm_file *
 	gem_obj = &shmem_obj->base;
 	rkt_obj = to_rocket_bo(gem_obj);
 
-	rkt_obj->driver_priv = rocket_priv;
-	rkt_obj->domain = rocket_iommu_domain_get(rocket_priv);
+	vm = rocket_vm_get(rocket_priv);
+	rkt_obj->vm = vm;
 	rkt_obj->size = args->size;
 	rkt_obj->offset = 0;
 
@@ -90,13 +91,13 @@ int rocket_ioctl_create_bo(struct drm_device *dev, void *data, struct drm_file *
 		goto err;
 	}
 
-	mutex_lock(&rocket_priv->mm_lock);
-	ret = drm_mm_insert_node_generic(&rocket_priv->mm, &rkt_obj->mm,
+	mutex_lock(&vm->lock);
+	ret = drm_mm_insert_node_generic(&vm->mm, &rkt_obj->mm,
 					 rkt_obj->size, PAGE_SIZE,
 					 0, 0);
-	mutex_unlock(&rocket_priv->mm_lock);
+	mutex_unlock(&vm->lock);
 
-	ret = iommu_map_sgtable(rocket_priv->domain->domain,
+	ret = iommu_map_sgtable(vm->domain,
 				rkt_obj->mm.start,
 				shmem_obj->sgt,
 				IOMMU_READ | IOMMU_WRITE);
@@ -115,9 +116,9 @@ int rocket_ioctl_create_bo(struct drm_device *dev, void *data, struct drm_file *
 	return 0;
 
 err_remove_node:
-	mutex_lock(&rocket_priv->mm_lock);
+	mutex_lock(&vm->lock);
 	drm_mm_remove_node(&rkt_obj->mm);
-	mutex_unlock(&rocket_priv->mm_lock);
+	mutex_unlock(&vm->lock);
 
 err:
 	drm_gem_shmem_object_free(gem_obj);
diff --git a/drivers/accel/rocket/rocket_gem.h b/drivers/accel/rocket/rocket_gem.h
index 240430334..e1fbbd8cf 100644
--- a/drivers/accel/rocket/rocket_gem.h
+++ b/drivers/accel/rocket/rocket_gem.h
@@ -9,9 +9,7 @@
 struct rocket_gem_object {
 	struct drm_gem_shmem_object base;
 
-	struct rocket_file_priv *driver_priv;
-
-	struct rocket_iommu_domain *domain;
+	struct rocket_vm *vm;
 	struct drm_mm_node mm;
 	size_t size;
 	u32 offset;
diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index 2f1861f96..7695fca02 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -233,7 +233,7 @@ static void rocket_job_cleanup(struct kref *ref)
 						refcount);
 	unsigned int i;
 
-	rocket_iommu_domain_put(job->domain);
+	rocket_vm_put(job->vm);
 
 	dma_fence_put(job->done_fence);
 	dma_fence_put(job->inference_done_fence);
@@ -314,7 +314,7 @@ static struct dma_fence *rocket_job_run(struct drm_sched_job *sched_job)
 	if (ret < 0)
 		return fence;
 
-	ret = iommu_attach_group(job->domain->domain, core->iommu_group);
+	ret = iommu_attach_group(job->vm->domain, core->iommu_group);
 	if (ret < 0)
 		return fence;
 
@@ -573,7 +573,7 @@ static int rocket_ioctl_submit_job(struct drm_device *dev, struct drm_file *file
 
 	rjob->out_bo_count = job->out_bo_handle_count;
 
-	rjob->domain = rocket_iommu_domain_get(file_priv);
+	rjob->vm = rocket_vm_get(file_priv);
 
 	ret = rocket_job_push(rjob);
 	if (ret)
diff --git a/drivers/accel/rocket/rocket_job.h b/drivers/accel/rocket/rocket_job.h
index 4ae00feec..9373c3d02 100644
--- a/drivers/accel/rocket/rocket_job.h
+++ b/drivers/accel/rocket/rocket_job.h
@@ -36,7 +36,7 @@ struct rocket_job {
 	/* Fence to be signaled by IRQ handler when the job is complete. */
 	struct dma_fence *done_fence;
 
-	struct rocket_iommu_domain *domain;
+	struct rocket_vm *vm;
 
 	struct kref refcount;
 };
-- 
2.43.0

