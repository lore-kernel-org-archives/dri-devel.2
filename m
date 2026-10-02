Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6220DCA5FC4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 08:24:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF50310F7B1;
	Fri,  2 Oct 2026 08:24:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yGgnmrqv";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9449C10E523
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 08:24:16 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-4a09e2d0f7dso2037095e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 01:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790929455; x=1791534255; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RoKrNdlWy9juYVasaEtNVnqjN6ihunEAqFoJ9i8t7V8=;
 b=yGgnmrqv9nCFVXwU2LUpGjpmTVs/U4mvBSxRsIOZjehlZC14x0WQ7s+vBPxBC24pIZ
 W6iNsC8H1F7b63E5J4KfY0F+vi9ZJ3H2qJdGa/bcX+el/auBEtTqeZMrtGWRg7ZfTIth
 OY89t4BBBZRCF7tWAqYTV8XIrkQfC+Z2WJv1weTBxu3rRr0tqWXZFNS/sQaTJ8HGL6sA
 EaVmoiQJGylGJgneT8yId2PI4f7g9x6WPEgfdJywclFZxXZUrfUyhZnErnsI5qBN27fC
 2cnHL3NGEsOkfXJ+m51R4EmokacBTfpHqEOy4kxiULABENiwDANWECla6446klx/Vc/0
 DY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790929455; x=1791534255;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RoKrNdlWy9juYVasaEtNVnqjN6ihunEAqFoJ9i8t7V8=;
 b=nO4MsMbwgYzQPcdXrkDrOjGM6sch00/+h/NM3gHovWHSOwj73qSvyrurfTObt3/AOQ
 MQB63ZvLBMHIBZnRrliPdQlEPubJkdhL0Dk3SM91AT+9UagOvEf/2myuHn9VylAwGF4Z
 aRQsoBJzr5tiQWp0s6xK3j64cBql4uqOeisC3/tLXS+1qe8dguu01hFmMluSz0tEiqwc
 EvZ5kcouBAxKXPwLp15IoUjsKtogy1B9ixq4d+Rk6NciYuF4xamjhdsrDYediW/sDN71
 YgflbC6EIPNmohiD4padK6L4BnpMYwtddjEc5jDKIP2Nd1G1TSoEfsR+ejJpOE748I/g
 5aAw==
X-Gm-Message-State: AFuF++mYFomt+2o2Eu6JgNT3JhBP22fKAWfB3eQXa83HyuDgG1sWMzN3
 Bq5+ewGdNULDYlZ3aBn7KjfsuuMZ3MJnNRLUSzIRTiEIkoqPpOKttDgVcoea5k+uck8=
X-Gm-Gg: AYBFou3Br3ESCFDLbZcoqXk4YtzVAUSUKWK6AoxQlxEYigKCdIz8WRR9l9njOEomxpE
 IsHP40kVir1GNkfh0qJJAkuUXs3EuH/Q1za5oyX+a/WXGCurjQdaP1YpoLc1Nh+tM2QrFxIqKcC
 tM9XDmGkuSEVxGR2HEnVB0f1eTO8k3QJDSqOgniTqxxzmzIsbrssrQcoFIvw/eFkfczj4MK7CPr
 RD+kN1qCzKzOnXUk7vQVvGbLtdL/+vsLraKYzvaZYuPMC3VjnbwFsdkP1Rsa2ThHpmCRB1fX/w7
 nufT0ft1zJErgb3LE6IE2Xfei/cvHU/WJDM2b9JHa5kT/d0iS18Jo3OrwpApe+1DVqNGOUeUa0N
 cb3eoo2Fc3YMDm2bBAi2wa1Nd986Bwp/zXiuCKELOH74J0LnA9yLejoPT9tbBYbJzr1RqSLgUdK
 7ZrzXabsAs9D3ubHDYaqoQ+c5Ezy4RgkhzzXosTTXCk6WQHeeQdK8TzXG+9v2I2py61SfPiX+Ds
 d0Q3uqbpMdvxYzyYe0fllVGpreU7/B2lHAl5oJt+KoPSyCuVXAT
