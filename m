Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A37E1C982DA
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 12:21:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 887F610F34F;
	Fri, 18 Sep 2026 12:21:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="P8TCs8Vh";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C4118825B
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 12:21:29 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49b965f447cso5775255e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 05:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789734088; x=1790338888; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pZSli+1ou/g+3V4+7u5wg2mN2aQGNSeaL9prHAmrZHY=;
 b=P8TCs8Vhow2zgTZRWJIBRksZ+6hf5rmwA4dSuY7ALsdkUwibOVzccq+NrBfZDwWIQ0
 kmY7dCPKiAehXFjKZfJC8AEzURLYjDFFlVRakdvlSIpXFp+iqFH0r7ATVv8ALsMLT2n5
 Sqz+Ww0kwxNTnhPRLrmCpDE+5B2re1TxWmXWwebKFUbwnKCM7JyYqnG6px8/QOmpwEWv
 elSBG7szrQan5JlUv4Rl1+C1dUahAn9XPJABaIWOfxWOZpEtmgchYmsAWE3b2pzBGW67
 VqLjXr3E9nLMyS8PSoA8c5UvN0ln/MKb31QJSH18JTbqgVfoaddQMGmrjp/0zcP6BxBA
 R4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789734088; x=1790338888;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pZSli+1ou/g+3V4+7u5wg2mN2aQGNSeaL9prHAmrZHY=;
 b=is+RLJX1yfIPmHEDOP652tQcsfKPTPVMoxOf9/Q5aBKoL6+04/9OXOUfdlueJ/y5pe
 VxZ63aHKk1axehOZTka0X3XTYBx9DckSNLDlMNriBqYRlDeUeOGjNjOllCIl/2Xt9vzw
 A42AZAzz85lnCy8fKgo2kO7ZXGqgj4/lpp8VTV04wuY06lJLWfffvK2ws6eJW9g/wbtm
 FacFyehOmHsJDBM23vef2PnoiqHGup6zmrU/4SsEKTSOKELXvGk7Z4Kf+vuw0+zn4QDV
 HXMsq+QvUopECXx9z5GY9o4P1xncGlwKFfnHjp/UUfANzq7GDVEY4Lc/b3pjLub7ZJFX
 EugA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwXXLXFLwy79YjcUuE2pMnapp1/Uug0hv7xoVcsJiXY+ABU1prHf91LAvB0weldBpfV+KPnKlvrx9s=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nN33sTdBdnYhqZEKeogsdqa3GwCB0H5Vw4btYpMBbReldlpqVK
 6J5QsCJHRQnUWUdj8IPVmQP7SUJoViJ2TYB/tQ5a0IG83DwlJVOfeShYp/XYEK5tXUM=
X-Gm-Gg: AYBFou3Ry+6uhQh50w9HWMcH88CDh6jxMroB2NAIYsvh70EIB6vYsNLUhTWF4E445/a
 IK/nOsUlsdYtA1wq6szap2SK4dwELkM44/yZvQwmO8rHYaOljKiKxHRBCDdCHZSWzqqKajx3L9h
 MRI61ANieku4ZWf4OVTuwxTAhbgQoMGGDk22i1gYHInZqSycE3dGzxiKNUZfhIla4X2mU3ClGLn
 Xlr1dY1uvWJBwXoYaT3X80ZG+IuQ5UZ8YY4Yu0QOXDNSBeHlnOLKtd74J0kpqqUr2hrCRzv3XQq
 VOdWwWFgF6p7uJ4QrXuyVmACBSDg69cAKaemPJxzdkZCZWiOGEI88fgfbMa5yFRvx4fvEgt7VVN
 p+GZqX8Edy5tXQRGYLfp4/mlQRQ2VR1e68u62h6jrgNr+RS0POX12mDEmbHPvdjIwNLvl96HVSJ
 7SDcSCwpNbP+1k2QcM7obQ4iaEBqwuu0o23I+9ouVEJL/5KOtuahCK7sU+XToKEE7v6MKX09lLO
 LyImhMtAADJo7/w1RBJENB//0jmzlYrffzNHJp0Q2l4DUM9wTn37CU=
X-Received: by 2002:a05:600c:3ba9:b0:49c:f504:2af5 with SMTP id
 5b1f17b1804b1-49fc566939emr33360575e9.1.1789734087499; 
 Fri, 18 Sep 2026 05:21:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:c55f:cb91:1ca5:54dc?
 ([2a01:e0a:106d:1080:c55f:cb91:1ca5:54dc])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc56eff84sm45727935e9.1.2026.09.18.05.21.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2026 05:21:27 -0700 (PDT)
Message-ID: <bcdbc5b2-785d-472e-9d07-599da628719d@linaro.org>
Date: Fri, 18 Sep 2026 14:21:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/2] drm/panel: simple: Add support for Truly
 TFT320240-229-E panel
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc: Frank Bodammer <frank.bodammer@siemens.com>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding
 <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
 linux-kernel@vger.kernel.org
References: <20260917110517.1053556-1-alexander.sverdlin@siemens.com>
 <20260917110517.1053556-3-alexander.sverdlin@siemens.com>
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
In-Reply-To: <20260917110517.1053556-3-alexander.sverdlin@siemens.com>
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

On 9/17/26 13:05, A. Sverdlin wrote:
> From: Frank Bodammer <frank.bodammer@siemens.com>
> 
> Add display mode and panel descriptor for the Truly TFT320240-229-E
> LCD panel.
> Register the panel in the of_device_id table with the compatible
> string "truly,tft320240-229-e".
> 
> Signed-off-by: Frank Bodammer <frank.bodammer@siemens.com>
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> ---
>   drivers/gpu/drm/panel/panel-simple.c | 29 ++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index c95964ba25a95..bd7f6eaeb0deb 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -5114,6 +5114,32 @@ static const struct panel_desc tpk_f10a_0102 = {
>   	},
>   };
>   
> +static const struct drm_display_mode truly_tft320240_229_e_mode = {
> +	.clock = 6410,
> +	.hdisplay = 320,
> +	.hsync_start = 320 + 8,
> +	.hsync_end = 320 + 8 + 39,
> +	.htotal = 320 + 8 + 39 + 4,
> +	.vdisplay = 240,
> +	.vsync_start = 240 + 8,
> +	.vsync_end = 240 + 8 + 8,
> +	.vtotal = 240 + 8 + 8 + 4,
> +	.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
> +};
> +
> +static const struct panel_desc truly_tft320240_229_e = {
> +	.modes = &truly_tft320240_229_e_mode,
> +	.num_modes = 1,
> +	.bpc = 8,
> +	.size = {
> +		.width = 70,
> +		.height = 53,
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
> +	.bus_flags = DRM_BUS_FLAG_DE_HIGH,
> +	.connector_type = DRM_MODE_CONNECTOR_DPI,
> +};
> +
>   static const struct display_timing urt_umsh_8596md_timing = {
>   	.pixelclock = { 33260000, 33260000, 33260000 },
>   	.hactive = { 800, 800, 800 },
> @@ -6167,6 +6193,9 @@ static const struct of_device_id platform_of_match[] = {
>   	}, {
>   		.compatible = "tpk,f10a-0102",
>   		.data = &tpk_f10a_0102,
> +	}, {
> +		.compatible = "truly,tft320240-229-e",
> +		.data = &truly_tft320240_229_e,
>   	}, {
>   		.compatible = "urt,umsh-8596md-t",
>   		.data = &urt_umsh_8596md_parallel,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
