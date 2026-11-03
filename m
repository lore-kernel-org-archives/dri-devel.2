Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A238F606A31B
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 19:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hihy9oFv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C42B10E817;
	Tue,  3 Nov 2026 19:05:35 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4721410E817
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 19:05:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0CA0140366;
 Tue,  3 Nov 2026 19:05:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C77E81F00A02;
 Tue,  3 Nov 2026 19:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793732728;
 bh=STG4BVKcuyUcccvKnTIevFlpwHicgSqU1AO2UIRjIfg=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=hihy9oFvQ13cUoG1g3xZUyLTgxmfsB4Ecktw4BzgL3vcjg5reN+Vu46QxHDYu+Kcj
 zNJUbIpRA7X4hJfcNhipK26hNL0GYUeVySWfwYLLDiPCdVQnw9Z2vNGVZwRyLRopEP
 pxEQnJxUe+PjnpseEPitZZ8tQs90qOO/j34LMGz9Fj7/4LIXoSeKlMAr0XpDHu0cOe
 0rnzVT1rqFmu3tmq1Q3Xu2fOQJp5MGI/bC/Ktcvp0Mmwq0FW7QqHSQolWjzZB99dqK
 zYMLWnYj2Ovh8Mbw1rXtDmp9o3xdDp1IdHQkInXG1oVdysbYrjdYe3iqwKtZwN+U/M
 AyEXDGALeKtZA==
Message-ID: <sashiko-outbox-195878@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] drm/msm: Inhibit IFPC for state snapshot
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261103184713.29664-5-robin.clark@oss.qualcomm.com>
References: <20261103184713.29664-1-robin.clark@oss.qualcomm.com>
 <20261103184713.29664-5-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 19:05:28 +0000
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] drm/msm: unclocked GMU access in a6xx_gmu_ifpc_update() via sysprof
- [High] drm/msm: lost IFPC-disable OOB vote across a6xx_gmu_shutdown()
- [High] drm/msm: pm_runtime_active outside gpu->lock in msm_gpu_open()
- [High] drm/msm: deadlock in sample_worker() acquiring gpu->lock
--

commit 71b418eb7a2a4bb66905b18dff6e35ba01475fcd
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Inhibit IFPC for state snapshot

This commit adds an ifpc_disable guard in msm_gpu_open() so that IFPC is
inhibited while taking a GPU state snapshot via debugfs.

