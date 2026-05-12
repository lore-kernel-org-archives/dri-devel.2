Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E83D5CD4F24
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 07:53:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3064810ECFF;
	Wed, 13 May 2026 07:53:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kXAjj0t6";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2043110E9D8
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 09:06:50 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-366087480d8so4794352a91.3
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 02:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778576810; x=1779181610; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1x3QKNa6wEmvoxZX8OKMfbWBrcN6crkcagrWuMBo3Xc=;
 b=kXAjj0t6iAu0X2OT0jEzwI+Evps779Cg8VeFSxXRHgTpibSrkGynKXcCE3Hh+BB0IV
 xkVmmPkQiD8HJD/haoIvm+gIQHJ7LQNe0MKe7XP7t+Ay2/3BqxbwEQv8u9NwKW9jvOAb
 bH9s3sg+M+aVny/9S/di6zH6pnPJ0BH76QB24pdZg6EFjExlG3mwLsMohDjnSrNB92wB
 YTXv0rNfutPTBZgKXgvdMMgvaRR/FashrtpIrLQfldqmpLkfzjoc2KmSBM7Z/KU1gu+N
 lSx2scLR2Iv0e6qyhDymNtYQaVav2l88XJm64jneOrK/wWEYbnoNvcX+BiNbaediqtbw
 u6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778576810; x=1779181610;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1x3QKNa6wEmvoxZX8OKMfbWBrcN6crkcagrWuMBo3Xc=;
 b=rjLbLAKueHETyUfvneOrxrOZDM8NAKW0p0leupDcjHj9yKtLPElcnczvs9kGHL0b52
 CKOURbaW/rTylqeGzfiFPAuB09wTKD+JIgdUPqLz62/ToXm4EPWHSEkSEyICjGtWe36a
 OhKuamiDG7ESr+bYtSJeQqgFOQICz/mlZecqawlLHr10kUHACK2Blp9r6L9qmePCpTdW
 gAZs5142btiTVaKgTKa3/IcHeojTccZ4QGDyCtzedM+Vv8cFuqANMQSwGwO4MUCemB74
 sMO1oFogp2PH8FKbKQcltBVd7yoU2OAC0faV6RZTVwvCGZyMICTBRopVLbuUmc8qFTr0
 ntmA==
X-Forwarded-Encrypted: i=1;
 AFNElJ85CkLWksDzSHxrtau0fzMNJGeeXLNZmiZb13HS285qQ+a+Ylczl56yZtnKBtnEsi8EscSNJrp/OGg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxFScPBahf4Ju2EXd8DqXTNRdPKExDcXBp7yQpGiLqEJuPb0iwo
 AM0Y+lXnhA4oktxN5k2SHQLhnZt3En+fUvzVw4ErqfMBOE0sQcKBfoqQ
X-Gm-Gg: Acq92OE1ELqNhTQlQYf2nUImiLwOHoL67SycYz+O4mOt6DIo4cKMavVhGratcsXzprf
 P820CPvcyHjOj0tnfuChC6LwLxQPkZ7oiqBTvdPezJ3LFHl6NASB2j2m4AEOJN9KkBVyYIJFw5E
 F2DWLhuM0IU1szG+Jp+vcT7drvxNEgLaj+7maE9TOCRt+zGge7qSQg4E3wTvWzq7SHD2L97hVti
 iZCKKr+lgjryKw2JTeuqAyjhGASdMPLNdFd+nyeTtq2KmoD7/qJT9YSF0kBxTHi8V+W01q8WIjV
 yMnXJYZb0UU59ZGpEWzGd/CytGjwjwS43IR/EaT/sfdpcQ1QfGp2pbWFBU6ZlaJ0fDLO8K9vcny
 cVLTKgcFrIkX28DqkscpMC4uj2gC0FB4Qa8iN55LQIF2RAwfRkTzpzNe2x+Z0IjiNO2dD/zTHt5
 zWcgUOT1l0BZPt+R6hH0aHLw8EmqWrjToSQ1aVj1F6Ev7glA5LjTM1HOuWtHIFWAAnetvoeofcM
 8mK
