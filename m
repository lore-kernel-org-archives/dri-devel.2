Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD35CCD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 16:47:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16A7A10E205;
	Tue, 19 May 2026 16:47:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WqAV1/vU";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 402C810E205
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 16:47:24 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 171CB444E9;
 Tue, 19 May 2026 16:47:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFFB4C2BCB3;
 Tue, 19 May 2026 16:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779209244;
 bh=wtsvs+5IaNBl2MEy4x4JHMc9B3fizNNrV8z58n7rl3Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WqAV1/vUS+qzidkcmOrFrxDBIjC1CilEtL+cxPm9lawvbyeBb6HyNrQVnHEOVcRO7
 rqgQak6iN7cLfYL7IZIagj2/u0KIgR8pWXqmX2aadlCeNI27TrvlcLk4uwY6HNF8Jg
 vYKFvr8xivTgaR0M/iebob0DyCqwwOdF90luF6xvRS3aWKbSBJK7w0AsOhfo9srFWY
 DwICPR6YaNW3MsUbVmqQvx23Oy7kN0gGBLIuiomaOMZd4XLflzdJNEt6S9dAVE2Yeq
 dSBmJJLNzhy2vi0Y/hd7hiMgNGFA3XpfycvSG6sSjvuyKyFVkm73C/a3Xoig6mh+RC
 6AmzOFJrfOffw==
Date: Tue, 19 May 2026 17:47:18 +0100
From: Conor Dooley <conor@kernel.org>
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: Joey Lu <a0987203069@gmail.com>, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, ychuang3@nuvoton.com, schung@nuvoton.com,
 yclu4@nuvoton.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: display: verisilicon, dc: generalize
 for  single-output variants
Message-ID: <20260519-fretful-blush-1aac18fa1360@spud>
References: <20260519055114.1886525-1-a0987203069@gmail.com>
 <20260519055114.1886525-2-a0987203069@gmail.com>
 <a66cc60fe163167e30e42f0b4be996cae1170a5e.camel@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="f26V0jFOIw6+Q/+q"
Content-Disposition: inline
In-Reply-To: <a66cc60fe163167e30e42f0b4be996cae1170a5e.camel@iscas.ac.cn>
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


--f26V0jFOIw6+Q/+q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 03:26:58PM +0800, Icenowy Zheng wrote:
> =E5=9C=A8 2026-05-19=E4=BA=8C=E7=9A=84 13:51 +0800=EF=BC=8CJoey Lu=E5=86=
=99=E9=81=93=EF=BC=9A
> > The existing schema assumes a fixed clock/reset topology and dual-
> > output
> > port structure matching the DC8200 IP block.=C2=A0 This prevents reuse =
for
> > single-output variants such as the Verisilicon DCU Lite used in the
> > Nuvoton MA35D1 SoC.
> >=20
> > Rework the schema so that variant-specific constraints are expressed
> > via allOf/if-then-else:
> >=20
> > - The thead,th1520-dc8200 compatible keeps its existing five-clock,
> > =C2=A0 three-reset, dual-port requirements.
> >=20
> > - A standalone verisilicon,dc compatible covers IPs whose identity is
> > =C2=A0 discovered entirely through hardware registers; these have flexi=
ble
> > =C2=A0 clock and reset counts, a single 'port' property, and no 'ports'
> > =C2=A0 requirement.
> >=20
> > Changes to the base schema:
> > - Replace the fixed clock/reset items lists with minItems/maxItems
> > =C2=A0 ranges; variant sub-schemas tighten the constraints via if-then-
> > else.
> > - Add a 'port' property (graph.yaml single-port alias) alongside the
> > =C2=A0 existing 'ports', for single-output variants.
> > - Drop the unconditional 'ports' requirement; each if-branch enforces
> > =C2=A0 its own port topology.
> > - Tighten additionalProperties to unevaluatedProperties to allow
> > =C2=A0 per-variant schemas to add their own constraints cleanly.
> > - Fix a stray space in the port@0 description.
> > - Add a DT example for the generic verisilicon,dc compatible
> > =C2=A0 (Nuvoton MA35D1 DCU Lite).
> >=20
> > Signed-off-by: Joey Lu <a0987203069@gmail.com>
> > ---
> > =C2=A0.../bindings/display/verisilicon,dc.yaml=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 135 ++++++++++++++--
> > --
> > =C2=A01 file changed, 108 insertions(+), 27 deletions(-)
> >=20
> > diff --git
> > a/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
> > b/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
> > index 9dc35ab973f2..3a814c2e083e 100644
> > --- a/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
> > +++ b/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
> > @@ -14,10 +14,12 @@ properties:
> > =C2=A0=C2=A0=C2=A0=C2=A0 pattern: "^display@[0-9a-f]+$"
> > =C2=A0
> > =C2=A0=C2=A0 compatible:
> > -=C2=A0=C2=A0=C2=A0 items:
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - enum:
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - thead,th1520-=
dc8200
>=20
> You should add a fallback compatible here for your SoC, in case its
> integration gets something quirky; this compatible is usually not
> consumed by the driver (see how thead,th1520-dc8200 exists in the
> binding but not the driver).

