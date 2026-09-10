Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 370BFC79FBF
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 19:05:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 818C110E27F;
	Thu, 10 Sep 2026 19:05:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="joHnjXN9";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0829F10E27F
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 19:05:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3FA1660A87;
 Thu, 10 Sep 2026 19:05:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE6AE1F000FF;
 Thu, 10 Sep 2026 19:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789067142;
 bh=KOvuIk5dAGylnFrLl/tFhi3NHRXmINOnoUyUuhQlmlA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=joHnjXN9WVVOSOU/6J5kYRV/sC5DNmSm5p8rIpV3aKfjzZmRmffxwrM33TLVIGIFu
 7Qrcm+FX7ome1jtzrT+HuwIe2C/mYkQS8INqwZVe3OvHujMaRKpnhBA3Bslzb4ZzNE
 Yb/G+U/GdGYPeZ7skd5BtrNYlCbnjKkwg8+5Sg3F8JjGnc058lFspHaKb6Mv+jcoB+
 qm8yL1iWF5JQoRPMdl/vDR0q04dMERV6js1Bm5NO5YcEDlP6PjeMRrlqq2+pZZq4M+
 2QdhGEpTCLSjffhzUZpFVTQ8HBV2UF0F8WrOcO7qY5iVFZuRiube/6nH1TGDSAInOl
 LiasnbrpQqkNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/2] drm/tiny: allow a framebuffer larger than the
 panel on MIPI DBI drivers
To: "Jonathan Frazin" <frazinjonathan@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260910185030.870-3-frazinjonathan@gmail.com>
References: <20260910185030.870-1-frazinjonathan@gmail.com>
 <20260910185030.870-3-frazinjonathan@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 19:05:42 +0000
Message-Id: <20260910190542.BE6AE1F000FF@smtp.kernel.org>
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
- [Critical] Heap buffer overflow in MIPI DBI transmit buffer due to fracti=
onal source coordinates.
--

commit 4a10bf379a1886aa47defe01dc700836d3b28773
Author: Jonathan Frazin <frazinjonathan@gmail.com>

drm/tiny: allow a framebuffer larger than the panel on MIPI DBI drivers

This commit raises the max_width and max_height for several MIPI DBI
drivers to DRM_SHADOW_PLANE_MAX_WIDTH/HEIGHT. This allows userspace to
allocate larger framebuffers and use the plane source rectangle to
pan without scaling.

> diff --git a/drivers/gpu/drm/tiny/panel-mipi-dbi.c b/drivers/gpu/drm/tiny=
/panel-mipi-dbi.c
> index 60cd65cae41d8..a0a098b0da8a3 100644
> --- a/drivers/gpu/drm/tiny/panel-mipi-dbi.c
> +++ b/drivers/gpu/drm/tiny/panel-mipi-dbi.c
[ ... ]
> @@ -448,9 +448,13 @@ static int panel_mipi_dbi_spi_probe(struct spi_devic=
e *spi)
>  		return ret;
> =20
>  	drm->mode_config.min_width =3D dbidev->mode.hdisplay;
> -	drm->mode_config.max_width =3D dbidev->mode.hdisplay;
> +	/*
> +	 * Allow a framebuffer larger than the panel so a sub-region can be
> +	 * displayed via the plane source rectangle (crop / pan, no scaling).
> +	 */
> +	drm->mode_config.max_width =3D DRM_SHADOW_PLANE_MAX_WIDTH;

[Severity: Critical]
Can this change cause a heap buffer overflow in mipi_dbi_fb_dirty()?

By allowing the framebuffer to be larger than the panel, userspace can now
use non-zero source offsets. If userspace provides fractional source
coordinates via the atomic ioctl, the damage iterator will round the
coordinates outwards (floor and ceil).

This can result in a merged damage rectangle that is larger than the
physical panel dimensions, which gets passed to
drm_mipi_dbi_plane_helper_atomic_update():

drivers/gpu/drm/drm_mipi_dbi.c:drm_mipi_dbi_plane_helper_atomic_update() {
    ...
    if (drm_atomic_helper_damage_merged(old_plane_state, plane_state, &rect=
))
        mipi_dbi_fb_dirty(&shadow_plane_state->data[0], fb, &rect,
    ...
}

Then in mipi_dbi_fb_dirty(), the inflated rectangle is used to compute the
copy bounds:

drivers/gpu/drm/drm_mipi_dbi.c:mipi_dbi_fb_dirty() {
    ...
    unsigned int height =3D rect->y2 - rect->y1;
    unsigned int width =3D rect->x2 - rect->x1;
    ...
    ret =3D mipi_dbi_buf_copy(tr, src, fb, rect, swap, fmtcnv_state);
    ...
}

Since tx_buf was strictly allocated during drm_mipi_dbi_dev_init() to hold
exactly the panel size, copying based on this inflated width and height will
overflow tx_buf on the heap.

>  	drm->mode_config.min_height =3D dbidev->mode.vdisplay;
> -	drm->mode_config.max_height =3D dbidev->mode.vdisplay;
> +	drm->mode_config.max_height =3D DRM_SHADOW_PLANE_MAX_HEIGHT;
>  	drm->mode_config.funcs =3D &panel_mipi_dbi_mode_config_funcs;
>  	drm->mode_config.preferred_depth =3D bpp;
>  	drm->mode_config.helper_private =3D &panel_mipi_dbi_mode_config_helper_=
funcs;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910185030.870-=
1-frazinjonathan@gmail.com?part=3D2
