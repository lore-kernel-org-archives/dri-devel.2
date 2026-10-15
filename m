Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 066F6CC6B30
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 00:02:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56F4210FFF1;
	Thu, 15 Oct 2026 00:02:35 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 614FB10FFF1
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 00:02:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4F0706022E;
 Thu, 15 Oct 2026 00:02:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD31D1F000C4;
 Thu, 15 Oct 2026 00:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792022547;
 bh=p1iqPX8yFUZPxFWJKBDgSmbe2Cr93gYl0ikZ73+Tn3I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AHwM0q9G07uIZ/gpxfQ3aZEOGK+LsA5fgZDu9LpCPScsfNjwuDCRJZeW/B93EuG5f
 Jgf/gpW9tXzOyPICtD6PqdHLhKyMJ31QhlpbEXEBtoT1f9mpxXO9Ifyq8hEO6XG3XF
 EQiVMEN9Aiwp2wkwNmlpLUtKa6060PwPiJWLOrNc8WJ0v44EBSFkPTxWiTb83eZA+X
 yyIaPO2tSEDycQSr5RWlnAk9EqAB6DWXJQNyIeJyuHo/Pz2xv5+twxKZYQCaNvc3n8
 6GsG/a5TWe+654834gaz1OFzwlnQgMT0pk7dv5771uKkkTRkJ5U3XGJ9ujcCw6E8B6
 Y30fuoicBMiAA==
Message-ID: <sashiko-outbox-172043@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] drm/panel: add Novatek NT36850 panel driver
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261015-sdm845-hdk-v3-2-1c179cd0d16f@oss.qualcomm.com>
References: <20261015-sdm845-hdk-v3-0-1c179cd0d16f@oss.qualcomm.com>
 <20261015-sdm845-hdk-v3-2-1c179cd0d16f@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 00:02:26 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] drm/panel: double free/UAF of secondary DSI device on host unbind
- [Low] drm/panel: NULL pointer dereference in nt36850_disable() for single=
-DSI panels
- [Low] drm/panel: Unused backlight field in struct panel_info
--

commit c61a43c5fad101fbd326985c7fa4cea8c858d4bd
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/panel: add Novatek NT36850 panel driver

Add support for the Truly WQHD dual-DSI command mode panel built around
the Novatek NT36850, found on the display card for the Qualcomm SDM845
and SM8150 HDK. The driver is based on panel-novatek-nt36523, the power
and command sequences follow the vendor device tree.

> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36850.c b/drivers/gpu/=
drm/panel/panel-novatek-nt36850.c
> new file mode 100644
> index 0000000000000..d3530e3d5754b
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt36850.c

[ ... ]

> +struct panel_info {
> +	struct drm_panel panel;
> +	struct mipi_dsi_device *dsi[2];
> +	const struct panel_desc *desc;
> +	enum drm_panel_orientation orientation;
> +
> +	struct gpio_desc *reset_gpio;
> +	struct backlight_device *backlight;

[Severity: Low]
Is this backlight pointer used anywhere else in the driver? It appears to be
declared here but never initialized or accessed since the backlight is hand=
led
entirely by the drm_panel framework via drm_panel_of_backlight().

> +	struct regulator *vddio;
> +	struct regulator *avdd;
> +	struct regulator *avee;
> +};

[ ... ]

> +static int nt36850_disable(struct drm_panel *panel)
> +{
> +	struct panel_info *pinfo =3D to_panel_info(panel);
> +	struct mipi_dsi_device *dsi0 =3D pinfo->dsi[0];
> +	struct mipi_dsi_device *dsi1 =3D pinfo->dsi[1];
> +	struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D NULL };
> +
> +	dsi0->mode_flags &=3D ~MIPI_DSI_MODE_LPM;
> +	dsi1->mode_flags &=3D ~MIPI_DSI_MODE_LPM;

[Severity: Low]
Could this cause a NULL pointer dereference if a single-DSI panel descriptor
is ever added?

The driver's probe function conditionally initializes dsi1 only when
is_dual_dsi is true, but nt36850_disable() unconditionally fetches and
dereferences it here, and then passes it to mipi_dsi_dual().

> +
> +	mipi_dsi_dual(mipi_dsi_dcs_set_display_off_multi, &dsi_ctx, dsi0, dsi1);
> +	mipi_dsi_msleep(&dsi_ctx, 120);
> +	mipi_dsi_dual(mipi_dsi_dcs_enter_sleep_mode_multi, &dsi_ctx, dsi0, dsi1=
);

[ ... ]

> +static int nt36850_probe(struct mipi_dsi_device *dsi)
> +{

[ ... ]

> +	/* If the panel is dual dsi, register DSI1 */
> +	if (pinfo->desc->is_dual_dsi) {
> +		struct mipi_dsi_device_info dsi_info =3D {
> +			.type =3D "dsi-secondary",
> +		};
> +
> +		dsi1 =3D of_graph_get_remote_node(dsi->dev.of_node, 1, -1);
> +		if (!dsi1) {
> +			dev_err(dev, "cannot get secondary DSI node.\n");
> +			return -ENODEV;
> +		}
> +
> +		dsi1_host =3D of_find_mipi_dsi_host_by_node(dsi1);
> +		of_node_put(dsi1);
> +		if (!dsi1_host)
> +			return dev_err_probe(dev, -EPROBE_DEFER, "cannot get secondary DSI ho=
st\n");
> +
> +		pinfo->dsi[1] =3D devm_mipi_dsi_device_register_full(dev, dsi1_host, &=
dsi_info);

[Severity: High]
Will this cause a double free or use-after-free during device unbind?

The devres cleanup action for the secondary DSI device is tied to the prima=
ry
DSI device (dev). However, the secondary DSI device is instantiated as a ch=
ild
of dsi1_host->dev.

If the secondary DSI host is unbound via sysfs or module removal,
mipi_dsi_host_unregister() will iterate over all its children and
unconditionally call mipi_dsi_device_unregister(), freeing the secondary
DSI device.

Later, when the primary DSI device is unbound, its devres cleanup executes
and calls mipi_dsi_device_unregister() on the already-freed pointer. Should
this lifecycle be tied directly to the secondary host's unbind instead?

> +		if (IS_ERR(pinfo->dsi[1])) {
> +			dev_err(dev, "cannot get secondary DSI device\n");
> +			return PTR_ERR(pinfo->dsi[1]);
> +		}
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-sdm845-hdk=
-v3-0-1c179cd0d16f@oss.qualcomm.com?part=3D2
