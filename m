Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2614CC79FBB
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 21:29:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02BB010F2A3;
	Wed,  9 Sep 2026 21:29:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JokJuPBu";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEA4A10F2A3
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 21:29:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 44BEC4095F;
 Wed,  9 Sep 2026 21:29:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F14F31F000FF;
 Wed,  9 Sep 2026 21:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788989395;
 bh=Yij5XOfukTCq8IKFTZEI3f/gZ0KCVjo2B4A4it81e+w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JokJuPBuCtm/LURoOp+0owF7l+2zBY6L8pkzEM2lNEJ/iJlHH6WthL5wh42plT3kG
 0Sjt3h8xDVQep9h5Hg19o+4qmOFQ0hBHpyLyXcQoQbt4wsH9SklpnyQ8h51b2cxPac
 J0fPp6ByuYFx2gN3ES5UqFPvKV+K2GFUh4lWSeD8FKjG890Mhjhe5BRemgi2QcZAz3
 Z8xrOAFQcBQL8Vsl/EBYPH1SKZHBejTCYFDaz28pqt0qP66i3iwoTzHH2T/GuMiaYD
 Birvqs1NLTVLHw3Ei/zB5ekMpyu9Pa7e66febsJOSQijPzFOi7oJbSdVnMcTOTBXp0
 9GFL14IklswSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm: rockchip: add drm_plane_create_blend_mode_property
To: "Johan Jonker" <jbx6244@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260909-blend-v2-1-37e27af4faee@gmail.com>
References: <20260909-blend-v2-1-37e27af4faee@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 21:29:54 +0000
Message-Id: <20260909212954.F14F31F000FF@smtp.kernel.org>
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
- [High] The patch advertises DRM_MODE_BLEND_PIXEL_NONE as the only support=
ed blend mode for all planes. However, the driver internally hardcodes pre-=
multiplied alpha blending for overlay planes, contradicting the advertised =
property and causing performance regressions in compositors.
--

commit 7635dc169cfab0b1a798ba56a1baaa9f77713842
Author: Johan Jonker <jbx6244@gmail.com>

drm: rockchip: add drm_plane_create_blend_mode_property

A validate_blend_mode_for_alpha_formats() function was added that
fills the kernel log with warnings for Rockchip VOP version 1 SoCs.
Add a drm_plane_create_blend_mode_property() function as fix.
VOP version 1 doesn't support blending with a pixel alpha background
layer, only with a constant alpha. Advertise blending capability with
DRM_MODE_BLEND_PIXEL_NONE.

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

[Severity: High]
Does advertising only DRM_MODE_BLEND_PIXEL_NONE here cause a performance
regression for userspace compositors?

When compositors query this property and see only DRM_MODE_BLEND_PIXEL_NONE
is supported, they may assume the hardware cannot perform alpha blending at
all and fall back to software or GPU composition for translucent layers like
cursors and ARGB windows.

Also, does this contradict the blending mode currently programmed in the dr=
iver?
Looking at vop_plane_atomic_update(), the driver explicitly programs
pre-multiplied alpha blending for overlay planes if the format has alpha:

drivers/gpu/drm/rockchip/rockchip_drm_vop.c:vop_plane_atomic_update() {
    ...
    if (fb->format->has_alpha && win_index > 0) {
        ...
        val =3D SRC_ALPHA_EN(1) | SRC_COLOR_M0(ALPHA_SRC_PRE_MUL) |
              ...
        ...
        VOP_WIN_SET(vop, win, alpha_pre_mul, ALPHA_SRC_PRE_MUL);
        ...
    }
}

Since the driver hardcodes pre-multiplied alpha for these planes, does this
violate the advertised API contract of only supporting
DRM_MODE_BLEND_PIXEL_NONE?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-blend-v2-1=
-37e27af4faee@gmail.com?part=3D1
