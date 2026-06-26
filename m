Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DEF7CD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 09:27:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F6D810E327;
	Fri, 26 Jun 2026 09:27:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="jthrdQl5";
	dkim-atps=neutral
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECAF810E327
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 09:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1782466032; x=1814002032;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Wkt3ar6iPUbFcYacgPNJpIHFcNav7UI8z4kHnwZokzk=;
 b=jthrdQl5yNZgAaRunu8EsTsSAM5pTjp3ZTLbXpLoNwhR5OqFokTkBSRg
 4BCSDfVDSc7KdjBN/IZt7R+qVKUQ9+DzP7hjuEEPIV5+qQEpDe2XvK/x9
 EoKG6uFKLJxeisaT7dHMSnZS6JNfpNIwfv3yd1FCgK9eJIuAIHEktjUQY
 JXsAAEIleHdSDpcFur0PBhUSHrQLuerdHBn1k4l9yN827/MZHSWOH2n+L
 yodXy/0Nt1nhrwrKmP3xLmoUDKjY+JJD0rUxu7C+N6JlpZOQjaVq3+Puo
 LkQXs+sLxzIjwVoX5opcRGmED30U31ClDxOWKvLPg2/30eSEb/7oA1X6a A==;
X-CSE-ConnectionGUID: YBF2Gm23RaCAopAUoC2ytw==
X-CSE-MsgGUID: oIg1nReOT0iGvs4oFRTaTw==
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
 d="asc'?scan'208";a="291102737"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 02:27:11 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Fri, 26 Jun 2026 02:27:10 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58 via Frontend
 Transport; Fri, 26 Jun 2026 02:27:07 -0700
Date: Fri, 26 Jun 2026 10:26:16 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>
CC: Conor Dooley <conor@kernel.org>, Joey Lu <a0987203069@gmail.com>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <ychuang3@nuvoton.com>, <schung@nuvoton.com>, <yclu4@nuvoton.com>,
 <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/7] dt-bindings: display: verisilicon,dc: generalize
 for single-output variants
Message-ID: <20260626-everybody-epilogue-8fb298a54981@wendy>
References: <20260625094449.708386-1-a0987203069@gmail.com>
 <20260625094449.708386-2-a0987203069@gmail.com>
 <20260625-bobbing-annotate-d1c4d6874ee2@spud>
 <e3fe23ddbc504879bd797bbaa595d3653fa139ff.camel@iscas.ac.cn>
 <20260626-astrology-mural-853d3860e048@wendy>
 <c0731801729713d35f97bec40ebc21cef31b72b5.camel@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="r8rF78kmCgnz4y87"
Content-Disposition: inline
In-Reply-To: <c0731801729713d35f97bec40ebc21cef31b72b5.camel@iscas.ac.cn>
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

--r8rF78kmCgnz4y87
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 05:00:35PM +0800, Icenowy Zheng wrote:
> =E5=9C=A8 2026-06-26=E4=BA=94=E7=9A=84 08:19 +0100=EF=BC=8CConor Dooley=
=E5=86=99=E9=81=93=EF=BC=9A
> > On Fri, Jun 26, 2026 at 01:27:21PM +0800, Icenowy Zheng wrote:
> > > =E5=9C=A8 2026-06-25=E5=9B=9B=E7=9A=84 17:33 +0100=EF=BC=8CConor Dool=
ey=E5=86=99=E9=81=93=EF=BC=9A
> > > > On Thu, Jun 25, 2026 at 05:44:43PM +0800, Joey Lu wrote:
> > > > > +allOf:
> > > > > +=C2=A0 - if:
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible:
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 contains:
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 const: thead,th1520-dc8200
> > > > > +=C2=A0=C2=A0=C2=A0 then:
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clocks:
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minItems:=
 5
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maxItems:=
 5
> > > > > +
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clock-names:
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minItems:=
 5
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maxItems:=
 5
> > > >=20
> > > > All the maxItems here repeat the maximum constraint and do
> > > > nothing.
> > > >=20
> > > > Since you didn't change the minimum constraint at the top level,
> > > > your
> > > > minItems also do nothing.
> > > >=20
> > > > > +
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 resets:
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minItems:=
 3
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maxItems:=
 3
> > > > > +
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reset-names:
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minItems:=
 3
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maxItems:=
 3
> > > > > +
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 required:
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - resets
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - reset-names
> > > >=20
> > > > Both conditional sections have this, but the original binding
> > > > doesn't
> > > > require these for the thead device. This is a functional change
> > > > therefore and shouldn't be in a patch calling itself "generalise
> > > > for
> > > > single ended variants".
> > >=20
> > > Well yes they're required.
> > >=20
> > > Should I send a patch adding the `thead,th1520-dc8200` part of the
> > > schema?
> >=20
> > If you mean the code above, no. Adding a conditional section when
> > there's only that compatible doesn't make sense.
> >=20
> > What you could do is just add it at the top level though, which would
> > also benefit this patch since it'd not have to be conditionally added
> > for the new nuvoton device.
> > Just note in your commit message about what the ABI impact of the
> > change
> > to required properties is (effectively nothing because it's optional
> > in
> > the driver and the only user has the properties).
>=20
> Okay, I will craft such a patch and send it.
>=20
> >=20
> > > > > +
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 resets:
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minItems:=
 1
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maxItems:=
 1
> > > > > +
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reset-names:
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 - const: core
> > > >=20
> > > > This is just maxItems: 1.
> > >=20
> > > Well the implicit rules of DT binding schemas are quite weird...
> >=20
> > I don't think it is that strange, as the binding has
> > =C2=A0 reset-names:
> > =C2=A0=C2=A0=C2=A0 items:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: core
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: axi
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: ahb
>=20
> Ah does the list constraint the order of items? If it constrains the

It does, yes.
Alternatively, using an enum permits free ordering.

> order, it partly breaks the intention of having names; if it does not
> constrain the order, it needs to be clarified that the required 1 reset
> is core instead of the other two.

Given the discussion we're having on the clocks, I wonder if this is
also an oversimplification and the IP has three resets inputs hooked up
to one output of the reset controller (or 3 outputs controlled by one
bit..).

--r8rF78kmCgnz4y87
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaj5FuAAKCRB4tDGHoIJi
0sUHAQC+jTasbIiodz+h8pTi1hrZwttHaW1rwv2+JI+IilqgIgD+LU/w2PQybkmB
IYTfrIxpqApp9H5myhsNrMD3QJIRRgE=
=OJVD
-----END PGP SIGNATURE-----

--r8rF78kmCgnz4y87--
