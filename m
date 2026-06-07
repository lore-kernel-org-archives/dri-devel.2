Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D128CD8C88
	for <dri-devel@archiver.kernel.org>; Sun,  7 Jun 2026 14:15:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E7C110EA61;
	Sun,  7 Jun 2026 14:14:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="krMZUm6u";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B23510EA61
 for <dri-devel@lists.freedesktop.org>; Sun,  7 Jun 2026 14:14:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id ECDE4600AE;
 Sun,  7 Jun 2026 14:14:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB2B1F00893;
 Sun,  7 Jun 2026 14:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780841697;
 bh=vgdliUEBvklGgzSeOsfYt11bYz84ZYVYuggWC9e/SX0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=krMZUm6uuQxK3e1KIJS6a8PUP6fAZ4310iVYdpKF2jKlKJoU+Lrj8dEqRz4PXHe3C
 8UbPo9pnAXOF3H8uprt+gT0w7R4rDsrPTX3TwBzapkqfAQXMaXK3DX0ltj0npkfsYe
 bqbmwUxtyJmsPCxWW3gl6Ky2CuOi3d7Jf5ZGPL5KiMfPk/xc2knwt43OWpnmFW4CUk
 PLIsA9a/Q5AP5xGo50+1a38YWESGhvT8wRu5SnpogS8UjxvqWEcwSLRpTEges0x2oR
 W9U/v90e+pif5YTy3ZQtARh5lU76U+VTbRQGOe2/+j8jUZmTQjIfOIbaeCLQpjgFoZ
 POA3QFShLCWKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/msm: Validate lazy VM in GEM_NEW
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260607140159.137068-3-robin.clark@oss.qualcomm.com>
References: <20260607140159.137068-3-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 14:14:57 +0000
Message-Id: <20260607141457.7DB2B1F00893@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] Calling DRM_IOCTL_MSM_GEM_NEW with the MSM_BO_NO_SHARE flag on=
 a device without a GPU causes a NULL pointer dereference.
- [High] Lockless fast-path reading of `ctx->vm` lacks acquire/release memo=
ry barriers, allowing concurrent threads to observe and access a partially =
initialized `drm_gpuvm` structure.
--

commit e440c951a727aa924c22337cdf0290e20b62ff2e
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Validate lazy VM in GEM_NEW

Otherwise creating a _NO_SHARE BO before any BOs are mapped could cause
a NPE.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: b58e12a66e47 ("drm/msm: Add _NO_SHARE flag")
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>

> diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
> index 2cb3ab04f1250..ef14ee66c6c30 100644
> --- a/drivers/gpu/drm/msm/msm_gem.c
> +++ b/drivers/gpu/drm/msm/msm_gem.c
> @@ -1148,7 +1148,8 @@ int msm_gem_new_handle(struct drm_device *dev, stru=
ct drm_file *file,
> =20
>  	if (flags & MSM_BO_NO_SHARE) {
>  		struct msm_context *ctx =3D file->driver_priv;
> -		struct drm_gem_object *r_obj =3D drm_gpuvm_resv_obj(ctx->vm);
> +		struct drm_gpuvm *vm =3D msm_context_vm(dev, ctx);

[Severity: High]
This isn't a bug introduced by this patch, but does the implementation of
msm_context_vm() lack necessary memory barriers?

Looking at msm_context_vm() in drivers/gpu/drm/msm/msm_drv.c:

	if (ctx->vm)
		return ctx->vm;

	mutex_lock(&init_lock);
	if (!ctx->vm) {
		ctx->vm =3D msm_gpu_create_private_vm(...);
	}
	mutex_unlock(&init_lock);

Since the fast-path reads ctx->vm without smp_load_acquire() and the write
happens without smp_store_release(), can a concurrent ioctl thread observe a
non-NULL ctx->vm pointer before the underlying drm_gpuvm structure is fully
initialized (such as setting vm->r_obj) on weakly-ordered architectures?

> +		struct drm_gem_object *r_obj =3D drm_gpuvm_resv_obj(vm);

[Severity: Critical]
This is a pre-existing issue, but does msm_context_vm() return NULL on
display-only configurations where the GPU fails to probe (priv->gpu =3D=3D =
NULL)?

If msm_context_vm() returns NULL, wouldn't passing it to drm_gpuvm_resv_obj=
(vm)
cause an immediate NULL pointer dereference since the macro unconditionally
expands to ((vm)->r_obj) here?

> =20
>  		drm_gem_object_get(r_obj);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260607140159.1370=
68-1-robin.clark@oss.qualcomm.com?part=3D2
