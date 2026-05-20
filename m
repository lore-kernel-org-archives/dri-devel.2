Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA86CD5BAC
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 07:13:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5ADB10EF3B;
	Wed, 20 May 2026 07:13:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AJ6+B79i";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE69D10E625
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 03:08:40 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2b9fcf7c91bso44963995ad.0
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 20:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779246520; x=1779851320; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7ogsLHdMRBDNhx86JrEpkhkME96SjA8tuF11+cYpwtQ=;
 b=AJ6+B79i9QKMjHCmuhAJ96S7hd27nDPihpOIJQXbRfHd0a+IJwdk5YfvD2Kz4LSvom
 Kv37bmXfhkDGqOOvqo3IJtVlFNttFw2Lj/dpLI8G1jtbhFYk7DWG5pvQf80BqAeCiwv9
 U+qa4Lpq8wPZFV6BpAEs0Nj46weJOk51Oxqep+ahxLgMmesZN5p1c9dZVUdR9v7rxtyP
 ofy+dxV8f0Wry/rfpIlqCcLSa1H8EXsjoNUPlkBLnjK7zi83aj5pDd2uHFrfq5QbhzDY
 mTuxaHJD7R58JKVFNHpPHhc3syhlPLdU75y0Z1+YAY7ourlp28RkJtKBVgYxvFms7TO/
 rRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779246520; x=1779851320;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7ogsLHdMRBDNhx86JrEpkhkME96SjA8tuF11+cYpwtQ=;
 b=IoCuLmubVHIY41GOtDeIfr1tSrs4CQWGfSnvaRQsX/3Yy+m+xTIlwRRpOMfd1YDTn8
 l1gE+i7l+YVHwn3ZQ87HYcw+bqXJmR9AUNQZwRNbX7TGHDeOUS25RbPyfc/W7YzCsz3H
 EoLxXUMqDB2+yUX92wwaDO4OTEjEw67tXsneCyhpXQPyNmyMNhP3R2XGEVO5WvWUqEo2
 dDIudaKpy12+RPPMKhNal3BNrL/OLh01Toe7XHj9s0MIlSTEGAdxHCURs/eWez/TvIzj
 hw6nBOdwuKkc7UEwwIE/Qk+Gzv2n7u+j/ynmLkWrzqnj84Pw3z2idrkVnuN8IuGytfOf
 YR6Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+CRIg6lTatWYuk/jFnrJbTizLLozRwVB5kBmB6n9oDo+k5DDiJnYzd2xjbXXaZTKg6Yn8nyIXB/ys=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwkxuAF+7PWaG4Iala19R1uKGi/hcmHDCkZTPDWNxRGS/Vp9ZfC
 63wfsrIC/j43jxQNhHKGTmv9UZJrIK20LFlTwtSwaAM96QRaUDDpAYRB
X-Gm-Gg: Acq92OFRfHVapB4f1kG4romgWVWp85z+H/LYvyF55TB4dXAnE0tQauVvy3onbPd2Fmq
 fa652ZjE3N30gxfPH5doEgeZz8aL/caidd2Z9p4hxmK9O4nDVgXizFl6r6JoBlqxuybbAqD7+v5
 vS4RtFLy6/7SdzVEaH/Ed2a/hcgEtfMCheR8ZuzK5Q/OLwnJ0zt4Pz7w5JonmZ+egyD4pcRp9ZA
 l721CHPJGMspZOwOXUvheeRZOqRo+d24ZjT3IAF3sCSMQkDCC3bIsmn5xSzzkB6Z4uQHTewXGK3
 VXFijgWUIY7IcxYA0nYNhUg5aBO/6W2S3i6j7VtdUc26ofwpLEjMcq1nq8KUbn+UY7T8Z+vjGXN
 S4KmndtdtPxvZEYJF3LxPuTB23juXVDAW0HICDI8RUREL0JqltHYb53rZRnik3PIN3VB5aetbTd
 yWmaN/UVVlO8atONqoNqHnpShiBUx1KHPkeZbneLXPRXm6aNtAtrg293w9TgpkFaTVZCgVFHjSZ
 6LyAGZi49ZttFk=
X-Received: by 2002:a17:903:22cb:b0:2b4:63c8:ce18 with SMTP id
 d9443c01a7336-2bd7e83176fmr241246245ad.12.1779246520280; 
 Tue, 19 May 2026 20:08:40 -0700 (PDT)
