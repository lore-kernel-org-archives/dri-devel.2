Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E9D8C5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 10:01:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8418710EC90;
	Wed, 26 Aug 2026 10:01:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="awXQRN+G";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11C8510EC90
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 10:01:37 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4995b0343c1so5886625e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 03:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787738495; x=1788343295; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bFUvpm8EmgV6Ri+LBPnpFH+gnBuAX0bG3qD3bLuTVyQ=;
 b=awXQRN+GsWAJWssQFqcTP4yZmd1WCFtL2B4JiK/h2xYKoFV3zQShLKqKBO77VLr6bg
 yUKvJos7Er9VTPehAzRG02eQ6+R710Mz+lTDNmwrlZ2LAuRxznPyx3RkhPaC0GisPvKU
 Mj4KvWreJnJqHwRvy7KdiNWB418PJw3qDJmRejUeBYVoTtJJe2O4+w4vLRlrKXl790sB
 po27bT48oxgifbgJM++TuI26S8a1bPQKR85RP/5IU7AsHdsMC1DaBNy8PGFfZcjVS5gp
 0DWqvl/hnyySnhvzZuZM8G/YaER/p75DjcOEaAv7pI13/YF6n9AOX/DVbu9eTxjaGmhw
 i87g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787738495; x=1788343295;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bFUvpm8EmgV6Ri+LBPnpFH+gnBuAX0bG3qD3bLuTVyQ=;
 b=Z2xAVBOV5YF7Pxv7CPIpweHOJ2CisKez7r6gbs8oKWKiBTkKsyVH++MuJO2wD5fAIP
 Bzm2uEfn3yWFP6q2GygZuFUjluiy/E9z2FfxkI8wNBlhqgfqloSxqxrmx1ZOLS8/m6NV
 v8Pe+C0nmc7coaSBwnfKiHfznsv1+jBs5lrWGsdwthFVMnf5MqBKOGPfz8h0o4o4qOBZ
 aMgX2qsM0hcyfD0Qfd9UTL8bPAACg8KTwi+Z9a8hBtCmqkYguu3qsSJFV5px6QGhaZOu
 nF3zBGalyhukZAIyUNUc/1tz9Ib/brEhjP0WREMe+mftBj6diYQskV9K3GYIYEYsErum
 Y30A==
X-Gm-Message-State: AFuF++ksPqfqWTizqH9AYyoUEyBXEPxjSoRCS6F8zg+UccCfkLmZAOjU
 UdV7QBakAaZLYEIAufNRuUhbOJolxxxGOuZoAKw8WMaZhzRSIijlTUOCoPgEyMgoPKPpG0V4S1I
 /jBPIv4o=
X-Gm-Gg: AR+sD125ImMDo/4XdkLebi+IfcUm8CVL2RFuS1uusq/cjAmVT2PEBPzzI+lYjgX17xb
 BL6gjMiq5/fNT2sCVJ5kWmzv640S4z01D36DX4573TuMd8WpvG4nykPStGI2bx1PhGaflBOByD5
 XxE0WxOl2svCCTkT32LTrOZz9rhm6kLLftP0DTEQYBEzjAXdys6je4JxcVasjxaVqjS8mTB6xNa
 dE7oVDDzAIcgEjrugxL7DaysMVjgFzet0VF8nG1hcOJTQtc1D1bMJTud7R+Co4bxVdnErD/RxBP
 ID5cmOs6OcOF0KEWHlXEyr8NZuCIOjXOY/FiCbhaajkWUOc9umzbac6ih/ySKekjihIqBqt21bu
 KuAS1jNpWwYsqWt0CVbZF23UeRUOuMUg+gPaE1cjemgikcK7e/cYUPSeMljm4nD1q2bZOwgKCru
 F0pzqQTEeqDSRY0WE0wbMGICapLOPyd8NX2qKGxffpE3aEJfT5O8gH/IeLokmwmGhmLqczIOfeG
 O+TL0riQUvNIVbDTtLdoQkz0AVtaVVERlgnnetRY4ZwePE=
