Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A90AE9A767
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 11:00:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7599310E5C8;
	Tue, 24 Mar 2026 11:00:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WTb3FN3s";
	dkim-atps=neutral
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BC2D10E667
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 11:00:26 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-82bae83318bso1960711b3a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 04:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774350026; x=1774954826; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Vg+tszAFkDYIKeCq8j/spGiQp8FN+9eBFj0O9Fz1BUg=;
 b=WTb3FN3sCvJ2m/yObdpqYdzPQa6qC25+n78K2opPtlksf/WWb2bdWifkjgc6CEWqc+
 dEYqLBnEghW85xr65kinKavRqN43j06ZonhBzAOjKd5+NusLYbfnRwTusc+jj8aXvhl+
 KwbRmNYpTq68znIgNCO7ZwIh83HMydFCaHWy14KNTPvB8TiookeRn/6ZNwf6esK82fyR
 tHIIjTJ21IiSPDPSpc2EziYvBuQQr6njXgVxDIPgcKaJGtgRd8SCU5s75iso7zNYEcTE
 3k92n0RCZQfp+sR/Li679R5QfO/DIq9/C7jDc5906480NWfSJ8tPeNk3VKHb2hMHefX7
 J72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774350026; x=1774954826;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vg+tszAFkDYIKeCq8j/spGiQp8FN+9eBFj0O9Fz1BUg=;
 b=ecEVRSBtLdKIIre355rFcpp81Jy+TB2HuuQL/G3eBxWOZCy+ngtk9yxlK54rPUBwrP
 IIiDaOY7IiUItFxQxHBbGEjud2MrgDbXEs1kamqIz7VEix7EGq3xwPbKGCvRl1Bfvq4B
 htUW3er+7PCQ92wSjTm7ynsHqs8fsTSoU55qtFbrlfeFbv1YRLckEum3SjXO/j8K8HSO
 i4vKnkw2CA0WNFx190R3qIQe9sqTZkPp+eU4JNNL3GSSyhzN9C2YSlz5aYi8NkqGPzr4
 bt97Clc1/hICl00pU2Un7OZu82U3wYXRnp1P3z5I/NyOQnWNbP8MVhkN5GXgPNQCuCqo
 o6UQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUz9R/hP6ZLUZFheEcmn2rMwCpnA/Dpz9f61e63WpI4Nx6bSvy2xrSofI0wUnkWyIa/tFFDF18+4Io=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyAgpdiyfNVUVL/N1LniBL33phbPrCMwlcZ9etTCjZbKYsHIInn
 qCv9QHeXpuFWYIcGWOcH7Z/535scNEM644y7CYpjze1dsMalTRg4KxQL
X-Gm-Gg: ATEYQzxA0w2LapnmSms3BVdwK0CTJahwPwOOoMkHH4dAy3WjdcN3nXA/vHwgNa7gfeN
 D7uS9nYoAdcwEeihT/j3dCLCeQsy7tWR4FZnGHe4Uq6WZ7CcB23Z9uLbzQ3+IVVk8gwNLkokuNl
 qHMD2DG5EPjl8WZh926Nmh6y0E/pSCEAxF2ES4mrIE3N62plSCqYiRTDDJga7uTM4VY8BO0n/yD
 ECjjj578bCeB2VyOB3qIwppTiYaff2rc9F+sEJ3WHRV6Kl50OwdnyfjLcF5L5Id2HZsa2DBNKug
 q1lHy9ew4AG0/Rgk4t7ZCRvHV0kK1INEcBHttu0+ykKkTjxjzonfEQZb2Fi1FNCG4pO1EctPj6y
 EuY7Qazm5PSGI1ErypnIC0nvSs8SyaY/atVTnvgj50S6b8CE148aZgnnUG5pwqZwwejXmMeFXCT
 0ipCzM33iMjlxF+9+koX7uYEIDlbyhkc5cctsW1CwdGdV3wuQ=
X-Received: by 2002:a05:6a00:1a89:b0:81f:b97:14a with SMTP id
 d2e1a72fcca58-82a8c3b8f88mr13871688b3a.61.1774350025354; 
 Tue, 24 Mar 2026 04:00:25 -0700 (PDT)
