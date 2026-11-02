Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF87606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 19:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FIhjPNlJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C2CE10F19A;
	Mon,  2 Nov 2026 19:18:32 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3200710F19A
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 19:18:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1855E43910;
 Mon,  2 Nov 2026 19:18:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D7D1F00A16;
 Mon,  2 Nov 2026 19:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793647106;
 bh=8OsX6NSmxrYXCkP/8g/puh0myzw+fClNoOwtGEaeXGU=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=FIhjPNlJnzVVCdGTJNxmgrV+A9QT9uIHOFM4EuZAhsZxGDuDm7dZRltgQWPcuitN8
 tADImUz20Nr1HGZhtMR/TWBvHU9M9EszpqvpmPoG3yL9qWjIf8jX46PLOH9AocN9qM
 VV7TgrBzZ1zbUn6WPAUkZ2El6P2ovGLyGTfJD6V1iXHwMOe7NoH+PVSyOjyVIe4aeb
 QF/3gEEnOUom5IE0hcv4BisYQx3LjhKepdjMQMu2SKHH1ojmYhsutjKVa0DSK9Bn4x
 SbPADbHT99VnRy8H8XibegPRqrMUjYSHkWB1nrKx8nLXKoznTnJh5EC3ZMWA8G1zDt
 06coQiC+v8ERA==
Message-ID: <sashiko-outbox-193988@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] drm/msm: Inhibit IFPC for state snapshot
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261102190010.720443-5-robin.clark@oss.qualcomm.com>
References: <20261102190010.720443-1-robin.clark@oss.qualcomm.com>
 <20261102190010.720443-5-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 19:18:25 +0000
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
- [High] drm/msm: premature GMU_OOB_PERFCOUNTER_SET before msm_gpu_hw_init()
- [High] drm/msm/adreno: stale GMU_STATUS_OOB_PERF_SET across a6xx_gmu_forc=
e_off()
- [High] drm/msm: pm_runtime_active outside gpu->lock in msm_gpu_open() blo=
cks recovery
--

commit c139e04b0443554ac873bfd8c98898fb001e8ce3
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Inhibit IFPC for state snapshot

This commit adds an ifpc_disable guard in msm_gpu_open() to keep the GPU
awake while capturing the debugfs GPU state snapshot.

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

[Severity: High]
As reported by Sashiko on v1 [1], can placing guard(ifpc_disable)(gpu)
before msm_gpu_hw_init(gpu) send a premature GMU_OOB_PERFCOUNTER_SET vote
before the initial GMU_OOB_GPU_SET handshake completes?

When msm_gpu_open() is called while the GPU is runtime-suspended,
scoped_guard(pm_runtime_active, &gpu->pdev->dev) invokes
a6xx_gmu_pm_resume(), which sets gpu->needs_hw_init =3D true, boots the GMU
firmware, and transitions &gpu->pdev->dev to RPM_ACTIVE without running
hw_init().

Immediately afterward, guard(ifpc_disable)(gpu) calls:

  msm_gpu_disable_ifpc_get(gpu)
    -> a6xx_gmu_ifpc_update(gpu)
      -> a6xx_gmu_ifpc_update_locked(gpu)

In drivers/gpu/drm/msm/adreno/a6xx_gmu.c:a6xx_gmu_ifpc_update():

	/* Nothing to do if GPU is suspended. We will handle this during GMU resum=
e */
	if (pm_runtime_get_if_active(&gpu->pdev->dev) <=3D 0)
		return;

	scoped_guard (mutex, &gmu->lock)
		a6xx_gmu_ifpc_update_locked(gpu);

Because the outer pm_runtime_active guard already resumed the device,
pm_runtime_get_if_active() succeeds even though gpu->needs_hw_init is still
true. a6xx_gmu_ifpc_update_locked() then sets GMU_STATUS_OOB_PERF_SET in
gmu->status and asserts GMU_OOB_PERFCOUNTER_SET before msm_gpu_hw_init() ->
hw_init() sets and clears GMU_OOB_GPU_SET (and GMU_OOB_BOOT_SLUMBER on
legacy GMUs). If mutex_intr fails with -EINTR, GMU_OOB_PERFCOUNTER_SET is
asserted and cleared without msm_gpu_hw_init() ever running.

Furthermore, when msm_gpu_hw_init() subsequently runs hw_init() in
drivers/gpu/drm/msm/adreno/a6xx_gpu.c:

	a6xx_gmu_clear_oob(&a6xx_gpu->gmu, GMU_OOB_GPU_SET);

	if (a6xx_gpu->gmu.legacy) {
		/* Take the GMU out of its special boot mode */
		a6xx_gmu_clear_oob(&a6xx_gpu->gmu, GMU_OOB_BOOT_SLUMBER);
	}

	a6xx_gmu_ifpc_update_locked(gpu);

