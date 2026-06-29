Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD924C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 20:32:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF68E10EA44;
	Mon, 29 Jun 2026 20:32:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="j8l+ZOop";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D7EE10EA44
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 20:32:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2D2EB42DE1;
 Mon, 29 Jun 2026 20:32:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E43C31F000E9;
 Mon, 29 Jun 2026 20:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782765155;
 bh=wOfUt76bh5n/pLtaivoNddTmvrEeGkze8H+fiEH4SpY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=j8l+ZOopi5qxk2/ngAoT3dI27LEOgAf3rEQFH3zmZ1wcJaMeQ8nyOWQsBe7oxI9Ic
 iznUcYtIeDH/wV0AyKBMMgMxePJZ3cfzUb4wabmMeHkIumO+DkKSjROoVulp+oXKdw
 f1ZHgO54CfORqAEZ7+hgIGXIo/5/VMXjLmvxS13BSSjrThN3AQqYe6J7lDrLR0rf07
 baRLd2lNh15l9K6bnvK4EXFvnXEbFvarof7m1DCmFVvHeNorX8oq4pcyyvqMavqd/l
 Zc07fJ8S8rHgZa0byrTDwLInD/k+Rpn4R5/ROxZgn3VdXGbEGkaPEPGsxVo3zvSEm8
 yUO+RPi9hPVIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] drm/panthor: Check for sparse binding range
 overflow
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260629-vm_bind_checks-v3-4-85e6740f6c2e@collabora.com>
References: <20260629-vm_bind_checks-v3-0-85e6740f6c2e@collabora.com>
 <20260629-vm_bind_checks-v3-4-85e6740f6c2e@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 20:32:34 +0000
Message-Id: <20260629203234.E43C31F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Low] The newly added overflow check in `panthor_vm_prepare_unmap_op_ctx`=
 is mathematically dead code because the `MAP_SPARSE` flag is explicitly re=
jected for UNMAP operations.
- [Low] The overflow check in `panthor_vm_prepare_map_op_ctx` is artificial=
ly restricted to sparse mappings, bypassing early protection for non-sparse=
 mappings.

Pre-existing issues:
- [High] Unbounded sparse mappings allow unprivileged users to instantly co=
nsume massive amounts of un-accounted kernel memory, causing system-wide OO=
M (Denial of Service).
--

commit 5e16f4b93a1093aa035900789a27182078dc6a8d
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panthor: Check for sparse binding range overflow

This commit adds checks to prevent sparse binding range overflows early in
the driver before GPUVM functions are invoked. This avoids wasting time
allocating vm_bind context resources.

Closes: https://sashiko.dev/#/message/20260623204220.CDB1B1F000E9%40smtp.ke=
rnel.org
Fixes: 12cf826bf1dd ("drm/panthor: Support sparse mappings")

> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/pant=
hor/panthor_mmu.c
> index 77fdad4e51665..8bd9b975e5ce2 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c

[ ... ]

> @@ -1353,6 +1354,10 @@ static int panthor_vm_prepare_map_op_ctx(struct pa=
nthor_vm_op_ctx *op_ctx,
>  	if (is_sparse && (op->bo_handle || op->bo_offset))
>  		return -EINVAL;
> =20
> +	/* Protect against sparse VA range overflow */
> +	if (is_sparse && check_add_overflow(op->va, op->size, &end))
> +		return -EINVAL;
> +

[Severity: Low]
Is this overflow check artificially restricted to sparse mappings?

If a non-sparse mapping request overflows the 64-bit bounds, the wrapped sum
bypasses the vm->user_va_range check and misses this new early check. The
driver will needlessly pin the BO and pre-allocate context resources before
safely failing downstream in drm_gpuvm_sm_map().

Would dropping the is_sparse condition here correctly fail early for both
sparse and non-sparse mappings?

[Severity: High]
This is a pre-existing issue, but does the lack of accounting on pt_cache
allow untrusted users to cause a system-wide OOM?

When a user submits a sparse mapping request with a massive size (e.g., 512=
GB)
and va =3D 0, it skips the backing GEM size validations. In
panthor_vm_op_ctx_prealloc_pts(), pt_count is calculated assuming the entire
range needs full L1-L3 page tables:

drivers/gpu/drm/panthor/panthor_mmu.c:panthor_vm_op_ctx_prealloc_pts() {
    ...
    ret =3D kmem_cache_alloc_bulk(pt_cache, GFP_KERNEL, pt_count,
                                op_ctx->rsvd_page_tables.pages);
    ...
}

Because pt_cache is created without the SLAB_ACCOUNT flag:

drivers/gpu/drm/panthor/panthor_mmu.c:panthor_mmu_pt_cache_init() {
    pt_cache =3D kmem_cache_create("panthor-mmu-pt", SZ_4K, SZ_4K, 0, NULL);
    ...
}

Can a local user execute this ioctl concurrently in a loop, draining tens of
gigabytes of memory that remain invisible to cgroup limits, to crash the ho=
st?

>  	/* If the BO has an exclusive VM attached, it can't be mapped to other =
VMs. */
>  	if (bo->exclusive_vm_root_gem &&
>  	    bo->exclusive_vm_root_gem !=3D panthor_vm_root_gem(vm))

[ ... ]

> @@ -1432,6 +1439,10 @@ static int panthor_vm_prepare_unmap_op_ctx(struct =
panthor_vm_op_ctx *op_ctx,
>  	if (op->va !=3D ALIGN(op->va, SZ_2M))
>  		pt_count++;
> =20
> +	/* Protect against sparse VA range overflow */
> +	if (is_sparse && check_add_overflow(op->va, op->size, &end))
> +		return -EINVAL;
> +

[Severity: Low]
Is this overflow check mathematically dead code?

In panthor_vm_bind_prepare_op_ctx(), any UNMAP operation containing flags
outside of DRM_PANTHOR_VM_BIND_OP_TYPE_MASK (which includes MAP_SPARSE) is
explicitly rejected with -EINVAL.

Because of this, is_sparse will evaluate to false unconditionally for UNMAP
operations, causing this check to always be skipped.

>  	if (op->va + op->size !=3D ALIGN(op->va + op->size, SZ_2M) &&
>  	    ALIGN(op->va + op->size, SZ_2M) !=3D ALIGN(op->va, SZ_2M))
>  		pt_count++;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-vm_bind_ch=
ecks-v3-0-85e6740f6c2e@collabora.com?part=3D4
