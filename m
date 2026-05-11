Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC44CD37AC
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 10:00:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F046910E17E;
	Mon, 11 May 2026 10:00:04 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A40610E17E
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 10:00:02 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.100.82])
 by APP-01 (Coremail) with SMTP id qwCowAA33GecqAFquQrkDw--.3722S2;
 Mon, 11 May 2026 17:59:56 +0800 (CST)
Message-ID: <cb69490652409eb4f07b3ee642d478e1b2e28c5b.camel@iscas.ac.cn>
Subject: Re: [PATCH 1/2] dt-bindings: display: verisilicon,dc: generalize
 for DCUltra Lite variant
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Joey Lu <a0987203069@gmail.com>, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, 	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Mon, 11 May 2026 17:59:55 +0800
In-Reply-To: <20260511075142.54752-2-a0987203069@gmail.com>
References: <20260511075142.54752-1-a0987203069@gmail.com>
 <20260511075142.54752-2-a0987203069@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: qwCowAA33GecqAFquQrkDw--.3722S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKFyDWFyDKrWfZrWUtFWrZrb_yoWfZF1rpF
 WrJFWUJryxtFn3Xr48tw109Fy5Jw4kJ3WDJr18X3WUJF4DJrW0qr42grn0g3W7Jr48XryU
 KF1Uur13Zr12yr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvvb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
 8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
 64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
 Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
 c7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
 1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
 14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
 IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
 87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
 IFyTuYvjxUqVcEUUUUU
X-Originating-IP: [112.94.100.82]
X-CM-SenderInfo: x2kh0wp0lqwv3d6l2u1dvotugofq/
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

=E5=9C=A8 2026-05-11=E4=B8=80=E7=9A=84 15:51 +0800=EF=BC=8CJoey Lu=E5=86=99=
=E9=81=93=EF=BC=9A
> Extend the verisilicon,dc base schema to accommodate the Nuvoton
> MA35D1
> DCUltra Lite (a previous generation of the DC8000 series) which has a
> different clock topology, no reset control, and a single output.
>=20
> - Replace the fixed clock/reset item lists with minItems/maxItems
> ranges
> =C2=A0 so sub-schemas can enforce variant-specific constraints
> - Add a 'port' property (single-port alias) alongside the existing
> 'ports'
> =C2=A0 for single-output variants
> - Remove the mandatory 'ports' requirement from the base schema; sub-
> schemas
> =C2=A0 shall enforce their own port topology
> - Add a 'select' stanza so the validator matches any node whose
> compatible
> =C2=A0 contains a known Verisilicon DC string, including SoC-specific glu=
e
> - Relax additionalProperties to allow unevaluatedProperties
> enforcement in
> =C2=A0 sub-schemas
> - Fix a minor whitespace issue in the port@0 description
>=20
> Add nuvoton,ma35d1-dcu.yaml as a sub-schema for the Nuvoton MA35D1
> DCUltra
> Lite display controller:
>=20
> The Nuvoton MA35D1 integrates the Verisilicon DCUltra Lite display
> controller. It is a single-output display controller with a 32-bit
> RGB (DPI) interface. Unlike the DC8000, it does not have discoverable
> chip identity registers, does not support the CONFIG_EX commit path,
> and uses dedicated IRQ status/enable registers at offsets
> 0x147C/0x1480.
> The clock topology uses two clocks (bus gate and pixel divider) and
> does not require explicit reset control from the driver.
>=20
> Signed-off-by: Joey Lu <a0987203069@gmail.com>
> ---
> =C2=A0.../bindings/display/nuvoton,ma35d1-dcu.yaml=C2=A0 | 94
> +++++++++++++++++++
> =C2=A0.../bindings/display/verisilicon,dc.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 64 +++++++------
> =C2=A02 files changed, 131 insertions(+), 27 deletions(-)
> =C2=A0create mode 100644
> Documentation/devicetree/bindings/display/nuvoton,ma35d1-dcu.yaml
>=20
> diff --git
> a/Documentation/devicetree/bindings/display/nuvoton,ma35d1-dcu.yaml
> b/Documentation/devicetree/bindings/display/nuvoton,ma35d1-dcu.yaml
> new file mode 100644
> index 000000000000..9279004ae27c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/nuvoton,ma35d1-
> dcu.yaml
> @@ -0,0 +1,94 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/nuvoton,ma35d1-dcu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton MA35D1 DCUltra Lite display controller
> +
> +maintainers:
> +=C2=A0 - Joey Lu <yclu4@nuvoton.com>
> +
> +description:
> +=C2=A0 The Nuvoton MA35D1 integrates the Verisilicon DCUltra Lite displa=
y
> +=C2=A0 controller. It is a single-output display controller with a 32-bi=
t
> +=C2=A0 RGB (DPI) interface.

