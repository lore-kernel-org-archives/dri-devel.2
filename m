Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51FDEC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 08:52:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F05310E477;
	Thu,  2 Jul 2026 08:52:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="ZgDkGxEH";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1696F10E477
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 08:52:34 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-4758b2a9e2aso1005299f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 01:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1782982352; x=1783587152;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aElLLGay9xB16xeANMb8tta8IpzpcumQhgPLm7WpnQE=;
 b=ZgDkGxEHRS4EEqPmXlL6ElFcEB1m8cM53cK6ZfyhLPtamtjg/xLmJNnnZe8cOFxDBz
 LfNUfp8A0T9t4k0C55hMKRiJH6KLCSvPgE39bWMtbDtiHOoNwTsh8zW4GVZlXB5kMd1V
 u+/xJ3WoBwiQhzxzd4PYQ7onLjIP904HOeNnxKWplZsMh54MfaiH/11n96E2KIpAlswb
 H8mqtAaOfu3DLaoOBNDOsWR2Njuwrymd2j42JxoCRvc6wSQEutOTC/ay2ynfJfigyNau
 9GFJLuEPfne0mjx1fftQ2tOdaHePVg5XryAISJLBH3sZMh0dWHuMZODUDO5hdDJmQSkV
 mbqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782982352; x=1783587152;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aElLLGay9xB16xeANMb8tta8IpzpcumQhgPLm7WpnQE=;
 b=Wwd0+vMKFafb/nytjGZCnznc7llLqP446R4iUy9stNssi+KXYRbfDQyU43SyoThFw0
 WvJfD2g8e0ex9HppczFdr14IlpUWcTDfrh3t8Keja0XCNY4HwlGA8rJO6X6d0Mzq9phd
 DOybzFHvRNkKsXUwGFhhvCfuLriH4+xulbFBg+ssMvmQSNcI0VGvoaA1tdBkv7s3nH97
 x6U3pNg6ADeWWGtWmd5cNa1MieSJ12F9Vg7ReUW1wNoleW0E1NPnrRZo40DHaVMeBuO6
 Hn9f/McvytB9ixGTnwtlfm4mm1FkQBUZuvnCYR4CQYOjt+qHoDaJa1DFZJ1gxeazdr5J
 kdqQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ror2dVlywrThQ0Pu/9KrP+vMn3rL7skK0AHNaB60/SSBXu/Sqo/N06ejiNv5rHI8GXf74aDXe3TnrQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyOOsIRPst+pA9RvFu5964y3VnsiWQ5g6eGkHK7DdVBmM1P+k5U
 TQtgLm7C8jgjGrCvGa8Uyn/R5mcg1Qpy2BtSszJQAsxEhHPORKpfIZSBWZX+ZFOVbh4=
X-Gm-Gg: AfdE7cl6qWuHcT9Nk+NtMzsWZjMeONxpLTHrPn7NsI9V0RhR03HAkpM5/ANJT87n2lI
 nRaSdbefSWx0ISxjPN4syJedYIzj83APNtfm3EYcbsZGZ2wkFbHBXlbyqvZ6waxxO93Zal3mMBl
 rqPRPiAXn2JQ2RRp34aerra23muYWZHMHu0Pubs+BirxAWZOz1gosawGua/RfYs3ej7ppLtTAIn
 J1rfAVTGDuF+JB4PDVukRwEQ00v/ZfP3g4H7XHNRYAs16CCXb6A8yeXm4kOI7eVqtlW0bbFyGw1
 MgvRGuASgXhzShOw2RiYVquQg+EgDq3A+XmwSmmscxxBKyGqtL18dlWua7Nvl1d7d0xOb42sroI
 Yg6jDj6FQmMKQyrGj5gVPeYaEHI6H7KP/Rf6YJwAsEl/UCKnsobaMbO9mh6yzTGnuAd74FutD6f
 1IttG+W0gpzG2aGvU36A==
