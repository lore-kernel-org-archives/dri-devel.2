Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EECAEC624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 03:41:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B5FF10F389;
	Thu,  3 Sep 2026 03:41:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XvOWonB+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E03AF10F389
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 03:41:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E8C3A600D1;
 Thu,  3 Sep 2026 03:41:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C8B31F000E9;
 Thu,  3 Sep 2026 03:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788406887;
 bh=i5G6VnmFShYHrpO/V4rqc9yWyThmWOo6lihVTDrgJ/s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XvOWonB+AU23DueAUaafvV/c1mBCiLxgcRU9x4gnMyIrhI0JEXEfWvQ0B+zNao9Ku
 G94vK0ChHy0yVwmMROpGOx/yHd2X5uq8j8ufzjlbJefp6S1hmFAAOD63giGpRiBL5n
 l9fKXdBZxpoKMvsbszTVH/QiP3k58RzmTfCBHGqTvcob/8qwO1x3XeaYUT/5Hj2S1L
 R7UjfHEOKPZ0/LOIANRNI8oheu/vW1voVaCX64LI0sBk4wcfeJp3o+0iPLJL4F1q1F
 RATi/aAK8UutfWCSq8j0S3MY93gwHXNhC88O03ikuDD3VmCFkbaGSAzoGSAnjyRy7b
 +QoNcjPh2aSow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] drm/panel: simple: Add BOE DV215FHM-R01 panel
To: "Vishnu Saini" <vishnu.saini@oss.qualcomm.com>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260903-b4-lvds-panel-doc-v4-2-861738a0d5de@oss.qualcomm.com>
References: <20260903-b4-lvds-panel-doc-v4-0-861738a0d5de@oss.qualcomm.com>
 <20260903-b4-lvds-panel-doc-v4-2-861738a0d5de@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 03:41:26 +0000
Message-Id: <20260903034127.4C8B31F000E9@smtp.kernel.org>
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
- [High] The DISPLAY_FLAGS_DE_HIGH flag in boe_dv215fhm_r01_timing is silen=
tly ignored because it is not propagated to the panel's bus_flags.
--

commit e8dda804d95e117a2144e77d29d6c181f747ad91
Author: Vishnu Saini <vishnu.saini@oss.qualcomm.com>

drm/panel: simple: Add BOE DV215FHM-R01 panel
   =20
This commit adds support for the BOE DV215FHM-R01 21.5" FHD (1920x1080)
dual-channel LVDS panel in the panel-simple driver.

> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel=
/panel-simple.c
> index c95964ba25a95..0b516385b2673 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -1593,6 +1593,31 @@ static const struct panel_desc boe_bp101wx1_100 =
=3D {
>  	.connector_type =3D DRM_MODE_CONNECTOR_LVDS,
>  };
> =20
> +static const struct display_timing boe_dv215fhm_r01_timing =3D {
> +	.pixelclock =3D { 148500000, 148500000, 148500000 },
> +	.hactive =3D { 1920, 1920, 1920 },
> +	.hfront_porch =3D { 88, 88, 88 },
> +	.hback_porch =3D { 148, 148, 148 },
> +	.hsync_len =3D { 44, 44, 44 },
> +	.vactive =3D { 1080, 1080, 1080 },
> +	.vfront_porch =3D { 4, 4, 4 },
> +	.vback_porch =3D { 36, 36, 36 },
> +	.vsync_len =3D { 5, 5, 5 },
> +	.flags =3D DISPLAY_FLAGS_DE_HIGH,
> +};
> +
> +static const struct panel_desc boe_dv215fhm_r01 =3D {
> +	.timings =3D &boe_dv215fhm_r01_timing,
> +	.num_timings =3D 1,
> +	.bpc =3D 8,
> +	.size =3D {
> +		.width =3D 476,
> +		.height =3D 268,
> +	},
> +	.bus_format =3D MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
> +	.connector_type =3D DRM_MODE_CONNECTOR_LVDS,
> +};

[Severity: High]
Does this panel descriptor need to set .bus_flags =3D DRM_BUS_FLAG_DE_HIGH?

The display_timing structure for boe_dv215fhm_r01_timing specifies
DISPLAY_FLAGS_DE_HIGH, but this flag appears to be silently ignored by the
panel-simple framework unless it is also propagated to the panel's bus_flag=
s.

When the boe_dv215fhm_r01 panel is probed and its modes are added via
panel_simple_get_non_edid_modes(), the connector assigns:

    connector->display_info.bus_flags =3D panel->desc->bus_flags;

Since .bus_flags is missing from the descriptor initialization here, it
defaults to 0. This causes the Data Enable (DE) polarity requirement to be
lost. If the controller defaults to DE low, the display might not function
correctly.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903-b4-lvds-pa=
nel-doc-v4-0-861738a0d5de@oss.qualcomm.com?part=3D2
