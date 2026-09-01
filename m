Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07ACCC624D3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 17:27:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46D4E10EA8A;
	Tue,  1 Sep 2026 17:27:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EDe26jkH";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABC6510EA8A
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 17:27:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F1B3B6022D;
 Tue,  1 Sep 2026 17:27:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859B01F000E9;
 Tue,  1 Sep 2026 17:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788283665;
 bh=AXdOY5GWTa94Gou06c2SSB+2Fzads16ylAiTY+egkzQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EDe26jkHJUunaL8iIw5ZTaAngXg/R/0bK2YzRWaSDx4zUpkGUwxa+55PXi95FQeQc
 CH5as4Jckeyu5yfgd0Yz/WGFe8XrxSx82XeC58HDtPQBTP0NFhssTOvAvy/c1QVDdB
 4B7iOlM0++aMQzqwNDaFbcoRdBzF0FiY4J+K28YRUusf908YyXcMzMQx7QHZj+qAFh
 gf0EAw1Qz0AT21SBCnkXV24yseYiVB7hBm/WHYXHmAast6L16rWb8cebUlzR3iAfWm
 V3RsDVtgcJxPGCscF1h4mHZs0porDG+ajVqKR5tapWFXdx2gbsU/Pba3AZCyxYhyGu
 7IazjDT5JkY9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/verisilicon: set blend mode for the primary plane
To: "Icenowy Zheng" <zhengxingda@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260901171703.1161592-1-zhengxingda@iscas.ac.cn>
References: <20260901171703.1161592-1-zhengxingda@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 17:27:45 +0000
Message-Id: <20260901172745.859B01F000E9@smtp.kernel.org>
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

New issues:
- [Medium] The return value of `drm_plane_create_blend_mode_property` is ig=
nored.

Pre-existing issues:
- [Critical] Dereferencing a NULL `crtc` pointer in `vs_primary_plane_atomi=
c_disable` during offscreen plane transitions.
- [High] `vs_primary_plane_atomic_disable` incorrectly sets the enable bit =
instead of clearing it.
--

commit 9aa67f5c63b091d89b8b4a7a3066a896f35cf108
Author: Icenowy Zheng <zhengxingda@iscas.ac.cn>

drm/verisilicon: set blend mode for the primary plane

Blend modes are now required to expose pixel formats w/ alpha.
   =20
As it's the primary plane and blending is explicitly disabled, just
expose PIXEL_NONE blend mode.

> diff --git a/drivers/gpu/drm/verisilicon/vs_primary_plane.c b/drivers/gpu=
/drm/verisilicon/vs_primary_plane.c
> index 1f2be41ae496c..8d58682d88ef8 100644
> --- a/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> +++ b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> @@ -7,6 +7,7 @@
> =20
>  #include <drm/drm_atomic.h>
>  #include <drm/drm_atomic_helper.h>
> +#include <drm/drm_blend.h>
>  #include <drm/drm_crtc.h>
>  #include <drm/drm_fourcc.h>
>  #include <drm/drm_framebuffer.h>

[ ... ]

[Severity: Critical]
This is a pre-existing issue, but can this dereference a NULL pointer during
offscreen plane transitions?

If userspace commits an atomic state where a plane transitions from fully
disabled (old_state->crtc =3D=3D NULL) to assigned but offscreen
(new_state->crtc !=3D NULL but new_state->visible =3D=3D false), the DRM co=
re
calls vs_primary_plane_atomic_update().

This function sees !state->visible and delegates to the disable function:

vs_primary_plane_atomic_update() {
    ...
	if (!state->visible) {
		vs_primary_plane_atomic_disable(plane, atomic_state);
		return;
	}
    ...
}

The disable function then fetches old_state->crtc, which is NULL, and
dereferences it:

vs_primary_plane_atomic_disable() {
    ...
	struct drm_plane_state *state =3D drm_atomic_get_old_plane_state(atomic_st=
ate,
								       plane);
	struct drm_crtc *crtc =3D state->crtc;
	struct vs_crtc *vcrtc =3D drm_crtc_to_vs_crtc(crtc);
	unsigned int output =3D vcrtc->id;
    ...
}

[Severity: High]
This isn't a bug introduced by this patch, but does
vs_primary_plane_atomic_disable() incorrectly set the enable bit instead of
clearing it?

vs_primary_plane_atomic_disable() {
    ...
	regmap_set_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
			VSDC_FB_CONFIG_EX_FB_EN);

	vs_primary_plane_commit(dc, output);
}

When the plane needs to be disabled, the core calls this function, which us=
es
regmap_set_bits() with the VSDC_FB_CONFIG_EX_FB_EN bit.

Should this use regmap_clear_bits() instead? The hardware plane is never
disabled, which can cause visual corruption, unexpected display state, and
potential memory access faults if the buffer memory is subsequently freed
while the hardware is still scanning it out.

> @@ -179,5 +180,7 @@ struct drm_plane *vs_primary_plane_init(struct drm_de=
vice *drm_dev, struct vs_dc
> =20
>  	drm_plane_helper_add(plane, &vs_primary_plane_helper_funcs);
> =20
> +	drm_plane_create_blend_mode_property(plane,
> +					     BIT(DRM_MODE_BLEND_PIXEL_NONE));

[Severity: Medium]
Is it intentional to ignore the return value of
drm_plane_create_blend_mode_property()?

If property creation fails (e.g. due to memory exhaustion), the plane is
initialized without the requested blend mode property, breaking userspace
expectations for alpha formats. Should this function check for an error code
and handle the failure?

>  	return plane;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901171703.1161=
592-1-zhengxingda@iscas.ac.cn?part=3D1
