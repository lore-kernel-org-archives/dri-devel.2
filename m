Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA3C5C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 09:17:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC52310E05F;
	Thu,  9 Jul 2026 09:17:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Hqm/fPSl";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1061D10E05F
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 09:17:09 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9BAD1448;
 Thu,  9 Jul 2026 11:16:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1783588576;
 bh=cfGBqMoCZZdYkPc6rSEc1mvwIyP87FxZlSbhBAt/oNQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Hqm/fPSlAfZsUvKK92jwDnCAZ07Q3Oxpgg8qhILk74jlNvqVNnAmkTk4yGnMXtdvP
 GXYk7GXo5GvCaleUvd7n6bfkVuFL+c0vd+Kj73+C3mqdEj2kQzlLJFuaq6GQr74q/a
 CgCBkLxJZvpn3xH/LpOGZb72cYmFDCVV4bdfDuDc=
Date: Thu, 9 Jul 2026 12:17:05 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
 devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: sn65dsi83: Add reverse lanes
 property
Message-ID: <20260709091705.GA547298@killaraus.ideasonboard.com>
References: <20260707070244.230546-1-wojciech.dubowik@mt.com>
 <20260707070244.230546-2-wojciech.dubowik@mt.com>
 <8332433.DvuYhMxLoT@steina-w>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8332433.DvuYhMxLoT@steina-w>
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

On Thu, Jul 09, 2026 at 10:33:36AM +0200, Alexander Stein wrote:
> Am Dienstag, 7. Juli 2026, 09:02:42 CEST schrieb Wojciech Dubowik:
> > From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> > 
> > Add reverse lvds lanes property for endpoints. It reverses
> > the data-lanes order i.e. <4 3 2 1> instead of default
> > <1 2 3 4>.
> 
> Wouldn't it be more reasonable to parse the data-lanes property and check
> for the order instead of introducing a new property?

I think so. That's the intended usage of data-lanes, the property is
meant to convey the order of lanes in addition to the count. Otherwise
we would have used a data-lanes-count property instead.

> > Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> > ---
> >  .../devicetree/bindings/display/bridge/ti,sn65dsi83.yaml      | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
> > index e69b6343a8eb..44483e808af9 100644
> > --- a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
> > +++ b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
> > @@ -115,6 +115,10 @@ $defs:
> >              enum: [100, 200]
> >              default: 200
> >  
> > +          ti,lvds-reverse-lanes:
> > +            description: Reverse the order of LVDS lanes.
> > +            type: boolean
> > +
> >            ti,lvds-vod-swing-clock-microvolt:
> >              description: LVDS diferential output voltage <min max> for clock
> >                lanes in microvolts.

-- 
Regards,

Laurent Pinchart
