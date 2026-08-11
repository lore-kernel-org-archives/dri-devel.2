Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D58C5AC67
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 07:21:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E162210E2CB;
	Tue, 11 Aug 2026 07:21:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TsdW0Iy3";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 414B110EAA8
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 07:21:19 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-47fd66a094eso153934f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 00:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786432878; x=1787037678; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ePOfulUBVBDfXt5o5ewYatlqaR+8+NY1Odh9u68sfA0=;
 b=TsdW0Iy3JbENpOFoQeSakN6jNfbkZYjW+Q32y+xyWhRo8WodaXIY6YvOq1+2IFcY1t
 +SgaHhYhcECs/grsWqaZOizz2Ch6ni3ngVmygtZEfk91Lpn6vlU++Fp31q+O7NgSlQmr
 FwKWZ2psQYiZBkEerpzdUQZgc7stT4leSny/j+N/zkN5dj+1BZ+Km+LFZpJtbBAbJLzn
 5jYXRCceF366aXwjRxVYAstzW3H8/lc8odqE8ysNma5U6vTqLeMk29da2iZhPBRtomeD
 5+qN98CY610oFOkjCY2AgekMO2V9o2wTvndtlLYy4AVWEMr8iZoiK30wRMbFHdp/YPEM
 ChSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786432878; x=1787037678;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ePOfulUBVBDfXt5o5ewYatlqaR+8+NY1Odh9u68sfA0=;
 b=TNyUpZ1tAUlnE9X0JQr3LQiexTeuuyrvGL5I3EZmP56kpHyojV+umEgMVkGMHx+D5Z
 GGUIL7FKgpdA6gVN8wPmaUmhufAhkIedRVubacb08fNZVyF5Ju0SWcdpdmveShENmSzG
 HqIbKRTnf5bSSM44tGEvxJvReJ2h4fg8MDkvzNVSCkAj4L+P/dwgq3TWHRpbv6v+3qWx
 P3EPJZRNdysgQ0QKPIKi8vK6yL5VBNQErekBECnUNc1yWiD6K4fgmH1gSFbrvDxMkiFf
 yXM2eC8x8V/AsjPqz9F3ZqdumgNJbzrvQZuOK7PFdL6KBqId44/wmSJOurM200DGiXgJ
 3P1g==
X-Gm-Message-State: AOJu0YzcflXawBILfANMLkscm3MZa2jLEQ1tjmsFDUlqgDD9LTPEIUTD
 4MVMWG7ZxGlH6zq48NQdyvfGgszTwDxRjbyCuxhtwoPXvanM30LMFkfaUdvwbSW1jOQ=
X-Gm-Gg: AR+sD11w7Efn7neVLUcbhCbSVP0BO1GYLLYROZI1HUv/47PSFTHsc6/SxfTTy//0ckX
 su4U96LjaQR45jKRd0ZOQN6cxW46sTCCKA3r11ZIpnE7e8jxhgdEgsmHE67p3Mb/fwxK+JxeZ1z
 C9IANhiuflNk6FRxLXxbdkaX4hDv8IH9sSpotAGJ+Memdi9/LtwHEWw+3sJEdid+yaiD9VRCWB3
 xrTquf08s6UQVRCpYZpMTtb1AH4/X/ZQ+VtdRo9KZZqKnMhxSsPmnzE5z3flLmZvv8nFbe3svvt
 TWRjDNyu1gNHZVOQkw61c/RTgBIINmdGnZ11lc7bWAtZOsbFDiL74g6zHMQwcdHqRtijX+9UF+l
 mVgTbj19raQPiq6xLwFip6DsQ80QmAMb75f/v6EZCdH8A4BSbUujw3+ZbFAUcuAxaKjOy4/YqZU
 VNvr89GHswiJUWvbSX+nhjS+3Aozl5H+CEDwu2wZK+HuP2MkurTP8itYu9M00byoVw0lVBnV3FT
 geZrUSaG3Uc8KK7aWoz1kyOy6nxydAwMD9VxjSCAkdyIp6sNlnbCj0=
