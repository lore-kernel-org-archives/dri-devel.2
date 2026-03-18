Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C4CFCD0B6
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 05:53:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A76F410E699;
	Wed, 18 Mar 2026 05:53:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kgdGEgQx";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40A9B10E049
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 05:53:12 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2b04e6a989eso26732125ad.3
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 22:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773813192; x=1774417992; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bxh7p5ubNM0UPeRub63aEAzjq5cy4XyXQ+j/f8jldew=;
 b=kgdGEgQxaf9W3FcMbSDTqSIAYnECNj3kyDRCNSg79sbo1hqBSb0SMH5ASvNUI73ChB
 IoR3wpcRwFDNaq94vkJQWAgHcO+32OrbRQ1SkOG3vc7RtvOGWQU1lAqkGSqnaR08hRxL
 PLJq9yV8lQF3oXFQWa9fB19MC5kTvdu286/r1SHgAxF5PJ55Z8aUphvA4NeiETU1cLJO
 O3Ep7go5L8/vd+Q/B18WPt4W27ju3WvatB6ji43o5geTLNG+/jRD46eRiyNuZzhF1Wdt
 Yp9MKST13yLbNEbArFsjfxf0Koujn5flFPHgAuGFCraVqCGhNuE0AsBPNnEOsnlqRhXm
 w6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773813192; x=1774417992;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bxh7p5ubNM0UPeRub63aEAzjq5cy4XyXQ+j/f8jldew=;
 b=dSOQj0Fxr/zPt6yzuhDdCmJBvRaOR9Eq63swflWk/vn2evjXp6aMc/ytlQhrp/uEcG
 FREFMqoSmGWu0dMjSDHwRy04FOcANKe68vUuPf2wQ4ZDQCHD27YvyGLGje7hAzyrDjA8
 uKCXPfpt4x4hSGf7bIyfYvQjunp49BuGDcI8Ofoc3JlCEesjsMMN/IImtcTDeke0Pu0I
 r0oI+HvIb998OlhZtbN+/UL8s5ae0xRtlu1CqJ0I0Xso3gfyMTnbooYx+gxGxgWwydiu
 KDZjs7bjR118+06w/n3tBK4O9mxYzucMN82FlSbaJA9S8wdT/O+AoKfEyMpN+OMlh3PT
 IjsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqSsrrVuAEPOiJSIUSD9p1bbnmD9YRxypnyHSvVBXPC4CsraYJgpI1OZ7EfRSY0xmOBI84foCPgjI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwrXfiQ2az4ZZUf7944VVtnfrOpC9rXuh2bCODzS4Ze3QUCUzYW
 DwZPTPd7DjB9+9ZY8amENN6V77e7sK7e8vwOEIvnYTpyMnujBbzl62vR
X-Gm-Gg: ATEYQzzs78m+TQ36R3LMWSlPPrNNyGFblB/2k6zoCLhhDr4ZP6ACZYeFUB7n8mUQcFE
 5yNrXNsALs6y35Hzd1KgJ8uWk4demAeYkdNMknUKPF6lG87tNO/urdA/2hAV6u5JywVbvDXcOFt
 t44MbaNmaZJrYgdd0i7Llg5bbXHuQE4B8DysTyziPCJrbUm2ze7gAQo6XdOE0ibpZcyDZrnHdGx
 bwx2MsGwZoqTzROwGlaRd4iKzeWRXUoP6KiZ99C9tV7aBOjJj0R9hx1Br58Yd5mndlZ8fIZ3M6D
 Rex1pa4O0BSXnbISgV13E+X+w3WFKSdWD4csImXJQRl+bvx0RRRCKlxUzjyoYIG8ZxG4JynQiAI
 1zhuEl3aD89HPlOwUzEGZ4qaJ4WVTKGYAL3Eam4ElhhQZMEyqGUinetE3R1+nbHiP6Rtyw+O/35
 5vE4RrVJ8AbS1qrY4TcXn3ni1wrdgx37o=
