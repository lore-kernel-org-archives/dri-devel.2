Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A74D5CD4F3D
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 04:07:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CFDA10E02F;
	Wed, 20 May 2026 04:07:16 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2981710E02F
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 04:07:14 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.100.115])
 by APP-03 (Coremail) with SMTP id rQCowABXddxrMw1q8pmgEQ--.8708S2;
 Wed, 20 May 2026 12:07:08 +0800 (CST)
Message-ID: <47a06094541da642cabcb6b7d2f92d5125d365ea.camel@iscas.ac.cn>
Subject: Re: [PATCH v2 1/4] dt-bindings: display: verisilicon, dc:
 generalize for single-output variants
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Joey Lu <a0987203069@gmail.com>, Conor Dooley <conor@kernel.org>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, 	airlied@gmail.com, simona@ffwll.ch, robh@kernel.org,
 krzk+dt@kernel.org, 	conor+dt@kernel.org, ychuang3@nuvoton.com,
 schung@nuvoton.com, yclu4@nuvoton.com, 	dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Date: Wed, 20 May 2026 12:07:06 +0800
In-Reply-To: <a112cb8b-21fb-4c33-89a3-14a4feb5e3f9@gmail.com>
References: <20260519055114.1886525-1-a0987203069@gmail.com>
 <20260519055114.1886525-2-a0987203069@gmail.com>
 <a66cc60fe163167e30e42f0b4be996cae1170a5e.camel@iscas.ac.cn>
 <20260519-fretful-blush-1aac18fa1360@spud>
 <a112cb8b-21fb-4c33-89a3-14a4feb5e3f9@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: rQCowABXddxrMw1q8pmgEQ--.8708S2
X-Coremail-Antispam: 1UD129KBjvAXoW3Zr45Wry5Aw4ruw1rXrykAFb_yoW8Jry8Jo
 W7Kr1fJr15Xr1UWryUJw4DGr13tw18JrnrtryUGry7Ar1Iy3WUA3y8AryUtay7Gr18GF1U
 J34UJ34UAFyUZF1fn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUYa7k0a2IF6w4kM7kC6x804xWl14x267AKxVW5JVWrJwAFc2x0
 x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj4
 1l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0
 I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
 C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
 MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
 4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
 67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
 x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
 z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
 UI43ZEXa7IUYsSdPUUUUU==
X-Originating-IP: [112.94.100.115]
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

=E5=9C=A8 2026-05-20=E4=B8=89=E7=9A=84 11:06 +0800=EF=BC=8CJoey Lu=E5=86=99=
=E9=81=93=EF=BC=9A
> On 5/20/2026 12:47 AM, Conor Dooley wrote:
> > On Tue, May 19, 2026 at 03:26:58PM +0800, Icenowy Zheng wrote:
> > > =E5=9C=A8 2026-05-19=E4=BA=8C=E7=9A=84 13:51 +0800=EF=BC=8CJoey Lu=E5=
=86=99=E9=81=93=EF=BC=9A
> > > > The existing schema assumes a fixed clock/reset topology and
> > > > dual-
> > > > output
> > > > port structure matching the DC8200 IP block.=C2=A0 This prevents
> > > > reuse for
> > > > single-output variants such as the Verisilicon DCU Lite used in
> > > > the
> > > > Nuvoton MA35D1 SoC.
> > > >=20
> > > > Rework the schema so that variant-specific constraints are
> > > > expressed
> > > > via allOf/if-then-else:
> > > >=20
> > > > - The thead,th1520-dc8200 compatible keeps its existing five-
> > > > clock,
> > > > =C2=A0=C2=A0 three-reset, dual-port requirements.
> > > >=20
> > > > - A standalone verisilicon,dc compatible covers IPs whose
> > > > identity is
> > > > =C2=A0=C2=A0 discovered entirely through hardware registers; these =
have
> > > > flexible
> > > > =C2=A0=C2=A0 clock and reset counts, a single 'port' property, and =
no
> > > > 'ports'
> > > > =C2=A0=C2=A0 requirement.
> > > >=20
> > > > Changes to the base schema:
> > > > - Replace the fixed clock/reset items lists with
> > > > minItems/maxItems
> > > > =C2=A0=C2=A0 ranges; variant sub-schemas tighten the constraints vi=
a if-
> > > > then-
> > > > else.
> > > > - Add a 'port' property (graph.yaml single-port alias)
> > > > alongside the
> > > > =C2=A0=C2=A0 existing 'ports', for single-output variants.
> > > > - Drop the unconditional 'ports' requirement; each if-branch
> > > > enforces
> > > > =C2=A0=C2=A0 its own port topology.
> > > > - Tighten additionalProperties to unevaluatedProperties to
> > > > allow
> > > > =C2=A0=C2=A0 per-variant schemas to add their own constraints clean=
ly.
> > > > - Fix a stray space in the port@0 description.
> > > > - Add a DT example for the generic verisilicon,dc compatible
> > > > =C2=A0=C2=A0 (Nuvoton MA35D1 DCU Lite).
> > > >=20
> > > > Signed-off-by: Joey Lu <a0987203069@gmail.com>
> > > > ---
> > > > =C2=A0=C2=A0.../bindings/display/verisilicon,dc.yaml=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 135
> > > > ++++++++++++++--
> > > > --
> > > > =C2=A0=C2=A01 file changed, 108 insertions(+), 27 deletions(-)
> > > >=20
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
> > > > b/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
> > > > index 9dc35ab973f2..3a814c2e083e 100644
> > > > ---
> > > > a/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
> > > > +++
> > > > b/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
> > > > @@ -14,10 +14,12 @@ properties:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pattern: "^display@[0-9a-f]+$"
> > > > =C2=A0=20
> > > > =C2=A0=C2=A0=C2=A0 compatible:
> > > > -=C2=A0=C2=A0=C2=A0 items:
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - enum:
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - thead,th1=
520-dc8200
> > > You should add a fallback compatible here for your SoC, in case
> > > its
> > > integration gets something quirky; this compatible is usually not
> > > consumed by the driver (see how thead,th1520-dc8200 exists in the
> > > binding but not the driver).
> > s/fallback compatible/soc-specific compatible/, but yes.
> > NAK to what's been done here, especially after the discussions on
> > earlier versions of this verisilicon binding.
> > pw-bot: changes-requested
> Understood. I will add `nuvoton,ma35d1-dcu` as the SoC-specific=20
> compatible string paired with `verisilicon,dc` as the generic
> fallback,=20
> matching the pattern used for `thead,th1520-dc8200`. The standalone=20
> `verisilicon,dc` compatible will be removed from the binding. The
> driver=20

