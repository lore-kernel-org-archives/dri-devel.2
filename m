Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D7FBC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 16:21:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED22689D9A;
	Tue,  7 Jul 2026 16:21:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YpzsMYPT";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CE2B89D9A
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 16:21:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1FC764035B;
 Tue,  7 Jul 2026 16:21:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B28411F000E9;
 Tue,  7 Jul 2026 16:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783441283;
 bh=vr7Ks1DCwvqtxTBrk6q4zbArTPG/BpwytD7pVNj1bjM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=YpzsMYPTcfCVr0YwD+UgvvTZmQfCzReXf3uffvar0+TyYBjqxssb/yILkLVHKtxC/
 SSersHNqjtHQcUcK4AfaIJ2P8AHQeO2WoU0P7a/7kwxBrQcknZU0xVsLbeIETr/9zy
 GR7QmrXhMteX9YoZUhgjNBKgkZRd1skTuojDeJjyeOEfi+FzmKtTGsX/63gNeqSWCH
 ltkCrGRI0JnWPLwtXLOhOYYaLXlBpG7oBCpXCuVRTgWgXmzSlMcB2/fhKCWHRgelvt
 CGTv8GffW+xg7U6QIQz0yPSNits169AKlW6rgTVMiyWvdy3QiUBlNB3rRX58YTEPIw
 UBDvLt1Q9z+dQ==
Date: Tue, 7 Jul 2026 17:21:19 +0100
From: Conor Dooley <conor@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Wojciech Dubowik <wojciech.dubowik@mt.com>, robh@kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/2] dt-bindings: display: sn65dsi83: Add reverse lanes
 property
Message-ID: <20260707-aching-clutch-a71a6492cde2@spud>
References: <20260707070244.230546-1-wojciech.dubowik@mt.com>
 <20260707070244.230546-2-wojciech.dubowik@mt.com>
 <20260707074500.CAF1B1F000E9@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ryl6ucjzQWrWKoA2"
Content-Disposition: inline
In-Reply-To: <20260707074500.CAF1B1F000E9@smtp.kernel.org>
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

--Ryl6ucjzQWrWKoA2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 07, 2026 at 07:45:00AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] The patch introduces a custom vendor-specific boolean property `t=
i,lvds-reverse-lanes` to indicate LVDS lane reversal. This is a device tree=
 anti-pattern because the referenced standard `video-interfaces.yaml` alrea=
dy provides the `data-lanes` property for this exact purpose (e.g., `data-l=
anes =3D <4 3 2 1>;`).
> --
>=20
> --- Patch [1]: [PATCH 1/2] dt-bindings: display: sn65dsi83: Add reverse l=
anes property ---
> commit c30eea01a74188461b7e527f71d282d68b885ec2
> Author: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
>=20
> dt-bindings: display: sn65dsi83: Add reverse lanes property
>=20
> This patch adds a boolean property to reverse the LVDS data lanes order f=
or
> endpoints.
>=20
> > diff --git a/Documentation/devicetree/bindings/display/bridge/ti,sn65ds=
i83.yaml b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.ya=
ml
> > --- a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
> > +++ b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
> [ ... ]
> > @@ -115,6 +115,10 @@ $defs:
> >              enum: [100, 200]
> >              default: 200
> > =20
> > +          ti,lvds-reverse-lanes:
> > +            description: Reverse the order of LVDS lanes.
> > +            type: boolean
>=20
> [Severity: Low]
> Is it necessary to introduce a custom vendor-specific boolean property
> for this?
>=20
> Since video-interfaces.yaml already provides the standard data-lanes prop=
erty
> which can be used to describe the exact lane routing, does this hardware
> require a distinct property instead of using the standard data-lanes
> approach with data-lanes =3D <4 3 2 1>?

I don't know much about display devices, but this seems like a
reasonable thing to me. Why would it not work?

--Ryl6ucjzQWrWKoA2
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCak0nfwAKCRB4tDGHoIJi
0hliAP9Za6VPiTNd2YOQPMgTQqjuqUU8tsMVvGXeI7WALz2OAwEAwTcAn6n+IeM/
XH2gRAwYsDuEIvmpI9z38gvbUoiFywE=
=a5FN
-----END PGP SIGNATURE-----

--Ryl6ucjzQWrWKoA2--
