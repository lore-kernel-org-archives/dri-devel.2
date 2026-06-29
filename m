Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C47C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 05:31:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E936F10E055;
	Mon, 29 Jun 2026 05:31:54 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2269010E055
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 05:31:51 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.101.182])
 by APP-05 (Coremail) with SMTP id zQCowABXrdBCA0JqknDpFQ--.43857S2;
 Mon, 29 Jun 2026 13:31:47 +0800 (CST)
Message-ID: <80ae28925a67b7bee3b8873db3c113111437e717.camel@iscas.ac.cn>
Subject: Re: [PATCH v5 1/7] dt-bindings: display: verisilicon,dc: generalize
 for single-output variants
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Joey Lu <a0987203069@gmail.com>, Conor Dooley <conor.dooley@microchip.com>
Cc: Conor Dooley <conor@kernel.org>, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, 	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ychuang3@nuvoton.com, 	schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, 	devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, 	linux-kernel@vger.kernel.org
Date: Mon, 29 Jun 2026 13:31:46 +0800
In-Reply-To: <b3b7a0f8-93a8-4965-a2f3-3ca1552a25d6@gmail.com>
References: <20260625094449.708386-1-a0987203069@gmail.com>
 <20260625094449.708386-2-a0987203069@gmail.com>
 <20260625-bobbing-annotate-d1c4d6874ee2@spud>
 <e3fe23ddbc504879bd797bbaa595d3653fa139ff.camel@iscas.ac.cn>
 <20260626-astrology-mural-853d3860e048@wendy>
 <c0731801729713d35f97bec40ebc21cef31b72b5.camel@iscas.ac.cn>
 <20260626-everybody-epilogue-8fb298a54981@wendy>
 <9456bde5059bea3aac1ed64355e3f017dd9bd3e5.camel@iscas.ac.cn>
 <b3b7a0f8-93a8-4965-a2f3-3ca1552a25d6@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: zQCowABXrdBCA0JqknDpFQ--.43857S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtFyUXFy8tr4UXr1fKw47twb_yoWxXFy3pF
 ykJFW5JFWkJr1rtr1Utw18JFy2yw1UJw1UXr1kXF17JF4qqF1jgr1jgr1q9Fy8Xr4xGr1j
 qr4jqry7Zr15AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvvb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
 8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
 64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
 Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
 c7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
 1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
 14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
 IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
 87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
 IFyTuYvjxUkX_TUUUUU
X-Originating-IP: [112.94.101.182]
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

