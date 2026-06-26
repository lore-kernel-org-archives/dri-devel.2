Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86580CD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:23:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A870A10F43C;
	Fri, 26 Jun 2026 07:23:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="SNganFz/";
	dkim-atps=neutral
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FAE710E315
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 07:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1782458609; x=1813994609;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=lYOOGzE7LwdgMGhlQH4i2dwWqqICBmMwCeAwhl5UGLA=;
 b=SNganFz/TVtSbwRwHKaaAqwEXogw5VfZx1IVCxZ/NMN4QYBgCVjyqYDF
 VdH8vhfORYZ4DE1pwOUlVRu6K/ndqP4JbgLgiQkpt4EFKwsCYNTSq7GmI
 0Y0ZpVuaCG6H6sx78ZMhqga9/50+CW/FrKCeNPeAWdmYePmL73pIUlbDK
 Tl8iU3ok6CxO1ofKlkgISnJADuW5uFcDtw/JgAhuFEm4jyeid8Buxi8Ma
 c3wl2RSkJNM2hqpp1QPMvMJLGOJeBrRp/caLjnpIDp7UFgcJMgmTBX+Sb
 ctmNSvburZf9pXKeXBNGYuxHpQ9RbwO6Dn22ppGzWlOQizlON+Y5YIjEu g==;
X-CSE-ConnectionGUID: YXc+Jpe1T8GT2zvd2E5JkQ==
X-CSE-MsgGUID: xAUdhOBNSdGhplnRPVZPqQ==
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
 d="asc'?scan'208";a="58876145"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 26 Jun 2026 00:23:28 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 26 Jun 2026 00:23:27 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58 via Frontend
 Transport; Fri, 26 Jun 2026 00:23:23 -0700
Date: Fri, 26 Jun 2026 08:22:33 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Conor Dooley <conor@kernel.org>
CC: Joey Lu <a0987203069@gmail.com>, <zhengxingda@iscas.ac.cn>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <ychuang3@nuvoton.com>, <schung@nuvoton.com>, <yclu4@nuvoton.com>,
 <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/7] dt-bindings: display: verisilicon,dc: generalize
 for single-output variants
Message-ID: <20260626-zit-amuck-e743e58d2e15@wendy>
References: <20260625094449.708386-1-a0987203069@gmail.com>
 <20260625094449.708386-2-a0987203069@gmail.com>
 <20260625-bobbing-annotate-d1c4d6874ee2@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zir5oJSkmyAXG85W"
Content-Disposition: inline
In-Reply-To: <20260625-bobbing-annotate-d1c4d6874ee2@spud>
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

--zir5oJSkmyAXG85W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 05:33:37PM +0100, Conor Dooley wrote:
> On Thu, Jun 25, 2026 at 05:44:43PM +0800, Joey Lu wrote:
> > The verisilicon,dc binding was originally written for the T-Head TH1520
> > SoC carrying a DC8200, and hard-codes five clocks, three resets and two
> > output ports.
> >=20
> > Add the Nuvoton MA35D1 DCUltraLite (nuvoton,ma35d1-dcu) to the binding.
> > The DCUltraLite uses only two clocks (core, pix0) and one reset (core),
> > with a single output port.
> >=20
> > Use allOf/if blocks to express per-variant constraints rather than
> > hard-coding the DC8200 topology at the top level.  Each compatible's
> > block constrains the clock and reset item counts; the nuvoton block
> > additionally overrides clock-names to the two names it actually uses.
> >=20
> > Signed-off-by: Joey Lu <a0987203069@gmail.com>
> > ---
> >  .../bindings/display/verisilicon,dc.yaml      | 57 +++++++++++++++++++
> >  1 file changed, 57 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/display/verisilicon,dc.y=
aml b/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
> > index 9dc35ab973f2..1e751f3c7ce8 100644
> > --- a/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
> > +++ b/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
> > @@ -17,6 +17,7 @@ properties:
> >      items:
> >        - enum:
> >            - thead,th1520-dc8200
> > +          - nuvoton,ma35d1-dcu
> >        - const: verisilicon,dc # DC IPs have discoverable ID/revision r=
egisters
> > =20
> >    reg:
> > @@ -77,6 +78,62 @@ required:
> >    - clock-names
> >    - ports
> > =20
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: thead,th1520-dc8200
> > +    then:
> > +      properties:
> > +        clocks:
> > +          minItems: 5
> > +          maxItems: 5
> > +
> > +        clock-names:
> > +          minItems: 5
> > +          maxItems: 5
>=20
> All the maxItems here repeat the maximum constraint and do nothing.
>=20
> Since you didn't change the minimum constraint at the top level, your
> minItems also do nothing.
>=20
> > +
> > +        resets:
> > +          minItems: 3
> > +          maxItems: 3
> > +
> > +        reset-names:
> > +          minItems: 3
> > +          maxItems: 3
> > +
> > +      required:
> > +        - resets
> > +        - reset-names
>=20
> Both conditional sections have this, but the original binding doesn't
> require these for the thead device. This is a functional change
> therefore and shouldn't be in a patch calling itself "generalise for
> single ended variants".
>=20
> FWIW, adding your new compatible shouldn't really be in a patch with
> that subject either, it really should say "add support for nuvoton
> ma35d1" or something.
>=20
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: nuvoton,ma35d1-dcu
> > +    then:
> > +      properties:
> > +        clocks:
> > +          minItems: 2
>=20
> Anything that updates the minimum constraint should be done at the top
> level of this schema. The conditional section should then tighten the
> constraint, in this case that means only having maxItems.
>=20
> > +          maxItems: 2
> > +
> > +        clock-names:
> > +          items:
> > +            - const: core
> > +            - const: pix0
>=20
> Does this even work when the top level schema thinks clock 2 should be
> called axi?

Additionally here, only have core and pix0 seems like it might be an
oversimplification. I doubt removing the second output port means that
the axi and ahb clocks are no longer needed.
Is it the case that your device supplies the same clock to core, ahb and
axi? If so, then you should fill those clocks in in your devicetree and
this can just constrain the number of clocks/clock-names to 4.

>=20
> > +
> > +        resets:
> > +          minItems: 1
> > +          maxItems: 1
> > +
> > +        reset-names:
> > +          items:
> > +            - const: core
>=20
> This is just maxItems: 1.
>=20
> pw-bot: changes-requested
>=20
> Thanks,
> Conor.
>=20
> > +
> > +      required:
> > +        - resets
> > +        - reset-names
> > +
> >  additionalProperties: false
> > =20
> >  examples:
> > --=20
> > 2.43.0
> >=20



--zir5oJSkmyAXG85W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaj4ouQAKCRB4tDGHoIJi
0gbuAP9YNrkk4sSHNNI/u1TL50xLKK0vVA2UxUnlFzZLo8p6BAEAyTBb18kN4Jsr
vttFNioIt2c8wadFCGvKcOjGHBz05g0=
=SCHK
-----END PGP SIGNATURE-----

--zir5oJSkmyAXG85W--
