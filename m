Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 239F5CD98F2
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 10:32:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C8E410EDC8;
	Thu, 18 Jun 2026 10:32:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OGITPyEh";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 296AF10EDC8
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 10:32:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 53CF2601FE;
 Thu, 18 Jun 2026 10:32:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C82581F000E9;
 Thu, 18 Jun 2026 10:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781778747;
 bh=W6rEgeEeqygUkmFeq2ogoXjlREWW/dmk0kBslBFvzwo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OGITPyEhqNbuKau+J7QXnvr3U/OdTvv3VjgT1NONzmxhGhuHRxjLAi0yQJPK3Pcdj
 JwNjpUZfuP6rjEcrcTo11Qa4/Ip5iZ24hF1P+yoVsqBnET9Bp7psBoucPb87foxBxq
 qp9+AHyapZl1BtNc04Pu/720GiYfufv75UN9NzIZTWyjvne62NJSNi1k3s0j6gpjOr
 bw/KmjdkIM2OccibwkhCWP8Gig1UcbP7IG45Xe05jMpRUS4Y6DNgIdQ7D6plIw1z3y
 vvDNap82vKeMT0X8sSyzFMMjw0JEcxDcbR9x4gm8ZwkC6N4wllgdeUVdEcjXdiyx/V
 SkSUGO4/MLnBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] drm/panel: add Ilitek ILI7807S panel driver
To: "Arpit Saini" <arpit.saini@oss.qualcomm.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org
In-Reply-To: <20260618-ili7807s-v2-2-b3f0c109b102@oss.qualcomm.com>
References: <20260618-ili7807s-v2-0-b3f0c109b102@oss.qualcomm.com>
 <20260618-ili7807s-v2-2-b3f0c109b102@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 10:32:26 +0000
Message-Id: <20260618103226.C82581F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Inverted manipulation of MIPI_DSI_MODE_LPM in backlight update_sta=
tus callback permanently corrupts DSI mode flags.
- [High] Concurrent read-modify-write operations on dsi->mode_flags can cau=
se state corruption.
- [Medium] Backlight update_status callback sends DCS commands without chec=
king if the panel is powered on.
- [Medium] Incorrect devm registration order causes the DSI device to be de=
tached while the DRM panel and backlight sysfs are still active.
- [Medium] Missing NULL check for the return value of of_device_get_match_d=
ata() leads to a potential NULL pointer dereference.
--

commit 97a4deef0ca55e71f3420d40260130de4242cae3
Author: Arpit Saini <arpit.saini@oss.qualcomm.com>

drm/panel: add Ilitek ILI7807S panel driver

This commit adds a DRM panel driver for the DLC DLC0697 1080x1920@60Hz
MIPI DSI panel based on the Ilitek ILI7807S display controller.

> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili7807s.c b/drivers/gpu/=
drm/panel/panel-ilitek-ili7807s.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili7807s.c

[ ... ]

> +static int ili7807s_bl_update_status(struct backlight_device *bl)
> +{
> +	struct mipi_dsi_device *dsi =3D bl_get_data(bl);
> +	u16 brightness =3D backlight_get_brightness(bl);
> +	int ret;
> +

[Severity: Medium]
Is it safe to send DCS commands here without checking if the panel is
currently powered on? If userspace writes to the sysfs brightness control
while the regulators are disabled and the panel is off, will this attempt
to send commands and cause DSI bus timeouts?

> +	dsi->mode_flags &=3D ~MIPI_DSI_MODE_LPM;
> +
> +	ret =3D mipi_dsi_dcs_set_display_brightness_large(dsi, brightness);
> +
> +	dsi->mode_flags |=3D MIPI_DSI_MODE_LPM;

[Severity: High]
Does this sequence invert the intended mode flags? The default panel mode
flags do not include MIPI_DSI_MODE_LPM. Clearing it beforehand and setting =
it
afterward will permanently force the DSI host into Low Power Mode after the
first backlight update, which might break subsequent video transmissions.

[Severity: High]
Can concurrent calls to ili7807s_on(), ili7807s_off(), and this backlight
update callback cause a data race? These functions all modify dsi->mode_fla=
gs
using non-atomic bitwise operations, which might clobber each other's chang=
es
if a backlight update is triggered from userspace simultaneously with a DRM
DPMS event.

[ ... ]

> +static int ili7807s_probe(struct mipi_dsi_device *dsi)
> +{
> +	struct device *dev =3D &dsi->dev;
> +	const struct panel_desc *desc;
> +	struct ili7807s *ctx;
> +	int ret;
> +
> +	ctx =3D devm_drm_panel_alloc(dev, struct ili7807s, panel,
> +				   &ili7807s_panel_funcs,
> +				   DRM_MODE_CONNECTOR_DSI);
> +	if (IS_ERR(ctx))
> +		return PTR_ERR(ctx);
> +
> +	desc =3D of_device_get_match_data(dev);
> +	ctx->desc =3D desc;

[Severity: Medium]
Can of_device_get_match_data() return NULL if the driver is bound manually
via sysfs without an associated device tree node? If so, will dereferencing
desc->lanes later in this function cause a NULL pointer dereference?

[ ... ]

> +	ret =3D devm_drm_panel_add(dev, &ctx->panel);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to add panel\n");
> +
> +	ret =3D devm_mipi_dsi_attach(dev, dsi);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to attach dsi\n");
> +
> +	return 0;
> +}

[Severity: Medium]
Does this devres registration order cause a teardown issue? Since devres
cleans up in reverse order of allocation, devm_mipi_dsi_detach() will run
before the DRM panel and backlight interfaces are removed. Could this leave
the sysfs interfaces exposed to userspace while the underlying DSI device is
already detached?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-ili7807s-v=
2-0-b3f0c109b102@oss.qualcomm.com?part=3D2
