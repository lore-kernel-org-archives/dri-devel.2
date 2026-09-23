Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41281C9830B
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 20:18:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7701710F173;
	Wed, 23 Sep 2026 20:18:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WHakZwuM";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3627810F173
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 20:18:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1B628409C4;
 Wed, 23 Sep 2026 20:18:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D24301F000FF;
 Wed, 23 Sep 2026 20:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790194689;
 bh=GFqmbSUj+aWSKdNdukwH5sUVVYAyiBvQ0a6X5heKkwI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WHakZwuMOuM4u1RgVTBMtHvJQk4KqQKJQzl5bbbybKpxTqoGtqRWQ9sJjxqP2YeiK
 R2ag1CObzyqK2GMYn2keJZAex4MmfpfUnasxd4g92/6DXTMVfi1XgJsVpqPk2/yBR4
 JY3XZ6HawTr3064ogq9rx9Z1as3imGFcQdtEMi0q5AWLsrA2Lkuk6ym6vRpW0lSWs3
 wW1UBOaZhNiQ/l6hepCY7LhiKFO7tNRIs1t4F9gKerjm7DqecjvCokjZAHa8HOtnPG
 qTM1Ls8bjtyp2O3vkdTWW10874k7hl+Lg+MRhUbvUBVW3dgGtKWXwDEjAnsietDs8L
 yIMG+IWdLALyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] drm/mipi-dbi: honour the plane source offset
 when flushing
To: "Jonathan Frazin" <frazinjonathan@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260923195713.88-2-frazinjonathan@gmail.com>
References: <20260923195713.88-1-frazinjonathan@gmail.com>
 <20260923195713.88-2-frazinjonathan@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 20:18:08 +0000
Message-Id: <20260923201808.D24301F000FF@smtp.kernel.org>
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
- [Medium] drm/mipi-dbi: hardware protocol violation for 0-width damage rec=
ts
--

commit f18906cb9ed3368767cdf7495a3f7b34e33a50c0
Author: Jonathan Frazin <frazinjonathan@gmail.com>
Date:   Wed Sep 23 19:57:11 2026 +0000

    drm/mipi-dbi: honour the plane source offset when flushing

This commit updates mipi_dbi_fb_dirty() to account for the plane's source
origin when calculating the display window address. It also clamps the dama=
ge
rectangle to the panel's fixed mode to prevent overshoots caused by
fractional scaling.

> diff --git a/drivers/gpu/drm/drm_mipi_dbi.c b/drivers/gpu/drm/drm_mipi_db=
i.c
> index 25cf04d029f77..1263dce91c80a 100644
> --- a/drivers/gpu/drm/drm_mipi_dbi.c
> +++ b/drivers/gpu/drm/drm_mipi_dbi.c
[ ... ]
> @@ -271,19 +271,35 @@ static void mipi_dbi_set_window_address(struct mipi=
_dbi_dev *dbidev,
>  }
> =20
>  static void mipi_dbi_fb_dirty(struct iosys_map *src, struct drm_framebuf=
fer *fb,
> -			      struct drm_rect *rect, struct drm_format_conv_state *fmtcnv_sta=
te)
> +			      struct drm_rect *rect, unsigned int src_x, unsigned int src_y,
> +			      struct drm_format_conv_state *fmtcnv_state)
>  {
[ ... ]
> +	/*
> +	 * @rect is in framebuffer coordinates, clipped to the plane's src
> +	 * rectangle by the damage iterator against that rectangle's exact
> +	 * 16.16 fixed-point bounds. @src_x/@src_y are that same origin
> +	 * truncated to whole pixels. When the origin has a fractional part,
> +	 * that truncation can leave @rect's far edge up to a pixel past
> +	 * where a whole-pixel @src_x/@src_y would place the panel's own
> +	 * width/height -- and tx_buf is sized for exactly the panel, with no
> +	 * slack for that overshoot. Clamp before using @rect for anything.
> +	 */
> +	rect->x2 =3D min_t(int, rect->x2, src_x + dbidev->mode.hdisplay);
> +	rect->y2 =3D min_t(int, rect->y2, src_y + dbidev->mode.vdisplay);
> +
> +	height =3D rect->y2 - rect->y1;
> +	width =3D rect->x2 - rect->x1;

[Severity: Medium]
If drm_atomic_helper_damage_merged() clips a damage rectangle entirely to t=
he
fractional overshoot region (e.g., where x1 is at src_x + hdisplay and x2
extends 1 pixel beyond it), does clamping only the far edge result in
rect->x2 becoming equal to rect->x1, leaving width or height as 0?

> =20
>  	full =3D width =3D=3D fb->width && height =3D=3D fb->height;
> =20
>  	DRM_DEBUG_KMS("Flushing [FB:%d] " DRM_RECT_FMT "\n", fb->base.id, DRM_R=
ECT_ARG(rect));
> @@ -298,8 +314,13 @@ static void mipi_dbi_fb_dirty(struct iosys_map *src,=
 struct drm_framebuffer *fb,
>  		tr =3D src->vaddr; /* TODO: Use mapping abstraction properly */
>  	}
> =20
> -	mipi_dbi_set_window_address(dbidev, rect->x1, rect->x2 - 1, rect->y1,
> -				    rect->y2 - 1);
> +	/*
> +	 * @rect is in framebuffer coordinates and has been clipped to the plane
> +	 * src rectangle by the damage iterator. The panel is addressed relative
> +	 * to the src origin, so subtract it here.
> +	 */
> +	mipi_dbi_set_window_address(dbidev, rect->x1 - src_x, rect->x2 - 1 - sr=
c_x,
> +				    rect->y1 - src_y, rect->y2 - 1 - src_y);

[Severity: Medium]
If width or height evaluates to 0 (as questioned above), will this calculate
an underflowed end window coordinate where the end is strictly less than the
start (e.g. xe < xs, due to rect->x2 - 1)?

Since this is followed by a 0-length data transfer, does sending an inverted
window address violate the MIPI DCS specification and potentially cause the
display controller to lock up or corrupt the display state?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923195713.88-1=
-frazinjonathan@gmail.com?part=3D1
