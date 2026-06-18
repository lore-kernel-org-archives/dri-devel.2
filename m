Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC19CD98ED
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:23:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0E8A10ED82;
	Thu, 18 Jun 2026 12:23:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BM6gQ3Pf";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 030CC10ED82
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 12:23:27 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so5848405e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 05:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781785406; x=1782390206; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=LAtGu/fA9uXxnFye1zu9fsid/L2b+MdGaREMuZCR+iU=;
 b=BM6gQ3PfPyPju2f3J35iGnGZhqv4VRvzzUMnE0j5AZEEPvcaLYtWGrTLgCSKOackiB
 /EyiaNNPeojgxv7W9fqkIoUXeBD8IE3FH6UDUbBjJ2zxdBuhnwDYvGndnEcmOp0z8Wt8
 TlfFeo4g3uu/gEevolg1ojBC9QvAodlwJ1g0P4EIzCI2JCD/kUSizueiKDsLQe6LMOIE
 5Qt1ccjm3jfKDZK9YqRegiUSpwaJIXwdQP9qpz2pQjNhPI6Mm8lxhTmexNec8LQDjyGL
 J2AcJWT1zzTFXkoNqeb5rxlQHUdxi2Xw0SH4jmfE50ddkbAbSiC/DmpuTgMfczA0BV/b
 1Pvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781785406; x=1782390206;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LAtGu/fA9uXxnFye1zu9fsid/L2b+MdGaREMuZCR+iU=;
 b=cyfBeaV1S8MHSQm2w+sNXDVuBhdCPncVbhQ6RtIn+tB4UKuFcsL4rmkwHLC/MAp4ES
 M4TfRMX/JyYgFG4wUj7koSEr9ViIJZ3y6FbRb6lyWQFsnhqBM7X5ep07LnLp+g99V8wn
 IC/kwJsGHuz4W8/evL+zV36RU3V8pz5iat6mMH6gxo3PU2WQ7/lx9dSmnS6B1x3Nx2+b
 54saymO7iG+g9nLPz8liR1n7zSX6V6WjnpuQIWJJjbhCjDj3KD2DbjIbgdC0ktNC2odO
 0TJk0dKRYSn7F3klih830NFAmBWqdL/VTo5YjljPsnO1admvLePBqKqhOG30qFgdT/i7
 5ZOA==
X-Forwarded-Encrypted: i=1;
 AFNElJ++nlBKwR2WP7NUxcXfZnPzfgpt/RSfXZL18wPRcIXx6YsyQQ8iwR093xWxhLHkGDoiJerKhH7ein8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyQ9M6CHEDkVlRGYLRhYum7fa/CZmiy7MggdWhGT5X5vTVK+YId
 pio+XCCOzES+DR34mfERMkXhzoo5qys0pc4zmCU28NR9c6cTs0UaaQ8BbaOQ38gCgkM=
X-Gm-Gg: AfdE7cnS+f5plvXjAdPudQmJDN618WfdFJVn3WSP2zLEF4JjkOQNBabeIPqPYtVbF5d
 aW6I1hSevLOZUhn6HtenVcdNAJFIYJEqp5bXyXipLOwwqrUt01to1Qh8KYvqi1Q/me2P7iockjZ
 zgdwSJ8NJ7UarnfJ0ah0OvFy+vgPHTKvguJsuoyv9fxcOaWjaUrTJ/r96B0yJUwDo4vw/WevfEr
 WPTdDGrEA1oK95UVQQD1SwgcivzlenOQLXUGRLu1smwfgxib0PN50R1CalGURjTK+UHsyLPgh6J
 U0q2xXJcs4gM24OqpkGil2fpq7necp4353qRZQuYBOWue5JYQgevoJEgoi80l5tzC5H9TsJ6uEE
 wmklJ9UDTB7NIYxEDMdsGg7wm4cKXinptQ1r3E95U64pzsd3kJipHHO9N00iAJO4ffhQNwJUmjz
 j1uSvvcm5VxfcQ8VGG+PI/AsQmRMIYtuF+ck1uiW4K2rfxmlQaWiBZiEdDGMthb9XAdg==
