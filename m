Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B48B3F8D760
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 16:34:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1ED210E8FD;
	Thu, 16 Apr 2026 16:34:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="be3RVlQW";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D218D10E8FD
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 16:34:23 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
 by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 2463D132;
 Thu, 16 Apr 2026 18:32:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1776357168;
 bh=XdxahCveiLxOke7E96oRAdPQIJZzBzGzrJtXWp06WsM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=be3RVlQWHfyDRozPaEAmAbD8NxU0//YfM+yqXlO7pds2ChlbrP3T/cdRju7FuvRe/
 tBS7zKumucfM2UokghPPbdJjK3Q2bvJjZwBju1WgQs50xnE3VbmnaC7WENDAMLwGY5
 6dd/aydIoP2UTxX/Cbl39rXSgalQD/4ujG3XvC90=
Date: Thu, 16 Apr 2026 19:34:20 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: tomm.merciai@gmail.com, geert@linux-m68k.org,
 linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v6 10/21] dt-bindings: display: renesas,rzg2l-du: Add
 support for RZ/G3E SoC
Message-ID: <20260416163420.GA1827725@killaraus.ideasonboard.com>
References: <cover.1775636898.git.tommaso.merciai.xr@bp.renesas.com>
 <8f814f22ff62dcde6153260e2c8c29a5415c9a89.1775636898.git.tommaso.merciai.xr@bp.renesas.com>
 <20260408122436.GH1928916@killaraus.ideasonboard.com>
 <dafdbdcf-98db-473c-8122-296af1922e6c@bp.renesas.com>
 <20260408141638.GA1965119@killaraus.ideasonboard.com>
 <87a18664-d19e-4434-8f92-1c7ce4f3a131@bp.renesas.com>
 <20260408150053.GC1965119@killaraus.ideasonboard.com>
 <61f294e8-f9ae-4868-8dba-60250279ef21@bp.renesas.com>
 <20260409132420.GD2634584@killaraus.ideasonboard.com>
 <191a4bc7-f19e-4771-b70d-e54dd5506799@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <191a4bc7-f19e-4771-b70d-e54dd5506799@bp.renesas.com>
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

