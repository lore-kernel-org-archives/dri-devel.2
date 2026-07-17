Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CFA9C44528
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 21:06:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E27810F630;
	Fri, 17 Jul 2026 21:06:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Jou+xj/r";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6142510F604
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 21:05:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 33C874347A;
 Fri, 17 Jul 2026 21:05:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09EB1F00A3A;
 Fri, 17 Jul 2026 21:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784322355;
 bh=WKskbqyinoO+by4dgrMZeuLNJjot+LiLj5m/h6T+KWU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Jou+xj/rM+pxU+gGCIC/+jivcPnSBfBCiySlMTMd7mnN22pEJjm3675i1SsQfYh3j
 f7cTSbh1AG8lTxw3Lfmmw5+UT2186lLt1kEBfHwm9y7uG3l6Qbu8djpXP1kdLwlQ9h
 fawyz+2OZ1kza4hrDnF7iiMqGqJhcxMlzJpoEfGAG+XoJ8/gCNYg9lS4wYE7NucduC
 34PKLSB0+0GY9cyAJyxysDWYZnJA/ppeedmpqh3+meqEzVppV27j2D7kNl8b4CnMrh
 nMtUj/1U4vfPRwhbq+WBIGzAnsLqE4zKD7XFX6Yuy09pCE+8DmGaKpJI56CNtGWtWX
 4H88y2s/EgnDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 12/16] drm/msm/gem: Validate lazy VM in GEM_NEW
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260717204841.26120-13-robin.clark@oss.qualcomm.com>
References: <20260717204841.26120-1-robin.clark@oss.qualcomm.com>
 <20260717204841.26120-13-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 21:05:54 +0000
Message-Id: <20260717210554.E09EB1F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The check `!vm` fails to detect shared VMs, breaking the `MSM_BO=
_NO_SHARE` contract.

Pre-existing issues:
- [Critical] NULL Pointer Dereference when accessing uninitialized `ctx->vm=
` in `msm_ioctl_gem_submit`.
--

--- Patch [12]: [PATCH v6 12/16] drm/msm/gem: Validate lazy VM in GEM_NEW -=
--
commit 2c5a1210206f5856b0becc6857b23e80e4e3fe79
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm/gem: Validate lazy VM in GEM_NEW

This commit adds a check in msm_gem_new_handle() to ensure the VM is
available before creating a BO with MSM_BO_NO_SHARE. It prevents a NULL
pointer dereference that could occur if a BO is created before any BOs have
been mapped.

> diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
> index 12d9b8a9c360a..b9da5b7ce8a31 100644
> --- a/drivers/gpu/drm/msm/msm_gem.c
> +++ b/drivers/gpu/drm/msm/msm_gem.c
> @@ -1139,9 +1139,13 @@ int msm_gem_new_handle(struct drm_device *dev, str=
uct drm_file *file,
>  	int ret;
> =20
>  	if (flags & MSM_BO_NO_SHARE) {
> +		struct msm_drm_private *priv =3D dev->dev_private;
>  		struct msm_context *ctx =3D file->driver_priv;
>  		struct drm_gpuvm *vm =3D msm_context_vm(dev, ctx);
> =20
> +		if (!priv->gpu || !vm)
> +			return UERR(EINVAL, dev, "not supported with shared VM");
> +

[Severity: Medium]
Does the check for !vm correctly detect if a shared VM is in use?

If a platform does not support private VMs and falls back to the global
VM, msm_context_vm() will return the shared gpu->vm. In this case, !vm
will evaluate to false, allowing the allocation to proceed.

Could this allow the MSM_BO_NO_SHARE flag to succeed while silently sharing
the global reservation object, defeating the purpose of the flag and
creating hidden lock contention?

Would it be better to check if vm =3D=3D priv->gpu->vm to ensure a private
VM is actually in use?

>  		r_obj =3D drm_gpuvm_resv_obj(vm);
>  	}
> =20

[Severity: Critical]
This is a pre-existing issue, but does msm_ioctl_gem_submit() have a
similar problem with lazy VM initialization?

Looking at msm_ioctl_gem_submit() in drivers/gpu/drm/msm/msm_gem_submit.c:

	if (!gpu)
		return -ENXIO;

	if (args->pad)
		return -EINVAL;

	if (to_msm_vm(ctx->vm)->unusable)
		return UERR(EPIPE, dev, "context is unusable");

If a userspace process calls the DRM_IOCTL_MSM_GEM_SUBMIT ioctl immediately
after opening the DRM device, ctx->vm will be NULL because no previous
operation has initialized it.

Since this code accesses ctx->vm directly instead of using msm_context_vm(),
will this cause a NULL pointer dereference when to_msm_vm() evaluates to NU=
LL
and ->unusable is accessed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717204841.2612=
0-1-robin.clark@oss.qualcomm.com?part=3D12
