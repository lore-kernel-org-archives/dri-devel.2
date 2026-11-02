Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C775606A329
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=J1Xc/8Jj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25C6310E20F;
	Mon,  2 Nov 2026 13:16:58 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C8EA10E20F
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 13:16:52 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a60f9474c4so31700695e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 05:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793625411; x=1794230211; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Nu0UBnRlzBjlTsD7Xnyon69xqlQ0MnOsBtNCGwjj4wU=;
 b=J1Xc/8JjdhcIOSQq1c+W3bADJeIRy637OBsuNNa8dpjG3jcsk9vC360PhHzyoU0rod
 fxw9gv0gXu4dk6LuQ5yr+ZNVe65aJXJLB5kx3fErIAuFMZE7yrxo8IUAmCH8+CyQMIel
 EEHRWQQBz/4yB4uWnkDcDB3wDF3ehuU+nJBcb49UU8bwIAP/BgXanOewVGUBqo0NpkOS
 EKv4LJduadwCkp2su1b1GNhgaeaXPe3tPHm+ZxGODU8CVqFukuZlOkvXv8wQkadEZgou
 DiAFZTXO6ozN2jEfqjOMGOA3aYUO08ZyTbz4PbBmQ5inBe0H9Le9o8pviwkPCMwZPH1s
 7AMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793625411; x=1794230211;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Nu0UBnRlzBjlTsD7Xnyon69xqlQ0MnOsBtNCGwjj4wU=;
 b=laSNGsIWH609rJvdMtp229FdEr8zUcDeCNukbWqVqsR8ajKY7BG5J48bpJtpNe+iv6
 2y5wkESFJ6oUsagjfwg2o25NlNQF4l/TMttGDUCmYIUmMB7G2UZjMboVLfaTQYiptiXO
 4VuicyECq83bvpEOg2/itkI+UaUwmQrbu7POQ+/0UZL+eR9wRnFGIPzOJNbdU1L3+o3J
 q5OwAFeKx5Zy3ztc5FcEuqVd83JHA0cq1DR1iMVJT145fiJ0ZuPFVjOZ7UW06oYxLOyg
 /g3/joQV5rtcRvFMBVp5U76hCGixJ2hsz9lAT5cPlqM9Gnb/vmKA/ikNfp9YTG3Ul7Co
 5oDA==
X-Gm-Message-State: AFq9FYIi/t56Lj/Sq/oK903SjBotIRjSPMIvGgAaYhLE+Ju4g6QXxQ7w
 BZJEs6VP1fURECvChXcUny8rlwJHHEQwWjCAtM96qgqjGPxqYppri0gOeNJR9HJLs9M=
X-Gm-Gg: AYBFou3ArF+Hm8tXeJ14Ly9UnXu5q6g7qZbuMpS6qdb/wHz3MMLt3kCCa6nj1mwNuFk
 PMIIpFi/psg9xkRmQ3thgb5YfE7MTmQ6ftE099ZpzGgz9ZyIYcTZQ+EALApPLznyTTisAfnDfWD
 0ONeZofP7FBExB00TTbYu7+DJXUZEjZkAuOgchg/ZYr08lXJsrgQ0wNEJxd9SbdvHZ6dA56U7Ln
 mkSb5v3/dsXtJ7CbfgPMc4A8HdHjivVG0m6uOsvLVo81Wc7I95HKBt+vr4Ou+jpAoqkX2aOHoc0
 q/kNRvl1sXdRrjuQHbmWTc1JhXul/6lUui0lOiH423EGPfgDq/Z3nvVcBrOHWrpj/TBlh794ABQ
 iwT586iVzja6vG72fHfBN5CpXaywyIkXA/TPOEAdHVBU8nn3l1KN0iAtVVmobB7H9ZuYKZktpAz
 75jl+eeWJPAqIS6nT6BOb32URGJgTNDu28nThdOEn/IrRdqmLw2Q6yjcTAOpnl/1SIsTNbisUHA
 26ryjLk+BPJ5xy9B57GoRzzTtODxAO59zLYqqDxSSkuVNvaR6Odo/b1P2V1ML9/J+4mhfsogHrW
 ekudXdItnjPaZWNOEmzGJUWaEp2z7r0teoJZJttorUqNEVna+ng45hbj+/Z7lJPgbp9rUKDxk5u
 cbdAyVA==
