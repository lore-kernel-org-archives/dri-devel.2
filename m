Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D168606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 18:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CS7nn0tw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBF2810E3D5;
	Sun,  1 Nov 2026 18:09:24 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B89610E3D5
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 18:09:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E293F4321D;
 Sun,  1 Nov 2026 18:09:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0941F000C1;
 Sun,  1 Nov 2026 18:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793556558;
 bh=FIjQhGFd7D8dZlgO2ylp6DfM1gUs2KPi3lY/6H4QrMw=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=CS7nn0twu0VzQufRrfk4VL/usWKGXJrw3B+YMwGVkGgTmZI3IbZcSz9EzU810/+mf
 WS5X9WsUXfNf6vfDcS1BvGduvyEka6WGOFWefeUmNucNRCbJid30ZOdl5LgusBzRjb
 QGygvtwLrKMuvwTfuNILWIaZVY3gHW6CEH82z0ABg1XcygNFurQjBrUyJ69zLnD/3J
 sW5e87502vOFlKKdf4iAq7o5g4nF1fxNaa92xRHLATqsmG63C8HHI872iWG22v8pHu
 KS6KYcEmOQ52ggwWPun4Lv/pDg5InveXouoT2EE2T3ft6kXXk1ZzmVd5TsgJnYBaoS
 y2gG4wRr8Fang==
Message-ID: <sashiko-outbox-192560@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] drm/msm: Inhibit IFPC for state snapshot
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261101174631.23637-5-robin.clark@oss.qualcomm.com>
References: <20261101174631.23637-1-robin.clark@oss.qualcomm.com>
 <20261101174631.23637-5-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 18:09:18 +0000
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
- [High] drm/msm: self-deadlock on gmu.lock in a6xx_hw_init() via a6xx_gmu_=
ifpc_update()
- [High] drm/msm: TOCTOU race on gpu->ifpc_disable in a6xx_gmu_ifpc_update()
- [High] drm/msm: premature GMU_OOB_PERFCOUNTER_SET before hw_init() in msm=
_gpu_open()
- [Medium] drm/msm/a8xx: hw_init() still checks msm_gpu_sysprof_no_perfcntr=
_zap()
--

commit 468ea56ed27402560d02d77cd1b25b3b9b6a8ecd
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Inhibit IFPC for state snapshot

This commit adds an ifpc_disable guard in msm_gpu_open() while capturing a
GPU state snapshot via debugfs so that IFPC remains inhibited while GPU
registers are read.

> diff --git a/drivers/gpu/drm/msm/msm_debugfs.c b/drivers/gpu/drm/msm/msm_=
debugfs.c
> index e1b872576c7b1..14b588aeeb562 100644
> --- a/drivers/gpu/drm/msm/msm_debugfs.c
> +++ b/drivers/gpu/drm/msm/msm_debugfs.c
> @@ -81,6 +81,8 @@ static int msm_gpu_open(struct inode *inode, struct fil=
e *file)
>  		return -ENOMEM;
> =20
>  	scoped_guard (pm_runtime_active, &gpu->pdev->dev) {
> +		guard(ifpc_disable)(gpu);

[Severity: High]
Could acquiring guard(ifpc_disable)(gpu) here send GMU_OOB_PERFCOUNTER_SET
to the GMU before msm_gpu_hw_init() completes the GMU_OOB_GPU_SET boot
handshake?

When msm_gpu_open() is called while the GPU is runtime-suspended,
scoped_guard(pm_runtime_active, &gpu->pdev->dev) resumes the device via:

  pm_runtime_get_sync()
    -> adreno_runtime_resume()
      -> a6xx_gmu_pm_resume()

which sets gpu->needs_hw_init =3D true and boots the GMU without performing
the GMU_OOB_GPU_SET handshake (deferred until msm_gpu_hw_init()). Once
adreno_runtime_resume() returns, &gpu->pdev->dev is marked RPM_ACTIVE.

Next, guard(ifpc_disable)(gpu) runs before gpu->lock is acquired and before
msm_gpu_hw_init(gpu) is called:

  msm_gpu_disable_ifpc_get(gpu)
    -> a6xx_gmu_ifpc_update(gpu)

In drivers/gpu/drm/msm/adreno/a6xx_gmu.c:a6xx_gmu_ifpc_update():

	/* Nothing to do if GPU is suspended. We will handle this during GMU resum=
e */
	if (!pm_runtime_get_if_active(&gpu->pdev->dev))
		return;

	mutex_lock(&gmu->lock);

	if (force_on && !test_and_set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status))
		a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET);

