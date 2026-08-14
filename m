Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB260C5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 15:11:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E72D10F64E;
	Fri, 14 Aug 2026 15:11:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fWSFEmVy";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5520A10F64E
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 15:11:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 383E5431C9
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 15:11:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF76D1F000E9;
 Fri, 14 Aug 2026 15:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786720268;
 bh=T40z2riaZC2eRysKOcGE0IuRCgfW5TsSLDHFUJVbORc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fWSFEmVyPp0+nl7M0i4z4Z5gsjcijWtqNOYGe89cGl+1XZpz1Ibk8wCtaVLrGAQS8
 B/mIQuQM4WmkZHFrZC1R8+KzQ6ZHo/Uh8RDYx7MkwLKlowjfueIC9K0pXu/EqJLD8r
 zIsjRy7Hr1s1Bt8drZFcBzkw+uxKmoNnkbBRENZiFGtI77JylrHgEdSCZmMQGOm3zT
 03WluIN9buekSHmCYyE1+5fNYJw8LYzQIvGZLulIRbNHPJEQwh33JvFHfEe2wvxpzS
 gXwr5TQOABN8Mjkv4AvqAfOmS0S/NjzmuYnTOBnR/heNKukV82jDV6Va+1PzlABhd7
 MnJvtuVcAykeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/61] drm/gem-atomic-helper: Switch
 DRM_GEM_SHADOW_PLANE_FUNCS to atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260814-drm-no-more-plane-reset-v2-4-82d2963dd134@kernel.org>
References: <20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org>
 <20260814-drm-no-more-plane-reset-v2-4-82d2963dd134@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 15:11:07 +0000
Message-Id: <20260814151107.EF76D1F000E9@smtp.kernel.org>
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
- [Low] The function `drm_gem_reset_shadow_plane` is now dead code and shou=
ld be removed.
--

--- Patch [4]: [PATCH v2 04/61] drm/gem-atomic-helper: Switch DRM_GEM_SHADO=
W_PLANE_FUNCS to atomic_create_state ---
commit e875af062658268c58ae3dc27d813b18fda75580
Author: Maxime Ripard <mripard@kernel.org>

drm/gem-atomic-helper: Switch DRM_GEM_SHADOW_PLANE_FUNCS to atomic_create_s=
tate

This commit updates the DRM_GEM_SHADOW_PLANE_FUNCS macro to use
atomic_create_state instead of reset. It maps the atomic_create_state
callback to drm_gem_create_shadow_plane_state.

> diff --git a/include/drm/drm_gem_atomic_helper.h b/include/drm/drm_gem_at=
omic_helper.h
> index 8a3bb27233db0..da8a4fb442b46 100644
> --- a/include/drm/drm_gem_atomic_helper.h
> +++ b/include/drm/drm_gem_atomic_helper.h

[ ... ]

> @@ -110,7 +110,7 @@ void drm_gem_destroy_shadow_plane_state(struct drm_pl=
ane *plane,
>   * macro initializes struct drm_plane_funcs to use the rsp helper functi=
ons.
>   */
>  #define DRM_GEM_SHADOW_PLANE_FUNCS \
> -	.reset =3D drm_gem_reset_shadow_plane, \
> +	.atomic_create_state =3D drm_gem_create_shadow_plane_state, \

[Severity: Low]
Does this leave drm_gem_reset_shadow_plane() as unused dead code?

Since it is no longer referenced by this macro, it appears its prototype
in include/drm/drm_gem_atomic_helper.h and its definition (along with
the EXPORT_SYMBOL) in drivers/gpu/drm/drm_gem_atomic_helper.c could also
be removed.

>  	.atomic_duplicate_state =3D drm_gem_duplicate_shadow_plane_state, \
>  	.atomic_destroy_state =3D drm_gem_destroy_shadow_plane_state

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-drm-no-mor=
e-plane-reset-v2-0-82d2963dd134@kernel.org?part=3D4
