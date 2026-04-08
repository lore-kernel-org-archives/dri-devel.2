Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6BD51073C99
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 11:10:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CE8610E436;
	Wed,  8 Apr 2026 11:10:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KaQ/fgCh";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00AF210E436
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 11:10:12 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-35d9749c26dso4488068a91.2
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Apr 2026 04:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775646612; x=1776251412; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=i58F6ne4PgXe2Y4QOzvEYFqWtMrZDhR7Y1bsKgY88r8=;
 b=KaQ/fgCh5tbn5hHzrKP9b1DKlQ4VGsxHdB0TV2X0j130+vH4krB3tZJsH2NFQ9Er/q
 fIER+c0SzU5gtjVXEdLbCLykuDTPFyuoUYyUgM8qVGm9biHfYSP70cf3mgiOcWqL9fxF
 zIepGtlciBBzahY3MQIqUpedbkyIG/ngODanc08aUQpoP0hvsThHywr6xD87Pzv13QQb
 u50oxwTeMawmoMOZfqtpuanG1eiAG6e89we+dD1UBWqsXFsEJcAudy/04Yd2d6XPtty1
 tKZci+pMBpkV2HlLQMx0nHSFJQlxEM8BSt9QLJNn5eFuOZ5gj9Og0D2Tlgexnl44RqGX
 Bakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775646612; x=1776251412;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i58F6ne4PgXe2Y4QOzvEYFqWtMrZDhR7Y1bsKgY88r8=;
 b=oTAm2ImRz/dMCQQm2cgB72p0LXJp4GgnWGseWOvXfLbWdsncJskULbHfWdokhJY3Kn
 r+wshHtHVWygoDW+xxWfICTUUPqDyir+6P1fR50cXohFLNhZgPgsQupIqvShK/RHCwaW
 KdhEzIBifCb+c39Dv9JjyQ2WxGCd56/M+ARz5khCbt1zJhNcZoVFcYYRuRfYWo88dAJu
 CeyfzUYEvpSDRyDljQrr3AvsNTpIos+qZtqkQQXgaQsoff9vG6xmFMHOxBdtUlERuPsX
 ezIk2ZWxZxtDt5uft5Lvsle8E+IhpXNrdrq81U55BY82CzVt9+EwSahIcPHe5Yk8gQTX
 nfVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0eneWvsyed+cMfzF2GH3DnGzTRI81tyr2BJpLlyZHqZAYVW0viN5m3Iq/1safy2QWpZSDOZybfqU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzPiper8IVVKm59zQJo5jlNfJ4o83673ciYvGTJ6caqATx9VxE3
 frkPi3Yi2Fvb6xulTDghm7bwjqssVxxNGzl6YXNuSGX1b6kKXs+2ylm0
X-Gm-Gg: AeBDieu08GFE1xBgeltXbzin3S3eIDc4GESnEYtI64TQz8UG9niHnjiYR8VvS8mGmDG
 uznAgBaep2JImhHUDcT83aYiUJlZ76g3diq9e/zgQDG/CKOyfda0xsbl1O0A8SWk9VcMOXcWm1k
 /oG9EpzZXCVSeA7+wJOu5tYwVP17aBNYYTUbU0n4Ua4AWVNbUkjy3THkT5LyCf4yxKP1GOXv8j+
 OY6e7nCWBsEzHp0RzbAkIdkLmCHyQWclEpPkh/yNP5CuLnCa4w7ExOQEUkwh2U5nZ1b3i3xaSBK
 aw78V6YWGH6yyhQmJyYro0KupDRo/ZY0l4/bCp46835Ndlu9Z+zVuZH/zhoQh6JIQkTGC/Not0Z
 2J1h/uM4yyyr45AHU2++nBPzcLs2IG/BsXDLWjI5ipf+AOyBoc+qwq755WI2giRO/FfDT/bp31Z
 2BDxbNeb89KJdQCLn9fMa3vdbdNAoAG3MhkQngNGOBaCU/fqM=
X-Received: by 2002:a17:90a:d403:b0:359:3426:c60a with SMTP id
 98e67ed59e1d1-35de67da841mr18869297a91.4.1775646612373; 
 Wed, 08 Apr 2026 04:10:12 -0700 (PDT)
Received: from [172.16.20.13] ([136.226.252.245])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35df82368f6sm13311565a91.12.2026.04.08.04.10.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2026 04:10:11 -0700 (PDT)
Message-ID: <6f39409e-1cf7-4e8e-8656-2e25135ae156@gmail.com>
Date: Wed, 8 Apr 2026 16:40:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm: bridge: ti-sn65dsi83: Add support for
 dual-link LVDS video mode
From: tessolveupstream@gmail.com
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, rfoss@kernel.org, Marek Vasut
 <marex@nabladev.com>, Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, marex@denx.de,
 valentin@compulab.co.il, philippe.schenker@toradex.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20260312043743.261475-1-tessolveupstream@gmail.com>
 <20260312043743.261475-3-tessolveupstream@gmail.com>
 <DH0X6JQP0ZIW.3F4LJLIEMWH8M@bootlin.com>
 <9a9e13a5-411a-40bc-b52f-4345e7f6b92e@gmail.com>
 <DH5S3RB2XZ31.3C994FZK5U4OV@bootlin.com>
 <35eed359-8088-4ec0-9e16-e5cb31e0952e@gmail.com>