Because &gpu->pdev->dev is already RPM_ACTIVE and gpu->needs_hw_init is not
checked, a6xx_gmu_ifpc_update() sets GMU_STATUS_OOB_PERF_SET in gmu->status
and sends GMU_OOB_PERFCOUNTER_SET to the GMU before hw_init() performs the
GMU_OOB_GPU_SET (and GMU_OOB_BOOT_SLUMBER) handshake.

As noted in commit d34b6919798c ("drm/msm/a6xx: Correct OOB usage"), sending
another OOB request such as GMU_OOB_PERFCOUNTER_SET during the GMU resume
sequence before GMU_OOB_GPU_SET is set and cleared confuses the internal
power state of the GMU firmware. In addition, because
GMU_STATUS_OOB_PERF_SET is already set in gmu->status prior to hw_init(),
the subsequent a6xx_gmu_ifpc_update() call in hw_init() sees
test_and_set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status) as already set and
does not re-assert GMU_OOB_PERFCOUNTER_SET after GMU_OOB_GPU_SET is cleared.
And if scoped_cond_guard(mutex_intr, ..., &gpu->lock) fails with -EINTR,
msm_gpu_hw_init(gpu) does not run at all after GMU_OOB_PERFCOUNTER_SET was
already set and cleared on the uninitialized GMU.

[Severity: High]
Is there also a TOCTOU race in a6xx_gmu_ifpc_update() when sampling
gpu->ifpc_disable outside gmu->lock?

Because msm_gpu_open() acquires and releases guard(ifpc_disable)(gpu)
outside gpu->lock, msm_gpu_disable_ifpc_get() and msm_gpu_disable_ifpc_put()
can run concurrently across msm_gpu_open(), sample_worker() in
drivers/gpu/drm/msm/msm_perfcntr.c, and msm_context_set_sysprof() in
drivers/gpu/drm/msm/msm_submitqueue.c without a shared lock.

In drivers/gpu/drm/msm/adreno/a6xx_gmu.c:a6xx_gmu_ifpc_update(), force_on is
evaluated before pm_runtime_get_if_active() and before mutex_lock(&gmu->loc=
k):

void a6xx_gmu_ifpc_update(struct msm_gpu *gpu)
{
	struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
	struct a6xx_gpu *a6xx_gpu =3D to_a6xx_gpu(adreno_gpu);
	struct a6xx_gmu *gmu =3D &a6xx_gpu->gmu;
	bool force_on =3D refcount_read(&gpu->ifpc_disable) > 1;

	/* Nothing to do if GPU is suspended. We will handle this during GMU resum=
e */
	if (!pm_runtime_get_if_active(&gpu->pdev->dev))
		return;

	mutex_lock(&gmu->lock);

	if (force_on && !test_and_set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status))
		a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
	else if (!force_on && test_and_clear_bit(GMU_STATUS_OOB_PERF_SET, &gmu->st=
atus))
		a6xx_gmu_clear_oob(gmu, GMU_OOB_PERFCOUNTER_SET);

If Thread A calls msm_gpu_disable_ifpc_put(gpu), decrements
gpu->ifpc_disable from 2 to 1, and reads force_on =3D false before acquiring
gmu->lock, Thread B (such as msm_gpu_open()) can concurrently call
msm_gpu_disable_ifpc_get(gpu), increment gpu->ifpc_disable from 1 to 2, read
force_on =3D true, acquire gmu->lock first, see GMU_STATUS_OOB_PERF_SET
already set, unlock gmu->lock, and begin reading GX registers in
gpu_state_get(). Thread A then acquires gmu->lock with its stale
force_on =3D=3D false and clears GMU_STATUS_OOB_PERF_SET and
GMU_OOB_PERFCOUNTER_SET while Thread B holds an active ifpc_disable vote
(or conversely, a stale force_on =3D=3D true can leave IFPC permanently
disabled after the last voter drops its reference).

