Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96860CD98E2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 11:00:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C26DD10E5A1;
	Wed, 17 Jun 2026 11:00:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="Uaywdnh+";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5144010E5A1
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 11:00:01 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4908b92904fso69820835e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 04:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1781694000; x=1782298800;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YxKh8I0UMSkrnZV+aGOFbOS2uZGvOfyS/QrDhlucjm8=;
 b=Uaywdnh+Qkx8nFBWKVVAcWJoUTGKEofgTI3RcfiosIPpHT2vS7wCCd0lLC/GLxr37Y
 yCgsikrROG5nuj6ffn9kCtyxOXEwmkYCETWN1Qj2kIkxuQ9qt1EBJbQXHJhuPfRTEEBa
 J+SnbF34Dfa1ksh3mAmc5Z5p5ylAVROL7ZlAxhqtSKbA9mKe2bxRPXjQ+hQh2FnarcTM
 c4h6G20TN03+mjb/dy8mMnqV3rhelYBiEPranbYN8SnY+k1d82lD0Fgkeve/GJhS1Lgr
 2h4slZa1TLOrZg32CdP9w3olUKD5+SbQRHpLdMal78HUT7Ij42csYFk3EdWeTPgv/EZt
 XL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781694000; x=1782298800;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YxKh8I0UMSkrnZV+aGOFbOS2uZGvOfyS/QrDhlucjm8=;
 b=C5A99ds0z/OESIp89feGj1FkNXX7/vT84mKL12nnMb7YR0C3ZR+N3158TkHjj/QSIW
 0BAoyvOJtCjWwecoOGFQCOwxgMKCbwGEZ8RVgCTwXCjE/br83PzARbEuh3FfdB4VmAFq
 dgTVha7GDcxw09svV5FBWbQBH7/ZTs/tNeS+G+nKPFIL5+PZS9y2j9Lq5/u9aUwMJpIQ
 gnjC/tYgwv0gzoaj1IQJWeFEEmOJG7U8wH9pZO0SOVzMVNa0gCXgiJuXPUNqKkleIsuY
 XGQ4DFZMk76TgFxe7+bZDOCuqoHAqOMdBmIo0VCyz5Yl2xHixm47MYULt+sWlC0kWOW5
 RUuQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9yJnypObGj7lgfkrHgAROojn4sS5SvpdBCm0qt2h11pR/wppd6mVt0iDkOZJC41mge9Xa1S590PSw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwicGMLntcVO3HPlHUT2wZto9dZv4/+miGPMFdMgcNqEOA9PiwF
 HWRHxZ/oWKS6F124ivUnVmt88P/km6DEOuUMAAoCd8XL/Ca/+JdKyG1C4y2ioZlINdo=
X-Gm-Gg: Acq92OFfg8fiAppsJTkbcHIqq39anckCIEspp8jKo9VxN4TLdIe1jmNiWb7muPkbFGU
 tMscZFBh+gbT5tpZJTz3/4Vv9rsOiy+q9huLoglLxR7atMj5PrUHcKq9zC2ka6yip9vPqMoXams
 zPFPdJko9X+OxaAAPecKzwJzaMepXrpyoHTzg2syhFhj1A6P6kxMYMyLS99jOvEnKq0OZ5S/+yd
 dQ4NuJOlNY+uN3TarQB8eYs2oumQUXHQabjUOjNTgY65Y1LiCWNWmREs9TkBoYMhAY+yKmwzbjg
 gm2/K7aSPQJ1sjiAMon6RQsjc5flqvuiJuPrKgkj9/dh+IBcWejMCetqr25TNu+AA8lljqFVpBP
 FPQtd1sktKlIi7DEPC/B5ky28jSgO1W6moPMnJz9CBM7+XWRjUb+FKj5OFLyKMvGLOqtF+2filp
 tjXYHTQECzoQ8qMZzCu1xGftYERI6yXf6x8/SAUGVmAyGRfIzDDNQHZbjq9eFIqQVzI5h71y42O
 f8MnsLUhUOcN7k=
