Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC6BFF8855
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 13:58:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D429110E461;
	Tue,  5 May 2026 13:58:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ASyOUAyi";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C18610E461
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 13:58:53 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso63228325e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 06:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777989532; x=1778594332; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=iEThy3ceEM1qRBHeltl9ycUnSvR4lD90NN2PoprYdj4=;
 b=ASyOUAyiV6cG8HuAPicQHgWjjgF4F/4iiUTjjLJ0ny7LlPXfzDc/iMR12XtCVoS43O
 ara7Dm2bBqSKh+B1ntgidipgJ53W1DTz1NH+/PL3A9QdxusKNS+1GwTYe0E+cdlnQ5Q/
 uza5CiPZ3glzGjJVDBBpswwv0a2A6rPNq/4bCvLm9d/ZqfUTzqAcFsgPfIgIILmkL9Q3
 +wy5MpKv2HohSlCux/HIHQifwpLIUXi0kOleAFfvjvMs5Z1xQwnc2RYkq4idA93VI7l/
 pJ+qoxn330qsm5LKEi8XDONb0BXdksme6AMM3rNRzzT1ZJrQwI69hgArSz6djtRPOS/5
 7E2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777989532; x=1778594332;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iEThy3ceEM1qRBHeltl9ycUnSvR4lD90NN2PoprYdj4=;
 b=BAjidXKQFhP1DjccXSi+Qm00/VwNuiRxUCwVP6gJdl/Pilp7PLl3hpTtg3uWnw1v2g
 O5agq7KtA8UBaY/SfGSc/wTg02O2WPvYaRZmQuWwqrQdWoUHLP3LYFon3TCN0yk6g1aY
 tjst+RqN1b108kUbD9iSYe0ZH0Bv7jroQ67drhXFdd15umwDaGSogNHE/dDDru5S8XcZ
 fYYTGGKVDajNIs2BBJyGp+R1dOAdK0nE3ZMWbbUWFNzULIR/1LQ4akMMM/+yjm1mihMV
 +Ks+XypnLuX/QMXgd8o9evV/rOXA8J2Jya5ccOHOiWIQ3xdpIGdVz41E1KTXvPHOCN+K
 f+0g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ZU9o0QsSKwVkPSjQ+CWAhRowPJTl6VzyS0riu1z3MBYZUHC51rAZhuEEODcnE2de0+wG5n51Lrxw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxWgTGZW29YD6auBs86GNmFE0asTEUokD5+adrE4k2zSoCnCeXx
 vvuxf4Bkt6Nk72MF795MEBpyPYLUmcfLCzPI0rt3yrr7s68LX3PkgJvlrv4tQMarObI=
X-Gm-Gg: AeBDietl9/3pUiZcWLk692fOkCtVRnkhaZ3VU6JNooDEJh38XBPlsx5xGNcsqhO0q+V
 dDNtETlQxhLeUMyx+RQenaDbrMFKHQBzn+4anPzxqMhLltpmM/+vYsPX7Bn/6J6dIELJibburon
 eMsr2E9IZe6QcRas0QiDNEIafCERhu9PMvoPJkdpukD/dyBzZqSQ7KRDJ4qxR4q+nQ8sIJ5V5RX
 IuXoZ5weQy7CyuUYxwgwZkP3SdQUNr1J1cu946AjyXH9Qy/GM5Ln6wjFzEPhzDscd7O0+inqBf9
 M7kVJhX9FntkMKlpWxjFs3vH28pZ8z/M6bDpPMs3mcspAJaYz5Nl/tpkfbJWE8K3pJNhUzO5aBy
 EikvzL7ZeMKAuyG7ZuG3QB+E0vu/cHalUVsbV4yg5OJ4sN13Wq9bj8GA+w7Lc8iYhxoAJJNs/Jg
 e/svRQKffy2WjZl/vk/cvOesIHLcQuwaPyBy1j1bDlhga/qmuumhHCHQLzIUgg0WUenSrY9G5nB
 K0ncvFzAdrutNp05w==
X-Received: by 2002:a05:600c:4b16:b0:489:e696:836f with SMTP id
 5b1f17b1804b1-48bcc9f32f3mr131446495e9.10.1777989531558; 
 Tue, 05 May 2026 06:58:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:19a4:dd04:854d:9f82?
 ([2a01:e0a:106d:1080:19a4:dd04:854d:9f82])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48d181efbdfsm17720105e9.25.2026.05.05.06.58.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 06:58:50 -0700 (PDT)
Message-ID: <f47be60b-5629-4536-89ee-6d033e21fe20@linaro.org>
Date: Tue, 5 May 2026 15:58:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 3/4] drm/panel: Clean up S6E3HA2 config dependencies
 and fill help text
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
 <20260505-panel-clean-up-kconfig-dep-v2-3-9cc31d6e6919@ixit.cz>
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
In-Reply-To: <20260505-panel-clean-up-kconfig-dep-v2-3-9cc31d6e6919@ixit.cz>
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
> utilities, hence should not select VIDEOMODE_HELPERS. In addition it
> uses devm_gpiod_get() and related functions from GPIOLIB.
> 
> Fixes: 779679d3c164 ("drm/panel: Add support for S6E3HA8 panel driver")
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>   drivers/gpu/drm/panel/Kconfig | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index 813380ca76117..9360297ee99e5 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -904,21 +904,28 @@ config DRM_PANEL_SAMSUNG_S6E3HA2
>   	tristate "Samsung S6E3HA2 DSI video mode panel"
>   	depends on OF
>   	depends on DRM_MIPI_DSI
>   	depends on BACKLIGHT_CLASS_DEVICE
>   	select VIDEOMODE_HELPERS
>   
>   config DRM_PANEL_SAMSUNG_S6E3HA8
>   	tristate "Samsung S6E3HA8 DSI video mode panel"
> +	depends on GPIOLIB
>   	depends on OF
>   	depends on DRM_MIPI_DSI
>   	depends on BACKLIGHT_CLASS_DEVICE
>   	select DRM_DISPLAY_DSC_HELPER
> -	select VIDEOMODE_HELPERS
> +	help
> +	  Say Y or M here if you want to enable support for the
> +	  Samsung S6E3HA8 DDIC and connected MIPI DSI panel.
> +	  Currently supported panels:
> +
> +	    Samsung AMB577PX01 (found in the Samsung S9 smartphone)
> +
>   
>   config DRM_PANEL_SAMSUNG_S6E63J0X03
>   	tristate "Samsung S6E63J0X03 DSI command mode panel"
>   	depends on OF
>   	depends on DRM_MIPI_DSI
>   	depends on BACKLIGHT_CLASS_DEVICE
>   	select VIDEOMODE_HELPERS
>   
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