Should force_on be evaluated after acquiring gmu->lock?

> +
>  		scoped_cond_guard (mutex_intr, return PTR_ERR(scope.lock), &gpu->lock)=
 {
>  			msm_gpu_hw_init(gpu);

[Severity: High]
Won't calling msm_gpu_hw_init(gpu) when gpu->needs_hw_init is true
self-deadlock on a6xx_gpu->gmu.lock on GMU-based A6xx and A7xx platforms?

During msm_gpu_hw_init(gpu) (whether called from msm_gpu_open(),
adreno_load_gpu(), msm_gpu_submit(), sel_worker(), or a6xx_recover()),
&gpu->pdev->dev is runtime-active (RPM_ACTIVE). On A6xx and A7xx,
msm_gpu_hw_init() calls a6xx_hw_init() in
drivers/gpu/drm/msm/adreno/a6xx_gpu.c:

static int a6xx_hw_init(struct msm_gpu *gpu)
{
	struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
	struct a6xx_gpu *a6xx_gpu =3D to_a6xx_gpu(adreno_gpu);
	int ret;

	mutex_lock(&a6xx_gpu->gmu.lock);
	ret =3D hw_init(gpu);
	mutex_unlock(&a6xx_gpu->gmu.lock);

At the end of hw_init(gpu) in drivers/gpu/drm/msm/adreno/a6xx_gpu.c,
a6xx_gmu_ifpc_update(gpu) is called unconditionally while
a6xx_gpu->gmu.lock is held (including when an earlier step jumps to the
out: label with a non-zero ret):

out:
	...
	a6xx_gmu_ifpc_update(gpu);

	return ret;
}

Inside drivers/gpu/drm/msm/adreno/a6xx_gmu.c:a6xx_gmu_ifpc_update(),
pm_runtime_get_if_active(&gpu->pdev->dev) returns 1 because the device is
RPM_ACTIVE, and mutex_lock(&gmu->lock) attempts to acquire the same
a6xx_gpu->gmu.lock already held by a6xx_hw_init() while gpu->lock is held
and gpu->irq is disabled.

[Severity: Medium]
On A8xx GPUs, was drivers/gpu/drm/msm/adreno/a8xx_gpu.c:hw_init() missed
when converting IFPC inhibition from msm_gpu_sysprof_no_ifpc() to
gpu->ifpc_disable?

In drivers/gpu/drm/msm/adreno/a6xx_gpu.c, a8xx_gpu_funcs sets:

		.progress =3D a8xx_progress,
		.ifpc_update =3D a6xx_gmu_ifpc_update,
		.perfcntr_configure =3D a6xx_perfcntr_configure,

which manages GMU_OOB_PERFCOUNTER_SET and GMU_STATUS_OOB_PERF_SET based on
refcount_read(&gpu->ifpc_disable) > 1. However, in
drivers/gpu/drm/msm/adreno/a8xx_gpu.c:hw_init(), the code still checks
msm_gpu_sysprof_no_perfcntr_zap(gpu) instead of gpu->ifpc_disable:

	if (!ret && msm_gpu_sysprof_no_perfcntr_zap(gpu)) {
		ret =3D a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
		if (!ret)
			set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status);
	}

Doesn't this cause three mismatches on A8xx when msm_gpu_hw_init() runs:
first, if a global perfcntr stream is active (gpu->perfcntrs->stream !=3D N=
ULL)
while gpu->ifpc_disable =3D=3D 1, hw_init() sets GMU_OOB_PERFCOUNTER_SET and
GMU_STATUS_OOB_PERF_SET even though no continuous IFPC disable vote is held;
second, if gpu->ifpc_disable > 1 (such as from guard(ifpc_disable)(gpu) in
msm_gpu_open()) while neither sysprof_active > 1 nor perfcntrs->stream is
set, hw_init() will not assert GMU_OOB_PERFCOUNTER_SET after clearing
GMU_OOB_GPU_SET; and third, if GMU_STATUS_OOB_PERF_SET was already set by
a6xx_gmu_ifpc_update() before a8xx_hw_init(), hw_init() calls
a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET) a second time without
checking GMU_STATUS_OOB_PERF_SET?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101174631.2363=
7-1-robin.clark@oss.qualcomm.com?part=3D4
