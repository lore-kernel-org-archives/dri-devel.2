Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE6C3C61DC2
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 09:54:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 203F810EC7E;
	Wed, 26 Aug 2026 09:54:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="snwytO5Q";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A95310EC7E
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 09:53:45 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-47f633e6058so581328f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 02:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787738024; x=1788342824; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5JrH7nWWgGuvLy0NhN9o6PtziTy8uleFbA9BsnogKWU=;
 b=snwytO5Qrrw9o7IQ2R6b9oFixevnaZvTMAeyA1WsaHDzkMwf+GzTMJT3ioElg3G8fA
 iYFuefd0yFqx39eB2mfdPLEknWLucyatXlKYlH0KbJqoQhPbeeexVZUn3fWNu5tIzOnc
 Xf8q8mojCub8xJj4/75cgxvu1KprqRmqoXBPblw2mHqTWLv1iaju4H/brlf6UT51QfhO
 Nl3Ie1zB0gpTlANYwSnV2utVkhHKZE6HMSgY6L4LMdas/kDq75wg3UjxBwGBSAazFHlp
 7xLTUiF/5ksU2lYPgB/xQMUW5RJKCJ3IdUbmZJW9dJBnC6tKB1K9OnJUFFA2Yjnxya6x
 /8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787738024; x=1788342824;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5JrH7nWWgGuvLy0NhN9o6PtziTy8uleFbA9BsnogKWU=;
 b=CmTENlfRHp11EdpiTgE33EGPo+eKlFqdWqAPpO6riNf8sRofLf8/1dn8KPJDum5wHx
 yMmqf/exYzZZgflsegTVGrbwH32lfgG2VRxHOeZJZxEyq2GCZ9OEFy3kkaiaRqFF90a4
 gwmhuWOW5FIlICWmKwNketLAKI5GpavRzLfQ7TkR1ZtJCIqTgN2ZbPX9i+/Zemz0a2v+
 xS4UvS+mdTYaV08itkVOVZ/BzlPa/qG5RDUa/iGNb9nX+iLxvnHp1Mx+AeKO5jpKlp5U
 SeXgmFY/U7MHSVP7gcK/GVdmQMTMU7fbRzIdPSapDCEnNoNgjuyKtue5VHOFK4mDG0ic
 zwOQ==
X-Gm-Message-State: AFuF++mK+4EvVDyiFCign/SslP79D78hU+2fx0wOpcT/Nfzc1O1XPhQJ
 O8/eugjOGSqazTS8vtmYH9pFQ82kK8gwncuBDJPsgwVcdykA0OmFHW0dsnzVSKcDL2A=
X-Gm-Gg: AR+sD13yBTLUNg6RuW9LtgsFsJ72KASFGc9g2lOHvF2Hhaai1mE7IYV9ka+s4RgvUA0
 oepWN5j6+QMLqkSXy0Ad7yOAU5SR+njjPQV79kda9bzFq/XfQNaT6TB1otpWXfhnMPfrsHTu45q
 DSdtv/xTxeNxY6XncbVCDyejhPyC+0zljvz04Vg13GQkrKxT98kwLlI2C0L1WgJj8M54qX9OMis
 Ny+Uo/wtPievfBFOUbBOj6GFVfWDXqOZwwDwutD5bvhxTZ4h60Vj/wzHWUxbVSV0tJpaTuZ6Fsu
 E6xOIPEoByoMdC7p6liDgXDchmKPrP027tmPEDCynxWTvJMYoUSGPgQSHbftj8LklgGAvCbpvHQ
 AnAppARNlo/M/6z2fr/lcSJq8bMZv3Qw2wT12dka2iztuqwC4A9tA1JvQBNIBythWXBI+Kps92p
 VKZQPfQqnK4oMbdTxWdrKDuu2DmwIvY7dZAGaPTFE/RGM6GzRcxP7O1cHW4VJqBx+bE9ERZM7Ko
 ZHc8/gH36Kw3d47SGiGdrHqWyjx4I8TObywPUHT427Bvg==
X-Received: by 2002:a05:600c:a01:b0:496:c1f3:e8f8 with SMTP id
 5b1f17b1804b1-499dc7015bfmr42175085e9.7.1787738023576; 
 Wed, 26 Aug 2026 02:53:43 -0700 (PDT)
