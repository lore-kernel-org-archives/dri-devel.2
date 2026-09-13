Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA0FC88E5C
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 22:45:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18D6810EA54;
	Sun, 13 Sep 2026 22:45:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LvOTFiKn";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 528D910EA54
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 22:45:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 32FF1429D0;
 Sun, 13 Sep 2026 22:45:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09AF1F000FF;
 Sun, 13 Sep 2026 22:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789339537;
 bh=uOKD626mzhyVQKJC+pAUQ7WbNQ/JTER5SD41exTfuIc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LvOTFiKnf9gEe+csSIrsMvMnR9v0lKLX2PfsLMVEVoOODOp/SIBmBeqkquqK18lQP
 hyGs+HvYYIFr8KQthEfO5rPqXcKYNDn7lhIcMQhjug5T/AoMr0EgckdCBsiSYaplHN
 GWLg2T2P3KRJtzUjgr6SFvZLd/jn0T4h9pvsEN7/4oSzPHn8h/ucWBUanj2rrLMvOH
 WX43Z6VwREhn5X9G08txETdrjWhbR/lxZ/z8Xre+VQRQLetqAGyirSOccXft64q/eZ
 UKLdhsU7WkwF8H8q/v4dgXfX0FPyrkqkih5TOIdv6N8RmWAFsdVAZrqB5oh2y32X5K
 /40wypoBmzIfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] drm/qxl: reject relocations whose writes cross a
 page boundary
To: "Aldo Ariel Panzardo" <qwe.aldo@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260913223000.695299-4-qwe.aldo@gmail.com>
References: <20260913223000.695299-1-qwe.aldo@gmail.com>
 <20260913223000.695299-4-qwe.aldo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 22:45:36 +0000
Message-Id: <20260913224536.E09AF1F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] An integer overflow in `reloc.dst_offset + write_size` bypasse=
s bounds checks, leading to out-of-bounds writes within the shared command =
buffer.
- [Critical] The fallback path in `qxl_bo_kmap_atomic_page` improperly mult=
iplies an already byte-scaled offset by `PAGE_SIZE`, leading to massive out=
-of-bounds kernel memory corruption.
- [High] Type truncation of `dst_offset` and passing an unsigned value to a=
 signed `int` causes negative memory mapping before the VRAM buffer.
- [High] `qxl_bo_kmap_atomic_page` fails to increment `map_count` in the fa=
llback path when `bo->kptr` is already set, causing a reference count under=
flow when unmapped.
--

commit 9e6139abca50852ee6ddcc5adb21b30da6e7a5ae
Author: Aldo Ariel Panzardo <qwe.aldo@gmail.com>

drm/qxl: reject relocations whose writes cross a page boundary

This commit adds a check to reject relocations in the qxl driver where the
write would cross a page boundary, preventing out-of-bounds writes into the
kernel's fixmap area.

> diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl_io=
ctl.c
> index e727a35c94136..9fba6e26d048b 100644
> --- a/drivers/gpu/drm/qxl/qxl_ioctl.c
> +++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
[ ... ]
> @@ -247,6 +247,12 @@ static int qxl_process_single_command(struct qxl_dev=
ice *qdev,
[ ... ]
>  		if (reloc.dst_handle) {
>  			ret =3D qxlhw_handle_to_bo(file_priv, reloc.dst_handle, release,
>  						 &reloc_info[i].dst_bo);
>  			if (ret)
>  				goto out_free_bos;
>  			reloc_info[i].dst_offset =3D reloc.dst_offset;
>  		} else {
>  			if (reloc.dst_offset < sizeof(union qxl_release_info) ||
>  			    reloc.dst_offset + write_size >
>  			    sizeof(union qxl_release_info) + cmd->command_size) {
                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: Critical]
This isn't a bug introduced by this patch, but does the addition
reloc.dst_offset + write_size overflow?

If a user sets reloc.dst_offset to a value like 0xFFFFFFFFFFFFFFF8 (-8),
the addition of write_size (8) would wrap around to 0. Since the first check
(0xFFFFFFFFFFFFFFF8 < 40) is false, and the second check (0 > 40 +
cmd->command_size) is also false, the bounds checks are bypassed.

This could allow out-of-bounds writes into the shared cmd_bo ring buffer.

>  				ret =3D -EINVAL;
>  				goto out_free_bos;
>  			}
>  			reloc_info[i].dst_bo =3D cmd_bo;
>  			reloc_info[i].dst_offset =3D reloc.dst_offset + release->release_offs=
et;
>  		}
>=20
>  		if ((u64)reloc_info[i].dst_offset + write_size >
>  		    reloc_info[i].dst_bo->tbo.base.size) {
>  			ret =3D -EINVAL;
>  			goto out_free_bos;
>  		}
>=20
> +		if ((reloc_info[i].dst_offset & ~PAGE_MASK) + write_size >
> +		    PAGE_SIZE) {
> +			ret =3D -EINVAL;
> +			goto out_free_bos;
> +		}
> +
>  		/* reserve and validate the reloc dst bo */


While reviewing the relocation bounds checks, I noticed a few pre-existing
issues in the page mapping code called during relocations:

drivers/gpu/drm/qxl/qxl_object.c:qxl_bo_kmap_atomic_page() {
    ...
	offset =3D bo->tbo.resource->start << PAGE_SHIFT;
	return io_mapping_map_atomic_wc(map, offset + page_offset);
}

[Severity: High]
This isn't a bug introduced by this patch, but is it safe to pass page_offs=
et
as a signed int?

The callers pass dst_offset & PAGE_MASK to qxl_bo_kmap_atomic_page(). If a
user provides a large offset like 0x80000000 for a large buffer, it will be
interpreted as a negative integer (-2147483648) and sign-extended in
io_mapping_map_atomic_wc(), mapping memory before the intended physical VRAM
buffer.


drivers/gpu/drm/qxl/qxl_object.c:qxl_bo_kmap_atomic_page() {
    ...
fallback:
	if (bo->kptr) {
		rptr =3D bo->kptr + (page_offset * PAGE_SIZE);
		return rptr;
	}

	ret =3D qxl_bo_vmap_locked(bo, &bo_map);
	if (ret)
		return NULL;
	rptr =3D bo_map.vaddr;

	rptr +=3D page_offset * PAGE_SIZE;
	return rptr;
}

[Severity: Critical]
This isn't a bug introduced by this patch, but is page_offset incorrectly
multiplied by PAGE_SIZE here?

The callers already pass a byte-scaled offset (e.g., info->dst_offset &
PAGE_MASK) as the page_offset argument. If the fallback path is taken
(e.g. for a buffer in TTM_PL_SYSTEM), multiplying this byte offset by
PAGE_SIZE again causes a massive out-of-bounds kernel pointer calculation.


[Severity: High]
This isn't a bug introduced by this patch, but does the fallback path fail
to update the map count when bo->kptr is already set?

drivers/gpu/drm/qxl/qxl_object.c:qxl_bo_kmap_atomic_page() {
    ...
fallback:
	if (bo->kptr) {
		rptr =3D bo->kptr + (page_offset * PAGE_SIZE);
		return rptr;
	}
    ...
}

If a buffer is already mapped via the fallback path (for instance, exported
via PRIME and vmapped by another driver), returning bo->kptr without
incrementing map_count creates a mismatch.

When it is later unmapped:

drivers/gpu/drm/qxl/qxl_object.c:qxl_bo_kunmap_atomic_page() {
    ...
 fallback:
	qxl_bo_vunmap_locked(bo);
}

The qxl_bo_vunmap_locked() function unconditionally decrements map_count to=
 0,
prematurely unmapping the buffer while the original map user is still activ=
e.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913223000.6952=
99-1-qwe.aldo@gmail.com?part=3D3
