Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A3BECD8C8C
	for <dri-devel@archiver.kernel.org>; Sun,  7 Jun 2026 14:10:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F36210EA5C;
	Sun,  7 Jun 2026 14:10:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IUZ1KWIe";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1E8F10EA5C
 for <dri-devel@lists.freedesktop.org>; Sun,  7 Jun 2026 14:10:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CDB9060018;
 Sun,  7 Jun 2026 14:10:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A9F1F00893;
 Sun,  7 Jun 2026 14:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780841408;
 bh=bRlklbgOx8tdlxEMYD802G3v1JJNHPqtCvWZTUhKTBE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IUZ1KWIesAD/nYS1pQg0OmzdURuPo28VPytxJCUQGNaCEIwOn5jADYxll2zxMCLeQ
 TjK4g35K0NLW2/K+pHXenzWEk52zWelKBGjaSE5Ocs3Th06hKm8S6/QWpJYlfkbPO+
 Z9TzB/sHQaBvmtmdY6A2/fHiLGii9II1aVKZsGR36XHXDix4RvJd1+vNDlzHV8Vbbz
 wSOZxEPr259/k5kIYsYqWjARirhVsjwGlZBqOqJlfzA8SK2N4IPzcXTPRkyreRRjEm
 kQv8WdflY8jJ1mw4lwAF2XldMY3276X5FEcm6lqQtmRQjfsKvDweUrhOGu3D0gPeI9
 fh2ILv285hePQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/msm: Validate lazy VM is created in GEM_SUBMIT
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260607140159.137068-2-robin.clark@oss.qualcomm.com>
References: <20260607140159.137068-2-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 14:10:07 +0000
Message-Id: <20260607141008.68A9F1F00893@smtp.kernel.org>
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
- [High] MSM VM Lazy Initialization Violation: Direct access to lazily init=
ialized ctx->vm without accessor.
--

commit 1e90d5d8db7bb987e468148877a0109dc4324252
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Validate lazy VM is created in GEM_SUBMIT

This commit adds a NULL check for the context VM in the GEM_SUBMIT ioctl
to prevent a null pointer exception when submitting before any buffer
objects are mapped.

> diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/m=
sm_gem_submit.c
> index 26ea8a28be474..af564acf1f0df 100644
> --- a/drivers/gpu/drm/msm/msm_gem_submit.c
> +++ b/drivers/gpu/drm/msm/msm_gem_submit.c
> @@ -572,7 +572,7 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void=
 *data,
>  	if (args->pad)
>  		return -EINVAL;
> =20
> -	if (to_msm_vm(ctx->vm)->unusable)
> +	if (ctx->vm && to_msm_vm(ctx->vm)->unusable)

[Severity: High]
This is a pre-existing issue, but should this code use the msm_context_vm()
accessor instead of directly accessing ctx->vm here in msm_ioctl_gem_submit?

According to the DRM subsystem guidelines, accessing ctx->vm directly in io=
ctl
entry points before the VM is guaranteed to exist can be unsafe. Because
ctx->vm is initialized lazily and published without memory barriers, a
concurrent VM initialization could cause this unlocked read to observe a
non-NULL pointer but read uninitialized memory for the unusable field. Might
this lead to spurious EPIPE failures for valid submits?

>  		return UERR(EPIPE, dev, "context is unusable");
> =20
>  	/* for now, we just have 3d pipe.. eventually this would need to

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260607140159.1370=
68-1-robin.clark@oss.qualcomm.com?part=3D1
