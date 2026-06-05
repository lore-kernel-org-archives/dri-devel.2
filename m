Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC757CD6E7C
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 11:56:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48F8F11A7B4;
	Fri,  5 Jun 2026 11:56:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="THKcg5Hn";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF44C11A7B4
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 11:56:22 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-490aebf33e9so10172795e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 04:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1780660581; x=1781265381;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+kMxhX4dP4R/LjY4CwrRq2xMY3d+unBriPLMp8xLnLc=;
 b=THKcg5HneS4+jhRN00U/zis1JwLOcInRibkPoz6dTm7bILjix2GCsFvzmuXfAWQNnw
 l3g6F+FAyWhLmAbSnJM4SkFkLq2Km5LteU6ObDNxaVJBMbn5gYwbQWwaJAdpTNbg0SoH
 vFDzEt83nlLpBghmxyla3bGxqQ2BEG9eLu2ImEoVZ9keza8iYxR33Pe0SSwh9vQEZGzs
 0CqaFD9JNW0y7K3mgLOdU4DbfkIUrzmE0QDqg1Q+HwabvDLuzVug6bf1TlfLFP3MEUTm
 hU7ct9cwZwwOomS4Q97PurIcsT28cPJaBvRnDK7Qyw1qk4wIcrPQsUbQRP8TzXOpNQag
 67lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780660581; x=1781265381;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+kMxhX4dP4R/LjY4CwrRq2xMY3d+unBriPLMp8xLnLc=;
 b=QoPNtLcdQhdn4agNk/aT/ZwlLgK3OodUg58h7qtAGWDdMkW29tzYyJbowHYscOCEhc
 689ZLvkgq2ua7MZCoOLTLcK7hThh78CyYsxFWALxOI/RRRZH/0iOOHpIeRkkVnDG5hlH
 FjS3+PX7piKbeFph752Enwxo+eyFMO8u6SXLLfDoRgbpiB0858jHpu3dF8KfA188jy8A
 ItunMIxJ5JJVh752RneLp3EfMJ4zbM2jGnoifd20e+MFR7cAv5cDm4UeFmuCHikfPHGu
 Dn6lcI9ff5OuhULAuq3ywCaNHRSjbZiH1vrePnxjACGuHsAzYgTs8Mi/qOdLg6RiMOoh
 LYdg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8PsgT8GIBMWtMIPASnnK8B/CkD7qgxwouMoVGYHxnqeyVvS+YqjXX/Bzn4PSNzIWu5O7Trl5OpaW4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy8HbYKgvCKk3kg+MmAmjU1CuEfCDXZ7cNKZx0hge95dyLgExtG
 BydksIbJQJCV0HMN9n50z2rmZbojrIkNUc4ZuSAMF8Irfa4NKZZeXiqWwyUi1554SZo=
X-Gm-Gg: Acq92OFQOyixmD3K3nsoM4ff/uSaUjq1Wwuqef/JOl1PbtMGfpZb/25PVMPgsFlxS0R
 +IOc5iaUX4p53KNziSLzMQkeeuFj6ltFdlHStQMMAO1qJEQ5qNdBVgsYbeoZm6+zv8k1bQHMRBT
 JSn4MbsBQkm/RKT6g414Ys6nmTEWyyjLsIuJNG8id8kXAORsj/nGfFYhF9l7tbkVQIoIljF35K4
 EXB97Z7qdyxBW46TXZ9g/zHA9adr1EC43gJkvomon8AxuWKCT7UT0nVaF8vRxFrh9Z8gBEm6aNw
 KVPt5NU33tfyrWzHMq1+65HS0qksoQf2I8O7qIIEoM24dHG56rkqw3Www991AcAvpv/tHncs/Ut
 3BpiXEjutjvEId4pnghUfTnXCYAZzMK0MflIzBnf8KzKl0iO2Jwg7rTCEgmYlAZsCPZOa3XgTkE
 hC69YqR/mTKXt+UdiPsxxLOVMh6tUG6uKq
X-Received: by 2002:a05:600c:8705:b0:488:ac01:72de with SMTP id
 5b1f17b1804b1-490c25898efmr60737855e9.5.1780660580944; 
 Fri, 05 Jun 2026 04:56:20 -0700 (PDT)
Received: from localhost ([212.133.41.47]) by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-490bc3fd502sm147344695e9.11.2026.06.05.04.56.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 04:56:20 -0700 (PDT)
Date: Fri, 5 Jun 2026 13:56:17 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Helge Deller <deller@gmx.de>, 
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-ide@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
 netdev@vger.kernel.org, 
 linux-i2c@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 "Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>,
 "Christian A. Ehrhardt" <lk@c--e.de>
Subject: Re: [PATCH v1 0/8] zorro: Improve handling of pointers in
 zorro_device_id::driver_data
Message-ID: <aiKyB-28VEg1kp7W@monoceros>
References: <cover.1779803053.git.u.kleine-koenig@baylibre.com>
 <a3f9e96e-3bbb-4cfc-845c-58649405a1cf@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="22tuv3cnyx6wf3bq"
Content-Disposition: inline
In-Reply-To: <a3f9e96e-3bbb-4cfc-845c-58649405a1cf@gmx.de>
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


--22tuv3cnyx6wf3bq
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 0/8] zorro: Improve handling of pointers in
 zorro_device_id::driver_data
MIME-Version: 1.0

Hello Helge,

On Fri, Jun 05, 2026 at 12:44:04AM +0200, Helge Deller wrote:
> On 5/26/26 16:17, Uwe Kleine-K=C3=B6nig (The Capable Hub) wrote:

