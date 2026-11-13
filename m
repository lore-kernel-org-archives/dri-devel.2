Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D2760A2605
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 09:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ANRn8LSK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91EE410E04B;
	Fri, 13 Nov 2026 09:49:33 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFCE310E04B
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 09:49:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7617A43658;
 Fri, 13 Nov 2026 09:49:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C651F000C4;
 Fri, 13 Nov 2026 09:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794563366;
 bh=/aG1jSSWAds0+j4pEPdfoJ6aaSMd1uR1KmdiCUMi4Vo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ANRn8LSKfU8G9TPfJp1Lln0UzlKszKZAwSvooV85dfAelZAYiU86cdUqCzPIzdPhi
 iSehagHUDw6YGMifm0UDaiTPSP456ec06whC7p7U4C253tXTpaVUEZ5OAu1MPE487r
 Xi30OS0rz/S3+bUJXtGAWykVJYls2ArjLUTU52+U80goGwaF79sy4yS/xFUlDY5LeH
 A0lqusgiGE3iKNlWjnDD1SwVHl//OHECh3C6fT4h3gkcyG7ZShHBkRQ95uUYRH3Hs+
 yrjknYrwp8AS7nQT5IiAwspF2/KxCvcHU3bjSqEqSo7eK4LEtpT0u73zBkts86uvTw
 tHWk4XMUfazrQ==
Message-ID: <sashiko-outbox-212575@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/14] drm/panfrost: Soft-stop and resume a job that
 outlives the timeout
To: "Arun Iyengar" <aiyengar1990@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261113-panfrost-long-jobs-v3-13-80ae78d38f6e@gmail.com>
References: <20261113-panfrost-long-jobs-v3-0-80ae78d38f6e@gmail.com>
 <20261113-panfrost-long-jobs-v3-13-80ae78d38f6e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 09:49:25 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/panfrost: runtime suspend race in panfrost_job_timedout()
  before reset
--

commit 3b989ea77e83f04bf915c182d8dabfa8f214f4fc
Author: Arun Iyengar <aiyengar1990@gmail.com>

drm/panfrost: Soft-stop and resume a job that outlives the timeout

This commit updates the Panfrost job timeout handler to soft-stop and resume
slots whose jobs are still active, falling back to a hard-stop after 5 seco=
nds
and a full GPU reset only if the hard-stop fails or another reset is
requested.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/pa=
nfrost/panfrost_job.c
> index 8235d182d8114..6757d0fbf63c9 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
[ ... ]
> @@ -664,18 +677,35 @@ static bool panfrost_slots_idle(struct panfrost_dev=
ice *pfdev)
[ ... ]
>  static void
>  panfrost_reset(struct panfrost_device *pfdev,
> -	       struct drm_sched_job *bad)
> +	       struct drm_sched_job *bad, bool job_active)
>  {
>  	struct panfrost_job *evicted[NUM_JOB_SLOTS] =3D {};
> +	struct panfrost_job *hung[NUM_JOB_SLOTS] =3D {};
> +	bool cookie, idle, stop_failed =3D false, reset_gpu;
>  	unsigned int i, j;
> -	bool cookie, idle;
>  	int ret;
> =20
>  	if (!atomic_read(&pfdev->reset.pending))
>  		return;
> =20
> +	/* The stopped jobs drop their runtime PM references before they are
> +	 * resubmitted: keep the GPU powered in between.
> +	 */
> +	pm_runtime_get_noresume(pfdev->base.dev);
[ ... ]
> @@ -816,18 +920,46 @@ static enum drm_gpu_sched_stat panfrost_job_timedou=
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
> +	 * A slot that is still ACTIVE runs a long job, not a hung one:
> +	 * soft-stop and resume it instead of resetting the GPU.
> +	 */
> +	js_status =3D job_read(pfdev, JS_STATUS(js));
> +	job_active =3D js_status =3D=3D DRM_PANFROST_EXCEPTION_ACTIVE;
> +
> +	/* The job may have completed since the fence check above. */
> +	if (!job_active) {
> +		if (job_read(pfdev, JOB_INT_RAWSTAT) & JOB_INT_MASK_DONE(js))
> +			return DRM_GPU_SCHED_STAT_NO_HANG;
> +
> +		synchronize_irq(pfdev->js->irq);
> +		if (dma_fence_is_signaled(job->done_fence))
> +			return DRM_GPU_SCHED_STAT_NO_HANG;
> +	}
> =20
> -	panfrost_core_dump(job);
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
> -	atomic_set(&pfdev->reset.pending, 1);
> -	panfrost_reset(pfdev, sched_job);
> +		panfrost_core_dump(job);
> +	}
> +
> +	/* Ask for a reset, or only for the stop if no reset is pending. */
> +	if (job_active)
> +		atomic_cmpxchg(&pfdev->reset.pending, 0,
> +			       PANFROST_RESET_STOP_ONLY);
> +	else
> +		atomic_set(&pfdev->reset.pending, 1);
> +	panfrost_reset(pfdev, sched_job, job_active);

[Severity: Medium]
Can the GPU runtime-autosuspend in panfrost_job_timedout() before
panfrost_reset() calls pm_runtime_get_noresume(), causing MMIO accesses on
a powered-off GPU?

CPU0 (timeout worker)             CPU1 (IRQ thread / PM worker)
panfrost_job_timedout()
  js_status =3D job_read(JS_STATUS)
  // reads ACTIVE
                                  panfrost_jm_irq_handler_thread()
                                    panfrost_jm_handle_done()
                                      dma_fence_signal_locked(done_fence)
                                        drm_sched_job_done_cb()
                                          // credit_count -> 0
                                      pm_runtime_put_autosuspend()
                                  ...
                                  // 50 ms autosuspend expires
                                  panfrost_device_runtime_suspend()
                                    panfrost_gpu_power_off()
  panfrost_reset()
    pm_runtime_get_noresume()
    job_write(JOB_INT_MASK, 0)    <-- external abort (GPU powered off)

Job interrupts remain enabled until panfrost_reset() masks JOB_INT_MASK,
and the completion callback on job->done_fence remains attached until
drm_sched_stop().  If the only in-flight job completes right after
JS_STATUS(js) is read as DRM_PANFROST_EXCEPTION_ACTIVE (or faults just
before, setting JOB_INT_MASK_ERR(js) rather than JOB_INT_MASK_DONE(js),
and the IRQ thread finishes while panfrost_core_dump() is copying BOs),
the IRQ handler drops sched->credit_count to 0 and releases the job's
runtime PM reference.  With panfrost_jm_is_idle() now true, runtime
autosuspend can power off the GPU and disable its clocks before
panfrost_reset() is reached, and pm_runtime_get_noresume() only increments
usage_count without resuming the device.

Acquiring the runtime PM reference at the start of panfrost_job_timedout()
(or using pm_runtime_resume_and_get()) before checking the fences and
reading registers would keep the GPU powered throughout the timeout and
reset path.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-panfrost-l=
ong-jobs-v3-0-80ae78d38f6e@gmail.com?part=3D13
