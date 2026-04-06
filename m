Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F17EF4EC6
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 08:35:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 730F810E098;
	Mon,  6 Apr 2026 08:35:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pu+PapHd";
	dkim-atps=neutral
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E564910E098
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 08:35:48 +0000 (UTC)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-c76af7b0f94so2378412a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Apr 2026 01:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775464548; x=1776069348; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MB0F9SKYr6+JVse3TW9scM+eJP0jATRzNvx3luR3WWo=;
 b=pu+PapHdg0jdcSPc3ZZU3iyEQyGWUlrn82UQlN+ObOit3J7dtxl7NMMz/7bFnYxPId
 6KG15yG12w4JkPu9DHk1t/wLnGYCEMncuIWv8fIi8taksOrKutkTwcG4A+FUE8tQNeNl
 iAQU3hL/bYSJ7kic0zWGxIGMva1/HvKU8wrFqkTJiNrD6wIBvZ/5zqMjmRU1FEP3NGXI
 XEQh40gFllJ9Ojegi04IZQ1HN3UN9BNyt/icV6GPEWBpbX4t/O0j+S3YLa2g3GS2GMBX
 B5pkWEEfSxDJs0orx1dCBSPWPMLPdR18VRQfCW0Uz06mdFQDBTiBsNkZRjUe9M4dQSlH
 hA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775464548; x=1776069348;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MB0F9SKYr6+JVse3TW9scM+eJP0jATRzNvx3luR3WWo=;
 b=IMG/NXkROEbC20oFnh/70BvmYCWkBT2wKjq9AbWACC7y/4mp5qt/+QwRo4QYm9uSl7
 cJJ6KESPvh6Ypua39QHeTn+W994nKfVZI4xuHchArzM1xX0ylnJTZZqC9cFbJu83/qEO
 xPV0I3dOTcHzYOUbuSwCzCzho/Z6iraZEEeSt/g8OQABnkbWjbsz50pICcTZs2/j9Ylv
 GUEpzW3SvWx1hnGjBvXbvYu4uSFj340sWoLojZbCjPPqVudZxJ312agM+cZJjIoWLiHR
 JlQ7PiBSfXjC0Gl8FNP7c7J2su6O6BqufBgWu4Eo45E8vXfgo2AliHKJKzsQxFrBc2wp
 lqVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoFL9j4cnTUsNRmZpXUiQ6g5iLMwMppeRxlHLpmdV8PiCHnZRqBBiTKM356Hb5UUNWFv/E5wBv/JY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywy+1ya0KJ68hRM3GCn9S3i4vQOcDKK59ZTm84u8aP5mBoyxyt/
 gaqWx+0r7ABB8S0taup3wbDpJzNRAO3LwjlaMxGGXIXR4tRS4OeH92Je
X-Gm-Gg: AeBDieuF9kqslPLigho0PREX7JSb4rPad18cc2hrMd9/5xYsjbvvdB5/PXfIKChk7Nw
 8gaXnpCkmaXcG5b0m/xQuYOvNxzrrakH9U7h13sj6fiaL3gBAU0meHm7Ep2ttQrcswYKrBqle64
 LxqjfOqk5vd17EmUlZ/IY2J8fKfCbMooJmHqBDx78zzTn+wI+Xd1jBm89wDGcW4PL6dkqgkvc3I
 cqgLhUff+FeRMGZQYeqXM6ZSzkf2s99ZwF8woEItLWNwVlWxxYc/AztANkYb4MAy9fw6wdcyGdp
 +3sdPSEwl0g3nFv8ACWqfSMBJzaKChG1xxb+bvGsyrlCy464W+ShNdQneJ8SH3wH2ANKJ6f40SK
 Nje+mAFOYeYpUFR4Qh8w1LvbvcA4EsQGG2FNgX7uNv6IdZo/zFPRLdq2eDkLXEcxrH0v8hTlZoK
 Gg8kBoj1tQ+S+TvKBFmYz2MJthMyPOr9O7osSTqfkLUgxtIqk=
X-Received: by 2002:a05:6a20:7354:b0:39b:e321:784f with SMTP id
 adf61e73a8af0-39f2f05041dmr12441393637.40.1775464548351; 
 Mon, 06 Apr 2026 01:35:48 -0700 (PDT)
