Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533AD606A327
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=retsim.com header.i=@retsim.com header.a=rsa-sha256 header.s=abaygg6onarqet2uti4t4yyiczbpngnf header.b=VrmnahLx;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=hsbnp7p3ensaochzwyq5wwmceodymuwv header.b=CPcp3ISw;
	dkim=temperror header.d=retsim.com header.i=@retsim.com header.a=rsa-sha256 header.s=dkim header.b=T3znDYeI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CF5011212C;
	Thu, 26 Nov 2026 08:11:06 +0000 (UTC)
X-Greylist: delayed 308 seconds by postgrey-1.36 at gabe;
 Wed, 25 Nov 2026 08:31:54 UTC
Received: from a27-123.smtp-out.us-west-2.amazonses.com
 (a27-123.smtp-out.us-west-2.amazonses.com [54.240.27.123])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 243BE10E223
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 08:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=abaygg6onarqet2uti4t4yyiczbpngnf; d=retsim.com; t=1795595206;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=FnF8LYPoCkzEXbgxM2cjh9/eIUU/GSstSIv9Shki8BA=;
 b=VrmnahLx4oBRED7rZ3GMs887saE1qMP1FUl/f2GJOFwSvssCq4nRY8haTaRnEZci
 aqAGYd/4V5CIt6R7of2HBffSYukLkTCm1p49D8SxXiKMY4RkEHmw33CsPl+KoSYuLBg
 41XAUhIp6rX60YM9Uicl6PgKUE1JGwwbK+fiqp18=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1795595206;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
 bh=FnF8LYPoCkzEXbgxM2cjh9/eIUU/GSstSIv9Shki8BA=;
 b=CPcp3ISwbi/+jKEJNTN71SSAhHExPeM6UwwGSy+jzftS6EwJNL/QtVk4KmVeopbL
 n77eg9GiPNsLXUdRoCrT/0uTrGl1pAAWVVR98EJgcdUSRx3pgbLpGVSbxG4gDimoAN3
 vUs/QbxFsC6JrKs6Z+t1vo0QoeCmubF//UHJZGK0=
Authentication-Results: mailserver.retsim.com (amavis); dkim=pass
 reason="pass (just generated, assumed good)" header.d=retsim.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=retsim.com; h=
 content-transfer-encoding:mime-version:references:in-reply-to
 :x-mailer:message-id:date:subject:to:from; s=dkim; t=1795595198;
 x=1798187199; bh=FnF8LYPoCkzEXbgxM2cjh9/eIUU/GSstSIv9Shki8BA=; b=
 T3znDYeIkCES/Pf3ZK69GSWTGLPYmQ9AjYSsFIS0sNh0mH439BnDFeiiVi8FfYfZ
 R9gYvQEB2bgTKxjMrZylrfTaohFrjjcbjDtjgjwP/Gs1Ona9dC20bxex7vCkmMrD
 0U8cyP7JeTdTwfOw0B/qp6z3H7IoggK9AuqJUhhzcjtZjJaXvQr43LHpHS3IetgL
 lto0/3vQqRbHnh9PoqdWuG1tafQThYaezUYbPPoagbpIiPzRXrFYBwPIu9McYLB4
 VVnB9g0UHI0d1UmChMWjV5SEE4NOk2vSKGipLCKRG4Inb5ISooDy/Q08CK7MxP1J
 3UCbTH6Djw08iAwhhHYyag==
X-Virus-Scanned: Debian amavis at 
From: Lewis Lakerink <lewis@retsim.com>
To: imagination@lists.freedesktop.org
Cc: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Ryan Brue <ryanbrue.dev@gmail.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Lewis Lakerink <lewis@retsim.com>
Subject: [PATCH 2/2] drm/imagination: quiesce queues before device teardown
Date: Wed, 25 Nov 2026 08:26:46 +0000
Message-ID: <010101a211d07fcc-55f41080-fd57-47e4-8a51-a92b1adf86de-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125082637.2839673-1-lewis@retsim.com>
References: <20261125082637.2839673-1-lewis@retsim.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Feedback-ID: ::1.us-west-2.jZ+gdeR9TqNTaB6Dq50UPG8S0IjuYZETsFsi7SlhF6Q=:AmazonSES
X-SES-Outgoing: 2026.11.25-54.240.27.123
X-Mailman-Approved-At: Thu, 26 Nov 2026 08:08:59 +0000
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
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_PDS_OTHER_BAD_TLD,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

