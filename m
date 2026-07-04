Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D5DC43458
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 08:23:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D574010E06F;
	Sat,  4 Jul 2026 08:23:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GW/hPYiv";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7744A10E06F
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 08:23:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CBF266001A;
 Sat,  4 Jul 2026 08:23:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A061F000E9;
 Sat,  4 Jul 2026 08:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783153423;
 bh=Ax6N8Gojza5MvF7k+ktY/i6Sih5FQmzOwRO9mIOFaw0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GW/hPYivWUL1JJV/vQmIpF4ZRlBUI+HTMro39av0UWMHjOUFj0qXBMoHUtgk43lRL
 gfsySYbnJ5wJeDKxHy67a+mQZX5ANZb5zC4fX61XMqBk7l9HIChrl3GHZ8hVbmiWTL
 3Ny+xhmjUoblqwjblLV9ygf7+9I7fhMmSxpR90X+sm/IMY5xs/SMqepaWaBZHsHLD+
 c6iIUZ6WLqAG9pnqlyOlaKdmsL0Z07cSAqOdX0KUXAA2Lr4QqZEbej67zQG0nJH5Pg
 /IKRmaFLVz77O1hJYqF0jbH3fCEJhQQI9RsOroiC0ZV1Z+q2Etd9vGePVg8tDou26a
 caZng3gp5ITeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] drm/ssd130x: Change SSD133X color format to
 RGB565 from RGB332
To: "Amit Barzilai" <amit.barzilai22@gmail.com>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260704080925.75113-3-amit.barzilai22@gmail.com>
References: <20260704080925.75113-1-amit.barzilai22@gmail.com>
 <20260704080925.75113-3-amit.barzilai22@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Jul 2026 08:23:42 +0000
