Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A137CD4F4A
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 14:00:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFAF510E84F;
	Mon, 18 May 2026 14:00:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="N5j4/Y6R";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0338810E84F
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 14:00:30 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso24155335e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 07:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779112828; x=1779717628; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=xSzdDCalKroiZkrBK5EAjSSCAceaufgt8kCZ3umG54s=;
 b=N5j4/Y6RJ2Y/CCBZspIxnA5YUdvEY+V2yVMDcnl2I6zrpKSLGgByrsmJQOBbYh7vNL
 2zSF6WKhf9s6onwZ97HNXuAP7wSjbh+Fdk0Upxb/kgJkrIMJ766HyXaDnz1jUFjKmlzT
 rYLzD/RWSLgJxmVL9w51SFjh7mL0pYc++2Rx/cBO9TH7116/PlIaFIeV3/KTpfTFJfnl
 beO/LN1rFAq5qpMo49nqbYGEgT+OCyAhVuCOu5PMoLVpusXO7sUXyGCdR1c0RSDKd8/f
 dwTQoCF0lHZJ0Gvk0bld6JxOlBm7o+XaKPqC3LUZXfnsB9/AqI4kv4apP8XdH7FgJYFP
 4D7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779112828; x=1779717628;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xSzdDCalKroiZkrBK5EAjSSCAceaufgt8kCZ3umG54s=;
 b=bheZk/QJg7cFSQti9JDiq3zFVyWQx+BJuirKLmUiPZKXfa0w26UN2XszCYYsAplVBX
 iNc16AGYXQPjHqgQ5D2Nqm+9UYZ5FpE4JeY4Oh9YL7fyBKuoCXG1QuLIwYqpvnOnUbH3
 47Jk3edykRWHW4ob3TIP9SJqtWz2VMcyzyWuGcusOp59ISZRQYMsZgYEjW1fRP7pIwx/
 brnfywxHVUL7ruihMZpJb+5LZ15EcHrdHy5w2UQk01pd0begQJj187Ky/IN5ahDet1Nl
 C1gVhPT9vHlkAnYwYDva1dfAwp7EvCgaqdqcjFWGt91sDbwEuq7zYIFWVGq7vLnDwDO0
 t5hg==
X-Gm-Message-State: AOJu0YwT/cGd/67gUxFLw7Ls0Kt8XW5mXhXBB2AFAkkizxTlcVEJLkjN
 lrr4pCg5l6K6/smp1uMo+ss76uJC0m3oRrWptJnqsxvXeJ9SNAHzG2kRK6FWfTzgxzg=
X-Gm-Gg: Acq92OG7sCbrM3g5uqPqBIelgPYvlokzehLod8tsY55eU+HaFGmG1wvOcPKmrC+hjcu
 SB9+8dsoMDwmKHzHZlv12XzV1qhTC1f5uLnP/fE/pLnUQ8ThhT6+xpjOPntmG/gmhHtNue6UvH1
 XHE8ILZ8oJG2LrXT9gTrFiy/sVhsG9Ut3IBncKVU+jVbFhskzNCrrUl/QGjgIjv7HixrSxHcjq5
 7XkVmQWVLQUxj71Pi2nrFM5GgiKLDDLiZYtugOrwM6otyZvlKJlu+gOAWN300T61xgp4JHsI6aP
 2+KATuOEgb/LxGUaW+WOCLUHHkUNi2KEXx+MpWQbfDr9jrUPywrm24+jUxL38JgfFTqe4i8cZgY
 R/2VOr7u5FkC++oYpwNYOnuu+xko6+BMBVwF4OHI/zeUgtCqlNn0AV6D0lkYHDigiSKoup2rPbJ
 ScRoKPnR31B2QqZf/PZXw16blc/JWGv9grQss80uoWfPrmdbnfS1Cf8IYOZEgx86zr3QAq2Cthe
 cCB4Pc=
X-Received: by 2002:a05:600d:8:b0:48f:e6b9:c740 with SMTP id
 5b1f17b1804b1-48fe6b9c811mr201655935e9.30.1779112828111; 
 Mon, 18 May 2026 07:00:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:1029:e3c5:362e:1250?
 ([2a01:e0a:106d:1080:1029:e3c5:362e:1250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ed2f738sm36982077f8f.16.2026.05.18.07.00.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 07:00:27 -0700 (PDT)
Message-ID: <4d7d7ab9-5c68-4edd-a6ce-cee7b7726ca0@linaro.org>
Date: Mon, 18 May 2026 16:00:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 2/2] drm/panel: simple: add NEC NL6448BC33-70C
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding
 <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260515-v7-1-topic-panel-simple-nl6448bc33-v2-0-74ab0baa1817@pengutronix.de>
 <20260515-v7-1-topic-panel-simple-nl6448bc33-v2-2-74ab0baa1817@pengutronix.de>
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
In-Reply-To: <20260515-v7-1-topic-panel-simple-nl6448bc33-v2-2-74ab0baa1817@pengutronix.de>
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

On 5/15/26 13:46, Steffen Trumtrar wrote:
> Add NEC NL6448BC33-70C 10.4" 640x480 LCD module support.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>   drivers/gpu/drm/panel/panel-simple.c | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 236bd56208ccf..dca6cbc41bd9f 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -3659,6 +3659,32 @@ static const struct panel_desc nec_nl4827hc19_05b = {
>   	.bus_flags = DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE,
>   };
>   
> +static const struct drm_display_mode nec_nl6448bc33_70c_mode = {
> +	.clock = 25175,
> +	.hdisplay = 640,
> +	.hsync_start = 640 + 16,
> +	.hsync_end = 640 + 16 + 48,
> +	.htotal = 640 + 16 + 48 + 96,
> +	.vdisplay = 480,
> +	.vsync_start = 480 + 2,
> +	.vsync_end = 480 + 2 + 31,
> +	.vtotal = 480 + 2 + 31 + 31,
> +	.flags = DRM_MODE_FLAG_PVSYNC | DRM_MODE_FLAG_PHSYNC,
> +};
> +
> +static const struct panel_desc nec_nl6448bc33_70c = {
> +	.modes = &nec_nl6448bc33_70c_mode,
> +	.num_modes = 1,
> +	.bpc = 6,
> +	.size = {
> +		.width = 211,
> +		.height = 158,
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
> +	.bus_flags = DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE,
> +	.connector_type = DRM_MODE_CONNECTOR_LVDS,
> +};
> +
>   static const struct drm_display_mode netron_dy_e231732_mode = {
>   	.clock = 66000,
>   	.hdisplay = 1024,
> @@ -5520,6 +5546,9 @@ static const struct of_device_id platform_of_match[] = {
>   	}, {
>   		.compatible = "nec,nl4827hc19-05b",
>   		.data = &nec_nl4827hc19_05b,
> +	}, {
> +		.compatible = "nec,nl6448bc33-70c",
> +		.data = &nec_nl6448bc33_70c,
>   	}, {
>   		.compatible = "netron-dy,e231732",
>   		.data = &netron_dy_e231732,
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
