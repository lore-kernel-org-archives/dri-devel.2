Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78DB606A326
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 17:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YrjlfRCT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C45C10E29C;
	Sun,  1 Nov 2026 17:58:12 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA3A810E29C
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 17:58:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C061243BF6;
 Sun,  1 Nov 2026 17:58:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D3241F00A16;
 Sun,  1 Nov 2026 17:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793555885;
 bh=DpPWRDUHj2ANKxsnUsgS1EVs2IAlYEykWZdhuE2OvBI=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=YrjlfRCT57JsRpNdu/zQ5RNr2Li2U/23va6OI5DpnkheOAfzHclviYLS7nWNZmMKh
 /uUJk/JFRwuGVwUmZ4DqZXHsI99cmIztVDRJxlpTlri5TxHO5c9qxSsXV4hkCIcKGn
 7Oi/FaVFQq1jbjtOgZW4uP5GTYRoep+0qfXixBw45J4ZQWozfwVYeXk4Jei0SZuTnH
 F9TUWA9b+x3+VTx3ohrR+qfwbeGChVqKaPqtx7IHOFg8jh3Hxlsrh6zp2eRhtmNjtH
 ho2IKe94gpTC66Ga9xsuqr2tbZ/paq0KYZKgBgG8hWFFrrx4O5s4Vtfof5OQmzfoRN
 vzku1Me4duisA==
Message-ID: <sashiko-outbox-192551@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] drm/msm: Rework IFPC disable
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261101174631.23637-2-robin.clark@oss.qualcomm.com>
References: <20261101174631.23637-1-robin.clark@oss.qualcomm.com>
 <20261101174631.23637-2-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 17:58:05 +0000
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
- [High] drm/msm/adreno: self-deadlock on gmu.lock in hw_init()
- [High] drm/msm/adreno: unlocked ifpc_disable read in a6xx_gmu_ifpc_update=
()
- [High] drm/msm/adreno: a8xx hw_init() not updated to check ifpc_disable
- [Medium] drm/msm/adreno: stale GMU_STATUS_OOB_PERF_SET after a6xx_gmu_for=
ce_off()
--

commit 14094c96f7c739970280de8ad207fe78e212a6f7
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Rework IFPC disable

This commit decouples IFPC inhibition from the sysprof refcount by
introducing a dedicated ifpc_disable refcount on struct msm_gpu and
replacing sysprof_setup() with ifpc_update().

> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/=
adreno/a6xx_gmu.c
> index 662f09bec9d52..d1fe6c40da83b 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -2128,12 +2128,12 @@ static int a6xx_gmu_get_irq(struct a6xx_gmu *gmu,=
 struct platform_device *pdev,
>  	return irq;
>  }
> =20
> -void a6xx_gmu_sysprof_setup(struct msm_gpu *gpu, bool force_on)
> +void a6xx_gmu_ifpc_update(struct msm_gpu *gpu)
>  {
> -	bool sysprof =3D msm_gpu_sysprof_no_ifpc(gpu) || force_on;
>  	struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
>  	struct a6xx_gpu *a6xx_gpu =3D to_a6xx_gpu(adreno_gpu);
>  	struct a6xx_gmu *gmu =3D &a6xx_gpu->gmu;
> +	bool force_on =3D refcount_read(&gpu->ifpc_disable) > 1;
> =20
>  	/* Nothing to do if GPU is suspended. We will handle this during GMU re=
sume */
>  	if (!pm_runtime_get_if_active(&gpu->pdev->dev))
> @@ -2145,9 +2145,9 @@ void a6xx_gmu_sysprof_setup(struct msm_gpu *gpu, bo=
ol force_on)
>  	 * 'Perfcounter select' register values are lost during IFPC collapse. =
To avoid that,
>  	 * use the currently unused perfcounter oob vote to block IFPC when sys=
prof is active
>  	 */
> -	if (sysprof && !test_and_set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status))
> +	if (force_on && !test_and_set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status=
))
>  		a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
> -	else if (!sysprof && test_and_clear_bit(GMU_STATUS_OOB_PERF_SET, &gmu->=
status))
> +	else if (!force_on && test_and_clear_bit(GMU_STATUS_OOB_PERF_SET, &gmu-=
>status))
>  		a6xx_gmu_clear_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
> =20
>  	mutex_unlock(&gmu->lock);

