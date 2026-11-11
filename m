Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B2A606A33B
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=eQIgQn/B
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD9BE10E9B3;
	Wed, 11 Nov 2026 09:04:55 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C7BA10E9B3
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 09:04:49 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so34895285e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 01:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794387887; x=1794992687;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sP7k6XjcVumCLj2NxGQn6KKl25HOAblRp6pXpTH9GPw=;
 b=eQIgQn/BEHgv1PIxN/oPQH+GEMlJj8Ic1Qly6o2qIW5ZA6OFX0i1+Wb09yfE4JTXa3
 iwHv6HO6jukke0JK4qskPzi/03ek3vYFjgYzZqCgGqQmghb9LUx/gP6IbNzkycVnq1Lc
 ZFs+8P1FwKr3uCXQYRQ+eapHHF2h0KhHIC5hMEXxOlCqcXo9d4CX2LQZbMaLnQL+w74d
 qSZzF9z4q7XhxJi4YNbX3wm7Te/kPnxesk8fG4Cye4H97JUoP3BieAYvy/L0pSX7NYlN
 hLMBuDBOGOeOvPU2IjPjyzvV2A15QWp31lSajjtfB2roR+42zYItBtz0HTp/GGCpVPKq
 q1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794387887; x=1794992687;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sP7k6XjcVumCLj2NxGQn6KKl25HOAblRp6pXpTH9GPw=;
 b=JZ3VxY6bJUvZuuvtZxVJEL06KiuW7JFNtk0O9L7s3NeYgbRHyb0N5cKcFsvf+Tot6R
 9T/Pfp1Tel2fRsWHmtArDBUAlUARHRwBA80ebUBqR3aoYgysgZy+z4lhSV6aYS2jFtyy
 UmCxvDAo70ZaN6AZrZP5R5Q5lWw5oEd9tDNPi02AX1SAivzPGd7vDBoK6kqsObCSi4TK
 IwzFMKdvhAff//iXvs/edddBB0jD6xqv3ZCF02u4efqu6RE2IOaGTbyFHo3bOUegH3gj
 94R9zm9hBZ/IGOfRGzAgpTNqWI8clyb+Nb8KfQHr8C0ckayGTh4kMYcQ+bZKA8SGWYTy
 rumA==
X-Forwarded-Encrypted: i=1;
 AL+hErE0MAHR8Mg5vF7obIEkahr51Urt+eMPRDD76kAqLuTTkSSCRVTNF5ow6ycJs3GmmX5V9aaAKmDsajU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8LxtPwICGi2WH73gH3NqmhnEHrX7Za68m/DhW53dtph3R6JyQt
 hzsL0uC2UxC1lhszVw0yG1LPAAKwwRqQuU7qLxXJ4qRTcPA61E8Hh/TgKT3BzvPzgx4RJ7kcNMT
 Yj5r6iRQ=
X-Gm-Gg: AYBFou1oxfLsc0HichhJOPzx0fx4zt+ogY7/ARgv/I9/abIKUyKTQ3TnGFCD3bpwXxf
 Jvy5i5Pz35NWNhAMfViNGDwmcP9dB3xDA2qPZsmhL9FXybm2ecYpcBRfOWv9sL3ueY5qd+f5/E1
 RgIRVA5lc4tDBXZ9h66p/LagyGtY8IcjgDLd6JtEkbiVoqxcNJPivCeUJbTNmUycVbRXLD9kwNR
 7Msa5ajNGu1IUdDLZQZe0ZFEfXO0pem2T3pkLEJNRKAjDbaAjRL3+YXUkV/Sb0Vef81xtBTKJDY
 aOVlW4F96HWgsEEhjSL8/YvzeODm40L7hloaxrKw5GTugvTI4+NeTzh3nnp8ncBiurp6Ldglh0c
 KrUPCb8jB03evu0ZC8x7ky5yoII3DxEKJ9b1hd5AESGHUAWEV9AMc21UcAw0a4zuSPkQQFYgnPL
 mMWsurX5rzV2Ndmxl7rmV8zb2cdr1B72OpgHl/dBjnnwtkIqGZkFjDkW7mlnPsBQVDCKhwQlRo8
 te3OknxakgAFdgsrId2X0I7aae4/Ra/O0o/M5iDuj3UP8Vyx869la1QJlD1uWtMnrFgvIrY/Gx3
 8J6Y5oWvzI5EavzJQWSF6xR7ItQSNm936XRaq3iYtyd0/lL9trdo28/3FmRySW7z2JAeNRRgF6w
 X1XjOePNzo4Ye2vNQmHyq2teoVzk7rHCQxg8=
