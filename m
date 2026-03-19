Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96BD7107528A
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 09:55:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE8B310E7E0;
	Thu, 19 Mar 2026 09:55:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qx3UOR+/";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D48E810E7E0
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 09:55:03 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-c741692db4cso204144a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 02:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773914103; x=1774518903; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r1/D9HJg8CdQe3sCd1w5lE5XoL+bpuuZ1Z5WHjbt018=;
 b=Qx3UOR+/xTdTas9e0NbZxI6d21O/C3j+C3B/a48M4feWJR4awojof4AUOvvetPJzRT
 /CWopjpwuu+Cz0cYZr1EalqmAA7+q7J8LKH+I19hv8dVaXezRlq+sKaVnCJqvyuK9FMY
 /xUKwc48//6ElFjzgxG09aQTjVAZMERBBC6+GUs61pYYs/OMj9aBuKiY+eHQnRJT7y6l
 Fa3PoL6qfJQZYtRo9/YgwVPJme3L+tYYCGl9Dz6UYIV33HNjrduFaTDAgtMWndgi7tF1
 L17JiftD1/Yox914zM5+lX9AcfJKlmGTlQ9+ehJnWLurQTF0uZBB32vvcrQ3crhDlf2s
 ISXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773914103; x=1774518903;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r1/D9HJg8CdQe3sCd1w5lE5XoL+bpuuZ1Z5WHjbt018=;
 b=c6v4Jqdi1Mkzm732gqv6ljmflPr01fu+QrxG11Ny1VfpPZxqJHv2ACuTRgVSKe8Kat
 IkuOg1eZMieH6bWGHUr/UE+/8ILpPYABr8/uJG2gxY2e3nn1X00gcgGFhhsgkRVIu63N
 yk0QDq16+Iyx2jpSO4XJytOz6FCcMYC3fOR9iFHYTAQ7Kh2XG21Jc1JweaqoY/JYyKIs
 9cDAQY/u8BbvdZIzt043+ox3c9ehwomd6YzbRN9VqjQsIlSMdpyoQXScooUsyfpGYmdj
 EXb3byWBSuC7TwsS5riQiQ+IW3YcO1w3ZjrL0BntvHv+zz3AO3n3Oi6IWtXjHQalrivB
 1mSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpw3ckSybWheGq1BVLWDb/hEz0RjkKsdvKk7Pn3/M37M595mofmJfiteZVh8r00CXaCgV/61bNN/U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzxRbm/Wph9hy6tCld8LizIA/jCklGyqkhL9kwKHKW2lJJhU8an
 wpdO2HtiOA8FQA+x3RahbyWfUDGOeuYgdYB17Jcp6Xpfe213kFujVZYGpHvSaQ==
X-Gm-Gg: ATEYQzxo+nQQVhehaPMjfjy8BV+Pj0HE1hpE/HC8ECzyjCORkrWRIVgH8q0gswQlJzv
 LiCh8vE4SBpLmt/D7ta8YJSUQYHY4MnU3NhQmMcEgi7c71w216SD8GZ1kfTQKsKcsc81adnMwww
 a1FK+VGotBWOAZp2knTZ7+UJ3hgyC5bGVr32Pz8qJd48qn2+KCRbJVyLO+67LI1HY0Q83d+RdIC
 7l5+KevLjM49JlRsMiY5uBJ49rA8OfvOC6P6Y7UUC0FGu5XDJEpKIfuY+VsRheabdUcCTNgsnEQ
 2dq8A540Epe/JMvT/ix5DtzWomfAuZ76dpKkK4ym/UfD7zg1TVpaDzqPvgUQlcEzpCQjZwL7ouR
 hzY96a4TG989i2HsfjMjzvovZEnh8F2a/PflblzZL7QtLUyc6uuqktLRNZMt9uJVxO+fgppvX7z
 0oXtdaMbFs/VizSZofQo+DkQlmxuOn5CQoBU3UsZfyCabb+Gw=
X-Received: by 2002:a05:6a21:7d03:b0:39b:8571:3051 with SMTP id
 adf61e73a8af0-39bb25aabf2mr2527165637.28.1773914103190; 
 Thu, 19 Mar 2026 02:55:03 -0700 (PDT)
Received: from [172.16.20.13] ([136.226.252.245])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c741e0b38d0sm4593977a12.1.2026.03.19.02.54.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2026 02:55:02 -0700 (PDT)
Message-ID: <a937f714-d013-4ac2-a52b-2893fc16f225@gmail.com>
Date: Thu, 19 Mar 2026 15:25:22 +0530
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
Content-Language: en-US
From: tessolveupstream@gmail.com
In-Reply-To: <DH5S3DYT0PJQ.11ABZFGEU6ZPC@bootlin.com>
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



