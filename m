Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65EEFCD98CF
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 17:01:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A335710EAA3;
	Fri, 12 Jun 2026 17:01:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="llm605R7";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C24C910EAA3
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 17:01:49 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6A615225;
 Fri, 12 Jun 2026 19:01:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1781283677;
 bh=KVbtAEEtprqp5yyIoAXBQcwpPK0XelSa5kEMMWYCbAI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=llm605R7ZrLc9err8IAkvdf4IzX4Spd6MKK7m6pw5EdHUOYoTigYq5B62jlv0yazg
 mbg/joeHg1oy1aTU96k+hDxZ+KHpvqentcezJiiytYRIT/SPXAZ6sC5Np6Zi7D7Han
 0pCNsBhLoieIxwIdVVc1UQ6I5cQalETck5BgagGw=
Date: Fri, 12 Jun 2026 20:01:46 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Conor Dooley <conor@kernel.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/5] dt-bindings: display: bridge: Document Renesas
 R-Car V4H DSC bindings
Message-ID: <20260612170146.GA2094246@killaraus.ideasonboard.com>
References: <20260515-rcar-du-dsc-v2-0-f6b9240a1240@ideasonboard.com>
 <20260515-rcar-du-dsc-v2-2-f6b9240a1240@ideasonboard.com>
 <20260515-fraying-trickle-7511a2eeaf44@spud>
 <81f89aa1-84d8-44e1-813b-2bbcafe3687e@ideasonboard.com>
 <20260612-landed-remedial-79582e900699@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260612-landed-remedial-79582e900699@spud>
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

On Fri, Jun 12, 2026 at 05:09:48PM +0100, Conor Dooley wrote:
> On Fri, Jun 12, 2026 at 01:43:44PM +0300, Tomi Valkeinen wrote:
> > On 15/05/2026 20:32, Conor Dooley wrote:
> > > On Fri, May 15, 2026 at 10:56:15AM +0300, Tomi Valkeinen wrote:
> > > > From: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > > > 
> > > > The Renesas DSC Display Stream Compression is a bridge embedded in the
> > > > Renesas R-Car V4H SoC. The bridge performs VESA DSC encoding of up to
> > > > 8k or 400 Mpixel/s .
> > > > 
> > > > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > > > [tomi.valkeinen: fix the example]
> > > > Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
> > > > ---
> > > >   .../bindings/display/bridge/renesas,dsc.yaml       | 96 ++++++++++++++++++++++
> > > >   1 file changed, 96 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/display/bridge/renesas,dsc.yaml b/Documentation/devicetree/bindings/display/bridge/renesas,dsc.yaml
> > > > new file mode 100644
> > > > index 000000000000..2918d592732b
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/display/bridge/renesas,dsc.yaml
> > > 
> > > Filename matching the compatible please.
> > 
> > All the other Documentation/devicetree/bindings/display/bridge/renesas,*
> > files follow the same style, where the file name is in a generic format, but
> > the actual compat strings are per SoC (and no generic compat string).
> 
> No idea why it's like that currently, but filename matching compatible
> is the policy.

I wonder if we should use

  compatible:
    items:
      - enum:
          - renesas,r8a779g0-dsc
      - const: renesas,rcar-dsc

to prepare for the other SoCs that include a DSC. It's of course hard to
predict how compatible all new silicon will be, but we know there will
be some compatible ones.

This being said, looking for instance at renesas,du.yaml in the same
directory, we have

  compatible:
    enum:
      - renesas,du-r8a7742 # for RZ/G1H compatible DU
      - renesas,du-r8a7743 # for RZ/G1M compatible DU
      - renesas,du-r8a7744 # for RZ/G1N compatible DU
      - renesas,du-r8a7745 # for RZ/G1E compatible DU
      - renesas,du-r8a77470 # for RZ/G1C compatible DU
      - renesas,du-r8a774a1 # for RZ/G2M compatible DU
      - renesas,du-r8a774b1 # for RZ/G2N compatible DU
      - renesas,du-r8a774c0 # for RZ/G2E compatible DU
      - renesas,du-r8a774e1 # for RZ/G2H compatible DU
      - renesas,du-r8a7779 # for R-Car H1 compatible DU
      - renesas,du-r8a7790 # for R-Car H2 compatible DU
      - renesas,du-r8a7791 # for R-Car M2-W compatible DU
      - renesas,du-r8a7792 # for R-Car V2H compatible DU
      - renesas,du-r8a7793 # for R-Car M2-N compatible DU
      - renesas,du-r8a7794 # for R-Car E2 compatible DU
      - renesas,du-r8a7795 # for R-Car H3 compatible DU
      - renesas,du-r8a7796 # for R-Car M3-W compatible DU
      - renesas,du-r8a77961 # for R-Car M3-W+ compatible DU
      - renesas,du-r8a77965 # for R-Car M3-N compatible DU
      - renesas,du-r8a77970 # for R-Car V3M compatible DU
      - renesas,du-r8a77980 # for R-Car V3H compatible DU
      - renesas,du-r8a77990 # for R-Car E3 compatible DU
      - renesas,du-r8a77995 # for R-Car D3 compatible DU
      - renesas,du-r8a779a0 # for R-Car V3U compatible DU
      - renesas,du-r8a779g0 # for R-Car V4H compatible DU
      - renesas,du-r8a779h0 # for R-Car V4M compatible DU

Could the file have been named renesas,du-r8a7790.yaml ? Sure. Would it
be better for users than renesas,du.yaml ? I'm less sure.

-- 
Regards,

Laurent Pinchart