Your MUA seems to interpret my UTF-8 encoded name as latin1 and
converted it to UTF-8 making my =F6 appear as =C3=B6. I *think* the problem=
 is
on your side.

> > this series is about improving the handling of pointers in struct
> > zorro_device_id's driver_data.
> >=20
> > While it's ok on all current Linux platforms to store a pointer in an
> > unsigned long variable, it involves casting that loses type information.
> > This can be nicely seen in patch #7 where after profiting from patch #6
> > the compiler notices a missing const.
> >=20
> > Preparing for that change, all zorro_device_ids are converted to use
> > named initializers, which is also a nice cleanup that could stand for
> > itself, as it improves readability for humans. (That is necessary
> > because an anonymous union can be initialized by name, but not using a
> > list initializer.)
> >=20
> > My motivation for this series is the CHERI hardware extension. With that
> > pointers are bigger than longs and thus you cannot store pointers in
> > zorro_device_id::driver_data. So this series is also about getting
> > support for CHERI into the mainline, but I hope the clean up effects
> > mentioned above are justification enough to accept this series.
> >=20
> > The dependencies in this series are as follows:
> >=20
> >   - Patch #5 depends on #1, #2
> >   - Patches #7 and #8 depend on patch #6.
> >=20
> > So if the ata maintainers agreed to merge their patch #1 via scsi, and
> > Geert agrees to patch #5 and that it's also merged via scsi, patches #1,
> > #2, #6 and #7 can go in without further coordination.
> >=20
> > Patches #3, #4 and #5 are only about using the same initialization style
> > for all zorro_device_id and can go in without coordination.
> >=20
> > Best regards
> > Uwe
> >=20
> > Uwe Kleine-K=F6nig (The Capable Hub) (8):
> >    ata: pata_budda: Use named initializer for zorro_device_id
> >    scsi: Use named initializer for zorro_device_id
> >    net: Use named initializer for zorro_device_id arrays
> >    i2c: icy: Use named initializer for zorro_device_id arrays
> >    video: fm2fb: Use named initializer for zorro_device_id array
> >    zorro: Simplify storing pointers in device id struct
> >    scsi: zorro7xx: Make use of struct zorro_device_id::driver_data_ptr
> >    video: cirrusfb: Make use of struct zorro_device_id::driver_data_ptr
> >=20
> >   drivers/ata/pata_buddha.c             |  8 ++++----
> >   drivers/i2c/busses/i2c-icy.c          |  4 ++--
> >   drivers/net/ethernet/8390/hydra.c     |  4 ++--
> >   drivers/net/ethernet/8390/xsurf100.c  |  4 ++--
> >   drivers/net/ethernet/8390/zorro8390.c |  6 +++---
> >   drivers/net/ethernet/amd/a2065.c      |  8 ++++----
> >   drivers/net/ethernet/amd/ariadne.c    |  4 ++--
> >   drivers/scsi/a2091.c                  |  6 +++---
> >   drivers/scsi/gvp11.c                  | 17 ++++++++--------
> >   drivers/scsi/zorro7xx.c               | 16 +++++++--------
> >   drivers/scsi/zorro_esp.c              |  2 +-
> >   drivers/video/fbdev/cirrusfb.c        | 28 +++++++++++++--------------
> >   drivers/video/fbdev/fm2fb.c           |  6 +++---
> >   include/linux/mod_devicetable.h       |  6 +++++-
> >   14 files changed, 62 insertions(+), 57 deletions(-)
>=20
> you may add to the series:
> Acked-by: Helge Deller <deller@gmx.de>

Thanks!

> Since it touches various subtrees, I assume you will merge it though your=
 tree?

Well, my plan is that the scsi maintainers pick up patches #1, #2, #6
and #7 and I remind you once #6 (i.e. the dependency for #8) is in
Linus' tree. But with your ack the two fb patches can also go in via
scsi.

To James and Martin: I didn't hear from you about my merge suggestion up
to now. The other affected maintainers agreed so far that (assuming
you're using b4) and interpreting Helge's ack as agreement that you also
pick up the fb patches, you can go for

	b4 am -l -t -3 -P1,2,5-8 cover.1779803053.git.u.kleine-koenig@baylibre.com

If you like I can also pick up these patches (then with your ack please)
and send them to Linus for the next merge window. Just tell me about
your preference.

Best regards
Uwe

--22tuv3cnyx6wf3bq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoiuV8ACgkQj4D7WH0S
/k6cwgf+IBJ8XPNUSo4d38q7fIjSN9Kio+eF/i1F0XZFkTXu/snZAgAhVec4a9nQ
0tReoiNbPZL5k1kFhyjqoVSmH2A6Oe8hDK/rHeszhxosEzgOuGyGVmM1cDKfUkNQ
+nhcan81Bf43fZgyFWoOlxns+20U6kjBBAksZHGYgm6L41w0tjVYLHTN9Pv1jTWz
TK+k3WMkM0Sln7O6Rk2DBDBNJ8/lz82tGZkcfgmaM8P8WffD91LeUDcXvTBNYFJR
9P0mISJgM+Qt5WaJwzW0k/h0Vu3HPh3P3wPIGiYQGLV7jfcHFG2xvWIwxONopqV5
MD78q/W31G+Q1Z796Ms01uQxrzyWaQ==
=ZKbW
-----END PGP SIGNATURE-----

--22tuv3cnyx6wf3bq--
