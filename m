Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB76CD5BB1
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 16:38:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86E5C10E1A1;
	Tue, 26 May 2026 16:38:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="H17L7q/r";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D357810E1A1
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 16:38:18 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4891b0786beso72675125e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 09:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1779813497; x=1780418297;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+neT3f/iOdkns4E+8cxUHIEwouFFRC5e7pB2NZRvaQM=;
 b=H17L7q/rQlEVpdNqSPFoMXCjaW1Hw90qWmor/UxGNRrtb7CGTYldH4Jt+FHiS9soqx
 sWtpL9Cb7ZPUeS+6H8+4t6gw3BJmZ8huSXA6gNXSiuf/BlyNVUgiMeSAHZNlmqJ2WjFM
 4aqfAw6YYx6/O3pdZoslxpUP9I0rX0TziLnIQknY3/l8ANNOu3a/M2SeGZbn9T3PhFnq
 pTm+Karwjpml8onSUZcA7rH+7QegfqMhyEUB2BRH0rlyPaXaVFtY30mnyYMsBkicPWc0
 CxoEw92CczT70Sl4jx7kFwukAJxy9k3Z2e9b8m9Tc+lbLMojX2dHycu1wfddwgMWTXM+
 2tRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779813497; x=1780418297;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+neT3f/iOdkns4E+8cxUHIEwouFFRC5e7pB2NZRvaQM=;
 b=HGTRgPYIObcPyICHLTyASH7ELDlVMLLQveByznWXuL7umm+8HyRiwpBNMQxdEwNvNc
 INLscrK6A8SIf0Rpm+BlAa8n8XyiIxj2tc4W7n2/62FEQlQfltVAY/1l0shdU2OvOMPU
 GcCyzCYkunDwXtKNh8gT78OquagopLy4EGf8Nbd96453/SgRi34i2lGT27wCp5IXmJ+1
 adeulaSF4LJ+PlRaq38Pwl0OaSjJp1jfrAdWj5Q7rDi9ofbb0hKZ9pR2LYOmFuYWdpBE
 wp4iI5ZXDTaMCiYShivelBuQOSuTyJU1qw4+laRe+Mez0k1N5lmwDjRgyAbMU8iwnC4f
 oIQw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9qIKGROp5M37B5v+4hX3dDViFMni9WwGovZmmUThZoKQ5opRpfQWQaawLbErFMnZ0OUr5LFs18qLY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw+y2a2E5L0N2U3OeLmq8wVfIVghIuMtW7D0As1a+RCblAQELw9
 o2Bzj2T+AzjPRSUkO5wH1beenWLlVRUufydgAL+dRpvgjYyzleArrsyXBBIgAJXZCV4=
X-Gm-Gg: Acq92OG3GRM1ycK1O6o6d+rVHFJKIvg9qAEsR/1ITeapRUQHP//7BUyFj0dd2W9XWmb
 ZUTyqa6v7y7oyXdFbbt7AvOmSq0E6Fu63sPwpYGdf2+7DzUlY1f2oiJ5h9J7PIWbPzkjnB+slOf
 9mCdupIlSu+YFnNioPOx4kS1j+UliJDOWvl87jCGrv624ETcRamgBfYB4nBWgWCkr+c//6qZjbl
 3rjclhkrpOFjIzn34BlNq+bUq/awDT0NxMFhn2FasIZgqCaTKzNzmeAh8zqQAnmOnkbaeLdf4a5
 6e1BGwUuWfoPF6zd2kjJiqyMlJnjiDZ9G4uPTginx/4OqM1WbWz7GhKGg3s4cY8kYMH4SazHURe
 LjlV8W9IGqpPi/ZevW+mW46OkkSVsXqmb2ZBC8FzmHzRao3F2t3aX09wdMgEjsOLBy0AaHR4Mu2
 JUNuAf/i29/aJGuSvrzOOYP2J9YODBWxTiWfLEGG5KQ9t+2GSqrUkJ16cEwP++VYTGR9ToKIOCw
 kwUbfy6s8WjMKo=
X-Received: by 2002:a05:600c:4ecc:b0:485:4388:3492 with SMTP id
 5b1f17b1804b1-490424b25abmr314126765e9.11.1779813497306; 
 Tue, 26 May 2026 09:38:17 -0700 (PDT)
