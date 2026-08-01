Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E5DC54FCD
	for <dri-devel@archiver.kernel.org>; Sat,  1 Aug 2026 08:08:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B969910E2E8;
	Sat,  1 Aug 2026 08:08:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="p4AJxg2z";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE9BB10E2E8
 for <dri-devel@lists.freedesktop.org>; Sat,  1 Aug 2026 08:08:04 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-496b7622a83so3031335e9.2
 for <dri-devel@lists.freedesktop.org>; Sat, 01 Aug 2026 01:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785571683; x=1786176483;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BhbXt57FHs7QvkLjuDbwFmPJXue3peGLZ2pH9/2qYXs=;
 b=p4AJxg2zpmX/WQAoEEHA6cc8Dfk/mzmdeYmURixJGUaPjx9HC4E3Ck7plzKHzAommA
 5OGRZeB8lWpFMqpjatgquBuSb1gOGN1WdxO28ES84ikCCdh74R5VXTpQGoKXk7G82d2P
 xwlwvWZfw0XWXMWaQtk3vf+SLY82XOPysJgpvAx72VniC3nH4uyAWFOlhrFXR9hQpc4Z
 owlA26l5deAdsqXJABwt0fn8jI2iGbt0QyQf6R0ylXO2yzSHYdZjvKQfUY9kbWyUcGHd
 gVrqSC70sXxK97ukYYqObLzCu9tuQSS5KEPimtHch2oyCory2sDcmfrYTlxw3Rz6GSOw
 VosA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785571683; x=1786176483;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BhbXt57FHs7QvkLjuDbwFmPJXue3peGLZ2pH9/2qYXs=;
 b=EOdpo/SPYs3hf7qwaaUHDojQqPjJNgDw7JN7D5g/xCFNbPTAl0tQJ4ik5TwaxdZ1gX
 ZOl+1YD1mbPmZ9tn7Y7z4nMQPB1Hn5F6Gnw9skA4HVRSU4TLA7KO1KqvFb3W6l/F6oAQ
 0w7Ge94ZEEiP2A5pB4qJUGyPXjli9bWUZMxXMI9a0GTMYJoy61BwxjVjbpVNIT3IJxrE
 wt4N9lvC3EYe54b9xTJKCJ2DPXcMY6M+9jL1wMUut8ZaVvu4gMVIJOU3ByGYuOV+qlB5
 AZZEKwg2FvU1HXzLHqrMgA6K9NPI+FLsRAg6rtQSNTOxjdM6UrW1gBKr5NqH8BtTKKkg
 7xmg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoCrUA94iqACxypFOIK9Bv5teF4ncghpioy6UAslppYyAJIuNUn6r1npL3LxTOYGLoosLV0mkTLTc4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw9PehzWn4aJ15Vt9rwjESDDoOljjSO4xp52Xx3a8jril3d0VIB
 ryMcZbMEZiA5R7MfU0DoL4xvlv4Ih73HyG9J5kaitdkcK28ECCAUSA3D+fTamKNqjao=
X-Gm-Gg: AR+sD126iQM7tEA+Ws5uhas7KIosxv1qG6o9J9iFRIspOErQuqLPKiIjJrGwbn+qYHF
 kFur15lsXVqPcj/UI5nL0vxZWpB0e/N0EJa0lAM8EKJHQyVhqk8LjlapGPMf1AA1xCvMdfpceTN
 mDTrm9NsaZTb4sw9Su+vddCFP4M8ErAnxI26w1lPKnrj4GDy7B4c+Uw3scTwnoHKdBKmzFyW9Ow
 ITNOyGuP5Gbpp4SiYja1h5+uD4Mt9dHv1YEu2oV7TeYxNr1csmtc7tyFdkb22h01WeX+AIlD8uW
 +CoBbR8/E029g63/IA8nXeKOV9Jt6LQkGy7tyqAtN5NeCXbthWrkCoMjQEjGK8+OOZPe36jNMZ8
 LAwDPW0e78QhPCIOKDdtJaVGIv/stLK0RVuXEbwvPISjYwlwq3cA2JRrwY8hp8+b0JSQpl5XilA
 x8eLWJzzK6/OwUpJT6DKpYyFmbSE6yIpQBlgQEPQYq9fONkjiDffrkWqgY2wjl/cJg8g==
X-Received: by 2002:a05:600c:e48a:b0:493:bacb:1341 with SMTP id
 5b1f17b1804b1-4980c66b53bmr17150785e9.4.1785571682507; 
 Sat, 01 Aug 2026 01:08:02 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-49808191ef9sm37069725e9.1.2026.08.01.01.08.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Aug 2026 01:08:01 -0700 (PDT)
