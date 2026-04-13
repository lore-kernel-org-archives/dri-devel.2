Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4749EBFD21
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 09:17:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0421810E39D;
	Mon, 13 Apr 2026 09:17:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xQS8sfCH";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5719410E39B
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 09:17:15 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so66786655e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 02:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776071834; x=1776676634; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=BBXQV8IQIM5Jz+pAvVnKIgGMT01hQYDxhN8tz3TvSyk=;
 b=xQS8sfCHHcGmr+jAbS74N6Y02gD3XY3oLX6kfX+QMuUvsnC5tzSap61uJ2HCsuVVDm
 DBAG7khfN00P30MwqfsOzqpE0fBdd9ujcjQOl9DxXjlMimV816zQ+XJf+SJtFD2D2N0x
 z8X01MKQ9DLIwiShGz8ijn5ILMpt+/ZNy66BJP1r1MM3FjRW13VqqjZunRpxTKag9mgO
 DutD1zZL9NhpFoX4QW+uJ01HqiTMFoaDfczEbHefzOp3Y6lffzxsVvMS/LW7S+0Ytg3q
 fYI7WQmTG11LAILGPahH0KWBk1vjNU8XSfuNXsPhSH0xR3xg6INYj5ndBWXv9FAnnrem
 Dh4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776071834; x=1776676634;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BBXQV8IQIM5Jz+pAvVnKIgGMT01hQYDxhN8tz3TvSyk=;
 b=F2VLB68ZlLguslnsMKlBjcJQTGGeOaxdDDjbnQYFZX2K5grlM7uGATQcwF1erxaIVA
 v8iiMm7vEGmoyPZEH/r8jm9WZoJIMgJu7f24Q1ywl9k80Mw0R4QlPWY5F80JgP57HD7m
 ZK0MyglxWK2vf4H+nu2DEqBcGHSbJGcRMpA4tpqnIXabKR2tykeSrXAN+17Dt5wOE6jl
 QBlgGSI3oQrs32+zbBUlYcnqUud15CrhjtA5ZBN0C3Cgc7bC0b+DW2NSIOVMGhExoSHz
 GowOw7JLG96QYtWuRjPRBRuayyuhxALQgmm/LQCiP78roRbkUC6/cAZ3ZLhHnZ+D0B2V
 j6hw==
X-Gm-Message-State: AOJu0YxpJDZST4lIiIU5Ty+hf23EzmRH09fXY2euGInJjT42BETLuLeu
 ZMKd5q60sYQWiJ22QMQpB0CmpOYNFQ2XCwSoKmfIAXdO+WrEL+ecFdkE0p6ytw+QRdc=
X-Gm-Gg: AeBDieteiJ762xyKUsiVsgrSZPWQ6GSvoDWB4fY7HwTtVPGnZ/2aCbV+Qpob+Hkb9iK
 fWaV0BZBjLtTZwnXyumWbGI5FlvwzjaF4FozYRcmqK88asC6F1IyYb5Fnw9zWfetpeVm84sOL0M
 kRQ1JqOoHzdHQ0/N4K2eIZ81Py0SXMH/smLxWZOb6dpEfGIR7Qg4snCb1IEfQpLCsp5NHvS6qvV
 cM0ZAC55FQJbnDcPXzx/IEUoEOUebaMNW2/oUaHsZoQIBX85le+eSdjBaJ1HxG431ZfZZRL5k2T
 ic3lK8XpRgmLRkHBt/MNJnXslq/8hL7Ai3NHp3s8+7RBrjASNxgIvdHmDcT1d3tyrtAgkiyMZYD
 jqodfkVweqX4yaqdEE/8vXe+pCFy53FS9zUx80GtCQyW8de7yHQiLMrG/1hZ3LP8ox848eS/8zp
 RWs39PHEZv4zeEafQw2CNuCS9aQO3eX0SW3QcPMgb+8c/ih1xzdO3QQIoAUjbWJZP04mA7Ohc5g
 haJHmDo8U53mdlq/A==
X-Received: by 2002:a05:600c:5298:b0:488:c014:34da with SMTP id
 5b1f17b1804b1-488d688687cmr180555835e9.26.1776071833592; 
 Mon, 13 Apr 2026 02:17:13 -0700 (PDT)
Received: from ?IPV6:2a01:cb1c:fcf:4600:4cfb:7427:8a08:9d25?
 ([2a01:cb1c:fcf:4600:4cfb:7427:8a08:9d25])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d5888c12sm332474845e9.3.2026.04.13.02.17.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 02:17:13 -0700 (PDT)
Message-ID: <63870098-5e70-44af-ba18-1fd726b5ef5a@linaro.org>
Date: Mon, 13 Apr 2026 11:17:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 2/2] drm/panel: Add panel driver for ChipWealth
 CH13726A based panels
