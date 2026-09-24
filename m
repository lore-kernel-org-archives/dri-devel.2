Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760ABC98317
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 13:26:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D196210F555;
	Thu, 24 Sep 2026 13:26:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QoofDQeH";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1F5210F555
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 13:26:18 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49ccf3ca626so11713945e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 06:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790256377; x=1790861177; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3YpbC2cevJhCGSNlrQqP8f2EEjaO7UmMh+iM/qOZL28=;
 b=QoofDQeHqdZvxqo2JpHpd4sGGIiL8Ln2e1YB9L2EuDP2BlsQCRp1IMfrVr4QGMmpJp
 pUC9wmH4oO/e/nFjCpJzP4MPUHLz0dzGdRKW7W7+XLv08mQHtHIUC4fOlcYucbsjEhg2
 Z82hHxbTrcp1BLbdd0cWZ9qMzC8+8YZwhqb5QhXmf70VDbmL8Kq1my05VkNcBiIRTDWF
 GkG3N85UIIfT4Y+4LrrcGpwc+9wId/YDCGEIwZbT6HZ1i4zpaFjvyAtLGy80ZRjZXX2x
 M8Q+ZIN5VIxN24dhY6X7z4+8ZzOqNgsq2iONd/y2G55oe9vISnVuFHOADyN8oZ6KEkUj
 xVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790256377; x=1790861177;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3YpbC2cevJhCGSNlrQqP8f2EEjaO7UmMh+iM/qOZL28=;
 b=QN+66KzITNKHMf0qN97czEvCiA+QpGmjO2XMEBJUNtuIg/5SiVavAHTrZ7FU6BRBwZ
 jnXO1qgP7RidOkIFmtqPAVHr8EtrxjDPy5+85RT8w9n22Crl2eaig+Cr5HERSi5UAeaI
 e0mNPXmJ2YeDAQy29++htHjsx2Vqbq0M1pLOzMZa9iqVA8lAQ/B5vvEey3E/QxK7FFgU
 UaMlA4mPGegt3rii8t2PDiug7FCoaSUHiCnqtaKa+g/XG4x3549seoAjinRo0M7YxX4Z
 yD6yiz+bdHL8kJAyMGyfiJyDT9hN0Qnug9y032yb+ZhQVLDhaaegXhQ91neIIDJgGDXL
 inRw==
X-Gm-Message-State: AFuF++kPMV2PsZqDe59yBWMucP4JGcGYFAJdkTozeFCiWxSKx/WinWme
 5hfOsYOUzZLHQOugf70CAjURPtLpZsPhspWFNjMeGvF0rYJKDffALEQdd0x6kLhw7FY=
X-Gm-Gg: AYBFou1+cMhGMh4Zkq2SHAB8MFwk2+IFW+6CPF0ML5Wfx16QfUyiUkbr8N8LB7wYfVW
 e29BaNaqIwEcvQgBcU+yip0MEPQCmwOyRdq62C6xdOTX05UeCsC82Z5SgpFK1G2pTF6rpA4G/AM
 kofDEycbb2E83LyTSuaesJRkGHQyKtOi+RgjtMkVScTBqszbJjD1PQJYfHz1VTPr82LdWL4dPEm
 eDvgI/Z7Hw0JbeFtJiOyIc5RrBBq3vOKP9gnkQ9PxDLFPC5RPzZLI82WZFVE6T14e1vaqnFDiSM
 SmK2dgS95vpLvH48qvJSkovCUdf+OdCeXr30vTncIHT9jf1u3nAUdTK5S0KKOC0gWs3WuCAP8Vz
 m5TZsnPyuX/YrkxydVAuYr+dvJjbIXDYR+fn5GKSBkJ/3GDeqoKOkAfZc+1K8AqtcNae2JZ9uTT
 SmtbSEG3TKvJ1sAq947Uig3kyor8sFb1Bw+HDwGTr9qp/AQ3IzsC5O2PBw6dEl1cSCzTDxjKqoS
 3txfP0UCR+bETrfUI4MIrBPKIa7wVcRy7iLENqBJlv0wFupB/pbeAQ=