[Severity: High]
Should force_on be evaluated inside the gmu->lock critical section in
a6xx_gmu_ifpc_update() rather than before acquiring gmu->lock?

Callers of msm_gpu_disable_ifpc_get() and msm_gpu_disable_ifpc_put(), such =
as
sample_worker() and msm_context_set_sysprof(), update gpu->ifpc_disable and
invoke gpu->funcs->ifpc_update(gpu) without holding a shared outer lock:

drivers/gpu/drm/msm/msm_gpu.h:
    static inline void
    msm_gpu_disable_ifpc_get(struct msm_gpu *gpu)
    {
        refcount_inc(&gpu->ifpc_disable);
        if (gpu->funcs->ifpc_update)
            gpu->funcs->ifpc_update(gpu);
    }

    static inline void
    msm_gpu_disable_ifpc_put(struct msm_gpu *gpu)
    {
        refcount_dec(&gpu->ifpc_disable);
        if (gpu->funcs->ifpc_update)
            gpu->funcs->ifpc_update(gpu);
    }

Because a6xx_gmu_ifpc_update() reads gpu->ifpc_disable before calling
mutex_lock(&gmu->lock), two concurrent callers can race:

Thread A (msm_gpu_disable_ifpc_put)
    refcount_dec(&gpu->ifpc_disable); /* 2 -> 1 */
    a6xx_gmu_ifpc_update(gpu)
        force_on =3D refcount_read(&gpu->ifpc_disable) > 1; /* false */

Thread B (msm_gpu_disable_ifpc_get)
    refcount_inc(&gpu->ifpc_disable); /* 1 -> 2 */
    a6xx_gmu_ifpc_update(gpu)
        force_on =3D refcount_read(&gpu->ifpc_disable) > 1; /* true */
        mutex_lock(&gmu->lock);
        /* sets GMU_OOB_PERFCOUNTER_SET or sees GMU_STATUS_OOB_PERF_SET set=
 */
        mutex_unlock(&gmu->lock);
    /* proceeds to access GX registers in sample_worker() */

Thread A
        mutex_lock(&gmu->lock);
        /* uses stale force_on =3D=3D false and clears GMU_OOB_PERFCOUNTER_=
SET */
        mutex_unlock(&gmu->lock);

This leaves IFPC enabled while gpu->ifpc_disable is 2 and Thread B is
actively reading GX registers (or conversely leaves GMU_OOB_PERFCOUNTER_SET
asserted when gpu->ifpc_disable is 1).

> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/=
adreno/a6xx_gpu.c
> index 92e8c8abb86da..39a1472e0def0 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -1537,11 +1537,7 @@ static int hw_init(struct msm_gpu *gpu)
>  		a6xx_gmu_clear_oob(&a6xx_gpu->gmu, GMU_OOB_BOOT_SLUMBER);
>  	}
> =20
> -	if (!ret && msm_gpu_sysprof_no_ifpc(gpu)) {
> -		ret =3D a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
> -		if (!ret)
> -			set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status);
> -	}
> +	a6xx_gmu_ifpc_update(gpu);
> =20
>  	return ret;
>  }

[Severity: High]
Does calling a6xx_gmu_ifpc_update(gpu) inside hw_init() cause a self-deadlo=
ck
on a6xx_gpu->gmu.lock?

In drivers/gpu/drm/msm/adreno/a6xx_gpu.c, a6xx_hw_init() already holds
a6xx_gpu->gmu.lock when calling hw_init():

    static int a6xx_hw_init(struct msm_gpu *gpu)
    {
        ...
        mutex_lock(&a6xx_gpu->gmu.lock);
        ret =3D hw_init(gpu);
        mutex_unlock(&a6xx_gpu->gmu.lock);

        return ret;
    }

