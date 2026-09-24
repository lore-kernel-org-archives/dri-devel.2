Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF9AC98317
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 13:31:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C61110F560;
	Thu, 24 Sep 2026 13:31:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="L36yTx0l";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B32410F559
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 13:31:52 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ccff31419so17806625e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 06:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790256711; x=1790861511; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LlAThN9jWeNROShzdEU7L1H8aD7zdTFmym8b3e4BWaI=;
 b=L36yTx0lYRdkFKrDOqttP1kwx7yzvR2cz8aFTTu5aYgRLCZulFPU3Su/3zJh/ZDNrr
 5YkSTXhYPes0X2GMqpSbOP+yYEQTqHC6MChOea45QP8S8luUqvM3UqIpcujLc+HDNC9J
 zFllFfmDtg04WsdXIiviEuvGA7fI3eXCF4a/M3LcTWG0jPu7JfD+FjMF33BpQDhzuIqZ
 6WcvV/lRIUh1C34tWHU31mc0OMikwO3jJHOGEXN43vYuaVk1X8kmh612+uuclFZNpQFX
 nmJyHRc8J0bs5/LFwqXmVh97Q/RA1n/ToZWqlEUGMy5GOFq0Dn8qnZpDGGdkOEJ/kpX0
 DNXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790256711; x=1790861511;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LlAThN9jWeNROShzdEU7L1H8aD7zdTFmym8b3e4BWaI=;
 b=1wvy0yxqbZLbwUL9cPw/mDoBNjw6qA8dqXWpE4u35JTqfA3CzT2fsWhyz87sVOgP9C
 5WEuWO8SaxvWnYKSLFkGa1U8Jqc89+gyFw14jnLAZpMGFXD4j/CmQXCcUjpe5tR8kVRf
 0p9gigTeqyDInHlqAIuILKWH9HuPt9EtE992Udk3YxoVTz/wr3WZWYWbwP65kTvbDoFy
 PIkAYSq+S4MykFcteg25CJaAyGWaXt+2detHKShRCxTtcY0rhXhdPgV9+9J3OU9VQheK
 a6KDgPb9bB7AL1uL75l0hG3hyg6vCfciksX1VQPKnXBzN9z3zeEJ54aGdIIsJjHneVxG
 zfZQ==
X-Gm-Message-State: AFuF++k/T6Wub5cMpIJUjZNId1nlKnc/coMm6+8myz3Mbtl94AcNI8qh
 eUWUNQ/YXBClxYnsN+NDWbHgA8kmKadN3sjwE4/VPZcBBS0S/xkEKqN1/x8n3mPtmes=
X-Gm-Gg: AYBFou0N5uOuxe7Romg/8MB651KXrgdEXziLVYkgHdAxfIQy+dEnlF2p8hgNWFAXyha
 dgqNk5r2B/q+Bm5d3rsRLvLGBuyGVxIQLX7Qp/jrFADvmuPkl4m48VRHCztIlyTyWrtI1esMdst
 F7NBRCv97xhoVJ/ONuppLq2N3XPuI3VukIhpsAcgxeXONB7HEx7RSIq+EEpop/z3XTvyfsRmY+5
 lmPUXkHuO38jaUH9Eri+n7mrjIrbWR+M+sUX2PE4XcQCZGnPWLp3b3+LqbWWNLiw86uWjSNJcAh
 MDlyc+LjawsqMsanmSqRa9LRaNnwo7Q3uwaHsdRmjFPAcMo/S8R7vIpmKuf2v6aqmVa+PUXs6GM
 /j5KIL6A14/ssUll6kXMhcNLo4pfhhIPo1ExtXQcM5qntvnnjTmpaOMpCjjOcoTCAS+/YYREip5
 fAmWkN3NDF9p6dISRnNemM5Kqb2voN512PqI4caRifKmkghP89iKvz2Tm5F6WdeEMyt8gsGWk5k
 tEwk4ZliNqLXxR+3Vo5kNtYYuufvzspGEyNsy6RQw4WtBAj5UOXKUI=
