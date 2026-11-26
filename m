Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFA0606A321
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G5OoBP7R
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3643E1121BD;
	Thu, 26 Nov 2026 08:46:32 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D35D1121BD
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 08:46:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1E8C162279;
 Thu, 26 Nov 2026 08:46:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE4A1F000D1;
 Thu, 26 Nov 2026 08:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795682784;
 bh=wXAXC6WYFAb54fMBO73bRUpkHr9gTFC6ZbqH5nYMx/s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=G5OoBP7R5+hDkQEhu/pjJcwVVpN7mbKrYVsHvIx7YvLIKy84xPkVs38tR1K3Arn5Q
 7G6FYq1YXXRSGa1bBNMKfB67bQ74KkpA9Iwy/WjVL9veP+OkuJKlFXRPFr4blwOedb
 kJNHrc5g7r5Nj4Jx4InbLyUBZdXbattTl3zx1kgEAV6CwyZUiriiIGHimeSkd1jAkf
 6jobbtttoBQiF7jNQy4pn88aOD2bCAaN/OjwlmaJsQEbUfsFjlHXVY0e/G3qdFAp6B
 azkiy0yXxA6x22v3ob5c2BJoOyFieX+GxOhaubQSfHxS8ghcgbP7vNjnHwwXFxyNM9
 rzMbpBrvPYELQ==
Message-ID: <sashiko-outbox-235052@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/imagination: quiesce queues before device teardown
To: "Lewis Lakerink" <lewis@retsim.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <010101a211d07fcc-55f41080-fd57-47e4-8a51-a92b1adf86de-000000@us-west-2.amazonses.com>
References: <20261125082637.2839673-1-lewis@retsim.com>
 <010101a211d07fcc-55f41080-fd57-47e4-8a51-a92b1adf86de-000000@us-west-2.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 08:46:23 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential
issues to consider:
- [High] drm/imagination: race with IRQ reset and pvr_device_lost() in
  pvr_remove()
- [High] drm/imagination: deadlock in pvr_remove() and reset via
  drm_dev_enter()
- [High] drm/imagination: active FW DMA and clock leak in pvr_remove()
  after unplug
- [High] drm/imagination: async entity job teardown race in
  pvr_queue_device_quiesce()
- [Medium] drm/imagination: runtime PM ref leak in
  pvr_queue_timedout_job() on unplug
- [Medium] drm/imagination: paired fragment job PM ref leak in
  pvr_queue_device_quiesce()
- [Medium] drm/imagination: pvr_power_device_idle() UAF race with
  pvr_device_fini()
It also noticed 2 related pre-existing issues this patch does not
introduce:
- [High] drm/imagination: race between pvr_queue_timedout_job() and hard
  reset [1]
- [High] drm/imagination: scheduler timeout on PM ref failure in
  pvr_queue_run_job() [2]
--

commit 183994369960829d968efc4d07cee9c3ce99db2a
Author: Lewis Lakerink <lewis@retsim.com>

drm/imagination: quiesce queues before device teardown

This commit reorders pvr_remove() to unplug the DRM device and quiesce
active and idle scheduler queues before tearing down device state, and adds
drm_dev_enter() guards to context destruction, postclose, and job timeouts.