Received: from localhost
 (p200300f65f47db04a716d2bdeddb4813.dip0.t-ipconnect.de.
 [2003:f6:5f47:db04:a716:d2bd:eddb:4813])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-45eb6d493dfsm37901229f8f.23.2026.05.26.09.38.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 09:38:16 -0700 (PDT)
Date: Tue, 26 May 2026 18:38:15 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@kernel.org>, Max Staudt <max@enpas.org>,
 Andi Shyti <andi.shyti@kernel.org>, 
 Helge Deller <deller@gmx.de>, linux-ide@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, 
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
 netdev@vger.kernel.org, 
 linux-i2c@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 "Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>,
 "Christian A. Ehrhardt" <lk@c--e.de>
Subject: Re: [PATCH v1 0/8] zorro: Improve handling of pointers in
 zorro_device_id::driver_data
Message-ID: <ahXMGtBv_pQXM7YS@monoceros>
References: <cover.1779803053.git.u.kleine-koenig@baylibre.com>
 <CAMuHMdUVoNg-rSV_hDcvi6KCosmE=SMcxUj2Y8fkoJ=33zMSXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="26ssrqftvvoyehs2"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUVoNg-rSV_hDcvi6KCosmE=SMcxUj2Y8fkoJ=33zMSXw@mail.gmail.com>
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


--26ssrqftvvoyehs2
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 0/8] zorro: Improve handling of pointers in
 zorro_device_id::driver_data
MIME-Version: 1.0

On Tue, May 26, 2026 at 05:01:48PM +0200, Geert Uytterhoeven wrote:
> Hi Uwe,
>=20
> On Tue, 26 May 2026 at 16:17, Uwe Kleine-K=F6nig (The Capable Hub)
> <u.kleine-koenig@baylibre.com> wrote:
> > this series is about improving the handling of pointers in struct
> > zorro_device_id's driver_data.
> >
> > While it's ok on all current Linux platforms to store a pointer in an
> > unsigned long variable, it involves casting that loses type information.
> > This can be nicely seen in patch #7 where after profiting from patch #6
> > the compiler notices a missing const.
> >
> > Preparing for that change, all zorro_device_ids are converted to use
> > named initializers, which is also a nice cleanup that could stand for
> > itself, as it improves readability for humans. (That is necessary
> > because an anonymous union can be initialized by name, but not using a
> > list initializer.)
> >
> > My motivation for this series is the CHERI hardware extension. With that
> > pointers are bigger than longs and thus you cannot store pointers in
> > zorro_device_id::driver_data. So this series is also about getting
> > support for CHERI into the mainline, but I hope the clean up effects
> > mentioned above are justification enough to accept this series.
>=20
> Thanks for your series!
>=20
> > The dependencies in this series are as follows:
> >
> >  - Patch #5 depends on #1, #2
>=20
> s/5/6/?
>=20
> >  - Patches #7 and #8 depend on patch #6.
> >
> > So if the ata maintainers agreed to merge their patch #1 via scsi, and
> > Geert agrees to patch #5 and that it's also merged via scsi, patches #1,
>=20
> s/5/6/?

Yes, indeed. And I tried so hard to get all the numbers right :-\

Best regards
Uwe

--26ssrqftvvoyehs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoVzHQACgkQj4D7WH0S
/k4BXggAoAuTCgxPow5/rQYRxSTj+kNc4XmxhIlX39wkjq4KJoBOkfK1zOhQISV1
4HHCqWa9m9dov4bu6Kg8LwbKa2UChzh7HIDanvg0FuTjuR2DvZAqQ1h3KlZHQj4H
Dh1fxxwA9H2mAUN8tHgeBxUVZ6qajflOjKFHpsQbdgTyoj2LkR1szY77e5P4QdmS
0UJbs5rWuTPA+ErMqqdl4SkAygYx8SEw84ch7byHO4yx9rpUCp8zJk95dKJCgAir
L38wVLJUZNR7sQVkPKakWtv34niUdKWjqIXa8yB4GHOQFX65uFKEzrvodPCyE2J/
vgh7fbUvdt3OqTL+DpSduQS2l1F1qA==
=W3Nr
-----END PGP SIGNATURE-----

--26ssrqftvvoyehs2--
