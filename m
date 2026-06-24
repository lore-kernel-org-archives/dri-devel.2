Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EAF5CDB479
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 09:04:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEE2E10EE16;
	Wed, 24 Jun 2026 09:04:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UdsFFTp/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CAC510EE16
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 09:04:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CE41C6021C;
 Wed, 24 Jun 2026 09:04:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 423F21F000E9;
 Wed, 24 Jun 2026 09:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782291890;
 bh=ltcEPjzV94rgUWdiJZzsLfZop8HCYB8ZSPfZjlC2Fa4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UdsFFTp/DWKDvZzGBG6yqQcjqwWjAxobDbHaxgj2Rz/X1cMOfN1SvSFL/O5aaWTEi
 S15my4JwYmGURLVkICszZ3YOGXdd4X+pYBvoW2Gm9M3sh3P0ZB2Muwp2OhMnNdNvDi
 gWZY8MwPHlp66KjdaOlhSVHxjofT1ZCo6nDMW5/3Pbsd14KkwPQscwE9Bp9YqpwOgf
 3ALk+ty8Vvb1a5jnYPq3CwtxT6V9AIMmdLty37VaQq4ilqII9Nhqiamwo+Dhjot6Gl
 8AWHOoitSCo+3VMGH2QncyBUlHEXvHFp7525/TlBa/eRCA+cDnh0/lRRGCnlAJFwYE
 I2SCOwOhWTxOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] drm/panel: add Ilitek ILI7807S panel driver
To: "Arpit Saini" <arpit.saini@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260624-ili7807s-v3-2-ddf37052a289@oss.qualcomm.com>
References: <20260624-ili7807s-v3-0-ddf37052a289@oss.qualcomm.com>
 <20260624-ili7807s-v3-2-ddf37052a289@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 09:04:49 +0000
Message-Id: <20260624090450.423F21F000E9@smtp.kernel.org>
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
- [High] Incorrect and non-atomic modification of `dsi->mode_flags` permane=
ntly enables Low Power Mode and introduces a data race.
- [High] Backlight `update_status` sends DSI commands without verifying tha=
t the panel is powered on, risking DSI host timeouts.
--

commit 2f966f15c21adb82ce5699cdffad22cac6628b98
Author: Arpit Saini <arpit.saini@oss.qualcomm.com>

drm/panel: add Ilitek ILI7807S panel driver
   =20
Add a DRM panel driver for the DLC DLC0697 1080x1920@60Hz MIPI DSI
panel based on the Ilitek ILI7807S display controller.

> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili7807s.c b/drivers/gpu/=
drm/panel/panel-ilitek-ili7807s.c
> new file mode 100644
> index 0000000000000..8ddfab2693ec8
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili7807s.c

[ ... ]

> +static int ili7807s_bl_update_status(struct backlight_device *bl)
> +{
> +	struct mipi_dsi_device *dsi =3D bl_get_data(bl);
> +	u16 brightness =3D backlight_get_brightness(bl);
> +	int ret;
> +

[Severity: High]
Does this code send DSI commands without verifying if the panel is powered =
on?

If the panel regulators are disabled and reset is asserted via
ili7807s_unprepare(), attempting to communicate with it here during a sysfs
backlight update could result in DSI host bus timeouts or hardware lockups.

Should there be a check against a power state tracking flag before
sending the DCS command?

> +	dsi->mode_flags &=3D ~MIPI_DSI_MODE_LPM;
> +
> +	ret =3D mipi_dsi_dcs_set_display_brightness_large(dsi, brightness);
> +
> +	dsi->mode_flags |=3D MIPI_DSI_MODE_LPM;

[Severity: High]
Does unconditionally setting MIPI_DSI_MODE_LPM here permanently alter the
panel's base operating state?

Since the mode_flags are modified without synchronization with DRM modeset
paths (like ili7807s_on() and ili7807s_off()), could this create a data
race?

Also, the logic clears the flag before the transaction and unconditionally
sets it afterwards, leaving Low Power Mode permanently enabled for
subsequent DSI transmissions.

> +
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624-ili7807s-v=
3-0-ddf37052a289@oss.qualcomm.com?part=3D2
