Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44326C54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 16:09:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0F1310ECDE;
	Wed, 29 Jul 2026 16:09:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AY0xho8e";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A31710ECDE
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 16:09:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2BEFA6004E;
 Wed, 29 Jul 2026 16:09:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA35F1F00A3A;
 Wed, 29 Jul 2026 16:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785341384;
 bh=lgWXJujoZ+s+ktBfFf+NbI8AzDs/S2TzFaNJuOrp5fI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AY0xho8e0W8tUScvKZeNTXBf0ENxir0KWQK7dU9e+hvPG37qjdNWRiW48X5zsFUoA
 vzOq5PLSeq0SnuzxAMUAyMcVh0aEkTsrrknM9qURGG8omhobzHWjJgrWQpsbJyX4IB
 HdVMm2uElVBpm0wIgf5C5leaTOwU/NvQc7AdZEe4xXoG5K4bzhBOUvS4rY/7gKd6JN
 qJnZ5YPrZJ686hPVd10hBdipcuCyNmV396KwnhKM1pbZW2nTx8bqk+wos3ezB8m0eY
 QxI3oclCfSNqxhK++vfJD+S0hPjLLN85LnXRLmgXE0ZNbLn49v79k1JkuvVo/lxfiL
 l6SdfIPV5sGAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 06/17] drm/msm: Remove redundant SIZE_MAX check
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260729155609.20190-7-robin.clark@oss.qualcomm.com>
References: <20260729155609.20190-1-robin.clark@oss.qualcomm.com>
 <20260729155609.20190-7-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 16:09:44 +0000
Message-Id: <20260729160944.AA35F1F00A3A@smtp.kernel.org>
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

Pre-existing issues:
- [High] NULL pointer dereference from direct access to `ctx->vm` before VM=
 initialization.
--

--- Patch [6]: [PATCH v7 06/17] drm/msm: Remove redundant SIZE_MAX check ---
commit 704799112fb8f5dd4e2424f4cac69e1d4b373f9d
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Remove redundant SIZE_MAX check

This commit removes a redundant SIZE_MAX overflow check in submit_lookup_cm=
ds().
Since kmalloc() will inherently fail and return NULL when passed SIZE_MAX,
the explicit check is unnecessary.

> diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/m=
sm_gem_submit.c
> index aa48ea4e7f584..040354ee16d11 100644
> --- a/drivers/gpu/drm/msm/msm_gem_submit.c
> +++ b/drivers/gpu/drm/msm/msm_gem_submit.c
> @@ -250,11 +250,6 @@ static int submit_lookup_cmds(struct msm_gem_submit =
*submit,
> =20
>  		sz =3D array_size(submit_cmd.nr_relocs,
>  				sizeof(struct drm_msm_gem_submit_reloc));
> -		/* check for overflow: */
> -		if (sz =3D=3D SIZE_MAX) {
> -			ret =3D -ENOMEM;
> -			goto out;
> -		}
>  		submit->cmd[i].relocs =3D kmalloc(sz, GFP_KERNEL | __GFP_NOWARN);
>  		if (!submit->cmd[i].relocs) {
>  			ret =3D -ENOMEM;

[Severity: High]
This is a pre-existing issue, but I noticed it while reviewing this file.
Can this code cause a NULL pointer dereference if a local user opens a DRM
context and immediately calls the GEM submit ioctl before any VM has been
created for that context?

Looking at msm_ioctl_gem_submit() in the same file:

drivers/gpu/drm/msm/msm_gem_submit.c:msm_ioctl_gem_submit() {
    ...
	if (args->pad)
		return -EINVAL;

	if (to_msm_vm(ctx->vm)->unusable)
		return UERR(EPIPE, dev, "context is unusable");
    ...
}

The to_msm_vm() macro performs a container_of() calculation, which on a NULL
ctx->vm yields an invalid pointer offset. Dereferencing ->unusable on this
invalid pointer will cause a page fault.

Should this use msm_context_vm(dev, ctx) instead of accessing ctx->vm
directly to ensure the VM is properly initialized before checking its
unusable state?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729155609.2019=
0-1-robin.clark@oss.qualcomm.com?part=3D6
