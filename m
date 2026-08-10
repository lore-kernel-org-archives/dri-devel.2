Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C4FC5AD4E
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 09:58:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7356110E77C;
	Mon, 10 Aug 2026 09:58:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GE5/lr+p";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15CDF10E77C
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 09:58:42 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4996f1ee4a4so5797515e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 02:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786355920; x=1786960720; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kD0pMxuZ3raUNAZbYBvOzeB3CvmMmqgfQTOE6nazHnk=;
 b=GE5/lr+pYzIUB4M/kMk9p1/A3OlB52nJxE2aFE5LaMtPDjQyvH0H+YeX3sLPROw5Hn
 O2XO20uSOIx/YJQA7iI3r0TF5lyEC0j4JDFrWl+3+CeHH4S8iOrcbLOamKs2zmuJkiYG
 7ZvIiUskfyFeHORbrq3VWD6doLvtt7/pHEgVcsCUlX9filkQdfUYNrVjwwPWPKu0YaPY
 CfpUsJk1NyYlJFupp8bt0nPrmdGza0r/V5/ZXTaeDWznVdUiJMB/DSBxvMVmhKU6ImTe
 50QBb83z4uMKdprVvIE7Jwfjsa6d54IEha0dcJIctsgv5Y6gXSND0SR8ua0XOzjveKqC
 Rm/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786355920; x=1786960720;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kD0pMxuZ3raUNAZbYBvOzeB3CvmMmqgfQTOE6nazHnk=;
 b=ethfhSsEZV1XrXczeHANpgQmkG6kBUurBzZcxZvoWtLHuN+BT9warDjrVjfpHItgwL
 1PtxlFhwfJ70TCyQ/27YndtSh+feYHfbWmVMiOtuDUNZOfep4yw1HCnuZJX2tdEGygi/
 dTTQyz+sGGGgRnbAme+OFAijoGv/bgf8WBCSnLko1CqV3aayG+9/tPJiKDkcPozSXksn
 TxzdhalL7LVgTOAuHhnjlF9APAVqfxbKZWqffr9IFkJM5PqcnlYiKDu/2Bs8xsJActUJ
 cCtvBVM/+BYH6NxOz526s/kyoz6ZqNt1Vp/y5AFp439ZWOPmxzdBKIoNuYPwqWGMljXV
 fPVQ==
X-Gm-Message-State: AOJu0Yyef2mqAuKe5uXNyyBliLIVwnEqwiTe/a0OvO9nhNkkQ9tI8zoQ
 bEl+z05SXVDIfuOZ6MKC7tY7UjslACMJRdd8y5AYRuFNL9y+0H9kI+T2QuP8iwIjw2o=
X-Gm-Gg: AR+sD11xv33SooYFHFrO++JO32jiysv+wFaAjbhKQamVa+iNHe6w8vDylB9K2dg/RWP
 1qBiI8zbu6O+2MFmBOp1VjVt2oYzjDZSnarJoRoKzuF0RNAS4qkM3MQ7I+oRAm5NKAiCDRsfIDz
 1IUGkX5u348HiFzdRtFoWl5ugdxmNmajwJqXfV1B2qLkeDMr7Jtl5FwmuOjUxMNa7XkH2XP7bk7
 M3xWMbvK6nQTQeV17QUWiLxmSBJVznwTwznztD09wYCAy/LaL9ZG5WW2Vxpagil3j7++z+WP1BT
 Wml4SoqEJQNaQMjETFkWnOQfQTgfxFcN6O1KxF7C8kmEfoyabOHOIUUAcrG4KtM2VDZeQkuqavK
 rFallfYz/j8kZ9Db3T3kWr8BEfHacEO46U9r6Qk50r5iVK9/UQp+WjLbxlSFo93d9Pr2CVcthzu
 g/XAK0bMrY43g51fRdhaouq9wf9seg9JkwnJ2ylxMDha7K1Pq9yU4NgPZs88up2oSqKq7uha7BY
 5NKUhzu+BwzPYvGFnAL1RHG81twShyR5IxD/vkVzLF7qo4Xmn+b
