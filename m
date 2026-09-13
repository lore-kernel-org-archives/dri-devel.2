Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B63C3C88E64
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 22:46:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5AA310EA56;
	Sun, 13 Sep 2026 22:46:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DBtL1rGt";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6F7710EA56
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 22:46:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BBA5B40ABF;
 Sun, 13 Sep 2026 22:46:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B1611F000FF;
 Sun, 13 Sep 2026 22:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789339582;
 bh=opLmj+jLjNYDusJ422KDOZLzzZ9h3FSBrRqOoC8jm3U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DBtL1rGt1kLOAzuihBoK0gOahSYB5RwFdO+tuAJdfrDtkIowfZtA/BluTwqcQH5dH
 2rk6nWe+yKWv0KFW+NMzYPklZbQNu70sQVKarz/EdC2UQu6zZXcxsYP/2oMat3j0YS
 WcZVBgXM0jS6Rtf0LUGE+E9q29bxULke4vhWDKVCbD5AN4G2HlqbzusSJ8V9RluiaO
 eTLGmiuH+V5FVxuLHXLtOjSqOdwj+dpKGhr/qFl+ThcxNnxONdBzy/4ScfSuxhRy5E
 f7hV7yXik5Fw0WjpN8pL4Ve9KFE71SLX/3OW8INbJrq4UQ9Ggxc/nLgz4ldikNW1mL
 RBNzsXRIE60vg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] drm/qxl: validate relocation src_offset and fix
 type truncation
To: "Aldo Ariel Panzardo" <qwe.aldo@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260913223000.695299-5-qwe.aldo@gmail.com>
References: <20260913223000.695299-1-qwe.aldo@gmail.com>
 <20260913223000.695299-5-qwe.aldo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 22:46:22 +0000
Message-Id: <20260913224622.8B1611F000FF@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] Arbitrary kernel memory corruption due to incorrect byte-to-pa=
ge arithmetic in CPU-domain fallback path.
- [High] Incomplete mitigation for VRAM out-of-bounds access due to lack of=
 command extent validation.
- [High] Unaligned memory accesses to Write-Combining (WC) I/O memory via u=
ser-controlled `dst_offset`.
--

commit dafc93fc8afc46baa3769cdc18eb27a22986da61
Author: Aldo Ariel Panzardo <qwe.aldo@gmail.com>

drm/qxl: validate relocation src_offset and fix type truncation

The UAPI struct drm_qxl_reloc declares src_offset as __u64, but the
internal struct qxl_reloc_info stores it as a signed int.  The
assignment silently truncates the 64-bit value without any bounds check.
A negative or very large truncated offset is then passed to
qxl_bo_physical_address(), generating a physical address that points outside
the source BO.

> diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl_io=
ctl.c
> index 9fba6e26d048b..6559ba7d86f90 100644
> --- a/drivers/gpu/drm/qxl/qxl_ioctl.c
> +++ b/drivers/gpu/drm/qxl/qxl_ioctl.c

[ ... ]

> @@ -259,6 +259,10 @@ static int qxl_process_single_command(struct qxl_dev=
ice *qdev,
>  						 &reloc_info[i].src_bo);
>  			if (ret)
>  				goto out_free_bos;
> +			if (reloc.src_offset >=3D reloc_info[i].src_bo->tbo.base.size) {

[Severity: High]
This is a pre-existing issue, but does this check fully mitigate the
out-of-bounds access?

If a user submits a DRAW command and sets reloc.src_offset to a valid offset
near the end of the BO (e.g. bo->size - 1), this check passes.  However,
doesn't the hypervisor then read the full extent dictated by the DRAW
command payload, crossing the BO boundary into adjacent VRAM?

Would it be safer to also validate that the size of the access requested by
the QXL command fits within the source BO?

> +				ret =3D -EINVAL;
> +				goto out_free_bos;
> +			}
>  			reloc_info[i].src_offset =3D reloc.src_offset;
>  		} else {
>  			reloc_info[i].src_bo =3D NULL;

[Severity: Critical]
This isn't a bug introduced by this patch, but can this code cause an
arbitrary out-of-bounds kernel memory write?

In the CPU-domain fallback path for mapping a BO:

drivers/gpu/drm/qxl/qxl_object.c:qxl_bo_kmap_atomic_page() {
...
	offset =3D bo->tbo.resource->start << PAGE_SHIFT;
	return io_mapping_map_atomic_wc(map, offset + page_offset);
fallback:
	if (bo->kptr) {
		rptr =3D bo->kptr + (page_offset * PAGE_SIZE);
		return rptr;
	}

	ret =3D qxl_bo_vmap_locked(bo, &bo_map);
	if (ret)
		return NULL;
	rptr =3D bo_map.vaddr; /* TODO: Use mapping abstraction properly */

	rptr +=3D page_offset * PAGE_SIZE;
	return rptr;
}

The page_offset parameter is passed as a byte offset (e.g., from
dst_offset & PAGE_MASK in apply_reloc()).  If a user creates a CPU-domain
dumb buffer and provides a large dst_offset, doesn't multiplying page_offset
by PAGE_SIZE here generate a massively out-of-bounds pointer?

[Severity: High]
This is a pre-existing issue, but can these unaligned assignments cause a
kernel panic (alignment fault) on strict-alignment architectures like ARM64?

When a user submits an execbuffer command with a dst_offset that is not
aligned to an 8-byte boundary:

drivers/gpu/drm/qxl/qxl_ioctl.c:apply_reloc() {
...
	reloc_page =3D qxl_bo_kmap_atomic_page(qdev, info->dst_bo, info->dst_offse=
t & PAGE_MASK);
	*(uint64_t *)(reloc_page + (info->dst_offset & ~PAGE_MASK)) =3D qxl_bo_phy=
sical_address(qdev,
											      info->src_bo,
											      info->src_offset);
	qxl_bo_kunmap_atomic_page(qdev, info->dst_bo, reloc_page);
}

and

drivers/gpu/drm/qxl/qxl_ioctl.c:apply_surf_reloc() {
...
	reloc_page =3D qxl_bo_kmap_atomic_page(qdev, info->dst_bo, info->dst_offse=
t & PAGE_MASK);
	*(uint32_t *)(reloc_page + (info->dst_offset & ~PAGE_MASK)) =3D id;
	qxl_bo_kunmap_atomic_page(qdev, info->dst_bo, reloc_page);
}

Since reloc_page is mapped as Write-Combining (WC) I/O memory via
io_mapping_map_atomic_wc(), doesn't performing an unaligned 64-bit or 32-bit
direct memory write trigger a fatal Data Abort?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913223000.6952=
99-1-qwe.aldo@gmail.com?part=3D4