s/fallback compatible/soc-specific compatible/, but yes.
NAK to what's been done here, especially after the discussions on
earlier versions of this verisilicon binding.
pw-bot: changes-requested

>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: verisilicon,dc # DC IPs have d=
iscoverable ID/revision
> > registers
> > +=C2=A0=C2=A0=C2=A0 oneOf:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - items:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - enum:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 - thead,th1520-dc8200
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: verisi=
licon,dc
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: verisilicon,dc=C2=A0 # DC IPs =
have discoverable
> > ID/revision registers
> > =C2=A0
> > =C2=A0=C2=A0 reg:
> > =C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 1
> > @@ -26,32 +28,24 @@ properties:
> > =C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 1
> > =C2=A0
> > =C2=A0=C2=A0 clocks:
> > -=C2=A0=C2=A0=C2=A0 items:
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: DC Core clock
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: DMA AXI bus clock
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Configuration AHB bus cl=
ock
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Pixel clock of output 0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Pixel clock of output 1
> > +=C2=A0=C2=A0=C2=A0 minItems: 2
> > +=C2=A0=C2=A0=C2=A0 maxItems: 5
> > =C2=A0
> > =C2=A0=C2=A0 clock-names:
> > -=C2=A0=C2=A0=C2=A0 items:
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: core
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: axi
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: ahb
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: pix0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: pix1
> > +=C2=A0=C2=A0=C2=A0 minItems: 2
> > +=C2=A0=C2=A0=C2=A0 maxItems: 5
> > =C2=A0
> > =C2=A0=C2=A0 resets:
> > -=C2=A0=C2=A0=C2=A0 items:
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: DC Core reset
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: DMA AXI bus reset
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Configuration AHB bus re=
set
> > +=C2=A0=C2=A0=C2=A0 minItems: 1
> > +=C2=A0=C2=A0=C2=A0 maxItems: 3
> > =C2=A0
> > =C2=A0=C2=A0 reset-names:
> > -=C2=A0=C2=A0=C2=A0 items:
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: core
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: axi
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: ahb
> > +=C2=A0=C2=A0=C2=A0 minItems: 1
> > +=C2=A0=C2=A0=C2=A0 maxItems: 3
> > +
> > +=C2=A0 port:
> > +=C2=A0=C2=A0=C2=A0 $ref: /schemas/graph.yaml#/properties/port
> > +=C2=A0=C2=A0=C2=A0 description: Single video output port for single-ou=
tput
> > variants.
>=20
> Maybe the endpoint numbering rule needs a move to here? (I am not very
> sure).
>=20
> > =C2=A0
> > =C2=A0=C2=A0 ports:
> > =C2=A0=C2=A0=C2=A0=C2=A0 $ref: /schemas/graph.yaml#/properties/ports
> > @@ -59,7 +53,7 @@ properties:
> > =C2=A0=C2=A0=C2=A0=C2=A0 properties:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 port@0:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $ref: /schemas/graph.y=
aml#/properties/port
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description: The first outp=
ut channel , endpoint 0 should be
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description: The first outp=
ut channel, endpoint 0 should be
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 used for D=
PI format output and endpoint 1 should be used
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for DP for=
mat output.
> > =C2=A0
> > @@ -75,9 +69,75 @@ required:
> > =C2=A0=C2=A0 - interrupts
> > =C2=A0=C2=A0 - clocks
> > =C2=A0=C2=A0 - clock-names
> > -=C2=A0 - ports
> > =C2=A0
> > -additionalProperties: false
> > +allOf:
> > +=C2=A0 - if:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 contains:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 con=
st: thead,th1520-dc8200
> > +=C2=A0=C2=A0=C2=A0 then:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clocks:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - d=
escription: DC Core clock
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - d=
escription: DMA AXI bus clock
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - d=
escription: Configuration AHB bus clock
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - d=
escription: Pixel clock of output 0
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - d=
escription: Pixel clock of output 1
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clock-names:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - c=
onst: core
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - c=
onst: axi
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - c=
onst: ahb
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - c=
onst: pix0
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - c=
onst: pix1
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 resets:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - d=
escription: DC Core reset
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - d=
escription: DMA AXI bus reset
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - d=
escription: Configuration AHB bus reset
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reset-names:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - c=
onst: core
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - c=
onst: axi
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - c=
onst: ahb
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 required:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - ports
> > +
> > +=C2=A0=C2=A0=C2=A0 else:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clocks:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - d=
escription: Bus clock that gates register access
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - d=
escription: Pixel clock divider for display timing
>=20
> Please don't make compatible-specific description strings for
> individual compatibles, and keep these descriptions outside of the if.
> The compatible-specific part should be used to specify what's required
> for the specific SoC, for dt validation purpose.
>=20
> BTW if the clock is both the working clock and bus clock for the
> controller, I suggest listing it twice, except if the IP core is
> provided without a dedicated core clock (in the case I suggest to use
> "bus" only).

