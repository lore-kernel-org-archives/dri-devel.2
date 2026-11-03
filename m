Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DB9606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 19:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZUYbC5SU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B55410F78B;
	Tue,  3 Nov 2026 19:03:19 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0663D10E817
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 19:03:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8F6EB4162E;
 Tue,  3 Nov 2026 19:03:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A2E1F00919;
 Tue,  3 Nov 2026 19:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793732592;
 bh=K5Sc7Nl7UHpxK9Yqpj8PjB6COii8tMRlRK8QVv6539k=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=ZUYbC5SURyu148WHNv33/G0+Y5FrG4W6Gof/mw/FSXZszcx4JjCNpIcGxhsow96cV
 sFjWmRS2WIshs/mP3j8LgQ28AD/yuf8IOtjDJ+9OkTMlvdqH1E/SPKwcbgn6rZF5P9
 fBqmZLHVS8I8EB7QcATx2vTJRhe0ifUbokkOOnjqYq7SdDbq3/W/NZzDBxUK11a0vp
 4qr/a59mCLXOAqjPhScge3WuJ0g0TlQ1DSOZr4ugkhqAW/fZgp9BXiGicDiYaEpd4q
 Rfk+yZYYouC8gPQyfesApMzMLYt34Koa+ZhocSbhvvKFgiIRduJHeacLB/cZ0VjWr4
 oKQIcFxLreA2w==
Message-ID: <sashiko-outbox-195875@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] drm/msm: Add cleanup help for disabling IFPC
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261103184713.29664-3-robin.clark@oss.qualcomm.com>
References: <20261103184713.29664-1-robin.clark@oss.qualcomm.com>
 <20261103184713.29664-3-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 19:03:11 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] drm/msm: deadlock on gpu->lock in sample_worker() via guard(ifpc_d=
isable)
- [High] drm/msm: unclocked GMU access in msm_context_set_sysprof() when su=
spended
- [Medium] drm/msm: IFPC-disable OOB state lost across suspend in a6xx_gmu_=
shutdown()
--

commit 9050e0e5968aa8a31885cced8f55edd75166ae58
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Add cleanup help for disabling IFPC

This commit adds a cleanup guard helper for disabling IFPC via
msm_gpu_disable_ifpc_get() and msm_gpu_disable_ifpc_put(), and converts
sample_worker() in msm_perfcntr.c to use guard(ifpc_disable).

> diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
> index 0334a0f604ac1..e7912d2180a51 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.h
> +++ b/drivers/gpu/drm/msm/msm_gpu.h
> @@ -399,6 +399,10 @@ msm_gpu_disable_ifpc_put(struct msm_gpu *gpu)
>  		gpu->funcs->ifpc_update(gpu);
>  }
> =20
> +DEFINE_GUARD(ifpc_disable, struct msm_gpu *,
> +	     msm_gpu_disable_ifpc_get(_T),
> +	     msm_gpu_disable_ifpc_put(_T))

[Severity: High]
Can calling msm_gpu_disable_ifpc_get() and msm_gpu_disable_ifpc_put() from
msm_context_set_sysprof() access unclocked GMU registers when the GPU is
runtime-suspended?

In drivers/gpu/drm/msm/msm_submitqueue.c, msm_context_set_sysprof() (called
from adreno_set_param() via MSM_PARAM_SYSPROF and from msm_postclose() when
closing the DRM file) only acquires a runtime PM reference in case 2, and
drops it in case 2 before calling msm_gpu_disable_ifpc_put() when unwinding:

drivers/gpu/drm/msm/msm_submitqueue.c:msm_context_set_sysprof() {
	switch (sysprof) {
	default:
		return UERR(EINVAL, gpu->dev, "Invalid sysprof: %d", sysprof);
	case 2:
		pm_runtime_get_sync(&gpu->pdev->dev);
		fallthrough;
	case 1:
		/* Disable zapping perfcntrs on context switch: */
		refcount_inc(&gpu->sysprof_active);
		/* Disable IFPC: */
		msm_gpu_disable_ifpc_get(gpu);
		fallthrough;
	case 0:
		break;
	}

	/* unwind old value: */
	switch (ctx->sysprof) {
	case 2:
		pm_runtime_put_autosuspend(&gpu->pdev->dev);
		fallthrough;
	case 1:
		/* Drop our vote for inhibiting IFPC: */
		msm_gpu_disable_ifpc_put(gpu);
    ...
}

Both helpers call gpu->funcs->ifpc_update(gpu) -> a6xx_gmu_ifpc_update(gpu)
in drivers/gpu/drm/msm/adreno/a6xx_gmu.c:

drivers/gpu/drm/msm/adreno/a6xx_gmu.c:a6xx_gmu_ifpc_update() {
	/* Caller must hold a runpm ref: */
	drm_WARN_ON_ONCE(gpu->dev, pm_runtime_status_suspended(&gpu->pdev->dev));
    ...
	if (ifpc_disable && !test_and_set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->statu=
s)) {
		if (!gpu->needs_hw_init)
			a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
	} else if (!ifpc_disable && test_and_clear_bit(GMU_STATUS_OOB_PERF_SET, &g=
mu->status)) {
		if (!gpu->needs_hw_init)
			a6xx_gmu_clear_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
	}
}

Because gpu->needs_hw_init is only set to true at the start of
a6xx_gmu_pm_resume() and a6xx_pm_resume() in
drivers/gpu/drm/msm/adreno/a6xx_gpu.c (and is not set during runtime
suspend), once the GPU has initialized and later entered runtime suspend,
gpu->needs_hw_init remains false while GMU clocks and power domains are off.

