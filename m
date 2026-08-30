Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC060C61DD9
	for <dri-devel@archiver.kernel.org>; Sun, 30 Aug 2026 13:01:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 855B910E156;
	Sun, 30 Aug 2026 13:01:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OLzhl6RR";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3381D10E156
 for <dri-devel@lists.freedesktop.org>; Sun, 30 Aug 2026 13:01:04 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-49b0dd3c9a0so18432445e9.1
 for <dri-devel@lists.freedesktop.org>; Sun, 30 Aug 2026 06:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788094862; x=1788699662; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YhL1ly3YIRNDPzvkjY6WMFNYE0jQiecIsvA8t9J5bag=;
 b=OLzhl6RRfw8smLpW+eTruE+tBei5kxZ9FrHaCMENwV3kBCct40V/Aw+pNJBKux1IgZ
 KCIJnc7PjSJR9UGemIu+8I7qSHo0s843YJdUxNP3KkBXVsl5t11XazyPubTmtM71aR0w
 bJAfYA4cGMavadf756wDVI5FDjWH6pzD55N86WzPCpzJ7TpxT/6JwtE5qMXaf2AW4NHW
 +xhaYaISmW+gQdW+wakuziMPLWxfsp7I/2Nb1eLB2U0ExSZOPS9s3Rm1/CMewPbLcpDo
 QWd1Xq/S0wvjLaXYxT7UDP2QBrg/oREMZ39Im9HJctPpD4V7+IukdKewKNmAIhhH77A+
 VBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788094862; x=1788699662;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YhL1ly3YIRNDPzvkjY6WMFNYE0jQiecIsvA8t9J5bag=;
 b=tD7iXydgDc0/YLXXC3i1fUfQgw3AGphHKAS/Z4jFZ9ZD0vnXLTetSbRwVRUc5YSORH
 51KST4Fs9N2hzbIaEpGIvqXCSmRiTIAi+GHp9ZEKGnKdssZl79/nWx+5i85jpstjp8CR
 y8XJ2Z2Kewn7QpSKpwZ30Ygo5ikkCA2WSIWB0+qYkHaYzpc1T4eZXw5cPqKCK5fwYd8E
 ZQal1sDvT6Tu7tDTmsMOpcd2Wah/qj3U7lgvVbiaZQfI7X8Zi0mVUDJPCZR+6yT8H71W
 2799OjgJXvACaAPGuMA2Q0j7Vv9N/Uf8tqzm/BEA2xT4ZaA7Bru655zkbVbVw3j8FJ4E
 jpSg==
X-Gm-Message-State: AFuF++lTuuWG5dHZQPcdISXZqeNfwARqcEnK28X/IJQ8XxL9LQKF4Ufh
 PY4bm+dFKJfoCPB4783oOCRpuXWomdkI9rGfKgqD8//BH9txlSXfeI6fKBwZpSLWBrw=
X-Gm-Gg: AR+sD13rWERPA70N4krjeO7tz9/GGLqPAamQ6KPDJY2bDcU/3FP9BSoyOb7wuRhf1p2
 8zmPifwy5degXoj7/54eKy/+yXM7pB6S3xRXMOk4qTdxRXLT5meDA2MWQeAvIuBj8/PBgFnaqQh
 s4Dtzrc/3itm8EsyjgYExM4hKAHq4n5zzwGaa0bNjHlq994P0bSS1r8xKYa5IueoisW1nKINc9O
 rLk67nmZijtVNUHYgAr7AGgX2YTKpqOwHNuZevcvyK5Mj4z/HF8FdmFTDyHNgaVODrKAmfoFJW3
 j8leHApw+LrTSgEnKbxwXmaIGknG4YSVImJR9XLAr6CpPS7ZO5A11SpHkfivdi6oGEr/36t7kn2
 u5oMGrfTq2US20YI2/FQSXx6kq80QKUccUW4pWnscO4I3oiADmoaC08uLrAEO6/aRMdHkOLt6ib
 aFpOAQGDxFLAgHo0oWyinwf8KHHNzwZV8aGJ4AkG9GNzwQOFXCRAmzu9F3oaxuiHVbfx2A/5uig
 06O8+KnBA==
