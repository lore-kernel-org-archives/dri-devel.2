Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61ED2CD3439
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 15:35:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1D8510E58B;
	Thu,  7 May 2026 15:35:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ilHafS1H";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0260410E58B
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 15:35:02 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-488ba840146so9356675e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 08:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778168101; x=1778772901; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=qviuCjYgg89dp4Zj0iDLZr+bYb7DPV34z48Pa7dHTMc=;
 b=ilHafS1HcFvsT+T1zlRjYQ9LaVhKsizM6nW3XHZbwfFF7O6X//JRxKg4aLBWOCOl8m
 8Gbi7VrKq6db+fDWB6b8M8uW+B0v9HFD0Bjyr+LhgroMLVX9F+dmPBT/2bikr9C6Co0+
 uuvs24SDerqT58F2Oj1RvjdVzEHwMBRkfpUKfrFNkCy5LpH1UYV7wDIUmtSwK1cFYwCE
 fw8OT9uo19ZNVDdMomWRWjKE1pIjOXdNdophutraBZDRxF0XiZvTnyLsF8fovbdB1ygs
 2FlbfLjWDqMn7q7LIcJyoUgHTbufJQhuhrhyTIBnd8fYOWJMEXYUSS0HvYN2I/xx6RFc
 xevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778168101; x=1778772901;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qviuCjYgg89dp4Zj0iDLZr+bYb7DPV34z48Pa7dHTMc=;
 b=M6AJXvB3zwaHCOfRA/hblB8XLmjcRfy6EbO52klXXadFqcBiCRuHtvAzxVeqqK51al
 ogKJ+lbl3xDuS8hOT5v0bvmsm5/oZwk6j/j3pH1Ci0mBDx0Mns3eJRiOtMqCMs66q/zF
 XG0PE7wbjhIuZhuAoxnj9iadkYCpevlHBhox0cRhrDUhDv4QefS66hP9z+la5J83rjTA
 1Zfe1+S3szPjpha2HVFLqRTgLRtMttqH808L4ESxl1Q7EWjEMDolyO0nrCskfP6FZb1d
 DLjGR2ZXq9cm3s+fT6WmufjOvadL7pLaEv2wh4HfYEwZu/3ieHtS+a8uQOJJPCu4W/Wx
 Jk2A==
X-Gm-Message-State: AOJu0Yx3JsFT9TphbPvtZbf6Z4SdoU3W8KYk/KW5TzBYFa6VDOuMWq2j
 /gLsZ5JxpZ8X8eIOCwshS/ctkVicunS9yLalSou3r5I/edWLVBtmt4GGT7pzcguEVP0=
X-Gm-Gg: AeBDieuazdsyzuQihEBZELn1TN7keOrx24DIFxAqn8Rm2eQEPMJ+zdO1vnlp/Vjuvt0
 Ibk8pyd4IaYgVNTEdtfVqh4wCnLczMLqKfMJH9PM8pG7SJBnkuWF195gHF8el3nXONjuT/xaMXP
 DbYe5TpG1j+jvgguINAcH8HDoy2tsKMZ08G80BVuFIML2VEJo0LLLDeIQ/hWj0oR/ZJ/s9Oe6gR
 php9IcxYymSPq64e/Hr283f/uaNetEEoF2IB6XlKRs93huJJbmIZ9mrtFR/uJTfiuFIfxyW2/9l
 7nMMdEJUwAzmQ+RzbUnnRlQ91rxFUrlKtt+Jppp3W/AzESxz4kU8w1NgTQmpERkwLwdR/Upt3El
 m5q4wZdn9mOcZ6YNuv2ovra9M5LEkpvY2NKIC/2xXFhk6Rv+/7Pu5z749/K4tiYQa0X7fCy7MuZ
 Agul6f5192BUOYcfWlnKV63WyKxyry5+EVD2VIddENh8fn+R0xKRjkagCSD5P3YomXCw4p5Lo1N
 DaOM53KX4mxYt4/EA==
X-Received: by 2002:a05:600c:a110:b0:488:9e43:9690 with SMTP id
 5b1f17b1804b1-48e51e17746mr108372715e9.10.1778168101138; 
 Thu, 07 May 2026 08:35:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:6762:47bb:1e06:ff70?
 ([2a01:e0a:106d:1080:6762:47bb:1e06:ff70])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538a8159sm140909335e9.6.2026.05.07.08.35.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 08:35:00 -0700 (PDT)
Message-ID: <8e401d8a-728d-447a-b647-b21da6849ea7@linaro.org>
Date: Thu, 7 May 2026 17:35:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 02/10] drm/panel/samsung-s6e63m0: Use refcounted
 allocation in place of devm_kzalloc()
To: Albert Esteve <aesteve@redhat.com>, Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Michael Tretter <m.tretter@pengutronix.de>, Michael Walle
 <mwalle@kernel.org>, Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260507-drm_panel_init_rm-v1-0-51f448c7c291@redhat.com>
 <20260507-drm_panel_init_rm-v1-2-51f448c7c291@redhat.com>
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
In-Reply-To: <20260507-drm_panel_init_rm-v1-2-51f448c7c291@redhat.com>
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
>   drivers/gpu/drm/panel/panel-samsung-s6e63m0.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c b/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
> index ea241c89593b6..997115b1e541d 100644
> --- a/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
> +++ b/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
> @@ -677,9 +677,13 @@ int s6e63m0_probe(struct device *dev, void *trsp,
>   	u32 max_brightness;
>   	int ret;
>   
> -	ctx = devm_kzalloc(dev, sizeof(struct s6e63m0), GFP_KERNEL);
> -	if (!ctx)
> -		return -ENOMEM;
> +	ctx = devm_drm_panel_alloc(dev, __typeof(*ctx), panel,
> +				  &s6e63m0_drm_funcs,
> +				  dsi_mode ? DRM_MODE_CONNECTOR_DSI :
> +				  DRM_MODE_CONNECTOR_DPI);
> +
> +	if (IS_ERR(ctx))
> +		return PTR_ERR(ctx);
>   
>   	ctx->transport_data = trsp;
>   	ctx->dsi_mode = dsi_mode;
> @@ -712,10 +716,6 @@ int s6e63m0_probe(struct device *dev, void *trsp,
>   		return PTR_ERR(ctx->reset_gpio);
>   	}
>   
> -	drm_panel_init(&ctx->panel, dev, &s6e63m0_drm_funcs,
> -		       dsi_mode ? DRM_MODE_CONNECTOR_DSI :
> -		       DRM_MODE_CONNECTOR_DPI);
> -
>   	ret = s6e63m0_backlight_register(ctx, max_brightness);
>   	if (ret < 0)
>   		return ret;
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
