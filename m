Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31420F327CB
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 09:12:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92F7F10E84E;
	Tue, 21 Apr 2026 09:12:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=tuxon.dev header.i=@tuxon.dev header.b="qSKfxc8y";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64BFF10E84E
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 09:12:07 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-43d7213b6ebso2655035f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 02:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tuxon.dev; s=google; t=1776762726; x=1777367526; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D4ShzPYZF8P5aa2FyFk22XMxsjQJqHFxT1MYEEzO2jc=;
 b=qSKfxc8ywdS5LF0LVW5+R5749mD1gM4UjvJJCvZP+oZfFbCkGxgo/wFvzFzE05mzO8
 UJoVrv43mkh67HWSGrQ7CP4zsxsEafIwArBrs51SVDO4p2+FQMtYYjtNVZU5gi5Akx46
 55GIfWXFdxdW2Z8s+1WcmcEi8iPeH3yzPkf5k8M55jV7DDd17gRpkYW6bypWovKm70ml
 3/XEDn44twsfk1Inkr+Wtr2/n6JnqC6ETs4U3bc4N3wBJLHXF6MA9pV0phVh7jcSMK6z
 Mt+sqSb4XJCbZHAkqk9IH3L8nM0vLBD5etSkDCssqVH3TKhOD1X5LFfo6OtiUt1a1wJD
 V+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776762726; x=1777367526;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D4ShzPYZF8P5aa2FyFk22XMxsjQJqHFxT1MYEEzO2jc=;
 b=aRC7X/mUeNPkgnVLbPVTlpaZd//odyYDo09gPopi7Qxr+LR5ddUlF2TfYSW8LjC9dH
 SvSd8suO4fLeBjK63TQMuPpk9KKvreAEZ83MCYYnT/9NbNFN5wNDFAFXUgpYIdIJOAvN
 R72eoy0I/NVTs/rOWoIMr7RqQvVMTjQgMAR8Pv4RWchGII8tGulG8MhSITmPx32N+TVt
 GA5rJotWZxLsmrNqeeZ3Jbx9hQt0ChrJSxM6wDF2JUoZOLCFKMRxSqS49sJmYcFMyWUl
 b0ZZ+ATbXvEsPlV9ijPJODt649zq4NszdE4ShypjU5HqY9MOKBuT8F9/5GekgIeFSRfR
 Yotw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ED54Qg41JaVO+kHXQ2g/JA5AGD0SwEPci+pwpnTD6FtNfgnLVCDVjEtziPuyv+eqBjk8nAtEzAMY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzCcWOvknkcP8Hjof+pFxY4bfAbk8Cw/4fsYHZKr7cxsBrCRZOe
 oSbwLsqgjYCZRMOtqdN9MDhFSwk799DxpeMq+0K6Kp+oWuSgNiRSE5sSB9uzxJgm+Ls=
X-Gm-Gg: AeBDiesEEenPlE5NX96IehU1snspn8W9Zop4wG2whtV+CfG5F1BNT24ZYw6W/phlR8X
 Eeiif2kpOwXBHbqol5oLofFitYpiukwFT5z/ux1ETjyK4V9cLxJYbkfy6DJ5wXVnq+uXWVAgFh8
 VrVHzQVjGanSJsYQKItM0hMrcc3H6QR65b4cPRCK2bC4iBG1MmCbEliBBQMOLEw4aZ1N7/Y0LvI
 INOpYHclIqnpfvtZoOu4MG5pAp3PdFdHTfZr40Rch6pecq8A/jVfsIO/FBcnXyIutp+06V9lQ3A
 m6LX1qgvD4mH/H11L9vrwB+xR0LHaLs3j5xGyR0yFP3Bs9P+z6/sV0fe6gpmcXcgaQQ18gCzIl9
 dufULESMQYrD+XwD2Mz3oNB4zRPD420iELMOA92iuZB4vthnJurL5GNzx6R8NGgORC7o+KInXON
 ODUI78P5mSGVhA83mZhomurjOsnr2owSEwDKGcco4lDg==
X-Received: by 2002:a05:6000:184d:b0:43d:e31:68d1 with SMTP id
 ffacd0b85a97d-43fe3dd958amr27187440f8f.21.1776762725378; 
 Tue, 21 Apr 2026 02:12:05 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.162])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4ffa8sm35588267f8f.35.2026.04.21.02.12.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2026 02:12:04 -0700 (PDT)
