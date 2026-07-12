Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B4C4C43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 15:15:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC2D410E49A;
	Sun, 12 Jul 2026 15:15:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="qkOE/XBZ";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C324910E49A
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 15:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=X8SLw0uevDEnJfkzdaZZBZbeOHTFLg6jWg3oPcn/H7k=; b=qkOE/XBZGwUNiN7WVmpIllsWo0
 AyarwwoGH3XtbS2aTg2CnpaGfHuH1ZW6l1RerB+1fDojyXcpsBaLH4vv44Xq/z9/wJmMFlq9iQTKn
 ym0dvNt/+XjOOOejdFtZpvBxYcfuAThiHrvIX/KwLBD9l82+E83q5C75eV9kAxRLKceYUSHe0DMOO
 2RKXILQ2olOm40CRDquCLfc2ELSC5aykVzo1MC2KjvOHPlwmBi+vzixEhEZHdpQP2tkm4mnYdVHMB
 O37X4iaeXe6Gx5BdBetXwE9MgXDO7UZ5d4dJ8D8iqnB8FN3DrTLZmec/SzD7gi73cvQeEnZSXqAxV
 qXUal7Eg==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wivte-00DnB6-3t; Sun, 12 Jul 2026 17:15:10 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sun, 12 Jul 2026 12:14:39 -0300
Subject: [PATCH v3 6/8] drm/vc4: Add per-file descriptor seqno tracking
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260712-vc4-drm-scheduler-v3-6-ed6dc4defa53@igalia.com>
References: <20260712-vc4-drm-scheduler-v3-0-ed6dc4defa53@igalia.com>
In-Reply-To: <20260712-vc4-drm-scheduler-v3-0-ed6dc4defa53@igalia.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Melissa Wen <mwen@igalia.com>, Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6922; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=SEhzdqZZ2EMrhiu4sEmXXIE7k5guI/3bvrjUZV3lmJ8=;
 b=owGbwMvMwMVo/5mvq6zj1yrG02pJDFnB6xPesPdY8OjpqXGvEAtMv7lo7wyWyqvXlG8XTzT4r
 P6nfdHTTkZjFgZGLgZZMUWWH09iaxnFytk1l5VfhBnEygQyhYGLUwAm8jyFg6Fd04KbjTN1JVPc
 3+hbZxntJjwOf34z5F3syQ81igFRteuXtJb0yx23lVff8Cc//lldIYdV547wrcJScY4PL3pJT8t
 zT9+yR/Bepbn4q7mWale2hKUWTNPyncDe9Pq2YcaNVcfuzWObtf5O74vwjr0B60rOmzg/vmZnwL
 FdPisl2KzKzT2p/pZH7pQQify0fbwaH/cFKEnd6p/M9Vgx6sX+Ka9tPQK6eBuVfWRPfrqb9SJrR
 6HP1Kqa+trYG9/uPf2kv4PX5qT0jZvqX2udwreJ38lym3Vpr8y96WwC+TMWqR2foKZ219jIWMkw
 N9ssXD+iO+3S3uI/sw/UOFr0Zj77d8g54fCaCi7eMMYjAA==
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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

Implement per-file descriptor seqno tracking using an xarray, allowing
userspace to wait on specific job completions via vc4_wait_seqno_ioctl.

While this interface should ideally be deprecated in favor of syncobjs,
it has long been exposed to userspace and therefore must continue to be
supported.

Lay the groundwork to replace the existing `finished_seqno` logic with
DMA fence-based tracking. Each allocated seqno is associated with the
job's done_fence in a per-fd xarray. This allows vc4_wait_seqno_ioctl()
to simply look up the corresponding fence and wait on it.

This changes seqno semantics from global to per-file descriptor.
However, this doesn't affect userspace because a client can only wait
on seqnos returned from its own submissions.

Having per-fd seqnos is an intentional choice, as job ordering with the
DRM scheduler can only be guaranteed within an entity, which is per-fd.
Jobs from different file descriptors can complete out of order, so a
global seqno would break user-space expectations. Therefore, using
per-fd seqnos guarantees that the seqno monotonicity contract holds.

This design is inspired by the user fence handling in the Etnaviv and
msm drivers.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_drv.c    |  2 ++
 drivers/gpu/drm/vc4/vc4_drv.h    | 11 ++++++
 drivers/gpu/drm/vc4/vc4_submit.c | 77 ++++++++++++++++++++++++++++++++++++++--
 3 files changed, 88 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
index 6c49304301c9..3b0551da4dd0 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.c
+++ b/drivers/gpu/drm/vc4/vc4_drv.c
@@ -168,6 +168,7 @@ static int vc4_open(struct drm_device *dev, struct drm_file *file)
 	}
 
 	kref_init(&vc4file->refcount);
+	xa_init_flags(&vc4file->seqno_xa, XA_FLAGS_ALLOC1);
 	vc4_perfmon_open_file(vc4file);
 	file->driver_priv = vc4file;
 
@@ -185,6 +186,7 @@ void vc4_file_release(struct kref *ref)
 {
 	struct vc4_file *vc4file = container_of(ref, struct vc4_file, refcount);
 
+	xa_destroy(&vc4file->seqno_xa);
 	vc4_perfmon_close_file(vc4file);
 	kfree(vc4file);
 }
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 4f452ea3b4a6..fc37410aef9e 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -10,6 +10,7 @@
 #include <linux/of.h>
 #include <linux/refcount.h>
 #include <linux/uaccess.h>
