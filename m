Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00975C88E4C
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 11:40:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07B2110F35A;
	Fri, 11 Sep 2026 11:40:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="G+eD4Hwj";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id F2AD810F35A
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 11:40:37 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFC621655;
 Fri, 11 Sep 2026 04:40:33 -0700 (PDT)
Received: from e120398-lin.trondheim.arm.com (e120398-lin.trondheim.arm.com
 [10.42.46.160])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B29B3F59E;
 Fri, 11 Sep 2026 04:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789126837; bh=VotY5yVk2kEF+6syW15FI6fV9p/yKv/256/aV84IF+Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=G+eD4HwjrJ2wk8Ei4E8Key++sqqDCqKvTVboon//AkI533zytn7nhKpPodJ5Ky+dD
 HiN8bXqKI2VPY1lvO42frCfX5ziDcAUjK54vbOiaEh8LdVhTUkWU09EPXrwx1AYu+l
 vKFw3ji2ffspdS+kM2E3XFXgIRYpZ7mXc6FCK97U=
From: Ketil Johnsen <ketil.johnsen@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Ketil Johnsen <ketil.johnsen@arm.com>
Subject: [PATCH v3 3/6] drm/panthor: Pass drm_file instead of panthor_file
Date: Fri, 11 Sep 2026 13:40:11 +0200
Message-ID: <20260911114014.79139-4-ketil.johnsen@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911114014.79139-1-ketil.johnsen@arm.com>
References: <20260911114014.79139-1-ketil.johnsen@arm.com>
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

From: Boris Brezillon <boris.brezillon@collabora.com>

Some sched helpers need info that are part of drm_file, and we will
soon need to call drm_gem_object_lookup() from panthor_group_create().
Let's prepare for that by passing a drm_file instead of panthor_file to
all current helpers taking a panthor_file, so we keep things consistent.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Co-developed-by: Ketil Johnsen <ketil.johnsen@arm.com>
Signed-off-by: Ketil Johnsen <ketil.johnsen@arm.com>

---

v3:
- Fixed incorrect parameter passed to panthor_gpu_show_fdinfo()

