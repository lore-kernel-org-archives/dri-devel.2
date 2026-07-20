Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8613BC44521
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 06:54:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD71110E6B8;
	Mon, 20 Jul 2026 06:54:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KrQosxJr";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBD2A10E6B8
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:54:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CAD58601D9;
 Mon, 20 Jul 2026 06:54:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848101F000E9;
 Mon, 20 Jul 2026 06:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784530477;
 bh=KRb6TGQxOC1FpFX6y3n5ATAXoW7DHU5XuX04bzI5yNw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=KrQosxJrHCwq+btkXOpUYptoX+JGrJtGW8RNxpgyd9ZY2dQFMRbV2zas5fN5KzMAw
 djgrG3YRQnM7FmnOYIPrhzmsxyF2gJ2AlC1USnFXuNCQygnr6flhkYVwrA5dxj7XA6
 TNbRojYNm/XqFDwcZJl3v19Qh9sqeLduiLJwyKIlyT+4FDRlE5G6U7z0zCT4Nhb+RI
 n46RehFK6SwdWabFoPlisYKQeakodv9MUvja1J94TjU75wH26W6QVfxHzgjII6YnnT
 rwl70AVrhnBDnKyGFEJ5gX9ecIlMvhiMG27UziU+/wv91zzEuMsOm25F+uXTt276OG
 xBDcAbrR2zj+Q==
Date: Mon, 20 Jul 2026 08:54:33 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Eduard Bostina <egbostina@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Conor Dooley <conor+dt@kernel.org>, 
 Daniel Thompson <danielt@kernel.org>, devicetree@vger.kernel.org, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, dri-devel@lists.freedesktop.org, 
 Jingoo Han <jingoohan1@gmail.com>, Kevin Hilman <khilman@baylibre.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-omap@vger.kernel.org, 
 Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
 Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, daniel.baluta@nxp.com, simona.toaca@nxp.com, 
 goledhruva@gmail.com, m-chawdhry@ti.com
Subject: Re: [PATCH v2 3/3] dt-bindings: leds: backlight: Convert TPS65217 to
 DT schema
Message-ID: <20260720-huge-sturgeon-from-shambhala-a1bdcf@quoll>
References: <20260718215632.3295049-1-egbostina@gmail.com>
 <20260718215632.3295049-4-egbostina@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260718215632.3295049-4-egbostina@gmail.com>
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

On Sat, Jul 18, 2026 at 09:56:32PM +0000, Eduard Bostina wrote:
 +
> +    patternProperties:
> +      "^regulator@[0-6]$":
> +        type: object
> +        $ref: /schemas/regulator/regulator.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          reg:
> +            maxItems: 1
> +
> +          regulator-compatible:
> +            $ref: /schemas/types.yaml#/definitions/string

You should not need this property, it is already in regulator.yaml.

> +
> +  charger:
> +    $ref: /schemas/power/supply/tps65217-charger.yaml#

unevaluatedProperties: false

> +
> +  pwrbutton:
> +    $ref: /schemas/input/ti,tps65217-pwrbutton.yaml#

unevaluatedProperties: false

> +
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        tps@24 {

pmic@24

Please make the example mostly complete - add rest of properties and nodes.

> +            reg = <0x24>;
> +            compatible = "ti,tps65217";
> +
> +            backlight {
> +                isel = <1>;   /* 1 - ISET1, 2 ISET2 */
> +                fdim = <100>; /* TPS65217_BL_FDIM_100HZ */
> +                default-brightness = <50>;
> +            };
> +        };

Best regards,
Krzysztof