+#include <linux/xarray.h>
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_debugfs.h>
@@ -777,6 +778,10 @@ struct vc4_render_job {
 	 * Must remain allocated until the render job completes.
 	 */
 	uint32_t bin_slots;
+
+	/* For userspace fence tracking. */
+	struct vc4_file *file;
+	u32 seqno;
 };
 
 struct vc4_exec_info {
@@ -911,6 +916,12 @@ struct vc4_file {
 
 	struct drm_sched_entity sched_entity[VC4_MAX_QUEUES];
 
+	/* Mapping of seqno to dma_fence for job completion tracking.
+	 * Allows userspace to wait on specific submissions.
+	 */
+	struct xarray seqno_xa;
+	u32 next_seqno;
+
 	bool bin_bo_used;
 };
 
diff --git a/drivers/gpu/drm/vc4/vc4_submit.c b/drivers/gpu/drm/vc4/vc4_submit.c
index 5e839db2ba4d..0e43f31fb813 100644
--- a/drivers/gpu/drm/vc4/vc4_submit.c
+++ b/drivers/gpu/drm/vc4/vc4_submit.c
@@ -232,6 +232,57 @@ vc4_get_bcl(struct drm_device *dev, struct vc4_exec_info *exec)
 	return ret;
 }
 
+int
+vc4_wait_seqno_ioctl(struct drm_device *dev, void *data,
+		     struct drm_file *file_priv)
+{
+	struct vc4_file *vc4_priv = file_priv->driver_priv;
+	struct vc4_dev *vc4 = to_vc4_dev(dev);
+	struct drm_vc4_wait_seqno *args = data;
+	unsigned long timeout_jiffies = nsecs_to_jiffies(args->timeout_ns);
+	unsigned long start = jiffies;
+	struct dma_fence *fence;
+	long ret;
+
+	if (WARN_ON_ONCE(vc4->gen > VC4_GEN_4))
+		return -ENODEV;
+
+	/*
+	 * While RCU guarantees the xarray entry won't be freed during the
+	 * lookup, it does not prevent the fence's refcount from being
+	 * concurrently dropped to zero from the IRQ context.
+	 *
+	 * dma_fence_get_rcu() pretends we didn't find a fence in that case.
+	 */
+	rcu_read_lock();
+	fence = xa_load(&vc4_priv->seqno_xa, args->seqno);
+	if (fence)
+		fence = dma_fence_get_rcu(fence);
+	rcu_read_unlock();
+
+	if (!fence)
+		return 0;
+
+	trace_vc4_wait_for_seqno_begin(dev, args->seqno, args->timeout_ns);
+	ret = dma_fence_wait_timeout(fence, true, timeout_jiffies);
+	trace_vc4_wait_for_seqno_end(dev, args->seqno);
+
+	dma_fence_put(fence);
+
+	if (ret == -ERESTARTSYS) {
+		u64 delta = jiffies_to_nsecs(jiffies - start);
+
+		if (args->timeout_ns >= delta)
+			args->timeout_ns -= delta;
+		else
+			args->timeout_ns = 0;
+
+		return ret;
+	}
+
+	return ret > 0 ? 0 : -ETIME;
+}
+
 static void
 vc4_job_free(struct kref *ref)
 {
@@ -290,6 +341,10 @@ vc4_render_job_free(struct kref *ref)
 	vc4->bin_alloc_used &= ~job->bin_slots;
 	spin_unlock_irqrestore(&vc4->job_lock, irqflags);
 
+	if (job->seqno)
+		xa_erase(&job->file->seqno_xa, job->seqno);
+
+	vc4_file_put(job->file);
 	vc4_job_free(ref);
 }
 
@@ -365,7 +420,7 @@ vc4_job_alloc(struct vc4_dev *vc4, struct drm_file *file_priv, u32 in_sync,
 }
 
 static int
-vc4_push_jobs(struct vc4_exec_info *exec)
+vc4_push_jobs(struct vc4_file *vc4_priv, struct vc4_exec_info *exec)
 {
 	struct vc4_render_job *render = exec->render;
 	struct vc4_job *jobs[VC4_MAX_QUEUES];
@@ -391,6 +446,14 @@ vc4_push_jobs(struct vc4_exec_info *exec)
 			goto err;
 	}
 
+	/*
+	 * The slot was already reserved by xa_alloc_cyclic() (which allocates
+	 * the node), so storing the fence into the same index reuses that slot
+	 * and cannot fail.
+	 */
+	xa_store(&vc4_priv->seqno_xa, render->seqno, render->base.done_fence,
+		 GFP_KERNEL);
+
 	for (int i = 0; i < num_jobs; i++)
 		drm_sched_entity_push_job(&jobs[i]->base);
 
@@ -498,6 +561,7 @@ vc4_submit_cl_ioctl(struct drm_device *dev, void *data,
 	}
 
 	exec.render = render;
+	render->file = vc4_file_get(vc4_priv);
 	INIT_LIST_HEAD(&render->unref_list);
 
 	ret = vc4_lookup_bos(dev, file_priv, render, args->bo_handles,
@@ -547,11 +611,20 @@ vc4_submit_cl_ioctl(struct drm_device *dev, void *data,
 		goto fail_exec;
 
 	scoped_guard(mutex, &vc4->sched_lock) {
-		ret = vc4_push_jobs(&exec);
+		ret = xa_alloc_cyclic(&vc4_priv->seqno_xa, &render->seqno,
+				      NULL, xa_limit_32b, &vc4_priv->next_seqno,
+				      GFP_KERNEL);
+		if (ret < 0)
+			goto fail_exec;
+
+		ret = vc4_push_jobs(vc4_priv, &exec);
 	}
 
 	if (!ret) {
 		vc4_attach_fences(render, sync_out, render->base.done_fence);
+
+		/* Return the seqno for our job. */
+		args->seqno = render->seqno;
 	} else if (sync_out) {
 		/* The jobs were never submitted, so release the unpublished syncobj */
 		drm_syncobj_put(sync_out);

-- 
2.54.0

