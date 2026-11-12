Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484AA606A323
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 09:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m5Owlxsb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D0C410FF77;
	Thu, 12 Nov 2026 09:36:31 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F23410FF81
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 09:36:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 72130630AB;
 Thu, 12 Nov 2026 09:36:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B1631F00A05;
 Thu, 12 Nov 2026 09:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794476184;
 bh=jMsfj264bRuWErFV7rEIyeJPHWoEUd0b5B2SmV/oolY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=m5OwlxsbcMeYlWEG73eVfqbIG05C3HTn6t8JvVlu3NxlnOzheyLFQxYnfNXJvaIW9
 W1+WPLSR51lMkXSgEQYmehF1S74ONBEinMZ2mvCShgZiwxH/9gEdWaNPB58N1mHCb2
 ecXsVuy1cIShQgMaGrN4RuSJmTV5MhWArUP85X2XE2tdGg0PabePXD9F++UNrSMYc+
 +z1d6b3Rr/n1g1K/vIPXuWsfgRVS9ybZDlSDnV12Wz+vHZXP3/xcqwnee1Iya+EIxB
 Ly8zGBeOHKfGGsIlhlzY/Qtx2AgM9W5nOEPwtKHg7JIEsddfbViEtrfSvAT01HPkMH
 ZU2uF3hGQ3fPQ==
Message-ID: <sashiko-outbox-210891@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/11] drm/panfrost: Soft-stop and resume a job that
 outlives the timeout
To: "Arun Iyengar" <aiyengar1990@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261112-panfrost-long-jobs-v2-10-a06830da3d99@gmail.com>
References: <20261112-panfrost-long-jobs-v2-0-a06830da3d99@gmail.com>
 <20261112-panfrost-long-jobs-v2-10-a06830da3d99@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 09:36:23 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] drm/panfrost: cycle counter refcount underflow in
  panfrost_reset()
- [High] drm/panfrost: unstarted _NEXT job marked done in
  panfrost_jm_handle_irq()
--

commit 8e3c3b18f9b16cbaedc76fbae266b58fbe0f8950
Author: Arun Iyengar <aiyengar1990@gmail.com>

drm/panfrost: Soft-stop and resume a job that outlives the timeout

This commit soft-stops and resumes jobs that are still active when the
scheduler timeout fires, escalating to a hard-stop after 5 seconds and a
full GPU reset only if the hard-stop fails or another reset was requested.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/pa=
nfrost/panfrost_job.c
> index 28842c5724868..a920d112a67dd 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c

[ ... ]

> @@ -752,21 +858,53 @@ panfrost_reset(struct panfrost_device *pfdev,
>  			pfdev->jobs[i][pfdev->jobs[i][0] ? 1 : 0] =3D evicted[i];
> =20
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
> +			if (!reset_gpu)
> +				panfrost_mmu_as_put(pfdev, job->mmu);
> +
> +			/* The job still running on a slot that neither stop
> +			 * took effect on is what forces the reset. Fail it,
> +			 * as the Arm driver fails every atom on the hardware
> +			 * at a reset: restarted from scratch it would hit the
> +			 * timeout and the reset again. A job that was only
> +			 * given the 10 ms is restarted, as before.
> +			 */
> +			if (stop_failed && job =3D=3D hung[i])
> +				dma_fence_set_error(&job->base.s_fence->finished,
> +						    -ECANCELED);
>  		}
>  	}
>  	memset(pfdev->jobs, 0, sizeof(pfdev->jobs));
>  	spin_unlock(&pfdev->js->job_lock);
> =20
> -	/* Proceed with reset now. */
> -	panfrost_device_reset(pfdev, false);
> +	/* Proceed with reset now, unless the slots were simply busy with long
> +	 * jobs that stopped at a task boundary (or a hard stop ended the one
> +	 * that did not). The stopped jobs will be resumed from JS_TAIL (see
> +	 * panfrost_job_handle_err()).
> +	 */
> +	if (reset_gpu) {
> +		panfrost_device_reset(pfdev, false);
> =20
> -	/* GPU has been reset, we can clear the reset pending bit. */
> -	atomic_set(&pfdev->reset.pending, 0);
> +		/* GPU has been reset, we can clear the reset pending bit. */
> +		atomic_set(&pfdev->reset.pending, 0);
> +	} else {
> +		/* Leave a reset that was asked for since we looked to the
> +		 * reset work or timeout handler that asked for it.
> +		 */
> +		atomic_cmpxchg(&pfdev->reset.pending,
> +			       PANFROST_RESET_STOP_ONLY, 0);
> +	}
> =20
>  	/* Now resubmit jobs that were previously queued but didn't have a
>  	 * chance to finish.

[Severity: High]
Can this underflow pfdev->cycle_counter.use_count when a job is submitted
while pfdev->reset.pending is non-zero?

In panfrost_job_hw_submit(), panfrost_enqueue_job() records the job in
pfdev->jobs[js][subslot] unconditionally, but updating job->is_profiled and
calling panfrost_cycle_counter_get() are skipped when pfdev->reset.pending
is set:

drivers/gpu/drm/panfrost/panfrost_job.c:panfrost_job_hw_submit() {
    ...
	subslot =3D panfrost_enqueue_job(pfdev, js, job);
	/* Don't queue the job if a reset is in progress */
	if (!atomic_read(&pfdev->reset.pending)) {
		job->is_profiled =3D pfdev->profile_mode;

		if (job->requirements & PANFROST_JD_REQ_CYCLE_COUNT ||
		    job->is_profiled)
			panfrost_cycle_counter_get(pfdev);
    ...
}

