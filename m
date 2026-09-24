Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C624CC9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 13:27:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E452310F4EF;
	Thu, 24 Sep 2026 13:27:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LpiJddnt";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC45810F4EF
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 13:27:00 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49cd38e0e5dso26097515e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 06:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790256419; x=1790861219; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bR8KLVmfkqlUwLeA5NPAg5mdoYKwiz6mqVtLy5sMUQI=;
 b=LpiJddnt7Gz0hOKdpySKWIlN6NIdXS+NPwMKa+S4JGtC2FtI96MScTsdZ7BLzHjR97
 9cropC1QyZyrAPIg2cD46fBY1kpPIOZFR0OJ96LSl5X9XzPA5CXEuVr5JdUB9sb4AM2a
 LyBlswLkebzymOaDPR8v/6Pav+rnwLMf5PXIAYUBOGMAAxTYDVlrjhHdgDXJTLBUpP5w
 0C/qsHYiBqREel3c64xwrmuzXT+0mUZ3j2qlvgTeZcKCn9bVz+xxKmSCf8nCdhrxGNU1
 sqxnqxXC0LyhiT81NvcI4iIHjb7xGRu+CnYIsC25dq3pzvxW6JV3Whf3y2w+y8hCBFbE
 FS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790256419; x=1790861219;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bR8KLVmfkqlUwLeA5NPAg5mdoYKwiz6mqVtLy5sMUQI=;
 b=NJCyipw41qB+VcJNA8F/WQbq4RNLIB9pskbLBEvHSSmL0/0l+65Pm45AmJsYjnZ8O1
 8wsLKQdBZAB2owKqvSyGUxBIQX4OCM9EBDGroSAYduJIqyQdipzoDl4IVlIiq6RPw1jH
 fp3xwfhWDs2XR8StbYmMM+kiNmrM4NYXkw9fYtmYX385EUzgPUfDkD4u90FY9IVE32Df
 YoU7NX2NExWTjBVY5FS6/aZIgN7fmaVQ3YdAHRVbfFSQpMVLe81v8QtxI5W30ZxuzNeF
 z98aZobcvrKQjUfeYbDEB40wku3UupIKHtBYdoSdC37hhBeUf6V6fA75lRpRrAx7ZiOR
 XOtA==
X-Gm-Message-State: AFuF++lrWPwRv0/ZPEgHWByoKJ+BKiQ0MH64+mqiob4bXCqZbq1oizLQ
 O50Wd7Io7ITvHJJEDEw/89fSWbdtdS/MWSbD+tKiUuGWcdwIiT/5mz0kH8YMK7wtKAI=
X-Gm-Gg: AYBFou223iSukdDf52AwfStnTUhfJoOT+Adifl0DGbFpsElqOJbBPVyWyQnbc4/6CQs
 KM7tbQYXR0W4yahNUyhQ6BaNp/VQqGLPf82GC0fla+XcZJjffmPX5UBjBOnU2V6v5zXGMOapQtB
 uhOIEgS4MOScaSc2zt4GvDI5MwEAuaCYUsR4Ujx1B6zZzNbiCl0tDFRzasAiNh7wdoYVr1Wskr/
 HtRe4XUkrJgSUJvQw5aB6RxFUgR49yqWUUu9b0oqz4AaGRuqnYG+ICOZjkz+tDfB+WpHmWppZP0
 zJnnQ7RtNYrPYPekRV3ng5UdpQljaIl1Isv+N1hAzo06hD0A99F9p7HYochgcNqj3KrT0GKsT66
 1C5UIuzYHBVFcNHk8ta01xB1nRlOKFKeA1p4/CQVx7Of2eQSs4rXWOtAozJHKMf1v0k2ZqzeJNw
 IhrrcIsdkJXEM4F2x5f0185ZCtJSkc7+aeD4EwtBNLbCnKIv+r34eQNwSORAfc9fZu728rdvcy/
 4tU3WuNm8QW/ozjl4APp7dc67nLwtwaX7EmjKWO44RlXAMny2jqVQ==
