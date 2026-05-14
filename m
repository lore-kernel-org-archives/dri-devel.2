Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 320C3CD37AC
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 18:53:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8168410F30F;
	Thu, 14 May 2026 18:53:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SwIKUlZZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9DAD10F310
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 18:53:36 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id AF8D1435D5;
 Thu, 14 May 2026 18:53:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0939C2BCB3;
 Thu, 14 May 2026 18:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778784816;
 bh=LojdqSQPYBF5kOn8K4ij6P5PAbYy892VG0hBX1AfX/k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SwIKUlZZXtg28j72IRi90fQR8j5y6N5LCi0+Wuqq2IiiKkizMKGRpFy29n0M0sAUp
 hmgZVEtYBzMIXBJLeyCE95RyAeWijMiSDUB+RRZVDqfHzlH0RhmSrThL50vRKjHBKJ
 ISByx5wjy4tqlWcp3JO/gYA5uNTmfdNsJza52oBs90/lcYORa+3PSd7xG6pQ3EV5Zv
 Oz9587SQSkgHJSv2xHSwZ2rFQLon2sWTb3jkT9FymtZwXxuXSWr7t/UikDndJD/LcZ
 7MUsEYLEk0X2pKeM5bZJaY394+1rdJ4VLAcVaJRhhzQiKLadZ29UtGemOm76bLFOIR
 cj1Ug44Vgu+KQ==
Date: Thu, 14 May 2026 19:53:31 +0100
From: Conor Dooley <conor@kernel.org>
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Teguh Sobirin <teguh@sobir.in>
Subject: Re: [PATCH v2 2/2] drm/panel: Add panel driver for Chipone ICNA35XX
 based panels
Message-ID: <20260514-ability-ditch-b9194a93227f@spud>
References: <20260514-icna35xx-v2-0-45acd1dfa566@gmail.com>
 <20260514-icna35xx-v2-2-45acd1dfa566@gmail.com>
 <20260514-sphere-overstep-e564bf7ca609@spud>
 <CALHNRZ_4aii1MTqd58zZ_1sFoxNZPPehuRauvExvQzzBBb7tKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LH9x5Wis7azuK+VC"
Content-Disposition: inline
In-Reply-To: <CALHNRZ_4aii1MTqd58zZ_1sFoxNZPPehuRauvExvQzzBBb7tKg@mail.gmail.com>
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


--LH9x5Wis7azuK+VC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 01:24:19PM -0500, Aaron Kling wrote:
> On Thu, May 14, 2026 at 1:05=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Thu, May 14, 2026 at 12:24:50PM -0500, Aaron Kling via B4 Relay wrot=
e:
> >
> > > +static const struct of_device_id icna35xx_of_match[] =3D {
> > > +     { .compatible =3D "ayaneo,pocketds-panel-top", .data =3D &odin2=
portal_desc },
> > > +     { .compatible =3D "ayntec,odin2portal-panel", .data =3D &odin2p=
ortal_desc },
> > > +     { .compatible =3D "ayntec,odin3-panel", .data =3D &thor_top_des=
c },
> > > +     { .compatible =3D "ayntec,thor-panel-top", .data =3D &thor_top_=
desc },
> >
> > This looks like you could be using the fallback compatibles instead of
> > matching on the panel's. Why aren't you?
>=20
> I'm uncertain if the panels are actually the same between these
> devices or if the init sequences are just similar enough to share. I
> am told that the thor top panel and the odin 3 panel are the same
> model. But I don't know about the portal and the pocket ds, just know
> that they both fire up and work as expected with the same init
> sequence. I'm trying to follow the bindings idea that these might be
> different physical panels that only share a ddic and thus driver
> handling.

That's a reasonable rationale. Could you include this in your commit
message please?

>=20
> > > +     { /* sentinel */ }
>=20
> Aaron

--LH9x5Wis7azuK+VC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCagYaKwAKCRB4tDGHoIJi
0pW2AP99vZlg9sg3BFdlVMbpLtSekLQr/+4ZVTe/Qg6zB97dWQEA6oGr4N0iVOfI
/G47jkjtB6w+EZMnfucgztmPdPzsyAc=
=U4cC
-----END PGP SIGNATURE-----

--LH9x5Wis7azuK+VC--