No, please don't remove compatible strings from existing binding, and
the generic compatible is still used for driver binding.

The SoC-specific compatible is informative here, it needs to exist, but
it doesn't supersede "verisilicon,dc" .

In addition, the SoC-specific compatible is also used for verification
of the SoC device tree, which is the reason if clauses exist with
compatible match and additional constraints (e.g. for the nuvoton DCU
it's invalid to have a 2nd output port).

> match table is not changed since hardware detection is done via ID=20
> registers.
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: verisilicon,dc # DC IPs ha=
ve discoverable
> > > > ID/revision
> > > > registers
> > > > +=C2=A0=C2=A0=C2=A0 oneOf:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - items:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - enum:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 - thead,th1520-dc8200
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: ve=
risilicon,dc
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: verisilicon,dc=C2=A0 # DC =
IPs have discoverable
> > > > ID/revision registers
> > > > =C2=A0=20
> > > > =C2=A0=C2=A0=C2=A0 reg:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > > @@ -26,32 +28,24 @@ properties:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > > =C2=A0=20
> > > > =C2=A0=C2=A0=C2=A0 clocks:
> > > > -=C2=A0=C2=A0=C2=A0 items:
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: DC Core clock
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: DMA AXI bus clock
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Configuration AHB bu=
s clock
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Pixel clock of outpu=
t 0
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Pixel clock of outpu=
t 1
> > > > +=C2=A0=C2=A0=C2=A0 minItems: 2
> > > > +=C2=A0=C2=A0=C2=A0 maxItems: 5
> > > > =C2=A0=20
> > > > =C2=A0=C2=A0=C2=A0 clock-names:
> > > > -=C2=A0=C2=A0=C2=A0 items:
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: core
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: axi
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: ahb
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: pix0
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: pix1
> > > > +=C2=A0=C2=A0=C2=A0 minItems: 2
> > > > +=C2=A0=C2=A0=C2=A0 maxItems: 5
> > > > =C2=A0=20
> > > > =C2=A0=C2=A0=C2=A0 resets:
> > > > -=C2=A0=C2=A0=C2=A0 items:
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: DC Core reset
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: DMA AXI bus reset
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Configuration AHB bu=
s reset
> > > > +=C2=A0=C2=A0=C2=A0 minItems: 1
> > > > +=C2=A0=C2=A0=C2=A0 maxItems: 3
> > > > =C2=A0=20
> > > > =C2=A0=C2=A0=C2=A0 reset-names:
> > > > -=C2=A0=C2=A0=C2=A0 items:
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: core
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: axi
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: ahb
> > > > +=C2=A0=C2=A0=C2=A0 minItems: 1
> > > > +=C2=A0=C2=A0=C2=A0 maxItems: 3
> > > > +
> > > > +=C2=A0 port:
> > > > +=C2=A0=C2=A0=C2=A0 $ref: /schemas/graph.yaml#/properties/port
> > > > +=C2=A0=C2=A0=C2=A0 description: Single video output port for singl=
e-output
> > > > variants.
> > > Maybe the endpoint numbering rule needs a move to here? (I am not
> > > very
> > > sure).
> I will add a description to the `port` property noting that endpoint
> 0=20
> is used for DPI output, which is the only output type for
> DCUltraLite.

Please note that DC8000 exists, which is single-port but supports both
DPI and DP.

> > > > =C2=A0=20
> > > > =C2=A0=C2=A0=C2=A0 ports:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $ref: /schemas/graph.yaml#/propertie=
s/ports
> > > > @@ -59,7 +53,7 @@ properties:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 port@0:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $ref: /schem=
as/graph.yaml#/properties/port
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description: The first =
output channel , endpoint 0
> > > > should be
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description: The first =
output channel, endpoint 0
> > > > should be
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
used for DPI format output and endpoint 1 should be
> > > > used
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
for DP format output.
> > > > =C2=A0=20
> > > > @@ -75,9 +69,75 @@ required:
> > > > =C2=A0=C2=A0=C2=A0 - interrupts
> > > > =C2=A0=C2=A0=C2=A0 - clocks
> > > > =C2=A0=C2=A0=C2=A0 - clock-names
> > > > -=C2=A0 - ports
> > > > =C2=A0=20
> > > > -additionalProperties: false
> > > > +allOf:
> > > > +=C2=A0 - if:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 contains:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 const: thead,th1520-dc8200
> > > > +=C2=A0=C2=A0=C2=A0 then:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clocks:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 - description: DC Core clock
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 - description: DMA AXI bus clock
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 - description: Configuration AHB bus clock
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 - description: Pixel clock of output 0
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 - description: Pixel clock of output 1
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clock-names:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 - const: core
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 - const: axi
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 - const: ahb
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 - const: pix0
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 - const: pix1
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 resets:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 - description: DC Core reset
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 - description: DMA AXI bus reset
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 - description: Configuration AHB bus reset
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reset-names:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 - const: core
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 - const: axi
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 - const: ahb
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 required:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - ports
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0 else:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clocks:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 - description: Bus clock that gates register
> > > > access
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 - description: Pixel clock divider for display
> > > > timing
> > > Please don't make compatible-specific description strings for
> > > individual compatibles, and keep these descriptions outside of
> > > the if.
> > > The compatible-specific part should be used to specify what's
> > > required
> > > for the specific SoC, for dt validation purpose.
> > >=20
> > > BTW if the clock is both the working clock and bus clock for the
> > > controller, I suggest listing it twice, except if the IP core is
> > > provided without a dedicated core clock (in the case I suggest to
> > > use
> > > "bus" only).
> > I agree. If the same clock is provided to two+ ports on the IP,
> > that
> > should still be two+ clocks in the devicetree.
> >=20
> > > Here's an example for "listing it twice":
> > > ```
> > > clocks =3D <&clk DCU_GATE>, <&clk DCU_GATE>, <&clk DCUP_DIV>;
> > > clock-names =3D "core", "bus", "pix0";
> > > ```
> > >=20
> > > Well nonetheless the name "core" does not match the description
> > > "Bus
> > > clock that gates register access".
> > >=20
> > > Thanks,
> > > Icenowy
>=20
> Understood. I will remove all description strings from the if/else=20
> branches; the if/then clauses will only constrain clock-names and=20
> reset-names items (name values only, no descriptions). Regarding
> clock=20

Well I think a required properties list is also needed in the if/then
clause, to prevent DT's from lacking properties.

> naming: DCU_GATE on MA35D1 is a peripheral gate clock without a
> separate=20
> dedicated core working clock, so I will keep "core" as the name and

Do you mean there's no seperate dedicated bus clock? I find that in the
clock driver dcu_gate has no parent as bus clocks -- its parent is
dcu_mux, and dcu_mux's 2 parents are both pll ("epll_div2" and
"syspll").

