Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9688ACD37B6
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 07:54:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69D1010ED1E;
	Wed, 13 May 2026 07:54:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZkjNfCcn";
	dkim-atps=neutral
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF75810E9CD
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 09:10:27 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-83ec36a13e9so1084198b3a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 02:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778577027; x=1779181827; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z33mAnUolaaopuhgkgsSsR1XqxZfuAXYGKr6UlpMNF4=;
 b=ZkjNfCcnug8Jy+Dl0cCjzmN61WTGh8IqEyfre57OjLRGu72z+awRKpE3sxf4iUyiIU
 yjanqaZZUdgBLS+gf5mlNNXeUMUZXmDM1l8ecCpjeRHE58A1SW56BhnELeRQNdGWdBny
 wD57Uo016JpsxHnPRNRzPfP2baKgWym6DolnuDWY92pD3Vp0AkqxaTWk81iUB7Xxn1sv
 qvUdWBtr5pKw9yAe0HNYAFR4D5WW/rYHRzsiJ9pXSORwAKAtrvjbdIhlflkRLVrxfqGT
 EhwNV+5QJlVYvZCFMTBgdA7UiDc3x45Qs6fDz+mnUZmYMwBEtveMAyIN0GmjfhJFxczH
 ImSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778577027; x=1779181827;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z33mAnUolaaopuhgkgsSsR1XqxZfuAXYGKr6UlpMNF4=;
 b=LEkakSAEeSrrXY/ERD2EQBY0w5Vr2bp1p6xYZD48gNEo2rDufbXik1IwAPk1PYt5SQ
 5diMjzgH8yzwtk0Ljr9OGG2cgkRWapeGGLLq071GsEj45bQ+GdKAiB8Dg6QZ2G8MbFXP
 A64QWxd3ZKiy1YZU56Tb5/eBf2Koqvbxf6SsJE5mXoLhCl6RIQt30u+MMTYeDTE6fHbU
 w2QdKSbRthmWJZ0pAr2VFWSm71hYlctYRmbiAU6bc1k9DnVPcDv2VsBjGn/VaXiCUNQL
 gRpaBGzV8ipC35Dz3fFZVp41PVdg1wCXHtKnYjIVviW940h4rKi4xAtJCuXvKn3he0/W
 fmSw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/nHNXyxZXLca5pMS8V2d/yCLCtkylhVphZy4SQcQn1WENm3LvDUTz63IwyY1U/6vO3GQPBYA/KVjM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxvAox8gd36YbUMf6uJ3gqI+M5I386NWLV3bCBeLMzyaAEgY9Uh
 IOr1jJbxOFB3910+6IrAKBqKn57SIpz2nSkTJ1crSEbf1LOE3Fn/yfsryyWikQ==
X-Gm-Gg: Acq92OFFRWaTdYji4Uj44itYNq2EbkT0ha9YGPUURaMiG7gUuCFdeSUqM1B9yWoASl8
 JGjAmLD0jUkqdtEBJEIG0fpuAyRv4pLUzL992YzYk3fWbNdZCzSkkrZV45O3hl/649FZCBpVadW
 Oh+xJ4Zvw8wzAv92ly79AdzJQ/+DGpQhykNd3/DUHJ5VtbNcjbdJ6BowkL46KuXTc20admZtrEm
 MrTjfon8KBlC0usIN/iBApxFnBI08G8HKazj27lZ4KTy/NUFm43EH1QKFFLPZIsoH0b1Ow5Ep9S
 gkSxwL/arlgFliqlCgIyjLAGGEohuirZN8LpDV6cB1hcwJcWWBgwb1AUD+kvqPFRmVt9JiWp2K5
 zLGOLg98MAyObzCtun9b4GPV4Le53E+C80Mzd3so2fHOBtQvuRxCT6mKed2UyskX4YTHVgJnKhD
 wxBzM4k4W/45NPElHxie6pr7BYpzTZuYYt+vFQzal2LdRcAIuPR62Gl9/Kf3516lw8mJ8ooHHmu
 JsObCtJcLk0DWY=
X-Received: by 2002:a05:6a00:9a8:b0:835:5557:31fa with SMTP id
 d2e1a72fcca58-83eebe7fd90mr2418145b3a.46.1778577027383; 
 Tue, 12 May 2026 02:10:27 -0700 (PDT)
