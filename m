Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB063CD4851
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 07:53:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BB7310E283;
	Wed, 13 May 2026 07:53:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PYW4qIgd";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5334310E17F
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 07:45:43 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-3567e2b4159so3159610a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 00:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778571943; x=1779176743; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UTgZhfx5akyaIwwa2Nv45b7XTM6tXA6vydkcj20lD9U=;
 b=PYW4qIgdOlVWOL+Hvsgwz0GwWmLA6HX7L73ICGbzkouyxqPwGgiMYpXAld9MIkks5q
 l1W/A3vk1Al8dEcpJBmDonhwZ1di2uYqweoWwkgTZ7UYGtUY929Z6VQfvvITq0EvIG3g
 wasZjqVTyljF1n7PtVVTJP5vXkp0YWVv1+M0AZICg3zDzB3mCVI3p4/e3UqDB31ZHyYX
 3TP7qfYG6mbHgNS5++TU/4qOjRoCd2So0WqiczeQMwcDfD7zjCw2ADgI7D/iehitd1Ut
 aGYGT08nY/Ru0xoPnZrp+ioDDFHIWM+QxP8bZrs2XiC6BRwmGuTdRG37B/v+2d0+EuUv
 uX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778571943; x=1779176743;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UTgZhfx5akyaIwwa2Nv45b7XTM6tXA6vydkcj20lD9U=;
 b=DSzgEasH2YY0oh/gTHvBcOUkzfj5WIa2YcBi8OJep6eaNi5ymfGhgxyd3GaeUjFyJF
 mkyeXNeIM0Ryx0y8USxOJDvs03SntcTV2/GipfEdHkMQgz5Alowpcvj1UTwjnfW+4eqT
 eW+iAg1eYt+4yb5wRu0U4bpr7wYsnLSkB0UkgXcV5aYFl944aFfJsOExqA4TQXEXz3Df
 E6KgmUSpc1fUqB7EAwkQja9/y235XVCCcbeEp44p+qu53gkyjx2l3u1eaj1jgetB0jgY
 CSAqy5TgXFLRr8FI2tjmLhjqM65s8/FRGiojYBbRfL0RsEz9ZlRipsnMElG0NHNhdDOE
 kn5A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9nQ23z2tC87OFZNNHvuSrMqCVghT4RxN7L0trD3uDPX1KEJNqzs/+P9DsVtvhdIJopZfTq5xsefqM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy698G1rFpN+Fvm0ERKO5ni/b6DvnNB0lVTjnr96nZiD50fiSK+
 N9+YQS4b2M5JbYI67ZOWWCqEsImKNHzlCdokK9H0ANaXVM4cMIX1EvKf
X-Gm-Gg: Acq92OF73SwWA/Aa+5yfUYFTemQX/1av8venQkOePjOC0ZMc6KZX7Uw3xGmLi8lCDDh
 3dLTI/hy2OrlX8K+PmLJWGePfO/cG4OK82iLKIq0w+c2xT6UHySl1RBAFOfCumv7vvgCAWjJV0z
 /OJxrbW0PXN6yhIcg1M/x/5B9sF4ChkRp/YHYn1rNgkKzOJGzyxOJrjOXIXuM9AgCqRCe4ZigbZ
 m2GesxVw58gV8gSvbWKpOpMIDex0CQbx6QnoeSbPRPLz+s3C6TEc9gxgMFaUrBTxbmoTq8I9seG
 gsTTmDpda0qvDM7ccsYzNkxJK0t5FqJA4gnuiNl8rMoahK1CkqR9H4bmfQ7IfY0F5OfZoY6a1MY
 /huVVXg98omqucel5sJy/D+zJhOJ4z8fXMdRkSa8Br+UbeF3CbO/kpKddxN+Jer7lRjpVHEzFga
 FMIRYuDxQlwr4Bh4Vs4k9lyOYle9FG7/dfe1TL/q9EQSSpyg8TjnCjEMWprh02YgmKXDLgyYYbB
 bGF
X-Received: by 2002:a17:90b:3dcb:b0:366:decb:d119 with SMTP id
 98e67ed59e1d1-366decbd2c3mr16642402a91.11.1778571942490; 
 Tue, 12 May 2026 00:45:42 -0700 (PDT)
