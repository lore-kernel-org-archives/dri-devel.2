Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63EB2CD4851
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 07:54:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20D5D10ED19;
	Wed, 13 May 2026 07:54:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VTiqRJtk";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8406210E2F8
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 10:59:28 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-367c2a39fcfso1774278a91.3
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 03:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778583568; x=1779188368; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lFfxIbyksNeEtf5P/BOwbmqUFbMT5NN+UNPslcsX6G8=;
 b=VTiqRJtk4CMPF6+j14VTtQywhawiZ6WDWiAMDTo54H07lzhO14njrdLqzSs3MRIHfu
 Fh0iohGRDbicReb67p8YnI0IJFJyWQK0TpgJvYnNst8vGJbKUmaGvs/wPY6I12/OAhej
 A97Gui23mdG7e9bMX9Fkq4nmIYUPBh3F0v2JybyJtSHxeLarXCe1sN75suTe/7cnqcVC
 XldmVTIC7kwGHwxZoYv+nOFDZQzM5No7P6tf58M0hbKs/0kYf23B75kKga2v7bRE14iL
 lohh3UtoQrSdGk0pePLOBEwA6siH23PtC0jnv1o0FKnKZcPB5LHRPSiUFxqdAjcL4Gs/
 I/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778583568; x=1779188368;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lFfxIbyksNeEtf5P/BOwbmqUFbMT5NN+UNPslcsX6G8=;
 b=d7L7jLwSx2lDC900H9Vu44GWTC11Lrx9ch70hh4m72nlnhS76pCnCm5dO6kzt8f2qV
 7xVMpi7+f3CRcFulgNWSGIVgrKlnU7lXJk768J2Q054QZOvXXNrpDxN5Q7xdpr+CXn4b
 LkpgX/7gMU1OPXmsPFI2jLNQv7vb9CzzuZBC2lPoxdKOuNatsDYiEGY51TbQbpRd7ABi
 V8x6U4pRDD5FfhqhezavAxhl2czpy+Z1THPoMEtMfPMu2zQ6MajUWtVcPb6s5RXrM5k3
 343/T5t8WUma6h+U3iKe/CY0h9cHRk9hwERD2UcnwTWRS1d2Cu6umXcFxPU3lL9NisHF
 2bqQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/TAxslIsZOQYdhY3HKK8ngqlpaqAZ+JLfTdaw92clawSkxRzq3cG9wRj5jO9z3c7qb1gDC2+LvWH4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxZ43O3SkWNkep7gxWOg7ZJSzu2K9zmvBjERrVzEf6zi8TGTLfi
 CLTCakkS43Pk5Oo1m7AELnq77oAfYOz0AA6Dv0Cl1hbMP9hT+wJ/yqeo
X-Gm-Gg: Acq92OFCcqh//Teov8Tufu/9e1er3d9QlNVtzyZeGjnu9knVrVUwEtkl4Whh8UvgSxg
 +j0SuxMZmaDLs9c2kgR+JNMOFSHS5wA7ZiNT+/hLHIw5M1nZC1QYVjOZJfJ75EVrEAC1CbzXdMr
 rK044rDWx1IvT6C/lwVmrkEQFX5RrdsApRLFHN9UsFnncTlYcWUzBeRN/AOOk0NvxwhxiG6fujl
 PcgLiAlbX4nNTjlRnTZ9c6X7RdEy/iiRWHGZ7fjbB8rHh5wqESlvKX/YTRJQnhkGRwBRsr4ehJi
 6hq5meipE8QfhQ3+x7Oy8/GlCwPFUMS61u+5B7gAmivqPIzwFucKqURiox+rQH2BFhmX/lx0fZ0
 KY+9BZ3g0vXvqLKkK61ykO/2MwALeUhTmk3/KGDjUCrfqH6g8xmY+cjTEV97rvZrXCeFwYWdxAU
 b765YnIwuZGX5Cz1IJ40FSvFnRqfRbCDIuhVCKI7YkGr0s1U6SL7ZxFrPgSVKbyPXJDFtDABxBa
 8Y5
X-Received: by 2002:a17:90b:3883:b0:368:6998:b49e with SMTP id
 98e67ed59e1d1-3686998bc7emr7312294a91.9.1778583567896; 
 Tue, 12 May 2026 03:59:27 -0700 (PDT)
