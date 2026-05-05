Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DADE2CD3427
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 13:59:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4202D10E763;
	Tue,  5 May 2026 13:59:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yimv9Kps";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EC2E10E763
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 13:59:07 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso51092225e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 06:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777989546; x=1778594346; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=5jDuJcze3P4s7VYgp+yE4jNd0LF2tgF4WZnAUmhlkIk=;
 b=yimv9Kps/rpKhuVH3sN8REA/0umiGBZWvCADbLOnRskFGn53yiN8huFIRyV//qUL7D
 RzMoroX/eoI6FP2vO+JqOkyTgyaEdpUzMk1F8Qfu0rotVv9m4q+L32IAPwiPfAcXGthE
 3+IweuYlWqPOnlJGvvi5JjbMggybbnRh8usSWlW4kVnFLu+9f9vVv3Lz0qwc2f/ty83B
 kBfTzVm2xHfGC3WBHkkaVi3l5xBfMVHFsF+Z37YFb5y5+py4Ifqg6DQofRmhFkIFnbcP
 /KVta2bLaxsy9ojP10hXUEuRME0DP9qA+DLTcgNdsNxjGcO5z9+3swk5EjMiWSEeoUvi
 cU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777989546; x=1778594346;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5jDuJcze3P4s7VYgp+yE4jNd0LF2tgF4WZnAUmhlkIk=;
 b=p0kDcdaJj7QlDNj4Z87wTcgcMevpLdXR6C0kywi7NKt//pBiWO5fCdWqFEMDeTXwhp
 gFtYPxCmEa85USBr8EWj0Nty+Cf9JSqnit6WHJ9uMgpB0x5kf3innwv8uzBUqUPZFHhJ
 vCI2Jgg/tIlTULJJAJ8cXqlphyqp65RO/pQpZStHS2rx/X364kHPwy6x5K8+uePaIocS
 a50+03mst71h8ehBtQIyPvVkWQFpUFsWaOt7Tlv2WQSQ+P6YKRnTAyeZFJzf0tXmPeBF
 d3pXTsiinkSAoa7bQa1ICD4xqUmqpbTO+rc6aHVb6symHzJkbuVGuuK2jGTIRLPbx1Cs
 Lp9Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+XgHDbduTsNZ3vHuA7dfGltIBU9WmqlFiYFb3WFC4ProjqPy4Vj2q90DjVAJJx2s7DR4Wui6uBE/4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxg5EtbVPR0Ceeou8rUpgMGbzJyzVrFrJ3nvDD1cV/32t+n7225
 ICvUP0uF6jhw3Ua4m4ly3Wu00C1CKR74sfbt/NhpeqFaqYxCsJFtQidVKHyfdUrlX28=
X-Gm-Gg: AeBDiesVSf2jeHRILMuFJlxuEaUmfYCT3NKoPDQ3TTmhiCezfGVGe1OkgjiIcI9ms0E
 XHD3wjUUqAtEcv8CYSNMrEK/5vFX25m8jCTp50c7lNLyD0ZkpfqA47YE+Gp7lnezwueoHMk/hnH
 GHvGHalDy+008uM0wteIQ8G3tKzza4U7VXn6Q5VC/SL1kAvVPkyOXx3a+rFURcB2flV07CyEhcR
 C2QSFBPl/q/XYF1O4025cY4DXWngR9b+LxcRvat9afFeUX3k0XBK7IPTnPWwPYha4MWT+IzuoRA
 SGtQ1wQKK2hsJBRaLusInlK94TaQvGqQ+k2ocTMl9USqoGLkl0aKEVwUtoeGmNf1B9XLyCnS//I
 MrVc8VYzdhj/qf+0Dv/VHZ9lcxPoHFxn/jpuc8W3dZrE6QqfkOdwD8wQ6fKxDSrzbrasVrmeo+U
 jh7MKjMUKBL21q79SiksjJhzJRcLS+3Pc4wOEps6+y5LmbueCKt1qj+0ZlnFxogPJ9vVdueCbtq
 3XepAXKpFQii6FC56xzIytZEome
X-Received: by 2002:a05:600c:c094:b0:48d:5c1:bc3b with SMTP id
 5b1f17b1804b1-48d18cef847mr40114605e9.24.1777989545455; 
 Tue, 05 May 2026 06:59:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:19a4:dd04:854d:9f82?
 ([2a01:e0a:106d:1080:19a4:dd04:854d:9f82])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48d181efbdfsm17724765e9.25.2026.05.05.06.59.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 06:59:05 -0700 (PDT)
Message-ID: <e2c0d1a3-9023-423f-b784-32f55cc859b7@linaro.org>
Date: Tue, 5 May 2026 15:59:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 4/4] drm/panel: Enable GPIOLIB for panels which uses
 functions from it
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
 <20260505-panel-clean-up-kconfig-dep-v2-4-9cc31d6e6919@ixit.cz>
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
In-Reply-To: <20260505-panel-clean-up-kconfig-dep-v2-4-9cc31d6e6919@ixit.cz>
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

