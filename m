Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B05CA5FA1
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 03:55:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFB0F10E06B;
	Tue, 29 Sep 2026 03:55:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JEc4I3vj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C55D910E06B
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 03:54:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7A78640716;
 Tue, 29 Sep 2026 03:54:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3296F1F000FF;
 Tue, 29 Sep 2026 03:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790654099;
 bh=cQ77VYZ7Z4sW34S/reMTq7UIQwRfz5/ntdmbF2XFx3s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JEc4I3vjzBWOhZSGdkz0LNsCt5bnhMK6cs3hJBLoODKgap+viOCQBAK147DhAK6BQ
 Gw/t1j7NFcILH7U7QHdXBEMwGczFWAt0YH1wht46LtTFOe1dRBeTVyUHsCTqHOS+X/
 JVrPF0xn2X+xRjbM4uyZhuR8uWysJxC2VSQopwuq90QZ+x9HRM21ga7pb9Cv2n2RLW
 LDy/pi99iei6ix+iC33n+BS7jb5fBl4NZrr3plK+zb3Yd3xaa9d+OjnxGSg09iJsOy
 1o65OX0QcGTFIfZ91nOKBiqXJMyChrGz8mrHCNECpCRkPeWk26g4UF4VPvbFTjDf/s
 +dJrDLXo+IdcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 11/15] drm/panfrost: Move perfcnt GPU disable
 sequence into a helper
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260929-claude-fixes-v12-11-62beb08de207@collabora.com>
References: <20260929-claude-fixes-v12-0-62beb08de207@collabora.com>
 <20260929-claude-fixes-v12-11-62beb08de207@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 03:54:58 +0000
Message-Id: <20260929035459.3296F1F000FF@smtp.kernel.org>
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
- [High] drm/panfrost: inverted hardware disable sequence risks spurious du=
mp
--

commit 3efe7a19ba3bb185c762f241fc91b732bd783ed3
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Move perfcnt GPU disable sequence into a helper

This commit introduces a helper function to avoid repetition of the hardware
performance counter disable sequence.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/dr=
m/panfrost/panfrost_perfcnt.c
> index 7020c0192e189..f71534e741b65 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> @@ -35,6 +35,16 @@ struct panfrost_perfcnt {
>  	struct completion dump_comp;
>  };
> =20
> +static void panfrost_perfcnt_hw_disable(struct panfrost_device *pfdev)
> +{
> +	gpu_write(pfdev, GPU_PERFCNT_CFG,
> +		  GPU_PERFCNT_CFG_MODE(GPU_PERFCNT_CFG_MODE_OFF));
> +	gpu_write(pfdev, GPU_PRFCNT_JM_EN, 0x0);
> +	gpu_write(pfdev, GPU_PRFCNT_SHADER_EN, 0x0);
> +	gpu_write(pfdev, GPU_PRFCNT_MMU_L2_EN, 0x0);
> +	gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0);
> +}

[Severity: High]
Does this sequence introduce a risk of a spurious hardware dump?

The new helper turns off the GPU_PERFCNT_CFG register before disabling the
individual block counters, which reverses the previous safe sequence in
panfrost_perfcnt_disable_locked() where the EN registers were cleared first.

Modifying the CFG register while TILER_EN is still active might trigger a
spurious dump. This seems similar to hardware erratum PRLAM-8186, which
requires TILER_EN to be off before modifying the CFG register to enable
counters.

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
> +	panfrost_perfcnt_hw_disable(pfdev);
> =20
>  	perfcnt->user =3D NULL;
>  	drm_gem_vunmap(&perfcnt->mapping->obj->base.base, &map);

[Severity: High]
Could a spurious hardware dump here result in memory corruption?

Because the inverted hardware disable sequence is invoked while TILER_EN is
active, a spurious hardware dump would cause the GPU to write to the
performance counter buffer asynchronously.

Since panfrost_perfcnt_disable_locked() immediately tears down and unmaps
this memory via drm_gem_vunmap(), could the GPU perform a DMA write-after-f=
ree,
leading to an IOMMU fault or memory corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929-claude-fix=
es-v12-0-62beb08de207@collabora.com?part=3D11
