Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B682DCD6E77
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 17:47:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C7C111A221;
	Thu,  4 Jun 2026 17:47:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OTbM4zE/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BC4811A221
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 17:47:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4CD3F4073F;
 Thu,  4 Jun 2026 17:47:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C381F00893;
 Thu,  4 Jun 2026 17:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780595243;
 bh=GmeruHLWlms6IR2rajqBUtvVHTXABEjnLihDOO77Cjc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OTbM4zE/KoRys2sEMmsMJmPXpR+nYFmsA75NtSDkyGgeO/Pt5Bp94DRZI8M5Y6dwS
 4lk4/NeZJl7uRjQgBLDMRK4ImyTt+4gdqkvgUrYJqJ2Z5+oXPlS0KErGKZocdB8npx
 ubjxNEsn1JHhiZK+6HBwokAnMtKBvYwD44Zj8W4TYIpnISboC/s3svwEXtu/v/rTcp
 la/b3PKwUAzr25EaLLwidHhRPJBV4ktFDmOkkp0bjMAL6xDaqkDcWEWcNe5aWLPaI8
 BsKUKU62B1H92WMsEyLwewBhR3MpXMXE3k50/UZW52vLRKthvAUuIwHSuX1zgEgb1q
 mqFEuPXA+4dxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/7] drm/panfrost: Move perfcnt GPU disable sequence
 into a helper
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260604-claude-fixes-v2-4-57c6bd4c1655@collabora.com>
References: <20260604-claude-fixes-v2-4-57c6bd4c1655@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 17:47:22 +0000
Message-Id: <20260604174723.08C381F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The refactored `panfrost_perfcnt_gpu_disable()` helper reverses th=
e register write sequence when disabling performance counters, potentially =
breaking the HW_ISSUE_8186 (PRLAM-8186) hardware workaround and risking har=
dware state corruption.
--

commit b1a0eb47a40de5889be52c5109cc3ee780f78598
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Move perfcnt GPU disable sequence into a helper

This commit refactors the performance counter disable sequences into a
single helper function to avoid repetition.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/dr=
m/panfrost/panfrost_perfcnt.c
> index 7020c0192e189..ad1156678e91c 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> @@ -35,6 +35,16 @@ struct panfrost_perfcnt {
>  	struct completion dump_comp;
>  };
> =20
> +static void panfrost_perfcnt_gpu_disable(struct panfrost_device *pfdev)
> +{
> +	gpu_write(pfdev, GPU_PERFCNT_CFG,
> +		  GPU_PERFCNT_CFG_MODE(GPU_PERFCNT_CFG_MODE_OFF));
> +	gpu_write(pfdev, GPU_PRFCNT_JM_EN, 0x0);
> +	gpu_write(pfdev, GPU_PRFCNT_SHADER_EN, 0x0);
> +	gpu_write(pfdev, GPU_PRFCNT_MMU_L2_EN, 0x0);
> +	gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0);
> +}

[Severity: High]
Does this new helper reverse the hardware disable sequence when called on
actively running counters?

In the original panfrost_perfcnt_disable_locked(), the block enable
registers (like GPU_PRFCNT_TILER_EN) were explicitly cleared to 0 before
the master configuration GPU_PERFCNT_CFG was turned off. The new helper
reverses this order.

Could shutting down the master configuration while sub-blocks are still
actively generating events cause hardware state corruption or bus hangs?

Modifying the main configuration while the Tiler counters are actively
enabled might also trigger hardware bugs (e.g., HW_ISSUE_8186), which the
original sequence safely avoided.

[ ... ]

> @@ -193,12 +203,7 @@ static int panfrost_perfcnt_disable_locked(struct pa=
nfrost_device *pfdev,
>  	if (user !=3D perfcnt->user)
>  		return -EINVAL;
> =20
> -	gpu_write(pfdev, GPU_PRFCNT_JM_EN, 0x0);
> -	gpu_write(pfdev, GPU_PRFCNT_SHADER_EN, 0x0);
> -	gpu_write(pfdev, GPU_PRFCNT_MMU_L2_EN, 0x0);
> -	gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0);
> -	gpu_write(pfdev, GPU_PERFCNT_CFG,
> -		  GPU_PERFCNT_CFG_MODE(GPU_PERFCNT_CFG_MODE_OFF));
> +	panfrost_perfcnt_gpu_disable(pfdev);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604-claude-fix=
es-v2-0-57c6bd4c1655@collabora.com?part=3D4