All callers of msm_gpu_hw_init() -> a6xx_hw_init() -> hw_init() hold an
active runtime PM reference on &gpu->pdev->dev, so inside
a6xx_gmu_ifpc_update(), pm_runtime_get_if_active(&gpu->pdev->dev) succeeds
and mutex_lock(&gmu->lock) attempts to acquire the same mutex a second time.

Also, since this call is after the out: label, hw_init() now calls
a6xx_gmu_ifpc_update(gpu) even when an earlier step failed with ret !=3D 0,=
 and
no longer propagates errors from a6xx_gmu_set_oob().

[Severity: Medium]
In addition to the locking issue above, can replacing the unconditional
a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET) in hw_init() with
a6xx_gmu_ifpc_update(gpu) skip re-applying the OOB vote after a forced GMU
reset?

During a graceful shutdown, a6xx_gmu_shutdown() clears
GMU_STATUS_OOB_PERF_SET in gmu->status. However, if the GMU is hung during
recovery in a6xx_recover() -> a6xx_gmu_stop() -> a6xx_gmu_force_off(), or if
a6xx_gmu_shutdown() fails early and jumps to force_off:

drivers/gpu/drm/msm/adreno/a6xx_gmu.c:a6xx_gmu_shutdown() {
    if (adreno_gpu->base.needs_hw_init) {
        if (a6xx_gmu_set_oob(&a6xx_gpu->gmu, GMU_OOB_GPU_SET))
            goto force_off;
        ...
    }

    if (test_and_clear_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status))
        a6xx_gmu_clear_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
}

a6xx_gmu_force_off() powers off and resets the GMU without clearing
GMU_STATUS_OOB_PERF_SET in gmu->status. When hw_init() subsequently runs to
reinitialize the GPU while gpu->ifpc_disable > 1, the
!test_and_set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status) check in
a6xx_gmu_ifpc_update() will see the stale bit still set and skip sending
GMU_OOB_PERFCOUNTER_SET to the freshly reset GMU.

[ ... ]

> @@ -2925,7 +2921,7 @@ const struct adreno_gpu_funcs a8xx_gpu_funcs =3D {
>  		.create_private_vm =3D a6xx_create_private_vm,
>  		.get_rptr =3D a6xx_get_rptr,
>  		.progress =3D a8xx_progress,
> -		.sysprof_setup =3D a6xx_gmu_sysprof_setup,
> +		.ifpc_update =3D a6xx_gmu_ifpc_update,
>  		.perfcntr_configure =3D a6xx_perfcntr_configure,
>  		.perfcntr_flush =3D a8xx_perfcntr_flush,
>  	},

[Severity: High]
While a8xx_gpu_funcs is updated here to use a6xx_gmu_ifpc_update(), it looks
like hw_init() in drivers/gpu/drm/msm/adreno/a8xx_gpu.c still checks
msm_gpu_sysprof_no_perfcntr_zap(gpu):

drivers/gpu/drm/msm/adreno/a8xx_gpu.c:hw_init() {
    ...
    a6xx_gmu_clear_oob(&a6xx_gpu->gmu, GMU_OOB_GPU_SET);

    if (!ret && msm_gpu_sysprof_no_perfcntr_zap(gpu)) {
        ret =3D a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
        if (!ret)
            set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status);
    }

    return ret;
}

Should a8xx_gpu.c:hw_init() also be updated to check gpu->ifpc_disable so
that non-sysprof votes on gpu->ifpc_disable are honored across A8xx hardware
init (and an active global perfcntr stream with gpu->ifpc_disable =3D=3D 1 =
does
not leave GMU_OOB_PERFCOUNTER_SET set on resume)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101174631.2363=
7-1-robin.clark@oss.qualcomm.com?part=3D1
