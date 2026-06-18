Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8CFECD98F2
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:23:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A1B210EDC6;
	Thu, 18 Jun 2026 12:23:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tYMZcovP";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAE5410EDC6
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 12:23:43 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-490bc6a7958so15386015e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 05:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781785422; x=1782390222; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=D5FEcOXjp/hefaowFGFjzfPrPE1kEo+L375WErKUiNc=;
 b=tYMZcovPElZX/UyiZT7+J8YhLuIBX+QHlh9NHsHTr8+wjthm0BduaF50LTYMic6e8T
 DXRr5yNllmg/jiBww+VRyHgRJCGGPoV1IQB/V1dO5MivXpmkIf+OqBkvZ3un4bECVS0M
 1eVPaJW5CKVZ2+AQAvB8Y1Ie8p11ggWcKvvdMxzfmT0spzAGIAMXteHwVLfsJurL39j0
 tk0ZemMMVpRUhq29LyMjLvPRlDR3aARtjMQRGIBaJnBoneNCJE1iwnsGaMZvy5N7qwMp
 4ZFWgDhOafDhW9+O/TcwsI0UHAzWh90F1/vM0cbMc9D8UE51a3FD/UOs3UBsBZOe0qaA
 xJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781785422; x=1782390222;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D5FEcOXjp/hefaowFGFjzfPrPE1kEo+L375WErKUiNc=;
 b=W3Ult/HjBymo7gGRhEmoeZ6iGaFGVoqgtr9W25yi1vqnUZB1PphDrChFMDcYxMXvuD
 qE8WzsVD7bELKzDPW7q47hGn1H4F+24jZcy+eQnaQICojhyy7aOEnjSZQfiHunjD1TJl
 +KHvT57ZPkk/GZnKd62iNMtGF9taBuCd5V89UlDaDI/NpABZ1smvSMy5Aev7HM9ukwUF
 QLFqIIaV3Ss8CBhzNQGhal740UAmoBTL3BoA9UQ0xlIg4zvYcJUQTA6O0p/eMNIXIsaa
 wzVBm20DSKMEoX/5jA7Y+VwECqnv3Prfk5ezur21yPwSuanL0KFO4EdTko6oEqgjuAk8
 iPsQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8YIN7/8vExVvK1viFI2/Rkffd+T+lckb6Lcu2JX63mEE+hlV0Ztq8K1GSnObS6kosrWqNelSbm6ko=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwzFTrI9g6Jj+F4/ntjCwV5aqL2bJQIpjeeVPfBuP+bw7pRrFTN
 Z/fm4mDBrqaRhMztpN7iHPq6glUkXIkjKZkgAj34uBJYP4PZcNaXaUMnQI2wopFLFS0=
X-Gm-Gg: AfdE7cliIwlKa8u/WKAxa701Wee2HChL7UKsxdsaxEujJcHnVEKOjH4JUXrilMg7z3B
 Ch7yMczHCaaCXmr555SERR3T+NsIrtHXnYVmzicxbpWwA9Q49AK7ZkWJliivlXdiGpnGVQZqRCR
 u1pVFpxYBQObtvKIzWxC+NFau4xa395IdXHmey4gvXgl7US+hZOvTpORo4wzahvt22NuJTxk32O
 6PKz4Fzq7rnzzWnwKoQmQeDug6ip1iCh/2dpcIprqaE6IIoc4o68tZJgSIRpxYiwttsq+XagOeT
 pIKEjJo89p8ulQkcFHtONAmGEAayjeoL1FqpmrYnvWsMwpxKH/XNe5TpwBHr1G2ET/3S+yQWkjT
 lvyfhFZr2/ymwje4ImEdLpc5pv7vwsfY9hbCqeBFtxkb1WuIUqlLEvmCpwS4HzbebYmaxYobjH4
 mwFsoP5oVe1u/xoIPm/ElnQ16za78/mk+jJRU7c+pMf5b+wok8gDAcXEY/+XTLQMVtvw==
