Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C170CCD4F49
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 14:29:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38A5710E895;
	Mon, 18 May 2026 14:29:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rB6t5UFa";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7A0D10E895
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 14:29:07 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-44a74032ff8so1632678f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 07:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779114546; x=1779719346; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=TTdFtAK8+JT9gdb6CdwgGQw7SyxlaTVSzX+SPPMdh5A=;
 b=rB6t5UFaS3485HZm3lMacX3hNz5x6F3TOdnYdD8MdERTMHn0Ea65TvYeOuw0Ua2dZ7
 7503hwXTXzBlNOd2IdceOp78dRQth/6dd5vJoL7j5gbUyvVYQT0E0up6sARLMpWhollR
 +ra+rO5nj0S7XYfrhIqhdxwgu/9ONTjjgLOuwF2IV8uAKZ90BrM1WCSHQWn+AD74lGYA
 /TUd2JWsuML0TnmA8xfijaAVNzyaVUrbxE8aTcgEwV/KFEKsckX2FkKf9K07TVuxdRaL
 6+TC1j8Yg3G5PZA1WlObSa/KsOVbqcfIvIivxe4ImZcY2t8+jX0txYORw1vIHBR+ZQeQ
 trYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779114546; x=1779719346;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TTdFtAK8+JT9gdb6CdwgGQw7SyxlaTVSzX+SPPMdh5A=;
 b=LQDWzeUv9dlS6ERObOKqJGtyk7utJOMWRZgCZ6WgJwP4sYPJS8bFpsrlztguyQsVt3
 +0WSwivwvVg0UlVmMhV7dAKHwMDvtAP5cpcOpNjOQ1IfBnm325RTAIuq9cMU3aD3CJwB
 aCtZUl7Dl5SOPbqoLAvdEum24APBd/CE3YGZHhUX12E52N4dgXHiAMZ1RlWFkjSoJbVX
 1jGT8e8GP5hpx9f6HorvWqUX2hF3KaZ75b7Y6dYrwHgF3dmgF0tVXGzTur+Wk3WAQij4
 HlZ2AuOyh6kPWrj4s0HwZvfjergLsawAdnQC4AUy6zNR6DO3ywQzS1gd9dN3RAobrtGP
 dyhQ==
X-Gm-Message-State: AOJu0Yy0sbBRjaQJzgk0eTw0VizEg1Au7KvoMnR75KD3IcFvK8IsYlzR
 IOVo2kVZnas6pFADRyotBS7hnVHxt64YkufSuPhZNr8ssy5apuQGHR6acW1mkUE48kc=
X-Gm-Gg: Acq92OEl+PoUJ0qgaLUoUYEga4XFocENKNZjbSgfOuadBQgCv42eU2gGyngxdGTnhyg
 CcPyWB0oKUzwfLaEsWl41aNrECryN3LxXmDmKYOKPNABRbQHDMI5LQyJJmKDLsjtCrXFAwfIsXm
 tYNzayzezwf0vAjTxLAdhOxnvtdXjUfHUAullkhWGoHVHry2jQanTemPCThUyxWNoMUtQph/WFy
 u9wMOXyUpssFiZ0GruG2BYLDB6dWfIYaIV92Rsep0OyBEI0b+qEUazQ6+ykSYvBw+CIskDvV24P
 zxIaLGLCbUs3zxaYkHlI/R37WpNluYAIj5yuQFUKpF7WQ9LNQIv5L2nPgPEMiJaf0a/gu5X1DWY
 fwo7+wyCNBPmRh1/HNnPZEDyt4/6IzDfpPllIfwQiPx+YTdd/2ksW7/xBpwLZvgUYfmKnXJ9BOw
 CmlX8xdbzn3FsjFmrt0Z6MHZr8ZBPmyoLJl6kTeuCNvkHCsVnO9ieBdr0kFAyyvja5VwwVitMwZ
 FVhlCTBZW7SRC/yUA==
