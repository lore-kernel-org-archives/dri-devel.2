Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C29EF10854D2
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 17:23:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34C0510E90A;
	Thu, 19 Mar 2026 17:23:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=marek.ca header.i=@marek.ca header.b="TRoqjIQb";
	dkim-atps=neutral
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEF7A10E7DD
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 17:23:27 +0000 (UTC)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-8cb4136d865so162436385a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 10:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marek.ca; s=google; t=1773941007; x=1774545807; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ja7EO2H78kHpMisRkGGD8HVMRsNc2KCgajfwyEKarFA=;
 b=TRoqjIQbkpQuucSx8/2lqjsHDdQLw7iVkFftn1VHOfXh8RrJBKbnBBVwP2TJKP7iIv
 +g9valpvRVejxGn+iedie3NiZFyUxlm1og17DknOuJ8UHxBTby32JVefpuclN8C2bCcV
 TNhTeLGaewin3fOlj9ZvRAGvcS3yttQiAoCijxGBjuGGjxX9AzH8SsgAak3X/r/zbGYJ
 Ve22gl+UzVsWZwEgjKEb63fekCc5JGnwjpQ0TlBXs8uHTcEr/9t7WNhBlehJ0W51WtOy
 umhB7hqWs7oeDzGs2C+xWT95u/RipSCLoCnP6SUf1lVjY8MzqV/tTAMQssI//KT1WXZZ
 sOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773941007; x=1774545807;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ja7EO2H78kHpMisRkGGD8HVMRsNc2KCgajfwyEKarFA=;
 b=tTS4WtyJcYEF4cdhm3jO8dDczNazVENCf5eZ5f5D8cwQTuL3iDdvCfHWWj4COCtHPX
 UUxpv+gIIQeGFme8OIMIKUgBN5Jzk4fj7CfFaqv9Ca7FiOqT70DGZ32l02y3wdFCWXEh
 ob8M/PEoJ2srO/8ZOdvkMHRZEtj5ksdPlRuuIOruKGVB0NPU1FK1dEY21V1PwN8+UPXS
 90Y46FbqqUmteqqHGXpe8BFkRofWDMsJ2wnOMndvJmGrkljUgJhSri2qT10SErWjqQq0
 rqzA8PcO1wnRj8qYCckug+wTT8EjjDMqjLQiPH2S6GsEmA4L220M218G4fSWQAy4i8Q0
 uNaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW66BHrpRIHqEzmEZUoJQx1VHC5GUGt0QlI+nIBBfx86Um5n8Ec/lUJMhkKFfmspEmPHmoAFXiKiUQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxm+3XUA5glXb/KNOfyUsm0jQqLGw60pd5yPAe1oc3OXRyd5Lud
 OtpMolePkfmVNXShJcf1fpXaX/vC3cniHWIrU/IVb8eneulWlRZuvdj/KNCkRAL2FCY=
X-Gm-Gg: ATEYQzy4qO5VTAQJ0v+38o9lwCD+gt1MEUM+Wxyq5kzk73otdO51uU0nh4sujHQaEdm
 jePwVrhp1Lee3BpWvg7TK/BKvJpXEPxbBklFzWfUr7YGcmq/+st1TSY5kU1sae0D0nog5kOXFAr
 8RonukIejFuad8L0o2GpL4R+CSOcHcqgC85VUkgBpCKP2Oqhu4geOf4x/QYbX9Ktbu33oWWBqka
 L8AuQUMIwfjbY2zQ1+G9nKMWWFTIHuVv7H1UbmzBlyh7AoZX7FGzwt9uBjFmTeYh9+eqmJbNzKx
 LXdcM+TpHow0R9dnNEU49MS0Xzc+Q70MqoijBCHxRc+07oTxmuz5b+ol7fAAERRYcW0VbW0VvhV
 0J2UQR4ee5IvCo3cLBj+98ESWwJ3QpltAniRhFv6Zna8FlGbr1lW4JO5KuUmynt22ZYi1ThqOxX
 DpSrpCki/ePMFOUBRQuwkgTYq+l+7/jY8NPA5+xDXke63MbrYIPFTIFMNtaHJfyXRs1Tlz9A==
X-Received: by 2002:a05:620a:28ce:b0:8cd:8f18:d1f4 with SMTP id
 af79cd13be357-8cfc7b788f0mr8360585a.6.1773941006423; 
 Thu, 19 Mar 2026 10:23:26 -0700 (PDT)