Received: from [172.16.20.13] ([136.226.252.245])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b03bc1e59sm12800759b3a.13.2026.03.24.04.00.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2026 04:00:24 -0700 (PDT)
Message-ID: <1ecbcd57-83d9-410c-8e1a-d6a171321ccd@gmail.com>
Date: Tue, 24 Mar 2026 16:30:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] drm: bridge: ti-sn65dsi83: Improve dual-link LVDS
 support
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Marek Vasut <marex@nabladev.com>, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, rfoss@kernel.org
Cc: Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 valentin@compulab.co.il, philippe.schenker@toradex.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20260312043743.261475-1-tessolveupstream@gmail.com>
 <9f694b2d-44bc-46ad-8aa3-b464c2f0da13@nabladev.com>
 <176ed865-11a6-42de-89e0-06951b59a430@gmail.com>
 <DH0X7QW3AH3C.PRNRA8CRSSKA@bootlin.com>
 <49b79a0d-844b-4fee-bccb-706187ed76d1@gmail.com>
 <DH5S3DYT0PJQ.11ABZFGEU6ZPC@bootlin.com>
 <a937f714-d013-4ac2-a52b-2893fc16f225@gmail.com>
 <DH6T0NTZHP93.2DWN4BWDPP331@bootlin.com>
Content-Language: en-US
From: tessolveupstream@gmail.com
In-Reply-To: <DH6T0NTZHP93.2DWN4BWDPP331@bootlin.com>
Content-Type: text/plain; charset=UTF-8
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



