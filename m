Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE57606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F0pdg0Hm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB17F10EE84;
	Tue, 10 Nov 2026 08:14:52 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5744910EE84
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 08:14:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 133E341493;
 Tue, 10 Nov 2026 08:14:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A151F0089F;
 Tue, 10 Nov 2026 08:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794298486;
 bh=q1TT9foL9/CX/BjNT1OuAcmcNzzEDvJ+jP3uzMwc/hI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=F0pdg0HmLV5yDPzuRi4OYmIeE6iSHB/5RAVDEfk/AH8Fkq3aJOq6l9OC0XZO/TKeJ
 FJCZGoF1VvgJRVxJSWzzyQcndcN0xLAzoOtT6hL9VYzIoggTHc7AT6XgPdTvWAvwWk
 JrbI9nDSJVMkxm29Z2dcUyk2V03+NZ+4xYDrHyJpnqxLMOaITZ5KKUykfDmxoiI5Z5
 b2hWmUc71U6Pg9C4SONwxIoWPluc8qa8g8jSmAOzktS+0RD1O6OOpBiByKwk38frDF
 dBlrcxz92eEDaWRtidP4gkookJ/9tB9ET1YlkusrRA/5cyXUGFFr7SVHIp0oDj+ouG
 gwcKL0934YPWw==
Message-ID: <sashiko-outbox-206581@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/7] drm/panfrost: Soft-stop and resume a job that
 outlives the timeout
To: "Arun Iyengar" <aiyengar1990@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261110-panfrost-long-jobs-v1-6-24508939ae8d@gmail.com>
References: <20261110-panfrost-long-jobs-v1-0-24508939ae8d@gmail.com>
 <20261110-panfrost-long-jobs-v1-6-24508939ae8d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 08:14:45 +0000
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

Thank you for your contribution! Sashiko AI review found 6 potential
issues to consider:
- [High] drm/panfrost: jobs finishing during panfrost_reset() get
  -ECANCELED
- [High] drm/panfrost: cancelled _NEXT job marked DONE in
  panfrost_jm_handle_irq()
- [Medium] drm/panfrost: panfrost_reset() clears reset.pending without
  GPU reset
- [Medium] drm/panfrost: hung active jobs skip karma increase and core
  dump
- [Medium] drm/panfrost: panfrost_reset() fails active jobs on sibling
  slots
- [Medium] drm/panfrost: race in panfrost_job_timedout() causes false
  GPU reset
--

commit 459199c0f22ade204c094e9cf2b470689b79061c
Author: Arun Iyengar <aiyengar1990@gmail.com>

drm/panfrost: Soft-stop and resume a job that outlives the timeout

This commit changes the Panfrost scheduler timeout path to soft-stop active
job slots, wait up to 5 seconds for them to reach a task boundary, and
resume their jobs from JS_TAIL without resetting the GPU unless soft-stop
and hard-stop fail.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/pa=
nfrost/panfrost_job.c
> index 81efa8a867890..e37dd92651188 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c

[ ... ]