Message-Id: <20260704082343.33A061F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Red and Blue colors will be swapped on SSD133X panels due to a mis=
match between the controller's expected color sequence and the output of `d=
rm_fb_xrgb8888_to_rgb565be`.

Pre-existing issues:
- [High] Incorrect column and row end coordinates are sent to the SSD132X/S=
SD133X controllers during partial screen updates.
- [High] The `ssd133x_clear_screen` and `ssd132x_clear_screen` functions fa=
il to reset the hardware column and row ranges before clearing the screen.
- [High] Missing format conversion buffer reservation in atomic_check cause=
s a `GFP_KERNEL` allocation to be attempted during `atomic_update`.
- [High] Plane disable function returns early and fails to clear the screen=
 when a plane is detached.
--

commit 0636086c3e6d41d22249a2602bc27600caf69b06
Author: Amit Barzilai <amit.barzilai22@gmail.com>

drm/ssd130x: Change SSD133X color format to RGB565 from RGB332

SSD133X screens were driven at 8bpp RGB332 despite supporting 16bpp RGB565.
Switch the SSD133X data path to RGB565.

> diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/=
ssd130x.c
> index 04da4f2f7d087..3f09977d227b0 100644
> --- a/drivers/gpu/drm/solomon/ssd130x.c
> +++ b/drivers/gpu/drm/solomon/ssd130x.c
[ ... ]
> @@ -584,6 +589,12 @@ static int ssd132x_init(struct ssd130x_device *ssd13=
0x)
> =20
>  static int ssd133x_init(struct ssd130x_device *ssd130x)
>  {
> +	/*
> +	 * Horizontal address increment, normal SA,SB,SC (e.g. RGB) sub-pixel
> +	 * order, COM split odd even and 65k (RGB565) color depth.
> +	 */
> +	u8 remap =3D SSD133X_SET_REMAP_COM_SPLIT |
> +		   FIELD_PREP(SSD133X_SET_REMAP_COLOR_DEPTH_MASK, SSD133X_COLOR_DEPTH_=
65K);
>  	const u8 cmds[] =3D {
[ ... ]
> -		2, SSD13XX_SET_SEG_REMAP, 0x20,
> +		2, SSD13XX_SET_SEG_REMAP, remap,

[Severity: High]
Does this result in the Red and Blue color channels being swapped?

Later in the update path, ssd133x_fb_blit_rect() uses=20
drm_fb_xrgb8888_to_rgb565be(), which places Red in the MSB and Blue in the =
LSB
of the 16-bit pixel.

However, without the Color Remap bit (bit 2) set in SSD13XX_SET_SEG_REMAP,=
=20
doesn't the SSD133X hardware expect Color C (Blue) in the MSB (D15-D11) and=
=20
Color A (Red) in the LSB (D4-D0)?

[ ... ]
> @@ -794,14 +799,20 @@ static int ssd133x_update_rect(struct ssd130x_devic=
e *ssd130x,
>  	 *
> -	 * Each Segment has a 8-bit pixel and each Common output has a
> -	 * row of pixels. When using the (default) horizontal address
> -	 * increment mode, each byte of data sent to the controller has
> -	 * a Segment (e.g: SEG0).
> +	 * Each Segment holds one pixel and each Common output has a row
> +	 * of pixels. A pixel is 8 bits (one byte) in the 256 color
> +	 * (RGB332) format or 16 bits (two bytes) in the 65k color
> +	 * (RGB565) format. When using the (default) horizontal address
> +	 * increment mode, the pixel data is sent Segment by Segment
> +	 * (e.g: SEG0 first).
>  	 *
>  	 * When using the 256 color depth format, each pixel contains 3
> -	 * sub-pixels for color A, B and C. These have 3 bit, 3 bit and
> -	 * 2 bits respectively.
> +	 * sub-pixels for color A, B and C. These have 3, 3 and 2 bits
> +	 * respectively.
> +	 *
> +	 * When using the 65k color depth format, each pixel contains 3
> +	 * sub-pixels for color A, B and C. These have 5, 6 and 5 bits
> +	 * respectively.
>  	 */
> =20
>  	/* Set column start and end */

[Severity: High]
This is a pre-existing issue, but does this configure the hardware with
incorrect end coordinates when x > 0 or y > 0?

When ssd133x_update_rect() is called for a partial screen update, it passes
columns - 1 and rows - 1 as the end coordinates instead of x + columns - 1
and y + rows - 1.

Could this configure the hardware with an end coordinate smaller than the
start coordinate, causing memory wrapping and corruption?

(Note that the identical coordinate calculation bug also exists in
ssd132x_update_rect()).

[ ... ]
> @@ -874,7 +885,7 @@ static void ssd132x_clear_screen(struct ssd130x_devic=
e *ssd130x, u8 *data_array)
> =20
>  static void ssd133x_clear_screen(struct ssd130x_device *ssd130x, u8 *dat=
a_array)
>  {
> -	const struct drm_format_info *fi =3D drm_format_info(DRM_FORMAT_RGB332);
> +	const struct drm_format_info *fi =3D drm_format_info(DRM_FORMAT_RGB565);

[Severity: High]
This is a pre-existing issue, but does this function clear the screen
properly if a partial update happened previously?

Because ssd133x_clear_screen() writes a full-size buffer of clearing data
without first issuing the column and row range setup commands, if a prior
atomic plane update constrained the hardware window (for a damage clip),
won't the zeroes loop continuously within the small constrained window inst=
ead
of clearing the full screen?

(Note that this same omission exists for ssd132x_clear_screen()).

[ ... ]
> @@ -945,7 +956,7 @@ static int ssd133x_fb_blit_rect(struct drm_framebuffe=
r *fb,
>  				struct drm_format_conv_state *fmtcnv_state)
>  {
[ ... ]
>  	iosys_map_set_vaddr(&dst, data_array);
> -	drm_fb_xrgb8888_to_rgb332(&dst, &dst_pitch, vmap, fb, rect, fmtcnv_stat=
e);
> +	drm_fb_xrgb8888_to_rgb565be(&dst, &dst_pitch, vmap, fb, rect, fmtcnv_st=
ate);

[Severity: High]
This is a pre-existing issue, but will this trigger a sleeping allocation
in atomic context?

The atomic commit phase calls drm_fb_xrgb8888_to_rgb565be() here, which
internally calls drm_fb_xfrm() and dynamically allocates memory using
GFP_KERNEL.

Since ssd133x_primary_plane_atomic_check() does not call
drm_format_conv_state_reserve() to preallocate this buffer, won't this resu=
lt
in an illegal sleeping allocation during the atomic update?

[ ... ]

[Severity: High]
This is a pre-existing issue, but does the plane disable function fail to
clear the screen when a plane is detached?

In ssd130x_primary_plane_atomic_disable():

    struct drm_plane_state *plane_state =3D=20
        drm_atomic_get_new_plane_state(state, plane);
    ...
    if (!plane_state->crtc)
        return;

When a plane is explicitly disabled or detached, the new plane state's crtc
pointer is NULL.

Doesn't this early return bypass the screen clearing logic, causing the
display to freeze on the last rendered frame instead of clearing to black?
Should the old plane state be used instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260704080925.7511=
3-1-amit.barzilai22@gmail.com?part=3D2
