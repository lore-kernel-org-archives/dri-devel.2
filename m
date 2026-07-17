Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C661C44515
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 21:06:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28B8510F624;
	Fri, 17 Jul 2026 21:06:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fI5wceFA";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4CED10F626
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 21:06:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 48C1F60051;
 Fri, 17 Jul 2026 21:06:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C84F61F000E9;
 Fri, 17 Jul 2026 21:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784322361;
 bh=2EvCGMwl8Wy6kd16GoNLUKOx67Gcj22P6xondvQAUPo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fI5wceFAA1V2GJ5i0mhOyzeZDNM6yFXY3dyLxkjAqjsQmGBgjAqov+CrQfc4wcweg
 sdxN3aylZyVV0NkqsPU98JQp5SlBvxFVLs6OJ4y1M0dTFxpeOSZYQqfYViw37YGaKQ
 /mKQQp4emrMLUVVW9YUptiwjGYXQVYxPieWLd5gOu4OWXyUrs8f2FiX6j/xjr4r0ff
 FDcS9TkhjwwqcePf86Et8b5YdqED1rmk4qgvlRu2EpWUgOjKFKG64U6FOCsERP+/fQ
 oGbdqgFUGPP5KZOfOtYfo886jn4SvyVGZrZt16b2uH8NFHMNboU39ieH4DyQ/3HgfJ
 RwJzshg6Ksm9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 11/16] drm/msm/gem: Set resv before exposing obj
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260717204841.26120-12-robin.clark@oss.qualcomm.com>
References: <20260717204841.26120-1-robin.clark@oss.qualcomm.com>
 <20260717204841.26120-12-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 21:06:00 +0000
Message-Id: <20260717210600.C84F61F000E9@smtp.kernel.org>
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
- [Low] The patch modifies the signature of msm_gem_new() from 3 to 4 argum=
ents but fails to update the caller in drivers/gpu/drm/msm/disp/mdp4/mdp4_k=
ms.c. This results in a compiler error ('too few arguments to function').

Pre-existing issues:
- [Critical] Missing NULL check for the return value of msm_context_vm() le=
ads to a kernel panic when dereferenced by drm_gpuvm_resv_obj(). This probl=
em wasn't introduced by this patch, but remains a critical vulnerability.
--

--- Patch [11]: [PATCH v6 11/16] drm/msm/gem: Set resv before exposing obj =
---
commit 96533966332980b8f99abb5ba08db109f97b565b
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm/gem: Set resv before exposing obj

Don't swap the resv object _after_ exposing the newly created obj in LRU
or global objects list, as that creates a race condition where another
thread could lock the object using the original (per-obj) resv, but then
unlock after the resv is replaced.

> diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
> index 961e22d3c7292..12d9b8a9c360a 100644
> --- a/drivers/gpu/drm/msm/msm_gem.c
> +++ b/drivers/gpu/drm/msm/msm_gem.c

[ ... ]

> @@ -1135,10 +1135,17 @@ int msm_gem_new_handle(struct drm_device *dev, st=
ruct drm_file *file,
>  		size_t size, uint32_t flags, uint32_t *handle,
>  		char *name)
>  {
> -	struct drm_gem_object *obj;
> +	struct drm_gem_object *obj, *r_obj =3D NULL;
>  	int ret;
> =20
> -	obj =3D msm_gem_new(dev, size, flags);
> +	if (flags & MSM_BO_NO_SHARE) {
> +		struct msm_context *ctx =3D file->driver_priv;
> +		struct drm_gpuvm *vm =3D msm_context_vm(dev, ctx);
> +
> +		r_obj =3D drm_gpuvm_resv_obj(vm);

[Severity: Critical]
This is a pre-existing issue, but can msm_context_vm() return NULL here?

If this runs on a KMS-only configuration where no GPU is bound,=20
msm_context_vm() can return NULL. When passed to drm_gpuvm_resv_obj(vm),
would this cause a NULL pointer dereference since the macro expands to
((vm)->r_obj)?

Since unprivileged userspace can trigger this path via the MSM_GEM_NEW
ioctl with the MSM_BO_NO_SHARE flag, should a NULL check be added before
accessing vm?

> +	}
> +
> +	obj =3D msm_gem_new(dev, size, flags, r_obj);

[ ... ]

> diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
> index 762e546d25ef3..47ff2bbc19150 100644
> --- a/drivers/gpu/drm/msm/msm_gem.h
> +++ b/drivers/gpu/drm/msm/msm_gem.h
> @@ -296,7 +296,7 @@ int msm_gem_cpu_fini(struct drm_gem_object *obj);
>  int msm_gem_new_handle(struct drm_device *dev, struct drm_file *file,
>  		size_t size, uint32_t flags, uint32_t *handle, char *name);
>  struct drm_gem_object *msm_gem_new(struct drm_device *dev,
> -		size_t size, uint32_t flags);
> +		size_t size, uint32_t flags, struct drm_gem_object *r_obj);

[Severity: Low]
Does this change miss updating some callers? Looking at mdp4_kms_init() in
drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c, it still calls msm_gem_new() with
only 3 arguments:

mdp4_kms->blank_cursor_bo =3D msm_gem_new(dev, SZ_16K, MSM_BO_WC | MSM_BO_S=
CANOUT);

Could this cause a build failure when CONFIG_DRM_MSM_MDP4 is enabled due to
too few arguments?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717204841.2612=
0-1-robin.clark@oss.qualcomm.com?part=3D11