Received: from [192.168.0.189] (modemcable125.110-19-135.mc.videotron.ca.
 [135.19.110.125]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89c8521521dsm1516736d6.8.2026.03.19.10.23.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2026 10:23:26 -0700 (PDT)
Subject: Re: [PATCH v3 4/4] drm/msm/dpu: fix video mode DSC INTF timing width
 calculation
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Alexander Koskovich <akoskovich@pm.me>
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
 <3f8763af-aad2-4d92-90c8-cfd290212503@linaro.org>
From: Jonathan Marek <jonathan@marek.ca>
Message-ID: <7fb9dd9d-13f9-7bba-93d1-08f42dd6ee38@marek.ca>
Date: Thu, 19 Mar 2026 13:23:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <3f8763af-aad2-4d92-90c8-cfd290212503@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On 3/19/26 10:54 AM, Neil Armstrong wrote:
> On 3/19/26 15:40, Alexander Koskovich wrote:
>> On Thursday, March 19th, 2026 at 10:13 AM, Neil Armstrong 
>> <neil.armstrong@linaro.org> wrote:
>>
>>> Hi,
>>>
>>> On 3/19/26 12:58, Alexander Koskovich wrote:
>>>> Using bits_per_component * 3 as the divisor for the compressed INTF
>>>> timing width produces constant FIFO errors for the BOE BF068MWM-TD0
>>>> panel due to bits_per_component being 10 which results in a divisor
>>>> of 30 instead of 24.
>>>>
>>>> Regardless of the compression ratio and pixel depth, 24 bits of
>>>> compressed data are transferred per pclk, so the divisor should
>>>> always be 24.
>>>
>>> Not true with widebus, specify why 24 and because DSI widebus is not 
>>> implemented yet.
>>>

DSI widebus is implemented, and always used when available. The 
adjustment for DSI widebus just doesn't happen in this function.

>>>>
>>>> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
>>>> ---
>>>>    drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c | 9 ++++-----
>>>>    1 file changed, 4 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c 
>>>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
>>>> index 0ba777bda253..5419ef0be137 100644
>>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
>>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
>>>> @@ -122,19 +122,18 @@ static void drm_mode_to_intf_timing_params(
>>>>        }
>>>>
>>>>        /*
>>>> -     * for DSI, if compression is enabled, then divide the 
>>>> horizonal active
>>>> -     * timing parameters by compression ratio. bits of 3 
>>>> components(R/G/B)
>>>> -     * is compressed into bits of 1 pixel.
>>>> +     * For DSI, if DSC is enabled, 24 bits of compressed data are
>>>> +     * transferred per pclk regardless of the source pixel depth.
>>>>         */
>>>>        if (phys_enc->hw_intf->cap->type != INTF_DP && 
>>>> timing->compression_en) {
>>>>            struct drm_dsc_config *dsc =
>>>>                   dpu_encoder_get_dsc_config(phys_enc->parent);
>>>> +
>>> Drop this change
>>>
>>>>            /*
>>>>             * TODO: replace drm_dsc_get_bpp_int with logic to handle
>>>>             * fractional part if there is fraction
>>>>             */
>>>> -        timing->width = timing->width * drm_dsc_get_bpp_int(dsc) /
>>>> -                (dsc->bits_per_component * 3);
>>>> +        timing->width = timing->width * drm_dsc_get_bpp_int(dsc) / 24;
>>>
>>> It would be helpful to somehow show that 24 is 8 * 3, 8 being the 
>>> byte width and 3 the compression ratio.
>>
>> Can you clarify what the 3 represents? My panel should have a 3.75:1 
>> compression
>> ratio (30/8) so the final divisor of 24 would be wrong for my panel if 
>> its the
>> compression ratio?
> 
> So my guess is that while the exact ratio on the DSI lanes is 3.75:1, 
> the ratio
> used to calculate the INTF timings is 3, then the DSC encoder probably 
> does the
> magic to feed 10bpp into a 3.75:1 ratio over the DSI lanes.
> 

That's not how it works. INTF (which feeds DSI) is after DSC compression.

INTF timings are always in RGB888 (24-bit) units. Ignoring widebus 
details, the INTF timing should match what is programmed on the DSI side 
(hdisplay, which is calculated as bytes per line / 3).

(fwiw, the current "timing->width = ..." calculation here blames to me, 
but what I wrote originally was just "timing->width = timing->width / 3" 
with a comment about being incomplete.)

> In dsi_adjust_pclk_for_compression, the pclk is adjusted to take in 
> account bits_per_component,
> so I presume the actual DSI pclk _is_  timing->width * 
> drm_dsc_get_bpp_int(dsc) / (dsc->bits_per_component * 3),
> which is your 3.75:1, but the INTF needs to generate timing->width * 
> drm_dsc_get_bpp_int(dsc) / (8 * 3) pixels
> to the DSC encoder which will emit timing->width * 
> drm_dsc_get_bpp_int(dsc) / (dsc->bits_per_component * 3) pixels.
> 

The hdisplay calculation in dsi_adjust_pclk_for_compression (which only 
affects the clock rate) seems to be wrong, and I think Alexander's panel 
must be running at a 20% lower clock because of it. dsi_timing_setup has 
the right hdisplay adjustment.

> In any case, 24 _is_ 3 * 8, 3 being the DSC compression ratio on the 
> INTF side.
> 
> Dmitry, Konrad, could you help confirming this ?
> 
> Neil
> 
>>
>>>
>>>>            timing->xres = timing->width;
>>>>        }
>>>>    }
>>>>
>>>
>>>
>>>
>>
>> Thanks,
>> Alex
> 
