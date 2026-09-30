Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C862CA5FB1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:43:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A03410E8C2;
	Wed, 30 Sep 2026 10:43:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UyfPVZnz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BE1410E8C2
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 10:43:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B47EB60236;
 Wed, 30 Sep 2026 10:43:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D730A1F0089A;
 Wed, 30 Sep 2026 10:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790765003;
 bh=7yyzSOInAkUGRq5dHL3pz4TbnD3aTRaw+i+69ZVaw08=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=UyfPVZnzF+lD5Jp+7EFCb7CYkScPiVCdFblzNg5UF2sN19BrGW8kEdAE7MFLYRU8I
 aIT8oFXeDvdrWFPncK8LpYS1zlbLGOswJoX1wwr5242gNkAH8rFFpfghYSvSVZrV8s
 f8W30eA7lu1Mj6WOLPwYao2nxwFXHKCNOG+UcW7MjHa5kuKIfB2pSItfbtwD4p/elS
 PkoPxO3D4qviX4Sb9bIlMIVfeSz68wQiZJI4/d5Xn1A4BKUtAzg5BuSJ9Pain3QHND
 xrEeXT/PGrUUSI1DG+kO3P2PR+5Uc+0/yN7hju6H8UP/Ri7yVqKP7biUT/0it1kDmx
 nl9D8cJttopwQ==
Date: Wed, 30 Sep 2026 12:43:21 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v1 6/6] drm/panel: Add Hitachi TX10D07VM0BAA and LG
 LH400WV3-SD04 MIPI DBI panel driver
Message-ID: <arznE4HKl9r_mPX2@orome>
References: <20260930070535.47130-1-clamor95@gmail.com>
 <20260930070535.47130-7-clamor95@gmail.com>
 <arzNgbx465QIKYdX@orome>
 <CAPVz0n2QdSWL8=KBXnsQQkdNEJ9m6HSQ0+6mJji_RHZ8QgXN-g@mail.gmail.com>
 <arzilGz4akKvRF1K@orome>
 <CAPVz0n0-baCzHOXjWLOCLjv8fb5GbE9a2v=8tBYr3RgHkEu+qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="inabyhftcsvajn5l"
Content-Disposition: inline
In-Reply-To: <CAPVz0n0-baCzHOXjWLOCLjv8fb5GbE9a2v=8tBYr3RgHkEu+qg@mail.gmail.com>
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


--inabyhftcsvajn5l
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 6/6] drm/panel: Add Hitachi TX10D07VM0BAA and LG
 LH400WV3-SD04 MIPI DBI panel driver
MIME-Version: 1.0

On Wed, Sep 30, 2026 at 01:34:19PM +0300, Svyatoslav Ryhel wrote:
> =D1=81=D1=80, 30 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 13:23 Th=
ierry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Wed, Sep 30, 2026 at 12:08:41PM +0300, Svyatoslav Ryhel wrote:
> > > =D1=81=D1=80, 30 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 12:0=
2 Thierry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > > > On Wed, Sep 30, 2026 at 10:05:35AM +0300, Svyatoslav Ryhel wrote:
> > [...]
> > > > > +static const struct of_device_id panel_dbi_of_match[] =3D {
> > > > > +     { .compatible =3D "hit,tx10d07vm0baa", .data =3D (void *)PA=
NEL_DBI_TX10D07VM0BAA },
> > > > > +     { .compatible =3D "lg,lh400wv3-sd04", .data =3D (void *)PAN=
EL_DBI_LH400WV3 },
> > > >
> > > > Why the detour through that PANEL_DB_* enum? You could just pass the
> > > > panel funcs pointers directly via .data here.
> > > >
> > >
> > > Passing API/OPS via .data is discouraged.
> >
> > No it's not. We do it all the time.
> >
>=20
> I have had some controversial experience with MFD, with passing cell
> composition. If DRM subsystem allows this, I am more then happy to
> pass panel ops directly.
>=20
> > > > Also, looking at the enable/disable sequences these are in fact two
> > > > different drivers, with the only commonality being that they happen=
 to
> > > > be used in the same device. Rolling them both into one driver seems=
 a
> > > > bit odd.
> > >
> > > I did this to simplify maintainance. Both panels are used in the LG
> > > Optimus 2X. My assumption is that LG switched one to another at some
> > > point, hence they share same timings, controls and supplies, but
> > > differ in en/disable sequence. Additionally, these are the the only
> > > DBI Type B-only panels in the kernel, from what I can see.
> >
> > That's just one more reason to put them into more of a generic driver,
> > which would allow people to find it and extend/improve it as needed.
> >
>=20
> This driver cannot be "generic". Both panels don't fall into any
> category of being "generic". They are grouped solely cause they share
> same timings, controls and supplies (only these 2 panels, other will
> definitely differ) and are used in the same device. I have no problems
> in splitting them into 2 distinct drivers.

The driver can still be mostly generic. And I suspect that the panels
might have different names for the supplies and controls as well, they
just happen to match in schematics or sources that you used as reference
because they are for the same device.

My point is, you can keep a lot of boilerplate in a generic DBI driver
and then parameterize the things that aren't the same across them. That
gives you the best of both worlds.

The reason why I objected is that you have a very specific name for the
driver file and the second panel doesn't match that at all, so it's
confusing.

Thierry

--inabyhftcsvajn5l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmq858gACgkQ3SOs138+
s6HGhg/+JmLTUMGSPe575o/yuo3LDz+vlWdqi3tAABk0qwu0WkwJ6b2OX3HhmecD
4CixZaHzeRglHA3Qp5OIofMnSAqI+7Y2iPcLI+eKHvqaSbMBoNqaJ9poZb59OJ0t
YeKeQDC0w/mj1uRl5U2Lw06Rx32bF+JCmsztzwKAfm1uQF3kTwKfctHfVkf2UBlM
HVvux9gvrvKR3BYdVK1nx7gkqBXifwTTWyqLY5piAtcfF045P44PtPkpQKuJ7T49
2b1SLJ2o9JEN3Quf3F0FR0ZHu7mx0/+NXOpcl0XrntZ2MzPzkGAnCYZxEHxU9Yop
HJ+IDi8vcI/ETbX4j+l6JbEFTqa03S/xKubknmYBoQkXBWUj7G4+UWO9DnjHfoUb
Vk0KwJSA8SL/qz4+BsiYJ+Q7wvQ13OeKsYTVeUyfTc0YaY3IeRXI4/lqba783rtV
VdC5olXPhhVwMyLA6W9JbBkLV3du4Pxx+d32g9asdrXRT9n7sXwDiO0uTfNCfxUM
A42abW7eMYfKAY8sS/sokWMIFW920TFJOXMXPqXPepK0p0/6V8iFH5JtgWEG2OWj
GesX6c1knAuzGdvxU71W9I//rJzEyAXHq0MB0/ViDduX1i5Q0ARsSZNp105MunDf
bHTIOfRRp/T7Q/r+hydWkxQh4Ps6/1zYMGgq/wnfOAynLDkfak8=
=mzl7
-----END PGP SIGNATURE-----

--inabyhftcsvajn5l--