On 5/5/26 15:53, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> These panels used on sdm845 devices are using GPIOLIB functions,
> ensure it's enabled.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>   drivers/gpu/drm/panel/Kconfig | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index 9360297ee99e5..268b45d4b82f5 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -102,16 +102,17 @@ config DRM_PANEL_BOE_TV101WUM_LL2
>   	depends on DRM_MIPI_DSI
>   	depends on BACKLIGHT_CLASS_DEVICE
>   	help
>   	  Say Y here if you want to support for BOE TV101WUM-LL2
>   	  WUXGA PANEL DSI Video Mode panel
>   
>   config DRM_PANEL_EBBG_FT8719
>   	tristate "EBBG FT8719 panel driver"
> +	depends on GPIOLIB
>   	depends on OF
>   	depends on DRM_MIPI_DSI
>   	depends on BACKLIGHT_CLASS_DEVICE
>   	help
>   	  Say Y here if you want to enable support for the EBBG FT8719
>   	  video mode panel. Mainly found on Xiaomi Poco F1 mobile phone.
>   	  The panel has a resolution of 1080x2246. It provides a MIPI DSI
>   	  interface to the host.
> @@ -339,17 +340,18 @@ config DRM_PANEL_JADARD_JD9365DA_H3
>   	depends on BACKLIGHT_CLASS_DEVICE
>   	help
>   	  Say Y here if you want to enable support for Jadard JD9365DA-H3
>   	  WXGA MIPI DSI panel. The panel support TFT dot matrix LCD with
>   	  800RGBx1280 dots at maximum.
>   
>   config DRM_PANEL_JDI_LPM102A188A
>   	tristate "JDI LPM102A188A DSI panel"
> -	depends on OF && GPIOLIB
> +	depends on GPIOLIB
> +	depends on OF
>   	depends on DRM_MIPI_DSI
>   	depends on BACKLIGHT_CLASS_DEVICE
>   	help
>   	  Say Y here if you want to enable support for JDI LPM102A188A DSI
>   	  command mode panel as found in Google Pixel C devices.
>   	  The panel has a 2560×1800 resolution. It provides a MIPI DSI interface
>   	  to the host.
>   
> @@ -454,16 +456,17 @@ config DRM_PANEL_LG_LG4573
>   	depends on OF && SPI
>   	select VIDEOMODE_HELPERS
>   	help
>   	  Say Y here if you want to enable support for LG4573 RGB panel.
>   	  To compile this driver as a module, choose M here.
>   
>   config DRM_PANEL_LG_SW43408
>   	tristate "LG SW43408 panel"
> +	depends on GPIOLIB
>   	depends on OF
>   	depends on DRM_MIPI_DSI
>   	depends on BACKLIGHT_CLASS_DEVICE
>   	select DRM_DISPLAY_DSC_HELPER
>   	select DRM_DISPLAY_HELPER
>   	help
>   	  Say Y here if you want to enable support for LG sw43408 panel.
>   	  The panel has a 1080x2160@60Hz resolution and uses 24 bit RGB per
> @@ -579,26 +582,28 @@ config DRM_PANEL_NOVATEK_NT36523
>   	depends on BACKLIGHT_CLASS_DEVICE
>   	help
>   	  Say Y here if you want to enable support for the panels built
>   	  around the Novatek NT36523 display controller, such as some
>   	  Boe panels used in Xiaomi Mi Pad 5 and 5 Pro tablets.
>   
>   config DRM_PANEL_NOVATEK_NT36672A
>   	tristate "Novatek NT36672A DSI panel"
> +	depends on GPIOLIB
>   	depends on OF
>   	depends on DRM_MIPI_DSI
>   	depends on BACKLIGHT_CLASS_DEVICE
>   	help
>   	  Say Y here if you want to enable support for the panels built
>   	  around the Novatek NT36672A display controller, such as some
>   	  Tianma panels used in a few Xiaomi Poco F1 mobile phones.
>   
>   config DRM_PANEL_NOVATEK_NT36672E
>   	tristate "Novatek NT36672E DSI panel"
> +	depends on GPIOLIB
>   	depends on OF
>   	depends on DRM_MIPI_DSI
>   	depends on BACKLIGHT_CLASS_DEVICE
>   	help
>   	  Say Y here if you want to enable support for Novatek NT36672E DSI Video Mode
>   	  LCD panel module. The panel has a resolution of 1080x2408 and uses 24 bit
>   	  RGB per pixel.
>   
> @@ -726,17 +731,18 @@ config DRM_PANEL_RAYDIUM_RM692E5
>   	select DRM_DISPLAY_DSC_HELPER
>   	select DRM_DISPLAY_HELPER
>   	help
>   	  Say Y here if you want to enable support for Raydium RM692E5-based
>   	  display panels, such as the one found in the Fairphone 5 smartphone.
>   
>   config DRM_PANEL_RAYDIUM_RM69380
>   	tristate "Raydium RM69380-based DSI panel"
> -	depends on OF && GPIOLIB
> +	depends on GPIOLIB
> +	depends on OF
>   	depends on DRM_MIPI_DSI
>   	depends on BACKLIGHT_CLASS_DEVICE
>   	help
>   	  Say Y here if you want to enable support for Raydium RM69380-based
>   	  display panels.
>   
>   	  This panel controller can be found in the Lenovo Xiaoxin Pad Pro 2021
>   	  in combination with an EDO OLED panel.
> @@ -1251,16 +1257,17 @@ config DRM_PANEL_VISIONOX_R66451
>   	select DRM_DISPLAY_DSC_HELPER
>   	select DRM_DISPLAY_HELPER
>   	help
>   	  Say Y here if you want to enable support for Visionox
>   	  R66451 1080x2340 AMOLED DSI panel.
>   
>   config DRM_PANEL_VISIONOX_RM69299
>   	tristate "Visionox RM69299"
> +	depends on GPIOLIB
>   	depends on OF
>   	depends on DRM_MIPI_DSI
>   	depends on BACKLIGHT_CLASS_DEVICE
>   	help
>   	  Say Y here if you want to enable support for Visionox
>   	  RM69299  DSI Video Mode panel.
>   
>   config DRM_PANEL_VISIONOX_RM692E5
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