pvr_remove() calls pvr_device_fini() before drm_dev_unplug() and does
not stop active or idle queues first:

  * pvr_drm_driver_postclose() has no drm_dev_enter() guard, so closing
    a file after removal runs pvr_fw_object_destroy() ->
    pvr_meta_vm_unmap() against kernel_vm_ctx after pvr_device_gpu_fini()
    has freed it;
  * drm_sched_entity_destroy() does not wait for jobs on
    sched->pending_list or cancel work_free_job and work_tdr, leaving
    scheduler work and the timeout timer armed across destroy_workqueue()
    and FW/VM teardown;
  * an IRQ-driven reset via pvr_fwccb_process() can re-arm watchdog.work
    before free_irq() runs in pvr_device_fini().

Reorder pvr_remove() so drm_dev_unplug() comes first and the queues are
stopped before device state is torn down:

  * Stop the watchdog via pvr_watchdog_fini() first so it cannot race
    pvr_dev->lost, then call drm_dev_unplug() when
    !READ_ONCE(pvr_dev->lost) (pvr_device_lost() may already have
    unplugged it, and drm_dev_unplug() is not idempotent) so in-flight
    drm_dev_enter() sections finish and no new ones can start.
  * Add pvr_queue_device_quiesce() to detach every queue from
    queues.{active,idle} under queues.lock while pinning its context via
    pvr_context_get_if_referenced().  Call drm_sched_entity_fini()
    directly (avoiding drm_sched_entity_flush()'s wait_event_killable()
    hang on non-exiting unbind tasks), then drm_sched_fini() to cancel
    work_run_job, work_free_job and work_tdr.  After drm_sched_fini(),
    walk sched->pending_list and call pvr_job_release_pm_ref() on each
    remaining job: those jobs still hold a pvr_job_get_pm_ref()
    reference, and nothing else releases it once the scheduler is gone,
    so without this the device's PM usage count never returns to zero
    and every later runtime suspend is refused.  Skip drm_sched_fini()
    in pvr_queue_destroy() when sched_rq is already NULL.
  * Guard postclose, pvr_ioctl_destroy_context() and
    pvr_queue_timedout_job() with drm_dev_enter(), returning
    DRM_GPU_SCHED_STAT_ENODEV on timeout after unplug.
  * Run flush_workqueue(pvr_dev->sched_wq) while the GPU, job_ids, FW
    objects and kernel_vm_ctx are still live, xa_destroy() the job and
    free-list id arrays before pvr_device_fini(), and re-run
    pvr_watchdog_fini() after free_irq() in case an IRQ-driven reset
    re-armed it.

Runtime PM is deliberately unchanged: pm_runtime_suspend() still runs
after drm_dev_unplug(), so pvr_power_device_suspend() returns -EIO from
its drm_dev_enter() guard and latches runtime_error.  That latch is what
keeps rpm_idle() from invoking pvr_power_device_idle() during devres
teardown, after pvr_device_fini() has unmapped the fwif_sysdata memory
that callback reads; making the suspend succeed removes the latch and
oopses there.  The GPU is therefore left powered when it was runtime
active at removal, a known limitation rather than a use-after-free.

When postclose runs after unplug, detach pvr_file->contexts under
ctx_list_lock, xa_destroy() the four handle xarrays and kfree(pvr_file)
as required by drm_file_free(), deliberately leaking the underlying
device objects; the existing WARN_ON() checks in pvr_remove(),
pvr_fw_fini(), drm_mm_takedown() and pvr_context_device_fini() report
those leaks.

