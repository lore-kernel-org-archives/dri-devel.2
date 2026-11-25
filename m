Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED00606A326
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 08:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bDQSba5v
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E624210FA44;
	Wed, 25 Nov 2026 08:55:49 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3862C10FA44
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 08:55:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 46E57623FF;
 Wed, 25 Nov 2026 08:55:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E9D1F000C4;
 Wed, 25 Nov 2026 08:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795596941;
 bh=3WiI+IOdnfv8v96e3lY0IeeYPRxM5kTqm7dW4/rCiU4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bDQSba5vo85uSb8BTEhp4CqGH3PJV6CdD2hPtm6uFFPzj8/ftniAxz7lhfbN78a5q
 JlsBNXfovM8z6d4Q3/4Xv9VrxDQGdgsAJpJ/BgMYvqOREAGaQ1MEi0XxGD7J4D0HTq
 YBP26WRrED9mS9w/zPVfXDlWPMMPlyDeip+AyeOH7Rw/ZNrpO4BE/mSddVQQ6hdHUk
 IMgayfWH7uxcHI32WRk/lL8DLmHuhgEM3jLexrdLq9UuxGdAe9hB+H2Nv+Xf11ZBzy
 HDUVVJBOxkrT0ry5DPZi+HPAfdyJhH0D1gBFD02HsOKCfFnYr9k3PL+R4Sl50/jEBM
 Rb1clwJfRQJ7g==
Message-ID: <sashiko-outbox-232957@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/imagination: quiesce queues before device teardown
To: "Lewis Lakerink" <lewis@retsim.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <010101a211d07b13-42cf1386-97c8-41d3-8eca-2e56ccb33258-000000@us-west-2.amazonses.com>
References: <20261125082637.2839673-1-lewis@retsim.com>
 <010101a211d07b13-42cf1386-97c8-41d3-8eca-2e56ccb33258-000000@us-west-2.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 08:55:41 +0000
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

Thank you for your contribution! Sashiko AI review found 8 potential
issues to consider:
- [High] drm/imagination: pvr_remove() races pvr_device_lost() and IRQ
  pvr_power_reset()
- [High] drm/imagination: unplugging before pm_runtime_suspend() breaks
  GPU power-off
- [High] drm/imagination: pvr_power_device_idle() UAF when runtime_error
  is not latched
- [High] drm/imagination: drm_dev_enter() across
  drm_sched_entity_destroy() deadlocks
- [High] drm/imagination: unflushed entity kill work in
  pvr_queue_device_quiesce()
- [Medium] drm/imagination: unplugging before pvr_queue_device_quiesce()
  leaks contexts
- [Medium] drm/imagination: PM ref leak on unplug in
  pvr_queue_timedout_job()
- [Medium] drm/imagination: paired frag job PM ref leak in
  pvr_queue_device_quiesce()
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [High] drm/imagination: unmapped firmware dereference in
  pvr_power_device_idle() [1]
--

commit 65a076714aeb37e172c20303373b34d2af84b0ea
Author: Lewis Lakerink <lewis@retsim.com>

drm/imagination: quiesce queues before device teardown

This commit reorders pvr_remove() to unplug the DRM device and quiesce acti=
ve
and idle scheduler queues before tearing down device state, and adds
drm_dev_enter() guards to context destruction, postclose, and job timeout
handling.

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

[Severity: High]
Can holding drm_dev_enter() across pvr_context_destroy() here (and in
pvr_drm_driver_postclose() below) deadlock against drm_dev_unplug() in
pvr_remove()?

pvr_context_destroy() calls pvr_context_kill_queues() -> pvr_queue_kill() ->
drm_sched_entity_destroy() -> drm_sched_entity_flush(), which blocks
non-exiting tasks in wait_event_killable(sched->job_scheduled, ...) until t=
he
entity drains:

CPU0                              CPU1
pvr_ioctl_destroy_context()
  drm_dev_enter()
  pvr_context_destroy()
    ...
      drm_sched_entity_flush()
        wait_event_killable(
          sched->job_scheduled)
                                  pvr_remove()
                                    drm_dev_unplug()
                                      synchronize_srcu()  <-- waits for CPU0
                                    pvr_queue_device_quiesce()

If an entity job is waiting on an unsignaled dependency fence or a stalled
GPU, CPU0 stays inside the drm_unplug_srcu read-side critical section while
waiting for sched->job_scheduled, and pvr_remove() cannot reach
pvr_queue_device_quiesce() -> drm_sched_fini() to wake it.

[ ... ]

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
Can this unsynchronized pvr_dev->lost check race with pvr_device_lost() and
an IRQ-driven pvr_power_reset()?

The threaded IRQ handler remains active until pvr_device_fini() calls
free_irq(), and pvr_remove() neither sets pvr_dev->lost =3D true nor holds
pvr_dev->reset_sem:

CPU0                              CPU1 (IRQ thread)
pvr_remove()
  if (!READ_ONCE(pvr_dev->lost))
    drm_dev_unplug(drm_dev)
                                  pvr_fwccb_process()
                                    pvr_power_reset()
                                      pvr_power_device_resume()
                                        drm_dev_enter() -> -EIO
                                      pvr_device_lost()
                                        if (!pvr_dev->lost)
                                          drm_dev_unplug()  <-- second unpl=
