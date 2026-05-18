Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A0CCD4F4A
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 14:00:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5694010E857;
	Mon, 18 May 2026 14:00:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="juYYUSdY";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C40210E86A
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 14:00:50 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-48896199cbaso18142775e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 07:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779112849; x=1779717649; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=/9RfURwu1IqM95+26wfOLt80mxZnfDTRrUVwQvAEzdo=;
 b=juYYUSdYSX30SygUIlEXcIhkysMDYBqI9WB97xFjMkuQNUse/KH5s6nfvfAhI51bJT
 tV5YpRL7SvJYzQLkKGxZCxhxKou2C5l+R2/d3PyMnwwHURsPWu4P1kNDxyxmJJm4LTtZ
 6FgtfsqZEowuuWIbdxKRXb10K2EHmJdzO/Dh6yl9a4tabn94+XOKZtB2y8rAX9QHH5Nv
 7NpFFfpE+NMykvau4ZVIdXFl8MXJSyKxKqXWBysUG8IPtqAk4HaabsXmTW67BgM3yfm8
 7FL8VIlIQLPLXw8N5Q36dEwtEi1I6vYP/wYD5QA0D9LUBDa4pWE4i8IyoynmOxuSNs0R
 fP/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779112849; x=1779717649;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/9RfURwu1IqM95+26wfOLt80mxZnfDTRrUVwQvAEzdo=;
 b=qUdvk7qdfc+n5R2DRYctCtYkkv4Oq9EdlaJKDKh2eBYlDXhKWrp3V/rG+cmDUa11ms
 NaEeT9a4feChMnHd4xtrK74LEaordGO1Vng0EhnOmB6wJ49tCJtyW2+OtFaCF9TWVwMk
 R/EXCI0qBZQgp7oesqN8y/i68QBjKlGYm7KmwSY1fITicQtElI0KNeq5EpPzWQ9/lG+k
 WjhKTylzNyMG7NdcHya41AsO8XSSpVk57CsYZM0ariVg0OrEJnjXLUrKe1Wp8NHoRZZM
 5d53DUAxlh3zL8hPN4xUVpCQu0G/fUMF3lLvkCIDeSmMdP/CFBPSBMs0e+w04DHZu26i
 x+HA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+wNIQYU+0l+ZMx2zP3bK+YTaGOp2Rkhqye+XHq6zeW0mCjB9wM/iZ1PFqaUB9F1rrFWjBLjG4Z73c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwUFBixkB+DjmHfKBm6LHh7ekh6uwcgwQCf3Z6n/cZw+qI1wil8
 njJx9HJdwCCKxcKLXWn276g/X3iAJdPPhbQ8pkhedMDNwG5067mRTiDuqjzH7dVNF/dwBfZSAUh
 iCOsm
X-Gm-Gg: Acq92OGyHB1OH8pYM4P4yl2RV6+6n5Btz1nVxHdkPjwHmmmbEmvCkpwtDvXvS3SLZVG
 qFfPo/bs54aX/b3si0vrVPrF11X2TfAtTOPjiKUJeSrnUADwU0ERsfQdKR3W4fLqfGnbqkESN3t
 Ggk4OYzNtZ3Lit4rBjviUlUOCpePHuPqkDrsCvgjP9od4YrJDUtvIQqk1odtOS+GmpKkuu1UxYo
 TZry7b6XzWcULsNtp5KUiZl52AY5qTKhA4Jx+cRI2gzY7/LT6JGF3tvsl4Ql6czdyLU96Vs89rB
 Qcgo4xa3GaJ96vHNrk+g4B4SXc5NxHOQX6OM4oY+F1VR6hg7pv/qL4uqxICf5Tez3PGPLt5/OOn
 AEnS/SLZKdL3ydZtWLNabj6s6QdYUFUAFlUbRvrU717ICg/pxMJMaB1/5AioQntMsJFxIFfXTsC
 E6IV75ouQL0/KAMn0CtBibCCGGUMxMhfMWK6V0Ex6OSM64BxG6NnmyXapHOzJc1SrnAIHu+NrRS
 sNal4U=
X-Received: by 2002:a05:600c:491e:b0:48e:978f:c45a with SMTP id
 5b1f17b1804b1-48fed455991mr135326915e9.19.1779112848462; 
 Mon, 18 May 2026 07:00:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:1029:e3c5:362e:1250?
 ([2a01:e0a:106d:1080:1029:e3c5:362e:1250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe537ccf5sm252594685e9.14.2026.05.18.07.00.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 07:00:47 -0700 (PDT)
Message-ID: <1a24fdd5-24d9-4d3b-82a6-21c9c7b9fff0@linaro.org>
Date: Mon, 18 May 2026 16:00:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/2] drm/panel: simple: Add AM-1280800W8TZQW-T00H
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 linux-kernel@vger.kernel.org
Cc: Michael Trimarchi <michael@amarulasolutions.com>,
 David Airlie <airlied@gmail.com>, Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
References: <20260515064721.1750990-1-dario.binacchi@amarulasolutions.com>
 <20260515064721.1750990-2-dario.binacchi@amarulasolutions.com>
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
In-Reply-To: <20260515064721.1750990-2-dario.binacchi@amarulasolutions.com>
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

On 5/15/26 08:47, Dario Binacchi wrote:
> Add Ampire, AM-1280800W8TZQW-T00H 10.1" TFT LCD panel timings.
> 
> Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
> 
>   drivers/gpu/drm/panel/panel-simple.c | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 236bd56208cc..99deab68a2fb 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -794,6 +794,31 @@ static void panel_simple_remove(struct device *dev)
>   		put_device(&panel->ddc->dev);
>   }
>   
> +static const struct drm_display_mode ampire_am_1280800w8tzqw_t00h_mode = {
> +	.clock = 72400,
> +	.hdisplay = 1280,
> +	.hsync_start = 1280 + 40,
> +	.hsync_end = 1280 + 40 + 80,
> +	.htotal = 1280 + 40 + 80 + 40,
> +	.vdisplay = 800,
> +	.vsync_start = 800 + 10,
> +	.vsync_end = 800 + 10 + 18,
> +	.vtotal = 800 + 10 + 18 + 10,
> +};
> +
> +static const struct panel_desc ampire_am_1280800w8tzqw_t00h = {
> +	.modes = &ampire_am_1280800w8tzqw_t00h_mode,
> +	.num_modes = 1,
> +	.bpc = 8,
> +	.size = {
> +		.width = 217,
> +		.height = 136,
> +	},
> +	.bus_flags = DRM_BUS_FLAG_DE_HIGH,
> +	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
> +	.connector_type = DRM_MODE_CONNECTOR_LVDS,
> +};
> +
>   static const struct drm_display_mode ampire_am_1280800n3tzqw_t00h_mode = {
>   	.clock = 71100,
>   	.hdisplay = 1280,
> @@ -5193,6 +5218,9 @@ static const struct of_device_id platform_of_match[] = {
>   	{
>   		.compatible = "ampire,am-1280800n3tzqw-t00h",
>   		.data = &ampire_am_1280800n3tzqw_t00h,
> +	}, {
> +		.compatible = "ampire,am-1280800w8tzqw-t00h",
> +		.data = &ampire_am_1280800w8tzqw_t00h,
>   	}, {
>   		.compatible = "ampire,am-480272h3tmqw-t01h",
>   		.data = &ampire_am_480272h3tmqw_t01h,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
