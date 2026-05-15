Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B72A9CD4851
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 07:13:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFA8310F440;
	Fri, 15 May 2026 07:13:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RM/6fDqV";
	dkim-atps=neutral
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2A9C10F400
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 06:25:55 +0000 (UTC)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-c828daf83e2so2791336a12.2
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 23:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778826355; x=1779431155; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F4wG8bH1gfDBcb14JbvmcrOJGC7+5HB1bq/2ymPAYSI=;
 b=RM/6fDqVc8SE+x20Oa6RVzcGIvIv42x/qOgZY/Rxnoyolac7qHseS/rWnhg+nNTk5O
 WudiHGQaeSpasyqYixar6rEn2dQ7YkGhztutn2wQxv3gu5f/qPhOlsx5iwnlQ08kxWyM
 6Tlh6q4Ddafnq67QWC9ow+lvG9DnmjG6aHfgYCPrqo4p3UPv8mr5wf9m8eXN0JYffjMf
 sXZFj/FNF5xvOENAcyxsan5xnT/Gg1pMQ+WMjtUT3rDQwQaVgQC4r7FdBZ6efoBq9+c+
 83TdTT8QGNk6CKFMhvCkbLSO4e6Rmvt2S7/n4UYxglsSUp9y9mwLgXfXp6nkKK9igqXT
 HewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778826355; x=1779431155;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F4wG8bH1gfDBcb14JbvmcrOJGC7+5HB1bq/2ymPAYSI=;
 b=p/n8TdXzkfiLLisRkxOxT5PkoJE4Ci6Cu6qeQ8Pin2IF6jTpRyBOGKsl5hrjbIjojy
 lfNUkkU6swHomGWa4HSTQ16e3VGofxZZCpPPZAOgHVpqexiToRXCnMPikZatqZ6aY+H2
 Tq+BQeLapdx2OX4pRvunuKdc0qUzSTvmQXo3Rsmw7xLlDYwnj9XiizdWEozc4zItKLDq
 ReCtWzZY0FDvNs2R77u27gZs7xtI6nHarwLrOn+CesMpfUWavFzJGUPNYv4rHMwXAcSm
 Y0+bRPVgEm8+Xbb9ZTB4rYx63L0bVhWtw6JGnnOY3H5JNYQjqJB4fItql1/6t0z/gZNd
 fj9g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/U4+lFg9szGiAYqIWNcyBfh3S7cotGJwFocWDd0SGPlr197R6PRXjhUAYUz/ItTGDUja/1lxiNIAE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzjZ9J28VJOINSb0speO3U5vQpmNGSPFGuKV8I5h4Rf3/8eTctP
 prxD2yUAwJOyg5clkYkcj4lCTzkr5AKwxcJZAaz7fyFuVmnqTI83bavk
X-Gm-Gg: Acq92OGPB5F6YC/Y0L3wYywnzNZMonvZOWUS0VJWQ9xTsPlVj6VNLDdDLRcw46K7384
 vGLHas1VLvtUJMtR/oR6ZuRsTryFEqhQYdx7dpq5rQPeNVZGq1jzj6ogTl9JfJAzIcn2idG9gUG
 v4EVMz8ZO3GNKBHyz6IWSqnz1TYXLEY8FZ7iHIfy34z7b9watE5sCRRkJVQUAKOZHbQDjOQ1Kcz
 xhtyMV1S9YRMSjVSJy3kOvjJ4I9oz67kfIeUsK+D4XGHQr1dia0VnSWnO6C6Fhnc3U+4WvSS1IR
 0NRs3jMm0Kj/aYg2IZUI9hP2EjIfuIiiqhKmVhArH4wx3FXwODctgEbJg41kg1E8DIHL8ISkplK
 evhDSo4mzc9tvxa5ZLANvO0G+V12OUsvQPzUNKJBILMnF0ZrDwuCuujnaKVTsMa3eR+bTOorl6V
 h5EGixSyM9c8PWHrwh2yR6sZrOFQBMnwwKbBHhc++E0pevCI2fRK4nyagtQXRqekp1eXiCgl0H2
 /Ns
X-Received: by 2002:a05:6a20:560c:b0:3a8:2af3:ce8b with SMTP id
 adf61e73a8af0-3b22e72fb16mr2125835637.14.1778826355136; 
 Thu, 14 May 2026 23:25:55 -0700 (PDT)