You'd better write this in verisilicon,dc.yaml with if clauses. See
Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml for an
example for a generic IP with different integrations, and how it
constraints different SoC's integration.=20

> +
> +select:
> +=C2=A0 properties:
> +=C2=A0=C2=A0=C2=A0 compatible:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 contains:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - nuvoton,ma35d1-=
dcu
> +=C2=A0 required:
> +=C2=A0=C2=A0=C2=A0 - compatible
> +
> +allOf:
> +=C2=A0 - $ref: http://devicetree.org/schemas/display/verisilicon,dc.yaml=
#
> +
> +properties:
> +=C2=A0 compatible:
> +=C2=A0=C2=A0=C2=A0 const: nuvoton,ma35d1-dcu
> +
> +=C2=A0 reg:
> +=C2=A0=C2=A0=C2=A0 maxItems: 1
> +=C2=A0=C2=A0=C2=A0 description:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Register range of the DCUltra Lite contro=
ller. The address
> space
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 is 0x2000 bytes.

Is it really 0x2000 bytes? The next peripherals in the address space,
the GC520L 2D GPU, is 0x20000 bytes away from the start of DCU
registers space.

> +
> +=C2=A0 interrupts:
> +=C2=A0=C2=A0=C2=A0 maxItems: 1
> +
> +=C2=A0 clocks:
> +=C2=A0=C2=A0=C2=A0 items:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Bus clock that gates regis=
ter access (DCU_GATE)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Pixel clock divider for di=
splay timing
> (DCUP_DIV)
> +
> +=C2=A0 clock-names:
> +=C2=A0=C2=A0=C2=A0 items:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: core
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: pix0
> +
> +=C2=A0 resets:
> +=C2=A0=C2=A0=C2=A0 maxItems: 1
> +=C2=A0=C2=A0=C2=A0 description:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Optional reset for the display controller=
. The driver does not
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert or deassert this reset; it may be =
used by firmware or
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 boot loaders to bring the hardware to a c=
lean state.

Why is there a reset in hardware but not toggled in the software?

