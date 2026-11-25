Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96896606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 02:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l+KZxeD5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0450410F9A2;
	Wed, 25 Nov 2026 02:26:16 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1722810F9A2
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 02:26:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D44C843CA7;
 Wed, 25 Nov 2026 02:26:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD7D31F000CF;
 Wed, 25 Nov 2026 02:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795573569;
 bh=YuBvNmRkTNzt2xiFLt4XMErMr+q2sxN4QP4D8r/892I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=l+KZxeD5cNd3GQaU1GRqRu19/7vMnN/SNV5iQsx8SDfY13bvLB0Tm+IuuPT3ACeBf
 3BzgmVBBjKtcwp7h+1yXojDb9ATN6NOa8MNmxC5DKOKLjAJW6QgtRRhYtnrI4OIz9f
 i/t0ivGm7X9wZ70hxip16A6DiSIsXATZ32NMbjoLU7fTdG09cEasdVyOXoHkr/286X
 pWkZSQoMWLW6i0DjuR/kbtCi4sX5XQFPHkkOQ2yEO6F9CujB+tOAFk/ebF4qtYFNql
 VBnqJkB01LQQpnw/VvBCDg37q0WeZ1IXdliqYoqnmJYJ4z5YGjyEVyBE4zco4D8Miv
 LjhoR8F7pzLZg==
Message-ID: <sashiko-outbox-232409@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/6] drm/panel: add VIEWE JD9365TX 7 inch DSI panel
To: Hefei <3066883572@qq.com>, dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <tencent_3D3EC29E27E9DF37D4C9F1A60F2F2BA3EF07@qq.com>
References: <20261125021127.1430-1-3066883572@qq.com>
 <tencent_3D3EC29E27E9DF37D4C9F1A60F2F2BA3EF07@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 02:26:08 +0000
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

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [High] drm/panel: call to removed of_drm_get_panel_orientation() in
  jd9365tx_probe()
- [High] drm/panel: call to static drm_panel_init() in jd9365tx_probe()
- [Low] drm/panel: undocumented compatible jadard,jd9365tx-7kf82 in
  jd9365tx_of_match
- [Low] drm/panel: open-coded DSI command sender and helpers in
  panel-viewe-jd9365tx
- [Low] drm/panel: non-alphabetical Kconfig and Makefile order for
  VIEWE_JD9365TX
--

commit 0ea4165795cc39804999640f1fa6be9c2c2143db
Author: Hefei <3066883572@qq.com>

drm/panel: add VIEWE JD9365TX 7 inch DSI panel

This commit adds a DRM panel driver for the VIEWE 7" 720x1280 Jadard
JD9365TX (7KF82) 2-lane MIPI-DSI panel.

> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index 26ffa2378f55c..9a3038bf60987 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -427,6 +427,17 @@ config DRM_PANEL_INNOLUX_P079ZCA
>  	  24 bit RGB per pixel. It provides a MIPI DSI interface to
>  	  the host and has a built-in LED backlight.
> =20
> +config DRM_PANEL_VIEWE_JD9365TX
> +	tristate "VIEWE 7\" JD9365TX DSI panel"
> +	depends on OF
> +	depends on DRM_MIPI_DSI
> +	depends on BACKLIGHT_CLASS_DEVICE
> +	help
> +	  Say Y here to enable the VIEWE 7" 720x1280 Jadard JD9365TX
> +	  MIPI-DSI panel.
> +
> +	  If unsure, say N.
> +
>  config DRM_PANEL_JADARD_JD9365DA_H3
>  	tristate "Jadard JD9365DA-H3 WXGA DSI panel"
>  	depends on OF
> diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makef=
ile
> index 365f2e73f6b45..84ed0891a40d1 100644
> --- a/drivers/gpu/drm/panel/Makefile
> +++ b/drivers/gpu/drm/panel/Makefile
> @@ -42,6 +42,7 @@ obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9881C) +=3D panel-ilit=
ek-ili9881c.o
>  obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9882T) +=3D panel-ilitek-ili9882t.o
>  obj-$(CONFIG_DRM_PANEL_INNOLUX_EJ030NA) +=3D panel-innolux-ej030na.o
>  obj-$(CONFIG_DRM_PANEL_INNOLUX_P079ZCA) +=3D panel-innolux-p079zca.o
> +obj-$(CONFIG_DRM_PANEL_VIEWE_JD9365TX) +=3D panel-viewe-jd9365tx.o
>  obj-$(CONFIG_DRM_PANEL_JADARD_JD9365DA_H3) +=3D panel-jadard-jd9365da-h3=
.o
>  obj-$(CONFIG_DRM_PANEL_JDI_LT070ME05000) +=3D panel-jdi-lt070me05000.o
>  obj-$(CONFIG_DRM_PANEL_JDI_LPM102A188A) +=3D panel-jdi-lpm102a188a.o

[Severity: Low]
This isn't a bug, but DRM_PANEL_VIEWE_JD9365TX is placed between the
INNOLUX and JADARD entries instead of in alphabetical order in both
Kconfig and Makefile.

> diff --git a/drivers/gpu/drm/panel/panel-viewe-jd9365tx.c b/drivers/gpu/d=
rm/panel/panel-viewe-jd9365tx.c
> new file mode 100644
> index 0000000000000..b511dd6bfed96
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-viewe-jd9365tx.c

[ ... ]

