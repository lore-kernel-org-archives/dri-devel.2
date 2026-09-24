Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEFA8C9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 14:12:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58D7010E0F4;
	Thu, 24 Sep 2026 14:12:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mKcLY+lV";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B4E910E0F4
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 14:12:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E90514392E;
 Thu, 24 Sep 2026 14:12:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D87A1F00893;
 Thu, 24 Sep 2026 14:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790259139;
 bh=0eseanD6N+BnVnRgpD8hYQ/vqwEYDeqLmeOpSXWUII4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mKcLY+lVZaE/CrZOKfP9MBSWBTKjyJ+iYnHZNVP/sCdqKSum+ajlP/QsWUD41SiRM
 AED+efXWExs4gQ/JN4ikMqZkrH7uGkKDegCEOgbRSoO+tIOCDwN3C2wndbzqBmS1Oq
 YfDNlVh7wCDgZdm05em69///TRiApmvnjMecmPvLLxjMu7TaSzReJblqHdovVu3mf/
 5037OTT8BhXlFWKXi/8BcN2mixWSq2idC7YyCmXNuAVkcJf7f+Zl9M6iCY19aCnww5
 fGt2N+9Fkgi85UhFjUdAuBDlRthy6KKcIXfgCCZd4jN9IoLTqLv4iTDZj2yye9Lvk+
 9+U3mg7us1Cvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/11] drm/panel: s6e3ha8: add Samsung AMB630QY01
 (Google Pixel 3 XL) panel
To: "David Heidelberg" <david@ixit.cz>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260924-crosshatch-panel-v2-8-08d5c7bf72fc@ixit.cz>
References: <20260924-crosshatch-panel-v2-0-08d5c7bf72fc@ixit.cz>
 <20260924-crosshatch-panel-v2-8-08d5c7bf72fc@ixit.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 14:12:19 +0000
Message-Id: <20260924141219.7D87A1F00893@smtp.kernel.org>
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
- [High] drm/panel: s6e3ha8: unconditional DCS command in backlight update =
causes DSI host wedge
--

commit cc2d04d32c8c8a9c163b61b933026b6a253b1aca
Author: David Heidelberg <david@ixit.cz>

drm/panel: s6e3ha8: add Samsung AMB630QY01 (Google Pixel 3 XL) panel

The Google Pixel 3 XL (crosshatch) uses a Samsung AMB630QY01 6.3" 1440x2960
flexible AMOLED panel, driven by the same S6E3HA8 DDIC as the Galaxy S9 pan=
el
this driver already supports. This commit adds the initialization sequences=
 and
timings, along with a backlight device since brightness is controlled via
standard DCS commands.

> diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c b/drivers/gpu/=
drm/panel/panel-samsung-s6e3ha8.c
> index 2591b8c1a7753..e02f1d9f0dcd0 100644
> --- a/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
> +++ b/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c

[ ... ]

> @@ -271,6 +294,136 @@ static const struct s6e3ha8_desc s6e3ha8_amb577px01=
_wqhd_desc =3D {

[ ... ]

> +static int s6e3ha8_bl_update_status(struct backlight_device *bl)
> +{
> +	struct mipi_dsi_device *dsi =3D bl_get_data(bl);
> +	u16 brightness =3D backlight_get_brightness(bl);
> +
> +	return mipi_dsi_dcs_set_display_brightness_large(dsi, brightness);

[Severity: High]
Could this transmission wedge the display pipeline? In
drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c within
s6e3ha8_bl_update_status(), this DSI transmission is executed unconditional=
ly
without verifying if the panel's regulators and DSI link are active (e.g.
lacking a prepared state check).

Writing to the sysfs brightness attribute while the display is suspended or
disabled causes the driver to send DCS commands over the DSI bus when the D=
SI
host clocks and PHY may be gated or panel regulators disabled.

On many platforms (including the target Qualcomm sdm845), unclocked accesses
or DSI timeouts can result in a system crash (NOC error) or permanently wed=
ge
the display pipeline.

> +}

[ ... ]

> @@ -313,6 +466,13 @@ static int s6e3ha8_probe(struct mipi_dsi_device *dsi)
> =20
>  	priv->panel.prepare_prev_first =3D true;
> =20
> +	if (priv->desc->has_backlight) {
> +		priv->panel.backlight =3D s6e3ha8_create_backlight(dsi);

[Severity: High]
Does this code create a race condition for early or late backlight updates?
In drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c, this exposes the backlight
interface to userspace in s6e3ha8_probe(), creating the window for the race
condition where sysfs writes can trigger before the panel is prepared or af=
ter
it is unprepared.

A user-space process or udev rule could write to the sysfs brightness
attribute after the panel has been disabled via drm_panel_unprepare/disable.
The sysfs interface is typically accessible to unprivileged users, making t=
his
easily reachable from user-space.

> +		if (IS_ERR(priv->panel.backlight))
> +			return dev_err_probe(dev, PTR_ERR(priv->panel.backlight),
> +					     "Failed to create backlight\n");
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924-crosshatch=
-panel-v2-0-08d5c7bf72fc@ixit.cz?part=3D8
