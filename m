Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C70A51090236
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 14:54:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BB1C10E8FF;
	Thu, 19 Mar 2026 14:54:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GaLiZ91L";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79DB910E8FF
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 14:54:09 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-485445e80bdso9026755e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 07:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773932048; x=1774536848; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=fYfxz+rNELIteGsbKAMavpc3Lvzth4lh50wrsIwCT58=;
 b=GaLiZ91LAVxgNylLfysr1fUTnhLmSvzrJQkWWcUzUooA4I9g7/cYU4xsPpCNmeQDI8
 YenUBnUKzTKJOl/d0PWmr71fgR7fUOh71uCGz/wHBfI/p+TZMt4kAgeZmU7qnYhA/iOt
 Yzw1SMCgE3aKtWSTdE7EzA7fepB4wGppZwYAbjTwLIBBys8ZDQ9DY0nhR86tqiLGLXn5
 JQA13r4fnuaMeHNSWmZVfgsSklg3+Qdhf1u1i94D4YgQYNDVUZSd5/pm25adfE3ERVDW
 Z6dkr6JGyfiVJvypkSUHbzGnmoFIjRM5dW6SW6JU/CyMFehz094AgEZQRAOkjbHJxaw/
 indg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773932048; x=1774536848;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fYfxz+rNELIteGsbKAMavpc3Lvzth4lh50wrsIwCT58=;
 b=U4lNeklfvYBEmY7aZcIGkTMhreJysDb2E6IK1SKAjIXc0VJ9Kv5w2p9ZVB1RuEgGsy
 de2UxOrQ3bTERrbwmTQUe2tKjoUhlAF4tfrG/l+W0xJfpsv9yDdMQdFeGm+cp0JM6AqQ
 jgwW1ZV4RK/xBImMl55lSmgVtz8OadBlDyEG06iZ5irBqchA5r2o11EA6KWWBmHZIYCv
 tSchgq7cXTZQixKLiqrmdmgBeOXeJmBaBUOjrgq8nwx9oOfBetzPbnFTJ65Ug1WUUQt5
 DeluVrPZlHbTL9RLrc4EL/5yYsjXOmc6Vvstv+MA8kHtmbd2PKx60SO0Q+y9xDG1BIqg
 DyIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZacrie9I+rg63m87ZClz9FTT2PJODBOwYv/7ddmRXXiLKJ+LUE6UTiNu6rz/6GUnFZavdr3YfXq4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx1IAy8DAKKE1ChpolA/G+QESTKcp/rKsxNivBRpZkQazdfCzZN
 WLRRFrJr8jhEwE0PVUFROEzrJY3uofe+xaGGOvGomF6mFWRrYGFEYE+tJcakG48q09Q=
X-Gm-Gg: ATEYQzz5SRL/HtMFT663EsHPRBexYGRVeoUS228teXq6zm2joCQnKsMMHVvpP5adf18
 HHhMPhNHTitYDwTydtOsrb2Ioy5/CpH1rV1EqhP1SIsw/XXFzzQ+LefRh8clkFQSLz6opEQz/6t
 acUEE03zIP7NyrQQCcmbuRAuOmjwZGKQsLVnyhN5uEPkCgMAhTDZe9GB8vCCwA1ueUwsoQkUsGZ
 OhHGT+M/OkzIvgvNkZpmq+rCKC10IWpui7o1Yb1TGCscUMKDYSztfyPu5EHnWpIxldRt2PntYN3
 XKr3m6mTz9T1aJN8djPFxxqvIujtBj8LYOnlW7kh44+nVxzXwdh0PKTIlXyQYeFFtoFFjVQ7pGp
 Oj8/ejo+T4eeMmpVHJ7hiLTx+bm/oyW7nAb8EmRDSrniI8WgOyRkYWySe4jSn9WljFzATOLb0p1
 DHjFskEg00QS/IyyY4Ew9b3QHfp/MVf5OASdQP+ojXHP5gm5QXJvN9RajcYvVfnH/vn370QjtdZ
 RAWgx0=