Message-ID: <6d223449-8a5e-4565-b026-8c7cf6961343@tuxon.dev>
Date: Tue, 21 Apr 2026 12:12:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm: renesas: rz-du: Add support for RZ/G3L LVDS
 encoder
To: Biju <biju.das.au@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
References: <20260417175235.224809-1-biju.das.jz@bp.renesas.com>
 <20260417175235.224809-4-biju.das.jz@bp.renesas.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260417175235.224809-4-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi,

On 4/17/26 20:52, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
> 
> Add support for the RZ/G3L LVDS encoder driver. It operates in single-link
> mode with 4 lanes (Data) + 1 lane (Clock) and supports pixel clock rates
> from 25 to 87 MHz. The LVDS module cannot be used at the same time as
> MIPI-DSI. However, LVDS and the DSI interface share a peripheral clock and
> the MIPI_DSI_PRESET_N reset signal. Also, the MIPI_DSI_CMN_RSTB and
> MIPI_DSI_ARESET_N reset signals must be asserted before using the LVDS
> module.
> 
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>   drivers/gpu/drm/renesas/rz-du/Kconfig         |  13 +
>   drivers/gpu/drm/renesas/rz-du/Makefile        |   1 +
>   drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c    | 333 ++++++++++++++++++
>   drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.h    |  22 ++
>   .../gpu/drm/renesas/rz-du/rzg3l_lvds_regs.h   |  26 ++
>   5 files changed, 395 insertions(+)
>   create mode 100644 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c
>   create mode 100644 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.h
>   create mode 100644 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds_regs.h
> 
> diff --git a/drivers/gpu/drm/renesas/rz-du/Kconfig b/drivers/gpu/drm/renesas/rz-du/Kconfig
> index 7f2ef7137ae5..cbfc7b6bccb8 100644
> --- a/drivers/gpu/drm/renesas/rz-du/Kconfig
> +++ b/drivers/gpu/drm/renesas/rz-du/Kconfig
> @@ -26,3 +26,16 @@ config DRM_RZG2L_MIPI_DSI
>   	def_tristate DRM_RZG2L_DU
>   	depends on DRM_RZG2L_USE_MIPI_DSI
>   	select DRM_MIPI_DSI
> +
> +config DRM_RZG3L_USE_LVDS
> +	bool "RZ/G3L DU LVDS Encoder Support"
> +	depends on DRM_BRIDGE && OF
> +	default DRM_RZG2L_DU
> +	help
> +	  Enable support for the RZ/G3L Display Unit embedded LVDS encoders.
> +
> +config DRM_RZG3L_LVDS
> +	def_tristate DRM_RZG2L_DU
> +	depends on DRM_RZG3L_USE_LVDS
> +	select DRM_KMS_HELPER
> +	select DRM_PANEL
> diff --git a/drivers/gpu/drm/renesas/rz-du/Makefile b/drivers/gpu/drm/renesas/rz-du/Makefile
> index 2987900ea6b6..46decb7ac4f1 100644
> --- a/drivers/gpu/drm/renesas/rz-du/Makefile
> +++ b/drivers/gpu/drm/renesas/rz-du/Makefile
> @@ -8,3 +8,4 @@ rzg2l-du-drm-$(CONFIG_VIDEO_RENESAS_VSP1)	+= rzg2l_du_vsp.o
>   obj-$(CONFIG_DRM_RZG2L_DU)		+= rzg2l-du-drm.o
>   
>   obj-$(CONFIG_DRM_RZG2L_MIPI_DSI)	+= rzg2l_mipi_dsi.o
> +obj-$(CONFIG_DRM_RZG3L_LVDS)		+= rzg3l_lvds.o
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c b/drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c
> new file mode 100644
> index 000000000000..bedeedbdfada
> --- /dev/null
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c
> @@ -0,0 +1,333 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * RZ/G3L LVDS Encoder Driver
> + *
> + * Copyright (C) 2026 Renesas Electronics Corporation
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/media-bus-format.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_graph.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +
> +#include <drm/drm_atomic.h>
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_bridge.h>
> +#include <drm/drm_of.h>
> +#include <drm/drm_panel.h>
> +#include <drm/drm_probe_helper.h>
> +
> +#include "rzg3l_lvds.h"
> +#include "rzg3l_lvds_regs.h"
> +
> +enum rzg3l_lvds_mode {
> +	RZG3L_LVDS_MODE_JEIDA = 0,
> +	RZG3L_LVDS_MODE_JEIDA_MIRROR = 1,
> +	RZG3L_LVDS_MODE_MODE2 = 2,
> +	RZG3L_LVDS_MODE_MODE2_MIRROR = 3,
> +	RZG3L_LVDS_MODE_VESA = 4,
> +	RZG3L_LVDS_MODE_VESA_MIRROR = 5,
> +	RZG3L_LVDS_MODE_MODE6 = 6,
> +	RZG3L_LVDS_MODE_MODE6_MIRROR = 7,
> +};
> +
> +struct rzg3l_lvds {
> +	struct device *dev;
> +	struct reset_control *prstc;
> +	struct reset_control *lvd_rstc;
> +	struct regmap *regmap;
> +
> +	struct drm_bridge bridge;
> +	struct drm_bridge *next_bridge;
> +};
> +
> +#define bridge_to_rzg3l_lvds(b) \
> +	container_of(b, struct rzg3l_lvds, bridge)
> +
> +/* -----------------------------------------------------------------------------
> + * Bridge
> + */
> +static void rzg3l_lvds_atomic_enable(struct drm_bridge *bridge,
> +				     struct drm_atomic_state *state)
> +{
> +	struct rzg3l_lvds *lvds = bridge_to_rzg3l_lvds(bridge);
> +	const struct drm_bridge_state *bridge_state;
> +	int ret;
> +	u32 fmt;
> +
> +	/* Get the LVDS format from the bridge state. */
> +	bridge_state = drm_atomic_get_new_bridge_state(state, bridge);
> +	if (!bridge_state) {
> +		dev_err(lvds->dev, "failed to get bridge state\n");
> +		return;
> +	}
> +
> +	switch (bridge_state->output_bus_cfg.format) {
> +	case MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA:
> +		fmt = RZG3L_LVDS_MODE_JEIDA;
> +		break;
> +	case MEDIA_BUS_FMT_RGB888_1X7X4_SPWG:
> +		fmt = RZG3L_LVDS_MODE_VESA;
> +		break;
> +	default:
> +		fmt = RZG3L_LVDS_MODE_VESA;
> +		dev_warn(lvds->dev, "Unsupported bus fmt 0x%04x\n",
> +			 bridge_state->output_bus_cfg.format);
> +		break;
> +	}
> +
> +	ret = pm_runtime_resume_and_get(lvds->dev);
> +	if (ret < 0) {
> +		dev_err(lvds->dev, "pm_runtime_resume_and_get error\n");
> +		return;
> +	}
> +
> +	regmap_update_bits(lvds->regmap, LVDS_0_PHY_OFFSET,
> +			   LVDS_0_PHY_CH_EN_BGR, LVDS_0_PHY_CH_EN_BGR);
> +	usleep_range(20, 25);

maybe fsleep()? Same for the above usleep_range()

> +
> +	regmap_update_bits(lvds->regmap, LVDS_0_PHY_OFFSET,
> +			   LVDS_0_PHY_CH_EN_LDO, LVDS_0_PHY_CH_EN_LDO);
> +	usleep_range(10, 15);
> +
> +	regmap_write(lvds->regmap, LVDS_CMN, LVDS_CMN_RST_PHY0_SEL);
> +	regmap_update_bits(lvds->regmap, LVDS_0_CTL_OFFSET,
> +			   LVDS_0_CTL_FMT_SEL_MSK,
> +			   FIELD_PREP(LVDS_0_CTL_FMT_SEL_MSK, fmt));
> +	regmap_update_bits(lvds->regmap, LVDS_0_PHY_OFFSET,
> +			   LVDS_0_PHY_CH_IO_EN_MSK, LVDS_0_PHY_CH_IO_EN);
> +	regmap_write(lvds->regmap, LVDS_CMN,
> +		     LVDS_CMN_RST_PHY0_SEL | LVDS_CMN_PHY_RESET);
> +	usleep_range(100, 150);
> +}
> +
> +static void rzg3l_lvds_atomic_disable(struct drm_bridge *bridge,
> +				      struct drm_atomic_state *state)
> +{
> +	struct rzg3l_lvds *lvds = bridge_to_rzg3l_lvds(bridge);
> +
> +	regmap_update_bits(lvds->regmap, LVDS_CMN, LVDS_CMN_PHY_RESET, 0);
> +	regmap_update_bits(lvds->regmap, LVDS_0_PHY_OFFSET,
> +			   LVDS_0_PHY_CH_IO_EN_MSK, 0);
> +	regmap_update_bits(lvds->regmap, LVDS_0_PHY_OFFSET,
> +			   LVDS_0_PHY_CH_EN_LDO, 0);
> +	regmap_update_bits(lvds->regmap, LVDS_0_PHY_OFFSET,
> +			   LVDS_0_PHY_CH_EN_BGR, 0);
> +
> +	pm_runtime_put(lvds->dev);
> +}
> +
> +static int rzg3l_lvds_attach(struct drm_bridge *bridge,
> +			     struct drm_encoder *encoder,
> +			     enum drm_bridge_attach_flags flags)
> +{
> +	struct rzg3l_lvds *lvds = bridge_to_rzg3l_lvds(bridge);
> +
> +	if (!lvds->next_bridge)
> +		return 0;
> +
> +	return drm_bridge_attach(encoder, lvds->next_bridge, bridge, flags);
> +}
> +
> +static enum drm_mode_status
> +rzg3l_lvds_bridge_mode_valid(struct drm_bridge *bridge,
> +			     const struct drm_display_info *info,
> +			     const struct drm_display_mode *mode)
> +{
> +	if (mode->clock > 87000)
> +		return MODE_CLOCK_HIGH;
> +
> +	if (mode->clock < 25000)
> +		return MODE_CLOCK_LOW;
> +
> +	return MODE_OK;
> +}
> +
> +bool rzg3l_lvds_is_connected(struct drm_bridge *bridge)
> +{
> +	struct rzg3l_lvds *lvds = bridge_to_rzg3l_lvds(bridge);
> +
> +	return !!lvds->next_bridge;
> +}
> +EXPORT_SYMBOL_GPL(rzg3l_lvds_is_connected);
> +
> +static const struct drm_bridge_funcs rzg3l_lvds_bridge_ops = {
> +	.attach = rzg3l_lvds_attach,
> +	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
> +	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
> +	.atomic_reset = drm_atomic_helper_bridge_reset,
> +	.atomic_enable = rzg3l_lvds_atomic_enable,
> +	.atomic_disable = rzg3l_lvds_atomic_disable,
> +	.mode_valid = rzg3l_lvds_bridge_mode_valid,
> +};
> +
> +/* -----------------------------------------------------------------------------
> + * Power Management
> + */
> +
> +static int rzg3l_lvds_pm_runtime_suspend(struct device *dev)
> +{
> +	struct rzg3l_lvds *lvds = dev_get_drvdata(dev);

You can use:

	struct reset_control_bulk_data resets[] = {
		{ .rstc = lvds->lvd_rstc },
		{ .rstc = lvds->prstc },
	};


	return reset_control_bulk_assert(ARRAY_SIZE(resets), resets);

> +	int ret;
> +
> +	ret = reset_control_assert(lvds->lvd_rstc);
> +	if (ret)
> +		return ret;
> +
> +	ret = reset_control_assert(lvds->prstc);
> +	if (ret)
> +		goto err_deassert_lvd_rstc;
> +
> +	return 0;
> +
> +err_deassert_lvd_rstc:
> +	reset_control_deassert(lvds->lvd_rstc);
> +	return ret;
> +}
> +
> +static int rzg3l_lvds_pm_runtime_resume(struct device *dev)
> +{
> +	struct rzg3l_lvds *lvds = dev_get_drvdata(dev);
> +	int ret;

Same here.

> +
> +	ret = reset_control_deassert(lvds->prstc);
> +	if (ret)
> +		return ret;
> +
> +	return reset_control_deassert(lvds->lvd_rstc);
> +	if (ret)
> +		goto err_assert_prstc;
> +
> +	return 0;
> +
> +err_assert_prstc:
> +	reset_control_assert(lvds->prstc);
> +	return ret;
> +}
> +
> +static const struct dev_pm_ops rzg3l_lvds_pm_ops = {
> +	RUNTIME_PM_OPS(rzg3l_lvds_pm_runtime_suspend,
> +		       rzg3l_lvds_pm_runtime_resume, NULL)
> +	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
> +};
> +
> +/* -----------------------------------------------------------------------------
> + * Probe & Remove
> + */
> +
> +static int rzg3l_lvds_parse_dt(struct rzg3l_lvds *lvds)
> +{
> +	struct device *dev = lvds->dev;
> +	struct drm_panel *panel;
> +	int ret;
> +
> +	ret = drm_of_find_panel_or_bridge(dev->of_node, 1, 0,
> +					  &panel, &lvds->next_bridge);

 From documentation of this function:

  * This function is deprecated and should not be used in new drivers. Use 

  * devm_drm_of_get_bridge() instead. 


devm_of_get_bridged() seems to be doing exactly what rzg3l_lvds_parse_dt() is doing.

Thank you,
Claudiu
