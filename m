Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6943B606A333
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 19:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YK3knJAx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE09B10F19E;
	Mon,  2 Nov 2026 19:20:56 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC9D610F199
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 19:20:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0E03060621;
 Mon,  2 Nov 2026 19:20:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6A81F00A1C;
 Mon,  2 Nov 2026 19:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793647248;
 bh=u5wb+F2vJngnFfXO1U5vbY1/zSuFqvkQweuIHu1xS7Y=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=YK3knJAxEV+UcfhC83AT45OKRq/Ow1nuZm1gYnHNxOWc4O5/1839IFpzDlA7Lhzyp
 ZWKgSwMYXiB1vxujfDVE7Bbs5DqK4wCEJ1jjj3Dr/lVbxVpu3AomixHapNrz3e9dtX
 +6NVXJ79V4zaZqQluSJhvGrV7Fbs79aejkmEwZ0DobLwTQ10hlCD77HzuLdtzeuAvn
 +a6pBZMFPOmSab6a43sRfpleaso82PYuGIFQyiG4mu+TS0JSwNx89cAewkTfnh1IDf
 dcW3uLXZrtaCJnye0pvAhUUwFToN99gYvM9I2baM/SgMtlLs7ixyb2HRNidFtU2wOg
 7pbJFpuoie1GA==
Message-ID: <sashiko-outbox-193992@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] drm/msm: Rework IFPC disable
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261102190010.720443-2-robin.clark@oss.qualcomm.com>
References: <20261102190010.720443-1-robin.clark@oss.qualcomm.com>
 <20261102190010.720443-2-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 19:20:48 +0000
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
- [High] drm/msm/adreno: stale GMU_STATUS_OOB_PERF_SET after a6xx_gmu_force=
_off()
- [Medium] drm/msm/adreno: premature GMU_OOB_PERFCOUNTER_SET in a6xx_gmu_if=
pc_update()
- [Medium] drm/msm/adreno: unhandled OOB errors in a6xx_gmu_ifpc_update_loc=
ked()
--

commit 15aefb4a3ef6c261aac3a46fc7b4e9cde2215554
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Rework IFPC disable

This commit decouples IFPC inhibition from the sysprof refcount by
introducing a dedicated gpu->ifpc_disable refcount and replacing
gpu->funcs->sysprof_setup() with gpu->funcs->ifpc_update().

> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/=
adreno/a6xx_gmu.c
> index 662f09bec9d52..bba5468db42e9 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -2128,29 +2128,33 @@ static int a6xx_gmu_get_irq(struct a6xx_gmu *gmu,=
 struct platform_device *pdev,
>  	return irq;
>  }
> =20
> -void a6xx_gmu_sysprof_setup(struct msm_gpu *gpu, bool force_on)
> +void a6xx_gmu_ifpc_update_locked(struct msm_gpu *gpu)
>  {
> -	bool sysprof =3D msm_gpu_sysprof_no_ifpc(gpu) || force_on;
>  	struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
>  	struct a6xx_gpu *a6xx_gpu =3D to_a6xx_gpu(adreno_gpu);
>  	struct a6xx_gmu *gmu =3D &a6xx_gpu->gmu;
> +	bool force_on =3D refcount_read(&gpu->ifpc_disable) > 1;
> =20
> -	/* Nothing to do if GPU is suspended. We will handle this during GMU re=
sume */
> -	if (!pm_runtime_get_if_active(&gpu->pdev->dev))
> -		return;
> -
> -	mutex_lock(&gmu->lock);
> +	WARN_ON_ONCE(!mutex_is_locked(&gmu->lock));
> =20
> -	/*
> -	 * 'Perfcounter select' register values are lost during IFPC collapse. =
To avoid that,
> -	 * use the currently unused perfcounter oob vote to block IFPC when sys=
prof is active
> -	 */
> -	if (sysprof && !test_and_set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status))
> +	if (force_on && !test_and_set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status=
))
>  		a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
> -	else if (!sysprof && test_and_clear_bit(GMU_STATUS_OOB_PERF_SET, &gmu->=
status))
> +	else if (!force_on && test_and_clear_bit(GMU_STATUS_OOB_PERF_SET, &gmu-=
>status))
>  		a6xx_gmu_clear_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
> +}

[Severity: High]
As reported by Sashiko on v1 [1], can a6xx_gmu_ifpc_update_locked() skip
re-asserting GMU_OOB_PERFCOUNTER_SET during hw_init() after a forced GMU
shutdown?

GMU_STATUS_OOB_PERF_SET in gmu->status is normally cleared during a
graceful shutdown in a6xx_gmu_shutdown(). However, if a6xx_gmu_stop() takes
the a6xx_gmu_force_off() path because gmu->hung is true (or if
a6xx_gmu_shutdown() jumps to force_off when GMU_OOB_GPU_SET fails),
a6xx_gmu_force_off() resets the GMU CM3 core and powers down RPMh without
clearing GMU_STATUS_OOB_PERF_SET:

drivers/gpu/drm/msm/adreno/a6xx_gmu.c:a6xx_gmu_stop() {
	if (gmu->hung)
		a6xx_gmu_force_off(gmu);
	else
		a6xx_gmu_shutdown(gmu);
}

Previously, hw_init() in a6xx_gpu.c and a8xx_gpu.c unconditionally called
a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET) and set
GMU_STATUS_OOB_PERF_SET when IFPC inhibition was active. With hw_init() now
calling a6xx_gmu_ifpc_update_locked(), test_and_set_bit() sees the stale
GMU_STATUS_OOB_PERF_SET bit and skips sending GMU_OOB_PERFCOUNTER_SET to
the freshly reset GMU, leaving IFPC enabled in hardware while
gpu->ifpc_disable > 1.

> =20
> -	mutex_unlock(&gmu->lock);
> +void a6xx_gmu_ifpc_update(struct msm_gpu *gpu)
> +{
> +	struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
> +	struct a6xx_gpu *a6xx_gpu =3D to_a6xx_gpu(adreno_gpu);
> +	struct a6xx_gmu *gmu =3D &a6xx_gpu->gmu;
> +
> +	/* Nothing to do if GPU is suspended. We will handle this during GMU re=
sume */
> +	if (pm_runtime_get_if_active(&gpu->pdev->dev) <=3D 0)
> +		return;
> +
> +	scoped_guard (mutex, &gmu->lock)
> +		a6xx_gmu_ifpc_update_locked(gpu);
> =20
>  	pm_runtime_put(&gpu->pdev->dev);
>  }

[Severity: Medium]
Can a6xx_gmu_ifpc_update() send GMU_OOB_PERFCOUNTER_SET after runtime
resume before hw_init() has completed the initial GMU_OOB_GPU_SET
handshake?

When the GPU is runtime-resumed via adreno_runtime_resume() ->
a6xx_gmu_pm_resume(), the GMU is booted and gpu->needs_hw_init is set to
true, while msm_gpu_hw_init() is deferred until later. At that point,
pm_runtime_get_if_active(&gpu->pdev->dev) returns 1 even though hw_init()
has not run yet.

In msm_context_set_sysprof():

drivers/gpu/drm/msm/msm_submitqueue.c:msm_context_set_sysprof() {
	case 2:
		pm_runtime_get_sync(&gpu->pdev->dev);
		fallthrough;
	case 1:
		/* Disable zapping perfcntrs on context switch: */
		refcount_inc(&gpu->sysprof_active);
		/* Disable IFPC: */
		msm_gpu_disable_ifpc_get(gpu);
}

If the GPU was runtime-suspended, pm_runtime_get_sync() wakes the GMU with
gpu->needs_hw_init =3D=3D true, and msm_gpu_disable_ifpc_get() immediately
calls a6xx_gmu_ifpc_update() -> a6xx_gmu_ifpc_update_locked().

This issues GMU_OOB_PERFCOUNTER_SET before hw_init() performs the initial
GMU_OOB_GPU_SET handshake (which commit d34b6919798c noted confuses GMU
firmware state), and sets GMU_STATUS_OOB_PERF_SET in gmu->status so that
the subsequent hw_init() call to a6xx_gmu_ifpc_update_locked() skips
sending GMU_OOB_PERFCOUNTER_SET after clearing GMU_OOB_GPU_SET.

Should a6xx_gmu_ifpc_update_locked() (or a6xx_gmu_ifpc_update()) check
!gpu->needs_hw_init before touching GMU OOB state?

> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/=
adreno/a6xx_gpu.c
> index 92e8c8abb86da..773c1727dd31a 100644
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
> +	a6xx_gmu_ifpc_update_locked(gpu);
> =20
>  	return ret;
>  }

[Severity: Medium]
As reported by Sashiko on v1 [2], is it intentional that hw_init() in both
a6xx_gpu.c and a8xx_gpu.c now calls a6xx_gmu_ifpc_update_locked() at the
out label even when ret !=3D 0, and ignores errors from a6xx_gmu_set_oob()?

Previously, if adreno_hw_init() or CP initialization failed and jumped to
out with a non-zero ret, GMU_OOB_PERFCOUNTER_SET was skipped because of the
!ret check. In addition, if a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET)
timed out, GMU_STATUS_OOB_PERF_SET was not set and the error was returned
from hw_init().

With this change, a6xx_gmu_ifpc_update_locked() sets
GMU_STATUS_OOB_PERF_SET via test_and_set_bit() before calling
a6xx_gmu_set_oob() and discards its return value, leaving
GMU_STATUS_OOB_PERF_SET set even if the OOB request fails.

[1] https://lore.kernel.org/r/20261101174631.23637-2-robin.clark@oss.qualco=
mm.com
[2] https://lore.kernel.org/r/20261101174631.23637-2-robin.clark@oss.qualco=
mm.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102190010.7204=
43-1-robin.clark@oss.qualcomm.com?part=3D1