> diff --git a/drivers/gpu/drm/imagination/pvr_drv.c b/drivers/gpu/drm/imag=
ination/pvr_drv.c
> index 2d522a8e46ad6..65c0747cf4d19 100644
> --- a/drivers/gpu/drm/imagination/pvr_drv.c
> +++ b/drivers/gpu/drm/imagination/pvr_drv.c
> @@ -724,10 +724,18 @@ pvr_ioctl_destroy_context(struct drm_device *drm_de=
v, void *raw_args,
>  	struct drm_pvr_ioctl_destroy_context_args *args =3D raw_args;
>  	struct pvr_file *pvr_file =3D file->driver_priv;
> =20
> +	int idx, err;
> +
>  	if (args->_padding_4)
>  		return -EINVAL;
> =20
> -	return pvr_context_destroy(pvr_file, args->handle);
> +	if (!drm_dev_enter(drm_dev, &idx))
> +		return -EIO;
> +
> +	err =3D pvr_context_destroy(pvr_file, args->handle);
> +	drm_dev_exit(idx);
> +
> +	return err;
>  }
> =20
>  /**
> @@ -1356,7 +1364,7 @@ pvr_drm_driver_open(struct drm_device *drm_dev, str=
uct drm_file *file)
>  /**
>   * pvr_drm_driver_postclose() - One of the driver callbacks when a &stru=
ct
>   * drm_file is closed.
> - * @drm_dev: [IN] DRM device (unused).
> + * @drm_dev: [IN] DRM device.
>   * @file: [IN] DRM file private data.
>   *
>   * Frees powervr-specific file private data (&struct pvr_file).
> @@ -1364,10 +1372,35 @@ pvr_drm_driver_open(struct drm_device *drm_dev, s=
truct drm_file *file)
>   * Registered in &pvr_drm_driver.
>   */
>  static void
> -pvr_drm_driver_postclose(__always_unused struct drm_device *drm_dev,
> +pvr_drm_driver_postclose(struct drm_device *drm_dev,
>  			 struct drm_file *file)
>  {
>  	struct pvr_file *pvr_file =3D to_pvr_file(file);
> +	int idx;
> +
> +	/*
> +	 * If the device is already unplugged, pvr_remove() may have torn down
> +	 * sched_wq, kernel_vm_ctx and FW objects. Release only the per-file
> +	 * container bookkeeping (detaching file_link so leaked contexts cannot
> +	 * point into freed pvr_file) and deliberately leak the device objects.
> +	 */
> +	if (!drm_dev_enter(drm_dev, &idx)) {
> +		struct pvr_device *pvr_dev =3D to_pvr_device(drm_dev);
> +		struct pvr_context *ctx, *tmp;
> +
> +		spin_lock(&pvr_dev->ctx_list_lock);
> +		list_for_each_entry_safe(ctx, tmp, &pvr_file->contexts, file_link)
> +			list_del_init(&ctx->file_link);
> +		spin_unlock(&pvr_dev->ctx_list_lock);
> +
> +		xa_destroy(&pvr_file->ctx_handles);
> +		xa_destroy(&pvr_file->free_list_handles);
> +		xa_destroy(&pvr_file->hwrt_handles);
> +		xa_destroy(&pvr_file->vm_ctx_handles);
> +		kfree(pvr_file);
> +		file->driver_priv =3D NULL;
> +		return;
> +	}
> =20
>  	/* Kill remaining contexts. */
>  	pvr_destroy_contexts_for_file(pvr_file);
> @@ -1379,6 +1412,8 @@ pvr_drm_driver_postclose(__always_unused struct drm=
_device *drm_dev,
> =20
>  	kfree(pvr_file);
>  	file->driver_priv =3D NULL;
> +
> +	drm_dev_exit(idx);
>  }

[Severity: High]
Can holding drm_dev_enter() across pvr_context_destroy() and
pvr_drm_driver_postclose() deadlock with drm_dev_unplug() in pvr_remove()
and pvr_power_reset()?

In the first case, pvr_context_destroy() calls pvr_context_kill_queues() ->
pvr_queue_kill() -> drm_sched_entity_destroy() -> drm_sched_entity_flush().
For pvr_ioctl_destroy_context() or an explicit close() where PF_EXITING is
not set, drm_sched_entity_flush() waits in wait_event_killable() on
sched->job_scheduled for entity->job_queue to drain:

CPU0                                  CPU1
pvr_ioctl_destroy_context()
  drm_dev_enter()
  pvr_context_destroy()
    ...
      drm_sched_entity_flush()
                                      pvr_remove()
                                        drm_dev_unplug()
                                          dev->unplugged =3D true
                                          synchronize_srcu(&drm_unplug_srcu)
        wait_event_killable(
          sched->job_scheduled, ...)
          <-- waits for entity idle;
              pvr_remove() cannot reach
              pvr_queue_device_quiesce()

If a queued job is waiting on an unsignaled dependency or a wedged job
(whose timeout handler now returns DRM_GPU_SCHED_STAT_ENODEV once
dev->unplugged is set), drm_sched_entity_flush() never wakes up and
pvr_remove() blocks in synchronize_srcu() before reaching
pvr_queue_device_quiesce().

In the second case, wrapping these paths in drm_dev_enter() inverts the
lock order between drm_unplug_srcu and pvr_dev->reset_sem:

CPU0                                  CPU1
----                                  ----
down_write(&pvr_dev->reset_sem)
                                      drm_dev_enter() [drm_unplug_srcu]
                                      down_read(&pvr_dev->reset_sem)
drm_dev_unplug() [drm_unplug_srcu]

 *** DEADLOCK ***

CPU0: pvr_power_reset() -> pvr_device_lost() -> drm_dev_unplug()
CPU1: pvr_drm_driver_postclose() -> pvr_destroy_contexts_for_file() ->
      pvr_context_destroy() -> pvr_context_put() -> pvr_context_release() ->
      pvr_queue_destroy() -> pvr_queue_cleanup_fw_context() ->
      pvr_fw_structure_cleanup()

> @@ -1474,15 +1509,45 @@ static void pvr_remove(struct platform_device *pl=
at_dev)
>  	struct drm_device *drm_dev =3D platform_get_drvdata(plat_dev);
>  	struct pvr_device *pvr_dev =3D to_pvr_device(drm_dev);
> =20
> +	/* Stop the watchdog first so it cannot race the pvr_dev->lost check. */
> +	pvr_watchdog_fini(pvr_dev);
> +
> +	/*
> +	 * Unplug first so in-flight ioctls, postclose, timeouts and fence
> +	 * releases finish and no new ones (or runtime resumes) can start.
> +	 * pvr_device_lost() may already have unplugged it, and drm_dev_unplug()
> +	 * is not idempotent.
> +	 */
> +	if (!READ_ONCE(pvr_dev->lost))
> +		drm_dev_unplug(drm_dev);

[Severity: High]
Can pvr_remove() still race with an IRQ-driven pvr_power_reset() or an
in-flight pvr_device_lost() here?

The threaded IRQ handler pvr_device_irq_thread_handler() remains active
until pvr_device_fini() -> pvr_device_irq_fini() -> free_irq(), and
pvr_remove() neither takes pvr_dev->reset_sem nor sets pvr_dev->lost =3D tr=
ue:

CPU0                                  CPU1
pvr_remove()
  if (!READ_ONCE(pvr_dev->lost))
    drm_dev_unplug(drm_dev)
                                      pvr_device_irq_thread_handler()
                                        pvr_fwccb_process()
                                          pvr_power_reset(pvr_dev, false)
                                            pvr_power_get_clear()
                                            ...
                                            pvr_power_device_resume() -> -E=
IO
                                            pvr_device_lost(pvr_dev)
                                              if (!pvr_dev->lost)
                                                drm_dev_unplug()
                                                  <-- second drm_dev_unplug=
()

Conversely, pvr_device_lost() sets pvr_dev->lost =3D true before calling
drm_dev_unplug().  If pvr_device_lost() sets pvr_dev->lost just before
pvr_remove() checks !READ_ONCE(pvr_dev->lost), pvr_remove() skips
drm_dev_unplug() while pvr_device_lost() is still inside
synchronize_srcu(&drm_unplug_srcu), tearing down queues, sched_wq, and
kernel_vm_ctx while in-flight drm_dev_enter() sections are still running.

Leaving the IRQ handler active across the rest of pvr_remove() causes three
additional races before free_irq():
- An IRQ-driven pvr_power_reset() calls pvr_power_get_clear() ->
  pvr_power_clear_error(), which clears the runtime_error latch that keeps
  devres teardown from running pvr_power_device_idle() on unmapped
  fwif_sysdata.
- pvr_fwccb_process() can look up entries in pvr_dev->free_list_ids after
  xa_destroy(&pvr_dev->free_list_ids) runs.
- The second pvr_watchdog_fini() is placed after pvr_device_fini(), which
  calls pvr_device_gpu_fini() -> pvr_fw_fini() after free_irq(), so a
  watchdog work item re-armed by an IRQ reset before free_irq() can run
  pvr_watchdog_worker() concurrently with pvr_fw_fini().

> +
> +	/* Stop all queues and their drm_sched workers/timers before teardown. =
*/
> +	pvr_queue_device_quiesce(pvr_dev);
> +
> +	/*
> +	 * Drain pre-unplug pvr_queue_fence_release_work items while the GPU,
> +	 * kernel_vm_ctx, FW objects and job_ids are still alive.
> +	 */
> +	flush_workqueue(pvr_dev->sched_wq);
> +
>  	WARN_ON(!xa_empty(&pvr_dev->job_ids));
>  	WARN_ON(!xa_empty(&pvr_dev->free_list_ids));
> =20
>  	xa_destroy(&pvr_dev->job_ids);
>  	xa_destroy(&pvr_dev->free_list_ids);
> =20
> +	/*
> +	 * Leave runtime PM to the driver core.  This call happens after
> +	 * drm_dev_unplug(), so pvr_power_device_suspend() returns -EIO from
> +	 * its drm_dev_enter() guard and latches runtime_error.  That latch is
> +	 * load-bearing: it makes rpm_idle() bail out before invoking
> +	 * pvr_power_device_idle(), which reads pvr_dev->fw_dev.fwif_sysdata
> +	 * memory that pvr_device_fini() has already unmapped below.
> +	 */
>  	pm_runtime_suspend(drm_dev->dev);
> +
>  	pvr_device_fini(pvr_dev);

[Severity: High]
When the GPU is runtime-active during pvr_remove(), doesn't making
pm_runtime_suspend() fail with -EIO cause pvr_device_fini() ->
pvr_fw_fini() to free all firmware DMA buffers and MMU page tables while
the firmware processor is still running?

Because pvr_power_device_suspend() aborts at its drm_dev_enter() check
after drm_dev_unplug(), neither pvr_power_fw_disable() (pvr_fw_stop()) nor
pwr_ops->power_off() runs.  pvr_fw_fini() then unmaps and frees the
firmware code, data, CCB, and page-table GEM objects back to the page
allocator while the GPU remains powered, clocked, out of reset, and
performing DMA through those page tables, and leaks the clk_prepare_enable()
references on core_clk, sys_clk, and mem_clk.

Note that when pm_runtime_suspend() succeeds, dev->power.runtime_status is
set to RPM_SUSPENDED, and rpm_idle() immediately returns -EAGAIN when
runtime_status !=3D RPM_ACTIVE without invoking pvr_power_device_idle().

[Severity: Medium]
Can an asynchronous runtime PM idle check triggered by
pvr_queue_device_quiesce() still race with pvr_device_fini() here?

When the last pvr_job_release_pm_ref() in pvr_queue_device_quiesce() calls
pvr_power_put() -> pm_runtime_put(), dropping usage_count to zero queues
async RPM_REQ_IDLE work on pm_wq:

CPU0                                  kworker (pm_wq)
pvr_remove()
  pvr_queue_device_quiesce()
    pvr_job_release_pm_ref()
      pm_runtime_put()
                                      pm_runtime_work()
                                        rpm_idle()
                                          dev->power.idle_notification =3D =
true
                                          spin_unlock(&dev->power.lock)
                                          pvr_power_device_idle()
  pm_runtime_suspend() -> -EIO
  pvr_device_fini()
    ...
      pvr_fw_Destroy_structures()
        /* unmaps fwif_sysdata */
                                            pvr_power_is_idle()
                                              fwif_sysdata->pow_state
                                                <-- use-after-free

Unlike pm_runtime_barrier(), pm_runtime_suspend() does not wait for an
in-progress dev->power.idle_notification callback to finish, and
pvr_power_device_idle() has no drm_dev_enter() guard.

[ ... ]

> diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/im=
agination/pvr_queue.c
> index 2a6bfb090fadd..c8d8a2285b0ac 100644
> --- a/drivers/gpu/drm/imagination/pvr_queue.c
> +++ b/drivers/gpu/drm/imagination/pvr_queue.c
> @@ -881,9 +881,15 @@ pvr_queue_timedout_job(struct drm_sched_job *s_job)
>  	struct pvr_device *pvr_dev =3D queue->ctx->pvr_dev;
>  	struct pvr_job *job;
>  	u32 job_count =3D 0;
> +	int idx;
> +
> +	if (!drm_dev_enter(from_pvr_device(pvr_dev), &idx))
> +		return DRM_GPU_SCHED_STAT_ENODEV;

[Severity: Medium]
Does returning DRM_GPU_SCHED_STAT_ENODEV here leak the timed-out job's
runtime PM reference?

drm_sched_job_timedout() unlinks s_job from sched->pending_list via
list_del_init(&job->list) before calling timedout_job(), and only
reinserts it on DRM_GPU_SCHED_STAT_NO_HANG (or when drm_sched_stop() runs).
When pvr_queue_timedout_job() returns DRM_GPU_SCHED_STAT_ENODEV after
unplug, s_job stays off sched->pending_list, so pvr_queue_device_quiesce()
misses it when walking pending_list to call pvr_job_release_pm_ref().

> =20
> -	if (dma_fence_is_signaled(s_job->s_fence->parent))
> +	if (dma_fence_is_signaled(s_job->s_fence->parent)) {
> +		drm_dev_exit(idx);
>  		return DRM_GPU_SCHED_STAT_NO_HANG;
> +	}

[Severity: High]
This problem wasn't introduced by this patch, but pvr_queue_timedout_job()
runs without holding pvr_dev->reset_sem and can race with a hard reset in
pvr_power_reset() [1]:

CPU0                                CPU1
drm_sched_job_timedout()            pvr_watchdog_worker()
  pvr_queue_timedout_job()            pvr_power_reset(..., true)
                                        pvr_queue_device_pre_reset()
                                          pvr_queue_stop()
                                            drm_sched_stop()
                                              s_job->s_fence->parent =3D NU=
LL
    dma_fence_is_signaled(
      s_job->s_fence->parent)
      <-- NULL pointer dereference

drm_sched_stop() clears s_job->s_fence->parent and only calls
non-synchronous cancel_delayed_work(&sched->work_tdr) at the end.  If
pvr_queue_timedout_job() starts first, it also unlinks queue->node from
pvr_dev->queues.active before dropping pvr_dev->queues.lock, causing
pvr_queue_device_pre_reset() to miss the queue while
pvr_queue_timedout_job() restarts and kicks it in the middle of the reset.

[ ... ]

> @@ -1512,6 +1520,60 @@ int pvr_queue_device_init(struct pvr_device *pvr_d=
ev)
>  	return 0;
>  }
> =20
> +/**
> + * pvr_queue_device_quiesce() - Stop all remaining queues during device =
removal.
> + * @pvr_dev: The device to quiesce.
> + *
> + * Detaches every registered queue from @pvr_dev->queues.{active,idle} s=
o the
> + * IRQ handler cannot signal fences or re-queue free_job work, tears dow=
n its
> + * scheduler entity without blocking in drm_sched_entity_flush(), finali=
ses its
> + * scheduler so work_run_job, work_free_job and work_tdr are stopped, and
> + * releases runtime PM references held by remaining in-flight jobs before
> + * device teardown. Pins each queue's context while operating on it to a=
void
> + * racing with concurrent pvr_queue_destroy().
> + */
> +void pvr_queue_device_quiesce(struct pvr_device *pvr_dev)
> +{
> +	struct pvr_queue *queue;
> +
> +	for (;;) {
> +		struct pvr_context *ctx =3D NULL;
> +
> +		mutex_lock(&pvr_dev->queues.lock);
> +		queue =3D list_first_entry_or_null(&pvr_dev->queues.active,
> +						 struct pvr_queue, node);
> +		if (!queue)
> +			queue =3D list_first_entry_or_null(&pvr_dev->queues.idle,
> +							 struct pvr_queue, node);
> +		if (queue) {
> +			list_del_init(&queue->node);
> +			if (pvr_context_get_if_referenced(queue->ctx))
> +				ctx =3D queue->ctx;
> +		}
> +		mutex_unlock(&pvr_dev->queues.lock);
> +
> +		if (!queue)
> +			break;
> +		if (!ctx)
> +			continue;
> +
> +		if (!queue->entity.stopped) {
> +			drm_sched_entity_fini(&queue->entity);
> +			dma_fence_put(queue->last_queued_job_scheduled_fence);
> +			queue->last_queued_job_scheduled_fence =3D NULL;
> +		}

[Severity: High]
Can unscheduled jobs killed by drm_sched_entity_fini() here outlive
flush_workqueue(pvr_dev->sched_wq) and race with pvr_device_fini()?

drm_sched_entity_fini() -> drm_sched_entity_kill() frees queued entity jobs
via schedule_work(&job->work) on system_percpu_wq (or defers them to a
dma_fence callback when a job has an unsignaled dependency), not on
pvr_dev->sched_wq:

CPU0                                  kworker (system_percpu_wq)
pvr_remove()
  pvr_queue_device_quiesce()
    drm_sched_entity_fini()
      drm_sched_entity_kill()
        schedule_work(&job->work)
  flush_workqueue(pvr_dev->sched_wq)
  xa_destroy(&pvr_dev->job_ids)
  pvr_device_fini(pvr_dev)
    /* frees kernel_vm_ctx */
                                      drm_sched_entity_kill_jobs_work()
                                        pvr_queue_free_job()
                                          pvr_job_release()
                                            xa_erase(&pvr_dev->job_ids, ...)
                                            pvr_context_put()
                                              ...
                                              pvr_meta_vm_unmap()
                                                <-- use-after-free

Because jobs that never reached pvr_queue_prepare_job() have an
uninitialized job->done_fence, their release goes directly through
pvr_job_release() without any drm_dev_enter() check, accessing the
destroyed job_ids XArray and unmapping FW objects against the freed
kernel_vm_ctx.

> +		if (queue->scheduler.sched_rq) {
> +			struct pvr_job *job;
> +
> +			drm_sched_fini(&queue->scheduler);
> +			list_for_each_entry(job, &queue->scheduler.pending_list, base.list)
> +				pvr_job_release_pm_ref(job);
> +		}

[Severity: Medium]
Can walking only queue->scheduler.pending_list leak the runtime PM
reference of a paired fragment job?

In pvr_queue_run_job(), running a geometry job that has job->paired_job
acquires a PM reference for both job and job->paired_job while the paired
fragment job is still in frag_queue->entity.job_queue waiting on the
geometry job's scheduled fence.  If pvr_queue_device_quiesce() stops the
fragment queue before that fragment job is moved to
frag_queue->scheduler.pending_list, drm_sched_entity_fini() pops it from
the entity queue (where it waits indefinitely on the geometry job's
unsignaled finished fence), so neither pending_list walk releases
job->paired_job's PM reference.

[Severity: High]
This problem wasn't introduced by this patch, but in pvr_queue_run_job(),
if pvr_job_get_pm_ref(job->paired_job) fails after pvr_job_get_pm_ref(job)
succeeds, the early return leaks the geometry job's PM reference and aborts
the combined kick [2]:

drivers/gpu/drm/imagination/pvr_queue.c:pvr_queue_run_job() {
    ...
	err =3D pvr_job_get_pm_ref(job);
	if (WARN_ON(err))
		return ERR_PTR(err);

	if (job->paired_job) {
		err =3D pvr_job_get_pm_ref(job->paired_job);
		if (WARN_ON(err))
			return ERR_PTR(err);
	}
    ...
}

When the paired fragment job later runs on the fragment queue,
pvr_queue_run_job() returns job->done_fence, which is never signaled
because the combined kick was never sent, causing a scheduler timeout.

[1] https://sashiko.dev/#/bug/linux-df7937e5-34ea-4049-927a-b1a2ab49472c
[2] https://sashiko.dev/#/bug/linux-323442c2-f456-45f6-8b7f-1b059c35de97

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/010101a211d07798-70=
c4219d-e457-43d8-835c-321a7c035057-000000@us-west-2.amazonses.com?part=3D2
