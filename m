Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3855C531CB
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 09:41:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B9EC10E55D;
	Thu, 23 Jul 2026 09:41:48 +0000 (UTC)
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de
 [185.203.200.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CACA010E55D
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 09:41:46 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de
 (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
 (Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
 by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id EE906201FBB;
 Thu, 23 Jul 2026 11:41:44 +0200 (CEST)
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
 by drehscheibe.grey.stw.pengutronix.de with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <mfe@pengutronix.de>) id 1wmpw0-000sSL-2r;
 Thu, 23 Jul 2026 11:41:44 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
 (envelope-from <mfe@pengutronix.de>) id 1wmpw0-0000000Edj9-3Cl9;
 Thu, 23 Jul 2026 11:41:44 +0200
Date: Thu, 23 Jul 2026 11:41:44 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Liu Ying <victor.liu@nxp.com>
Cc: festevam@gmail.com, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v13] drm/bridge: imx: Add i.MX93 parallel display format
 configuration support
Message-ID: <mtlwa5e3fafhw4gx4jll6z6veqmzedeeeahwo4ddepzed6oc5z@rjeywlqzr4lp>
References: <20260723-v6-18-topic-imx93-parallel-display-v13-1-ccf3f9bbc0fc@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723-v6-18-topic-imx93-parallel-display-v13-1-ccf3f9bbc0fc@nxp.com>
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

On 26-07-23, Liu Ying wrote:
> NXP i.MX93 mediamix blk-ctrl contains one DISPLAY_MUX register which
> configures parallel display format by using the "PARALLEL_DISP_FORMAT"
> field. Add a DRM bridge driver to support the display format configuration.
> 
> [m.felsch@pengutronix.de: port to v7.0-rc1]
> [m.felsch@pengutronix.de: add review feedback (Alexander)]
> [m.felsch@pengutronix.de: fix to short Kconfig description (checkpath)]
> [m.felsch@pengutronix.de: use "GPL" instead of "GPL v2" (checkpatch)]
> [m.felsch@pengutronix.de: add bus-width support]
> [ Liu Ying: Port to drm-misc/drm-misc-next(v7.2-rc2 based) ]
> [ Liu Ying: Add nxp,imx91-pdfc compatible string ]
> [ Liu Ying: Call drm_bridge_get() for next_bridge ]
> [ Liu Ying: Reject unsupported output bus fmt in .atomic_get_input_bus_fmts() ]
> 
> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> Hi,
> 
> I'm taking Marco Felsch's v11 work over and trying to add the imx93-pdfc.c
> driver.
> 
> DT binding patch and DT patch in v11 have already landed, so only need
> to send the driver patch out for review.

Thanks for taking care of this :) This was too long on my todo-list.

Regards,
  Marco

