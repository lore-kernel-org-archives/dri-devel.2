Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6137F1090231
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 14:09:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE50910E915;
	Thu, 19 Mar 2026 14:09:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BzSgA2hL";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA79E10E910
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 14:09:16 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-43b3d9d0695so770275f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 07:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773929355; x=1774534155; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=No+jRdZXBH1kzO/iwEkAzBKEfmzYF8fD5kLubhT3iAY=;
 b=BzSgA2hLs18CEsiSVumrVSxFlOqMmh9yOopdd1T2ZOcLv3mQ/LvOr9S0cqUUNGFPLj
 iB4H8YLg05ZZ/RwA88hiHQZzm6joUe7UbNkMSJpIl86SN0l2p2FWejIqNOd79V0SlTL+
 g0p4DgepsFgOZ21TUtS9hk6J/yH3m4cTrIonvXiqOwfRd2iCuyt1S73nYO0NTguzMlfr
 xeuPPCSl5w4pTxZtl/ElvL/SjHoGu5qo4eqLwuRuuoOxaWjBO1rnvQWbYExesdqmD0RL
 XbhyQvfZEVxrCNjWz3Jk68g2QL4kfPgp7XKvIi7W5JeB3VmIfnQk0COAjbJAgujzA278
 yWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773929355; x=1774534155;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=No+jRdZXBH1kzO/iwEkAzBKEfmzYF8fD5kLubhT3iAY=;
 b=iRj+vX+w58YzGg8EzGdgFv5cYeb1GUUbEiBhXKdYa2GK/2ZPHNM/DJksha7DPtK6S7
 dR7QHp37Ydo7rTBer5kmrA3Xy8epTc/gvchOTHC6uzlVylk877ghpyl2CCRurVyIv+Mt
 VSiH6/yhVOKU+z/4qeJt/K5QFn3nAeSLvTQTPyTVy0hEBDotozqpdlbwrtKXP7viIqGI
 rcrGRpdvHXCUl7AhCyvwlDhgOLI4n2fT2IOf4b8hb0zPo+b1pCJ8T6KsenRyk4d382qu
 xV4Dd/DnixxfRvgGY8DrllKkkGOl/KBxv6l7gEzTybnUlV4mbZRsqqFwxeXGzzb7mNcp
 Pt2g==
X-Gm-Message-State: AOJu0YwSR2AfwMbvxk4EpAg8ecKLI9R2HpSHuafBXOgtKC/eGBfBJt62
 h10tEi0v0LLHCX78Qm1ZLec4I4lgDVGBBiNgEKPiWfjQbwt3fvr/a/STd8w4IiBRE9E=
X-Gm-Gg: ATEYQzzl1VF/tFvMC5+5dg3a8EP5aTBdMOEvVEL5vCIm+IYrsssXHWm97Y8lpULUf83
 Nx/FKSmg/CRPZWIRb4hqrNTvg9bgdbnPuRSAj1s313g/etwYMpj4ZOaSL26ymFCNDL2Wd7H0pjP
 5eFViKJH1H8iaJsSlN1WxWJjj+utkecv5lz+UK4jI8OlllR2hraSSu/Ulgh05cKtCOdAlKsc+SR
 Y5ljHaxDW9cvcmhL38Q1XdzhZcyWIqB24uckmyV161rsBFwgix11wy8OH+oYx2qPry0ODuG5Pia
 D57zMUMXC29HcEu6+1gb7LpCmAr2aI7O1ZQTzarNB2O1/vvVMBfNpUNDYwV83/2A9slQ/nMlmV2
 N7wB0zag2+V0cyZaZccTUfN4jBj6G9WJ8d3TtlvOLdzM9k05uG6D+4OpWTSC5WRpEcfWobfCR5S
 IAjzA6nSqOatMGDx7nNy/myd5zxUHS64sQ6zDDf5ZvGqjvQgqqAOMFJVUimYFv1PMIU9NDiByql
 3clDt8=
X-Received: by 2002:a05:6000:2d83:b0:43b:45c6:7ad with SMTP id
 ffacd0b85a97d-43b57732e56mr4966729f8f.29.1773929355079; 
 Thu, 19 Mar 2026 07:09:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:8e54:fbaf:8cb6:e9f7?
 ([2a01:e0a:106d:1080:8e54:fbaf:8cb6:e9f7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b5184957bsm17789468f8f.5.2026.03.19.07.09.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2026 07:09:14 -0700 (PDT)
Message-ID: <1360a31d-669e-48df-a1be-f0af4a253cd7@linaro.org>
Date: Thu, 19 Mar 2026 15:09:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] drm/msm/dpu: fix video mode DSC INTF timing width
 calculation
To: Alexander Koskovich <akoskovich@pm.me>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
References: <20260319-dsi-rgb101010-support-v3-0-85b99df2d090@pm.me>
 <20260319-dsi-rgb101010-support-v3-4-85b99df2d090@pm.me>
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
In-Reply-To: <20260319-dsi-rgb101010-support-v3-4-85b99df2d090@pm.me>
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

Hi,

On 3/19/26 12:58, Alexander Koskovich wrote:
> Using bits_per_component * 3 as the divisor for the compressed INTF
> timing width produces constant FIFO errors for the BOE BF068MWM-TD0
> panel due to bits_per_component being 10 which results in a divisor
> of 30 instead of 24.
> 
> Regardless of the compression ratio and pixel depth, 24 bits of
> compressed data are transferred per pclk, so the divisor should
> always be 24.

Not true with widebus, specify why 24 and because DSI widebus is not implemented yet.

> 
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> index 0ba777bda253..5419ef0be137 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> @@ -122,19 +122,18 @@ static void drm_mode_to_intf_timing_params(
>   	}
>   
>   	/*
> -	 * for DSI, if compression is enabled, then divide the horizonal active
> -	 * timing parameters by compression ratio. bits of 3 components(R/G/B)
> -	 * is compressed into bits of 1 pixel.
> +	 * For DSI, if DSC is enabled, 24 bits of compressed data are
> +	 * transferred per pclk regardless of the source pixel depth.
>   	 */
>   	if (phys_enc->hw_intf->cap->type != INTF_DP && timing->compression_en) {
>   		struct drm_dsc_config *dsc =
>   		       dpu_encoder_get_dsc_config(phys_enc->parent);
> +
Drop this change

>   		/*
>   		 * TODO: replace drm_dsc_get_bpp_int with logic to handle
>   		 * fractional part if there is fraction
>   		 */
> -		timing->width = timing->width * drm_dsc_get_bpp_int(dsc) /
> -				(dsc->bits_per_component * 3);
> +		timing->width = timing->width * drm_dsc_get_bpp_int(dsc) / 24;

It would be helpful to somehow show that 24 is 8 * 3, 8 being the byte width and 3 the compression ratio.

>   		timing->xres = timing->width;
>   	}
>   }
> 

