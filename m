Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED1DB1073CA7
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 12:24:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45C0D10E356;
	Wed,  8 Apr 2026 12:24:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="OnLaZMZ1";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94CC810E356
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 12:24:39 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
 by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 1C2701121;
 Wed,  8 Apr 2026 14:23:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1775650990;
 bh=SlTk9pYhw8gQ7IZR2fT/XadwHciBiREZfYXDdO1UhJk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OnLaZMZ1pmD2g1tGdeeljmulCswG+u122ucyDAAGFxR8/P5USrhgyhM17hCTgE62r
 1XAZONBqEi2kCLQ0lXSfe9Gh0pXCGbuxkvWXcyDOH68LgilFNnB8MrKVs/cz5+R2FZ
 36NXD8osRqUJOOVDxAQfart6OQOMQp/WBxmH9GEw=
Date: Wed, 8 Apr 2026 15:24:36 +0300
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
Message-ID: <20260408122436.GH1928916@killaraus.ideasonboard.com>
References: <cover.1775636898.git.tommaso.merciai.xr@bp.renesas.com>
 <8f814f22ff62dcde6153260e2c8c29a5415c9a89.1775636898.git.tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8f814f22ff62dcde6153260e2c8c29a5415c9a89.1775636898.git.tommaso.merciai.xr@bp.renesas.com>
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

On Wed, Apr 08, 2026 at 12:36:55PM +0200, Tommaso Merciai wrote:
> The RZ/G3E SoC has 2 LCD controllers (LCDC), each containing a Frame
> Compression Processor (FCPVD), a Video Signal Processor (VSPD), and a
> Display Unit (DU).
> 
>  - LCDC0 supports DSI and LVDS (single or dual-channel) outputs.
>  - LCDC1 supports DSI, LVDS (single-channel), and RGB outputs.
> 
> Add a new SoC-specific compatible string 'renesas,r9a09g047-du'.
> 
> Extend patternProperties from "^port@[0-1]$" to "^port@[0-3]$" to
> allow up to four output ports, and explicitly disable port@2 and port@3
> for existing SoCs that do not expose them.
> 
> Describe the four output ports of the RZ/G3E DU:
> 
>  - port@0: DSI (available on both LCDC instances)
>  - port@1: DPAD / parallel RGB (LCDC1 only)
>  - port@2: LVDS channel 0 (LCDC0 only)
>  - port@3: LVDS channel 1 (available on both LCDC instances)
> 
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> ---
> v5->v6:
>  - Extend patternProperties from "^port@[0-1]$" to "^port@[0-3]$" and
>    explicitly disable port@2 and port@3 for existing SoCs that do not expose
>    them.
>  - Reworked ports numbering + improved/fixed ports descriptions in the
>    bindings documentation.
>  - Improved commit body.
> 
> v4->v5:
>  - Dropped renesas,id property and updated bindings
>    accordingly.
> 
> v2->v3:
>  - No changes.
> 
> v2->v3:
>  - No changes.
> 
> v1->v2:
>  - Use single compatible string instead of multiple compatible strings
>    for the two DU instances, leveraging a 'renesas,id' property to
>    differentiate between DU0 and DU1.
>  - Updated commit message accordingly.
> 
>  .../bindings/display/renesas,rzg2l-du.yaml    | 30 ++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml b/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
> index 5add3b832eab..32da0b5ec88c 100644
> --- a/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
> +++ b/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
> @@ -20,6 +20,7 @@ properties:
>        - enum:
>            - renesas,r9a07g043u-du # RZ/G2UL
>            - renesas,r9a07g044-du # RZ/G2{L,LC}
> +          - renesas,r9a09g047-du # RZ/G3E
>            - renesas,r9a09g057-du # RZ/V2H(P)
>        - items:
>            - enum:
> @@ -61,7 +62,7 @@ properties:
>        model-dependent. Each port shall have a single endpoint.
>  
>      patternProperties:
> -      "^port@[0-1]$":
> +      "^port@[0-3]$":
>          $ref: /schemas/graph.yaml#/properties/port
>          unevaluatedProperties: false
>  
> @@ -103,6 +104,8 @@ allOf:
>              port@0:
>                description: DPI
>              port@1: false
> +            port@2: false
> +            port@3: false
>  
>            required:
>              - port@0
> @@ -119,6 +122,8 @@ allOf:
>                description: DSI
>              port@1:
>                description: DPI
> +            port@2: false
> +            port@3: false
>  
>            required:
>              - port@0
> @@ -135,9 +140,32 @@ allOf:
>              port@0:
>                description: DSI
>              port@1: false
> +            port@2: false
> +            port@3: false
>  
>            required:
>              - port@0
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: renesas,r9a09g047-du
> +    then:
> +      properties:
> +        ports:
> +          properties:
> +            port@0:
> +              description: DSI
> +            port@1:
> +              description: DPAD
> +            port@2:
> +              description: LVDS, Channel 0
> +            port@3:
> +              description: LVDS, Channel 1
> +
> +          required:
> +            - port@0
> +            - port@3

Why are ports 1 and 2 not required ?

>  
>  examples:
>    # RZ/G2L DU

-- 
Regards,

Laurent Pinchart
