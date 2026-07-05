Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 614ACC43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 19:36:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 798AC10E236;
	Sun,  5 Jul 2026 19:36:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="l92HDg+G";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65A0310E236
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 19:36:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BED60600C3;
 Sun,  5 Jul 2026 19:36:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31ADB1F000E9;
 Sun,  5 Jul 2026 19:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783280187;
 bh=77D0XQyj/xfk1JXZh8y4vUqygGw0szn4FU5vclveBUw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=l92HDg+GbfU4nJBFrqPeVRHKzzmyf/qwKsKEm6pak/8rExDZh4+yXhj/m8ReIVviw
 kNldkRvFJyCwMkdf43Y7ftQ3VGtPcc8qL/pfXcDzvv/att/GHtjZI473bDV50fxsiF
 /6SMNRYurHln6LvL3kvRO7TK0EUMi9qHKXRlvpXXqPvJyPKZTQLjeLFDBUAY+HrBY/
 XsbwDJyTPHpe6MryvYnoeo4fYVyP5iYmzelDRnV67ZjlfFPgzbi2RvkemRjd7GhhEN
 3MitW9tZoyoX5hV1cicYO+GUyZiwzN5JeZBKDCd1l6j8SYZk9Rf8c7CAF0CMUykxDe
 CW/hngjiQieUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 11/13] drm/msm: Add LPAC submitqueue
To: "Anna Maniscalco" <anna.maniscalco2000@gmail.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260705-descriptive-name-lpac-upstream-v1-11-01d50c3e0c99@gmail.com>
References: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
 <20260705-descriptive-name-lpac-upstream-v1-11-01d50c3e0c99@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 19:36:26 +0000
Message-Id: <20260705193627.31ADB1F000E9@smtp.kernel.org>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [Critical] LPAC-specific registers and commands are programmed unconditio=
nally for all A6XX-family GPUs, breaking hardware initialization on older c=
hips.
- [High] Missing error check for LPAC ringbuffer allocation leads to out-of=
-bounds array access and silent failures.
- [High] Unconditional creation of LPAC submitqueues allows unprivileged us=
ers to cause unrecoverable GPU hangs on hardware without LPAC support.
- [High] The GPU hangcheck mechanism ignores the LPAC ring, meaning LPAC-ex=
clusive hangs will never be recovered.
- [High] In `msm_iommu_new`, failing to attach the LPAC domain causes resou=
rce leaks and use-after-free bugs by freeing attached domains.
- [Medium] Performance counter statistics for LPAC submissions will be corr=
upted due to mismatched start and end register reads.
- [Medium] When error interrupts are disabled, LPAC completion interrupts a=
re inadvertently dropped, causing job timeouts.
--

commit f42a6839003ad94fdc9d88ca88077e9fcbcda345
Author: Anna Maniscalco <anna.maniscalco2000@gmail.com>

drm/msm: Add LPAC submitqueue

Add UAPI and infostructure to support sending submission to the LPAC
ring.

> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/=
adreno/a6xx_gpu.c
> index 9f69aada9b7b7..4417a9d04d7c2 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
[ ... ]
> @@ -493,7 +498,10 @@ static void a7xx_submit(struct msm_gpu *gpu, struct =
msm_gem_submit *submit)
[ ... ]
>  	get_stats_counter(ring, rbbm_perfctr_cp0, rbmemptr_stats(ring, index, c=
pcycles_start));
> -	get_stats_counter(ring, cp_always_on_context, rbmemptr_stats(ring, inde=
x, alwayson_start));
> +	if (is_lpac)
> +		get_stats_counter(ring, cp_always_on_counter, rbmemptr_stats(ring, ind=
ex, alwayson_start));
> +	else
> +		get_stats_counter(ring, cp_always_on_context, rbmemptr_stats(ring, ind=
ex, alwayson_start));

[Severity: Medium]
Does this cause a mismatch for LPAC submissions? The start counter
conditionally reads from cp_always_on_counter for LPAC, but the end counter
unconditionally reads from cp_always_on_context later in the function:

	get_stats_counter(ring, rbbm_perfctr_cp0, rbmemptr_stats(ring, index, cpcy=
cles_end));
	get_stats_counter(ring, cp_always_on_context, rbmemptr_stats(ring, index, =
alwayson_end));

This will cause the duration of LPAC jobs to be incorrectly calculated since
the start and end values are read from different registers.

>  	OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
>  	OUT_RING(ring, CP_SET_THREAD_BOTH);
[ ... ]
> @@ -2030,6 +2048,9 @@ static irqreturn_t a6xx_irq(struct msm_gpu *gpu)
>  		a6xx_preempt_trigger(gpu);
>  	}
> =20
> +	if (status & A6XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS_LPAC)
> +		msm_gpu_retire(gpu);
> +

[Severity: Medium]
Are LPAC completion interrupts inadvertently dropped when error interrupts =
are
disabled?

Earlier in a6xx_irq():
	if (priv->disable_err_irq)
		status &=3D A6XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS;

