Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28481FE51F2
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 09:32:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87BAB10F47C;
	Fri, 24 Apr 2026 09:32:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VRK/wNDY";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CFB410F47D
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 09:32:05 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-43fe3e22e33so4967380f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 02:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777023124; x=1777627924; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=5X+knTsCdbNBxq4XMgOAP3PZXLW1KWDABPAEfaBV/tc=;
 b=VRK/wNDYwcFx95vCS4IiT9EyRq1q3Od/8Iqva0Z0m4u5L+tCnVb9zkuxmgbhG3nraX
 AXuAFnTU3PdEd+CfoYT21HOGzeyf174reDwqRoLrqFWfiwdIcAo5uzcZvenXsx7NcD50
 KCtfYcWrHTUubMM5zpgGognOX3kHm7YwmktfIZsdiFleaCQZux+HpjPW3AmTeQPbhXG+
 7K/rR0ivsoXnBpLvAi6Jg04UxfdNSEAb4PEMIQhCh7ruRY24F9V4SdqsWJSN11HT1cim
 wSsRYwJ3HKvbA7lnCECqaqaD5mzmsPHCNoE+mm3bFLJfjw/+sEIregSdlHM+MonLnKb0
 Ggmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777023124; x=1777627924;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5X+knTsCdbNBxq4XMgOAP3PZXLW1KWDABPAEfaBV/tc=;
 b=Plc7GT/0iXMO5Yrqv/YhmcBK0dGNeL0cEeFJ3lavi7SZuC6jrmt/lk5TDYXqBoFV2P
 YDNPg4caAqEQyHE9fN79fuCudvqWBf/uLcXWI6CeV9e0Nq70xg3RckJ+/77x0Qxd4mGs
 jnbuQ4a/eWj2UBeD7Q4wKXEjixgLgItCaWBoVxww6iNnSek1Px+VKN5XPI83trQ+7odl
 9UA+1dAm+x7feqIMCMDDz7A86CUDSHwFBJNtw48YuEPq5VYFS20MYkoIc4wo1BNM0ldI
 F09ymrPJlumUj80aqkElEqSZjkphhdQaqwMK/KA5hQAaWh6QeWxiOoZqO93DbQEQenCE
 fCRw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/A8DB+VjhCD105AFt+u+uNC6VrQrh9sznkm/w8kT35h+5yA4j97QXvieAf7UlaVmw9B0yqooVCe2g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw+lJ+ofSTxZ/E37YmHV/Y7H1haSO+PolIBUhw7quMkl/yP8m3F
 QTZ+wnBaQus4KMQTYqxqSbuPYatjpNYC2unZVONF3kKvD4gsKZL+pI2Kk9TCGnlHnTw=
X-Gm-Gg: AeBDiev+jOp0MgzxFAVFr2oIOWukobaK7XlLTIzXx9QoKMuFWKuDciC72mhmQEgh6Ap
 l5lN89vN5ttHH/Av/6ZmW/AKt630nE73HJbvk/+Mz9nJwcOLk/FUGwYEV5VbG1iTbwQSbbWG9Kb
 +mxRHtEyY95JyhQow0mvoyZAi7KsPGYRf6NLY184H0UQIHeMeBhr+O2XiySKYEPYmf0GzjedUfp
 0BEY5Hh+jOCdOwiWr4sZalv47SYHRNasOI/luFV8y+TQNFr3UxNrV8R+k2CKdWUsSALXkUnairr
 avr5QqjmXNrtIqhDOuDVxfGFv/6OfzDyMBGjCUYRQgkPVnB2z2SJlPd5rqf0RNo7RdzMn/fnPqC
 VDnyNcsYvzKGJyORmIeDtKK99o3BpMwCQe/h2Kz6CA/2el3D6f5mc5lVGOwcy1L/7M8Amocfy8d
 2MaHKhEsMK2iCLQVjO3kb8TC3IfTMfV5rGKNleSVtF6oCybFl7gsS5ayPc+t4yeT9ExS3/8povs
 znAIYK1/UxwxWOJUw==
X-Received: by 2002:a05:6000:61e:b0:43d:6fb7:fee2 with SMTP id
 ffacd0b85a97d-43fe3e20b32mr51416716f8f.45.1777023123349; 
 Fri, 24 Apr 2026 02:32:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:79e1:f56b:445c:ca9c?
 ([2a01:e0a:106d:1080:79e1:f56b:445c:ca9c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cc0f31sm58644023f8f.12.2026.04.24.02.32.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2026 02:32:02 -0700 (PDT)
Message-ID: <ebe54ec7-9cf2-4243-a616-34b18c50fd57@linaro.org>
Date: Fri, 24 Apr 2026 11:32:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RESEND 2/4] drm/panel: Clean up S6E3FC2X01 config
 dependencies
To: david@ixit.cz, Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: Casey Connolly <casey.connolly@linaro.org>,
 marijn.suijten@somainline.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org
References: <20260422-panel-clean-up-kconfig-dep-v1-0-d825e9ffe911@ixit.cz>
 <20260422-panel-clean-up-kconfig-dep-v1-2-d825e9ffe911@ixit.cz>
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
In-Reply-To: <20260422-panel-clean-up-kconfig-dep-v1-2-d825e9ffe911@ixit.cz>
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

On 4/22/26 11:48, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> As per the config name this Display IC features a DSI command-mode
> interface (or the command to switch to video mode is not
> known/documented) and does not use any of the video-mode helper
> utilities, hence should not select VIDEOMODE_HELPERS.  In addition it
> uses devm_gpiod_get() and related functions from GPIOLIB.
> 
> Fixes: 88148c30ef26 ("drm/panel: Add Samsung S6E3FC2X01 DDIC with AMS641RW panel")
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>   drivers/gpu/drm/panel/Kconfig | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index 2fd3222ba2e3b..a81ea7755c03f 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -825,20 +825,19 @@ config DRM_PANEL_SAMSUNG_S6D7AA0
>   	tristate "Samsung S6D7AA0 MIPI-DSI video mode panel controller"
>   	depends on OF
>   	depends on BACKLIGHT_CLASS_DEVICE
>   	select DRM_MIPI_DSI
>   	select VIDEOMODE_HELPERS
>   
>   config DRM_PANEL_SAMSUNG_S6E3FC2X01
>   	tristate "Samsung S6E3FC2X01 DSI panel controller"
> -	depends on OF
> +	depends on OF && GPIOLIB

Why OF && GPIOLIB and not on separate depends ?

>   	depends on DRM_MIPI_DSI
>   	depends on BACKLIGHT_CLASS_DEVICE
> -	select VIDEOMODE_HELPERS
>   	help
>   	  Say Y or M here if you want to enable support for the
>   	  Samsung S6E3FC2 DDIC and connected MIPI DSI panel.
>   	  Currently supported panels:
>   
>   	    Samsung AMS641RW (found in the OnePlus 6T smartphone)
>   
>   config DRM_PANEL_SAMSUNG_S6E3HA2
> 

