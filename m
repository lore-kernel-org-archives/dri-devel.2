Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12AF6C88E5C
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 22:44:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08B3810EA4D;
	Sun, 13 Sep 2026 22:44:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DVg3V66/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1002610EA4D
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 22:44:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BBD45411FE;
 Sun, 13 Sep 2026 22:44:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 750671F000FF;
 Sun, 13 Sep 2026 22:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789339475;
 bh=SYNhFKCzmL5LXfXSZuzkV20pYM6JQ52eVzWTsrqIPQo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DVg3V66/zeaHiRPA623CJhD6BWpwn0BxuYmH4pg3wDJIKCBamiiqIUcFfRqnX4KxP
 mYCvFMslu14Q90eK6roNxbcnr4V87kVHvgoYrVaxCN/QPulNfDWHZOeCsM7+k2BPC/
 vs+yz0ioPVE1XnYdcDe7UfLaONQv90zs0wVoku9i4D3Ksbt1rC0OlZ1rhSc3hfNB2u
 xomK4B6Ok6urwL/5sZzHUbj/8A5Y9C/Q7mSBJAWfTt//GiQoDoDhBvgmaLs9f0TkbK
 +UEMvRPpSkimNV4FfR687iuxonTLW5mSzyuomAkODSZ/Iy/saShIpWQewTeC8Grvva
 j6+SoEO+epiLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] drm/qxl: validate relocation dst_offset against
 destination BO
To: "Aldo Ariel Panzardo" <qwe.aldo@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260913223000.695299-2-qwe.aldo@gmail.com>
References: <20260913223000.695299-1-qwe.aldo@gmail.com>
 <20260913223000.695299-2-qwe.aldo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 22:44:35 +0000
Message-Id: <20260913224435.750671F000FF@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] The patch fails to prevent out-of-bounds writes for system RAM=
 BOs (dumb buffers) due to a preexisting flaw in qxl_bo_kmap_atomic_page's =
fallback branch.
--

commit 816a48396f060545d332f11cc2d661437076fb2f
Author: Aldo Ariel Panzardo <qwe.aldo@gmail.com>

drm/qxl: validate relocation dst_offset against destination BO

This patch attempts to prevent out-of-bounds writes during relocation
processing by validating that the user-provided dst_offset falls within
the destination buffer object. It adds bounds checks for both the
command/release BO and general relocation destination BOs.

> diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl_io=
ctl.c
> index 591b026ceff9c..e727a35c94136 100644
> --- a/drivers/gpu/drm/qxl/qxl_ioctl.c
> +++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
[ ... ]
> @@ -227,10 +231,22 @@ static int qxl_process_single_command(struct qxl_de=
vice *qdev,
>  				goto out_free_bos;
>  			reloc_info[i].dst_offset =3D reloc.dst_offset;
>  		} else {
[ ... ]
>  			reloc_info[i].dst_bo =3D cmd_bo;
>  			reloc_info[i].dst_offset =3D reloc.dst_offset + release->release_offs=
et;
>  		}
> =20
> +		if ((u64)reloc_info[i].dst_offset + write_size >
> +		    reloc_info[i].dst_bo->tbo.base.size) {

[Severity: Critical]
This is a pre-existing issue, but does this newly added bounds check fully
prevent out-of-bounds writes for system RAM BOs (dumb buffers)?

The new bounds check in qxl_process_single_command verifies that dst_offset
is within the BO size. However, it relies on the un-multiplied byte offset.
Later, apply_reloc calls qxl_bo_kmap_atomic_page, passing
dst_offset & PAGE_MASK as the page_offset argument.

If a user creates a dumb buffer (placed in TTM_PL_SYSTEM) and passes its
handle with a large dst_offset, qxl_bo_kmap_atomic_page in
drivers/gpu/drm/qxl/qxl_object.c takes a fallback branch. That fallback
branch contains the following pointer calculation:

rptr +=3D page_offset * PAGE_SIZE;

Because page_offset is derived from a byte offset, multiplying it by
PAGE_SIZE creates a massive out-of-bounds pointer calculation (for example,
a 100MB offset becomes 400GB). Since the QXL_EXECBUFFER ioctl is accessible
to any authenticated DRM client, an unprivileged user could use this path to
write a 64-bit physical address or 32-bit surface ID into kernel memory,
which can lead to system compromise or a kernel panic.

Should the underlying multiplier bug in qxl_bo_kmap_atomic_page be addressed
alongside this patch to ensure the vulnerability is fully closed?

> +			ret =3D -EINVAL;
> +			goto out_free_bos;
> +		}
> +
>  		/* reserve and validate the reloc dst bo */
>  		if (reloc.reloc_type =3D=3D QXL_RELOC_TYPE_BO || reloc.src_handle) {
>  			ret =3D qxlhw_handle_to_bo(file_priv, reloc.src_handle, release,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913223000.6952=
99-1-qwe.aldo@gmail.com?part=3D1
