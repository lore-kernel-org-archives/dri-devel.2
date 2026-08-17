Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 042FBC5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 07:07:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 672D610E699;
	Mon, 17 Aug 2026 07:07:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fx4QM6oZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50F9910E699
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 07:07:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E13C540A24;
 Mon, 17 Aug 2026 07:07:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2EAB1F000E9;
 Mon, 17 Aug 2026 07:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786950445;
 bh=FIfp5lNkzp4cLPqMS/rlGnpSH4W556pQQTOLfJb4IqQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fx4QM6oZPMHVLqmxxj3f0UbVMv6GRtICExNBLk4tAHubZjo2PImIXvJSeQRQ7XheS
 9ES2sHACoaHkF6QyMZfDevgwx3z1GVr5FgnIUGs9M4nmhLL00Lr7AA1HIXyGSqoAuY
 mR6LpUnb16yAZ8Q787i4kVbJS1WdPa6DH8W+3Vb9/W8qmb0t7AN0bVOYXBtvvzrDcS
 lN6LUsNKKaZ7/D7mLdHXuO8hSdd0LBs8QOB2FGi8Dq9DKVDsFDRllyx0I9LMuRLsaD
 8T3PiWlHNs0xgALX+QQTQj2PGE/1DTOyxD9GlH2sBC0M0jhtKfEXbSZHWuP828POl5
 ti8me3yaIiQ9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/nouveau/uvmm: reject replace across page sizes
To: "Junrui Luo" <moonafterrain@outlook.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260817-nouveau-fixes-v1-2-f518d0c735f3@outlook.com>
References: <20260817-nouveau-fixes-v1-0-f518d0c735f3@outlook.com>
 <20260817-nouveau-fixes-v1-2-f518d0c735f3@outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 07:07:25 +0000
Message-Id: <20260817070725.A2EAB1F000E9@smtp.kernel.org>
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
- [Critical] Unaligned split remainders inherit a large page shift without =
alignment validation, causing silent hardware unmap failures and VMM state =
mismatch.

Pre-existing issues:
- [High] Missing rollback for `op_unmap_prepare` in `DRM_GPUVA_OP_REMAP` er=
ror paths leads to permanent loss of GPUVM mappings.
--

--- Patch [2]: [PATCH 2/2] drm/nouveau/uvmm: reject replace across page siz=
es ---
commit 90a0db35cc87b7654c52294b9abdb178f1a05f0b
Author: Junrui Luo <moonafterrain@outlook.com>

drm/nouveau/uvmm: reject replace across page sizes

A new mapping takes over the page tables of the mappings it replaces.
nouveau_uvmm_sm_prepare() only acquires page tables for the range no
existing mapping covers, and the map path frees the replaced mappings
without putting their references. That is only valid while all of them
use the same page size, which select_page_shift() no longer guarantees.

> diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nou=
veau/nouveau_uvmm.c
> index f5e4756b4de4a..6404c54d097c1 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c

[ ... ]

> @@ -713,11 +728,22 @@ nouveau_uvmm_sm_prepare(struct nouveau_uvmm *uvmm,
>  			struct uvmm_map_args remap_args =3D {
>  				.kind =3D uvma_from_va(va)->kind,
>  				.region =3D uvma_from_va(va)->region,
> +				/* The remainders of the split keep the page
> +				 * tables of the mapping they are split from,
> +				 * so they must keep its page size too.
> +				 */
> +				.page_shift =3D uvma_from_va(va)->page_shift,

[Severity: Critical]
Does this inheritance of the parent's page shift bypass alignment checks for
unaligned split remainders?

If a process maps a BO with a 2MB-aligned address and size (creating a 2MB
page shift mapping), and then unmaps a 4K sub-region, the DRM_GPUVA_OP_REMAP
has args =3D=3D NULL. The remainder mapping inherits the 2MB page shift via
remap_args.page_shift.

When passed to op_map_prepare():

	uvma->page_shift =3D args->page_shift ? args->page_shift :
			   select_page_shift(uvmm, op);

The logic skips select_page_shift() because args->page_shift is non-zero,
assigning the 2MB page size to the remainder mapping. Could this cause the
hardware unmap operations to silently fail (e.g., nvkm_vmm_iter computing a
0 iteration count for sizes smaller than the page size)? This seems like it
could leave the memory still mapped in hardware while the kernel considers
the hole empty.

>  			};
>  			u64 ustart =3D va->va.addr;
>  			u64 urange =3D va->va.range;
>  			u64 uend =3D ustart + urange;
> =20
> +			if (map_page_shift &&
> +			    uvma_from_va(va)->page_shift !=3D map_page_shift) {
> +				ret =3D -EINVAL;
> +				goto unwind;
> +			}
> +
>  			op_unmap_prepare(r->unmap);
> =20
>  			if (r->prev) {
>  				ret =3D op_map_prepare(uvmm, &new->prev, r->prev,
>  						     &remap_args);
>  				if (ret)
>  					goto unwind;

[Severity: High]
This isn't a bug introduced by this patch, but does this error path permane=
ntly
lose the mapping from the interval tree?

If op_map_prepare() fails (for example, due to an ENOMEM from
nouveau_uvma_alloc), the code jumps to unwind. However,
nouveau_uvmm_sm_prepare_unwind() starts unwinding from drm_gpuva_prev_op(op=
),
which skips the current operation.

This means op_unmap_prepare_unwind(r->unmap) is never called to roll back
the op_unmap_prepare(r->unmap) that executed just before this. Will this le=
ave
the mapping permanently removed from the tracking tree while returning fail=
ure
to userspace?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817-nouveau-fi=
xes-v1-0-f518d0c735f3@outlook.com?part=3D2