Fixes: 1f88f017e649 ("drm/imagination: Get GPU resources")
Cc: stable@vger.kernel.org # 6.8+
Assisted-by: LLM
Signed-off-by: Lewis Lakerink <lewis@retsim.com>
---
 drivers/gpu/drm/imagination/pvr_drv.c   | 73 +++++++++++++++++++++++--
 drivers/gpu/drm/imagination/pvr_queue.c | 66 +++++++++++++++++++++-
 drivers/gpu/drm/imagination/pvr_queue.h |  2 +
 3 files changed, 135 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_drv.c b/drivers/gpu/drm/imag=
ination/pvr_drv.c
index 2d522a8..65c0747 100644
--- a/drivers/gpu/drm/imagination/pvr_drv.c
+++ b/drivers/gpu/drm/imagination/pvr_drv.c
@@ -724,10 +724,18 @@ pvr_ioctl_destroy_context(struct drm_device *drm_de=
v, void *raw_args,
 	struct drm_pvr_ioctl_destroy_context_args *args =3D raw_args;
 	struct pvr_file *pvr_file =3D file->driver_priv;
=20
+	int idx, err;
+
 	if (args->_padding_4)
 		return -EINVAL;
=20
-	return pvr_context_destroy(pvr_file, args->handle);
+	if (!drm_dev_enter(drm_dev, &idx))
+		return -EIO;
+
+	err =3D pvr_context_destroy(pvr_file, args->handle);
+	drm_dev_exit(idx);
+
+	return err;
 }
=20
 /**
@@ -1356,7 +1364,7 @@ pvr_drm_driver_open(struct drm_device *drm_dev, str=
uct drm_file *file)
 /**
  * pvr_drm_driver_postclose() - One of the driver callbacks when a &stru=
ct
  * drm_file is closed.
- * @drm_dev: [IN] DRM device (unused).
+ * @drm_dev: [IN] DRM device.
  * @file: [IN] DRM file private data.
  *
  * Frees powervr-specific file private data (&struct pvr_file).
@@ -1364,10 +1372,35 @@ pvr_drm_driver_open(struct drm_device *drm_dev, s=
truct drm_file *file)
  * Registered in &pvr_drm_driver.
  */
 static void
