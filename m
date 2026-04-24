Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F28B3FE51F2
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 09:34:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 646F510E3C1;
	Fri, 24 Apr 2026 09:34:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="E0/7IsLT";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9592D10E3C1
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 09:34:36 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-43eada6d900so7434914f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 02:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777023275; x=1777628075; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=ZJWCPBfaf3hl7HU5rQXTywnCv02n6udY9nbMMzxiGZ4=;
 b=E0/7IsLT8X7MdTz6e+g8DhwIb3gQdT3rHxq+2vHEycqn9LBgXeALmJ7sSdLsUXpPS+
 LOIo8OMDEEybkONi3tVtoPE3AkXkyrrHYur0KoF4xwvzpiQ8WW7mgjH6wP8Ff6UVUcVJ
 JlFXI7nBnT/UuxeIwDwoC8YCqfBipthoC9XwqJ1Rm9fPH0N+qeP4IdW9/P8CrkjqQ18g
 GjbRIqqhH6/l8NhDW27wrE+3TRQ1OciS8ElHPSK3l4jpKcvvAxIFK4zCPt+JxRl7iT0S
 ixcoiVjLbWOxTA8E5iuBSw6PRfrTMUprmuXnB5mpWRK4nyXOPRLfcbTrNysAxdqJ2ub5
 01aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777023275; x=1777628075;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZJWCPBfaf3hl7HU5rQXTywnCv02n6udY9nbMMzxiGZ4=;
 b=pPSjy3uuYgDg9cGTD+s/YeTdUT4gvV3VgRz6Y92fEhJbAtxg05nRss3fvZg1E5awkA
 233gTBj2WROIKbymS1NgJZ8OcGqamV9DN8Ix0WiB+FBBV/vZxL2AIHmW1JYpGJr213b7
 XlYhZhSG2MyP3XAN23FPPHkILzOhKsML9VEqxN1ZJKHDWBJTUlA/CdeAM7ZF8HSty8sv
 i7p86jRoVBuqnzYuDXSXDFYKS0cwFDN8JXZbRKWIfOv6CDYcYM3YZJz/FdHUq1idLjR4
 sz4gyTdbDTfyFDGSYXFj7Scmdhmd9yVLdv60lG4zvQpHSBV7UVkYrU5CW0K3aELL7V8O
 EheA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8J69IiQgf45Iv1gaCyw8xtEkhKQOEb236UT/R+XDoMjNwBq9h+S5Jrm/mznTLCRw9HrKJZoVBD2Ds=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxI88kiF2I0f2KFVVgjJE9qgwud7+0rBrcYHpmIXpjAUrTaqBGW
 vr5SOtePd9LR+qcI/2/mRWx6cc4lDfKerWa+Fujtfbmc6xXsp6pQXbY0AKLQwrKc19ukN3vLFYD
 hCL3Swlw=
X-Gm-Gg: AeBDievVE33IJ/nwnVcXjsexYVKpNETtU0ot1QrXJi6V/2GEePGDm7ELaWPz5Po6OG2
 uXJT3N1k7kas4gyC9NxzFr2eGqIyHiZiB9rk6uA11Z+IGqtOYMDPMqAY9boXOhGSGBkwNVwaabl
 O6HeEws6JrMMRXYzf17IOQDFUXYcnppIFxMrp1GmFX0h4+AvnxmBXylN8YmlluqU5/qz51gyin6
 X0YlgIanDtCCMBybk/CA/GsKoQ/5gqppjTXzpSNyX6QnR4rkpx05kjwtBwefCp2FhFiw3HDCo/v
 ShXQMwrVtj+5dofrqonl1mSqUsR4MglNO7neCNC8R152geaBlnM9wUYCicLYefEaIMrGjiwyyfv
 dgdYB+gqNLhnAyVsOOVIRfdlFWDSYLcZDekmu0GVXQZyx7u0K6uCRwSDTS9fDm4xZHaGlBRXQMj
 FNaqMyHjS6Eie3CUv3oV5hE5Jf2EKnM/y77AKHnrb5H22NHXk8mz20K5jQRu/ebpQEvcwtg786D
 qsx5vINHOYDPZxGgw==
