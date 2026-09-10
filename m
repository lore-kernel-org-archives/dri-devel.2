Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6CEBC79FB9
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 10:01:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EE8510E5D3;
	Thu, 10 Sep 2026 10:01:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Uum0iGAv";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8818010E5D3
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 10:01:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D291C600C8;
 Thu, 10 Sep 2026 10:01:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6538B1F000FF;
 Thu, 10 Sep 2026 10:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789034513;
 bh=r+JTNLOiPcPdHxZynRD6P8Yd5vZPNwIgQh9uYVbNP8M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Uum0iGAvQ3GJG1kr4LfUXUltVBh7OhEbf26+I3MY9LrucaujZj++dBioIZBw2oeXT
 4GZJV8DNplvtBv1+WlmLaFOkh5AAYBoBxPKqKIusxO2x1sp1cbCVGOkq9w2fr8OeuO
 Yck9eGm/YzIWpR2nT58dfv6Amjl+cRoKvaazENKma4ftOFD/56vBd16GK+fp0I1dQ7
 YIsWhX0VCWJy5hk2TfH/JbSpBisRKUfxMY3F/P2Jj1kB1/uuJXUpaHtchUg6lED1tt
 GPQ9psxjTvbxP8jKHNn8lI7b4pYCAZlMwH/kLIftCBfXEFXCwuzJJ4Ja1JJ9VyxBXo
 4Dd5B+I/IpRdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/verisilicon: remove ARGB formats from primary
 plane
To: "Icenowy Zheng" <zhengxingda@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260910095000.3505878-2-zhengxingda@iscas.ac.cn>
References: <20260910095000.3505878-1-zhengxingda@iscas.ac.cn>
 <20260910095000.3505878-2-zhengxingda@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 10:01:53 +0000
Message-Id: <20260910100153.6538B1F000FF@smtp.kernel.org>
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
- [Medium] Unintentional removal of 10-bit color formats from the primary p=
lane.

Pre-existing issues:
- [High] Plane `atomic_disable` crashes when called on a previously disable=
d plane.
- [High] Primary plane `atomic_disable` mistakenly enables the plane in the=
 hardware register.
--

commit 53c18bf18dd1a86e14f16784c764ae73c2637d54
Author: Icenowy Zheng <zhengxingda@iscas.ac.cn>

drm/verisilicon: remove ARGB formats from primary plane
   =20
