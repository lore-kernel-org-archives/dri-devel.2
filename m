Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C536CD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 09:05:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA9A010F3F5;
	Fri, 26 Jun 2026 09:05:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="ft3k6SDz";
	dkim-atps=neutral
X-Greylist: delayed 427 seconds by postgrey-1.36 at gabe;
 Fri, 26 Jun 2026 09:05:55 UTC
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95D5110F502
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 09:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1782464757; x=1814000757;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=gBAXAZAAK2FtxoDd2n15ZSuLuPQ6DYQX29tnPTf6I0A=;
 b=ft3k6SDzSUTi0vV5Lkp/1SdfWAwLAYJVbmHZi87Zs6WMsWDYR3dHV9I3
 XwMFiDWQTRm6HPOsyfJ1zGrZEX11nVkpg36pFgX5vGCeOArFUrJtLKcdN
 7QsVpNSvUQpyjSSd1hdx2krPd9cSyFDxJcJ8EirXiYFPiLs9u/41h2IpM
 WcTk429TBtOFESzumO+UOGXCMUA5lck37tkJhJezxI989U4AH7r/o0aTP
 FLbNV1vLcIfwI/1RUlH8/DowCo2WCJgc6iuL9hOWhfwuuN8igUHlTc6MA
 faWsWJCUjLKAQyx9FfmJgEXKG4GeFALC72y3tIDWgVv5tFb0P09oANTmi w==;
X-CSE-ConnectionGUID: IvWDA/V0S8+NXI2DA7OsIw==
X-CSE-MsgGUID: W/2gxdW/TaO6gXqF0Utz7A==
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
 d="asc'?scan'208";a="59724797"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 01:58:49 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Fri, 26 Jun 2026 01:58:47 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58 via Frontend
 Transport; Fri, 26 Jun 2026 01:58:43 -0700
Date: Fri, 26 Jun 2026 09:57:53 +0100
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
Message-ID: <20260626-agreement-express-b16c71315f7b@wendy>
References: <20260625094449.708386-1-a0987203069@gmail.com>
 <20260625094449.708386-2-a0987203069@gmail.com>
 <20260625-bobbing-annotate-d1c4d6874ee2@spud>
 <20260626-zit-amuck-e743e58d2e15@wendy>
 <84b93c496fabdeee05d2f962a1b764fdbfaacdb7.camel@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="oMGcdFhNmrqDF+5V"
Content-Disposition: inline
In-Reply-To: <84b93c496fabdeee05d2f962a1b764fdbfaacdb7.camel@iscas.ac.cn>
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

--oMGcdFhNmrqDF+5V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 03:58:14PM +0800, Icenowy Zheng wrote:
> =E5=9C=A8 2026-06-26=E4=BA=94=E7=9A=84 08:22 +0100=EF=BC=8CConor Dooley=
=E5=86=99=E9=81=93=EF=BC=9A
> > On Thu, Jun 25, 2026 at 05:33:37PM +0100, Conor Dooley wrote:
> > > On Thu, Jun 25, 2026 at 05:44:43PM +0800, Joey Lu wrote:
> > > > +
> > > > +=C2=A0 - if:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 contains:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 const: nuvoton,ma35d1-dcu
> > > > +=C2=A0=C2=A0=C2=A0 then:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clocks:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minItems: 2
> > >=20
> > > Anything that updates the minimum constraint should be done at the
> > > top
> > > level of this schema. The conditional section should then tighten
> > > the
> > > constraint, in this case that means only having maxItems.
> > >=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 2
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clock-names:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 - const: core
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 - const: pix0
> > >=20
> > > Does this even work when the top level schema thinks clock 2 should
> > > be
> > > called axi?
> >=20
> > Additionally here, only have core and pix0 seems like it might be an
> > oversimplification. I doubt removing the second output port means
> > that
> > the axi and ahb clocks are no longer needed.
> > Is it the case that your device supplies the same clock to core, ahb
> > and
> > axi? If so, then you should fill those clocks in in your devicetree
> > and
> > this can just constrain the number of clocks/clock-names to 4.
>=20
> The clock controller of that SoC is quite weird -- it has only a single
> gate bit, but controlling 3 clock gates. All core, ahb and axi clocks
> have gates controlled by this single bit, so it's why currently it's
> modelled as only core clock supplied.

Yeah, then what's in the binding is definitely wrong.
Even if the same clock was provided to all clock inputs in the IP, all
individual clock should be listed in the devicetree - although it will
look a little silly to see clocks =3D <&foo 2>, <&foo 2>, <&foo 2>, <&foo 2=
>;
In this case, 3 clocks controlled by 1 gate bit is an implementation detail
of the SoC's clocking hardware, and not relevant to how the dc instance
should be described.

> Well it might be worthful to supply the bus clock before the gate as
> ahb/axi, especially axi, because both the AXI clock and the core clock
> constraints the maximum pixel clock.

Right. And looking at patch 4/7, and the wording:
| The Nuvoton MA35D1 SoC integrates a DCUltraLite display controller whose
| AXI and AHB bus clocks share a single gate enable bit with the display
| core clock, so the clock driver does not expose them separately. This
| patch makes the axi and ahb clocks optional in the probe.

It sounds like there's probably some issues with how things are modelled
clock wise in this device, unless this is not an accurate statement and
there's actually one clock provided to all three inputs. If they're
distinct clocks, with different rates, only having one exposed has a lot
of potential to be problematic!

--oMGcdFhNmrqDF+5V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaj4/EQAKCRB4tDGHoIJi
0sgLAQDTZ355M4AEO2uZkBGTQ7oEMZkFXQdFbefyp5zI+AwZFgD9FvkomdGAUC4V
3G3h0sz6Ep5t2DWWrSj9oLBU7J3uQwo=
=jvWv
-----END PGP SIGNATURE-----

--oMGcdFhNmrqDF+5V--
