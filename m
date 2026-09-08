Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0692AC79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 12:15:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3245F10EB9E;
	Tue,  8 Sep 2026 12:15:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xwIppdd7";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9AE310EB9E
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 12:15:27 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f6356257so493470f8f.0
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 05:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788869726; x=1789474526; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=opW7KwpTJqDOoH0UYZ6XA/5fYGHhXR/DMT65lptOerM=;
 b=xwIppdd7NRj4hp839xsrACdCziKLfnNq1lgl0gDsFOkybvzei7D2n3tbg85y2FToTj
 Li4mjbCt4vE56vSPiidJY7QX+Rxa7Qkwy37Fy7XE2BZEkLAh1VGqclQo1avtEUN/BYXE
 /d55v6SPR2roJxMIDY2Nflhc8ydzAySTVcvDxOP6eqXhbtwQWO2SgBdy9gmTMLFTml6M
 7PBreL3ETVQMskETx/8hLTmQpeBVvLcnwkDP4SUHcigzUhrbq/6nkvLz3Xn/XGAN63/q
 WYLxnCSPvNUIFIZt6voVHEU3VDEr9Tj07UHXZCL0lLk0H5FFCTw26V5u0tOZJXJxlzgc
 7fJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788869726; x=1789474526;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=opW7KwpTJqDOoH0UYZ6XA/5fYGHhXR/DMT65lptOerM=;
 b=JO4KE655TYPGquH9EDpdyeoE5Mk2zaI/7xLD8U9rQ/ulFmAqlMsEaXbfdJmvzZGAZ8
 PQFUesofhCD3VAG0mkFBwmG4g7H74ddKwMtZ6USdKjh5Nuq7Xwrol68foro6unwNOa4h
 6kOabwFqiWjyoJOsGLJE9rxxmmfH9nvrpdzGFFGSP6A5ZLImDYL2ypz/J9seqTD9QpJC
 O6F5TZslKH7gUPMnAESHMziIMeAS16tio/R7TRu7JGSAotzVTZDY9Po7129NV6RCMZPo
 TkvIpUOQrzBbnztnRr8P7jtWWQc0ETOrFqD58bgbX+fPtlWxCfnD6xM4Z9a5/uf9tQCe
 +o0w==
X-Gm-Message-State: AFuF++kLvQrbmmlN1HBnCls6KTCKGE+3xOfOCxiTIuwdWx6IliVFFBif
 xO2RcZyMw6N0jdfY/R7ZRzU9SiwGSE2hwoaMkfdOVBcVoRB+WJTqL1MYgG+GGFeN8Sc=
X-Gm-Gg: AYBFou3nodUgQslVFLhO8bWSBO7BembaYSN4mgin72rBbVweHZBJb9fG8wAjdpceQ5A
 NXKaQdtp7tx8CIZKN3wCCrTQf+++bJzkVCuwB6hyFHIweh4JwGLGMaWnkJ5UV1Kj6X6e4aUmeaN
 H9IdaIx3cPZody6Gg5yTHih3SxK0uW8yUuqtXB+X4KB7hE7Qgyxh3Vw1IWvEFDe+YNZJnysTk2X
 qHU1echhOQnsEq5YXt2Fi5PlIdVBdy8DWNeHhjywcdnTap/zCd4KEZHBNfrb4FIXfVJ5E7oLfjd
 OQYlCTCoWlW2iTvphwUK6l2NAuCueynfXcc/Kcfluk+ikvBeJGwbGKX5n85UgZvoup9M0v1agYN
 /2Va/HjeH2Rmy0j7htaxP/yCzYTzwJN+7kjNlWkxjSmWcpCgDqxrCDTLkZ/eFzGGBDshNdOFlB0
 TT8T0Rlk3w96gDe5GuZcYjQZ6zvVp0Uw1ei6g1PJE5liy1UZoaDLanZT+DOVnj7ZD/BzYbs40AY
 htgX4Khsg2sASBPnP5/siq16UCoMRwLa7BlK5+pO6Q=