X-Received: by 2002:a5d:588f:0:b0:455:70bc:216d with SMTP id
 ffacd0b85a97d-45e5c589054mr25285488f8f.12.1779114546099; 
 Mon, 18 May 2026 07:29:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:1029:e3c5:362e:1250?
 ([2a01:e0a:106d:1080:1029:e3c5:362e:1250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da15a5653sm38289605f8f.35.2026.05.18.07.29.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 07:29:05 -0700 (PDT)
Message-ID: <6dd8f137-a4df-4602-9536-b73abff5e7d1@linaro.org>
Date: Mon, 18 May 2026 16:29:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3 2/2] drm/panel: Add panel driver for Chipone ICNA35XX
 based panels
To: webgeek1234@gmail.com, Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Teguh Sobirin <teguh@sobir.in>
References: <20260514-icna35xx-v3-0-c304f04c32c4@gmail.com>
 <20260514-icna35xx-v3-2-c304f04c32c4@gmail.com>
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
In-Reply-To: <20260514-icna35xx-v3-2-c304f04c32c4@gmail.com>
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

On 5/14/26 23:29, Aaron Kling via B4 Relay wrote:
> From: Teguh Sobirin <teguh@sobir.in>
> 
> This adds support for the ICNA3512 and ICNA3520 DDICs used in both the
> AYN Odin 2 Portal and Ayaneo Pocket DS top panel respectively and for
> for both the AYN Odin 3 and the AYN Thor top panel respectively.
> 
> These all have unique compatibles because the panels themselves are
> likely unique hardware with only the ddic's and thus api and driver
> handling shared.
> 
> Signed-off-by: Teguh Sobirin <teguh@sobir.in>
> Co-developed-by: Aaron Kling <webgeek1234@gmail.com>
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>   drivers/gpu/drm/panel/Kconfig                  |  11 +
>   drivers/gpu/drm/panel/Makefile                 |   1 +
>   drivers/gpu/drm/panel/panel-chipone-icna35xx.c | 619 +++++++++++++++++++++++++
>   3 files changed, 631 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index 7450b27622a233..1368b5a0b6c912 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -105,6 +105,17 @@ config DRM_PANEL_BOE_TV101WUM_LL2
>   	  Say Y here if you want to support for BOE TV101WUM-LL2
>   	  WUXGA PANEL DSI Video Mode panel
>   
> +config DRM_PANEL_CHIPONE_ICNA35XX
> +	tristate "Chipone ICNA35XX panel driver"
> +	depends on OF
> +	depends on DRM_MIPI_DSI
> +	depends on BACKLIGHT_CLASS_DEVICE
> +	select DRM_DISPLAY_HELPER
> +	help
> +	  Say Y here if you want to enable support for the panels built
> +	  around the Chipone ICNA3512 and ICNA3520 display controllers,
> +	  such as some Tianma panels used in AYN Odin2 Portal and Thor.
> +
>   config DRM_PANEL_CHIPWEALTH_CH13726A
>   	tristate "CHIPWEALTH CH13726A-based DSI panel"
>   	depends on OF
> diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
> index c2c5cf81711633..d39a8f82fa8c06 100644
> --- a/drivers/gpu/drm/panel/Makefile
> +++ b/drivers/gpu/drm/panel/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_DRM_PANEL_BOE_TD4320) += panel-boe-td4320.o
>   obj-$(CONFIG_DRM_PANEL_BOE_TH101MB31UIG002_28A) += panel-boe-th101mb31ig002-28a.o
>   obj-$(CONFIG_DRM_PANEL_BOE_TV101WUM_LL2) += panel-boe-tv101wum-ll2.o
>   obj-$(CONFIG_DRM_PANEL_BOE_TV101WUM_NL6) += panel-boe-tv101wum-nl6.o
> +obj-$(CONFIG_DRM_PANEL_CHIPONE_ICNA35XX) += panel-chipone-icna35xx.o
>   obj-$(CONFIG_DRM_PANEL_CHIPWEALTH_CH13726A) += panel-chipwealth-ch13726a.o
>   obj-$(CONFIG_DRM_PANEL_DSI_CM) += panel-dsi-cm.o
>   obj-$(CONFIG_DRM_PANEL_LVDS) += panel-lvds.o
> diff --git a/drivers/gpu/drm/panel/panel-chipone-icna35xx.c b/drivers/gpu/drm/panel/panel-chipone-icna35xx.c
> new file mode 100644
> index 00000000000000..958f205a7f4f93
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-chipone-icna35xx.c
> @@ -0,0 +1,619 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Chipone ICNA35XX Driver IC panels driver
> + *
> + * Copyright (c) 2025 Teguh Sobirin <teguh@sobir.in>
> + */
> +
> +#include <linux/backlight.h>
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_graph.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <video/mipi_display.h>
> +
> +#include <drm/display/drm_dsc.h>
> +#include <drm/display/drm_dsc_helper.h>
> +#include <drm/drm_connector.h>
> +#include <drm/drm_crtc.h>
> +#include <drm/drm_mipi_dsi.h>
> +#include <drm/drm_modes.h>
> +#include <drm/drm_panel.h>
> +
> +struct panel_info {
> +	struct drm_panel panel;
> +	struct drm_connector *connector;
> +	struct mipi_dsi_device *dsi;
> +	struct panel_desc *desc;
> +	enum drm_panel_orientation orientation;
> +
> +	struct gpio_desc *reset_gpio;
> +	struct regulator_bulk_data *supplies;
> +};
> +
> +struct panel_desc {
> +	unsigned int width_mm;
> +	unsigned int height_mm;
> +
> +	unsigned int bpc;
> +	unsigned int lanes;
> +	unsigned long mode_flags;
> +	enum mipi_dsi_pixel_format format;
> +
> +	const struct drm_display_mode *modes;
> +	unsigned int num_modes;
> +	int (*init_sequence)(struct panel_info *pinfo);
> +
> +	struct drm_dsc_config dsc;
> +};
> +
> +static const struct regulator_bulk_data panel_supplies[] = {
> +	{ .supply = "vdd" },
> +	{ .supply = "vddio" },
> +	{ .supply = "vci" },
> +	{ .supply = "disp" },
> +	{ .supply = "blvdd" },
> +};
> +
> +static inline struct panel_info *to_panel_info(struct drm_panel *panel)
> +{
> +	return container_of(panel, struct panel_info, panel);
> +}
> +
> +static int icna35xx_get_current_mode(struct panel_info *pinfo)
> +{
> +	struct drm_connector *connector = pinfo->connector;
> +	struct drm_crtc_state *crtc_state;
> +	int i;
> +
> +	/* Return the default (first) mode if no info available yet */
> +	if (!connector->state || !connector->state->crtc)
> +		return 0;
> +
> +	crtc_state = connector->state->crtc->state;
> +
> +	for (i = 0; i < pinfo->desc->num_modes; i++) {
> +		if (drm_mode_match(&crtc_state->mode,
> +				   &pinfo->desc->modes[i],
> +				   DRM_MODE_MATCH_TIMINGS | DRM_MODE_MATCH_CLOCK))
> +			return i;
> +	}
> +
> +	return 0;
> +}