To: webgeek1234@gmail.com, Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Teguh Sobirin <teguh@sobir.in>
References: <20260408-ch13726a-v4-0-9bb1a9b8f329@gmail.com>
 <20260408-ch13726a-v4-2-9bb1a9b8f329@gmail.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20260408-ch13726a-v4-2-9bb1a9b8f329@gmail.com>
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On 4/8/26 07:32, Aaron Kling via B4 Relay wrote:
> From: Teguh Sobirin <teguh@sobir.in>
> 
> This is used by the AYN Thor for the bottom panel.
> 
> Signed-off-by: Teguh Sobirin <teguh@sobir.in>
> Co-developed-by: Aaron Kling <webgeek1234@gmail.com>
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>   drivers/gpu/drm/panel/Kconfig                     |  11 +
>   drivers/gpu/drm/panel/Makefile                    |   1 +
>   drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c | 339 ++++++++++++++++++++++
>   3 files changed, 351 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index d6863b28ddc559..e2c00f08f4507d 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -105,6 +105,17 @@ config DRM_PANEL_BOE_TV101WUM_LL2
>   	  Say Y here if you want to support for BOE TV101WUM-LL2
>   	  WUXGA PANEL DSI Video Mode panel
>   
> +config DRM_PANEL_CHIPWEALTH_CH13726A
> +	tristate "CHIPWEALTH CH13726A-based DSI panel"
> +	depends on OF
> +	depends on DRM_MIPI_DSI
> +	depends on BACKLIGHT_CLASS_DEVICE
> +	select DRM_DISPLAY_DP_HELPER
> +	select DRM_DISPLAY_HELPER
> +	help
> +	  Say Y here if you want to enable support for ChipWealth
> +	  CH13726A-based display panels.
> +
>   config DRM_PANEL_EBBG_FT8719
>   	tristate "EBBG FT8719 panel driver"
>   	depends on OF
> diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
> index a4291dc3905bed..343d283d1620fb 100644
> --- a/drivers/gpu/drm/panel/Makefile
> +++ b/drivers/gpu/drm/panel/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_DRM_PANEL_BOE_TD4320) += panel-boe-td4320.o
>   obj-$(CONFIG_DRM_PANEL_BOE_TH101MB31UIG002_28A) += panel-boe-th101mb31ig002-28a.o
>   obj-$(CONFIG_DRM_PANEL_BOE_TV101WUM_LL2) += panel-boe-tv101wum-ll2.o
>   obj-$(CONFIG_DRM_PANEL_BOE_TV101WUM_NL6) += panel-boe-tv101wum-nl6.o
> +obj-$(CONFIG_DRM_PANEL_CHIPWEALTH_CH13726A) += panel-chipwealth-ch13726a.o
>   obj-$(CONFIG_DRM_PANEL_DSI_CM) += panel-dsi-cm.o
>   obj-$(CONFIG_DRM_PANEL_LVDS) += panel-lvds.o
>   obj-$(CONFIG_DRM_PANEL_SIMPLE) += panel-simple.o
> diff --git a/drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c b/drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c
> new file mode 100644
> index 00000000000000..48a5e20e07c487
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c
> @@ -0,0 +1,339 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ChipWealth CH13726A MIPI-DSI panel driver
> + * Copyright (c) 2024, Teguh Sobirin <teguh@sobir.in>.
> + */
> +
> +#include <linux/backlight.h>
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <drm/drm_mipi_dsi.h>
> +#include <drm/drm_modes.h>
> +#include <drm/drm_panel.h>
> +
> +#include <video/mipi_display.h>
> +
> +struct ch13726a_panel {
> +	struct drm_panel panel;
> +	struct mipi_dsi_device *dsi;
> +	struct regulator_bulk_data supplies[4];
> +	struct gpio_desc *reset_gpio;
> +	struct ch13726a_desc *desc;
> +	enum drm_panel_orientation orientation;
> +	bool prepared;

Drop this, it's handled by the panel core now.

> +};
> +
> +struct ch13726a_desc {
> +	unsigned int width_mm;
> +	unsigned int height_mm;
> +	unsigned int bpc;
> +
> +	const struct drm_display_mode *modes;
> +	unsigned int num_modes;
> +};
> +
> +static inline struct ch13726a_panel *to_ch13726a_panel(struct drm_panel *panel)
> +{
> +	return container_of(panel, struct ch13726a_panel, panel);
> +}
> +
> +static void ch13726a_reset(struct ch13726a_panel *ctx)
> +{
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> +	usleep_range(10000, 11000);
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> +	usleep_range(10000, 11000);
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> +	usleep_range(10000, 11000);
> +}
> +
> +static int ch13726a_on(struct ch13726a_panel *ctx)
> +{
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
> +
> +	ctx->dsi->mode_flags |= MIPI_DSI_MODE_LPM;
> +
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf0, 0x50);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb9, 0x00);
> +
> +	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> +
> +	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
> +
> +	return dsi_ctx.accum_err;
> +}
> +
> +static int ch13726a_disable(struct drm_panel *panel)
> +{
> +	struct ch13726a_panel *ctx = to_ch13726a_panel(panel);
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
> +
> +	ctx->dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
> +
> +	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
> +	mipi_dsi_msleep(&dsi_ctx, 50);
> +	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
> +
> +	return dsi_ctx.accum_err;
> +}
> +
> +static int ch13726a_prepare(struct drm_panel *panel)
> +{
> +	struct ch13726a_panel *ctx = to_ch13726a_panel(panel);
> +	struct device *dev = &ctx->dsi->dev;
> +	int ret;
> +
> +	if (ctx->prepared)
> +		return 0;
> +
> +	ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to enable regulators: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ch13726a_reset(ctx);
> +
> +	ret = ch13726a_on(ctx);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to initialize panel: %d\n", ret);
> +		gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> +		regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
> +		return ret;
> +	}
> +
> +	msleep(28);
> +
> +	ctx->prepared = true;
> +
> +	return 0;
> +}
> +
> +static int ch13726a_unprepare(struct drm_panel *panel)
> +{
> +	struct ch13726a_panel *ctx = to_ch13726a_panel(panel);
> +
> +	if (!ctx->prepared)
> +		return 0;
> +
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> +	regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
> +
> +	ctx->prepared = false;
> +	return 0;
> +}
> +
> +static const struct drm_display_mode thor_bottom_modes[] = {
> +	{
> +		/* 120Hz */
> +		.clock = (1080 + 28 + 4 + 36) * (1240 + 16 + 4 + 8) * 120 / 1000,
> +		.hdisplay = 1080,
> +		.hsync_start = 1080 + 28,
> +		.hsync_end = 1080 + 28 + 4,
> +		.htotal = 1080 + 28 + 4 + 36,
> +		.vdisplay = 1240,
> +		.vsync_start = 1240 + 16,
> +		.vsync_end = 1240 + 16 + 4,
> +		.vtotal = 1240 + 16 + 4 + 8,
> +	},
> +	{
> +		/* 60Hz */
> +		.clock = (1080 + 28 + 4 + 36) * (1240 + 16 + 4 + 8) * 60 / 1000,
> +		.hdisplay = 1080,
> +		.hsync_start = 1080 + 28,
> +		.hsync_end = 1080 + 28 + 4,
> +		.htotal = 1080 + 28 + 4 + 36,
> +		.vdisplay = 1240,
> +		.vsync_start = 1240 + 16,
> +		.vsync_end = 1240 + 16 + 4,
> +		.vtotal = 1240 + 16 + 4 + 8,
> +	}
> +};
> +
> +static struct ch13726a_desc thor_bottom_desc = {
> +	.modes = thor_bottom_modes,
> +	.num_modes = ARRAY_SIZE(thor_bottom_modes),
> +	.width_mm = 65,
> +	.height_mm = 75,
> +	.bpc = 8,
> +};
> +
> +static int ch13726a_get_modes(struct drm_panel *panel,
> +					struct drm_connector *connector)
> +{
> +	struct ch13726a_panel *ctx = to_ch13726a_panel(panel);
> +
> +	for (uint8_t i = 0; i < ctx->desc->num_modes; i++) {
> +		const struct drm_display_mode *m = &ctx->desc->modes[i];
> +		struct drm_display_mode *mode;
> +
> +		mode = drm_mode_duplicate(connector->dev, m);
> +		if (!mode) {
> +			dev_err(&ctx->dsi->dev, "failed to add mode %ux%u@%u\n",
> +				m->hdisplay, m->vdisplay, drm_mode_vrefresh(m));
> +			return -ENOMEM;
> +		}

Can you use drm_connector_helper_get_modes_fixed instead ?

> +
> +		mode->type = DRM_MODE_TYPE_DRIVER;
> +		if (i == 0)
> +			mode->type |= DRM_MODE_TYPE_PREFERRED;
> +
> +		drm_mode_set_name(mode);
> +		drm_mode_probed_add(connector, mode);
> +	}
> +
> +	connector->display_info.width_mm = ctx->desc->width_mm;
> +	connector->display_info.height_mm = ctx->desc->height_mm;
> +	connector->display_info.bpc = ctx->desc->bpc;
> +
> +	return ctx->desc->num_modes;
> +}
> +
> +static enum drm_panel_orientation ch13726a_get_orientation(struct drm_panel *panel)
> +{
> +	struct ch13726a_panel *ctx = to_ch13726a_panel(panel);
> +
> +	return ctx->orientation;
> +}
> +
> +static const struct drm_panel_funcs ch13726a_panel_funcs = {
> +	.prepare = ch13726a_prepare,
> +	.unprepare = ch13726a_unprepare,
> +	.disable = ch13726a_disable,
> +	.get_modes = ch13726a_get_modes,
> +	.get_orientation = ch13726a_get_orientation,
> +};
> +
> +static int ch13726a_bl_update_status(struct backlight_device *bl)
> +{
> +	struct mipi_dsi_device *dsi = bl_get_data(bl);
> +	u16 brightness = backlight_get_brightness(bl);
> +	int ret;
> +
> +	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
> +
> +	ret = mipi_dsi_dcs_set_display_brightness(dsi, brightness);
> +	if (ret < 0)
> +		return ret;
> +
> +	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
> +
> +	return 0;
> +}
> +
> +static const struct backlight_ops ch13726a_bl_ops = {
> +	.update_status = ch13726a_bl_update_status,
> +};
> +
> +static struct backlight_device *
> +ch13726a_create_backlight(struct mipi_dsi_device *dsi)
> +{
> +	struct device *dev = &dsi->dev;
> +	const struct backlight_properties props = {
> +		.type = BACKLIGHT_RAW,
> +		.brightness = 255,
> +		.max_brightness = 255,
> +	};
> +
> +	return devm_backlight_device_register(dev, dev_name(dev), dev, dsi,
> +					      &ch13726a_bl_ops, &props);
> +}
> +
> +static int ch13726a_probe(struct mipi_dsi_device *dsi)
> +{
> +	struct device *dev = &dsi->dev;
> +	struct ch13726a_panel *ctx;
> +	int ret;
> +
> +	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	ctx->desc = (struct ch13726a_desc *)of_device_get_match_data(dev);
> +	if (!ctx->desc)
> +		return -ENODEV;
> +
> +	ctx->supplies[0].supply = "vdd1v2";
> +	ctx->supplies[1].supply = "vddio";
> +	ctx->supplies[2].supply = "vdd";
> +	ctx->supplies[3].supply = "avdd";
> +
> +	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(ctx->supplies),
> +				      ctx->supplies);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to get regulators\n");
> +
Can you switch to devm_regulator_bulk_get_const ?

