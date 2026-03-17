Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F842FF6E97
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 23:29:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C9C210E171;
	Tue, 17 Mar 2026 23:29:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="MXMDiGrS";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04E0310E171
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 23:29:55 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
 by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 7360CB3;
 Wed, 18 Mar 2026 00:28:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1773790121;
 bh=10fbkQNfdwX5A27Z4ALHm7yHi4nhiv1bo993DzslWMI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MXMDiGrSdU9Qj6JpWul47oft3o47Du5hPaSnZqjPZzz+wiX7ficHtC9dy//br/eNz
 I1QtB6lP2A2K9kXPWcWk7ufSGRrMLhbiLGa/Y570/VEUQ64r7SF/S20bKfrz29jmsM
 N9Qt7ujsOxryFfpM4arSWhGHHVZCHk0zH2fVuo58=
Date: Wed, 18 Mar 2026 01:29:52 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "biju.das.au" <biju.das.au@gmail.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Douglas Anderson <dianders@chromium.org>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Jesse Van Gavere <jesseevg@gmail.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH] drm/bridge: adv7511: Clear HPD IRQ before powering on
 device during resume()
Message-ID: <20260317232952.GD408929@killaraus.ideasonboard.com>
References: <20251219104659.114032-1-biju.das.jz@bp.renesas.com>
 <20260316140232.GB31616@killaraus.ideasonboard.com>
 <TYCPR01MB113325ADBA0ACD1872BD4959B8640A@TYCPR01MB11332.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <TYCPR01MB113325ADBA0ACD1872BD4959B8640A@TYCPR01MB11332.jpnprd01.prod.outlook.com>
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

On Mon, Mar 16, 2026 at 05:59:57PM +0000, Biju Das wrote:
> On 16 March 2026 14:03, Laurent Pinchart wrote:
> > On Fri, Dec 19, 2025 at 10:46:53AM +0000, Biju wrote:
> > > From: Biju Das <biju.das.jz@bp.renesas.com>
> > >
> > > On RZ/G3E SMARC EVK using PSCI, s2ram powers down the SoC. Testing
> > > ADV7535 IRQ configured as edge-triggered interrupt on RZ/G3E SMARC EVK
> > > shows that it is missing HPD IRQ during system resume, as the status
> > > change occurs before the IRQ/pincontrol resume. Once the status bit is
> > > set, there won't be any further IRQ unless the status bit is cleared.
> > >
> > > Clear any pending HPD IRQs before powering on the ADV7535 device to
> > > deliver HPD interrupts after resume().
> > 
> > This issue doesn't seem to be specific to the ADV7511. Any device that uses an edge-triggered
> > interrupt could suffer from the same problem.
> > Implementing a work around in the driver doesn't seem to be a solution that would scale.
> 
> I don't see any bridge device is complaining about similar issues in Linux kernel.

This is exactly why this patch concerns me. The issue doesn't seem to be
specific to the ADV7511, yet no other bridge driver implements anything
similar. It seems to indicate something else is wrong.

I understand and agree with the analysis of the issue (although I find
it weird that the interrupt controller or pin controller would be
resumed after the ADV7511), but any device with an edge-triggered
interrupt should then suffer from the same problem. This means it
shouldn't be handled at individual drivers level, unless there's
something I'm missing that makes the problem very specific to the
ADV7511. Otherwise, a more generic solution is needed.

> Looks like, other bridge devices do not have such restriction.
>
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > ---
> > >  drivers/gpu/drm/bridge/adv7511/adv7511.h     |  1 +
> > >  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 32 ++++++++++++++++++++
> > >  2 files changed, 33 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511.h
> > > b/drivers/gpu/drm/bridge/adv7511/adv7511.h
> > > index 8be7266fd4f4..03aa23836ca4 100644
> > > --- a/drivers/gpu/drm/bridge/adv7511/adv7511.h
> > > +++ b/drivers/gpu/drm/bridge/adv7511/adv7511.h
> > > @@ -393,6 +393,7 @@ struct adv7511 {
> > >  	bool cec_enabled_adap;
> > >  	struct clk *cec_clk;
> > >  	u32 cec_clk_freq;
> > > +	bool suspended;
> > >  };
> > >
> > >  static inline struct adv7511 *bridge_to_adv7511(struct drm_bridge
> > > *bridge) diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> > > b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> > > index b9be86541307..8d9467187d7c 100644
> > > --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> > > +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> > > @@ -790,6 +790,25 @@ static void adv7511_bridge_atomic_enable(struct drm_bridge *bridge,
> > >  	struct drm_connector_state *conn_state;
> > >  	struct drm_crtc_state *crtc_state;
> > >
> > > +	if (adv->i2c_main->irq && adv->suspended) {
> > > +		unsigned int irq;
> > > +
> > > +		/*
> > > +		 * If ADV7511 IRQ is configured as edge triggered interrupt, it
> > > +		 * will miss the IRQ during system resume as the status change
> > > +		 * occurs before IRQ/pincontrol resume. Once the status bit is
> > 
> > That seems very platform-specific.
> 
> OK, I will reword something like. Is it ok for you?
> 
> The HPD status change occurs before the interrupt/pin control resume.
> Once the status bit is set, there will be no further delivery of interrupts
> unless the status bit is cleared. Therefore, clear the interrupt status bit
> for further delivery of HPD interrupts.
> 
> > 
> > > +		 * set there won't be any further IRQ unless the status bit is
> > > +		 * cleared. So, clear the IRQ status bit for further delivery
> > > +		 * of HPD IRQ.
> > > +		 */
> > > +		regmap_read(adv->regmap, ADV7511_REG_INT(0), &irq);
> > > +		if (irq & ADV7511_INT0_HPD)
> > > +			regmap_write(adv->regmap, ADV7511_REG_INT(0),
> > > +				     ADV7511_INT0_HPD);
> > 
> > Why do you need to read and test the IRQ here ? If ADV7511_INT0_HPD isn't set, a write will be a no-op
> > and will keep it cleared. If it is set, it will clear it. It seems that an unconditional
> > 
> > 		regmap_write(adv->regmap, ADV7511_REG_INT(0),
> > 			     ADV7511_INT0_HPD);
> > 
> > should be enough.
> 
> Agreed, I will make this unconditional.

-- 
Regards,

Laurent Pinchart
