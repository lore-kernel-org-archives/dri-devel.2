Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2CB1CD4F25
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 17:32:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 257A310E03D;
	Fri, 15 May 2026 17:32:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oDIjNocx";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3230610E03D
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 17:32:35 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E89B3405C0;
 Fri, 15 May 2026 17:32:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1299C2BCB3;
 Fri, 15 May 2026 17:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778866354;
 bh=+DB+r2QuZCt9cRXlZ6SZbjHw/zkrj85jxoOPFc8ej2c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oDIjNocxi9GT9+5bJC32MLJccue9nzxCG9LlpQB34n1ZAH5ROOOSiGyRx/jriBtrH
 okdNB/ZwAxpY56i81tlQJXdDHs1I6WSOb/hd7OGB/0w9VksX9JBZDO3rRA1zr96A0k
 QQ8QkLsudDg/XmkXi7TUfoWmF9mlEAXwu+0qI58V/wxbfZzk7mpjQvLDd5DFUvSVwB
 jDlZ6RsZXM23jm9Cis6dwl2jMr5Tt5ZdMVgLuFPbycaVGgGVMzFWCjGOP3cHYLsekm
 GFHCY1TI6PAblaTJ3KWsaYRoRmQZAv+EG9FSqL3UnMLIWCHw77WYitgU6cSbBJbblf
 70xq+4VeGK+lg==
Date: Fri, 15 May 2026 18:32:27 +0100
From: Conor Dooley <conor@kernel.org>
To: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/5] dt-bindings: display: bridge: Document Renesas
 R-Car V4H DSC bindings
Message-ID: <20260515-fraying-trickle-7511a2eeaf44@spud>
References: <20260515-rcar-du-dsc-v2-0-f6b9240a1240@ideasonboard.com>
 <20260515-rcar-du-dsc-v2-2-f6b9240a1240@ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BKUyMwCcAfsDfsPq"
Content-Disposition: inline
In-Reply-To: <20260515-rcar-du-dsc-v2-2-f6b9240a1240@ideasonboard.com>
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


--BKUyMwCcAfsDfsPq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 10:56:15AM +0300, Tomi Valkeinen wrote:
> From: Marek Vasut <marek.vasut+renesas@mailbox.org>
>=20
> The Renesas DSC Display Stream Compression is a bridge embedded in the
> Renesas R-Car V4H SoC. The bridge performs VESA DSC encoding of up to
> 8k or 400 Mpixel/s .
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> [tomi.valkeinen: fix the example]
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
> ---
>  .../bindings/display/bridge/renesas,dsc.yaml       | 96 ++++++++++++++++=
++++++
>  1 file changed, 96 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/display/bridge/renesas,dsc=
=2Eyaml b/Documentation/devicetree/bindings/display/bridge/renesas,dsc.yaml
> new file mode 100644
> index 000000000000..2918d592732b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/renesas,dsc.yaml

Filename matching the compatible please.

pw-bot: changes-requested

> @@ -0,0 +1,96 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/renesas,dsc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas R-Car DSC Display Stream Compression
> +
> +maintainers:
> +  - Marek Vasut <marek.vasut+renesas@mailbox.org>
> +
> +description: |
> +  This binding describes the VESA DSC Display Stream Compression encoder
> +  embedded in the Renesas R-Car V4H SoC. The encoder supports all DSC1.1
> +  encoding mechanisms, configurable bits-per-pixel, resolution up to 8k.
> +
> +properties:
> +  compatible:
> +    const: renesas,r8a779g0-dsc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: R-Car DU input port
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: R-Car DSI output port
> +
> +    required:
> +      - port@0
> +      - port@1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - interrupts
> +  - power-domains
> +  - resets
> +  - ports
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/r8a779g0-cpg-mssr.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/power/r8a779g0-sysc.h>
> +
> +    dsc@feb8d000 {

Speaking of fixing the example, should this not be "decoder" or
"bridge"?
Not a big deal though.
With the changed filename
Acked-by: Conor Dooley <conor.dooley@microchip.com>


Cheers,
Conor.

> +        compatible =3D "renesas,r8a779g0-dsc";
> +        reg =3D <0xfeb8d000 0x400>;
> +        interrupts =3D <GIC_SPI 559 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks =3D <&cpg CPG_MOD 2819>;
> +        power-domains =3D <&sysc R8A779G0_PD_ALWAYS_ON>;
> +        resets =3D <&cpg 2819>;
> +
> +        ports {
> +            #address-cells =3D <1>;
> +            #size-cells =3D <0>;
> +
> +            port@0 {
> +                reg =3D <0>;
> +                dsc_in_dsi1: endpoint {
> +                    remote-endpoint =3D <&du_out_dsi1>;
> +                };
> +            };
> +
> +            port@1 {
> +                reg =3D <1>;
> +                dsc_out_dsi1: endpoint {
> +                    remote-endpoint =3D <&dsi1_in>;
> +                };
> +            };
> +        };
> +    };
> +...
>=20
> --=20
> 2.43.0
>=20

--BKUyMwCcAfsDfsPq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCagdYqwAKCRB4tDGHoIJi
0tgFAQCWZr0VyJbUsmrykeSLd46OUSC5XEhD7J2xXWqd9lUphgEAhFyus39c0hs/
Rg7UtXW22xP/EamsRO2R+icGF9YqcQg=
=1aTv
-----END PGP SIGNATURE-----

--BKUyMwCcAfsDfsPq--
