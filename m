Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FACE106F302
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 08:38:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 127B510E9F3;
	Thu, 26 Mar 2026 08:38:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tFGtCj0g";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00AB810EA18
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 08:38:41 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-43b527ac5d0so330149f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 01:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774514320; x=1775119120; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=jqy37fTLBIgdrRRJV6oiAJlRmShF96nT8C9cnYI6+hQ=;
 b=tFGtCj0gNKBMqU+Z4VtG2sum3I3hY6ZwM1Nxia/pvsl1x1c0fhAJMipI1ZzslKPite
 HGP6PGrdqDyZThk0T7sjJTbEvQLxKCUv0h29N1khy7T9dg6kPXQo4ew7RE6piZTmfiPi
 vY/WVdFnq2zjMqYnAqFesgA/uFzFwrg6aNguaWQwsfZk4Su5KQNDolEF74O8fdJoKqp0
 TjD8k+huCYXGALlenWIj5UCquFd1xymyzqOJTSspHJzeTseWpL+JYOnbpf7Yk1eFSJuc
 WgizpHNx2igVaWcmafvzSovzNYXenAiavv+SudlNTi3xKLi3qVomLlYSst4AOWHKKsbC
 gWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774514320; x=1775119120;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jqy37fTLBIgdrRRJV6oiAJlRmShF96nT8C9cnYI6+hQ=;
 b=cx1nfwjQp17iLSle5brd4j+ch1omyStQkS5FBJ9Gnb72EYeGK76BGqMT/ARSasW/gm
 srODN2LzHQ5J5uzsJn3qosaveuiLje/Ifo3q4rqhTzxnfoaFPeSUaXlZFChpCFyMsbGb
 AXSBwYI+iyIwCT6flwFVvawX2gXtcCVNgIsq1pYFTgRiiOIb5xVRRZ0a4D+DR3ZVN3x6
 JVKS/tivqW/5YiatIqVylDhvnhbL/ixGVlRrHjxJeT+VozjLgr/x0TIw3u1d4YpIeWPo
 wPMSjNUSZeP2KJFowhl5e2DD7CO0Gg0mfbrJqn+sGp3m2udUCRpTOh1qMKNL8LnAUL6S
 HRDQ==
X-Gm-Message-State: AOJu0YyAgvtVjsSLYwnY4zhsVthqgytuSBaceYwYe2c/9W5P8zVif6Wr
 W/RRNSZ14FY3LrvJWDQokd1q4DO83yI6lYenpI3Qz//C/+adZN6T70u7S0VB+eNWs40=
X-Gm-Gg: ATEYQzwA26Hu6BXjcfykNqp4wZj6ieJ9C17u2UILR5LwRfqc+z6vtHaLo54TqMBOD5G
 YKBj7osnoXFysT80Od++hD2NzEenN8Mi/5NdJ8ATt6HAk7VztBXHUQ42kBN3MJJgEn7TvuyFRY6
 JwTipdIoOcsgQGwfVhSXo5ohFcyQ+aCL7oxSkRXMgsQLO4rFL9PH+pBaLHId1nzUr7RK7ZARGni
 rGTMLqLA4DZEWZgOYHF1ynqo8Ml2sZXhu0QJqalEsheWHFOPemcs9MVIi9uLv3gpFmq3sAULKRn
 tm3TdzSVr3jOIn7i9VWq0f+I8+BEnQZ0kOEKisZEssqVWT9t/B4fbpJMRUsbT1terPpi8K3/BwO
 AGBzhe82oQZdfHnq6C5c8LehSY8HV6GZBTmdmLaFtDIbkuH7A07Nlu0saorL9XOF4NQseyyDPk0
 M0xTTSTjMwYQhHHUxk8DkBCuHNd/wm+mCFVjeNg3hm9vV4m8Ox25IK/DLUijKFAKVPj5mgRrxh/
 njKu2Qp2klitWgq8Q==
X-Received: by 2002:a05:6000:4381:b0:43b:4468:b114 with SMTP id
 ffacd0b85a97d-43b889db4b2mr9444918f8f.23.1774514320331; 
 Thu, 26 Mar 2026 01:38:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:8431:f88b:714d:f78d?
 ([2a01:e0a:106d:1080:8431:f88b:714d:f78d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919e68a6sm7333599f8f.33.2026.03.26.01.38.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2026 01:38:39 -0700 (PDT)
Message-ID: <dc18d8b4-34d8-4c66-bcd3-e20c4af50319@linaro.org>
Date: Thu, 26 Mar 2026 09:38:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/4] drm/panel: simple: add JuTouch JT070TM041
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding
 <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
 Shawn Guo <shawnguo@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
References: <20260325-v7-0-topic-imx8mp-skov-dts-jutouch-7inch-v1-0-10255d236439@pengutronix.de>
 <20260325-v7-0-topic-imx8mp-skov-dts-jutouch-7inch-v1-2-10255d236439@pengutronix.de>
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
In-Reply-To: <20260325-v7-0-topic-imx8mp-skov-dts-jutouch-7inch-v1-2-10255d236439@pengutronix.de>
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

On 3/25/26 12:32, Steffen Trumtrar wrote:
> Add JuTouch Technology JT070TM041 7" 1024x600 LVDS panel support.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>   drivers/gpu/drm/panel/panel-simple.c | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 91ab280869bac..6ac263f83793b 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -2940,6 +2940,35 @@ static const struct panel_desc innolux_zj070na_01p = {
>   	},
>   };
>   
> +static const struct display_timing jutouch_jt070tm041_timing = {
> +	.pixelclock = { 40800000, 51200000, 67200000 },
> +	.hactive = { 1024, 1024, 1024 },
> +	.hfront_porch = { 16, 160, 216 },
> +	.hback_porch = { 160, 160, 160 },
> +	.hsync_len = { 1, 1, 140 },
> +	.vactive = { 600, 600, 600 },
> +	.vfront_porch = { 1, 12, 127 },
> +	.vback_porch = { 23, 23, 23 },
> +	.vsync_len = { 1, 1, 20 },
> +};
> +
> +static const struct panel_desc jutouch_jt070tm041 = {
> +	.timings = &jutouch_jt070tm041_timing,
> +	.num_timings = 1,
> +	.bpc = 8,
> +	.size = {
> +		.width = 154,
> +		.height = 86,
> +	},
> +	.delay = {
> +		.enable = 50,
> +		.disable = 50,
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
> +	.bus_flags = DRM_BUS_FLAG_DE_HIGH,
> +	.connector_type = DRM_MODE_CONNECTOR_LVDS,
> +};
> +
>   static const struct display_timing jutouch_jt101tm023_timing = {
>   	.pixelclock = { 66300000, 72400000, 78900000 },
>   	.hactive = { 1280, 1280, 1280 },
> @@ -5352,6 +5381,9 @@ static const struct of_device_id platform_of_match[] = {
>   	}, {
>   		.compatible = "innolux,zj070na-01p",
>   		.data = &innolux_zj070na_01p,
> +	}, {
> +		.compatible = "jutouch,jt070tm041",
> +		.data = &jutouch_jt070tm041,
>   	}, {
>   		.compatible = "jutouch,jt101tm023",
>   		.data = &jutouch_jt101tm023,
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
