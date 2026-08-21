Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E66C5DF93
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 15:14:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8A1610E1BC;
	Fri, 21 Aug 2026 15:14:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="R5VSx6m2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B0F210E1BC
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 15:14:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3711D41299
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 15:14:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E48E51F000E9;
 Fri, 21 Aug 2026 15:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787325271;
 bh=ZYGoidQOiEW+Ca91vdpp2LDgeOxIqb6qUf0120mkWfA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=R5VSx6m2e6Dv2NTJT+F7K6O5UnDV8Spk+PihzCcvdLolGmLKtu93a4mB4/Tdm5lM1
 FHYrnFKvAQK2qzbaRl8iqfS8ceD5CWWFTDx9ADw/zPSVvgP4aEteOrpV8SxRw30ZQl
 JTEyCdg6qmnYR9C3k+JTgFJ7rw7DW4SAoLmUDVBxxvJy/0m3j6pOpoe6BGxayYX3wG
 MYQBqBwjCfM6VESK5q6jrWqCdXGz/XXjQ38lne30uFuP2VcrbE3e84d81ROcDyDTcc
 KWNHNNJ2Xm5yyjjsgikWnIFS7frl/b92YHax9POIa7ma5WkWqmKbYLiMudYTr0FeiC
 vBzjwfYWM1aVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 23/70] drm/sitronix: st7571: Switch to
 drm_atomic_helper_crtc_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-23-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
 <20260821-drm-no-more-crtc-reset-v1-23-fb793475c05a@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 15:14:30 +0000
Message-Id: <20260821151430.E48E51F000E9@smtp.kernel.org>
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
- [High] Unconditional 8-line page iterations in `st7571_transform_xy` caus=
e an out-of-bounds read when `nlines` is not a multiple of 8.
- [High] Mismatch between framebuffer pitch during conversion and reading c=
auses display corruption and invalid reads from `hwbuf`.
--

--- Patch [23]: [PATCH 23/70] drm/sitronix: st7571: Switch to drm_atomic_he=
lper_crtc_create_state ---
commit cf528fe94124a1e49e93edb3680754d3976e2864
Author: Maxime Ripard <mripard@kernel.org>

drm/sitronix: st7571: Switch to drm_atomic_helper_crtc_create_state
   =20
The st7571 crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook. Switch to
drm_atomic_helper_crtc_create_state() instead.

> diff --git a/drivers/gpu/drm/sitronix/st7571.c b/drivers/gpu/drm/sitronix=
/st7571.c
> index 20954c33eca93..fc3ba5e8600f6 100644
> --- a/drivers/gpu/drm/sitronix/st7571.c
> +++ b/drivers/gpu/drm/sitronix/st7571.c
> @@ -424,7 +424,7 @@ static const struct drm_crtc_helper_funcs st7571_crtc=
_helper_funcs =3D {
>  };
> =20
>  static const struct drm_crtc_funcs st7571_crtc_funcs =3D {
> -	.reset =3D drm_atomic_helper_crtc_reset,
> +	.atomic_create_state =3D drm_atomic_helper_crtc_create_state,
>  	.destroy =3D drm_crtc_cleanup,
>  	.set_config =3D drm_atomic_helper_set_config,
>  	.page_flip =3D drm_atomic_helper_page_flip,

[Severity: High]
This isn't a bug introduced by this patch, but does this code cause an
out-of-bounds read when nlines is not a multiple of 8?

In drivers/gpu/drm/sitronix/st7571.c:st7571_probe():
	st7571->hwbuf =3D devm_kzalloc(st7571->dev,
				     (st7571->nlines * st7571->ncols * st7571->bpp) / 8,
				     GFP_KERNEL);

If nlines is not a multiple of 8, hwbuf is allocated strictly based on the
unaligned nlines value.

During a display update:

drivers/gpu/drm/sitronix/st7571.c:st7571_fb_update_rect_monochrome():
	for (int y =3D rect->y1; y < rect->y2; y +=3D ST7571_PAGE_HEIGHT) {

drivers/gpu/drm/sitronix/st7571.c:st7571_transform_xy():
	for (int i =3D 0; i < 8; i++) {
		int row_idx =3D y + i;
		u8 byte =3D p[row_idx * row_len + x];

This iterates 8 times vertically, which could read beyond the allocated buf=
fer
if nlines is smaller than the assumed 8-line page height.


[Severity: High]
This is a pre-existing issue, but does a mismatch between the framebuffer
pitch during conversion and reading cause invalid reads from hwbuf?

In drivers/gpu/drm/sitronix/st7571.c:st7571_prepare_buffer_monochrome():
	dst_pitch =3D DIV_ROUND_UP(drm_rect_width(rect), 8);
	iosys_map_set_vaddr(&dst, st7571->hwbuf);
	drm_fb_xrgb8888_to_mono(&dst, &dst_pitch, vmap, fb, rect, fmtcnv_state);

The converted partial damage is tightly packed at offset 0 of hwbuf with a
dynamic pitch.

However, when reading the data:

drivers/gpu/drm/sitronix/st7571.c:st7571_fb_update_rect_monochrome():
	row[x] =3D st7571_transform_xy(st7571->hwbuf, x, y, 1);

drivers/gpu/drm/sitronix/st7571.c:st7571_transform_xy():
	u8 row_len =3D 16 * bpp;
	...
	int row_idx =3D y + i;
	u8 byte =3D p[row_idx * row_len + x];

st7571_transform_xy() accesses hwbuf using absolute coordinates and assumes=
 a
full-screen layout with a fixed pitch, which seems to completely miss the
packed damage data.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-drm-no-mor=
e-crtc-reset-v1-0-fb793475c05a@kernel.org?part=3D23
