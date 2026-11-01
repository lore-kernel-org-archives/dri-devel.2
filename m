Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B67606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 07:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bwoMo1VE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 113A010E0B0;
	Sun,  1 Nov 2026 07:37:42 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0233410E0B0
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 07:37:35 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-3ae486f8a27so1159811a91.0
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 00:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793518655; x=1794123455; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=t/gjE8PAV/l+wGQLdHNbUraby6W5o/4waIhxkQthi2Q=;
 b=bwoMo1VEEwXIbxC7EXGVOgJa6z+jbFB3kuQd4wVPfhbg9rlCKTI4ss/ZlVt14AWqfl
 dcS4xK02cmzIRNSwhOJ3nYuu3DKHQRBnltP2fya5HofbIE+GIDx/xDlAqpQV3thMjbi0
 AQptOh/wuniuiv/qrOWMz/9G+ZFg1dHgtCQfUza6BXFKoQVRbYlSgOd7Kmy3URn2EUD1
 TFPIrQWpcxvGf71IChQLbmZ5CYaxJQawGlrrLsLjwnZCW1K4LdLD+IF1yq2ir3VU3KoK
 HyN0arAf0TyZrIQfTXtNcV0vfQwGo5rI/mBYTzvtZMk0WVPd+U6ArkVD2SHm74+CGBZV
 Vg+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793518655; x=1794123455;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t/gjE8PAV/l+wGQLdHNbUraby6W5o/4waIhxkQthi2Q=;
 b=I/Kph3f4IRxsQE+RMYdR2qOKMwLJ8ma3oCFPs4fne6SbLIbL5NaBlartR0OoHe8EDz
 /uQdWeMGfyNLhM32AG8CKotXOIHYSyyfRopwqQQzuGJjOaOm1PE2wYxcaADx38azVZXn
 WD6Qq0ZS9Yh8Zxke5h8HNw+qQNnH5CoLCYe/TI1QKZLWk7c7g+HABmg2ON+HZ/j4pQOL
 wUBe0n0Kp6e4qrZGpHOlkBBZEhTRrsRIEle/uJ8XdUAIKSloA0Y7EkCOYKl0aXwAYPWm
 HYT86D0vdL7tVVMJ6j+c4LGvKh0Ez7Tj0qOn7ztKmmhdwClHn3eJJ/TIZnJerELptzoG
 rHEg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxxNhIS7oGC7e52T9FV13h2xbxB/Tk8Wao+AQQ6OwztYf+Dmv9j/F/9v+ampfdPS9dkdNHHgUO0izk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9E/OA7WxcIaR917K6mH9wU2ege6e5G018tBCEebjvhLV3D25te
 Aadi+DOuj35zYB5toEqQQR3jMnHwgHKINvOGbtfC4j7po+esp7HLDfeE
X-Gm-Gg: AYBFou1giSOqiissjGYpi1W5gCsMoGPfW2WiPhY74kaRkBZBlMHPWdRrXVSRUmIKpIg
 Qzi+6q1Si2g6Qsothcyuu6PbyWjBlN+4IxORDrPWTYR89pKxLLFwWR5gIt82cHXrjd5fM+CZrlp
 3aDZzP8CmHqPKLq/RD7niagyCgbkTLUaFNn6+NchhxOV27VkSvgkAAGFSxxqbazCxvOjWhXrKcO
 J0UEg2Wvq3thDYo1q2pZKr3Zv6771H6CMYm3RiPpclfvbEweRR7vmbvnAXwVejEoqtc80OdhDB/
 rXGYoZG2CZBwWyN5XrSOcbVRKRnT0Ds95gG7r/caqL0xkUggFGHfixrFsmCqbFSWah0BFKJTVxw
 fCf4hf5ViHbFkpuvTSIEikJkAlAu9QqlEP5Dytkx9HTqkVwuQlaTiqqPgrnRYav6nZkY0v6Y5hb
 xhAqyXRnn0/ow9hvPdHHYkAcyl8XvJDSf5U228eaqX3Atfj5IGqrC+bF9XdJV1ohsgDN5fQ7Krx
 nomu4BYQQoOIIlGZqvxvBpA6aysJQFiqU6YgI4K5Etw89JBfXBym1hJFT7ml247jRhOoQoMIfZl
 fwjpZ2wtqoBM8UwtqK8XKxDR3FNtWikbha9k6CpOhspcng==
X-Received: by 2002:a17:90b:2741:b0:3a0:e4ce:31fd with SMTP id
 98e67ed59e1d1-3ae896f8304mr6013969a91.10.1793518655425; 
 Sun, 01 Nov 2026 00:37:35 -0700 (PDT)
Received: from gye-SER8.tail6a86d6.ts.net ([121.125.115.175])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdb096b8323sm2114642a12.6.2026.11.01.00.37.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 00:37:34 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Oded Gabbay <ogabbay@kernel.org>
Cc: Jeff Hugo <jeff.hugo@oss.qualcomm.com>, Heiko Stuebner <heiko@sntech.de>,
 Sidong Yang <sidong.yang@furiosa.ai>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH v2] accel/rocket: Fix drm_mm UAF on close vs in-flight job
