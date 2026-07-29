Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 986A4C53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 03:03:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 010F110E644;
	Wed, 29 Jul 2026 03:03:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Rb86hBoM";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95ACF10E644
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 03:03:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6E766411EE;
 Wed, 29 Jul 2026 03:03:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D441F000E9;
 Wed, 29 Jul 2026 03:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785294211;
 bh=YbzzCT2gB3KjzkQSOWfvz+HumisTnkPrgu5NjRzwnR0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Rb86hBoMriuRJQh7XPbz/dOvhNdUc4CAKl+V7HBw6YJi2fRCwqclANv6p9gjBmtir
 ioWrLeqFDwbJykoKMRrvabg9zBYSi5iN1UkkP04ZiSGIwXLrcAFLRfNjpsCTu0SIJJ
 3XMQm+WE9cK72ikZ2oEcDPNa/7nAR4CE8+epBDmu8terSBmvSa+hQkbiFHXyacPL5S
 nHoxdI0H5amKdWnkBokairSKvjmCAmZokdIORpvbCYUyUClowrXm9RRKMJNYRpxnet
 1DZJouiMYNh5R6L3X3eSUo7DfloaecCoN8QrhbLsFtu3CcHA6vGKg2HXQIAO7urGeu
 o4ClIyOdQG/2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/13] drm/panfrost: Move perfcnt GPU disable
 sequence into a helper
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260729-claude-fixes-v4-10-01968f2ec77a@collabora.com>
References: <20260729-claude-fixes-v4-0-01968f2ec77a@collabora.com>
 <20260729-claude-fixes-v4-10-01968f2ec77a@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 03:03:30 +0000
Message-Id: <20260729030331.27D441F000E9@smtp.kernel.org>
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
- [High] Inversion of register write order when disabling performance count=
ers can cause hardware hangs or unintended asynchronous dumps.
--

--- Patch [10]: [PATCH v4 10/13] drm/panfrost: Move perfcnt GPU disable seq=
uence into a helper ---
commit 2406c3dc1e67f4022955a0b8844241dd50763d30
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Move perfcnt GPU disable sequence into a helper

This patch introduces a helper function to consolidate the sequence=20
that disables GPU performance counters. It replaces the open-coded=20
register writes across the panfrost driver to reduce repetition.

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
Does this helper invert the intended register write order?

Looking at the original implementation being replaced below, the _EN regist=
ers
were cleared before writing GPU_PERFCNT_CFG_MODE_OFF to GPU_PERFCNT_CFG. By
turning off the CFG mode first, we might violate hardware quirks like
PRLAM-8186 which require TILER_EN to be disabled before writing to CFG.

Could writing CFG while the counter enable registers are still active trigg=
er
an unintended asynchronous dump? Additionally, if the block clock-gates aft=
er
CFG is turned off, could the subsequent writes to clear the _EN registers be
ignored?

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
> =20
>  	perfcnt->user =3D NULL;
>  	drm_gem_vunmap(&perfcnt->mapping->obj->base.base, &map);

[Severity: High]
If an asynchronous dump is triggered by the inverted register order above,
could it hit unmapped memory here?

Since panfrost_perfcnt_disable_locked() immediately proceeds to unmap the BO
and tear down the MMU address space, any unexpected dump in progress would
cause an IOMMU fault and potentially a GPU reset.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729-claude-fix=
es-v4-0-01968f2ec77a@collabora.com?part=3D10
