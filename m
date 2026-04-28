Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D7DFF8868
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 13:32:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBABD10E2C1;
	Tue, 28 Apr 2026 13:32:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="aHGBJAy4";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC53310E332
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 13:32:15 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4891c00e7aeso87577395e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 06:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777383134; x=1777987934;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=l7QR1wYD5I11EeP6iTvNmbLy1lgTXchC2dI25BuZcVk=;
 b=aHGBJAy4A1EscMrXjNM1WeoNmrkoO5HsuLZcbSsX594mJq9R+sBu8/uEdnMOefJJF0
 SZ17+Qh1vEuqpSsoh/hUGBibCs1w7vh87hOmqwsiFHqUwFiJlyIM9ea9v0IzjmVdhcuh
 Ugb0r0fkydheK5ALdF2ymFH+uAFZE2N2lHujJvSoHldVDKM/DC4twc9Ar47Mwmi4c3Sk
 3tQpCnDcPimuyM2cJ4Iszk9EtDgNz5lHBCFepbdTuGAoLYKKjxQqf69LNgZ3d+6Db4XZ
 e1k48lWkuK+p1aYbCiPq/FmNlI05n9qVMYyiBBQF8+yi6zaA7+IAuR5uP+ggIheFtjbB
 R23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777383134; x=1777987934;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l7QR1wYD5I11EeP6iTvNmbLy1lgTXchC2dI25BuZcVk=;
 b=OdhVURJHxsc/egH/g2GHDPiQhPCPN6nPPMTE7PGoI+bpJF9yOYsgwvsdtbQa9ULLdS
 SXHGCSoMBAbm7GL1yEhI1+xFSpCuIQB5Shqhwsr0uvyL7OUMLUrKLYm0TtJaCTMyZg64
 RByATdzghSe62IAa72uectav+sEc7ILJvDbKFFgTNJcOY893y57XP0smX/YICYMuaE8v
 KaEQeTFA1ksYMYIOwJ4cIkQrnQBexQ6YT6/a0XPqo6yPDFGPejfwPgAu6OfsaeYrOAT6
 Z8Z3jshC3BvGr1rJAikXarG5yoTjVsUstzdotyrkE/0E71IYYLyNh4lf65FjyZR3lC6p
 wVKQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/bldlLkJkjbmgNEymt0YAePKd0T7hKp2z1USYkT6oSLQ54wRDw8iwacKFbqPmAbf0WT+tSqL/bIt8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwyIS3AUB3t6GdP3PLLLLUAc2a8O24Q4nD4IPU/A3z5qaj5BdBB
 O+G6KQBTn6v9T4rea97NU1KntQw9ioZopfrWN2AY9rbuclJfvIYzQsSGWATwGi83iHw=
X-Gm-Gg: AeBDietw3+8NvfkPLnLwQzD2UqLjuY6US2HldMjIpJ7wqPxoGvOVKwt4b6h6CPxoReR
 puCMBrjO0bE+gslJ+TemSC//cdfZso5ju8WBcHLOMGaQMp6QKj8SiWsMPauFqAzOMUcU+4aWoKm
 tflKOP7L9J50dD+tfjMyvmVes8zluunflc05Tfi8H1qDtFnRvIJAwiRFyuteU4+WFMpMSJBI4CW
 ykwgwFjFKTUEgY530P9AtEqM4S8SAVPiVFdeRglwo6pwE6I8z2zgQ4CJKZM1dFSb8OCUTLR6Tv8
 uy3LqzbgmzHARhpnLdwz9QLun9prNjs7MVT+70myKKvTC891fYbQ6MvykzoHYs3wVUEOz9cpxOb
 YbcjmUV9oNIsHp2hoRs3F/Clk4wFOcANRhMh2U07LveXmQW7izY/OKAEcS4yVv7WqtK5KhABWw+
 4Ucwl6ejHCVyHUKBoPdH6MChF+fSNf7aHWRkUPr5gy+7iYCjZ5+OQouC/dwYoPOhmy8HYpL0lHD
 hLP0gxfZ5UZOn5r6/KR+iuHTQ==
X-Received: by 2002:a05:600c:6814:b0:488:a977:8d6 with SMTP id
 5b1f17b1804b1-48a77b1dac1mr52885775e9.19.1777383134040; 
 Tue, 28 Apr 2026 06:32:14 -0700 (PDT)
Received: from localhost
 (p200300f65f114e083adbfb3674088b9a.dip0.t-ipconnect.de.
 [2003:f6:5f11:4e08:3adb:fb36:7408:8b9a])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-48a775eb93esm18306035e9.22.2026.04.28.06.32.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 06:32:13 -0700 (PDT)
Date: Tue, 28 Apr 2026 15:32:12 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>, 
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 intel-xe@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/xe: Don't use UTS_RELEASE directly
Message-ID: <afC2Y8ZMEc2T-tVp@monoceros>
References: <20260428102527.189593-2-u.kleine-koenig@baylibre.com>
 <be82fd356047513f23a3193d8007a2e5e8d97e35@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kfwcih2ewprx56b2"
Content-Disposition: inline
In-Reply-To: <be82fd356047513f23a3193d8007a2e5e8d97e35@intel.com>
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


--kfwcih2ewprx56b2
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] drm/xe: Don't use UTS_RELEASE directly
MIME-Version: 1.0

On Tue, Apr 28, 2026 at 02:09:31PM +0300, Jani Nikula wrote:
> On Tue, 28 Apr 2026, Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koeni=
g@baylibre.com> wrote:
> > UTS_RELEASE evaluates to a static string and changes quite easily (e.g.
> > uncommitted changes in the source tree or new commits). So when checking
> > if a patch introduces changes to the resulting binary each usage of
> > UTS_RELEASE is source of annoyance.
> >
> > Instead of using UTS_RELEASE directly use init_utsname()->release which
> > evaluates to the same string but with that a change of UTS_RELEASE
> > doesn't affect xe_devcoredump.o.
> >
> > Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@ba=
ylibre.com>
>=20
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>

Thanks!

> > (implicit) v1 of this patch is available at=20
> > https://lore.kernel.org/20260427160902.1126027-2-u.kleine-koenig%40bayl=
ibre.com.
> >
> > The only changes since then is that instead of dropping the kernel line,
> > init_utsname()->release is used, which is nearly what Jani Nikula
> > suggested.
>=20
> Almost the same, but better. ;)
>=20
> I wonder if most UTS_RELEASE uses in the kernel should be changed the
> same way?

I have adapting these on my todo list.

Best regards
Uwe

--kfwcih2ewprx56b2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnwttoACgkQj4D7WH0S
/k6BMgf/cVZ4MEithHfIvnCDQ9coHA5fBbFzfrXAF/eV6S0i43uU0d7FDiWYEApC
9MevmcEk1C5jMG1HH6n7GusNVe6B2dh0UhsdoRm7SeJIvNhLVH7y9an2CTtSlRqF
nkw3Dn1TUNtssUdpE+AT2FLDJ/xZM/mLCWQ7I3lareyatwxp9mG8JiBcIonXSyWz
Ws7I5YCxrwEqGka+T6cwx451fx+H6A086Eg0NKCgy/tplm5TZd5eqH4jkKW6/afC
upcExMmT7/UpmmgqQ4Jn4wWb/CE57NW+ykytmt9ldIAF8bicZQC4A5Dx7ejwlIBB
Ehd8TiKip26WzkcjTGnQOd/mbt/l2w==
=z5vP
-----END PGP SIGNATURE-----

--kfwcih2ewprx56b2--