Thanks,
Icenowy

> drop=20
> the misleading description "Bus clock that gates register access".
> The=20
> description mismatch was entirely in the if/else strings which are
> now=20
> removed.
>=20
> Thanks.
>=20
> > >=20
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clock-names:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 - const: core
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 - const: pix0
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 resets:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description=
:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 Reset line for the display controller.
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reset-names:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 - const: core
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 required:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - port
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 not:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 required:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - ports
> > > > +
> > > > +unevaluatedProperties: false
> > > > =C2=A0=20
> > > > =C2=A0=C2=A0examples:
> > > > =C2=A0=C2=A0=C2=A0 - |
> > > > @@ -120,3 +180,24 @@ examples:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > > > +
> > > > +=C2=A0 - |
> > > > +=C2=A0=C2=A0=C2=A0 #include <dt-bindings/interrupt-controller/arm-=
gic.h>
> > > > +=C2=A0=C2=A0=C2=A0 #include <dt-bindings/clock/nuvoton,ma35d1-clk.=
h>
> > > > +=C2=A0=C2=A0=C2=A0 #include <dt-bindings/reset/nuvoton,ma35d1-rese=
t.h>
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0 display@40260000 {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "verisil=
icon,dc";
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x40260000 0x2=
0000>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 interrupts =3D <GIC_SPI=
 20 IRQ_TYPE_LEVEL_HIGH>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clocks =3D <&clk DCU_GA=
TE>, <&clk DCUP_DIV>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clock-names =3D "core",=
 "pix0";
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 resets =3D <&sys MA35D1=
_RESET_DISP>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reset-names =3D "core";
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 port {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 dpi_out: endpoint {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 remote-endpoint =3D <&panel_in>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 };
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > > > +=C2=A0=C2=A0=C2=A0 };

