Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9530AC98338
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 18:43:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAF8710E691;
	Sun, 27 Sep 2026 18:43:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NmkI7HEg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A0D010E691
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 18:43:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0E18460052;
 Sun, 27 Sep 2026 18:43:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B6B71F000FF;
 Sun, 27 Sep 2026 18:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790534608;
 bh=afsyPqr6K3RrPooxiMars5q1pjzphSzjMRyNifTqSuQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NmkI7HEg1k9n6mrBy6MXiux/esf6lGPxz9bRMGm4UvNyaLi2sBfjDk/IFOQWbmQCt
 VMmLqIht0gBIghFPDLchxp0xtEdi4WP/06opShihHkp0m/h/BIt89axTcPGqwkaV4J
 DkX6xNAcup5sASQscugz8u90A9q3mBJCmE9NfITdKOCwmQL62bfPaRWEA/iRWrZF8u
 Jt6T/vimCjtTtsZeEvFgmism0b0CiUODdVa5XRZhBjYfHQvp5+6kjfhFUM/oed6IHn
 nJAZet1omTEtoj2uvwA26YgxUFYiPRZzdcXUlrNMLxidJt7QBkfb8Vy7USy6qHpP3f
 6IwHBnRQUnh/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/14] drm/solomon: ssd16xx: Expose color mode as
 plane property
To: "Devarsh Thakkar" <devarsht@ti.com>
Cc: dri-devel@lists.freedesktop.org, conor+dt@kernel.org, robh@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260927182329.4193961-10-devarsht@ti.com>
References: <20260927182329.4193961-1-devarsht@ti.com>
 <20260927182329.4193961-10-devarsht@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 18:43:28 +0000
Message-Id: <20260927184328.6B6B71F000FF@smtp.kernel.org>
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
- [High] drm/solomon: ssd16xx: 3-color mode with partial refresh corrupts R=
1 pixels
- [Medium] drm/solomon: ssd16xx: Commit message contradicts color_mode prop=
erty creation
--

commit 50bd4d2129cba69722affa1695b7f8c68a0578a8
Author: Devarsh Thakkar <devarsht@ti.com>

drm/solomon: ssd16xx: Expose color mode as plane property

This commit introduces a new DRM plane property called "color_mode" to supp=
ort
panels with 3-color (black/white/red) display modes. It allows switching
between standard black/white representation and a 3-color representation wh=
ere
the R1 format designates red ink on a white background.

> Add a DRM plane property "color_mode" for panels that support
> 3-color (black/white/red) display modes.
>=20
> The property allows runtime selection between:
>   - bw (black/white): R1 format represents black (0) and white (1)
>   - 3color: R1 format represents red ink (1) on white background
>=20
> This property is only created on panels with red_supported =3D true.

[Severity: Medium]
The commit message states the property is only created on panels where red
is supported.

However, the code in ssd16xx_plane_create_properties() appears to create
it unconditionally for all panels (while restricting the selectable enum
options if unsupported).

Is this description accurate?

> The default is set from the panel configuration's default_color_mode
> field (typically BW for monochrome panels).
>=20
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>

diff --git a/drivers/gpu/drm/solomon/ssd16xx.c b/drivers/gpu/drm/solomon/ss=
d16xx.c
index dc2b8fe536af3..3815af0cee5c5 100644
--- a/drivers/gpu/drm/solomon/ssd16xx.c
+++ b/drivers/gpu/drm/solomon/ssd16xx.c
[ ... ]
@@ -1568,6 +1587,7 @@ static void ssd16xx_plane_atomic_update(struct drm_pl=
ane *plane,
 	}
=20
 	device->refresh_mode =3D new_ssd->refresh_mode;
+	device->color_mode =3D new_ssd->color_mode;

[Severity: High]
When a user sets color_mode to 3COLOR and refresh_mode to PARTIAL,
device->color_mode is updated here before calling ssd16xx_fb_dirty().

However, looking at ssd16xx_fb_dirty():

drivers/gpu/drm/solomon/ssd16xx.c:ssd16xx_fb_dirty() {
    ...
    if (device->color_mode =3D=3D SSD16XX_COLOR_MODE_3COLOR &&
        (device->refresh_mode =3D=3D SSD16XX_REFRESH_FULL ||
         device->refresh_mode =3D=3D SSD16XX_REFRESH_FAST)) {
            red_buffer =3D device->tx_red_buf;
    }
    ...
    if (red_buffer)
            ssd16xx_convert_fb_to_3color(mono_buffer, red_buffer, &map, fb,=
 rect);
    else
            ssd16xx_convert_fb_to_1bpp(mono_buffer, &map, fb, rect, device-=
>orientation);
    ...
}

Because red_buffer is only initialized for FULL or FAST refresh modes, a
PARTIAL refresh in 3-color mode leaves red_buffer as NULL.

This triggers the fallback to ssd16xx_convert_fb_to_1bpp(), which copies
R1 bits directly and interprets them as luma (0=3Dblack, 1=3Dwhite) instead=
 of
the 3-color expectation (0=3Dwhite, 1=3Dred).

Can this lead to corrupted R1 pixel colors during a partial refresh?

 	/*
 	 * When refresh_mode_init was set, use the specified mode for this first
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927182329.4193=
961-1-devarsht@ti.com?part=3D9