> +static int jd9365tx_send_cmds(struct mipi_dsi_device *dsi,
> +			      const struct jd9365tx_cmd *cmds,
> +			      unsigned int count)
> +{
> +	unsigned int i;
> +	int ret;
> +
> +	for (i =3D 0; i < count; i++) {
> +		const struct jd9365tx_cmd *cmd =3D &cmds[i];
> +
> +		if (cmd->len) {
> +			ret =3D mipi_dsi_dcs_write_buffer(dsi, cmd->data, cmd->len);
> +			if (ret < 0) {
> +				dev_err(&dsi->dev,
> +					"DCS write 0x%02x failed: %d\n",
> +					cmd->data[0], ret);
> +				return ret;
> +			}
> +		}
> +		if (cmd->delay_ms)
> +			msleep(cmd->delay_ms);
> +	}
> +	return 0;
> +}

[ ... ]

> +static int jd9365tx_get_modes(struct drm_panel *panel,
> +			      struct drm_connector *connector)
> +{
> +	struct jd9365tx_panel *ctx =3D to_jd9365tx(panel);
> +	struct drm_display_mode *mode;
> +
> +	mode =3D drm_mode_duplicate(connector->dev, &jd9365tx_7kf82_mode);
> +	if (!mode)
> +		return -ENOMEM;
> +
> +	drm_mode_set_name(mode);
> +	mode->type =3D DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
> +	drm_mode_probed_add(connector, mode);
> +
> +	connector->display_info.width_mm =3D mode->width_mm;
> +	connector->display_info.height_mm =3D mode->height_mm;
> +	drm_connector_set_panel_orientation(connector, ctx->orientation);
> +	return 1;
> +}

[Severity: Low]
Can this driver use the existing DRM and MIPI-DSI helpers instead of
open-coding them?

Since jd9365tx_prepare() already sets up a struct mipi_dsi_multi_context,
using mipi_dsi_dcs_write_seq_multi() and mipi_dsi_msleep() avoids the
custom struct jd9365tx_cmd table and jd9365tx_send_cmds() loop.

In jd9365tx_get_modes(), using drm_connector_helper_get_modes_fixed()
avoids returning a negative errno from .get_modes on allocation failure and
drops the redundant drm_connector_set_panel_orientation() call (which
panel_bridge_attach() already handles via .get_orientation).  Using
devm_drm_panel_add() and devm_mipi_dsi_attach() in jd9365tx_probe() would
also allow dropping jd9365tx_remove(), and a brief commit message body
describing the panel hardware would be helpful.

[ ... ]

> +static int jd9365tx_probe(struct mipi_dsi_device *dsi)
> +{
> +	struct device *dev =3D &dsi->dev;
> +	struct jd9365tx_panel *ctx;
> +	int ret;
> +
> +	ctx =3D devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	ctx->dsi =3D dsi;
> +	mipi_dsi_set_drvdata(dsi, ctx);
> +
> +	dsi->lanes =3D 2;
> +	dsi->format =3D MIPI_DSI_FMT_RGB888;
> +	dsi->mode_flags =3D MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
> +			  MIPI_DSI_MODE_LPM;
> +
> +	ctx->reset =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(ctx->reset))
> +		return PTR_ERR(ctx->reset);
> +
> +	ctx->vdd =3D devm_regulator_get(dev, "vdd");
> +	if (IS_ERR(ctx->vdd))
> +		return PTR_ERR(ctx->vdd);
> +
> +	ctx->iovcc =3D devm_regulator_get(dev, "iovcc");
> +	if (IS_ERR(ctx->iovcc))
> +		return PTR_ERR(ctx->iovcc);
> +
> +	ret =3D of_drm_get_panel_orientation(dev->of_node, &ctx->orientation);
> +	if (ret)
> +		return ret;

[Severity: High]
Does calling of_drm_get_panel_orientation() fail to compile when
CONFIG_DRM_PANEL_VIEWE_JD9365TX is enabled?

Commit b5a8b1f2a973 ("drm/panel: Use drm_of_get_panel_orientation()")
removed of_drm_get_panel_orientation() in favor of
drm_of_get_panel_orientation() declared in include/drm/drm_of.h.

> +
> +	drm_panel_init(&ctx->panel, dev, &jd9365tx_funcs, DRM_MODE_CONNECTOR_DS=
I);

[Severity: High]
Does calling drm_panel_init() here also break the build and leave
ctx->panel.bridge uninitialized?

Commit fe417df954a9 ("drm/panel: Make drm_panel_init() static") made
drm_panel_init() static to drivers/gpu/drm/drm_panel.c.  Allocating ctx
with devm_kzalloc() instead of devm_drm_panel_alloc() also skips
initializing the embedded refcounted struct drm_bridge that
drm_panel_add() registers.

[ ... ]

> +static const struct of_device_id jd9365tx_of_match[] =3D {
> +	{ .compatible =3D "viewe,7kf82" },
> +	{ .compatible =3D "jadard,jd9365tx-7kf82" },
> +	{ }
> +};

[Severity: Low]
Is "jadard,jd9365tx-7kf82" documented in the Device Tree bindings?
Documentation/devicetree/bindings/display/panel/viewe,jd9365tx.yaml only
documents "viewe,7kf82".

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_A3BF23A8B6E=
3691F0D567ADF8B84194F4408@qq.com?part=3D4