X-Received: by 2002:a05:600c:1d06:b0:49e:69ff:c6b1 with SMTP id
 5b1f17b1804b1-49fe7bcc25dmr34669325e9.31.1790256710437; 
 Thu, 24 Sep 2026 06:31:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:336e:a1a0:8f96:9f7a?
 ([2a01:e0a:106d:1080:336e:a1a0:8f96:9f7a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5de4de4sm74488925e9.8.2026.09.24.06.31.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2026 06:31:48 -0700 (PDT)
Message-ID: <24774a8c-f832-4696-a176-da7e18292662@linaro.org>
Date: Thu, 24 Sep 2026 15:31:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 2/3] drivers: gpu: drm: panel: Add BOE NT51021 driver
To: Nickolay Goppen <setotau@mainlining.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ryan Brue <ryanbrue.dev@gmail.com>,
 Alexey Minnekhanov <alexeymin@minlexx.ru>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20260917-qcom-novatek-nt51021-panels-v4-0-30afbc35d70c@mainlining.org>
 <20260917-qcom-novatek-nt51021-panels-v4-2-30afbc35d70c@mainlining.org>
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
In-Reply-To: <20260917-qcom-novatek-nt51021-panels-v4-2-30afbc35d70c@mainlining.org>
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

On 9/17/26 14:51, Nickolay Goppen wrote:
> Add driver for BOE NT51021-based 8-inch and 10-inch DSI video mode
> panels used in Xiaomi Mi Pad 4, Mi Pad 4 Plus (xiaomi-clover)
> and Amazon Fire HD 10 (2017) (amazon-suez) tablets.
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
> The register sequence of the TV101WUM-NM0 is the BOE branch of
> init_lcm_registers() in drivers/misc/mediatek/lcm/nt51021_wuxga_dsi_vdo/
> in the Fire OS 3.18 tree, command for command, with only a 120 ms wait
> after sleep-out added where the vendor waits its trailing 5 ms.
> The 0x8f 0xa5 and 0x8f 0x00 that bracket it are the vendor's command
> interface selection, sent on every board that is not an early proto or
> HVT unit.
> 
> It is much shorter than boe_tv101wum_nx0_init() because this module is
> left on its own factory trim. NT51021 R8CH selects whether V1/V14, gamma
> and HAOP come from the panel's OTP memory or from control registers, and
> the 0x8c 0x80 here leaves all three on OTP, where the NX0's 0x8e
> switches
> them to registers so that the three pages of gamma it then writes take
> effect. So the absent gamma is deliberate rather than an omission, and
> the differing 0x8c is its consequence. CABC is likewise untouched
> because
> the vendor drives it over I2C from the backlight path. What is left is
> 0xc0 and 0xc8, which the public NT51021 specification does not describe;
> everything else this sequence touches carries the same value as the
> other
> two panels, including the terminal resistor, TP_SYNC, the MIPI Rx drive
> strength and all three test modes.
> 
> The timings are the vendor's lcm_get_params(): hsync 1, hbp 32, hfp 110,
> vsync 1, vbp 14, vfp 11, so htotal 1343 and vtotal 1946. The pixel clock
> follows the vendor's PLL_CLOCK = 490, which after DDR is 980 Mbps per
> lane and over four lanes at 24bpp is 163.33 MHz, so 62.5 Hz. The
> bootloader leaves the MIPI TX PLL at that rate: read back before the
> kernel touches it, this board's PLL decodes to exactly 980 Mbps per
> lane, so the panel is already there when the kernel takes over.
> 
> The front porch is the vendor's declared 110 rather than the smaller
> value its own DSI driver ends up running. That driver also sets
> clk_lp_per_line_enable, which makes ddp_dsi_config() overwrite HFP_WC
> after the declared timing is programmed, shrinking it to leave just
> enough room to take the clock lane to LP and back. That is a
> controller-side workaround rather than a panel property, and it
> contradicts the cont_clock = 1 set beside it, which disables the very LP
> transition it makes room for. Mainline mtk_dsi handles the clock lane
> itself, so the panel's declared timing is the right thing to carry here.
> 
> The vendor asks for SYNC_EVENT_VDO_MODE with cont_clock = 1 rather than
> burst, so make mode_flags per variant instead of fixed in probe(). The
> two existing panels keep the flags they had. Burst was also tried on
> this hardware and worked, but the vendor configuration is the one the
> module is characterised for.
> 
> The physical size is the datasheet active area, 216.576 x 135.36 mm,
> which measures 216 x 135 on the glass. The vendor's declared a
> physical_width = 136 and physical_height = 221, which appears to be an
> error. The size of the test unit was physically measured. 1200/136 and
> 1920/221 disagree by 1.5%.
> 
> The vendor's bootloader and kernel both carry a second register sequence
> for the Innolux module this board second-sources against, selected from
> two board ID straps. No Innolux unit was available, so that sequence is
> left out rather than carried untested; however, the Innolux part number
> was identified as "P101KDA-AB0", should someone with that glass need to
> upstream support in the future.
> 
> Tested on the Amazon Fire HD 10 (2017) driven by mediatek-drm: 1200x1920
> at 62.5 Hz across a cold boot, display off and on cycles and a
> suspend/resume, with the MIPI TX PLL reading back at the intended rate
> every time.
> 
> Assisted-by: LLM
> Tested-by: Ryan Brue <ryanbrue.dev@gmail.com> # Amazon Fire HD 10 (2017), boe,tv101wum-nm0
> Co-developed-by: Ryan Brue <ryanbrue.dev@gmail.com>
> Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
> Co-developed-by: Alexey Minnekhanov <alexeymin@minlexx.ru>
> Signed-off-by: Alexey Minnekhanov <alexeymin@minlexx.ru>
> Signed-off-by: Nickolay Goppen <setotau@mainlining.org>
> ---
>   drivers/gpu/drm/panel/Kconfig                 |   9 +
>   drivers/gpu/drm/panel/Makefile                |   1 +
>   drivers/gpu/drm/panel/panel-novatek-nt51021.c | 875 ++++++++++++++++++++++++++
>   3 files changed, 885 insertions(+)
> 
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
> index 000000000000..94e7d6aaf0cb
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt51021.c
> @@ -0,0 +1,875 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright (c) 2026, Ryan Brue <ryanbrue.dev@gmail.com>
> +// Copyright (c) 2025, Nickolay Goppen <setotau@mainlining.org>
> +// Copyright (c) 2024, Alexey Minnekhanov <alexeymin@minlexx.ru>
> +
> +/*
> + * This panel IC doesn't use the set_display_on command although
> + * it uses set_display_off command. This is not an error.
> + */
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <drm/drm_mipi_dsi.h>
> +#include <drm/drm_modes.h>
> +#include <drm/drm_panel.h>
> +#include <drm/drm_probe_helper.h>
> +
> +struct novatek_nt51021_desc;
> +
> +struct novatek_nt51021_variant {
> +	int (*init)(struct novatek_nt51021_desc *ctx);
> +	int (*off)(struct novatek_nt51021_desc *ctx);
> +
> +	const struct drm_display_mode *display_mode;
> +	unsigned long mode_flags;
> +};
> +
> +struct novatek_nt51021_desc {
> +	struct drm_panel panel;
> +	struct mipi_dsi_device *dsi;
> +	struct regulator_bulk_data *supplies;
> +	struct gpio_desc *reset_gpio;
> +
> +	const struct novatek_nt51021_variant *variant;
> +};
> +
> +static const struct regulator_bulk_data nt51021_novatek_supplies[] = {
> +	{ .supply = "vdd" },
> +	{ .supply = "avdd" },
> +	{ .supply = "havdd" },
> +};
> +
> +static inline struct novatek_nt51021_desc *to_novatek_panel(struct drm_panel *panel)
> +{
> +	return container_of_const(panel, struct novatek_nt51021_desc, panel);
> +}
> +
> +static void nt51021_novatek_reset(struct novatek_nt51021_desc *ctx)
> +{
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> +	msleep(20);
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
> +static int boe_tv080wum_nx2_init(struct novatek_nt51021_desc *ctx)
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
> +static int boe_tv101wum_nx0_init(struct novatek_nt51021_desc *ctx)
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
> +static int boe_tv101wum_nm0_init(struct novatek_nt51021_desc *ctx)
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
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x8c, 0x80);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xcd, 0x6c);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc0, 0x8b);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc8, 0xf0);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x97, 0x00);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x8b, 0x10);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xa9, 0x20);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x83, 0xaa);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x84, 0x11);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xa9, 0x4b);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x85, 0x04);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x86, 0x08);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x9c, 0x10);
> +	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> +	mipi_dsi_msleep(&dsi_ctx, 120);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x8f, 0x00);
> +	mipi_dsi_msleep(&dsi_ctx, 5);
> +
> +	return dsi_ctx.accum_err;
> +}
> +
> +static int nt51021_novatek_with_cabc_off(struct novatek_nt51021_desc *ctx)
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
> +static int nt51021_novatek_off(struct novatek_nt51021_desc *ctx)
> +{
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
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
> +static int nt51021_novatek_prepare(struct drm_panel *panel)
> +{
> +	struct novatek_nt51021_desc *ctx = to_novatek_panel(panel);
> +	struct device *dev = &ctx->dsi->dev;
> +	int ret;
> +
> +	ret = regulator_bulk_enable(ARRAY_SIZE(nt51021_novatek_supplies), ctx->supplies);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to enable regulators: %d\n", ret);
> +		return ret;
> +	}
> +	nt51021_novatek_reset(ctx);
> +
> +	ret = ctx->variant->init(ctx);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to initialize panel: %d\n", ret);
> +		gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> +		regulator_bulk_disable(ARRAY_SIZE(nt51021_novatek_supplies), ctx->supplies);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int nt51021_novatek_unprepare(struct drm_panel *panel)
> +{
> +	struct novatek_nt51021_desc *ctx = to_novatek_panel(panel);
> +	struct device *dev = &ctx->dsi->dev;
> +	int ret;
> +
> +	ret = ctx->variant->off(ctx);
> +	if (ret < 0)
> +		dev_err(dev, "Failed to un-initialize panel: %d\n", ret);
> +
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> +	regulator_bulk_disable(ARRAY_SIZE(nt51021_novatek_supplies), ctx->supplies);
> +
> +	return 0;
> +}
> +
> +static int nt51021_novatek_get_modes(struct drm_panel *panel,
> +				 struct drm_connector *connector)
> +{
> +	struct novatek_nt51021_desc *ctx = to_novatek_panel(panel);
> +
> +	return drm_connector_helper_get_modes_fixed(connector,
> +						    ctx->variant->display_mode);
> +}
> +
> +static const struct drm_panel_funcs nt51021_novatek_panel_funcs = {
> +	.prepare = nt51021_novatek_prepare,
> +	.unprepare = nt51021_novatek_unprepare,
> +	.get_modes = nt51021_novatek_get_modes,
> +};
> +
> +static int nt51021_novatek_probe(struct mipi_dsi_device *dsi)
> +{
> +	struct device *dev = &dsi->dev;
> +	struct novatek_nt51021_desc *ctx;
> +	int ret;
> +
> +	ctx = devm_drm_panel_alloc(dev, struct novatek_nt51021_desc, panel,
> +				   &nt51021_novatek_panel_funcs,
> +				   DRM_MODE_CONNECTOR_DSI);
> +	if (IS_ERR(ctx))
> +		return PTR_ERR(ctx);
> +
> +	ctx->variant = of_device_get_match_data(dev);
> +	if (!ctx->variant)
> +		return dev_err_probe(dev, -ENODEV, "No match data\n");
> +
> +	ret = devm_regulator_bulk_get_const(dev,
> +					    ARRAY_SIZE(nt51021_novatek_supplies),
> +					    nt51021_novatek_supplies,
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
> +	dsi->mode_flags = ctx->variant->mode_flags;
> +
> +	ctx->panel.prepare_prev_first = true;
> +
> +	ret = drm_panel_of_backlight(&ctx->panel);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get backlight\n");
> +
> +	ret = devm_drm_panel_add(dev, &ctx->panel);
> +	if (ret)
> +		return ret;
> +
> +	return devm_mipi_dsi_attach(dev, dsi);
> +}
> +
> +static const struct drm_display_mode boe_tv080wum_nx2_mode = {
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
> +static const struct drm_display_mode boe_tv101wum_nm0_mode = {
> +	.clock = 163333,
> +	.hdisplay = 1200,
> +	.hsync_start = 1200 + 110,
> +	.hsync_end = 1200 + 110 + 1,
> +	.htotal = 1200 + 110 + 1 + 32,
> +	.vdisplay = 1920,
> +	.vsync_start = 1920 + 11,
> +	.vsync_end = 1920 + 11 + 1,
> +	.vtotal = 1920 + 11 + 1 + 14,
> +	.width_mm = 135,
> +	.height_mm = 216,
> +	.type = DRM_MODE_TYPE_DRIVER,
> +};
> +
> +static const struct drm_display_mode boe_tv101wum_nx0_mode = {
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
> +#define NT51021_BURST_MODE_FLAGS	(MIPI_DSI_MODE_VIDEO | \
> +					 MIPI_DSI_MODE_VIDEO_BURST | \
> +					 MIPI_DSI_MODE_NO_EOT_PACKET | \
> +					 MIPI_DSI_MODE_LPM)
> +
> +static const struct novatek_nt51021_variant boe_tv080wum_nx2_data = {
> +	.init = boe_tv080wum_nx2_init,
> +	.off = nt51021_novatek_with_cabc_off,
> +	.display_mode = &boe_tv080wum_nx2_mode,
> +	.mode_flags = NT51021_BURST_MODE_FLAGS,
> +};
> +
> +static const struct novatek_nt51021_variant boe_tv101wum_nm0_data = {
> +	.init = boe_tv101wum_nm0_init,
> +	.off = nt51021_novatek_off,
> +	.display_mode = &boe_tv101wum_nm0_mode,
> +	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_LPM,
> +};
> +
> +static const struct novatek_nt51021_variant boe_tv101wum_nx0_data = {
> +	.init = boe_tv101wum_nx0_init,
> +	.off = nt51021_novatek_with_cabc_off,
> +	.display_mode = &boe_tv101wum_nx0_mode,
> +	.mode_flags = NT51021_BURST_MODE_FLAGS,
> +};
> +
> +static const struct of_device_id nt51021_novatek_of_match[] = {
> +	{ .compatible = "boe,tv080wum-nx2", .data = &boe_tv080wum_nx2_data },
> +	{ .compatible = "boe,tv101wum-nm0", .data = &boe_tv101wum_nm0_data },
> +	{ .compatible = "boe,tv101wum-nx0", .data = &boe_tv101wum_nx0_data },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, nt51021_novatek_of_match);
> +
> +static struct mipi_dsi_driver nt51021_boe_driver = {
> +	.probe = nt51021_novatek_probe,
> +	.driver = {
> +		.name = "panel-novatek-nt51021",
> +		.of_match_table = nt51021_novatek_of_match,
> +	},
> +};
> +module_mipi_dsi_driver(nt51021_boe_driver);
> +
> +MODULE_AUTHOR("Nickolay Goppen <setotau@mainlining.org>");
> +MODULE_AUTHOR("Alexey Minnekhanov <alexeymin@minlexx.ru>");
> +MODULE_AUTHOR("Ryan Brue <ryanbrue.dev@gmail.com>");
> +MODULE_DESCRIPTION("DRM driver for Novatek NT51021-based DSI panels");
> +MODULE_LICENSE("GPL");
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