On Fri, Apr 10, 2026 at 03:21:44PM +0200, Tommaso Merciai wrote:
> On 4/9/26 15:24, Laurent Pinchart wrote:
> > On Thu, Apr 09, 2026 at 01:15:18PM +0200, Tommaso Merciai wrote:
> >> On 4/8/26 17:00, Laurent Pinchart wrote:
> >>> On Wed, Apr 08, 2026 at 04:44:48PM +0200, Tommaso Merciai wrote:
> >>>> On 4/8/26 16:16, Laurent Pinchart wrote:
> >>>>> On Wed, Apr 08, 2026 at 04:02:14PM +0200, Tommaso Merciai wrote:
> >>>>>> On 4/8/26 14:24, Laurent Pinchart wrote:
> >>>>>>> On Wed, Apr 08, 2026 at 12:36:55PM +0200, Tommaso Merciai wrote:
> >>>>>>>> The RZ/G3E SoC has 2 LCD controllers (LCDC), each containing a Frame
> >>>>>>>> Compression Processor (FCPVD), a Video Signal Processor (VSPD), and a
> >>>>>>>> Display Unit (DU).
> >>>>>>>>
> >>>>>>>>      - LCDC0 supports DSI and LVDS (single or dual-channel) outputs.
> >>>>>>>>      - LCDC1 supports DSI, LVDS (single-channel), and RGB outputs.
> >>>>>>>>
> >>>>>>>> Add a new SoC-specific compatible string 'renesas,r9a09g047-du'.
> >>>>>>>>
> >>>>>>>> Extend patternProperties from "^port@[0-1]$" to "^port@[0-3]$" to
> >>>>>>>> allow up to four output ports, and explicitly disable port@2 and port@3
> >>>>>>>> for existing SoCs that do not expose them.
> >>>>>>>>
> >>>>>>>> Describe the four output ports of the RZ/G3E DU:
> >>>>>>>>
> >>>>>>>>      - port@0: DSI (available on both LCDC instances)
> >>>>>>>>      - port@1: DPAD / parallel RGB (LCDC1 only)
> >>>>>>>>      - port@2: LVDS channel 0 (LCDC0 only)
> >>>>>>>>      - port@3: LVDS channel 1 (available on both LCDC instances)
> >>>>>>>>
> >>>>>>>> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> >>>>>>>> ---
> >>>>>>>> v5->v6:
> >>>>>>>>      - Extend patternProperties from "^port@[0-1]$" to "^port@[0-3]$" and
> >>>>>>>>        explicitly disable port@2 and port@3 for existing SoCs that do not expose
> >>>>>>>>        them.
> >>>>>>>>      - Reworked ports numbering + improved/fixed ports descriptions in the
> >>>>>>>>        bindings documentation.
> >>>>>>>>      - Improved commit body.
> >>>>>>>>
> >>>>>>>> v4->v5:
> >>>>>>>>      - Dropped renesas,id property and updated bindings
> >>>>>>>>        accordingly.
> >>>>>>>>
> >>>>>>>> v2->v3:
> >>>>>>>>      - No changes.
> >>>>>>>>
> >>>>>>>> v2->v3:
> >>>>>>>>      - No changes.
> >>>>>>>>
> >>>>>>>> v1->v2:
> >>>>>>>>      - Use single compatible string instead of multiple compatible strings
> >>>>>>>>        for the two DU instances, leveraging a 'renesas,id' property to
> >>>>>>>>        differentiate between DU0 and DU1.
> >>>>>>>>      - Updated commit message accordingly.
> >>>>>>>>
> >>>>>>>>      .../bindings/display/renesas,rzg2l-du.yaml    | 30 ++++++++++++++++++-
> >>>>>>>>      1 file changed, 29 insertions(+), 1 deletion(-)
> >>>>>>>>
> >>>>>>>> diff --git a/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml b/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
> >>>>>>>> index 5add3b832eab..32da0b5ec88c 100644
> >>>>>>>> --- a/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
> >>>>>>>> +++ b/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
> >>>>>>>> @@ -20,6 +20,7 @@ properties:
> >>>>>>>>            - enum:
> >>>>>>>>                - renesas,r9a07g043u-du # RZ/G2UL
> >>>>>>>>                - renesas,r9a07g044-du # RZ/G2{L,LC}
> >>>>>>>> +          - renesas,r9a09g047-du # RZ/G3E
> >>>>>>>>                - renesas,r9a09g057-du # RZ/V2H(P)
> >>>>>>>>            - items:
> >>>>>>>>                - enum:
> >>>>>>>> @@ -61,7 +62,7 @@ properties:
> >>>>>>>>            model-dependent. Each port shall have a single endpoint.
> >>>>>>>>      
> >>>>>>>>          patternProperties:
> >>>>>>>> -      "^port@[0-1]$":
> >>>>>>>> +      "^port@[0-3]$":
> >>>>>>>>              $ref: /schemas/graph.yaml#/properties/port
> >>>>>>>>              unevaluatedProperties: false
> >>>>>>>>      
> >>>>>>>> @@ -103,6 +104,8 @@ allOf:
> >>>>>>>>                  port@0:
> >>>>>>>>                    description: DPI
> >>>>>>>>                  port@1: false
> >>>>>>>> +            port@2: false
> >>>>>>>> +            port@3: false
> >>>>>>>>      
> >>>>>>>>                required:
> >>>>>>>>                  - port@0
> >>>>>>>> @@ -119,6 +122,8 @@ allOf:
> >>>>>>>>                    description: DSI
> >>>>>>>>                  port@1:
> >>>>>>>>                    description: DPI
> >>>>>>>> +            port@2: false
> >>>>>>>> +            port@3: false
> >>>>>>>>      
> >>>>>>>>                required:
> >>>>>>>>                  - port@0
> >>>>>>>> @@ -135,9 +140,32 @@ allOf:
> >>>>>>>>                  port@0:
> >>>>>>>>                    description: DSI
> >>>>>>>>                  port@1: false
> >>>>>>>> +            port@2: false
> >>>>>>>> +            port@3: false
> >>>>>>>>      
> >>>>>>>>                required:
> >>>>>>>>                  - port@0
> >>>>>>>> +  - if:
> >>>>>>>> +      properties:
> >>>>>>>> +        compatible:
> >>>>>>>> +          contains:
> >>>>>>>> +            const: renesas,r9a09g047-du
> >>>>>>>> +    then:
> >>>>>>>> +      properties:
> >>>>>>>> +        ports:
> >>>>>>>> +          properties:
> >>>>>>>> +            port@0:
> >>>>>>>> +              description: DSI
> >>>>>>>> +            port@1:
> >>>>>>>> +              description: DPAD
> >>>>>>>> +            port@2:
> >>>>>>>> +              description: LVDS, Channel 0
> >>>>>>>> +            port@3:
> >>>>>>>> +              description: LVDS, Channel 1
> >>>>>>>> +
> >>>>>>>> +          required:
> >>>>>>>> +            - port@0
> >>>>>>>> +            - port@3
> >>>>>>>
> >>>>>>> Why are ports 1 and 2 not required ?
> >>>>>>
> >>>>>> About this we had a similar discussion on v5[0]
> >>>>>> We are using the same compatible and:
> >>>>>>
> >>>>>> - LCDC0 supports DSI and LVDS (single or dual-channel) outputs.
> >>>>>> |
> >>>>>> --> then has:
> >>>>>> 	port@0
> >>>>>> 	port@2
> >>>>>> 	port@3
> >>>>>> 	
> >>>>>>
> >>>>>>      - LCDC1 supports DSI, LVDS (single-channel), and RGB outputs.
> >>>>>> |
> >>>>>> --> then has:
> >>>>>> 	port@0
> >>>>>> 	port@1
> >>>>>> 	port@3
> >>>>>
> >>>>> Ah yes, I forget there are two LCDC instances with different output
> >>>>> configurations.
> >>>>>
> >>>>> Something still looks a bit weird to me though. For LCDC1, which
> >>>>> supports a single LVDS channel, you use the port described as the second
> >>>>> LVDS channel. Is there a reason not to use port@2 ?
> >>>>
> >>>> 9.11 Low Voltage Differential Signaling (LVDS)
> >>>> 9.11.1.2 Block Diagram
> >>>> Figure 9.11-1 shows a block diagram of LVDS.
> >>>>
> >>>> LCDC1 is connected to LVDS, Channel 1
> >>>> For this reason I'm using port@3.
> >>>
> >>> Re-reading that, I think I've misinterpreted the hardware architecture.
> >>> Doesn't the DU have a single output, that is connected the multiple
> >>> encoders (LVDS and DSI for LCDC0 and LVDS, DSI and DPI for LCDC1) ? It
> >>> seems modelling it with a single port and multiple endpoints would
> >>> better match the device.
> >>>
> >>> For LVDS in particular, I see a single LVDS encoder with two channels,
> >>> so there should not be two LVDS output ports in the DU. The two ports
> >>> should be on the output of the LVDS device.
> >>
> >> You are suggesting the following dt architecture:
> >>
> >> du0: display@16460000 {
> >> 	compatible = "renesas,r9a09g047-du";
> >> 	reg = <0 0x16460000 0 0x10000>;
> >> 	interrupts = <GIC_SPI 882 IRQ_TYPE_LEVEL_HIGH>;
> >> 	clocks = <&cpg CPG_MOD 0xed>,
> >> 			<&cpg CPG_MOD 0xee>,
> >> 			<&cpg CPG_MOD 0xef>;
> >> 	clock-names = "aclk", "pclk", "vclk";
> >> 	power-domains = <&cpg>;
> >> 	resets = <&cpg 0xdc>;
> >> 	renesas,vsps = <&vspd0 0>;
> >> 	status = "disabled";
> >>
> >> 	port {
> >> 		du0_out_dsi: endpoint@0 {
> >> 			reg = <0>;
> >> 		};
> >>
> >> 		du0_out_lvds0: endpoint@2 {
> >> 			reg = <2>;
> >> 		};
> >>
> >> 		du0_out_lvds1: endpoint@3 {
> >> 			reg = <3>;
> >> 		};
> >> 	}
> >> };
> >>
> >> du1: display@16490000 {
> >> 	compatible = "renesas,r9a09g047-du";
> >> 	reg = <0 0x16490000 0 0x10000>;
> >> 	interrupts = <GIC_SPI 922 IRQ_TYPE_LEVEL_HIGH>;
> >> 	clocks = <&cpg CPG_MOD 0x1a8>,
> >> 			<&cpg CPG_MOD 0x1a9>,
> >> 			<&cpg CPG_MOD 0x1aa>;
> >> 	clock-names = "aclk", "pclk", "vclk";
> >> 	power-domains = <&cpg>;
> >> 	resets = <&cpg 0x11e>;
> >> 	renesas,vsps = <&vspd1 0>;
> >> 	status = "disabled";
> >>
> >> 	port {
> >> 		du1_out_dsi: endpoint@0 {
> >> 			reg = <0>;
> >> 		};
> >>
> >> 		du1_out_rgb: endpoint@1 {
> >> 			reg = <1>;
> >> 		};
> >>
> >> 		du1_out_lvds1: endpoint@3 {
> >> 			reg = <3>;
> >> 		};
> >> 	}
> >> };
> >>
> >>
> >> Please correct me if I'm wrong.
> > 
> > That's right. It would match the hardware, or at least my understanding
> > of the hardware based on the documentation. As far as I can tell, each
> > DU has a single 24-bit output port connected to multiple encoders.
> 
> Thanks for the clarification.
> 
> I want to make sure I understand the intended architecture correctly,
> because I see a potential conflict between your feedback on the two patches.
> 
> For [1], you confirmed the two separate DU nodes (DU0 and DU1) with the
> single-port/multi-endpoint model. That maps to two separate platform 
> devices, which means two separate DRM devices.

