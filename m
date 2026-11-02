Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2FB606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=l+ZeaJbq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04BCF10EE0E;
	Mon,  2 Nov 2026 13:19:59 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FB1210EE0E
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 13:19:52 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a5087a5348so24062475e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 05:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793625590; x=1794230390; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3mgHrg5Sv9wyPBlR2qdKiADODTO9w/sIrDMDe0KcwGs=;
 b=l+ZeaJbqDO3BL7wKXVpe32RpDcrkYwL7442swVePd/uOgfmY5IvxwEI1eypC1Ga8IT
 3x1tDKdumoSv7vGS316WPzBUoOi0EOG7q3XMhCKG9HHsJ8PgnI6YIEI13gxoMcJLgTw/
 IskP7pc3mHsvV6+LT645LJzNP/+ORsqS0UJ0A/xAVgCtUnaka1ZVx6aXruJCORkUEQEL
 IhUoPDvn/ru9xfQUtXDiFyBoHo8G/wyAfvRR+eJvcpf7RyMYIbXht2TF5oRyeXjVz991
 HQKApCHETQYIHYCsuWlvc4ZSftK6VcHxuzOG8w9XiV4Fli8TIUG8xLwn6K6hK7gqrr1I
 5ekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793625590; x=1794230390;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3mgHrg5Sv9wyPBlR2qdKiADODTO9w/sIrDMDe0KcwGs=;
 b=VwY7LMss8TJ35sgoyJzuNGxZpsSZcQtBeXSe0Hama4ViQE+21wRuEjlhQsZ6DLJ5sM
 vDaEsF30yELplp9luMNbYoqnnDxygYAGFETqC7HW5DwR3mcDzN63yjFPQOa+bva/uRyI
 bLUKBrz7F8FoM/rL+Gt6SyiQuaMN1imreqaObMlf+tJikZyKRbKg4FyjzMqi99zV0+6P
 8yFaaioFNfjSRnZS+T4Otc7eyB8D8c8V1PT4BngoH7O8JMppEVdyi4M6XrvAOWFVYmzm
 NYK9JbHNENBgnuSkHbKFoWrOsmnnbgZeIIWqnOKUXUgTzX50dxJATwnq0pQvkraUOuAf
 UFaA==
X-Gm-Message-State: AFq9FYK4xNUzuEFw4CNnMjJkg5YKmpSAq/JVGVmRYig4pzOT5BhXG7/c
 7X7UJvlbjgfndKawShjcGSae6P/khRvWYMjvz4VdgvFeK/UlxPvGqwX7R/MBle8r6sc=
X-Gm-Gg: AYBFou0jsIoWb7+dYx/D0hS+HjYnKdQKYh8SdIeGk9zQ5ktA7ijXFgYekzms++CuLuV
 jtahuDdTxRydVUYTaLIuQejcYiZHyzwfQ0sk5VKJwv+IVcZ7KSDKxupXQY3h+Q0xl1X3bPYWlwp
 FOvds3gwdhbw0E1lWCAH8k6SPnd1oeOpHxSUg1HpZ2FgFAj+zIvhioKXOJ9aUx6zl1dkBh4Cwds
 otwgzTe9Yg9mJjj+Q7GH2AH0pDEQZCTfWsg6lavaQl1Key91ikW/m6ZgaO7wLLvJguAs6VGn+6t
 v/3w0b+uaEV9L+LLdtGU7MG19eVYt+98qyKnG34spbOdIfF4sEAkShodO78vQhATVTBny9eVSdX
 Rd/D8NgqrYgDeu+fIwRVkrdqrq1n/UKCr6TQ714Ks64tiyxA1CYOJUwqIyby9ZayPuspkVHvFds
 sJQn+UNdy+Xl9vSurdXZXj9dpVSnGdzilE5sizKWhO95cLLgCgAbAiMob4Yepw/GYkvVYrgTdad
 mkxXZM61G7zUDKc2gKW6WdxiM2EbyluyVQn8pWFrP7qaRJiEOtq7MTDwwbrTiviuDf+xCfsiH7s
 NvoQHKw2z8ZKndrWudH+0DfFSgzG7uOmn2BnZRx8hDdAvZ6NYFGieV0ctFQAgiDp9byoFu/jPmY
 OhibS
X-Received: by 2002:a05:600c:138c:b0:4a1:f90d:6f4c with SMTP id
 5b1f17b1804b1-4ac17ffaff2mr219159845e9.7.1793625590201; 
 Mon, 02 Nov 2026 05:19:50 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:9476:5165:3a16:262?
 ([2a01:e0a:106d:1080:9476:5165:3a16:262])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf5b286a0sm228365785e9.4.2026.11.02.05.19.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 05:19:49 -0800 (PST)