> diff --git a/drivers/gpu/drm/msm/msm_debugfs.c b/drivers/gpu/drm/msm/msm_=
debugfs.c
> index 9373ac19ee953..89d5c52e04678 100644
> --- a/drivers/gpu/drm/msm/msm_debugfs.c
> +++ b/drivers/gpu/drm/msm/msm_debugfs.c
> @@ -81,6 +81,8 @@ static int msm_gpu_open(struct inode *inode, struct fil=
e *file)
>  		return -ENOMEM;
> =20
>  	scoped_guard (pm_runtime_active, &gpu->pdev->dev) {
> +		guard(ifpc_disable)(gpu);
> +
>  		scoped_cond_guard (mutex_intr, return -EINTR, &gpu->lock) {
>  			msm_gpu_hw_init(gpu);
>  			show_priv->state =3D gpu->funcs->gpu_state_get(gpu);

[Severity: High]
As reported by Sashiko on v2 [1], in msm_gpu_open(), acquiring
pm_runtime_active and guard(ifpc_disable)(gpu) outside the mutex_intr guard=
 on
gpu->lock appears to introduce a couple of issues.

First, guard(ifpc_disable)(gpu) calls msm_gpu_disable_ifpc_get() ->
a6xx_gmu_ifpc_update(), which acquires gpu->lock uninterruptibly via
guard(mutex)(&gpu->lock). Doesn't that defeat the subsequent mutex_intr gua=
rd
in msm_gpu_open() and acquire and release gpu->lock three separate times?

Second, during GPU hang recovery, recover_worker() holds gpu->lock and calls
a6xx_recover() or a8xx_recover(), which expects to drop all runtime PM
references on &gpu->pdev->dev so that runtime suspend collapses the CX GDSC:

drivers/gpu/drm/msm/adreno/a6xx_gpu.c:a6xx_recover() {
    ...
	/* Drop the rpm refcount from active submits */
	if (active_submits)
		pm_runtime_put(&gpu->pdev->dev);

	/* And the final one from recover worker */
	pm_runtime_put_sync(&gpu->pdev->dev);

	if (!wait_for_completion_timeout(&gmu->pd_gate, msecs_to_jiffies(1000)))
		DRM_DEV_ERROR(&gpu->pdev->dev, "cx gdsc didn't collapse\n");
    ...
}

If a concurrent msm_gpu_open() acquires pm_runtime_active before waiting on
gpu->lock (or releases it asynchronously via pm_runtime_put() after dropping
gpu->lock), won't that prevent runtime suspend during recovery, causing
gmu->pd_gate to time out and leaving gpu->needs_hw_init false when
msm_gpu_hw_init(gpu) is called?

[Severity: High]
Also looking at the underlying ifpc_disable implementation that
guard(ifpc_disable)(gpu) invokes in a6xx_gmu_ifpc_update(), can
msm_context_set_sysprof() access unclocked GMU registers when the GPU is
runtime-suspended?

In drivers/gpu/drm/msm/adreno/a6xx_gmu.c, a6xx_gmu_ifpc_update() requires t=
he
caller to hold a runtime PM reference and accesses GMU registers whenever
!gpu->needs_hw_init is true:

drivers/gpu/drm/msm/adreno/a6xx_gmu.c:a6xx_gmu_ifpc_update() {
	/* Caller must hold a runpm ref: */
	drm_WARN_ON_ONCE(gpu->dev, pm_runtime_status_suspended(&gpu->pdev->dev));

	guard(mutex)(&gpu->lock);
	guard(mutex)(&gmu->lock);

	bool ifpc_disable =3D refcount_read(&gpu->ifpc_disable) > 1;

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

However, in drivers/gpu/drm/msm/msm_submitqueue.c, msm_context_set_sysprof()
only takes a runtime PM reference for case 2, not case 1, and when unwinding
case 2 it calls pm_runtime_put_autosuspend() before falling through to call
msm_gpu_disable_ifpc_put():

drivers/gpu/drm/msm/msm_submitqueue.c:msm_context_set_sysprof() {
    ...
	switch (sysprof) {
	default:
		return -EINVAL;
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

On A6xx, A7xx, and A8xx, gpu->needs_hw_init is set to true in
a6xx_gmu_pm_resume() and a6xx_pm_resume(), not in a6xx_gmu_pm_suspend(). On=
ce
the GPU has initialized at least once and entered runtime suspend,
gpu->needs_hw_init remains false while the GMU is powered off. If userspace
sets sysprof to 1 or closes the context while the GPU is runtime-suspended,
won't a6xx_gmu_ifpc_update() trigger drm_WARN_ON_ONCE and perform unclocked
MMIO accesses in a6xx_gmu_set_oob() or a6xx_gmu_clear_oob()?

In addition, if a6xx_gmu_ifpc_update() sets GMU_STATUS_OOB_PERF_SET while
gpu->needs_hw_init is true (after runtime resume but before msm_gpu_hw_init=
()
runs) and the GPU then suspends via a6xx_gmu_shutdown() without ever calling
msm_gpu_hw_init(), won't a6xx_gmu_shutdown() call
a6xx_gmu_clear_oob(gmu, GMU_OOB_PERFCOUNTER_SET) even though
GMU_OOB_PERFCOUNTER_SET was never asserted in hardware?

[Severity: High]
Does a6xx_gmu_shutdown() also cause the IFPC-disable OOB vote to be lost ac=
ross
a GMU suspend/resume cycle?

In drivers/gpu/drm/msm/adreno/a6xx_gmu.c, a6xx_gmu_shutdown() clears
GMU_STATUS_OOB_PERF_SET from gmu->status when shutting down the GMU:

drivers/gpu/drm/msm/adreno/a6xx_gmu.c:a6xx_gmu_shutdown() {
    ...
	if (test_and_clear_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status))
		a6xx_gmu_clear_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
    ...
}

When the GPU later resumes and runs msm_gpu_hw_init() -> hw_init() in
drivers/gpu/drm/msm/adreno/a6xx_gpu.c and
drivers/gpu/drm/msm/adreno/a8xx_gpu.c, hw_init() checks
GMU_STATUS_OOB_PERF_SET to decide whether to re-apply the OOB request:

drivers/gpu/drm/msm/adreno/a6xx_gpu.c:hw_init() {
    ...
	/* re-apply IFPC-disable OOB request, if needed: */
	if (!ret && test_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status)) {
		ret =3D a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
	}
    ...
}

Since a6xx_gmu_shutdown() cleared GMU_STATUS_OOB_PERF_SET, won't hw_init()
skip re-applying GMU_OOB_PERFCOUNTER_SET on resume even when
refcount_read(&gpu->ifpc_disable) > 1?

[Severity: High]
Finally, can acquiring gpu->lock inside a6xx_gmu_ifpc_update() deadlock with
performance counter sampling in sample_worker()?

In drivers/gpu/drm/msm/msm_perfcntr.c, sample_worker() uses
guard(ifpc_disable)(gpu), which now acquires gpu->lock via
a6xx_gmu_ifpc_update(). Meanwhile, msm_perfcntr_suspend_locked() is called
under gpu->perfcntr_lock (from msm_perfcntr_suspend() and
msm_perfcntrs_stream_release()) and synchronously cancels sample_work:

drivers/gpu/drm/msm/msm_perfcntr.c:msm_perfcntr_suspend_locked() {
    ...
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

Because sample_worker() now acquires gpu->lock, doesn't
kthread_cancel_work_sync(&stream->sample_work) in
msm_perfcntr_suspend_locked() hit the exact same two deadlock conditions
described in the comment for sel_work (inverting gpu->perfcntr_lock and
gpu->lock relative to sel_worker(), or blocking on gpu->lock when synchrono=
us
runtime suspend is triggered while gpu->lock is already held)?

[1] https://lore.kernel.org/r/20261102190010.720443-5-robin.clark@oss.qualc=
omm.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103184713.2966=
4-1-robin.clark@oss.qualcomm.com?part=3D4
