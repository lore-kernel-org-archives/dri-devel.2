Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 536D1109317B
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 04:25:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C4BB10E1DC;
	Fri, 20 Mar 2026 04:25:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=marek.ca header.i=@marek.ca header.b="aw/DWKkW";
	dkim-atps=neutral
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
 [209.85.160.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3883810E1DC
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 04:25:25 +0000 (UTC)
Received: by mail-qt1-f179.google.com with SMTP id
 d75a77b69052e-509101189f4so13310341cf.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 21:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marek.ca; s=google; t=1773980724; x=1774585524; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CTWWaO+/XhoNRCAuJEz9H+WLHO2eUwKG5OIDlVViY4s=;
 b=aw/DWKkWQWXAQK2cewVWGwcgvmiIwdIfFLZ3KugKMkb8UF9Ci+7DFSD16jkv26Ve8g
 PU+SkGi2qYO8ZexRNvOSiZDsCH+tGyrNLeEr41SZtDddVq+94z7kiqebPnd6ciL8PUD1
 1HAxgeot807BTDygUo5E1HAdD0CfA8NTpwFxAoY6RRy0FBgqd/ki4SCUCRBYEu41DdkQ
 C+WIyVAfLQPg/gotUYfWdL1ty0rdhLFoYvSEvUnYoRNVDP31aBPY2tN5pqE1M0bUJk90
 sOBP3j4ggl7knQKHtxeGfnOttQkAOHqmmBcWVDzuN+W6z01VDP6d35ku6v12G8fpAdvC
 BbCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773980724; x=1774585524;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CTWWaO+/XhoNRCAuJEz9H+WLHO2eUwKG5OIDlVViY4s=;
 b=dPlsbRXLYbDZhD563XD1vr/TIoV41pw/xgSMg/WQb86nEZC0ZQcyKZX9zQGbm4m6Hf
 e65LmUXCtSDO+qfk9owuplVvqjG7W4gvfaNXwT5WhGvMskvYFnSDP3bg4LeL3TWX5b0U
 PfnzK9GMO4A4sfMk6LGKCalCLMvABNieV8r77Wx2CebIMnMqQYtsZnDEEE+VpyPqpZ7f
 KFuBD+DHOCGfes7PPgwRO1EmltRjYUGnHCzeXHOiK9+Lm/DQDMR0ipW/2Hpe9E0fCbmI
 LCdO2rFuFxhaMeu/kt9/tsYoyoVpkReNHrqOK9u9ogxwcaMZ0Crr+fbYduCGbaXaqH4x
 dlOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJjCDuobSOfzvyKo+ugNGXa8DM1cymfOb1pB1xYzQl6rEQf2PFtB4/C5NMwsVXV/lmr4zHrn+TNjk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YywvUOmmD7roiY26MtqbCl72QT/hvRnmI7icng6CHPUhQXhn8n9
 zM1FeWRTaT2xGpQlbky+BypFabNEVfLIL3eW9r0j+4ozV1aBYICjJXXgos9X+mtLwuA=
X-Gm-Gg: ATEYQzxAAvdyRHfu1IxYmFtUlfEIfTXFjP/E9t143KUZItEUUKU4GNAB8ZJ4I80Ohcz
 0meIW6RHy9xgKwNDrPkSjBgAd+PtInGw0d7KuUpch12N4t55UcG7Xo1S4i7gJFyCoAwuqmUNLfQ
 RyWqomxtwTvReCV8iXCQx0Sa0JbqUSH1KxCJOMpUl+zz6tyUdEDpBU9m+FAR9VB8dplNZjZFcDg
 g/2m2DDwNDcMmMNRKKTILu/+YGaqBycPm7wcRnglXypeYYzu+177/2I/ZB1RUvc1+gAEWSAiI/Z
 lnS1bJDbijD9E+cix8KWQ6pyzHxq8E24NgFZVHo/EchqwXlsXSlm5ZcfN622VJywJW9f2OX2SaV
 rb4HOOWmCdd+M5jwoS/M/ekk7sXzXlMdJTE3tyzs7ftBORopW6mtHJ1FFjdogqvYeJEf7JlSyYN
 Sy4y897DKhz8gJLpVdEoSawttxmhL/jpp1vd6b40c7bzDt7+w4cZSk9and0hBLMphk4ll9Qw==
X-Received: by 2002:a05:622a:1249:b0:509:1b76:e9b2 with SMTP id
 d75a77b69052e-50b37503075mr24487301cf.55.1773980724006; 
 Thu, 19 Mar 2026 21:25:24 -0700 (PDT)
Received: from [192.168.0.189] (modemcable125.110-19-135.mc.videotron.ca.
 [135.19.110.125]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89c85251e32sm12201056d6.16.2026.03.19.21.25.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2026 21:25:23 -0700 (PDT)
Subject: Re: [PATCH v3 4/4] drm/msm/dpu: fix video mode DSC INTF timing width
 calculation
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Alexander Koskovich <akoskovich@pm.me>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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
 <7fb9dd9d-13f9-7bba-93d1-08f42dd6ee38@marek.ca>
 <oihbfczsj5cg7qfjjt6jvyodjnjbezyrv6f32vmg444g5bx6ow@r54epj7ilsyt>
From: Jonathan Marek <jonathan@marek.ca>
Message-ID: <da050aad-381d-ffb7-ec7d-8ed8a80d790a@marek.ca>
Date: Fri, 20 Mar 2026 00:25:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <oihbfczsj5cg7qfjjt6jvyodjnjbezyrv6f32vmg444g5bx6ow@r54epj7ilsyt>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On 3/19/26 9:45 PM, Dmitry Baryshkov wrote:
> On Thu, Mar 19, 2026 at 01:23:03PM -0400, Jonathan Marek wrote:
...
>>
>> That's not how it works. INTF (which feeds DSI) is after DSC compression.
>>
>> INTF timings are always in RGB888 (24-bit) units. Ignoring widebus details,
>> the INTF timing should match what is programmed on the DSI side (hdisplay,
>> which is calculated as bytes per line / 3).
>>
>> (fwiw, the current "timing->width = ..." calculation here blames to me, but
>> what I wrote originally was just "timing->width = timing->width / 3" with a
>> comment about being incomplete.)
>>
> Okay. After reading the docs (sorry, it took a while).
> 
> - When widebus is not enabled, the transfer is always 24 bit of
>    compressed data. Thus if it is not in play, pclk and timing->width
>    should be scaled by source_pixel_depth / compression_ratio / 24. In
>    case of the code it is 'drm_dsc_get_bpp_int(dsc) / 24'.
> 
>    For RGB101010 / 8bpp DSC this should result in the PCLK being lowered
>    by the factor of 3 (= 24 / (30 / 3.75))
> 
> - When widebus is in play (MDSS 6.x+, DSI 2.4+), the transfer takes
>    more than 24 bits. In this case the PCLK and timing->width should be
>    scaled exactly by the DSC compression ratio, which is
>    'drm_dsc_get_bpp_int(dsc) / (3 * dsc->bits_per_component).
> 
> So, this piece of code needs to be adjusted to check for the widebus
> being enabled or not.
> 

The widebus adjustment on the MDP/INTF side is already in 
dpu_hw_intf_setup_timing_engine: the "data width" is divided by 2 for 
48-bit widebus instead of 24-bit. there shouldn't be any other 
adjustment (downstream doesn't have any other adjustment).

a relevant downstream comment: "In DATABUS-WIDEN mode, MDP always sends 
out 48-bit compressed data per pclk and on average, DSI consumes an 
amount of compressed data equivalent to the uncompressed pixel depth per 
pclk."

Based on that comment, this patch is correct, and the 
''drm_dsc_get_bpp_int(dsc) / (3 * dsc->bits_per_component)' adjustment 
only applies to DSI. (note: newer downstream looks like it would divide 
by 3.75 here, which doesn't make sense. older downstream would divide by 
3 here. I guess downstream is broken now and video mode + 10-bit dsc 
doesn't get tested?)

on DSI side, "uncompressed pixel depth" shouldn't matter either: DSI 
only sees the compressed data. But based on that comment, when widebus 
is enabled, by setting DSI_VID_CFG0_DST_FORMAT(?) to 30bpp, then the DSI 
pclk is in 30-bit units instead of 24-bits. And with this series DSI 
side ends up with the right result if 30bpp format and widebus is enabled.
