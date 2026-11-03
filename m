Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E24606EEA7
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 23:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kanDsmZg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C17B10E09B;
	Tue,  3 Nov 2026 23:46:58 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0CDA10E09B
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 23:46:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2183360D9F;
 Tue,  3 Nov 2026 23:46:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A60F31F000C1;
 Tue,  3 Nov 2026 23:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793749610;
 bh=ElxElOyoHY+0HfrjrEnHX8+2M0IUK7zYj2AHe7J4I8U=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=kanDsmZgurdcA9YremePZsxo3bt90yJzkWZQtgPloOrcnbhNf5TznSdXffbvNp006
 TXbxcCa+RtFpLomgWonWJTGNknkv7lvXr9N+RG92hmHR31ZWdsdYflV6by7Zqnwfu0
 NlorIs69wSyafYH4TYuGS+kfrmlR+vqNYX212v70iOHZdILLbrs+vcRPQwjg2+rRW8
 QvvptKQQCmCH+TCbOHNXchpCUEXs0PgW0UNAZHs95HiFCqckLFudyF4x8bAGzNRiqg
 lpww/l/T+AQ/Lr2RHILV8x9Kwpjf7VRZ8JdlWMbuJ/7otqttB0QOq8zbLoZjYB34rh
 bD/vF958hDehw==
Message-ID: <sashiko-outbox-196234@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/6] drm/msm: Rework IFPC disable
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261103231850.17493-4-robin.clark@oss.qualcomm.com>
References: <20261103231850.17493-1-robin.clark@oss.qualcomm.com>
 <20261103231850.17493-4-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 23:46:50 +0000
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
- [High] drm/msm: recursive mutex deadlock on gpu->perfcntr_lock in sel_wor=
ker()
- [Medium] drm/msm/adreno: unmatched OOB clear in a6xx_gmu_shutdown() when =
uninitialized
--

commit da3fce8126509b0693832ae064a79a5dbbf0cc40
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Rework IFPC disable

This commit decouples IFPC inhibition from the sysprof refcount by
introducing a dedicated ifpc_disable refcount on struct msm_gpu and
replacing sysprof_setup() with ifpc_update().

> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/=
adreno/a6xx_gmu.c
> index 662f09bec9d52..b02bcaa4bd96f 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -1443,7 +1443,7 @@ static void a6xx_gmu_shutdown(struct a6xx_gmu *gmu)
>  		a6xx_gmu_clear_oob(&a6xx_gpu->gmu, GMU_OOB_GPU_SET);
>  	}
> =20
> -	if (test_and_clear_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status))
> +	if (test_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status))
>  		a6xx_gmu_clear_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
> =20
>  	ret =3D a6xx_gmu_wait_for_idle(gmu);

[Severity: Medium]
As reported by Sashiko on v3 [1], can a6xx_gmu_shutdown() issue an unmatched
a6xx_gmu_clear_oob(gmu, GMU_OOB_PERFCOUNTER_SET) when the GMU wakes up and
shuts down again without hw_init() running?

With this change, a6xx_gmu_shutdown() keeps GMU_STATUS_OOB_PERF_SET set in
gmu->status across suspend, and hw_init() in drivers/gpu/drm/msm/adreno/a6x=
x_gpu.c
and drivers/gpu/drm/msm/adreno/a8xx_gpu.c only re-asserts
GMU_OOB_PERFCOUNTER_SET on the GMU at the end of hardware initialization:

drivers/gpu/drm/msm/adreno/a6xx_gpu.c:hw_init() {
	...
	/* re-apply IFPC-disable OOB request, if needed: */
	if (!ret && test_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status)) {
		ret =3D a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
	}
}

If IFPC disable is active without holding a persistent runtime PM reference
(for example when sysprof is set to 1) and the GPU runtime-suspends,
GMU_STATUS_OOB_PERF_SET remains set. If the GMU is later resumed (setting
gpu->needs_hw_init =3D true in a6xx_gmu_pm_resume()) and suspends again
without msm_gpu_hw_init() running, such as when querying MSM_PARAM_TIMESTAMP
in adreno_get_param() or closing another DRM file descriptor in
msm_postclose() -> msm_context_set_sysprof(ctx, priv->gpu, 0),
GMU_OOB_PERFCOUNTER_SET is never asserted during that wakeup cycle.