When sysprof is set to 1 (or unwound from 1 or 2) while the GPU is
runtime-suspended, won't a6xx_gmu_ifpc_update() trigger the
drm_WARN_ON_ONCE() and call a6xx_gmu_set_oob() or a6xx_gmu_clear_oob() on
powered-off GMU registers?

[Severity: Medium]
Also in the IFPC disable tracking, does GMU_STATUS_OOB_PERF_SET get lost
across GMU suspend and recovery?

During GMU shutdown (a6xx_gmu_pm_suspend() -> a6xx_gmu_stop() ->
a6xx_gmu_shutdown()), a6xx_gmu_shutdown() in
drivers/gpu/drm/msm/adreno/a6xx_gmu.c clears GMU_STATUS_OOB_PERF_SET:

drivers/gpu/drm/msm/adreno/a6xx_gmu.c:a6xx_gmu_shutdown() {
    ...
	if (test_and_clear_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status))
		a6xx_gmu_clear_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
    ...
}

However, hw_init() in both drivers/gpu/drm/msm/adreno/a6xx_gpu.c and
drivers/gpu/drm/msm/adreno/a8xx_gpu.c checks GMU_STATUS_OOB_PERF_SET to
decide whether to re-apply the OOB request on resume:

	/* re-apply IFPC-disable OOB request, if needed: */
	if (!ret && test_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status)) {
		ret =3D a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
	}

Since a6xx_gmu_shutdown() cleared GMU_STATUS_OOB_PERF_SET when stopping the
GMU, won't hw_init() see GMU_STATUS_OOB_PERF_SET as cleared on resume and
fail to re-apply GMU_OOB_PERFCOUNTER_SET even when
refcount_read(&gpu->ifpc_disable) > 1?

[ ... ]

> diff --git a/drivers/gpu/drm/msm/msm_perfcntr.c b/drivers/gpu/drm/msm/msm=
_perfcntr.c
> index bf73752dac3de..0d33f0eae35d7 100644
> --- a/drivers/gpu/drm/msm/msm_perfcntr.c
> +++ b/drivers/gpu/drm/msm/msm_perfcntr.c
> @@ -259,7 +259,7 @@ sample_worker(struct kthread_work *work)
>  	}
> =20
>  	/* Inhibit IFPC while accessing registers: */
> -	msm_gpu_disable_ifpc_get(gpu);
> +	guard(ifpc_disable)(gpu);

[Severity: High]
Could calling guard(ifpc_disable)(gpu) in sample_worker() deadlock on
gpu->lock against msm_perfcntr_suspend_locked()?

Here guard(ifpc_disable)(gpu) calls msm_gpu_disable_ifpc_get(gpu) on entry
and msm_gpu_disable_ifpc_put(gpu) on scope exit, both of which invoke
gpu->funcs->ifpc_update(gpu) -> a6xx_gmu_ifpc_update(gpu) and acquire
gpu->lock:

drivers/gpu/drm/msm/adreno/a6xx_gmu.c:a6xx_gmu_ifpc_update() {
    ...
	guard(mutex)(&gpu->lock);
	guard(mutex)(&gmu->lock);
    ...
}

Meanwhile, msm_perfcntr_suspend_locked() in
drivers/gpu/drm/msm/msm_perfcntr.c (called with gpu->perfcntr_lock held from
msm_perfcntr_suspend() and msm_perfcntrs_stream_release()) waits
synchronously for sample_work:

drivers/gpu/drm/msm/msm_perfcntr.c:msm_perfcntr_suspend_locked() {
	if (!stream)
		return;

	hrtimer_cancel(&stream->sample_timer);
	kthread_cancel_work_sync(&stream->sample_work);

	/*
	 * We can't use cancel_work_sync() here, since sel_work acquires
	 * gpu->lock which (a) in suspend path can already be held, or
	 * (b) in release path would invert the order of gpu->lock and
	 * gpu->perfcntr_lock.  Either would cause deadlock.
	 */
	cancel_work(&stream->sel_work);
    ...
}

As explained in the comment for sel_work, synchronously canceling a worker
here that acquires gpu->lock appears to hit both deadlock scenarios:

1. Lock order inversion between gpu->lock and gpu->perfcntr_lock:
sel_worker() in drivers/gpu/drm/msm/msm_perfcntr.c and recover_worker() ->
adreno_recover() -> msm_perfcntr_suspend() acquire gpu->lock before
gpu->perfcntr_lock:

drivers/gpu/drm/msm/msm_perfcntr.c:sel_worker() {
    ...
	scoped_guard (mutex, &gpu->lock) {
		guard(mutex)(&gpu->perfcntr_lock);
    ...
}

If msm_perfcntrs_stream_release() or msm_perfcntr_suspend() holds
gpu->perfcntr_lock and blocks in kthread_cancel_work_sync(&stream->sample_w=
ork)
while sample_worker() is waiting for gpu->lock in a6xx_gmu_ifpc_update(), a
concurrent thread holding gpu->lock and waiting for gpu->perfcntr_lock will
deadlock.

2. Runtime suspend while gpu->lock is held: paths that hold gpu->lock across
pm_runtime_put_sync(&gpu->pdev->dev) (such as
msm_gpu_fault_crashstate_capture() in drivers/gpu/drm/msm/msm_gpu.c), or a
concurrent msm_job_run() -> msm_gpu_submit() holding gpu->lock while waiting
in pm_runtime_get_sync(&gpu->pdev->dev) for an in-progress
adreno_runtime_suspend() -> msm_perfcntr_suspend() ->
kthread_cancel_work_sync(&stream->sample_work) to finish, will block forever
when sample_worker() tries to acquire gpu->lock in a6xx_gmu_ifpc_update().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103184713.2966=
4-1-robin.clark@oss.qualcomm.com?part=3D2