If a reset is requested after reset_gpu is evaluated as false,
atomic_cmpxchg() leaves pfdev->reset.pending set to 1 while
drm_sched_resubmit_jobs() runs (or another slot's scheduler submits a job
after panfrost_job_timedout() sets PANFROST_RESET_STOP_ONLY and before
drm_sched_stop()).  A job with PANFROST_JD_REQ_CYCLE_COUNT, or a
soft-stopped job whose job->is_profiled stayed true after
panfrost_dequeue_job() already dropped its reference, is then queued in
pfdev->jobs[js][subslot] without a matching panfrost_cycle_counter_get().

When panfrost_reset() subsequently drains pfdev->jobs[i][j], it calls
panfrost_cycle_counter_put() for that job and decrements use_count below 0.
Without a GPU reset to reinitialize use_count, the underflowed counter stops
panfrost_cycle_counter_get() from starting the hardware cycle counter and
triggers the drm_WARN_ON() in panfrost_gpu_soft_reset() on the next reset.

[ ... ]

> @@ -820,18 +962,51 @@ static enum drm_gpu_sched_stat panfrost_job_timedou=
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
> +
> +	/* A job that completed after the checks above is not active either:
> +	 * its interrupt is then pending, or being handled.
> +	 */
> +	if (!job_active) {
> +		if (job_read(pfdev, JOB_INT_RAWSTAT) & JOB_INT_MASK_DONE(js))
> +			return DRM_GPU_SCHED_STAT_NO_HANG;
> +
> +		synchronize_irq(pfdev->js->irq);
> +		if (dma_fence_is_signaled(job->done_fence))
> +			return DRM_GPU_SCHED_STAT_NO_HANG;
> +	}
> +
> +	if (job_active) {
> +		dev_dbg(pfdev->base.dev, "job still active after %u ms, js=3D%d, head=
=3D0x%x, sched_job=3D%p: soft-stopping it to resume",
> +			JOB_TIMEOUT_MS, js, job_read(pfdev, JS_HEAD_LO(js)),
> +			sched_job);
> +	} else {
> +		dev_err(pfdev->base.dev, "gpu sched timeout, js=3D%d, config=3D0x%x, s=
tatus=3D0x%x, head=3D0x%x, tail=3D0x%x, sched_job=3D%p",
> +			js,
> +			job_read(pfdev, JS_CONFIG(js)),
> +			js_status,
> +			job_read(pfdev, JS_HEAD_LO(js)),
> +			job_read(pfdev, JS_TAIL_LO(js)),
> +			sched_job);
> =20
> -	panfrost_core_dump(job);
> +		panfrost_core_dump(job);
> +	}
> =20
> -	atomic_set(&pfdev->reset.pending, 1);
> -	panfrost_reset(pfdev, sched_job);
> +	/* Ask for a reset, or only for the stop if no reset is pending. */
> +	if (job_active)
> +		atomic_cmpxchg(&pfdev->reset.pending, 0,
> +			       PANFROST_RESET_STOP_ONLY);
> +	else
> +		atomic_set(&pfdev->reset.pending, 1);
> +	panfrost_reset(pfdev, sched_job, job_active);
> =20
>  	return DRM_GPU_SCHED_STAT_RESET;
>  }

[Severity: High]
Can setting pfdev->reset.pending before stopping the schedulers and masking
interrupts cause a second job queued on another slot to be signaled as done
without ever running on the GPU?

CPU0                              CPU1
panfrost_job_timedout()
  atomic_cmpxchg(&pfdev->reset.pending,
                 0, PANFROST_RESET_STOP_ONLY)
                                  panfrost_job_hw_submit() [job1]
                                    panfrost_enqueue_job()
                                      pfdev->jobs[j][1] =3D job1
                                    if (!atomic_read(&pfdev->reset.pending))
                                      /* skipped: _NEXT not started */
                                  panfrost_jm_irq_handler_thread()
                                    panfrost_jm_handle_irq()
                                      /* job0 finishes; job1 moves to [0] */
                                      done[j][0] =3D panfrost_dequeue_job()
                                      if (pfdev->jobs[j][0] &&
                                          !(js_state & MK_JS_MASK(j)))
                                        done[j][1] =3D panfrost_dequeue_job=
()
                                      panfrost_jm_handle_done(..., job1)
                                        <-- signals fence without running
  panfrost_reset()
    drm_sched_stop()
    job_write(pfdev, JOB_INT_MASK, 0)

When a 500 ms time-slice timeout fires on one slot, pfdev->reset.pending is
set to PANFROST_RESET_STOP_ONLY before panfrost_reset() stops the schedulers
and masks job interrupts.  If another slot is running job0 and submits job1
in that window, panfrost_job_hw_submit() puts job1 into pfdev->jobs[j][1]
but skips writing JS_COMMAND_START to JS_COMMAND_NEXT(j).

If job0 finishes before JOB_INT_MASK is cleared, panfrost_jm_handle_irq()
shifts job1 into pfdev->jobs[j][0], sees both hardware subslots inactive in
js_state, and dequeues job1 into done[j][1] as if the hardware had
auto-started and completed it.  panfrost_jm_handle_done() then sets
job1->jc =3D 0 and signals job1->done_fence, causing drm_sched_resubmit_job=
s()
to treat job1 as finished even though it never ran on the GPU.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-panfrost-l=
ong-jobs-v2-0-a06830da3d99@gmail.com?part=3D10
