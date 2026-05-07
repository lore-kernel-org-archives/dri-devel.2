Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65277CD3439
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 15:34:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C07E810E2BB;
	Thu,  7 May 2026 15:34:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qis7Ux2X";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0655D10E2BB
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 15:34:50 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso9703005e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 08:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778168088; x=1778772888; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=HNpNxTDdt1OmLULsDYJhJ1FFpNi+U6Ym7YcH8EiGwkY=;
 b=qis7Ux2XJbYcm+CVYbhKwkeMkyINSi1zrDsWMVIGC07kkGwz+iGCgQPC25l1iIfITq
 gg0UOO0h5/a8QrXjSApF6MrRmJH7ZlfgFLDYPnEDdMEqX/BWo5MUE7snZZZeKFV0Gy6b
 eIjt9OaRXKSwGVqIjiA3ztXpdG3NZjVICdWBF94/EyoRCB+1LhD4g9tyMF/8xllY7y5E
 5hZccQJhPEXc3TtK1z9y8APnzaJOeJpD5tJ24PB+iDYi0UQrmVQ3ZelxotmGYlqetjBr
 fYc2Lb7a5cj+kc+P1YcAlNHYFoQw8ZGU8LFRf67D8UWUm7WlI/YkDy4cTySzBrzRaMMX
 Z2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778168088; x=1778772888;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HNpNxTDdt1OmLULsDYJhJ1FFpNi+U6Ym7YcH8EiGwkY=;
 b=mHRuV+Ap3JG+V42SJiVB4W+js3yPQcGgVE0T/ZZS344LKpOot1qipJ4lRk4ynGcE7L
 TII4oaU5672p2jEYM+JJcWCky2Y9ZFny46fuRaRtciYAwrk/CDlfhA5hB3h3JW26x1ie
 l/NYEXMbS/h6rZ8RhdJ6AHddzWtX38sytaP1LYtfFeUpOGCm6KIOkTYFNVaauB/Gg/1n
 rVnmlEmt9TEpxkbkBp1paIUyvBoJzZeH7zIPGpoYRV0QVFIDJYkCQF+Y/A/g6lzdlHym
 FqvpCqAHmbCF2c8mISSfrShP1g5cC4vUiJP1esv91Fx4K9Na9KsWw6Vq2QS+bvHazgX1
 b+qg==
X-Gm-Message-State: AOJu0YxmGjt/Au3lHTIYcxgkIo6XbgVMeL2j0HeFePzqIEURcZZ2wNO1
 IzZBlXeSFAhiMNr6mxJJAkzTfAfpT9qdrPWDpV9nLt4m4zcersLkWV1YHD9WYv7UjGI=
X-Gm-Gg: AeBDieuvb4th3i5zVr8Hh3RUS7BqhTsO2pOgIMxNIx3qO6ARx00W97mrkS6toHI7Bvp
 lfXbtSRol8IYR/CFFmSpfrOxIearPcnqwjYP4eAHPYgQuPkjW9SYaRHjtEZzKtvIFKUYzm2WZy8
 WpTWqEVk9W6Z4qrcvWmSUu75kaYSN41fDYtXBYxNXIbGmQfBiSVussSEuKeXTZCy8WrLY+y8gN1
 ybqyfB07X6CiGRyb9phFz5Dr/TpHErf7gG4XC26lCC5RozoLTWNSL/6DpiXK08RpAapnoibuaD7
 nlTSjwBWA7Brd2f6FY4c5UU+vHrE+FyXqXDAMjKywSFBVXpHN+zr0TKnhgYBGiypQ3z3pEnWkML
 c/Tg7+cd3pp9lmKjDjXBKDdFirp2Xs9MsuONYqYk4DNhWik2pCjtTLl25manFv4dNRgU6Qmg+Nt
 6rOMOemSoZYPlN3nmMSWe2BYIRCepq1VzZyr2yVqJvY6N0+Csh3vGEFAG1k+sBNhoR4igm+Oscy
 uwcO8gre1+DWWEaEMGF7Pr4Kr7A
X-Received: by 2002:a05:600c:a30b:b0:489:1c1f:35f9 with SMTP id
 5b1f17b1804b1-48e51e1773bmr103146425e9.9.1778168088174; 
 Thu, 07 May 2026 08:34:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:6762:47bb:1e06:ff70?
 ([2a01:e0a:106d:1080:6762:47bb:1e06:ff70])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4505558e213sm22225403f8f.25.2026.05.07.08.34.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 08:34:47 -0700 (PDT)
Message-ID: <9b2d61b9-6f7e-49fb-967d-e0858ff782ce@linaro.org>
Date: Thu, 7 May 2026 17:34:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 01/10] drm/panel/visionox-g2647fb105: Use refcounted
 allocation in place of devm_kzalloc()
To: Albert Esteve <aesteve@redhat.com>, Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Michael Tretter <m.tretter@pengutronix.de>, Michael Walle
 <mwalle@kernel.org>, Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260507-drm_panel_init_rm-v1-0-51f448c7c291@redhat.com>
 <20260507-drm_panel_init_rm-v1-1-51f448c7c291@redhat.com>
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
In-Reply-To: <20260507-drm_panel_init_rm-v1-1-51f448c7c291@redhat.com>
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

On 5/7/26 13:52, Albert Esteve wrote:
> Move to using the new API devm_drm_panel_alloc() to allocate the
> panel. In the call to the new API, avoid using explicit type and use
> __typeof() for more type safety. Also deduplicate the prepare_prev_first
> assignment that was set both before and after drm_panel_init().
> 
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>   drivers/gpu/drm/panel/panel-visionox-g2647fb105.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-visionox-g2647fb105.c b/drivers/gpu/drm/panel/panel-visionox-g2647fb105.c
> index 413849f7b4dec..d5555a1731575 100644
> --- a/drivers/gpu/drm/panel/panel-visionox-g2647fb105.c
> +++ b/drivers/gpu/drm/panel/panel-visionox-g2647fb105.c
> @@ -207,9 +207,12 @@ static int visionox_g2647fb105_probe(struct mipi_dsi_device *dsi)
>   	struct visionox_g2647fb105 *ctx;
>   	int ret;
>   
> -	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> -	if (!ctx)
> -		return -ENOMEM;
> +	ctx = devm_drm_panel_alloc(dev, __typeof(*ctx), panel,
> +				  &visionox_g2647fb105_panel_funcs,
> +				  DRM_MODE_CONNECTOR_DSI);
> +
> +	if (IS_ERR(ctx))
> +		return PTR_ERR(ctx);
>   
>   	ret = devm_regulator_bulk_get_const(dev,
>   					    ARRAY_SIZE(visionox_g2647fb105_supplies),
> @@ -233,10 +236,6 @@ static int visionox_g2647fb105_probe(struct mipi_dsi_device *dsi)
>   
>   	ctx->panel.prepare_prev_first = true;
>   
> -	drm_panel_init(&ctx->panel, dev, &visionox_g2647fb105_panel_funcs,
> -		       DRM_MODE_CONNECTOR_DSI);
> -	ctx->panel.prepare_prev_first = true;
> -
>   	ctx->panel.backlight = visionox_g2647fb105_create_backlight(dsi);
>   	if (IS_ERR(ctx->panel.backlight))
>   		return dev_err_probe(dev, PTR_ERR(ctx->panel.backlight),
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
