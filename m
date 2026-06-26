Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92836CDE008
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:58:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03C3C10F4BA;
	Fri, 26 Jun 2026 07:58:23 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F119810F4BA
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 07:58:20 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.101.182])
 by APP-03 (Coremail) with SMTP id rQCowADXwagWMT5qnInoFQ--.17195S2;
 Fri, 26 Jun 2026 15:58:15 +0800 (CST)
Message-ID: <84b93c496fabdeee05d2f962a1b764fdbfaacdb7.camel@iscas.ac.cn>
Subject: Re: [PATCH v5 1/7] dt-bindings: display: verisilicon,dc: generalize
 for single-output variants
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Conor Dooley <conor.dooley@microchip.com>, Conor Dooley <conor@kernel.org>
Cc: Joey Lu <a0987203069@gmail.com>, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, 	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ychuang3@nuvoton.com, 	schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, 	devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, 	linux-kernel@vger.kernel.org
Date: Fri, 26 Jun 2026 15:58:14 +0800
In-Reply-To: <20260626-zit-amuck-e743e58d2e15@wendy>
References: <20260625094449.708386-1-a0987203069@gmail.com>
 <20260625094449.708386-2-a0987203069@gmail.com>
 <20260625-bobbing-annotate-d1c4d6874ee2@spud>
 <20260626-zit-amuck-e743e58d2e15@wendy>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: rQCowADXwagWMT5qnInoFQ--.17195S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XFW8ur13trWfCryrtry7ZFb_yoW7Aw18pF
 WkAFWUJr95Jrn5Jr1UKr1UJFyjyw1kJ3WDJr1xXFyxAFsrAr12gr4jgr1qgFy7Xr48Jr1j
 qr4jqr9xZr1ayFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvvb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
 8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
 64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
 Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
 c7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
 1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
 14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
 IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
 87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
 IFyTuYvjxUvaZXDUUUU
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

=E5=9C=A8 2026-06-26=E4=BA=94=E7=9A=84 08:22 +0100=EF=BC=8CConor Dooley=E5=
=86=99=E9=81=93=EF=BC=9A
> On Thu, Jun 25, 2026 at 05:33:37PM +0100, Conor Dooley wrote:
> > On Thu, Jun 25, 2026 at 05:44:43PM +0800, Joey Lu wrote:
> > > The verisilicon,dc binding was originally written for the T-Head
> > > TH1520
> > > SoC carrying a DC8200, and hard-codes five clocks, three resets
> > > and two
> > > output ports.
> > >=20
> > > Add the Nuvoton MA35D1 DCUltraLite (nuvoton,ma35d1-dcu) to the
> > > binding.
> > > The DCUltraLite uses only two clocks (core, pix0) and one reset
> > > (core),
> > > with a single output port.
> > >=20
> > > Use allOf/if blocks to express per-variant constraints rather
> > > than
> > > hard-coding the DC8200 topology at the top level.=C2=A0 Each
> > > compatible's
> > > block constrains the clock and reset item counts; the nuvoton
> > > block
> > > additionally overrides clock-names to the two names it actually
> > > uses.
> > >=20
> > > Signed-off-by: Joey Lu <a0987203069@gmail.com>
> > > ---
> > > =C2=A0.../bindings/display/verisilicon,dc.yaml=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 57
> > > +++++++++++++++++++
> > > =C2=A01 file changed, 57 insertions(+)
> > >=20
> > > diff --git
> > > a/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
> > > b/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
> > > index 9dc35ab973f2..1e751f3c7ce8 100644
> > > ---
> > > a/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
> > > +++
> > > b/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
> > > @@ -17,6 +17,7 @@ properties:
> > > =C2=A0=C2=A0=C2=A0=C2=A0 items:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - enum:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - thead,=
th1520-dc8200
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - nuvoton,ma3=
5d1-dcu
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: verisilicon,dc # DC IPs=
 have discoverable
> > > ID/revision registers
> > > =C2=A0
> > > =C2=A0=C2=A0 reg:
> > > @@ -77,6 +78,62 @@ required:
> > > =C2=A0=C2=A0 - clock-names
> > > =C2=A0=C2=A0 - ports
> > > =C2=A0
> > > +allOf:
> > > +=C2=A0 - if:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 contains:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
onst: thead,th1520-dc8200
> > > +=C2=A0=C2=A0=C2=A0 then:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clocks:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minItems: 5
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 5
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clock-names:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minItems: 5
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 5
> >=20
> > All the maxItems here repeat the maximum constraint and do nothing.
> >=20
> > Since you didn't change the minimum constraint at the top level,
> > your
> > minItems also do nothing.
> >=20
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 resets:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minItems: 3
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 3
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reset-names:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minItems: 3
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 3
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 required:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - resets
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - reset-names
> >=20
> > Both conditional sections have this, but the original binding
> > doesn't
> > require these for the thead device. This is a functional change
> > therefore and shouldn't be in a patch calling itself "generalise
> > for
> > single ended variants".
> >=20
> > FWIW, adding your new compatible shouldn't really be in a patch
> > with
> > that subject either, it really should say "add support for nuvoton
> > ma35d1" or something.
> >=20
> > > +
> > > +=C2=A0 - if:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 contains:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
onst: nuvoton,ma35d1-dcu
> > > +=C2=A0=C2=A0=C2=A0 then:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clocks:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minItems: 2
> >=20
> > Anything that updates the minimum constraint should be done at the
> > top
> > level of this schema. The conditional section should then tighten
> > the
> > constraint, in this case that means only having maxItems.
> >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 2
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clock-names:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=
 const: core
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=
 const: pix0
> >=20
> > Does this even work when the top level schema thinks clock 2 should
> > be
> > called axi?
>=20
> Additionally here, only have core and pix0 seems like it might be an
> oversimplification. I doubt removing the second output port means
> that
> the axi and ahb clocks are no longer needed.
> Is it the case that your device supplies the same clock to core, ahb
> and
> axi? If so, then you should fill those clocks in in your devicetree
> and
> this can just constrain the number of clocks/clock-names to 4.

The clock controller of that SoC is quite weird -- it has only a single
gate bit, but controlling 3 clock gates. All core, ahb and axi clocks
have gates controlled by this single bit, so it's why currently it's
modelled as only core clock supplied.

Well it might be worthful to supply the bus clock before the gate as
ahb/axi, especially axi, because both the AXI clock and the core clock
constraints the maximum pixel clock.

Thanks,
Icenowy

>=20
> >=20
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 resets:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minItems: 1
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reset-names:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=
 const: core
> >=20
> > This is just maxItems: 1.
> >=20
> > pw-bot: changes-requested
> >=20
> > Thanks,
> > Conor.
> >=20
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 required:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - resets
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - reset-names
> > > +
> > > =C2=A0additionalProperties: false
> > > =C2=A0
> > > =C2=A0examples:
> > > --=20
> > > 2.43.0
> > >=20
>=20