X-Received: by 2002:a05:600c:1f8f:b0:499:b65d:1250 with SMTP id
 5b1f17b1804b1-49b91c1fc4bmr252799325e9.2.1788094862103; 
 Sun, 30 Aug 2026 06:01:02 -0700 (PDT)
Received: from [192.168.1.36] ([83.214.235.72])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ccea87e1asm81979695e9.2.2026.08.30.06.01.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Aug 2026 06:01:01 -0700 (PDT)
Message-ID: <31246adf-4878-4059-a1e9-a13e112048db@linaro.org>
Date: Sun, 30 Aug 2026 14:58:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RFC 2/2] drivers: gpu: drm: panel: Add BOE NT51021 driver
To: Nickolay Goppen <setotau@mainlining.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexey Minnekhanov <alexeymin@minlexx.ru>
References: <20260829-qcom-novatek-nt51021-panels-v1-0-cc1ca61bd261@mainlining.org>
 <20260829-qcom-novatek-nt51021-panels-v1-2-cc1ca61bd261@mainlining.org>
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
In-Reply-To: <20260829-qcom-novatek-nt51021-panels-v1-2-cc1ca61bd261@mainlining.org>
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

Hi,

On 8/29/26 22:09, Nickolay Goppen wrote:
> Add driver for BOE NT51021-based 8-inch and 10-inch DSI video mode
> panels used in Xiaomi Mi Pad 4 and Mi Pad 4 Plus (xiaomi-clover)
> tablets.
> 
> NT51021-based panels also support content-adaptive brightness control by
> generating a PWM signal for backlight driver IC. Content adaptation
> means that content grey level scale can be increased while
> simultaneously decreasing brightness of the backlight to achieve
> same perceived brightness. This makes the power consumption of
> backlight be reduced with keeping acceptable display quality.
> 
> Both panels are very similar, differences are only in init sequence
> and resolution.
> 
> Co-developed-by: Alexey Minnekhanov <alexeymin@minlexx.ru>
> Signed-off-by: Alexey Minnekhanov <alexeymin@minlexx.ru>
> Signed-off-by: Nickolay Goppen <setotau@mainlining.org>
> ---
>   MAINTAINERS                                   |   1 +
>   drivers/gpu/drm/panel/Kconfig                 |   9 +
>   drivers/gpu/drm/panel/Makefile                |   1 +
>   drivers/gpu/drm/panel/panel-novatek-nt51021.c | 804 ++++++++++++++++++++++++++
>   4 files changed, 815 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6cbf9ee3fa9b..3e2e6b94e6ed 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8358,6 +8358,7 @@ DRM DRIVER FOR NOVATEK NT51021 PANELS
>   M:	Nickolay Goppen <setotau@mainlining.org>
>   S:	Maintained
>   F:	Documentation/devicetree/bindings/display/panel/novatek,nt51021.yaml
> +F:	drivers/gpu/drm/panel/panel-novatek-nt51021.c
>   
>   DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS
>   M:	Lyude Paul <lyude@redhat.com>
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index cbdf7b8f7f7a..b7c11990b46f 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -727,6 +727,15 @@ config DRM_PANEL_NOVATEK_NT39016
>   	  Say Y here if you want to enable support for the panels built
>   	  around the Novatek NT39016 display controller.
>   
> +config DRM_PANEL_NOVATEK_NT51021
> +	tristate "Novatek NT51021 DSI panel"
> +	depends on OF
> +	depends on DRM_MIPI_DSI
> +	depends on BACKLIGHT_CLASS_DEVICE
> +	help
> +	  Say Y here if you want to enable support for the panels built
> +	  around the Novatek NT51021 Display controller.
> +
>   config DRM_PANEL_OLIMEX_LCD_OLINUXINO
>   	tristate "Olimex LCD-OLinuXino panel"
>   	depends on OF
> diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
> index 3b523cf37833..3fe7c2e579d3 100644
> --- a/drivers/gpu/drm/panel/Makefile
> +++ b/drivers/gpu/drm/panel/Makefile
> @@ -70,6 +70,7 @@ obj-$(CONFIG_DRM_PANEL_NOVATEK_NT36672E) += panel-novatek-nt36672e.o
>   obj-$(CONFIG_DRM_PANEL_NOVATEK_NT37700F) += panel-novatek-nt37700f.o
>   obj-$(CONFIG_DRM_PANEL_NOVATEK_NT37801) += panel-novatek-nt37801.o
>   obj-$(CONFIG_DRM_PANEL_NOVATEK_NT39016) += panel-novatek-nt39016.o
> +obj-$(CONFIG_DRM_PANEL_NOVATEK_NT51021) += panel-novatek-nt51021.o
>   obj-$(CONFIG_DRM_PANEL_MANTIX_MLAF057WE51) += panel-mantix-mlaf057we51.o
>   obj-$(CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO) += panel-olimex-lcd-olinuxino.o
>   obj-$(CONFIG_DRM_PANEL_ORISETECH_OTA5601A) += panel-orisetech-ota5601a.o
> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt51021.c b/drivers/gpu/drm/panel/panel-novatek-nt51021.c
> new file mode 100644
> index 000000000000..12778ea32ebd
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt51021.c
> @@ -0,0 +1,804 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright (c) 2025, Nickolay Goppen <setotau@mainlining.org>
> +// Copyright (c) 2024, Alexey Minnekhanov <alexeymin@minlexx.ru>
> +
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <drm/drm_mipi_dsi.h>
> +#include <drm/drm_modes.h>
> +#include <drm/drm_panel.h>
> +#include <drm/drm_probe_helper.h>
> +
> +struct boe_nt51021_desc;
> +
> +struct boe_nt51021_variant {
> +	int (*init)(struct boe_nt51021_desc *ctx);
> +
> +	const struct drm_display_mode *display_mode;
> +};
> +
> +struct boe_nt51021_desc {

Why do you use the boe prefix here ? BOE is the panel vendor,
NT51021 is the DDIC so either you use "novatek_nt51021" or just "nt51021".

> +	struct drm_panel panel;
> +	struct mipi_dsi_device *dsi;
> +	struct regulator_bulk_data *supplies;
> +	struct gpio_desc *reset_gpio;
> +
> +	const struct boe_nt51021_variant *variant;
> +};
> +
> +static const struct regulator_bulk_data nt51021_boe_supplies[] = {
> +	{ .supply = "vdd" },
> +	{ .supply = "avdd" },
> +	{ .supply = "havdd" },
> +};
> +
> +static inline struct boe_nt51021_desc *to_boe_panel(struct drm_panel *panel)
> +{
> +	return container_of_const(panel, struct boe_nt51021_desc, panel);
> +}
> +
> +static void nt51021_boe_reset(struct boe_nt51021_desc *ctx)
> +{
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> +	usleep_range(10000, 11000);
> +}
> +
> +static void nt51021_cabc_on(struct mipi_dsi_multi_context *dsi_ctx)
> +{
> +	if (dsi_ctx->accum_err)
> +		return;
> +
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x8f, 0x00);
> +	mipi_dsi_usleep_range(dsi_ctx, 1000, 2000);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x8f, 0xa5);
> +	mipi_dsi_usleep_range(dsi_ctx, 1000, 2000);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x83, 0xbb);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x84, 0x22);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x90, 0x40);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x8f, 0x00);
> +	mipi_dsi_usleep_range(dsi_ctx, 1000, 2000);
> +}
> +
> +static void nt51021_cabc_off(struct mipi_dsi_multi_context *dsi_ctx)
> +{
> +	if (dsi_ctx->accum_err)
> +		return;
> +
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x8f, 0xa5);
> +	mipi_dsi_usleep_range(dsi_ctx, 1000, 2000);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x83, 0xbb);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x84, 0x22);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x90, 0xc0);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x8f, 0x00);
> +	mipi_dsi_usleep_range(dsi_ctx, 1000, 2000);
> +}
> +
> +static int nt51021_boe_8_init(struct boe_nt51021_desc *ctx)
> +{
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
> +
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x8f, 0xa5);
> +	mipi_dsi_usleep_range(&dsi_ctx, 1000, 2000);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x01, 0x00);
> +	mipi_dsi_msleep(&dsi_ctx, 20);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x8f, 0xa5);
> +	mipi_dsi_usleep_range(&dsi_ctx, 1000, 2000);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x83, 0x00);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x84, 0x00);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x8c, 0x8e);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xcd, 0x6c);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc0, 0x8b);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc8, 0xf0);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x8b, 0x10);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xa9, 0x20);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x97, 0x00);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xfa, 0x15);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xfd, 0x1b);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x83, 0xaa);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x84, 0x11);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xa9, 0x4b);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x85, 0x04);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x86, 0x08);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x98, 0xc1);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x83, 0xaa);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x84, 0x11);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc0, 0x05);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc1, 0x0c);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc2, 0x22);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc3, 0x34);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc4, 0x44);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc5, 0x52);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc6, 0x5d);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc7, 0x66);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc8, 0x70);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc9, 0x00);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xca, 0x11);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xcb, 0x3b);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xcc, 0x53);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xcd, 0x69);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xce, 0x6a);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xcf, 0x6c);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd0, 0x6b);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd1, 0x75);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd2, 0x83);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd3, 0x99);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd4, 0x9a);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd5, 0xd0);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd6, 0xd6);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd7, 0xdb);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd8, 0xe1);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd9, 0xe7);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xda, 0xed);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xdb, 0xf4);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xdc, 0xfb);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xdd, 0xff);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xde, 0xff);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xdf, 0x0f);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe0, 0x15);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe1, 0x1c);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe2, 0x32);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe3, 0x44);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe4, 0x52);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe5, 0x60);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe6, 0x6b);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe7, 0x74);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe8, 0x7e);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe9, 0x14);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xea, 0x25);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xeb, 0x4d);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xec, 0x63);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xed, 0x71);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xee, 0x6a);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xef, 0x6c);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf0, 0x6b);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf1, 0x75);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf2, 0x83);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf3, 0x99);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf4, 0x9a);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf5, 0xd0);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf6, 0xd6);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf7, 0xdb);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf8, 0xe1);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf9, 0xe7);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xfa, 0xed);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xfb, 0xf4);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xfc, 0xfb);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xfd, 0xff);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xfe, 0xff);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xff, 0x0f);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x83, 0xbb);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x84, 0x22);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xa1, 0xff);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xa2, 0xfe);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xa3, 0xfa);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xa4, 0xf7);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xa5, 0xf3);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xa6, 0xf1);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xa7, 0xed);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xa8, 0xeb);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xa9, 0xe9);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xaa, 0xe6);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xaf, 0x00);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb0, 0x35);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb1, 0x89);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb2, 0x99);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb3, 0x99);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb4, 0x0d);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb5, 0x1a);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb6, 0x16);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x9a, 0x10);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x9b, 0x00);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x96, 0xe6);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x99, 0x06);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc0, 0x05);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc1, 0x0c);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc2, 0x22);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc3, 0x34);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc4, 0x44);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc5, 0x52);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc6, 0x5d);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc7, 0x66);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc8, 0x70);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc9, 0x00);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xca, 0x11);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xcb, 0x3b);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xcc, 0x53);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xcd, 0x69);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xce, 0x6a);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xcf, 0x6c);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd0, 0x6b);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd1, 0x75);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd2, 0x83);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd3, 0x99);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd4, 0x9a);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd5, 0xd0);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd6, 0xd6);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd7, 0xdb);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd8, 0xe1);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd9, 0xe7);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xda, 0xed);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xdb, 0xf4);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xdc, 0xfb);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xdd, 0xff);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xde, 0xff);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xdf, 0x0f);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe0, 0x15);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe1, 0x1c);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe2, 0x32);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe3, 0x44);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe4, 0x52);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe5, 0x60);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe6, 0x6b);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe7, 0x74);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe8, 0x7e);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe9, 0x14);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xea, 0x25);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xeb, 0x4d);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xec, 0x63);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xed, 0x71);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xee, 0x6a);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xef, 0x6c);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf0, 0x6b);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf1, 0x75);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf2, 0x83);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf3, 0x99);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf4, 0x9a);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf5, 0xd0);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf6, 0xd6);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf7, 0xdb);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf8, 0xe1);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf9, 0xe7);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xfa, 0xed);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xfb, 0xf4);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xfc, 0xfb);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xfd, 0xff);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xfe, 0xff);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xff, 0x0f);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x83, 0xcc);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x84, 0x33);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc0, 0x05);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc1, 0x0c);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc2, 0x22);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc3, 0x34);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc4, 0x44);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc5, 0x52);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc6, 0x5d);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc7, 0x66);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc8, 0x70);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc9, 0x00);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xca, 0x11);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xcb, 0x3b);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xcc, 0x53);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xcd, 0x69);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xce, 0x6a);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xcf, 0x6c);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd0, 0x6b);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd1, 0x75);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd2, 0x83);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd3, 0x99);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd4, 0x9a);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd5, 0xd0);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd6, 0xd6);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd7, 0xdb);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd8, 0xe1);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd9, 0xe7);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xda, 0xed);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xdb, 0xf4);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xdc, 0xfb);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xdd, 0xff);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xde, 0xff);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xdf, 0x0f);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe0, 0x15);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe1, 0x1c);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe2, 0x32);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe3, 0x44);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe4, 0x52);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe5, 0x60);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe6, 0x6b);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe7, 0x74);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe8, 0x7e);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe9, 0x14);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xea, 0x25);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xeb, 0x4d);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xec, 0x63);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xed, 0x71);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xee, 0x6a);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xef, 0x6c);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf0, 0x6b);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf1, 0x75);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf2, 0x83);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf3, 0x99);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf4, 0x9a);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf5, 0xd0);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf6, 0xd6);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf7, 0xdb);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf8, 0xe1);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf9, 0xe7);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xfa, 0xed);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xfb, 0xf4);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xfc, 0xfb);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xfd, 0xff);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xfe, 0xff);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xff, 0x0f);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x83, 0x00);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x84, 0x00);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x9f, 0xff);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x83, 0xbb);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x84, 0x22);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x94, 0xba);
> +	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> +	mipi_dsi_usleep_range(&dsi_ctx, 5000, 6000);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x8f, 0x00);
> +	mipi_dsi_usleep_range(&dsi_ctx, 1000, 2000);
> +
> +	nt51021_cabc_on(&dsi_ctx);
> +
> +	return dsi_ctx.accum_err;
> +}
> +
> +static int nt51021_boe_10wu_init(struct boe_nt51021_desc *ctx)
> +{
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
> +
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x8f, 0xa5);
> +	mipi_dsi_usleep_range(&dsi_ctx, 1000, 2000);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x01, 0x00);
> +	mipi_dsi_msleep(&dsi_ctx, 20);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x8f, 0xa5);
> +	mipi_dsi_usleep_range(&dsi_ctx, 1000, 2000);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x83, 0x00);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x84, 0x00);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x8c, 0x8e);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xfa, 0x12);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xfd, 0x1b);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xcd, 0x6c);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc8, 0xfc);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x97, 0x00);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x8b, 0x10);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xa9, 0x20);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x83, 0xaa);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x84, 0x11);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xa9, 0x4b);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x85, 0x04);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x86, 0x08);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x98, 0xc1);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x9c, 0x10);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x83, 0xaa);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x84, 0x11);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc0, 0x0e);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc1, 0x11);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc2, 0x1f);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc3, 0x30);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc4, 0x3f);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc5, 0x4b);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc6, 0x55);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc7, 0x5d);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc8, 0x68);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc9, 0xe3);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xca, 0xea);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xcb, 0x01);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xcc, 0x0a);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xcd, 0x0a);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xce, 0x07);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xcf, 0x08);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd0, 0x09);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd1, 0x1d);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd2, 0x31);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd3, 0x52);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd4, 0x5b);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd5, 0xb6);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd6, 0xbd);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd7, 0xc5);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd8, 0xcd);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd9, 0xd6);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xda, 0xe0);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xdb, 0xeb);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xdc, 0xf8);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xdd, 0xff);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xde, 0xfc);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xdf, 0x0f);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe0, 0x0e);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe1, 0x11);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe2, 0x1f);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe3, 0x30);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe4, 0x3f);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe5, 0x4b);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe6, 0x55);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe7, 0x5d);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe8, 0x68);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe9, 0xe3);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xea, 0xea);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xeb, 0x01);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xec, 0x0a);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xed, 0x0a);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xee, 0x07);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xef, 0x08);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf0, 0x09);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf1, 0x1d);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf2, 0x31);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf3, 0x52);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf4, 0x5b);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf5, 0xb6);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf6, 0xbd);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf7, 0xc5);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf8, 0xcd);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf9, 0xd6);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xfa, 0xe0);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xfb, 0xeb);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xfc, 0xf8);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xfd, 0xff);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xfe, 0xfc);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xff, 0x0f);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x83, 0xbb);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x84, 0x22);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xa1, 0xff);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xa2, 0xfe);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xa3, 0xfa);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xa4, 0xf7);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xa5, 0xf3);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xa6, 0xf1);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xa7, 0xed);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xa8, 0xeb);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xa9, 0xe9);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xaa, 0xe6);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xaf, 0x00);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb0, 0x12);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb1, 0x23);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb2, 0x34);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb3, 0x77);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb4, 0x0d);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb5, 0x1a);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb6, 0x16);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x9a, 0x10);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x9b, 0x00);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x96, 0xe6);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x99, 0x06);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc0, 0x0e);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc1, 0x11);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc2, 0x1f);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc3, 0x30);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc4, 0x3f);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc5, 0x4b);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc6, 0x55);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc7, 0x5d);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc8, 0x68);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc9, 0xe3);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xca, 0xea);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xcb, 0x01);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xcc, 0x0a);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xcd, 0x0a);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xce, 0x07);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xcf, 0x08);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd0, 0x09);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd1, 0x1d);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd2, 0x31);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd3, 0x52);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd4, 0x5b);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd5, 0xb6);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd6, 0xbd);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd7, 0xc5);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd8, 0xcd);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd9, 0xd6);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xda, 0xe0);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xdb, 0xeb);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xdc, 0xf8);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xdd, 0xff);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xde, 0xfc);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xdf, 0x0f);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe0, 0x0e);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe1, 0x11);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe2, 0x1f);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe3, 0x30);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe4, 0x3f);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe5, 0x4b);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe6, 0x55);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe7, 0x5d);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe8, 0x68);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe9, 0xe3);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xea, 0xea);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xeb, 0x01);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xec, 0x0a);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xed, 0x0a);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xee, 0x07);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xef, 0x08);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf0, 0x09);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf1, 0x1d);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf2, 0x31);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf3, 0x52);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf4, 0x5b);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf5, 0xb6);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf6, 0xbd);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf7, 0xc5);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf8, 0xcd);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf9, 0xd6);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xfa, 0xe0);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xfb, 0xeb);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xfc, 0xf8);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xfd, 0xff);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xfe, 0xfc);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xff, 0x0f);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x83, 0xcc);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x84, 0x33);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc0, 0x0e);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc1, 0x11);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc2, 0x1f);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc3, 0x30);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc4, 0x3f);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc5, 0x4b);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc6, 0x55);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc7, 0x5d);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc8, 0x68);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc9, 0xe3);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xca, 0xea);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xcb, 0x01);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xcc, 0x0a);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xcd, 0x0a);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xce, 0x07);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xcf, 0x08);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd0, 0x09);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd1, 0x1d);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd2, 0x31);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd3, 0x52);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd4, 0x5b);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd5, 0xb6);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd6, 0xbd);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd7, 0xc5);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd8, 0xcd);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd9, 0xd6);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xda, 0xe0);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xdb, 0xeb);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xdc, 0xf8);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xdd, 0xff);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xde, 0xfc);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xdf, 0x0f);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe0, 0x0e);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe1, 0x11);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe2, 0x1f);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe3, 0x30);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe4, 0x3f);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe5, 0x4b);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe6, 0x55);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe7, 0x5d);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe8, 0x68);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe9, 0xe3);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xea, 0xea);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xeb, 0x01);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xec, 0x0a);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xed, 0x0a);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xee, 0x07);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xef, 0x08);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf0, 0x09);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf1, 0x1d);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf2, 0x31);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf3, 0x52);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf4, 0x5b);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf5, 0xb6);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf6, 0xbd);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf7, 0xc5);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf8, 0xcd);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf9, 0xd6);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xfa, 0xe0);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xfb, 0xeb);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xfc, 0xf8);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xfd, 0xff);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xfe, 0xfc);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xff, 0x0f);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x83, 0x00);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x84, 0x00);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x9f, 0xff);
> +	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> +	mipi_dsi_usleep_range(&dsi_ctx, 5000, 6000);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x8f, 0x00);
> +	mipi_dsi_usleep_range(&dsi_ctx, 1000, 2000);
> +
> +	nt51021_cabc_on(&dsi_ctx);
> +	mipi_dsi_usleep_range(&dsi_ctx, 1000, 2000);
> +
> +	return dsi_ctx.accum_err;
> +}
> +
> +static int nt51021_boe_off(struct boe_nt51021_desc *ctx)
> +{
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
> +
> +	nt51021_cabc_off(&dsi_ctx);
> +
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x8f, 0xa5);
> +	mipi_dsi_msleep(&dsi_ctx, 20);
> +	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
> +	mipi_dsi_msleep(&dsi_ctx, 130);
> +	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
> +	mipi_dsi_msleep(&dsi_ctx, 70);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x8f, 0x00);
> +	mipi_dsi_usleep_range(&dsi_ctx, 4000, 5000);
> +
> +	return dsi_ctx.accum_err;
> +}
> +
> +static int nt51021_boe_prepare(struct drm_panel *panel)
> +{
> +	struct boe_nt51021_desc *ctx = to_boe_panel(panel);
> +	struct device *dev = &ctx->dsi->dev;
> +	int ret;
> +
> +	ret = regulator_bulk_enable(ARRAY_SIZE(nt51021_boe_supplies), ctx->supplies);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to enable regulators: %d\n", ret);
> +		return ret;
> +	}
> +	nt51021_boe_reset(ctx);
> +
> +	ret = ctx->variant->init(ctx);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to initialize panel: %d\n", ret);
> +		gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> +		regulator_bulk_disable(ARRAY_SIZE(nt51021_boe_supplies), ctx->supplies);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int nt51021_boe_unprepare(struct drm_panel *panel)
> +{
> +	struct boe_nt51021_desc *ctx = to_boe_panel(panel);
> +	struct device *dev = &ctx->dsi->dev;
> +	int ret;
> +
> +	ret = nt51021_boe_off(ctx);
> +	if (ret < 0)
> +		dev_err(dev, "Failed to un-initialize panel: %d\n", ret);
> +
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> +	regulator_bulk_disable(ARRAY_SIZE(nt51021_boe_supplies), ctx->supplies);
> +
> +	return 0;
> +}
> +
> +static int nt51021_boe_get_modes(struct drm_panel *panel,
> +				 struct drm_connector *connector)
> +{
> +	struct boe_nt51021_desc *ctx = to_boe_panel(panel);
> +
> +	return drm_connector_helper_get_modes_fixed(connector,
> +						    ctx->variant->display_mode);
> +}
> +
> +static const struct drm_panel_funcs nt51021_boe_panel_funcs = {
> +	.prepare = nt51021_boe_prepare,
> +	.unprepare = nt51021_boe_unprepare,
> +	.get_modes = nt51021_boe_get_modes,
> +};
> +
> +static int nt51021_boe_probe(struct mipi_dsi_device *dsi)
> +{
> +	struct device *dev = &dsi->dev;
> +	struct boe_nt51021_desc *ctx;
> +	int ret;
> +
> +	ctx = devm_drm_panel_alloc(dev, struct boe_nt51021_desc, panel,
> +				   &nt51021_boe_panel_funcs,
> +				   DRM_MODE_CONNECTOR_DSI);
> +	if (IS_ERR(ctx))
> +		return PTR_ERR(ctx);
> +
> +	ctx->variant = of_device_get_match_data(dev);
> +	if (!ctx->variant)
> +		return dev_err_probe(dev, -ENODEV, "No match data\n");
> +
> +	ret = devm_regulator_bulk_get_const(dev,
> +					    ARRAY_SIZE(nt51021_boe_supplies),
> +					    nt51021_boe_supplies,
> +					    &ctx->supplies);
> +	if (ret < 0)
> +		return ret;
> +
> +	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(ctx->reset_gpio))
> +		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
> +				     "Failed to get reset-gpios\n");
> +
> +	ctx->dsi = dsi;
> +	mipi_dsi_set_drvdata(dsi, ctx);
> +
> +	dsi->lanes = 4;
> +	dsi->format = MIPI_DSI_FMT_RGB888;
> +	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
> +			  MIPI_DSI_MODE_NO_EOT_PACKET | MIPI_DSI_MODE_LPM;
> +
> +	ctx->panel.prepare_prev_first = true;
> +
> +	ret = drm_panel_of_backlight(&ctx->panel);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get backlight\n");
> +
> +	drm_panel_add(&ctx->panel);