=E5=9C=A8 2026-06-29=E4=B8=80=E7=9A=84 11:47 +0800=EF=BC=8CJoey Lu=E5=86=99=
=E9=81=93=EF=BC=9A
>=20
> On 6/26/2026 5:33 PM, Icenowy Zheng wrote:
> > =E5=9C=A8 2026-06-26=E4=BA=94=E7=9A=84 10:26 +0100=EF=BC=8CConor Dooley=
=E5=86=99=E9=81=93=EF=BC=9A
> > > On Fri, Jun 26, 2026 at 05:00:35PM +0800, Icenowy Zheng wrote:
> > > > =E5=9C=A8 2026-06-26=E4=BA=94=E7=9A=84 08:19 +0100=EF=BC=8CConor Do=
oley=E5=86=99=E9=81=93=EF=BC=9A
> > > > > On Fri, Jun 26, 2026 at 01:27:21PM +0800, Icenowy Zheng
> > > > > wrote:
> > > > > > =E5=9C=A8 2026-06-25=E5=9B=9B=E7=9A=84 17:33 +0100=EF=BC=8CCono=
r Dooley=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > > On Thu, Jun 25, 2026 at 05:44:43PM +0800, Joey Lu wrote:
> > > > > > > > +allOf:
> > > > > > > > +=C2=A0 - if:
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible:
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 con=
tains:
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 const: thead,th1520-dc8200
> > > > > > > > +=C2=A0=C2=A0=C2=A0 then:
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clocks:
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 min=
Items: 5
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 max=
Items: 5
> > > > > > > > +
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clock-names:
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 min=
Items: 5
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 max=
Items: 5
> > > > > > > All the maxItems here repeat the maximum constraint and
> > > > > > > do
> > > > > > > nothing.
> > > > > > >=20
> > > > > > > Since you didn't change the minimum constraint at the top
> > > > > > > level,
> > > > > > > your
> > > > > > > minItems also do nothing.
> > > > > > >=20
> > > > > > > > +
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 resets:
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 min=
Items: 3
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 max=
Items: 3
> > > > > > > > +
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reset-names:
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 min=
Items: 3
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 max=
Items: 3
> > > > > > > > +
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 required:
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - resets
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - reset-names
> > > > > > > Both conditional sections have this, but the original
> > > > > > > binding
> > > > > > > doesn't
> > > > > > > require these for the thead device. This is a functional
> > > > > > > change
> > > > > > > therefore and shouldn't be in a patch calling itself
> > > > > > > "generalise
> > > > > > > for
> > > > > > > single ended variants".
> > > > > > Well yes they're required.
> > > > > >=20
> > > > > > Should I send a patch adding the `thead,th1520-dc8200` part
> > > > > > of
> > > > > > the
> > > > > > schema?
> > > > > If you mean the code above, no. Adding a conditional section
> > > > > when
> > > > > there's only that compatible doesn't make sense.
> > > > >=20
> > > > > What you could do is just add it at the top level though,
> > > > > which
> > > > > would
> > > > > also benefit this patch since it'd not have to be
> > > > > conditionally
> > > > > added
> > > > > for the new nuvoton device.
> > > > > Just note in your commit message about what the ABI impact of
> > > > > the
> > > > > change
> > > > > to required properties is (effectively nothing because it's
> > > > > optional
> > > > > in
> > > > > the driver and the only user has the properties).
> > > > Okay, I will craft such a patch and send it.
> > > >=20
> > > > > > > > +
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 resets:
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 min=
Items: 1
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 max=
Items: 1
> > > > > > > > +
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reset-names:
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ite=
ms:
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 - const: core
> > > > > > > This is just maxItems: 1.
> > > > > > Well the implicit rules of DT binding schemas are quite
> > > > > > weird...
> > > > > I don't think it is that strange, as the binding has
> > > > > =C2=A0=C2=A0 reset-names:
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 items:
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: core
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: axi
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: ahb
> > > > Ah does the list constraint the order of items? If it
> > > > constrains
> > > > the
> > > It does, yes.
> > > Alternatively, using an enum permits free ordering.
> > Ah in this case this should be converted to an enum, I think.
> >=20
> > Should I send a patch for converting it?
> >=20
> > Thanks,
> > Icenowy
> Thank you all for the detailed review and discussion, it really
> helped
> clarify the right approach.
>=20
> Since I will supply all four clocks with the same phandle for
> core/axi/ahb,
> and only one reset "core" for MA35D1, the ordering constraint in the
> `items` list is not a problem, "core" is already the first entry.
> There
> is no need to convert to an enum.
>=20
> Regarding the clock situation for the MA35D1: I agree with supplying
> all
> four clocks (core, axi, ahb, pix0) in the devicetree, even though the
> MA35D1 clock controller gates core/axi/ahb with a single bit. The DT
> will
> use the same clock phandle for core, axi, and ahb:
>=20
> =C2=A0=C2=A0 clocks =3D <&clk X>, <&clk X>, <&clk X>, <&pix_clk Y>;
> =C2=A0=C2=A0 clock-names =3D "core", "axi", "ahb", "pix0";
>=20
> This correctly models the hardware topology. Since all three names

No, this doesn't correctly model the hardware topology -- this will
lead to clk_get_rate() return the rate of DC core clock when checking
the AXI clock rate, which is problematic because both clocks are
limiting the performance of the DC.

> resolve
> to the same underlying clock node, the CCF's standard enable
> refcounting
> handles the shared gate correctly without any custom implementation
> needed.
> I will also revert the change in patch 4/7 that made axi and ahb
> clocks
> optional, since they will now always be provided in the devicetree.
>=20
> Regarding moving `resets` and `reset-names` to the top-level
> `required:`,
> I will wait for Icenowy's patch to land before sending v6 to avoid
> duplicating the work.

The patch is sent.

>=20
> In v6 I will update patch 1/7 with:
> - Update the subject to "dt-bindings: display: verisilicon,dc: add
> =C2=A0=C2=A0 support for nuvoton,ma35d1-dcu"
> - Lower `clocks`/`clock-names` `minItems` to 4 at the top level
> - Remove the `thead,th1520-dc8200` conditional block entirely

I think this conditional block will still be needed, because it will
need to constrain the minItems to ensure all clocks / resets are
populated.

Thanks,
Icenowy

> - Keep only the `nuvoton,ma35d1-dcu` conditional block, using only
> =C2=A0=C2=A0 `maxItems: 4` for clocks/clock-names and `maxItems: 1` for
> =C2=A0=C2=A0 resets/reset-names to tighten the top-level constraints
>=20
> BR,
> Joey
> > > > order, it partly breaks the intention of having names; if it
> > > > does
> > > > not
> > > > constrain the order, it needs to be clarified that the required
> > > > 1
> > > > reset
> > > > is core instead of the other two.
> > > Given the discussion we're having on the clocks, I wonder if this
> > > is
> > > also an oversimplification and the IP has three resets inputs
> > > hooked
> > > up
> > > to one output of the reset controller (or 3 outputs controlled by
> > > one
> > > bit..).

