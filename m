Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 611D1C53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 16:26:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BACEA10ECE6;
	Wed, 29 Jul 2026 16:26:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DepdJJj+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0843D10ECE6
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 16:26:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C7D6B43548;
 Wed, 29 Jul 2026 16:26:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ACFA1F000E9;
 Wed, 29 Jul 2026 16:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785342382;
 bh=hrQxiadJniG94MyhN4Akslspx3RbeakCM0h14vo1JAo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DepdJJj+Mhtn2eGkwErIDEcWDeQWmLpPh1imxGfw4dxqxC+oUIlB5HXfReBOqPqxz
 Txisp7+n5W75Z7pSWNnE7987XHvJSKaAkHEYyWMZSl/NvOWQNaeDH2xb3glxx/HsSA
 H2ppbyn3kftuPpxfVCJmmCFdQfp9iAHrutpoQWb/wnCr/xlVbny/y/oZzMkNl5FNTv
 Ew1AJIfrEQ+GezwXDfnaFweXL2xmZ2kdCHmxweZByykmab0xuUbW0WuBwz+h8QNdUL
 CrmqYQ2nuqKWreeEW0DsL6BW+BsWlHvkS+vWrX8rLjXMZ8SYwA5TZlkn/HnU78Pkmu
 JTL4v8QcYUSJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 13/17] drm/msm/gem: Validate lazy VM in GEM_NEW
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260729155609.20190-14-robin.clark@oss.qualcomm.com>
References: <20260729155609.20190-1-robin.clark@oss.qualcomm.com>
 <20260729155609.20190-14-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 16:26:22 +0000
Message-Id: <20260729162622.8ACFA1F000E9@smtp.kernel.org>
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
- [High] Unsafe Lazy VM Access / Null Pointer Dereference in msm_ioctl_gem_=
submit.
--

--- Patch [13]: [PATCH v7 13/17] drm/msm/gem: Validate lazy VM in GEM_NEW -=
--
commit c70d69b1e94af5ce03e9eafbf80189affee59538
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm/gem: Validate lazy VM in GEM_NEW

This commit fixes a potential NULL pointer dereference when creating a
NO_SHARE buffer object before any buffer objects are mapped. It ensures
that the lazy VM is properly initialized and supported before proceeding.

> diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
> --- a/drivers/gpu/drm/msm/msm_gem.c
> +++ b/drivers/gpu/drm/msm/msm_gem.c
> @@ -1140,9 +1140,13 @@ int msm_gem_new_handle(struct drm_device *dev, str=
uct drm_file *file,
[ ... ]
>  	if (flags & MSM_BO_NO_SHARE) {
> +		struct msm_drm_private *priv =3D dev->dev_private;
>  		struct msm_context *ctx =3D file->driver_priv;
>  		struct drm_gpuvm *vm =3D msm_context_vm(dev, ctx);
> =20
> +		if (!priv->gpu || !vm)
> +			return UERR(EINVAL, dev, "not supported with shared VM");
> +
>  		r_obj =3D drm_gpuvm_resv_obj(vm);
>  	}

[Severity: High]
This is a pre-existing issue, but seeing how msm_context_vm() is used here
to safely initialize the lazy VM, does a similar risk exist in
msm_ioctl_gem_submit() where ctx->vm is accessed directly?

If a user opens the DRM device node and immediately issues the MSM_GEM_SUBM=
IT
ioctl before any other ioctls trigger VM creation, could this sequence cause
a NULL pointer dereference?

drivers/gpu/drm/msm/msm_gem_submit.c:msm_ioctl_gem_submit() {
    ...
    if (to_msm_vm(ctx->vm)->unusable)
    ...
}

Since base is at offset 0 in struct msm_gem_vm, to_msm_vm(NULL) evaluates to
NULL. Would accessing the unusable flag immediately cause a dereference
before msm_context_vm() is called to safely initialize the VM?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729155609.2019=
0-1-robin.clark@oss.qualcomm.com?part=3D13
