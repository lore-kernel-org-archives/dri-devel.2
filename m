Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C03CD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 15:35:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDA4910F1AA;
	Thu,  7 May 2026 15:35:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hT7aifRu";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C90E010F1AA
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 15:35:21 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-48d102471a4so10558345e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 08:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778168120; x=1778772920; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=GI9QQt0uat60f27/e8CjUrG4GRyOGDwHMWobsR5o1QQ=;
 b=hT7aifRuHLy5bUkfCzmxL3y4ddACe6SIrq7UbIGCQe34z+zjuUednGDzOcbT0ALC2C
 QlkRZtXZcaGxHQpUAoGD8t5MKl79YF+fAmv0lwbKqnDIOQK8/KGQHnbUN3EpXX0pErHG
 N8Ort374FavwhcBsF3j87Z0zZFu77tcXcBXmPMv5w9fpF/wwV3WIpVljLKqua4yFt84+
 7H2yY7Uz6ntu7M8jZ6B79e9XVYv3tcmqA6qVERE4x3Tzy/CEZqjYrRCF9aoZtnhbvTyG
 R/s+c5wQPEpnYxB5Iiq4BBVjw5NBfcbCKaXvr+5pPOLAfIuuQ2QP0Y+Qp2P5mrYdw2kA
 1AyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778168120; x=1778772920;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GI9QQt0uat60f27/e8CjUrG4GRyOGDwHMWobsR5o1QQ=;
 b=H2y3gDnq6yCUDgCO9tO+/yGdDqIJxM/ozC5DsXBcBz8KmDzoXbUC1kWUkfJngmBtHg
 +6SFLKzKo1vr2tlMIGbjN3RJKCvEV6Jp2Ca4iKlUG4qXTG+CRylliJPIvp4jBPGeK/2A
 +6kmkw40SYOjMojm7B8gLAFBKTWFjleocqEYv9oQI36XgwXDVcAQeyw5aiWFuY4zr0Me
 11H8kIa8tcDZu7JFrzJnXro7+R5TIw1F/wK4fFSYF5FdxOCb7Dx1PTMhVC5I9/Ciu7CP
 tpu98ofB+G69sq226UrYbYDRXE62cOSi+qf2wI9VtBi7HgoBHQ9DQqTZ2PXf7ucngjgB
 l9oA==
X-Gm-Message-State: AOJu0YyAwNp7rKFt2CXMZzYx10GIvlgLh/ObnxYoBrUns5+BZsNiBTxH
 xbUzf/zEVa2Gm53Dadyz/dD0kLhYCIexr9EvG4vJlarXpmzWUZOBRbHmiuz6nC3Bbl4=
X-Gm-Gg: AeBDieuYKahF3o8R2mEISY8kDwx7gNJYxN4YHlDHTdyGRRExBrLIF1FvpsWRa3IMl2N
 qLRkf0sMtXxNnuFvQ3YXf0ViuNzdtEcLI3KIwnBZB+jngYY2DOhKxbnS3JsNQn12RFx0y6wnvD0
 bh92t9tRKENmP/DxQ1L5/kg/S01Id/CX79YsGZakg0jEbMI+VveuEN4mI+JaqmVtSwwwEWexaEn
 luJ8PY/H1pg2GI5kzm8vCXbCXDXrvxhDZAxBzSGEfd/97njQ+Z4k8KBoJMqtFlfYXd2rve5IYcl
 VV6mYx2/X63KQs9aEef6rPLcEyg02bJ+ezEh6UPuFpBKnPm4Axs16F/b57BptJp8NpvzcLpXbGE
 LAUxEHTJrdS/5D+XRIduWYu5jYDUkJZFF/wQztX0I0STab8swxM1Jban5WRaiCECFfjhQqB0t8T
 CJXoeOQspKcvWqkGacZMXXPm4ub+LOM0CypL3jJxRjv6KgGUCu/S5+x+GOgy4P07tUL7w5Yw2Yu
 sWNKK9Q7Ct0VOK31w==
X-Received: by 2002:a05:600d:18:b0:48a:75b9:5e07 with SMTP id
 5b1f17b1804b1-48e51f2f14emr104673885e9.11.1778168120170; 
 Thu, 07 May 2026 08:35:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:6762:47bb:1e06:ff70?
 ([2a01:e0a:106d:1080:6762:47bb:1e06:ff70])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e628d8da6sm12073945e9.4.2026.05.07.08.35.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 08:35:19 -0700 (PDT)
Message-ID: <494a5e7d-03fe-4138-b8fb-e17110787af4@linaro.org>
Date: Thu, 7 May 2026 17:35:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 03/10] drm/panel/novatek-nt37700f: Use refcounted
 allocation in place of devm_kzalloc()
To: Albert Esteve <aesteve@redhat.com>, Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Michael Tretter <m.tretter@pengutronix.de>, Michael Walle
 <mwalle@kernel.org>, Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260507-drm_panel_init_rm-v1-0-51f448c7c291@redhat.com>
 <20260507-drm_panel_init_rm-v1-3-51f448c7c291@redhat.com>
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
In-Reply-To: <20260507-drm_panel_init_rm-v1-3-51f448c7c291@redhat.com>
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

On 5/7/26 13:53, Albert Esteve wrote:
> Move to using the new API devm_drm_panel_alloc() to allocate the
> panel. In the call to the new API, avoid using explicit type and use
> __typeof() for more type safety.
> 
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>   drivers/gpu/drm/panel/panel-novatek-nt37700f.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt37700f.c b/drivers/gpu/drm/panel/panel-novatek-nt37700f.c
> index 74f46a268c0f6..c221dd498fed4 100644
> --- a/drivers/gpu/drm/panel/panel-novatek-nt37700f.c
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt37700f.c
> @@ -225,9 +225,12 @@ static int nt37700f_tianma_probe(struct mipi_dsi_device *dsi)
>   	struct nt37700f_tianma *ctx;
>   	int ret;
>   
> -	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> -	if (!ctx)
> -		return -ENOMEM;
> +	ctx = devm_drm_panel_alloc(dev, __typeof(*ctx), panel,
> +				  &nt37700f_tianma_panel_funcs,
> +				  DRM_MODE_CONNECTOR_DSI);
> +
> +	if (IS_ERR(ctx))
> +		return PTR_ERR(ctx);
>   
>   	ctx->supply = devm_regulator_get(dev, "power");
>   	if (IS_ERR(ctx->supply))
> @@ -247,8 +250,6 @@ static int nt37700f_tianma_probe(struct mipi_dsi_device *dsi)
>   	dsi->mode_flags = MIPI_DSI_MODE_VIDEO_BURST |
>   			  MIPI_DSI_CLOCK_NON_CONTINUOUS | MIPI_DSI_MODE_LPM;
>   
> -	drm_panel_init(&ctx->panel, dev, &nt37700f_tianma_panel_funcs,
> -		       DRM_MODE_CONNECTOR_DSI);
>   	ctx->panel.prepare_prev_first = true;
>   
>   	ctx->panel.backlight = nt37700f_tianma_create_backlight(dsi);
> 