Received: from [192.168.0.100] (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-367d65ed459sm14241837a91.14.2026.05.12.03.59.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 03:59:27 -0700 (PDT)
Message-ID: <1d04dd6d-f245-4b83-96b0-c5491fad8093@gmail.com>
Date: Tue, 12 May 2026 18:59:21 +0800
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
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <4bf6efbb222ebc4d770ad613d17c6185e7cb2fda.camel@iscas.ac.cn>
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


On 5/12/2026 6:01 PM, Icenowy Zheng wrote:
> 在 2026-05-12二的 17:06 +0800，Joey Lu写道：
>
> ======= 8< =============
>>>>>> diff --git a/drivers/gpu/drm/verisilicon/vs_bridge.c
>>>>>> b/drivers/gpu/drm/verisilicon/vs_bridge.c
>>>>>> index 7a93049368db..225af322de32 100644
>>>>>> --- a/drivers/gpu/drm/verisilicon/vs_bridge.c
>>>>>> +++ b/drivers/gpu/drm/verisilicon/vs_bridge.c
>>>>>> @@ -164,13 +164,16 @@ static void
>>>>>> vs_bridge_enable_common(struct
>>>>>> vs_crtc *crtc,
>>>>>>     			VSDC_DISP_PANEL_CONFIG_CLK_EN);
>>>>>>     	regmap_set_bits(dc->regs,
>>>>>> VSDC_DISP_PANEL_CONFIG(output),
>>>>>>     			VSDC_DISP_PANEL_CONFIG_RUNNING);
>>>>>> -	regmap_clear_bits(dc->regs, VSDC_DISP_PANEL_START,
>>>>>> -			
>>>>>> VSDC_DISP_PANEL_START_MULTI_DISP_SYNC);
>>>>>> -	regmap_set_bits(dc->regs, VSDC_DISP_PANEL_START,
>>>>>> -
>>>>>> 			VSDC_DISP_PANEL_START_RUNNING(output));
>>>>>>     
>>>>>> -	regmap_set_bits(dc->regs,
>>>>>> VSDC_DISP_PANEL_CONFIG_EX(crtc-
>>>>>>> id),
>>>>>> -			VSDC_DISP_PANEL_CONFIG_EX_COMMIT);
>>>>>> +	if (dc->info->has_config_ex) {
>>>>>> +		regmap_clear_bits(dc->regs,
>>>>>> VSDC_DISP_PANEL_START,
>>>>>> +				
>>>>>> VSDC_DISP_PANEL_START_MULTI_DISP_SYNC);
>>>>>> +		regmap_set_bits(dc->regs,
>>>>>> VSDC_DISP_PANEL_START,
>>>>>> +				VSDC_DISP_PANEL_START_RUNNIN
>>>>>> G(ou
>>>>>> tput
>>>>>> ));
>>>>>> +
>>>>>> +		regmap_set_bits(dc->regs,
>>>>>> VSDC_DISP_PANEL_CONFIG_EX(crtc->id),
>>>>>> +				VSDC_DISP_PANEL_CONFIG_EX_CO
>>>>>> MMIT
>>>>>> );
>>>>> Should the commit operation happen on DC8000/DCUltraLite too?
>>>>> (By
>>>>> writing to DcregFrameBufferConfig0.VALID).
>>>>>
>>>>> Many registers written has "Note: This field is double
>>>>> buffered" in
>>>>> the
>>>>> DCUltraLite documentation.
>>>>>
>>>>> I suggest create a static function for commit -- write to the
>>>>> corresponding commit bit on DC8200, and write to
>>>>> DcregFrameBufferConfig0.VALID on DC8000/DCUltraLite.
>>>> [a] There is no commit operation for DCUltra Lite.
>>>> I'll not add a `VSDC_FB_CONFIG_VALID` macro. VALID (BIT(3)) is a
>>>> hardware-managed double-buffer status bit: hardware writes
>>>> 1=PENDING
>>>> when a new register set is ready and clears to 0=WORKING after
>>>> the
>>>> VBLANK copy. Software must never write it, and there is no
>>>> polling
>>>> use
>>> It seems to be writable and controls whether register buffering is
>>> enabled, see [1].
>>>
>>> The description of this bit in MA35D1 TRM says "This ensures a
>>> frame
>>> will always start with a valid working set if this register is
>>> programmed last, which reduces the need for SW to wait for the
>>> start of
>>> a VBLANK signal in order to ensure all states are loaded before the
>>> next VBLANK", which indicates some kind of "committing write",
>>> although
>>> the code at [1] seems to indicate that double buffering is only
>>> enabled
>>> when bit is cleared.
>>>
>>> Anyway this bit should be programmable, and "Software must never
>>> write
>>> it" contradicts with the MA35D1 TRM.
>>>
>>> Thanks,
>>> Icenowy
>>>
>>> [1]
>>> https://github.com/rockos-riscv/rockos-kernel/blob/rockos-v6.6.y/drivers/gpu/drm/eswin/es_dc_hw.c#L993
>> Thank you for the correction. I'll add
>> `#define VSDC_FB_CONFIG_VALID BIT(3)` to vs_primary_plane_regs.h and
>> write it in `vs_primary_plane_commit()` for non-config_ex variants.
>>>> case in the driver that requires a named constant. For non-
>>>> config_ex
>>>> variants, `vs_primary_plane_commit()` performs no commit
>>>> operation —
>>>> `VSDC_FB_CONFIG_ENABLE` (OUTPUT, BIT(0)) is set in
>>>> `vs_crtc_atomic_enable()` and `VSDC_FB_CONFIG_RESET` (BIT(4)) is
>>>> set/cleared in the bridge enable/disable paths.
> Well according to the driver code for DC8000 from Eswin, and the bit
> named "VALID", maybe it should be cleared before programming the
> registers, and set after programming registers, to make the process of
> programming registers atomic from the perspective of the display
> controller.
>
> Anyway this should require testing on real hardware to verify.
>
> By the way, I see multiple peripheral drivers for MA35D1 get applied in
> the torvalds tree, but the device tree is still only a skeleton; when
> will the device tree be updated?
>
> Thanks,
> Icenowy

Thanks for pointing this out. I’ll perform tests on real hardware since 
I haven’t used this bit before.

As for the device tree, we plan to update it comprehensively after 
completing several major IPs, with the goal of releasing the update 
later this year.

>>> ========= 8< ==========
>>>