X-Received: by 2002:a05:600c:8b0a:b0:4a1:777b:8a12 with SMTP id
 5b1f17b1804b1-4ac1709ae4emr246187665e9.14.1793625410523; 
 Mon, 02 Nov 2026 05:16:50 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:9476:5165:3a16:262?
 ([2a01:e0a:106d:1080:9476:5165:3a16:262])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7f322c46sm331607645e9.2.2026.11.02.05.16.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 05:16:50 -0800 (PST)
Message-ID: <fbf54a00-33c6-4b5f-a9d9-3f6c23744ae9@linaro.org>
Date: Mon, 2 Nov 2026 14:16:49 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 3/7] drm/panel: simple: Add Waiken WKS101WX001-WCT
 panel support
To: Frank.Li@oss.nxp.com, Marek Vasut <marex@denx.de>,
 Stefan Agner <stefan@agner.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, Robert Chiras <robert.chiras@nxp.com>,
 Liu Ying <victor.liu@nxp.com>, Frank Li <Frank.Li@nxp.com>
References: <20261027-dxl_lcdif-v5-0-3a974e4b94b2@nxp.com>
 <20261027-dxl_lcdif-v5-3-3a974e4b94b2@nxp.com>
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
In-Reply-To: <20261027-dxl_lcdif-v5-3-3a974e4b94b2@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/27/26 16:00, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Add support for the Waiken WKS101WX001-WCT, an industrial-grade 10.1-inch
> IPS TFT LCD panel with a capacitive touchscreen.
> 
> Although the module advertises LVDS support, enabling LVDS operation
> requires hardware modification, including the removal of several on-board
> resistors. As there are currently no known users of the LVDS configuration,
> only the default interface mode is supported.
> 
> Acked-by: Liu Ying <victor.liu@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change in v5
> - drop "If LVDS..." in commit message (Liu ying).
> 
> change in v4
> - s/LDB/DPI
> - variable use 101wx001_wct
> 
> change in v3
> - add wct surfix and change to use MEDIA_BUS_FMT_RGB888_1X24
> - Add information about lvds support plan.
> 
> change in v2
> - update height to 135 from 136 (sashiko)
> ---
>   drivers/gpu/drm/panel/panel-simple.c | 31 +++++++++++++++++++++++++++++++
>   1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index d7dbd7442919b..5ef6a79f0de95 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -5252,6 +5252,34 @@ static const struct panel_desc vl050_8048nt_c01 = {
>   	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE,
>   };
>   
> +static const struct drm_display_mode waiken_101wx001_wct_mode = {
> +	.clock = 71100,
> +	.hdisplay = 1280,
> +	.hsync_start = 1280 + 70,
> +	.hsync_end = 1280 + 70 + 10,
> +	.htotal = 1280 + 70 + 10 + 80,
> +	.vdisplay = 800,
> +	.vsync_start = 800 + 10,
> +	.vsync_end = 800 + 10 + 3,
> +	.vtotal = 800 + 10 + 3 + 10,
> +	.width_mm = 217,
> +	.height_mm = 135,
> +	.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
> +};
> +
> +static const struct panel_desc waiken_101wx001_wct_panel = {
> +	.modes = &waiken_101wx001_wct_mode,
> +	.num_modes = 1,
> +	.bpc = 8,
> +	.size = {
> +		.width = 217,
> +		.height = 135,
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
> +	.connector_type = DRM_MODE_CONNECTOR_DPI,
> +	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE,
> +};
> +
>   static const struct drm_display_mode waveshare_28_lcd_mode = {
>   	.clock = 50000,
>   	.hdisplay = 480,
> @@ -6248,6 +6276,9 @@ static const struct of_device_id platform_of_match[] = {
>   	}, {
>   		.compatible = "vxt,vl050-8048nt-c01",
>   		.data = &vl050_8048nt_c01,
> +	}, {
> +		.compatible = "waiken,101wx001-wct",
> +		.data = &waiken_101wx001_wct_panel,
>   	}, {
>   		.compatible = "waveshare,2.8inch-panel",
>   		.data = &waveshare_28_lcd_panel
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
