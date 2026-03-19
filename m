Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED1951075276
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 08:35:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20CC710E90E;
	Thu, 19 Mar 2026 08:35:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SFOIlYH1";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08C6710E90E
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 08:35:01 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-43b44c0bcdbso329680f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 01:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773909299; x=1774514099; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=ZHeGhSHAyZHfpsSBccIQu+12DxQmOjEjuujaPyfYiZk=;
 b=SFOIlYH1k/P3sd+/HSa5Zftf7PrVlPay8AftbsvdBsO4q+NyhqGvnPTqpPwLJJrgqk
 PJt2TDjZ7TmZbxErNeVOGUdkZJSZm9Lj6rJfHNUFN2Wdt0a7v9EiOvhEuUHPm1cNYsyX
 8YDjNEuTOWviWFkv333sSAEcPBD6jMcaM1p76kLJ83wLTODYraD/ylJixpqeJtEfQImn
 q7If8TuVaet3u3tMv63eamc8KBjoPLViYsB3fBEAwxZdoW66c8tMWTAImGEuCAwAs8s2
 wchZPD2HGQUe6la1HydG749wHwIN9HL/mMCreBDxijlEQTBSbtAEyoLTlv5imDq/iMEy
 ilZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773909299; x=1774514099;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZHeGhSHAyZHfpsSBccIQu+12DxQmOjEjuujaPyfYiZk=;
 b=DX4dn/nf5yZnYvuvfnamyoUgzOmRdD5PBEoEwbfBwJbZPsg8qD9Hh1n8FSaL1Wecgg
 gg9TL5VLdM+3kdyZzbj1xx4v76JqvO/5AbCHt8rn6Z2n3nm/rqmD39UiYHib9wgwAcki
 kOuq1B5ST2wIqUlKTepfAXi7u2GJ2MJLtSEbSpg4n/Tcy1SPrnGQ9dEZJ71dtROEny54
 CV/PoTO3ogL4uMW4LKkuePA96T9VPZ4eJCSFvUvI2cAvirtZGG6rLZrS0QEdszwfPhKr
 WRqLQGzvobG9kDAyjLA6RVmauabyHOEYK6svM4IPNcMNMIBy4qBUO7jczJdFZnZ9Qz+6
 yprw==
X-Gm-Message-State: AOJu0YxMpl6EeOCYdo5+xPnNPBJch+BxJmVd4c+PMqyMBtI6RAGTYZot
 Cp+wSj00csqh0vFlkHK695RFxfL89eR+xC4xb7Q8D2U9eiGzh7nEiyiPXYYM0VVH+lw=
X-Gm-Gg: ATEYQzw8jf2hEIiVji+appe55zBTBaqbbO32qikzeL87JHUDKEaeNj8l3KADVGfRceY
 CeCHvN3y1CH8jGBaXS0BiQq7qbE+5bRifxi32upijD2GEk/FNNQ8r1LGMArMoRgxiBlBgph/E7Z
 15Uo4dpnvamE27YIL2jsMOI02qjbaIO5sczypnk/OJ6FoLbWxtxPnPBCyi4oikZP1ouSs5sR5sQ
 a7jG44SPx6bOvIBPeITFtQrRs8Gv58t7Sgw7QN+JdPRfd9/bhgQdzHK5LWpg7lyF9s60ReIh//t
 iNfjjL4xX1IYYCvH4TU8CKYeY3jUaWcZ97PGca1Usay8hLVGscbt17jd1bxXP9jb8AjIROmXTaT
 /ny7g9It8ba1XHEX3FwLVRwMC905kYQbczOemvEVMd+irH1Fg1LaS8NKzrChDg0F3k7aTk4AN5S
 9/bSa/ZmrACrjwpIU3NZGyUiRVEjUttj9Dwm5KaESAgBhCgiqZpm2vRfdKO9GzQL91QmaPG2xqg
 rGFHq0=
X-Received: by 2002:a05:600c:3551:b0:485:3e00:9440 with SMTP id
 5b1f17b1804b1-486f4474b56mr107037965e9.24.1773909299273; 
 Thu, 19 Mar 2026 01:34:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:8e54:fbaf:8cb6:e9f7?
 ([2a01:e0a:106d:1080:8e54:fbaf:8cb6:e9f7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f4ba73b4sm39934325e9.22.2026.03.19.01.34.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2026 01:34:58 -0700 (PDT)
Message-ID: <c9d14a74-8e59-43bb-827b-577c8f675c8f@linaro.org>
Date: Thu, 19 Mar 2026 09:34:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] drm/msm/dpu: fix video mode DSC INTF timing width
 for non 8 bit panels
To: Alexander Koskovich <akoskovich@pm.me>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
References: <20260318-dsi-rgb101010-support-v2-0-698b7612eaeb@pm.me>
 <20260318-dsi-rgb101010-support-v2-3-698b7612eaeb@pm.me>
From: Neil Armstrong <neil.armstrong@linaro.org>
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
In-Reply-To: <20260318-dsi-rgb101010-support-v2-3-698b7612eaeb@pm.me>
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

On 3/19/26 05:00, Alexander Koskovich wrote:
> Using bits_per_component * 3 as the divisor for the compressed INTF
> timing width produces constant FIFO errors for panels such as the BOE
> BF068MWM-TD0 which is a 10 bit panel.
> 
> The downstream driver calculates the compressed timing width by
> dividing the total compressed bytes per line by 3 which does not depend
> on bits_per_component. Switch the divisor to 24 to match downstream.
> 
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> index 0ba777bda253..9b046a0e77aa 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> @@ -122,19 +122,21 @@ static void drm_mode_to_intf_timing_params(
>   	}
>   
>   	/*
> -	 * for DSI, if compression is enabled, then divide the horizonal active
> -	 * timing parameters by compression ratio. bits of 3 components(R/G/B)
> -	 * is compressed into bits of 1 pixel.
> +	 * For DSI, if DSC is enabled, use a fixed divisor of 24 rather than
> +	 * bits_per_component * 3 when calculating the compressed timing width.
> +	 *
> +	 * This matches the downstream driver and is required for panels with
> +	 * bits_per_component != 8.
>   	 */
>   	if (phys_enc->hw_intf->cap->type != INTF_DP && timing->compression_en) {
>   		struct drm_dsc_config *dsc =
>   		       dpu_encoder_get_dsc_config(phys_enc->parent);
> +
>   		/*
>   		 * TODO: replace drm_dsc_get_bpp_int with logic to handle
>   		 * fractional part if there is fraction
>   		 */
> -		timing->width = timing->width * drm_dsc_get_bpp_int(dsc) /
> -				(dsc->bits_per_component * 3);
> +		timing->width = timing->width * drm_dsc_get_bpp_int(dsc) / 24;



@bits_per_component: Bits per component to code (8/10/12) <= how the DSC pixels are encoded in the stream
@bits_per_pixel: Target bits per pixel with 4 fractional bits, bits_per_pixel << 4 <= the target display pixels

- bits_per_component is the transport width
- bits_per_pixel is the display width
- 3 is the DSC compression ratio

So for a RGB101010 DSC display bits_per_pixel should be 10 << 4

But here you say bits_per_component should be 8 ? can you share the downstream config of your panel ?

Are you sure about the bits_per_component & bits_per_pixel values you set in the dsc parameters ?

Neil


>   		timing->xres = timing->width;
>   	}
>   }
> 