In testing or debug modes where disable_err_irq is set, the interrupt status
mask preserves the main ring's completion bit but drops the newly added LPAC
completion bit (CP_CACHE_FLUSH_TS_LPAC). This causes LPAC jobs to artificia=
lly
time out during these tests. Should the mask be updated to include the LPAC
bit?

>  	if (status & A6XX_RBBM_INT_0_MASK_CP_SW)
[ ... ]
> diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/msm/=
msm_submitqueue.c
> index 1a5a77b280163..042b4f90fb73f 100644
> --- a/drivers/gpu/drm/msm/msm_submitqueue.c
> +++ b/drivers/gpu/drm/msm/msm_submitqueue.c
[ ... ]
> @@ -211,6 +212,13 @@ int msm_submitqueue_create(struct drm_device *drm, s=
truct msm_context *ctx,
>  		queue =3D kzalloc_obj(*queue);
>  	}
> =20
> +	if (flags & MSM_SUBMITQUEUE_LPAC) {
> +		ring_nr =3D priv->gpu->nr_rings;
> +		ring =3D priv->gpu->lpac_rb;
> +	} else {
> +		ring =3D priv->gpu->rb[ring_nr];
> +	}
> +

[Severity: High]
Can an unprivileged user cause a GPU hang regression on hardware without LP=
AC
support?=20

Because lpac_rb is exposed unconditionally here, userspace can request an L=
PAC
submitqueue and push commands to it even on hardware without an LPAC proces=
sor.
The hardware will ignore the software ringbuffer, causing the jobs to time =
out
and the GPU to enter a recovery loop. Should this verify if the hardware
actually supports LPAC first?

>  	if (!queue)
>  		return -ENOMEM;
[ ... ]

I also noticed a few regressions in the broader LPAC enablement changes out=
side
of this specific diff:

[Severity: Critical]
Is it safe to unconditionally program LPAC registers for all A6xx-family GP=
Us?

drivers/gpu/drm/msm/adreno/a6xx_gpu.c:hw_init() {
    ...
	/* Set the ringbuffer address for lpac */
	gpu_write64(gpu, REG_A7XX_CP_LPAC_RB_BASE, gpu->lpac_rb->iova);
    ...
	ret =3D lpac_cp_init(gpu);
	if (ret)
		goto out;
    ...
}

Writing to A7xx-only registers and submitting initialization commands to the
non-existent LPAC ring on older A6xx GPUs appears to cause the hardware to
timeout during a6xx_idle() and potentially trigger AHB bus errors. This
introduces a regression in GPU driver initialization on non-LPAC platforms.

[Severity: High]
Does this error check inspect the wrong variable?

drivers/gpu/drm/msm/msm_gpu.c:msm_gpu_init() {
    ...
	gpu->lpac_rb =3D msm_ringbuffer_new(gpu, nr_rings, memptrs, memptrs_iova);

	if (IS_ERR(gpu->rb[i])) {
		ret =3D PTR_ERR(gpu->rb[i]);
    ...
}

This checks gpu->rb[i] instead of gpu->lpac_rb. This accesses memory past t=
he
end of the initialized gpu->rb array and ignores lpac_rb allocation failure=
s.
If the allocation fails, gpu->lpac_rb remains an error pointer and can caus=
e a
panic when accessed later.

[Severity: High]
Will the GPU hangcheck mechanism fail to detect LPAC-exclusive hangs?

drivers/gpu/drm/msm/msm_gpu.c:hangcheck_handler() {
    ...
	struct msm_ringbuffer *ring =3D gpu->funcs->active_ring(gpu);
    ...
}

The handler only inspects progress on the main ring returned by
active_ring(gpu), skipping the concurrent lpac_rb. If a job hangs on the LP=
AC
ring while the main ring is idle or progressing normally, the timer will ne=
ver
detect the lockup and the GPU will remain stuck.

[Severity: High]
Could this error path leak the primary domain or cause a use-after-free?

drivers/gpu/drm/msm/msm_iommu.c:msm_iommu_new() {
    ...
	if (lpac_dev) {
		if (!device_iommu_mapped(lpac_dev))
			return ERR_PTR(-ENODEV);

		lpac_domain =3D iommu_paging_domain_alloc(lpac_dev);
		if (IS_ERR(lpac_domain))
			return ERR_CAST(lpac_domain);
    ...
		ret =3D iommu_attach_device(lpac_domain, lpac_dev);
		if (ret) {
			iommu_domain_free(domain);
			iommu_domain_free(lpac_domain);
			kfree(iommu);
			return ERR_PTR(ret);
		}
    ...
}

If device_iommu_mapped(lpac_dev) is false or domain allocation fails, it
returns an error without freeing the primary domain, causing a memory leak.=
=20

Additionally, if iommu_attach_device() fails, it calls iommu_domain_free() =
on
the primary domain while it is still actively attached to dev. Freeing an
attached domain without first calling iommu_detach_device() can lead to
use-after-free corruption in the IOMMU subsystem.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705-descriptiv=
e-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com?part=3D11