X-Received: by 2002:a05:600c:4ed4:b0:492:1e36:85dd with SMTP id
 5b1f17b1804b1-49238231011mr57313945e9.37.1781785406267; 
 Thu, 18 Jun 2026 05:23:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:6e1b:5a5:b2b5:b2c0?
 ([2a01:e0a:106d:1080:6e1b:5a5:b2b5:b2c0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-461eaa0d275sm19033981f8f.2.2026.06.18.05.23.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 05:23:25 -0700 (PDT)
Message-ID: <d7e482c2-80aa-49ec-b339-8bffbdd7e664@linaro.org>
Date: Thu, 18 Jun 2026 14:23:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/3] drm/panel: himax-hx83121a: pass the panel pointer
 when creating BL
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
 <20260608162622.403713-2-zhengxingda@iscas.ac.cn>
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
In-Reply-To: <20260608162622.403713-2-zhengxingda@iscas.ac.cn>
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
> As backlight powering on/off support will be added, more fields of the
> panel context will be accessed in the backlight update function.
> 
> Pass the whole panel struct instead of the DSI device when creating the
> backlight device.
> 
> Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> ---
>   drivers/gpu/drm/panel/panel-himax-hx83121a.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-himax-hx83121a.c b/drivers/gpu/drm/panel/panel-himax-hx83121a.c
> index bed79aa06f46a..1a7e0125bced8 100644
> --- a/drivers/gpu/drm/panel/panel-himax-hx83121a.c
> +++ b/drivers/gpu/drm/panel/panel-himax-hx83121a.c
> @@ -193,10 +193,11 @@ static const struct drm_panel_funcs himax_panel_funcs = {
>   
>   static int himax_bl_update_status(struct backlight_device *bl)
>   {
> -	struct mipi_dsi_device *dsi = bl_get_data(bl);
> +	struct himax *ctx = bl_get_data(bl);
>   	u16 brightness = backlight_get_brightness(bl);
>   	/* TODO: brightness to raw map table */
> -	return mipi_dsi_dcs_set_display_brightness_large(dsi, brightness);
> +	return mipi_dsi_dcs_set_display_brightness_large(to_primary_dsi(ctx),
> +							 brightness);
>   }
>   
>   static const struct backlight_ops himax_bl_ops = {
> @@ -205,9 +206,9 @@ static const struct backlight_ops himax_bl_ops = {
>   };
>   
>   static struct backlight_device *
> -himax_create_backlight(struct mipi_dsi_device *dsi)
> +himax_create_backlight(struct himax *ctx)
>   {
> -	struct device *dev = &dsi->dev;
> +	struct device *dev = &to_primary_dsi(ctx)->dev;
>   	const struct backlight_properties props = {
>   		.type = BACKLIGHT_RAW,
>   		.brightness = 512,
> @@ -215,7 +216,7 @@ himax_create_backlight(struct mipi_dsi_device *dsi)
>   		.scale = BACKLIGHT_SCALE_NON_LINEAR,
>   	};
>   
> -	return devm_backlight_device_register(dev, dev_name(dev), dev, dsi,
> +	return devm_backlight_device_register(dev, dev_name(dev), dev, ctx,
>   					      &himax_bl_ops, &props);
>   }
>   
> @@ -646,7 +647,7 @@ static int himax_probe(struct mipi_dsi_device *dsi)
>   	ctx->panel.prepare_prev_first = true;
>   
>   	if (desc->has_dcs_backlight) {
> -		ctx->backlight = himax_create_backlight(to_primary_dsi(ctx));
> +		ctx->backlight = himax_create_backlight(ctx);
>   		if (IS_ERR(ctx->backlight))
>   			return dev_err_probe(dev, PTR_ERR(ctx->backlight),
>   					     "Failed to create backlight\n");

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