ug

Conversely, pvr_device_lost() sets pvr_dev->lost =3D true before calling
drm_dev_unplug():

drivers/gpu/drm/imagination/pvr_power.c:pvr_device_lost() {
	if (!pvr_dev->lost) {
		pvr_dev->lost =3D true;
		drm_dev_unplug(from_pvr_device(pvr_dev));
	}
}

If pvr_device_lost() sets pvr_dev->lost =3D true just before pvr_remove()
checks it, pvr_remove() skips drm_dev_unplug() and proceeds to
pvr_queue_device_quiesce(), xa_destroy(), and pvr_device_fini() before
pvr_device_lost()'s synchronize_srcu() has finished waiting for in-flight
drm_dev_enter() sections.

Also, because free_irq() does not run until pvr_device_fini(), an IRQ thread
running pvr_fwccb_process() can still look up pvr_dev->free_list_ids after
xa_destroy(&pvr_dev->free_list_ids) below, or call pvr_power_reset() ->
pvr_power_get_clear() after pm_runtime_suspend() and clear the
dev->power.runtime_error latch back to 0.

> +
> +	/* Stop all queues and their drm_sched workers/timers before teardown. =
*/
> +	pvr_queue_device_quiesce(pvr_dev);

[Severity: Medium]
Does calling drm_dev_unplug() before pvr_queue_device_quiesce() leak every
context that has ever submitted a job?

Each queue retains a reference to the last submitted job's scheduled fence =
in
queue->entity.last_scheduled and queue->last_queued_job_scheduled_fence, wh=
ose
parent pvr_queue_fence holds a reference to queue->ctx.  When
pvr_queue_device_quiesce() drops those fences after drm_dev_unplug(),
pvr_queue_fence_release() sees drm_dev_enter() fail:

drivers/gpu/drm/imagination/pvr_queue.c:pvr_queue_fence_release() {
	...
	if (drm_dev_enter(from_pvr_device(pvr_dev), &idx)) {
		queue_work(pvr_dev->sched_wq, &fence->release_work);
		drm_dev_exit(idx);
	} else {
		dma_fence_free(&fence->base);
	}
}

Instead of queueing fence->release_work to be drained by the
flush_workqueue(pvr_dev->sched_wq) below, pvr_queue_fence_release() frees t=
he
fence without calling pvr_context_put(), leaking the context and its firmwa=
re
objects and VM mappings and triggering the WARN_ON() checks in pvr_fw_fini(=
),
drm_mm_takedown(), and pvr_context_device_fini().

> +
> +	/*
> +	 * Drain pre-unplug pvr_queue_fence_release_work items while the GPU,
> +	 * kernel_vm_ctx, FW objects and job_ids are still alive.
> +	 */
> +	flush_workqueue(pvr_dev->sched_wq);
> =20
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
Does moving drm_dev_unplug() ahead of pm_runtime_suspend() leave the firmwa=
re
processor and clocks running while pvr_device_fini() frees the firmware DMA
buffers and GPU page tables?

Before calling pvr_remove(), __device_release_driver() calls
pm_runtime_get_sync() followed by pm_runtime_put_sync(), which wakes the GPU
and starts the firmware processor via pvr_power_device_resume() and only ar=
ms
the 50 ms autosuspend timer.  Previously, pm_runtime_suspend() ran before
drm_dev_unplug(), so pvr_power_device_suspend() stopped the firmware proces=
sor
via pvr_power_fw_disable() and cut clocks via pwr_ops->power_off() (and a
successful pm_runtime_suspend() sets runtime_status to RPM_SUSPENDED, which
also prevents rpm_idle() from calling pvr_power_device_idle()).  With
drm_dev_unplug() moved first, pvr_power_device_suspend() always fails
drm_dev_enter() with -EIO, so pvr_device_fini() -> pvr_fw_fini() unmaps and
frees all firmware objects and destroys kernel_vm_ctx while the GPU is still
powered, clocked, and executing from those DMA pages, and leaks the clock
enable references.

[Severity: High]
Can pvr_power_device_idle() still dereference unmapped fwif_sysdata during =
or
after pvr_device_fini() despite the pm_runtime_suspend() call?

pvr_queue_device_quiesce() calls pvr_job_release_pm_ref() -> pvr_power_put()
-> pm_runtime_put(), which queues an asynchronous RPM_REQ_IDLE work item on
pm_wq.  Unlike __pm_runtime_barrier(), pm_runtime_suspend() does not wait f=
or
an in-flight dev->power.idle_notification callback to finish:

CPU0                              CPU1 (pm_wq)
pvr_remove()
  pvr_queue_device_quiesce()
    pvr_job_release_pm_ref()
      pm_runtime_put()
                                  pm_runtime_work()
                                    rpm_idle()
                                      pvr_power_device_idle()
  pm_runtime_suspend() -> -EIO
  pvr_device_fini()
    pvr_fw_fini()
      /* unmaps fwif_sysdata */
                                        pvr_power_is_idle()
                                          fwif_sysdata->pow_state  <-- UAF

