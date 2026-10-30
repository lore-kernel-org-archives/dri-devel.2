Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCC7606A333
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y4x1V+MH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51FBB10E260;
	Fri, 30 Oct 2026 21:38:24 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8593310E291
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:38:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 81C7C609D0;
 Fri, 30 Oct 2026 21:38:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 128F81F000C1;
 Fri, 30 Oct 2026 21:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793396297;
 bh=4r83b8bKxz38jjuc81F/8EzX+49a9TPo+aCKEYcLO3Q=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=Y4x1V+MHMwgw3KE0Cz0n0KT76pzDTfR5zTByAEK3t4Y1WzAhbZ2npAs8jfG64JF9O
 OXpz/AxZBNxTkOteWMfYIrsKwJNgCpSdWkKbk2eo1lp6ng/S06zipGSzPNMOPiMOnb
 3b0cerprsF9ayoAoVSzz4HuAAJ0UykJLUGJCL4HjGlQ/aL0kKu15RgZBrRGpoudgxG
 cd9eCd7c6HG3G34Ug02VmOTVKem5vNAAdsiURPKopD+BLUndaNBKNn72rt5MhXPV1C
 3b0rqHsxvf6V/Xu5heT+Ao1oZsksdrXprrJzGRgag4hxaE5HJf/Q5iutmMT5jteL5K
 fpONIywP/spAw==
Message-ID: <sashiko-outbox-191537@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/19] drm/msm: Inhibit IFPC for state snapshot
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261030211928.45761-13-robin.clark@oss.qualcomm.com>
References: <20261030211928.45761-1-robin.clark@oss.qualcomm.com>
 <20261030211928.45761-13-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 21:38:16 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/msm: race re-enabling IFPC during gpu_state_get() in msm_gpu_o=
pen()
- [High] drm/msm: premature GMU_OOB_PERFCOUNTER_SET before msm_gpu_hw_init()
--

commit 158363591a2450fd461587eb02116600b0d3c278
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Inhibit IFPC for state snapshot

This commit adds an ifpc_disable guard in msm_gpu_open() to keep the GPU
awake while capturing a GPU state snapshot via debugfs.

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
> +
>  		scoped_cond_guard (mutex_intr, return PTR_ERR(scope.lock), &gpu->lock)=
 {
>  			msm_gpu_hw_init(gpu);
>  			show_priv->state =3D gpu->funcs->gpu_state_get(gpu);

[Severity: High]
As reported by Sashiko on v3 [1], can concurrent callers clear the
GMU_OOB_PERFCOUNTER_SET vote and re-enable IFPC while gpu_state_get() or
sample_worker() is still reading GPU GX registers?

In drivers/gpu/drm/msm/msm_gpu.h, the ifpc_disable guard toggles
ifpc_update() with a boolean rather than a reference count:

DEFINE_GUARD(ifpc_disable, struct msm_gpu *,
	     if (_T->funcs->ifpc_update) _T->funcs->ifpc_update(_T, true),
	     if (_T->funcs->ifpc_update) _T->funcs->ifpc_update(_T, false));

And in drivers/gpu/drm/msm/adreno/a6xx_gmu.c, a6xx_gmu_ifpc_update() tracks
the OOB request with a single bit (GMU_STATUS_OOB_PERF_SET) in gmu->status:

	if (force_on && !test_and_set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status))
		a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
	else if (!force_on && test_and_clear_bit(GMU_STATUS_OOB_PERF_SET, &gmu->st=
atus))
		a6xx_gmu_clear_oob(gmu, GMU_OOB_PERFCOUNTER_SET);

When sysprof is not active (refcount_read(&gpu->sysprof_active) =3D=3D 1),
several paths can clear GMU_STATUS_OOB_PERF_SET and drop
GMU_OOB_PERFCOUNTER_SET while another thread is inside gpu_state_get():

