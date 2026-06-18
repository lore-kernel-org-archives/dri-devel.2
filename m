Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C9FCCD98F2
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:43:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E55010E3EA;
	Thu, 18 Jun 2026 12:43:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DZ2tiQu/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF87110E3EA
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 12:43:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 36BDD60008;
 Thu, 18 Jun 2026 12:43:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98211F000E9;
 Thu, 18 Jun 2026 12:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781786585;
 bh=v0bextYkzYiRnHFWeuimI4dftVpBsD2CEIKb+vaKRp4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DZ2tiQu/J8hopCdOc8RPujxhfhVegYC4MLyYh9uDqp7+J2K2Y34tRF4vqLHpsVuji
 /5QzMZHDL4MIVzixSEljxMUNmRJVJPyyiye5GZyDpVfEQyzZ2DeejFLOOwTBzrUyrl
 11XjGMk9z1XpAkfRg0OpWy8GpAiVJt24TOqehjLAa7312uZ8IwW3500vhaK/ZrwLJO
 /zl5qKzq3HRUbmKc57SoPHmCRxsqTydrg1YPJJM5y+fw6COHnbc+zR/rGBXSelwqKm
 CCLJFsb5yewhA14ZWe11CbTRHmH5/pJfEiBsDR48aJa5EyFXM4YcUHxveyUMoBD9/f
 7euZHDXWbV9zQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/6] drm/hibmc: Fix list of formats on the primary plane
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260618123142.92298-3-tzimmermann@suse.de>
References: <20260618123142.92298-1-tzimmermann@suse.de>
 <20260618123142.92298-3-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 12:43:05 +0000
Message-Id: <20260618124305.B98211F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] The display plane atomic update ignores the plane state's source c=
oordinates and dimensions, causing corrupted output for cropped or panned f=
ramebuffers.
- [High] The CRTC atomic flush immediately sends the vblank event instead o=
f arming it, breaking page-flip synchronization.
--

commit c951a1d1c3d9caa9dc42e8ab8693ac3a8121b925
Author: Thomas Zimmermann <tzimmermann@suse.de>
Subject: drm/hibmc: Fix list of formats on the primary plane

This commit removes unsupported formats from the primary plane, leaving
only XRGB8888 and RGB565. It addresses issues where planes with alpha
channels or BGR order were not properly supported, and fixes distorted
output for RGB888.

> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c b/drivers/gpu=
/drm/hisilicon/hibmc/hibmc_drm_de.c
> index 7c0b88c774b5e..2e6e189bec1a0 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
> @@ -135,10 +135,8 @@ static void hibmc_plane_atomic_update(struct drm_pla=
ne *plane,
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does
hibmc_plane_atomic_update() ignore the plane state's source coordinates?

It programs the hardware's visible scanout width using the full fb->width
instead of the active source width (new_state->src_w >> 16):

	writel(gpu_addr, priv->mmio + HIBMC_CRT_FB_ADDRESS);
	reg =3D drm_format_info_min_pitch(fb->format, 0, fb->width);
	line_l =3D fb->pitches[0];
	writel(HIBMC_FIELD(HIBMC_CRT_FB_WIDTH_WIDTH, reg) |
	       HIBMC_FIELD(HIBMC_CRT_FB_WIDTH_OFFS, line_l),
	       priv->mmio + HIBMC_CRT_FB_WIDTH);

Since the shadow plane damage copy maintains the original framebuffer's
layout in VRAM, scanning out from offset 0 with fb->width means the
hardware will always display the top-left of the framebuffer. If userspace
provides a framebuffer larger than the CRTC (e.g., for panning) or requests
cropping, will the hardware fetch the wrong number of pixels per scanline
and display the wrong region?

> =20
>  static const u32 channel_formats1[] =3D {
> -	DRM_FORMAT_RGB565, DRM_FORMAT_BGR565, DRM_FORMAT_RGB888,
> -	DRM_FORMAT_BGR888, DRM_FORMAT_XRGB8888, DRM_FORMAT_XBGR8888,
> -	DRM_FORMAT_RGBA8888, DRM_FORMAT_BGRA8888, DRM_FORMAT_ARGB8888,
> -	DRM_FORMAT_ABGR8888
> +	DRM_FORMAT_XRGB8888,
> +	DRM_FORMAT_RGB565,
>  };

[Severity: High]
This is a pre-existing issue, but does hibmc_crtc_atomic_flush()
immediately send the vblank event instead of arming it?

	if (crtc->state->event)
		drm_crtc_send_vblank_event(crtc, crtc->state->event);
	crtc->state->event =3D NULL;

Because the driver has working vblank interrupts (as shown by
hibmc_crtc_enable_vblank()), shouldn't it defer the event until the actual
vertical blanking interval with drm_crtc_arm_vblank_event()? Immediately
completing the event violates the atomic KMS API contract, causing
userspace compositors to render the next frame prematurely, which results
in screen tearing and breaks presentation timing guarantees.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618123142.9229=
8-1-tzimmermann@suse.de?part=3D2
