Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E32CD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 13:28:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5515710EE65;
	Wed, 20 May 2026 13:28:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="YyNUzjZt";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AE7710EE65
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 13:28:32 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-488ff90d6c7so37876685e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 06:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1779283711; x=1779888511;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YdRArgXhGEk4i+GZe+h4MUY32Lfiq4WFd9PhB4MWWT4=;
 b=YyNUzjZtgyhms7bp6MYXB/Vpt41qWprf8/xhISiYM2XOvx9gG+q4f/u3qO8CpJeOb6
 M7hPI6Jhhx+YZ9bWnx4GunNMjObog1vEBeBFEuD+b9L81LtjrZJUYDpuwuQsur93vY4T
 6rkXr9WvGDkLcqFap1Dv+3q89FG4JC0MrkriBBE8HA1IZXTTlW3cOvo8UgWkcd26asVR
 Hsv9bilmwiFQNclerwy/MBE7q5hj2D8dEU9ttGZ5XG4BbzoJ2HPab5rrS0QPNVqtRqjc
 OZcqWZzDj+m64a5bYEEmfqELDzCHx4/52y/XcTDs7HAVbl7UVZelCkKbQZyX4AIH4psr
 oTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779283711; x=1779888511;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YdRArgXhGEk4i+GZe+h4MUY32Lfiq4WFd9PhB4MWWT4=;
 b=kefBYstFZG/Ed58aQcPZf0vz8s4s/O48j+vRw/4r8DGfweCvNEmH7yuEaNcLSVc7gp
 WVHSw+A2BjFUHAIOV86SSKKDhwpT3IjAI7GzHs+cW2TMX9w1D/SK9+tAtmXK3iGqRcdu
 LHHTTzEYI3czZvKCKaUli2SjZkOMUuTUXj3S1Ru7oY4qCdQQXHUxWxX2nVx263RmRcZu
 k8S/ff5J7Or2TKo1E+RAAAftGNW+TqIYPDSWj75iNLl9xqPwIWl+rqGfe0TfHMoMgzF9
 E55Bmlwj116+7mhzZ8JH3larFav5Cui2KB0sFlRsb3phG6Udp1EuVwCeQSY8TjvPwLkn
 PYIQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ZBDyPFchM/INXSxCP/eG4qAwv6X+kJXi1tHMiTIaxk7bvd6Tb4r9aDfRYLWxQz97ih4gUbs26uEU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx8ncP+6pSLJ3/25ffVvUm/BZ6PhROXcFaQXBee/HyahNODXgc8
 H0/cmS6WW1aVcGQb8B9fOITqtmewgb7ieB/H1tuhzQX+zpegSktaE8LE9Za/EiLGCSo=
X-Gm-Gg: Acq92OHYBPd4BT/pD5pbUub9u7Jf2AlcU1OH6BuxnrN1Vm5s1hmbLZ2nPc2lxrR9e6o
 prf9pmMXD2KZPv1Qv53YiaVmb5+PVpc/4mUBYobiz/J9WgqJm7bkrWJ/YzpZ7f61P+k02Ivv3w7
 pFtXzcqLYgjU9UUwpGNPzCmaNomWQVxLo+gDbdpzFzPM0nSnIwrt2dJI6yiVzqi3KAsOIBqa+LV
 GXOWjj3IJbwSlFh+uvjHNTGYsqe9KKBc1E+t5fYerwaQ0tF5fEpzUOJmVD8k3U4k/F/DnYC1uto
 3I5cboGwPV9xfKo/PoqxOJ691wudNkvKVlJtsrDUzS03aUuxsAml0+5Kuersoi3HPXzVT0Hfa7H
 2bVQjcb5AaZYSFgEW+Z645r4BKFm1vMiz2PItWelxHQM15pdF3bWIAQYZR7MTyZFQ/FgtzAsLmX
 sLcG/pYN56bAGQh5x2jiOxtjfNBNIgC/Lvz9Boalt4X9OLzY5lJosH2jPbM8NdTOPBR/LHyYnKP
 dlV9A==
X-Received: by 2002:a05:600c:5296:b0:48a:65ad:1881 with SMTP id
 5b1f17b1804b1-48fe60ed846mr375342815e9.13.1779283710913; 
 Wed, 20 May 2026 06:28:30 -0700 (PDT)
Received: from localhost
 (p200300f65f47db00000000000000081d.dip0.t-ipconnect.de.
 [2003:f6:5f47:db00::81d]) by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-48fe4c8344asm671573025e9.1.2026.05.20.06.28.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 06:28:30 -0700 (PDT)
Date: Wed, 20 May 2026 15:28:28 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Helge Deller <deller@gmx.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
 Russell King <linux@armlinux.org.uk>, Andres Salomon <dilinger@queued.net>, 
 Antonino Daplas <adaplas@gmail.com>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-geode@lists.infradead.org, Markus Schneider-Pargmann <msp@baylibre.com>
Subject: Re: [PATCH] fbdev: Consistently define pci_device_ids using named
 initializers
Message-ID: <ag22VfyB51APLhQL@monoceros>
References: <20260430111637.211336-2-u.kleine-koenig@baylibre.com>
 <ag1xQVCCzXkc_Ucu@monoceros>
 <6f1e1da5-a086-4261-aacb-f1117e22146b@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2ur6redof34jxgqs"
Content-Disposition: inline
In-Reply-To: <6f1e1da5-a086-4261-aacb-f1117e22146b@gmx.de>
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


--2ur6redof34jxgqs
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] fbdev: Consistently define pci_device_ids using named
 initializers
MIME-Version: 1.0

On Wed, May 20, 2026 at 12:11:16PM +0200, Helge Deller wrote:
> On 5/20/26 10:46, Uwe Kleine-K=F6nig (The Capable Hub) wrote:
> > Would you mind squashing that into the patch you already applied, maybe
> > adding:
> >=20
> > 	While touching all these arrays, unify usage of whitespace and
> > 	comma in a few drivers.
> >=20
> > to the commit log? I can also send a v2 of the patch with these changes
> > included if that's easier for you.
> >=20
> > Otherwise I will put sending these modifications separately on my todo
> > list.
>=20
> No need to resend anything. I'll clean it up manually during the next few=
 hours....

Looking at commit bca0e1973086919ae2dcd7b72e4ef5ee48858df5 in your
branch, the result looks fine. Thanks for cleaning up after me, very
appreciated.

Best regards
Uwe

--2ur6redof34jxgqs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoNtvoACgkQj4D7WH0S
/k6hDQf/QmYRiZj4xogmbV9WDEP+x/E2ECzORIkyZD+45qdJTmD/Blz8kOhzvJz0
/EkAqyoqAlLkC772ihHZUjPshnDK3USSHcNOIxLqUoSOA9jN8NA9NfadZVMPllqC
Hvu7al1cPZOEt9hMTsqK1udc8XPdKkVsyfoStLkG56POcb+uKORAcrRsGjHoWxhR
x/6/r27m1hhMM1FdD+eHuN1lDOCB/tGLO1mTIqMxKiJBboBiOFrumDEz90TEpLMv
akJ6g/RxEAsQsJFGu5sj0H+FtLWoawj4QLxljR32XLO6Sn5ZUn4qcLJyr3+fXHF4
oBKqDxZM6lVNp2fpiG4EFeEQ+rISLw==
=dV9W
-----END PGP SIGNATURE-----

--2ur6redof34jxgqs--