> +	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(ctx->reset_gpio))
> +		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
> +				     "Failed to get reset-gpios\n");
> +
> +	ret = of_drm_get_panel_orientation(dev->of_node, &ctx->orientation);
> +	if (ret < 0) {
> +		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, ret);
> +		return ret;
> +	}
> +
> +	ctx->dsi = dsi;
> +	mipi_dsi_set_drvdata(dsi, ctx);
> +
> +	dsi->lanes = 4;
> +	dsi->format = MIPI_DSI_FMT_RGB888;
> +	dsi->mode_flags = MIPI_DSI_MODE_VIDEO |
> +			  MIPI_DSI_CLOCK_NON_CONTINUOUS;
> +
> +	drm_panel_init(&ctx->panel, dev, &ch13726a_panel_funcs,
> +		       DRM_MODE_CONNECTOR_DSI);

Please use devm_drm_panel_alloc() instead.

> +	ctx->panel.prepare_prev_first = true;
> +
> +	ctx->panel.backlight = ch13726a_create_backlight(dsi);
> +	if (IS_ERR(ctx->panel.backlight))
> +		return dev_err_probe(dev, PTR_ERR(ctx->panel.backlight),
> +				     "Failed to create backlight\n");
> +
> +	drm_panel_add(&ctx->panel);
> +
> +	ret = mipi_dsi_attach(dsi);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
> +		drm_panel_remove(&ctx->panel);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void ch13726a_remove(struct mipi_dsi_device *dsi)
> +{
> +	struct ch13726a_panel *ctx = mipi_dsi_get_drvdata(dsi);
> +	int ret;
> +
> +	ret = mipi_dsi_detach(dsi);
> +	if (ret < 0)
> +		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
> +
> +	drm_panel_remove(&ctx->panel);
> +}
> +
> +static const struct of_device_id ch13726a_of_match[] = {
> +	{ .compatible = "ayntec,thor-panel-bottom", .data = &thor_bottom_desc },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, ch13726a_of_match);
> +
> +static struct mipi_dsi_driver ch13726a_driver = {
> +	.probe = ch13726a_probe,
> +	.remove = ch13726a_remove,
> +	.driver = {
> +		.name = "panel-ch13726a-amoled",
> +		.of_match_table = ch13726a_of_match,
> +	},
> +};
> +module_mipi_dsi_driver(ch13726a_driver);
> +
> +MODULE_DESCRIPTION("DRM driver for CH13726A DSI panels");
> +MODULE_LICENSE("GPL");
> 

