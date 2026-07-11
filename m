Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5A28C43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 03:28:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C897110E70C;
	Sat, 11 Jul 2026 03:28:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TZXxbIhw";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35C1A10E70C
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 03:28:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 51393600C3;
 Sat, 11 Jul 2026 03:28:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A0A21F000E9;
 Sat, 11 Jul 2026 03:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783740487;
 bh=NvL6OG0ZjDvsElc/sXPE9LQTNNuaDgTaXxWq5/Gx4yo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TZXxbIhwdOXhxAyl2MDGuBTvcXiD6X9127weX55wDnyO7V1d+Orb31Y5x0QVXAHzr
 fv3K1Uld1vK90NdzU/eKMrkn+TEzfmuG+qQFsm6ZbU6DTgDe4TX5Eu3V19y+8eea3A
 JgIwtaQHskimV4cMLTdi4JJ/edp+sNAWrQWL99dSGvicXuWfgWivlkdb82Mv3XtzeH
 coaPMmsJK3JNZ6EZAsOJQNkAREDce6BFjHVerfBjMAKV4l5M8ihZ0z+sENCl7GjTdP
 02MfbTBUVfYGLe53DzC3mkzKUvmDGmf/IVhcRfAQuIU2Fe1ZiUnXGz2EH2k7ZC6d+6
 gANklgDLJiFlg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 33/33] drm/amdgpu: Preallocate system BO pages
 outside the reservation lock
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260711025619.2540575-34-matthew.brost@intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-34-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 03:28:07 +0000
Message-Id: <20260711032807.9A0A21F000E9@smtp.kernel.org>
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
- [Medium] TOCTOU race on `fpriv->xcp_id` causes pool allocation mismatches=
 and potential NUMA pool pollution.
--

--- Patch [33]: [PATCH v3 33/33] drm/amdgpu: Preallocate system BO pages ou=
tside the reservation lock ---
commit 4e5e075ea8b2b453d727a0f32343eda951ff2819
Author: Matthew Brost <matthew.brost@intel.com>
drm/amdgpu: Preallocate system BO pages outside the reservation lock

This commit introduces out-of-lock preallocation for pure system buffer
objects to avoid stalling under the reservation lock. By mirroring the Xe
driver's approach, it fills the full page backing up front before taking the
lock.

> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
[ ... ]
> @@ -443,10 +448,57 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev,=
 void *data,
>  		flags |=3D AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
>  	}
> =20
> +	/*
> +	 * For system-only (pure GTT) BOs, preallocate the whole page backing
> +	 * up front, outside the reservation lock. Populate under the lock then
> +	 * just installs these pages instead of reclaiming/compacting in the
> +	 * critical section. Best-effort: a short fill falls back to the normal
> +	 * in-lock allocation for the missing pages.
> +	 */
> +	if (args->in.domains =3D=3D AMDGPU_GEM_DOMAIN_GTT) {
> +		struct ttm_resource_manager *gtt_man =3D
> +			ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
> +		int32_t xcp_id =3D adev->gmc.mem_partitions ? fpriv->xcp_id : 0;
> +		int32_t pool_id =3D amdgpu_ttm_tt_pool_id(adev, xcp_id);

[ ... ]

> @@ -455,7 +507,8 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, v=
oid *data,
>  retry:
>  	r =3D amdgpu_gem_object_create(adev, size, args->in.alignment,
>  				     initial_domain,
> -				     flags, ttm_bo_type_device, resv, &gobj, fpriv->xcp_id + 1);
> +				     flags, ttm_bo_type_device, resv, &gobj,
> +				     fpriv->xcp_id + 1, prealloc_pool ? &prealloc : NULL);

[Severity: Medium]
Is it possible for fpriv->xcp_id to change between these two reads?

If a concurrent thread updates fpriv->xcp_id (for example, via context
creation in amdgpu_xcp_select_scheds changing it from AMDGPU_XCP_NO_PARTITI=
ON
to a specific partition), the first read could select the generic TTM pool
for preallocation.

The second read could then evaluate to a specific partition, initializing
the BO with the partition-specific TTM pool. Could this mismatch result
in pages allocated from the generic pool being consumed by the partition
pool, potentially degrading NUMA locality or causing accounting mismatches?

Would it be safer to read fpriv->xcp_id once into a local variable and pass
that same value to both amdgpu_ttm_tt_pool_id() and
amdgpu_gem_object_create()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711025619.2540=
575-1-matthew.brost@intel.com?part=3D33
