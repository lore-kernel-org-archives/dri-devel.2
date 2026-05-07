Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C177CD3442
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 07:12:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E244310E312;
	Thu,  7 May 2026 07:12:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Lo/GP9i0";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB61410E312
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 07:12:46 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4891f625344so5080675e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 00:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778137965; x=1778742765; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=nxn+gzXZryt3B/YHtHg/ku/ujylgebVtdoLvLxBx7Y8=;
 b=Lo/GP9i0xwhKPo4L05igur4DgHXrJkA059Xf5KIjUB2DzEQQHOLwVes/P/ub7MMB2Y
 yhz6L0Xba2pefUj4ciN73WZCRuvvIwpKzn/v4fHlR3fKjNCVSOh0RPjlxQqHcc/YSq1m
 xvpbkcm1dDuidElMqCcLlPJXEipYmwPgNziz6hYTiQIBk3qFdwWLv/axr0FWTvI2pYET
 U7MCuknL+XHBKdWAQXIVp+2nFcmxgwQNDVyADcNRTROwhi2Mgu5obi7xAou1qO4vNe/V
 +jTMq+Povl7FGgKlKT0Vexf1pugiflmrZ0CpTvPxVPzFG5nuDl8gJ5HEfYoxDOiQBfc0
 sT6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778137965; x=1778742765;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nxn+gzXZryt3B/YHtHg/ku/ujylgebVtdoLvLxBx7Y8=;
 b=g5IT6BSpGjguZfOydLuQjeJaa/HWh9u/+FC2pMBycMM4XtCRBSUtNu/eMlTCCFvMls
 yRq6FEFpuRqORx3NwHoQRP01oiJ2UfZ2WyP58oGZVurOL2DP+41qTA3MU/rlSyK81C1V
 ld9GpVP7hl6a08h13rqkCYW4kA8rO8toxW2EzneAZ1de7qMqfliFRFTXUJsMo3XA9HO1
 F7Cmi6I5KL4OWJtI/v6Z4ZDT7boAReRWxPIROhZZIhFWei13XqDIRmYbdC+wPUHLC2hd
 jpQ03C7R6Uz+27eAAwbjg2WS3t/oWTtvcfiPaShv5quHZpVz2hkCE6rmKxjHRVnMPEXN
 Khog==
X-Gm-Message-State: AOJu0Yx/FAMQOdCFIWF+bn3N3JqP+rP81AL6sRw3KdB7ehn0zEEb2aAc
 BHNPeiiH25jWsP5sGRnkC6Xg4wYRlyBKMW1rmYkrRtDb7dwLX5u8w3lZD37haas2auaUMZeKx14
 XHXtM
X-Gm-Gg: AeBDieuBtkVLR92mpBZomWgxx82YcwHVJasSpNWVSo2l5GEBdHdBCgud9GyZV7yYnaq
 21e6DZT0G8krmLZz9YmUrHUv2nAcJNbmWBq5QqxHKo79s6CeZBWVOWx84PoAITqPVmXsTUIyde/
 QxcOJbnNiFALQHHCUq+ct4WF++3VHY2+hQE6nHTQoDEL8B6l60Q6S+E0UqfCIvztTgzkkWm+Snb
 1FJAdmQCt0QYLfjVT+OcBfXngJjPdYJ6tfGWXy7HqkX9qyK/sdXPdvtfRoZZu3bb6eOzpGtE+i6
 YelCbvM8WgciNMaqylSQm2GY1uRZ40t/LYuKsZyfh/KnsimoofpQD7MMZtI9y3Vsa8urfFAjFJk
 ygLlBZKRUGM9ZDGfVGJrZYztYxuC5uOYxmimQGWlCjip+mosYI85sTR7sCw0/LWbNSQ7vHg60C9
 wP+AfngxV7e3PeQ/u9R93pFxedlfXCK/95MX8SvY6XfrnaWIrjCmaOE6uoETOkFij3VGghJ9Ams
 Zx7XaRqnxvaotxlmQ==