> ---
> Changes in v13:
> - Reject unsupported output bus fmt in .atomic_get_input_bus_fmts()  (Sashiko bot)
> - Tweak commit message about change log
> - Link to v12: https://patch.msgid.link/20260722-v6-18-topic-imx93-parallel-display-v12-1-a59dbb4dbc13@nxp.com
> 
> Changes in v12:
> - Link to v11: https://lore.kernel.org/r/20260303-v6-18-topic-imx93-parallel-display-v11-0-1b03733c8461@pengutronix.de
> - Rebase onto latest drm-misc/drm-misc-next
> - Drop DT binding patch and DT patch because they have landed
> - Add nxp,imx91-pdfc compatible string
> - Call drm_bridge_get() for next_bridge
> - Cc Marco
> 
> Changes in v11:
> - Link to v10: https://lore.kernel.org/r/20260302-v6-18-topic-imx93-parallel-display-v10-0-634fe2778c7a@pengutronix.de
> - Fix double space (Liu)
> - Drop 'const' (Liu)
> - Drop GFP_KERNEL from kmalloc_obj() (Liu)
> - Add r-b (Luca)
> 
> Changes in v10:
> - Link to v9: https://lore.kernel.org/r/20260115-v6-18-topic-imx93-parallel-display-v9-0-2c5051e4b144@pengutronix.de
> - Add MEDIA_BUS_FMT_FIXED (Liu)
> - Drop next_bridge from driver struct and use bridge.next_bridge (Liu)
> - Drop linux/of_address.h include (Liu)
> - imx93-pdfc: drop bridge.driver_private usage++ (Liu)
> - Make use of kmalloc_obj() (Liu)
> 
> Changes in v9:
> - Link to v8: https://lore.kernel.org/r/20260113-v6-18-topic-imx93-parallel-display-v8-0-4abccdc473a5@pengutronix.de
> - dt-bindings: drop unncessary changes (Frank)
> - imx93-pdfc: drop bridge.driver_private usage (Luca)
> - Kconfig: Adapt Kconfig symbol and prompt (Luca)
> 
> Changes in v8:
> - Link to v7: https://lore.kernel.org/r/20251202-v6-18-topic-imx93-parallel-display-v7-0-2cce31d64608@pengutronix.de
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
> - imx93-pdfc: imx93_pdfc_bridge_probe: pass -1 for endpoint reg value (Liu)
> 
> Changes in v7:
> - Link to v6: https://lore.kernel.org/r/20251201-v6-18-topic-imx93-parallel-display-v6-0-7b056e1e5b1e@pengutronix.de
> - Add missing bits.h and bitfield.h headers (lkp)
> 
> Changes in v6:
> - Link to v5: https://lore.kernel.org/all/20250304082434.834031-1-victor.liu@nxp.com/
> - Add bus-width support
> - rebase onto v6.18-rc1
> - add review feedback (Alexander)
> - driver license "GPL v2" -> "GPL" (checkpatch)
> - make use of reg of-property
> - fix to short Kconfig description (checkpath)
> - add OF integration
> 
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
>  drivers/gpu/drm/bridge/imx/imx93-pdfc.c | 222 ++++++++++++++++++++++++++++++++
>  3 files changed, 234 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/imx/Kconfig b/drivers/gpu/drm/bridge/imx/Kconfig
> index 005a745e5c47..49fcecfee38e 100644
> --- a/drivers/gpu/drm/bridge/imx/Kconfig
> +++ b/drivers/gpu/drm/bridge/imx/Kconfig
> @@ -107,4 +107,15 @@ config DRM_IMX93_MIPI_DSI
>  	  Choose this to enable MIPI DSI controller found in Freescale i.MX93
>  	  processor.
>  
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
> diff --git a/drivers/gpu/drm/bridge/imx/Makefile b/drivers/gpu/drm/bridge/imx/Makefile
> index 94ac8c40ebe9..99f28cd013ae 100644
> --- a/drivers/gpu/drm/bridge/imx/Makefile
> +++ b/drivers/gpu/drm/bridge/imx/Makefile
> @@ -10,3 +10,4 @@ obj-$(CONFIG_DRM_IMX8QXP_PIXEL_COMBINER) += imx8qxp-pixel-combiner.o
>  obj-$(CONFIG_DRM_IMX8QXP_PIXEL_LINK) += imx8qxp-pixel-link.o
>  obj-$(CONFIG_DRM_IMX8QXP_PIXEL_LINK_TO_DPI) += imx8qxp-pxl2dpi.o
>  obj-$(CONFIG_DRM_IMX93_MIPI_DSI) += imx93-mipi-dsi.o
> +obj-$(CONFIG_DRM_IMX93_PARALLEL_DISP_FMT_CONVERTER) += imx93-pdfc.o
> diff --git a/drivers/gpu/drm/bridge/imx/imx93-pdfc.c b/drivers/gpu/drm/bridge/imx/imx93-pdfc.c
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
> +imx93_pdfc_bridge_attach(struct drm_bridge *bridge, struct drm_encoder *encoder,
> +			 enum drm_bridge_attach_flags flags)
> +{
> +	return drm_bridge_attach(bridge->encoder, bridge->next_bridge, bridge, flags);
> +}
> +
> +static void imx93_pdfc_bridge_atomic_enable(struct drm_bridge *bridge,
> +					    struct drm_atomic_commit *state)
> +{
> +	struct imx93_pdfc *pdfc = bridge_to_imx93_pdfc(bridge);
> +	const struct drm_bridge_state *bridge_state;
> +	unsigned int mask = PARALLEL_DISP_FORMAT;
> +	unsigned int val;
> +
> +	bridge_state = drm_atomic_get_new_bridge_state(state, bridge);
> +
> +	switch (bridge_state->output_bus_cfg.format) {
> +	case MEDIA_BUS_FMT_RGB888_1X24:
> +	case MEDIA_BUS_FMT_FIXED:
> +		val = FORMAT_RGB888_TO_RGB888;
> +		if (pdfc->phy_bus_width == 18) {
> +			/*
> +			 * Can be valid if physical bus limitation exists,
> +			 * therefore use dev_dbg().
> +			 */
> +			dev_dbg(pdfc->dev, "Truncate two LSBs from each color\n");
> +			val = FORMAT_RGB888_TO_RGB666;
> +		}
> +		break;
> +	case MEDIA_BUS_FMT_RGB666_1X18:
> +		val = FORMAT_RGB888_TO_RGB666;
> +		break;
> +	case MEDIA_BUS_FMT_RGB565_1X16:
> +		val = FORMAT_RGB565_TO_RGB565;
> +		break;
> +	}
> +
> +	regmap_update_bits(pdfc->regmap, IMX93_DISPLAY_MUX_REG, mask, val);
> +}
> +
> +/* TODO: Add YUV formats */
> +static const u32 imx93_pdfc_bus_output_fmts[] = {
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
> +	for (i = 0; i < ARRAY_SIZE(imx93_pdfc_bus_output_fmts); i++) {
> +		if (imx93_pdfc_bus_output_fmts[i] == fmt)
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
> +	*num_input_fmts = 0;
> +
> +	if (!imx93_pdfc_bus_output_fmt_supported(output_fmt))
> +		return NULL;
> +
> +	input_fmts = kmalloc_obj(*input_fmts);
> +	if (!input_fmts)
> +		return NULL;
> +
> +	*num_input_fmts = 1;
> +
> +	switch (output_fmt) {
> +	case MEDIA_BUS_FMT_RGB888_1X24:
> +	case MEDIA_BUS_FMT_RGB565_1X16:
> +		input_fmts[0] = output_fmt;
> +		break;
> +	case MEDIA_BUS_FMT_RGB666_1X18:
> +	case MEDIA_BUS_FMT_FIXED:
> +		input_fmts[0] = MEDIA_BUS_FMT_RGB888_1X24;
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
> +	struct imx93_pdfc *pdfc = bridge_to_imx93_pdfc(bridge);
> +	u32 format = bridge_state->output_bus_cfg.format;
> +
> +	if (imx93_pdfc_bus_output_fmt_supported(format))
> +		return 0;
> +
> +	dev_warn(pdfc->dev, "Unsupported output bus format: 0x%x\n", format);
> +
> +	return -EINVAL;
> +}
> +
> +static const struct drm_bridge_funcs funcs = {
> +	.attach			= imx93_pdfc_bridge_attach,
> +	.atomic_enable		= imx93_pdfc_bridge_atomic_enable,
> +	.atomic_duplicate_state	= drm_atomic_helper_bridge_duplicate_state,
> +	.atomic_destroy_state	= drm_atomic_helper_bridge_destroy_state,
> +	.atomic_get_input_bus_fmts	= imx93_pdfc_bridge_atomic_get_input_bus_fmts,
> +	.atomic_check		= imx93_pdfc_bridge_atomic_check,
> +	.atomic_create_state	= drm_atomic_helper_bridge_create_state,
> +};
> +
> +static int imx93_pdfc_bridge_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct drm_bridge *next_bridge;
> +	struct imx93_pdfc *pdfc;
> +	struct device_node *ep;
> +	int err;
> +
> +	pdfc = devm_drm_bridge_alloc(dev, struct imx93_pdfc, bridge, &funcs);
> +	if (IS_ERR(pdfc))
> +		return PTR_ERR(pdfc);
> +
> +	pdfc->regmap = syscon_node_to_regmap(dev->of_node->parent);
> +	if (IS_ERR(pdfc->regmap))
> +		return dev_err_probe(dev, PTR_ERR(pdfc->regmap),
> +				     "failed to get regmap\n");
> +
> +	/* No limits per default */
> +	pdfc->phy_bus_width = 24;
> +
> +	/* Get output ep (port1/endpoint) */
> +	ep = of_graph_get_endpoint_by_regs(dev->of_node, 1, -1);
> +	if (ep) {
> +		err = of_property_read_u32(ep, "bus-width", &pdfc->phy_bus_width);
> +		of_node_put(ep);
> +
> +		/* bus-width is optional but it must have valid data if present */
> +		if (err && err != -EINVAL)
> +			return dev_err_probe(dev, err,
> +					     "failed to query bus-width\n");
> +	}
> +
> +	next_bridge = devm_drm_of_get_bridge(dev, dev->of_node, 1, 0);
> +	if (IS_ERR(next_bridge))
> +		return dev_err_probe(dev, PTR_ERR(next_bridge),
> +				     "failed to get next bridge\n");
> +	pdfc->dev = dev;
> +	pdfc->bridge.of_node = dev->of_node;
> +	pdfc->bridge.type = DRM_MODE_CONNECTOR_DPI;
> +	pdfc->bridge.next_bridge = drm_bridge_get(next_bridge);
> +
> +	return devm_drm_bridge_add(dev, &pdfc->bridge);
> +}
> +
> +static const struct of_device_id imx93_pdfc_dt_ids[] = {
> +	{ .compatible = "nxp,imx91-pdfc", },
> +	{ .compatible = "nxp,imx93-pdfc", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, imx93_pdfc_dt_ids);
> +
> +static struct platform_driver imx93_pdfc_bridge_driver = {
> +	.probe	= imx93_pdfc_bridge_probe,
> +	.driver	= {
> +		.of_match_table = imx93_pdfc_dt_ids,
> +		.name = "imx93_pdfc",
> +	},
> +};
> +module_platform_driver(imx93_pdfc_bridge_driver);
> +
> +MODULE_DESCRIPTION("NXP i.MX93 parallel display format configuration driver");
> +MODULE_AUTHOR("Liu Ying <victor.liu@nxp.com>");
> +MODULE_LICENSE("GPL");
> 
> ---
> base-commit: 9499d3bc41a2c4e6a1badfb55f943b9d0c34f034
> change-id: 20251201-v6-18-topic-imx93-parallel-display-95f9234bf6cc
> 
> Best regards,
> --  
> Regards,
> Liu Ying
> 
> 

-- 
#gernperDu 
#CallMeByMyFirstName

Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |
