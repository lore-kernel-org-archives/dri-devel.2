Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47697C53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:33:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D6BA10E1F5;
	Tue, 28 Jul 2026 15:33:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FSztAphg";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58D9310E1F5
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 15:33:29 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-476a130c138so20567f8f.0
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 08:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785252808; x=1785857608; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UZl7ZZQdX8R89+NK2xNbSunu1MDvLENG3pDreEWWuxw=;
 b=FSztAphgga787lZg4sJmnxcC/CxG1drJG0fU2AUWwVZiNGBUgaLR5XY5jkSuLhqdny
 JKHo+rGeVbN3FEfT0ha9IBHnSiIl+mtgEV4wkRWxZQclyqpyI7dCRxy4zOlNJDHH6CpV
 OM5OaqHszlXVIDG2Q5Vxigcgrd9dT+ym4hVJIojGjXHsUOXg6MWLRC+NZXFdNpWNYIeZ
 naVGKzIFY6+GgeI1kEKqgIO41V68ZJMqL40Er40FdbDvsoucSGzbuVyEj6yuispwreO+
 TBbU+p+B4WbPwzCDdNL8Is0RFkYSxO0nBs6hByTKugFmiX4H5WGVE9P9I/1i4UC0abs3
 Tq0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785252808; x=1785857608;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UZl7ZZQdX8R89+NK2xNbSunu1MDvLENG3pDreEWWuxw=;
 b=NqC0oevJQ241+yrQmfJpDC1RheikXOg6yap091BM8RZyKd2pSkmsSGqYDQKw13pFU4
 FGCLlv3ADIl1UERYKFByacdGZ2agETzRDFyFuVOIycGyCFyy38aUfmSFHwK4Kk+gwvK/
 Zv4bAe4b+sVBP7MEJfvn1f/ieG7K6VaYyXHdW6+TzutmTfqjWosxtVQL/j6+NQmSpMXM
 UhKIldBrMmwg9SOsclEYBKQFmNyXOgGFwYjH24f+Vwr+Fu8PLNBf7mWxd+F4tN+RJxeZ
 lBn59pLpb2ckZwuH4//7yjrbyoq5upJjJOhDZlzxUnneqRMwvRWOrLGI1W3EgXpuJPUu
 CQyA==
X-Gm-Message-State: AOJu0YzWECPudiVJGI/USa5pNO4BHyWmJ+iAmS+3uYeBXXsVRHt2Jpu6
 T5o+e3dOUhyzV9kcKMjM+3vkp8ITLQN9U5CtDuQHhNxCJLr18izENU4vSTc/fjXegW8=
X-Gm-Gg: AR+sD11tWxfvMaFgr231ClqP8UHi/Sk/wwvpVjuFWitJSMb7Par5e9A6NmmF3Xp/647
 EWDQwPHKNSt+nDU3o/zBQ+0fugxZveOC2V/lAeun1MQ9LQeNHhIpwXQ3XzaAUaJ1jlRemrVvUwT
 7SJKse0ZBT5x0LVQ6w4Yc3QuWSHthFT5gBxueb9WVTNAA5qbYCv04vaBRPmbkq0beTvJN8+QhIk
 gu+bBCC3gay8Hcds1CZ8A31JlxEiHVFEd7I8A3F0cvn4wxrJEB0senMcE76MKoyWJjWzWS9diyV
 jItFy3FIqkyZ+E1iGogkHf03ViFAsXe9cafc43UOoXfCk5jMHtcifZ/F0flpdTmZ5gZcxLHjte+
 J+tUJePp7A9LHWzHV1DPszGks30gxiCGmTzD8mwSbMaeUfMmb+edNaVzQTIoOZ/2I3awsHOMfSL
 8PKQ5p+3b+X1ls6KaTfPtYUTmhTwx+oWfQk5okJo+CdOZb4BlACRFMiYoF2rFKDR8W+zLu
X-Received: by 2002:a05:6000:240d:b0:47f:928e:21f7 with SMTP id
 ffacd0b85a97d-47fb1ef25a6mr3770755f8f.55.1785252807601; 
 Tue, 28 Jul 2026 08:33:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:6843:9af3:9745:9034?
 ([2a01:e0a:106d:1080:6843:9af3:9745:9034])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c52fc0sm59232935f8f.23.2026.07.28.08.33.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2026 08:33:27 -0700 (PDT)