As the blending of the primary plane is currently explicitly disabled
(and it's not possible on DC8000), remove the ARGB formats from the
primary plane format tables.

> diff --git a/drivers/gpu/drm/verisilicon/vs_hwdb.c b/drivers/gpu/drm/veri=
silicon/vs_hwdb.c
> index 56aa450443068..ebf6f843bc885 100644
> --- a/drivers/gpu/drm/verisilicon/vs_hwdb.c
> +++ b/drivers/gpu/drm/verisilicon/vs_hwdb.c
> @@ -15,32 +15,16 @@ static const u32 vs_primary_formats_array_no_yuv444[]=
 =3D {
[ ... ]
>  	DRM_FORMAT_XRGB8888,
>  	DRM_FORMAT_XBGR8888,
>  	DRM_FORMAT_RGBX8888,
>  	DRM_FORMAT_BGRX8888,
> -	DRM_FORMAT_ARGB8888,
> -	DRM_FORMAT_ABGR8888,
> -	DRM_FORMAT_RGBA8888,
> -	DRM_FORMAT_BGRA8888,
> -	DRM_FORMAT_ARGB2101010,
> -	DRM_FORMAT_ABGR2101010,
> -	DRM_FORMAT_RGBA1010102,
> -	DRM_FORMAT_BGRA1010102,

[Severity: Medium]
Does the removal of DRM_FORMAT_ARGB2101010 and its variants drop all 10-bit
color support from the primary plane?

Since the opaque 10-bit counterparts (like DRM_FORMAT_XRGB2101010) are
missing from vs_primary_formats_array_no_yuv444, any userspace compositor
attempting to use 10-bit color will find no supported formats and fail.

>  	/* TODO: non-RGB formats */
>  };
> =20
> @@ -49,32 +33,16 @@ static const u32 vs_primary_formats_array_with_yuv444=
[] =3D {
[ ... ]
>  	DRM_FORMAT_XRGB8888,
>  	DRM_FORMAT_XBGR8888,
>  	DRM_FORMAT_RGBX8888,
>  	DRM_FORMAT_BGRX8888,
> -	DRM_FORMAT_ARGB8888,
> -	DRM_FORMAT_ABGR8888,
> -	DRM_FORMAT_RGBA8888,
> -	DRM_FORMAT_BGRA8888,
> -	DRM_FORMAT_ARGB2101010,
> -	DRM_FORMAT_ABGR2101010,
> -	DRM_FORMAT_RGBA1010102,
> -	DRM_FORMAT_BGRA1010102,

[Severity: Medium]
Will this also remove 10-bit color support from the secondary array
vs_primary_formats_array_with_yuv444?

Just like the array above, the opaque 10-bit formats were not added,
removing 10-bit color support for userspace compositors on this plane.

>  	/* TODO: non-RGB formats */
>  };

[Severity: High]
This isn't a bug introduced by this patch, but can
vs_primary_plane_atomic_disable() crash when called on a previously disabled
plane?

drivers/gpu/drm/verisilicon/vs_primary_plane.c:vs_primary_plane_atomic_disa=
ble() {
	struct drm_plane_state *state =3D drm_atomic_get_old_plane_state(atomic_st=
ate,
								       plane);
	struct drm_crtc *crtc =3D state->crtc;
	struct vs_crtc *vcrtc =3D drm_crtc_to_vs_crtc(crtc);
	unsigned int output =3D vcrtc->id;
        ...

If a userspace process performs an atomic commit that targets a disabled pl=
ane
and keeps it disabled or moves it out of bounds (!state->visible), DRM help=
ers
may call atomic_update. The driver's atomic_update unconditionally calls
atomic_disable for invisible planes.

When atomic_disable retrieves old_plane_state->crtc, it is NULL since the
plane was already disabled. Would this result in a NULL pointer dereference
at vcrtc->id?

This exact same pattern exists in the cursor plane's disable path in
drivers/gpu/drm/verisilicon/vs_cursor_plane.c for
vs_cursor_plane_atomic_disable():

drivers/gpu/drm/verisilicon/vs_cursor_plane.c:vs_cursor_plane_atomic_disabl=
e() {
	struct drm_plane_state *state =3D drm_atomic_get_old_plane_state(atomic_st=
ate,
								       plane);
	struct drm_crtc *crtc =3D state->crtc;
	struct vs_crtc *vcrtc =3D drm_crtc_to_vs_crtc(crtc);
	unsigned int output =3D vcrtc->id;
        ...

[Severity: High]
This is a pre-existing issue, but does vs_primary_plane_atomic_disable()
mistakenly enable the plane in the hardware register instead of disabling i=
t?

drivers/gpu/drm/verisilicon/vs_primary_plane.c:vs_primary_plane_atomic_disa=
ble() {
    ...
	regmap_set_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
			VSDC_FB_CONFIG_EX_FB_EN);
    ...
}

Whenever the primary plane is disabled (e.g., DPMS off, mode set, or
compositor exit), this code uses regmap_set_bits with VSDC_FB_CONFIG_EX_FB_=
EN.
This leaves the hardware plane active instead of disabling it.

When the DRM core subsequently frees the framebuffer memory, the display
controller hardware will continue to DMA read from the freed memory. Can th=
is
cause a Use-After-Free and potential memory corruption or IOMMU faults?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910095000.3505=
878-1-zhengxingda@iscas.ac.cn?part=3D2
