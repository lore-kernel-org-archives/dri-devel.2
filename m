Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C620C43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 15:24:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 646A689954;
	Sun, 12 Jul 2026 15:24:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IXX1BiDI";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CAEA89954
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 15:24:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 08F0D42DAA;
 Sun, 12 Jul 2026 15:24:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783CE1F000E9;
 Sun, 12 Jul 2026 15:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783869873;
 bh=HQIHMdxN0FPpuhQMFBvDbnB9+5Gm6o4Vk0oxtEYadb4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=IXX1BiDIrRCafafq1RK1qogsHcqU1MZbu+4n+7pVF7mwXtFkSmQVvxK6L0pEzl9hn
 XZNp+9pnme2K+FN5lkyHHw2cAq2rIZnJnSFqYNcNuvHRjIpXPkjnNmFebkjK+wYxHp
 +aLKNbJYT/XWGqgsYLbnGBLIEedxQdJt+J/GUuRODn19VZULZ4a3thPuaAme8dmYq3
 GLNsXHSIs5yYSlGjsfS7qZErTSIEW20N8Ct0vkHDyf7fYxeB4liJnfH8v2ZqYanMBN
 tL82ylSdO80OxGwf+6kHon+LCaetDcxJ7Pe53mlHUe6kcqr0hUETsEkgOoVqWYbqOe
 bSa320TOJoqjQ==
Date: Sun, 12 Jul 2026 17:24:29 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "biju.das.au" <biju.das.au@gmail.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 "magnus.damm" <magnus.damm@gmail.com>,
 "laurent.pinchart" <laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 01/16] dt-bindings: display: bridge: renesas,dsi:
 Document RZ/G3L
Message-ID: <20260712-jumping-whimsical-alligator-8fa8ec@quoll>
References: <20260704093433.273672-1-biju.das.jz@bp.renesas.com>
 <20260704093433.273672-2-biju.das.jz@bp.renesas.com>
 <20260708-hopping-exotic-baboon-6c5a46@quoll>
 <TY3PR01MB11346CB08784610C00EBC870A86FF2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <TY3PR01MB11346CB08784610C00EBC870A86FF2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
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

On Wed, Jul 08, 2026 at 09:39:01AM +0000, Biju Das wrote:
> Hi Krzysztof Kozlowski,
> 
> Thanks for the feedback.
> 
> > -----Original Message-----
> > From: Krzysztof Kozlowski <krzk@kernel.org>
> > Sent: 08 July 2026 09:30
> > Subject: Re: [PATCH 01/16] dt-bindings: display: bridge: renesas,dsi: Document RZ/G3L
> > 
> > On Sat, Jul 04, 2026 at 10:34:11AM +0100, Biju wrote:
> > > From: Biju Das <biju.das.jz@bp.renesas.com>
> > >
> > > The RZ/G3L DSI IP is similar to the RZ/G2L but has different global
> > > PHY timings and also the PLLCLK is ungateble clock. Add the compatible
> > > string "renesas,r9a08g046-mipi-dsi" to handle these difference for the
> > > Renesas RZ/G3L SoC. The power to DSI region is controlled by SYSC block.
> > > Document renesas,sysc-pwrrdy property to handle the power control.
> > >
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > ---
> > >  .../bindings/display/bridge/renesas,dsi.yaml      | 15 +++++++++++++++
> > >  1 file changed, 15 insertions(+)
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/display/bridge/renesas,dsi.yaml
> > > b/Documentation/devicetree/bindings/display/bridge/renesas,dsi.yaml
> > > index c20625b8425e..b114ac3b111a 100644
> > > ---
> > > a/Documentation/devicetree/bindings/display/bridge/renesas,dsi.yaml
> > > +++ b/Documentation/devicetree/bindings/display/bridge/renesas,dsi.yam
> > > +++ l
> > > @@ -28,6 +28,7 @@ properties:
> > >            - const: renesas,r9a09g057-mipi-dsi
> > >
> > >        - enum:
> > > +          - renesas,r9a08g046-mipi-dsi # RZ/G3L
> > >            - renesas,r9a09g057-mipi-dsi # RZ/V2H(P)
> > >
> > >    reg:
> > > @@ -108,6 +109,20 @@ properties:
> > >    power-domains:
> > >      maxItems: 1
> > >
> > > +  renesas,sysc-pwrrdy:
> > > +    description:
> > > +      The system controller PWRRDY indicates to the DSI region, if the power
> > > +      supply is ready. PWRRDY needs to be set during power-on before applying
> > > +      any other settings. It also needs to be set before powering off the DSI.
> > > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > 
> > This feels a lot like a power domain. Please elaborate what is PWRRDY and why power-on/off and power
> > status within SoC (important!) is not encoded as power domain.
> 
> We already tried modelling signal as power domain in RZ/G3S and finally Ulf
> agreed that it cannot be power-domain[1]
> 
> " SYSC signal seems best to be modelled as a reset.
> Although, it looks like the USB PM domain provider should rather be
> the consumer of that reset, instead of having the reset being consumed
> by the consumers of the USB PM domain."
> 
> Then Phillip proposed power sequencing driver[2] and finally he and Rob ok for the 
> solution [3] 

The problem is that you did not implement or reference here power
sequencing. You created phandle without corresponding any hardware
signal and used "driver" as an argument.

power sequencing does not mean you can stuff random phandles here and
there.

Best regards,
Krzysztof

