Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF312C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 22:29:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1291F10F9A3;
	Fri, 10 Jul 2026 22:29:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="huKeNSQD";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62B9E10F9A3
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 22:29:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7612F60051;
 Fri, 10 Jul 2026 22:29:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB431F000E9;
 Fri, 10 Jul 2026 22:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783722546;
 bh=2s4cfhtCmFZxLAy2P0iNkX+oKLU/n60xHZMOO8xbWXg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=huKeNSQDXmN64BJnqUNfzKUh9r5LImFJlxfH31+vb+943Gnn4SlY30aS5nT/mdCyv
 9mcBuH6k60swdEbl1bf5DBAsXdtPJ9LrqcspJpFG5SldqSyeMGT/LEvBDZFytCLkaV
 OZIgudmPQJKA37UmLPNgv676EQ9CEma58Apeflqc52PwI4DQdTjMIJ07b4VLsGQ1nR
 etZ/t83WzzEbBe6AQJ6k8/URFvichUWF2kmXCw3KeqCmlFaEt4M3tGfq7jdB86uXAe
 FzW0LtDncoUIxTru7YN3s/604Yd4q76uZUvcTf9M+B6eHWmu5CDQs29pn3DyF/tRY0
 TF5jp/s0at7cg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 33/33] drm/amdgpu: Preallocate system BO pages
 outside the reservation lock
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260710215442.2444235-34-matthew.brost@intel.com>
References: <20260710215442.2444235-1-matthew.brost@intel.com>
 <20260710215442.2444235-34-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 22:29:05 +0000
Message-Id: <20260710222906.0CB431F000E9@smtp.kernel.org>
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
- [Critical] Preallocated pages can be configured with Write-Combined (WC) =
caching but assigned to a Write-Back (WB) TTM buffer object if the platform=
 rejects USWC, causing PAT aliasing and TTM pool corruption.
- [High] Unbounded memory preallocation allows unprivileged users to cause =
massive memory pressure and kernel stalls before BO size limits are checked.
--

--- Patch [33]: [PATCH v2 33/33] drm/amdgpu: Preallocate system BO pages ou=
tside the reservation lock ---
commit 4ff1d390d0b654be970d2510b2e5cd29bc266121
Author: Matthew Brost <matthew.brost@intel.com>

drm/amdgpu: Preallocate system BO pages outside the reservation lock

This commit mirrors Xe's out-of-lock preallocation for pure system BOs in
amdgpu. When a gem_create request targets only AMDGPU_GEM_DOMAIN_GTT, it
fills the full page backing up front before taking the reservation lock,
to prevent stalls in reclaim and compaction while holding the lock.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gem.c
> index 6a0699746fbcd..bef8b5bc8b892 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c

[ ... ]

> @@ -443,10 +448,29 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev,=
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
> +		int32_t xcp_id =3D adev->gmc.mem_partitions ? fpriv->xcp_id : 0;
> +		int32_t pool_id =3D amdgpu_ttm_tt_pool_id(adev, xcp_id);
> +		enum ttm_caching caching =3D
> +			(flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC) ?
> +			ttm_write_combined : ttm_cached;

[Severity: Critical]
Is it possible for the preallocated pages to be configured with write-combi=
ned
caching here, but later assigned to a write-back TTM buffer object?

If an unprivileged user requests AMDGPU_GEM_CREATE_CPU_GTT_USWC on a platfo=
rm
where amdgpu_bo_support_uswc() returns false, the code preallocates the
pages as ttm_write_combined.

Later, amdgpu_bo_create() in drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
strips the unsupported flag:

amdgpu_bo_create() {
    ...
    if (!amdgpu_bo_support_uswc(bo->flags))
        bo->flags &=3D ~AMDGPU_GEM_CREATE_CPU_GTT_USWC;
    ...
}

This creates a ttm_tt initialized as ttm_cached (write-back). When the
object is eventually destroyed, ttm_pool_free() will use the write-back
caching state, bypassing the required PAT restoration.

Does this leak the write-combined physical pages back into the kernel
allocator and cause PAT aliasing or machine check exceptions?

> +
> +		prealloc_pool =3D amdgpu_ttm_pool(adev, pool_id);
> +		ttm_pool_prealloc_fill_full(prealloc_pool, caching, &prealloc,
> +					    PFN_UP(size), false);

[Severity: High]
Could this allow unprivileged users to trigger massive memory pressure befo=
re
buffer object size limits are checked?

The user-provided size is passed directly to ttm_pool_prealloc_fill_full()
here, but the size validation against domain limits does not happen until
later in the call chain:

drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:amdgpu_bo_create() {
    ...
    if (!amdgpu_bo_validate_size(adev, size, bp->domain))
        return -ENOMEM;
    ...
}

If an unprivileged user makes an ioctl request with an excessively large si=
ze
(e.g., 100 GB), ttm_pool_prealloc_fill_full() will attempt to satisfy the
request, triggering intensive reclaim and compaction before the size is ever
validated.

Would it be safer to validate the size against domain limits before
attempting the preallocation?

> +	}
> +
>  	if (flags & AMDGPU_GEM_CREATE_VM_ALWAYS_VALID) {
>  		r =3D amdgpu_bo_reserve(vm->root.bo, false);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710215442.2444=
235-1-matthew.brost@intel.com?part=3D33
