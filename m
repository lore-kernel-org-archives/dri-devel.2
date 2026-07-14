Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 997BCC44501
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 14:04:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06BDD10ED6C;
	Tue, 14 Jul 2026 14:04:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="l057zPmA";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFCF310ED6C
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 14:04:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E192C6111A;
 Tue, 14 Jul 2026 14:04:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E3D41F000E9;
 Tue, 14 Jul 2026 14:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784037844;
 bh=Psz2s/QJ0wuSbKBdRa87DaG1zgzj65QUqPJVExOKTB0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=l057zPmAKzBrNgvhCMY0aConPhwtSiKxK9IyeFo0RRKOJuArM2IbCt6T95ogJ18sm
 SEQOotsv2v/O2qkWaayfWvIx7slfHLf1jM3XjXRKLi8xKufiGvCfK6o9Trcz4fXx6z
 SmZOJ3l+SWp5Hvx2GoTRgkzzRqaNpYlPGbSmkCf0h/t1ekieEyK4Cj2TqSjbunfqEQ
 8JtRTO+lhZ3qxscXSmxhTPK5MdBZQco3j2+om/5OY16pJeWoHQQD4roaY/ISDhD8Hy
 U8WY3w5Jd3n2MAGz4aZZey6PuwbZ8OynD98fJBkUtNShPDa2+LhYV95OZthIHSNNqi
 5VcnE9Ga9frXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] drm/panel: simple: Add waiken WKS101WX001-WCT support
To: Frank.Li@oss.nxp.com
Cc: robh@kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev,
 conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260714-dxl_lcdif-v1-3-6761a8a6592b@nxp.com>
References: <20260714-dxl_lcdif-v1-0-6761a8a6592b@nxp.com>
 <20260714-dxl_lcdif-v1-3-6761a8a6592b@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 14:04:03 +0000
Message-Id: <20260714140404.2E3D41F000E9@smtp.kernel.org>
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
- [Low] Mismatch in physical height specification between the display mode =
and the panel description.
--

--- Patch [3]: [PATCH 3/6] drm/panel: simple: Add waiken WKS101WX001-WCT su=
pport ---
commit 3308303d1b9690b2cd880fcdaaf60adb3ce4cea7
Author: Frank Li <Frank.Li@nxp.com>

drm/panel: simple: Add waiken WKS101WX001-WCT support

This commit adds support for the waiken WKS101WX001-WCT panel, which is an
industrial-grade 10.1-inch IPS TFT LCD capacitive touch screen display
module.

> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel=
/panel-simple.c
> index c09bf3db5e78a..26fd150aa4454 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c

[ ... ]

> +static const struct drm_display_mode waiken_101wx001_mode =3D {
> +	.clock =3D 71100,
> +	.hdisplay =3D 1280,
> +	.hsync_start =3D 1280 + 70,
> +	.hsync_end =3D 1280 + 70 + 10,
> +	.htotal =3D 1280 + 70 + 10 + 80,
> +	.vdisplay =3D 800,
> +	.vsync_start =3D 800 + 10,
> +	.vsync_end =3D 800 + 10 + 3,
> +	.vtotal =3D 800 + 10 + 3 + 10,
> +	.width_mm =3D 217,
> +	.height_mm =3D 135,
> +	.flags =3D DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
> +};
> +
> +static const struct panel_desc waiken_101wx001_panel =3D {
> +	.modes =3D &waiken_101wx001_mode,
> +	.num_modes =3D 1,
> +	.bpc =3D 6,
> +	.size =3D {
> +		.width =3D 217,
> +		.height =3D 136,

[Severity: Low]
Is there a reason the physical height differs between the display mode and =
the
panel descriptor?

In waiken_101wx001_mode, height_mm is set to 135, but here in
waiken_101wx001_panel the size.height is set to 136. This mismatch will
cause userspace applications querying DRM properties to receive inconsistent
dimension values depending on whether they read connector or mode propertie=
s.

> +	},
> +	.bus_format =3D MEDIA_BUS_FMT_RGB666_1X18,
> +	.connector_type =3D DRM_MODE_CONNECTOR_DPI,
> +	.bus_flags =3D DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDG=
E,
> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-dxl_lcdif-=
v1-0-6761a8a6592b@nxp.com?part=3D3