Message-ID: <36c73363-faa0-458b-92f3-31096ebc6139@linaro.org>
Date: Tue, 28 Jul 2026 17:33:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] drm/panel: chipone-icna35xx: Fix picture parameter set
To: webgeek1234@gmail.com, Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260727-icna35xx-pps-v1-1-691d79d13ee4@gmail.com>
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
In-Reply-To: <20260727-icna35xx-pps-v1-1-691d79d13ee4@gmail.com>
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

On 7/28/26 03:02, Aaron Kling via B4 Relay wrote:
> From: Aaron Kling <webgeek1234@gmail.com>
> 
> These ddic's do not handle the standard mipi dsi command for pps.
> Instead, there are per chip vendor commands to write the packed struct
> directly to manufacturer registers.
> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>

Any Fixes tag ?

> ---
> This patch results in no change at runtime because the ddic defaults to
> the config being set by the existing mode. The issue was found while
> doing testing running the panel in a 10-bit mode. But since it is a real
> problem, better to fix it early.
> ---
>   drivers/gpu/drm/panel/panel-chipone-icna35xx.c | 20 ++++++++++++++++++--
>   1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-chipone-icna35xx.c b/drivers/gpu/drm/panel/panel-chipone-icna35xx.c
> index 2cc16494a4cef..b2422ffc1d1c5 100644
> --- a/drivers/gpu/drm/panel/panel-chipone-icna35xx.c
> +++ b/drivers/gpu/drm/panel/panel-chipone-icna35xx.c
> @@ -69,6 +69,7 @@ static int icna3512_init_sequence(struct panel_info *pinfo)
>   {
>   	struct mipi_dsi_multi_context dsi_ctx = { .dsi = pinfo->dsi };
>   	struct drm_dsc_picture_parameter_set pps;
> +	u8 *pps_ptr = (u8 *)&pps;
>   
>   	pinfo->dsi->mode_flags |= MIPI_DSI_MODE_LPM;
>   
> @@ -91,7 +92,14 @@ static int icna3512_init_sequence(struct panel_info *pinfo)
>   	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x48, 0x20);
>   
>   	drm_dsc_pps_payload_pack(&pps, &pinfo->desc->dsc);
> -	mipi_dsi_picture_parameter_set_multi(&dsi_ctx, &pps);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x9F, 0x01);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xC6, 0x11, 0x88);
> +
> +	mipi_dsi_dcs_write(dsi_ctx.dsi, 0xC7, pps_ptr, 32);
> +	mipi_dsi_dcs_write(dsi_ctx.dsi, 0xC8, pps_ptr + 32, 32);
> +	mipi_dsi_dcs_write(dsi_ctx.dsi, 0xC9, pps_ptr + 64, 24);
> +
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xFD, 0xA5, 0xA5);
>   
>   	mipi_dsi_msleep(&dsi_ctx, 20);
>   
> @@ -104,6 +112,7 @@ static int icna3520_init_sequence(struct panel_info *pinfo)
>   {
>   	struct mipi_dsi_multi_context dsi_ctx = { .dsi = pinfo->dsi };
>   	struct drm_dsc_picture_parameter_set pps;
> +	u8 *pps_ptr = (u8 *)&pps;
>   
>   	pinfo->dsi->mode_flags |= MIPI_DSI_MODE_LPM;
>   
> @@ -133,7 +142,14 @@ static int icna3520_init_sequence(struct panel_info *pinfo)
>   	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xB2, 0x24);
>   
>   	drm_dsc_pps_payload_pack(&pps, &pinfo->desc->dsc);
> -	mipi_dsi_picture_parameter_set_multi(&dsi_ctx, &pps);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x9F, 0x01);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xC0, 0x1A, 0x71);
> +
> +	mipi_dsi_dcs_write(dsi_ctx.dsi, 0xC1, pps_ptr, 32);
> +	mipi_dsi_dcs_write(dsi_ctx.dsi, 0xC2, pps_ptr + 32, 32);
> +	mipi_dsi_dcs_write(dsi_ctx.dsi, 0xC3, pps_ptr + 64, 24);
> +
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xFD, 0xA5, 0xA5);
>   
>   	mipi_dsi_msleep(&dsi_ctx, 20);
>   

Otherwise it looks good.

Thanks,
Neil

> 
> ---
> base-commit: 0d33d21e47d9dc66f91e44da3fc9220c74d93df7
> change-id: 20260727-icna35xx-pps-bdd353e188cc
> 
> Best regards,

