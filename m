Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC05CDE009
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 19:23:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEA7C10E25B;
	Thu, 25 Jun 2026 19:23:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dLUZ6FRq";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A200610E25B
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 19:23:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 66E2F43B04;
 Thu, 25 Jun 2026 19:23:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225381F000E9;
 Thu, 25 Jun 2026 19:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782415383;
 bh=B3/D3ru/9ynhqTXUtvnOMrdmadP3xVIBah+PdPAzeT4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dLUZ6FRq0Rc4zw+yYpBYt2yQE9LsjTXBcwDbs9R1rsph6vTP6VrM8ZSJp8mcK2q51
 bXWFTkoro37ofvPjftGJjkzleztkPBTeUqeMCz4ty32T30pDw2VhedCrZb9rRqaav0
 WhU2yFnJy4oXosWCsbdfyOqnFEsnq4doarS5ORMQgqb1Ua01zUXobZMCiPuhmaKnm5
 jdMPG7e+coYWrUIeF8w1JbU7C06iJjINDXrhg2lYUuseb/EIshZpwtsve4qCR/KpEP
 FyNu2sStHCtc3P/dOfnoa34JX8ouol8wfBynmOovku0waf9QRGS77mnil7asCUgd7q
 9WLAmg7fLvd5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] drm/msm: Validate lazy VM in GEM_NEW
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260625191537.47965-4-robin.clark@oss.qualcomm.com>
References: <20260625191537.47965-1-robin.clark@oss.qualcomm.com>
 <20260625191537.47965-4-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 19:23:02 +0000
Message-Id: <20260625192303.225381F000E9@smtp.kernel.org>
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
- [High] The newly allocated GEM object 'obj' is leaked on the error path i=
f the VM is not found or unsupported.
--

commit ebb450a0150beb70fa2ad61c737f157a48b8cb86
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Validate lazy VM in GEM_NEW

Otherwise creating a _NO_SHARE BO before any BOs are mapped could cause
a NPE.

> diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
> index efd3d3c9a4490..733a094354e1d 100644
> --- a/drivers/gpu/drm/msm/msm_gem.c
> +++ b/drivers/gpu/drm/msm/msm_gem.c
> @@ -1147,7 +1147,12 @@ int msm_gem_new_handle(struct drm_device *dev, str=
uct drm_file *file,
> =20
>  	if (flags & MSM_BO_NO_SHARE) {
>  		struct msm_context *ctx =3D file->driver_priv;
> -		struct drm_gem_object *r_obj =3D drm_gpuvm_resv_obj(ctx->vm);
> +		struct drm_gpuvm *vm =3D msm_context_vm(dev, ctx);
> +
> +		if (!vm)
> +			return UERR(EINVAL, dev, "not supported with shared VM");
                        ^^^^

[Severity: High]
Does this code leak the newly allocated obj?

Looking earlier in msm_gem_new_handle(), obj is allocated:

	obj =3D msm_gem_new(dev, size, flags);

	if (IS_ERR(obj))
		return PTR_ERR(obj);

If vm is NULL, we return directly here without calling drm_gem_object_put(o=
bj)
to release the reference.

> +
> +		struct drm_gem_object *r_obj =3D drm_gpuvm_resv_obj(vm);
> =20
>  		drm_gem_object_get(r_obj);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625191537.4796=
5-1-robin.clark@oss.qualcomm.com?part=3D3