In addition, if dev->power.usage_count > 0 when pm_runtime_suspend() runs (=
for
instance when power/autosuspend_delay_ms is negative, or while an IRQ-driven
pvr_power_reset() holds a PM reference), rpm_suspend() returns -EAGAIN befo=
re
invoking pvr_power_device_suspend(), so runtime_error is never latched and
devres teardown's pm_runtime_disable_action() later calls
pvr_power_device_idle() on the unmapped fwif_sysdata.

[Severity: High]
This problem wasn't introduced by this patch, but pvr_power_device_idle() h=
as
no drm_dev_enter() or READ_ONCE(pvr_dev->fw_dev.initialised) check before
calling pvr_power_is_idle() [1], so on the pvr_probe() error path (if
drm_dev_register() fails after pvr_device_init() has queued an asynchronous
idle request via pm_runtime_put()) or whenever pm_runtime_suspend() in
pvr_remove() fails with -EAGAIN while pvr_watchdog_worker() holds a PM
reference, runtime PM can still invoke pvr_power_device_idle() after
pvr_fw_fini() has unmapped fwif_sysdata and kccb.ccb.ctrl.

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
Does returning DRM_GPU_SCHED_STAT_ENODEV here leak s_job's runtime PM
reference?

Before invoking timedout_job(), drm_sched_job_timedout() unlinks s_job from
sched->pending_list via list_del_init(&job->list), and it does not reinsert
the job when timedout_job() returns DRM_GPU_SCHED_STAT_ENODEV.  When
pvr_queue_device_quiesce() later walks queue->scheduler.pending_list to call
pvr_job_release_pm_ref(), s_job is no longer on pending_list, so its runtime
PM reference is never released.

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
Can jobs killed by drm_sched_entity_fini() run pvr_job_release() on the sys=
tem
workqueue after pvr_remove() has destroyed job_ids and kernel_vm_ctx?

For each unpopped job still in entity->job_queue, drm_sched_entity_fini() ->
drm_sched_entity_kill() schedules drm_sched_entity_kill_jobs_work via
schedule_work(&job->work) onto the global system workqueue (or defers it to=
 an
unsignaled dependency fence callback), not onto pvr_dev->sched_wq:

CPU0                              CPU1 (system_wq)
pvr_remove()
  pvr_queue_device_quiesce()
    drm_sched_entity_fini()
      ...
        schedule_work(&job->work)
  flush_workqueue(pvr_dev->sched_wq)
  xa_destroy(&pvr_dev->job_ids)
  pvr_device_fini()
    /* frees kernel_vm_ctx */
                                  drm_sched_entity_kill_jobs_work()
                                    pvr_queue_free_job()
                                      pvr_job_release()
                                        xa_erase(&pvr_dev->job_ids, ...)
                                        pvr_context_put()
                                          ...
                                            pvr_meta_vm_unmap()  <-- UAF

Because flush_workqueue(pvr_dev->sched_wq) does not drain those system
workqueue items, pvr_job_release() (which has no drm_dev_enter() guard) can
erase from the destroyed job_ids xarray and release the last context or HWRT
reference after pvr_device_fini() has freed kernel_vm_ctx.  Also, if
pvr_queue_prepare_job() had already run for a job still in entity->job_queu=
e,
queue->cccb_fence_ctx.job and pvr_dev->kccb.waiters / reserved_count are le=
ft
behind when pvr_kccb_fini() runs.

> +		if (queue->scheduler.sched_rq) {
> +			struct pvr_job *job;
> +
> +			drm_sched_fini(&queue->scheduler);
> +			list_for_each_entry(job, &queue->scheduler.pending_list, base.list)
> +				pvr_job_release_pm_ref(job);
> +		}

[Severity: Medium]
Can this loop miss the runtime PM reference held by a paired fragment job?

In pvr_queue_run_job(), running a geometry job with a paired fragment job
acquires the PM reference for both jobs before the fragment job is popped f=
rom
frag_queue->entity onto frag_queue->scheduler.pending_list:

drivers/gpu/drm/imagination/pvr_queue.c:pvr_queue_run_job() {
	...
	if (job->paired_job) {
		err =3D pvr_job_get_pm_ref(job->paired_job);
		if (WARN_ON(err))
			return ERR_PTR(err);
	}
	...
}

If pvr_queue_device_quiesce() runs after the geometry job's run_job() has
taken job->paired_job's PM reference but before frag_queue's work_run_job p=
ops
the fragment job onto frag_queue->scheduler.pending_list, the fragment job =
is
killed in frag_queue->entity and never reaches pending_list, so walking
pending_list without also releasing job->paired_job's PM reference leaks it.

[1] https://sashiko.dev/#/bug/linux-00298821-c6b8-4257-b57f-8521b3a59a07

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/010101a211d07983-72=
e5379a-adfd-4134-b23d-3e2b1422bc2e-000000@us-west-2.amazonses.com?part=3D2