X-Received: by 2002:a05:600c:a00b:b0:49c:cee2:a508 with SMTP id
 5b1f17b1804b1-49fe66eaff3mr36849325e9.16.1790256376895; 
 Thu, 24 Sep 2026 06:26:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:336e:a1a0:8f96:9f7a?
 ([2a01:e0a:106d:1080:336e:a1a0:8f96:9f7a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5bae53dsm70497035e9.4.2026.09.24.06.26.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2026 06:26:16 -0700 (PDT)
Message-ID: <104333a1-5e38-40e9-968f-00f9bb324a3c@linaro.org>
Date: Thu, 24 Sep 2026 15:26:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 05/11] drm/panel: s6e3ha8: Prepare for supporting multiple
 panels
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
 <20260920-crosshatch-panel-v1-5-de6e9512da96@ixit.cz>
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
In-Reply-To: <20260920-crosshatch-panel-v1-5-de6e9512da96@ixit.cz>
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
> The S6E3HA8 DDIC drives more panels than the Galaxy S9 (AMB577PX01)
> one currently supported. Move the display mode, DSI mode flags,
> regulator supplies and panel functions into a per-compatible descriptor
> passed as OF match data, and rename the panel-specific symbols
> accordingly.
> 
> No functional change.
> 
> Assisted-by: LLM
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>   drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c | 118 ++++++++++++++++----------
>   1 file changed, 74 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c b/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
> index a0015ac0e2782..5e1e997b83b36 100644
> --- a/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
> +++ b/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
> @@ -3,49 +3,73 @@
>   // Generated with linux-mdss-dsi-panel-driver-generator from vendor device tree:
>   //	Copyright (c) 2013, The Linux Foundation. All rights reserved.
>   // Copyright (c) 2024 Dzmitry Sankouski <dsankouski@gmail.com>
>   
>   #include <linux/delay.h>
>   #include <linux/gpio/consumer.h>
>   #include <linux/module.h>
>   #include <linux/of.h>
> +#include <linux/property.h>
>   #include <linux/regulator/consumer.h>
>   
>   #include <drm/display/drm_dsc.h>
>   #include <drm/display/drm_dsc_helper.h>
>   #include <drm/drm_mipi_dsi.h>
>   #include <drm/drm_probe_helper.h>
>   #include <drm/drm_panel.h>
>   
>   #include "panel-samsung-dsi.h"
>   
> +struct s6e3ha8_desc {
> +	const struct drm_panel_funcs *funcs;
> +	const struct drm_display_mode *mode;
> +	unsigned long mode_flags;
> +	const struct regulator_bulk_data *supplies;
> +	unsigned int num_supplies;
> +};
> +
>   struct s6e3ha8 {
>   	struct drm_panel panel;
>   	struct mipi_dsi_device *dsi;
> +	const struct s6e3ha8_desc *desc;
>   	struct drm_dsc_config dsc;
>   	struct gpio_desc *reset_gpio;
>   	struct regulator_bulk_data *supplies;
>   };
>   
> -static const struct regulator_bulk_data s6e3ha8_supplies[] = {
> +static const struct regulator_bulk_data s6e3ha8_vddr_supplies[] = {
>   	{ .supply = "vdd3" },
>   	{ .supply = "vci" },
>   	{ .supply = "vddr" },
>   };
>   
> -static inline
> -struct s6e3ha8 *to_s6e3ha8_amb577px01_wqhd(struct drm_panel *panel)
> +static inline struct s6e3ha8 *to_s6e3ha8(struct drm_panel *panel)
>   {
>   	return container_of(panel, struct s6e3ha8, panel);
>   }
>   
>   #define s6e3ha8_afc_off(ctx) \
>   	mipi_dsi_dcs_write_seq_multi(ctx, 0xe2, 0x00, 0x00)
>   
> +static int s6e3ha8_get_modes(struct drm_panel *panel,
> +			     struct drm_connector *connector)
> +{
> +	struct s6e3ha8 *priv = to_s6e3ha8(panel);
> +
> +	return drm_connector_helper_get_modes_fixed(connector, priv->desc->mode);
> +}
> +
> +static int s6e3ha8_unprepare(struct drm_panel *panel)
> +{
> +	struct s6e3ha8 *priv = to_s6e3ha8(panel);
> +
> +	return regulator_bulk_disable(priv->desc->num_supplies, priv->supplies);
> +}
> +
>   static void s6e3ha8_amb577px01_wqhd_reset(struct s6e3ha8 *priv)
>   {
>   	gpiod_set_value_cansleep(priv->reset_gpio, 1);
>   	usleep_range(5000, 6000);
>   	gpiod_set_value_cansleep(priv->reset_gpio, 0);
>   	usleep_range(5000, 6000);
>   	gpiod_set_value_cansleep(priv->reset_gpio, 1);
>   	usleep_range(5000, 6000);
> @@ -130,32 +154,32 @@ static int s6e3ha8_amb577px01_wqhd_on(struct s6e3ha8 *priv)
>   	mipi_dsi_dcs_write_seq_multi(&ctx, 0xf7, 0x03); /* Gamma, LTPS(AID) update */
>   	samsung_dsi_test_key_off_lvl2(&ctx);
>   
>   	samsung_dsi_test_key_off_lvl1(&ctx);
>   
>   	return ctx.accum_err;
>   }
>   
> -static int s6e3ha8_enable(struct drm_panel *panel)
> +static int s6e3ha8_amb577px01_wqhd_enable(struct drm_panel *panel)
>   {
> -	struct s6e3ha8 *priv = to_s6e3ha8_amb577px01_wqhd(panel);
> +	struct s6e3ha8 *priv = to_s6e3ha8(panel);
>   	struct mipi_dsi_device *dsi = priv->dsi;
>   	struct mipi_dsi_multi_context ctx = { .dsi = dsi };
>   
>   	samsung_dsi_test_key_on_lvl1(&ctx);
>   	mipi_dsi_dcs_set_display_on_multi(&ctx);
>   	samsung_dsi_test_key_off_lvl1(&ctx);
>   
>   	return ctx.accum_err;
>   }
>   
> -static int s6e3ha8_disable(struct drm_panel *panel)
> +static int s6e3ha8_amb577px01_wqhd_disable(struct drm_panel *panel)
>   {
> -	struct s6e3ha8 *priv = to_s6e3ha8_amb577px01_wqhd(panel);
> +	struct s6e3ha8 *priv = to_s6e3ha8(panel);
>   	struct mipi_dsi_device *dsi = priv->dsi;
>   	struct mipi_dsi_multi_context ctx = { .dsi = dsi };
>   
>   	samsung_dsi_test_key_on_lvl1(&ctx);
>   	mipi_dsi_dcs_set_display_off_multi(&ctx);
>   	samsung_dsi_test_key_off_lvl1(&ctx);
>   	mipi_dsi_msleep(&ctx, 20);
>   
> @@ -165,23 +189,23 @@ static int s6e3ha8_disable(struct drm_panel *panel)
>   
>   	mipi_dsi_msleep(&ctx, 160);
>   
>   	return ctx.accum_err;
>   }
>   
>   static int s6e3ha8_amb577px01_wqhd_prepare(struct drm_panel *panel)
>   {
> -	struct s6e3ha8 *priv = to_s6e3ha8_amb577px01_wqhd(panel);
> +	struct s6e3ha8 *priv = to_s6e3ha8(panel);
>   	struct mipi_dsi_device *dsi = priv->dsi;
>   	struct mipi_dsi_multi_context ctx = { .dsi = dsi };
>   	struct drm_dsc_picture_parameter_set pps;
>   	int ret;
>   
> -	ret = regulator_bulk_enable(ARRAY_SIZE(s6e3ha8_supplies), priv->supplies);
> +	ret = regulator_bulk_enable(priv->desc->num_supplies, priv->supplies);
>   	if (ret < 0)
>   		return ret;
>   	mipi_dsi_msleep(&ctx, 120);
>   	s6e3ha8_amb577px01_wqhd_reset(priv);
>   
>   	ret = s6e3ha8_amb577px01_wqhd_on(priv);
>   	if (ret < 0) {
>   		gpiod_set_value_cansleep(priv->reset_gpio, 0);
> @@ -193,88 +217,88 @@ static int s6e3ha8_amb577px01_wqhd_prepare(struct drm_panel *panel)
>   	samsung_dsi_test_key_on_lvl1(&ctx);
>   	mipi_dsi_picture_parameter_set_multi(&ctx, &pps);
>   	samsung_dsi_test_key_off_lvl1(&ctx);
>   
>   	mipi_dsi_msleep(&ctx, 28);
>   
>   	return ctx.accum_err;
>   err:
> -	regulator_bulk_disable(ARRAY_SIZE(s6e3ha8_supplies), priv->supplies);
> +	regulator_bulk_disable(priv->desc->num_supplies, priv->supplies);
>   	return ret;
>   }
>   
> -static int s6e3ha8_amb577px01_wqhd_unprepare(struct drm_panel *panel)
> -{
> -	struct s6e3ha8 *priv = to_s6e3ha8_amb577px01_wqhd(panel);
> -
> -	return regulator_bulk_disable(ARRAY_SIZE(s6e3ha8_supplies), priv->supplies);
> -}
> -
>   static const struct drm_display_mode s6e3ha8_amb577px01_wqhd_mode = {
>   	.clock = (1440 + 116 + 44 + 120) * (2960 + 120 + 80 + 124) * 60 / 1000,
>   	.hdisplay = 1440,
>   	.hsync_start = 1440 + 116,
>   	.hsync_end = 1440 + 116 + 44,
>   	.htotal = 1440 + 116 + 44 + 120,
>   	.vdisplay = 2960,
>   	.vsync_start = 2960 + 120,
>   	.vsync_end = 2960 + 120 + 80,
>   	.vtotal = 2960 + 120 + 80 + 124,
>   	.width_mm = 64,
>   	.height_mm = 132,
>   };
>   
> -static int s6e3ha8_amb577px01_wqhd_get_modes(struct drm_panel *panel,
> -					     struct drm_connector *connector)
> -{
> -	return drm_connector_helper_get_modes_fixed(connector, &s6e3ha8_amb577px01_wqhd_mode);
> -}
> -
>   static const struct drm_panel_funcs s6e3ha8_amb577px01_wqhd_panel_funcs = {
>   	.prepare = s6e3ha8_amb577px01_wqhd_prepare,
> -	.unprepare = s6e3ha8_amb577px01_wqhd_unprepare,
> -	.get_modes = s6e3ha8_amb577px01_wqhd_get_modes,
> -	.enable = s6e3ha8_enable,
> -	.disable = s6e3ha8_disable,
> +	.unprepare = s6e3ha8_unprepare,
> +	.get_modes = s6e3ha8_get_modes,
> +	.enable = s6e3ha8_amb577px01_wqhd_enable,
> +	.disable = s6e3ha8_amb577px01_wqhd_disable,
> +};
> +
> +static const struct s6e3ha8_desc s6e3ha8_amb577px01_wqhd_desc = {
> +	.funcs = &s6e3ha8_amb577px01_wqhd_panel_funcs,
> +	.mode = &s6e3ha8_amb577px01_wqhd_mode,
> +	.mode_flags = MIPI_DSI_CLOCK_NON_CONTINUOUS |
> +		MIPI_DSI_MODE_VIDEO_NO_HFP | MIPI_DSI_MODE_VIDEO_NO_HBP |
> +		MIPI_DSI_MODE_VIDEO_NO_HSA | MIPI_DSI_MODE_NO_EOT_PACKET,
> +	.supplies = s6e3ha8_vddr_supplies,
> +	.num_supplies = ARRAY_SIZE(s6e3ha8_vddr_supplies),
>   };
>   
> -static int s6e3ha8_amb577px01_wqhd_probe(struct mipi_dsi_device *dsi)
> +static int s6e3ha8_probe(struct mipi_dsi_device *dsi)
>   {
>   	struct device *dev = &dsi->dev;
> +	const struct s6e3ha8_desc *desc;
>   	struct s6e3ha8 *priv;
>   	int ret;
>   
> -	priv = devm_drm_panel_alloc(dev, struct s6e3ha8, panel,
> -				    &s6e3ha8_amb577px01_wqhd_panel_funcs,
> +	desc = device_get_match_data(dev);
> +	if (!desc)
> +		return -ENODEV;
> +
> +	priv = devm_drm_panel_alloc(dev, struct s6e3ha8, panel, desc->funcs,
>   				    DRM_MODE_CONNECTOR_DSI);
>   	if (IS_ERR(priv))
>   		return PTR_ERR(priv);
>   
> -	ret = devm_regulator_bulk_get_const(dev, ARRAY_SIZE(s6e3ha8_supplies),
> -				      s6e3ha8_supplies,
> -				      &priv->supplies);
> +	priv->desc = desc;
> +
> +	ret = devm_regulator_bulk_get_const(dev, desc->num_supplies,
> +					    desc->supplies, &priv->supplies);
>   	if (ret < 0) {
>   		dev_err(dev, "failed to get regulators: %d\n", ret);
>   		return ret;
>   	}
>   
>   	priv->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
>   	if (IS_ERR(priv->reset_gpio))
>   		return dev_err_probe(dev, PTR_ERR(priv->reset_gpio),
>   				     "Failed to get reset-gpios\n");
>   
>   	priv->dsi = dsi;
>   	mipi_dsi_set_drvdata(dsi, priv);
>   
>   	dsi->lanes = 4;
>   	dsi->format = MIPI_DSI_FMT_RGB888;
> -	dsi->mode_flags = MIPI_DSI_CLOCK_NON_CONTINUOUS |
> -		MIPI_DSI_MODE_VIDEO_NO_HFP | MIPI_DSI_MODE_VIDEO_NO_HBP |
> -		MIPI_DSI_MODE_VIDEO_NO_HSA | MIPI_DSI_MODE_NO_EOT_PACKET;
> +	dsi->mode_flags = priv->desc->mode_flags;
>   
>   	priv->panel.prepare_prev_first = true;
>   
>   	ret = devm_drm_panel_add(dev, &priv->panel);
>   	if (ret)
>   		return ret;
>   
>   	/* This panel only supports DSC; unconditionally enable it */
> @@ -295,27 +319,33 @@ static int s6e3ha8_amb577px01_wqhd_probe(struct mipi_dsi_device *dsi)
>   	if (ret < 0) {
>   		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
>   		return ret;
>   	}
>   
>   	return 0;
>   }
>   
> -static const struct of_device_id s6e3ha8_amb577px01_wqhd_of_match[] = {
> -	{ .compatible = "samsung,s6e3ha8" }, /* deprecated */
> -	{ .compatible = "samsung,s6e3ha8-amb577px01" },
> +static const struct of_device_id s6e3ha8_of_match[] = {
> +	{
> +		/* deprecated */
> +		.compatible = "samsung,s6e3ha8",
> +		.data = &s6e3ha8_amb577px01_wqhd_desc,
> +	}, {
> +		.compatible = "samsung,s6e3ha8-amb577px01",
> +		.data = &s6e3ha8_amb577px01_wqhd_desc,
> +	},
>   	{ /* sentinel */ }
>   };
> -MODULE_DEVICE_TABLE(of, s6e3ha8_amb577px01_wqhd_of_match);
> +MODULE_DEVICE_TABLE(of, s6e3ha8_of_match);
>   
> -static struct mipi_dsi_driver s6e3ha8_amb577px01_wqhd_driver = {
> -	.probe = s6e3ha8_amb577px01_wqhd_probe,
> +static struct mipi_dsi_driver s6e3ha8_driver = {
> +	.probe = s6e3ha8_probe,
>   	.driver = {
>   		.name = "panel-s6e3ha8",
> -		.of_match_table = s6e3ha8_amb577px01_wqhd_of_match,
> +		.of_match_table = s6e3ha8_of_match,
>   	},
>   };
> -module_mipi_dsi_driver(s6e3ha8_amb577px01_wqhd_driver);
> +module_mipi_dsi_driver(s6e3ha8_driver);
>   
>   MODULE_AUTHOR("Dzmitry Sankouski <dsankouski@gmail.com>");
>   MODULE_DESCRIPTION("DRM driver for S6E3HA8 panel");
>   MODULE_LICENSE("GPL");
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
