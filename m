Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C7BC43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 14:05:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9DE010E0E7;
	Tue, 30 Jun 2026 14:05:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FhwUknK4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 547FB10E0E7
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 14:05:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 63CA1601C1;
 Tue, 30 Jun 2026 14:05:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA981F000E9;
 Tue, 30 Jun 2026 14:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782828337;
 bh=eNY2Xxxk//2WsyShuqS54lgOiU6FNy/a02RLRWW4u7M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FhwUknK4nDDHFILp/n5YWaVrOb6ojyj1LjnDJ6WrWsy5CwGQ3/EcAcMKSjJqaZsCq
 L90HC5HrJy6Rmd4gVElfhzebH6UevAf4LIzBo7Pfcy9Cb1dQTF8PViXry1QdPleJcj
 yiTaOIy9CKHQtE+fKkG1UGUJrnipCgpBj/ju09g1cPp+b1n6ldoNICT0Nrw4YoX4dP
 Kuj7KCf+Rl/yUd2fZ2S7D1U0CwP3ao8kSxpQqyeB58K6Y9B99PsYHBPMfGCxFH0/Vz
 Wsehpnc3p8NgPBnhs1QTkiqfbDLiCMXM99qN42i4zqUAlJDJxPuQPO4grP23x4zhlr
 XbDneWk7RjkAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] drm/xe: Avoid using stolen memory for DPT.
To: "Maarten Lankhorst" <dev@lankhorst.se>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260630135523.1775379-2-dev@lankhorst.se>
References: <20260630135523.1775379-1-dev@lankhorst.se>
 <20260630135523.1775379-2-dev@lankhorst.se>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 14:05:36 +0000
Message-Id: <20260630140536.EEA981F000E9@smtp.kernel.org>
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
- [Medium] The refactoring inadvertently removes the SYSTEM memory fallback=
 for Display Page Tables (DPTs) on discrete graphics (DGFX).

Pre-existing issues:
- [High] Integer truncation of the GEM object size leads to an undersized D=
isplay Page Table (DPT) allocation, allowing the display engine to read out=
-of-bounds physical memory.
--

commit 45b977ae39cb9d3ad37f33363c230cce698f7958
Author: Maarten Lankhorst <dev@lankhorst.se>

drm/xe: Avoid using stolen memory for DPT.

On systems with media GT, extra latency is added when accessing stolen
memory when the GT is in MC6. Since we additionally aren't counting how
much memory is used for stolen and we could in theory fill up the
entire stolen area with DPT's, avoid using stolen and only use the
default memory region.

Additionally, this may also result in random system hangs under load.

Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/7513

> diff --git a/drivers/gpu/drm/xe/display/xe_fb_pin.c b/drivers/gpu/drm/xe/=
display/xe_fb_pin.c
> index f93c98bec5b5f..86013ef532fd7 100644
> --- a/drivers/gpu/drm/xe/display/xe_fb_pin.c
> +++ b/drivers/gpu/drm/xe/display/xe_fb_pin.c
> @@ -146,8 +146,8 @@ static int __xe_pin_fb_vma_dpt(struct drm_gem_object =
*obj,
>  			       const struct intel_fb_pin_params *pin_params,
>  			       struct i915_vma *vma)
>  {
>  	struct xe_device *xe =3D to_xe_device(obj->dev);
>  	struct xe_tile *tile0 =3D xe_device_get_root_tile(xe);
>  	struct xe_ggtt *ggtt =3D tile0->mem.ggtt;
>  	const struct i915_gtt_view *view =3D pin_params->view;
>  	struct xe_bo *bo =3D gem_to_xe_bo(obj), *dpt;
>  	u32 dpt_size, size =3D bo->ttm.base.size;

[Severity: High]
This is a pre-existing issue, but does assigning the 64-bit bo->ttm.base.si=
ze
to a 32-bit size variable in __xe_pin_fb_vma_dpt() cause integer truncation?

If a BO larger than 4GB is allocated by a userspace attacker and used as a
normal framebuffer, the size could be truncated (e.g., 5GB becomes 1GB),
leading to an undersized DPT allocation. When the display engine scans out
the framebuffer, could this cause it to read past the undersized DPT and
potentially leak arbitrary physical memory contents to the screen?

[ ... ]

> @@ -164,31 +164,14 @@ static int __xe_pin_fb_vma_dpt(struct drm_gem_objec=
t *obj,
>  		dpt_size =3D ALIGN(intel_rotation_info_size(&view->rotated) * 8,
>  				 XE_PAGE_SIZE);
> =20
> -	if (IS_DGFX(xe))
> -		dpt =3D xe_bo_create_pin_map_at_novm(xe, tile0,
> -						   dpt_size, ~0ull,
> -						   ttm_bo_type_kernel,
> -						   XE_BO_FLAG_VRAM0 |
> -						   XE_BO_FLAG_GGTT |
> -						   XE_BO_FLAG_PAGETABLE,
> -						   pin_params->alignment, false);
> -	else
> -		dpt =3D xe_bo_create_pin_map_at_novm(xe, tile0,
> -						   dpt_size,  ~0ull,
> -						   ttm_bo_type_kernel,
> -						   XE_BO_FLAG_STOLEN |
> -						   XE_BO_FLAG_GGTT |
> -						   XE_BO_FLAG_PAGETABLE,
> -						   pin_params->alignment, false);
> -	if (IS_ERR(dpt))
> -		dpt =3D xe_bo_create_pin_map_at_novm(xe, tile0,
> -						   dpt_size,  ~0ull,
> -						   ttm_bo_type_kernel,
> -						   XE_BO_FLAG_SYSTEM |
> -						   XE_BO_FLAG_GGTT |
> -						   XE_BO_FLAG_PAGETABLE |
> -						   XE_BO_FLAG_FORCE_WC,
> -						   pin_params->alignment, false);
> +	dpt =3D xe_bo_create_pin_map_at_novm(xe, tile0,
> +					   dpt_size,  ~0ull,
> +					   ttm_bo_type_kernel,
> +					   XE_BO_FLAG_VRAM_IF_DGFX(tile0) |
> +					   XE_BO_FLAG_GGTT |
> +					   XE_BO_FLAG_PAGETABLE |
> +					   XE_BO_FLAG_FORCE_WC,
> +					   pin_params->alignment, false);
>  	if (IS_ERR(dpt))
>  		return PTR_ERR(dpt);

[Severity: Medium]
Does removing the if (IS_ERR(dpt)) fallback to XE_BO_FLAG_SYSTEM
inadvertently break DPT allocations on discrete graphics (DGFX) under memory
pressure?

If VRAM is full during normal operations, it seems the allocation would now
just fail rather than falling back to SYSTEM memory, which could cause mode=
sets
to fail on DGFX. The commit message only mentions avoiding STOLEN memory on
integrated graphics.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630135523.1775=
379-1-dev@lankhorst.se?part=3D1