test_and_set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status) in
a6xx_gmu_ifpc_update_locked() finds the bit already set and becomes a
no-op instead of asserting GMU_OOB_PERFCOUNTER_SET after GMU_OOB_GPU_SET
is cleared. As noted in commit d34b6919798c ("drm/msm/a6xx: Correct OOB
usage"), issuing GMU_OOB_PERFCOUNTER_SET before the GMU_OOB_GPU_SET
handshake completes confuses the GMU firmware internal power state.

The same sequence also happens in
drivers/gpu/drm/msm/msm_submitqueue.c:msm_context_set_sysprof() when
sysprof =3D=3D 2 wakes a suspended GPU:

	case 2:
		pm_runtime_get_sync(&gpu->pdev->dev);
		fallthrough;
	case 1:
		/* Disable zapping perfcntrs on context switch: */
		refcount_inc(&gpu->sysprof_active);
		/* Disable IFPC: */
		msm_gpu_disable_ifpc_get(gpu);

[Severity: High]
In a related path, can GMU_STATUS_OOB_PERF_SET remain stale across a forced
GMU power-off in a6xx_gmu_force_off() and leave IFPC uninhibited after
recovery?

In drivers/gpu/drm/msm/adreno/a6xx_gmu.c:a6xx_gmu_ifpc_update_locked():

	if (force_on && !test_and_set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status))
		a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
	else if (!force_on && test_and_clear_bit(GMU_STATUS_OOB_PERF_SET, &gmu->st=
atus))
		a6xx_gmu_clear_oob(gmu, GMU_OOB_PERFCOUNTER_SET);

Prior to commit 15aefb4a3ef6 ("drm/msm: Rework IFPC disable"), hw_init() in
a6xx_gpu.c and a8xx_gpu.c unconditionally called a6xx_gmu_set_oob(gmu,
GMU_OOB_PERFCOUNTER_SET) whenever IFPC was disabled, regardless of the
prior state of GMU_STATUS_OOB_PERF_SET. Now hw_init() calls
a6xx_gmu_ifpc_update_locked(gpu), which skips a6xx_gmu_set_oob() if
GMU_STATUS_OOB_PERF_SET is already set.

However, GMU_STATUS_OOB_PERF_SET is only cleared on the graceful shutdown
path in a6xx_gmu_shutdown(). When a6xx_gmu_stop() takes the gmu->hung
branch to a6xx_gmu_force_off(gmu), or when a6xx_gmu_shutdown() jumps to
force_off on an OOB failure, a6xx_gmu_force_off() and a6xx_rpmh_stop()
clear GMU_STATUS_FW_START but do not clear GMU_STATUS_OOB_PERF_SET:

	/* Reset GPU core blocks */
	a6xx_gpu_sw_reset(gpu, true);

	a6xx_rpmh_stop(gmu);

If a hang recovery or forced GMU shutdown occurs while gpu->ifpc_disable > =
1,
won't GMU_STATUS_OOB_PERF_SET stay set in gmu->status across the hardware
reset, causing a6xx_gmu_ifpc_update_locked() in hw_init() to skip
re-asserting GMU_OOB_PERFCOUNTER_SET on the restarted GMU?

> +
>  		scoped_cond_guard (mutex_intr, return -EINTR, &gpu->lock) {
>  			msm_gpu_hw_init(gpu);
>  			show_priv->state =3D gpu->funcs->gpu_state_get(gpu);

[Severity: High]
Does holding pm_runtime_active outside gpu->lock in msm_gpu_open() prevent
the GPU from suspending during hang recovery in a6xx_recover() and
a8xx_recover()?

Prior to commit 8504c24acea0 ("drm/msm/debugfs: Use cleanup.h for gpu state
dump"), msm_gpu_open() acquired gpu->lock first and called
pm_runtime_get_sync() and pm_runtime_put_sync() inside gpu->lock. With
scoped_guard(pm_runtime_active, &gpu->pdev->dev) outside
scoped_cond_guard(mutex_intr, return -EINTR, &gpu->lock), msm_gpu_open()
acquires an active runtime PM reference before waiting on gpu->lock and
releases it asynchronously via pm_runtime_put() after unlocking gpu->lock.

During hang recovery, recover_worker() holds gpu->lock and calls
a6xx_recover() (or a8xx_recover()), which drops its runtime PM references
expecting the device usage count to reach zero so the GMU suspends and the
CX GDSC collapses:

	/* Drop the rpm refcount from active submits */
	if (active_submits)
		pm_runtime_put(&gpu->pdev->dev);

	/* And the final one from recover worker */
	pm_runtime_put_sync(&gpu->pdev->dev);

	if (!wait_for_completion_timeout(&gmu->pd_gate, msecs_to_jiffies(1000)))
		DRM_DEV_ERROR(&gpu->pdev->dev, "cx gdsc didn't collapse\n");

If a user or debugging tool opens the debugfs gpu file while
recover_worker() holds gpu->lock (or right before recover_worker() takes
gpu->lock while the asynchronous pm_runtime_put() from msm_gpu_open() is
still pending), won't the extra runtime PM reference keep the usage count
above zero, causing gmu->pd_gate to time out with "cx gdsc didn't collapse"
and leaving gpu->needs_hw_init false so msm_gpu_hw_init() skips
re-initializing the hung GPU?

[1] https://lore.kernel.org/r/20261101174631.23637-5-robin.clark@oss.qualco=
mm.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102190010.7204=
43-1-robin.clark@oss.qualcomm.com?part=3D4