X-Received: by 2002:a05:600c:4f49:b0:493:cc25:9c0e with SMTP id
 5b1f17b1804b1-499727a205cmr5365615e9.14.1786355920387; 
 Mon, 10 Aug 2026 02:58:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:eb7f:37e4:e8c9:f32?
 ([2a01:e0a:106d:1080:eb7f:37e4:e8c9:f32])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995ea27ef0sm323981765e9.9.2026.08.10.02.58.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2026 02:58:39 -0700 (PDT)
Message-ID: <38df557d-cbe4-4db4-a300-d6af613ea68b@linaro.org>
Date: Mon, 10 Aug 2026 11:58:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/2] drm/panel: add Ilitek ILI7836A panel driver
To: webgeek1234@gmail.com, Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260808-ili7836a-v1-0-07a7becc5636@gmail.com>
 <20260808-ili7836a-v1-2-07a7becc5636@gmail.com>
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
In-Reply-To: <20260808-ili7836a-v1-2-07a7becc5636@gmail.com>
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

On 8/8/26 21:01, Aaron Kling via B4 Relay wrote:
> From: Aaron Kling <webgeek1234@gmail.com>
> 
> This is a DDIC which can be used in various panels. The first
> supported panel is the one used in the Retroid Pocket Nova.
> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>   drivers/gpu/drm/panel/Kconfig                 |  11 +
>   drivers/gpu/drm/panel/Makefile                |   1 +
>   drivers/gpu/drm/panel/panel-ilitek-ili7836a.c | 297 ++++++++++++++++++++++++++
>   3 files changed, 309 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index cbdf7b8f7f7af..792d6b92798d9 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -298,6 +298,17 @@ config DRM_PANEL_ILITEK_ILI7807S
>   
>   	  If M is selected the module will be called panel-ilitek-ili7807s.
>   
> +config DRM_PANEL_ILITEK_ILI7836A
> +	tristate "Ilitek ILI7836A-based panels"
> +	depends on OF
> +	depends on DRM_MIPI_DSI
> +	depends on BACKLIGHT_CLASS_DEVICE
> +	help
> +	  Say Y if you want to enable support for panels based on the
> +	  Ilitek ILI7836A DDIC.
> +
> +	  If M is selected the module will be called panel-ilitek-ili7836a.
> +
>   config DRM_PANEL_ILITEK_IL9322
>   	tristate "Ilitek ILI9322 320x240 QVGA panels"
>   	depends on OF && SPI
> diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
> index 3b523cf378330..be96f4e8112da 100644
> --- a/drivers/gpu/drm/panel/Makefile
> +++ b/drivers/gpu/drm/panel/Makefile
> @@ -29,6 +29,7 @@ obj-$(CONFIG_DRM_PANEL_HIMAX_HX83121A) += panel-himax-hx83121a.o
>   obj-$(CONFIG_DRM_PANEL_HIMAX_HX8394) += panel-himax-hx8394.o
>   obj-$(CONFIG_DRM_PANEL_HYDIS_HV101HD1) += panel-hydis-hv101hd1.o
>   obj-$(CONFIG_DRM_PANEL_ILITEK_ILI7807S) += panel-ilitek-ili7807s.o
> +obj-$(CONFIG_DRM_PANEL_ILITEK_ILI7836A) += panel-ilitek-ili7836a.o
>   obj-$(CONFIG_DRM_PANEL_ILITEK_IL9322) += panel-ilitek-ili9322.o
>   obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9341) += panel-ilitek-ili9341.o
>   obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9488) += panel-ilitek-ili9488.o
> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili7836a.c b/drivers/gpu/drm/panel/panel-ilitek-ili7836a.c
> new file mode 100644
> index 0000000000000..f6331129dadf2
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili7836a.c
> @@ -0,0 +1,297 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/backlight.h>
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <drm/drm_connector.h>
> +#include <drm/drm_crtc.h>
> +#include <drm/drm_mipi_dsi.h>
> +#include <drm/drm_modes.h>
> +#include <drm/drm_of.h>
> +#include <drm/drm_panel.h>
> +#include <drm/drm_probe_helper.h>
> +
> +#include <video/mipi_display.h>
> +
> +static const struct regulator_bulk_data ili7836a_supplies[] = {
> +	{ .supply = "vddio", },
> +	{ .supply = "avdd", },
> +};
> +
> +struct ili7836a_panel {
> +	struct drm_panel panel;
> +	struct drm_connector *connector;
> +	struct mipi_dsi_device *dsi;
> +	struct regulator_bulk_data *supplies;
> +	struct gpio_desc *reset_gpio;
> +	struct ili7836a_desc *desc;
> +	enum drm_panel_orientation orientation;
> +};
> +
> +struct ili7836a_desc {
> +	unsigned int width_mm;
> +	unsigned int height_mm;
> +	unsigned int bpc;
> +
> +	const struct drm_display_mode *modes;
> +	unsigned int num_modes;
> +};
> +
> +static inline struct ili7836a_panel *to_ili7836a_panel(struct drm_panel *panel)
> +{
> +	return container_of(panel, struct ili7836a_panel, panel);
> +}
> +
> +static void ili7836a_reset(struct ili7836a_panel *ctx)
> +{
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> +	msleep(20);
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> +	msleep(20);
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> +	msleep(20);
> +}
> +
> +static int ili7836a_on(struct ili7836a_panel *ctx)
> +{
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
> +
> +	ctx->dsi->mode_flags |= MIPI_DSI_MODE_LPM;
> +
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xff, 0x5a, 0xa5, 0x08);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc8, 0x62);
> +
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xff, 0x5a, 0xa5, 0x21);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xa4, 0x38);
> +
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xff, 0x5a, 0xa5, 0x23);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x85, 0x15);
> +
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xff, 0x5a, 0xa5, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x60, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6d, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x35);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x53, 0x20);
> +
> +	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> +	mipi_dsi_msleep(&dsi_ctx, 120);
> +
> +	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
> +	mipi_dsi_msleep(&dsi_ctx, 20);
> +
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xff, 0x5a, 0xa5, 0x22);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe1, 0x01);
> +
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xff, 0x5a, 0xa5, 0x00);
> +
> +	return dsi_ctx.accum_err;
> +}
> +
> +static int ili7836a_disable(struct drm_panel *panel)
> +{
> +	struct ili7836a_panel *ctx = to_ili7836a_panel(panel);
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
> +
> +	ctx->dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
> +
> +	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
> +	mipi_dsi_msleep(&dsi_ctx, 20);
> +	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
> +	mipi_dsi_msleep(&dsi_ctx, 120);
> +
> +	return dsi_ctx.accum_err;
> +}
> +
> +static int ili7836a_prepare(struct drm_panel *panel)
> +{
> +	struct ili7836a_panel *ctx = to_ili7836a_panel(panel);
> +	struct device *dev = &ctx->dsi->dev;
> +	int ret;
> +
> +	ret = regulator_bulk_enable(ARRAY_SIZE(ili7836a_supplies), ctx->supplies);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to enable regulators: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ili7836a_reset(ctx);
> +
> +	ret = ili7836a_on(ctx);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to initialize panel: %d\n", ret);
> +		gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> +		regulator_bulk_disable(ARRAY_SIZE(ili7836a_supplies), ctx->supplies);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ili7836a_unprepare(struct drm_panel *panel)
> +{
> +	struct ili7836a_panel *ctx = to_ili7836a_panel(panel);
> +
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> +	regulator_bulk_disable(ARRAY_SIZE(ili7836a_supplies), ctx->supplies);
> +
> +	return 0;
> +}
> +
> +static const struct drm_display_mode nova_modes[] = {
> +	{
> +		/* 120Hz */
> +		.clock = (1280 + 12 + 2 + 8) * (960 + 12 + 2 + 24) * 120 / 1000,
> +		.hdisplay = 1280,
> +		.hsync_start = 1280 + 12,
> +		.hsync_end = 1280 + 12 + 2,
> +		.htotal = 1280 + 12 + 2 + 8,
> +		.vdisplay = 960,
> +		.vsync_start = 960 + 12,
> +		.vsync_end = 960 + 12 + 2,
> +		.vtotal = 960 + 12 + 2 + 24,
> +	}
> +};
> +
> +static struct ili7836a_desc nova_desc = {
> +	.modes = nova_modes,
> +	.num_modes = ARRAY_SIZE(nova_modes),
> +	.width_mm = 91,
> +	.height_mm = 68,
> +	.bpc = 8,
> +};
> +
> +static int ili7836a_get_modes(struct drm_panel *panel,
> +					struct drm_connector *connector)
> +{
> +	struct ili7836a_panel *ctx = to_ili7836a_panel(panel);
> +
> +	return drm_connector_helper_get_modes_fixed(connector, ctx->desc->modes);
> +}
> +
> +static enum drm_panel_orientation ili7836a_get_orientation(struct drm_panel *panel)
> +{
> +	struct ili7836a_panel *ctx = to_ili7836a_panel(panel);
> +
> +	return ctx->orientation;
> +}
> +
> +static const struct drm_panel_funcs ili7836a_panel_funcs = {
> +	.prepare = ili7836a_prepare,
> +	.unprepare = ili7836a_unprepare,
> +	.disable = ili7836a_disable,
> +	.get_modes = ili7836a_get_modes,
> +	.get_orientation = ili7836a_get_orientation,
> +};
> +
> +static int ili7836a_bl_update_status(struct backlight_device *bl)
> +{
> +	struct mipi_dsi_device *dsi = bl_get_data(bl);
> +	u16 brightness = backlight_get_brightness(bl);
> +	int ret;
> +
> +	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
> +
> +	ret = mipi_dsi_dcs_set_display_brightness_large(dsi, brightness);
> +	if (ret < 0)
> +		return ret;
> +
> +	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
> +
> +	return 0;
> +}
> +
> +static const struct backlight_ops ili7836a_bl_ops = {
> +	.update_status = ili7836a_bl_update_status,
> +};
> +
> +static struct backlight_device *
> +ili7836a_create_backlight(struct mipi_dsi_device *dsi)
> +{
> +	struct device *dev = &dsi->dev;
> +	const struct backlight_properties props = {
> +		.type = BACKLIGHT_RAW,
> +		.brightness = 3445,
> +		.max_brightness = 3445,
> +	};
> +
> +	return devm_backlight_device_register(dev, dev_name(dev), dev, dsi,
> +					      &ili7836a_bl_ops, &props);
> +}
> +
> +static int ili7836a_probe(struct mipi_dsi_device *dsi)
> +{
> +	struct device *dev = &dsi->dev;
> +	struct ili7836a_panel *ctx;
> +	int ret;
> +
> +	ctx = devm_drm_panel_alloc(dev, __typeof(*ctx), panel,
> +				   &ili7836a_panel_funcs,
> +				   DRM_MODE_CONNECTOR_DSI);
> +	if (IS_ERR(ctx))
> +		return PTR_ERR(ctx);
> +
> +	ctx->desc = (struct ili7836a_desc *)of_device_get_match_data(dev);
> +	if (!ctx->desc)
> +		return -ENODEV;
> +
> +	ret = devm_regulator_bulk_get_const(dev,
> +					    ARRAY_SIZE(ili7836a_supplies),
> +					    ili7836a_supplies,
> +					    &ctx->supplies);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to get regulators\n");
> +
> +	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(ctx->reset_gpio))
> +		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
> +				     "Failed to get reset-gpios\n");
> +
> +	ret = drm_of_get_panel_orientation(dev->of_node, &ctx->orientation);
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
> +	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_HSE |
> +			  MIPI_DSI_MODE_NO_EOT_PACKET | MIPI_DSI_CLOCK_NON_CONTINUOUS;
> +
> +	ctx->panel.prepare_prev_first = true;
> +
> +	ctx->panel.backlight = ili7836a_create_backlight(dsi);
> +	if (IS_ERR(ctx->panel.backlight))
> +		return dev_err_probe(dev, PTR_ERR(ctx->panel.backlight),
> +				     "Failed to create backlight\n");
> +
> +	ret = devm_drm_panel_add(dev, &ctx->panel);
> +	if (ret)
> +		return ret;
> +
> +	return devm_mipi_dsi_attach(dev, dsi);
> +}
> +
> +static const struct of_device_id ili7836a_of_match[] = {
> +	{ .compatible = "retroidpocket,nova-panel", .data = &nova_desc },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, ili7836a_of_match);
> +
> +static struct mipi_dsi_driver ili7836a_driver = {
> +	.probe = ili7836a_probe,
> +	.driver = {
> +		.name = "panel-ili7836a-amoled",
> +		.of_match_table = ili7836a_of_match,
> +	},
> +};
> +module_mipi_dsi_driver(ili7836a_driver);
> +
> +MODULE_DESCRIPTION("DRM driver for ILI7836A DSI panels");
> +MODULE_LICENSE("GPL");
> 

Looks good

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