Content-Language: en-US
In-Reply-To: <35eed359-8088-4ec0-9e16-e5cb31e0952e@gmail.com>
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



On 06-04-2026 14:05, tessolveupstream@gmail.com wrote:
> 
> 
> On 18-03-2026 14:22, Luca Ceresoli wrote:
>> Hello Sudarshan,
>>
>> On Wed Mar 18, 2026 at 6:53 AM CET, tessolveupstream wrote:
>>>>> +	if (ctx->dual_link_video_mode) {
>>>>> +		regmap_write(ctx->regmap, REG_RC_LVDS_PLL, 0x05);
>>>>> +		regmap_write(ctx->regmap, REG_RC_PLL_EN, 0x00);
>>>>> +		regmap_write(ctx->regmap, REG_DSI_CLK, 0x53);
>>>>> +		regmap_write(ctx->regmap, REG_LVDS_FMT, 0x6f);
>>>>> +		regmap_write(ctx->regmap, REG_LVDS_VCOM, 0x00);
>>>>> +		regmap_write(ctx->regmap,
>>>>> +			     REG_VID_CHA_VERTICAL_DISPLAY_SIZE_LOW, 0x00);
>>>>> +		regmap_write(ctx->regmap,
>>>>> +			     REG_VID_CHA_VERTICAL_DISPLAY_SIZE_HIGH, 0x00);
>>>>> +		regmap_write(ctx->regmap,
>>>>> +			     REG_VID_CHA_HSYNC_PULSE_WIDTH_LOW, 0x10);
>>>>> +		regmap_write(ctx->regmap,
>>>>> +			     REG_VID_CHA_HORIZONTAL_BACK_PORCH, 0x28);
>>>>> +		regmap_write(ctx->regmap,
>>>>> +			     REG_VID_CHA_VERTICAL_BACK_PORCH, 0x00);
>>>>> +		regmap_write(ctx->regmap,
>>>>> +			     REG_VID_CHA_HORIZONTAL_FRONT_PORCH, 0x00);
>>>>> +		regmap_write(ctx->regmap,
>>>>> +			     REG_VID_CHA_VERTICAL_FRONT_PORCH, 0x00);
>>>>> +	}
>>>>
>>>> I guess these hard-coded values are sepcific to your panel. They must
>>>> instead be computed based on the timings in order to work for every panel.
>>>>
>>>
>>> The hard-coded values were initially derived from the TI DSI Tuner output
>>> during our bring-up testing. TI had also mentioned that when PATGEN is
>>> enabled with dual-LVDS output on the SN65DSI84, the horizontal timings
>>> must be divided by 2. They also noted that the current driver does not
>>> appear to divide the horizontal timings when PATGEN is enabled in
>>> dual-LVDS mode.
>>>
>>> Based on that suggestion, we had tried adjusting the horizontal timing
>>> registers accordingly to match the tuner output.
>>> Could you please advise how these register values are expected to be
>>> derived from the mode timings so that they work correctly for different
>>> panels?
>>
>> Well, the principle is quite simple:
>>
>>  1. the panel docs tell you which timings the panel needs, e.g. HBP must be
>>     10 clock cycles
>>
>>  2. your panel description in dts or implementation in a panel driver will
>>     then be written accordingly
>>
>>  3. the ti-sn65dsi83 driver will receive a struct drm_display_mode* with
>>     these values
>>
>>  4. based on those values it sets the registers so the SN65DSI84 uses the
>>     timings required by the panel (with a bit of math if needed):
>>
>> 	regmap_write(ctx->regmap, REG_VID_CHA_HORIZONTAL_BACK_PORCH,
>> 		     mode->htotal - mode->hsync_end);
>>
>> Same for all other timings.
>>
>> Ti is more complicated if more cases need to be handled, such as dual-LVDS,
>> and the chip documentation is vague about what must be done in those cases.
>>
>> I suggested next steps to move forward in reply to the cover letter.
>>
> 
> Thank you so much for your suggestion.
>  
>>>>> @@ -965,9 +1001,15 @@ static int sn65dsi83_host_attach(struct sn65dsi83 *ctx)
>>>>>
>>>>>  	dsi->lanes = dsi_lanes;
>>>>>  	dsi->format = MIPI_DSI_FMT_RGB888;
>>>>> -	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
>>>>> -			  MIPI_DSI_MODE_VIDEO_NO_HFP | MIPI_DSI_MODE_VIDEO_NO_HBP |
>>>>> -			  MIPI_DSI_MODE_VIDEO_NO_HSA | MIPI_DSI_MODE_NO_EOT_PACKET;
>>>>> +	if (ctx->dual_link_video_mode)
>>>>> +		dsi->mode_flags = MIPI_DSI_MODE_VIDEO;
>>>>> +	else
>>>>> +		dsi->mode_flags = MIPI_DSI_MODE_VIDEO |
>>>>> +				  MIPI_DSI_MODE_VIDEO_BURST |
>>>>> +				  MIPI_DSI_MODE_VIDEO_NO_HFP |
>>>>> +				  MIPI_DSI_MODE_VIDEO_NO_HBP |
>>>>> +				  MIPI_DSI_MODE_VIDEO_NO_HSA |
>>>>> +				  MIPI_DSI_MODE_NO_EOT_PACKET;
>>>>
>>>> There is no explanation about this, can you elaborate on why?
>>>>
>>>> I'm working on bringing up a dual-LVDS panel on a board with the SN65DSI84,
>>>> and the removing MIPI_DSI_MODE_VIDEO_BURST seems to help, but I still have
>>>> no idea why. Should you have any info, maybe from TI, it would be very
>>>> interesting.
>>>>
>>>
>>> During our earlier bring-up, TI mentioned that one possible reason for the DSI
>>> REFCLK not behaving as expected could be that the DSI output is configured in
>>> burst mode instead of non-burst mode. In burst mode the DSI clock may not be
>>> continuous, whereas non-burst mode provides a more predictable DSI clock.
>>
>> Uhm, this is a bit vague. They basically said "burst can be more
>> problematic than continuous", which is obvious, and "try disabling burst
>> and see whether it helps" with no explanation on why one works and not the
>> other. Shoudl you have more info from them you'd be welcome to share it. In
>> particular, is disabling burst mode specifically related to dual-LVDS, or
>> just a way to (try to) get rid of some problems without a clear
>> understanding?
>>
>> On my side I also have a dual-LVDS panel connected to a SN65DSI84, which
>> works only by disabling burst mode. I haven't tried upstreaming it because
>> I don't have an explanation of why it fixes the panel and so I have no idea
>> how to teach the driver when it should disable burst mode.
>>
>> Additionally inyour patch you remove many other flags. Any explanation from
>> those?
>>
> 
> Thanks for your inputs.
>  
> I wanted to share a quick observation from our side. With your suggested 3
> patches (links below), the panel started working after simplifying the 
> dsi-> mode_flags:
>  
> https://lore.kernel.org/all/20260226-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v1-1-2e15f5a9a6a0@bootlin.com/
>  
> https://lore.kernel.org/all/20260226-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v1-2-2e15f5a9a6a0@bootlin.com/
>  
> https://lore.kernel.org/lkml/20260309-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v2-1-e6aaa7e1d181@bootlin.com/
>  
> Earlier configuration:
>  
> MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
> MIPI_DSI_MODE_VIDEO_NO_HFP | MIPI_DSI_MODE_VIDEO_NO_HBP |
> MIPI_DSI_MODE_VIDEO_NO_HSA | MIPI_DSI_MODE_NO_EOT_PACKET;
>  
> Working configuration:
>  
> MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_NO_HSA |
> MIPI_DSI_MODE_NO_EOT_PACKET;
>  
> From our testing, removing MIPI_DSI_MODE_VIDEO_BURST along with the NO_HFP/NO_HBP 
> flags results in stable LVDS output in dual-link mode.
>  
> Could you please suggest how you would prefer to handle this change for 
> upstreaming?
> 

