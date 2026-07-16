Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB7CDC44512
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 20:30:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D4A410E3C2;
	Thu, 16 Jul 2026 20:30:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="obyLqcTt";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41B2910E3C2
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 20:29:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 285564375E;
 Thu, 16 Jul 2026 20:29:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29FD11F000E9;
 Thu, 16 Jul 2026 20:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784233799;
 bh=aSRGQiJitm8S9zsWThbxaqQ9pGpaxi1RAsoQHRoTV2Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=obyLqcTtazVlPziGnn6PaF4W+cIN8viIaZywAjKZrL3/2ZHtij/s8HbhhggfsDG2l
 1zX27dYI4Kwe0jvpoOwtBqe/0Sg5Tt/V7OG0YqpVqJsHVzMTUScJb/QNNG4umIgtsE
 xoJ5IEDcLDMBzM6t0Sao7X4wd70FNwRPOZq9xrEP+eoBjI/RG72jDG2M+GxQDECp0b
 1NWL2459CTSARve0LHXPU8dZztrr0H0Z4Caxdxwh5D9w57F4wVnv3F2NKyI5TjN+9Q
 Pz7U6MoYD/czrfXTm/8/kHYGwXzzVKudYRVajxgy+y94pIFNIn2lfgzfLmdjisS+5Q
 vEYzA4rljXSVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/10] drm/msm: Validate lazy VM in GEM_NEW
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260716201538.365824-9-robin.clark@oss.qualcomm.com>
References: <20260716201538.365824-1-robin.clark@oss.qualcomm.com>
 <20260716201538.365824-9-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 20:29:57 +0000
Message-Id: <20260716202958.29FD11F000E9@smtp.kernel.org>
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
- [High] The fallback logic for shared VMs in `msm_gpu_create_private_vm()`=
 is inverted, causing VM_BIND contexts to incorrectly fall back to the shar=
ed VM while legacy contexts fail to do so.

Pre-existing issues:
- [High] Concurrent modification of `obj->resv` after publishing the GEM ob=
ject to `priv->objects` causes a mismatched lock/unlock sequence if accesse=
d via debugfs.
--

--- Patch [8]: [PATCH v5 08/10] drm/msm: Validate lazy VM in GEM_NEW ---
commit b2a817e93a22417a9189cd5ad2d48b886f18f14d
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Validate lazy VM in GEM_NEW

Otherwise creating a _NO_SHARE BO before any BOs are mapped could cause
a NPE.

> diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
> index 2cb3ab04f1250..9bdbcf1279b00 100644
> --- a/drivers/gpu/drm/msm/msm_gem.c
> +++ b/drivers/gpu/drm/msm/msm_gem.c
> @@ -1147,8 +1147,16 @@ int msm_gem_new_handle(struct drm_device *dev, str=
uct drm_file *file,
>  		msm_gem_object_set_name(obj, "%s", name);
> =20
>  	if (flags & MSM_BO_NO_SHARE) {
> +		struct msm_drm_private *priv =3D dev->dev_private;
>  		struct msm_context *ctx =3D file->driver_priv;
> -		struct drm_gem_object *r_obj =3D drm_gpuvm_resv_obj(ctx->vm);
> +		struct drm_gpuvm *vm =3D msm_context_vm(dev, ctx);

[Severity: High]
Does this call to msm_context_vm() trigger inverted fallback logic for shar=
ed
VMs in drivers/gpu/drm/msm/msm_gpu.c?

When msm_context_vm() evaluates !ctx->userspace_managed_vm, it passes this =
as
the kernel_managed parameter to msm_gpu_create_private_vm().

In msm_gpu_create_private_vm(), the fallback condition is:

    if (IS_ERR_OR_NULL(vm) && !kernel_managed)
        vm =3D drm_gpuvm_get(gpu->vm);

This causes VM_BIND contexts (where kernel_managed is false) to silently fa=
ll
back to the shared VM, directly violating the intent described in the commit
'drm/msm: Don't fallback to shared VM for VM_BIND'.

Conversely, for legacy contexts (where kernel_managed is true), the fallback
is skipped. This leaves vm as NULL on legacy targets that lack private VM
support, which would break context initialization completely.

> +
> +		if (!priv->gpu || !vm) {
> +			ret =3D UERR(EINVAL, dev, "not supported with shared VM");
> +			goto out_put;
> +		}
> +
> +		struct drm_gem_object *r_obj =3D drm_gpuvm_resv_obj(vm);
> =20
>  		drm_gem_object_get(r_obj);
> =20
>  		obj->resv =3D r_obj->resv;

[Severity: High]
This is a pre-existing issue, but can this concurrent modification of
obj->resv cause a mismatched lock/unlock sequence if accessed via debugfs?

In drivers/gpu/drm/msm/msm_gem.c:msm_gem_new(), the BO is allocated,
obj->resv is initialized to &obj->_resv, and it is added to the global
priv->objects list under priv->obj_lock. This makes the object globally
visible.

If debugfs iterates over priv->objects concurrently via msm_gem_show(), it
calls msm_gem_describe(obj) which evaluates msm_gem_trylock(obj) and locks
the original &obj->_resv.

If the ioctl thread executing msm_gem_new_handle() then overwrites obj->resv
here without holding any locks, the subsequent msm_gem_unlock(obj) in debug=
fs
will unlock the new r_obj->resv (which it never locked).

This mismatched sequence would cause a kernel BUG in ww_mutex_unlock or a
lockdep splat.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716201538.3658=
24-1-robin.clark@oss.qualcomm.com?part=3D8
