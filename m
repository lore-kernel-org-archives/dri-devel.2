Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC5AEC5AC67
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 00:42:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4A5510E0CC;
	Sun,  9 Aug 2026 00:42:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="j2R0r9Gr";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 340FE10E490
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 00:42:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2A90660008;
 Sun,  9 Aug 2026 00:42:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837231F000E9;
 Sun,  9 Aug 2026 00:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786236169;
 bh=p3RRc9s/COF2UdacQi8r1joQkZuAQDc3RZk0YPKAYYg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=j2R0r9GrYzASt5ZRhFm6eMmF0JfvufUoIfJcuX7FhPm+rmzLL5kTD9FIJ8fFpJVex
 Wye2xRm+F4zr+TnamIh05hg8J6Lbh0PX0+IgcRuWWPtjZhS2WIK8w9iUu6c4fHdHqS
 HdIULNXM+NOzmrEAg3jICQioG53w4KzqC9PHjXT03lI/B90jPAJDlIQCtThw48AW1Q
 DEQf15a9iJSJJOrHic9fv55itSXAKlbWRCztFvRaphfqHr+mOKw8+Hm+qy1V0B1WEB
 otx5URU3Y6LyJEimPtC2uc3lFkVcWMftxrWZmQXbINY1pCiVTDwRWZFMbk4LDjlUFo
 7xNs4Cyy8ENrQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/qxl: fix 32-bit overflow in the ALLOC_SURF size
 computation
To: "Aldo Ariel Panzardo" <qwe.aldo@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260809002621.122832-1-qwe.aldo@gmail.com>
References: <20260809002621.122832-1-qwe.aldo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 00:42:49 +0000
Message-Id: <20260809004249.837231F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] The command relocation processing lacks bounds checking on `ds=
t_offset`, allowing userspace to perform arbitrary writes to kernel or VRAM=
 memory.
- [High] The size computation in `qxl_alloc_surf_ioctl` prevents integer ov=
erflows but fails to validate that the userspace-provided `stride` is mathe=
matically sufficient for the `width` of the surface, leaving it vulnerable =
to undersized VRAM allocations.
--

--- Patch [1]: [PATCH v2] drm/qxl: fix 32-bit overflow in the ALLOC_SURF si=
ze computation ---
commit 0b850095b7d5d290c2b02556121eaeca53cced5b
Author: Aldo Ariel Panzardo <qwe.aldo@gmail.com>

drm/qxl: fix 32-bit overflow in the ALLOC_SURF size computation

This commit fixes a 32-bit integer overflow in the QXL surface allocation
ioctl by computing the backing size as u64 and checking it against INT_MAX.
It also rejects zero dimensions and handles an INT_MIN stride properly.

> diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl_io=
ctl.c
> index 591b026ceff9c..5f84a4cf9631d 100644
> --- a/drivers/gpu/drm/qxl/qxl_ioctl.c
> +++ b/drivers/gpu/drm/qxl/qxl_ioctl.c

[Severity: Critical]
This is a pre-existing issue, but does qxl_process_single_command() lack
bounds checking on dst_offset? A userspace client could send a QXL_EXECBUFF=
ER
ioctl with a maliciously crafted dst_offset. qxl_process_single_command()
copies this without validating it against dst_bo->tbo.base.size:

drivers/gpu/drm/qxl/qxl_ioctl.c:qxl_process_single_command() {
	...
	reloc_info[i].dst_offset =3D reloc.dst_offset;
	...
}

Later, apply_reloc() calls qxl_bo_kmap_atomic_page() with this out-of-bounds
offset and writes the source BO's physical address to it:

drivers/gpu/drm/qxl/qxl_ioctl.c:apply_reloc() {
	...
	reloc_page =3D qxl_bo_kmap_atomic_page(qdev, info->dst_bo, info->dst_offse=
t & PAGE_MASK);
	*(uint64_t *)(reloc_page + (info->dst_offset & ~PAGE_MASK)) =3D qxl_bo_phy=
sical_address(qdev, info->src_bo, info->src_offset);
	...
}

Could this allow arbitrary local privilege escalation or system crashes from
any DRM_AUTH client via out-of-bounds writes?

> @@ -386,12 +386,24 @@ int qxl_alloc_surf_ioctl(struct drm_device *dev, vo=
id *data, struct drm_file *fi
>  	struct drm_qxl_alloc_surf *param =3D data;
>  	int handle;
>  	int ret;
> -	int size, actual_stride;
> +	int actual_stride;
> +	u64 size;
>  	struct qxl_surface surf;
> =20
>  	/* work out size allocate bo with handle */
> +	if (param->stride =3D=3D INT_MIN)
> +		return -EINVAL;
>  	actual_stride =3D param->stride < 0 ? -param->stride : param->stride;
> -	size =3D actual_stride * param->height + actual_stride;
> +	if (!actual_stride || !param->width || !param->height)
> +		return -EINVAL;
> +	/*
> +	 * size =3D actual_stride * (height + 1), computed in u64 so it cannot
> +	 * wrap on any architecture, then bounded so it still fits the int
> +	 * parameter of qxl_gem_object_create().
> +	 */
> +	size =3D (u64)actual_stride * ((u64)param->height + 1);
> +	if (size > INT_MAX)
> +		return -EINVAL;
> =20
>  	surf.format =3D param->format;
>  	surf.width =3D param->width;

[Severity: High]
This isn't a bug introduced by this patch, but does this allocation validate
that the stride is mathematically sufficient for the width?

If DRM_IOCTL_QXL_ALLOC_SURF is called with a huge param->width and a tiny
actual_stride (e.g., 1), the size computation will pass the INT_MAX check,
but fail to enforce stride >=3D width * bytes_per_pixel.

Since the width is passed directly to the QXL host device, could the host
subsequently overrun the guest VRAM outside the undersized allocated buffer
when processing the surface?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809002621.1228=
32-1-qwe.aldo@gmail.com?part=3D1