X-Received: by 2002:a05:6000:24ca:b0:43e:a70d:7632 with SMTP id
 ffacd0b85a97d-43fe3e0b463mr48905959f8f.25.1777023274954; 
 Fri, 24 Apr 2026 02:34:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:79e1:f56b:445c:ca9c?
 ([2a01:e0a:106d:1080:79e1:f56b:445c:ca9c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cb11b4sm60175178f8f.2.2026.04.24.02.34.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2026 02:34:34 -0700 (PDT)
Message-ID: <fbfdcb81-6293-47af-8d09-30bd18b9c815@linaro.org>
Date: Fri, 24 Apr 2026 11:34:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 3/3] drm/panel: simple: Add Displaytech DT050BTFT-PTS panel
To: Marek Vasut <marex@nabladev.com>, dri-devel@lists.freedesktop.org
Cc: Kael D'Alcamo <dev@kael-k.io>,
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
 Sam Ravnborg <sam@ravnborg.org>, Simona Vetter <simona@ffwll.ch>,
 Thierry Reding <thierry.reding@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260422210806.80948-1-marex@nabladev.com>
 <20260422210806.80948-3-marex@nabladev.com>
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
In-Reply-To: <20260422210806.80948-3-marex@nabladev.com>
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

On 4/22/26 23:07, Marek Vasut wrote:
> Add support for the Displaytech DT050BTFT-PTS 5.0" (800x480) color TFT
> LCD panel, connected over DPI. Timings are taken from the datasheet
> from 16 Nov 2023 is available from Seacomp:
> 
> https://www.seacomp.com/sites/default/files/datasheets/DT050BTFT-Displaytech-Spec.pdf
> 
> Signed-off-by: Marek Vasut <marex@nabladev.com>
> ---
> Cc: "Kael D'Alcamo" <dev@kael-k.io>
> Cc: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Jessica Zhang <jesszhan0024@gmail.com>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: devicetree@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> ---
>   drivers/gpu/drm/panel/panel-simple.c | 36 ++++++++++++++++++++++++++++
>   1 file changed, 36 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 236bd56208ccf..9f4c907ae044e 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -1902,6 +1902,39 @@ static const struct panel_desc dataimage_scf0700c48ggu18 = {
>   	.connector_type = DRM_MODE_CONNECTOR_DPI,
>   };
>   
> +static const struct display_timing displaytech_dt050btft_pts_timing = {
> +	/* The TYP pixel clock are recalculated from tV * tH * 60 Hz */
> +	.pixelclock = { 30000000, 33264000, 50000000 },
> +	.hactive = { 800, 800, 800 },
> +	.hfront_porch = { 16, 210, 354 },
> +	/* Datasheet Figure 3 indicates, that tHPW is part of tHBP */
> +	.hback_porch = { 41, 26, 6 },
> +	.hsync_len = { 1, 20, 40 },
> +	.vactive = { 480, 480, 480 },
> +	.vfront_porch = { 7, 22, 147 },
> +	/* Datasheet Figure 2 indicates, that tVPW is part of tVBP */
> +	.vback_porch = { 22, 13, 3 },
> +	.vsync_len = { 1, 10, 20 },
> +	.flags = DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_LOW |
> +		 DISPLAY_FLAGS_DE_HIGH | DISPLAY_FLAGS_PIXDATA_POSEDGE |
> +		 DISPLAY_FLAGS_SYNC_POSEDGE,
> +};
> +
> +static const struct panel_desc displaytech_dt050btft_pts = {
> +	.timings = &displaytech_dt050btft_pts_timing,
> +	.num_timings = 1,
> +	.bpc = 8,
> +	.size = {
> +		.width = 108,
> +		.height = 65,
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
> +	.bus_flags = DRM_BUS_FLAG_DE_HIGH |
> +		     DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE |
> +		     DRM_BUS_FLAG_SYNC_SAMPLE_NEGEDGE,
> +	.connector_type = DRM_MODE_CONNECTOR_DPI,
> +};
> +
>   static const struct display_timing dlc_dlc0700yzg_1_timing = {
>   	.pixelclock = { 45000000, 51200000, 57000000 },
>   	.hactive = { 1024, 1024, 1024 },
> @@ -5319,6 +5352,9 @@ static const struct of_device_id platform_of_match[] = {
>   	}, {
>   		.compatible = "dataimage,scf0700c48ggu18",
>   		.data = &dataimage_scf0700c48ggu18,
> +	}, {
> +		.compatible = "displaytech,dt050btft-pts",
> +		.data = &displaytech_dt050btft_pts,
>   	}, {
>   		.compatible = "dlc,dlc0700yzg-1",
>   		.data = &dlc_dlc0700yzg_1,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
