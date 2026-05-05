Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54AF7FF8855
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 13:58:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD65110E402;
	Tue,  5 May 2026 13:58:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BSFTgUVS";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FABE10E402
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 13:58:40 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so83853335e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 06:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777989519; x=1778594319; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=wTqqIiWh7w88CXO/27dveUeDNrBn2mFq5ALoevEOCPc=;
 b=BSFTgUVSJ9vPup0dl7OOWOcGIEBZL64/MHwfOjfkU5BTMlFNNKZTlSEgApGSsns2GC
 341Ivy7kEEcIPOvF9PcW3tR+XExscKTC8tFsLHpGjM6FwZPhz9ZeTm2umU8/XdqCkvu+
 j40QvhmF+DWUgyZ7pQ2Os1BaYRN9XKzbI/BHM917AElJJplSQ6v3cJnE7S3Tb1Nj1ZpD
 KeVjG2IKvhwHiGEjMiVSzRWZ8eGmCaa+XzNtNAVIsm1GIfXVF99uCl7AlPoDivRzASeB
 c/bEW2Z01Jcqo0HFRpflp3Lmf4/Bh74WyRDpFgyWaYzuWJosdKUQW466ZrrGS0Co3K1l
 NdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777989519; x=1778594319;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wTqqIiWh7w88CXO/27dveUeDNrBn2mFq5ALoevEOCPc=;
 b=DZGPj/QsL0uHvuMxvxU4q1e3itDrvyIH6WqLy4nAjhYUhCBNOwmA3He5of9iMwVF7O
 l4HOoDc/78BcIg0VAM1MBbXUZ45G/nFmlolaV02s0l5Q9gVQfHJkBwWQbKq/5UIljfEx
 7nb8Gb9YPgLA5XY/RZw48R8zXlW9Vsa8G/gf11drWGCd0alHj/MM1VugTSvyfX8Uvmhb
 jSLQauwZeIAC+v8K+SuweBPLSUfooUoL1myJl9n2Jrh4b6gQLkuhSQOXItLNdGPxAtaV
 nXV+WZtVMXsM7ItAmRNwRR6OnaHzANitcsceHqSsvd9jic/igKhZN0rfn9ekCgSO2KTY
 uKjw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ksKbzO6gnWXuTl4UoxwpWQyA8yklpdx4mUNSBwRpLPKx7TPw+RqTha7qcMXs9dtI4VB6tFTvZPdc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw7GtXbKBQxn16C1l+b9R5AmVpblW0Wl3xVn0VveU/dLMTdBwzo
 quF4O4RBawsPTUpG/bRaIiMXf8Mgxl8DXltkKc97DpVmQwbcAiXvb6/eV80iGa0fBVg=
X-Gm-Gg: AeBDiet9FHlncv7ykCvLBrPpvfwYHbmtPmu21u3yVzztmcZgmFXDbe9gUE1FnqRAfd8
 882PMf2PRvmy1vbZ6Il6Xn/kCViYYMq/tQg/3xJw0lykFBRIcKXzquwX1/LF1jzVvjrec2GMoyU
 4xCkQ2+4tUVUb9PN+1/ZgmdtnmPlWm8HftpsMf/CX1YUR7xMQlpHA4oSmTGGGKzgrfBYEI00CID
 ELsmr0YuyqIbwo0xnbZpkwDN37IsMIXPgY1L8fvS8wzf4+o2XXc12YnbmEYdVL6lhyv5T2jIrKL
 11bUzgkCbCKbQnRTIWVGVnmd5ay1nlC1MXdSF6IQFPSyNtYpNywDG8mZKHHw7n+2659aDo9nVnR
 ZuLTEMkpqinVBwmjC9T2mfwLJ/53wFTVWxuyQTc18zu0xcqdMPIeM+zFKFlro/lTsmQG+d/nfUH
 dSRYeVc6X0ROsT+pKwaZ9gvXrqtYHnFcjZdl1OFXhN+lF+Rw9x0Nw0TlenD++5q90XaErGpmttY
 OIe3Ytajw5P2WRlrw==
X-Received: by 2002:a05:600c:c0c2:b0:48a:65a5:750f with SMTP id
 5b1f17b1804b1-48a98668f0emr180192745e9.21.1777989518513; 
 Tue, 05 May 2026 06:58:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:19a4:dd04:854d:9f82?
 ([2a01:e0a:106d:1080:19a4:dd04:854d:9f82])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48d14a12ccesm20531225e9.8.2026.05.05.06.58.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 06:58:38 -0700 (PDT)
Message-ID: <eeafc3ee-ab61-4666-8e65-600c566ec1b1@linaro.org>
Date: Tue, 5 May 2026 15:58:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 2/4] drm/panel: Clean up S6E3FC2X01 config dependencies
To: david@ixit.cz, Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: Casey Connolly <casey.connolly@linaro.org>,
 marijn.suijten@somainline.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org
References: <20260505-panel-clean-up-kconfig-dep-v2-0-9cc31d6e6919@ixit.cz>
 <20260505-panel-clean-up-kconfig-dep-v2-2-9cc31d6e6919@ixit.cz>
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
In-Reply-To: <20260505-panel-clean-up-kconfig-dep-v2-2-9cc31d6e6919@ixit.cz>
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

On 5/5/26 15:53, David Heidelberg via B4 Relay wrote:
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
>   drivers/gpu/drm/panel/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index 627b839ac9edb..813380ca76117 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -884,20 +884,20 @@ config DRM_PANEL_SAMSUNG_S6D7AA0
>   	tristate "Samsung S6D7AA0 MIPI-DSI video mode panel controller"
>   	depends on OF
>   	depends on BACKLIGHT_CLASS_DEVICE
>   	select DRM_MIPI_DSI
>   	select VIDEOMODE_HELPERS
>   
>   config DRM_PANEL_SAMSUNG_S6E3FC2X01
>   	tristate "Samsung S6E3FC2X01 DSI panel controller"
> +	depends on GPIOLIB
>   	depends on OF
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

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