On 19-03-2026 19:17, Luca Ceresoli wrote:
> On Thu Mar 19, 2026 at 10:55 AM CET, tessolveupstream wrote:
>>
>>
>> On 18-03-2026 14:21, Luca Ceresoli wrote:
>>> Hello Sudarshan,
>>>
>>> On Wed Mar 18, 2026 at 6:45 AM CET, tessolveupstream wrote:
>>>>>>> You might want to look at recently posted:
>>>>>>>
>>>>>>> [PATCH 2/3] drm/bridge: ti-sn65dsi83: halve horizontal syncs for dual LVDS output
>>>>>>
>>>>>> Thanks for pointing this out.
>>>>>> I tried applying the patch “[PATCH 2/3] drm/bridge: ti-sn65dsi83: halve horizontal syncs for dual LVDS output” on top of the current tree and
>>>>>> removed the changes that I had previously added in the driver.
>>>>>> However, with this patch applied, I am currently seeing only the backlight turning on and no image on the LVDS panel.
>>>>>> For reference, the LVDS panel used on our platform is G133HAN01.1 and the
>>>>>> DSI-to-dual-link LVDS bridge is SN65DSI84ZXHR.
>>>>>
>>>>> Thanks for having tried.
>>>>>
>>>>> Can you please test with both the fixes in the series applied + the test
>>>>> pattern feature and report the results you get with and without test
>>>>> pattern enabled?
>>>>>
>>>>> The patches to apply are:
>>>>>
>>>>>  - https://lore.kernel.org/all/20260226-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v1-1-2e15f5a9a6a0@bootlin.com/
>>>>>  - https://lore.kernel.org/all/20260226-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v1-2-2e15f5a9a6a0@bootlin.com/
>>>>>  - https://lore.kernel.org/lkml/20260309-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v2-1-e6aaa7e1d181@bootlin.com/
>>>>>
>>>>
>>>> Thanks for the suggestions.
>>>>
>>>> I tested the three patches together as mentioned, but the LVDS panel
>>>> still only shows the backlight and no image. I also tried removing the
>>>> test-pattern patch and retesting with only the remaining two fixes, but
>>>> the result remained the same — only the backlight turns on and no image
>>>> is displayed.
>>>
>>> Sure, the test pattern patch does not change anything, unless you enable
>>> the test pattern.
>>>
>>>>> The first thing I suggest doing on your side is testing with the 3 patches
>>>>> mentioned above.
>>>>>
>>>>> If you display works, good! Let us know (you can also add your Tested-by /
>>>>> Reviewed-by tags to the test_pattern patch too if applicable).
>>>>>
>>>>> If it doesn't work, compare the individual register values to find the
>>>>> differences, try to figure out why the working setting works and how to
>>>>> apply that change to the driver in away that keeps other boards
>>>>> working. You're welcome to come back here to discuss it in case you can't
>>>>> find out on your own.
>>>>>
>>>>
>>>> I tested the three patches as suggested, but the panel still shows only the
>>>> backlight with no visible image. I’m unsure how to translate the working
>>>> register values into a generic fix based on display timings. Any guidance
>>>> on the right direction would be helpful.
>>>
>>> What you should do is:
>>>
>>>  1. with your patches, and while the display is enabled (and working) do
>>>
>>>      cat /sys/kernel/debug/regmap/4-002c/registers >regs.working
>>>
>>>  2. remove your patches, add the 3 I mentioned, and while the display is
>>>     enabled (but only backlight is working) do
>>>
>>>      cat /sys/kernel/debug/regmap/4-002c/registers >regs.broken
>>>
>>> Then compare regs.working and regs.broken. Which registers differ? Can you
>>> give a reason for the differences?
>>>
>>> You can come back with these values here so we may discuss them.
>>>
>>
>> I followed your suggestion and captured the register dumps in both cases.
> 
> Thanks for getting the values.
> 
>> In the working case, several of the timing registers remain at 0,
>> while in the broken case they are programmed with non-zero values.
> 
> Yes, but read the documentation carefully and you will discover this is
> OK. Also you shuld analyze all the differences, some are very interesting.
> 
> The differences are:
> 
>   reg working broken  what changes
>   12:   53      55    CHA_DSI_CLK_RANGE
>   18:   6f      0f    HS_NEG_POLARITY, VS_NEG_POLARITY
>   19:   00      05    CHB_LVDS_VOD_SWING, CHA_LVDS_VOD_SWING
>   24:   00      38    CHA_VERTICAL_DISPLAY_SIZE_LOW (*)
>   25:   00      04    CHA_VERTICAL_DISPLAY_SIZE_HIGH (*)
>   2c:   10      15    CHA_HSYNC_PULSE_WIDTH_LOW
>   34:   28      2c    CHA_HORIZONTAL_BACK_PORCH
>   36:   00      0e    CHA_VERTICAL_BACK_PORCH (*)
>   38:   00      1d    CHA_HORIZONTAL_FRONT_PORCH (*)
>   3a:   00      08    CHA_VERTICAL_FRONT_PORCH (*)
> 
> Values with (*) are those you mentioned above (zero in the working case,
> nonzero in the "broken" case). The docs for these registers says: "TEST
> PATTERN GENERATION PURPOSE ONLY". Those values are irrelevant when not
> using the test pattern.
> 
> Your timings are all different. That means probably you have them
> incorrectly described in device tree or the panel driver, so the
> ti-sn65dsi83 driver computes them using a correct formula but based on
> incorrect inputs, thus producing incorrect output values into the
> registers. What are the timings in your dts or the panel drivers? If you
> don't understand the question: what is your panel description in device
> tree?
>

Thanks for the detailed explanation.
Regarding the panel timings, they are not explicitly defined in the DTS. 
The panel is currently using the timings provided by the panel driver 
(panel-simple.c), specifically:

static const struct display_timing auo_g133han01_timings = {
        .pixelclock = { 134000000, 141200000, 149000000 },
        .hactive = { 1920, 1920, 1920 },
        .hfront_porch = { 39, 58, 77 },
        .hback_porch = { 59, 88, 117 },
        .hsync_len = { 28, 42, 56 },
        .vactive = { 1080, 1080, 1080 },
        .vfront_porch = { 3, 8, 11 },
        .vback_porch = { 5, 14, 19 },
        .vsync_len = { 4, 14, 19 },
};

The panel I am using is based on AUO G133HAN01, and the datasheet can 
be found here:
https://datasheet4u.com/pdf/1257948/G133HAN01.0.pdf > About CHA_DSI_CLK_RANGE: what is your DSI clock?
> 

In the current working configuration, the measured clock frequencies 
are:
DSI_CLK: ~422MHz
LVDS_CLK(both A & B Channels): ~70MHz
> Finally I don't think the swing values are problematic, so I'd leave them
> as the last thing to check.
> 
> Luca
> 
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