X-Received: by 2002:a05:600c:4e87:b0:49f:e772:6ddf with SMTP id
 5b1f17b1804b1-4ba0938ae31mr28591735e9.32.1794387887546; 
 Wed, 11 Nov 2026 01:04:47 -0800 (PST)
Received: from localhost
 (p200300f65f19a90460510dd506fc51af.dip0.t-ipconnect.de.
 [2003:f6:5f19:a904:6051:dd5:6fc:51af])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4ba09509c74sm24119845e9.2.2026.11.11.01.04.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 01:04:46 -0800 (PST)
Date: Wed, 11 Nov 2026 10:04:44 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Alex Deucher <alexander.deucher@amd.com>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Markus Schneider-Pargmann <msp@baylibre.com>
Subject: Re: [PATCH] drm/radeon: Consistently define pci_device_ids using
 named initializers
Message-ID: <avQvaiaEyWDUQsZz@monoceros>
References: <20260430102958.136859-2-u.kleine-koenig@baylibre.com>
 <aimXCmtgcejwInNg@monoceros>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pma5azs7fhrm2bnu"
Content-Disposition: inline
In-Reply-To: <aimXCmtgcejwInNg@monoceros>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--pma5azs7fhrm2bnu
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/radeon: Consistently define pci_device_ids using
 named initializers
MIME-Version: 1.0

On Wed, Jun 10, 2026 at 06:56:35PM +0200, Uwe Kleine-K=F6nig (The Capable H=
ub) wrote:
> Hello,
>=20
> On Thu, Apr 30, 2026 at 12:29:57PM +0200, Uwe Kleine-K=F6nig (The Capable=
 Hub) wrote:
> > ... and PCI device helpers.
> >=20
> > The struct pci_device_id array of supported device was initialized
> > by list expressions. This isn't easily readable if you're not into PCI.
> >=20
> > Use PCI_DEVICE* helper macros and named initializers which is more
> > explicit and thus easier to parse. Also skip explicit assignments of 0
> > (which the compiler then takes care of).
> >=20
> > The secret plan is to make struct pci_device_id::driver_data an
> > anonymous union (similar to
> > https://lore.kernel.org/all/cover.1776579304.git.u.kleine-koenig@baylib=
re.com/)
> > and that requires named initializers. But it's also a nice cleanup on
> > its own.
> >=20
> > This change doesn't introduce changes to the compiled pci_device_id
> > array. Tested on x86 and arm64.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@ba=
ylibre.com>
>=20
> Similar to the amdgpu driver patch I just pinged, this patch would also
> be great if it made it in for 7.2-rc1. Please?

That didn't work and it failed to go into 7.4-rc1 either :-\ It still
applies to next-20261110, is it still on your radar?

Best regards
Uwe

--pma5azs7fhrm2bnu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmr0L6kACgkQj4D7WH0S
/k4KfAf/f5q3Vl7EnPVZaB/M3tX4n0SFtnKOCJkLtj4107/VpJ+jLb3mrCXFulXy
Z1rgfK86pXvaFuknlwOCHRZ6mpoZCgbp7YQYcc1+hWncLfLYFcnGvQKoZLKP8RK6
yHLzpWaGzaZvH7Q6DBQurfqIwGwTNRrFyZzi4ILzOS2nIhFGSsDwCxKAlkX1OrEp
d1wJQgg7dLK5dcHAoejIUCKED5kOVs+Sh81KFrkkgvyDB6FunShTz3T3Q0BhTALD
c1MP6XcJaHm5IpB4yWysfiiuKeYcO45KZSSKa0XoBjpmhXooicsJk6ggWaQbxElk
MUXB5eCUZ9TeWy82BMLT7UZrHZzvRA==
=gtpi
-----END PGP SIGNATURE-----

--pma5azs7fhrm2bnu--