X-Received: by 2002:a05:600c:1c08:b0:49f:e0f4:1aac with SMTP id
 5b1f17b1804b1-49fe66fd431mr48391305e9.25.1790256418908; 
 Thu, 24 Sep 2026 06:26:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:336e:a1a0:8f96:9f7a?
 ([2a01:e0a:106d:1080:336e:a1a0:8f96:9f7a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdf99df60sm108015625e9.1.2026.09.24.06.26.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2026 06:26:58 -0700 (PDT)
Message-ID: <aac7a74b-e1e8-4956-b1e9-4c4e1e04a6ec@linaro.org>
Date: Thu, 24 Sep 2026 15:26:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 06/11] drm/panel: s6e3ha8: Correct the polarity logic
 within
To: david@ixit.cz, Dzmitry Sankouski <dsankouski@gmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 phone-devel@vger.kernel.org
References: <20260920-crosshatch-panel-v1-0-de6e9512da96@ixit.cz>
 <20260920-crosshatch-panel-v1-6-de6e9512da96@ixit.cz>
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
In-Reply-To: <20260920-crosshatch-panel-v1-6-de6e9512da96@ixit.cz>
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

On 9/20/26 13:05, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> The reset was introduced with wrong polarity. Correct for the future
> compatibles and keep current with reverted logic.
> 
> Old DTs keep GPIO_ACTIVE_HIGH and are fixed up via
> gpiod_toggle_active_low() on the deprecated compatible.
> 
> Assisted-by: LLM
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>   drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c | 23 +++++++++++++++++++----
>   1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c b/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
> index 5e1e997b83b36..99290913de69a 100644
> --- a/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
> +++ b/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
> @@ -20,16 +20,17 @@
>   #include "panel-samsung-dsi.h"
>   
>   struct s6e3ha8_desc {
>   	const struct drm_panel_funcs *funcs;
>   	const struct drm_display_mode *mode;
>   	unsigned long mode_flags;
>   	const struct regulator_bulk_data *supplies;
>   	unsigned int num_supplies;
> +	bool broken_reset_polarity;
>   };
>   
>   struct s6e3ha8 {
>   	struct drm_panel panel;
>   	struct mipi_dsi_device *dsi;
>   	const struct s6e3ha8_desc *desc;
>   	struct drm_dsc_config dsc;
>   	struct gpio_desc *reset_gpio;
> @@ -62,22 +63,22 @@ static int s6e3ha8_unprepare(struct drm_panel *panel)
>   {
>   	struct s6e3ha8 *priv = to_s6e3ha8(panel);
>   
>   	return regulator_bulk_disable(priv->desc->num_supplies, priv->supplies);
>   }
>   
>   static void s6e3ha8_amb577px01_wqhd_reset(struct s6e3ha8 *priv)
>   {
> -	gpiod_set_value_cansleep(priv->reset_gpio, 1);
> -	usleep_range(5000, 6000);
>   	gpiod_set_value_cansleep(priv->reset_gpio, 0);
>   	usleep_range(5000, 6000);
>   	gpiod_set_value_cansleep(priv->reset_gpio, 1);
>   	usleep_range(5000, 6000);
> +	gpiod_set_value_cansleep(priv->reset_gpio, 0);
> +	usleep_range(5000, 6000);
>   }
>   
>   static int s6e3ha8_amb577px01_wqhd_on(struct s6e3ha8 *priv)
>   {
>   	struct mipi_dsi_device *dsi = priv->dsi;
>   	struct mipi_dsi_multi_context ctx = { .dsi = dsi };
>   
>   	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
> @@ -203,17 +204,17 @@ static int s6e3ha8_amb577px01_wqhd_prepare(struct drm_panel *panel)
>   	ret = regulator_bulk_enable(priv->desc->num_supplies, priv->supplies);
>   	if (ret < 0)
>   		return ret;
>   	mipi_dsi_msleep(&ctx, 120);
>   	s6e3ha8_amb577px01_wqhd_reset(priv);
>   
>   	ret = s6e3ha8_amb577px01_wqhd_on(priv);
>   	if (ret < 0) {
> -		gpiod_set_value_cansleep(priv->reset_gpio, 0);
> +		gpiod_set_value_cansleep(priv->reset_gpio, 1);
>   		goto err;
>   	}
>   
>   	drm_dsc_pps_payload_pack(&pps, &priv->dsc);
>   
>   	samsung_dsi_test_key_on_lvl1(&ctx);
>   	mipi_dsi_picture_parameter_set_multi(&ctx, &pps);
>   	samsung_dsi_test_key_off_lvl1(&ctx);
> @@ -243,16 +244,27 @@ static const struct drm_display_mode s6e3ha8_amb577px01_wqhd_mode = {
>   static const struct drm_panel_funcs s6e3ha8_amb577px01_wqhd_panel_funcs = {
>   	.prepare = s6e3ha8_amb577px01_wqhd_prepare,
>   	.unprepare = s6e3ha8_unprepare,
>   	.get_modes = s6e3ha8_get_modes,
>   	.enable = s6e3ha8_amb577px01_wqhd_enable,
>   	.disable = s6e3ha8_amb577px01_wqhd_disable,
>   };
>   
> +static const struct s6e3ha8_desc s6e3ha8_amb577px01_wqhd_desc_legacy = {
> +	.funcs = &s6e3ha8_amb577px01_wqhd_panel_funcs,
> +	.mode = &s6e3ha8_amb577px01_wqhd_mode,
> +	.mode_flags = MIPI_DSI_CLOCK_NON_CONTINUOUS |
> +		MIPI_DSI_MODE_VIDEO_NO_HFP | MIPI_DSI_MODE_VIDEO_NO_HBP |
> +		MIPI_DSI_MODE_VIDEO_NO_HSA | MIPI_DSI_MODE_NO_EOT_PACKET,
> +	.supplies = s6e3ha8_vddr_supplies,
> +	.num_supplies = ARRAY_SIZE(s6e3ha8_vddr_supplies),
> +	.broken_reset_polarity = true,
> +};
> +
>   static const struct s6e3ha8_desc s6e3ha8_amb577px01_wqhd_desc = {
>   	.funcs = &s6e3ha8_amb577px01_wqhd_panel_funcs,
>   	.mode = &s6e3ha8_amb577px01_wqhd_mode,
>   	.mode_flags = MIPI_DSI_CLOCK_NON_CONTINUOUS |
>   		MIPI_DSI_MODE_VIDEO_NO_HFP | MIPI_DSI_MODE_VIDEO_NO_HBP |
>   		MIPI_DSI_MODE_VIDEO_NO_HSA | MIPI_DSI_MODE_NO_EOT_PACKET,
>   	.supplies = s6e3ha8_vddr_supplies,
>   	.num_supplies = ARRAY_SIZE(s6e3ha8_vddr_supplies),
> @@ -283,16 +295,19 @@ static int s6e3ha8_probe(struct mipi_dsi_device *dsi)
>   		return ret;
>   	}
>   
>   	priv->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
>   	if (IS_ERR(priv->reset_gpio))
>   		return dev_err_probe(dev, PTR_ERR(priv->reset_gpio),
>   				     "Failed to get reset-gpios\n");
>   
> +	if (priv->desc->broken_reset_polarity)
> +		gpiod_toggle_active_low(priv->reset_gpio);
> +
>   	priv->dsi = dsi;
>   	mipi_dsi_set_drvdata(dsi, priv);
>   
>   	dsi->lanes = 4;
>   	dsi->format = MIPI_DSI_FMT_RGB888;
>   	dsi->mode_flags = priv->desc->mode_flags;
>   
>   	priv->panel.prepare_prev_first = true;
> @@ -323,17 +338,17 @@ static int s6e3ha8_probe(struct mipi_dsi_device *dsi)
>   
>   	return 0;
>   }
>   
>   static const struct of_device_id s6e3ha8_of_match[] = {
>   	{
>   		/* deprecated */
>   		.compatible = "samsung,s6e3ha8",
> -		.data = &s6e3ha8_amb577px01_wqhd_desc,
> +		.data = &s6e3ha8_amb577px01_wqhd_desc_legacy,
>   	}, {
>   		.compatible = "samsung,s6e3ha8-amb577px01",
>   		.data = &s6e3ha8_amb577px01_wqhd_desc,
>   	},
>   	{ /* sentinel */ }
>   };
>   MODULE_DEVICE_TABLE(of, s6e3ha8_of_match);
>   
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