Received: from ?IPV6:2a0d:e487:135f:84f0:37f7:9223:8e7a:9b5f?
 ([2a0d:e487:135f:84f0:37f7:9223:8e7a:9b5f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dc977b7csm21589845e9.7.2026.08.26.02.53.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 02:53:43 -0700 (PDT)
Message-ID: <007e73a9-8220-46bb-89c6-2354740392c8@linaro.org>
Date: Wed, 26 Aug 2026 11:53:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 3/4] drm/panel: visionox-vtdr6130: Modularize panel config
To: webgeek1234@gmail.com, Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260814-rp6-panel-v1-0-111c1aeccf0f@gmail.com>
 <20260814-rp6-panel-v1-3-111c1aeccf0f@gmail.com>
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
In-Reply-To: <20260814-rp6-panel-v1-3-111c1aeccf0f@gmail.com>
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

On 8/14/26 20:17, Aaron Kling via B4 Relay wrote:
> From: Aaron Kling <webgeek1234@gmail.com>
> 
> The vtdr6130 is a DDIC, a common chip that is used by multiple panels.
> Prepare the driver for more panels.
> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>   drivers/gpu/drm/panel/panel-visionox-vtdr6130.c | 95 +++++++++++++++++--------
>   1 file changed, 65 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c b/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
> index b66d6c7128c75..805c9846c2a0b 100644
> --- a/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
> +++ b/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
> @@ -19,11 +19,28 @@
>   
>   struct visionox_vtdr6130 {
>   	struct drm_panel panel;
> -	struct drm_dsc_config dsc;
> +	struct drm_connector *connector;

Why ? connector is unused in this patch.

>   	struct mipi_dsi_device *dsi;
>   	struct gpio_desc *reset_gpio;
>   	struct regulator_bulk_data *supplies;
>   	enum drm_panel_orientation orientation;
> +	struct visionox_vtdr6130_desc *desc;
> +};
> +
> +struct visionox_vtdr6130_desc {
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
> +	int (*init_sequence)(struct visionox_vtdr6130 *ctx);
> +
> +	struct drm_dsc_config dsc;
>   };
>   
>   static const struct regulator_bulk_data visionox_vtdr6130_supplies[] = {
> @@ -162,7 +179,7 @@ static int visionox_vtdr6130_prepare(struct drm_panel *panel)
>   
>   	visionox_vtdr6130_reset(ctx);
>   
> -	ret = visionox_vtdr6130_on(ctx);
> +	ret = ctx->desc->init_sequence(ctx);
>   	if (ret < 0) {
>   		gpiod_set_value_cansleep(ctx->reset_gpio, 1);
>   		regulator_bulk_disable(ARRAY_SIZE(visionox_vtdr6130_supplies),
> @@ -187,34 +204,58 @@ static int visionox_vtdr6130_unprepare(struct drm_panel *panel)
>   	return 0;
>   }
>   
> -static const struct drm_display_mode visionox_vtdr6130_mode = {
> -	.clock = (1080 + 20 + 2 + 20) * (2400 + 20 + 2 + 18) * 144 / 1000,
> -	.hdisplay = 1080,
> -	.hsync_start = 1080 + 20,
> -	.hsync_end = 1080 + 20 + 2,
> -	.htotal = 1080 + 20 + 2 + 20,
> -	.vdisplay = 2400,
> -	.vsync_start = 2400 + 20,
> -	.vsync_end = 2400 + 20 + 2,
> -	.vtotal = 2400 + 20 + 2 + 18,
> +static const struct drm_display_mode visionox_vtdr6130_modes[] = {
> +	{
> +		.clock = (1080 + 20 + 2 + 20) * (2400 + 20 + 2 + 18) * 144 / 1000,
> +		.hdisplay = 1080,
> +		.hsync_start = 1080 + 20,
> +		.hsync_end = 1080 + 20 + 2,
> +		.htotal = 1080 + 20 + 2 + 20,
> +		.vdisplay = 2400,
> +		.vsync_start = 2400 + 20,
> +		.vsync_end = 2400 + 20 + 2,
> +		.vtotal = 2400 + 20 + 2 + 18,
> +	},
> +};
> +
> +static struct visionox_vtdr6130_desc visionox_vtdr6130_panel_desc = {
> +	.modes = visionox_vtdr6130_modes,
> +	.num_modes = ARRAY_SIZE(visionox_vtdr6130_modes),
>   	.width_mm = 71,
>   	.height_mm = 157,

Why did you move the width/height out of the mode ?

Leave it in the mode, since you don't even use the same mode for the Retroid 6 panel

> +	.bpc = 8,
> +	.lanes = 4,
> +	.format = MIPI_DSI_FMT_RGB888,
> +	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_NO_EOT_PACKET |
> +		      MIPI_DSI_CLOCK_NON_CONTINUOUS,
> +	.init_sequence = visionox_vtdr6130_on,
> +	.dsc = {
> +		.dsc_version_major = 0x1,
> +		.dsc_version_minor = 0x2,
> +		.slice_height = 40,
> +		.slice_width = 540,
> +		.slice_count = 2,
> +		.bits_per_component = 8,
> +		.bits_per_pixel = 8 << 4,
> +		.block_pred_enable = true,
> +	},
>   };
>   
>   static int visionox_vtdr6130_get_modes(struct drm_panel *panel,
>   				       struct drm_connector *connector)
>   {
> +	struct visionox_vtdr6130 *ctx = to_visionox_vtdr6130(panel);
>   	struct drm_display_mode *mode;
>   
> -	mode = drm_mode_duplicate(connector->dev, &visionox_vtdr6130_mode);
> +	mode = drm_mode_duplicate(connector->dev, ctx->desc->modes);
>   	if (!mode)
>   		return -ENOMEM;
>   
>   	drm_mode_set_name(mode);
>   
>   	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
> -	connector->display_info.width_mm = mode->width_mm;
> -	connector->display_info.height_mm = mode->height_mm;
> +	connector->display_info.width_mm = ctx->desc->width_mm;
> +	connector->display_info.height_mm = ctx->desc->height_mm;

Drop this change, take them from the mode.

>   	drm_mode_probed_add(connector, mode);
>   
>   	return 1;
> @@ -284,23 +325,17 @@ static int visionox_vtdr6130_probe(struct mipi_dsi_device *dsi)
>   		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
>   				     "Failed to get reset-gpios\n");
>   
> +	ctx->desc = (struct visionox_vtdr6130_desc *)of_device_get_match_data(dev);
> +	if (!ctx->desc)
> +		return -ENODEV;
> +
>   	ctx->dsi = dsi;
>   	mipi_dsi_set_drvdata(dsi, ctx);
>   
> -	ctx->dsc.dsc_version_major = 0x1;
> -	ctx->dsc.dsc_version_minor = 0x2;
> -	ctx->dsc.slice_height = 40;
> -	ctx->dsc.slice_width = 540;
> -	ctx->dsc.slice_count = 2;
> -	ctx->dsc.bits_per_component = 8;
> -	ctx->dsc.bits_per_pixel = 8 << 4;
> -	ctx->dsc.block_pred_enable = true;
> -
> -	dsi->dsc = &ctx->dsc;
> -	dsi->lanes = 4;
> -	dsi->format = MIPI_DSI_FMT_RGB888;
> -	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_NO_EOT_PACKET |
> -			  MIPI_DSI_CLOCK_NON_CONTINUOUS;
> +	dsi->dsc = &ctx->desc->dsc;
> +	dsi->lanes = ctx->desc->lanes;
> +	dsi->format = ctx->desc->format;
> +	dsi->mode_flags = ctx->desc->mode_flags;
>   	ctx->panel.prepare_prev_first = true;
>   
>   	ret = drm_of_get_panel_orientation(dev->of_node, &ctx->orientation);
> @@ -322,7 +357,7 @@ static int visionox_vtdr6130_probe(struct mipi_dsi_device *dsi)
>   }
>   
>   static const struct of_device_id visionox_vtdr6130_of_match[] = {
> -	{ .compatible = "visionox,vtdr6130" },
> +	{ .compatible = "visionox,vtdr6130", .data = &visionox_vtdr6130_panel_desc },
>   	{ /* sentinel */ }
>   };
>   MODULE_DEVICE_TABLE(of, visionox_vtdr6130_of_match);
> 

Thanks,
Neil

