Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5806C531F9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 07:37:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3DE910F314;
	Fri, 24 Jul 2026 07:37:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="DnG9dbqI";
	dkim-atps=neutral
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAAE710F313
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 07:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=usmnOREhVpp5UGqsgZqVu1SHhZoxM8bbKfW0aG7kuQ8=; b=DnG9dbqI3bQmjKK8AaX7nsQebi
 A6x30SWeQ1BONjyGd0tlJkOWcOVP6pA6p0iCjVkp5Jxouu+CSLSap9vQey5Fzzfg2TtyMcsrZPNKT
 2RqjiGgSHw2PqHcimSyYSv5IfnttBl1b0cLRAdBTmg2E+YVMoUGQkd9GIH3SZiErFPLRzicH3gC5R
 RsIx8qRhQ1Q9YaLEgQdxmiiLWoxowfgv1ZMwjaG6jOUAO0t4/Kno0NfgmDp+cQsf36RBQXRINCk8E
 868Z1tiS393ysUP6fAOPnO+QUPli2OabsTCECxkxAeXnf5LlOrUuTpd4Hsjw66RNfV6r1lisZSlkQ
 NeLiuaYA==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1wnASt-000Nx6-2V; Fri, 24 Jul 2026 09:37:03 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy04.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1wnASs-000EuX-3C; Fri, 24 Jul 2026 09:37:03 +0200
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: festevam@gmail.com, dri-devel@lists.freedesktop.org
Cc: m.felsch@pengutronix.de, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Liu Ying <victor.liu@nxp.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH v13] drm/bridge: imx: Add i.MX93 parallel display format
 configuration support
Date: Fri, 24 Jul 2026 09:37:01 +0200
Message-ID: <3722274.mvXUDI8C0e@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20260723-v6-18-topic-imx93-parallel-display-v13-1-ccf3f9bbc0fc@nxp.com>
References: <20260723-v6-18-topic-imx93-parallel-display-v13-1-ccf3f9bbc0fc@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Virus-Scanned: Clear (ClamAV 1.4.3/28069/Thu Jul 23 08:24:48 2026)
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Am Donnerstag, 23. Juli 2026, 08:37:32 CEST schrieb Liu Ying:
> NXP i.MX93 mediamix blk-ctrl contains one DISPLAY_MUX register which
> configures parallel display format by using the "PARALLEL_DISP_FORMAT"
> field. Add a DRM bridge driver to support the display format configuratio=
n.
>=20
> [m.felsch@pengutronix.de: port to v7.0-rc1]
> [m.felsch@pengutronix.de: add review feedback (Alexander)]
> [m.felsch@pengutronix.de: fix to short Kconfig description (checkpath)]
> [m.felsch@pengutronix.de: use "GPL" instead of "GPL v2" (checkpatch)]
> [m.felsch@pengutronix.de: add bus-width support]
> [ Liu Ying: Port to drm-misc/drm-misc-next(v7.2-rc2 based) ]
> [ Liu Ying: Add nxp,imx91-pdfc compatible string ]
> [ Liu Ying: Call drm_bridge_get() for next_bridge ]
> [ Liu Ying: Reject unsupported output bus fmt in .atomic_get_input_bus_fm=
ts() ]
>=20
> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> Signed-off-by: Liu Ying <victor.liu@nxp.com>

Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>

