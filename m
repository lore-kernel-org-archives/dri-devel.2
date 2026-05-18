Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 863A8CD4F4A
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 13:59:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E035A10E029;
	Mon, 18 May 2026 13:59:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="k0VjbDsG";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED90010E029
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 13:59:41 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so23883485e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 06:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779112780; x=1779717580; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=AnU5FDn+KzMBX5iK1bsH44f81pms9pH5cn3b+/Mb3eY=;
 b=k0VjbDsGqJsdHrduzur8f7xvHko7N06yM9YmbQ4oCIKIPOJTOvMr7BE9QAvYLfANSl
 D0RTK28HuemCwJ8h0k2LqYD/7klKrX5J4k18HvS4+J7W37MesCAqc4iImBt1VtjjDjxL
 N9w3P1OaFF88KE5iJpK6B0rqMkJxc7N+sxTNfhG6/wIJVDOyW7zWHzKHzAiZy1q2L6Q1
 BzdiweEfz0h5q+Mks6vbQYYU0FsyQqe9aeiNEfDuVl9nAxYhukW60YhmscsjZvpFl2W1
 rInhyFxicPZ0/FDDGQDQTBW3dteaMATjIiBfePxO+N555LD87vIK2MaTSwF0IO6HshLq
 WJew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779112780; x=1779717580;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AnU5FDn+KzMBX5iK1bsH44f81pms9pH5cn3b+/Mb3eY=;
 b=eomMhb6XGpGFgkbnO7v/LxmG55VS1osh+YCE8fLdS0HbPBxyzIQBbIwm8he+p5dVia
 rp8OMzl1OnysDnpzb/dtWhuTFKGt7AQe9M56aUxTffxw9n4aY2XeyIpfw2VpJVvTjrl4
 R8t32y+vRVNasBjuH6jYLdYjUbfYI/ri7lZ8VPybY2i6QDes/EnZxT5UkiOBall4lMLj
 qYkKfsY0eYqu+Y5cXb05tZ7glFVqaHlbGj4VrgkdtyhJxJGYf+ODfen+FtlZbDUTr5/C
 HfWwGbC9JrFt7rHTKPJV1TuBnHPMlNG7E4fuGaLk9qvOy75P+Z0FboH0eizQH4qlVMdK
 Niyg==
X-Gm-Message-State: AOJu0YxhYWxdPJSbiv1rd11jxljkP10KVu8yP5qOabux2Du+tKYXmZpO
 7tWlCjDk//fkDIYn2j2/ajLvOJa0Q1VNqzlwjfnD4BExo3EccsprzOPm6XVRqhGKOn8=
X-Gm-Gg: Acq92OFxmKRZ/EnjYznw3QluzLrzvrq0akOLr1veJ1x4p0mlMHCo/Fv90beLb2TgIAz
 YRodYzyuQ6rJ59Abzz+9TiEomvZx50OLZUiM0DhulMlrZTZ3EwdOk31RBc/wvkQxqNcv4lxIlHl
 sqDCEI4AZCt4TIFYTFWzXF0ojyxtgX+3d9VbkuI5h/2GkDGKN2NoF0HnyrEOzsRAcPRVPM8GhUJ
 GBpZlNTCNW0nfubwckYdQsMj1CFQH0GRfJqLcFXD33UQur6iWgaEtzXZ7xUG87Hk4wXg9gQJlc3
 op2AknSRcV9LlLRQvVgr1yQf1HKAvN2BzY5EWodqbZe4ZaxJ2ZgHT6ZImkIE8Wjso2SqAuAdO/m
 fLsmOxz0OLLhzWDfejGOndaDZfn6Yzi9LZ4Nj4yswWwBHix8A489DHJU7/t4M4tFb5oslLzraPY
 vK4yM7sZ31YkxV8wMpRqFW49S2Y4cPbp2bZj05AxFIJZnDL1MsSS1sfWUJ3HlpY4wr4Q8lWCVjp
 5it76g=
X-Received: by 2002:a05:600c:4692:b0:48a:906b:14ca with SMTP id
 5b1f17b1804b1-48fe632579dmr236323395e9.20.1779112780287; 
 Mon, 18 May 2026 06:59:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:1029:e3c5:362e:1250?
 ([2a01:e0a:106d:1080:1029:e3c5:362e:1250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febe58c04sm84381495e9.20.2026.05.18.06.59.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 06:59:39 -0700 (PDT)
Message-ID: <97556944-0031-46fa-b735-9d26bca4aea4@linaro.org>
Date: Mon, 18 May 2026 15:59:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3 2/2] drm/panel: simple: add NEC NL6448BC33-70C
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
References: <20260518-v7-1-topic-panel-simple-nl6448bc33-v3-0-21ea14a6e835@pengutronix.de>
 <20260518-v7-1-topic-panel-simple-nl6448bc33-v3-2-21ea14a6e835@pengutronix.de>
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
In-Reply-To: <20260518-v7-1-topic-panel-simple-nl6448bc33-v3-2-21ea14a6e835@pengutronix.de>
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

On 5/18/26 09:47, Steffen Trumtrar wrote:
> Add NEC NL6448BC33-70C 10.4" 640x480 LCD module support.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>   drivers/gpu/drm/panel/panel-simple.c | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 236bd56208ccf..0bf50b1ed69e6 100644
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
> +	.bus_format = MEDIA_BUS_FMT_RGB666_1X7X3_SPWG,
> +	.bus_flags = DRM_BUS_FLAG_DE_HIGH,
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