X-Received: by 2002:a17:90b:3806:b0:367:bf59:6f99 with SMTP id
 98e67ed59e1d1-368b26f7b09mr2441610a91.26.1778576809623; 
 Tue, 12 May 2026 02:06:49 -0700 (PDT)
Received: from [192.168.0.100] (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-367d625cee7sm10341825a91.2.2026.05.12.02.06.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 02:06:49 -0700 (PDT)
Message-ID: <dfbc4042-64cf-49f2-a5de-12260beffaa0@gmail.com>
Date: Tue, 12 May 2026 17:06:43 +0800
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
 <de35406e-874d-4bdd-be7f-3d74dc37b13f@gmail.com>
 <3b94806073de8bd1d79aa7ec956493f67679e46b.camel@iscas.ac.cn>
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <3b94806073de8bd1d79aa7ec956493f67679e46b.camel@iscas.ac.cn>
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


On 5/12/2026 4:11 PM, Icenowy Zheng wrote:
> 在 2026-05-12二的 15:45 +0800，Joey Lu写道：
>> On 5/11/2026 5:47 PM, Icenowy Zheng wrote:
>>> 在 2026-05-11一的 15:51 +0800，Joey Lu写道：
>>>> The Nuvoton MA35D1 SoC integrates a Verisilicon DCUltra Lite
>>>> display
>>>> controller, which is a previous generation of the DC8000 series.
>>>> While
>>>> the general register layout is similar to the DC8000, there are
>>>> several
>>>> key differences that require per-variant handling in the driver.
>>>>
>>>> Add a vs_dc_info platform data structure (in vs_hwdb.h) to
>>>> describe
>>>> per-IP-variant capabilities, and use it throughout the driver to
>>>> select
>>>> the correct code paths at runtime.
>>>>
>>>> Key differences between DC8000 and DCUltra Lite handled:
>>> What the driver supports now is DC8200, DC8000 have the following
>>> point
>>> 1~4 the same with DCUltraLite (different to DC8200).
>> Understood. I'll rename all `vs_dc8000_*` identifiers to
>> `vs_dc8200_*` in v2. The commit message will also be corrected to say
>> that points 1~4 are differences from DC8200, not DC8000.
>>>> 1. No chip identity registers (0x0020-0x0030): DCUltra Lite uses
>>>> static
>>>>      platform data instead of reading model/revision/customer_id
>>>> from
>>>> HW.
>>> My test shows that revision and customer_id is correctly present,
>>> only
>>> model is 0 -- I think this can be also considered as a valid model
>>> value because the IP name has also no model number.
>>>
>>> The revision number is 0x5560 and customer id is 0x305 .
>> Thank you for testing. I'll drop the `has_chip_id` flag
>> entirely. In v2, `vs_fill_chip_identity()` will be called for all
>> variants. A new entry will be added to `vs_chip_identities[]` in
>> vs_hwdb.c with model=0x0, revision=0x5560, customer_id=0x305,
>> display_count=1, and `vs_formats_no_yuv444`.
>> e.g. verisilicon-dc 40260000.display: Found DC0 rev 5560 customer 305
>>>> 2. No CONFIG_EX commit mechanism: DC8000 uses registers at 0x1CC0
>>>>      (FB_CONFIG_EX), 0x24D8 (FB_TOP_LEFT), 0x24E0
>>>> (FB_BOTTOM_RIGHT),
>>>>      0x2510 (FB_BLEND_CONFIG), 0x2518 (PANEL_CONFIG_EX). DCUltra
>>>> Lite
>>>>      omits all of these and instead uses enable/reset bits in
>>>> FB_CONFIG
>>>>      (bit 0 = enable, bit 4 = reset) for direct framebuffer
>>>> updates.
>>>>
>>>> 3. No PANEL_START register (0x1CCC): DCUltra Lite panel output
>>>> starts
>>>>      when PANEL_CONFIG.RUNNING is set; no separate multi-display
>>>> sync
>>>>      start register is needed.
>>>>
>>>> 4. Different IRQ registers: DCUltra Lite uses 0x147C (IRQ_STA) /
>>>>      0x1480 (IRQ_EN); DC8000 uses 0x0010 (IRQ_ACK) / 0x0014
>>>> (IRQ_EN).
>>>>
>>>> 5. Different clock/reset topology: DCUltra Lite requires only
>>>> "core"
>>>>      (bus gate) and "pix0" (pixel divider) clocks with no reset
>>>> lines
>>>>      managed by the driver. DC8000 needs core/axi/ahb clocks and
>>>> three
>>>>      resets.
>>> It's possible that your SoC integration combines core clock gate
>>> with
>>> bus clock gate instead of bus clock gate not existing.
>> Agreed. In v2 I'll remove the family-gated clock handling and
>> instead use `devm_clk_get_optional_enabled()` for the axi and ahb
>> clocks, so they are simply skipped if not present in DT. Resets are
>> already optional. This keeps the probe path uniform and handles any
>> SoC-specific clock combinations naturally.
> Maybe this could be splitted as another patch, to make single commits
> smaller.
Got it.
>>>> 6. Single output only: DCUltra Lite has one display output; per-
>>>> output
>>>>      index logic is still in place but display_count is fixed at
>>>> 1.
>>>>
>>>> 7. Reduced register space: max_register is 0x2000 vs DC8000's
>>>> 0x2544.
>>>>
>>>> Add the "nuvoton,ma35d1-dcu" compatible string to the OF match
>>>> table,
>>>> extend Kconfig to allow building on ARCH_MA35 platforms, and
>>>> expose
>>>> vs_formats_no_yuv444 as the default format table for DCUltra Lite
>>>> (YUV444 blending is a DC8000-only feature).
>>>>
>>>> All changes have been tested on Nuvoton MA35D1 hardware and are
>>>> functioning correctly.
>>>>
>>>> Signed-off-by: Joey Lu <a0987203069@gmail.com>
>>>> ---
>>>>    drivers/gpu/drm/verisilicon/Kconfig           |   2 +-
>>>>    drivers/gpu/drm/verisilicon/vs_bridge.c       |  28 ++--
>>>>    drivers/gpu/drm/verisilicon/vs_crtc.c         |  13 +-
>>>>    drivers/gpu/drm/verisilicon/vs_dc.c           | 129
>>>> ++++++++++++----
>>>> --
>>>>    drivers/gpu/drm/verisilicon/vs_dc.h           |   1 +
>>>>    drivers/gpu/drm/verisilicon/vs_drm.c          |  16 ++-
>>>>    drivers/gpu/drm/verisilicon/vs_hwdb.c         |   2 +-
>>>>    drivers/gpu/drm/verisilicon/vs_hwdb.h         |  25 ++++
>>>>    .../gpu/drm/verisilicon/vs_primary_plane.c    |  43 +++---
>>>>    .../drm/verisilicon/vs_primary_plane_regs.h   |   2 +
>>>>    10 files changed, 187 insertions(+), 74 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/verisilicon/Kconfig
>>>> b/drivers/gpu/drm/verisilicon/Kconfig
>>>> index 7cce86ec8603..295d246eb4b4 100644
>>>> --- a/drivers/gpu/drm/verisilicon/Kconfig
>>>> +++ b/drivers/gpu/drm/verisilicon/Kconfig
>>>> @@ -2,7 +2,7 @@
>>>>    config DRM_VERISILICON_DC
>>>>    	tristate "DRM Support for Verisilicon DC-series display
>>>> controllers"
>>>>    	depends on DRM && COMMON_CLK
>>>> -	depends on RISCV || COMPILE_TEST
>>>> +	depends on RISCV || ARCH_MA35 || COMPILE_TEST
>>>>    	select DRM_BRIDGE_CONNECTOR
>>>>    	select DRM_CLIENT_SELECTION
>>>>    	select DRM_DISPLAY_HELPER
>>>> diff --git a/drivers/gpu/drm/verisilicon/vs_bridge.c
>>>> b/drivers/gpu/drm/verisilicon/vs_bridge.c
>>>> index 7a93049368db..225af322de32 100644
>>>> --- a/drivers/gpu/drm/verisilicon/vs_bridge.c
>>>> +++ b/drivers/gpu/drm/verisilicon/vs_bridge.c
>>>> @@ -164,13 +164,16 @@ static void vs_bridge_enable_common(struct
>>>> vs_crtc *crtc,
>>>>    			VSDC_DISP_PANEL_CONFIG_CLK_EN);
>>>>    	regmap_set_bits(dc->regs,
>>>> VSDC_DISP_PANEL_CONFIG(output),
>>>>    			VSDC_DISP_PANEL_CONFIG_RUNNING);
>>>> -	regmap_clear_bits(dc->regs, VSDC_DISP_PANEL_START,
>>>> -			
>>>> VSDC_DISP_PANEL_START_MULTI_DISP_SYNC);
>>>> -	regmap_set_bits(dc->regs, VSDC_DISP_PANEL_START,
>>>> -			VSDC_DISP_PANEL_START_RUNNING(output));
>>>>    
>>>> -	regmap_set_bits(dc->regs,
>>>> VSDC_DISP_PANEL_CONFIG_EX(crtc-
>>>>> id),
>>>> -			VSDC_DISP_PANEL_CONFIG_EX_COMMIT);
>>>> +	if (dc->info->has_config_ex) {
>>>> +		regmap_clear_bits(dc->regs,
>>>> VSDC_DISP_PANEL_START,
>>>> +				
>>>> VSDC_DISP_PANEL_START_MULTI_DISP_SYNC);
>>>> +		regmap_set_bits(dc->regs, VSDC_DISP_PANEL_START,
>>>> +				VSDC_DISP_PANEL_START_RUNNING(ou
>>>> tput
>>>> ));
>>>> +
>>>> +		regmap_set_bits(dc->regs,
>>>> VSDC_DISP_PANEL_CONFIG_EX(crtc->id),
>>>> +				VSDC_DISP_PANEL_CONFIG_EX_COMMIT
>>>> );
>>> Should the commit operation happen on DC8000/DCUltraLite too? (By
>>> writing to DcregFrameBufferConfig0.VALID).
>>>
>>> Many registers written has "Note: This field is double buffered" in
>>> the
>>> DCUltraLite documentation.
>>>
>>> I suggest create a static function for commit -- write to the
>>> corresponding commit bit on DC8200, and write to
>>> DcregFrameBufferConfig0.VALID on DC8000/DCUltraLite.
>> [a] There is no commit operation for DCUltra Lite.
>> I'll not add a `VSDC_FB_CONFIG_VALID` macro. VALID (BIT(3)) is a
>> hardware-managed double-buffer status bit: hardware writes 1=PENDING
>> when a new register set is ready and clears to 0=WORKING after the
>> VBLANK copy. Software must never write it, and there is no polling
>> use
> It seems to be writable and controls whether register buffering is
> enabled, see [1].
>
> The description of this bit in MA35D1 TRM says "This ensures a frame
> will always start with a valid working set if this register is
> programmed last, which reduces the need for SW to wait for the start of
> a VBLANK signal in order to ensure all states are loaded before the
> next VBLANK", which indicates some kind of "committing write", although
> the code at [1] seems to indicate that double buffering is only enabled
> when bit is cleared.
>
> Anyway this bit should be programmable, and "Software must never write
> it" contradicts with the MA35D1 TRM.
>
> Thanks,
> Icenowy
>
> [1]
> https://github.com/rockos-riscv/rockos-kernel/blob/rockos-v6.6.y/drivers/gpu/drm/eswin/es_dc_hw.c#L993
Thank you for the correction. I'll add
`#define VSDC_FB_CONFIG_VALID BIT(3)` to vs_primary_plane_regs.h and
write it in `vs_primary_plane_commit()` for non-config_ex variants.
>> case in the driver that requires a named constant. For non-config_ex
>> variants, `vs_primary_plane_commit()` performs no commit operation —
>> `VSDC_FB_CONFIG_ENABLE` (OUTPUT, BIT(0)) is set in
>> `vs_crtc_atomic_enable()` and `VSDC_FB_CONFIG_RESET` (BIT(4)) is
>> set/cleared in the bridge enable/disable paths.
> ========= 8< ==========
>
