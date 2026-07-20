Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DAD6C44520
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 12:38:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2F8510E8F8;
	Mon, 20 Jul 2026 12:38:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="T5uX/mmS";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93EDD10E8F9
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 12:38:55 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4956242332dso4960085e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 05:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784551134; x=1785155934; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E6KBtb/Bb0z4jnxcgcZfuIhxmNTLNaOmSJg4VYdhfw4=;
 b=T5uX/mmSjfQIG7FAEkvrGD/sEd3995oLvN+IABXYV0MnsFeK3NnesRa5PcQqD09ZAJ
 agapUHSU1fvde7p2G3uCwcu8s9K/u7N/IWAJ9h+WPEBXqsyAcIyulkLjMsxu9mMcR9Om
 T9eyi1vgD2jXVuU5mU26ndZv2i9x7GVdfK4VR97xwAXsVuW64907B/tLK/YlB97HvKah
 tiEWThWR2AxNhdzA1LAcwElB0YKowG63NGReE2CLeFfUkfVp7S8/RdUNjofnbWIwjX4k
 3WN/IlumumPyhnqgzngYXfnlyjx2M/LHI2MUv0V3Aikil6eOzi5GIcIwVy03FCwo5A1H
 mtQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784551134; x=1785155934;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=E6KBtb/Bb0z4jnxcgcZfuIhxmNTLNaOmSJg4VYdhfw4=;
 b=obvA5mfesis5cUufu98aQRvw3I/sGYoVZcW+n6ywmCWCx+TWg4dlqgg5kg+yAmpT2Z
 9c0P7mDbbjasnf/9i4UKYjyEN1Z0xkufgSblgLBAjZ8IrKxUA9AK3fTecvfFhj3i9rE4
 uiNdmw/sYm83LrTroiGNgaSSPUlbEBP999n/ZOPEPdNG5OLv9MFqPAkMD0WC67LLWQ3H
 N/e+Z9reDHqH1sshQ/g5PSEKlatAlmcncwaKzisXD4DobwnRiPQZax+u5OyH1fACDTQi
 1+aTs/mwRef/igXnnDeb5dl/465NuQr6mOS9VrKpP/EWz9S+Cno168onEtVo3gjtLvTj
 PLqQ==
X-Gm-Message-State: AOJu0YznxG3+8WZEAMLXlxh9tYjSdMjMWSZyMTrrDSd/q3wxX+mourQp
 KD4oRBQWbXzYBT2cWqEbZzcRwxq1YTFwOOaRTNKMxzwOao9+Iy8CmAqamY/QW/CaLko6SdXyh1I
 LyRIWpLM=
X-Gm-Gg: AfdE7cnAls4Db18N8VqrXpLJx2S7RGevoAlRh2dAidAU44TCNxPD3SfnecmfyVwPcuL
 /GSueKBqm/0m7F6XvwZ4XO3seJJCO+uBos8wGXD+he5ao9HYWeDY7ULNdha4gxA0NTPzH0dDgCE
 xil3GYgQ7ta6TjwZgu7UB5cvGUH35K4VI1NSfsosRjWNkyOzLHp2XpL3aHApPAHwT+OKuxbevh+
 kovmrvs04oU54D6U9r2Wa2vUk6KiUeDqWcjGzz86qWZVKLu9DaIBYtv6I8VvXtUbIltI4Si9pm+
 TF8ZhHLqUiMKR2Amy+ygA/SL/89QEEy2RTepNDdrOTXvlZ2BpsY7jT3xLr6e2TKkdPfwYFXct2t
 MmRqbJq5hqbYS3sLJsaaBlygSPLkPLc1smG8Yj7ZRvkJTT6LP2Fk99w+wD7Y2Fnq0dKlhrfhiX9
 llEIWlCyRpwMqv/3DiyuDddS577e3TqeNlwIk6b0wceX3lEisTrk1EUbtI2A==