On 18-03-2026 14:21, Luca Ceresoli wrote:
> Hello Sudarshan,
> 
> On Wed Mar 18, 2026 at 6:45 AM CET, tessolveupstream wrote:
>>>>> You might want to look at recently posted:
>>>>>
>>>>> [PATCH 2/3] drm/bridge: ti-sn65dsi83: halve horizontal syncs for dual LVDS output
>>>>
>>>> Thanks for pointing this out.
>>>> I tried applying the patch “[PATCH 2/3] drm/bridge: ti-sn65dsi83: halve horizontal syncs for dual LVDS output” on top of the current tree and
>>>> removed the changes that I had previously added in the driver.
>>>> However, with this patch applied, I am currently seeing only the backlight turning on and no image on the LVDS panel.
>>>> For reference, the LVDS panel used on our platform is G133HAN01.1 and the
>>>> DSI-to-dual-link LVDS bridge is SN65DSI84ZXHR.
>>>
>>> Thanks for having tried.
>>>
>>> Can you please test with both the fixes in the series applied + the test
>>> pattern feature and report the results you get with and without test
>>> pattern enabled?
>>>
>>> The patches to apply are:
>>>
>>>  - https://lore.kernel.org/all/20260226-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v1-1-2e15f5a9a6a0@bootlin.com/
>>>  - https://lore.kernel.org/all/20260226-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v1-2-2e15f5a9a6a0@bootlin.com/
>>>  - https://lore.kernel.org/lkml/20260309-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v2-1-e6aaa7e1d181@bootlin.com/
>>>
>>
>> Thanks for the suggestions.
>>
>> I tested the three patches together as mentioned, but the LVDS panel
>> still only shows the backlight and no image. I also tried removing the
>> test-pattern patch and retesting with only the remaining two fixes, but
>> the result remained the same — only the backlight turns on and no image
>> is displayed.
> 
> Sure, the test pattern patch does not change anything, unless you enable
> the test pattern.
> 
>>> The first thing I suggest doing on your side is testing with the 3 patches
>>> mentioned above.
>>>
>>> If you display works, good! Let us know (you can also add your Tested-by /
>>> Reviewed-by tags to the test_pattern patch too if applicable).
>>>
>>> If it doesn't work, compare the individual register values to find the
>>> differences, try to figure out why the working setting works and how to
>>> apply that change to the driver in away that keeps other boards
>>> working. You're welcome to come back here to discuss it in case you can't
>>> find out on your own.
>>>
>>
>> I tested the three patches as suggested, but the panel still shows only the
>> backlight with no visible image. I’m unsure how to translate the working
>> register values into a generic fix based on display timings. Any guidance
>> on the right direction would be helpful.
> 
> What you should do is:
> 
>  1. with your patches, and while the display is enabled (and working) do
> 
>      cat /sys/kernel/debug/regmap/4-002c/registers >regs.working
> 
>  2. remove your patches, add the 3 I mentioned, and while the display is
>     enabled (but only backlight is working) do
> 
>      cat /sys/kernel/debug/regmap/4-002c/registers >regs.broken
> 
> Then compare regs.working and regs.broken. Which registers differ? Can you
> give a reason for the differences?
> 
> You can come back with these values here so we may discuss them.
>

I followed your suggestion and captured the register dumps in both cases.
~# cat regs.working
00: 35
01: 38
02: 49
03: 53
04: 44
05: 20
06: 20
07: 20
08: 01
09: 01
0a: 85
0b: 28
0d: 01
10: 26
11: 00
12: 53
18: 6f
19: 00
1a: 03
1b: 00
20: 80
21: 07
24: 00
25: 00
28: 21
29: 00
2c: 10
2d: 00
30: 0e
31: 00
34: 28
36: 00
38: 00
3a: 00
3c: 00
e0: 00
e1: 00
e5: 00

~# cat regs.broken
00: 35
01: 38
02: 49
03: 53
04: 44
05: 20
06: 20
07: 20
08: 01
09: 01
0a: 85
0b: 28
0d: 01
10: 26
11: 00
12: 55
18: 0f
19: 05
1a: 03
1b: 00
20: 80
21: 07
24: 38
25: 04
28: 21
29: 00
2c: 15
2d: 00
30: 0e
31: 00
34: 2c
36: 0e
38: 1d
3a: 08
3c: 00
e0: 00
e1: 00
e5: 00

In the working case, several of the timing registers remain at 0, 
while in the broken case they are programmed with non-zero values.
> Luca
> 
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