X-Received: by 2002:a05:6000:4702:b0:480:6af8:305f with SMTP id
 ffacd0b85a97d-4814adcac42mr2003606f8f.20.1786432877509; 
 Tue, 11 Aug 2026 00:21:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:370e:5b2f:7205:786f?
 ([2a01:e0a:106d:1080:370e:5b2f:7205:786f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4814a5ac70dsm2644183f8f.5.2026.08.11.00.21.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Aug 2026 00:21:17 -0700 (PDT)
Message-ID: <a4921a3f-48f3-4cd9-8205-a29a97ea2722@linaro.org>
Date: Tue, 11 Aug 2026 09:21:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2] drm/panel: samsung-s6d16d0: Use mipi_dsi_*_multi();
 fix minor bugs
To: Akash Sukhavasi <akash.sukhavasi@gmail.com>,
 Doug Anderson <dianders@chromium.org>, Linus Walleij <linusw@kernel.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260810-mipi-dsi-s6d16d0-multi-v2-1-8fcdfbf9bbd2@gmail.com>
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
In-Reply-To: <20260810-mipi-dsi-s6d16d0-multi-v2-1-8fcdfbf9bbd2@gmail.com>
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

On 8/11/26 01:45, Akash Sukhavasi wrote:
> The mipi_dsi_dcs_*() functions used by this driver are deprecated
> in favour of their _multi() counterparts, as noted in
> Documentation/gpu/todo.rst. The _multi() variants record the
> first error in a context structure and skip subsequent calls once
> an error is set, removing the need to check the return value
> after each command. They also log failures internally, making the
> per-call dev_err() calls redundant.
> 
> Convert prepare(), enable(), disable(), and unprepare() to use
> mipi_dsi_dcs_*_multi().
> 
> unprepare() previously returned an error if
> mipi_dsi_dcs_enter_sleep_mode() failed, skipping RESET assertion
> and regulator_disable(). Because drm_panel_unprepare() does not
> clear panel->prepared when the callback returns an error,
> drm_panel_prepare() would then return early on the next call,
> leaving the panel powered and unable to be re-initialised. The
> converted code always asserts RESET, disables the regulator, and
> returns 0.
> 
> Also fix a typo in a comment ("Enabe" -> "Enable").
> 
> Signed-off-by: Akash Sukhavasi <akash.sukhavasi@gmail.com>
> ---
> Compile tested only, no hardware available. checkpatch and a W=1
> build are clean.
> ---
> Changes in v2:
> - Keep intermediate dsi variable for readability, per Neil's review.
> - Add comment explaining why accum_err is not checked in unprepare().
> - Simplify prepare() to a single return path.
> - Link to v1: https://lore.kernel.org/r/20260807-mipi-dsi-s6d16d0-multi-v1-1-c6179f6f3c98@gmail.com
> ---
>   drivers/gpu/drm/panel/panel-samsung-s6d16d0.c | 55 +++++++++------------------
>   1 file changed, 17 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c b/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
> index 54a65abf7e89..e734fffa45a4 100644
> --- a/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
> +++ b/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
> @@ -48,14 +48,10 @@ static int s6d16d0_unprepare(struct drm_panel *panel)
>   {
>   	struct s6d16d0 *s6 = panel_to_s6d16d0(panel);
>   	struct mipi_dsi_device *dsi = to_mipi_dsi_device(s6->dev);
> -	int ret;
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
>   
> -	/* Enter sleep mode */
> -	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
> -	if (ret) {
> -		dev_err(s6->dev, "failed to enter sleep mode (%d)\n", ret);
> -		return ret;
> -	}
> +	/* Enter sleep mode; error does not prevent power-off */
> +	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
>   
>   	/* Assert RESET */
>   	gpiod_set_value_cansleep(s6->reset_gpio, 1);
> @@ -68,6 +64,7 @@ static int s6d16d0_prepare(struct drm_panel *panel)
>   {
>   	struct s6d16d0 *s6 = panel_to_s6d16d0(panel);
>   	struct mipi_dsi_device *dsi = to_mipi_dsi_device(s6->dev);
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
>   	int ret;
>   
>   	ret = regulator_enable(s6->supply);
> @@ -83,57 +80,39 @@ static int s6d16d0_prepare(struct drm_panel *panel)
>   	gpiod_set_value_cansleep(s6->reset_gpio, 0);
>   	msleep(120);
>   
> -	/* Enabe tearing mode: send TE (tearing effect) at VBLANK */
> -	ret = mipi_dsi_dcs_set_tear_on(dsi,
> +	/* Enable tearing mode: send TE (tearing effect) at VBLANK */
> +	mipi_dsi_dcs_set_tear_on_multi(&dsi_ctx,
>   				       MIPI_DSI_DCS_TEAR_MODE_VBLANK);
> -	if (ret) {
> -		dev_err(s6->dev, "failed to enable vblank TE (%d)\n", ret);
> -		goto err_power_off;
> -	}
>   	/* Exit sleep mode and power on */
> -	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
> -	if (ret) {
> -		dev_err(s6->dev, "failed to exit sleep mode (%d)\n", ret);
> -		goto err_power_off;
> +	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> +	if (dsi_ctx.accum_err) {
> +		gpiod_set_value_cansleep(s6->reset_gpio, 1);
> +		regulator_disable(s6->supply);
>   	}
>   
> -	return 0;
> -
> -err_power_off:
> -	gpiod_set_value_cansleep(s6->reset_gpio, 1);
> -	regulator_disable(s6->supply);
> -
> -	return ret;
> +	return dsi_ctx.accum_err;
>   }
>   
>   static int s6d16d0_enable(struct drm_panel *panel)
>   {
>   	struct s6d16d0 *s6 = panel_to_s6d16d0(panel);
>   	struct mipi_dsi_device *dsi = to_mipi_dsi_device(s6->dev);
> -	int ret;
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
>   
> -	ret = mipi_dsi_dcs_set_display_on(dsi);
> -	if (ret) {
> -		dev_err(s6->dev, "failed to turn display on (%d)\n", ret);
> -		return ret;
> -	}
> +	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
>   
> -	return 0;
> +	return dsi_ctx.accum_err;
>   }
>   
>   static int s6d16d0_disable(struct drm_panel *panel)
>   {
>   	struct s6d16d0 *s6 = panel_to_s6d16d0(panel);
>   	struct mipi_dsi_device *dsi = to_mipi_dsi_device(s6->dev);
> -	int ret;
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
>   
> -	ret = mipi_dsi_dcs_set_display_off(dsi);
> -	if (ret) {
> -		dev_err(s6->dev, "failed to turn display off (%d)\n", ret);
> -		return ret;
> -	}
> +	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
>   
> -	return 0;
> +	return dsi_ctx.accum_err;
>   }
>   
>   static int s6d16d0_get_modes(struct drm_panel *panel,
> 
> ---
> base-commit: dc2f9f7fed1a8ea5290f9f60c6310d497e85e666
> change-id: 20260807-mipi-dsi-s6d16d0-multi-167e236e9666
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