-pvr_drm_driver_postclose(__always_unused struct drm_device *drm_dev,
+pvr_drm_driver_postclose(struct drm_device *drm_dev,
 			 struct drm_file *file)
 {
 	struct pvr_file *pvr_file =3D to_pvr_file(file);
+	int idx;
+
+	/*
+	 * If the device is already unplugged, pvr_remove() may have torn down
+	 * sched_wq, kernel_vm_ctx and FW objects. Release only the per-file
+	 * container bookkeeping (detaching file_link so leaked contexts cannot
+	 * point into freed pvr_file) and deliberately leak the device objects.
+	 */
+	if (!drm_dev_enter(drm_dev, &idx)) {
+		struct pvr_device *pvr_dev =3D to_pvr_device(drm_dev);
+		struct pvr_context *ctx, *tmp;
+
+		spin_lock(&pvr_dev->ctx_list_lock);
+		list_for_each_entry_safe(ctx, tmp, &pvr_file->contexts, file_link)
+			list_del_init(&ctx->file_link);
+		spin_unlock(&pvr_dev->ctx_list_lock);
+
+		xa_destroy(&pvr_file->ctx_handles);
+		xa_destroy(&pvr_file->free_list_handles);
+		xa_destroy(&pvr_file->hwrt_handles);
+		xa_destroy(&pvr_file->vm_ctx_handles);
+		kfree(pvr_file);
+		file->driver_priv =3D NULL;
+		return;
+	}
=20
 	/* Kill remaining contexts. */
 	pvr_destroy_contexts_for_file(pvr_file);
@@ -1379,6 +1412,8 @@ pvr_drm_driver_postclose(__always_unused struct drm=
_device *drm_dev,
=20
 	kfree(pvr_file);
 	file->driver_priv =3D NULL;
+
+	drm_dev_exit(idx);
 }
=20
 DEFINE_DRM_GEM_FOPS(pvr_drm_driver_fops);
@@ -1474,15 +1509,45 @@ static void pvr_remove(struct platform_device *pl=
at_dev)
 	struct drm_device *drm_dev =3D platform_get_drvdata(plat_dev);
 	struct pvr_device *pvr_dev =3D to_pvr_device(drm_dev);
=20
+	/* Stop the watchdog first so it cannot race the pvr_dev->lost check. *=
/
+	pvr_watchdog_fini(pvr_dev);
+
+	/*
+	 * Unplug first so in-flight ioctls, postclose, timeouts and fence
+	 * releases finish and no new ones (or runtime resumes) can start.
+	 * pvr_device_lost() may already have unplugged it, and drm_dev_unplug(=
)
+	 * is not idempotent.
+	 */
+	if (!READ_ONCE(pvr_dev->lost))
+		drm_dev_unplug(drm_dev);
+
+	/* Stop all queues and their drm_sched workers/timers before teardown. =
*/
+	pvr_queue_device_quiesce(pvr_dev);
+
+	/*
+	 * Drain pre-unplug pvr_queue_fence_release_work items while the GPU,
+	 * kernel_vm_ctx, FW objects and job_ids are still alive.
+	 */
+	flush_workqueue(pvr_dev->sched_wq);
+
 	WARN_ON(!xa_empty(&pvr_dev->job_ids));
 	WARN_ON(!xa_empty(&pvr_dev->free_list_ids));
=20
 	xa_destroy(&pvr_dev->job_ids);
 	xa_destroy(&pvr_dev->free_list_ids);
=20
+	/*
+	 * Leave runtime PM to the driver core.  This call happens after
+	 * drm_dev_unplug(), so pvr_power_device_suspend() returns -EIO from
+	 * its drm_dev_enter() guard and latches runtime_error.  That latch is
+	 * load-bearing: it makes rpm_idle() bail out before invoking
+	 * pvr_power_device_idle(), which reads pvr_dev->fw_dev.fwif_sysdata
+	 * memory that pvr_device_fini() has already unmapped below.
+	 */
 	pm_runtime_suspend(drm_dev->dev);
+
 	pvr_device_fini(pvr_dev);
-	drm_dev_unplug(drm_dev);
+	/* Cancel again in case an IRQ-driven reset re-armed watchdog before fr=
ee_irq(). */
 	pvr_watchdog_fini(pvr_dev);
 	pvr_queue_device_fini(pvr_dev);
 	pvr_context_device_fini(pvr_dev);
diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/im=
agination/pvr_queue.c
index 2a6bfb0..c8d8a22 100644
--- a/drivers/gpu/drm/imagination/pvr_queue.c
+++ b/drivers/gpu/drm/imagination/pvr_queue.c
@@ -881,9 +881,15 @@ pvr_queue_timedout_job(struct drm_sched_job *s_job)
 	struct pvr_device *pvr_dev =3D queue->ctx->pvr_dev;
 	struct pvr_job *job;
 	u32 job_count =3D 0;
+	int idx;
+
+	if (!drm_dev_enter(from_pvr_device(pvr_dev), &idx))
+		return DRM_GPU_SCHED_STAT_ENODEV;
=20
-	if (dma_fence_is_signaled(s_job->s_fence->parent))
+	if (dma_fence_is_signaled(s_job->s_fence->parent)) {
+		drm_dev_exit(idx);
 		return DRM_GPU_SCHED_STAT_NO_HANG;
+	}
=20
 	dev_err(sched->dev, "Job timeout\n");
=20
@@ -924,6 +930,7 @@ pvr_queue_timedout_job(struct drm_sched_job *s_job)
 	mutex_unlock(&pvr_dev->queues.lock);
=20
 	drm_sched_start(sched, 0);
+	drm_dev_exit(idx);
=20
 	return DRM_GPU_SCHED_STAT_RESET;
 }
@@ -1469,7 +1476,8 @@ void pvr_queue_destroy(struct pvr_queue *queue, boo=
l cleanup_queue_entity)
 	list_del_init(&queue->node);
 	mutex_unlock(&queue->ctx->pvr_dev->queues.lock);
=20
-	drm_sched_fini(&queue->scheduler);
+	if (queue->scheduler.sched_rq)
+		drm_sched_fini(&queue->scheduler);
 	if (cleanup_queue_entity)
 		drm_sched_entity_fini(&queue->entity);
=20
@@ -1512,6 +1520,60 @@ int pvr_queue_device_init(struct pvr_device *pvr_d=
ev)
 	return 0;
 }