I'm uncertain about that, I think you should stick to a single mode for
now until we properly add the atomic panel API variant.

Please see https://lore.kernel.org/all/20260425001130.233935-1-val@packett.cool/
for a first version of that, but it may need more work to make it right.

> +
> +static int icna3512_init_sequence(struct panel_info *pinfo)
> +{
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = pinfo->dsi };
> +	struct drm_dsc_picture_parameter_set pps;
> +
> +	int cur_mode = icna35xx_get_current_mode(pinfo);
> +	int cur_vrefresh = drm_mode_vrefresh(&pinfo->desc->modes[cur_mode]);
> +
> +	pinfo->dsi->mode_flags |= MIPI_DSI_MODE_LPM;
> +
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x9C, 0xA5, 0xA5);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xFD, 0x5A, 0x5A);
> +
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x53, 0xE0);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x35, 0x00);
> +
> +	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> +
> +	mipi_dsi_msleep(&dsi_ctx, 120);
> +
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x9F, 0x0F);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xCE, 0x22);
> +
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x9F, 0x01);
> +	if (cur_vrefresh == 165) {
> +		mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x48, 0x20);
> +	} else if (cur_vrefresh == 144) {
> +		mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xB3,
> +			0x00, 0xE0, 0xA0, 0x10, 0xC8, 0x00, 0x02, 0x83,
> +			0x00, 0x10, 0x14, 0x00, 0x00, 0xC3, 0x00, 0x10,
> +			0x14, 0x00, 0x00, 0xE0, 0x00, 0x10, 0x14, 0x00,
> +			0x00, 0xE0, 0xA0, 0x10, 0xC8, 0x22, 0x18, 0x18,
> +			0x18, 0x18, 0x18);
> +		mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x9F, 0x07);
> +		mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xB5,
> +			0x04, 0x0A, 0x08, 0x0A, 0x04, 0x00, 0xC4);
> +		mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xD9,
> +			0x66, 0xE4, 0xE4, 0x66, 0xE4, 0xE4, 0x00, 0xC4,
> +			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00);
> +		mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xCE,
> +			0x01, 0x01, 0x01, 0x01, 0x04, 0x07, 0xA4);
> +		mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x48, 0x30);
> +	} else if (cur_vrefresh == 120) {
> +		mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xB3,
> +			0x00, 0xE0, 0xA0, 0x10, 0xC8, 0x00, 0x02, 0x83,
> +			0x00, 0x10, 0x14, 0x00, 0x00, 0xC3, 0x00, 0x10,
> +			0x14, 0x00, 0x00, 0xE0, 0x10, 0x10, 0x9C, 0x00,
> +			0x00, 0xE0, 0xA0, 0x10, 0xC8, 0x22, 0x18, 0x18,
> +			0x18, 0x18, 0x18);
> +		mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x9F, 0x07);
> +		mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xB5,
> +			0x04, 0x0C, 0x08, 0x0C, 0x04, 0x00, 0xC4);
> +		mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xD9,
> +			0x88, 0x40, 0x40, 0x88, 0x40, 0x40, 0x00, 0xEB,
> +			0x11, 0xFF);
> +		mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xCE,
> +			0x01, 0x01, 0x01, 0x01, 0x04, 0x09, 0x2C);
> +		mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x48, 0x30);
> +	} else if (cur_vrefresh == 90) {
> +		mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xB3,
> +			0x00, 0xE0, 0x40, 0x10, 0xA8, 0x00);
> +		mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x9F, 0x07);
> +		mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xB2,
> +			0x04, 0x10, 0x08, 0x0C, 0x04, 0x00, 0xC4);
> +		mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xD3,
> +			0x55, 0x80, 0x80, 0x55, 0x80, 0xB0, 0x00, 0x9C,
> +			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00);
> +		mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xCB,
> +			0x01, 0x01, 0x01, 0x01, 0x04, 0x06, 0x1C);
> +		mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x48, 0x00);
> +	} else {
> +		mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xB3,
> +			0x00, 0xE0, 0xA0, 0x10, 0xC8, 0x00);
> +		mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x9F, 0x07);
> +		mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xB2,
> +			0x04, 0x18, 0x08, 0x0C, 0x02, 0x00, 0xC4);
> +		mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xD3,
> +			0x88, 0x4A, 0x4A, 0x88, 0x4A, 0x4A, 0x00, 0xEB,
> +			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00);
> +		mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xCB,
> +			0x01, 0x01, 0x01, 0x01, 0x04, 0x2C);
> +		mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x48, 0x00);
> +	}
> +
> +	drm_dsc_pps_payload_pack(&pps, &pinfo->desc->dsc);
> +	mipi_dsi_picture_parameter_set_multi(&dsi_ctx, &pps);
> +
> +	mipi_dsi_msleep(&dsi_ctx, 20);
> +
> +	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
> +
> +	return dsi_ctx.accum_err;
> +}
> +
> +static int icna3520_init_sequence(struct panel_info *pinfo)
> +{
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = pinfo->dsi };
> +	struct drm_dsc_picture_parameter_set pps;
> +
> +	int cur_mode = icna35xx_get_current_mode(pinfo);
> +	int cur_vrefresh = drm_mode_vrefresh(&pinfo->desc->modes[cur_mode]);
> +
> +	pinfo->dsi->mode_flags |= MIPI_DSI_MODE_LPM;
> +
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x9C, 0xA5, 0xA5);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xFD, 0x5A, 0x5A);
> +
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x53, 0xE0);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x35, 0x00);
> +
> +	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> +
> +	mipi_dsi_msleep(&dsi_ctx, 120);
> +
> +	if (cur_vrefresh == 120) {
> +		mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x48, 0x00);
> +		mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x9F, 0x00);
> +		mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xB3,
> +			0x00, 0xD8, 0x00, 0x1C, 0x00, 0x4C);
> +	} else {
> +		mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x48, 0x10);
> +		mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x9F, 0x00);
> +		mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xB3,
> +			0x00, 0xDB, 0x00, 0x1C, 0x00, 0x1C, 0x00, 0x00,
> +			0xDB, 0x00, 0x1C, 0x07, 0xD6, 0x00);
> +	}
> +
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x9F, 0x01);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xB2, 0x00);
> +
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x9F, 0x0D);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xB2, 0x27);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xB6, 0x03);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xBB, 0x01);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xB2, 0x24);
> +
> +	drm_dsc_pps_payload_pack(&pps, &pinfo->desc->dsc);
> +	mipi_dsi_picture_parameter_set_multi(&dsi_ctx, &pps);
> +
> +	mipi_dsi_msleep(&dsi_ctx, 20);
> +
> +	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
> +
> +	return dsi_ctx.accum_err;
> +}
> +
> +static const struct drm_display_mode odin2portal_modes[] = {
> +	{
> +		/* 165Hz */
> +		.clock = (1080 + 98 + 1 + 23) * (1920 + 20 + 1 + 15) * 165 / 1000,
> +		.hdisplay = 1080,
> +		.hsync_start = 1080 + 98,
> +		.hsync_end = 1080 + 98 + 1,
> +		.htotal = 1080 + 98 + 1 + 23,
> +		.vdisplay = 1920,
> +		.vsync_start = 1920 + 20,
> +		.vsync_end = 1920 + 20 + 1,
> +		.vtotal = 1920 + 20 + 1 + 15,
> +	},
> +	{
> +		/* 144Hz */
> +		.clock = (1080 + 156 + 1 + 23) * (1920 + 20 + 1 + 15) * 144 / 1000,
> +		.hdisplay = 1080,
> +		.hsync_start = 1080 + 156,
> +		.hsync_end = 1080 + 156 + 1,
> +		.htotal = 1080 + 156 + 1 + 23,
> +		.vdisplay = 1920,
> +		.vsync_start = 1920 + 20,
> +		.vsync_end = 1920 + 20 + 1,
> +		.vtotal = 1920 + 20 + 1 + 15,
> +	},
> +	{
> +		/* 120Hz */
> +		.clock = (1080 + 156 + 1 + 23) * (1920 + 412 + 1 + 15) * 120 / 1000,
> +		.hdisplay = 1080,
> +		.hsync_start = 1080 + 156,
> +		.hsync_end = 1080 + 156 + 1,
> +		.htotal = 1080 + 156 + 1 + 23,
> +		.vdisplay = 1920,
> +		.vsync_start = 1920 + 412,
> +		.vsync_end = 1920 + 412 + 1,
> +		.vtotal = 1920 + 412 + 1 + 15,
> +	},
> +	{
> +		/* 90Hz */
> +		.clock = (1080 + 156 + 1 + 23) * (1920 + 1192 + 1 + 15) * 90 / 1000,
> +		.hdisplay = 1080,
> +		.hsync_start = 1080 + 156,
> +		.hsync_end = 1080 + 156 + 1,
> +		.htotal = 1080 + 156 + 1 + 23,
> +		.vdisplay = 1920,
> +		.vsync_start = 1920 + 1192,
> +		.vsync_end = 1920 + 1192 + 1,
> +		.vtotal = 1920 + 1192 + 1 + 15,
> +	},
> +	{
> +		/* 60Hz */
> +		.clock = (1080 + 156 + 1 + 23) * (1920 + 2760 + 1 + 15) * 60 / 1000,
> +		.hdisplay = 1080,
> +		.hsync_start = 1080 + 156,
> +		.hsync_end = 1080 + 156 + 1,
> +		.htotal = 1080 + 156 + 1 + 23,
> +		.vdisplay = 1920,
> +		.vsync_start = 1920 + 2760,
> +		.vsync_end = 1920 + 2760 + 1,
> +		.vtotal = 1920 + 2760 + 1 + 15,
> +	}
> +};
> +
> +static const struct drm_display_mode thor_top_modes[] = {
> +	{
> +		/* 120Hz */
> +		.clock = (1080 + 24 + 1 + 24) * (1920 + 28 + 1 + 28) * 120 / 1000,
> +		.hdisplay = 1080,
> +		.hsync_start = 1080 + 24,
> +		.hsync_end = 1080 + 24 + 1,
> +		.htotal = 1080 + 24 + 1 + 24,
> +		.vdisplay = 1920,
> +		.vsync_start = 1920 + 28,
> +		.vsync_end = 1920 + 28 + 1,
> +		.vtotal = 1920 + 28 + 1 + 28,
> +	},
> +	{
> +		/* 60Hz */
> +		.clock = (1080 + 24 + 1 + 24) * (1920 + 2006 + 1 + 28) * 60 / 1000,
> +		.hdisplay = 1080,
> +		.hsync_start = 1080 + 24,
> +		.hsync_end = 1080 + 24 + 1,
> +		.htotal = 1080 + 24 + 1 + 24,
> +		.vdisplay = 1920,
> +		.vsync_start = 1920 + 2006,
> +		.vsync_end = 1920 + 2006 + 1,
> +		.vtotal = 1920 + 2006 + 1 + 28,
> +	}
> +};
> +
> +static struct panel_desc odin2portal_desc = {
> +	.modes = odin2portal_modes,
> +	.num_modes = ARRAY_SIZE(odin2portal_modes),
> +	.width_mm = 160,
> +	.height_mm = 89,
> +	.bpc = 8,
> +	.lanes = 4,
> +	.format = MIPI_DSI_FMT_RGB888,
> +	.mode_flags = MIPI_DSI_MODE_NO_EOT_PACKET | MIPI_DSI_CLOCK_NON_CONTINUOUS |
> +			MIPI_DSI_MODE_LPM,
> +	.init_sequence = icna3512_init_sequence,
> +	.dsc = {
> +		.dsc_version_major = 0x1,
> +		.dsc_version_minor = 0x1,
> +		.slice_height = 20,
> +		.slice_width = 540,
> +		.slice_count = 2,
> +		.bits_per_component = 8,
> +		.bits_per_pixel = 8 << 4,
> +		.block_pred_enable = true,
> +	},
> +};
> +
> +static struct panel_desc thor_top_desc = {
> +	.modes = thor_top_modes,
> +	.num_modes = ARRAY_SIZE(thor_top_modes),
> +	.width_mm = 136,
> +	.height_mm = 68,
> +	.bpc = 8,
> +	.lanes = 4,
> +	.format = MIPI_DSI_FMT_RGB888,
> +	.mode_flags =  MIPI_DSI_MODE_NO_EOT_PACKET | MIPI_DSI_CLOCK_NON_CONTINUOUS |
> +			MIPI_DSI_MODE_LPM,
> +	.init_sequence = icna3520_init_sequence,
> +	.dsc = {
> +		.dsc_version_major = 0x1,
> +		.dsc_version_minor = 0x1,
> +		.slice_height = 12,
> +		.slice_width = 540,
> +		.slice_count = 2,
> +		.bits_per_component = 8,
> +		.bits_per_pixel = 8 << 4,
> +		.block_pred_enable = true,
> +	},
> +};
> +
> +static void icna35xx_reset(struct panel_info *pinfo)
> +{
> +	gpiod_set_value_cansleep(pinfo->reset_gpio, 0);
> +	usleep_range(20000, 21000);
> +	gpiod_set_value_cansleep(pinfo->reset_gpio, 1);
> +	usleep_range(20000, 21000);
> +	gpiod_set_value_cansleep(pinfo->reset_gpio, 0);
> +	usleep_range(20000, 21000);
> +}
> +
> +static int icna35xx_prepare(struct drm_panel *panel)
> +{
> +	struct panel_info *pinfo = to_panel_info(panel);
> +	int ret;
> +
> +	ret = regulator_bulk_enable(ARRAY_SIZE(panel_supplies), pinfo->supplies);
> +	if (ret < 0) {
> +		dev_err(panel->dev, "failed to enable regulators: %d\n", ret);
> +		return ret;
> +	}
> +
> +	icna35xx_reset(pinfo);
> +
> +	ret = pinfo->desc->init_sequence(pinfo);
> +	if (ret < 0) {
> +		regulator_bulk_disable(ARRAY_SIZE(panel_supplies), pinfo->supplies);
> +		dev_err(panel->dev, "failed to initialize panel: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int icna35xx_disable(struct drm_panel *panel)
> +{
> +	struct panel_info *pinfo = to_panel_info(panel);
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = pinfo->dsi };
> +
> +	pinfo->dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
> +
> +	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
> +	mipi_dsi_msleep(&dsi_ctx, 50);
> +	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
> +	mipi_dsi_msleep(&dsi_ctx, 120);
> +
> +	return dsi_ctx.accum_err;
> +}
> +
> +static int icna35xx_unprepare(struct drm_panel *panel)
> +{
> +	struct panel_info *pinfo = to_panel_info(panel);
> +
> +	gpiod_set_value_cansleep(pinfo->reset_gpio, 1);
> +	regulator_bulk_disable(ARRAY_SIZE(panel_supplies), pinfo->supplies);
> +
> +	return 0;
> +}
> +
> +static void icna35xx_remove(struct mipi_dsi_device *dsi)
> +{
> +	struct panel_info *pinfo = mipi_dsi_get_drvdata(dsi);
> +	int ret;
> +
> +	ret = mipi_dsi_detach(pinfo->dsi);
> +	if (ret < 0)
> +		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", ret);
> +
> +	drm_panel_remove(&pinfo->panel);
> +}

Weird place for remove, anyway you can drop this when using the devm_ probe calls.

> +
> +static int icna35xx_get_modes(struct drm_panel *panel,
> +			       struct drm_connector *connector)
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
> +			dev_err(panel->dev, "failed to add mode %ux%u@%u\n",
> +				m->hdisplay, m->vdisplay, drm_mode_vrefresh(m));
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
> +	connector->display_info.bpc = pinfo->desc->bpc;
> +	pinfo->connector = connector;
> +
> +	return pinfo->desc->num_modes;
> +}
> +
> +static enum drm_panel_orientation icna35xx_get_orientation(struct drm_panel *panel)
> +{
> +	struct panel_info *pinfo = to_panel_info(panel);
> +
> +	return pinfo->orientation;
> +}
> +
> +static const struct drm_panel_funcs icna35xx_panel_funcs = {
> +	.disable = icna35xx_disable,
> +	.prepare = icna35xx_prepare,
> +	.unprepare = icna35xx_unprepare,
> +	.get_modes = icna35xx_get_modes,
> +	.get_orientation = icna35xx_get_orientation,
> +};
> +
> +static int icna35xx_bl_update_status(struct backlight_device *bl)
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

Add back MIPI_DSI_MODE_LPM even in dsi command error.

> +
> +	return 0;
> +}
> +
> +static int icna35xx_bl_get_brightness(struct backlight_device *bl)
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

