Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA365CD4F48
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 07:41:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48A8A10E6DE;
	Mon, 18 May 2026 07:41:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cstWlngN";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CA2110F49A
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 09:08:32 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2bc7b311e77so3283235ad.0
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 02:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778836112; x=1779440912; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MDBlcreApT69nD2JDPHGYA71d8rTboSMPdYxDM3luXk=;
 b=cstWlngNxZ72//0GqjSAaw92GxlO44g+qaY7/xH/Wl2UkpuVQE681h3PzDYndw3GNN
 v/uyBA/77nCh/3FtjTc5RDc7qN7KmxuuHnIWeN9fvIKcCKYuFj9hYwk6FACOxTBSCqvy
 jU7GGM88udtY4PLzq1f3lvuEqQnvKu7plRAezsnIGmTg7H0WVATj7mgBDg+Q5h6mMxjt
 chPgYvfc1Gnkr0gj4/18UEnwsjDOK1TgHEq2GAumS0iZUgOZxsGUrRLK5K3EHYkPyb4c
 MGHzX6shBN4Us6yHJi1WhklPm2Qb3fdAT6BHtU46hEPi6YdzkhhzYOfaDMdnNPpaBibz
 FJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778836112; x=1779440912;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MDBlcreApT69nD2JDPHGYA71d8rTboSMPdYxDM3luXk=;
 b=V29sZt7w7WJG/YLHi27vhyVlF+ihs4Bq4HaB8mlrmFizYQgc6+JiZHcHCfK+5wNTrc
 chOZyJpkkKgBCDqdeI/vEqmS2AI7h9soGceivlfobr6FEY61wi1Fr1VbF08g+u/Ms8Qu
 Y0nTZn1R7jDr5IDzSy2xbefsSoQjusmZUlkaZG+GjgaXRyO2Dr4xwEySXvDCHenJ5adW
 /qlOdHAAryBk6CjXwgwAsnpSwsGEOSUOdyBPgP9ba7pP0jRiF8ocEJfmsDXHayfN/45Q
 eD6GMl1FxqUUWJ5ARCu7UJkeedQU0Aizrx6yM2r62LiukSxX1ArVbINFQUUMvLw8NUV2
 pkJQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/QgBdv56EdkmFWchMrn4HEjQBPNIeiNH+ytQeNbo+xzQSXq2ThAnYAbeNlod03NU5fjA+ZbmeNFyo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxcmalr2pwcrjdk/JVRfIr5JSLY89l5hGc8V0dIYWvTYRB/p9sq
 aKKK8G+H/7e9pKtyz5cRRNc8dUsxNCpd+75KE0fhmvI/35uJTIGLlexU
X-Gm-Gg: Acq92OEwbmaCnEPM3QfphoEXHZAj0PVMk4QRs/ui6U9c+0tXPuBq42BnXUmToJ775H7
 VkjGdzQ90YUmrkCi2LgFOnauLiPyTA51H/3aU7rMKShsWzyVS3swUsrvx8eYbwW2liDhQCNsrET
 KZaPd53vKl26s3Rg1cNxDiCsJLxyP0XtRfTOouYYNVgAjNFiKBs5A9FhCo5BYmUhc7JEcRZKHR4
 FiiZdbRJ8H52fSYwgzhdNuEynJ5N6lxviWPULhWBmGBLdzzKz4kb5U4ZqrA9+gEoCjy4l2FDAz/
 k3uhLqqYDYYmKVkZWfWdHeLPFMVz2QNVLj7zGk2a5XNJExlA3Q8yuB7mDqSbypoHhmvgXHN5oJs
 AxvTFOWA5gkZs3mlTaCXzBywhfmVTAzPOggcmfgHzrQUCnYUVQVXdgC6OKtBthHNTqYSO6AXwKD
 9NoJT0/khG5fNwvMYJtjJPI5zNg36t50DJbgr7OjrqLtQPkWvy1Rn4cw9ZRe6xdgofdbbGLYwrS
 ThXP2WF2Kws46w=
X-Received: by 2002:a17:903:46c7:b0:2bc:dca9:f0ed with SMTP id
 d9443c01a7336-2bd7e9249a5mr28348315ad.15.1778836111714; 
 Fri, 15 May 2026 02:08:31 -0700 (PDT)
