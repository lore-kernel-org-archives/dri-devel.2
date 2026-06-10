Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 906A5CD98C7
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 23:18:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5F1D10E275;
	Wed, 10 Jun 2026 23:18:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="IU0H9k89";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 881FF10E275
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 23:18:45 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id C4C419D1;
 Thu, 11 Jun 2026 01:18:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1781133495;
 bh=bDutxsDGuo64IizNyxZ3PZMW7vgf15RM9takx0DvE9g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IU0H9k89utnCTP8294WQVrX4V7yUu1dCAp/7cj2CxziK3GlvEP7jp4nxaWe60bykX
 0YR2Nt6KMs7QgEF2RP+wqg6h05arbJb4q4SQvh3BN0KhqLiFPGpvKOYstMthRFIQMM
 Ka287by0WrkpCnyCg4fTZQCOa17uSWpZrlacTa3s=
Date: Thu, 11 Jun 2026 02:18:42 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Conor Dooley <conor@kernel.org>
Cc: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
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
Message-ID: <20260610231842.GA1751568@killaraus.ideasonboard.com>
References: <20260515-rcar-du-dsc-v2-0-f6b9240a1240@ideasonboard.com>
 <20260515-rcar-du-dsc-v2-2-f6b9240a1240@ideasonboard.com>
 <20260515-fraying-trickle-7511a2eeaf44@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260515-fraying-trickle-7511a2eeaf44@spud>
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

On Fri, May 15, 2026 at 06:32:27PM +0100, Conor Dooley wrote:
> On Fri, May 15, 2026 at 10:56:15AM +0300, Tomi Valkeinen wrote:
> > From: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > 
> > The Renesas DSC Display Stream Compression is a bridge embedded in the
> > Renesas R-Car V4H SoC. The bridge performs VESA DSC encoding of up to
> > 8k or 400 Mpixel/s .
> > 
> > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > [tomi.valkeinen: fix the example]
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
> > ---
> >  .../bindings/display/bridge/renesas,dsc.yaml       | 96 ++++++++++++++++++++++
> >  1 file changed, 96 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/bridge/renesas,dsc.yaml b/Documentation/devicetree/bindings/display/bridge/renesas,dsc.yaml
> > new file mode 100644
> > index 000000000000..2918d592732b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/bridge/renesas,dsc.yaml
> 
> Filename matching the compatible please.
> 
> pw-bot: changes-requested
> 
> > @@ -0,0 +1,96 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/bridge/renesas,dsc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Renesas R-Car DSC Display Stream Compression
> > +
> > +maintainers:
> > +  - Marek Vasut <marek.vasut+renesas@mailbox.org>
> > +
> > +description: |
> > +  This binding describes the VESA DSC Display Stream Compression encoder
> > +  embedded in the Renesas R-Car V4H SoC. The encoder supports all DSC1.1
> > +  encoding mechanisms, configurable bits-per-pixel, resolution up to 8k.
> > +
> > +properties:
> > +  compatible:
> > +    const: renesas,r8a779g0-dsc
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  resets:
> > +    maxItems: 1
> > +
> > +  ports:
> > +    $ref: /schemas/graph.yaml#/properties/ports
> > +
> > +    properties:
> > +      port@0:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: R-Car DU input port
> > +
> > +      port@1:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: R-Car DSI output port
> > +
> > +    required:
> > +      - port@0
> > +      - port@1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - interrupts
> > +  - power-domains
> > +  - resets
> > +  - ports
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/r8a779g0-cpg-mssr.h>
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/power/r8a779g0-sysc.h>
> > +
> > +    dsc@feb8d000 {
> 
> Speaking of fixing the example, should this not be "decoder" or

Or rather "encoder"

> "bridge"?
> Not a big deal though.
> With the changed filename
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 
> > +        compatible = "renesas,r8a779g0-dsc";
> > +        reg = <0xfeb8d000 0x400>;
> > +        interrupts = <GIC_SPI 559 IRQ_TYPE_LEVEL_HIGH>;
> > +        clocks = <&cpg CPG_MOD 2819>;
> > +        power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
> > +        resets = <&cpg 2819>;
> > +
> > +        ports {
> > +            #address-cells = <1>;
> > +            #size-cells = <0>;
> > +
> > +            port@0 {
> > +                reg = <0>;
> > +                dsc_in_dsi1: endpoint {
> > +                    remote-endpoint = <&du_out_dsi1>;
> > +                };
> > +            };
> > +
> > +            port@1 {
> > +                reg = <1>;
> > +                dsc_out_dsi1: endpoint {
> > +                    remote-endpoint = <&dsi1_in>;
> > +                };
> > +            };
> > +        };
> > +    };
> > +...

-- 
Regards,

Laurent Pinchart