> @@ -672,7 +686,7 @@ static bool panfrost_slots_idle(struct panfrost_devic=
e *pfdev)
> =20
>  static void
>  panfrost_reset(struct panfrost_device *pfdev,
> -	       struct drm_sched_job *bad)
> +	       struct drm_sched_job *bad, bool job_active)
>  {
>  	unsigned int i, j;
>  	bool cookie, idle;
> @@ -681,6 +695,12 @@ panfrost_reset(struct panfrost_device *pfdev,
>  	if (!atomic_read(&pfdev->reset.pending))
>  		return;
> =20
> +	/* The jobs we stop drop their runtime PM references before we submit
> +	 * them again. Keep the GPU powered in between: a suspend would power
> +	 * the L2 off and lose the dirty lines of a soft-stopped job.
> +	 */
> +	pm_runtime_get_noresume(pfdev->base.dev);
> +
>  	/* Stop the schedulers.
>  	 *
>  	 * FIXME: We temporarily get out of the dma_fence_signalling section
> @@ -699,7 +719,8 @@ panfrost_reset(struct panfrost_device *pfdev,
> =20
>  	cookie =3D dma_fence_begin_signalling();
> =20
> -	if (bad)
> +	/* A job that is merely long is not guilty of anything. */
> +	if (bad && !job_active)
>  		drm_sched_increase_karma(bad);

[Severity: Medium]
Does checking !job_active here and in panfrost_job_timedout() skip
drm_sched_increase_karma() and panfrost_core_dump() for shaders that are
genuinely hung in DRM_PANFROST_EXCEPTION_ACTIVE?

A shader stuck in an infinite loop still reports JS_STATUS as
DRM_PANFROST_EXCEPTION_ACTIVE when the 500 ms timeout fires, so job_active
starts out true.  If the job then fails the 5-second soft-stop and has to
be hard-stopped (or fails the hard-stop too and forces a GPU reset),
neither its karma nor a devcoredump is ever recorded.

>  	/* Mask job interrupts and synchronize to make sure we won't be
> @@ -714,43 +735,110 @@ panfrost_reset(struct panfrost_device *pfdev,
>  		job_write(pfdev, JS_COMMAND(i), JS_COMMAND_SOFT_STOP);
>  	}
> =20
> -	/* Wait at most 10ms for soft-stops to complete. Every slot must have
> -	 * gone idle before we touch the queues: a job that is still stopping
> -	 * (or finishing) raises its interrupt later, when its entry in
> -	 * pfdev->jobs[] is gone or belongs to its own resubmission.
> +	/* Every slot must have gone idle before we touch the queues: a job
> +	 * that is still stopping (or finishing) raises its interrupt later,
> +	 * when its entry in pfdev->jobs[] is gone or belongs to its own
> +	 * resubmission, and the second start of that job then runs on a slot
> +	 * we have no job for.
> +	 *
> +	 * A slot that was idle or faulted gets 10 ms. A job that was still
> +	 * active gets the time the Arm driver gives it to reach a task
> +	 * boundary (JOB_SOFT_STOP_TIMEOUT_MS). If it has not stopped by then
> +	 * it is hard-stopped, which terminates it at once and fails it
> +	 * (TERMINATED, see panfrost_job_handle_err()), instead of resetting
> +	 * the GPU under every job on it; the GPU is reset only when the hard
> +	 * stop does not take effect either.
>  	 */
> -	ret =3D read_poll_timeout(panfrost_slots_idle, idle, idle, 10, 10000,
> +	ret =3D read_poll_timeout(panfrost_slots_idle, idle, idle,
> +				job_active ? 200 : 10,
> +				job_active ? JOB_SOFT_STOP_TIMEOUT_MS * 1000 : 10000,
>  				false, pfdev);

[Severity: High]
If an active job finishes its last tasks during this 5-second soft-stop
wait (raising JOB_INT_MASK_DONE rather than stopping with
DRM_PANFROST_EXCEPTION_STOPPED), won't its scheduler fence be signaled with
-ECANCELED?

drm_sched_stop() has already detached the completion callback from
job->done_fence and cleared s_job->s_fence->parent.  When
panfrost_jm_handle_irqs() then runs panfrost_jm_handle_done(), it sets
job->jc =3D 0, so panfrost_job_run() returns NULL during
drm_sched_resubmit_jobs():

drivers/gpu/drm/panfrost/panfrost_job.c:panfrost_job_run() {
	...
	if (!job->jc)
		return NULL;
}

When drm_sched_start(&pfdev->js->queue[i].sched, 0) runs afterwards,
s_job->s_fence->parent is still NULL, so drm_sched_start() completes the
job with errno ?: -ECANCELED, failing a job that succeeded on the GPU.

[ ... ]

>  	/* Handle the remaining interrupts before we reset. */
>  	panfrost_jm_handle_irqs(pfdev);

[Severity: High]
What happens to a second job queued in _NEXT (pfdev->jobs[j][1]) when
panfrost_reset() cancels it with JS_COMMAND_NOP and the running job in
pfdev->jobs[j][0] finishes with JOB_INT_MASK_DONE during the soft-stop
poll?

In panfrost_jm_handle_irq(), JOB_INT_MASK_DONE(j) dequeues the running job
into done[j][0] and shifts the cancelled _NEXT job into pfdev->jobs[j][0],
with failed[j] still NULL and both hardware subslots now inactive:

drivers/gpu/drm/panfrost/panfrost_job.c:panfrost_jm_handle_irq() {
	...
		if (failed[j]) {
			panfrost_job_handle_err(pfdev, failed[j], j);
		} else if (pfdev->jobs[j][0] && !(js_state & MK_JS_MASK(j))) {
			if (WARN_ON(!done[j][0]))
				done[j][0] =3D panfrost_dequeue_job(pfdev, j);
			else
				done[j][1] =3D panfrost_dequeue_job(pfdev, j);
		}

		for (i =3D 0; i < ARRAY_SIZE(done[0]) && done[j][i]; i++)
			panfrost_jm_handle_done(pfdev, done[j][i]);
}

Because that branch assumes _NEXT is only cancelled when failed[j] is set,
it dequeues the unstarted _NEXT job into done[j][1] and calls
panfrost_jm_handle_done() on it.  That zeroes its job->jc, so
drm_sched_resubmit_jobs() skips it and the job never runs on the hardware.

>  	/* Remaining interrupts have been handled, but we might still have
> -	 * stuck jobs. Let's make sure the PM counters stay balanced by
> +	 * stuck jobs, and jobs that were waiting in _NEXT when it was
> +	 * cancelled. Let's make sure the PM counters stay balanced by
>  	 * manually calling pm_runtime_put_noidle() and
> -	 * panfrost_devfreq_record_idle() for each stuck job.
> +	 * panfrost_devfreq_record_idle() for each of them.
>  	 * Let's also make sure the cycle counting register's refcnt is
> -	 * kept balanced to prevent it from running forever
> +	 * kept balanced to prevent it from running forever.
>  	 */
>  	spin_lock(&pfdev->js->job_lock);
>  	for (i =3D 0; i < NUM_JOB_SLOTS; i++) {
>  		for (j =3D 0; j < ARRAY_SIZE(pfdev->jobs[0]) && pfdev->jobs[i][j]; j++=
) {
> -			if (pfdev->jobs[i][j]->requirements & PANFROST_JD_REQ_CYCLE_COUNT ||
> -			    pfdev->jobs[i][j]->is_profiled)
> -				panfrost_cycle_counter_put(pfdev->jobs[i][j]->pfdev);
> +			struct panfrost_job *job =3D pfdev->jobs[i][j];
> +
> +			if (job->requirements & PANFROST_JD_REQ_CYCLE_COUNT ||
> +			    job->is_profiled)
> +				panfrost_cycle_counter_put(job->pfdev);
>  			pm_runtime_put_noidle(pfdev->base.dev);
>  			panfrost_devfreq_record_idle(&pfdev->pfdevfreq);
> +
> +			/* The GPU reset wipes the address space assignments;
> +			 * without one, release the reference the submission
> +			 * took, or the address space can never be reassigned.
> +			 */
> +			if (job_active)
> +				panfrost_mmu_as_put(pfdev, job->mmu);
> +
> +			/* The job still running on a slot that neither stop
> +			 * took effect on is what forces the reset. Fail it,
> +			 * as the Arm driver fails every atom on the hardware
> +			 * at a reset: restarted from scratch it would hit the
> +			 * timeout and the reset again.
> +			 */
> +			if (!job_active && j =3D=3D 0 &&
> +			    job_read(pfdev, JS_STATUS(i)) =3D=3D
> +			    DRM_PANFROST_EXCEPTION_ACTIVE)
> +				dma_fence_set_error(&job->base.s_fence->finished,
> +						    -ECANCELED);

[Severity: Medium]
Can this fail an innocent job on another slot when panfrost_reset() was
entered with job_active =3D=3D false?

When panfrost_reset() is called from panfrost_reset_work() or from
panfrost_job_timedout() for a non-active slot, job_active is false on
entry, so read_poll_timeout() only gives the other slots 10 ms to reach a
task boundary and skips the hard-stop pass.  Any normal job on another
slot whose current task takes longer than 10 ms will still have
JS_STATUS(i) =3D=3D DRM_PANFROST_EXCEPTION_ACTIVE here and get failed with
-ECANCELED instead of being restarted after the reset.

>  		}
>  	}
> -	pfdev->reset.count++;
> +	if (!job_active)
> +		pfdev->reset.count++;
>  	memset(pfdev->jobs, 0, sizeof(pfdev->jobs));
>  	spin_unlock(&pfdev->js->job_lock);
> =20
> -	/* Proceed with reset now. */
> -	panfrost_device_reset(pfdev, false);
> +	/* Proceed with reset now, unless the slots were simply busy with long
> +	 * jobs that stopped at a task boundary (or a hard stop ended the one
> +	 * that did not). The stopped jobs will be resumed from JS_TAIL (see
> +	 * panfrost_job_handle_err()). The hardware keeps their resume state in
> +	 * the job header and the results of the tasks that already finished
> +	 * in the L2: a soft reset throws both away, and a job resumed after it
> +	 * completes with stale data in the buffers it had still to write and
> +	 * no error reported (panfrost_job_run() fails such a job instead).
> +	 */
> +	if (!job_active)
> +		panfrost_device_reset(pfdev, false);
> =20
>  	/* GPU has been reset, we can clear the reset pending bit. */
>  	atomic_set(&pfdev->reset.pending, 0);

[Severity: Medium]
Can clearing pfdev->reset.pending when job_active is true drop a needed
hardware reset?

pfdev->reset.pending is also set by panfrost_device_schedule_reset() (for
example when wait_ready() times out on an MMU command) and by
panfrost_job_handle_err() when panfrost_exception_needs_reset() is true.
If either happens before or during a soft-stop-only panfrost_reset() (inclu=
ding
inside panfrost_jm_handle_irqs() above), skipping panfrost_device_reset()
while unconditionally clearing pfdev->reset.pending causes
panfrost_reset_work() to see !atomic_read(&pfdev->reset.pending) and return
without resetting the GPU.

[ ... ]

> @@ -807,18 +899,34 @@ static enum drm_gpu_sched_stat panfrost_job_timedou=
t(struct drm_sched_job
>  		return DRM_GPU_SCHED_STAT_NO_HANG;
>  	}
> =20
> -	dev_err(pfdev->base.dev, "gpu sched timeout, js=3D%d, config=3D0x%x, st=
atus=3D0x%x, head=3D0x%x, tail=3D0x%x, sched_job=3D%p",
> -		js,
> -		job_read(pfdev, JS_CONFIG(js)),
> -		job_read(pfdev, JS_STATUS(js)),
> -		job_read(pfdev, JS_HEAD_LO(js)),
> -		job_read(pfdev, JS_TAIL_LO(js)),
> -		sched_job);
> +	/*
> +	 * A slot that is still ACTIVE is not hung, it is running a job that
> +	 * takes longer than JOB_TIMEOUT_MS. Compute kernels legitimately do.
> +	 * Soft-stop such a job and resume it, the way the Arm driver
> +	 * time-slices jobs, instead of resetting the GPU under it; the reset
> +	 * stays for faults and for jobs that do not stop.
> +	 */
> +	js_status =3D job_read(pfdev, JS_STATUS(js));
> +	job_active =3D js_status =3D=3D DRM_PANFROST_EXCEPTION_ACTIVE;

[Severity: Medium]
What if the job finishes on the hardware right after the
dma_fence_is_signaled(job->done_fence) check above and before this
JS_STATUS(js) read?

CPU0 (timeout work)               GPU / IRQ
panfrost_job_timedout()
  dma_fence_is_signaled() -> false
                                  job finishes on slot js
                                  JS_STATUS(js) becomes 0 (OK)
  js_status =3D job_read(JS_STATUS)
  job_active =3D false              <-- triggers full GPU reset

Because job interrupts are not masked until inside panfrost_reset(),
JS_STATUS(js) transitions from DRM_PANFROST_EXCEPTION_ACTIVE to 0 (OK) as
soon as the job completes.  job_active then evaluates to false, which logs
a timeout error with status=3D0x0, takes a devcoredump, increases the
completed job's karma, and performs a full GPU reset (also failing any
soft-stopped jobs on other slots by bumping pfdev->reset.count).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-panfrost-l=
ong-jobs-v1-0-24508939ae8d@gmail.com?part=3D6
