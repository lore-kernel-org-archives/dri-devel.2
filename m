Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A6F0CA5FE0
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 09:13:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9A0110F7ED;
	Fri,  2 Oct 2026 09:13:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WBkJoOWw";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C9A210F7ED;
 Fri,  2 Oct 2026 09:13:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E5E0460A79;
 Fri,  2 Oct 2026 09:13:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE4161F000FF;
 Fri,  2 Oct 2026 09:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790932436;
 bh=6nWr69HDxmm+vFpnQEK8/qJOpOn5sUvuGNijObMZabg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WBkJoOWwfPnKW3DThlJuXz+JjbpY4tYGpXTFUER8tRMNzgM+ubvazMcHxpSyEBzj3
 p01i8yFKNPkxhcG4bctcHIVn/gcMNQKosFZH98+DQbyehv1D5nnfcpkQWeJpUqVmgE
 Z6g2MpegjSt21IPTJ1paVj4xnxEkAuzq/EbTpTxzdN4TJ+g7Cg/0GVNZWQyllLcQk/
 Akq8a7XNONYhEqAEGGqoTiP6JNCn2OxALYd0btnYdIGELSJ8dvxOow4M4lI0velAza
 tUV40M3gR+dNGadZSqbGHGhyAL6dWSg4m94Oftq8fqcMU+B7e9dxixLSVlp4w1NWbU
 UFGVqPC5Aiiqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/8] drm/nouveau: use DRM_GPUVM_RESV_PROTECTED
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20261001220632.3190896-8-matthew.brost@intel.com>
References: <20261001220632.3190896-1-matthew.brost@intel.com>
 <20261001220632.3190896-8-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:13:55 +0000
Message-Id: <20261002091355.EE4161F000FF@smtp.kernel.org>
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
- [High] drm/nouveau: silently ignored lock failure causes unprotected list=
 access
--

commit 8fab8734d6eb64d1f1dd2d598d76c6f17c6efddd
Author: Matthew Brost <matthew.brost@intel.com>
Subject: drm/nouveau: use DRM_GPUVM_RESV_PROTECTED

This commit sets DRM_GPUVM_RESV_PROTECTED for the nouveau drm_gpuvm. It
introduces nouveau_uvmm_lock_vm_and_obj() to lock the VM's dma-resv together
with the object's dma-resv when dropping a reference to a drm_gpuvm_bo.

> diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nou=
veau/nouveau_uvmm.c
> index fc125fd44a9b7..13e11905b5f97 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
[ ... ]
> @@ -1184,6 +1184,27 @@ bind_validate_region(struct nouveau_job *job)
>  	return 0;
>  }
> =20
> +/*
> + * Lock the VM's common dma-resv together with the one of @obj, as neede=
d to
> + * drop what may be the last reference of a &drm_gpuvm_bo.
> + */
> +static void
> +nouveau_uvmm_lock_vm_and_obj(struct nouveau_uvmm *uvmm, struct drm_exec =
*exec,
> +			     struct drm_gem_object *obj)
> +{
> +	int ret;
> +
> +	drm_exec_init(exec, DRM_EXEC_IGNORE_DUPLICATES, 2);
> +	drm_exec_until_all_locked(exec) {
> +		ret =3D drm_exec_lock_obj(exec, drm_gpuvm_resv_obj(&uvmm->base));
> +		if (!ret)
> +			ret =3D drm_exec_lock_obj(exec, obj);
> +		drm_exec_retry_on_contention(exec);
> +		if (drm_WARN_ON(uvmm->base.drm, ret))
> +			break;

[Severity: High]
If drm_exec_lock_obj() fails with an error like -ENOMEM (which can occur
during internal memory allocations), the loop hits this break and returns.

Does this mean the function returns without fully acquiring the necessary
locks, while hiding the failure from the caller because of the void return
type?

> +	}
> +}
[ ... ]
> @@ -1594,9 +1625,11 @@ nouveau_uvmm_bind_job_cleanup(struct nouveau_job *=
job)
>  			drm_gpuva_ops_free(&uvmm->base, op->ops);
> =20
>  		if (!IS_ERR_OR_NULL(op->vm_bo)) {
> -			dma_resv_lock(obj->resv, NULL);
> +			struct drm_exec exec;
> +
> +			nouveau_uvmm_lock_vm_and_obj(uvmm, &exec, obj);
>  			drm_gpuvm_bo_put(op->vm_bo);

[Severity: High]
If nouveau_uvmm_lock_vm_and_obj() fails and returns without holding the
dma_resv locks, will calling drm_gpuvm_bo_put() here result in unprotected
concurrent list operations?

The caller assumes the locks are securely held. Functions like
drm_gpuvm_bo_put() can modify obj->gpuva.list and gpuvm->extobj.list.

Under memory pressure on a shared GEM object, could this lead to list
corruption or a use-after-free?

> -			dma_resv_unlock(obj->resv);
> +			drm_exec_fini(&exec);
>  		}
> =20
>  		if (obj)
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001220632.3190=
896-1-matthew.brost@intel.com?part=3D7