X-Received: by 2002:a05:600c:1f86:b0:490:33b3:4be0 with SMTP id
 5b1f17b1804b1-49234127a4dmr40056925e9.20.1781693999653; 
 Wed, 17 Jun 2026 03:59:59 -0700 (PDT)
Received: from localhost
 (p200300f65f47db04bc2080ea3c93ea6d.dip0.t-ipconnect.de.
 [2003:f6:5f47:db04:bc20:80ea:3c93:ea6d])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4922f9cd140sm143803295e9.0.2026.06.17.03.59.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 03:59:58 -0700 (PDT)
Date: Wed, 17 Jun 2026 12:59:57 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Gerd Hoffmann <kraxel@redhat.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, 
 Jianmin Lv <lvjianmin@loongson.cn>, Qianhai Wu <wuqianhai@loongson.cn>, 
 Huacai Chen <chenhuacai@kernel.org>, Mingcong Bai <jeffbai@aosc.io>,
 Xi Ruoyao <xry111@xry111.site>, 
 Icenowy Zheng <zhengxingda@iscas.ac.cn>, Dave Airlie <airlied@redhat.com>, 
 Jocelyn Falempe <jfalempe@redhat.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, 
 virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm: Consistently define pci_device_ids using named
 initializers
Message-ID: <ajJ93BcJ8wT7NcnG@monoceros>
References: <20260504150537.2136760-2-u.kleine-koenig@baylibre.com>
 <b13678d8-1159-457a-bcab-ade06bea0cf8@suse.de>
 <bc89deb2-2a2e-41c5-8cd9-28b794020972@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wb7rzchjydq75p5e"
Content-Disposition: inline
In-Reply-To: <bc89deb2-2a2e-41c5-8cd9-28b794020972@suse.de>
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


--wb7rzchjydq75p5e
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm: Consistently define pci_device_ids using named
 initializers
MIME-Version: 1.0

Hallo Thomas,

On Wed, Jun 17, 2026 at 11:11:32AM +0200, Thomas Zimmermann wrote:
> Am 12.06.26 um 14:10 schrieb Thomas Zimmermann:
> > Hi
> >=20
> > Am 04.05.26 um 17:05 schrieb Uwe Kleine-K=F6nig (The Capable Hub):
> > > The .driver_data member of the various struct pci_device_id arrays we=
re
> > > initialized by list expressions. This isn't easily readable if you're
> > > not into PCI. Using the PCI_DEVICE macro and named initializers is mo=
re
> > > explicit and thus easier to parse. Also skip explicit assignments of 0
> > > (which the compiler then takes care of).
> > >=20
> > > This change doesn't introduce changes to the compiled pci_device_id
> > > arrays. Tested on x86 and arm64.
> > >=20
> > > Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub)
> > > <u.kleine-koenig@baylibre.com>
> >=20
> > Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> >=20
> > I'll merge the patch into drm-misc-next.
>=20
> Merged with a minor change to coding style in gma500.

Ah, you removed spaces from expressions like:

	(long) &cdv_chip_ops

That's fine, thank you.

Best regards
Uwe

--wb7rzchjydq75p5e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoyfisACgkQj4D7WH0S
/k4IaAf/WKwHqoBZKlZOBFkwYpxmnJKXcyGTkSX1s1Vl6noDw9E+DLSsNl23lLrm
l/HM6dvtSt99bkmVsETfPltX+t1/i7+muGo4o0cTI6DQIME/+XzGrhbc6KH4QRSI
Z/Q17qqeXJ8detwkJ6mt9pO/+IsiD9luh6GuB6cemPxU6DG0mzL8uum5OA7oeU/B
8E8aCTxY15HfmzY7y8+h+WN/kh1KTUiZ/em8fSX/fKNFfJXeIyBQXV0Ht2AtAEsR
dYqDqOsbZhkwK0MCJ2DjDI5uDa0UyKDSpwLTswdzrokmYDYgOzJ19bS8Ywr3kkDA
yv6uzfaQwaQwDUNFmmCHFpSLYDtdKw==
=sh50
-----END PGP SIGNATURE-----

--wb7rzchjydq75p5e--