=20
+/**
+ * pvr_queue_device_quiesce() - Stop all remaining queues during device =
removal.
+ * @pvr_dev: The device to quiesce.
+ *
+ * Detaches every registered queue from @pvr_dev->queues.{active,idle} s=
o the
+ * IRQ handler cannot signal fences or re-queue free_job work, tears dow=
n its
+ * scheduler entity without blocking in drm_sched_entity_flush(), finali=
ses its
+ * scheduler so work_run_job, work_free_job and work_tdr are stopped, an=
d
+ * releases runtime PM references held by remaining in-flight jobs befor=
e
+ * device teardown. Pins each queue's context while operating on it to a=
void
+ * racing with concurrent pvr_queue_destroy().
+ */
+void pvr_queue_device_quiesce(struct pvr_device *pvr_dev)
+{
+	struct pvr_queue *queue;
+
+	for (;;) {
+		struct pvr_context *ctx =3D NULL;
+
+		mutex_lock(&pvr_dev->queues.lock);
+		queue =3D list_first_entry_or_null(&pvr_dev->queues.active,
+						 struct pvr_queue, node);
+		if (!queue)
+			queue =3D list_first_entry_or_null(&pvr_dev->queues.idle,
+							 struct pvr_queue, node);
+		if (queue) {
+			list_del_init(&queue->node);
+			if (pvr_context_get_if_referenced(queue->ctx))
+				ctx =3D queue->ctx;
+		}
+		mutex_unlock(&pvr_dev->queues.lock);
+
+		if (!queue)
+			break;
+		if (!ctx)
+			continue;
+
+		if (!queue->entity.stopped) {
+			drm_sched_entity_fini(&queue->entity);
+			dma_fence_put(queue->last_queued_job_scheduled_fence);
+			queue->last_queued_job_scheduled_fence =3D NULL;
+		}
+		if (queue->scheduler.sched_rq) {
+			struct pvr_job *job;
+
+			drm_sched_fini(&queue->scheduler);
+			list_for_each_entry(job, &queue->scheduler.pending_list, base.list)
+				pvr_job_release_pm_ref(job);
+		}
+
+		pvr_context_put(ctx);
+	}
+}
+
 /**
  * pvr_queue_device_fini() - Device-level cleanup of queue related field=
s.
  * @pvr_dev: The device to cleanup.
diff --git a/drivers/gpu/drm/imagination/pvr_queue.h b/drivers/gpu/drm/im=
agination/pvr_queue.h
index 149cc6d..fab168e 100644
--- a/drivers/gpu/drm/imagination/pvr_queue.h
+++ b/drivers/gpu/drm/imagination/pvr_queue.h
@@ -168,6 +168,8 @@ void pvr_queue_device_post_reset(struct pvr_device *p=
vr_dev);
=20
 int pvr_queue_device_init(struct pvr_device *pvr_dev);
=20
+void pvr_queue_device_quiesce(struct pvr_device *pvr_dev);
+
 void pvr_queue_device_fini(struct pvr_device *pvr_dev);
=20
 #endif /* PVR_QUEUE_H */
--=20
2.43.0