X-Received: by 2002:a05:600c:8b2e:b0:485:2a4b:7bc3 with SMTP id
 5b1f17b1804b1-486f4440fb2mr118026975e9.4.1773932047740; 
 Thu, 19 Mar 2026 07:54:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:8e54:fbaf:8cb6:e9f7?
 ([2a01:e0a:106d:1080:8e54:fbaf:8cb6:e9f7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b5184962bsm16678526f8f.7.2026.03.19.07.54.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2026 07:54:07 -0700 (PDT)
Message-ID: <3f8763af-aad2-4d92-90c8-cfd290212503@linaro.org>
Date: Thu, 19 Mar 2026 15:54:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3 4/4] drm/msm/dpu: fix video mode DSC INTF timing width
 calculation
To: Alexander Koskovich <akoskovich@pm.me>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Jeffrey Hugo <jeffrey.l.hugo@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org
References: <20260319-dsi-rgb101010-support-v3-0-85b99df2d090@pm.me>
 <20260319-dsi-rgb101010-support-v3-4-85b99df2d090@pm.me>
 <1360a31d-669e-48df-a1be-f0af4a253cd7@linaro.org>
 <3gLK4s97giqqXagfHKhfiIHbfbl2snwfOj9dcTNGPUYi10w9-1EdATqzz1LPCVTpz4bLFYOm8u_Fl8PfC7t5yabows4UCzRKVwjraEWW6hc=@pm.me>
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
In-Reply-To: <3gLK4s97giqqXagfHKhfiIHbfbl2snwfOj9dcTNGPUYi10w9-1EdATqzz1LPCVTpz4bLFYOm8u_Fl8PfC7t5yabows4UCzRKVwjraEWW6hc=@pm.me>
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

On 3/19/26 15:40, Alexander Koskovich wrote:
> On Thursday, March 19th, 2026 at 10:13 AM, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> 
>> Hi,
>>
>> On 3/19/26 12:58, Alexander Koskovich wrote:
>>> Using bits_per_component * 3 as the divisor for the compressed INTF
>>> timing width produces constant FIFO errors for the BOE BF068MWM-TD0
>>> panel due to bits_per_component being 10 which results in a divisor
>>> of 30 instead of 24.
>>>
>>> Regardless of the compression ratio and pixel depth, 24 bits of
>>> compressed data are transferred per pclk, so the divisor should
>>> always be 24.
>>
>> Not true with widebus, specify why 24 and because DSI widebus is not implemented yet.
>>
>>>
>>> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
>>> ---
>>>    drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c | 9 ++++-----
>>>    1 file changed, 4 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
>>> index 0ba777bda253..5419ef0be137 100644
>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
>>> @@ -122,19 +122,18 @@ static void drm_mode_to_intf_timing_params(
>>>    	}
>>>
>>>    	/*
>>> -	 * for DSI, if compression is enabled, then divide the horizonal active
>>> -	 * timing parameters by compression ratio. bits of 3 components(R/G/B)
>>> -	 * is compressed into bits of 1 pixel.
>>> +	 * For DSI, if DSC is enabled, 24 bits of compressed data are
>>> +	 * transferred per pclk regardless of the source pixel depth.
>>>    	 */
>>>    	if (phys_enc->hw_intf->cap->type != INTF_DP && timing->compression_en) {
>>>    		struct drm_dsc_config *dsc =
>>>    		       dpu_encoder_get_dsc_config(phys_enc->parent);
>>> +
>> Drop this change
>>
>>>    		/*
>>>    		 * TODO: replace drm_dsc_get_bpp_int with logic to handle
>>>    		 * fractional part if there is fraction
>>>    		 */
>>> -		timing->width = timing->width * drm_dsc_get_bpp_int(dsc) /
>>> -				(dsc->bits_per_component * 3);
>>> +		timing->width = timing->width * drm_dsc_get_bpp_int(dsc) / 24;
>>
>> It would be helpful to somehow show that 24 is 8 * 3, 8 being the byte width and 3 the compression ratio.
> 
> Can you clarify what the 3 represents? My panel should have a 3.75:1 compression
> ratio (30/8) so the final divisor of 24 would be wrong for my panel if its the
> compression ratio?

So my guess is that while the exact ratio on the DSI lanes is 3.75:1, the ratio
used to calculate the INTF timings is 3, then the DSC encoder probably does the
magic to feed 10bpp into a 3.75:1 ratio over the DSI lanes.

In dsi_adjust_pclk_for_compression, the pclk is adjusted to take in account bits_per_component,
so I presume the actual DSI pclk _is_  timing->width * drm_dsc_get_bpp_int(dsc) / (dsc->bits_per_component * 3),
which is your 3.75:1, but the INTF needs to generate timing->width * drm_dsc_get_bpp_int(dsc) / (8 * 3) pixels
to the DSC encoder which will emit timing->width * drm_dsc_get_bpp_int(dsc) / (dsc->bits_per_component * 3) pixels.

In any case, 24 _is_ 3 * 8, 3 being the DSC compression ratio on the INTF side.

Dmitry, Konrad, could you help confirming this ?

Neil

> 
>>
>>>    		timing->xres = timing->width;
>>>    	}
>>>    }
>>>
>>
>>
>>
> 
> Thanks,
> Alex