Received: from [192.168.0.100] (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83965946543sm28990915b3a.16.2026.05.12.02.10.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 02:10:26 -0700 (PDT)
Message-ID: <07ca65f6-33da-40b1-afcd-0b0ceabd49f9@gmail.com>
Date: Tue, 12 May 2026 17:10:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/verisilicon: add support for Nuvoton MA35D1
 DCUltra Lite display controller
To: Thomas Zimmermann <tzimmermann@suse.de>, zhengxingda@iscas.ac.cn,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260511075142.54752-1-a0987203069@gmail.com>
 <20260511075142.54752-3-a0987203069@gmail.com>
 <5157ab4d-3195-49f3-a3e9-aef6d58e869e@suse.de>
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <5157ab4d-3195-49f3-a3e9-aef6d58e869e@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 13 May 2026 07:53:28 +0000
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


On 5/12/2026 4:24 PM, Thomas Zimmermann wrote:
> Hi,
>
> instead of this if-else branchery, I strongly recommend to add a new 
> file with a new mode-setting pipeline for the new chipset. You can 
> share existing helpers where possible, and implement variants where 
> chips differ.  It's a bit more code, but will be a lot easier to 
> maintain in the future.
>
> See ast and mgag200 for example. Both drivers support various 
> revisions of their chipset, where each rev has its oddities.
>
> Best regards
> Thomas

Thank you for the detailed suggestion.

I see your point and will refactor by adding a new file with a 
mode-setting pipeline for the chipset, reusing helpers where possible 
and handling variants as needed.

>
> Am 11.05.26 um 09:51 schrieb Joey Lu:
>> The Nuvoton MA35D1 SoC integrates a Verisilicon DCUltra Lite display
>> controller, which is a previous generation of the DC8000 series. While
>> the general register layout is similar to the DC8000, there are several
>> key differences that require per-variant handling in the driver.
>>
>> Add a vs_dc_info platform data structure (in vs_hwdb.h) to describe
>> per-IP-variant capabilities, and use it throughout the driver to select
>> the correct code paths at runtime.
>>
>> Key differences between DC8000 and DCUltra Lite handled:
>>
>> 1. No chip identity registers (0x0020-0x0030): DCUltra Lite uses static
>>     platform data instead of reading model/revision/customer_id from HW.
>>
>> 2. No CONFIG_EX commit mechanism: DC8000 uses registers at 0x1CC0
>>     (FB_CONFIG_EX), 0x24D8 (FB_TOP_LEFT), 0x24E0 (FB_BOTTOM_RIGHT),
>>     0x2510 (FB_BLEND_CONFIG), 0x2518 (PANEL_CONFIG_EX). DCUltra Lite
>>     omits all of these and instead uses enable/reset bits in FB_CONFIG
>>     (bit 0 = enable, bit 4 = reset) for direct framebuffer updates.
>>
>> 3. No PANEL_START register (0x1CCC): DCUltra Lite panel output starts
>>     when PANEL_CONFIG.RUNNING is set; no separate multi-display sync
>>     start register is needed.
>>
>> 4. Different IRQ registers: DCUltra Lite uses 0x147C (IRQ_STA) /
>>     0x1480 (IRQ_EN); DC8000 uses 0x0010 (IRQ_ACK) / 0x0014 (IRQ_EN).
>>
>> 5. Different clock/reset topology: DCUltra Lite requires only "core"
>>     (bus gate) and "pix0" (pixel divider) clocks with no reset lines
>>     managed by the driver. DC8000 needs core/axi/ahb clocks and three
>>     resets.
>>
>> 6. Single output only: DCUltra Lite has one display output; per-output
>>     index logic is still in place but display_count is fixed at 1.
>>
>> 7. Reduced register space: max_register is 0x2000 vs DC8000's 0x2544.
>>
>> Add the "nuvoton,ma35d1-dcu" compatible string to the OF match table,
>> extend Kconfig to allow building on ARCH_MA35 platforms, and expose
>> vs_formats_no_yuv444 as the default format table for DCUltra Lite
>> (YUV444 blending is a DC8000-only feature).
>>
>> All changes have been tested on Nuvoton MA35D1 hardware and are
>> functioning correctly.
>>
>> Signed-off-by: Joey Lu <a0987203069@gmail.com>
>> ---
>>   drivers/gpu/drm/verisilicon/Kconfig           |   2 +-
>>   drivers/gpu/drm/verisilicon/vs_bridge.c       |  28 ++--
>>   drivers/gpu/drm/verisilicon/vs_crtc.c         |  13 +-
>>   drivers/gpu/drm/verisilicon/vs_dc.c           | 129 ++++++++++++------
>>   drivers/gpu/drm/verisilicon/vs_dc.h           |   1 +
>>   drivers/gpu/drm/verisilicon/vs_drm.c          |  16 ++-
>>   drivers/gpu/drm/verisilicon/vs_hwdb.c         |   2 +-
>>   drivers/gpu/drm/verisilicon/vs_hwdb.h         |  25 ++++
>>   .../gpu/drm/verisilicon/vs_primary_plane.c    |  43 +++---
>>   .../drm/verisilicon/vs_primary_plane_regs.h   |   2 +
>>   10 files changed, 187 insertions(+), 74 deletions(-)
>>
>>
>
