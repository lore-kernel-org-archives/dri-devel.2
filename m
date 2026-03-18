Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E544FCD0DA
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 08:52:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7B8510E78B;
	Wed, 18 Mar 2026 08:52:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="2LsqgJO9";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B051F10E778
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 08:52:15 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 8B0CCC55069;
 Wed, 18 Mar 2026 08:52:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 1FF976004F;
 Wed, 18 Mar 2026 08:52:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5CD1E104506C1; Wed, 18 Mar 2026 09:52:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1773823933; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=nT0Hf9Q9SP5IQGF+baESZbBfkIQwTmW8dv27L7iwgeE=;
 b=2LsqgJO9mmywmuu+OZIQWEmwa9aPtAMPTrwKG7bGoN5bV+/zhTYajELNrPnKUD64igN24M
 2G5NuTm6Ghia91FARpBn73xewOOhT5+NwMmlSVYdLu/UM6/pn23wP/oHh8R8sMmkZzA9kO
 Fab49tsKAwf6PoEflO4Igf4p/vLTuzagTJH3fJfhpOqIUifSXbz+EdTVdRB0HKgmPa113Y
 z1OftieVu4yAmcpkhPJEPP2pkarYESUtft8jshwsRBs47hVtrIIvjJcBEQx6L3vpoiolq6
 b8XgizJPYNlO9cprRBlYtnkzwW2oFgdUwGKoSMuuh9uBwsjytAQ8vcC1C8Eqew==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Mar 2026 09:52:08 +0100
Message-Id: <DH5S3RB2XZ31.3C994FZK5U4OV@bootlin.com>
Subject: Re: [PATCH v2 2/2] drm: bridge: ti-sn65dsi83: Add support for
 dual-link LVDS video mode
Cc: <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
 <jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <marex@denx.de>, <valentin@compulab.co.il>,
 <philippe.schenker@toradex.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
To: <tessolveupstream@gmail.com>, <andrzej.hajda@intel.com>,
 <neil.armstrong@linaro.org>, <rfoss@kernel.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.20.1
References: <20260312043743.261475-1-tessolveupstream@gmail.com>
 <20260312043743.261475-3-tessolveupstream@gmail.com>
 <DH0X6JQP0ZIW.3F4LJLIEMWH8M@bootlin.com>
 <9a9e13a5-411a-40bc-b52f-4345e7f6b92e@gmail.com>
In-Reply-To: <9a9e13a5-411a-40bc-b52f-4345e7f6b92e@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Sudarshan,

On Wed Mar 18, 2026 at 6:53 AM CET, tessolveupstream wrote:
>>> +	if (ctx->dual_link_video_mode) {
>>> +		regmap_write(ctx->regmap, REG_RC_LVDS_PLL, 0x05);
>>> +		regmap_write(ctx->regmap, REG_RC_PLL_EN, 0x00);
>>> +		regmap_write(ctx->regmap, REG_DSI_CLK, 0x53);
>>> +		regmap_write(ctx->regmap, REG_LVDS_FMT, 0x6f);
>>> +		regmap_write(ctx->regmap, REG_LVDS_VCOM, 0x00);
>>> +		regmap_write(ctx->regmap,
>>> +			     REG_VID_CHA_VERTICAL_DISPLAY_SIZE_LOW, 0x00);
>>> +		regmap_write(ctx->regmap,
>>> +			     REG_VID_CHA_VERTICAL_DISPLAY_SIZE_HIGH, 0x00);
>>> +		regmap_write(ctx->regmap,
>>> +			     REG_VID_CHA_HSYNC_PULSE_WIDTH_LOW, 0x10);
>>> +		regmap_write(ctx->regmap,
>>> +			     REG_VID_CHA_HORIZONTAL_BACK_PORCH, 0x28);
>>> +		regmap_write(ctx->regmap,
>>> +			     REG_VID_CHA_VERTICAL_BACK_PORCH, 0x00);
>>> +		regmap_write(ctx->regmap,
>>> +			     REG_VID_CHA_HORIZONTAL_FRONT_PORCH, 0x00);
>>> +		regmap_write(ctx->regmap,
>>> +			     REG_VID_CHA_VERTICAL_FRONT_PORCH, 0x00);
>>> +	}
>>
>> I guess these hard-coded values are sepcific to your panel. They must
>> instead be computed based on the timings in order to work for every pane=
l.
>>
>
> The hard-coded values were initially derived from the TI DSI Tuner output
> during our bring-up testing. TI had also mentioned that when PATGEN is
> enabled with dual-LVDS output on the SN65DSI84, the horizontal timings
> must be divided by 2. They also noted that the current driver does not
> appear to divide the horizontal timings when PATGEN is enabled in
> dual-LVDS mode.
>
> Based on that suggestion, we had tried adjusting the horizontal timing
> registers accordingly to match the tuner output.
> Could you please advise how these register values are expected to be
> derived from the mode timings so that they work correctly for different
> panels?

