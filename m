Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F28C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 12:40:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8768110E8FA;
	Mon, 20 Jul 2026 12:40:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XdA/9HMC";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9A1F10E8FA
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 12:40:14 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-476a130c138so6564721f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 05:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784551213; x=1785156013; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rFXYaVGgGEb7joixlU0w7k5auPqDLVpSrfyhDN1sfkc=;
 b=XdA/9HMC6Y6ud9dKQ/nWltIuCqSjle3Ziuk0FC+tDE9pMJuk+TgJ+KhgM2Kn1k8wZs
 5rIbWNAVcyVXr9YmaEFTgLnuF1dB+2D3PZQcCRUYQaiNhTixxrGrnT4BQMpSCkGaSinY
 ZEAjW6I+3ALnJgb+KsXe3p8otkrqjlxEU9ohFBB+E9p5u78FtsuG3CixAGM4MvtNFtj3
 LKFFmDzh5IW+hwjZ5GNZkgMR053cq64Gi4odG20Up3m7ATVo/ABPYKusAgeW3ssE7dUA
 +S21d4YF0BOZNNSTTA6wNWuXPpXiHMDlHeziIDCEzvVahzhjzmvf8POCNNtl8jpPkg1l
 HV8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784551213; x=1785156013;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rFXYaVGgGEb7joixlU0w7k5auPqDLVpSrfyhDN1sfkc=;
 b=Z2Zt29/QAZy3rh8/GZYVi+dEWbzfSZ4/XmOrlWEkFMiruANEY2QcUmSuJdmrNOohEj
 y7cJYlWiiV5TVuKFheQ9Phi4c3Q+GK1jXjraM43EpOqiQMdTHJiIcl+sIZOKWk9rhSzM
 NVxXEr/ekkO6FF5leN6RCMPV0K3cKckHMp4eIat9SE6AGkH5WC++zd68sPMSWsDACIbe
 zU3JHrhiaimA4eiLy3QxcQjLfcHVSiWeFpKwz84G3BUqlJ+rAQytl8x5DuQ8TZIuJ1um
 Y01TmwICfZz0WiiM2krGeohRiKLAWZ4ayExZFeaDwyP9/CCayAo+i8OFhtLLJtSA/bZW
 I9LQ==
X-Gm-Message-State: AOJu0YxFso+iXYDr+IxqJJIRSPYZCnMsJJHoUvgIHfiPQKk4WV3hYcpX
 F4+M9FpUny3afwB0VkZVuv0GgcTNNiQNWZHqY4Ww+e7q6n4MjS7vlMdq+Owt1hB4xno=
X-Gm-Gg: AR+sD13mU5qwU3pYS1ECrnQBhdbA7N0x6ZZiV3lwfq1PJSerSKkol6Fm/wyCFfkaK7a
 ugKLUIM7081efmiYE2noGyxxFolm/PoQCuKHAr4+M07Xjc15SDDbGKPOuyhSEW3byHsZP0Teg2f
 mk6sQeQ1dFLZaEe1k6Ir+73n4MWFRFChruW2YlISAbNin4a5szNG0J07wOm87m3YA6UPx9HQPFe
 yA1tCFvCTS/5oEagovkOj7Q2a2xI3YNno3rCokhpnU8IgFRyKt9Le+/+ZFL5dgjSavIdRr/Vybg
 8cQvYtoXjx+lbPnom2BGwcpCbtUtmbO3XR83fUFCVDy19QbU8WTD5iYSLcO2f4eFJNcp8lZMDLY
 taae9AmjeGqGop60+7xSTdpilY3QOUpTBGJv90SKPnLlM1IDkGrRcTxxZNvwcdMdHb1u5ecbfnf
 I58eXkfaLUp58ZCw6iEp0bInJnk4OkeKx6sd8By6VrohK07C0+ucwmxUONQlu+vKlSo2lk
X-Received: by 2002:a05:6000:310d:b0:47f:7736:2a0c with SMTP id
 ffacd0b85a97d-47f77362b3bmr5262395f8f.14.1784551212769; 
 Mon, 20 Jul 2026 05:40:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:544a:2852:f257:ebc5?
 ([2a01:e0a:106d:1080:544a:2852:f257:ebc5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e51986sm33815224f8f.11.2026.07.20.05.40.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 05:40:12 -0700 (PDT)
Message-ID: <f8ba765c-bd64-4a2a-808f-ce7b2721ed89@linaro.org>
Date: Mon, 20 Jul 2026 14:40:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 3/3] drm/panel: ilitek-ili9805: make cleanup funcs void
To: Michail Tatas <michail.tatas@gmail.com>, michael@amarulasolutions.com,
 jesszhan0024@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 dianders@chromium.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260719190358.438699-1-michail.tatas@gmail.com>
 <20260719190358.438699-4-michail.tatas@gmail.com>
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
In-Reply-To: <20260719190358.438699-4-michail.tatas@gmail.com>
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
> Make cleanup functions return void since no one is checking
> their return values
> 
> Signed-off-by: Michail Tatas <michail.tatas@gmail.com>
> ---
>   drivers/gpu/drm/panel/panel-ilitek-ili9805.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9805.c b/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
> index a70b9512746a..64cfaf981e9f 100644
> --- a/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
> @@ -148,13 +148,11 @@ static int ili9805_power_on(struct ili9805 *ctx)
>   	return 0;
>   }
>   
> -static int ili9805_power_off(struct ili9805 *ctx)
> +static void ili9805_power_off(struct ili9805 *ctx)
>   {
>   	gpiod_set_value(ctx->reset_gpio, 0);
>   	regulator_disable(ctx->dvdd);
>   	regulator_disable(ctx->avdd);
> -
> -	return 0;
>   }
>   
>   static int ili9805_activate(struct ili9805 *ctx)
> @@ -188,15 +186,13 @@ static int ili9805_prepare(struct drm_panel *panel)
>   	return 0;
>   }
>   
> -static int ili9805_deactivate(struct ili9805 *ctx)
> +static void ili9805_deactivate(struct ili9805 *ctx)
>   {
>   	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
>   
>   	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
>   	mipi_dsi_usleep_range(&dsi_ctx, 5000, 10000);
>   	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
> -
> -	return dsi_ctx.accum_err;
>   }
>   
>   static int ili9805_unprepare(struct drm_panel *panel)

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
