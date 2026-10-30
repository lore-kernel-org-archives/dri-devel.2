Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C6F606A337
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bte/lvtN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27AE310E24C;
	Fri, 30 Oct 2026 15:19:41 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CA4F10E24C
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 15:19:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1AABA410CB;
 Fri, 30 Oct 2026 15:19:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766AD1F0093A;
 Fri, 30 Oct 2026 15:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793373574;
 bh=PsVKPZVc44PCZoORE4idM922fiRfq5VdfwUd07YqWDk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Bte/lvtNF6Us/1b7jCHDJ/mv+bBnE8JPEMoq1dA4UWpcc+qRawb68Z+G8S3A39QsS
 hDYiMpIgUeJ1tiT655OIgVe9SVckgg5bg4XqkX/WFVJY+tz8OPLhAwkav9InmUJ8xs
 d5qnMYvYPFuMl6XteASq47T7pAhec2QeXsuCXEqFKd648i3Y9eC8KQkKJ53rEG8qxX
 vHHjDvdba3GaMtISZl7JYMqV5vZycgGg6jwSitKz2VPbYvPqOlkkMkWG3RZQkNqhvc
 uMKk4+deh0FkRktOmsQmwq7Q9jGto1HncEET+BVuGljgUAYRBbxUnCKSFlQJep9bbj
 FG0BsOBOS+dUA==
Date: Fri, 30 Oct 2026 16:19:30 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v5 01/11] drm: Add MIPI DBI bus support
Message-ID: <auS1aG5y3nmnDkVu@houat>
References: <20261029152909.234584-1-clamor95@gmail.com>
 <20261029152909.234584-2-clamor95@gmail.com>
 <auRjGM7briuvXDEg@houat>
 <CAPVz0n2=sgbzBfvhGOoRFXeOzKDvs9en7QD0pHc31r5GzgCsKA@mail.gmail.com>
 <auRoaHUqMO4BRQlk@houat>
 <CAPVz0n3K74CZemDzVVymmjU_5GUGE9FsEKk555-AJfG0jek_hg@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="omsmhv7zumr2gj46"
Content-Disposition: inline
In-Reply-To: <CAPVz0n3K74CZemDzVVymmjU_5GUGE9FsEKk555-AJfG0jek_hg@mail.gmail.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--omsmhv7zumr2gj46
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 01/11] drm: Add MIPI DBI bus support
MIME-Version: 1.0

On Fri, Oct 30, 2026 at 12:02:52PM +0200, Svyatoslav Ryhel wrote:
> =D0=BF=D1=82, 30 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 11=
:51 Maxime Ripard <mripard@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Fri, Oct 30, 2026 at 11:42:12AM +0200, Svyatoslav Ryhel wrote:
> > > =D0=BF=D1=82, 30 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=
=BE 11:29 Maxime Ripard <mripard@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > > >
> > > > On Thu, Oct 29, 2026 at 05:28:59PM +0200, Svyatoslav Ryhel wrote:
> > > > > From: Mikko Perttunen <mperttunen@nvidia.com>
> > > > >
> > > > > The MIPI DBI bus allows modeling DBI hosts and peripherals using =
the Linux
> > > > > driver model. DBI hosts are registered by their respective driver=
s. During
> > > > > registration, DBI peripherals are created from the device tree no=
des
> > > > > provided by the host.
> > > > >
> > > > > DBI hosts expose operations that can be used by peripheral driver=
s to
> > > > > access associated devices.
> > > > >
> > > > > The original code was authored by Mikko Perttunen; I have aligned=
 it with
> > > > > the existing MIPI DSI implementation.
> > > > >
> > > > > Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > >
> > > > The SoB situation isn't right here. The author is allegedly Mikko
> > > > Perttunen, but you don't have their SoB, and yours isn't there eith=
er.
> > >
> > > This is up to Mikko to decide what to do.
> >
> > Not only, no. When you're sending a patch you must add yours too.
> >
>=20
> > > > > Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
>=20
> My CO dev and SoB are both present. Mikko will say their word and I
> will update accordingly in v6

Oh, right... I'm sorry.

Maxime

--omsmhv7zumr2gj46
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCauS1gQAKCRAnX84Zoj2+
dimXAYD/kqhnWNp/fGtGmf02koLLAQSBfFjU7YQFTgtxn7ZE1915cNwji0VZhZ5U
PUt5uAYBf1EDORnUBqbBxbSSuSfnz1QobM7lQT6wiW+bZhw6bAea7gPY0866McMg
o1D52FAX9g==
=A4YB
-----END PGP SIGNATURE-----

--omsmhv7zumr2gj46--