Received: from [192.168.0.100] (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5c26355csm202030405ad.35.2026.05.19.20.08.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 20:08:39 -0700 (PDT)
Message-ID: <c85299a1-1ea6-4c6c-ba77-ce46969b8c39@gmail.com>
Date: Wed, 20 May 2026 11:08:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] drm/verisilicon: add model ID constants and DCU
 Lite chip identity
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260519055114.1886525-1-a0987203069@gmail.com>
 <20260519055114.1886525-3-a0987203069@gmail.com>
 <5b7b28558aece1d99e93c1d69ce2c381929813a2.camel@iscas.ac.cn>
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <5b7b28558aece1d99e93c1d69ce2c381929813a2.camel@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 20 May 2026 07:13:27 +0000
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

On 5/19/2026 3:37 PM, Icenowy Zheng wrote:
> 在 2026-05-19二的 13:51 +0800，Joey Lu写道：
>> Introduce symbolic constants VSDC_MODEL_DC8200 and
>> VSDC_MODEL_DCU_LITE
>> to replace magic numbers in the hardware database and probe path.
>>
>> Register the DCU Lite chip identity (model 0x0, revision 0x5560,
>> customer_id 0x305) in vs_chip_identities[], making the existing
>> vs_fill_chip_identity() path able to recognise Nuvoton MA35D1
>> hardware
>> purely through register reads.
> The HWDB change should be added in the end of the series, making it a
> gate to the newly added changes that is finally opened when
> everything's ready.
>
>> Also add three register-level macros for forthcoming DCU Lite
>> support:
>> - VSDC_DISP_IRQ_VSYNC(n) in vs_crtc_regs.h, for per-output VSYNC IRQ
>>    bits used by the DCU Lite IRQ enable/status registers.
>> - VSDC_FB_CONFIG_ENABLE, VSDC_FB_CONFIG_VALID and
>> VSDC_FB_CONFIG_RESET
>>    in vs_primary_plane_regs.h, for the framebuffer enable and
>>    commit-cycle bits used by the DCU Lite plane update path.
> Maybe you can split the register change
Understood. I will split the register macro additions into a separate 
patch: one for the new vs_crtc_regs.h IRQ macro and one for the 
vs_primary_plane_regs.h FB_CONFIG bits, keeping them independent of the 
HWDB identity change.
>> No behaviour change for existing DC8200 platforms.
>>
>> Signed-off-by: Joey Lu <a0987203069@gmail.com>
>> ---
>>   drivers/gpu/drm/verisilicon/vs_crtc_regs.h       |  1 +
>>   drivers/gpu/drm/verisilicon/vs_hwdb.c            | 16 ++++++++++++--
>> --
>>   drivers/gpu/drm/verisilicon/vs_hwdb.h            |  3 +++
>>   .../gpu/drm/verisilicon/vs_primary_plane_regs.h  |  3 +++
>>   4 files changed, 19 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/verisilicon/vs_crtc_regs.h
>> b/drivers/gpu/drm/verisilicon/vs_crtc_regs.h
>> index c7930e817635..d4da22b08cd5 100644
>> --- a/drivers/gpu/drm/verisilicon/vs_crtc_regs.h
>> +++ b/drivers/gpu/drm/verisilicon/vs_crtc_regs.h
>> @@ -54,6 +54,7 @@
>>   #define VSDC_DISP_GAMMA_DATA(n)			(0x1460 +
>> 0x4 * (n))
>>   
>>   #define VSDC_DISP_IRQ_STA			0x147C
>> +#define VSDC_DISP_IRQ_VSYNC(n)			BIT(n)
>>   
>>   #define VSDC_DISP_IRQ_EN			0x1480
>>   
>> diff --git a/drivers/gpu/drm/verisilicon/vs_hwdb.c
>> b/drivers/gpu/drm/verisilicon/vs_hwdb.c
>> index 09336af0900a..a25c4b16181d 100644
>> --- a/drivers/gpu/drm/verisilicon/vs_hwdb.c
>> +++ b/drivers/gpu/drm/verisilicon/vs_hwdb.c
>> @@ -90,7 +90,7 @@ static const struct vs_formats
>> vs_formats_with_yuv444 = {
>>   
>>   static struct vs_chip_identity vs_chip_identities[] = {
>>   	{
>> -		.model = 0x8200,
>> +		.model = VSDC_MODEL_DC8200,
> I don't think such a macro is needed.
Understood. I will remove `VSDC_MODEL_DC8200` and use the literal 
`0x8200` directly in vs_hwdb.c with a comment.
>>   		.revision = 0x5720,
>>   		.customer_id = ~0U,
>>   
>> @@ -98,7 +98,7 @@ static struct vs_chip_identity vs_chip_identities[]
>> = {
>>   		.formats = &vs_formats_no_yuv444,
>>   	},
>>   	{
>> -		.model = 0x8200,
>> +		.model = VSDC_MODEL_DC8200,
>>   		.revision = 0x5721,
>>   		.customer_id = 0x30B,
>>   
>> @@ -106,7 +106,7 @@ static struct vs_chip_identity
>> vs_chip_identities[] = {
>>   		.formats = &vs_formats_no_yuv444,
>>   	},
>>   	{
>> -		.model = 0x8200,
>> +		.model = VSDC_MODEL_DC8200,
>>   		.revision = 0x5720,
>>   		.customer_id = 0x310,
>>   
>> @@ -114,13 +114,21 @@ static struct vs_chip_identity
>> vs_chip_identities[] = {
>>   		.formats = &vs_formats_with_yuv444,
>>   	},
>>   	{
>> -		.model = 0x8200,
>> +		.model = VSDC_MODEL_DC8200,
>>   		.revision = 0x5720,
>>   		.customer_id = 0x311,
>>   
>>   		.display_count = 2,
>>   		.formats = &vs_formats_no_yuv444,
>>   	},
>> +	{
>> +		.model = VSDC_MODEL_DCU_LITE,
> The number is 0x0 and the whole public name of this IP is
> "DCUltraLite", w/o any numbers.
>
> I suggest leave it at 0x0 and add a comment saying this is DCUltraLite
> -- Verisilicon people are abusing suffix for their IP names now.
Understood. I will remove the `VSDC_MODEL_DCU_LITE` macro and use `0x0` 
directly with a `/* DCUltraLite */` comment in vs_hwdb.c.
>> +		.revision = 0x5560,
>> +		.customer_id = 0x305,
>> +
>> +		.display_count = 1,
>> +		.formats = &vs_formats_no_yuv444,
>> +	},
>>   };
>>   
>>   int vs_fill_chip_identity(struct regmap *regs,
>> diff --git a/drivers/gpu/drm/verisilicon/vs_hwdb.h
>> b/drivers/gpu/drm/verisilicon/vs_hwdb.h
>> index 92192e4fa086..cca126bd2da5 100644
>> --- a/drivers/gpu/drm/verisilicon/vs_hwdb.h
>> +++ b/drivers/gpu/drm/verisilicon/vs_hwdb.h
>> @@ -9,6 +9,9 @@
>>   #include <linux/regmap.h>
>>   #include <linux/types.h>
>>   
>> +#define VSDC_MODEL_DC8200 0x8200
>> +#define VSDC_MODEL_DCU_LITE 0x0
>> +
>>   struct vs_formats {
>>   	const u32 *array;
>>   	unsigned int num;
>> diff --git a/drivers/gpu/drm/verisilicon/vs_primary_plane_regs.h
>> b/drivers/gpu/drm/verisilicon/vs_primary_plane_regs.h
>> index cbb125c46b39..67d4b00f294e 100644
>> --- a/drivers/gpu/drm/verisilicon/vs_primary_plane_regs.h
>> +++ b/drivers/gpu/drm/verisilicon/vs_primary_plane_regs.h
>> @@ -16,6 +16,9 @@
>>   #define VSDC_FB_STRIDE(n)			(0x1408 + 0x4 * (n))
>>   
>>   #define VSDC_FB_CONFIG(n)			(0x1518 + 0x4 * (n))
>> +#define VSDC_FB_CONFIG_ENABLE			BIT(0)
>> +#define VSDC_FB_CONFIG_VALID			BIT(3)
>> +#define VSDC_FB_CONFIG_RESET			BIT(4)
> Should the new IRQ register to be added here too?
>
> Thanks,
> Icenowy
`VSDC_DISP_IRQ_VSYNC(n)` is a bit-mask for the IRQ status/enable 
registers (`VSDC_DISP_IRQ_STA` / `VSDC_DISP_IRQ_EN`) which already live 
in vs_crtc_regs.h. Keeping it there alongside the register addresses it 
operates on is cleaner than splitting the IRQ definitions across two 
headers.
>>   #define VSDC_FB_CONFIG_CLEAR_EN			BIT(8)
>>   #define VSDC_FB_CONFIG_ROT_MASK			GENMASK(13,
>> 11)
>>   #define VSDC_FB_CONFIG_ROT(v)			((v) << 11)