Date: Sun,  1 Nov 2026 16:37:00 +0900
Message-ID: <20261101073700.1261966-1-gye976@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The drm_mm and its mutex live in rocket_file_priv, which
rocket_postclose() frees on fd close.  But a BO held by an
in-flight job is only freed after close, from the drm_sched
free_job worker, and its destructor then accesses the already
freed drm_mm and mutex.

  BUG: KASAN: slab-use-after-free in __mutex_trylock_common+0x90/0x1e8
  Workqueue: <NPU>.npu drm_sched_free_job_work [gpu_sched]
  Call trace:
    __mutex_lock
    rocket_gem_bo_free
    rocket_job_cleanup
    rocket_job_free
    drm_sched_free_job_work [gpu_sched]

Move drm_mm and the mutex out of rocket_file_priv into the
kref-managed rocket_iommu_domain (renamed to rocket_vm).  Their
lifetime now matches the vm's: as long as a BO or job references
the vm, the address-space state stays alive.

Fixes: ed98261b4168 ("accel/rocket: Add a new driver for Rockchip's NPU")
Cc: stable@vger.kernel.org
Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
Changes in v2:
- Rebased on drm-misc-fixes and resent. No functional changes.
- Link to v1: https://lore.kernel.org/r/20260426103758.1373137-1-gye976@gmail.com

 drivers/accel/rocket/rocket_drv.c | 74 +++++++++++++++----------------
 drivers/accel/rocket/rocket_drv.h | 13 +++---
 drivers/accel/rocket/rocket_gem.c | 31 ++++++-------
 drivers/accel/rocket/rocket_gem.h |  4 +-
 drivers/accel/rocket/rocket_job.c |  6 +--
 drivers/accel/rocket/rocket_job.h |  2 +-
 6 files changed, 64 insertions(+), 66 deletions(-)

diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/rocket_drv.c
index 5d7805c41dc..f58c15131dc 100644
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
index 2c673bb99cc..2754f46f174 100644
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
index a5fffa51ff3..057fd82e2a5 100644
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
 
@@ -85,15 +86,15 @@ int rocket_ioctl_create_bo(struct drm_device *dev, void *data, struct drm_file *
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
 	if (ret)
 		goto err;
 
-	ret = iommu_map_sgtable(rocket_priv->domain->domain,
+	ret = iommu_map_sgtable(vm->domain,
 				rkt_obj->mm.start,
 				shmem_obj->sgt,
 				IOMMU_READ | IOMMU_WRITE);
@@ -118,13 +119,13 @@ int rocket_ioctl_create_bo(struct drm_device *dev, void *data, struct drm_file *
 	return 0;
 
 err_unmap:
-	iommu_unmap(rocket_priv->domain->domain,
+	iommu_unmap(vm->domain,
 		    rkt_obj->mm.start, rkt_obj->size);
 
 err_remove_node:
-	mutex_lock(&rocket_priv->mm_lock);
+	mutex_lock(&vm->lock);
 	drm_mm_remove_node(&rkt_obj->mm);
-	mutex_unlock(&rocket_priv->mm_lock);
+	mutex_unlock(&vm->lock);
 
 err:
 	drm_gem_shmem_object_free(gem_obj);
diff --git a/drivers/accel/rocket/rocket_gem.h b/drivers/accel/rocket/rocket_gem.h
index 24043033450..e1fbbd8cf71 100644
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
index 4bc4f9c8ee4..0de56bb84e3 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -240,7 +240,7 @@ static void rocket_job_cleanup(struct kref *ref)
 						refcount);
 	unsigned int i;
 
-	rocket_iommu_domain_put(job->domain);
+	rocket_vm_put(job->vm);
 
 	dma_fence_put(job->done_fence);
 	dma_fence_put(job->inference_done_fence);
@@ -321,7 +321,7 @@ static struct dma_fence *rocket_job_run(struct drm_sched_job *sched_job)
 	if (ret < 0)
 		goto err_put_fences;
 
-	ret = iommu_attach_group(job->domain->domain, core->iommu_group);
+	ret = iommu_attach_group(job->vm->domain, core->iommu_group);
 	if (ret < 0)
 		goto err_put_pm;
 
@@ -564,7 +564,7 @@ static int rocket_ioctl_submit_job(struct drm_device *dev, struct drm_file *file
 	kref_init(&rjob->refcount);
 
 	rjob->rdev = rdev;
-	rjob->domain = rocket_iommu_domain_get(file_priv);
+	rjob->vm = rocket_vm_get(file_priv);
 
 	ret = drm_sched_job_init(&rjob->base,
 				 &file_priv->sched_entity,
diff --git a/drivers/accel/rocket/rocket_job.h b/drivers/accel/rocket/rocket_job.h
index 4ae00feec3b..9373c3d0273 100644
--- a/drivers/accel/rocket/rocket_job.h
+++ b/drivers/accel/rocket/rocket_job.h
@@ -36,7 +36,7 @@ struct rocket_job {
 	/* Fence to be signaled by IRQ handler when the job is complete. */
 	struct dma_fence *done_fence;
 
-	struct rocket_iommu_domain *domain;
+	struct rocket_vm *vm;
 
 	struct kref refcount;
 };

base-commit: f00d7a241f846b053e89c0bb2285ef5988d4cafc
-- 
2.43.0