X-Received: by 2002:a17:902:ea02:b0:2b0:691a:8cba with SMTP id
 d9443c01a7336-2b06e2da887mr21889105ad.5.1773813191640; 
 Tue, 17 Mar 2026 22:53:11 -0700 (PDT)
Received: from [172.16.20.13] ([136.226.252.245])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b06e431c1asm14023225ad.24.2026.03.17.22.53.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2026 22:53:11 -0700 (PDT)
Message-ID: <9a9e13a5-411a-40bc-b52f-4345e7f6b92e@gmail.com>
Date: Wed, 18 Mar 2026 11:23:30 +0530
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
Content-Language: en-US
In-Reply-To: <DH0X6JQP0ZIW.3F4LJLIEMWH8M@bootlin.com>
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



On 12-03-2026 21:17, Luca Ceresoli wrote:
> Hello Sudarshan,
> 
> On Thu Mar 12, 2026 at 5:37 AM CET, Sudarshan Shetty wrote:
>> Some LVDS panels operating in dual-link mode require adjusted
>> horizontal timing parameters when programmed into the SN65DSI84
>> bridge. According to TI documentation, horizontal timing values
>> must be divided by two when operating in dual-link mode. Without
>> this adjustment, the panel may fail to display or produce corrupted
>> output.
>>
>> Add support for an optional DT property "ti,dual-link-video-mode"
>> to enable configuration required for dual-link LVDS operation.
>> These settings ensure correct LVDS output for panels that require
>> this mode of operation.
>>
>> Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
>> ---
>>  drivers/gpu/drm/bridge/ti-sn65dsi83.c | 52 ++++++++++++++++++++++++---
>>  1 file changed, 48 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
>> index f6736b4457bb..9b7d35487bd8 100644
>> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
>> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
>> @@ -164,6 +164,7 @@ struct sn65dsi83 {
>>  	int				irq;
>>  	struct delayed_work		monitor_work;
>>  	struct work_struct		reset_work;
>> +	bool				dual_link_video_mode;
> 
> As said in the reply to patch 1, there is already 'bool lvds_dual_link'
> carrying the same info.
> 

okay.
>>  static const struct regmap_range sn65dsi83_readable_ranges[] = {
>> @@ -667,8 +668,43 @@ static void sn65dsi83_atomic_pre_enable(struct drm_bridge *bridge,
>>  		     mode->hsync_start - mode->hdisplay);
>>  	regmap_write(ctx->regmap, REG_VID_CHA_VERTICAL_FRONT_PORCH,
>>  		     mode->vsync_start - mode->vdisplay);
>> -	regmap_write(ctx->regmap, REG_VID_CHA_TEST_PATTERN, 0x00);
>>
>> +	/*
>> +	 * In dual-link LVDS mode, the SN65DSI84 requires the horizontal
>> +	 * timing parameters to be adjusted before being programmed into
>> +	 * the device. According to TI documentation, the horizontal timing
>> +	 * values must be divided by two when operating in dual-link mode.
>> +	 * Without this adjustment, the connected panel may fail to light up
>> +	 * or display corrupted output.
>> +	 *
>> +	 * TI also provides recommended register settings for this mode,
>> +	 * which were derived using the TI DSI-Tuner tool. When the optional
>> +	 * DT property "ti,dual-link-video-mode" is present, apply these
>> +	 * configuration settings to ensure correct dual-link LVDS operation.
>> +	 */
>> +	if (ctx->dual_link_video_mode) {
>> +		regmap_write(ctx->regmap, REG_RC_LVDS_PLL, 0x05);
>> +		regmap_write(ctx->regmap, REG_RC_PLL_EN, 0x00);
>> +		regmap_write(ctx->regmap, REG_DSI_CLK, 0x53);
>> +		regmap_write(ctx->regmap, REG_LVDS_FMT, 0x6f);
>> +		regmap_write(ctx->regmap, REG_LVDS_VCOM, 0x00);
>> +		regmap_write(ctx->regmap,
>> +			     REG_VID_CHA_VERTICAL_DISPLAY_SIZE_LOW, 0x00);
>> +		regmap_write(ctx->regmap,
>> +			     REG_VID_CHA_VERTICAL_DISPLAY_SIZE_HIGH, 0x00);
>> +		regmap_write(ctx->regmap,
>> +			     REG_VID_CHA_HSYNC_PULSE_WIDTH_LOW, 0x10);
>> +		regmap_write(ctx->regmap,
>> +			     REG_VID_CHA_HORIZONTAL_BACK_PORCH, 0x28);
>> +		regmap_write(ctx->regmap,
>> +			     REG_VID_CHA_VERTICAL_BACK_PORCH, 0x00);
>> +		regmap_write(ctx->regmap,
>> +			     REG_VID_CHA_HORIZONTAL_FRONT_PORCH, 0x00);
>> +		regmap_write(ctx->regmap,
>> +			     REG_VID_CHA_VERTICAL_FRONT_PORCH, 0x00);
>> +	}
> 
> I guess these hard-coded values are sepcific to your panel. They must
> instead be computed based on the timings in order to work for every panel.
> 

The hard-coded values were initially derived from the TI DSI Tuner output 
during our bring-up testing. TI had also mentioned that when PATGEN is 
enabled with dual-LVDS output on the SN65DSI84, the horizontal timings 
must be divided by 2. They also noted that the current driver does not 
appear to divide the horizontal timings when PATGEN is enabled in 
dual-LVDS mode.

Based on that suggestion, we had tried adjusting the horizontal timing 
registers accordingly to match the tuner output.
Could you please advise how these register values are expected to be 
derived from the mode timings so that they work correctly for different 
panels?
>> +
>> +	regmap_write(ctx->regmap, REG_VID_CHA_TEST_PATTERN, 0x00);
>>  	/* Enable PLL */
>>  	regmap_write(ctx->regmap, REG_RC_PLL_EN, REG_RC_PLL_EN_PLL_EN);
>>  	usleep_range(3000, 4000);
>> @@ -965,9 +1001,15 @@ static int sn65dsi83_host_attach(struct sn65dsi83 *ctx)
>>
>>  	dsi->lanes = dsi_lanes;
>>  	dsi->format = MIPI_DSI_FMT_RGB888;
>> -	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
>> -			  MIPI_DSI_MODE_VIDEO_NO_HFP | MIPI_DSI_MODE_VIDEO_NO_HBP |
>> -			  MIPI_DSI_MODE_VIDEO_NO_HSA | MIPI_DSI_MODE_NO_EOT_PACKET;
>> +	if (ctx->dual_link_video_mode)
>> +		dsi->mode_flags = MIPI_DSI_MODE_VIDEO;
>> +	else
>> +		dsi->mode_flags = MIPI_DSI_MODE_VIDEO |
>> +				  MIPI_DSI_MODE_VIDEO_BURST |
>> +				  MIPI_DSI_MODE_VIDEO_NO_HFP |
>> +				  MIPI_DSI_MODE_VIDEO_NO_HBP |
>> +				  MIPI_DSI_MODE_VIDEO_NO_HSA |
>> +				  MIPI_DSI_MODE_NO_EOT_PACKET;
> 
> There is no explanation about this, can you elaborate on why?
> 
> I'm working on bringing up a dual-LVDS panel on a board with the SN65DSI84,
> and the removing MIPI_DSI_MODE_VIDEO_BURST seems to help, but I still have
> no idea why. Should you have any info, maybe from TI, it would be very
> interesting.
> 

During our earlier bring-up, TI mentioned that one possible reason for the DSI 
REFCLK not behaving as expected could be that the DSI output is configured in 
burst mode instead of non-burst mode. In burst mode the DSI clock may not be 
continuous, whereas non-burst mode provides a more predictable DSI clock.
> Luca
> 
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

