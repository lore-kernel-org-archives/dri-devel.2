Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9447ECD3439
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 15:37:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E979B10F1B2;
	Thu,  7 May 2026 15:37:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="l6z60WiW";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0075210F1B2
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 15:37:12 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4891c0620bcso7977945e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 08:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778168231; x=1778773031; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=M8S+Tg2Eja+tOTOC+LVq5hYqCOZm7RH/gZAoL5yYOEA=;
 b=l6z60WiWFnQc/5RER5bLTt9R3bAfmIJ+hvu8jZUL/ZMNk9IA+sJZVZhqWleXk2FU7B
 1656WrE6BBqTm82x4/SQiow9ckA4Blt3YzX2KJs+pf0H9FSN1uzzEP8bqVTuZO1wlmMz
 6FI657s1gNFRh5hJra1tygbmRY865i0bpYQSrETuZrYuNfHhVi/ZxwTaEmX65mUteHwl
 B+JMPluP4Kb7CbQ4jI522HYRSAxuG/R61OevF9XrmiiOyEt7nk/pDQ+87RlARSJvlhkC
 Y1I6qXeQJaeymO4qI82clYeHGeKSv3oRl5WKQW3m5VQj4zZAx4PHpYY5HvRhwi9LdyIA
 8Krw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778168231; x=1778773031;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M8S+Tg2Eja+tOTOC+LVq5hYqCOZm7RH/gZAoL5yYOEA=;
 b=Lw/0V1ElI7v1hj9l3UI1Iwli+vTmBEOFu0/BB4GzFas/htHYDe+S/Dfi+XaC6zWLrT
 xK9IXPMaSV/FIu23qHCbuf4ytwnVIcMwaSra8k9fiY6+b3tLr0O8/82Yf+WYrCAdSeCF
 ZZPwEYxIgFnLCkG42st1bSeLNlA3pQt15+uwuJgDyEY6ThzN8LnJsIm/PMir8cX+AL5G
 HM63gBL7updW6yYbVYpCcjd17rIHGMLYruuSf7/K4RsqSYQUxi2vE6Pe6fpC28GTJopN
 YdJaFi1Y4wOMXrHHG6cQSyHQOKEeOoxWId8bnPLMX4t69L/CAvLzYr13QmpYbOclfNEE
 2I4Q==
X-Gm-Message-State: AOJu0YyVAWt2RBn/iujqoi3967e3d2XRF8qKDRA/uX6/boWNW4HR9+lk
 jFlHlM5Lck5UO2mbMDa/+srU3eitOc6iZRZiohUUAUgGzdBP0ctOqULtnmmUgnlmsas=
X-Gm-Gg: AeBDieuM2wy6PO0let0sM8Z6sx8jkNdiYQOGbNvlpjrsMXWWLb1M4qosMJU3YZxECIm
 /+BRhFTB8Erd2J9u31RsRTe330zo9FQdEM/2K1N26UlK+orfYYvOXXofCLNSym9iUm3ujrE4WVg
 lA7HfzlWImOqMmd4bMqOZNC54TG0bV7joo9gN+f3Rth+TY1UZbD2Uv7yw/lSvvYvNCIAE1daxpv
 tSAMS2sVgXqauyGBOCwnn5wj8IMpK6ysLQd16AgtQV2wQt29UJs0THqdpMvrgK2l4tLlTfmovxo
 XbemOtyCTDTcWxI9IMvkGAuw9QpPB5hECNzyjLp78YzLzSolL4TN2iM85cTZlbZHW2coLQ7gLqI
 zizIcfADnQGVLtmd6C0NwpwluVItSZ9nF74Ql5J/fLh+Mf1uu0sIbQmK+JVHH79BZuXND+G8tw6
 yvNZ0uS11oJnnNBnwJlySivyXFFr3pAST8lsCRCaBSb0vn/iotQ2vUtAAHik+qntFLrESq7dZOP
 vE87pVel65gRB/wHQ==
X-Received: by 2002:a05:600c:6095:b0:485:39b2:a47c with SMTP id
 5b1f17b1804b1-48e51f48352mr138387665e9.25.1778168231238; 
 Thu, 07 May 2026 08:37:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:6762:47bb:1e06:ff70?
 ([2a01:e0a:106d:1080:6762:47bb:1e06:ff70])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e53116a9fsm63070005e9.8.2026.05.07.08.37.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 08:37:10 -0700 (PDT)
Message-ID: <c60ef89c-74c0-489e-9db7-ee584512592c@linaro.org>
Date: Thu, 7 May 2026 17:37:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 08/10] drm/panel/truly-nt35597: Use refcounted allocation
 in place of devm_kzalloc()
To: Albert Esteve <aesteve@redhat.com>, Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Michael Tretter <m.tretter@pengutronix.de>, Michael Walle
 <mwalle@kernel.org>, Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260507-drm_panel_init_rm-v1-0-51f448c7c291@redhat.com>
 <20260507-drm_panel_init_rm-v1-8-51f448c7c291@redhat.com>
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
In-Reply-To: <20260507-drm_panel_init_rm-v1-8-51f448c7c291@redhat.com>
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
>   drivers/gpu/drm/panel/panel-truly-nt35597.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-truly-nt35597.c b/drivers/gpu/drm/panel/panel-truly-nt35597.c
> index d447db912a61e..f740b9257c09c 100644
> --- a/drivers/gpu/drm/panel/panel-truly-nt35597.c
> +++ b/drivers/gpu/drm/panel/panel-truly-nt35597.c
> @@ -476,8 +476,6 @@ static int truly_nt35597_panel_add(struct truly_nt35597 *ctx)
>   	/* dual port */
>   	gpiod_set_value(ctx->mode_gpio, 0);
>   
> -	drm_panel_init(&ctx->panel, dev, &truly_nt35597_drm_funcs,
> -		       DRM_MODE_CONNECTOR_DSI);
>   	drm_panel_add(&ctx->panel);
>   
>   	return 0;
> @@ -523,10 +521,12 @@ static int truly_nt35597_probe(struct mipi_dsi_device *dsi)
>   		.node = NULL,
>   	};
>   
> -	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> +	ctx = devm_drm_panel_alloc(dev, __typeof(*ctx), panel,
> +				  &truly_nt35597_drm_funcs,
> +				  DRM_MODE_CONNECTOR_DSI);
>   
> -	if (!ctx)
> -		return -ENOMEM;
> +	if (IS_ERR(ctx))
> +		return PTR_ERR(ctx);
>   
>   	/*
>   	 * This device represents itself as one with two input ports which are
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
