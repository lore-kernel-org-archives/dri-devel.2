Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E836BC44520
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 15:37:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D41210E992;
	Mon, 20 Jul 2026 15:37:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LNfpy/03";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14C1F10E992
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 15:37:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3EDD160051;
 Mon, 20 Jul 2026 15:37:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9BC21F00A3F;
 Mon, 20 Jul 2026 15:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784561865;
 bh=uSnN0Ka5V0fkXt0oqtU6U2UjM2hgBBFpRlN4nOyEFkE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=LNfpy/03szprSLih2eTjVOy7quvwJ5r5bGBeW9D81uNGSCEwh1eO70iZlxfGL66Go
 Lde2ck1z7uOuKriDvDZ4m78mGR17lc3qh2cY3cRI9HyQT7pcPSJD35hAw3FdHQQf+/
 zpRfdEhDbAcPmqaRXIwrs3XWnDm5peO9BZKl6NgAqbkirsK36wK8+zY/FOP7r1Q3LJ
 d8Skr52ulbewSn+dEutXD6juqwdrB7v1b577LHW7BfcGS/EfzekMqwe8Jbl1Tx/KH8
 szX9/4Lu2c+m7d7Dx72o6S54DGZnMhQRntBAhbgbVav6FkPvb3IdBevzVCPC2lfVvd
 OuiN6sWJmg2ng==
Date: Mon, 20 Jul 2026 16:37:41 +0100
From: Conor Dooley <conor@kernel.org>
To: Leander Kieweg <kieweg.leander@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 airlied@gmail.com, simona@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Subject: Re: [RFC PATCH 1/3] dt-bindings: display: Add GlandaGPU binding
Message-ID: <20260720-caloric-lisp-67a55f4920d2@spud>
References: <20260714101146.200416-1-kieweg.leander@gmail.com>
 <20260714101146.200416-2-kieweg.leander@gmail.com>
 <20260716-decidable-tingle-175efaf36540@spud>
 <CAMwcS0hBc_ruk_r+F6cQHQzO+jZagi3M9_AHQ3fpT7cbSUqeOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PeB1kup6Wwr0UQKJ"
Content-Disposition: inline
In-Reply-To: <CAMwcS0hBc_ruk_r+F6cQHQzO+jZagi3M9_AHQ3fpT7cbSUqeOg@mail.gmail.com>
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

--PeB1kup6Wwr0UQKJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 18, 2026 at 12:39:19AM +0200, Leander Kieweg wrote:
> Hi Conor,
>=20
> Thanks for the review.
>=20
> > Sadly googling this device only shows up Phoronix and other copy-paste
> > reporting sites. I think it'd probably be good to include a link to your
> > project either here or in the commit message.
>=20
> Good point either way. The link was in the cover letter, but I agree
> it makes sense to have it directly in the description too, so it's
> not something you have to go dig up separately when looking at just
> this patch.
>=20
> > This clock sounds like it is actually required? Doubt the device works
> > without it!
> > pw-bot: changes-requested
>=20
> You're right, I'll move clocks into the required list.
>=20
> > Usually I would say do not include things if you don't have to, but I
> > would much rather you did if the alternative is an interrupts property
> > like this that doesn't resemble anything used in devicetrees.
>=20
> The example was actually taken from my DE10-Standard DTS, just
> shortened, since I understood examples are generally expected to be
> minimal. For v2 I'll add interrupt-parent back in and use the
> GIC_SPI/IRQ_TYPE_LEVEL_HIGH macros from
> dt-bindings/interrupt-controller/arm-gic.h instead of raw numbers:
>=20

All of this sounds good, thanks.

> #include <dt-bindings/interrupt-controller/arm-gic.h>
> gpu@c0000000 {
>     compatible =3D "glanda,gpu-1.0";
>     reg =3D <0xc0000000 0x1000000>;
>     interrupt-parent =3D <&intc>;
>     interrupts =3D <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
>     clocks =3D <&osc1>;
> };
>=20
> Thanks again,
> Leander

--PeB1kup6Wwr0UQKJ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCal5AwgAKCRB4tDGHoIJi
0jO6AP9uoWP0h3/12z0h3pmBr4+lbYgaZ11MRcd21hJwgOV+AgD8D6VOheNoRfNo
kBaQhujdBvCka3mIvad5/lH0gEirpQk=
=A0Tp
-----END PGP SIGNATURE-----

--PeB1kup6Wwr0UQKJ--
