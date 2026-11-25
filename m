Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861FF606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 10:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hDdAPcZc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E68E210FAFA;
	Wed, 25 Nov 2026 10:28:18 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8693D10FAFA
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 10:28:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 81C4460F7C;
 Wed, 25 Nov 2026 10:28:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C12161F000D8;
 Wed, 25 Nov 2026 10:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795602491;
 bh=T/vjXrDrOmURMsVld3JH//LKMEf80TQjoe2Cv0+uAys=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hDdAPcZc2Q4Bf/WCMlIN9w/CxQEAfqerEpoqp0j+8QVqw3vNxvm1XFu6pjImg47VZ
 uNAglPEjw5IWri/tJKx16jWiLx9ZNUL0PUFBxcjKqXwDaJBgdFhPujrB53h10UMVYf
 /D1VYxguXIeM21AYxNuHnTwR+JonzTBhXRThPe6R4SjX1TKE66WJvSJayJQExdrnXx
 zxmO7MZnMB/PguZoDWEuHGpbwgZJOMdzOLwngGxEVsYNDAA0MqrlK9RUznj9HBOZsh
 E/l6xbg7WosS4qn4x1XpaefMc/hCvo0nOLIohXD9WR5s6kQYgM3X8Ja7ysDv1KqS2p
 GCod0YIo4lLnw==
Message-ID: <sashiko-outbox-233121@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] drm/panel: simple: Add support for Techshine
 TS-P0700031A panel
To: "Alessandro Zini" <alessandro.zini@siemens.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261125101936.103094-4-alessandro.zini@siemens.com>
References: <20261125101936.103094-1-alessandro.zini@siemens.com>
 <20261125101936.103094-4-alessandro.zini@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 10:28:10 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] drm/panel: simple: missing DRM_BUS_FLAG_DE_HIGH in
  techshine_ts_p0700031a
- [Medium] drm/panel: simple: outline dimensions used for
  techshine_ts_p0700031a.size
--

commit 09cc823426aa17952fdeb447b0b574537835dc2b
Author: Andrej Valek <andrej.v@skyrain.eu>

drm/panel: simple: Add support for Techshine TS-P0700031A panel

This commit adds a display timing descriptor, a panel descriptor, and an OF
match table entry for the Techshine TS-P0700031A LVDS panel.

> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel=
/panel-simple.c
> index 33d954f3ee289..8eda4f74bc44f 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -4827,6 +4827,35 @@ static const struct panel_desc tsd_tst043015cmhx =
=3D {
>  	.bus_flags =3D DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGED=
GE,
>  };
> =20
> +static const struct display_timing techshine_ts_p0700031a_timing =3D {
> +	.pixelclock =3D { 44900000, 51200000, 63000000 },
> +	.hactive =3D { 1024, 1024, 1024 },
> +	.hfront_porch =3D { 16, 160, 216 },
> +	.hback_porch =3D { 160, 160, 160 },
> +	.hsync_len =3D { 1, 1, 256 },
> +	.vactive =3D { 600, 600, 600 },
> +	.vfront_porch =3D { 1, 12, 127 },
> +	.vback_porch =3D { 23, 23, 23 },
> +	.vsync_len =3D { 1, 1, 128 },
> +	.flags =3D DISPLAY_FLAGS_DE_HIGH,
> +};
> +
> +static const struct panel_desc techshine_ts_p0700031a =3D {
> +	.timings =3D &techshine_ts_p0700031a_timing,
> +	.num_timings =3D 1,
> +	.bpc =3D 8,
> +	.size =3D {
> +		.width =3D 165,
> +		.height =3D 105,
> +	},

[Severity: Medium]
Are 165 mm and 105 mm in techshine_ts_p0700031a.size the mechanical module
outline dimensions rather than the active display area?

struct panel_desc.size specifies the active display area in millimeters and
populates connector->display_info.width_mm and height_mm.  For a 7.0-inch
1024x600 panel, 165x105 mm yields a 7.7-inch diagonal and non-square pixel
aspect ratio instead of the ~154x86 mm active area.

> +	.delay =3D {
> +		.enable =3D 25,
> +		.disable =3D 25,
> +	},
> +	.bus_format =3D MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
> +	.connector_type =3D DRM_MODE_CONNECTOR_LVDS,
> +};

[Severity: Medium]
Should techshine_ts_p0700031a also set .bus_flags =3D DRM_BUS_FLAG_DE_HIGH =
to
match DISPLAY_FLAGS_DE_HIGH in techshine_ts_p0700031a_timing?

panel_simple_get_timings_modes() does not translate DISPLAY_FLAGS_DE_HIGH
into connector->display_info.bus_flags, which panel_simple_get_non_edid_mod=
es()
copies directly from panel->desc->bus_flags.  Leaving .bus_flags unset leav=
es
display_info.bus_flags as 0 for display controllers and LVDS bridges that
configure Data Enable polarity from it.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125101936.1030=
94-1-alessandro.zini@siemens.com?part=3D3