Date: Sat, 1 Aug 2026 10:08:00 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Max Pedraza <maximpedraza@gmail.com>
Cc: Helge Deller <deller@gmx.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>,
 linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [RFC PATCH 0/6] Boot logo supplied by the device tree
Message-ID: <am2mvECnCcO9IxuI@monoceros>
References: <20260731215043.30392-1-maximpedraza@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="y7euzt5xlmsr2onq"
Content-Disposition: inline
In-Reply-To: <20260731215043.30392-1-maximpedraza@gmail.com>
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


--y7euzt5xlmsr2onq
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 0/6] Boot logo supplied by the device tree
MIME-Version: 1.0

Hello Max,

On Fri, Jul 31, 2026 at 11:50:37PM +0200, Max Pedraza wrote:
> Embedded products routinely need their own boot logo. Today the only way =
to
> get one is to replace one of the logo_*_clut224.ppm files in the kernel
> source tree, which bakes the image into the kernel image. Two products th=
at
> share a board support package but differ in branding therefore need two
> kernel builds, and rebranding an existing product means rebuilding and
> requalifying a kernel for what is purely a cosmetic change.
>=20
> This series lets the logo be described by the device tree instead: a node
> compatible with "linux,boot-logo-clut224" supplies the image in the same
> paletted format the built-in CLUT224 logos already use, and the kernel
> prefers it over the built-in ones when it is present and enabled. If the
> node is absent or disabled, nothing changes.
>=20
> The image can come from the node itself (patches 1-2) or from a reserved
> memory region the bootloader filled in (patches 4-5), because the image a=
nd
> its placement are independent axes of variation. One board sold to several
> customers wants several device trees differing in the logo. One customer
> with several products built on that board, with different panels, wants t=
he
> same logo placed differently on each: there the image belongs in a shared
> binary and only the placement belongs in the device tree. Patch 3 adds th=
at
> placement.
>=20
> We have been carrying a cruder version of this downstream on an AM335x
> product since 2020, across a handful of board revisions, and it has remov=
ed
> a real maintenance burden for us. This is an attempt to find out whether
> something along these lines is wanted upstream, and if so in what shape --
> hence RFC.
>=20
> I am aware of the contentious part: a bitmap is not hardware, and the dev=
ice
> tree is not an obvious place to put one. The argument for it is that the
> logo identifies the board in the same way the model property does, it is
> available before any filesystem is mounted, and it is per board rather th=
an
> per kernel. The argument against is presumably that this is policy and
> belongs in userspace or in the bootloader. I would rather hear that
> explicitly than keep the patch downstream on a guess, and if the concept =
is
> rejected I would still like to know whether a smaller subset -- say the
> placement properties driven from the fbcon command line, without any image
> in the device tree -- would be worth submitting separately.

My 0.02=E2=82=AC: Usually you want to use the display using drm and not fb =
once
the machine is fully booted. If you're using fb during boot to display a
logo, it's hardly possible to switch to drm later in the boot process
without flicker.

So my recommendation for your usecase is to not use the kernel boot logo
stuff, but something like https://github.com/pengutronix/platsch.  Then
all the configuration is in userspace and modifyable using kernel
parameters. Or you create your own application using libplatsch that
selects the image based on the actual product derived from the dt
compatible or some EEPROM's content.

Best regards
Uwe

--y7euzt5xlmsr2onq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmptqV0ACgkQj4D7WH0S
/k6bUwf/b3R5nKZ+dHyzlIKZ+XN6rpMjgW3Dl0H1qu406Hg4yhjBwvx8FmRpc3W2
O6jYub6BAi5oZj+FpvzdR63pWRetwzGpigOqsGlUeGjjIrHbCJWONwOCAu3Q8ynB
CfnK2Hg/gWfPSbnzglGMcvjMnOkkBEV9c07rG72C7qPJClOD5n4qPQhh2TwlVHuV
w2uooARlVezImhDjrexVlRSF8RfZ6tfpHG7Tvingt92i/AnRVb233p6a+8cb4nbY
VTJeBWgsBPTUYC3OQYjgqtHPA1ZE+G6ZZCukwZii7myk+Y7Xdf4EaYVnnI69vrGM
4yeJ1GaCsfsBHz5Himv00/m5LkZR0Q==
=xd2+
-----END PGP SIGNATURE-----

--y7euzt5xlmsr2onq--
