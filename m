Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB1BEF4EC4
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 08:32:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58DAA10E077;
	Mon,  6 Apr 2026 08:32:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hPTVqNJZ";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C455210E077
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 08:32:23 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-c06cb8004e8so1269187a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Apr 2026 01:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775464343; x=1776069143; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MB0F9SKYr6+JVse3TW9scM+eJP0jATRzNvx3luR3WWo=;
 b=hPTVqNJZggb7pUZPPo01AmOFoHhYDcTABtR5ljiFsoOTGoq1NU0HVIERHHUkvnxvTg
 POXEqjYcEGzlg7qZomQ1muF7hx6JZJoEvkJdc8cCgZWGQIiTtPl+HZAFd46leZMCup+v
 q2Tp9ynlJuU2IOwoNgPYZfbODf67Rf6n2xK2kfmlqBeLGnIEyb6cJzJolcnzp+AKXJo2
 nSc0FgRfwpnrPM/oVtMmOkUUcMOwnpvzPc8IF8FeUmBheignjgU/cryepWJCOYeQmsoq
 mLLmETDptdlpcqa3wI7z6ywKBtECLugy9L6TwoHxGr/M47V9sw+faFAHHj4pGpUib3cd
 FYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775464343; x=1776069143;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MB0F9SKYr6+JVse3TW9scM+eJP0jATRzNvx3luR3WWo=;
 b=rCU7ka2hm81rjABZWi+b5S0Wuc7B7E3hzHAx/Q6AuK5S4oWwmwqw2Kr9KmZUR8R/Xl
 CEV0Uzd25/ggg6iFVOKZJ/IqNtfDt2OaPq9vVlHdcxXnlW0V3jVY21RayNOhyViutLmJ
 PWqyVfZGlBlTfxCZyOKFawZD4Ka1h9JuIbLq//n+Qvdh2Mh2dIN60DY7pPHuw6tweMjB
 F3ONlOHFGN9uTQp+UUAC2fesFHyxp4P2tz+Osbb/DAGBihUDwKUqSFzNvDOjdy3FLdll
 Ba4Hdb7c338BagCRmhABle0mmJGh8/F4AwfO4jcz95kTWPIaOJQbsZMYrr1UCXclI4z7
 J+fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsAyL+Y+IFcgkhYIGGepJ0BYVDmswNOa3L6IFy0CwvntSvIrcmo/JVghK/3zKlvKbCg2mL5BXXa/4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxGWJ27MrqCbJeTCKZik416WuBrm9ElGclNgvFfBUsOIy/tZZCa
 mVaoFHwM7l31iTj0BU06bkrtkuA0fKAMe70YolSM2rAr6bweDRfZ3gp0
X-Gm-Gg: AeBDiesFedOEcMaK/H9qc5TWj549jn2pWgVJkWab86d9dWmgwYLyTEa4vXkp+iEac1C
 jnh9whkNkpkmN0eKaApszffeVN75QJzmHqTkHMb69ETHkUa12lTtDj5mh47V6YdnRwcnp3PUQCB
 fuYIjDtdz0Y6UWWWV7kyeOLqmyI0GyugLSpIHgNHRuq3ILq627MAhmz5JmUOxibUop9YQCNmxXI
 8NzUCzVFYFkzb3DcWtmb1S9EJC5z2IsR8WOIMVGTZ8bZHTqQ+0z3z37O4oU7ZhTpj1NLbucxEJ6
 M5rExOcRDua5dDApgUMefzkVaHpjpNAkiUvGxeQlBL14Q/va17lYJlQjOJKZUrNwhttBSnAbZ1C
 n7v3eSSiLOFaFiBM1l8+TQ6XwBgtwa8YcGlp4CbiHZthDeDrA7T5IVvRJNfKCTyU47qNCqfvkLp
 um5X/HNbFUsEMBnDNUS34Hy3FpdaBPs6pXVIaCTuvnNV8D8Xo=
X-Received: by 2002:a05:6a00:1745:b0:82c:21df:807a with SMTP id
 d2e1a72fcca58-82d0db6ac7bmr11028578b3a.26.1775464343129; 
 Mon, 06 Apr 2026 01:32:23 -0700 (PDT)
Received: from [172.16.20.13] ([136.226.252.245])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9b6113dsm12306813b3a.23.2026.04.06.01.32.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Apr 2026 01:32:22 -0700 (PDT)
Message-ID: <68015824-8b8a-4349-a681-163a8ca3b5bc@gmail.com>
Date: Mon, 6 Apr 2026 14:02:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
From: tessolveupstream@gmail.com
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