X-Received: by 2002:a05:600c:5297:b0:495:6485:226b with SMTP id
 5b1f17b1804b1-49564852284mr880375e9.22.1784551133799; 
 Mon, 20 Jul 2026 05:38:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:544a:2852:f257:ebc5?
 ([2a01:e0a:106d:1080:544a:2852:f257:ebc5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4955dfa4a97sm109669725e9.4.2026.07.20.05.38.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 05:38:53 -0700 (PDT)
Message-ID: <a74ca56f-9961-4018-93b7-4058f08b1090@linaro.org>
Date: Mon, 20 Jul 2026 14:38:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 1/3] drm/panel: ilitek-ili9805: Use _multi variants
To: Michail Tatas <michail.tatas@gmail.com>, michael@amarulasolutions.com,
 jesszhan0024@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 dianders@chromium.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260719190358.438699-1-michail.tatas@gmail.com>
 <20260719190358.438699-2-michail.tatas@gmail.com>
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
In-Reply-To: <20260719190358.438699-2-michail.tatas@gmail.com>
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

On 7/19/26 21:03, Michail Tatas wrote:
> Convert functions mipi_dsi_* to mipi_dsi_*_multi as per the
> gpu/todo file.
> The multi variant of these functions include improved error
> handling.
> 
> Signed-off-by: Michail Tatas <michail.tatas@gmail.com>
> ---
>   drivers/gpu/drm/panel/panel-ilitek-ili9805.c | 51 +++++---------------
>   1 file changed, 13 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9805.c b/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
> index e6c483851f1f..7e9587afebbe 100644
> --- a/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
> @@ -159,36 +159,23 @@ static int ili9805_power_off(struct ili9805 *ctx)
>   
>   static int ili9805_activate(struct ili9805 *ctx)
>   {
> -	struct mipi_dsi_device *dsi = ctx->dsi;
> -	struct device *dev = &dsi->dev;
> -	int i, ret;
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
> +	int i;
>   
>   	for (i = 0; i < ctx->desc->init_length; i++) {
>   		const struct ili9805_instr *instr = &ctx->desc->init[i];
>   
> -		ret = mipi_dsi_dcs_write_buffer(ctx->dsi, instr->data, instr->len);
> -		if (ret < 0)
> -			return ret;
> +		mipi_dsi_dcs_write_buffer_multi(&dsi_ctx, instr->data, instr->len);
>   
>   		if (instr->delay > 0)
> -			msleep(instr->delay);
> -	}
> -
> -	ret = mipi_dsi_dcs_exit_sleep_mode(ctx->dsi);
> -	if (ret) {
> -		dev_err(dev, "Failed to exit sleep mode (%d)\n", ret);
> -		return ret;
> +			mipi_dsi_msleep(&dsi_ctx, instr->delay);
>   	}
>   
> -	usleep_range(5000, 6000);
> +	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> +	mipi_dsi_usleep_range(&dsi_ctx, 5000, 6000);
> +	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
>   
> -	ret = mipi_dsi_dcs_set_display_on(ctx->dsi);
> -	if (ret) {
> -		dev_err(dev, "Failed to set display ON (%d)\n", ret);
> -		return ret;
> -	}
> -
> -	return 0;
> +	return dsi_ctx.accum_err;
>   }
>   
>   static int ili9805_prepare(struct drm_panel *panel)
> @@ -211,25 +198,13 @@ static int ili9805_prepare(struct drm_panel *panel)
>   
>   static int ili9805_deactivate(struct ili9805 *ctx)
>   {
> -	struct mipi_dsi_device *dsi = ctx->dsi;
> -	struct device *dev = &dsi->dev;
> -	int ret;
> -
> -	ret = mipi_dsi_dcs_set_display_off(ctx->dsi);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed to set display OFF (%d)\n", ret);
> -		return ret;
> -	}
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
>   
> -	usleep_range(5000, 10000);
> -
> -	ret = mipi_dsi_dcs_enter_sleep_mode(ctx->dsi);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed to enter sleep mode (%d)\n", ret);
> -		return ret;
> -	}
> +	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
> +	mipi_dsi_usleep_range(&dsi_ctx, 5000, 10000);
> +	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
>   
> -	return 0;
> +	return dsi_ctx.accum_err;
>   }
>   
>   static int ili9805_unprepare(struct drm_panel *panel)

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
