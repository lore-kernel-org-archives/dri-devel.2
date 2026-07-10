Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5116CC43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 22:21:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A81B710E267;
	Fri, 10 Jul 2026 22:21:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kCrExY2D";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AD6B10F99F
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 22:21:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A994360052;
 Fri, 10 Jul 2026 22:21:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FFB61F00A3D;
 Fri, 10 Jul 2026 22:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783722076;
 bh=d+uUqiAc2H2zmLjtkm7bVXkjGksDt08JTKk1JzMAejI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kCrExY2Daf08X34Hz9h00BXgTisLt876ozVXwOGdaRQyO9TbBRZ46+EMOeygzYPMt
 EOvpvk7ijHLLJnaS6nzt8WxOVup7VRLw7DW3G5YkG81jbA0zViuy/6VH764dWki4sK
 cO0hueit+tn2cy7Gld6FAJVL1IZw+OKj0QhRakvJRapEj1uPjxLF0Mr/HbBp1hHJ37
 7N4qXCjVVbALYHLkj79f5XrcYuNsYoZG4houQgY56a3oi35EZV1uALALx4HQxu/lF8
 GBXQLlx7NZh6HHeGbBWeq5EJIPQlGCCxAhqe7GhfYpUPXsR79V+0oGYT4ak7tGrDDC
 w0ApJKhAuzT5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 25/33] drm/xe: Preallocate system BO backing outside
 the dma-resv lock
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260710215442.2444235-26-matthew.brost@intel.com>
References: <20260710215442.2444235-1-matthew.brost@intel.com>
 <20260710215442.2444235-26-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 22:21:15 +0000
Message-Id: <20260710222116.2FFB61F00A3D@smtp.kernel.org>
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
- [High] Integer truncation in xe_device_ccs_bytes() returning u32 causes b=
uffer overflows and physical memory corruption/panics for BOs >=3D 1TB.
--

--- Patch [25]: [PATCH v2 25/33] drm/xe: Preallocate system BO backing outs=
ide the dma-resv lock ---
commit aa051bafd6b83b01e59b139bb60870dfa1044d22
Author: Matthew Brost <matthew.brost@intel.com>
Subject: drm/xe: Preallocate system BO backing outside the dma-resv lock

xe_gem_create_ioctl() populates a buffer object's backing store inside
xe_validation_guard(), i.e. under the dma-resv lock. This patch uses the
TTM full-preallocation mechanism to move that work out of the lock.

> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index a010042653495..d9226a3995fe4 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c
[ ... ]
> @@ -3994,6 +4009,45 @@ int xe_gem_create_ioctl(struct drm_device *dev, vo=
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

[Severity: High]
This is a pre-existing issue, but can this lead to an integer truncation for
very large buffer sizes?

The function xe_device_ccs_bytes() in drivers/gpu/drm/xe/xe_device.c returns
a u32, but takes a u64 size parameter. If a user requests a BO allocation of
>=3D 1TB via DRM_IOCTL_XE_GEM_CREATE with CCS enabled, the required CCS size
would be 1TB / 256 =3D 4GB, which silently truncates to 0 in the u32 return
type.

Because this patch propagates the pattern by calling xe_device_ccs_bytes() =
on
the user-controlled args->size, the extra_pages for the CCS backup could be
calculated as 0, under-allocating the BO's SG table. Later, when
xe_migrate_copy() processes the BO in chunks, it could advance the CCS curs=
or
past the end of the under-allocated SG table, resulting in a NULL pointer
dereference and kernel panic.

Should xe_device_ccs_bytes() be updated to return a u64, or should there be
size limits enforced earlier in the ioctl?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710215442.2444=
235-1-matthew.brost@intel.com?part=3D25