> +
> +=C2=A0 port:
> +=C2=A0=C2=A0=C2=A0 $ref: /schemas/graph.yaml#/properties/port
> +=C2=A0=C2=A0=C2=A0 description:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Output port to the downstream display dev=
ice (e.g. RGB panel).
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The DCUltra Lite supports a single parall=
el RGB output.
> +
> +required:
> +=C2=A0 - compatible
> +=C2=A0 - reg
> +=C2=A0 - interrupts
> +=C2=A0 - clocks
> +=C2=A0 - clock-names
> +=C2=A0 - port
> +
> +unevaluatedProperties: false
> +
> +examples:
> +=C2=A0 - |
> +=C2=A0=C2=A0=C2=A0 #include <dt-bindings/interrupt-controller/arm-gic.h>
> +=C2=A0=C2=A0=C2=A0 #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
> +=C2=A0=C2=A0=C2=A0 #include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
> +
> +=C2=A0=C2=A0=C2=A0 display@40260000 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "nuvoton,ma35d=
1-dcu";
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x40260000 0x2000>;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 interrupts =3D <GIC_SPI 20 IR=
Q_TYPE_LEVEL_HIGH>;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clocks =3D <&clk DCU_GATE>, <=
&clk DCUP_DIV>;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clock-names =3D "core", "pix0=
";
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 resets =3D <&sys MA35D1_RESET=
_DISP>;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 port {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dpi_o=
ut: endpoint {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 remote-endpoint =3D <&panel_in>;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> +=C2=A0=C2=A0=C2=A0 };
> diff --git
> a/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
> b/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
> index 9dc35ab973f2..00884529f8c1 100644
> --- a/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
> +++ b/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
> @@ -9,15 +9,34 @@ title: Verisilicon DC-series display controllers
> =C2=A0maintainers:
> =C2=A0=C2=A0 - Icenowy Zheng <uwu@icenowy.me>
> =C2=A0
> +description:
> +=C2=A0 Verisilicon DC-series display controllers.
> +
> +# Select any node whose compatible contains one of the known
> Verisilicon DC
> +# or DC-derived compatible strings, including SoC-specific glue
> variants.
> +select:
> +=C2=A0 properties:
> +=C2=A0=C2=A0=C2=A0 compatible:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 contains:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - verisilicon,dc
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - thead,th1520-dc=
8200
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - nuvoton,ma35d1-=
dcu
> +=C2=A0 required:
> +=C2=A0=C2=A0=C2=A0 - compatible
> +
> =C2=A0properties:
> =C2=A0=C2=A0 $nodename:
> =C2=A0=C2=A0=C2=A0=C2=A0 pattern: "^display@[0-9a-f]+$"
> =C2=A0
> =C2=A0=C2=A0 compatible:
> -=C2=A0=C2=A0=C2=A0 items:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - enum:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - thead,th1520-dc=
8200
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: verisilicon,dc # DC IPs have dis=
coverable ID/revision
> registers
> +=C2=A0=C2=A0=C2=A0 # Enumerated in full so the schema validator can veri=
fy any
> compatible
> +=C2=A0=C2=A0=C2=A0 # string against this list, including those from chil=
d schemas.
> +=C2=A0=C2=A0=C2=A0 contains:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - verisilicon,dc
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - thead,th1520-dc8200
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - nuvoton,ma35d1-dcu
> =C2=A0
> =C2=A0=C2=A0 reg:
> =C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 1
> @@ -26,32 +45,24 @@ properties:
> =C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 1
> =C2=A0
> =C2=A0=C2=A0 clocks:
> -=C2=A0=C2=A0=C2=A0 items:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: DC Core clock
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: DMA AXI bus clock
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Configuration AHB bus cloc=
k
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Pixel clock of output 0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Pixel clock of output 1
> +=C2=A0=C2=A0=C2=A0 minItems: 2
> +=C2=A0=C2=A0=C2=A0 maxItems: 5
> =C2=A0
> =C2=A0=C2=A0 clock-names:
> -=C2=A0=C2=A0=C2=A0 items:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: core
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: axi
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: ahb
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: pix0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: pix1
> +=C2=A0=C2=A0=C2=A0 minItems: 2
> +=C2=A0=C2=A0=C2=A0 maxItems: 5
> =C2=A0
> =C2=A0=C2=A0 resets:
> -=C2=A0=C2=A0=C2=A0 items:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: DC Core reset
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: DMA AXI bus reset
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Configuration AHB bus rese=
t
> +=C2=A0=C2=A0=C2=A0 minItems: 1
> +=C2=A0=C2=A0=C2=A0 maxItems: 3
> =C2=A0
> =C2=A0=C2=A0 reset-names:
> -=C2=A0=C2=A0=C2=A0 items:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: core
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: axi
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: ahb
> +=C2=A0=C2=A0=C2=A0 minItems: 1
> +=C2=A0=C2=A0=C2=A0 maxItems: 3
> +
> +=C2=A0 port:
> +=C2=A0=C2=A0=C2=A0 $ref: /schemas/graph.yaml#/properties/port
> +=C2=A0=C2=A0=C2=A0 description: Single video output port for single-outp=
ut
> variants.
> =C2=A0
> =C2=A0=C2=A0 ports:
> =C2=A0=C2=A0=C2=A0=C2=A0 $ref: /schemas/graph.yaml#/properties/ports
> @@ -59,7 +70,7 @@ properties:
> =C2=A0=C2=A0=C2=A0=C2=A0 properties:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 port@0:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $ref: /schemas/graph.yam=
l#/properties/port
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description: The first output=
 channel , endpoint 0 should be
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description: The first output=
 channel, endpoint 0 should be
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 used for DPI=
 format output and endpoint 1 should be used
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for DP forma=
t output.
> =C2=A0
> @@ -75,9 +86,8 @@ required:
> =C2=A0=C2=A0 - interrupts
> =C2=A0=C2=A0 - clocks
> =C2=A0=C2=A0 - clock-names
> -=C2=A0 - ports
> =C2=A0
> -additionalProperties: false
> +additionalProperties: true
> =C2=A0
> =C2=A0examples:
> =C2=A0=C2=A0 - |

