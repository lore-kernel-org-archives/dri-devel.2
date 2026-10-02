Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF509CA5FD4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 14:02:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32FA110F84B;
	Fri,  2 Oct 2026 14:02:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MyIc5aB1";
	dkim-atps=neutral
Received: from mail-wr2-f39.google.com (mail-wr2-f39.google.com
 [74.125.225.103])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAF3F10F84B
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 14:02:33 +0000 (UTC)
Received: by mail-wr2-f39.google.com with SMTP id
 ffacd0b85a97d-48af929e59dso2987014f8f.3
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 07:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790949752; x=1791554552; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qb3iCujopSE8wIGt0Gx78GxDd4scP1isaUjBiUrVvNQ=;
 b=MyIc5aB1ukqLN/7v7QCfToRwgnZO/Kl6sP12gkHEUZZ+RKjbCwZAXpk+pZ+Pt1U8UH
 ZWdVnBxlG3J15h5xUR8BHwm8SenLyhH7ZKSyJS46RXVb5RpRKg5n4N/5jbs+91pcZpWt
 cx9MheThBroWDgbu9+up6SKgnNQzu1GFgkPsLQGnByu3cMdaZc7kZ57KOJ43GID9xaYW
 2/ETtMqpKsw9PJN7J7L4IXiAaJdYx8FuvAWkpIFLO2Yv2Q28aqak/hFbtzXF8zxKzNSu
 XPiuaWpOrN/AagqJwDKVyA8VZ0LpkbPSF6LUDgGunaPZphZeL5aKktjyPD8kSI5x6J+X
 aKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790949752; x=1791554552;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qb3iCujopSE8wIGt0Gx78GxDd4scP1isaUjBiUrVvNQ=;
 b=y6oY0z0D1vKTKEXnct7obCRpnWJ0geaIlZkbz0F1JtYzeSk+tvKcltVizNnCu65LZ8
 PKvv3tBJnO932Ch34xVWQCtYMtsqcKPLp/766kXANr++ttxLwmUjznjWQUjvsZbdmgyB
 r+wjXlz4EtorA2t5ZKHPbAWJVK4noGQYgXPuIqBR13i4RUwfMUp46tXEe8c7zxbZus/q
 CJSzL4yMAg0T8tSUN5ldEIQ9ETQJ2/jYjdnuorZ3v5Rxfg1WElmNGcaILB9PkAOge+YR
 Ea2w9D0zi2E4VeIi62Yi8TyEdTgj8kqDJ/Rm259j6Zfht/2hTd2qE5LL0Jx8MIvvaY9/
 Xt7w==
X-Forwarded-Encrypted: i=1;
 AKwUvByn+e1jgzUV1SJveoFJaUzBmLmIoNYajyL2H74pxsEUfJhKEhJC6+6At1Yx5sQX/h7fri7PUcwLjQU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKMJ4LcX1aYzrAtp/t4iWM4k8BvM1lR54WA7l5UO9PzHr3u6cW8
 PfjC1bS6vRSTIK3Zpqw1o5c+bojVJdTp1Iz1R/yV986xLm/VAbxjznq2TLr2UQ/vtbk=
X-Gm-Gg: AYBFou0I+ErWKU/xVjQf47pnFBq0QEh/jIrV99C6ZM50QyyUw16P0AFfT8X7ZPYcxqX
 iJiPWzMbssc/zMUkpSPd/XXEml7nBD97Wj/mqtY+/iWY0aP3wXN2bwkddHfDMTc/8bCy8qapv7f
 1SqDCV7TDuySF3jcjQrl6lhDlbGTZQnY7n1q7MVtQphwD+QexId06VTu34IBUh50r77DQKchRON
 xmHO7wlBiI0oGT35HKm97UFTUAuH0inFMtHyCcMuhiNNjz2vFvXlNwGl91XoqwzB4bmyT7bnXSl
 FD1t1bTCiVkOFE8lWD3TnMUWJaqvlErCSYDgvBhK5AHo4DKGnFQLS2wLRiobRcCAfaTZzNb9TkB
 wTm+CqtAz1OmGsYxsfWS+xpzOjja6OX2XjE796sczuPUyJPjUmLq6hCVwRYt5rHPb8yW2WfSbv8
 f5OF3QoxqCrSPkSoX+o0eSQKEiW9GI/F2NtT1HMm/mQugenpoKeWGNHYgRP7rE1phZR/CQdQAZA
 5FwV7cKfblgDbmZHx3cSy77guwL0nVvE+VUGpX0QHs9FRUspmw=
X-Received: by 2002:a05:6000:2287:b0:48a:f354:aefe with SMTP id
 ffacd0b85a97d-48b1274facdmr5552169f8f.39.1790949751982; 
 Fri, 02 Oct 2026 07:02:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:2f62:6d3:721b:8c9e?
 ([2a01:e0a:106d:1080:2f62:6d3:721b:8c9e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b38105239sm8006009f8f.33.2026.10.02.07.02.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2026 07:02:31 -0700 (PDT)
Message-ID: <e37d41db-5218-494e-96fe-bbf4e028763e@linaro.org>
Date: Fri, 2 Oct 2026 16:02:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] drm/panel-simple: take i2c adapter module reference
To: Johan Hovold <johan@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260716132334.1565183-1-johan@kernel.org>
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
In-Reply-To: <20260716132334.1565183-1-johan@kernel.org>
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

On 7/16/26 15:23, Johan Hovold wrote:
> The i2c subsystem currently blocks during adapter deregistration
> whenever there are consumers holding a reference.
> 
> Switch to using of_get_i2c_adapter_by_node() which also takes a
> reference to the adapter module so that an attempt to unload the module
> while in use fails gracefully instead of blocking uninterruptibly.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>   drivers/gpu/drm/panel/panel-simple.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index c09bf3db5e78..f58e83aa4ebe 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -701,7 +701,7 @@ static struct panel_simple *panel_simple_probe(struct device *dev)
>   
>   	ddc = of_parse_phandle(dev->of_node, "ddc-i2c-bus", 0);
>   	if (ddc) {
> -		panel->ddc = of_find_i2c_adapter_by_node(ddc);
> +		panel->ddc = of_get_i2c_adapter_by_node(ddc);
>   		of_node_put(ddc);
>   
>   		if (!panel->ddc)
> @@ -746,7 +746,7 @@ static struct panel_simple *panel_simple_probe(struct device *dev)
>   	pm_runtime_disable(dev);
>   free_ddc:
>   	if (panel->ddc)
> -		put_device(&panel->ddc->dev);
> +		i2c_put_adapter(panel->ddc);
>   
>   	return ERR_PTR(err);
>   }
> @@ -791,7 +791,7 @@ static void panel_simple_remove(struct device *dev)
>   	pm_runtime_dont_use_autosuspend(dev);
>   	pm_runtime_disable(dev);
>   	if (panel->ddc)
> -		put_device(&panel->ddc->dev);
> +		i2c_put_adapter(panel->ddc);
>   }
>   
>   static const struct drm_display_mode ampire_am_1280800n3tzqw_t00h_mode = {

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