v2:
- First introduction of this patch in this patch set
---
 drivers/gpu/drm/panthor/panthor_drv.c   | 38 +++++++++++--------------
 drivers/gpu/drm/panthor/panthor_mmu.c   | 11 ++++---
 drivers/gpu/drm/panthor/panthor_mmu.h   |  6 ++--
 drivers/gpu/drm/panthor/panthor_sched.c | 37 ++++++++++++++----------
 drivers/gpu/drm/panthor/panthor_sched.h | 23 +++++++--------
 5 files changed, 59 insertions(+), 56 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index 46a3080b0b206..51eb77633602f 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -1111,7 +1111,6 @@ static int panthor_ioctl_bo_mmap_offset(struct drm_device *ddev, void *data,
 static int panthor_ioctl_group_submit(struct drm_device *ddev, void *data,
 				      struct drm_file *file)
 {
-	struct panthor_file *pfile = file->driver_priv;
 	struct drm_panthor_group_submit *args = data;
 	struct drm_panthor_queue_submit *jobs_args;
 	struct panthor_submit_ctx ctx;
@@ -1136,8 +1135,7 @@ static int panthor_ioctl_group_submit(struct drm_device *ddev, void *data,
 		const struct drm_panthor_queue_submit *qsubmit = &jobs_args[i];
 		struct drm_sched_job *job;
 
-		job = panthor_job_create(pfile, args->group_handle, qsubmit,
-					 file->client_id);
+		job = panthor_job_create(file, args->group_handle, qsubmit);
 		if (IS_ERR(job)) {
 			ret = PTR_ERR(job);
 			goto out_cleanup_submit_ctx;
@@ -1217,19 +1215,17 @@ static int panthor_ioctl_group_submit(struct drm_device *ddev, void *data,
 static int panthor_ioctl_group_destroy(struct drm_device *ddev, void *data,
 				       struct drm_file *file)
 {
-	struct panthor_file *pfile = file->driver_priv;
 	struct drm_panthor_group_destroy *args = data;
 
 	if (args->pad)
 		return -EINVAL;
 
-	return panthor_group_destroy(pfile, args->group_handle);
+	return panthor_group_destroy(file, args->group_handle);
 }
 
 static int panthor_ioctl_group_create(struct drm_device *ddev, void *data,
 				      struct drm_file *file)
 {
-	struct panthor_file *pfile = file->driver_priv;
 	struct drm_panthor_group_create *args = data;
 	struct drm_panthor_queue_create *queue_args;
 	int ret;
@@ -1245,7 +1241,7 @@ static int panthor_ioctl_group_create(struct drm_device *ddev, void *data,
 	if (ret)
 		goto out;
 
-	ret = panthor_group_create(pfile, args, queue_args, file->client_id);
+	ret = panthor_group_create(file, args, queue_args);
 	if (ret < 0)
 		goto out;
 	args->group_handle = ret;
@@ -1259,10 +1255,9 @@ static int panthor_ioctl_group_create(struct drm_device *ddev, void *data,
 static int panthor_ioctl_group_get_state(struct drm_device *ddev, void *data,
 					 struct drm_file *file)
 {
-	struct panthor_file *pfile = file->driver_priv;
 	struct drm_panthor_group_get_state *args = data;
 
-	return panthor_group_get_state(pfile, args);
+	return panthor_group_get_state(file, args);
 }
 
 static int panthor_ioctl_tiler_heap_create(struct drm_device *ddev, void *data,
@@ -1605,6 +1600,7 @@ panthor_open(struct drm_device *ddev, struct drm_file *file)
 	if (!pfile)
 		return -ENOMEM;
 
+	file->driver_priv = pfile;
 	pfile->ptdev = ptdev;
 	pfile->user_mmio.offset = DRM_PANTHOR_USER_MMIO_OFFSET;
 
@@ -1619,19 +1615,18 @@ panthor_open(struct drm_device *ddev, struct drm_file *file)
 #endif
 
 
-	ret = panthor_vm_pool_create(pfile);
+	ret = panthor_vm_pool_create(file);
 	if (ret)
 		goto err_free_file;
 
-	ret = panthor_group_pool_create(pfile);
+	ret = panthor_group_pool_create(file);
 	if (ret)
 		goto err_destroy_vm_pool;
 
-	file->driver_priv = pfile;
 	return 0;
 
 err_destroy_vm_pool:
-	panthor_vm_pool_destroy(pfile);
+	panthor_vm_pool_destroy(file);
 
 err_free_file:
 	kfree(pfile);
@@ -1643,8 +1638,8 @@ panthor_postclose(struct drm_device *ddev, struct drm_file *file)
 {
 	struct panthor_file *pfile = file->driver_priv;
 
-	panthor_group_pool_destroy(pfile);
-	panthor_vm_pool_destroy(pfile);
+	panthor_group_pool_destroy(file);
+	panthor_vm_pool_destroy(file);
 
 	kfree(pfile);
 }
@@ -1704,11 +1699,13 @@ static int panthor_mmap(struct file *filp, struct vm_area_struct *vma)
 }
 
 static void panthor_gpu_show_fdinfo(struct panthor_device *ptdev,
-				    struct panthor_file *pfile,
+				    struct drm_file *file,
 				    struct drm_printer *p)
 {
+	struct panthor_file *pfile = file->driver_priv;
+
 	if (ptdev->profile_mask & PANTHOR_DEVICE_PROFILING_ALL)
-		panthor_fdinfo_gather_group_samples(pfile);
+		panthor_fdinfo_gather_group_samples(file);
 
 	if (ptdev->profile_mask & PANTHOR_DEVICE_PROFILING_TIMESTAMP) {
 #ifdef CONFIG_ARM_ARCH_TIMER
@@ -1728,11 +1725,10 @@ static void panthor_gpu_show_fdinfo(struct panthor_device *ptdev,
 static void panthor_show_internal_memory_stats(struct drm_printer *p, struct drm_file *file)
 {
 	char *drv_name = file->minor->dev->driver->name;
-	struct panthor_file *pfile = file->driver_priv;
 	struct drm_memory_stats stats = {0};
 
-	panthor_fdinfo_gather_group_mem_info(pfile, &stats);
-	panthor_vm_heaps_sizes(pfile, &stats);
+	panthor_fdinfo_gather_group_mem_info(file, &stats);
+	panthor_vm_heaps_sizes(file, &stats);
 
 	drm_fdinfo_print_size(p, drv_name, "resident", "memory", stats.resident);
 	drm_fdinfo_print_size(p, drv_name, "active", "memory", stats.active);
@@ -1743,7 +1739,7 @@ static void panthor_show_fdinfo(struct drm_printer *p, struct drm_file *file)
 	struct drm_device *dev = file->minor->dev;
 	struct panthor_device *ptdev = container_of(dev, struct panthor_device, base);
 
-	panthor_gpu_show_fdinfo(ptdev, file->driver_priv, p);
+	panthor_gpu_show_fdinfo(ptdev, file, p);
 	panthor_show_internal_memory_stats(p, file);
 
 	drm_show_memory_stats(p, file);
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index d75d575473da4..3e5f20768d545 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -1692,8 +1692,9 @@ panthor_vm_pool_get_vm(struct panthor_vm_pool *pool, u32 handle)
  * Note that VMs can outlive the pool they were created from if other
  * objects hold a reference to there VMs.
  */
-void panthor_vm_pool_destroy(struct panthor_file *pfile)
+void panthor_vm_pool_destroy(struct drm_file *file)
 {
+	struct panthor_file *pfile = file->driver_priv;
 	struct panthor_vm *vm;
 	unsigned long i;
 
@@ -1715,8 +1716,9 @@ void panthor_vm_pool_destroy(struct panthor_file *pfile)
  *
  * Return: 0 on success, a negative error code otherwise.
  */
-int panthor_vm_pool_create(struct panthor_file *pfile)
+int panthor_vm_pool_create(struct drm_file *file)
 {
+	struct panthor_file *pfile = file->driver_priv;
 	struct panthor_gem_object *dummy;
 	int ret;
 
@@ -1737,7 +1739,7 @@ int panthor_vm_pool_create(struct panthor_file *pfile)
 	return 0;
 
 err_destroy_vm_pool:
-	panthor_vm_pool_destroy(pfile);
+	panthor_vm_pool_destroy(file);
 	return ret;
 }
 
@@ -2157,8 +2159,9 @@ struct panthor_heap_pool *panthor_vm_get_heap_pool(struct panthor_vm *vm, bool c
  * Calculate all heap chunk sizes in all heap pools bound to a VM. If the VM
  * is active, record the size as active as well.
  */
-void panthor_vm_heaps_sizes(struct panthor_file *pfile, struct drm_memory_stats *stats)
+void panthor_vm_heaps_sizes(struct drm_file *file, struct drm_memory_stats *stats)
 {
+	struct panthor_file *pfile = file->driver_priv;
 	struct panthor_vm *vm;
 	unsigned long i;
 
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.h b/drivers/gpu/drm/panthor/panthor_mmu.h
index abc36e7204be0..e262fe2303f6c 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.h
+++ b/drivers/gpu/drm/panthor/panthor_mmu.h
@@ -38,7 +38,7 @@ int panthor_vm_as(struct panthor_vm *vm);
 struct panthor_heap_pool *
 panthor_vm_get_heap_pool(struct panthor_vm *vm, bool create);
 
-void panthor_vm_heaps_sizes(struct panthor_file *pfile, struct drm_memory_stats *stats);
+void panthor_vm_heaps_sizes(struct drm_file *file, struct drm_memory_stats *stats);
 
 struct panthor_vm *panthor_vm_get(struct panthor_vm *vm);
 void panthor_vm_put(struct panthor_vm *vm);
@@ -64,8 +64,8 @@ void panthor_vm_add_job_fence_to_bos_resvs(struct panthor_vm *vm,
 struct dma_resv *panthor_vm_resv(struct panthor_vm *vm);
 struct drm_gem_object *panthor_vm_root_gem(struct panthor_vm *vm);
 
-void panthor_vm_pool_destroy(struct panthor_file *pfile);
-int panthor_vm_pool_create(struct panthor_file *pfile);
+void panthor_vm_pool_destroy(struct drm_file *file);
+int panthor_vm_pool_create(struct drm_file *file);
 int panthor_vm_pool_create_vm(struct panthor_device *ptdev,
 			      struct panthor_vm_pool *pool,
 			      struct drm_panthor_vm_create *args);
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 1123cf36a7bca..e02062e8443ec 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -3112,8 +3112,9 @@ void panthor_sched_post_reset(struct panthor_device *ptdev, bool reset_failed)
 	}
 }
 
-void panthor_fdinfo_gather_group_samples(struct panthor_file *pfile)
+void panthor_fdinfo_gather_group_samples(struct drm_file *file)
 {
+	struct panthor_file *pfile = file->driver_priv;
 	struct panthor_group_pool *gpool = pfile->groups;
 	struct panthor_group *group;
 	unsigned long i;
@@ -3649,11 +3650,11 @@ static void add_group_kbo_sizes(struct panthor_device *ptdev,
 
 #define MAX_GROUPS_PER_POOL		128
 
-int panthor_group_create(struct panthor_file *pfile,
+int panthor_group_create(struct drm_file *file,
 			 const struct drm_panthor_group_create *group_args,
-			 const struct drm_panthor_queue_create *queue_args,
-			 u64 drm_client_id)
+			 const struct drm_panthor_queue_create *queue_args)
 {
+	struct panthor_file *pfile = file->driver_priv;
 	struct panthor_device *ptdev = pfile->ptdev;
 	struct panthor_group_pool *gpool = pfile->groups;
 	struct panthor_scheduler *sched = ptdev->scheduler;
@@ -3748,7 +3749,8 @@ int panthor_group_create(struct panthor_file *pfile,
 		goto err_put_group;
 
 	for (i = 0; i < group_args->queues.count; i++) {
-		group->queues[i] = group_create_queue(group, &queue_args[i], drm_client_id, gid, i);
+		group->queues[i] = group_create_queue(group, &queue_args[i],
+						      file->client_id, gid, i);
 		if (IS_ERR(group->queues[i])) {
 			ret = PTR_ERR(group->queues[i]);
 			group->queues[i] = NULL;
@@ -3788,8 +3790,9 @@ int panthor_group_create(struct panthor_file *pfile,
 	return ret;
 }
 
-int panthor_group_destroy(struct panthor_file *pfile, u32 group_handle)
+int panthor_group_destroy(struct drm_file *file, u32 group_handle)
 {
+	struct panthor_file *pfile = file->driver_priv;
 	struct panthor_group_pool *gpool = pfile->groups;
 	struct panthor_device *ptdev = pfile->ptdev;
 	struct panthor_scheduler *sched = ptdev->scheduler;
@@ -3834,9 +3837,10 @@ static struct panthor_group *group_from_handle(struct panthor_group_pool *pool,
 	return group;
 }
 
-int panthor_group_get_state(struct panthor_file *pfile,
+int panthor_group_get_state(struct drm_file *file,
 			    struct drm_panthor_group_get_state *get_state)
 {
+	struct panthor_file *pfile = file->driver_priv;
 	struct panthor_group_pool *gpool = pfile->groups;
 	struct panthor_device *ptdev = pfile->ptdev;
 	struct panthor_scheduler *sched = ptdev->scheduler;
@@ -3867,8 +3871,9 @@ int panthor_group_get_state(struct panthor_file *pfile,
 	return 0;
 }
 
-int panthor_group_pool_create(struct panthor_file *pfile)
+int panthor_group_pool_create(struct drm_file *file)
 {
+	struct panthor_file *pfile = file->driver_priv;
 	struct panthor_group_pool *gpool;
 
 	gpool = kzalloc_obj(*gpool);
@@ -3880,8 +3885,9 @@ int panthor_group_pool_create(struct panthor_file *pfile)
 	return 0;
 }
 
-void panthor_group_pool_destroy(struct panthor_file *pfile)
+void panthor_group_pool_destroy(struct drm_file *file)
 {
+	struct panthor_file *pfile = file->driver_priv;
 	struct panthor_group_pool *gpool = pfile->groups;
 	struct panthor_group *group;
 	unsigned long i;
@@ -3890,7 +3896,7 @@ void panthor_group_pool_destroy(struct panthor_file *pfile)
 		return;
 
 	xa_for_each(&gpool->xa, i, group)
-		panthor_group_destroy(pfile, i);
+		panthor_group_destroy(file, i);
 
 	xa_destroy(&gpool->xa);
 	kfree(gpool);
@@ -3905,9 +3911,10 @@ void panthor_group_pool_destroy(struct panthor_file *pfile)
  *
  */
 void
-panthor_fdinfo_gather_group_mem_info(struct panthor_file *pfile,
+panthor_fdinfo_gather_group_mem_info(struct drm_file *file,
 				     struct drm_memory_stats *stats)
 {
+	struct panthor_file *pfile = file->driver_priv;
 	struct panthor_group_pool *gpool = pfile->groups;
 	struct panthor_group *group;
 	unsigned long i;
@@ -3970,11 +3977,11 @@ struct panthor_vm *panthor_job_vm(struct drm_sched_job *sched_job)
 }
 
 struct drm_sched_job *
-panthor_job_create(struct panthor_file *pfile,
+panthor_job_create(struct drm_file *file,
 		   u16 group_handle,
-		   const struct drm_panthor_queue_submit *qsubmit,
-		   u64 drm_client_id)
+		   const struct drm_panthor_queue_submit *qsubmit)
 {
+	struct panthor_file *pfile = file->driver_priv;
 	struct panthor_group_pool *gpool = pfile->groups;
 	struct panthor_job *job;
 	u32 credits;
@@ -4045,7 +4052,7 @@ panthor_job_create(struct panthor_file *pfile,
 
 	ret = drm_sched_job_init(&job->base,
 				 &job->group->queues[job->queue_idx]->entity,
-				 credits, job->group, drm_client_id);
+				 credits, job->group, file->client_id);
 	if (ret)
 		goto err_put_job;
 
diff --git a/drivers/gpu/drm/panthor/panthor_sched.h b/drivers/gpu/drm/panthor/panthor_sched.h
index 9a8692de8aded..be7e1c8b4f563 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.h
+++ b/drivers/gpu/drm/panthor/panthor_sched.h
@@ -15,31 +15,28 @@ struct drm_panthor_queue_create;
 struct drm_panthor_group_get_state;
 struct drm_panthor_queue_submit;
 struct panthor_device;
-struct panthor_file;
 struct panthor_group_pool;
 struct panthor_job;
 
-int panthor_group_create(struct panthor_file *pfile,
+int panthor_group_create(struct drm_file *file,
 			 const struct drm_panthor_group_create *group_args,
-			 const struct drm_panthor_queue_create *queue_args,
-			 u64 drm_client_id);
-int panthor_group_destroy(struct panthor_file *pfile, u32 group_handle);
-int panthor_group_get_state(struct panthor_file *pfile,
+			 const struct drm_panthor_queue_create *queue_args);
+int panthor_group_destroy(struct drm_file *file, u32 group_handle);
+int panthor_group_get_state(struct drm_file *file,
 			    struct drm_panthor_group_get_state *get_state);
 
 struct drm_sched_job *
-panthor_job_create(struct panthor_file *pfile,
+panthor_job_create(struct drm_file *file,
 		   u16 group_handle,
-		   const struct drm_panthor_queue_submit *qsubmit,
-		   u64 drm_client_id);
+		   const struct drm_panthor_queue_submit *qsubmit);
 struct drm_sched_job *panthor_job_get(struct drm_sched_job *job);
 struct panthor_vm *panthor_job_vm(struct drm_sched_job *sched_job);
 void panthor_job_put(struct drm_sched_job *job);
 void panthor_job_update_resvs(struct drm_exec *exec, struct drm_sched_job *job);
 
-int panthor_group_pool_create(struct panthor_file *pfile);
-void panthor_group_pool_destroy(struct panthor_file *pfile);
-void panthor_fdinfo_gather_group_mem_info(struct panthor_file *pfile,
+int panthor_group_pool_create(struct drm_file *file);
+void panthor_group_pool_destroy(struct drm_file *file);
+void panthor_fdinfo_gather_group_mem_info(struct drm_file *pfile,
 					  struct drm_memory_stats *stats);
 
 int panthor_sched_init(struct panthor_device *ptdev);
@@ -53,6 +50,6 @@ void panthor_sched_report_mmu_fault(struct panthor_device *ptdev);
 void panthor_sched_prepare_for_vm_destruction(struct panthor_device *ptdev);
 void panthor_sched_report_fw_events(struct panthor_device *ptdev, u32 events);
 
-void panthor_fdinfo_gather_group_samples(struct panthor_file *pfile);
+void panthor_fdinfo_gather_group_samples(struct drm_file *file);
 
 #endif
-- 
2.43.0

