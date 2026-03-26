Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 327EF106F302
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 08:35:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B55110E8E9;
	Thu, 26 Mar 2026 08:35:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hk3zr2gh";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E41910E8DB
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 08:35:27 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-43b40003d13so408912f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 01:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774514126; x=1775118926; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=fnvsgNCpEbH4UYp5iVoGOvBVdC52HxKa6FniJfiCGlU=;
 b=hk3zr2ghSx8JCfeaXjwlSj8W1AVRIIs/5+UTec9c66iZXmHpJwL0Pv9+09KV+Bdie9
 uRN3khFDCRMgpWDOzcn10TlNTLr0vfb1Hprt5SXCggZ0QxzBrdH+vOMfxaYIEhL6ZSYb
 Qe+kINYxUhhvFm7jb/+rCdgbVsgc+cmb6TP+QVWqzpfe7QLJFlVnDra5pPl96Q2tl2BQ
 C8pj4H87B+EpuMriKj28VZ8dKkmfYgZCaamu23KlBHMUq7eMufw0TZiNTfr2NX5MALjD
 MjmC6IoODzJxYBnK753WEAr10vsz8fbEfUTBUQlHxxZIIdf6x1AsSGs6lT/ElnSAAheu
 nAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774514126; x=1775118926;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fnvsgNCpEbH4UYp5iVoGOvBVdC52HxKa6FniJfiCGlU=;
 b=BNDl8b9TM0s9WLdHN727GlP4ee9pp+2KldTqnE0efzlvtdPm20MW+d0LF4A2CtosXW
 4hlFjhKS1umGKdW/uuJZgexwO9muxthGM6z9PZ7OdqHhPc/qyu7fvOtYZM0LJzykXi3d
 yUi7d/ivCSGFMotFkn7fUh9ArwEQoiVhpytiCRgp8gW4EUHljJxw/WMsmo5/EoYyPO33
 LFv7c3Ryz/JaexSFyNwjagw/pavoQ/soEl8qFgW8xk5nd43i30lxBTa5H1hjOycP0EbN
 VaticrkowC289ETQKE2dhp8IA590WfCPCr9t9GOTS49WYFuOxukJYbzIX4fB4t52Qf9q
 LuAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWzgRJMK8P3LAahrkInGCUZYQR9TK+yG3XBnGvwkt0tW/dk/lnohVS/+bEGDXnaf8xfa6KAA69wms=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzk3k47XXMO42G+z1h6BKJrz5rBNLQ1kGpEuwkXM3Iiq8nq4cMF
 ZTKKZsQ7Z27TkI0SBH/DfWVhxIJKEIEj1aoDJOUmCzb/Ar2NDkFHrCJWPKio/uSs/oQ=
X-Gm-Gg: ATEYQzwkPr5OqC4mM1Mu24BbHfZW2IbHkdfAzn5HeJty0QO6WUfEEAqHDU6PqA8k5d+
 s37Fsr1pNQ0O5s8X9nyfcWyj2u+7kzbWjt2lozOWhWSQA2jCmXoTSJEGYhySWAKsTMhT4gcvvww
 pyyr7Z07M5QcDLcPzk0LMPQuavW21M0CDxG6Xt9VXEtD+HKXckfOPGP3FXtZeBztgY/v6Q2URmN
 hUQZTtFM2PZa3yFGnX/nIJP8OJGNW5OQcerx5NQBuw1bqbBU0nG9OwZM5G+wNIsr5vZULe8HRye
 TiC69cZewEvVI+SfcFMK0tPkNBqLWTa8c2mFVs0FFudqMP7CdGmPZleeF3aJTM7EI0ZD//jnU8w
 BRqQggxn9RfGvQ4XXdphpXLHGyLB7qSpn2MKJJ4KTo5AVpnHcURow9jHPAeJw7EpZUf7N3I7jTC
 BGCdSegKpzRS7Xq9qspo/qKKyUgeNJXc5tpAfiV6KnvVgr0T7WVMuJHS+yowI72ikBX8QF00Uvs
 uN1djY=
