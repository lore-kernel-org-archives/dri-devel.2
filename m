Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B41C5AD5A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 11:55:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBD8510E2B6;
	Wed, 12 Aug 2026 11:55:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="heqKjoUb";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C92D10E2B6
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 11:55:44 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-47f633e6058so733259f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 04:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786535742; x=1787140542; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xBQ6+uOQL37M+U6oTKIHCjMa+hz/qamwAGt4gMYVnhc=;
 b=heqKjoUbO7KLKvq7LG9I7cW6KP5rqux7shK+IkqOQ/k2RGPkyDcFKM8pxFyf8KxMyc
 P17GaWGBCntQu0HW+S+kX/021p3AZ/Krhxtwzehsg5b0C/NduOfWYkLu0SpzoHAX9Gzi
 De3RD5iJG++TuoAcxuGWTKTh3p4rlRATrJQXp4LhKQqdJ7B+HPIbqTV/K1dDOn3cJJ+u
 +9Jn3/NJtccUYgYSGFL2dg2a8LBonxZXpjHUao0x+zwEA0hpvYXDRXyBBL4I73BM75o+
 Pa0j7vkLKfLYoOLXib38LxQ4SUYw/JppTkDqFbWyEVn5O4XaI82cEL+bEjEoA0bTye1R
 UO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786535742; x=1787140542;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xBQ6+uOQL37M+U6oTKIHCjMa+hz/qamwAGt4gMYVnhc=;
 b=dKYkSU7X4JvtF9UQ+dvZKQ0S0C2lgM6xzCGBaNtamsKYIp/NOHa4JPPPda6OvnJxRj
 beG6fNYfdyYHjq9JXhYib4eXX4EhmaFPD670MngMfCshsLVFWZi7rStDPnH6JUwLHb/w
 8MA6994WheVy5iQL8kMorfwW3hLpIxrQMkmAbp6AgPT98L7gFWR4x0hzIYCMFOnzLEU7
 v6KP6px72BNOvYbQFSzPePbNAtpYm1hIRVyvdKabPlgzbJD/4FLtsTSadrRSy2oNLTbs
 xqwO22exI0xuEAepMDf1DW1Ije2rTweg2IGHPmXS7ExgXOHRV9KqXmMUVdqlLCG7cE7M
 yOCQ==
X-Gm-Message-State: AOJu0YwwEFy4Bw9JzBn3R7ckKj6yXmeFxslKZL7MIBHZU/samTguC2Xp
 7qZmi+MO0+PBcDjn/xplIL9P8DLQMQD71tv77Xuke/jkLcgumFXpwhBVa+Z3bZofEEvA31tBm3z
 AEKGSFtw=
X-Gm-Gg: AR+sD11pFwogEmwsO/FtVDt6//ohcStYqO/D9GVmxfEb2dZb7CL99XSQ1/rojLmAm7K
 B+IQo91tkeve+3mD5kZpPkD4gEi6pN0LbT56+Kvc65Pzjtb5zCb/ZFhadjEqwKUknQ9ffcvPPxw
 YZ15VpK+XtUJLvZPWXpfeBwIExDhp3Fr7zUlqJDgi16mv7HE0ptm1fVWUfISO/JtzcuCN3wpHCY
 z/Im3WM2NqqYYhwcgXekRxohAaH6mJgrakoCQxNKhVHkuvRdLqX+lOlKORuCa4V8ca2EF2z3Sn6
 sC2KsTbg2bsTcqZF+7Lczlqbev+ZelHPl55vVvTfKnUupfzBC2tT1ItRNlJEVgF8VVUjKpB9dhv
 5Nis9Yw4j1YBx9HYmUPU/Cp7v0rA5xk1LEf9rYVfYdxvpknRM+lQ/gpME4opQKJR+JJN0ZH3T1d
 f50Nf0At4+hBg77Y4upl6sW00zjSZSdpg4i9kc5t5e5rlJ7djf+dI3Cf1g+UJ+A/jLxw5NwOXv+
 qFamqQNEp48uQIZ42Y+J3vmClYvgAvXYaJvXGhbShmv
