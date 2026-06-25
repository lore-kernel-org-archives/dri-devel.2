Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60162CDE00B
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 19:32:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBA6F10E260;
	Thu, 25 Jun 2026 19:32:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nyBKtkLK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CF2810E260
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 19:32:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1D31543F09;
 Thu, 25 Jun 2026 19:32:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE24F1F000E9;
 Thu, 25 Jun 2026 19:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782415946;
 bh=iXPNkLZRi2BlEp7vWH1rcXXJ5pLNWBuBUWky3miJJ6Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nyBKtkLKzIHbEO5+Iw/E4SMFyoIb6osggkCtVai2UjwLbNgZf61dsmKVZ7+fJz4DF
 46kyP8r4WOSrIyQWXPP3nRB6cb9H2K8sM3mvXPaLP5WbxIES0aOilv//LpVGIN8M7Y
 dSUeDLiz6nOWGj/LVf9RlNv69xIvy0x2bL707BBIKt3+qz44z/aqts0BMyVHQOOjA/
 3GM1cqYNLjf7/cQlE/AEN+dVon9JcvwHYu3tcNtzpDnNX/0+tJIoB8EC4Tw2rcCsxm
 Rv3NkmWEnMXgv5njZ0aVUufo5LMOcvS9/usJlioJZYpszOEr5qA7b/2enzbmHSjMzJ
 /L/CPm+t54hvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] drm/msm: Validate lazy VM is created in GEM_SUBMIT
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260625191537.47965-3-robin.clark@oss.qualcomm.com>
References: <20260625191537.47965-1-robin.clark@oss.qualcomm.com>
 <20260625191537.47965-3-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 19:32:25 +0000
Message-Id: <20260625193225.CE24F1F000E9@smtp.kernel.org>
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
- [Critical] The MSM_PARAM_EN_VM_BIND ioctl validation compares an uninitia=
lized context VM against the global VM, failing to prevent VM_BIND enableme=
nt on GPUs without per-process page tables.
--

commit 0fcb5ea6b90013aec15c2f186ee0bbf02e4e4818
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Validate lazy VM is created in GEM_SUBMIT
   =20
Otherwise a GEM_SUBMIT ioctl before any BOs are mapped could cause a
NPE.

> diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/m=
sm_gem_submit.c
> index 3c6bc90c3d486..56929e8212008 100644
> --- a/drivers/gpu/drm/msm/msm_gem_submit.c
> +++ b/drivers/gpu/drm/msm/msm_gem_submit.c
[ ... ]
> @@ -572,7 +573,7 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void=
 *data,
>  	if (args->pad)
>  		return -EINVAL;
> =20
> -	if (to_msm_vm(ctx->vm)->unusable)
> +	if (vm && to_msm_vm(vm)->unusable)
>  		return UERR(EPIPE, dev, "context is unusable");

[Severity: Critical]
This is a pre-existing issue, but since we are fixing lazy VM access
here, is there a similar issue in adreno_set_param() when handling
MSM_PARAM_EN_VM_BIND?

Looking at drivers/gpu/drm/msm/adreno/adreno_gpu.c:

adreno_set_param()
{
    ...
	case MSM_PARAM_EN_VM_BIND:
		/* We can only support VM_BIND with per-process pgtables: */
		if (ctx->vm =3D=3D gpu->vm)
			return UERR(EINVAL, drm, "requires per-process pgtables");

Because ctx->vm can be NULL prior to lazy initialization, this check
evaluates to false, allowing the restriction to be bypassed.

Could this allow an unprivileged user to enable userspace management
(VM_BIND) on older GPUs that fall back to the globally shared GPU VM,
and overwrite page tables shared by other processes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625191537.4796=
5-1-robin.clark@oss.qualcomm.com?part=3D2