1. Because guard(ifpc_disable)(gpu) in msm_gpu_open() runs outside
   gpu->lock, a second process opening the debugfs file enters
   guard(ifpc_disable)(gpu) (which is a no-op since GMU_STATUS_OOB_PERF_SET
   is already set) and blocks on gpu->lock. If that waiter is interrupted by
   a signal, or when the first caller unlocks gpu->lock and exits its
   ifpc_disable guard after the second caller has entered gpu_state_get(),
   a6xx_gmu_ifpc_update(gpu, false) clears GMU_OOB_PERFCOUNTER_SET while
   gpu_state_get() is actively accessing GX registers.

2. sample_worker() in drivers/gpu/drm/msm/msm_perfcntr.c runs on gpu->worker
   without gpu->lock and also uses guard(ifpc_disable)(gpu). When either
   sample_worker() or msm_gpu_open() finishes first, its guard cleanup clea=
rs
   GMU_OOB_PERFCOUNTER_SET for the other.

3. msm_context_set_sysprof() in drivers/gpu/drm/msm/msm_submitqueue.c runs
   without gpu->lock (including on every DRM fd close via msm_postclose())
   and unconditionally calls gpu->funcs->ifpc_update(gpu, false), which also
   clears GMU_OOB_PERFCOUNTER_SET mid-snapshot.

4. On A8xx, hw_init() in drivers/gpu/drm/msm/adreno/a8xx_gpu.c sets
   GMU_OOB_PERFCOUNTER_SET and GMU_STATUS_OOB_PERF_SET when
   msm_gpu_sysprof_no_perfcntr_zap(gpu) is true (such as when
   gpu->perfcntrs->stream is active with sysprof_active =3D=3D 1), whereas
   a6xx_gmu_ifpc_update() only checks msm_gpu_sysprof_no_ifpc(gpu). Exiting
   guard(ifpc_disable)(gpu) in msm_gpu_open() will then clear the active
   perfcntr stream's OOB vote.

[Severity: High]
Also in msm_gpu_open(), does placing guard(ifpc_disable)(gpu) before
msm_gpu_hw_init(gpu) assert GMU_OOB_PERFCOUNTER_SET before the initial
GMU_OOB_GPU_SET handshake when waking from runtime suspend?

When the GPU is runtime-suspended, entering scoped_guard(pm_runtime_active,
&gpu->pdev->dev) runs a6xx_gmu_pm_resume(), which sets
gpu->needs_hw_init =3D true and boots the GMU while deferring the
GMU_OOB_GPU_SET (and legacy GMU_OOB_BOOT_SLUMBER) handshake until
msm_gpu_hw_init(gpu).

Calling guard(ifpc_disable)(gpu) before msm_gpu_hw_init(gpu) causes
a6xx_gmu_ifpc_update(gpu, true) to set GMU_STATUS_OOB_PERF_SET and call
a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET) while gpu->needs_hw_init is
still true and before hw_init() has performed the GMU_OOB_GPU_SET handshake.

Furthermore, when msm_gpu_hw_init(gpu) subsequently calls hw_init() in
drivers/gpu/drm/msm/adreno/a6xx_gpu.c or
drivers/gpu/drm/msm/adreno/a8xx_gpu.c while msm_gpu_sysprof_no_ifpc(gpu) or
msm_gpu_sysprof_no_perfcntr_zap(gpu) is true:

	if (!ret && msm_gpu_sysprof_no_ifpc(gpu)) {
		ret =3D a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
		if (!ret)
			set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status);
	}

hw_init() does not check whether GMU_STATUS_OOB_PERF_SET is already set and
calls a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET) a second time while the
OOB bit is already asserted. Should guard(ifpc_disable)(gpu) be placed insi=
de
the gpu->lock scope after msm_gpu_hw_init(gpu)?

[1] https://lore.kernel.org/r/20261029201730.151754-12-robin.clark@oss.qual=
comm.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030211928.4576=
1-1-robin.clark@oss.qualcomm.com?part=3D12