X-Received: by 2002:a05:600c:3485:b0:49a:77c1:d246 with SMTP id
 5b1f17b1804b1-49a77c1d2eemr10500275e9.15.1787738485302; 
 Wed, 26 Aug 2026 03:01:25 -0700 (PDT)
Received: from ?IPV6:2a0d:e487:135f:84f0:37f7:9223:8e7a:9b5f?
 ([2a0d:e487:135f:84f0:37f7:9223:8e7a:9b5f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dd5616f7sm13144835e9.2.2026.08.26.03.01.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 03:01:24 -0700 (PDT)
Message-ID: <1021133b-454a-4f49-965b-a71e065e556f@linaro.org>
Date: Wed, 26 Aug 2026 12:01:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3 2/2] drm/panel: simple: Add BOE DV215FHM-R01 panel
To: Vishnu Saini <vishnu.saini@oss.qualcomm.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Thierry Reding <thierry.reding@gmail.com>, Liu Ying <victor.liu@nxp.com>,
 Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, venkata.valluru@oss.qualcomm.com
References: <20260814-b4-lvds-panel-doc-v3-0-1ad152a4d3ec@oss.qualcomm.com>
 <20260814-b4-lvds-panel-doc-v3-2-1ad152a4d3ec@oss.qualcomm.com>
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
In-Reply-To: <20260814-b4-lvds-panel-doc-v3-2-1ad152a4d3ec@oss.qualcomm.com>
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

On 8/14/26 07:25, Vishnu Saini wrote:
> Add the BOE DV215FHM-R01 21.5" FHD (1920x1080) dual-channel
> LVDS panel.
> 
> Signed-off-by: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
> ---
>   drivers/gpu/drm/panel/panel-simple.c | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 5c169fdf265c..d95f842c8980 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -1563,6 +1563,31 @@ static const struct panel_desc boe_bp101wx1_100 = {
>   	.connector_type = DRM_MODE_CONNECTOR_LVDS,
>   };
>   
> +static const struct display_timing boe_dv215fhm_r01_timing = {
> +	.pixelclock = { 148500000, 148500000, 148500000 },
> +	.hactive = { 1920, 1920, 1920 },
> +	.hfront_porch = { 88, 88, 88 },
> +	.hback_porch = { 148, 148, 148 },
> +	.hsync_len = { 44, 44, 44 },
> +	.vactive = { 1080, 1080, 1080 },
> +	.vfront_porch = { 4, 4, 4 },
> +	.vback_porch = { 36, 36, 36 },
> +	.vsync_len = { 5, 5, 5 },
> +	.flags = DISPLAY_FLAGS_DE_HIGH,
> +};
> +
> +static const struct panel_desc boe_dv215fhm_r01 = {
> +	.timings = &boe_dv215fhm_r01_timing,
> +	.num_timings = 1,
> +	.bpc = 8,
> +	.size = {
> +		.width = 476,
> +		.height = 268,
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
> +	.connector_type = DRM_MODE_CONNECTOR_LVDS,
> +};
> +
>   static const struct display_timing boe_ev121wxm_n10_1850_timing = {
>   	.pixelclock = { 69922000, 71000000, 72293000 },
>   	.hactive = { 1280, 1280, 1280 },
> @@ -5726,6 +5751,9 @@ static const struct of_device_id platform_of_match[] = {
>   	}, {
>   		.compatible = "boe,bp101wx1-100",
>   		.data = &boe_bp101wx1_100,
> +	}, {
> +		.compatible = "boe,dv215fhm-r01",
> +		.data = &boe_dv215fhm_r01,
>   	}, {
>   		.compatible = "boe,ev121wxm-n10-1850",
>   		.data = &boe_ev121wxm_n10_1850,
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
