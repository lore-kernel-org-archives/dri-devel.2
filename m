Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E56CD98D2
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 07:21:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 314D410E887;
	Tue, 16 Jun 2026 07:21:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dHny4gxa";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDC5810E87F
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 07:21:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C068140EA5;
 Tue, 16 Jun 2026 07:21:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8632F1F000E9;
 Tue, 16 Jun 2026 07:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781594482;
 bh=jjXMZGja9mbqSc+0hjf4U5bzugbQ5ICeebHiJOOJdnU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dHny4gxab2UszYjUEHLLqlmS0yX3tli24tO7GpEY4/vEmoQ2rNvzjEBsj6kWAC3C7
 SBVk3V2i+uKk8t0bSmhJIPMxlrYxMiJEl3RH4wapb3EmLPztE/bbLA3nRpVMa2tFbc
 iemRuh2gRgvghbSjafTGGgn9IfkIfgAFDt26MTExlYi7oFChcgVTvaON6/1MoK6bri
 2oUGpxOy/Oqh9Pw45sdcLvwlNWwHCeNFiBcCdGBswgeZNrcwyOIk8ZdWIVZ2vZ0v2A
 CPoltiIkeYCp4O1WrSWJ+UxeHmw/mVEWlQxT1oiWLZrj/abq26z0ZKF2B463J4RGLD
 U/hdhp3Y11wCg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] drm/amd/display: Pin native scanout to VRAM on
 large-carveout APUs
To: "Matthew Schwartz" <matthew.schwartz@linux.dev>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260616071037.26718-1-matthew.schwartz@linux.dev>
References: <20260616071037.26718-1-matthew.schwartz@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 07:21:22 +0000
Message-Id: <20260616072122.8632F1F000E9@smtp.kernel.org>
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
- [High] The GTT fallback logic fails to handle `-EINVAL` for shared frameb=
uffers and `-ENOSPC` when VRAM is full, breaking atomic commits.
- [High] Unconditional pinning to VRAM causes severe CPU thrashing and dmes=
g spam on every page flip under memory pressure.
--

commit 56a58731a1850c7efcd10ad3db0b21ff08dd0a48
Author: Matthew Schwartz <matthew.schwartz@linux.dev>
Subject: drm/amd/display: Pin native scanout to VRAM on large-carveout APUs

This patch modifies the framebuffer preparation logic to pin native scanout
buffers in VRAM for APUs with large carveouts. If the VRAM allocation fails,
it falls back to GTT to ensure the swapchain remains in a single memory dom=
ain.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index 23a9faa2ea89f..8a5d03185c479 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -958,13 +959,35 @@ static int amdgpu_dm_plane_helper_prepare_fb(struct=
 drm_plane *plane,
>  	if (r)
>  		goto error_unlock;
> =20
> -	if (plane->type !=3D DRM_PLANE_TYPE_CURSOR)
> -		domain =3D amdgpu_display_supported_domains(adev, rbo->flags);
> -	else
> +	/*
> +	 * Pin native scanout in VRAM on APUs so a swapchain stays in one
> +	 * memory domain. A VRAM/GTT split changes its mem_type between flips
> +	 * and amdgpu_dm_crtc_mem_type_changed() rejects the async flip. Skip
> +	 * small carveouts that may not fit, and imported buffers.
> +	 */
> +	pin_vram_only =3D plane->type !=3D DRM_PLANE_TYPE_CURSOR &&
> +			(adev->flags & AMD_IS_APU) &&
> +			!rbo->tbo.base.import_attach &&
> +			adev->gmc.real_vram_size > AMDGPU_SG_THRESHOLD;
> +
> +	if (plane->type =3D=3D DRM_PLANE_TYPE_CURSOR || pin_vram_only)
>  		domain =3D AMDGPU_GEM_DOMAIN_VRAM;
> +	else
> +		domain =3D amdgpu_display_supported_domains(adev, rbo->flags);
> =20
>  	rbo->flags |=3D AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>  	r =3D amdgpu_bo_pin(rbo, domain);

[Severity: High]
Does this unconditional VRAM pinning attempt cause severe CPU thrashing and
dmesg spam on every page flip under memory pressure?

Since prepare_fb runs on every page flip for unpinned swapchain buffers, a
full VRAM might cause amdgpu_bo_pin() to perform an expensive memory evicti=
on
search and log a hard error via dev_err() 60 times a second.

Additionally, if a buffer was previously placed in GTT via the fallback and
unpinned, the next page flip will attempt to migrate it back to VRAM, causi=
ng
an eviction storm.

> +	if (r =3D=3D -ENOMEM && pin_vram_only) {

[Severity: High]
Will this strict check for -ENOMEM fail to handle -EINVAL and -ENOSPC, caus=
ing
the VRAM-to-GTT fallback to be skipped?

When VRAM is full, TTM's allocation often returns -ENOSPC instead of -ENOME=
M.

If a framebuffer is shared across planes (e.g., cloned displays) and the fi=
rst
plane falls back to GTT, the buffer is pinned in GTT with pin_count =3D 1.
When the second plane calls amdgpu_bo_pin() with AMDGPU_GEM_DOMAIN_VRAM,
it returns -EINVAL.

Skipping the fallback in these cases would break the atomic commit.

> +		/*
> +		 * VRAM could not fit the buffer. Fall back to GTT where
> +		 * allowed so the swapchain stays in one domain.
> +		 */
> +		domain =3D amdgpu_display_supported_domains(adev, rbo->flags);
> +		if (domain & AMDGPU_GEM_DOMAIN_GTT) {
> +			domain =3D AMDGPU_GEM_DOMAIN_GTT;
> +			r =3D amdgpu_bo_pin(rbo, domain);
> +		}
> +	}
>  	if (unlikely(r !=3D 0)) {
>  		if (r !=3D -ERESTARTSYS)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616071037.2671=
8-1-matthew.schwartz@linux.dev?part=3D1