Received: from [172.16.20.13] ([136.226.252.245])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9c41bc6sm13741897b3a.29.2026.04.06.01.35.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Apr 2026 01:35:47 -0700 (PDT)
Message-ID: <35eed359-8088-4ec0-9e16-e5cb31e0952e@gmail.com>
Date: Mon, 6 Apr 2026 14:05:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: tessolveupstream@gmail.com
Subject: Re: [PATCH v2 2/2] drm: bridge: ti-sn65dsi83: Add support for
 dual-link LVDS video mode
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, rfoss@kernel.org
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
Content-Language: en-US
In-Reply-To: <DH5S3RB2XZ31.3C994FZK5U4OV@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 18-03-2026 14:22, Luca Ceresoli wrote:
> Hello Sudarshan,
> 
> On Wed Mar 18, 2026 at 6:53 AM CET, tessolveupstream wrote:
>>>> +	if (ctx->dual_link_video_mode) {
>>>> +		regmap_write(ctx->regmap, REG_RC_LVDS_PLL, 0x05);
>>>> +		regmap_write(ctx->regmap, REG_RC_PLL_EN, 0x00);
>>>> +		regmap_write(ctx->regmap, REG_DSI_CLK, 0x53);
>>>> +		regmap_write(ctx->regmap, REG_LVDS_FMT, 0x6f);
>>>> +		regmap_write(ctx->regmap, REG_LVDS_VCOM, 0x00);
>>>> +		regmap_write(ctx->regmap,
>>>> +			     REG_VID_CHA_VERTICAL_DISPLAY_SIZE_LOW, 0x00);
>>>> +		regmap_write(ctx->regmap,
>>>> +			     REG_VID_CHA_VERTICAL_DISPLAY_SIZE_HIGH, 0x00);
>>>> +		regmap_write(ctx->regmap,
>>>> +			     REG_VID_CHA_HSYNC_PULSE_WIDTH_LOW, 0x10);
>>>> +		regmap_write(ctx->regmap,
>>>> +			     REG_VID_CHA_HORIZONTAL_BACK_PORCH, 0x28);
>>>> +		regmap_write(ctx->regmap,
>>>> +			     REG_VID_CHA_VERTICAL_BACK_PORCH, 0x00);
>>>> +		regmap_write(ctx->regmap,
>>>> +			     REG_VID_CHA_HORIZONTAL_FRONT_PORCH, 0x00);
>>>> +		regmap_write(ctx->regmap,
>>>> +			     REG_VID_CHA_VERTICAL_FRONT_PORCH, 0x00);
>>>> +	}
>>>
>>> I guess these hard-coded values are sepcific to your panel. They must
>>> instead be computed based on the timings in order to work for every panel.
>>>
>>
>> The hard-coded values were initially derived from the TI DSI Tuner output
>> during our bring-up testing. TI had also mentioned that when PATGEN is
>> enabled with dual-LVDS output on the SN65DSI84, the horizontal timings
>> must be divided by 2. They also noted that the current driver does not
>> appear to divide the horizontal timings when PATGEN is enabled in
>> dual-LVDS mode.
>>
>> Based on that suggestion, we had tried adjusting the horizontal timing
>> registers accordingly to match the tuner output.
>> Could you please advise how these register values are expected to be
>> derived from the mode timings so that they work correctly for different
>> panels?
> 
> Well, the principle is quite simple:
> 
>  1. the panel docs tell you which timings the panel needs, e.g. HBP must be
>     10 clock cycles
> 
>  2. your panel description in dts or implementation in a panel driver will
>     then be written accordingly
> 
>  3. the ti-sn65dsi83 driver will receive a struct drm_display_mode* with
>     these values
> 
>  4. based on those values it sets the registers so the SN65DSI84 uses the
>     timings required by the panel (with a bit of math if needed):
> 
> 	regmap_write(ctx->regmap, REG_VID_CHA_HORIZONTAL_BACK_PORCH,
> 		     mode->htotal - mode->hsync_end);
> 
> Same for all other timings.
> 
> Ti is more complicated if more cases need to be handled, such as dual-LVDS,
> and the chip documentation is vague about what must be done in those cases.
> 
> I suggested next steps to move forward in reply to the cover letter.
>

