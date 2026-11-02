Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972DF606A327
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=YTaemlTQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CABDF10E4E2;
	Mon,  2 Nov 2026 13:17:45 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C7A210E4E2
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 13:17:39 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-48df54150dfso1372926f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 05:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793625457; x=1794230257; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5+UXT116wgM3lPiMbzxGZ42MZgEREmAm0zBk0E1R92M=;
 b=YTaemlTQQx03jNQt6zbTpxHffUhO0v17vyNxYUNFd1uJkA9v0WLARb5z6f+p3gAkWT
 8vCv0PhpK/7lz339awGUSqnNEU8f3OAm1yVONMB592LPKzrYN3/IXd+ugt7q1kfGhlcp
 /rqdlDFMtla8do4B+Buex9GlmMt3dzpEdzIkxfJFXQwCD5AIy5LKJp56/IseRz6ff7mW
 3ciISlksaY1BuAE/4k7FZ4wBHvd68kU88AoLfheBZs+3ic1d7AqgFcFBcB7cTLL58duF
 qyKDcvpcKVVcHisvKB0LqgP9+OkttFM1fEC/z0cKgJoPQfTPUni0zY80Skm24G3+0cIg
 Xjkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793625457; x=1794230257;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5+UXT116wgM3lPiMbzxGZ42MZgEREmAm0zBk0E1R92M=;
 b=twQvv4E6EXAPBzY54XKKFgfix/cl2Ep5tnd+Je0hSD4tBEhEcprOEy3ni6F8pCjOnF
 VfkfirvEmafZfbZMd8QJ7wQhR1Z7QEcurWp3UxB1afiWhf2AyA1DJYuce67OMz5/6Kg3
 VplBW2YLyDF80G5Kqx9ursSHjYp0CCIRGXnIam2hAMcUCImapDgBkB+ggwBOf5qTG3uW
 wP+jvsZxefvxblpRAk8ccyLNG4iFJFAdcwOMLLxD4AbJOsqbzF0pT7K+2/CuYKTqQIzf
 KcNBksv4C1JYTGcslOSVERfF4RdWN2WJIkTUmaCLYPqgjZKoYlFmkoD8qGnxoV3mOuhl
 Zchw==
X-Gm-Message-State: APuU4Z/qjdOWkZSVXKxAE6Xq8AQQqxm7fjDrdmwn8Hnmvsc7OBw1aSIk
 avh03Y3KtdYjHfo4IOre4VdVspb/bR4qTlT8uIQVs7FjM4oZWlYC+MLQGlW01UvClcU=
X-Gm-Gg: AYBFou2hWbF/bNYwaSM2yhmGx/2cXAnbcPTF2XedAKMCMxDf7Q2tbl7yRKSXlvXmnPK
 lnbq6R+UZMw0iDv4NoJaiZAj//THf5W6XkKUMQ0z5OegqBrp1NvXU7nH9RdXpzC0gm/SHrAPv4h
 jIBelQc4o1YkdmKEgMujOz6kp6z2qgJikHsLwB4YCP/B75TNTHiQK55ynbpv6H0air23Qk7PPZV
 +gMAcyOuz6gRrYZQ0Tp9rnVYLgLoAJGUtcG1EiB9qtLI5A0toXGDLpoR47HOWfuk16vP+mUgze4
 UjPOdpv5H8Hvls0M+rhDuMlrygSzh5sLkGxkIls5OmcdTllAmc67NPGBniwxIYKzGNnCSNiL2iq
 /JICiOxcGtgMTM5tlnJLk9FUOtE8z1oamVeqs13+vHfDjvTFMs9CnnYc9xzxbjsXYP8oqddHR/g
 FFTioc2sNZvhzUB3spW2TeTYuTFIQ3szdrOTb25LTkrqMqXeqfW4xqucIRkPYvmpc36bpTENKZ8
 /spZDjtt4iCMdWGfiabpEtcHEAlx5s3pZA5kWOggkFbJ4t8km9UdbKYBDYVf+10+siZ85i9KBvV
 kLGJn7L1hIOK34ZoNdIVmsgA86eB95OwGgtCkhlrQyxuM2rmwCLoMon1EfnZc5yBJfhUkPM2SD0
 DCJ9M