X-Received: by 2002:a05:600c:a01:b0:49d:1916:2133 with SMTP id
 5b1f17b1804b1-49d1916215amr42841305e9.8.1788869725867; 
 Tue, 08 Sep 2026 05:15:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:ea45:883b:8b89:b4e5?
 ([2a01:e0a:106d:1080:ea45:883b:8b89:b4e5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf5135353sm342891865e9.2.2026.09.08.05.15.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2026 05:15:25 -0700 (PDT)
Message-ID: <7d1d7726-aff1-40cf-a958-6e825a1b50eb@linaro.org>
Date: Tue, 8 Sep 2026 14:15:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 3/3] drm/panel: ebbg-ft8719: Split initialization into
 enable/disable fn
To: david@ixit.cz, Joel Selvaraj <jo@jsfamily.in>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sam Ravnborg <sam@ravnborg.org>, Marco Mattiolo <marco.mattiolo@hotmail.it>,
 Linus Walleij <linusw@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org
References: <20260906-ebbg-ft8719-fixups-v1-0-4e846510cad1@ixit.cz>
 <20260906-ebbg-ft8719-fixups-v1-3-4e846510cad1@ixit.cz>
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
In-Reply-To: <20260906-ebbg-ft8719-fixups-v1-3-4e846510cad1@ixit.cz>
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

On 9/6/26 15:19, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> Efficiently this already happens with prepare/unprepare calls.
> Remove unnecessary login and just use enable/disable functions.

I would replace with:

Move the MIPI commands into enable/disable callbacks since they
are called between prepare/unprepare callbacks.

Or similar.

> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>   drivers/gpu/drm/panel/panel-ebbg-ft8719.c | 17 +++++++----------
>   1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-ebbg-ft8719.c b/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
> index 14982263a94f1..9965f46f1a316 100644
> --- a/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
> +++ b/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
> @@ -49,40 +49,42 @@ static void ebbg_ft8719_reset(struct ebbg_ft8719 *ctx)
>   	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
>   	usleep_range(4000, 5000);
>   	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
>   	usleep_range(1000, 2000);
>   	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
>   	usleep_range(15000, 16000);
>   }
>   
> -static int ebbg_ft8719_on(struct ebbg_ft8719 *ctx)
> +static int ebbg_ft8719_enable(struct drm_panel *panel)
>   {
> +	struct ebbg_ft8719 *ctx = to_ebbg_ft8719(panel);
>   	struct mipi_dsi_device *dsi = ctx->dsi;
>   	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
>   
>   	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
>   
>   	mipi_dsi_dcs_set_display_brightness_multi(&dsi_ctx, 0x00ff);
>   	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x24);
>   	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_WRITE_POWER_SAVE, 0x00);
>   
>   	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
>   	mipi_dsi_msleep(&dsi_ctx, 90);
>   	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
>   
>   	return dsi_ctx.accum_err;
>   }
>   
> -static int ebbg_ft8719_off(struct ebbg_ft8719 *ctx)
> +static int ebbg_ft8719_disable(struct drm_panel *panel)
>   {
> +	struct ebbg_ft8719 *ctx = to_ebbg_ft8719(panel);
>   	struct mipi_dsi_device *dsi = ctx->dsi;
>   	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
>   
> -	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
> +	ctx->dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
>   
>   	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
>   	mipi_dsi_usleep_range(&dsi_ctx, 10000, 11000);
>   	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
>   	mipi_dsi_msleep(&dsi_ctx, 90);
>   
>   	return dsi_ctx.accum_err;

Before the ebbg_ft8719_off() return error was ignored, perhaps you still want to ignore the disable return error.

Neil

>   }
> @@ -93,30 +95,23 @@ static int ebbg_ft8719_prepare(struct drm_panel *panel)
>   	int ret;
>   
>   	ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
>   	if (ret < 0)
>   		return ret;
>   
>   	ebbg_ft8719_reset(ctx);
>   
> -	ret = ebbg_ft8719_on(ctx);
> -	if (ret < 0) {
> -		gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> -		return ret;
> -	}
> -
>   	return 0;
>   }
>   
>   static int ebbg_ft8719_unprepare(struct drm_panel *panel)
>   {
>   	struct ebbg_ft8719 *ctx = to_ebbg_ft8719(panel);
>   
> -	ebbg_ft8719_off(ctx);
>   	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
>   	regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
>   
>   	return 0;
>   }
>   
>   static const struct drm_display_mode ebbg_ft8719_mode = {
>   	.clock = (1080 + 28 + 4 + 16) * (2246 + 120 + 4 + 12) * 60 / 1000,
> @@ -148,16 +143,18 @@ static int ebbg_ft8719_get_modes(struct drm_panel *panel,
>   	connector->display_info.height_mm = mode->height_mm;
>   	drm_mode_probed_add(connector, mode);
>   
>   	return 1;
>   }
>   
>   static const struct drm_panel_funcs ebbg_ft8719_panel_funcs = {
>   	.prepare = ebbg_ft8719_prepare,
> +	.enable = ebbg_ft8719_enable,
> +	.disable = ebbg_ft8719_disable,
>   	.unprepare = ebbg_ft8719_unprepare,
>   	.get_modes = ebbg_ft8719_get_modes,
>   };
>   
>   static int ebbg_ft8719_probe(struct mipi_dsi_device *dsi)
>   {
>   	struct device *dev = &dsi->dev;
>   	struct ebbg_ft8719 *ctx;
> 

