Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BFB9C98318
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 18:20:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7D1710F706;
	Thu, 24 Sep 2026 18:20:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FMgyBWhf";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74DA410F706
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 18:20:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A6FB9601DE;
 Thu, 24 Sep 2026 18:20:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35BFE1F000FF;
 Thu, 24 Sep 2026 18:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790274009;
 bh=FEztb1FKId69xAhcDTn191lMeV6bmfqMBdQKBXrpaNo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FMgyBWhfwfh4znj0Vt34sr+4kKJ2Xs0bs+yquTbEdl6C/YmY+Eh6J7MyEW+JAJRZ/
 bxjNpVE2CQgG2YN1JWasR/0kIcDm/5aw+n1z+Ej9dv8RQcGX/2jDwalf9pzOukLN3H
 PpxsDmhwBVF3/w3xZ3FWmeW9otnHQkZs+/tadNJgTFJj1EQPYmVeak2C5ju2LxTmC7
 aIAFxMLENK/B2jg16jMD52YGXYpHkvCfjRipwzR1sViY/vaNB2g5vNYUXxygL86JrI
 2u5Yt8aWdqAnHfDMfH19wxIv+cqiei4VR97trKMdPaBe6X9sWJVedQHwtzY/DSm/et
 MGxhz3pZdoXRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 11/15] drm/panfrost: Move perfcnt GPU disable
 sequence into a helper
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260924-claude-fixes-v10-11-755929b3cc19@collabora.com>
References: <20260924-claude-fixes-v10-0-755929b3cc19@collabora.com>
 <20260924-claude-fixes-v10-11-755929b3cc19@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 18:20:08 +0000
Message-Id: <20260924182009.35BFE1F000FF@smtp.kernel.org>
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
- [Medium] panfrost: potential hw bug trigger due to reversed perfcnt disab=
le sequence
--

commit 955ad49004b82d4c7b4dae93b28817ea9431d397
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Move perfcnt GPU disable sequence into a helper

This commit introduces a helper function panfrost_perfcnt_hw_disable to
handle the GPU performance counter disable sequence. It updates the existing
disable and init/fini paths to use this new helper to avoid code repetition.

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

[Severity: Medium]
Could this sequence reversal cause a hardware lockup or undefined behavior?

The new panfrost_perfcnt_hw_disable() helper reverses the previous order by
setting GPU_PERFCNT_CFG to OFF while the enable registers are still enabled.

Modifying GPU_PERFCNT_CFG while TILER_EN is actively enabled during the
teardown path might risk triggering hardware malfunctions similar to the
PRLAM-8186 issue, which requires TILER_EN to be 0 before modifying
GPU_PERFCNT_CFG to enable counters.

Does this disable sequence need to preserve the original ordering seen in
panfrost_perfcnt_disable_locked()?

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

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924-claude-fix=
es-v10-0-755929b3cc19@collabora.com?part=3D11