Received: from [192.168.0.100] (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-367d684009esm10366598a91.11.2026.05.12.00.45.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 00:45:41 -0700 (PDT)
Message-ID: <de35406e-874d-4bdd-be7f-3d74dc37b13f@gmail.com>
Date: Tue, 12 May 2026 15:45:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/verisilicon: add support for Nuvoton MA35D1
 DCUltra Lite display controller
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260511075142.54752-1-a0987203069@gmail.com>
 <20260511075142.54752-3-a0987203069@gmail.com>
 <93e69179dbc495188cfffd8015350b3a55ce7876.camel@iscas.ac.cn>
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <93e69179dbc495188cfffd8015350b3a55ce7876.camel@iscas.ac.cn>
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


On 5/11/2026 5:47 PM, Icenowy Zheng wrote:
> 在 2026-05-11一的 15:51 +0800，Joey Lu写道：
>> The Nuvoton MA35D1 SoC integrates a Verisilicon DCUltra Lite display
>> controller, which is a previous generation of the DC8000 series.
>> While
>> the general register layout is similar to the DC8000, there are
>> several
>> key differences that require per-variant handling in the driver.
>>
>> Add a vs_dc_info platform data structure (in vs_hwdb.h) to describe
>> per-IP-variant capabilities, and use it throughout the driver to
>> select
>> the correct code paths at runtime.
>>
>> Key differences between DC8000 and DCUltra Lite handled:
> What the driver supports now is DC8200, DC8000 have the following point
> 1~4 the same with DCUltraLite (different to DC8200).
Understood. I'll rename all `vs_dc8000_*` identifiers to
`vs_dc8200_*` in v2. The commit message will also be corrected to say
that points 1~4 are differences from DC8200, not DC8000.
>> 1. No chip identity registers (0x0020-0x0030): DCUltra Lite uses
>> static
>>     platform data instead of reading model/revision/customer_id from
>> HW.
> My test shows that revision and customer_id is correctly present, only
> model is 0 -- I think this can be also considered as a valid model
> value because the IP name has also no model number.
>
> The revision number is 0x5560 and customer id is 0x305 .
Thank you for testing. I'll drop the `has_chip_id` flag
entirely. In v2, `vs_fill_chip_identity()` will be called for all
variants. A new entry will be added to `vs_chip_identities[]` in
vs_hwdb.c with model=0x0, revision=0x5560, customer_id=0x305,
display_count=1, and `vs_formats_no_yuv444`.
e.g. verisilicon-dc 40260000.display: Found DC0 rev 5560 customer 305
>
>> 2. No CONFIG_EX commit mechanism: DC8000 uses registers at 0x1CC0
>>     (FB_CONFIG_EX), 0x24D8 (FB_TOP_LEFT), 0x24E0 (FB_BOTTOM_RIGHT),
>>     0x2510 (FB_BLEND_CONFIG), 0x2518 (PANEL_CONFIG_EX). DCUltra Lite
>>     omits all of these and instead uses enable/reset bits in FB_CONFIG
>>     (bit 0 = enable, bit 4 = reset) for direct framebuffer updates.
>>
>> 3. No PANEL_START register (0x1CCC): DCUltra Lite panel output starts
>>     when PANEL_CONFIG.RUNNING is set; no separate multi-display sync
>>     start register is needed.
>>
>> 4. Different IRQ registers: DCUltra Lite uses 0x147C (IRQ_STA) /
>>     0x1480 (IRQ_EN); DC8000 uses 0x0010 (IRQ_ACK) / 0x0014 (IRQ_EN).
>>
>> 5. Different clock/reset topology: DCUltra Lite requires only "core"
>>     (bus gate) and "pix0" (pixel divider) clocks with no reset lines
>>     managed by the driver. DC8000 needs core/axi/ahb clocks and three
>>     resets.
> It's possible that your SoC integration combines core clock gate with
> bus clock gate instead of bus clock gate not existing.
Agreed. In v2 I'll remove the family-gated clock handling and
instead use `devm_clk_get_optional_enabled()` for the axi and ahb
clocks, so they are simply skipped if not present in DT. Resets are
already optional. This keeps the probe path uniform and handles any
SoC-specific clock combinations naturally.
>> 6. Single output only: DCUltra Lite has one display output; per-
>> output
>>     index logic is still in place but display_count is fixed at 1.
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
>>   drivers/gpu/drm/verisilicon/Kconfig           |   2 +-
>>   drivers/gpu/drm/verisilicon/vs_bridge.c       |  28 ++--
>>   drivers/gpu/drm/verisilicon/vs_crtc.c         |  13 +-
>>   drivers/gpu/drm/verisilicon/vs_dc.c           | 129 ++++++++++++----
>> --
>>   drivers/gpu/drm/verisilicon/vs_dc.h           |   1 +
>>   drivers/gpu/drm/verisilicon/vs_drm.c          |  16 ++-
>>   drivers/gpu/drm/verisilicon/vs_hwdb.c         |   2 +-
>>   drivers/gpu/drm/verisilicon/vs_hwdb.h         |  25 ++++
>>   .../gpu/drm/verisilicon/vs_primary_plane.c    |  43 +++---
>>   .../drm/verisilicon/vs_primary_plane_regs.h   |   2 +
>>   10 files changed, 187 insertions(+), 74 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/verisilicon/Kconfig
>> b/drivers/gpu/drm/verisilicon/Kconfig
>> index 7cce86ec8603..295d246eb4b4 100644
>> --- a/drivers/gpu/drm/verisilicon/Kconfig
>> +++ b/drivers/gpu/drm/verisilicon/Kconfig
>> @@ -2,7 +2,7 @@
>>   config DRM_VERISILICON_DC
>>   	tristate "DRM Support for Verisilicon DC-series display
>> controllers"
>>   	depends on DRM && COMMON_CLK
>> -	depends on RISCV || COMPILE_TEST
>> +	depends on RISCV || ARCH_MA35 || COMPILE_TEST
>>   	select DRM_BRIDGE_CONNECTOR
>>   	select DRM_CLIENT_SELECTION
>>   	select DRM_DISPLAY_HELPER
>> diff --git a/drivers/gpu/drm/verisilicon/vs_bridge.c
>> b/drivers/gpu/drm/verisilicon/vs_bridge.c
>> index 7a93049368db..225af322de32 100644
>> --- a/drivers/gpu/drm/verisilicon/vs_bridge.c
>> +++ b/drivers/gpu/drm/verisilicon/vs_bridge.c
>> @@ -164,13 +164,16 @@ static void vs_bridge_enable_common(struct
>> vs_crtc *crtc,
>>   			VSDC_DISP_PANEL_CONFIG_CLK_EN);
>>   	regmap_set_bits(dc->regs, VSDC_DISP_PANEL_CONFIG(output),
>>   			VSDC_DISP_PANEL_CONFIG_RUNNING);
>> -	regmap_clear_bits(dc->regs, VSDC_DISP_PANEL_START,
>> -			  VSDC_DISP_PANEL_START_MULTI_DISP_SYNC);
>> -	regmap_set_bits(dc->regs, VSDC_DISP_PANEL_START,
>> -			VSDC_DISP_PANEL_START_RUNNING(output));
>>   
>> -	regmap_set_bits(dc->regs, VSDC_DISP_PANEL_CONFIG_EX(crtc-
>>> id),
>> -			VSDC_DISP_PANEL_CONFIG_EX_COMMIT);
>> +	if (dc->info->has_config_ex) {
>> +		regmap_clear_bits(dc->regs, VSDC_DISP_PANEL_START,
>> +				
>> VSDC_DISP_PANEL_START_MULTI_DISP_SYNC);
>> +		regmap_set_bits(dc->regs, VSDC_DISP_PANEL_START,
>> +				VSDC_DISP_PANEL_START_RUNNING(output
>> ));
>> +
>> +		regmap_set_bits(dc->regs,
>> VSDC_DISP_PANEL_CONFIG_EX(crtc->id),
>> +				VSDC_DISP_PANEL_CONFIG_EX_COMMIT);
> Should the commit operation happen on DC8000/DCUltraLite too? (By
> writing to DcregFrameBufferConfig0.VALID).
>
> Many registers written has "Note: This field is double buffered" in the
> DCUltraLite documentation.
>
> I suggest create a static function for commit -- write to the
> corresponding commit bit on DC8200, and write to
> DcregFrameBufferConfig0.VALID on DC8000/DCUltraLite.
[a] There is no commit operation for DCUltra Lite.
I'll not add a `VSDC_FB_CONFIG_VALID` macro. VALID (BIT(3)) is a
hardware-managed double-buffer status bit: hardware writes 1=PENDING
when a new register set is ready and clears to 0=WORKING after the
VBLANK copy. Software must never write it, and there is no polling use
case in the driver that requires a named constant. For non-config_ex
variants, `vs_primary_plane_commit()` performs no commit operation —
`VSDC_FB_CONFIG_ENABLE` (OUTPUT, BIT(0)) is set in
`vs_crtc_atomic_enable()` and `VSDC_FB_CONFIG_RESET` (BIT(4)) is
set/cleared in the bridge enable/disable paths.
>> +	}
>>   }
>>   
>>   static void vs_bridge_atomic_enable_dpi(struct drm_bridge *bridge,
>> @@ -228,14 +231,17 @@ static void vs_bridge_atomic_disable(struct
>> drm_bridge *bridge,
>>   	struct vs_dc *dc = crtc->dc;
>>   	unsigned int output = crtc->id;
>>   
>> -	regmap_clear_bits(dc->regs, VSDC_DISP_PANEL_START,
>> -			  VSDC_DISP_PANEL_START_MULTI_DISP_SYNC |
>> -			  VSDC_DISP_PANEL_START_RUNNING(output));
>>   	regmap_clear_bits(dc->regs, VSDC_DISP_PANEL_CONFIG(output),
>>   			  VSDC_DISP_PANEL_CONFIG_RUNNING);
> This bit seems to be not present in DCUltraLite, instead should
> DcregFrameBufferConfig0.RESET be clear, which will stall the DPI
> timing?
I'll move `VSDC_DISP_PANEL_CONFIG_RUNNING` inside the
`has_config_ex` block in both the enable and disable paths. For
non-config_ex variants (DCUltra Lite), the disable path will instead
clear `VSDC_FB_CONFIG_RESET` to stall DPI output.
`VSDC_DISP_PANEL_CONFIG_RUNNING` will only be set/cleared for
DC8200 (has_config_ex=true).
>>   
>> -	regmap_set_bits(dc->regs, VSDC_DISP_PANEL_CONFIG_EX(crtc-
>>> id),
>> -			VSDC_DISP_PANEL_CONFIG_EX_COMMIT);
>> +	if (dc->info->has_config_ex) {
>> +		regmap_clear_bits(dc->regs, VSDC_DISP_PANEL_START,
>> +				
>> VSDC_DISP_PANEL_START_MULTI_DISP_SYNC |
>> +				
>> VSDC_DISP_PANEL_START_RUNNING(output));
>> +
>> +		regmap_set_bits(dc->regs,
>> VSDC_DISP_PANEL_CONFIG_EX(crtc->id),
>> +				VSDC_DISP_PANEL_CONFIG_EX_COMMIT);
>> +	}
> Ditto.
Covered by the same fix above — the else branch in
vs_bridge_atomic_disable() will handle the non-config_ex (DCUltra
Lite) path by clearing RESET.
>>   }
>>   
>>   static const struct drm_bridge_funcs vs_dpi_bridge_funcs = {
>> diff --git a/drivers/gpu/drm/verisilicon/vs_crtc.c
>> b/drivers/gpu/drm/verisilicon/vs_crtc.c
>> index 9080344398ca..2f3e6d41c657 100644
>> --- a/drivers/gpu/drm/verisilicon/vs_crtc.c
>> +++ b/drivers/gpu/drm/verisilicon/vs_crtc.c
>> @@ -18,6 +18,7 @@
>>   #include "vs_dc.h"
>>   #include "vs_dc_top_regs.h"
>>   #include "vs_drm.h"
>> +#include "vs_hwdb.h"
>>   #include "vs_plane.h"
>>   
>>   static void vs_crtc_atomic_disable(struct drm_crtc *crtc,
>> @@ -132,7 +133,11 @@ static int vs_crtc_enable_vblank(struct drm_crtc
>> *crtc)
>>   	struct vs_crtc *vcrtc = drm_crtc_to_vs_crtc(crtc);
>>   	struct vs_dc *dc = vcrtc->dc;
>>   
>> -	regmap_set_bits(dc->regs, VSDC_TOP_IRQ_EN,
>> VSDC_TOP_IRQ_VSYNC(vcrtc->id));
>> +	if (dc->info->family == VS_DC_FAMILY_DCULTRA_LITE)
>> +		regmap_write(dc->regs, VSDC_DISP_IRQ_EN, BIT(0));
> Should `BIT(0)` be assigned with a named macro here, like
> `VSDC_DISP_IRQ_VSYNC(0)` ?
>
> In addition, even it's known that DC8000/DCUltraLite has only one
> output, hardcoding 0 here isn't so good. The header file at [1] (which
> is for DC8000) shows that two display interrupts and more other
> interrupts are present.
>
> BTW I don't like the idea of setting a "family" (because DC8000 behave
> nearly the same with DCUltraLite), maybe use `.irq_reg = VSDC_DISP_IRQ`
> (or a bool variable named `uses_top_irq`) is better?
>
> [1]
> https://github.com/milkv-megrez/rockos-u-boot/blob/c9221cf2fa77d39c0b241ab4b030c708e7ebe279/drivers/video/eswin/eswin_dc_reg.h#L2771
I'll address all three issues in v2:
1. Add `VSDC_DISP_IRQ_VSYNC(n)` macro (BIT(n)) to vs_crtc_regs.h.
2. Use `VSDC_DISP_IRQ_VSYNC(vcrtc->id)` with
    `regmap_set_bits`/`regmap_clear_bits` instead of hardcoding 0 and
    using `regmap_write` (which would clobber other IRQ bits).
3. Add `uses_top_irq` bool to `struct vs_chip_identity` in vs_hwdb.h.
    DC8200 entries will have `uses_top_irq = true`; the DCUltra Lite
    entry (model=0x0, rev=0x5560) will have `uses_top_irq = false`.
>> +	else
>> +		regmap_set_bits(dc->regs, VSDC_TOP_IRQ_EN,
>> +				VSDC_TOP_IRQ_VSYNC(vcrtc->id));
>>   
>>   	return 0;
>>   }
>> @@ -142,7 +147,11 @@ static void vs_crtc_disable_vblank(struct
>> drm_crtc *crtc)
>>   	struct vs_crtc *vcrtc = drm_crtc_to_vs_crtc(crtc);
>>   	struct vs_dc *dc = vcrtc->dc;
>>   
>> -	regmap_clear_bits(dc->regs, VSDC_TOP_IRQ_EN,
>> VSDC_TOP_IRQ_VSYNC(vcrtc->id));
>> +	if (dc->info->family == VS_DC_FAMILY_DCULTRA_LITE)
>> +		regmap_write(dc->regs, VSDC_DISP_IRQ_EN, 0);
>> +	else
>> +		regmap_clear_bits(dc->regs, VSDC_TOP_IRQ_EN,
>> +				  VSDC_TOP_IRQ_VSYNC(vcrtc->id));
>>   }
>>   
>>   static const struct drm_crtc_funcs vs_crtc_funcs = {
>> diff --git a/drivers/gpu/drm/verisilicon/vs_dc.c
>> b/drivers/gpu/drm/verisilicon/vs_dc.c
>> index dad9967bc10b..82a6a26f6d81 100644
>> --- a/drivers/gpu/drm/verisilicon/vs_dc.c
>> +++ b/drivers/gpu/drm/verisilicon/vs_dc.c
>> @@ -9,21 +9,45 @@
>>   #include <linux/of_graph.h>
>>   
>>   #include "vs_crtc.h"
>> +#include "vs_crtc_regs.h"
>>   #include "vs_dc.h"
>>   #include "vs_dc_top_regs.h"
>>   #include "vs_drm.h"
>>   #include "vs_hwdb.h"
>>   
>> -static const struct regmap_config vs_dc_regmap_cfg = {
>> +static const struct regmap_config vs_dc8000_regmap_cfg = {
> As what I said, the currently supported thing is DC8200, not DC8000.
I'll keep the name `vs_dc_regmap_cfg` — the original name from
upstream. A separate DCUltra Lite regmap config is not needed; the
hardware simply does not implement registers above 0x2000, and a regmap
window up to 0x2544 is harmless for that variant.
>>   	.reg_bits = 32,
>>   	.val_bits = 32,
>>   	.reg_stride = sizeof(u32),
>> -	/* VSDC_OVL_CONFIG_EX(1) */
>>   	.max_register = 0x2544,
>>   };
>>   
>> +static const struct regmap_config vs_dcultra_lite_regmap_cfg = {
>> +	.reg_bits = 32,
>> +	.val_bits = 32,
>> +	.reg_stride = sizeof(u32),
>> +	.max_register = 0x2000,
>> +};
>> +
>> +static const struct vs_dc_info vs_dc8000_info = {
>> +	.family = VS_DC_FAMILY_DC8000,
>> +	.has_chip_id = true,
>> +	.has_config_ex = true,
>> +	.regmap_cfg = &vs_dc8000_regmap_cfg,
>> +};
>> +
>> +static const struct vs_dc_info vs_dcultra_lite_info = {
>> +	.family = VS_DC_FAMILY_DCULTRA_LITE,
>> +	.display_count = 1,
>> +	.has_chip_id = false,
>> +	.has_config_ex = false,
>> +	.regmap_cfg = &vs_dcultra_lite_regmap_cfg,
>> +	.formats = &vs_formats_no_yuv444,
>> +};
>> +
>>   static const struct of_device_id vs_dc_driver_dt_match[] = {
>> -	{ .compatible = "verisilicon,dc" },
>> +	{ .compatible = "verisilicon,dc", .data = &vs_dc8000_info },
> "verisilicon,dc" is expected for DC8000 and 8200, and because of model,
> rev and customer_id values are all present for DCUltraLite, the special
> data might be dropped?
I'll drop `.data` from both `of_device_id` entries entirely.
`has_config_ex` and `uses_top_irq` will be added as fields to
`struct vs_chip_identity` in vs_hwdb.h, and populated for each entry
in `vs_chip_identities[]` in vs_hwdb.c. `vs_fill_chip_identity()` is
called unconditionally for all variants — chip-ID registers are present
on DCUltra Lite too. There is no need for a separate `vs_dc_info`
platform data structure.
>> +	{ .compatible = "nuvoton,ma35d1-dcu", .data =
>> &vs_dcultra_lite_info },
>>   	{},
>>   };
>>   MODULE_DEVICE_TABLE(of, vs_dc_driver_dt_match);
>> @@ -33,6 +57,13 @@ static irqreturn_t vs_dc_irq_handler(int irq, void
>> *private)
>>   	struct vs_dc *dc = private;
>>   	u32 irqs;
>>   
>> +	if (dc->info->family == VS_DC_FAMILY_DCULTRA_LITE) {
>> +		regmap_read(dc->regs, VSDC_DISP_IRQ_STA, &irqs);
> Maybe add an item in the hwdb for the IRQ register?
I'll add `uses_top_irq` as a bool field to `struct vs_chip_identity`
in vs_hwdb.h instead. The IRQ handler will branch on
`dc->identity.uses_top_irq` to read either `VSDC_TOP_IRQ_ACK` or
`VSDC_DISP_IRQ_STA`. No register address needs to be stored in the
hwdb struct.
>> +		if (irqs & BIT(0))
>> +			vs_drm_handle_irq(dc,
>> VSDC_TOP_IRQ_VSYNC(0));
>> +		return IRQ_HANDLED;
> Now I think for DC8200, the irq number decoding should be done here
> too.
I'll unify the IRQ handler: both paths will read their
respective IRQ status register and pass the raw `irqs` value to
`vs_drm_handle_irq()`. Since `VSDC_TOP_IRQ_VSYNC(n)` and
`VSDC_DISP_IRQ_VSYNC(n)` are both `BIT(n)`, the bit positions are
identical and `vs_drm_handle_irq()` handles both without change.
>> +	}
>> +
>>   	regmap_read(dc->regs, VSDC_TOP_IRQ_ACK, &irqs);
>>   
>>   	vs_drm_handle_irq(dc, irqs);
>> @@ -43,6 +74,7 @@ static irqreturn_t vs_dc_irq_handler(int irq, void
>> *private)
>>   static int vs_dc_probe(struct platform_device *pdev)
>>   {
>>   	struct device *dev = &pdev->dev;
>> +	const struct vs_dc_info *info;
>>   	struct vs_dc *dc;
>>   	void __iomem *regs;
>>   	unsigned int port_count, i;
>> @@ -55,6 +87,10 @@ static int vs_dc_probe(struct platform_device
>> *pdev)
>>   		return -ENODEV;
>>   	}
>>   
>> +	info = of_device_get_match_data(dev);
>> +	if (!info)
>> +		return -ENODEV;
>> +
>>   	port_count = of_graph_get_port_count(dev->of_node);
>>   	if (!port_count) {
>>   		dev_err(dev, "can't find DC downstream ports\n");
>> @@ -75,15 +111,31 @@ static int vs_dc_probe(struct platform_device
>> *pdev)
>>   	if (!dc)
>>   		return -ENOMEM;
>>   
>> -	dc->rsts[0].id = "core";
>> -	dc->rsts[1].id = "axi";
>> -	dc->rsts[2].id = "ahb";
>> +	dc->info = info;
>>   
>> -	ret = devm_reset_control_bulk_get_optional_shared(dev,
>> VSDC_RESET_COUNT,
>> -							  dc->rsts);
>> -	if (ret) {
>> -		dev_err(dev, "can't get reset lines\n");
>> -		return ret;
>> +	if (info->family == VS_DC_FAMILY_DC8000) {
>> +		dc->rsts[0].id = "core";
>> +		dc->rsts[1].id = "axi";
>> +		dc->rsts[2].id = "ahb";
>> +
>> +		ret =
>> devm_reset_control_bulk_get_optional_shared(dev,
>> +				VSDC_RESET_COUNT, dc->rsts);
>> +		if (ret) {
>> +			dev_err(dev, "can't get reset lines\n");
>> +			return ret;
>> +		}
>> +
>> +		dc->axi_clk = devm_clk_get_enabled(dev, "axi");
>> +		if (IS_ERR(dc->axi_clk)) {
>> +			dev_err(dev, "can't get axi clock\n");
>> +			return PTR_ERR(dc->axi_clk);
>> +		}
>> +
>> +		dc->ahb_clk = devm_clk_get_enabled(dev, "ahb");
>> +		if (IS_ERR(dc->ahb_clk)) {
>> +			dev_err(dev, "can't get ahb clock\n");
>> +			return PTR_ERR(dc->ahb_clk);
>> +		}
> Please make these clocks optional, instead of wrap them in a "family
> detection". The resets are already optional, see above.
I'll remove the family-gated block entirely. Resets will be
acquired unconditionally (they are optional, so absent ones are
skipped). axi and ahb clocks will use `devm_clk_get_optional_enabled()`
so they are silently skipped when not present in DT. The probe path
will be uniform for all variants.
>>   	}
>>   
>>   	dc->core_clk = devm_clk_get_enabled(dev, "core");
>> @@ -92,28 +144,18 @@ static int vs_dc_probe(struct platform_device
>> *pdev)
>>   		return PTR_ERR(dc->core_clk);
>>   	}
>>   
>> -	dc->axi_clk = devm_clk_get_enabled(dev, "axi");
>> -	if (IS_ERR(dc->axi_clk)) {
>> -		dev_err(dev, "can't get axi clock\n");
>> -		return PTR_ERR(dc->axi_clk);
>> -	}
>> -
>> -	dc->ahb_clk = devm_clk_get_enabled(dev, "ahb");
>> -	if (IS_ERR(dc->ahb_clk)) {
>> -		dev_err(dev, "can't get ahb clock\n");
>> -		return PTR_ERR(dc->ahb_clk);
>> -	}
>> -
>>   	irq = platform_get_irq(pdev, 0);
>>   	if (irq < 0) {
>>   		dev_err(dev, "can't get irq\n");
>>   		return irq;
>>   	}
>>   
>> -	ret = reset_control_bulk_deassert(VSDC_RESET_COUNT, dc-
>>> rsts);
>> -	if (ret) {
>> -		dev_err(dev, "can't deassert reset lines\n");
>> -		return ret;
>> +	if (info->family == VS_DC_FAMILY_DC8000) {
>> +		ret = reset_control_bulk_deassert(VSDC_RESET_COUNT,
>> dc->rsts);
>> +		if (ret) {
>> +			dev_err(dev, "can't deassert reset
>> lines\n");
>> +			return ret;
>> +		}
>>   	}
>>   
>>   	regs = devm_platform_ioremap_resource(pdev, 0);
>> @@ -123,23 +165,30 @@ static int vs_dc_probe(struct platform_device
>> *pdev)
>>   		goto err_rst_assert;
>>   	}
>>   
>> -	dc->regs = devm_regmap_init_mmio(dev, regs,
>> &vs_dc_regmap_cfg);
>> +	dc->regs = devm_regmap_init_mmio(dev, regs, info-
>>> regmap_cfg);
>>   	if (IS_ERR(dc->regs)) {
>>   		ret = PTR_ERR(dc->regs);
>>   		goto err_rst_assert;
>>   	}
>>   
>> -	ret = vs_fill_chip_identity(dc->regs, &dc->identity);
>> -	if (ret)
>> -		goto err_rst_assert;
>> +	if (info->has_chip_id) {
>> +		ret = vs_fill_chip_identity(dc->regs, &dc-
>>> identity);
>> +		if (ret)
>> +			goto err_rst_assert;
>>   
>> -	dev_info(dev, "Found DC%x rev %x customer %x\n", dc-
>>> identity.model,
>> -		 dc->identity.revision, dc->identity.customer_id);
>> +		dev_info(dev, "Found DC%x rev %x customer %x\n",
>> +			 dc->identity.model, dc->identity.revision,
>> +			 dc->identity.customer_id);
>>   
>> -	if (port_count > dc->identity.display_count) {
>> -		dev_err(dev, "too many downstream ports than HW
>> capability\n");
>> -		ret = -EINVAL;
>> -		goto err_rst_assert;
>> +		if (port_count > dc->identity.display_count) {
>> +			dev_err(dev, "too many downstream ports than
>> HW capability\n");
>> +			ret = -EINVAL;
>> +			goto err_rst_assert;
>> +		}
>> +	} else {
>> +		/* Fill identity from platform data */
>> +		dc->identity.display_count = info->display_count;
>> +		dc->identity.formats = info->formats;
>>   	}
>>   
>>   	for (i = 0; i < dc->identity.display_count; i++) {
>> @@ -168,7 +217,8 @@ static int vs_dc_probe(struct platform_device
>> *pdev)
>>   	return 0;
>>   
>>   err_rst_assert:
>> -	reset_control_bulk_assert(VSDC_RESET_COUNT, dc->rsts);
>> +	if (info->family == VS_DC_FAMILY_DC8000)
>> +		reset_control_bulk_assert(VSDC_RESET_COUNT, dc-
>>> rsts);
>>   	return ret;
>>   }
>>   
>> @@ -180,7 +230,8 @@ static void vs_dc_remove(struct platform_device
>> *pdev)
>>   
>>   	dev_set_drvdata(&pdev->dev, NULL);
>>   
>> -	reset_control_bulk_assert(VSDC_RESET_COUNT, dc->rsts);
>> +	if (dc->info->family == VS_DC_FAMILY_DC8000)
>> +		reset_control_bulk_assert(VSDC_RESET_COUNT, dc-
>>> rsts);
>>   }
>>   
>>   static void vs_dc_shutdown(struct platform_device *pdev)
>> diff --git a/drivers/gpu/drm/verisilicon/vs_dc.h
>> b/drivers/gpu/drm/verisilicon/vs_dc.h
>> index ed1016f18758..f0613519af37 100644
>> --- a/drivers/gpu/drm/verisilicon/vs_dc.h
>> +++ b/drivers/gpu/drm/verisilicon/vs_dc.h
>> @@ -31,6 +31,7 @@ struct vs_dc {
>>   	struct clk *pix_clk[VSDC_MAX_OUTPUTS];
>>   	struct reset_control_bulk_data rsts[VSDC_RESET_COUNT];
>>   
>> +	const struct vs_dc_info *info;
>>   	struct vs_drm_dev *drm_dev;
>>   	struct vs_chip_identity identity;
>>   };
>> diff --git a/drivers/gpu/drm/verisilicon/vs_drm.c
>> b/drivers/gpu/drm/verisilicon/vs_drm.c
>> index fd259d53f49f..ff0fc6673006 100644
>> --- a/drivers/gpu/drm/verisilicon/vs_drm.c
>> +++ b/drivers/gpu/drm/verisilicon/vs_drm.c
>> @@ -27,6 +27,7 @@
>>   #include "vs_dc.h"
>>   #include "vs_dc_top_regs.h"
>>   #include "vs_drm.h"
>> +#include "vs_hwdb.h"
>>   
>>   #define DRIVER_NAME	"verisilicon"
>>   #define DRIVER_DESC	"Verisilicon DC-series display controller
>> driver"
>> @@ -72,12 +73,19 @@ static struct drm_mode_config_helper_funcs
>> vs_mode_config_helper_funcs = {
>>   	.atomic_commit_tail = drm_atomic_helper_commit_tail,
>>   };
>>   
>> -static void vs_mode_config_init(struct drm_device *drm)
>> +static void vs_mode_config_init(struct drm_device *drm, struct vs_dc
>> *dc)
>>   {
>>   	drm->mode_config.min_width = 0;
>>   	drm->mode_config.min_height = 0;
>> -	drm->mode_config.max_width = 8192;
>> -	drm->mode_config.max_height = 8192;
>> +
>> +	if (dc->info->family == VS_DC_FAMILY_DCULTRA_LITE) {
>> +		drm->mode_config.max_width = 1920;
>> +		drm->mode_config.max_height = 1080;
> Surely only max width 1920 and max height 1080? Can a display of
> 1080x1920 (e.g. a portrait DSI panel behind a RGB2DSI bridge) be
> supported? Can a 2170x60 display (MacBook Touch Bar panel, also a DSI
> panel) be supported? Both displays here will have no higher pixel clock
> than 1080p in the same refresh rate, although the width / height is
> higher than your restriction.
>
> In addition, these parameters decide how big a FB can be created -- the
> FB might be scaned out by multiple devices (e.g. a USB DisplayLink
> device scanning out the remaining part). The stride register is said to
> have 17-bit width in the MA35D1 TRM, so the possible FB width could be
> quite high -- assume the 17th bit is only for the value with one 1 and
> all remaining 0, we get 65536 bytes stride; with 4-byte-per-pixel
> divided this gets 16384 pixels -- the htotal/hdisplay/vtotal/vdisplay
> fields in the manual has 15-bit field width, which can reach 32767.
>
> I strongly suggest leave the original values here.
You are right. I'll revert to 8192x8192 for all variants. The
variant-specific max_width/max_height logic will be removed entirely
and vs_mode_config_init() will take no dc argument.
>> +	} else {
>> +		drm->mode_config.max_width = 8192;
>> +		drm->mode_config.max_height = 8192;
>> +	}
>> +
>>   	drm->mode_config.funcs = &vs_mode_config_funcs;
>>   	drm->mode_config.helper_private =
>> &vs_mode_config_helper_funcs;
>>   }
>> @@ -125,7 +133,7 @@ int vs_drm_initialize(struct vs_dc *dc, struct
>> platform_device *pdev)
>>   	if (ret)
>>   		return ret;
>>   
>> -	vs_mode_config_init(drm);
>> +	vs_mode_config_init(drm, dc);
>>   
>>   	/* Enable connectors polling */
>>   	drm_kms_helper_poll_init(drm);
>> diff --git a/drivers/gpu/drm/verisilicon/vs_hwdb.c
>> b/drivers/gpu/drm/verisilicon/vs_hwdb.c
>> index 09336af0900a..39402d75d841 100644
>> --- a/drivers/gpu/drm/verisilicon/vs_hwdb.c
>> +++ b/drivers/gpu/drm/verisilicon/vs_hwdb.c
>> @@ -78,7 +78,7 @@ static const u32 vs_formats_array_with_yuv444[] = {
>>   	/* TODO: non-RGB formats */
>>   };
>>   
>> -static const struct vs_formats vs_formats_no_yuv444 = {
>> +const struct vs_formats vs_formats_no_yuv444 = {
>>   	.array = vs_formats_array_no_yuv444,
>>   	.num = ARRAY_SIZE(vs_formats_array_no_yuv444)
>>   };
>> diff --git a/drivers/gpu/drm/verisilicon/vs_hwdb.h
>> b/drivers/gpu/drm/verisilicon/vs_hwdb.h
>> index 92192e4fa086..655cf93ca3aa 100644
>> --- a/drivers/gpu/drm/verisilicon/vs_hwdb.h
>> +++ b/drivers/gpu/drm/verisilicon/vs_hwdb.h
>> @@ -14,6 +14,29 @@ struct vs_formats {
>>   	unsigned int num;
>>   };
>>   
>> +enum vs_dc_family {
>> +	VS_DC_FAMILY_DC8000,
>> +	VS_DC_FAMILY_DCULTRA_LITE,
>> +};
>> +
>> +/**
>> + * struct vs_dc_info - per-SoC DC platform data
>> + * @family:		DC IP family (DC8000, DCUltra Lite, etc.)
>> + * @display_count:	number of display outputs (0 = auto-detect
>> from DT/HW)
>> + * @has_chip_id:	whether chip identity registers exist
>> + * @has_config_ex:	whether CONFIG_EX commit mechanism exists
>> + * @regmap_cfg:		regmap configuration for this
>> variant
>> + * @formats:		supported pixel formats (NULL = auto-detect
>> from chip ID)
>> + */
>> +struct vs_dc_info {
>> +	enum vs_dc_family family;
>> +	u32 display_count;
>> +	bool has_chip_id;
>> +	bool has_config_ex;
>> +	const struct regmap_config *regmap_cfg;
>> +	const struct vs_formats *formats;
>> +};
>> +
>>   struct vs_chip_identity {
>>   	u32 model;
>>   	u32 revision;
>> @@ -23,6 +46,8 @@ struct vs_chip_identity {
>>   	const struct vs_formats *formats;
>>   };
>>   
>> +extern const struct vs_formats vs_formats_no_yuv444;
>> +
>>   int vs_fill_chip_identity(struct regmap *regs,
>>   			  struct vs_chip_identity *ident);
>>   
>> diff --git a/drivers/gpu/drm/verisilicon/vs_primary_plane.c
>> b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
>> index 1f2be41ae496..197d5d683e22 100644
>> --- a/drivers/gpu/drm/verisilicon/vs_primary_plane.c
>> +++ b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
>> @@ -55,8 +55,9 @@ static int vs_primary_plane_atomic_check(struct
>> drm_plane *plane,
>>   
>>   static void vs_primary_plane_commit(struct vs_dc *dc, unsigned int
>> output)
>>   {
>> -	regmap_set_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
>> -			VSDC_FB_CONFIG_EX_COMMIT);
>> +	if (dc->info->has_config_ex)
>> +		regmap_set_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
>> +				VSDC_FB_CONFIG_EX_COMMIT);
> Should VALID bit be written here instead of doing nothing on
> DC8000/DCUltraLite ?
Same as reply [a]. No `VSDC_FB_CONFIG_VALID` macro is needed.
For non-config_ex variants, `vs_primary_plane_commit()` is a no-op —
`VSDC_FB_CONFIG_ENABLE` (OUTPUT, bit 0) is set in `vs_crtc_atomic_enable()`
and `VSDC_FB_CONFIG_RESET` (bit 4) is managed in the bridge enable/disable
paths.
>>   }
>>   
>>   static void vs_primary_plane_atomic_enable(struct drm_plane *plane,
>> @@ -69,11 +70,13 @@ static void vs_primary_plane_atomic_enable(struct
>> drm_plane *plane,
>>   	unsigned int output = vcrtc->id;
>>   	struct vs_dc *dc = vcrtc->dc;
>>   
>> -	regmap_set_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
>> -			VSDC_FB_CONFIG_EX_FB_EN);
>> -	regmap_update_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
>> -			   VSDC_FB_CONFIG_EX_DISPLAY_ID_MASK,
>> -			   VSDC_FB_CONFIG_EX_DISPLAY_ID(output));
>> +	if (dc->info->has_config_ex) {
>> +		regmap_set_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
>> +				VSDC_FB_CONFIG_EX_FB_EN);
>> +		regmap_update_bits(dc->regs,
>> VSDC_FB_CONFIG_EX(output),
>> +				
>> VSDC_FB_CONFIG_EX_DISPLAY_ID_MASK,
>> +				
>> VSDC_FB_CONFIG_EX_DISPLAY_ID(output));
>> +	}
>>   
>>   	vs_primary_plane_commit(dc, output);
>>   }
>> @@ -88,8 +91,9 @@ static void vs_primary_plane_atomic_disable(struct
>> drm_plane *plane,
>>   	unsigned int output = vcrtc->id;
>>   	struct vs_dc *dc = vcrtc->dc;
>>   
>> -	regmap_set_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
>> -			VSDC_FB_CONFIG_EX_FB_EN);
>> +	if (dc->info->has_config_ex)
>> +		regmap_set_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
>> +				VSDC_FB_CONFIG_EX_FB_EN);
>>   
>>   	vs_primary_plane_commit(dc, output);
>>   }
>> @@ -126,6 +130,11 @@ static void
>> vs_primary_plane_atomic_update(struct drm_plane *plane,
>>   			   VSDC_FB_CONFIG_UV_SWIZZLE_EN,
>>   			   vs_state->format.uv_swizzle);
>>   
>> +	/* DCUltra Lite requires explicit enable/reset bits in
>> FB_CONFIG */
>> +	if (!dc->info->has_config_ex)
>> +		regmap_set_bits(dc->regs, VSDC_FB_CONFIG(output),
>> +				VSDC_FB_CONFIG_ENABLE |
>> VSDC_FB_CONFIG_RESET);
> Should VSDC_FB_CONFIG_RESET be only set when it's ready to output the
> signal (at least all timing is programmed)? I think it should be
> programmed in crtc/bridge instead of primary plane, although it's in
> the DcregFrameBufferConfig0 register (obviously this sounds a little
> weird, this might be why they changed this in DC8200).
>
> When ENABLE (OUTPUT in the document) is cleared, all pixels will be
> blacked out; so I think it's better to set ENABLE in CRTC, and then set
> RESET in bridge (doing the work of encoder in this driver) -- it seems
> that for DC8000/DCUltraLite the primary plane is not possible to be
> disabled.
I'll move these as suggested:
- `VSDC_FB_CONFIG_ENABLE` will be set in `vs_crtc_atomic_enable()` for
   non-config_ex variants (after the pixel clock is enabled).
- `VSDC_FB_CONFIG_RESET` will be set in `vs_bridge_enable_common()` for
   non-config_ex variants, after all timing registers are programmed.
- `VSDC_FB_CONFIG_RESET` will be cleared in `vs_bridge_atomic_disable()`
   for non-config_ex variants to stall DPI output.
- The ENABLE/RESET writes will be removed from
   `vs_primary_plane_atomic_update()`.
- `vs_primary_plane_commit()` will perform no action for non-config_ex
   variants; the function only triggers `VSDC_FB_CONFIG_EX_COMMIT` for
   config_ex variants.
>>   	dma_addr = vs_fb_get_dma_addr(fb, &state->src);
>>   
>>   	regmap_write(dc->regs, VSDC_FB_ADDRESS(output),
>> @@ -133,16 +142,18 @@ static void
>> vs_primary_plane_atomic_update(struct drm_plane *plane,
>>   	regmap_write(dc->regs, VSDC_FB_STRIDE(output),
>>   		     fb->pitches[0]);
>>   
>> -	regmap_write(dc->regs, VSDC_FB_TOP_LEFT(output),
>> -		     VSDC_MAKE_PLANE_POS(state->crtc_x, state-
>>> crtc_y));
>> -	regmap_write(dc->regs, VSDC_FB_BOTTOM_RIGHT(output),
>> -		     VSDC_MAKE_PLANE_POS(state->crtc_x + state-
>>> crtc_w,
>> -					 state->crtc_y + state-
>>> crtc_h));
>>   	regmap_write(dc->regs, VSDC_FB_SIZE(output),
>>   		     VSDC_MAKE_PLANE_SIZE(state->crtc_w, state-
>>> crtc_h));
>>   
>> -	regmap_write(dc->regs, VSDC_FB_BLEND_CONFIG(output),
>> -		     VSDC_FB_BLEND_CONFIG_BLEND_DISABLE);
>> +	if (dc->info->has_config_ex) {
>> +		regmap_write(dc->regs, VSDC_FB_TOP_LEFT(output),
>> +			     VSDC_MAKE_PLANE_POS(state->crtc_x,
>> state->crtc_y));
>> +		regmap_write(dc->regs, VSDC_FB_BOTTOM_RIGHT(output),
>> +			     VSDC_MAKE_PLANE_POS(state->crtc_x +
>> state->crtc_w,
>> +						 state->crtc_y +
>> state->crtc_h));
>> +		regmap_write(dc->regs, VSDC_FB_BLEND_CONFIG(output),
>> +			     VSDC_FB_BLEND_CONFIG_BLEND_DISABLE);
>> +	}
>>   
>>   	vs_primary_plane_commit(dc, output);
>>   }
>> diff --git a/drivers/gpu/drm/verisilicon/vs_primary_plane_regs.h
>> b/drivers/gpu/drm/verisilicon/vs_primary_plane_regs.h
>> index cbb125c46b39..288064760b48 100644
>> --- a/drivers/gpu/drm/verisilicon/vs_primary_plane_regs.h
>> +++ b/drivers/gpu/drm/verisilicon/vs_primary_plane_regs.h
>> @@ -16,6 +16,8 @@
>>   #define VSDC_FB_STRIDE(n)			(0x1408 + 0x4 * (n))
>>   
>>   #define VSDC_FB_CONFIG(n)			(0x1518 + 0x4 * (n))
>> +#define VSDC_FB_CONFIG_ENABLE			BIT(0)
> As I mentioned that the VALID bit is quite important, please add it
> here (you can call it "COMMIT" too if you like).
>
> #define VSDC_FB_CONFIG_VALID BIT(3)

Same as reply [a]. No `VSDC_FB_CONFIG_VALID` macro is needed.

Thank you very much for taking the time to review my work. 🙂

>> +#define VSDC_FB_CONFIG_RESET			BIT(4)
>>   #define VSDC_FB_CONFIG_CLEAR_EN			BIT(8)
>>   #define VSDC_FB_CONFIG_ROT_MASK			GENMASK(13,
>> 11)
>>   #define VSDC_FB_CONFIG_ROT(v)			((v) << 11)
