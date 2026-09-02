Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96544C61DFD
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 06:37:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9B5D10EFE9;
	Wed,  2 Sep 2026 06:37:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="edRi/DVR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 665EC10EFE9
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 06:37:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 652EA600C8;
 Wed,  2 Sep 2026 06:37:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C371F000E9;
 Wed,  2 Sep 2026 06:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788331030;
 bh=yaV9+mmFhJ8GvWA0OLuH6CZzZgW/+vhynYlQ7CIJRRw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=edRi/DVRnwAUrTUVWOxnz4Fe5g8c2h+vMV8JzZeUQDrVC12q6Nku9s/DAqRGbE6L1
 oQdSdn0/bkB2LUE/nFHJOVefphrolpCaFcC1vh5GoAmVW0SMV9q6/18aFg8Mv+6Uw0
 qXYIbQZQdC4r7A7zzkUiews8zrknjZQgcnkcy/kw/qB5U4L3Tu4zQF1UC2UxIlzUEO
 YANELdd9xYYxkoTBJIMsCytrdwWxkxJty+5tX2AZcqemvq6bxPfDpazE9x3ZE95y4V
 shcDBC5K0i0URWcNRCLc4YmHKcYUNos97p+CpsO7ZzjxoaegmtdlA8UtBbFHPMnHY+
 1FKWipxwZhQ3g==
Date: Wed, 2 Sep 2026 08:37:06 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: tomm.merciai@gmail.com, linux-renesas-soc@vger.kernel.org, 
 biju.das.jz@bp.renesas.com, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/9] dt-bindings: display: renesas,rzg2l-du: Document
 RZ/G3E SoC
Message-ID: <20260902-heavenly-ambrosial-trogon-b7ab03@quoll>
References: <20260828122113.1426778-1-tommaso.merciai.xr@bp.renesas.com>
 <20260828122113.1426778-2-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260828122113.1426778-2-tommaso.merciai.xr@bp.renesas.com>
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

On Fri, Aug 28, 2026 at 02:21:04PM +0200, Tommaso Merciai wrote:
> The RZ/G3E Soc has 2 LCD controller (LCDC), contain a Frame Compression
> Processor (FCPVD), a Video Signal Processor (VSPD), Video Signal
> Processor (VSPD), and Display Unit (DU).
> 
>  - LCDC0 supports DSI and LVDS (single or dual-channel) outputs.
>  - LCDC1 supports DSI, LVDS (single-channel), and RGB outputs.
> 
> Add new SoC-specific compatible string 'renesas,r9a09g047-du'.
> 
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> ---
> v7->v8:
>  - Rebased on top of RZ/G3L du support [1]
>  - Modelled using ports/port instead of port/ep.
>    [1] https://lore.kernel.org/all/20260826174854.199139-1-biju.das.jz@bp.renesas.com/
>  - Improved commit msg and commit body.
> 
> v6->v7:
>  - Rebased on top of [1]
>    [1] https://lore.kernel.org/all/20260429170012.366537-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
>  - Use single DRM device aggregating both DU instances (1 DU dt node),
>    modelling single port for each DU0, DU1 and multiple endpoints for
>    outputs.
> 
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
>  .../bindings/display/renesas,rzg2l-du.yaml    | 95 ++++++++++++++++++-
>  1 file changed, 91 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml b/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
> index 5c9b15a09dee..d44c7c0add8d 100644
> --- a/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
> +++ b/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
> @@ -21,6 +21,7 @@ properties:
>            - renesas,r9a07g043u-du # RZ/G2UL
>            - renesas,r9a07g044-du # RZ/G2{L,LC}
>            - renesas,r9a08g046-du # RZ/G3L
> +          - renesas,r9a09g047-du # RZ/G3E
>            - renesas,r9a09g057-du # RZ/V2H(P)
>            - renesas,r9a09g077-du # RZ/T2H
>        - items:
> @@ -35,25 +36,51 @@ properties:
>            - const: renesas,r9a09g077-du # RZ/T2H fallback
>  
>    reg:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
> +
> +  reg-names:
> +    items:
> +      - const: du.0
> +      - const: du.1

du is the name of the device, thus calling items "0" and "1" is pretty
pointless - indices already define that. Please drop the reg-names.

>  
>    interrupts:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
> +
> +  interrupt-names:
> +    items:
> +      - const: du.0
> +      - const: du.1

Same here

>  
>    clocks:
> +    minItems: 3
>      items:
>        - description: Main clock
>        - description: Register access clock
>        - description: Video clock
> +      - description: Main clock for DU1
> +      - description: Register access clock for DU1
> +      - description: Video clock for DU1
>  
>    clock-names:
> +    minItems: 3
>      items:
>        - const: aclk
>        - const: pclk
>        - const: vclk
> +      - const: aclk1
> +      - const: pclk1
> +      - const: vclk1
>  
>    resets:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
> +
> +  reset-names:
> +    items:
> +      - const: resetn
> +      - const: resetn1

Drop reset-names

>  
>    power-domains:
>      maxItems: 1
> @@ -66,7 +93,7 @@ properties:
>        model-dependent. Each port shall have a single endpoint.
>  
>      patternProperties:
> -      "^port@[0-2]$":
> +      "^port@[0-3]$":
>          $ref: /schemas/graph.yaml#/properties/port
>          unevaluatedProperties: false
>  
> @@ -110,6 +137,7 @@ allOf:
>                description: DPI
>              port@1: false
>              port@2: false
> +            port@3: false

Best regards,
Krzysztof

