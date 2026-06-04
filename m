Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A78B0CD6E75
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 20:25:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2DBF11A2F1;
	Thu,  4 Jun 2026 20:25:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="POpaPPXG";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B955611A2F1
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 20:25:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 86D6E43CE1;
 Thu,  4 Jun 2026 20:25:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CDDF1F00893;
 Thu,  4 Jun 2026 20:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780604722;
 bh=tCbLSCKRFTAFnnrwh+NCRcDKno79825XHp03R9a4B5w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=POpaPPXGaDzlU4D+SPF3gZznt/tUC6HSM7ge9+8H9j5NCHqGjNd2w+dfoDAkM/ypm
 gVM5s5U5Ox9O2JDLGVmCYkr1tvuklFmSxOsbcOg2BM4pogzGWeK39vW/BnbJK6YNZ3
 5PtoYEmRUgy/bY7Wg2DmiNs63s+a1pH0FCkY9GmywbpbKCHbbjON7UvHoiwUwzk0Ax
 6J8cfhyj9/b/UchC8nQ3GMdnTWxm6QvJ+nYF4AehHbFnQnnVWF6lLilOXFZ63gfE1x
 KtUootvBAO9E7Rw7ZRGfh3RzpcjwH5dInIJXAH5tWQDvSok3d2WAnMCcPlUMQKLyMd
 6xa9mPHp1v9FQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] drm/msm/a6xx: Fix IRQ storm during msm_recovery test
To: "Akhil P Oommen" <akhilpo@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260605-assorted-fixes-june-v1-5-2caa04f7287c@oss.qualcomm.com>
References: <20260605-assorted-fixes-june-v1-5-2caa04f7287c@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 20:25:21 +0000
Message-Id: <20260604202522.4CDDF1F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Toggling `disable_err_irq` back to false via debugfs leaves hardwa=
re error interrupts permanently disabled until a GPU reset.
- [High] Writing a restrictive interrupt mask in `a6xx_irq` and `a8xx_irq` =
drops the `CP_SW` interrupt, actively breaking preemption.
- [Medium] The `recover_worker` function unilaterally clears the user-contr=
olled `disable_err_irq` debugfs boolean during GPU recovery.
--

commit c227655841882ac95655f120b99ea1eb3c758dc2
Author: Jie Zhang <jie.zhang@oss.qualcomm.com>

drm/msm/a6xx: Fix IRQ storm during msm_recovery test

This commit masks GPU error IRQs during the msm_recovery test to prevent
an interrupt storm when a hang is triggered. It then attempts to re-enable
the interrupts during GPU recovery.

> diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/=
adreno/a5xx_gpu.c
> index 2c0bbac43c52b..f1df2514c6132 100644
> --- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
[ ... ]
> @@ -1275,6 +1275,11 @@ static irqreturn_t a5xx_irq(struct msm_gpu *gpu)
>  		status & ~A5XX_RBBM_INT_0_MASK_RBBM_AHB_ERROR);
> =20
>  	if (priv->disable_err_irq) {
> +		/* Turn off interrupts to avoid interrupt storm */
> +		gpu_write(gpu, REG_A5XX_RBBM_INT_0_MASK,
> +			       A5XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS |
> +			       A5XX_RBBM_INT_0_MASK_CP_SW);
> +
>  		status &=3D A5XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS |
>  			  A5XX_RBBM_INT_0_MASK_CP_SW;
>  	}
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/=
adreno/a6xx_gpu.c
> index 8b3bb2fd433ba..9a4f9d0e17800 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -1911,8 +1911,11 @@ static irqreturn_t a6xx_irq(struct msm_gpu *gpu)
> =20
>  	gpu_write(gpu, REG_A6XX_RBBM_INT_CLEAR_CMD, status);
> =20
> -	if (priv->disable_err_irq)
> +	if (priv->disable_err_irq) {
> +		/* Turn off interrupts to avoid interrupt storm */
> +		gpu_write(gpu, REG_A6XX_RBBM_INT_0_MASK, A6XX_RBBM_INT_0_MASK_CP_CACHE=
_FLUSH_TS);

[Severity: High]
If priv->disable_err_irq is managed via debugfs_create_bool(), setting it o=
nly
updates the variable in memory.

If a user sets it to true, we mask the hardware here. However, if they
subsequently set it to false, there is no callback or mechanism to restore =
the
hardware mask back to its default state.

Does this leave hardware error detection (like AHB errors and faults)
permanently crippled until a full GPU reset occurs?

[Severity: High]
Also, writing this mask drops the CP_SW interrupt entirely.

Both a6xx (which handles A7xx) and a8xx rely on CP_SW for preemption comple=
tion
events. Physically disabling it in hardware means subsequent preemptions wi=
ll
never be signaled to the CPU as complete.

Will dropping it cause a spurious GPU hang during the test window, instead
of correctly preserving both CP_CACHE_FLUSH_TS and CP_SW like a5xx_irq() do=
es?

>  		status &=3D A6XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS;
> +	}
> =20
>  	if (status & A6XX_RBBM_INT_0_MASK_RBBM_HANG_DETECT)
>  		a6xx_fault_detect_irq(gpu);
[ ... ]
> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
> index 9ac7740a87f01..48ac51f4119be 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.c
> +++ b/drivers/gpu/drm/msm/msm_gpu.c
> @@ -552,6 +552,8 @@ static void recover_worker(struct kthread_work *work)
>  		msm_update_fence(ring->fctx, fence);
>  	}
> =20
> +	priv->disable_err_irq =3D false;

[Severity: Medium]
The disable_err_irq flag is exposed via debugfs for userspace testing tools
(like IGT msm_recovery) to intentionally bypass hardware error interrupts a=
nd
validate the software hangcheck fallback.

By forcibly clearing it here upon the first recovery, the kernel silently
overrides the user's explicit configuration.

If a test expects this flag to remain active across multiple subtests or
submissions, won't subsequent hangs unexpectedly fall back to hardware
error detection?

Since hardware interrupts are natively re-enabled by the hardware reset dur=
ing
recovery, should this debugfs flag remain strictly under user control inste=
ad
of being unilaterally cleared?

> +
>  	gpu->funcs->recover(gpu);
> =20
>  	/* retire completed submits, plus the one that hung: */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605-assorted-f=
ixes-june-v1-0-2caa04f7287c@oss.qualcomm.com?part=3D5