I agree. If the same clock is provided to two+ ports on the IP, that
should still be two+ clocks in the devicetree.

>=20
> Here's an example for "listing it twice":
> ```
> clocks =3D <&clk DCU_GATE>, <&clk DCU_GATE>, <&clk DCUP_DIV>;
> clock-names =3D "core", "bus", "pix0";
> ```
>=20
> Well nonetheless the name "core" does not match the description "Bus
> clock that gates register access".
>=20
> Thanks,
> Icenowy
>=20
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clock-names:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - c=
onst: core
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - c=
onst: pix0
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 resets:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 1
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Res=
et line for the display controller.
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reset-names:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - c=
onst: core
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 required:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - port
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 not:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 required:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - ports
> > +
> > +unevaluatedProperties: false
> > =C2=A0
> > =C2=A0examples:
> > =C2=A0=C2=A0 - |
> > @@ -120,3 +180,24 @@ examples:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > =C2=A0=C2=A0=C2=A0=C2=A0 };
> > +
> > +=C2=A0 - |
> > +=C2=A0=C2=A0=C2=A0 #include <dt-bindings/interrupt-controller/arm-gic.=
h>
> > +=C2=A0=C2=A0=C2=A0 #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
> > +=C2=A0=C2=A0=C2=A0 #include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
> > +
> > +=C2=A0=C2=A0=C2=A0 display@40260000 {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "verisilicon=
,dc";
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x40260000 0x20000=
>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 interrupts =3D <GIC_SPI 20 =
IRQ_TYPE_LEVEL_HIGH>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clocks =3D <&clk DCU_GATE>,=
 <&clk DCUP_DIV>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clock-names =3D "core", "pi=
x0";
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 resets =3D <&sys MA35D1_RES=
ET_DISP>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reset-names =3D "core";
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 port {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dpi=
_out: endpoint {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 remote-endpoint =3D <&panel_in>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > +=C2=A0=C2=A0=C2=A0 };

--f26V0jFOIw6+Q/+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCagyUFgAKCRB4tDGHoIJi
0sbiAPwJC8osMDE74fZTkyhgPXzZeXZJdccgsP75N5NjzLdv5wEAgd75XJxx7BeV
SgKcLb/YWHbIxZ+4xA0QzhhyhYQfTAI=
=e1q6
-----END PGP SIGNATURE-----

--f26V0jFOIw6+Q/+q--
