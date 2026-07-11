Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C1BC43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 03:19:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E95610E710;
	Sat, 11 Jul 2026 03:19:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SaJn9AN0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D52E10E710
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 03:19:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0CE7C401F2;
 Sat, 11 Jul 2026 03:19:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D831F000E9;
 Sat, 11 Jul 2026 03:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783739990;
 bh=P98W199MicHvfiZnwwbAMXFj5BZkNJW363xZptxQRRs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SaJn9AN0bDvQ5jIecUlTmFr2LvmdmA9ICmXSxf6NBKwPLdbtJMhV6wq3saTUgyomo
 62+2ZmydH/JINANtXMssC9o6kHjVgd0nj6yI3yxrurFW8I9sXpCRcN5TadUB9Ky2aR
 xdUm7sfhvdphDSfuNrXi/NpKh60SpdRXOBDEl+cobHEbJENB0JVZKEQ5x8pa+b0SeJ
 0a+3XdG09rFzKogvhg05V6hibgvNbdqw8kAU84eH30iGkwLB7houWABmTIh1VasHGA
 wMYw2h77T6VWeJ4PpXg0l0qjSdKbXDzHjE6IHHqdmQrt+hhwAOdRkHahUgn5tmUeSa
 uMCSGnemM09Fw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 25/33] drm/xe: Preallocate system BO backing outside
 the dma-resv lock
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260711025619.2540575-26-matthew.brost@intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-26-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 03:19:50 +0000
Message-Id: <20260711031950.B9D831F000E9@smtp.kernel.org>
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
- [Critical] `xe_device_ccs_bytes()` truncates the calculated CCS size to `=
u32`, causing massive under-allocation of the `ttm_tt` pages array for buff=
ers >=3D 1TB.
--

--- Patch [25]: [PATCH v3 25/33] drm/xe: Preallocate system BO backing outs=
ide the dma-resv lock ---
commit 4ef9a2744ced48ab96c8a05eeb4fe0fa0b3bafac
Author: Matthew Brost <matthew.brost@intel.com>

drm/xe: Preallocate system BO backing outside the dma-resv lock
   =20
This commit uses the TTM full-preallocation mechanism to allocate the entire
tt backing up front before entering the validation guard for system-only,
non-deferred user BOs. It sizes the preallocation by querying the CCS-pages
decision directly from the ioctl.

> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index 25e5b72f870c0..a646a72122d40 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c

[ ... ]

> @@ -4018,6 +4033,64 @@ int xe_gem_create_ioctl(struct drm_device *dev, vo=
id *data,
>  			return -ENOENT;
>  	}
> =20
> +	/*
> +	 * For system-only BOs, preallocate the whole backing outside the
> +	 * dma-resv lock so the populate under the validation guard does not
> +	 * stall in reclaim/compaction. The caching mirrors the system-BO path
> +	 * in xe_ttm_tt_create(); the pool falls back to in-line allocation for
> +	 * any shortfall, so a failed fill is harmless.
> +	 */
> +	if ((bo_flags & XE_BO_FLAG_SYSTEM) &&
> +	    !(bo_flags & (XE_BO_FLAG_DEFER_BACKING | XE_BO_FLAG_VRAM_MASK |
> +			  XE_BO_FLAG_STOLEN))) {
> +		struct ttm_resource_manager *tt_man =3D
> +			ttm_manager_type(&xe->ttm, XE_PL_TT);
> +		enum ttm_caching caching =3D ttm_cached;
> +		unsigned long num_pages =3D args->size >> PAGE_SHIFT;
> +
> +		if (!IS_DGFX(xe) &&
> +		    args->cpu_caching =3D=3D DRM_XE_GEM_CPU_CACHING_WC)
> +			caching =3D ttm_write_combined;
> +
> +		/*
> +		 * Cover the CCS backup pages appended to the tt (see
> +		 * xe_ttm_tt_create()) so the whole tt is preallocated.
> +		 */
> +		if (__xe_bo_needs_ccs_pages(xe, ttm_bo_type_device, bo_flags,
> +					    args->cpu_caching))
> +			num_pages +=3D DIV_ROUND_UP(xe_device_ccs_bytes(xe,
> +								      args->size),
> +						  PAGE_SIZE);

[Severity: Critical]
This is a pre-existing issue, but does xe_device_ccs_bytes() truncate the
calculated size for very large buffers?

Looking at drivers/gpu/drm/xe/xe_device.c:

u32 xe_device_ccs_bytes(struct xe_device *xe, u64 size)
{
	return xe_device_has_flat_ccs(xe) ?
		DIV_ROUND_UP_ULL(size, NUM_BYTES_PER_CCS_BYTE(xe)) : 0;
}

Because the return type is u32, if a user requests a buffer of 1TB or large=
r,
the calculated CCS size truncates. For a 1TB buffer with a 256:1 compression
ratio, size / 256 exactly equals 0x100000000, which truncates to 0.

This means num_pages will not include the necessary CCS backup pages (and
similarly extra_pages in xe_ttm_tt_create() will be 0), which can lead to a
massive heap buffer overflow when the driver or GPU writes past the end of
the under-sized ttm_tt pages array.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711025619.2540=
575-1-matthew.brost@intel.com?part=3D25