Received: from [192.168.0.100] (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5d0fd384sm55522125ad.65.2026.05.15.02.08.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2026 02:08:31 -0700 (PDT)
Message-ID: <520e1683-6d5c-4e1f-8811-0ef78cf8d605@gmail.com>
Date: Fri, 15 May 2026 17:08:25 +0800
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
 <dfbc4042-64cf-49f2-a5de-12260beffaa0@gmail.com>
 <4bf6efbb222ebc4d770ad613d17c6185e7cb2fda.camel@iscas.ac.cn>
 <1d04dd6d-f245-4b83-96b0-c5491fad8093@gmail.com>
 <76a9e9b676509e85484a1eb31c723b46c7e21a19.camel@iscas.ac.cn>
 <1a42a168-1dbb-467e-9053-b5585a737f71@gmail.com>
 <1c4d8611411e2d14699ac0b9aeb5b2377feedc8a.camel@iscas.ac.cn>
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <1c4d8611411e2d14699ac0b9aeb5b2377feedc8a.camel@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 18 May 2026 07:41:36 +0000
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


On 5/15/2026 4:38 PM, Icenowy Zheng wrote:
> 在 2026-05-15五的 14:25 +0800，Joey Lu写道：
>> On 5/12/2026 9:12 PM, Icenowy Zheng wrote:
>>> 在 2026-05-12二的 18:59 +0800，Joey Lu写道：
>>>> On 5/12/2026 6:01 PM, Icenowy Zheng wrote:
>>>>> 在 2026-05-12二的 17:06 +0800，Joey Lu写道：
>>>>>
>>>>> ======= 8< =============
>>>>>>>>>> diff --git a/drivers/gpu/drm/verisilicon/vs_bridge.c
>>>>>>>>>> b/drivers/gpu/drm/verisilicon/vs_bridge.c
>>>>>>>>>> index 7a93049368db..225af322de32 100644
>>>>>>>>>> --- a/drivers/gpu/drm/verisilicon/vs_bridge.c
>>>>>>>>>> +++ b/drivers/gpu/drm/verisilicon/vs_bridge.c
>>>>>>>>>> @@ -164,13 +164,16 @@ static void
>>>>>>>>>> vs_bridge_enable_common(struct
>>>>>>>>>> vs_crtc *crtc,
>>>>>>>>>>       			VSDC_DISP_PANEL_CONFIG_CLK_E
>>>>>>>>>> N);
>>>>>>>>>>       	regmap_set_bits(dc->regs,
>>>>>>>>>> VSDC_DISP_PANEL_CONFIG(output),
>>>>>>>>>>       			VSDC_DISP_PANEL_CONFIG_RUNNI
>>>>>>>>>> NG);
>>>>>>>>>> -	regmap_clear_bits(dc->regs,
>>>>>>>>>> VSDC_DISP_PANEL_START,
>>>>>>>>>> -			
>>>>>>>>>> VSDC_DISP_PANEL_START_MULTI_DISP_SYNC);
>>>>>>>>>> -	regmap_set_bits(dc->regs,
>>>>>>>>>> VSDC_DISP_PANEL_START,
>>>>>>>>>> -
>>>>>>>>>> 			VSDC_DISP_PANEL_START_RUNNIN
>>>>>>>>>> G(ou
>>>>>>>>>> tput));
>>>>>>>>>>       
>>>>>>>>>> -	regmap_set_bits(dc->regs,
>>>>>>>>>> VSDC_DISP_PANEL_CONFIG_EX(crtc-
>>>>>>>>>>> id),
>>>>>>>>>> -
>>>>>>>>>> 			VSDC_DISP_PANEL_CONFIG_EX_CO
>>>>>>>>>> MMIT);
>>>>>>>>>> +	if (dc->info->has_config_ex) {
>>>>>>>>>> +		regmap_clear_bits(dc->regs,
>>>>>>>>>> VSDC_DISP_PANEL_START,
>>>>>>>>>> +				
>>>>>>>>>> VSDC_DISP_PANEL_START_MULTI_DISP_SYNC);
>>>>>>>>>> +		regmap_set_bits(dc->regs,
>>>>>>>>>> VSDC_DISP_PANEL_START,
>>>>>>>>>> +				VSDC_DISP_PANEL_STAR
>>>>>>>>>> T_RU
>>>>>>>>>> NNIN
>>>>>>>>>> G(ou
>>>>>>>>>> tput
>>>>>>>>>> ));
>>>>>>>>>> +
>>>>>>>>>> +		regmap_set_bits(dc->regs,
>>>>>>>>>> VSDC_DISP_PANEL_CONFIG_EX(crtc->id),
>>>>>>>>>> +				VSDC_DISP_PANEL_CONF
>>>>>>>>>> IG_E
>>>>>>>>>> X_CO
>>>>>>>>>> MMIT
>>>>>>>>>> );
>>>>>>>>> Should the commit operation happen on
>>>>>>>>> DC8000/DCUltraLite
>>>>>>>>> too?
>>>>>>>>> (By
>>>>>>>>> writing to DcregFrameBufferConfig0.VALID).
>>>>>>>>>
>>>>>>>>> Many registers written has "Note: This field is double
>>>>>>>>> buffered" in
>>>>>>>>> the
>>>>>>>>> DCUltraLite documentation.
>>>>>>>>>
>>>>>>>>> I suggest create a static function for commit -- write
>>>>>>>>> to
>>>>>>>>> the
>>>>>>>>> corresponding commit bit on DC8200, and write to
>>>>>>>>> DcregFrameBufferConfig0.VALID on DC8000/DCUltraLite.
>>>>>>>> [a] There is no commit operation for DCUltra Lite.
>>>>>>>> I'll not add a `VSDC_FB_CONFIG_VALID` macro. VALID
>>>>>>>> (BIT(3))
>>>>>>>> is a
>>>>>>>> hardware-managed double-buffer status bit: hardware
>>>>>>>> writes
>>>>>>>> 1=PENDING
>>>>>>>> when a new register set is ready and clears to 0=WORKING
>>>>>>>> after
>>>>>>>> the
>>>>>>>> VBLANK copy. Software must never write it, and there is
>>>>>>>> no
>>>>>>>> polling
>>>>>>>> use
>>>>>>> It seems to be writable and controls whether register
>>>>>>> buffering
>>>>>>> is
>>>>>>> enabled, see [1].
>>>>>>>
>>>>>>> The description of this bit in MA35D1 TRM says "This
>>>>>>> ensures a
>>>>>>> frame
>>>>>>> will always start with a valid working set if this register
>>>>>>> is
>>>>>>> programmed last, which reduces the need for SW to wait for
>>>>>>> the
>>>>>>> start of
>>>>>>> a VBLANK signal in order to ensure all states are loaded
>>>>>>> before
>>>>>>> the
>>>>>>> next VBLANK", which indicates some kind of "committing
>>>>>>> write",
>>>>>>> although
>>>>>>> the code at [1] seems to indicate that double buffering is
>>>>>>> only
>>>>>>> enabled
>>>>>>> when bit is cleared.
>>>>>>>
>>>>>>> Anyway this bit should be programmable, and "Software must
>>>>>>> never
>>>>>>> write
>>>>>>> it" contradicts with the MA35D1 TRM.
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Icenowy
>>>>>>>
>>>>>>> [1]
>>>>>>> https://github.com/rockos-riscv/rockos-kernel/blob/rockos-v6.6.y/drivers/gpu/drm/eswin/es_dc_hw.c#L993
>>>>>> Thank you for the correction. I'll add
>>>>>> `#define VSDC_FB_CONFIG_VALID BIT(3)` to
>>>>>> vs_primary_plane_regs.h
>>>>>> and
>>>>>> write it in `vs_primary_plane_commit()` for non-config_ex
>>>>>> variants.
>>>>>>>> case in the driver that requires a named constant. For
>>>>>>>> non-
>>>>>>>> config_ex
>>>>>>>> variants, `vs_primary_plane_commit()` performs no commit
>>>>>>>> operation —
>>>>>>>> `VSDC_FB_CONFIG_ENABLE` (OUTPUT, BIT(0)) is set in
>>>>>>>> `vs_crtc_atomic_enable()` and `VSDC_FB_CONFIG_RESET`
>>>>>>>> (BIT(4))
>>>>>>>> is
>>>>>>>> set/cleared in the bridge enable/disable paths.
>>>>> Well according to the driver code for DC8000 from Eswin, and
>>>>> the
>>>>> bit
>>>>> named "VALID", maybe it should be cleared before programming
>>>>> the
>>>>> registers, and set after programming registers, to make the
>>>>> process
>>>>> of
>>>>> programming registers atomic from the perspective of the
>>>>> display
>>>>> controller.
>>>>>
>>>>> Anyway this should require testing on real hardware to verify.
>>>>>
>>>>> By the way, I see multiple peripheral drivers for MA35D1 get
>>>>> applied in
>>>>> the torvalds tree, but the device tree is still only a
>>>>> skeleton;
>>>>> when
>>>>> will the device tree be updated?
>>>>>
>>>>> Thanks,
>>>>> Icenowy
>>>> Thanks for pointing this out. I’ll perform tests on real hardware
>>>> since
>>>> I haven’t used this bit before.
>>>>
>>>> As for the device tree, we plan to update it comprehensively
>>>> after
>>>> completing several major IPs, with the goal of releasing the
>>>> update
>>>> later this year.
>>> Well I bought a MA35D1 board (MYIR MYB-LMA35 + RGB LCD) earlier
>>> this
>>> year (and this is where I got the MA35D1 identification register
>>> values). Hope I can have a chance to test this driver by myself.
>>>
>>> As MMC, Ethernet and USB support is all applied, maybe it's already
>>> worthy to update the device tree ;-)
>>>
>>> Thanks,
>>> Icenowy
>> Yes you can!
>>
>> I have performed hardware validation on the MA35D1 and found that
>> this
>> bit acts as a manual latch for the shadow registers rather than an
>> auto-clearing trigger, which clarifies the slightly ambiguous
>> description in the TRM.
>>
>> Following your suggestion, I will align the implementation with
>> ESWIN's
>> DC8000 logic: setting the VALID bit at atomic_begin and clearing it
> Ah do you mean clearing it at begin and setting it at flush?
>
> In the Eswin driver (which seems to be based on reference code by
> Verisilicon, I saw similar driver code for DC8200),
> dc_hw_enable_shadow_register() clears VALID bit when enable is true,
> and all register setting sequences calls that function with enable =
> true before setting and enable = false after setting.
>
> In addition, considering this bit is called "VALID" instead of
> "INVALID", I think it represents that the DC will apply the new setting
> when it's set and keep the current setting when it's cleared, so I
> think it should be cleared before modeset sequence and be set after
> modeset sequence.
>
> Thanks,
> Icenowy
Thanks for pointing that out. To clarify, the TRM defines the states for 
this bit as:
1: PENDING (Shadow registers are locked; incoming CPU writes are held in 
the shadow buffer).
0: WORKING (Shadow registers are unfrozen/live; configuration is committed).

Regarding the Eswin reference, `dc_hw_enable_shadow_register(hw, false)` 
actually writes a 1 to isolate the registers during a batch update, and 
then transitions back to true (0) to flush them out.
My hardware test confirms this sequence:

- atomic_begin: We set VALID = 1. This safely freezes the current 
scanout configuration so we can update multiple registers (like frame 
addresses and pitches) without mid-frame tearing.
- atomic_update: We write the new register values safely into the frozen 
shadow space.
- atomic_flush: We clear VALID = 0. This releases the shadow lock, 
triggering the hardware to latch the whole batch atomically.

If we reverse this logic—leaving the bit at 1 after the flush — the 
hardware remains permanently stuck in the PENDING state, waiting to be 
unfrozen, which starves the display engine and results in the blank 
screen behavior I observed.
>> at
>> atomic_flush. My tests confirm this allows the hardware to latch the
>> plane configuration correctly while avoiding the blank screen issues
>> observed with other configurations.
>>
>> I am preparing the v2 patchset with this change, along with the
>> requested commit splits, and will submit it shortly.🙂
>>
>>>>>>> ========= 8< ==========
>>>>>>>