Not necessarily, it would be possible to instantiate a single drm_device
to cover both platform_device instances. It would require a bit of
manual work in the driver though.

> For [2], you suggested:
> 
> "you can have one DRM device that covers two LCDCs, with one CRTC each,
> both connected to the same DSI encoder. Userspace then selects which
> CRTC drives which connector."
> 
> Please correct me if I'm wrong but to me these two appear to be 
> incompatible. With two separate DRM devices,the DSI encoder and its 
> connector can only belong to one of them. Userspace cannot select 
> between CRTCs across two DRM devices.
> 
> To support the single-DRM-device model you describe, both DU0 and DU1 
> would need to be managed by a single driver instance, similar to R-Car 
> DU which aggregate multiple LCDC channels into one DRM device.
> 
> Using a single DRM device that spawn 2 crtc (1 du dt node ) this use 
> case can be tested with the following cmds:
> 
> 	modetest -M rzg2l-du -s 58@55:800x600-56.25@XR24
> 	modetest -M rzg2l-du -s 58@56:800x600-56.25@XR24
> 
> Could you clarify which architecture is the intended direction?
> 
> Option A: Two separate DRM devices (2 DU dt nodes, current approach),
>            with the DSI input selected via DT configuration.
>            The dynamic vclk selection I implemented still applies,
>            but runtime CRTC switching from userspace is not possible.
> 
> Option B: A single DRM device aggregating both DU instances (1 DU dt node),
>            with two CRTCs both connected to the DSI encoder.

I meant option B.

> [1] https://patchwork.kernel.org/project/linux-renesas-soc/patch/8f814f22ff62dcde6153260e2c8c29a5415c9a89.1775636898.git.tommaso.merciai.xr@bp.renesas.com/
> [2] https://patchwork.kernel.org/project/linux-renesas-soc/patch/9e0f64dd5e1efb0d27219416121c91a19da96ebd.1775636898.git.tommaso.merciai.xr@bp.renesas.com/
> 
> >>>>>> Then port@1 is required for DU1 but not for DU0.
> >>>>>> Same port@2 is required for DU0 but not for DU1.
> >>>>>>
> >>>>>> [0] https://patchwork.kernel.org/project/linux-renesas-soc/patch/ca022fdbba5236c36e0cb3095db4c31e8e0cb1b8.1770996493.git.tommaso.merciai.xr@bp.renesas.com/
> >>>>>>
> >>>>>>>>
> >>>>>>>>      examples:
> >>>>>>>>        # RZ/G2L DU

-- 
Regards,

Laurent Pinchart
