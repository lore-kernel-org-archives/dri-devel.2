Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A73D606A333
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 18:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=la3WHWNd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C76E410FEC8;
	Wed, 25 Nov 2026 18:14:06 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ABC010FEC7
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 18:14:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3C478437B8
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 18:14:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691281F000CA;
 Wed, 25 Nov 2026 18:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795630440;
 bh=Ax+PmbQ+lxqw6w647x+xJJMnRtT8Y9WCbO3rG/ztvrk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=la3WHWNdRDjU5VhX6f88ox8If/wOGWzBlfWdQ3dRibqpB92JI2KgwJdAqfChNm8r6
 VOxZXygFAItcgtec6yPQ/GUox8M55l5/LZw13uLvc4PtisQsLppzxq82N26FzF61Hl
 ezwScfLxcAYVoRyoUz55Cuj40NhNOa9W/yKv//ot7L9Yc2Dk28+5k0U6Te1XVCNuAN
 /esNiJn0ov3iBznyuCxdx0uFWsfUNIDkADgmhT+B/iWcBKrX0ZFzsDOOG9S4A7ojvi
 kh6mALqw2/sRNKmD2lMFOGz9jiiXy11g8P2Za+VVEpj8koj61d/B+i8QbeoF6YRNdB
 vHOnexNB7dOfA==
Date: Wed, 25 Nov 2026 19:13:55 +0100
From: Alejandro Colomar <alx@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] accel/habanalabs: Add missing const
Message-ID: <awclDHG2G41VpszR@devuan>
References: <a284672589d00aa039a8c53ccf43bd1a5fd8e8f9.1795628340.git.alx@kernel.org>
 <sashiko-outbox-233859@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jq3uupjizjh2pfm7"
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-233859@kernel.org>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--jq3uupjizjh2pfm7
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] accel/habanalabs: Add missing const
Message-ID: <awclDHG2G41VpszR@devuan>
References: <a284672589d00aa039a8c53ccf43bd1a5fd8e8f9.1795628340.git.alx@kernel.org>
 <sashiko-outbox-233859@kernel.org>
MIME-Version: 1.0
In-Reply-To: <sashiko-outbox-233859@kernel.org>

> Date: 2026-11-25 17:47:57+0000
> From: sashiko-bot@kernel.org
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] accel/habanalabs: missing const on ch in
>   extract_u32_until_given_char()
> --
>=20
> commit fd205b9061bdb9d6cd798164f715276c74b998b2
> Author: Alejandro Colomar <alx@kernel.org>
>=20
> accel/habanalabs: Add missing const
>=20
> This commit adds const qualifiers to firmware version string pointers
> derived from const char * inputs in firmware_if.c.
>=20
> > diff --git a/drivers/accel/habanalabs/common/firmware_if.c b/drivers/ac=
cel/habanalabs/common/firmware_if.c
> > index 29f5652d60433..69d39a8789d4c 100644
> > --- a/drivers/accel/habanalabs/common/firmware_if.c
> > +++ b/drivers/accel/habanalabs/common/firmware_if.c
> [ ... ]
> > @@ -112,7 +113,7 @@ static char *extract_fw_ver_from_str(const char *fw=
_str)
> >   *
> >   * Return: Upon success, return a pointer to the given_char in the str=
ing. Upon failure, return NULL
> >   */
> > -static char *extract_u32_until_given_char(char *str, u32 *ver_num, cha=
r given_char)
> > +static const char *extract_u32_until_given_char(const char *str, u32 *=
ver_num, char given_char)
> >  {
> >  	char num_str[8] =3D {}, *ch;
>=20
> [Severity: Low]
> Should ch also be declared as const char *?  It receives the result of
> strchrnul(str, given_char) on the now-const str and is returned directly,
> so leaving it non-const will trigger a -Wdiscarded-qualifiers warning once
> strchrnul() preserves const.

I haven't yet changed strchrnul(3) to preserve const, because I need to
discuss some stuff with GCC maintainers (it has some issues with the
existing builtins in GCC), so I'll do that in a future patch.

For now, let's ignore that.

>=20
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/a284672589d00aa03=
9a8c53ccf43bd1a5fd8e8f9.1795628340.git.alx@kernel.org?part=3D1

--=20
<https://www.alejandro-colomar.es>

--jq3uupjizjh2pfm7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmsHJWMACgkQ64mZXMKQ
wqni0A//fNoxJUmP43xHKoVBuaJx+zJp10m1UBS9Qtt0quJ3jTmZg4j0msz6ICJk
uVEH4UYqe7ddBBSicVRQGZUXv6M6kJdOx8pg5HUToRvyt0LJP+pkEh2eUZydb+Bn
04N+eVkYnbUTlRj98CWY2UEGQoksTkh8P3r0zGZm4tBL+WBThimpBpCvzdQdDzbN
OB7GYZMtq/PTIfpifBKcj+pnc3qV5ik0Ef4WJD/acZ37DtfR6r4VBz3Zlbphuyin
QYQgQHhDy1HC+cG70ZruUrAkqWhiRl5NjMvmcAw1yRKrd1ZrfP+j5bgCRXGGJ54O
MNg4jWbZd3M5IlIAXSs56haZsaD/y7iikzFN2fU615WLo+SpRjax3RA7pp38XyGV
dPrTlOjAc6vkjQa8UJzt6KHPV6UZynrGMwRZgJg7kNFTQSta6JVDowH82B+rzLVs
wwti+Uy4VIrh80tPjo/ccQoFm+xWEX72Rj+plYYjYMeI1KJETQpiBAJP29M+GHSq
Z1xY4bapn/CJ6dTEzBQS8jSFqQ6RHCgKGQPl5DOriy8nmaEkOiVSGBI7gWmckMen
FhtNWUfan5QGrSjEV2ulZFHtHVHF2N2DDMgDEUjYBp6EvZmV9yuUthi8EyIxeGYz
JNPwh0TRJIechXW3poA97t9gbdp9N4mmoYYjp/W/x1b9mhUyYb4=
=fWvK
-----END PGP SIGNATURE-----

--jq3uupjizjh2pfm7--
