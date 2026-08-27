Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB707C61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 23:25:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32A1E10E076;
	Thu, 27 Aug 2026 23:25:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bopB7jvq";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1E9B10E076
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 23:25:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A2D4B43590;
 Thu, 27 Aug 2026 23:25:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3A71F000E9;
 Thu, 27 Aug 2026 23:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787873112;
 bh=XYkVU56diRN8XlDY27WhNHGgK+t4EnYsvdGPhekoHoI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bopB7jvqeezYjQfWvNouBMLSQBZTZaJQDvLwRilshmWynFZZsrmWs3Pn5uFfE9Z+E
 6GeqYVpaCB6ETrEtOsjMrHzC7JhUxLFbuvJQ1vbzWYY6zcqhYrlCyvD95d73d91s2n
 xigZRGiHfj2qRES9SLLJ/RcRrCefzTCOXS4OIPIIhYoU7DlHsdU4cAgcdmcJbFFWjd
 RkSX6ck7691y7e93kA53gvbQ00WQr+C2JWhMJjXBBx+J7HMnHgKfV8O3If0jEgsoYp
 a5sSvVO0fJHirqGtiZQHj+HEfgpimtUs46/bNiF8gv735rHWRbPPqVCxE3zY4koBuL
 ct46RIm3DXT1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/msm/adreno: keep the GPU timestamp monotonic across
 power collapse
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260828-b4-adreno-timestamp-v1-1-273525da144c@oss.qualcomm.com>
References: <20260828-b4-adreno-timestamp-v1-1-273525da144c@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 23:25:11 +0000
Message-Id: <20260827232512.4D3A71F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Faking a monotonic timestamp in MSM_PARAM_TIMESTAMP decouples it f=
rom hardware command stream timestamps, tracepoints, and performance counte=
rs.
- [Medium] The monotonic timestamp loses the elapsed time prior to a GPU ha=
ng because software reset clears the hardware counter before it can be save=
d.
- [Medium] The accumulated timestamp offset is incorrectly inflated if GPU =
suspend fails.

Pre-existing issues:
- [High] Unchecked return value from pm_runtime_get_sync() before accessing=
 hardware registers.
--

commit 4aac28caddab346efde440b7be2ebe1a2b708116
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/msm/adreno: keep the GPU timestamp monotonic across power collapse

This patch attempts to make the GPU timestamp reported to userspace monoton=
ic
across power collapses. It accumulates the elapsed time during suspend in a
software offset and adds it to the hardware counter for the MSM_PARAM_TIMES=
TAMP
ioctl.

> diff --git a/drivers/gpu/drm/msm/adreno/a4xx_gpu.c b/drivers/gpu/drm/msm/=
adreno/a4xx_gpu.c
> index 6392126f48f2e..7d9dd9460f5bb 100644
> --- a/drivers/gpu/drm/msm/adreno/a4xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a4xx_gpu.c
> @@ -593,6 +593,8 @@ static int a4xx_pm_suspend(struct msm_gpu *gpu) {
>  	struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
>  	int ret;
> =20
> +	adreno_save_timestamp(gpu);
> +
>  	ret =3D msm_gpu_pm_suspend(gpu);
>  	if (ret)
>  		return ret;

[Severity: Medium]
Will this incorrectly inflate the accumulated timestamp offset if GPU suspe=
nd
fails?

If msm_gpu_pm_suspend() returns an error, the suspend is aborted and the
hardware counter is not reset. However, adreno_save_timestamp() has already
added the current hardware counter to timestamp_offset. Could this cause
the userspace timestamp to jump forward drastically and incorrectly on a
failed suspend?

(This pattern also applies to the a5xx_pm_suspend() path in this patch.)

[ ... ]

> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/ms=
m/adreno/adreno_gpu.c
> index 3370cd44382fe..f83960b319018 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -226,6 +226,13 @@ adreno_iommu_create_vm(struct msm_gpu *gpu,
>  	return vm;
>  }
> =20
> +void adreno_save_timestamp(struct msm_gpu *gpu)
> +{
> +	struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
> +
> +	adreno_gpu->timestamp_offset +=3D adreno_gpu->funcs->get_timestamp(gpu);
> +}

[Severity: Medium]
Will the elapsed time prior to a GPU hang be lost because software reset
clears the hardware counter before it can be saved?

When a GPU hang occurs, recovery routines like a6xx_recover() and
a5xx_recover() perform a global software reset to recover the hardware,
which clears the hardware counter:

    /* Reset the GPU to a clean state */
    a6xx_gpu_sw_reset(gpu, true);
    ...
    pm_runtime_put_sync(&gpu->pdev->dev);

When the PM suspend callback later runs and calls adreno_save_timestamp(),
it will read a near-zero value. Does this cause the userspace timestamp to
jump backwards after a GPU hang?

> +
>  u64 adreno_private_vm_size(struct msm_gpu *gpu)
>  {
>  	struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);

[ ... ]

> @@ -398,7 +405,8 @@ int adreno_get_param(struct msm_gpu *gpu, struct msm_=
context *ctx,
>  	case MSM_PARAM_TIMESTAMP:
>  		if (adreno_gpu->funcs->get_timestamp) {
>  			pm_runtime_get_sync(&gpu->pdev->dev);
> -			*value =3D adreno_gpu->funcs->get_timestamp(gpu);
> +			*value =3D adreno_gpu->timestamp_offset +
> +				 adreno_gpu->funcs->get_timestamp(gpu);
>  			pm_runtime_put_autosuspend(&gpu->pdev->dev);
> =20
>  			return 0;

[Severity: High]
This is a pre-existing issue, but does the lack of a return value check for
pm_runtime_get_sync() lead to a kernel panic if the device fails to
resume?

If the device fails to resume, reading the memory-mapped timestamp register
via get_timestamp() will access an unclocked power domain. On ARM
platforms, doesn't this cause a synchronous external abort (kernel panic)?


[Severity: High]
Does faking a monotonic timestamp here decouple it from hardware command
stream timestamps, tracepoints, and performance counters?

Userspace relies on MSM_PARAM_TIMESTAMP to calibrate CPU time with GPU
hardware time. Because this patch adds a software offset here but cannot add
it to timestamps written directly to memory by the GPU
(e.g., CP_EVENT_WRITE::TIMESTAMP), the two timestamps become decoupled.

Furthermore, internal kernel tracepoints and performance counters still emit
the unadjusted timestamp:

    sample_write_u64(stream, &head,
             to_adreno_gpu(gpu)->funcs->get_timestamp(gpu));

    trace_msm_gpu_submit_flush(submit, adreno_gpu->funcs->get_timestamp(gpu=
));

Could this break userspace GPU profiling, tracing, and calibration by
destroying the correlation between the userspace timestamp and the hardware
timestamp?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-b4-adreno-=
timestamp-v1-1-273525da144c@oss.qualcomm.com?part=3D1