X-Received: by 2002:a05:6000:2885:b0:488:88ec:59c3 with SMTP id
 ffacd0b85a97d-48e6e2f2c14mr21237777f8f.14.1793625457212; 
 Mon, 02 Nov 2026 05:17:37 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:9476:5165:3a16:262?
 ([2a01:e0a:106d:1080:9476:5165:3a16:262])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b7270asm20166279f8f.11.2026.11.02.05.17.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 05:17:36 -0800 (PST)
Message-ID: <402ef21d-84dd-42cf-89c3-748216ce2174@linaro.org>
Date: Mon, 2 Nov 2026 14:17:35 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 2/2] drm/panel: Add Samsung AMS644VK04 panel driver
To: patches@brar.si, Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261026-panel-ams644vk04-v2-0-e88cafb3e577@brar.si>
 <20261026-panel-ams644vk04-v2-2-e88cafb3e577@brar.si>
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
In-Reply-To: <20261026-panel-ams644vk04-v2-2-e88cafb3e577@brar.si>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/26/26 17:39, Ishu Brar via B4 Relay wrote:
> From: Ishu Brar <patches@brar.si>
> 
> Add a driver for the Samsung AMS644VK04, a 1080x2400 DSI command mode
> AMOLED panel with DSC found in the OnePlus Nord (SM7250). It uses four
> lanes and DSC 1.1 at 8 bits per pixel.
> 
> The initialisation sequence comes from the downstream driver. The DSC
> picture parameter set is built with drm_dsc_pps_payload_pack() from the
> same drm_dsc_config the DSI host uses. Only the 90 Hz mode is described
> for now.
> 
> Tested on a OnePlus Nord with the msm DSI host, including suspend and
> resume.
> 
> Signed-off-by: Ishu Brar <patches@brar.si>
> ---
>   MAINTAINERS                                      |   1 +
>   drivers/gpu/drm/panel/Kconfig                    |  17 ++
>   drivers/gpu/drm/panel/Makefile                   |   1 +
>   drivers/gpu/drm/panel/panel-samsung-ams644vk04.c | 356 +++++++++++++++++++++++
>   4 files changed, 375 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 19ec9f8b522f..b409a7f3985f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8466,6 +8466,7 @@ DRM DRIVER FOR SAMSUNG AMS644VK04 PANEL
>   M:	Ishu Brar <patches@brar.si>
>   S:	Maintained
>   F:	Documentation/devicetree/bindings/display/panel/samsung,ams644vk04.yaml
> +F:	drivers/gpu/drm/panel/panel-samsung-ams644vk04.c
>   
>   DRM DRIVER FOR SAMSUNG DB7430 PANELS
>   M:	Linus Walleij <linusw@kernel.org>
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index 7a520b4d60fe..7cb0ff13c037 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -956,6 +956,23 @@ config DRM_PANEL_SAMSUNG_AMS639RQ08
>   	  Say Y or M here if you want to enable support for the
>   	  Samsung AMS639RQ08 FHD Plus (2340x1080@60Hz) CMD mode panel.
>   
> +config DRM_PANEL_SAMSUNG_AMS644VK04
> +	tristate "Samsung AMS644VK04 panel"
> +	depends on OF
> +	depends on DRM_MIPI_DSI
> +	depends on BACKLIGHT_CLASS_DEVICE
> +	depends on GPIOLIB
> +	depends on REGULATOR
> +	select DRM_DISPLAY_DSC_HELPER
> +	select DRM_DISPLAY_HELPER
> +	help
> +	  Say Y or M here if you want to enable support for the
> +	  Samsung AMS644VK04 FHD Plus (1080x2400) DSC command mode AMOLED
> +	  panel, found in the OnePlus Nord.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called panel-samsung-ams644vk04.
> +
>   config DRM_PANEL_SAMSUNG_S6E88A0_AMS427AP24
>   	tristate "Samsung AMS427AP24 panel with S6E88A0 controller"
>   	depends on GPIOLIB && OF && REGULATOR
> diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
> index da5175909d54..01c1ca740dac 100644
> --- a/drivers/gpu/drm/panel/Makefile
> +++ b/drivers/gpu/drm/panel/Makefile
> @@ -92,6 +92,7 @@ obj-$(CONFIG_DRM_PANEL_RENESAS_R69328) += panel-renesas-r69328.o
>   obj-$(CONFIG_DRM_PANEL_RONBO_RB070D30) += panel-ronbo-rb070d30.o
>   obj-$(CONFIG_DRM_PANEL_SAMSUNG_AMS581VF01) += panel-samsung-ams581vf01.o
>   obj-$(CONFIG_DRM_PANEL_SAMSUNG_AMS639RQ08) += panel-samsung-ams639rq08.o
> +obj-$(CONFIG_DRM_PANEL_SAMSUNG_AMS644VK04) += panel-samsung-ams644vk04.o
>   obj-$(CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20) += panel-samsung-atna33xc20.o
>   obj-$(CONFIG_DRM_PANEL_SAMSUNG_DB7430) += panel-samsung-db7430.o
>   obj-$(CONFIG_DRM_PANEL_SAMSUNG_LD9040) += panel-samsung-ld9040.o
> diff --git a/drivers/gpu/drm/panel/panel-samsung-ams644vk04.c b/drivers/gpu/drm/panel/panel-samsung-ams644vk04.c
> new file mode 100644
> index 000000000000..3cbe1fd9aa01
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-samsung-ams644vk04.c
> @@ -0,0 +1,356 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Samsung AMS644VK04 AMOLED DSI command mode panel driver (DSC)
> + *
> + * 1080x2400, 4 lanes, DSC 1.1 8 bpc -> 8 bpp, 90 Hz.
> + * Found in the OnePlus Nord (avicii).
> + *
> + * The initialisation sequences were generated from the downstream panel
> + * description ("samsung ams644vk04 fhd cmd mode dsc dsi panel").
> + */
> +
> +#include <linux/backlight.h>
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <drm/display/drm_dsc.h>
> +#include <drm/display/drm_dsc_helper.h>
> +#include <drm/drm_mipi_dsi.h>
> +#include <drm/drm_modes.h>
> +#include <drm/drm_panel.h>
> +#include <drm/drm_probe_helper.h>
> +
> +#define AMS644VK04_WIDTH		1080
> +#define AMS644VK04_HEIGHT		2400
> +
> +#define AMS644VK04_MAX_BRIGHTNESS	0x7ff
> +#define AMS644VK04_DEFAULT_BRIGHTNESS	0x140
> +
> +/* Power-on order and expected load as given by the downstream supply entries */
> +static const struct regulator_bulk_data ams644vk04_supplies[] = {
> +	{ .supply = "vddio", .init_load_uA = 62000 },
> +	{ .supply = "vout", .init_load_uA = 857000 },
> +	{ .supply = "vdd", .init_load_uA = 857000 },
> +};
> +
> +struct ams644vk04 {
> +	struct drm_panel panel;
> +	struct mipi_dsi_device *dsi;
> +	struct drm_dsc_config dsc;
> +	struct gpio_desc *reset_gpio;
> +	struct regulator_bulk_data *supplies;
> +	bool prepared;
> +};
> +
> +static inline struct ams644vk04 *to_ams644vk04(struct drm_panel *panel)
> +{
> +	return container_of(panel, struct ams644vk04, panel);
> +}
> +
> +static void ams644vk04_send_on(struct mipi_dsi_multi_context *dsi_ctx,
> +			       const struct drm_dsc_config *dsc)
> +{
> +	struct drm_dsc_picture_parameter_set pps;
> +
> +	drm_dsc_pps_payload_pack(&pps, dsc);
> +
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf0, 0x5a, 0x5a);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x9d, 0x01);
> +	mipi_dsi_picture_parameter_set_multi(dsi_ctx, &pps);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf0, 0xa5, 0xa5);
> +	mipi_dsi_dcs_exit_sleep_mode_multi(dsi_ctx);
> +	mipi_dsi_msleep(dsi_ctx, 20);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf0, 0x5a, 0x5a);
> +	mipi_dsi_dcs_set_tear_on_multi(dsi_ctx, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf0, 0xa5, 0xa5);
> +	mipi_dsi_dcs_set_column_address_multi(dsi_ctx, 0, AMS644VK04_WIDTH - 1);
> +	mipi_dsi_dcs_set_page_address_multi(dsi_ctx, 0, AMS644VK04_HEIGHT - 1);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf0, 0x5a, 0x5a);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf5, 0x85);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb0, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf8, 0xc4);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb0, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf8, 0x41, 0x47, 0x11, 0xb8, 0xb8);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb0, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf8, 0xcc);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb0, 0x03);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf2, 0x82);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf5, 0x87);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf0, 0xa5, 0xa5);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf0, 0x5a, 0x5a);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb0, 0x03);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xdd, 0x40);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf0, 0xa5, 0xa5);
> +	mipi_dsi_msleep(dsi_ctx, 110);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf0, 0x5a, 0x5a);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb0, 0x06);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb7, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb0, 0x05);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb7, 0x13);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb7, 0x01, 0x37);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf0, 0xa5, 0xa5);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x53, 0x20);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf0, 0x5a, 0x5a);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x60, 0x10);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf0, 0xa5, 0xa5);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf0, 0x5a, 0x5a);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x55, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf0, 0xa5, 0xa5);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf0, 0x5a, 0x5a);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xbd, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf0, 0xa5, 0xa5);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf0, 0x5a, 0x5a);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xe6, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf0, 0xa5, 0xa5);
> +	mipi_dsi_dcs_set_display_on_multi(dsi_ctx);
> +}
> +
> +static void ams644vk04_send_off(struct mipi_dsi_multi_context *dsi_ctx)
> +{
> +	mipi_dsi_dcs_set_display_off_multi(dsi_ctx);
> +	mipi_dsi_msleep(dsi_ctx, 10);
> +	mipi_dsi_dcs_enter_sleep_mode_multi(dsi_ctx);
> +	mipi_dsi_msleep(dsi_ctx, 120);
> +}
> +
> +static void ams644vk04_reset(struct ams644vk04 *ctx)
> +{
> +	/* Same timing as downstream: 10 ms steps, the logical value 1 asserts reset */
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> +	usleep_range(10000, 10100);
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> +	usleep_range(10000, 10100);
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> +	usleep_range(10000, 10100);
> +}
> +
> +static void ams644vk04_supplies_disable(struct ams644vk04 *ctx, int first)
> +{
> +	int i;
> +
> +	for (i = first; i >= 0; i--)
> +		regulator_disable(ctx->supplies[i].consumer);
> +}
> +
> +static int ams644vk04_supplies_enable(struct ams644vk04 *ctx)
> +{
> +	struct device *dev = &ctx->dsi->dev;
> +	int i, ret;
> +
> +	/* The rails come up one after the other, vddio and vout need time to settle */
> +	for (i = 0; i < ARRAY_SIZE(ams644vk04_supplies); i++) {
> +		ret = regulator_enable(ctx->supplies[i].consumer);
> +		if (ret) {
> +			dev_err(dev, "Failed to enable %s: %d\n",
> +				ams644vk04_supplies[i].supply, ret);
> +			ams644vk04_supplies_disable(ctx, i - 1);
> +			return ret;
> +		}
> +
> +		if (i < ARRAY_SIZE(ams644vk04_supplies) - 1)
> +			msleep(20);
> +	}
> +
> +	return 0;
> +}
> +
> +static int ams644vk04_prepare(struct drm_panel *panel)
> +{
> +	struct ams644vk04 *ctx = to_ams644vk04(panel);
> +	struct device *dev = &ctx->dsi->dev;
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
> +	int ret;
> +
> +	ret = ams644vk04_supplies_enable(ctx);
> +	if (ret)
> +		return ret;
> +
> +	ams644vk04_reset(ctx);
> +
> +	ams644vk04_send_on(&dsi_ctx, &ctx->dsc);
> +	if (dsi_ctx.accum_err) {
> +		ret = dsi_ctx.accum_err;
> +		dev_err(dev, "Failed to send on sequence: %d\n", ret);
> +		goto err_power_down;
> +	}
> +
> +	ctx->prepared = true;
> +
> +	return 0;
> +
> +err_power_down:
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> +	ams644vk04_supplies_disable(ctx, ARRAY_SIZE(ams644vk04_supplies) - 1);
> +
> +	return ret;
> +}
> +
> +static int ams644vk04_unprepare(struct drm_panel *panel)
> +{
> +	struct ams644vk04 *ctx = to_ams644vk04(panel);
> +	struct device *dev = &ctx->dsi->dev;
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
> +
> +	ctx->prepared = false;
> +
> +	ams644vk04_send_off(&dsi_ctx);
> +	if (dsi_ctx.accum_err)
> +		dev_err(dev, "Failed to send off sequence: %d\n", dsi_ctx.accum_err);
> +
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> +	ams644vk04_supplies_disable(ctx, ARRAY_SIZE(ams644vk04_supplies) - 1);
> +
> +	return 0;
> +}
> +
> +/*
> + * Timings are the downstream ones.  The clock is htotal * vtotal * refresh:
> + * the msm DSI host scales the pixel clock for DSC by itself, so the mode
> + * describes the uncompressed picture.
> + */
> +static const struct drm_display_mode ams644vk04_mode = {
> +	.clock = (1080 + 52 + 24 + 24) * (2400 + 4 + 4 + 8) * 90 / 1000,
> +	.hdisplay = 1080,
> +	.hsync_start = 1080 + 52,
> +	.hsync_end = 1080 + 52 + 24,
> +	.htotal = 1080 + 52 + 24 + 24,
> +	.vdisplay = 2400,
> +	.vsync_start = 2400 + 4,
> +	.vsync_end = 2400 + 4 + 4,
> +	.vtotal = 2400 + 4 + 4 + 8,
> +	.width_mm = 67,
> +	.height_mm = 149,
> +	.type = DRM_MODE_TYPE_DRIVER,
> +};
> +
> +static int ams644vk04_get_modes(struct drm_panel *panel,
> +				struct drm_connector *connector)
> +{
> +	return drm_connector_helper_get_modes_fixed(connector, &ams644vk04_mode);
> +}
> +
> +static const struct drm_panel_funcs ams644vk04_panel_funcs = {
> +	.prepare = ams644vk04_prepare,
> +	.unprepare = ams644vk04_unprepare,
> +	.get_modes = ams644vk04_get_modes,
> +};
> +
> +static int ams644vk04_bl_update_status(struct backlight_device *bl)
> +{
> +	struct ams644vk04 *ctx = bl_get_data(bl);
> +
> +	if (!ctx->prepared)
> +		return 0;
> +
> +	/* The panel takes the 11 bit level most significant byte first */
> +	return mipi_dsi_dcs_set_display_brightness_large(ctx->dsi,
> +							 backlight_get_brightness(bl));
> +}
> +
> +static const struct backlight_ops ams644vk04_bl_ops = {
> +	.update_status = ams644vk04_bl_update_status,
> +};
> +
> +static int ams644vk04_probe(struct mipi_dsi_device *dsi)
> +{
> +	struct device *dev = &dsi->dev;
> +	const struct backlight_properties props = {
> +		.type = BACKLIGHT_RAW,
> +		.brightness = AMS644VK04_DEFAULT_BRIGHTNESS,
> +		.max_brightness = AMS644VK04_MAX_BRIGHTNESS,
> +	};
> +	struct backlight_device *bl;
> +	struct ams644vk04 *ctx;
> +	int ret;
> +
> +	ctx = devm_drm_panel_alloc(dev, struct ams644vk04, panel,
> +				   &ams644vk04_panel_funcs,
> +				   DRM_MODE_CONNECTOR_DSI);
> +	if (IS_ERR(ctx))
> +		return PTR_ERR(ctx);
> +
> +	ret = devm_regulator_bulk_get_const(dev, ARRAY_SIZE(ams644vk04_supplies),
> +					    ams644vk04_supplies, &ctx->supplies);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get regulators\n");
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
> +	dsi->mode_flags = MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS |
> +			  MIPI_DSI_MODE_DSC_ALL_SLICES_IN_PKT;
> +
> +	/*
> +	 * DSC 1.1, 8 bpc, 8 bpp (4 fractional bits), block prediction, two
> +	 * 540x48 slices per line, both in the same packet.  The DSI host
> +	 * derives the remaining rate control parameters from this.
> +	 */
> +	ctx->dsc.dsc_version_major = 1;
> +	ctx->dsc.dsc_version_minor = 1;
> +	ctx->dsc.slice_width = 540;
> +	ctx->dsc.slice_height = 48;
> +	ctx->dsc.slice_count = AMS644VK04_WIDTH / ctx->dsc.slice_width;
> +	ctx->dsc.bits_per_component = 8;
> +	ctx->dsc.bits_per_pixel = 8 << 4;
> +	ctx->dsc.block_pred_enable = true;
> +	dsi->dsc = &ctx->dsc;
> +
> +	ctx->panel.prepare_prev_first = true;
> +
> +	bl = devm_backlight_device_register(dev, dev_name(dev), dev, ctx,
> +					    &ams644vk04_bl_ops, &props);
> +	if (IS_ERR(bl))
> +		return dev_err_probe(dev, PTR_ERR(bl), "Failed to register backlight\n");
> +	ctx->panel.backlight = bl;
> +
> +	drm_panel_add(&ctx->panel);
> +
> +	ret = mipi_dsi_attach(dsi);
> +	if (ret < 0) {
> +		drm_panel_remove(&ctx->panel);
> +		return dev_err_probe(dev, ret, "Failed to attach to DSI host\n");
> +	}
> +
> +	return 0;
> +}
> +
> +static void ams644vk04_remove(struct mipi_dsi_device *dsi)
> +{
> +	struct ams644vk04 *ctx = mipi_dsi_get_drvdata(dsi);
> +	int ret;
> +
> +	ret = mipi_dsi_detach(dsi);
> +	if (ret < 0)
> +		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
> +
> +	drm_panel_remove(&ctx->panel);
> +}
> +
> +static const struct of_device_id ams644vk04_of_match[] = {
> +	{ .compatible = "samsung,ams644vk04" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, ams644vk04_of_match);
> +
> +static struct mipi_dsi_driver ams644vk04_driver = {
> +	.probe = ams644vk04_probe,
> +	.remove = ams644vk04_remove,
> +	.driver = {
> +		.name = "panel-samsung-ams644vk04",
> +		.of_match_table = ams644vk04_of_match,
> +	},
> +};
> +module_mipi_dsi_driver(ams644vk04_driver);
> +
> +MODULE_DESCRIPTION("Panel driver for the Samsung AMS644VK04 AMOLED DSI panel");
> +MODULE_LICENSE("GPL");
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