Use devm_ variant

> +
> +	ret = mipi_dsi_attach(dsi);

Use devm variant

> +	if (ret < 0) {
> +		drm_panel_remove(&ctx->panel);

Drop this with the devm variant

> +		return dev_err_probe(dev, ret,
> +				     "Failed to attach to DSI host\n");
> +	}
> +
> +	return 0;
> +}
> +
> +static void nt51021_boe_remove(struct mipi_dsi_device *dsi)
> +{
> +	struct boe_nt51021_desc *ctx = mipi_dsi_get_drvdata(dsi);
> +	int ret;
> +
> +	ret = mipi_dsi_detach(dsi);
> +	if (ret < 0)
> +		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
> +
> +	drm_panel_remove(&ctx->panel);
> +}

Drop the remove function when using the devm_ variants.

> +
> +static const struct drm_display_mode nt51021_boe_8_mode = {
> +	.clock = (1200 + 84 + 4 + 60) * (1920 + 36 + 1 + 25) * 60 / 1000,
> +	.hdisplay = 1200,
> +	.hsync_start = 1200 + 84,
> +	.hsync_end = 1200 + 84 + 4,
> +	.htotal = 1200 + 84 + 4 + 60,
> +	.vdisplay = 1920,
> +	.vsync_start = 1920 + 36,
> +	.vsync_end = 1920 + 36 + 1,
> +	.vtotal = 1920 + 36 + 1 + 25,
> +	.width_mm = 107,
> +	.height_mm = 172,
> +	.type = DRM_MODE_TYPE_DRIVER,
> +};
> +
> +static const struct drm_display_mode nt51021_boe_10wu_mode = {
> +	.clock = (1200 + 172 + 4 + 32) * (1920 + 25 + 1 + 14) * 60 / 1000,
> +	.hdisplay = 1200,
> +	.hsync_start = 1200 + 172,
> +	.hsync_end = 1200 + 172 + 4,
> +	.htotal = 1200 + 172 + 4 + 32,
> +	.vdisplay = 1920,
> +	.vsync_start = 1920 + 25,
> +	.vsync_end = 1920 + 25 + 1,
> +	.vtotal = 1920 + 25 + 1 + 14,
> +	.width_mm = 135,
> +	.height_mm = 216,
> +	.type = DRM_MODE_TYPE_DRIVER,
> +};
> +
> +static const struct boe_nt51021_variant nt51021_8inch_data = {
> +	.init = nt51021_boe_8_init,
> +	.display_mode = &nt51021_boe_8_mode,
> +};
> +
> +static const struct boe_nt51021_variant nt51021_10wu_data = {
> +	.init = nt51021_boe_10wu_init,
> +	.display_mode = &nt51021_boe_10wu_mode,
> +};
> +
> +static const struct of_device_id nt51021_boe_of_match[] = {
> +	{ .compatible = "boe,tv080wum-nx2", .data = &nt51021_8inch_data },
> +	{ .compatible = "boe,tv101wum-nx0", .data = &nt51021_10wu_data },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, nt51021_boe_of_match);
> +
> +static struct mipi_dsi_driver nt51021_boe_driver = {
> +	.probe = nt51021_boe_probe,
> +	.remove = nt51021_boe_remove,
> +	.driver = {
> +		.name = "panel-novatek-nt51021",
> +		.of_match_table = nt51021_boe_of_match,
> +	},
> +};
> +module_mipi_dsi_driver(nt51021_boe_driver);
> +
> +MODULE_AUTHOR("Nickolay Goppen <setotau@mainlining.org>");
> +MODULE_AUTHOR("Alexey Minnekhanov <alexeymin@minlexx.ru>");
> +MODULE_DESCRIPTION("DRM driver for Novatek NT51021-based DSI panels");
> +MODULE_LICENSE("GPL");
> 

Thanks,
Neil
