Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A947FD877B
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 14:10:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8382E10E5C9;
	Tue, 17 Mar 2026 14:10:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="k81ps8L6";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7868510E5C9;
 Tue, 17 Mar 2026 14:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1773756603;
 bh=mMG2aIP3veFf7ab9T5YQWN4fAdSMBTKrwwcb3rV/1Vo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=k81ps8L6xl/vmDTgwo5kRzeLTZ9zFEhe8T6kZns2BjLbGbTjKK+AeUjfpLPMfvqTr
 Uof02h6zowgPkVbhfImsV+QT6bnkTr+O+KAXnXp1kILu5qIPalDe4AnH58uXWvDFr8
 go5wWkHo78hZBrrlrLQXjt4oOG/zWcXgYqHXgFYeKRxj92SE14JM2kNPwNGFr5Vz6Q
 m8ZUItFHemtXNLT1795YyyZTIHoae4mD5YpqB0pVkMU214zMBnRtgj5CjvoQiBg6TZ
 wq0o3g02qJwbCT23VsFjfNWRsWpxB77KIfnYPeD+0vc7SK1Byf4K4PScwGchICrLCr
 icQkPXxbHZ97w==
Received: from eldfell (unknown [194.136.85.206])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: pq)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 48F9B17E0FA3;
 Tue, 17 Mar 2026 15:10:03 +0100 (CET)
Date: Tue, 17 Mar 2026 16:09:51 +0200
From: Pekka Paalanen <pekka.paalanen@collabora.com>
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
Cc: Harry Wentland <harry.wentland@amd.com>,
 <dri-devel@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <louis.chauvet@bootlin.com>,
 <mwen@igalia.com>, <contact@emersion.fr>, <alex.hung@amd.com>,
 <daniels@collabora.com>, <uma.shankar@intel.com>,
 <maarten.lankhorst@intel.com>, <pranay.samala@intel.com>,
 <swati2.sharma@intel.com>
Subject: Re: [PATCH 01/10] drm/colorop: Add DRM_COLOROP_CSC_FF
Message-ID: <20260317160951.407ee82a@eldfell>
In-Reply-To: <306d456f-4015-4b28-9fd8-b671d4c01929@intel.com>
References: <20260306165307.3233194-1-chaitanya.kumar.borah@intel.com>
 <20260306165307.3233194-2-chaitanya.kumar.borah@intel.com>
 <3cc8bd83-8a19-488b-b5bf-b71f75c18e74@amd.com>
 <306d456f-4015-4b28-9fd8-b671d4c01929@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/UXs5mYAJtEir5IyuCBoLZVW";
 protocol="application/pgp-signature"; micalg=pgp-sha256
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

--Sig_/UXs5mYAJtEir5IyuCBoLZVW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Mar 2026 17:59:27 +0530
"Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com> wrote:

> AFAIU, the block I wanted to represent is Full Range YCbCr -> Full Range=
=20
> RGB. We have the following configuration in our plane.
>=20
> [YUV range correction Block] -> [Degamma LUT] -> [PRESET CSC] -> [Gamma L=
UT]
>=20
> With the legacy "COLOR RANGE" property, selecting limited range enabled=20
> the YUV range correction block.
>=20
> I still need to figure out what use-case does the degamma LUT in between=
=20
> the Range correction block and the Preset CSC serve since YCbCr to RGB=20
> conversion will take place in non-linear domain. But it makes me wonder=20

Hi Chaitanya,

yes, that is peculiar indeed. At least "Degamma LUT" is usable with RGB
framebuffers.

> if we can have "COLOR ENCODING" and "COLOR RANGE" property within the=20
> same colorop like you have been implementing in [1] or should they be=20
> represented by separate colorops.

If there is another operation in between (Degamma LUT) that you want to
expose, then range-conversion and fixed-matrix operations need to have
their own colorops. The chain of colorops cannot go backwards.

OTOH, if there is a single hardware operation that does both
range-conversion and fixed-matrix, then there is no problem for a
driver to translate the pair of colorops into hardware configuration.
So it sounds like they should be defined as separate colorops, and then
drivers usually expose them together. Unless the hardware cannot do all
combinations of their values.


Thanks,
pq

> Uma please weigh in if you have something to add or disagree with.
>=20
> =3D=3D
> Chaitanya
>=20
> [1] https://gitlab.freedesktop.org/hwentland/linux/-/commits/csc-colorop
>=20

--Sig_/UXs5mYAJtEir5IyuCBoLZVW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmm5YK8ACgkQI1/ltBGq
qqcFqxAAnavVQ1zVA7R6Az97rZC3PV0R3XsvTaucqdizvayLaJCdHHV8mjxfY4hi
6nXBsiY8SF+kfQ/mA4P3Q/YVHq20EiCON7MxRPwUOh8A0ag0tGVKLTXd9diOSOZV
Oh5N9WNhVaabMKeI1Zg3q0eMDFtRU5BJSTq65LrBGfT+5OUaZtFCjoB3lwiI2j8t
3c5mh0sjefM/lFTcjMHWUtajI8NT4Mgf8sD/U37x5hsQ9z7EDISCTpOX2tKYSmXJ
DQs+DdiObC2a/OR1+BhS1NQDlLoqLCVYCXkwJtWIliw2oZXlCFGf5NU4vFGvT0qT
KIDwS3xhzY+CdBuJG0D2tiSBDDOF4KEUrtgTDsg1Tq91YB9JzHRLlUZacSozSTFw
WwHO6VTSnj+od+n6s1C/2Cbx3XGOEKCcZdqFRny5vOCw+vhX2ivMj1vdoZ3KMFE5
P/Bn0ZH3eNF2nylJq05zaBPLqYMXVrWGw2Rm6wjqGCY4DbIg/9yYju3HoX5ciDay
8MwudEHYarA2M9mD1kjDn8ENZNSOoHNWZezxB9b20k+h0TyJqLRz4YcCMvaUx6zL
lSgbQakIOdCymLUsf902ZoqWa1uVzbaEBgvI5tuzEYC8d29ue/MzAhO1P+S1UbPx
5XlMufUag0dMoMUJ89nOP/dh4i0RRZxXhZSVDVy52idTuJ7+BuM=
=+5uI
-----END PGP SIGNATURE-----

--Sig_/UXs5mYAJtEir5IyuCBoLZVW--
