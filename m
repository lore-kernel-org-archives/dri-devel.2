Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2AE606A326
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 10:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RLEyGsoy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C9A610FB08;
	Wed, 25 Nov 2026 10:35:20 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3CB610FB0D
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 10:35:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 85AE941B16;
 Wed, 25 Nov 2026 10:35:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66631F000CA;
 Wed, 25 Nov 2026 10:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795602914;
 bh=wPIRkpFj+VSo60G8la9AkeFVrHqbs05EY6/zMJntnBM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RLEyGsoyucnIE7j2IRZtTUJcqt4HS+6vJ+D8cN9bYLdzjco10BPUFHd9Et/wzqY2j
 JL63kooXErRUdscYJE8mzj1coAi+d6snST2VwYGomatsWppjtCcypEcbe7KviSfA1w
 uDNL2e9+SQNWEkQIqtaMwJPkTV1fE25L6uC9MWpAfr98Zii/aszJMI09mYlBbyPnjB
 6/jTHDyhc5XA+j4ENzBnAe3+OuBTbLNP80Qb4sqF5XSS4C1kKCL68q0hN6VdnF6y5E
 B0UyU9r2aktgk/03fu6bbdONYuydgX2vCqiFT5syc4PpjtvACRr7w7Vebvq+hhRSHJ
 eFdSxpYIOM8oA==
Message-ID: <sashiko-outbox-233133@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] drm/panel: simple: Add support for Goworld
 ILI6150H6 panel
To: "Alessandro Zini" <alessandro.zini@siemens.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261125102700.126248-4-alessandro.zini@siemens.com>
References: <20261125102700.126248-1-alessandro.zini@siemens.com>
 <20261125102700.126248-4-alessandro.zini@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 10:35:13 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/panel: simple: missing DRM_BUS_FLAG_DE_HIGH in
  goworld_ili6150h6
--

commit 7f53184ccc00be47fc506de056145e3aebeaf6e0
Author: Wang Yang <yang.wang-wy@siemens.com>

drm/panel: simple: Add support for Goworld ILI6150H6 panel

This commit adds display timing, panel descriptor, and the
"goworld,ili6150h6" device-tree compatible entry for the Goworld ILI6150H6
LVDS panel.

> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel=
/panel-simple.c
> index 33d954f3ee289..9beba399119cc 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -2543,6 +2543,35 @@ static const struct panel_desc giantplus_gpm940b0 =
=3D {
>  	.bus_flags =3D DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_SAMPLE_POSED=
GE,
>  };
> =20
> +static const struct display_timing goworld_ili6150h6_timing =3D {
> +	.pixelclock =3D { 44900000, 51200000, 63000000 },
> +	.hactive =3D { 1024, 1024, 1024 },
> +	.hfront_porch =3D { 16, 160, 216 },
> +	.hback_porch =3D { 160, 160, 160 },
> +	.hsync_len =3D { 1, 1, 256 },
> +	.vactive =3D { 600, 600, 600 },
> +	.vfront_porch =3D { 1, 12, 127 },
> +	.vback_porch =3D { 23, 23, 23 },
> +	.vsync_len =3D { 1, 3, 20 },
> +	.flags =3D DISPLAY_FLAGS_DE_HIGH,
> +};
> +
> +static const struct panel_desc goworld_ili6150h6 =3D {
> +	.timings =3D &goworld_ili6150h6_timing,
> +	.num_timings =3D 1,
> +	.bpc =3D 8,
> +	.size =3D {
> +		.width =3D 154,
> +		.height =3D 85,
> +	},
> +	.delay =3D {
> +		.enable =3D 25,
> +		.disable =3D 25,
> +	},
> +	.bus_format =3D MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
> +	.connector_type =3D DRM_MODE_CONNECTOR_LVDS,
> +};

[Severity: Medium]
Should goworld_ili6150h6 set .bus_flags =3D DRM_BUS_FLAG_DE_HIGH to match
DISPLAY_FLAGS_DE_HIGH in goworld_ili6150h6_timing?

panel_simple_get_timings_modes() converts display_timing entries through
drm_display_mode_from_videomode(), which ignores DISPLAY_FLAGS_DE_HIGH,
and panel_simple_get_non_edid_modes() sets
connector->display_info.bus_flags from panel->desc->bus_flags.  Without
.bus_flags in goworld_ili6150h6, connector->display_info.bus_flags remains
0, so LVDS bridges and display controllers checking DRM_BUS_FLAG_DE_HIGH
will not configure active-high DE polarity.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125102700.1262=
48-1-alessandro.zini@siemens.com?part=3D3