> ---
> Hi,
>=20
> I'm taking Marco Felsch's v11 work over and trying to add the imx93-pdfc.c
> driver.
>=20
> DT binding patch and DT patch in v11 have already landed, so only need
> to send the driver patch out for review.
> ---
> Changes in v13:
> - Reject unsupported output bus fmt in .atomic_get_input_bus_fmts()  (Sas=
hiko bot)
> - Tweak commit message about change log
> - Link to v12: https://patch.msgid.link/20260722-v6-18-topic-imx93-parall=
el-display-v12-1-a59dbb4dbc13@nxp.com
>=20
> Changes in v12:
> - Link to v11: https://lore.kernel.org/r/20260303-v6-18-topic-imx93-paral=
lel-display-v11-0-1b03733c8461@pengutronix.de
> - Rebase onto latest drm-misc/drm-misc-next
> - Drop DT binding patch and DT patch because they have landed
> - Add nxp,imx91-pdfc compatible string
> - Call drm_bridge_get() for next_bridge
> - Cc Marco
>=20
> Changes in v11:
> - Link to v10: https://lore.kernel.org/r/20260302-v6-18-topic-imx93-paral=
lel-display-v10-0-634fe2778c7a@pengutronix.de
> - Fix double space (Liu)
> - Drop 'const' (Liu)
> - Drop GFP_KERNEL from kmalloc_obj() (Liu)
> - Add r-b (Luca)
>=20
> Changes in v10:
> - Link to v9: https://lore.kernel.org/r/20260115-v6-18-topic-imx93-parall=
el-display-v9-0-2c5051e4b144@pengutronix.de
> - Add MEDIA_BUS_FMT_FIXED (Liu)
> - Drop next_bridge from driver struct and use bridge.next_bridge (Liu)
> - Drop linux/of_address.h include (Liu)
> - imx93-pdfc: drop bridge.driver_private usage++ (Liu)
> - Make use of kmalloc_obj() (Liu)
>=20
> Changes in v9:
> - Link to v8: https://lore.kernel.org/r/20260113-v6-18-topic-imx93-parall=
el-display-v8-0-4abccdc473a5@pengutronix.de
> - dt-bindings: drop unncessary changes (Frank)
> - imx93-pdfc: drop bridge.driver_private usage (Luca)
> - Kconfig: Adapt Kconfig symbol and prompt (Luca)
>=20
> Changes in v8:
> - Link to v7: https://lore.kernel.org/r/20251202-v6-18-topic-imx93-parall=
el-display-v7-0-2cce31d64608@pengutronix.de
> - dt-bindings: add nxp,imx91-pdfc compatible (Liu)
> - dt-bindings: use video-interfaces.yaml# (Liu)
> - dt-bindings: s/data lanes/data lines/ (Liu)
> - dt-bindings: drop 'reg' poperty
> - dt-bindings: drop #address-cells, #size-cells
> - imx93-pdfc: drop drm/drm_print.h include (Liu)
> - imx93-pdfc: s/exist/exists/ (Liu)
> - imx93-pdfc: drop MEDIA_BUS_FMT_FIXED from imx93_pdfc_bus_output_fmts
> - imx93-pdfc: imx93_pdfc_bus_output_fmt_supported: make fmt const
> - imx93-pdfc: Rework input-fmt selection to always fallback to a sane
>               default.
> - imx93-pdfc: imx93_pdfc_bridge_atomic_check: make use of
> 	      imx93_pdfc_bus_output_fmt_supported()
> - imx93-pdfc: drop 'reg' dt-property usage
> - imx93-pdfc: imx93_pdfc_bridge_probe: pass -1 for endpoint reg value (Li=
u)
>=20
> Changes in v7:
> - Link to v6: https://lore.kernel.org/r/20251201-v6-18-topic-imx93-parall=
el-display-v6-0-7b056e1e5b1e@pengutronix.de
> - Add missing bits.h and bitfield.h headers (lkp)
>=20
> Changes in v6:
> - Link to v5: https://lore.kernel.org/all/20250304082434.834031-1-victor.=
liu@nxp.com/
> - Add bus-width support
> - rebase onto v6.18-rc1
> - add review feedback (Alexander)
> - driver license "GPL v2" -> "GPL" (checkpatch)
> - make use of reg of-property
> - fix to short Kconfig description (checkpath)
> - add OF integration
>=20
> To: Liu Ying <victor.liu@nxp.com>
> To: Andrzej Hajda <andrzej.hajda@intel.com>
> To: Neil Armstrong <neil.armstrong@linaro.org>
> To: Robert Foss <rfoss@kernel.org>
> To: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> To: Jonas Karlman <jonas@kwiboo.se>
> To: Jernej Skrabec <jernej.skrabec@gmail.com>
> To: Luca Ceresoli <luca.ceresoli@bootlin.com>
> To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> To: Maxime Ripard <mripard@kernel.org>
> To: Thomas Zimmermann <tzimmermann@suse.de>
> To: David Airlie <airlied@gmail.com>
> To: Simona Vetter <simona@ffwll.ch>
> To: Frank Li <Frank.Li@nxp.com>
> To: Sascha Hauer <s.hauer@pengutronix.de>
> To: Pengutronix Kernel Team <kernel@pengutronix.de>
> To: Fabio Estevam <festevam@gmail.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: imx@lists.linux.dev
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  drivers/gpu/drm/bridge/imx/Kconfig      |  11 ++
>  drivers/gpu/drm/bridge/imx/Makefile     |   1 +
>  drivers/gpu/drm/bridge/imx/imx93-pdfc.c | 222 ++++++++++++++++++++++++++=
++++++
>  3 files changed, 234 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/bridge/imx/Kconfig b/drivers/gpu/drm/bridge/=
imx/Kconfig
> index 005a745e5c47..49fcecfee38e 100644
> --- a/drivers/gpu/drm/bridge/imx/Kconfig
> +++ b/drivers/gpu/drm/bridge/imx/Kconfig
> @@ -107,4 +107,15 @@ config DRM_IMX93_MIPI_DSI
>  	  Choose this to enable MIPI DSI controller found in Freescale i.MX93
>  	  processor.
> =20
> +config DRM_IMX93_PARALLEL_DISP_FMT_CONVERTER
> +	tristate "NXP i.MX91/i.MX93 parallel display format converter"
> +	depends on OF
> +	select DRM_KMS_HELPER
> +	help
> +	  On i.MX93 and i.MX91 SoCs the parallel display format output is
> +	  controlled via the MEDIAMIX BLK-CTRL DISPLAY_MUX.
> +
> +	  Say 'Y' or 'M' if you use the parallel display output path on a
> +	  i.MX93 or i.MX91 SoC.
> +
>  endif # ARCH_MXC || COMPILE_TEST
> diff --git a/drivers/gpu/drm/bridge/imx/Makefile b/drivers/gpu/drm/bridge=
/imx/Makefile
> index 94ac8c40ebe9..99f28cd013ae 100644
> --- a/drivers/gpu/drm/bridge/imx/Makefile
> +++ b/drivers/gpu/drm/bridge/imx/Makefile
> @@ -10,3 +10,4 @@ obj-$(CONFIG_DRM_IMX8QXP_PIXEL_COMBINER) +=3D imx8qxp-p=
ixel-combiner.o
>  obj-$(CONFIG_DRM_IMX8QXP_PIXEL_LINK) +=3D imx8qxp-pixel-link.o
>  obj-$(CONFIG_DRM_IMX8QXP_PIXEL_LINK_TO_DPI) +=3D imx8qxp-pxl2dpi.o
>  obj-$(CONFIG_DRM_IMX93_MIPI_DSI) +=3D imx93-mipi-dsi.o
> +obj-$(CONFIG_DRM_IMX93_PARALLEL_DISP_FMT_CONVERTER) +=3D imx93-pdfc.o
> diff --git a/drivers/gpu/drm/bridge/imx/imx93-pdfc.c b/drivers/gpu/drm/br=
idge/imx/imx93-pdfc.c
> new file mode 100644
> index 000000000000..2d6ca95ed554
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/imx/imx93-pdfc.c
> @@ -0,0 +1,222 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/*
> + * Copyright 2022-2025 NXP
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/media-bus-format.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_graph.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include <drm/drm_atomic_state_helper.h>
> +#include <drm/drm_bridge.h>
> +
> +#define IMX93_DISPLAY_MUX_REG		0x60
> +#define PARALLEL_DISP_FORMAT		GENMASK(10, 8)
> +#define FORMAT_RGB888_TO_RGB888		FIELD_PREP(PARALLEL_DISP_FORMAT, 0)
> +#define FORMAT_RGB888_TO_RGB666		FIELD_PREP(PARALLEL_DISP_FORMAT, 1)
> +#define FORMAT_RGB565_TO_RGB565		FIELD_PREP(PARALLEL_DISP_FORMAT, 2)
> +
> +struct imx93_pdfc {
> +	struct drm_bridge bridge;
> +	struct device *dev;
> +	struct regmap *regmap;
> +	u32 phy_bus_width;
> +};
> +
> +static struct imx93_pdfc *bridge_to_imx93_pdfc(struct drm_bridge *bridge)
> +{
> +	return container_of(bridge, struct imx93_pdfc, bridge);
> +}
> +
> +static int
> +imx93_pdfc_bridge_attach(struct drm_bridge *bridge, struct drm_encoder *=
encoder,
> +			 enum drm_bridge_attach_flags flags)
> +{
> +	return drm_bridge_attach(bridge->encoder, bridge->next_bridge, bridge, =
flags);
> +}
> +
> +static void imx93_pdfc_bridge_atomic_enable(struct drm_bridge *bridge,
> +					    struct drm_atomic_commit *state)
> +{
> +	struct imx93_pdfc *pdfc =3D bridge_to_imx93_pdfc(bridge);
> +	const struct drm_bridge_state *bridge_state;
> +	unsigned int mask =3D PARALLEL_DISP_FORMAT;
> +	unsigned int val;
> +
> +	bridge_state =3D drm_atomic_get_new_bridge_state(state, bridge);
> +
> +	switch (bridge_state->output_bus_cfg.format) {
> +	case MEDIA_BUS_FMT_RGB888_1X24:
> +	case MEDIA_BUS_FMT_FIXED:
> +		val =3D FORMAT_RGB888_TO_RGB888;
> +		if (pdfc->phy_bus_width =3D=3D 18) {
> +			/*
> +			 * Can be valid if physical bus limitation exists,
> +			 * therefore use dev_dbg().
> +			 */
> +			dev_dbg(pdfc->dev, "Truncate two LSBs from each color\n");
> +			val =3D FORMAT_RGB888_TO_RGB666;
> +		}
> +		break;
> +	case MEDIA_BUS_FMT_RGB666_1X18:
> +		val =3D FORMAT_RGB888_TO_RGB666;
> +		break;
> +	case MEDIA_BUS_FMT_RGB565_1X16:
> +		val =3D FORMAT_RGB565_TO_RGB565;
> +		break;
> +	}
> +
> +	regmap_update_bits(pdfc->regmap, IMX93_DISPLAY_MUX_REG, mask, val);
> +}
> +
> +/* TODO: Add YUV formats */
> +static const u32 imx93_pdfc_bus_output_fmts[] =3D {
> +	MEDIA_BUS_FMT_FIXED,
> +	MEDIA_BUS_FMT_RGB888_1X24,
> +	MEDIA_BUS_FMT_RGB666_1X18,
> +	MEDIA_BUS_FMT_RGB565_1X16,
> +};
> +
> +static bool imx93_pdfc_bus_output_fmt_supported(u32 fmt)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(imx93_pdfc_bus_output_fmts); i++) {
> +		if (imx93_pdfc_bus_output_fmts[i] =3D=3D fmt)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static u32 *
> +imx93_pdfc_bridge_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
> +					    struct drm_bridge_state *bridge_state,
> +					    struct drm_crtc_state *crtc_state,
> +					    struct drm_connector_state *conn_state,
> +					    u32 output_fmt,
> +					    unsigned int *num_input_fmts)
> +{
> +	u32 *input_fmts;
> +
> +	*num_input_fmts =3D 0;
> +
> +	if (!imx93_pdfc_bus_output_fmt_supported(output_fmt))
> +		return NULL;
> +
> +	input_fmts =3D kmalloc_obj(*input_fmts);
> +	if (!input_fmts)
> +		return NULL;
> +
> +	*num_input_fmts =3D 1;
> +
> +	switch (output_fmt) {
> +	case MEDIA_BUS_FMT_RGB888_1X24:
> +	case MEDIA_BUS_FMT_RGB565_1X16:
> +		input_fmts[0] =3D output_fmt;
> +		break;
> +	case MEDIA_BUS_FMT_RGB666_1X18:
> +	case MEDIA_BUS_FMT_FIXED:
> +		input_fmts[0] =3D MEDIA_BUS_FMT_RGB888_1X24;
> +		break;
> +	}
> +
> +	return input_fmts;
> +}
> +
> +static int imx93_pdfc_bridge_atomic_check(struct drm_bridge *bridge,
> +					  struct drm_bridge_state *bridge_state,
> +					  struct drm_crtc_state *crtc_state,
> +					  struct drm_connector_state *conn_state)
> +{
> +	struct imx93_pdfc *pdfc =3D bridge_to_imx93_pdfc(bridge);
> +	u32 format =3D bridge_state->output_bus_cfg.format;
> +
> +	if (imx93_pdfc_bus_output_fmt_supported(format))
> +		return 0;
> +
> +	dev_warn(pdfc->dev, "Unsupported output bus format: 0x%x\n", format);
> +
> +	return -EINVAL;
> +}
> +
> +static const struct drm_bridge_funcs funcs =3D {
> +	.attach			=3D imx93_pdfc_bridge_attach,
> +	.atomic_enable		=3D imx93_pdfc_bridge_atomic_enable,
> +	.atomic_duplicate_state	=3D drm_atomic_helper_bridge_duplicate_state,
> +	.atomic_destroy_state	=3D drm_atomic_helper_bridge_destroy_state,
> +	.atomic_get_input_bus_fmts	=3D imx93_pdfc_bridge_atomic_get_input_bus_f=
mts,
> +	.atomic_check		=3D imx93_pdfc_bridge_atomic_check,
> +	.atomic_create_state	=3D drm_atomic_helper_bridge_create_state,
> +};
> +
> +static int imx93_pdfc_bridge_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct drm_bridge *next_bridge;
> +	struct imx93_pdfc *pdfc;
> +	struct device_node *ep;
> +	int err;
> +
> +	pdfc =3D devm_drm_bridge_alloc(dev, struct imx93_pdfc, bridge, &funcs);
> +	if (IS_ERR(pdfc))
> +		return PTR_ERR(pdfc);
> +
> +	pdfc->regmap =3D syscon_node_to_regmap(dev->of_node->parent);
> +	if (IS_ERR(pdfc->regmap))
> +		return dev_err_probe(dev, PTR_ERR(pdfc->regmap),
> +				     "failed to get regmap\n");
> +
> +	/* No limits per default */
> +	pdfc->phy_bus_width =3D 24;
> +
> +	/* Get output ep (port1/endpoint) */
> +	ep =3D of_graph_get_endpoint_by_regs(dev->of_node, 1, -1);
> +	if (ep) {
> +		err =3D of_property_read_u32(ep, "bus-width", &pdfc->phy_bus_width);
> +		of_node_put(ep);
> +
> +		/* bus-width is optional but it must have valid data if present */
> +		if (err && err !=3D -EINVAL)
> +			return dev_err_probe(dev, err,
> +					     "failed to query bus-width\n");
> +	}
> +
> +	next_bridge =3D devm_drm_of_get_bridge(dev, dev->of_node, 1, 0);
> +	if (IS_ERR(next_bridge))
> +		return dev_err_probe(dev, PTR_ERR(next_bridge),
> +				     "failed to get next bridge\n");
> +	pdfc->dev =3D dev;
> +	pdfc->bridge.of_node =3D dev->of_node;
> +	pdfc->bridge.type =3D DRM_MODE_CONNECTOR_DPI;
> +	pdfc->bridge.next_bridge =3D drm_bridge_get(next_bridge);
> +
> +	return devm_drm_bridge_add(dev, &pdfc->bridge);
> +}
> +
> +static const struct of_device_id imx93_pdfc_dt_ids[] =3D {
> +	{ .compatible =3D "nxp,imx91-pdfc", },
> +	{ .compatible =3D "nxp,imx93-pdfc", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, imx93_pdfc_dt_ids);
> +
> +static struct platform_driver imx93_pdfc_bridge_driver =3D {
> +	.probe	=3D imx93_pdfc_bridge_probe,
> +	.driver	=3D {
> +		.of_match_table =3D imx93_pdfc_dt_ids,
> +		.name =3D "imx93_pdfc",
> +	},
> +};
> +module_platform_driver(imx93_pdfc_bridge_driver);
> +
> +MODULE_DESCRIPTION("NXP i.MX93 parallel display format configuration dri=
ver");
> +MODULE_AUTHOR("Liu Ying <victor.liu@nxp.com>");
> +MODULE_LICENSE("GPL");
>=20
> ---
> base-commit: 9499d3bc41a2c4e6a1badfb55f943b9d0c34f034
> change-id: 20251201-v6-18-topic-imx93-parallel-display-95f9234bf6cc
>=20
> Best regards,
> -- =20
> Regards,
> Liu Ying
>=20
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


