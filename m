Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB8DCD8C8E
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 08:00:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBE8510EE93;
	Mon,  8 Jun 2026 08:00:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RQOMOgPz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06F5510EE93
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 08:00:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4F1B56001D;
 Mon,  8 Jun 2026 08:00:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E251F00893;
 Mon,  8 Jun 2026 08:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780905655;
 bh=shxmCQvSBBkNie3O/CcwrtLbRce6sySrtFuYPQ8CYKk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=RQOMOgPzEjoT70pPB5OMCCJi0hMd9T/OIYgzJ4wRIaMkJslVqmxoeFc2FLbXXl1wd
 zLhK55oHz5jto8g56BT3Wv29Fce7c7CxLGc2z0yOitcB5yKjy52UIfTbYGpwQngChf
 DCaa+P8O2fIzraUcsg9bxTByaU3j5zFeVlQAIOHK2VBmIgV5iJf96mGX2r5g4Byrxj
 Fbcm/tO+8z0/4C0fm0f+/WyjurR7I92iIuzO6l7Ng0D6XvJCHwNvapf4EXB5LI6kTG
 CSSnLT+Mce9d/u5j87dXp62lnA8Uj8cNlC5fRmoHW+oTFL1B1zv987rqe/8bBTbPz6
 YAEVkyPepQUhA==
Date: Mon, 8 Jun 2026 10:00:51 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Joey Lu <a0987203069@gmail.com>
Cc: zhengxingda@iscas.ac.cn, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, ychuang3@nuvoton.com,
 schung@nuvoton.com, yclu4@nuvoton.com, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] dt-bindings: display: verisilicon,dc: generalize
 for single-output variants
Message-ID: <20260608-emotional-rapid-woodlouse-61f7b9@quoll>
References: <20260608023237.305036-1-a0987203069@gmail.com>
 <20260608023237.305036-2-a0987203069@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260608023237.305036-2-a0987203069@gmail.com>
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

On Mon, Jun 08, 2026 at 10:32:33AM +0800, Joey Lu wrote:
> The existing schema hard-codes the five-clock/three-reset/dual-port
> topology of the DC8200 IP block, preventing reuse for single-output
> variants such as the Verisilicon DCUltraLite used in the Nuvoton MA35D1
> SoC.
> 
> Rework the schema so that variant-specific constraints are expressed via
> allOf/if blocks:
> 
> - Add nuvoton,ma35d1-dcu to the SoC-specific compatible enum.  The
>   generic verisilicon,dc fallback remains the driver-binding string.
> - Relax the top-level clocks/resets definitions to minItems ranges so
>   the base schema accepts both variants.
> - Keep ports in the global required list and keep additionalProperties
>   tightened to unevaluatedProperties.
> - Add an allOf/if block for thead,th1520-dc8200: five-clock (core, axi,
>   ahb, pix0, pix1), three-reset (core, axi, ahb).
> - Add an allOf/if block for nuvoton,ma35d1-dcu: two-clock (core, pix0),
>   one-reset (core).
> - Fix a stray space in the port@0 description.
> - Add a DT example for the Nuvoton MA35D1 DCU Lite using ports/port@0.
> 
> Signed-off-by: Joey Lu <a0987203069@gmail.com>
> ---
>  .../bindings/display/verisilicon,dc.yaml      | 103 +++++++++++++++---
>  1 file changed, 90 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/verisilicon,dc.yaml b/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
> index 9dc35ab973f2..db0260d874c5 100644
> --- a/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
> +++ b/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
> @@ -17,7 +17,8 @@ properties:
>      items:
>        - enum:
>            - thead,th1520-dc8200
> -      - const: verisilicon,dc # DC IPs have discoverable ID/revision registers
> +          - nuvoton,ma35d1-dcu
> +      - const: verisilicon,dc  # DC IPs have discoverable ID/revision registers

Why do you need to change indentation? Why introducing irrelevant
changes to the diff?

>  
>    reg:
>      maxItems: 1
> @@ -26,6 +27,7 @@ properties:
>      maxItems: 1
>  
>    clocks:
> +    minItems: 2
>      items:
>        - description: DC Core clock
>        - description: DMA AXI bus clock

That's not true anymore. In such case the list should also be defined
per variant and here only min/maxItems.


> @@ -34,24 +36,19 @@ properties:
>        - description: Pixel clock of output 1
>  
>    clock-names:
> -    items:
> -      - const: core
> -      - const: axi
> -      - const: ahb
> -      - const: pix0
> -      - const: pix1
> +    minItems: 2
> +    maxItems: 5
>  
>    resets:
> +    minItems: 1
>      items:
>        - description: DC Core reset
>        - description: DMA AXI bus reset
>        - description: Configuration AHB bus reset
>  
>    reset-names:
> -    items:
> -      - const: core
> -      - const: axi
> -      - const: ahb

This stays, with minItems. Variants only need min/maxItems



> +    minItems: 1
> +    maxItems: 3
>  
>    ports:
>      $ref: /schemas/graph.yaml#/properties/ports
> @@ -59,7 +56,7 @@ properties:
>      properties:
>        port@0:
>          $ref: /schemas/graph.yaml#/properties/port
> -        description: The first output channel , endpoint 0 should be
> +        description: The first output channel, endpoint 0 should be
>            used for DPI format output and endpoint 1 should be used
>            for DP format output.
>  
> @@ -77,7 +74,60 @@ required:
>    - clock-names
>    - ports
>  
> -additionalProperties: false
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: thead,th1520-dc8200
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 5
> +          maxItems: 5
> +
> +        clock-names:
> +          items:
> +            - const: core
> +            - const: axi
> +            - const: ahb
> +            - const: pix0
> +            - const: pix1
> +
> +        resets:
> +          minItems: 3
> +          maxItems: 3
> +
> +        reset-names:

minItems: 3

> +          items:
> +            - const: core
> +            - const: axi
> +            - const: ahb
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: nuvoton,ma35d1-dcu
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 2
> +          maxItems: 2
> +
> +        clock-names:
> +          items:
> +            - const: core
> +            - const: pix0
> +
> +        resets:
> +          maxItems: 1
> +
> +        reset-names:

maxItems: 1

> +          items:
> +            - const: core
> +
> +unevaluatedProperties: false

Stop making random changes to the binding.

Best regards,
Krzysztof

