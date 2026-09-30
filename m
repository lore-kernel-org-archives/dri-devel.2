Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A4C5CA5FBA
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:23:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D5E110E0B9;
	Wed, 30 Sep 2026 10:23:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lHeN8bl4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDF5310E0B9
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 10:23:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2A9F4600D4;
 Wed, 30 Sep 2026 10:23:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE551F000FF;
 Wed, 30 Sep 2026 10:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790763789;
 bh=Y6/eisC/1PFb58SA29sI1vLKdk/wVao3FROKDUJrtpE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=lHeN8bl4qsZssVq0G+AKebLkMTNz5dsor1PkFzGDB+Fo2ksKyhPNcWDNf3c1oW8AY
 SXRyEup0Z6PhB1unC/Za3hEb8fCraiDSrAIdgUk5f7mOMUpKb7UQ2iuKLBPVFdWbkO
 Xd2yb175oTanKHzoLQk/Xfu3cX3pq2QP1qHe06uMrJOkxAdvC/01OMdzpZEu16E5Qv
 JAlnpQPUgYbezTQU6fB+sTFDdNApoezixWJhLASufOfh3x5Ve7/mBGmDFSKXlU6sJE
 +ldKbJ4qgrqVSuFdOuRtS92TxcnbufO1EcWK/uC0jBU1NaeZBm5yeRjgsixw9aKjRZ
 Eg3tKpKpJDWlw==
Date: Wed, 30 Sep 2026 12:23:07 +0200
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
Message-ID: <arzilGz4akKvRF1K@orome>
References: <20260930070535.47130-1-clamor95@gmail.com>
 <20260930070535.47130-7-clamor95@gmail.com>
 <arzNgbx465QIKYdX@orome>
 <CAPVz0n2QdSWL8=KBXnsQQkdNEJ9m6HSQ0+6mJji_RHZ8QgXN-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="c2npe4egdsdkxc2s"
Content-Disposition: inline
In-Reply-To: <CAPVz0n2QdSWL8=KBXnsQQkdNEJ9m6HSQ0+6mJji_RHZ8QgXN-g@mail.gmail.com>
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


--c2npe4egdsdkxc2s
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 6/6] drm/panel: Add Hitachi TX10D07VM0BAA and LG
 LH400WV3-SD04 MIPI DBI panel driver
MIME-Version: 1.0

On Wed, Sep 30, 2026 at 12:08:41PM +0300, Svyatoslav Ryhel wrote:
> =D1=81=D1=80, 30 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 12:02 Th=
ierry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > On Wed, Sep 30, 2026 at 10:05:35AM +0300, Svyatoslav Ryhel wrote:
[...]
> > > +static const struct of_device_id panel_dbi_of_match[] =3D {
> > > +     { .compatible =3D "hit,tx10d07vm0baa", .data =3D (void *)PANEL_=
DBI_TX10D07VM0BAA },
> > > +     { .compatible =3D "lg,lh400wv3-sd04", .data =3D (void *)PANEL_D=
BI_LH400WV3 },
> >
> > Why the detour through that PANEL_DB_* enum? You could just pass the
> > panel funcs pointers directly via .data here.
> >
>=20
> Passing API/OPS via .data is discouraged.

No it's not. We do it all the time.

> > Also, looking at the enable/disable sequences these are in fact two
> > different drivers, with the only commonality being that they happen to
> > be used in the same device. Rolling them both into one driver seems a
> > bit odd.
>=20
> I did this to simplify maintainance. Both panels are used in the LG
> Optimus 2X. My assumption is that LG switched one to another at some
> point, hence they share same timings, controls and supplies, but
> differ in en/disable sequence. Additionally, these are the the only
> DBI Type B-only panels in the kernel, from what I can see.

That's just one more reason to put them into more of a generic driver,
which would allow people to find it and extend/improve it as needed.

> > If you really want to avoid duplication, maybe they should go
> > into some kind of "simple" or "generic" DBI driver.
>=20
> DBI Type B is not well supported in the kernel.

Well, you always start somewhere.

Thierry

--c2npe4egdsdkxc2s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmq84wgACgkQ3SOs138+
s6Eiuw//RQ2fm/9EQCbJc7rzzjSmpYsrALrOL8ogrNgRr+Us7Js++rkpBy77jMCa
90Qnk6xN1CIf9BhJTiguaDmm5iYpvItlJttFThldrtaVCWR0dlS5YhTDgabxCcXh
CGvcXuGxPZfmx5/+IYpBkO48k83Czq+9CHDjL33IVSNmOXikAHLC9YeetQEky5vT
p8AANLuVKSig8r6ZpamwRiiiPDNhaQP2ohSJ58uaK3e0224iYTm7AYfEj6VZPKdG
yzO/ZrgFtpveqy6/XuY6h9GP2uF+lIE1ZAw1RseBYGuQe3/fROaZcCo+48T3h3cA
EKVOOGEFkbZVJtqojDA9vFrZyptANBNtFnB6TtNV4252NoMwkVpRs6zgcMO0F8k4
VBvzfEVE8Q8O5YD7Alugjsg5bdu+AmyxB9LnnqbvAIDwjPpbjGCo7b0slLaNxpq4
XMuzqsM8l5YvLFzgK3APfk13aBRbZoraA1NxE0pDOiJuz2jU2GQM93ApmReILD3a
wdC6598g1AkPaxNOSe/NIbe/uSg8a5AGE17AL7o5QJsbdgC58eHte8NsrplzK3h8
HXFCnZIhsl9F6PtqtEccus3qYk0kZENOYgEjwkIHVlMHVAUDOufngzwrX+QERknV
7mWpdUkxp9lUlmS5BXUcZRb1PR6e5ucdggcIjv6SFJYsWmdFf2Q=
=5XM7
-----END PGP SIGNATURE-----

--c2npe4egdsdkxc2s--
