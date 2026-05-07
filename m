Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2195CD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 15:36:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 467E910F1D5;
	Thu,  7 May 2026 15:36:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lgkmyRXH";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5330810F1B1
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 15:35:52 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-44ccbd3290aso773387f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 08:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778168151; x=1778772951; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=4z5DD24RfTrdP45OX3nmt+xGieHCkU7CBzs7THghyBo=;
 b=lgkmyRXHZpv4p+yAv7RR/2T5UCldOBXbxmQgjt8FdIo1YELD1k0lcgncMhdGKEkM38
 Jy4nhhSahMb60qzBpcGXGO5OAFPnH+x7YWt2qdvt++uEG/taXl8MrbIGJTxKSZ5KXAA+
 zHxLN2VBQZFQXG0Ebaq8c9urMeI4W7g41UhAEWoQSoxSwGaLqrVtSf6fh0oVPNaAMbbU
 K23ydHoEIqJ7lY0G/d7atWWSeJTfVAGd3osrKdv+Y27KZyNYM7DbmNc9K9riCk3Fz166
 iSm8U4mPHS44qcWToGeuKbtGwOByhQ7ry/U8sktyWmqWr8C3klOKRprk11us2Ugwsaq6
 vSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778168151; x=1778772951;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4z5DD24RfTrdP45OX3nmt+xGieHCkU7CBzs7THghyBo=;
 b=SKO2EVEYxyFFof8h0XYaexcCmokQu2j/9vA1S+0dEy24di/5ay6zUAke43tEOOeOju
 8Igt8VOmjyup8Mu8C3S2oE546MSpkyba3fHuggXj7PMyq7Y/jUSjmVq3ZWtvSC5Cpvdt
 o0sxSNfeXF/Tal/lNCLb8hIlAvqSO5kS6OKA9jiXbqxg27F7NHgJTZF/dws/cWSX+hOm
 YxOx0YzHmJYiP5ewv77ccgKzaLVaSdAtVDdNtwkW+KEvNos3oJ4ALLqO9pS6AxCiIHJf
 gk/cKp8DOhLOBAjfcJAJeU/hndZbcR+oSv5xAAgmTexdrIOiZE9Vc2waSiSpYq7HXHkU
 FH/g==
X-Gm-Message-State: AOJu0Yyj2fyK16gkFu90oRPRVP/I+vwbS0TkAWljQw6EBK9F6G4/i466
 M8gwRpuZgZjKvarlg3Ewhyt+0Yyb7W1kvayL4CgnXA6lU5JfjhCmAQy3UlpQZLQMCQo=
X-Gm-Gg: AeBDiesF5qUO+wwZjBlzwHNnbhtD9Pc+PLzIUmSItS5Z6dfdzslAr3wigTwHHQl00hr
 Vo8iPr6Xhn3x4trIKeOwnGGhW6AxOiUtrNxKOs19VSQtEzTFkrQiPF54o7Tj2TcvIWRkfh2JFyx
 VNzrt0sBUZ39bZsiRydthyVcyHBexaOjmgw5f9B13i2pIlnuhW9E/nUHNa20oJECBJz7+5lgKmv
 V+hj1yHQK4Cn/q3jVyxWORm7QtlnUSkR6ibhUZv3DJgK1rRYf6QHhXirtGT3wa8rk88WF08+o/K
 wvl7VpBE+HwJd340CAS6F7orJEyFvDPFHY0/6W9dGloCBQ6dzXCFI6DL/kRhjEDyEXngfrYWUJi
 RHOUNG5Zdi0IgTPlvseTRJKYtJok8g9Jn+T/FRjR72kQ48udVWo5qB31d9bBTmEFDrYU5zfZT1p
 Ou2zDqEz0+rVKWn4pK0t/KYAatkR8rOIlFWUcpw8JVvS+G5kvqHuZ4WKS86RlyvyVwbWVdvtdHM
 yUfWukn9dzUC60xRBf5cRMqYyxW
X-Received: by 2002:a05:600d:10:b0:488:e7e4:8425 with SMTP id
 5b1f17b1804b1-48e51f4ea40mr114855745e9.23.1778168150443; 
 Thu, 07 May 2026 08:35:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:6762:47bb:1e06:ff70?
 ([2a01:e0a:106d:1080:6762:47bb:1e06:ff70])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e53142043sm43689315e9.27.2026.05.07.08.35.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 08:35:49 -0700 (PDT)
Message-ID: <cb8a5660-4951-4652-b326-2e0103aecada@linaro.org>
Date: Thu, 7 May 2026 17:35:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 05/10] drm/panel/ilitek-ili9806e: Use refcounted
 allocation in place of devm_kzalloc()
To: Albert Esteve <aesteve@redhat.com>, Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Michael Tretter <m.tretter@pengutronix.de>, Michael Walle
 <mwalle@kernel.org>, Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260507-drm_panel_init_rm-v1-0-51f448c7c291@redhat.com>
 <20260507-drm_panel_init_rm-v1-5-51f448c7c291@redhat.com>
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
In-Reply-To: <20260507-drm_panel_init_rm-v1-5-51f448c7c291@redhat.com>
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
>   drivers/gpu/drm/panel/panel-ilitek-ili9806e-core.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9806e-core.c b/drivers/gpu/drm/panel/panel-ilitek-ili9806e-core.c
> index be2cf14401553..53e25d1086db8 100644
> --- a/drivers/gpu/drm/panel/panel-ilitek-ili9806e-core.c
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9806e-core.c
> @@ -78,9 +78,11 @@ int ili9806e_probe(struct device *dev, void *transport,
>   	bool set_prepare_prev_first = false;
>   	int ret;
>   
> -	ctx = devm_kzalloc(dev, sizeof(struct ili9806e), GFP_KERNEL);
> -	if (!ctx)
> -		return -ENOMEM;
> +	ctx = devm_drm_panel_alloc(dev, __typeof(*ctx), panel,
> +				  funcs, connector_type);
> +
> +	if (IS_ERR(ctx))
> +		return PTR_ERR(ctx);
>   
>   	dev_set_drvdata(dev, ctx);
>   	ctx->transport = transport;
> @@ -103,8 +105,6 @@ int ili9806e_probe(struct device *dev, void *transport,
>   		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
>   				     "Failed to get reset-gpios\n");
>   
> -	drm_panel_init(&ctx->panel, dev, funcs, connector_type);
> -
>   	ret = drm_panel_of_backlight(&ctx->panel);
>   	if (ret)
>   		return dev_err_probe(dev, ret, "Failed to get backlight\n");
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
