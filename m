Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6424DC5DF80
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 08:18:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFCA710E40A;
	Tue, 18 Aug 2026 08:18:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QHMYs4Cb";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5973210E40A
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 08:18:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 16C6841A0B;
 Tue, 18 Aug 2026 08:18:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80D81F000E9;
 Tue, 18 Aug 2026 08:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787041095;
 bh=pKC7rQ9BJhRdIPxdKtDknJH3NXbCDr6XKJ0DX7zQ+1Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QHMYs4Cb9NHJ/GL+swIhIQ8F1rzRn4cJ/iiZyTuKnjPjJ5tvpTP6BPXqzUVVPiBo8
 hPBaD0QykXOrYh0FbFGF89NwHGOy+5dQS60THYC0ksHLTaZsKZFnXScSVlK5Nb5OqH
 Tiy6BEV/ZfaskBaeo3v1vv4BzPptS39iDjykqvo+vkD+Md/FcOR87DhksOSGFbj1SV
 DQ7Xai34RethKre83I2wmgS+V5v+zzMugVuaNQpSmTFhnjJEBEONKjvIUznk2qtG3o
 XE49ewnCmmJNrmI7+14hAi3y4Sn2ugQICLQcsykrF1L6GJ/qZk+vPzSbpUWoKihaTt
 lfrhwENIwqZwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/6] drm/ssd130x: Change SSD133X color format to
 RGB565 from RGB332
To: "Amit Barzilai" <amit.barzilai22@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260818080626.30430-3-amit.barzilai22@gmail.com>
References: <20260818080626.30430-1-amit.barzilai22@gmail.com>
 <20260818080626.30430-3-amit.barzilai22@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 08:18:14 +0000
Message-Id: <20260818081814.A80D81F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Missing or undersized memory reservations for format conversion st=
ate in atomic check leading to atomic context violation.
- [High] Display hardware state desynchronization causing incomplete screen=
 clears.
- [High] Uninitialized kernel memory disclosure to display panel due to sil=
ent conversion failure.
--

--- Patch [2]: [PATCH v4 2/6] drm/ssd130x: Change SSD133X color format to R=
GB565 from RGB332 ---
commit 8cc727648aa06ffb4256eb0ad7ba43c6e84be6d7
Author: Amit Barzilai <amit.barzilai22@gmail.com>

drm/ssd130x: Change SSD133X color format to RGB565 from RGB332

SSD133X screens were driven at 8bpp RGB332 despite supporting 16bpp RGB565.
Switch the SSD133X data path to RGB565.

> diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/=
ssd130x.c
> index 0b0fc6fe3df23..1110aa63d0666 100644
> --- a/drivers/gpu/drm/solomon/ssd130x.c
> +++ b/drivers/gpu/drm/solomon/ssd130x.c

[ ... ]

> @@ -909,7 +920,7 @@ static void ssd132x_clear_screen(struct ssd130x_devic=
e *ssd130x, u8 *data_array)
> =20
>  static void ssd133x_clear_screen(struct ssd130x_device *ssd130x, u8 *dat=
a_array)
>  {
> -	const struct drm_format_info *fi =3D drm_format_info(DRM_FORMAT_RGB332);
> +	const struct drm_format_info *fi =3D drm_format_info(DRM_FORMAT_RGB565);
>  	unsigned int pitch;

[Severity: High]
This isn't a bug introduced by this patch, but does ssd133x_clear_screen() =
(and=20
ssd132x_clear_screen()) clear the entire screen properly?=20

Since the hardware update window (COL_RANGE and ROW_RANGE registers) is=20
not reset before writing the full-screen zero payload, won't the hardware=20
just wrap the zeroed payload within whatever stale damage rectangle was=20
last configured, leaving the rest of the panel uncleared?
=20
[ ... ]

> @@ -978,7 +989,7 @@ static int ssd133x_fb_blit_rect(struct drm_framebuffe=
r *fb,
>  				struct drm_format_conv_state *fmtcnv_state)
>  {
>  	struct ssd130x_device *ssd130x =3D drm_to_ssd130x(fb->dev);
> -	const struct drm_format_info *fi =3D drm_format_info(DRM_FORMAT_RGB332);
> +	const struct drm_format_info *fi =3D drm_format_info(DRM_FORMAT_RGB565);
>  	unsigned int dst_pitch;
>  	struct iosys_map dst;
> =20
> @@ -988,7 +999,7 @@ static int ssd133x_fb_blit_rect(struct drm_framebuffe=
r *fb,
>  	dst_pitch =3D drm_format_info_min_pitch(fi, 0, drm_rect_width(rect));
> =20
>  	iosys_map_set_vaddr(&dst, data_array);
> -	drm_fb_xrgb8888_to_rgb332(&dst, &dst_pitch, vmap, fb, rect, fmtcnv_stat=
e);
> +	drm_fb_xrgb8888_to_rgb565be(&dst, &dst_pitch, vmap, fb, rect, fmtcnv_st=
ate);
> =20
>  	ssd133x_update_rect(ssd130x, rect, data_array, dst_pitch);

[Severity: High]
This isn't a bug introduced by this patch, but is it safe to unconditionall=
y write the
data_array buffer to the hardware here?

In ssd133x_crtc_atomic_check(), data_array is allocated with kmalloc_array(=
)=20
which does not zero-initialize the memory. If drm_fb_xrgb8888_to_rgb565be()
fails and silently aborts, won't ssd133x_update_rect() then push=20
uninitialized kernel heap memory directly to the physical display?

[ ... ]

> @@ -1446,7 +1457,7 @@ static int ssd133x_crtc_atomic_check(struct drm_crt=
c *crtc,
>  	struct ssd130x_device *ssd130x =3D drm_to_ssd130x(drm);
>  	struct drm_crtc_state *crtc_state =3D drm_atomic_get_new_crtc_state(sta=
te, crtc);
>  	struct ssd130x_crtc_state *ssd130x_state =3D to_ssd130x_crtc_state(crtc=
_state);
> -	const struct drm_format_info *fi =3D drm_format_info(DRM_FORMAT_RGB332);
> +	const struct drm_format_info *fi =3D drm_format_info(DRM_FORMAT_RGB565);
>  	unsigned int pitch;
>  	int ret;

[Severity: High]
This isn't a bug introduced by this patch, but does this driver correctly m=
anage memory=20
reservations for format conversion to avoid atomic context violations?

Looking at ssd133x_primary_plane_atomic_check(), it completely omits a
call to drm_format_conv_state_reserve(). If the format conversion needs
intermediate buffers during the atomic update, it will dynamically provision
them using kmalloc(..., GFP_KERNEL) since the reservation is missing.

Similarly, ssd130x_primary_plane_atomic_check() and
ssd132x_primary_plane_atomic_check() seem to reserve undersized buffers=20
using the destination pitch rather than the source/conversion line size=20
requirement:

    buf =3D drm_format_conv_state_reserve(&shadow_plane_state->fmtcnv_state,
                                        pitch, GFP_KERNEL);

Won't these missing or undersized reservations cause sleeping functions to
be invoked during the non-blocking commit phase, violating atomic context
invariants?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818080626.3043=
0-1-amit.barzilai22@gmail.com?part=3D2