X-Received: by 2002:a05:6000:1867:b0:480:ca53:280f with SMTP id
 ffacd0b85a97d-481528b2208mr6442306f8f.2.1786535742332; 
 Wed, 12 Aug 2026 04:55:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:405d:735d:801e:de34?
 ([2a01:e0a:106d:1080:405d:735d:801e:de34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150c08982sm6169373f8f.14.2026.08.12.04.55.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2026 04:55:41 -0700 (PDT)
Message-ID: <7757da0a-ef3a-44b0-99c2-af9af3e21a0b@linaro.org>
Date: Wed, 12 Aug 2026 13:55:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/2] drm/panel: Add driver for Novatek NT37703 based panels
To: esteuwu@proton.me, Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org
References: <20260811-nt37703-bup-v1-0-34ad42b064a3@proton.me>
 <20260811-nt37703-bup-v1-2-34ad42b064a3@proton.me>
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
In-Reply-To: <20260811-nt37703-bup-v1-2-34ad42b064a3@proton.me>
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

On 8/11/26 07:52, Esteban Urrutia via B4 Relay wrote:
> From: Esteban Urrutia <esteuwu@proton.me>
> 
> Add driver for panels based on this DDIC.
> Initial support is added for the Tianma "v2" panel (no panel model) found
> in the Motorola ThinkPhone by motorola.
> 
> Signed-off-by: Esteban Urrutia <esteuwu@proton.me>
> ---
>   MAINTAINERS                                   |   6 +
>   drivers/gpu/drm/panel/Kconfig                 |  13 +
>   drivers/gpu/drm/panel/Makefile                |   1 +
>   drivers/gpu/drm/panel/panel-novatek-nt37703.c | 467 ++++++++++++++++++++++++++
>   4 files changed, 487 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index da14a58df9e8..e2bb50a8b1af 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8339,6 +8339,12 @@ T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
>   F:	Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
>   F:	drivers/gpu/drm/panel/panel-novatek-nt36672a.c
>   
> +DRM DRIVER FOR NOVATEK NT37703 PANELS
> +M:	Esteban Urrutia <esteuwu@proton.me>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/display/panel/novatek,nt37703.yaml
> +F:	drivers/gpu/drm/panel/panel-novatek-nt37703.c
> +
>   DRM DRIVER FOR NOVATEK NT37801 PANELS
>   M:	Krzysztof Kozlowski <krzk@kernel.org>
>   S:	Maintained
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index cbdf7b8f7f7a..9cd74ceef44e 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -706,6 +706,19 @@ config DRM_PANEL_NOVATEK_NT37700F
>   	  Say Y here if you want to enable support for Novatek NT37700F DSI
>   	  panel module. The panel has a resolution of 1080x2160.
>   
> +config DRM_PANEL_NOVATEK_NT37703
> +	tristate "Novatek NT37703 DSI panel"
> +	depends on OF
> +	depends on DRM_MIPI_DSI
> +	depends on BACKLIGHT_CLASS_DEVICE
> +	select DRM_DISPLAY_DSC_HELPER
> +	select DRM_DISPLAY_HELPER
> +	help
> +	  Say Y or M here if you want to enable support for panels based
> +	  on the Novatek NT37703 display driver IC, such as Tianma
> +	  panels found in some units of the Motorola ThinkPhone by
> +	  motorola.
> +
>   config DRM_PANEL_NOVATEK_NT37801
>   	tristate "Novatek NT37801/NT37810 AMOLED DSI panel"
>   	depends on OF
> diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
> index 3b523cf37833..4a69b2657c5b 100644
> --- a/drivers/gpu/drm/panel/Makefile
> +++ b/drivers/gpu/drm/panel/Makefile
> @@ -68,6 +68,7 @@ obj-$(CONFIG_DRM_PANEL_NOVATEK_NT36536) += panel-novatek-nt36536.o
>   obj-$(CONFIG_DRM_PANEL_NOVATEK_NT36672A) += panel-novatek-nt36672a.o
>   obj-$(CONFIG_DRM_PANEL_NOVATEK_NT36672E) += panel-novatek-nt36672e.o
>   obj-$(CONFIG_DRM_PANEL_NOVATEK_NT37700F) += panel-novatek-nt37700f.o
> +obj-$(CONFIG_DRM_PANEL_NOVATEK_NT37703) += panel-novatek-nt37703.o
>   obj-$(CONFIG_DRM_PANEL_NOVATEK_NT37801) += panel-novatek-nt37801.o
>   obj-$(CONFIG_DRM_PANEL_NOVATEK_NT39016) += panel-novatek-nt39016.o
>   obj-$(CONFIG_DRM_PANEL_MANTIX_MLAF057WE51) += panel-mantix-mlaf057we51.o
> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt37703.c b/drivers/gpu/drm/panel/panel-novatek-nt37703.c
> new file mode 100644
> index 000000000000..5858bf12a310
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt37703.c
> @@ -0,0 +1,467 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Driver for Novatek NT37703 based MIPI DSI panels
> + *
> + * Multiple panel support based on Novatek NT36523 driver
> + * Per panel DSC support based on Ilitek ILI9882T driver
> + *
> + * Copyright (c) 2026 Esteban Urrutia <esteuwu@proton.me>
> + */
> +
> +#include <linux/backlight.h>
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
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
> +#define DSC_BPG_OFFSET(x)		((u8) ((x) & DSC_RANGE_BPG_OFFSET_MASK))
> +#define NT37703_DCS_SWITCH_PAGE		0xf0
> +
> +#define nt37703_cmd_test_on(ctx)	mipi_dsi_dcs_write_seq_multi((ctx), 0xff, 0xaa, 0x55, \
> +								     0xa5, 0x80)
> +#define nt37703_switch_page(ctx, page)	mipi_dsi_dcs_write_seq_multi((ctx), \
> +								     NT37703_DCS_SWITCH_PAGE, \
> +								     0x55, 0xaa, 0x52, 0x08, (page))
> +
> +struct panel_info {
> +	struct drm_panel panel;
> +	const struct panel_desc *desc;
> +	struct mipi_dsi_device *dsi;
> +	struct drm_dsc_config dsc;
> +	struct regulator_bulk_data *supplies;
> +	struct gpio_desc *reset_gpio;
> +};
> +
> +struct panel_desc {
> +	unsigned int width_mm;
> +	unsigned int height_mm;
> +
> +	unsigned int lanes;
> +	unsigned long mode_flags;
> +	enum mipi_dsi_pixel_format format;
> +
> +	const struct drm_display_mode *modes;
> +	unsigned int num_modes;
> +	int (*init_sequence)(struct panel_info *pinfo);
> +	const struct drm_dsc_config *dsc;
> +};
> +
> +/*
> + * These parameters are applied when using DSC 1.1 and when the DSC configuration specifies 10 b.p.c
> + * and 8 b.p.p
> + */
> +static const struct drm_dsc_rc_range_parameters nt37703_rc_range_params[DSC_NUM_BUF_RANGES] = {
> +	{ 0,  8,  DSC_BPG_OFFSET(2)   },
> +	{ 4,  8,  DSC_BPG_OFFSET(0)   },
> +	{ 5,  9,  DSC_BPG_OFFSET(0)   },
> +	{ 5,  10, DSC_BPG_OFFSET(-2)  },
> +	{ 7,  11, DSC_BPG_OFFSET(-4)  },
> +	{ 7,  11, DSC_BPG_OFFSET(-6)  },
> +	{ 7,  11, DSC_BPG_OFFSET(-8)  },
> +	{ 7,  12, DSC_BPG_OFFSET(-8)  },
> +	{ 7,  13, DSC_BPG_OFFSET(-8)  },
> +	{ 8,  14, DSC_BPG_OFFSET(-10) },
> +	{ 9,  14, DSC_BPG_OFFSET(-10) },
> +	{ 9,  15, DSC_BPG_OFFSET(-10) },
> +	{ 9,  15, DSC_BPG_OFFSET(-12) },
> +	{ 12, 16, DSC_BPG_OFFSET(-12) },
> +	{ 16, 17, DSC_BPG_OFFSET(-12) },
> +};
> +
> +static const struct regulator_bulk_data nt37703_supplies[] = {
> +	{ .supply = "avdd"  },
> +	{ .supply = "elvdd" },
> +	{ .supply = "elvss" },
> +	{ .supply = "vci"   },
> +	{ .supply = "vdd"   },
> +	{ .supply = "vddi"  },
> +};
> +
> +static inline struct panel_info *to_panel_info(struct drm_panel *panel)
> +{
> +	return container_of_const(panel, struct panel_info, panel);
> +}
> +
> +static void nt37703_reset(struct panel_info *pinfo)
> +{
> +	gpiod_set_value_cansleep(pinfo->reset_gpio, 0);
> +	usleep_range(1000, 2000);
> +	gpiod_set_value_cansleep(pinfo->reset_gpio, 1);
> +	usleep_range(1000, 2000);
> +	gpiod_set_value_cansleep(pinfo->reset_gpio, 0);
> +	usleep_range(10000, 11000);
> +}
> +
> +static int nt37703_off(struct panel_info *pinfo)
> +{
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = pinfo->dsi };
> +
> +	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
> +	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
> +	mipi_dsi_msleep(&dsi_ctx, 120);
> +
> +	return dsi_ctx.accum_err;
> +}
> +
> +static int nt37703_prepare(struct drm_panel *panel)
> +{
> +	struct panel_info *pinfo = to_panel_info(panel);
> +	struct device *dev = &pinfo->dsi->dev;
> +	struct drm_dsc_picture_parameter_set pps;
> +	int ret;
> +	int i;
> +
> +	ret = regulator_bulk_enable(ARRAY_SIZE(nt37703_supplies), pinfo->supplies);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to enable regulators: %d\n", ret);
> +		return ret;
> +	}
> +
> +	nt37703_reset(pinfo);
> +
> +	ret = pinfo->desc->init_sequence(pinfo);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to initialize panel: %d\n", ret);
> +		gpiod_set_value_cansleep(pinfo->reset_gpio, 1);
> +		regulator_bulk_disable(ARRAY_SIZE(nt37703_supplies), pinfo->supplies);
> +		return ret;
> +	}
> +
> +	/*
> +	 * For some reason this DDIC uses different parameters for the RC ranges under certain DSC
> +	 * configurations.
> +	 * Not applying them results in heavy visual glitches, so do so if all conditions are met.
> +	 */
> +	if (pinfo->dsc.dsc_version_major == 1 && pinfo->dsc.dsc_version_minor == 1 &&
> +	    pinfo->dsc.bits_per_component == 10 && pinfo->dsc.bits_per_pixel == 8 << 4) {
> +		for (i = 0; i < DSC_NUM_BUF_RANGES; i++) {
> +			pinfo->dsc.rc_range_params[i].range_min_qp =
> +				nt37703_rc_range_params[i].range_min_qp;
> +			pinfo->dsc.rc_range_params[i].range_max_qp =
> +				nt37703_rc_range_params[i].range_max_qp;
> +			pinfo->dsc.rc_range_params[i].range_bpg_offset =
> +				nt37703_rc_range_params[i].range_bpg_offset;
> +		}
> +	}
> +
> +	/*
> +	 * Given drm_dsc_setup_rc_params() inconditionally overrides certain members in pinfo->dsc
> +	 * that may have been set in pinfo->desc->dsc, override these members once more with what's
> +	 * found in pinfo->desc->dsc.
> +	 */
> +	if (pinfo->desc->dsc->first_line_bpg_offset)
> +		pinfo->dsc.first_line_bpg_offset = pinfo->desc->dsc->first_line_bpg_offset;
> +
> +	drm_dsc_pps_payload_pack(&pps, &pinfo->dsc);
> +
> +	ret = mipi_dsi_picture_parameter_set(pinfo->dsi, &pps);
> +	if (ret < 0) {
> +		dev_err(panel->dev, "Failed to transmit PPS: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = mipi_dsi_compression_mode(pinfo->dsi, true);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to enable compression mode: %d\n", ret);
> +		return ret;
> +	}
> +
> +	msleep(28);
> +
> +	return 0;
> +}
> +
> +static int nt37703_unprepare(struct drm_panel *panel)
> +{
> +	struct panel_info *pinfo = to_panel_info(panel);
> +	struct device *dev = &pinfo->dsi->dev;
> +	int ret;
> +
> +	ret = nt37703_off(pinfo);
> +	if (ret < 0)
> +		dev_err(dev, "Failed to un-initialize panel: %d\n", ret);
> +
> +	gpiod_set_value_cansleep(pinfo->reset_gpio, 1);
> +	regulator_bulk_disable(ARRAY_SIZE(nt37703_supplies), pinfo->supplies);
> +
> +	return 0;
> +}
> +
> +static int nt37703_get_modes(struct drm_panel *panel, struct drm_connector *connector)
> +{
> +	struct panel_info *pinfo = to_panel_info(panel);
> +	int i;
> +
> +	for (i = 0; i < pinfo->desc->num_modes; i++) {
> +		const struct drm_display_mode *m = &pinfo->desc->modes[i];
> +		struct drm_display_mode *mode;
> +
> +		mode = drm_mode_duplicate(connector->dev, m);
> +		if (!mode) {
> +			dev_err(panel->dev, "Failed to add mode %ux%u@%u\n", m->hdisplay,
> +				m->vdisplay, drm_mode_vrefresh(m));
> +			return -ENOMEM;
> +		}
> +
> +		mode->type = DRM_MODE_TYPE_DRIVER;
> +		if (i == 0)
> +			mode->type |= DRM_MODE_TYPE_PREFERRED;
> +
> +		drm_mode_set_name(mode);
> +		drm_mode_probed_add(connector, mode);
> +	}
> +
> +	connector->display_info.width_mm = pinfo->desc->width_mm;
> +	connector->display_info.height_mm = pinfo->desc->height_mm;
> +
> +	return pinfo->desc->num_modes;

The only supported panel only supports a single mode, just support
a single mode for now and drop this open coded support for multiple modes.

You can add it later if somehow you need multiple modes.

> +}
> +
> +static const struct drm_panel_funcs nt37703_panel_funcs = {
> +	.prepare = nt37703_prepare,
> +	.unprepare = nt37703_unprepare,
> +	.get_modes = nt37703_get_modes,
> +};
> +
> +static int nt37703_bl_update_status(struct backlight_device *bl)
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
> +static int nt37703_bl_get_brightness(struct backlight_device *bl)
> +{
> +	struct mipi_dsi_device *dsi = bl_get_data(bl);
> +	u16 brightness;
> +	int ret;
> +
> +	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
> +
> +	ret = mipi_dsi_dcs_get_display_brightness_large(dsi, &brightness);
> +	if (ret < 0)
> +		return ret;
> +
> +	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
> +
> +	return brightness;
> +}
> +
> +static const struct backlight_ops nt37703_bl_ops = {
> +	.update_status = nt37703_bl_update_status,
> +	.get_brightness = nt37703_bl_get_brightness,
> +};
> +
> +static struct backlight_device *nt37703_create_backlight(struct mipi_dsi_device *dsi)
> +{
> +	struct device *dev = &dsi->dev;
> +	const struct backlight_properties props = {
> +		.type = BACKLIGHT_RAW,
> +		.brightness = 2047,
> +		.max_brightness = 4095,
> +	};
> +
> +	return devm_backlight_device_register(dev, dev_name(dev), dev, dsi, &nt37703_bl_ops,
> +					      &props);
> +}
> +
> +static const struct drm_display_mode bronco_tianma_modes[] = {
> +	{
> +		.clock = (1080 + 16 + 4 + 16) * (2400 + 44 + 2 + 14) * 144 / 1000,
> +		.hdisplay = 1080,
> +		.hsync_start = 1080 + 16,
> +		.hsync_end = 1080 + 16 + 4,
> +		.htotal = 1080 + 16 + 4 + 16,
> +		.vdisplay = 2400,
> +		.vsync_start = 2400 + 44,
> +		.vsync_end = 2400 + 44 + 2,
> +		.vtotal = 2400 + 44 + 2 + 14,
> +	},
> +};
> +
> +static int bronco_tianma_v2_init_sequence(struct panel_info *pinfo)
> +{
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = pinfo->dsi };
> +
> +	nt37703_switch_page(&dsi_ctx, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x06);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb5, 0x29);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x07);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb5, 0x2b, 0x1b, 0x00, 0x32);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x88, 0x01, 0x02, 0x1b, 0x08, 0x77);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x87, 0x20);
> +	mipi_dsi_dcs_set_column_address_multi(&dsi_ctx, 0, 1080 - 1);
> +	mipi_dsi_dcs_set_page_address_multi(&dsi_ctx, 0, 2400 - 1);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x90, 0x03, 0x03);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x20);
> +	nt37703_cmd_test_on(&dsi_ctx);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x15);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf8, 0x01, 0xe1);
> +	nt37703_cmd_test_on(&dsi_ctx);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x17);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf4, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xff, 0xaa, 0x55, 0xa5, 0x81);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x13);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf9, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xff, 0xaa, 0x55, 0xa5, 0x81);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x3c);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf5, 0x81);
> +	mipi_dsi_dcs_set_tear_on_multi(&dsi_ctx, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
> +	mipi_dsi_dcs_set_display_brightness_multi(&dsi_ctx, 0x0000);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2f, 0x00);
> +	nt37703_switch_page(&dsi_ctx, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x03);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc7, 0x47);
> +	nt37703_switch_page(&dsi_ctx, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0xc4);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb2, 0x09, 0x84, 0x09, 0x84, 0x09, 0x84, 0x16,
> +				     0xd6);
> +	nt37703_switch_page(&dsi_ctx, 0x03);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x33);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc6, 0x00, 0x18, 0x00, 0x18, 0x00, 0x18, 0x00,
> +				     0x18);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2f, 0x83);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x8b, 0x00, 0x00);
> +	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> +	mipi_dsi_msleep(&dsi_ctx, 120);
> +	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
> +
> +	return dsi_ctx.accum_err;
> +}
> +
> +static const struct drm_dsc_config bronco_tianma_dsc = {
> +	.dsc_version_major = 1,
> +	.dsc_version_minor = 1,
> +	.slice_height = 20,
> +	.slice_width = 540,
> +	.slice_count = 2,		/* 1080 / slice_width */
> +	.bits_per_component = 10,
> +	.bits_per_pixel = 8 << 4,	/* 4 fractional bits  */
> +	.block_pred_enable = true,
> +	.first_line_bpg_offset = 13,
> +};
> +
> +static const struct panel_desc bronco_tianma_v2_desc = {
> +	.modes = bronco_tianma_modes,
> +	.num_modes = ARRAY_SIZE(bronco_tianma_modes),
> +	.width_mm = 68,
> +	.height_mm = 152,
> +	.lanes = 4,
> +	.format = MIPI_DSI_FMT_RGB101010,
> +	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_NO_EOT_PACKET |
> +		      MIPI_DSI_CLOCK_NON_CONTINUOUS | MIPI_DSI_MODE_LPM |
> +		      MIPI_DSI_MODE_DSC_ALL_SLICES_IN_PKT;
> +	.init_sequence = bronco_tianma_v2_init_sequence,
> +	.dsc = &bronco_tianma_dsc,
> +};
> +
> +static int nt37703_probe(struct mipi_dsi_device *dsi)
> +{
> +	struct device *dev = &dsi->dev;
> +	struct panel_info *pinfo;
> +	int ret;
> +
> +	pinfo = devm_drm_panel_alloc(dev, struct panel_info, panel, &nt37703_panel_funcs,
> +				     DRM_MODE_CONNECTOR_DSI);
> +	if (IS_ERR(pinfo))
> +		return PTR_ERR(pinfo);
> +
> +	pinfo->desc = of_device_get_match_data(dev);
> +	if (IS_ERR(pinfo->desc))
> +		return PTR_ERR(pinfo->desc);
> +
> +	ret = devm_regulator_bulk_get_const(dev, ARRAY_SIZE(nt37703_supplies), nt37703_supplies,
> +					    &pinfo->supplies);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to get regulators\n");
> +
> +	pinfo->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(pinfo->reset_gpio))
> +		return dev_err_probe(dev, PTR_ERR(pinfo->reset_gpio),
> +				     "Failed to get reset-gpios\n");
> +
> +	pinfo->dsi = dsi;
> +	mipi_dsi_set_drvdata(dsi, pinfo);
> +
> +	dsi->lanes = pinfo->desc->lanes;
> +	dsi->format = pinfo->desc->format;
> +	dsi->mode_flags = pinfo->desc->mode_flags;
> +
> +	pinfo->panel.prepare_prev_first = true;
> +
> +	pinfo->panel.backlight = nt37703_create_backlight(dsi);
> +	if (IS_ERR(pinfo->panel.backlight))
> +		return dev_err_probe(dev, PTR_ERR(pinfo->panel.backlight),
> +				     "Failed to create backlight\n");
> +
> +	drm_panel_add(&pinfo->panel);