Well, the principle is quite simple:

 1. the panel docs tell you which timings the panel needs, e.g. HBP must be
    10 clock cycles

 2. your panel description in dts or implementation in a panel driver will
    then be written accordingly

 3. the ti-sn65dsi83 driver will receive a struct drm_display_mode* with
    these values

 4. based on those values it sets the registers so the SN65DSI84 uses the
    timings required by the panel (with a bit of math if needed):

	regmap_write(ctx->regmap, REG_VID_CHA_HORIZONTAL_BACK_PORCH,
		     mode->htotal - mode->hsync_end);

Same for all other timings.

Ti is more complicated if more cases need to be handled, such as dual-LVDS,
and the chip documentation is vague about what must be done in those cases.

I suggested next steps to move forward in reply to the cover letter.

>>> @@ -965,9 +1001,15 @@ static int sn65dsi83_host_attach(struct sn65dsi83=
 *ctx)
>>>
>>>  	dsi->lanes =3D dsi_lanes;
>>>  	dsi->format =3D MIPI_DSI_FMT_RGB888;
>>> -	dsi->mode_flags =3D MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
>>> -			  MIPI_DSI_MODE_VIDEO_NO_HFP | MIPI_DSI_MODE_VIDEO_NO_HBP |
>>> -			  MIPI_DSI_MODE_VIDEO_NO_HSA | MIPI_DSI_MODE_NO_EOT_PACKET;
>>> +	if (ctx->dual_link_video_mode)
>>> +		dsi->mode_flags =3D MIPI_DSI_MODE_VIDEO;
>>> +	else
>>> +		dsi->mode_flags =3D MIPI_DSI_MODE_VIDEO |
>>> +				  MIPI_DSI_MODE_VIDEO_BURST |
>>> +				  MIPI_DSI_MODE_VIDEO_NO_HFP |
>>> +				  MIPI_DSI_MODE_VIDEO_NO_HBP |
>>> +				  MIPI_DSI_MODE_VIDEO_NO_HSA |
>>> +				  MIPI_DSI_MODE_NO_EOT_PACKET;
>>
>> There is no explanation about this, can you elaborate on why?
>>
>> I'm working on bringing up a dual-LVDS panel on a board with the SN65DSI=
84,
>> and the removing MIPI_DSI_MODE_VIDEO_BURST seems to help, but I still ha=
ve
>> no idea why. Should you have any info, maybe from TI, it would be very
>> interesting.
>>
>
> During our earlier bring-up, TI mentioned that one possible reason for th=
e DSI
> REFCLK not behaving as expected could be that the DSI output is configure=
d in
> burst mode instead of non-burst mode. In burst mode the DSI clock may not=
 be
> continuous, whereas non-burst mode provides a more predictable DSI clock.

Uhm, this is a bit vague. They basically said "burst can be more
problematic than continuous", which is obvious, and "try disabling burst
and see whether it helps" with no explanation on why one works and not the
other. Shoudl you have more info from them you'd be welcome to share it. In
particular, is disabling burst mode specifically related to dual-LVDS, or
just a way to (try to) get rid of some problems without a clear
understanding?

On my side I also have a dual-LVDS panel connected to a SN65DSI84, which
works only by disabling burst mode. I haven't tried upstreaming it because
I don't have an explanation of why it fixes the panel and so I have no idea
how to teach the driver when it should disable burst mode.

Additionally inyour patch you remove many other flags. Any explanation from
those?

Best regards,
Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