Message-ID: <d0aa0ffb-e598-485c-a793-442d548fab90@linaro.org>
Date: Mon, 2 Nov 2026 14:19:49 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 3/7] drm/panel: Add LG LH400WV3-SD04 MIPI DBI Type B
 panel driver
To: Svyatoslav Ryhel <clamor95@gmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Mikko Perttunen <mperttunen@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20261022132259.240717-1-clamor95@gmail.com>
 <20261022132259.240717-4-clamor95@gmail.com>
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
In-Reply-To: <20261022132259.240717-4-clamor95@gmail.com>
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

On 10/22/26 15:22, Svyatoslav Ryhel wrote:
> Add a driver for panel used in LG Optimus 2X P990. Panel is 4" WVGA MIPI
> DBI Type B linked to DRM encoder via RGB to DBI bridge.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>   drivers/gpu/drm/panel/Kconfig             |  13 ++
>   drivers/gpu/drm/panel/Makefile            |   1 +
>   drivers/gpu/drm/panel/panel-lg-lh400wv3.c | 236 ++++++++++++++++++++++
>   3 files changed, 250 insertions(+)
>   create mode 100644 drivers/gpu/drm/panel/panel-lg-lh400wv3.c
> 
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index 5f68b78526c3e..f29b63ad8ba0f 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -554,6 +554,19 @@ config DRM_PANEL_LG_LG4573
>   	  Say Y here if you want to enable support for LG4573 RGB panel.
>   	  To compile this driver as a module, choose M here.
>   
> +config DRM_PANEL_LG_LH400WV3
> +	tristate "LG LH400WV3 MIPI DBI Type B panel"
> +	depends on OF
> +	depends on BACKLIGHT_CLASS_DEVICE
> +	select DRM_MIPI_DBI
> +	select VIDEOMODE_HELPERS
> +	help
> +	  Say Y here if you want to enable support for the LG LH400WV3 MIPI
> +	  DBI Type B panel found in the LG Optimus 2X P990 smartphone.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called panel-lg-lh400wv3.
> +
>   config DRM_PANEL_LG_SW43408
>   	tristate "LG SW43408 panel"
>   	depends on GPIOLIB
> diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
> index 414267a49d922..842a2a973777f 100644
> --- a/drivers/gpu/drm/panel/Makefile
> +++ b/drivers/gpu/drm/panel/Makefile
> @@ -54,6 +54,7 @@ obj-$(CONFIG_DRM_PANEL_LINCOLNTECH_LCD197) += panel-lincolntech-lcd197.o
>   obj-$(CONFIG_DRM_PANEL_LG_LB035Q02) += panel-lg-lb035q02.o
>   obj-$(CONFIG_DRM_PANEL_LG_LD070WX3) += panel-lg-ld070wx3.o
>   obj-$(CONFIG_DRM_PANEL_LG_LG4573) += panel-lg-lg4573.o
> +obj-$(CONFIG_DRM_PANEL_LG_LH400WV3) += panel-lg-lh400wv3.o
>   obj-$(CONFIG_DRM_PANEL_LG_SW43408) += panel-lg-sw43408.o
>   obj-$(CONFIG_DRM_PANEL_LXD_M9189A) += panel-lxd-m9189a.o
>   obj-$(CONFIG_DRM_PANEL_MAGNACHIP_D53E6EA8966) += panel-magnachip-d53e6ea8966.o
> diff --git a/drivers/gpu/drm/panel/panel-lg-lh400wv3.c b/drivers/gpu/drm/panel/panel-lg-lh400wv3.c
> new file mode 100644
> index 0000000000000..557bcb6f2ca70
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-lg-lh400wv3.c
> @@ -0,0 +1,236 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/array_size.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/media-bus-format.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <video/mipi_display.h>
> +
> +#include <drm/drm_mipi_dbi.h>
> +#include <drm/drm_modes.h>
> +#include <drm/drm_of.h>
> +#include <drm/drm_panel.h>
> +#include <drm/drm_probe_helper.h>
> +
> +static const struct regulator_bulk_data lg_lh400wv3_supplies[] = {
> +	{ .supply = "avci" }, { .supply = "iovcc" },
> +};
> +
> +struct lg_lh400wv3 {
> +	struct drm_panel panel;
> +	struct mipi_dbi *dbi;
> +
> +	struct regulator_bulk_data *supplies;
> +	struct gpio_desc *reset_gpio;
> +};
> +
> +static inline struct lg_lh400wv3 *to_lg_lh400wv3(struct drm_panel *panel)
> +{
> +	return container_of(panel, struct lg_lh400wv3, panel);
> +}
> +
> +#define panel_dbi_command(priv, cmd, seq...) \
> +({ \
> +	const u8 d[] = { seq }; \
> +	struct drm_panel *panel = &(priv)->panel; \
> +	struct device *dev = panel->dev; \
> +	int ret; \
> +	ret = mipi_dbi_command_stackbuf((priv)->dbi, cmd, d, ARRAY_SIZE(d)); \
> +	if (ret) \
> +		dev_err_ratelimited(dev, "error %d when sending command %#02x\n", ret, cmd); \
> +	ret; \
> +})
> +
> +static int lg_lh400wv3_prepare(struct drm_panel *panel)
> +{
> +	struct lg_lh400wv3 *priv = to_lg_lh400wv3(panel);
> +	struct device *dev = panel->dev;
> +	int ret;
> +
> +	priv->dbi = dev_get_drvdata(dev->parent);
> +	if (!priv->dbi)
> +		return -ENODEV;
> +
> +	gpiod_set_value_cansleep(priv->reset_gpio, 1);
> +
> +	ret = regulator_bulk_enable(ARRAY_SIZE(lg_lh400wv3_supplies), priv->supplies);
> +	if (ret) {
> +		dev_err(dev, "failed to enable power supplies: %d\n", ret);
> +		return ret;
> +	}
> +
> +	usleep_range(1000, 2000);
> +
> +	gpiod_set_value_cansleep(priv->reset_gpio, 0);
> +
> +	usleep_range(10000, 11000);
> +
> +	return 0;
> +};
> +
> +static int lg_lh400wv3_enable(struct drm_panel *panel)
> +{
> +	struct lg_lh400wv3 *priv = to_lg_lh400wv3(panel);
> +
> +	panel_dbi_command(priv, MIPI_DCS_EXIT_INVERT_MODE);
> +	panel_dbi_command(priv, MIPI_DCS_SET_TEAR_ON);
> +
> +	panel_dbi_command(priv, MIPI_DCS_SET_PIXEL_FORMAT, MIPI_DCS_PIXEL_FMT_24BIT |
> +			  MIPI_DCS_PIXEL_FMT_24BIT << 4);
> +
> +	panel_dbi_command(priv, 0xb2, 0x00, 0xc8);
> +	panel_dbi_command(priv, 0xb3, 0x00);
> +	panel_dbi_command(priv, 0xb4, 0x04);
> +	panel_dbi_command(priv, 0xb5, 0x42, 0x10, 0x10, 0x00, 0x20);
> +	panel_dbi_command(priv, 0xb6, 0x0b, 0x0f, 0x3c, 0x13, 0x13, 0xe8);
> +	panel_dbi_command(priv, 0xb7, 0x4c, 0x06, 0x0c, 0x00, 0x00);
> +
> +	panel_dbi_command(priv, 0xc0, 0x01, 0x11);
> +	panel_dbi_command(priv, 0xc3, 0x07, 0x03, 0x04, 0x04, 0x04);
> +	panel_dbi_command(priv, 0xc4, 0x12, 0x24, 0x18, 0x18, 0x02, 0x49);
> +	panel_dbi_command(priv, 0xc5, 0x65);
> +	panel_dbi_command(priv, 0xc6, 0x41, 0x63);
> +
> +	panel_dbi_command(priv, 0xd0, 0x00, 0x46, 0x74, 0x32, 0x1d, 0x03, 0x51, 0x15, 0x04);
> +	panel_dbi_command(priv, 0xd1, 0x00, 0x46, 0x74, 0x32, 0x1d, 0x03, 0x51, 0x15, 0x04);
> +	panel_dbi_command(priv, 0xd2, 0x00, 0x46, 0x74, 0x32, 0x1f, 0x03, 0x51, 0x15, 0x04);
> +	panel_dbi_command(priv, 0xd3, 0x00, 0x46, 0x74, 0x32, 0x1f, 0x03, 0x51, 0x15, 0x04);
> +	panel_dbi_command(priv, 0xd4, 0x01, 0x46, 0x74, 0x25, 0x00, 0x03, 0x51, 0x15, 0x04);
> +	panel_dbi_command(priv, 0xd5, 0x01, 0x46, 0x74, 0x25, 0x00, 0x03, 0x51, 0x15, 0x04);
> +
> +	panel_dbi_command(priv, MIPI_DCS_SET_COLUMN_ADDRESS, 0x00, 0x00, 0x01, 0xdf);
> +	panel_dbi_command(priv, MIPI_DCS_SET_PAGE_ADDRESS, 0x00, 0x00, 0x03, 0x1f);
> +
> +	panel_dbi_command(priv, MIPI_DCS_EXIT_SLEEP_MODE);
> +	msleep(120);
> +
> +	panel_dbi_command(priv, MIPI_DCS_WRITE_MEMORY_START);
> +	panel_dbi_command(priv, MIPI_DCS_SET_DISPLAY_ON);
> +
> +	return 0;
> +}
> +
> +static int lg_lh400wv3_disable(struct drm_panel *panel)
> +{
> +	struct lg_lh400wv3 *priv = to_lg_lh400wv3(panel);
> +
> +	panel_dbi_command(priv, MIPI_DCS_SET_DISPLAY_OFF);
> +	panel_dbi_command(priv, MIPI_DCS_ENTER_SLEEP_MODE);
> +	msleep(150);
> +
> +	panel_dbi_command(priv, 0xc1, 0x01);
> +	usleep_range(10000, 11000);
> +
> +	return 0;
> +};
> +
> +static int lg_lh400wv3_unprepare(struct drm_panel *panel)
> +{
> +	struct lg_lh400wv3 *priv = to_lg_lh400wv3(panel);
> +
> +	gpiod_set_value_cansleep(priv->reset_gpio, 1);
> +	regulator_bulk_disable(ARRAY_SIZE(lg_lh400wv3_supplies), priv->supplies);
> +
> +	msleep(50);
> +
> +	return 0;
> +}
> +
> +static const struct drm_display_mode lg_lh400wv3_mode = {
> +	.clock = (480 + 10 + 10 + 10) * (800 + 4 + 4 + 4) * 60 / 1000,
> +	.hdisplay = 480,
> +	.hsync_start = 480 + 10,
> +	.hsync_end = 480 + 10 + 10,
> +	.htotal = 480 + 10 + 10 + 10,
> +	.vdisplay = 800,
> +	.vsync_start = 800 + 4,
> +	.vsync_end = 800 + 4 + 4,
> +	.vtotal = 800 + 4 + 4 + 4,
> +	.width_mm = 52,
> +	.height_mm = 86,
> +	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
> +};
> +
> +static int lg_lh400wv3_get_modes(struct drm_panel *panel,
> +				 struct drm_connector *connector)
> +{
> +	u32 bus_format = MEDIA_BUS_FMT_RGB888_1X24;
> +
> +	drm_display_info_set_bus_formats(&connector->display_info,
> +					 &bus_format, 1);
> +
> +	connector->display_info.bus_flags = DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE |
> +					    DRM_BUS_FLAG_SYNC_SAMPLE_NEGEDGE |
> +					    DRM_BUS_FLAG_DE_HIGH |
> +					    DRM_BUS_FLAG_DATA_LSB_TO_MSB;
> +
> +	return drm_connector_helper_get_modes_fixed(connector, &lg_lh400wv3_mode);
> +}
> +
> +static const struct drm_panel_funcs lg_lh400wv3_panel_funcs = {
> +	.prepare = lg_lh400wv3_prepare,
> +	.enable = lg_lh400wv3_enable,
> +	.disable = lg_lh400wv3_disable,
> +	.unprepare = lg_lh400wv3_unprepare,
> +	.get_modes = lg_lh400wv3_get_modes,
> +};
> +
> +static int lg_lh400wv3_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct lg_lh400wv3 *priv;
> +	int ret;
> +
> +	priv = devm_drm_panel_alloc(dev, struct lg_lh400wv3, panel,
> +				    &lg_lh400wv3_panel_funcs, DRM_MODE_CONNECTOR_DPI);
> +	if (IS_ERR(priv))
> +		return PTR_ERR(priv);
> +
> +	ret = devm_regulator_bulk_get_const(dev, ARRAY_SIZE(lg_lh400wv3_supplies),
> +					    lg_lh400wv3_supplies, &priv->supplies);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get supplies\n");
> +
> +	priv->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(priv->reset_gpio))
> +		return dev_err_probe(dev, PTR_ERR(priv->reset_gpio),
> +				     "Failed to get reset gpio\n");
> +
> +	ret = drm_panel_of_backlight(&priv->panel);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get backlight\n");
> +
> +	ret = devm_drm_panel_add(dev, &priv->panel);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to add panel\n");
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id lg_lh400wv3_of_match[] = {
> +	{ .compatible = "lg,lh400wv3-sd04" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, lg_lh400wv3_of_match);
> +
> +static struct platform_driver lg_lh400wv3_driver = {
> +	.driver = {
> +		.name = "panel-lg-lh400wv3",
> +		.of_match_table = lg_lh400wv3_of_match,
> +	},
> +	.probe = lg_lh400wv3_probe,
> +};
> +module_platform_driver(lg_lh400wv3_driver);
> +
> +MODULE_AUTHOR("Svyatoslav Ryhel <clamor95@gmail.com>");
> +MODULE_DESCRIPTION("LG LH400WV3-SD04 MIPI DBI Type B panel driver");
> +MODULE_LICENSE("GPL");

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
