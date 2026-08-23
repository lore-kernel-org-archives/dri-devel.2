Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22461C5DF97
	for <dri-devel@archiver.kernel.org>; Sun, 23 Aug 2026 12:35:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13A3710E4A5;
	Sun, 23 Aug 2026 12:35:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kvVf8WHJ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90F5D10E4A5
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 12:35:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7680D60052;
 Sun, 23 Aug 2026 12:35:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026D71F000E9;
 Sun, 23 Aug 2026 12:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787488539;
 bh=guZzBU5PXG6LQtKEUssGv3Ct59SIAESQw+Sxj1YEFtI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kvVf8WHJV2QjpBdGgNBqqUB0l8SeWpzwmepWE2LJP5+NzuicGDjZQlum6+L3cdOvh
 UABUghOZDlDV8Te/vzUzhfrxFDIafhkULC3Wko6SWn6TWp8x+Ssb2FzsjJXcGgeAdj
 RuhdIiNS2hAw6MgdR3gMpOCzXJIF4JvjzYxt1Jr4z4bHpr7FINkuPse/lj2FICv3DL
 qICIzS/VPPur2+7FIJ2uvmaJhFDF8UXaExRAicRqwRa7KN2wkPoeM4ELvrieflrVKY
 wOCGFAe1bXV2uLpyopjJrilAF7VWxDW5VR5hQK8w2eEkNZRIj7qdqltDjR3At+TLzH
 A+y7m9uskb6/w==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1] drm: rockchip: add
 drm_plane_create_blend_mode_property
To: "Johan Jonker" <jbx6244@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <1ab6fb88-3b84-49b5-aa05-202a84edbd3d@gmail.com>
References: <1ab6fb88-3b84-49b5-aa05-202a84edbd3d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 12:35:38 +0000
Message-Id: <20260823123539.026D71F000E9@smtp.kernel.org>
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
- [Medium] The patch incorrectly advertises that all planes only support `D=
RM_MODE_BLEND_PIXEL_NONE`, but the driver unconditionally performs pre-mult=
iplied alpha blending for formats with an alpha channel on non-primary plan=
es.
--

--- Patch [1]: [RFC PATCH v1] drm: rockchip: add drm_plane_create_blend_mod=
e_property ---
commit b598208b3a4ac16667d04c601badf21d2ed2f848
Author: Johan Jonker <jbx6244@gmail.com>

drm: rockchip: add drm_plane_create_blend_mode_property

This commit fixes warnings in the kernel log by explicitly creating a blend
mode property for the planes. It restricts the supported blend mode to
DRM_MODE_BLEND_PIXEL_NONE.

Link: https://lore.kernel.org/all/20260526181700.25310-3-leandro.ribeiro@co=
llabora.com/

> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/dr=
m/rockchip/rockchip_drm_vop.c
> index 0090d8ff0c79e..0bc5b606f0213 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> @@ -1850,6 +1850,8 @@ static void vop_plane_add_properties(struct drm_pla=
ne *plane,
>  	if (flags)
>  		drm_plane_create_rotation_property(plane, DRM_MODE_ROTATE_0,
>  						   DRM_MODE_ROTATE_0 | flags);
> +	drm_plane_create_blend_mode_property(plane,
> +					     BIT(DRM_MODE_BLEND_PIXEL_NONE));
                                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: Medium]
Does this incorrectly advertise that all planes only support
DRM_MODE_BLEND_PIXEL_NONE?

Looking at vop_plane_atomic_update() in
drivers/gpu/drm/rockchip/rockchip_drm_vop.c, the driver unconditionally
performs pre-multiplied alpha blending for formats with an alpha channel
on overlay planes:

    if (fb->format->has_alpha && win_index > 0) {
        VOP_WIN_SET(vop, win, dst_alpha_ctl,
                    DST_FACTOR_M0(ALPHA_SRC_INVERSE));
        val =3D SRC_ALPHA_EN(1) | SRC_COLOR_M0(ALPHA_SRC_PRE_MUL) |
            SRC_ALPHA_M0(ALPHA_STRAIGHT) |
            SRC_BLEND_M0(ALPHA_PER_PIX) |
            SRC_ALPHA_CAL_M0(ALPHA_NO_SATURATION) |
            SRC_FACTOR_M0(ALPHA_ONE);
        VOP_WIN_SET(vop, win, src_alpha_ctl, val);

        VOP_WIN_SET(vop, win, alpha_pre_mul, ALPHA_SRC_PRE_MUL);
        VOP_WIN_SET(vop, win, alpha_mode, ALPHA_PER_PIX);
        VOP_WIN_SET(vop, win, alpha_en, 1);

If userspace compositors query the blend mode property and see only
PIXEL_NONE is supported, they might assume the pixel alpha channel will be
ignored and the plane rendered completely opaque.

If they assign an ARGB8888 buffer to an overlay plane, will the driver
ignore the property's implied opaque semantics and configure the hardware
to perform alpha blending anyway?

>  }
> =20
>  static int vop_create_crtc(struct vop *vop)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/1ab6fb88-3b84-49b5-=
aa05-202a84edbd3d@gmail.com?part=3D1