Received: from [192.168.0.100] (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c82bb0ff0edsm4688486a12.20.2026.05.14.23.25.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2026 23:25:54 -0700 (PDT)
Message-ID: <1a42a168-1dbb-467e-9053-b5585a737f71@gmail.com>
Date: Fri, 15 May 2026 14:25:48 +0800
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
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <76a9e9b676509e85484a1eb31c723b46c7e21a19.camel@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 15 May 2026 07:13:06 +0000
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


On 5/12/2026 9:12 PM, Icenowy Zheng wrote:
> 在 2026-05-12二的 18:59 +0800，Joey Lu写道：
>> On 5/12/2026 6:01 PM, Icenowy Zheng wrote:
>>> 在 2026-05-12二的 17:06 +0800，Joey Lu写道：
>>>
>>> ======= 8< =============
>>>>>>>> diff --git a/drivers/gpu/drm/verisilicon/vs_bridge.c
>>>>>>>> b/drivers/gpu/drm/verisilicon/vs_bridge.c
>>>>>>>> index 7a93049368db..225af322de32 100644
>>>>>>>> --- a/drivers/gpu/drm/verisilicon/vs_bridge.c
>>>>>>>> +++ b/drivers/gpu/drm/verisilicon/vs_bridge.c
>>>>>>>> @@ -164,13 +164,16 @@ static void
>>>>>>>> vs_bridge_enable_common(struct
>>>>>>>> vs_crtc *crtc,
>>>>>>>>      			VSDC_DISP_PANEL_CONFIG_CLK_EN);
>>>>>>>>      	regmap_set_bits(dc->regs,
>>>>>>>> VSDC_DISP_PANEL_CONFIG(output),
>>>>>>>>      			VSDC_DISP_PANEL_CONFIG_RUNNING);
>>>>>>>> -	regmap_clear_bits(dc->regs,
>>>>>>>> VSDC_DISP_PANEL_START,
>>>>>>>> -			
>>>>>>>> VSDC_DISP_PANEL_START_MULTI_DISP_SYNC);
>>>>>>>> -	regmap_set_bits(dc->regs, VSDC_DISP_PANEL_START,
>>>>>>>> -
>>>>>>>> 			VSDC_DISP_PANEL_START_RUNNING(ou
>>>>>>>> tput));
>>>>>>>>      
>>>>>>>> -	regmap_set_bits(dc->regs,
>>>>>>>> VSDC_DISP_PANEL_CONFIG_EX(crtc-
>>>>>>>>> id),
>>>>>>>> -
>>>>>>>> 			VSDC_DISP_PANEL_CONFIG_EX_COMMIT);
>>>>>>>> +	if (dc->info->has_config_ex) {
>>>>>>>> +		regmap_clear_bits(dc->regs,
>>>>>>>> VSDC_DISP_PANEL_START,
>>>>>>>> +				
>>>>>>>> VSDC_DISP_PANEL_START_MULTI_DISP_SYNC);
>>>>>>>> +		regmap_set_bits(dc->regs,
>>>>>>>> VSDC_DISP_PANEL_START,
>>>>>>>> +				VSDC_DISP_PANEL_START_RU
>>>>>>>> NNIN
>>>>>>>> G(ou
>>>>>>>> tput
>>>>>>>> ));
>>>>>>>> +
>>>>>>>> +		regmap_set_bits(dc->regs,
>>>>>>>> VSDC_DISP_PANEL_CONFIG_EX(crtc->id),
>>>>>>>> +				VSDC_DISP_PANEL_CONFIG_E
>>>>>>>> X_CO
>>>>>>>> MMIT
>>>>>>>> );
>>>>>>> Should the commit operation happen on DC8000/DCUltraLite
>>>>>>> too?
>>>>>>> (By
>>>>>>> writing to DcregFrameBufferConfig0.VALID).
>>>>>>>
>>>>>>> Many registers written has "Note: This field is double
>>>>>>> buffered" in
>>>>>>> the
>>>>>>> DCUltraLite documentation.
>>>>>>>
>>>>>>> I suggest create a static function for commit -- write to
>>>>>>> the
>>>>>>> corresponding commit bit on DC8200, and write to
>>>>>>> DcregFrameBufferConfig0.VALID on DC8000/DCUltraLite.
>>>>>> [a] There is no commit operation for DCUltra Lite.
>>>>>> I'll not add a `VSDC_FB_CONFIG_VALID` macro. VALID (BIT(3))
>>>>>> is a
>>>>>> hardware-managed double-buffer status bit: hardware writes
>>>>>> 1=PENDING
>>>>>> when a new register set is ready and clears to 0=WORKING
>>>>>> after
>>>>>> the
>>>>>> VBLANK copy. Software must never write it, and there is no
>>>>>> polling
>>>>>> use
>>>>> It seems to be writable and controls whether register buffering
>>>>> is
>>>>> enabled, see [1].
>>>>>
>>>>> The description of this bit in MA35D1 TRM says "This ensures a
>>>>> frame
>>>>> will always start with a valid working set if this register is
>>>>> programmed last, which reduces the need for SW to wait for the
>>>>> start of
>>>>> a VBLANK signal in order to ensure all states are loaded before
>>>>> the
>>>>> next VBLANK", which indicates some kind of "committing write",
>>>>> although
>>>>> the code at [1] seems to indicate that double buffering is only
>>>>> enabled
>>>>> when bit is cleared.
>>>>>
>>>>> Anyway this bit should be programmable, and "Software must
>>>>> never
>>>>> write
>>>>> it" contradicts with the MA35D1 TRM.
>>>>>
>>>>> Thanks,
>>>>> Icenowy
>>>>>
>>>>> [1]
>>>>> https://github.com/rockos-riscv/rockos-kernel/blob/rockos-v6.6.y/drivers/gpu/drm/eswin/es_dc_hw.c#L993
>>>> Thank you for the correction. I'll add
>>>> `#define VSDC_FB_CONFIG_VALID BIT(3)` to vs_primary_plane_regs.h
>>>> and
>>>> write it in `vs_primary_plane_commit()` for non-config_ex
>>>> variants.
>>>>>> case in the driver that requires a named constant. For non-
>>>>>> config_ex
>>>>>> variants, `vs_primary_plane_commit()` performs no commit
>>>>>> operation —
>>>>>> `VSDC_FB_CONFIG_ENABLE` (OUTPUT, BIT(0)) is set in
>>>>>> `vs_crtc_atomic_enable()` and `VSDC_FB_CONFIG_RESET` (BIT(4))
>>>>>> is
>>>>>> set/cleared in the bridge enable/disable paths.
>>> Well according to the driver code for DC8000 from Eswin, and the
>>> bit
>>> named "VALID", maybe it should be cleared before programming the
>>> registers, and set after programming registers, to make the process
>>> of
>>> programming registers atomic from the perspective of the display
>>> controller.
>>>
>>> Anyway this should require testing on real hardware to verify.
>>>
>>> By the way, I see multiple peripheral drivers for MA35D1 get
>>> applied in
>>> the torvalds tree, but the device tree is still only a skeleton;
>>> when
>>> will the device tree be updated?
>>>
>>> Thanks,
>>> Icenowy
>> Thanks for pointing this out. I’ll perform tests on real hardware
>> since
>> I haven’t used this bit before.
>>
>> As for the device tree, we plan to update it comprehensively after
>> completing several major IPs, with the goal of releasing the update
>> later this year.
> Well I bought a MA35D1 board (MYIR MYB-LMA35 + RGB LCD) earlier this
> year (and this is where I got the MA35D1 identification register
> values). Hope I can have a chance to test this driver by myself.
>
> As MMC, Ethernet and USB support is all applied, maybe it's already
> worthy to update the device tree ;-)
>
> Thanks,
> Icenowy

Yes you can!

I have performed hardware validation on the MA35D1 and found that this 
bit acts as a manual latch for the shadow registers rather than an 
auto-clearing trigger, which clarifies the slightly ambiguous 
description in the TRM.

Following your suggestion, I will align the implementation with ESWIN's 
DC8000 logic: setting the VALID bit at atomic_begin and clearing it at 
atomic_flush. My tests confirm this allows the hardware to latch the 
plane configuration correctly while avoiding the blank screen issues 
observed with other configurations.

I am preparing the v2 patchset with this change, along with the 
requested commit splits, and will submit it shortly.🙂

>>>>> ========= 8< ==========
>>>>>
