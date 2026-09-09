Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF4CCC79FB6
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 10:18:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2439910F079;
	Wed,  9 Sep 2026 10:18:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VwG9PH4J";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E224210F079
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 10:18:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1AB8C601FE;
 Wed,  9 Sep 2026 10:18:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B01EB1F0155A;
 Wed,  9 Sep 2026 10:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788949094;
 bh=IRHECcNStVblaqVm70/W50PFgXyEy0jFZ2fWJ+gPcNk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VwG9PH4JzritN2DucdAo407a1QpBCcvcaGPIFu+Lsx+SK5rJC0K9tlUg1qo96O6yY
 QwViDdnniaxnR9kfLnFDxbSCYj5y8AwG9sXqS8uLmQdmiK90atY4zP3+PaaRO5iSTO
 iyBi372lnKsyn3RIRSn+8w9q7ZCQ/tkMAo3J2oadPF2YFeAeUIV8S+X6UpCCWILtqv
 SQF4V8MyEarIN7Q6fzFPtk4efLyl2hNZ2rSxd/Idg8Wim6gdoYQYe1lTT2fNCeJnt0
 F/WSNO2k7/C8u5LEBZy9KveJcovoAq7dQCb666MS0BLzoNOXzlgAQr+5HvKdZLWd3X
 8IZoaMAUdlB5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/tiny: arcpgu: Replace simple display pipe with
 regular atomic helpers
To: "Davide Bonatto" <bonatto.davide@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260909100741.147859-1-bonatto.davide@gmail.com>
References: <20260909092455.13.19.62-1-bonatto.davide@gmail.com>
 <20260909100741.147859-1-bonatto.davide@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 10:18:14 +0000
Message-Id: <20260909101814.B01EB1F0155A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] Missing validation allows the CRTC to be enabled without a pri=
mary plane, causing a NULL pointer dereference in `arc_pgu_set_pxl_fmt()`.
- [Critical] The CRTC atomic_enable hook accesses arcpgu->plane.state direc=
tly without holding the plane's lock, allowing a concurrent plane update to=
 cause a Use-After-Free.
- [High] Disabling the primary plane incorrectly clears the global CRTC ena=
ble bit, permanently desyncing hardware state from the DRM core.
- [High] Missing `.cleanup_fb` callback causes GEM object pin count leak on=
 every plane update.
--

commit a8222dfe6a09a56b144901613fe5caafe6889898
Author: Davide Bonatto <bonatto.davide@gmail.com>

drm/tiny: arcpgu: Replace simple display pipe with regular atomic helpers
   =20
This commit migrates the arcpgu driver from the legacy drm_simple_display_p=
ipe
infrastructure to explicitly managing plane, CRTC, and encoder objects using
standard atomic helpers.

> diff --git a/drivers/gpu/drm/tiny/arcpgu.c b/drivers/gpu/drm/tiny/arcpgu.c
> index c93d61ac0bb75..e500e6e52b669 100644
> --- a/drivers/gpu/drm/tiny/arcpgu.c
> +++ b/drivers/gpu/drm/tiny/arcpgu.c
[ ... ]
> @@ -117,8 +125,8 @@ static const u32 arc_pgu_supported_formats[] =3D {
> =20
>  static void arc_pgu_set_pxl_fmt(struct arcpgu_drm_private *arcpgu)
>  {
> -	const struct drm_framebuffer *fb =3D arcpgu->pipe.plane.state->fb;
> -	uint32_t pixel_format =3D fb->format->format;
> +	const struct drm_framebuffer *fb =3D arcpgu->plane.state->fb;
> +	u32 pixel_format =3D fb->format->format;

[Severity: Critical]
What happens if userspace enables the CRTC but disables the primary plane?

In that scenario, fb would be NULL, and the subsequent fb->format->format
dereference would crash the kernel. The driver does not appear to have a
CRTC atomic_check hook to prevent enabling the CRTC without a valid plane,
and arc_pgu_plane_atomic_check() gracefully returns 0 when the framebuffer
is missing.

[Severity: Critical]
Can a concurrent plane update cause a use-after-free here?

This function is called from the CRTC enable path:
arc_pgu_crtc_atomic_enable() -> arc_pgu_mode_set() -> arc_pgu_set_pxl_fmt()

Since there is no CRTC atomic_check hook calling
drm_atomic_add_affected_planes(), a modeset only locks the CRTC and not
the plane. A concurrent plane update (page flip) could acquire the plane
lock, swap the state, and free the old framebuffer, causing the modesetting
thread to read freed memory when locklessly accessing fb->format->format.

[ ... ]
> +static void arc_pgu_plane_atomic_disable(struct drm_plane *plane,
> +					 struct drm_atomic_commit *state)
> +{
> +	struct arcpgu_drm_private *arcpgu =3D plane_to_arcpgu(plane);
> +
> +	arc_pgu_write(arcpgu, ARCPGU_REG_BUF0_ADDR, 0);
> +	arc_pgu_write(arcpgu, ARCPGU_REG_CTRL,
> +		      arc_pgu_read(arcpgu, ARCPGU_REG_CTRL) &
> +		      ~ARCPGU_CTRL_ENABLE_MASK);
> +}

[Severity: High]
Does clearing ARCPGU_CTRL_ENABLE_MASK permanently desync the hardware state?

This appears to be the global CRTC enable bit. If userspace disables just
the primary plane, this clears the global enable bit for the entire CRTC.
When the plane is later re-enabled, arc_pgu_plane_atomic_update() sets the
buffer address but does not restore the CRTC enable bit, leaving the
display controller completely disabled and causing VBLANK timeouts.

[ ... ]
> +static const struct drm_plane_helper_funcs arc_pgu_plane_helper_funcs =
=3D {
> +	.atomic_update =3D arc_pgu_plane_atomic_update,
> +	.prepare_fb =3D drm_gem_plane_helper_prepare_fb,
> +	.atomic_check =3D arc_pgu_plane_atomic_check,
> +	.atomic_disable =3D arc_pgu_plane_atomic_disable,
> +};

[Severity: High]
Does this leak the GEM object pin count on every plane update?

The prepare_fb hook is set to drm_gem_plane_helper_prepare_fb, which pins
the backing BO for the framebuffer. However, there is no corresponding
cleanup_fb callback (drm_gem_plane_helper_cleanup_fb) to unpin it.=20
Whenever a framebuffer is replaced during a page flip or disabled, its pin
count will never be decremented.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909100741.1478=
59-1-bonatto.davide@gmail.com?part=3D1