X-Received: by 2002:a05:6000:260c:b0:475:f0c2:5b05 with SMTP id
 ffacd0b85a97d-4775b64ba1emr7587656f8f.59.1782982352189; 
 Thu, 02 Jul 2026 01:52:32 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-477dd94c829sm6684131f8f.24.2026.07.02.01.52.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 01:52:31 -0700 (PDT)
Date: Thu, 2 Jul 2026 10:52:29 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, linux-hyperv@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/4] drm/hyperv: Explicitly set subvendor and
 subdevice for pci match array
Message-ID: <akYkWQzXIo-y3n4J@monoceros>
References: <cover.1782925276.git.u.kleine-koenig@baylibre.com>
 <019450ffb519d02821364afca32b9f48bcd8d2b6.1782925276.git.u.kleine-koenig@baylibre.com>
 <7a747d47-d275-48ad-a4ea-1e4897df1d28@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sqfonh6coq5d6ttj"
Content-Disposition: inline
In-Reply-To: <7a747d47-d275-48ad-a4ea-1e4897df1d28@suse.de>
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


--sqfonh6coq5d6ttj
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 2/4] drm/hyperv: Explicitly set subvendor and
 subdevice for pci match array
MIME-Version: 1.0

Hallo Thomas,

On Thu, Jul 02, 2026 at 08:43:32AM +0200, Thomas Zimmermann wrote:
> Am 01.07.26 um 19:05 schrieb Uwe Kleine-K=F6nig (The Capable Hub):
> > .subvendor and .subdevice were set to 0 implicitly, so only devices with
> > these two values set to 0 in hardware can probe automatically. Make this
> > requirement explicit.
> >=20
> > While touching this array item, also make use of the pci macro designed
> > for that case.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@ba=
ylibre.com>
> > ---
> >   drivers/gpu/drm/hyperv/hyperv_drm_drv.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/=
hyperv/hyperv_drm_drv.c
> > index 2e75fb793495..e766d87b7a9d 100644
> > --- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> > +++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> > @@ -51,8 +51,8 @@ static void hv_drm_pci_remove(struct pci_dev *pdev)
> >   static const struct pci_device_id hv_drm_pci_tbl[] =3D {
> >   	{
> > -		.vendor =3D PCI_VENDOR_ID_MICROSOFT,
> > -		.device =3D PCI_DEVICE_ID_HYPERV_VIDEO,
> > +		PCI_VDEVICE_SUB(MICROSOFT, PCI_DEVICE_ID_HYPERV_VIDEO,
> > +				0, 0),
>=20
> IDK, but it looks like an oversight to me.=A0 Setting the sub-fields to A=
NY
> seems like the better fix.

That was my initial reflex, too. However while writing the commit log
for that change I noticed that since commit d750785f305e ("Staging: hv:
fix hv_utils module to properly autoload") from 2010 (applied to
v2.6.35-rc4) the driver never worked for hardware with .subvendor !=3D 0
or .subdevice !=3D 0. I cannot believe that something like that is
discovered 16 years later by chance during a rework by someone who
didn't try to run that hardware. And if I understand correctly, this is
emulated hardware and so I guess used quite a lot.

Best regards
Uwe

--sqfonh6coq5d6ttj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpGJssACgkQj4D7WH0S
/k55cwf/UJBZ26bD2BNncRiKxBadwLt7x6gNyMi02vNafvcP5U6SmmmXCVTWPNxg
21tfbjDQBmk+B4wGTrcyLJLNWhh04x0o3nvE3aGMX4BjXOJR5LCdexnIuby3mLKU
A8JQTJKyHu2WdtRT4aLITjAE/4g5rYoRzH7UV970O4k1JjRYCJivjRMTpLzNQLYC
ZUA8AkZ9eFlVbt1yPzcrR/lpzk1V8zWQWRHjK16ZGVZpdFA7v2/GNcZTvoYcvZCP
e4jtKrKnSJr3Wwp8sfcEjLHtXlo2EL0GjatENsnFYdb7oyrQxXoLQ0G4EBxy9I37
JtoxY9CMlHLAsBUDt0gv/ecgN9xosg==
=QzVa
-----END PGP SIGNATURE-----

--sqfonh6coq5d6ttj--