Thank you so much for your suggestion.
 
>>>> @@ -965,9 +1001,15 @@ static int sn65dsi83_host_attach(struct sn65dsi83 *ctx)
>>>>
>>>>  	dsi->lanes = dsi_lanes;
>>>>  	dsi->format = MIPI_DSI_FMT_RGB888;
>>>> -	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
>>>> -			  MIPI_DSI_MODE_VIDEO_NO_HFP | MIPI_DSI_MODE_VIDEO_NO_HBP |
>>>> -			  MIPI_DSI_MODE_VIDEO_NO_HSA | MIPI_DSI_MODE_NO_EOT_PACKET;
>>>> +	if (ctx->dual_link_video_mode)
>>>> +		dsi->mode_flags = MIPI_DSI_MODE_VIDEO;
>>>> +	else
>>>> +		dsi->mode_flags = MIPI_DSI_MODE_VIDEO |
>>>> +				  MIPI_DSI_MODE_VIDEO_BURST |
>>>> +				  MIPI_DSI_MODE_VIDEO_NO_HFP |
>>>> +				  MIPI_DSI_MODE_VIDEO_NO_HBP |
>>>> +				  MIPI_DSI_MODE_VIDEO_NO_HSA |
>>>> +				  MIPI_DSI_MODE_NO_EOT_PACKET;
>>>
>>> There is no explanation about this, can you elaborate on why?
>>>
>>> I'm working on bringing up a dual-LVDS panel on a board with the SN65DSI84,
>>> and the removing MIPI_DSI_MODE_VIDEO_BURST seems to help, but I still have
>>> no idea why. Should you have any info, maybe from TI, it would be very
>>> interesting.
>>>
>>
>> During our earlier bring-up, TI mentioned that one possible reason for the DSI
>> REFCLK not behaving as expected could be that the DSI output is configured in
>> burst mode instead of non-burst mode. In burst mode the DSI clock may not be
>> continuous, whereas non-burst mode provides a more predictable DSI clock.
> 
> Uhm, this is a bit vague. They basically said "burst can be more
> problematic than continuous", which is obvious, and "try disabling burst
> and see whether it helps" with no explanation on why one works and not the
> other. Shoudl you have more info from them you'd be welcome to share it. In
> particular, is disabling burst mode specifically related to dual-LVDS, or
> just a way to (try to) get rid of some problems without a clear
> understanding?
> 
> On my side I also have a dual-LVDS panel connected to a SN65DSI84, which
> works only by disabling burst mode. I haven't tried upstreaming it because
> I don't have an explanation of why it fixes the panel and so I have no idea
> how to teach the driver when it should disable burst mode.
> 
> Additionally inyour patch you remove many other flags. Any explanation from
> those?
>

Thanks for your inputs.
 
I wanted to share a quick observation from our side. With your suggested 3
patches (links below), the panel started working after simplifying the 
dsi-> mode_flags:
 
https://lore.kernel.org/all/20260226-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v1-1-2e15f5a9a6a0@bootlin.com/
 
https://lore.kernel.org/all/20260226-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v1-2-2e15f5a9a6a0@bootlin.com/
 
https://lore.kernel.org/lkml/20260309-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v2-1-e6aaa7e1d181@bootlin.com/
 
Earlier configuration:
 
MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
MIPI_DSI_MODE_VIDEO_NO_HFP | MIPI_DSI_MODE_VIDEO_NO_HBP |
MIPI_DSI_MODE_VIDEO_NO_HSA | MIPI_DSI_MODE_NO_EOT_PACKET;
 
Working configuration:
 
MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_NO_HSA |
MIPI_DSI_MODE_NO_EOT_PACKET;
 
From our testing, removing MIPI_DSI_MODE_VIDEO_BURST along with the NO_HFP/NO_HBP 
flags results in stable LVDS output in dual-link mode.
 
Could you please suggest how you would prefer to handle this change for 
upstreaming?
 
> Best regards,
> Luca
> 
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