X-Received: by 2002:a05:6000:144d:b0:43b:3e34:7fe with SMTP id
 ffacd0b85a97d-43b889aefd2mr10034853f8f.21.1774514125851; 
 Thu, 26 Mar 2026 01:35:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:8431:f88b:714d:f78d?
 ([2a01:e0a:106d:1080:8431:f88b:714d:f78d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919df903sm6711609f8f.30.2026.03.26.01.35.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2026 01:35:25 -0700 (PDT)
Message-ID: <e4d85958-a0c2-49d6-8907-fbe2ab08affb@linaro.org>
Date: Thu, 26 Mar 2026 09:35:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 4/4] drm/panel: ilitek-ili9806e: add Rocktech
 RK050HR345-CT106A SPI panel
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com, David Airlie <airlied@gmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org
References: <20260318073346.18041-1-dario.binacchi@amarulasolutions.com>
 <20260318073346.18041-5-dario.binacchi@amarulasolutions.com>
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
In-Reply-To: <20260318073346.18041-5-dario.binacchi@amarulasolutions.com>
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

On 3/18/26 08:32, Dario Binacchi wrote:
> Add support for the Rocktech RK050HR345-CT106A panel based on the
> Ilitek ILI9806E controller using the SPI bus.
> 
> The driver is designed to be easily extensible to support other panels
> with different initialization sequences and display timings by
> providing a specific descriptor structure for each model.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> 
> ---
> 
> Changes in v5:
> - Add Reviewed-by tag of Neil Armstrong for patches:
>    - 1/4 drm/panel: ilitek-ili9806e: rename to specific DSI driver
>    - 2/4 drm/panel: ilitek-ili9806e: split core and DSI logic
> 
> Changes in v4:
> - Fix "WARNING: unmet direct dependencies detected for
>    DRM_PANEL_ILITEK_ILI9806E_CORE" reported by kernel test robot
> 
> Changes in v3:
> - Add Reviewed-by tag of Rob Herring
> 
> Changes in v2:
> - Introduce DRM_PANEL_ILITEK_ILI9806E_CORE hidden kconfig option.
> - Split core and DSI logic.
> - Restore vdd-supply as required for both DSI and SPI types in the
>    dt-bindings.
> - Dop useless settings in case of rocktech,rk050hr345-ct106a in the
>    dt-bindings.
> 
>   MAINTAINERS                                   |   1 +
>   drivers/gpu/drm/panel/Kconfig                 |  12 +
>   drivers/gpu/drm/panel/Makefile                |   1 +
>   .../drm/panel/panel-ilitek-ili9806e-core.c    |  31 +-
>   .../gpu/drm/panel/panel-ilitek-ili9806e-spi.c | 323 ++++++++++++++++++
>   5 files changed, 355 insertions(+), 13 deletions(-)
>   create mode 100644 drivers/gpu/drm/panel/panel-ilitek-ili9806e-spi.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fcb91fe8d061..15e88008bd14 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8027,6 +8027,7 @@ F:	drivers/gpu/drm/panel/panel-ilitek-ili9805.c
>   
>   DRM DRIVER FOR ILITEK ILI9806E PANELS
>   M:	Michael Walle <mwalle@kernel.org>
> +M:	Dario Binacchi <dario.binacchi@amarulasolutions.com>
>   S:	Maintained
>   F:	drivers/gpu/drm/panel/panel-ilitek-ili9806e-*
>   
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index 7fc20421cba5..ec12850fc231 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -270,6 +270,18 @@ config DRM_PANEL_ILITEK_ILI9806E_DSI
>   	  Say Y if you want to enable support for panels based on the
>   	  Ilitek ILI9806E controller using DSI.
>   
> +config DRM_PANEL_ILITEK_ILI9806E_SPI
> +	tristate "Ilitek ILI9806E-based RGB SPI panel"
> +	depends on OF
> +	depends on SPI
> +	depends on BACKLIGHT_CLASS_DEVICE
> +	select DRM_MIPI_DBI
> +	select VIDEOMODE_HELPERS
> +	select DRM_PANEL_ILITEK_ILI9806E_CORE
> +	help
> +	  Say Y if you want to enable support for panels based on the
> +	  Ilitek ILI9806E controller using SPI.
> +
>   config DRM_PANEL_ILITEK_ILI9881C
>   	tristate "Ilitek ILI9881C-based panels"
>   	depends on OF
> diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
> index f56dafb36499..948c4a2d58ff 100644
> --- a/drivers/gpu/drm/panel/Makefile
> +++ b/drivers/gpu/drm/panel/Makefile
> @@ -28,6 +28,7 @@ obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9341) += panel-ilitek-ili9341.o
>   obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9805) += panel-ilitek-ili9805.o
>   obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9806E_CORE) += panel-ilitek-ili9806e-core.o
>   obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9806E_DSI) += panel-ilitek-ili9806e-dsi.o
> +obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9806E_SPI) += panel-ilitek-ili9806e-spi.o
>   obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9881C) += panel-ilitek-ili9881c.o
>   obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9882T) += panel-ilitek-ili9882t.o
>   obj-$(CONFIG_DRM_PANEL_INNOLUX_EJ030NA) += panel-innolux-ej030na.o
> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9806e-core.c b/drivers/gpu/drm/panel/panel-ilitek-ili9806e-core.c
> index c088685d9d85..be2cf1440155 100644
> --- a/drivers/gpu/drm/panel/panel-ilitek-ili9806e-core.c
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9806e-core.c
> @@ -11,6 +11,7 @@
>   #include <linux/export.h>
>   #include <linux/gpio/consumer.h>
>   #include <linux/module.h>
> +#include <linux/of.h>
>   #include <linux/property.h>
>   #include <linux/regulator/consumer.h>
>   
> @@ -20,15 +21,11 @@ struct ili9806e {
>   	void *transport;
>   	struct drm_panel panel;
>   
> +	unsigned int num_supplies;
>   	struct regulator_bulk_data supplies[2];
>   	struct gpio_desc *reset_gpio;
>   };
>   
> -static const char * const regulator_names[] = {
> -	"vdd",
> -	"vccio",
> -};
> -
>   void *ili9806e_get_transport(struct drm_panel *panel)
>   {
>   	struct ili9806e *ctx = container_of(panel, struct ili9806e, panel);
> @@ -44,7 +41,7 @@ int ili9806e_power_on(struct device *dev)
>   
>   	gpiod_set_value(ctx->reset_gpio, 1);
>   
> -	ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
> +	ret = regulator_bulk_enable(ctx->num_supplies, ctx->supplies);
>   	if (ret) {
>   		dev_err(dev, "regulator bulk enable failed: %d\n", ret);
>   		return ret;
> @@ -65,7 +62,7 @@ int ili9806e_power_off(struct device *dev)
>   
>   	gpiod_set_value(ctx->reset_gpio, 1);
>   
> -	ret = regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
> +	ret = regulator_bulk_disable(ctx->num_supplies, ctx->supplies);
>   	if (ret)
>   		dev_err(dev, "regulator bulk disable failed: %d\n", ret);
>   
> @@ -78,7 +75,8 @@ int ili9806e_probe(struct device *dev, void *transport,
>   		  int connector_type)
>   {
>   	struct ili9806e *ctx;
> -	int i, ret;
> +	bool set_prepare_prev_first = false;
> +	int ret;
>   
>   	ctx = devm_kzalloc(dev, sizeof(struct ili9806e), GFP_KERNEL);
>   	if (!ctx)
> @@ -87,11 +85,16 @@ int ili9806e_probe(struct device *dev, void *transport,
>   	dev_set_drvdata(dev, ctx);
>   	ctx->transport = transport;
>   
> -	for (i = 0; i < ARRAY_SIZE(ctx->supplies); i++)
> -		ctx->supplies[i].supply = regulator_names[i];
> +	ctx->supplies[ctx->num_supplies++].supply = "vdd";
> +	if (of_device_is_compatible(dev->of_node,
> +				    "densitron,dmt028vghmcmi-1d") ||
> +	    of_device_is_compatible(dev->of_node,
> +				    "ortustech,com35h3p70ulc")) {
> +		ctx->supplies[ctx->num_supplies++].supply = "vccio";
> +		set_prepare_prev_first = true;
> +	}
>   
> -	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(ctx->supplies),
> -				      ctx->supplies);
> +	ret = devm_regulator_bulk_get(dev, ctx->num_supplies, ctx->supplies);
>   	if (ret)
>   		return dev_err_probe(dev, ret, "failed to get regulators\n");
>   
> @@ -106,7 +109,9 @@ int ili9806e_probe(struct device *dev, void *transport,
>   	if (ret)
>   		return dev_err_probe(dev, ret, "Failed to get backlight\n");
>   
> -	ctx->panel.prepare_prev_first = true;
> +	if (set_prepare_prev_first)
> +		ctx->panel.prepare_prev_first = true;
> +
>   	drm_panel_add(&ctx->panel);
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9806e-spi.c b/drivers/gpu/drm/panel/panel-ilitek-ili9806e-spi.c
> new file mode 100644
> index 000000000000..9d10b0d28f52
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9806e-spi.c
> @@ -0,0 +1,323 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * SPI interface to the Ilitek ILI9806E panel.
> + *
> + * Copyright (c) 2026 Amarula Solutions, Dario Binacchi <dario.binacchi@amarulasolutions.com>
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/media-bus-format.h>
> +#include <linux/module.h>
> +#include <linux/spi/spi.h>
> +
> +#include <drm/drm_mipi_dbi.h>
> +#include <drm/drm_panel.h>
> +#include <drm/drm_print.h>
> +
> +#include <video/mipi_display.h>
> +
> +#include "panel-ilitek-ili9806e-core.h"
> +
> +struct ili9806e_spi_panel {
> +	struct spi_device *spi;
> +	struct mipi_dbi dbi;
> +	const struct ili9806e_spi_panel_desc *desc;
> +};
> +
> +struct ili9806e_spi_panel_desc {
> +	const struct drm_display_mode *display_mode;
> +	u32 bus_format;
> +	u32 bus_flags;
> +	void (*init_sequence)(struct ili9806e_spi_panel *ctx);
> +};
> +
> +static int ili9806e_spi_off(struct ili9806e_spi_panel *ctx)
> +{
> +	struct mipi_dbi *dbi = &ctx->dbi;
> +
> +	mipi_dbi_command(dbi, MIPI_DCS_SET_DISPLAY_OFF, 0x00);
> +	mipi_dbi_command(dbi, MIPI_DCS_ENTER_SLEEP_MODE, 0x00);
> +
> +	return 0;
> +}
> +
> +static int ili9806e_spi_unprepare(struct drm_panel *panel)
> +{
> +	struct ili9806e_spi_panel *ctx = ili9806e_get_transport(panel);
> +	struct device *dev = &ctx->spi->dev;
> +	int ret;
> +
> +	ili9806e_spi_off(ctx);
> +
> +	ret = ili9806e_power_off(dev);
> +	if (ret)
> +		dev_err(dev, "power off failed: %d\n", ret);
> +
> +	return 0;
> +}
> +
> +static int ili9806e_spi_prepare(struct drm_panel *panel)
> +{
> +	struct ili9806e_spi_panel *ctx = ili9806e_get_transport(panel);
> +	struct device *dev = &ctx->spi->dev;
> +	int ret;
> +
> +	ret = ili9806e_power_on(dev);
> +	if (ret)
> +		return ret;
> +
> +	if (ctx->desc->init_sequence)
> +		ctx->desc->init_sequence(ctx);
> +
> +	return 0;
> +}
> +
> +static int ili9806e_spi_get_modes(struct drm_panel *panel,
> +			      struct drm_connector *connector)
> +{
> +	struct ili9806e_spi_panel *ctx = ili9806e_get_transport(panel);
> +	const struct ili9806e_spi_panel_desc *desc = ctx->desc;
> +	struct drm_display_mode *mode;
> +
> +	mode = drm_mode_duplicate(connector->dev, desc->display_mode);
> +	if (!mode)
> +		return -ENOMEM;
> +
> +	drm_mode_set_name(mode);
> +
> +	connector->display_info.width_mm = mode->width_mm;
> +	connector->display_info.height_mm = mode->height_mm;
> +	connector->display_info.bus_flags = desc->bus_flags;
> +	drm_display_info_set_bus_formats(&connector->display_info,
> +					 &desc->bus_format, 1);
> +
> +	drm_mode_probed_add(connector, mode);
> +
> +	return 1;
> +}
> +
> +static const struct drm_panel_funcs ili9806e_spi_funcs = {
> +	.unprepare = ili9806e_spi_unprepare,
> +	.prepare   = ili9806e_spi_prepare,
> +	.get_modes = ili9806e_spi_get_modes,
> +};
> +
> +static int ili9806e_spi_probe(struct spi_device *spi)
> +{
> +	struct device *dev = &spi->dev;
> +	struct ili9806e_spi_panel *ctx;
> +	int err;
> +
> +	ctx = devm_kzalloc(dev, sizeof(struct ili9806e_spi_panel), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	ctx->spi = spi;
> +	ctx->desc = device_get_match_data(dev);
> +
> +	err = mipi_dbi_spi_init(spi, &ctx->dbi, NULL);
> +	if (err)
> +		return dev_err_probe(dev, err, "MIPI DBI init failed\n");
> +
> +	return ili9806e_probe(dev, ctx, &ili9806e_spi_funcs,
> +			      DRM_MODE_CONNECTOR_DPI);
> +}
> +
> +static void ili9806e_spi_remove(struct spi_device *spi)
> +{
> +	ili9806e_remove(&spi->dev);
> +}
> +
> +static void rk050hr345_ct106a_init(struct ili9806e_spi_panel *ctx)
> +{
> +	struct mipi_dbi *dbi = &ctx->dbi;
> +
> +	/* Switch to page 1 */
> +	mipi_dbi_command(dbi, 0xff, 0xff, 0x98, 0x06, 0x04, 0x01);
> +	/* Interface Settings */
> +	mipi_dbi_command(dbi, 0x08, 0x10);
> +	mipi_dbi_command(dbi, 0x21, 0x01);
> +	/* Panel Settings */
> +	mipi_dbi_command(dbi, 0x30, 0x01);
> +	mipi_dbi_command(dbi, 0x31, 0x00);
> +	/* Power Control */
> +	mipi_dbi_command(dbi, 0x40, 0x15);
> +	mipi_dbi_command(dbi, 0x41, 0x44);
> +	mipi_dbi_command(dbi, 0x42, 0x03);
> +	mipi_dbi_command(dbi, 0x43, 0x09);
> +	mipi_dbi_command(dbi, 0x44, 0x09);
> +	mipi_dbi_command(dbi, 0x50, 0x78);
> +	mipi_dbi_command(dbi, 0x51, 0x78);
> +	mipi_dbi_command(dbi, 0x52, 0x00);
> +	mipi_dbi_command(dbi, 0x53, 0x3a);
> +	mipi_dbi_command(dbi, 0x57, 0x50);
> +	/* Timing Control */
> +	mipi_dbi_command(dbi, 0x60, 0x07);
> +	mipi_dbi_command(dbi, 0x61, 0x00);
> +	mipi_dbi_command(dbi, 0x62, 0x08);
> +	mipi_dbi_command(dbi, 0x63, 0x00);
> +	/* Gamma Settings */
> +	mipi_dbi_command(dbi, 0xa0, 0x00);
> +	mipi_dbi_command(dbi, 0xa1, 0x03);
> +	mipi_dbi_command(dbi, 0xa2, 0x0b);
> +	mipi_dbi_command(dbi, 0xa3, 0x0f);
> +	mipi_dbi_command(dbi, 0xa4, 0x0b);
> +	mipi_dbi_command(dbi, 0xa5, 0x1b);
> +	mipi_dbi_command(dbi, 0xa6, 0x0a);
> +	mipi_dbi_command(dbi, 0xa7, 0x0a);
> +	mipi_dbi_command(dbi, 0xa8, 0x02);
> +	mipi_dbi_command(dbi, 0xa9, 0x07);
> +	mipi_dbi_command(dbi, 0xaa, 0x05);
> +	mipi_dbi_command(dbi, 0xab, 0x03);
> +	mipi_dbi_command(dbi, 0xac, 0x0e);
> +	mipi_dbi_command(dbi, 0xad, 0x32);
> +	mipi_dbi_command(dbi, 0xae, 0x2d);
> +	mipi_dbi_command(dbi, 0xaf, 0x00);
> +	mipi_dbi_command(dbi, 0xc0, 0x00);
> +	mipi_dbi_command(dbi, 0xc1, 0x03);
> +	mipi_dbi_command(dbi, 0xc2, 0x0e);
> +	mipi_dbi_command(dbi, 0xc3, 0x10);
> +	mipi_dbi_command(dbi, 0xc4, 0x09);
> +	mipi_dbi_command(dbi, 0xc5, 0x17);
> +	mipi_dbi_command(dbi, 0xc6, 0x09);
> +	mipi_dbi_command(dbi, 0xc7, 0x07);
> +	mipi_dbi_command(dbi, 0xc8, 0x04);
> +	mipi_dbi_command(dbi, 0xc9, 0x09);
> +	mipi_dbi_command(dbi, 0xca, 0x06);
> +	mipi_dbi_command(dbi, 0xcb, 0x06);
> +	mipi_dbi_command(dbi, 0xcc, 0x0c);
> +	mipi_dbi_command(dbi, 0xcd, 0x25);
> +	mipi_dbi_command(dbi, 0xce, 0x20);
> +	mipi_dbi_command(dbi, 0xcf, 0x00);
> +
> +	/* Switch to page 6 */
> +	mipi_dbi_command(dbi, 0xff, 0xff, 0x98, 0x06, 0x04, 0x06);
> +	/* GIP settings */
> +	mipi_dbi_command(dbi, 0x00, 0x21);
> +	mipi_dbi_command(dbi, 0x01, 0x09);
> +	mipi_dbi_command(dbi, 0x02, 0x00);
> +	mipi_dbi_command(dbi, 0x03, 0x00);
> +	mipi_dbi_command(dbi, 0x04, 0x01);
> +	mipi_dbi_command(dbi, 0x05, 0x01);
> +	mipi_dbi_command(dbi, 0x06, 0x80);
> +	mipi_dbi_command(dbi, 0x07, 0x05);
> +	mipi_dbi_command(dbi, 0x08, 0x02);
> +	mipi_dbi_command(dbi, 0x09, 0x80);
> +	mipi_dbi_command(dbi, 0x0a, 0x00);
> +	mipi_dbi_command(dbi, 0x0b, 0x00);
> +	mipi_dbi_command(dbi, 0x0c, 0x0a);
> +	mipi_dbi_command(dbi, 0x0d, 0x0a);
> +	mipi_dbi_command(dbi, 0x0e, 0x00);
> +	mipi_dbi_command(dbi, 0x0f, 0x00);
> +	mipi_dbi_command(dbi, 0x10, 0xe0);
> +	mipi_dbi_command(dbi, 0x11, 0xe4);
> +	mipi_dbi_command(dbi, 0x12, 0x04);
> +	mipi_dbi_command(dbi, 0x13, 0x00);
> +	mipi_dbi_command(dbi, 0x14, 0x00);
> +	mipi_dbi_command(dbi, 0x15, 0xc0);
> +	mipi_dbi_command(dbi, 0x16, 0x08);
> +	mipi_dbi_command(dbi, 0x17, 0x00);
> +	mipi_dbi_command(dbi, 0x18, 0x00);
> +	mipi_dbi_command(dbi, 0x19, 0x00);
> +	mipi_dbi_command(dbi, 0x1a, 0x00);
> +	mipi_dbi_command(dbi, 0x1b, 0x00);
> +	mipi_dbi_command(dbi, 0x1c, 0x00);
> +	mipi_dbi_command(dbi, 0x1d, 0x00);
> +	mipi_dbi_command(dbi, 0x20, 0x01);
> +	mipi_dbi_command(dbi, 0x21, 0x23);
> +	mipi_dbi_command(dbi, 0x22, 0x45);
> +	mipi_dbi_command(dbi, 0x23, 0x67);
> +	mipi_dbi_command(dbi, 0x24, 0x01);
> +	mipi_dbi_command(dbi, 0x25, 0x23);
> +	mipi_dbi_command(dbi, 0x26, 0x45);
> +	mipi_dbi_command(dbi, 0x27, 0x67);
> +	mipi_dbi_command(dbi, 0x30, 0x01);
> +	mipi_dbi_command(dbi, 0x31, 0x11);
> +	mipi_dbi_command(dbi, 0x32, 0x00);
> +	mipi_dbi_command(dbi, 0x33, 0xee);
> +	mipi_dbi_command(dbi, 0x34, 0xff);
> +	mipi_dbi_command(dbi, 0x35, 0xbb);
> +	mipi_dbi_command(dbi, 0x36, 0xca);
> +	mipi_dbi_command(dbi, 0x37, 0xdd);
> +	mipi_dbi_command(dbi, 0x38, 0xac);
> +	mipi_dbi_command(dbi, 0x39, 0x76);
> +	mipi_dbi_command(dbi, 0x3a, 0x67);
> +	mipi_dbi_command(dbi, 0x3b, 0x22);
> +	mipi_dbi_command(dbi, 0x3c, 0x22);
> +	mipi_dbi_command(dbi, 0x3d, 0x22);
> +	mipi_dbi_command(dbi, 0x3e, 0x22);
> +	mipi_dbi_command(dbi, 0x3f, 0x22);
> +	mipi_dbi_command(dbi, 0x40, 0x22);
> +	mipi_dbi_command(dbi, 0x52, 0x10);
> +	mipi_dbi_command(dbi, 0x53, 0x10);
> +
> +	/* Switch to page 7 */
> +	mipi_dbi_command(dbi, 0xff, 0xff, 0x98, 0x06, 0x04, 0x07);
> +	mipi_dbi_command(dbi, 0x17, 0x22);
> +	mipi_dbi_command(dbi, 0x02, 0x77);
> +	mipi_dbi_command(dbi, 0xe1, 0x79);
> +	mipi_dbi_command(dbi, 0xb3, 0x10);
> +
> +	/* Switch to page 0 */
> +	mipi_dbi_command(dbi, 0xff, 0xff, 0x98, 0x06, 0x04, 0x00);
> +	mipi_dbi_command(dbi, MIPI_DCS_SET_ADDRESS_MODE, 0x00); // 0x36
> +	mipi_dbi_command(dbi, MIPI_DCS_EXIT_SLEEP_MODE); // 0x11
> +
> +	msleep(120);
> +
> +	mipi_dbi_command(dbi, MIPI_DCS_SET_DISPLAY_ON);
> +
> +	msleep(120);
> +}
> +
> +static const struct drm_display_mode rk050hr345_ct106a_mode = {
> +	.width_mm    = 62,
> +	.height_mm   = 110,
> +	.clock       = 27000,
> +	.hdisplay    = 480,
> +	.hsync_start = 480 + 10,
> +	.hsync_end   = 480 + 10 + 10,
> +	.htotal      = 480 + 10 + 10 + 10,
> +	.vdisplay    = 854,
> +	.vsync_start = 854 + 10,
> +	.vsync_end   = 854 + 10 + 10,
> +	.vtotal      = 854 + 10 + 10 + 10,
> +	.flags       = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
> +	.type        = DRM_MODE_TYPE_PREFERRED | DRM_MODE_TYPE_DRIVER,
> +};
> +
> +static const struct ili9806e_spi_panel_desc rk050hr345_ct106a_desc = {
> +	.init_sequence = rk050hr345_ct106a_init,
> +	.display_mode = &rk050hr345_ct106a_mode,
> +	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
> +	.bus_flags = DRM_BUS_FLAG_DE_HIGH |
> +		     DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE,
> +};
> +
> +static const struct of_device_id ili9806e_spi_of_match[] = {
> +	{ .compatible = "rocktech,rk050hr345-ct106a", .data = &rk050hr345_ct106a_desc },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ili9806e_spi_of_match);
> +
> +static const struct spi_device_id ili9806e_spi_ids[] = {
> +	{ "rk050hr345-ct106a", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(spi, ili9806e_spi_ids);
> +
> +static struct spi_driver ili9806e_spi_driver = {
> +	.driver = {
> +		.name = "ili9806e-spi",
> +		.of_match_table = ili9806e_spi_of_match,
> +	},
> +	.probe = ili9806e_spi_probe,
> +	.remove = ili9806e_spi_remove,
> +	.id_table = ili9806e_spi_ids,
> +};
> +module_spi_driver(ili9806e_spi_driver);
> +
> +MODULE_AUTHOR("Dario Binacchi <dario.binacchi@amarulasolutions.com>");
> +MODULE_DESCRIPTION("Ilitek ILI9806E LCD SPI Driver");
> +MODULE_LICENSE("GPL");

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