Use devm_ variant

> +
> +	/* This panel only supports DSC; unconditionally enable it */
> +	pinfo->dsc = *(pinfo->desc->dsc);
> +	dsi->dsc = &pinfo->dsc;
> +
> +	ret = mipi_dsi_attach(dsi);

Use devm_ variant

> +	if (ret < 0) {
> +		drm_panel_remove(&pinfo->panel);
> +		return dev_err_probe(dev, ret, "Failed to attach to DSI host\n");
> +	}
> +
> +	return 0;
> +}
> +
> +static void nt37703_remove(struct mipi_dsi_device *dsi)
> +{
> +	struct panel_info *pinfo = mipi_dsi_get_drvdata(dsi);
> +	int ret;
> +
> +	ret = mipi_dsi_detach(dsi);
> +	if (ret < 0)
> +		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
> +
> +	drm_panel_remove(&pinfo->panel);
> +}

And drop the remove()

Thanks.
Neil

> +
> +static const struct of_device_id nt37703_of_match[] = {
> +	{
> +		.compatible = "motorola,bronco-tianma-v2-nt37703",
> +		.data = &bronco_tianma_v2_desc,
> +	},
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, nt37703_of_match);
> +
> +static struct mipi_dsi_driver nt37703_driver = {
> +	.probe = nt37703_probe,
> +	.remove = nt37703_remove,
> +	.driver = {
> +		.name = "panel-novatek-nt37703",
> +		.of_match_table = nt37703_of_match,
> +	},
> +};
> +module_mipi_dsi_driver(nt37703_driver);
> +
> +MODULE_AUTHOR("Esteban Urrutia <esteuwu@proton.me>");
> +MODULE_DESCRIPTION("DRM driver for Novatek NT37703 based MIPI DSI panels");
> +MODULE_LICENSE("GPL");
> 

