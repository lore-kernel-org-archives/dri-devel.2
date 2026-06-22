Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF98CD98F2
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 20:38:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA7AD10E85E;
	Mon, 22 Jun 2026 20:38:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kemnade.info header.i=@kemnade.info header.b="G8Z2fknl";
	dkim-atps=neutral
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0396210E85E
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 20:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
 Reply-To:Content-ID:Content-Description;
 bh=yBPsbI4EYXmStV1slUm9ol2RoVm6krMqzl8qxSyD/+A=; t=1782160694; x=1783370294; 
 b=G8Z2fknlC/XAC6BdSdhUxCUBdUfj/ooeT3PCp4xnw1pr4n8K8Mfi2HOK9bi3N5czv9tCt3USIBt
 ph+BKSh77Gkld/VZ9SA/Z4uDT3OOO1h7vlCEQt8Gx5y8U1FQnBJPZh6rwVSAD3ccFkgLrwr14sTpQ
 oaVRfypZSFkO+9ijkjPeKghE8BNq3t9qlNcbP9qM/x71R2489ijKkjXmjexgRbJqMO5zGrl+FX3Lp
 9+3Miu6ncnM84At5Tc5aqfzcpRys/mkhhvXr5Flpd1reDxVzEaft3kwyU088+Q9f+JaniVMkB0JZM
 QNrSxmcfkaFLvbcWf/dpaIleSDOjq0ThDd7A==;
Date: Mon, 22 Jun 2026 22:37:54 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Marek Vasut <marex@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Dave
 Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH v3 07/13] drm/bridge: tc358762: Update comment about the
 number of lanes
Message-ID: <20260622223754.65f3ce97@kemnade.info>
In-Reply-To: <8efe44d7-3864-45cb-bd79-f25f573b6432@ideasonboard.com>
References: <20260513-tc358762-fixes-v3-0-6698b55008b9@ideasonboard.com>
 <20260513-tc358762-fixes-v3-7-6698b55008b9@ideasonboard.com>
 <20260529203424.72199881@kemnade.info>
 <8efe44d7-3864-45cb-bd79-f25f573b6432@ideasonboard.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Mon, 22 Jun 2026 10:31:35 +0300
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> wrote:

> Hi,
> 
> On 29/05/2026 21:34, Andreas Kemnade wrote:
> > On Wed, 13 May 2026 16:10:16 +0300
> > Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> wrote:
> >   
> >> Update comment about the number of lanes.
> >>
> >> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> >> ---
> >>   drivers/gpu/drm/bridge/tc358762.c | 9 ++++++++-
> >>   1 file changed, 8 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
> >> index 7840ab3454f6..c5734c4df440 100644
> >> --- a/drivers/gpu/drm/bridge/tc358762.c
> >> +++ b/drivers/gpu/drm/bridge/tc358762.c
> >> @@ -306,7 +306,14 @@ static int tc358762_probe(struct mipi_dsi_device *dsi)
> >>   	ctx->dev = dev;
> >>   	ctx->pre_enabled = false;
> >>   
> >> -	/* TODO: Find out how to get dual-lane mode working */
> >> +	/*
> >> +	 * When using DSI clk for pixel clock (only mode supported in the driver),
> >> +	 * the pclk is derived directly from the DSI byteclk via simple divider,
> >> +	 * which is either 2 or 3.
> >> +	 * The required divider can be calculated with bitspp / 8 / nlanes. Thus,
> >> +	 * for RGB888, only nlanes = 1 works as nlanes = 2 would require divider
> >> +	 * of 1.5.
> >> +	 */
> >>   	dsi->lanes = 1;
> >>   	dsi->format = MIPI_DSI_FMT_RGB888;
> >>   	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
> >>  
> > wondering: I am using lanes = 2 and RGB888. But I need to write something to
> > SYSPLL3 register. Which somehow is sensitive to write to.... Do you have any
> information about that register?  
> If you have an external refclk, then you can use the tc358762 pll to 
> generate the clock, which I guess you are using. SYSPLL3 configures some 
> parts of the PLL, and the doc says the write to SYSPLL3 must be the last 
> in the sequence.
>
Thanks for that explaination. Your comment in the code is really helpful.

I have anly a 22 page datasheet and I know only that the reference clock 
can be 6-40Mhz from that datasheet and the pixclock is 41600 according to
drm_display_mode struct.
I know the value which works is 0xB8640000.

I am asking all this since I want to upstream the display support for the
Epson Movero BT-200. The vendor kernel is 3.0. It is an old-style omapfb
display driver there. I converted it to a modern drm panel driver
with integrated bridge handling and now I am investingating how to use the
bridge driver together with a separate panel driver.

The clean way would be to define the input clock, and add code to 
calculate pll parameters. But without information, probably the
best way is to adjust magic numbers based on
if (of_machine_is_compatible())

Regards,
Andreas