I wanted to revisit the earlier discussion and share a consolidated summary 
of our observations below.

With your suggested patches (links below), the panel started working after 
simplifying the dsi->mode_flags:

https://lore.kernel.org/all/20260226-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v1-1-2e15f5a9a6a0@bootlin.com/
https://lore.kernel.org/all/20260226-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v1-2-2e15f5a9a6a0@bootlin.com/
https://lore.kernel.org/lkml/20260309-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v2-1-e6aaa7e1d181@bootlin.com/

Working 'dsi-> mode_flags' configuration is:
dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_NO_HSA | 
		  MIPI_DSI_MODE_NO_EOT_PACKET;

From our testing, removing MIPI_DSI_MODE_VIDEO_BURST along with the NO_HFP 
and NO_HBP flags results in stable LVDS output in dual-link mode.

Also I am sharing an update from our side after consulting the 'dsi-> 
mode_flags' behavior with the TI expert.

Based on their inputs:

1. The SN65DSI83/84 reconstructs LVDS timing from the incoming DSI stream 
   and requires explicit horizontal blanking (HFP/HBP) to do so reliably.
2. Suppressing HFP/HBP prevents correct timing reconstruction and can 
   result in unstable LVDS output, even when register timings are programmed.
3. DSI burst mode is supported, but depending on the host controller, it may 
   result in non‑continuous DSI clocking and HS/LP transitions.
4. Non‑burst (continuous) DSI video mode provides a more stable and 
   predictable timing stream, which is better suited for LVDS panels.
5. Ensuring continuous DSI video with standard horizontal blanking has been 
   observed to produce stable LVDS operation, particularly in dual‑link 
   configurations.  

Given these observations, we would appreciate your guidance on how to 
proceed with up-streaming.
 

>> Best regards,
>> Luca
>>
>> --
>> Luca Ceresoli, Bootlin
>> Embedded Linux and Kernel engineering
>> https://bootlin.com
> 