X-Received: by 2002:a7b:c8d3:0:b0:492:1e36:9a90 with SMTP id
 5b1f17b1804b1-492381a2e79mr37585935e9.18.1781785422212; 
 Thu, 18 Jun 2026 05:23:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:6e1b:5a5:b2b5:b2c0?
 ([2a01:e0a:106d:1080:6e1b:5a5:b2b5:b2c0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa96f0esm274863325e9.12.2026.06.18.05.23.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 05:23:41 -0700 (PDT)
Message-ID: <716f71ae-4642-4f22-8a9f-5b1c017d9ac2@linaro.org>
Date: Thu, 18 Jun 2026 14:23:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 3/3] drm/panel: himax-hx83121a: add backlight regulator
 support
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Pengyu Luo <mitltlatltl@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260608162622.403713-1-zhengxingda@iscas.ac.cn>
 <20260608162622.403713-3-zhengxingda@iscas.ac.cn>
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
In-Reply-To: <20260608162622.403713-3-zhengxingda@iscas.ac.cn>
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

On 6/8/26 18:26, Icenowy Zheng wrote:
> The backlight, when managed by the panel controller, could be powered by
> an external regulator, and shutting down the regulator could power off
> the backlight.
> 
> Add support for such a regulator. It's powered off when the backlight is
> 0 (either by setting brightness to 0 or setting bl_power), and powered
> on when the backlight should be operating.
> 
> Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> ---
>   drivers/gpu/drm/panel/panel-himax-hx83121a.c | 26 ++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-himax-hx83121a.c b/drivers/gpu/drm/panel/panel-himax-hx83121a.c
> index 1a7e0125bced8..e31e2fba0a787 100644
> --- a/drivers/gpu/drm/panel/panel-himax-hx83121a.c
> +++ b/drivers/gpu/drm/panel/panel-himax-hx83121a.c
> @@ -34,7 +34,9 @@ struct himax {
>   	struct drm_dsc_config dsc;
>   	struct gpio_desc *reset_gpio;
>   	struct regulator_bulk_data *supplies;
> +	struct regulator *bl_supply;
>   	struct backlight_device *backlight;
> +	bool backlight_enabled;
>   };
>   
>   struct panel_desc {
> @@ -195,7 +197,27 @@ static int himax_bl_update_status(struct backlight_device *bl)
>   {
>   	struct himax *ctx = bl_get_data(bl);
>   	u16 brightness = backlight_get_brightness(bl);
> +	int ret = 0;
> +
> +	if (!brightness) {
> +		if (ctx->backlight_enabled)
> +			ret = regulator_disable(ctx->bl_supply);
> +		if (ret)
> +			return ret;
> +
> +		ctx->backlight_enabled = false;
> +
> +		return 0;
> +	}
> +
>   	/* TODO: brightness to raw map table */
> +	if (!ctx->backlight_enabled)
> +		ret = regulator_enable(ctx->bl_supply);
> +	if (ret)
> +		return ret;
> +
> +	ctx->backlight_enabled = true;
> +
>   	return mipi_dsi_dcs_set_display_brightness_large(to_primary_dsi(ctx),
>   							 brightness);
>   }
> @@ -647,6 +669,10 @@ static int himax_probe(struct mipi_dsi_device *dsi)
>   	ctx->panel.prepare_prev_first = true;
>   
>   	if (desc->has_dcs_backlight) {
> +		ctx->bl_supply = devm_regulator_get_optional(dev, "bl");
> +		if (IS_ERR(ctx->bl_supply))
> +			return dev_err_probe(dev, PTR_ERR(ctx->bl_supply),
> +					     "Failed to get backlight supply\n");
>   		ctx->backlight = himax_create_backlight(ctx);
>   		if (IS_ERR(ctx->backlight))
>   			return dev_err_probe(dev, PTR_ERR(ctx->backlight),

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
