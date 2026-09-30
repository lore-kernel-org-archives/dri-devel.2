Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2AECA5FBA
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:58:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0385010F01D;
	Wed, 30 Sep 2026 10:58:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jRK1yGoH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DBFB10F01D
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 10:58:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CB86843A8B;
 Wed, 30 Sep 2026 10:58:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A931F000FF;
 Wed, 30 Sep 2026 10:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790765910;
 bh=pxhYZCRtMlW/teM6HS7EhHEc9imdgRYDA4FlDdsFq3M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=jRK1yGoHLg8mo0+XWEf7WOjjtFpxaRMreP9qMX3pg+2Y7ZiFtQSJz+CWqWeheH7U/
 97X6LWY/xoBvS447MoVh2DB9HePtTAwjh73etUcythKMcDkYAQloqbWVS8sEhRPm5W
 wNSlDpU24jgbrbDa8xwhUwBMc/1D9+EqMqS0BDE6/BjQIwlAIwTGYJMqIefBlVhe8j
 ML5zzV848TfX/F+Xu5yM2qzB5iw2pyAv52+B/AUj+xUK9imEFdRlF1S2s5ZVYLPfXN
 pCFmXcki3V8IPuTB31cByzs36LY3ujdDf9W/8Sg8xUSLVOT/g6jGIEP+MBhrgkCwie
 sqpPTKyzDzevQ==
Date: Wed, 30 Sep 2026 12:58:28 +0200
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
Message-ID: <arzqcM1Qn40gO9qY@orome>
References: <20260930070535.47130-1-clamor95@gmail.com>
 <20260930070535.47130-7-clamor95@gmail.com>
 <arzNgbx465QIKYdX@orome>
 <CAPVz0n2QdSWL8=KBXnsQQkdNEJ9m6HSQ0+6mJji_RHZ8QgXN-g@mail.gmail.com>
 <arzilGz4akKvRF1K@orome>
 <CAPVz0n0-baCzHOXjWLOCLjv8fb5GbE9a2v=8tBYr3RgHkEu+qg@mail.gmail.com>
 <arznE4HKl9r_mPX2@orome>
 <CAPVz0n2A8oU_yRFQ_u_YkXSa5x7PtK8sYZ_p2P+GNcphq-bP-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pxzrbd7z7tsl5fzj"
Content-Disposition: inline
In-Reply-To: <CAPVz0n2A8oU_yRFQ_u_YkXSa5x7PtK8sYZ_p2P+GNcphq-bP-w@mail.gmail.com>
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


--pxzrbd7z7tsl5fzj
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 6/6] drm/panel: Add Hitachi TX10D07VM0BAA and LG
 LH400WV3-SD04 MIPI DBI panel driver
MIME-Version: 1.0

