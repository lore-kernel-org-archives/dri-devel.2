Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AEFACD3439
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 15:36:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80C3310F1BC;
	Thu,  7 May 2026 15:36:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nP8XwYKH";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AB7810F1D1
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 15:36:53 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-48d146705b4so12567895e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 08:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778168212; x=1778773012; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=TC+WcOmSnmbCmszuAYvNK3p+hdwx02QbAixg42UI5rI=;
 b=nP8XwYKH1SN56EjDG3w3ciMo87Gidpe3jMbsCCccVC9Yk6D9FqBFXVK1GHBeW3Idpo
 MAakGZ7vu4WfSYPrqHW8eFRfxcTZuYW430XYNkTWd3wYGsYdKemC3Hwbzwabbiho97Pr
 8WQks27lL7Knb1+WvUyqhuVuKQz3xLS40wX75vt7pjtw8r54DSs2R442WVzW/sPOQy0Z
 FElHClzm3HHjcry2jGZ2/wKstcjpnJglAiv+rzZzvmdP+XJfk2LS+t9KJe3dneFcz0Za
 09T+PFBgvSbFoa9hpRj2nB/otNiZSX5iXQoSwEU3n7ub0JBS/CA7z7FVfKXeovKt0kNw
 QP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778168212; x=1778773012;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TC+WcOmSnmbCmszuAYvNK3p+hdwx02QbAixg42UI5rI=;
 b=bq7emKVywdlPJAQvcXnp0bQM2b6UYCMPK3p1PHV8dwBI8B3hK7TjsxSNcU3n2RT7oR
 /TtQIA09OmTRoZQ/qsz1FAWsOTphvzafgT8K3oAPjHq8U++nYJ/Nrh0s5exrOl8SvF1m
 PDWiZhZT9rWIOWON7G9HCSBWaRubsUSkosZWx285QzY/WGFMn19wXiJKm0Wo70ZZhSlU
 SZcVeuFzy+GlAlQ1TDZLtwaM9zP2MiLEKN2fKsMu36j9OwoUy55Vp4pyLoSbHzOuC96H
 s93f1Ds7jMm1cIXcRgBXDnITVSCg+9iK/dRJ0tvPFk8JUGJy3uY9kHhrmomXZqLpTnHN
 WLnA==
X-Gm-Message-State: AOJu0YyN5UQbzOK8JvJCJd4Ozoe+lseTVe7hpqsGoXDY4dN+vKZ2q3Da
 ju4kC++8E8StFWH0mDE803ZSJgCaYQMiY6MJgmtpp3ZjrzfOAk3FTr24j1kplZ4edss=
X-Gm-Gg: AeBDieuTX1KjgzJR2+J3ytABpadr7Hknguobt7FstUfkoXj+YsUm1IgeFrwWUeMcXDN
 emO9DddUP0XxQxrLA8MZrVztZzk0c/7TGLRJQg9W+iFE3hSA64AsG6bYgaS/fE87vgEG0RNm2ua
 jXCHUnWaWVcdvXb7ah+J7Bd8506X0+9Hv36FrMy3luoQEIyl0uT4f1AW2XNEfOaKQV2SvKMKN2n
 zt+rkUSO9uERpD1YDtK6nBdwVRjPpyVjHqBTFQDw9LorhuFsjdnJaU804JfJ+En5mlse1hB248F
 Y/sPdxZMCOCHqBbl8z+as/HhoMvrgp1ziaWMOuC6cyjrDMlC4jNIsTjvgMkS0J1WZ41Cg2dRUWC
 p1848nrj80ebnGy8F1A99ZwyoV8expFELF2i6SINMbY3i1z8kQjnyXcL2laKwAEKylj+8KYff8k
 zfXbecH2NkqQb3vVL2tm5x+OJT7/Yi/jY3KCxo50YiFrLiq22N07fCDvq4NxKQ6aNBO1tvCT5J6
 Nx/scFqHzZPZUspT3E27fEjD9Er
X-Received: by 2002:a05:600c:1d18:b0:48a:906b:14ca with SMTP id
 5b1f17b1804b1-48e51f46e46mr136818815e9.20.1778168211126; 
 Thu, 07 May 2026 08:36:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:6762:47bb:1e06:ff70?
 ([2a01:e0a:106d:1080:6762:47bb:1e06:ff70])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5389da63sm133465345e9.4.2026.05.07.08.36.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 08:36:50 -0700 (PDT)
Message-ID: <f08ea3a8-3ab8-4060-9f3a-3815ca43026e@linaro.org>
Date: Thu, 7 May 2026 17:36:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 07/10] drm/panel/sharp-ls043t1le01: Use refcounted
 allocation in place of devm_kzalloc()
To: Albert Esteve <aesteve@redhat.com>, Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Michael Tretter <m.tretter@pengutronix.de>, Michael Walle
 <mwalle@kernel.org>, Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260507-drm_panel_init_rm-v1-0-51f448c7c291@redhat.com>
 <20260507-drm_panel_init_rm-v1-7-51f448c7c291@redhat.com>
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
In-Reply-To: <20260507-drm_panel_init_rm-v1-7-51f448c7c291@redhat.com>
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
>   drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c b/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
> index dd1eaba23ad3c..989b030ea22de 100644
> --- a/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
> +++ b/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
> @@ -199,8 +199,6 @@ static int sharp_nt_panel_add(struct sharp_nt_panel *sharp_nt)
>   		gpiod_set_value(sharp_nt->reset_gpio, 0);
>   	}
>   
> -	drm_panel_init(&sharp_nt->base, &sharp_nt->dsi->dev,
> -		       &sharp_nt_panel_funcs, DRM_MODE_CONNECTOR_DSI);
>   	sharp_nt->base.prepare_prev_first = true;
>   
>   	ret = drm_panel_of_backlight(&sharp_nt->base);
> @@ -231,9 +229,12 @@ static int sharp_nt_panel_probe(struct mipi_dsi_device *dsi)
>   			MIPI_DSI_CLOCK_NON_CONTINUOUS |
>   			MIPI_DSI_MODE_NO_EOT_PACKET;
>   
> -	sharp_nt = devm_kzalloc(&dsi->dev, sizeof(*sharp_nt), GFP_KERNEL);
> -	if (!sharp_nt)
> -		return -ENOMEM;
> +	sharp_nt = devm_drm_panel_alloc(&dsi->dev, __typeof(*sharp_nt), base,
> +					&sharp_nt_panel_funcs,
> +					DRM_MODE_CONNECTOR_DSI);
> +
> +	if (IS_ERR(sharp_nt))
> +		return PTR_ERR(sharp_nt);
>   
>   	mipi_dsi_set_drvdata(dsi, sharp_nt);
>   
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
