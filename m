Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE256606A327
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 09:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hByeplNB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F86A10E22A;
	Fri, 30 Oct 2026 09:52:03 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 279BA10E22A
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 09:51:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2C1F060618;
 Fri, 30 Oct 2026 09:51:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 517981F00A16;
 Fri, 30 Oct 2026 09:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793353915;
 bh=Z/Vftd2TiLfBJONWG7tKtuadXYdLcG6KGxDi2+5TrPk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=hByeplNB2F+8/YYQPC2JpRUhzOe3vf3faSzOSkxSDHcYED9UZz5sLO2agt5UT0Rmb
 cLMwNB5IAV4N0s4b7zia5r32tdbNM2PJRYXk3wzFNnipbGyco3Te/DWXs7xM8a5Llq
 eeoFdBdqAiXTMc1uHBPJLSCtxVBjivongrzbGTvUICj6nFLmG9x9Dpeo3sljyZOcNO
 Ds1q16TBuctLaCSTFL04I9pXDnHPWI18yMie7ejJ+HBP/U4AoKs3Y9SHXNJP1pB4bd
 WwKjV0duBOSqKJTT4Bx7S2RTppemzti24ZYGWoQTwNGr41ekqMpRQFUQWU7hdjnm8O
 ssxNDGal6BOoQ==
Date: Fri, 30 Oct 2026 10:51:51 +0100
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
Message-ID: <auRoaHUqMO4BRQlk@houat>
References: <20261029152909.234584-1-clamor95@gmail.com>
 <20261029152909.234584-2-clamor95@gmail.com>
 <auRjGM7briuvXDEg@houat>
 <CAPVz0n2=sgbzBfvhGOoRFXeOzKDvs9en7QD0pHc31r5GzgCsKA@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="6rse7oyeg5jl7wfl"
Content-Disposition: inline
In-Reply-To: <CAPVz0n2=sgbzBfvhGOoRFXeOzKDvs9en7QD0pHc31r5GzgCsKA@mail.gmail.com>
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


--6rse7oyeg5jl7wfl
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 01/11] drm: Add MIPI DBI bus support
MIME-Version: 1.0

On Fri, Oct 30, 2026 at 11:42:12AM +0200, Svyatoslav Ryhel wrote:
> =D0=BF=D1=82, 30 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 11=
:29 Maxime Ripard <mripard@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Thu, Oct 29, 2026 at 05:28:59PM +0200, Svyatoslav Ryhel wrote:
> > > From: Mikko Perttunen <mperttunen@nvidia.com>
> > >
> > > The MIPI DBI bus allows modeling DBI hosts and peripherals using the =
Linux
> > > driver model. DBI hosts are registered by their respective drivers. D=
uring
> > > registration, DBI peripherals are created from the device tree nodes
> > > provided by the host.
> > >
> > > DBI hosts expose operations that can be used by peripheral drivers to
> > > access associated devices.
> > >
> > > The original code was authored by Mikko Perttunen; I have aligned it =
with
> > > the existing MIPI DSI implementation.
> > >
> > > Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> >
> > The SoB situation isn't right here. The author is allegedly Mikko
> > Perttunen, but you don't have their SoB, and yours isn't there either.
>
> This is up to Mikko to decide what to do.

Not only, no. When you're sending a patch you must add yours too.

> > Aside from that, which MIPI-DBI type is this supposed to support, and
> > how do you intend to support Type C panels we already support through
> > SPI?
> >
>=20
> MIPI-DBI Type A and B, which have NO support right now.

Then you need to make it much clearer... everywhere :)

Maxime

--6rse7oyeg5jl7wfl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCauRotwAKCRAnX84Zoj2+
dnWQAX4w8DU5UTbOSr0wJY5a5uRY5k5ksHOA2v27eRbtX+hNTHYRLlbwgNBIxoCt
gaz50U4BfjZFhg2AvQTHY02f+SDwsBFWZm/VA3Se1+aCU+LSX+Rvp/OreKHRL4JY
sYSGWF+RHw==
=47Ew
-----END PGP SIGNATURE-----

--6rse7oyeg5jl7wfl--