Add back MIPI_DSI_MODE_LPM even in dsi command error.

> +
> +	return brightness;
> +}
> +
> +static const struct backlight_ops icna35xx_bl_ops = {
> +	.update_status = icna35xx_bl_update_status,
> +	.get_brightness = icna35xx_bl_get_brightness,
> +};
> +
> +static struct backlight_device *icna35xx_create_backlight(struct mipi_dsi_device *dsi)
> +{
> +	struct device *dev = &dsi->dev;
> +	const struct backlight_properties props = {
> +		.type = BACKLIGHT_RAW,
> +		.brightness = 4096,
> +		.max_brightness = 4096,
> +	};
> +
> +	return devm_backlight_device_register(dev, dev_name(dev), dev, dsi,
> +					      &icna35xx_bl_ops, &props);
> +}
> +
> +static int icna35xx_probe(struct mipi_dsi_device *dsi)
> +{
> +	struct device *dev = &dsi->dev;
> +	struct panel_info *pinfo;
> +	int ret;
> +
> +	pinfo = devm_drm_panel_alloc(dev, __typeof(*pinfo), panel,
> +				     &icna35xx_panel_funcs,
> +				     DRM_MODE_CONNECTOR_DSI);
> +	if (IS_ERR(pinfo))
> +		return PTR_ERR(pinfo);
> +
> +	ret = devm_regulator_bulk_get_const(dev, ARRAY_SIZE(panel_supplies),
> +	panel_supplies, &pinfo->supplies);

Align correctly this second line.

> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to get regulators\n");
> +
> +	pinfo->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(pinfo->reset_gpio))
> +		return dev_err_probe(dev, PTR_ERR(pinfo->reset_gpio), "failed to get reset gpio\n");
> +
> +	pinfo->desc = (struct panel_desc *)of_device_get_match_data(dev);
> +	if (!pinfo->desc)
> +		return -ENODEV;
> +
> +	pinfo->dsi = dsi;
> +	mipi_dsi_set_drvdata(dsi, pinfo);
> +
> +	ret = of_drm_get_panel_orientation(dev->of_node, &pinfo->orientation);
> +	if (ret < 0) {
> +		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, ret);
> +		return ret;
> +	}
> +
> +	pinfo->panel.prepare_prev_first = true;
> +
> +	pinfo->panel.backlight = icna35xx_create_backlight(dsi);
> +	if (IS_ERR(pinfo->panel.backlight))
> +		return dev_err_probe(dev, PTR_ERR(pinfo->panel.backlight),
> +				     "Failed to create backlight\n");
> +
> +	drm_panel_add(&pinfo->panel);