X-Received: by 2002:a05:600c:c0d8:b0:486:faa8:9e4 with SMTP id
 5b1f17b1804b1-48e5e000c1cmr17768625e9.12.1778137965257; 
 Thu, 07 May 2026 00:12:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:5798:67fd:c866:b378?
 ([2a01:e0a:106d:1080:5798:67fd:c866:b378])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5389da63sm103677125e9.4.2026.05.07.00.12.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 00:12:44 -0700 (PDT)
Message-ID: <fb94f291-3831-417a-a924-e355cae27d89@linaro.org>
Date: Thu, 7 May 2026 09:12:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/2] drm/panel: visionox-rm69299: Move power_on/off into
 prepare/unprepare
To: =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org, David Heidelberg <david@ixit.cz>
References: <20260427-visionox-rm69299-enable-v1-0-fa7d62d26d87@sigxcpu.org>
 <20260427-visionox-rm69299-enable-v1-2-fa7d62d26d87@sigxcpu.org>
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
In-Reply-To: <20260427-visionox-rm69299-enable-v1-2-fa7d62d26d87@sigxcpu.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 4/27/26 15:56, Guido Günther wrote:
> No need to have separate functions now that prepare/unprepare only
> handle powering on & off.

Following my comment on patch 1, just move the unprepare() one, keep the
power on in prepare().

Neil

> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
>   drivers/gpu/drm/panel/panel-visionox-rm69299.c | 36 +++++++++-----------------
>   1 file changed, 12 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-visionox-rm69299.c b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
> index 3c92a6ceb8df..5c869d353368 100644
> --- a/drivers/gpu/drm/panel/panel-visionox-rm69299.c
> +++ b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
> @@ -198,15 +198,25 @@ static int visionox_rm69299_disable(struct drm_panel *panel)
>   	return dsi_ctx.accum_err;
>   }
>   
> -static int visionox_rm69299_power_on(struct visionox_rm69299 *ctx)
> +static int visionox_rm69299_unprepare(struct drm_panel *panel)
> +{
> +	struct visionox_rm69299 *ctx = panel_to_ctx(panel);
> +
> +	gpiod_set_value(ctx->reset_gpio, 0);
> +
> +	return regulator_bulk_disable(ARRAY_SIZE(visionox_rm69299_supplies),
> +				      ctx->supplies);
> +}
> +
> +static int visionox_rm69299_prepare(struct drm_panel *panel)
>   {
>   	int ret;
> +	struct visionox_rm69299 *ctx = panel_to_ctx(panel);
>   
>   	ret = regulator_bulk_enable(ARRAY_SIZE(visionox_rm69299_supplies),
>   				    ctx->supplies);
>   	if (ret < 0)
>   		return ret;
> -
>   	/*
>   	 * Reset sequence of visionox panel requires the panel to be
>   	 * out of reset for 10ms, followed by being held in reset
> @@ -222,28 +232,6 @@ static int visionox_rm69299_power_on(struct visionox_rm69299 *ctx)
>   	return 0;
>   }
>   
> -static int visionox_rm69299_power_off(struct visionox_rm69299 *ctx)
> -{
> -	gpiod_set_value(ctx->reset_gpio, 0);
> -
> -	return regulator_bulk_disable(ARRAY_SIZE(visionox_rm69299_supplies),
> -				      ctx->supplies);
> -}
> -
> -static int visionox_rm69299_unprepare(struct drm_panel *panel)
> -{
> -	struct visionox_rm69299 *ctx = panel_to_ctx(panel);
> -
> -	return visionox_rm69299_power_off(ctx);
> -}
> -
> -static int visionox_rm69299_prepare(struct drm_panel *panel)
> -{
> -	struct visionox_rm69299 *ctx = panel_to_ctx(panel);
> -
> -	return visionox_rm69299_power_on(ctx);
> -}
> -
>   static const struct drm_display_mode visionox_rm69299_1080x2248_60hz = {
>   	.name = "1080x2248",
>   	.clock = 158695,
> 

