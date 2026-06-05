Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 081A4CD6E7C
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 16:09:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5602010E69D;
	Fri,  5 Jun 2026 16:09:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="qtl0u6Qo";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E7E110E69D
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 16:09:49 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id A48C81B9A;
 Fri,  5 Jun 2026 18:09:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1780675762;
 bh=+e2oowBTjiy+F4ToW/32CTM5dYvXzNMCK0/BGh3H/3g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qtl0u6Qoao5FpcKZnYb8Cyt/+Alau4JdEbWBrS/Z5+ddP6orh5ESlpgMvTN2FthFi
 jZkgQ6l0BeDNEm+8z0qnY+9srl/x0guHJcrPHgTS2Nsf3LNqjjIjD+4j3FZie/sNqn
 JgAxCxR13i5FkiK56ZmZwSNR/JMXyN9eedR0oGgA=
Date: Fri, 5 Jun 2026 19:09:46 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Sean Nyekjaer <sean@geanix.com>,
 Sudarshan Shetty <tessolveupstream@gmail.com>,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 rfoss@kernel.org, jonas@kwiboo.se, jernej.skrabec@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 alexander.stein@ew.tq-group.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v4 2/2] drm: bridge: ti-sn65dsi83: Disable video burst
 mode for LVDS stability
Message-ID: <20260605160946.GC4350@killaraus.ideasonboard.com>
References: <ahsxWhXMhzbAj_3G@Seans-MacBook-Pro.local>
 <DJ17SSAYCT51.28YSD262KHNKK@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DJ17SSAYCT51.28YSD262KHNKK@bootlin.com>
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

On Fri, Jun 05, 2026 at 05:18:43PM +0200, Luca Ceresoli wrote:
> Hello Sean,
> 
> +Cc Marek, Maxime.
> 
> On Sat May 30, 2026 at 8:51 PM CEST, Sean Nyekjaer wrote:
> > On Wed, May 27, 2026 at 02:27:36PM +0100, Sudarshan Shetty wrote:
> >> The current DSI configuration enables MIPI_DSI_MODE_VIDEO_BURST.
> >> while burst mode is supported by the hardware, its use
> >> depends on continuous clock behavior from the DSI host. In practice,
> >> burst mode may introduce instability depending on the host controller
> >> implementation, as the DSI link may transition to low-power state
> >> between bursts.
> >>
> >> Testing showed improved display stability when using non-burst mode on
> >> affected panels.
> >>
> >> Remove MIPI_DSI_MODE_VIDEO_BURST and use non-burst video mode.
> >>
> >
> > We briefly talked about this at Embedded Recipes
> > I promised to sent a link:
> > https://lore.kernel.org/all/E35054BA-FBE5-4CEE-905C-1F5D20140590@geanix.com/
> 
> Thanks for the discussion at ER and for this follow-up e-mail.
> 
> > When burst mode is enabled, the LVDS clock gets way to high for my
> > panel. I don't know if it's the DSI controller in the STM32MP1 or
> > something not supported on the TI side.
> >
> > We have been running with this fix for 2 years :)
> 
> If I can summarize the situation in the last 4 years:
> 
>  * Several users reported the same trouble
>  * Those users patch their kernel out of tree to disable burst mode as a
>    workaround
>  * According to Marek the correct way to make burst mode work is
>    implementing link negotiation
>  * Nobody is willing to implement link negotiation as of now
> 
> And this leads me to some questions.
> 
>  * Do we want to keep the current situation (everybody beats their head on
>    the wall until they discover disabling burst mode "fixes" their panel,
>    and keep an out of tree patch)?
> 
>  * Assuming the priority is getting a screen working (and not saving power
>    on a black screen), would it make sense to apply this patch, and let
>    people improve in the future by implementing link negotiation?
> 
>    Let's pretend for a moment this is a new driver being developed: would
>    it be OK to have a basic working driver, without some power optimization
>    features which can be added later on? The only valid answer to this
>    question is obviously "yes". Doesn't the same principle apply here? If
>    it doesn't, why?
> 
>  * What is the expected power saving with burst mode?
> 
>    I'm afraid I don't have precise numbers but I measured the total board
>    consumption with or without burst mode (the former with a black screen
>    but backlight enabled) and found no difference: exactly 12.74 W in both
>    cases.
> 
> Thanks for you rpatience in reading this. I hope it helps in finding a
> better solution.

Rephrasing this a bit, is the discussion about dropping support for a
supported feature (burst mode) because users who suffer from the lack of
another feature (link negotiation) are not willing to spend time
implementing it, and would prefer if users of burst mode were forced to
do the work instead ? That doesn't seem very fair to me.

-- 
Regards,

Laurent Pinchart