X-Received: by 2002:a05:600c:4e13:b0:49e:7a10:1b71 with SMTP id
 5b1f17b1804b1-4a02754304fmr39323625e9.11.1790929454874; 
 Fri, 02 Oct 2026 01:24:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:2f62:6d3:721b:8c9e?
 ([2a01:e0a:106d:1080:2f62:6d3:721b:8c9e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a030326132sm44946255e9.0.2026.10.02.01.24.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2026 01:24:14 -0700 (PDT)
Message-ID: <91192ea5-d96f-4fd1-98b8-7db4c46dd9b5@linaro.org>
Date: Fri, 2 Oct 2026 10:24:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 2/2] drm/panel: Add driver for Raydium RM69220 DDIC
To: Alexander Koskovich <akoskovich@pm.me>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261001-asteroids-panel-support-v4-2-fb228194ad91@pm.me>
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
In-Reply-To: <20261001-asteroids-panel-support-v4-2-fb228194ad91@pm.me>
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

On 10/2/26 03:51, Alexander Koskovich wrote:
> Add a panel driver for Raydium RM69220 DDIC based displays such as the
> BOE BF068MWM-TD0 found in the Nothing Phone (3a).
> 
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> ---
>   MAINTAINERS                                   |   1 +
>   drivers/gpu/drm/panel/Kconfig                 |  15 +
>   drivers/gpu/drm/panel/Makefile                |   1 +
>   drivers/gpu/drm/panel/panel-raydium-rm69220.c | 417 ++++++++++++++++++++++++++
>   4 files changed, 434 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6702142b117d..1e4d309e4792 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8587,6 +8587,7 @@ DRM DRIVER FOR RAYDIUM RM69220 PANELS
>   M:	Alexander Koskovich <akoskovich@pm.me>
>   S:	Maintained
>   F:	Documentation/devicetree/bindings/display/panel/raydium,rm69220.yaml
> +F:	drivers/gpu/drm/panel/panel-raydium-rm69220.c
>   
>   DRM DRIVER FOR SAMSUNG DB7430 PANELS
>   M:	Linus Walleij <linusw@kernel.org>
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index 53a1fc2913fe..61c047891f50 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -850,6 +850,21 @@ config DRM_PANEL_RAYDIUM_RM692E5
>   	  Say Y here if you want to enable support for Raydium RM692E5-based
>   	  display panels, such as the one found in the Fairphone 5 smartphone.
>   
> +config DRM_PANEL_RAYDIUM_RM69220
> +	tristate "Raydium RM69220-based DSI panel"
> +	depends on OF
> +	depends on DRM_MIPI_DSI
> +	depends on BACKLIGHT_CLASS_DEVICE
> +	select DRM_DISPLAY_DSC_HELPER
> +	select DRM_DISPLAY_HELPER
> +	help
> +	  Say Y here if you want to enable support for Raydium RM69220-based
> +	  display panels, such as the BOE BF068MWM-TD0 which can be found in
> +	  the Nothing Phone (3a).
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called panel-raydium-rm69220.
> +
>   config DRM_PANEL_RAYDIUM_RM69380
>   	tristate "Raydium RM69380-based DSI panel"
>   	depends on GPIOLIB
> diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
> index f2c9c80a218f..00c06d956e8b 100644
> --- a/drivers/gpu/drm/panel/Makefile
> +++ b/drivers/gpu/drm/panel/Makefile
> @@ -83,6 +83,7 @@ obj-$(CONFIG_DRM_PANEL_RAYDIUM_RM67191) += panel-raydium-rm67191.o
>   obj-$(CONFIG_DRM_PANEL_RAYDIUM_RM67200) += panel-raydium-rm67200.o
>   obj-$(CONFIG_DRM_PANEL_RAYDIUM_RM68200) += panel-raydium-rm68200.o
>   obj-$(CONFIG_DRM_PANEL_RAYDIUM_RM692E5) += panel-raydium-rm692e5.o
> +obj-$(CONFIG_DRM_PANEL_RAYDIUM_RM69220) += panel-raydium-rm69220.o
>   obj-$(CONFIG_DRM_PANEL_RAYDIUM_RM69380) += panel-raydium-rm69380.o
>   obj-$(CONFIG_DRM_PANEL_RENESAS_R61307) += panel-renesas-r61307.o
>   obj-$(CONFIG_DRM_PANEL_RENESAS_R63419) += panel-renesas-r63419.o
> diff --git a/drivers/gpu/drm/panel/panel-raydium-rm69220.c b/drivers/gpu/drm/panel/panel-raydium-rm69220.c
> new file mode 100644
> index 000000000000..3030f8b89760
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-raydium-rm69220.c
> @@ -0,0 +1,417 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Generated with linux-mdss-dsi-panel-driver-generator from vendor device tree.
> + * Copyright (c) 2026 Alexander Koskovich <akoskovich@pm.me>
> + */
> +
> +#include <linux/backlight.h>
> +#include <linux/delay.h>
> +#include <linux/device-id/of.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <video/mipi_display.h>
> +
> +#include <drm/display/drm_dsc.h>
> +#include <drm/display/drm_dsc_helper.h>
> +#include <drm/drm_mipi_dsi.h>
> +#include <drm/drm_modes.h>
> +#include <drm/drm_panel.h>
> +#include <drm/drm_probe_helper.h>
> +
> +struct raydium_rm69220 {
> +	struct drm_panel panel;
> +	struct mipi_dsi_device *dsi;
> +	struct drm_dsc_config dsc;
> +	struct regulator_bulk_data *supplies;
> +	struct gpio_desc *reset_gpio;
> +};
> +
> +static const struct regulator_bulk_data raydium_rm69220_supplies[] = {
> +	{ .supply = "vddio" },
> +	{ .supply = "dvdd" },
> +	{ .supply = "vci" },
> +};
> +
> +static inline
> +struct raydium_rm69220 *to_raydium_rm69220(struct drm_panel *panel)
> +{
> +	return container_of(panel, struct raydium_rm69220, panel);
> +}
> +
> +static void raydium_rm69220_reset(struct raydium_rm69220 *ctx)
> +{
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> +	usleep_range(1000, 2000);
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> +	usleep_range(1000, 2000);
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> +	msleep(32);
> +}
> +
> +static int raydium_rm69220_on(struct raydium_rm69220 *ctx)
> +{
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
> +
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfe, 0x76);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x9a, 0x10);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x9b, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfe, 0x77);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x9a, 0x10);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x9b, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfe, 0x78);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x9a, 0x10);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x9b, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfe, 0x79);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x9a, 0xf0);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x9b, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfe, 0x74);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1a, 0xe0);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1b, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfe, 0x40);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xa9, 0x68);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xab, 0x22);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfe, 0x40);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc0, 0xa6);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xbf, 0x87);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfe, 0x82);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x90);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfe, 0xd4);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x61, 0x08);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xa2, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfe, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfa, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfe, 0xd2);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x97, 0x08);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x36, 0x11);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x39, 0xab);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3a, 0x30);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3b, 0x80);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3d, 0x09);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3f, 0x58);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x40, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x41, 0x38);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x42, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x43, 0x0d);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x44, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x45, 0x1c);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x46, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x47, 0x1c);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x48, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x49, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4a, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4b, 0x0e);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4d, 0x20);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4e, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4f, 0x39);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x50, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x51, 0x07);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x53, 0x0c);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x54, 0x08);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x55, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x56, 0x07);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x58, 0xd3);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x59, 0x18);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5a, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5b, 0x10);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5c, 0xf0);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5d, 0x07);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5e, 0x10);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5f, 0x20);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x60, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x61, 0x06);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x62, 0x0f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x63, 0x0f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x64, 0x33);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x65, 0x0e);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x66, 0x1c);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x67, 0x2a);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x68, 0x38);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x69, 0x46);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6a, 0x54);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6b, 0x62);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6c, 0x69);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6d, 0x70);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6e, 0x77);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x79);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x70, 0x7b);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x71, 0x7d);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x72, 0x7e);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x73, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x74, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0x22);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x76, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x77, 0x2a);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x78, 0x40);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x79, 0x2a);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7a, 0xbe);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7b, 0x3a);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7c, 0xfc);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7d, 0x3a);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7e, 0xfa);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7f, 0x3a);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x80, 0xf8);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x81, 0x3b);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x82, 0x38);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x83, 0x3b);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x84, 0x78);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x85, 0x3b);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x86, 0xb6);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x87, 0x4b);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x88, 0xf6);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x89, 0x4c);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x8a, 0x34);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x8b, 0x4c);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x8c, 0x74);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x8d, 0x5c);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x8e, 0x74);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x8f, 0x8c);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x90, 0xf4);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x91, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x92, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x93, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x94, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x95, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x96, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfe, 0xa0);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x66, 0x06);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfe, 0x49);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x87, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3f, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfe, 0xa0);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x04, 0x07);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4b, 0x40);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4d, 0x40);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfe, 0xa1);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x58, 0x67);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0xa7);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfe, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2f, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfe, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfa, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc1, 0x03);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc2, 0x03);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x35, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x51, 0x0d, 0xbb);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfe, 0x00);
> +	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> +	mipi_dsi_msleep(&dsi_ctx, 80);
> +	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
> +	mipi_dsi_usleep_range(&dsi_ctx, 10000, 11000);
> +
> +	return dsi_ctx.accum_err;
> +}
> +
> +static int raydium_rm69220_off(struct raydium_rm69220 *ctx)
> +{
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
> +
> +	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
> +	mipi_dsi_msleep(&dsi_ctx, 100);
> +	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
> +	mipi_dsi_msleep(&dsi_ctx, 100);
> +
> +	return dsi_ctx.accum_err;
> +}
> +
> +static int raydium_rm69220_prepare(struct drm_panel *panel)
> +{
> +	struct raydium_rm69220 *ctx = to_raydium_rm69220(panel);
> +	struct device *dev = &ctx->dsi->dev;
> +	struct drm_dsc_picture_parameter_set pps;
> +	int ret;
> +
> +	ret = regulator_bulk_enable(ARRAY_SIZE(raydium_rm69220_supplies), ctx->supplies);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to enable regulators: %d\n", ret);
> +		return ret;
> +	}
> +
> +	raydium_rm69220_reset(ctx);
> +
> +	ret = raydium_rm69220_on(ctx);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to initialize panel: %d\n", ret);
> +		goto err;
> +	}
> +
> +	drm_dsc_pps_payload_pack(&pps, &ctx->dsc);
> +
> +	ret = mipi_dsi_picture_parameter_set(ctx->dsi, &pps);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to transmit PPS: %d\n", ret);
> +		goto err;
> +	}
> +
> +	ret = mipi_dsi_compression_mode(ctx->dsi, true);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to enable compression mode: %d\n", ret);
> +		goto err;
> +	}
> +
> +	msleep(28);
> +
> +	return 0;
> +
> +err:
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> +	regulator_bulk_disable(ARRAY_SIZE(raydium_rm69220_supplies), ctx->supplies);
> +	return ret;
> +}
> +
> +static int raydium_rm69220_unprepare(struct drm_panel *panel)
> +{
> +	struct raydium_rm69220 *ctx = to_raydium_rm69220(panel);
> +	struct device *dev = &ctx->dsi->dev;
> +	int ret;
> +
> +	ret = raydium_rm69220_off(ctx);
> +	if (ret < 0)
> +		dev_err(dev, "Failed to un-initialize panel: %d\n", ret);
> +
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> +	regulator_bulk_disable(ARRAY_SIZE(raydium_rm69220_supplies), ctx->supplies);
> +
> +	return 0;
> +}
> +
> +static const struct drm_display_mode raydium_rm69220_mode = {
> +	.clock = (1080 + 36 + 4 + 36) * (2392 + 72 + 4 + 52) * 120 / 1000,
> +	.hdisplay = 1080,
> +	.hsync_start = 1080 + 36,
> +	.hsync_end = 1080 + 36 + 4,
> +	.htotal = 1080 + 36 + 4 + 36,
> +	.vdisplay = 2392,
> +	.vsync_start = 2392 + 72,
> +	.vsync_end = 2392 + 72 + 4,
> +	.vtotal = 2392 + 72 + 4 + 52,
> +	.width_mm = 71,
> +	.height_mm = 157,
> +	.type = DRM_MODE_TYPE_DRIVER,
> +};
> +
> +static int raydium_rm69220_get_modes(struct drm_panel *panel,
> +					    struct drm_connector *connector)
> +{
> +	return drm_connector_helper_get_modes_fixed(connector, &raydium_rm69220_mode);
> +}
> +
> +static const struct drm_panel_funcs raydium_rm69220_panel_funcs = {
> +	.prepare = raydium_rm69220_prepare,
> +	.unprepare = raydium_rm69220_unprepare,
> +	.get_modes = raydium_rm69220_get_modes,
> +};
> +
> +static int raydium_rm69220_bl_update_status(struct backlight_device *bl)
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
> +static const struct backlight_ops raydium_rm69220_bl_ops = {
> +	.update_status = raydium_rm69220_bl_update_status,
> +};
> +
> +static struct backlight_device *
> +raydium_rm69220_create_backlight(struct mipi_dsi_device *dsi)
> +{
> +	struct device *dev = &dsi->dev;
> +	const struct backlight_properties props = {
> +		.type = BACKLIGHT_RAW,
> +		.brightness = 2946,
> +		.max_brightness = 3442, /* 4095 is HBM max */
> +	};
> +
> +	return devm_backlight_device_register(dev, dev_name(dev), dev, dsi,
> +					      &raydium_rm69220_bl_ops, &props);
> +}
> +
> +static int raydium_rm69220_probe(struct mipi_dsi_device *dsi)
> +{
> +	struct device *dev = &dsi->dev;
> +	struct raydium_rm69220 *ctx;
> +	int ret;
> +
> +	ctx = devm_drm_panel_alloc(dev, struct raydium_rm69220, panel,
> +				   &raydium_rm69220_panel_funcs,
> +				   DRM_MODE_CONNECTOR_DSI);
> +	if (IS_ERR(ctx))
> +		return PTR_ERR(ctx);
> +
> +	ret = devm_regulator_bulk_get_const(dev,
> +					    ARRAY_SIZE(raydium_rm69220_supplies),
> +					    raydium_rm69220_supplies,
> +					    &ctx->supplies);
> +	if (ret < 0)
> +		return ret;
> +
> +	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(ctx->reset_gpio))
> +		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
> +				     "Failed to get reset-gpios\n");
> +
> +	ctx->dsi = dsi;
> +
> +	dsi->lanes = 4;
> +	dsi->format = MIPI_DSI_FMT_RGB101010;
> +	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_NO_EOT_PACKET |
> +			  MIPI_DSI_CLOCK_NON_CONTINUOUS | MIPI_DSI_MODE_LPM |
> +			  MIPI_DSI_MODE_DSC_ALL_SLICES_IN_PKT;
> +
> +	ctx->panel.prepare_prev_first = true;
> +
> +	ctx->panel.backlight = raydium_rm69220_create_backlight(dsi);
> +	if (IS_ERR(ctx->panel.backlight))
> +		return dev_err_probe(dev, PTR_ERR(ctx->panel.backlight),
> +				     "Failed to create backlight\n");
> +
> +	ret = devm_drm_panel_add(dev, &ctx->panel);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* This panel only supports DSC; unconditionally enable it */
> +	dsi->dsc = &ctx->dsc;
> +
> +	ctx->dsc.dsc_version_major = 1;
> +	ctx->dsc.dsc_version_minor = 1;
> +	ctx->dsc.slice_height = 13;
> +	ctx->dsc.slice_width = 540;
> +
> +	ctx->dsc.slice_count = 1080 / ctx->dsc.slice_width;
> +	ctx->dsc.bits_per_component = 10;
> +	ctx->dsc.bits_per_pixel = 8 << 4; /* 4 fractional bits */
> +	ctx->dsc.block_pred_enable = true;
> +
> +	return devm_mipi_dsi_attach(dev, dsi);
> +}
> +
> +static const struct of_device_id raydium_rm69220_of_match[] = {
> +	{ .compatible = "boe,bf068mwm-td0" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, raydium_rm69220_of_match);
> +
> +static struct mipi_dsi_driver raydium_rm69220_driver = {
> +	.probe = raydium_rm69220_probe,
> +	.driver = {
> +		.name = "panel-raydium-rm69220",
> +		.of_match_table = raydium_rm69220_of_match,
> +	},
> +};
> +module_mipi_dsi_driver(raydium_rm69220_driver);
> +
> +MODULE_AUTHOR("Alexander Koskovich <akoskovich@pm.me>");
> +MODULE_DESCRIPTION("DRM driver for RM69220-equipped DSI panels");
> +MODULE_LICENSE("GPL");
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