When a6xx_gmu_shutdown() then runs while adreno_gpu->base.needs_hw_init is
 still true, test_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status) evaluates to
true and sends an unpaired GMU_OOB_PERFCOUNTER_SET clear to the GMU. Should
clearing GMU_OOB_PERFCOUNTER_SET in a6xx_gmu_shutdown() be skipped when
adreno_gpu->base.needs_hw_init is true?

[ ... ]

> diff --git a/drivers/gpu/drm/msm/msm_perfcntr.c b/drivers/gpu/drm/msm/msm=
_perfcntr.c
> index 7fa2e858bd082..bf73752dac3de 100644
> --- a/drivers/gpu/drm/msm/msm_perfcntr.c
> +++ b/drivers/gpu/drm/msm/msm_perfcntr.c
> @@ -259,8 +259,7 @@ sample_worker(struct kthread_work *work)
>  	}
> =20
>  	/* Inhibit IFPC while accessing registers: */
> -	if (gpu->funcs->sysprof_setup)
> -		gpu->funcs->sysprof_setup(gpu, true);
> +	msm_gpu_disable_ifpc_get(gpu);

[Severity: High]
Does calling msm_gpu_hw_init() from sel_worker() in
drivers/gpu/drm/msm/msm_perfcntr.c cause a recursive mutex deadlock on
gpu->perfcntr_lock when gpu->needs_hw_init is true?

In drivers/gpu/drm/msm/msm_perfcntr.c, sel_worker() acquires both gpu->lock
and gpu->perfcntr_lock before calling msm_gpu_hw_init(gpu):

drivers/gpu/drm/msm/msm_perfcntr.c:sel_worker() {
	...
	scoped_guard (mutex, &gpu->lock) {
		guard(mutex)(&gpu->perfcntr_lock);

		if (stream =3D=3D gpu->perfcntrs->stream) {
			msm_gpu_hw_init(gpu);
			gpu->funcs->perfcntr_configure(gpu, ring, stream);
		}
	}
}

When gpu->needs_hw_init is true, msm_gpu_hw_init() in
drivers/gpu/drm/msm/msm_gpu.c runs gpu->funcs->hw_init(gpu) and then calls
msm_perfcntr_resume(gpu):

drivers/gpu/drm/msm/msm_gpu.c:msm_gpu_hw_init() {
	...
	disable_irq(gpu->irq);
	ret =3D gpu->funcs->hw_init(gpu);
	if (!ret) {
		msm_perfcntr_resume(gpu);
		gpu->needs_hw_init =3D false;
	}
	enable_irq(gpu->irq);
}

msm_perfcntr_resume() in drivers/gpu/drm/msm/msm_perfcntr.c then attempts
to acquire gpu->perfcntr_lock again on the same thread:

drivers/gpu/drm/msm/msm_perfcntr.c:msm_perfcntr_resume() {
	if (!gpu->perfcntrs)
		return 0;
	guard(mutex)(&gpu->perfcntr_lock);
	return msm_perfcntr_resume_locked(gpu->perfcntrs->stream);
}

This call chain sel_worker() -> msm_gpu_hw_init() -> msm_perfcntr_resume()
can be reached whenever sel_worker() runs while the GPU is runtime-active
and gpu->needs_hw_init is true, such as when a perfcntr stream is configured
via msm_ioctl_perfcntr_config() during the autosuspend window after a path
wakes the GPU without calling msm_gpu_hw_init() (for example
adreno_get_param() handling MSM_PARAM_TIMESTAMP, or msm_postclose() calling
msm_context_set_sysprof(ctx, priv->gpu, 0)). Would calling
msm_gpu_hw_init(gpu) under gpu->lock before acquiring gpu->perfcntr_lock in
sel_worker() avoid this deadlock?

[1] https://lore.kernel.org/r/20261103184713.29664-2-robin.clark@oss.qualco=
mm.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103231850.1749=
3-1-robin.clark@oss.qualcomm.com?part=3D3