devm_drm_panel_add()

> +
> +	pinfo->dsi->lanes = pinfo->desc->lanes;
> +	pinfo->dsi->format = pinfo->desc->format;
> +	pinfo->dsi->mode_flags = pinfo->desc->mode_flags;
> +	pinfo->dsi->dsc = &pinfo->desc->dsc;
> +
> +	ret = mipi_dsi_attach(pinfo->dsi);

devm_mipi_dsi_attach()

> +	if (ret < 0) {
> +		dev_err_probe(dev, ret, "Failed to attach to DSI host\n");
> +		drm_panel_remove(&pinfo->panel);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id icna35xx_of_match[] = {
> +	{ .compatible = "ayaneo,pocketds-panel-top", .data = &odin2portal_desc },
> +	{ .compatible = "ayntec,odin2portal-panel", .data = &odin2portal_desc },
> +	{ .compatible = "ayntec,odin3-panel", .data = &thor_top_desc },
> +	{ .compatible = "ayntec,thor-panel-top", .data = &thor_top_desc },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, icna35xx_of_match);
> +
> +static struct mipi_dsi_driver icna35xx_driver = {
> +	.probe = icna35xx_probe,
> +	.remove = icna35xx_remove,

Drop

> +	.driver = {
> +		.name = "panel-chipone-icna35xx",
> +		.of_match_table = icna35xx_of_match,
> +	},
> +};
> +module_mipi_dsi_driver(icna35xx_driver);
> +
> +MODULE_AUTHOR("Teguh Sobirin <teguh@sobir.in>");
> +MODULE_DESCRIPTION("DRM driver for Chipone ICNA35XX based MIPI DSI panels");
> +MODULE_LICENSE("GPL");
> 

Thanks,
Neil
