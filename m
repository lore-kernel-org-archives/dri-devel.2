Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8210C5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 15:11:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24E0710F65A;
	Fri, 14 Aug 2026 15:11:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GclFJtJW";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9F5C10F65A
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 15:11:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1FA8360120
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 15:11:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D7D1F000E9;
 Fri, 14 Aug 2026 15:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786720273;
 bh=Ia0LfMRkcsGvxHSwaB9ndNCJMdYvOd6RAy09dlz3Og8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GclFJtJW0K0N3sWhiOxz/A8ib1i3X2+xh3zAnEpGPL8yaHNnoj9NPMC0tuQrxcPYA
 B2G+Ouqxr0/8yesvacqtg4u/MQOkPWKjhAGRfOALe5HBT+VkDmk9X4AuekCrIcveY/
 TITitjSWO82kIIG/Mk1uKB0d1pqzAZKcMALOhqZydxvkFziMb4vafiXNyT2Vk0eVnJ
 1E+bc6wGgDORDCF8J2FivLmRfXDDN4+kmBgqOVkrs94Bw+PyYQRtBG8s6LkCPW6VZj
 zTQu4pH0Rdq2Lxq/TRVR5VFeXZXru3dZjmpkPbTnsC+ZzR3rFmH4jQUv7aEAHkHSy7
 lRhp0HKKbVRmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/61] drm/gem-atomic-helper: Create
 drm_gem_create_shadow_plane_state()
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260814-drm-no-more-plane-reset-v2-2-82d2963dd134@kernel.org>
References: <20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org>
 <20260814-drm-no-more-plane-reset-v2-2-82d2963dd134@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 15:11:13 +0000
Message-Id: <20260814151113.A0D7D1F000E9@smtp.kernel.org>
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
- [Medium] The newly introduced `drm_gem_create_shadow_plane_state` callbac=
k is not added to the `DRM_GEM_SHADOW_PLANE_FUNCS` macro.
--

--- Patch [2]: [PATCH v2 02/61] drm/gem-atomic-helper: Create drm_gem_creat=
e_shadow_plane_state() ---
commit 04bcd76bbde0146f1fe95d41bdf27b75eecf6aaa
Author: Maxime Ripard <mripard@kernel.org>

drm/gem-atomic-helper: Create drm_gem_create_shadow_plane_state()
   =20
The GEM shadow-plane helpers only expose reset functions that handle
both the initial state allocation and the reset path. The new
atomic_create_state hook requires a function that only allocates and
initializes a pristine state. Create new helpers to allocate and
initialize a shadow plane state from scratch.

> diff --git a/include/drm/drm_gem_atomic_helper.h b/include/drm/drm_gem_at=
omic_helper.h
> index 3e01c619a25e0..43657d8fb1c8c 100644
> --- a/include/drm/drm_gem_atomic_helper.h
> +++ b/include/drm/drm_gem_atomic_helper.h
> @@ -95,6 +95,9 @@ void __drm_gem_reset_shadow_plane(struct drm_plane *pla=
ne,
>  				  struct drm_shadow_plane_state *shadow_plane_state);
> =20
>  void drm_gem_reset_shadow_plane(struct drm_plane *plane);
> +void __drm_gem_shadow_plane_state_init(struct drm_plane *plane,
> +				       struct drm_shadow_plane_state *shadow_plane_state);
> +struct drm_plane_state *drm_gem_create_shadow_plane_state(struct drm_pla=
ne *plane);

[Severity: Medium]
Should the DRM_GEM_SHADOW_PLANE_FUNCS macro in this file be updated to incl=
ude
the newly introduced drm_gem_create_shadow_plane_state for the
.atomic_create_state hook?

Currently, the macro only sets .reset, .atomic_duplicate_state, and
.atomic_destroy_state:

include/drm/drm_gem_atomic_helper.h:DRM_GEM_SHADOW_PLANE_FUNCS {
#define DRM_GEM_SHADOW_PLANE_FUNCS \
	.reset =3D drm_gem_reset_shadow_plane, \
	.atomic_duplicate_state =3D drm_gem_duplicate_shadow_plane_state, \
	.atomic_destroy_state =3D drm_gem_destroy_shadow_plane_state
}

Without adding .atomic_create_state to this macro, any driver using it to
initialize their drm_plane_funcs will have .atomic_create_state left as NUL=
L.

If a driver attempts to migrate to using drm_mode_config_create_initial_sta=
te()
or relies on .atomic_create_state for initial allocation without noticing t=
his
omission, plane->state would remain NULL, which can lead to crashes from a
NULL pointer dereference.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-drm-no-mor=
e-plane-reset-v2-0-82d2963dd134@kernel.org?part=3D2