On Wed, Sep 30, 2026 at 01:48:02PM +0300, Svyatoslav Ryhel wrote:
> =D1=81=D1=80, 30 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 13:43 Th=
ierry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Wed, Sep 30, 2026 at 01:34:19PM +0300, Svyatoslav Ryhel wrote:
> > > =D1=81=D1=80, 30 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 13:2=
3 Thierry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > > >
> > > > On Wed, Sep 30, 2026 at 12:08:41PM +0300, Svyatoslav Ryhel wrote:
> > > > > =D1=81=D1=80, 30 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE =
12:02 Thierry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > > > > > On Wed, Sep 30, 2026 at 10:05:35AM +0300, Svyatoslav Ryhel wrot=
e:
> > > > [...]
> > > > > > > +static const struct of_device_id panel_dbi_of_match[] =3D {
> > > > > > > +     { .compatible =3D "hit,tx10d07vm0baa", .data =3D (void =
*)PANEL_DBI_TX10D07VM0BAA },
> > > > > > > +     { .compatible =3D "lg,lh400wv3-sd04", .data =3D (void *=
)PANEL_DBI_LH400WV3 },
> > > > > >
> > > > > > Why the detour through that PANEL_DB_* enum? You could just pas=
s the
> > > > > > panel funcs pointers directly via .data here.
> > > > > >
> > > > >
> > > > > Passing API/OPS via .data is discouraged.
> > > >
> > > > No it's not. We do it all the time.
> > > >
> > >
> > > I have had some controversial experience with MFD, with passing cell
> > > composition. If DRM subsystem allows this, I am more then happy to
> > > pass panel ops directly.
> > >
> > > > > > Also, looking at the enable/disable sequences these are in fact=
 two
> > > > > > different drivers, with the only commonality being that they ha=
ppen to
> > > > > > be used in the same device. Rolling them both into one driver s=
eems a
> > > > > > bit odd.
> > > > >
> > > > > I did this to simplify maintainance. Both panels are used in the =
LG
> > > > > Optimus 2X. My assumption is that LG switched one to another at s=
ome
> > > > > point, hence they share same timings, controls and supplies, but
> > > > > differ in en/disable sequence. Additionally, these are the the on=
ly
> > > > > DBI Type B-only panels in the kernel, from what I can see.
> > > >
> > > > That's just one more reason to put them into more of a generic driv=
er,
> > > > which would allow people to find it and extend/improve it as needed.
> > > >
> > >
> > > This driver cannot be "generic". Both panels don't fall into any
> > > category of being "generic". They are grouped solely cause they share
> > > same timings, controls and supplies (only these 2 panels, other will
> > > definitely differ) and are used in the same device. I have no problems
> > > in splitting them into 2 distinct drivers.
> >
> > The driver can still be mostly generic. And I suspect that the panels
> > might have different names for the supplies and controls as well, they
> > just happen to match in schematics or sources that you used as reference
> > because they are for the same device.
> >
> > My point is, you can keep a lot of boilerplate in a generic DBI driver
> > and then parameterize the things that aren't the same across them. That
> > gives you the best of both worlds.
> >
> > The reason why I objected is that you have a very specific name for the
> > driver file and the second panel doesn't match that at all, so it's
> > confusing.
> >
>=20
> Noted. I will split them to remove confusion. I assume that schema can
> remain common.

Works for me.

> IMHO creating a generic DBI Type B panel driver does not wort it,
> especially since these panels are more like non-simple DSI panels and
> always require a dedicated en/disable sequence.

But that's not a great reason. Note that you can have a generic driver
that describes radically different panels. It's all a matter of
parameterization. You can have very different *-supply property names
and enable/disable sequences, all in the same driver. What matters at
the driver level is the general structure (i.e. you're device has a
backlight, one or more power supplies, a DBI command sequence, a reset
GPIO, ...).

You managed to make them work in one driver, whether that's called
panel-dbi.c or panel-hitachi-tx10d07vm0baa.c doesn't matter. If there's
ever a DBI driver that doesn't match the structure of whatever you
introduce, we can improve or add another driver.

Thierry

--pxzrbd7z7tsl5fzj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmq861QACgkQ3SOs138+
s6H/kRAAm1vAxXljWgcYmOQOkbUgCiwXkFNb46Q54mWK1nQzXYXWFZlcyYbr4/sL
Qnlfcyg63GeL1vedgz72NvA3IW92mZzNo0eNFAqI5hGNj2xJnZw6rNatONFRnLUa
6LpqhL4TY4mel8zBczNh2JHGUYGCufpDMYAcJSY45po5pGJqtTDwfEf6oiZC3jdt
jHje5mFoCmeGak5W43VQQ060/ZI2Q1MchRKU0D3siG8GGUcYFlbecrJqQ6XS+0NX
iAXEH5mXB8VzS+yAVmWFIpYVGGtp1YzCtfn176NkzHj1VH0JUFjTE/flQAbsTdCl
fZCqw2HPfz7TOvZ0EnNEPtwAPmpIff/GXiiatmtKuRSdc42mexLR8bg/0Dy7PQUd
m+g6UuHYsWXsTHIEXpPNloA7I+tPESuGMf6+7FZOfTcyIzYK2uICQl3qaaPeGQF+
Opx+Xeac9OesckawREYpVjasI8tnWE+xkow3tnQyAtH0eKY+8a5D0byicJmISJek
c2ViwFSEzgo9c/M683yL9o8YbwADJr0EJZTGGU7iF6Kou0vgiaKECHH7pEAlc25l
O74WlMpnD48S5i8i5sD6Gnvn2SBS9HpzDarh6B5YhkUlifwWZnTSyZJ42rcCAzQA
A7Yb+1bCFegREaFz1KGQjHqR/j6vHMdKud6biUFdaJzK1IXW0gY=
=FFOm
-----END PGP SIGNATURE-----

--pxzrbd7z7tsl5fzj--
