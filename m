Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6812CD8CB9
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:56:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 061D910EAEE;
	Wed, 10 Jun 2026 16:56:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="KrXridSX";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9493F10EAF2
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 16:56:36 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4905529b933so75223615e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 09:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1781110595; x=1781715395;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wDGhghAvzNX5ObVecH4+CcJJHr84yhCjxW5gZJDsxQE=;
 b=KrXridSXfJoljgVGQlq8IDJyecmzrvhRW5ckeV1i7gdBDuEnIYoRDskCEuexqfi+es
 Cs1OwBf1wtrNnHJSw91+swyDswzVftq5X4nr+QOJMF6j/c+ugjqYrlvefotLjtceWmiE
 rz4rGirplyA//oDHz4h7jSnWre0VKEgbmfZUDovQWhWOVvkiaqLUbG7Aq4629wanIg/3
 76GWi1IIngIbXYz+bzvu2ZSAf4TgjcpxVcjwdAs8+K/rskBtsBjOjnMSiZ/kzyg/pe44
 R5aA0pS3uYc/UP0eBlQLb41IFENAQF/S7rpHOEC4IUqO0WBXimVNIWPmmci7oSgnt3Rt
 HEPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781110595; x=1781715395;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wDGhghAvzNX5ObVecH4+CcJJHr84yhCjxW5gZJDsxQE=;
 b=K023cDhA6PeV9HMlA7gpfBjE4KOWQVLo8Co/9QAMQiepiqKdH9YwTCUt/+T35QPca1
 NWZV/uaK34l4vw4UO9Jr8EGIqKU+gubDfowNVm9fDmsM+7QsmFcb3i7krsyn58c51Zfm
 STMUhk6kSpqLqWWLjP97FcJ+v1prn4DnYZvhy2VSHzoFBV71czDSJR5ckmm3PS0IrjGa
 Ti1z6+OOlxi3xLCsz9FnkAWV7pYk4mIYHmiycjLwShP4RpfYvy3mb/pGGjPk/X4dP5/M
 oe6jYks1uB42018h8WZbl2HHdIHhnBxlU+asAF62piAYTYD2UvgiCapsXFjo+LVQpAcz
 9Low==
X-Forwarded-Encrypted: i=1;
 AFNElJ8liiothe+xG0BsQnnYPkBfwsQShhRHWT6J0KDm9Po/7ubJeJC/HWwcLmvME48bKjt2CRH3NnX5MtM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwvMy36m3o401YrpPcqHH2FruPvSbdmCPy2a79QhWjc7GWjmntx
 dbNrpl5u3jULim1iclCyXV86utaIdkE05q+tj82NGRVhtqv6DTpBVPfSDaDdnhDArpM=
X-Gm-Gg: Acq92OFRvE674M6fNGaypM9rIPtpIIjA9k+pphiC24K8xbVhmoz4b6VtgGclRRQmObS
 4hobA0w4TRPZ2hz/DdLCxFDd0zD5QlFPhntMqYfgrDRFivaHMoXJUZOx52AuwIbwwbcp3/tB3HM
 Ogww47xNCFefK7WcCoBpUD6MYDv1izZwGjmMdj9/80JFvgD9Q67b1Q0u7WbreVhqwT36P9qlv8A
 Ntn2qavFlsSTHoKNTC886/VnIglC1o2VqGn8oviX3D+I+lskaM/DViMVPlSp0O1vASgL22iQv4X
 oQhhSOEjQ581QOuaI2OaWg7EcAQ/+nlC+AuNxgMicpkVMJ0StsIrWSvXeikcU1HTBHbJvZFOrYH
 N+3VsxJ0imkl34QNXMI04sqCslc4XNARP4DfQAb4dQ7SbZuf+Hto8ib/WlU9T0vPUHU+gtmPYNj
 QUA1LImWkksaW8+OhkH66rlzFbNpziELHCczNzflR8brSuv7NdgbMltkw7CCtoLBo3VwMqp5tAM
 x5c70v/+5+0cpuOF1MA+asMGw==
X-Received: by 2002:a05:600c:a00b:b0:490:b58b:a8cc with SMTP id
 5b1f17b1804b1-490c25d208bmr392108225e9.29.1781110595179; 
 Wed, 10 Jun 2026 09:56:35 -0700 (PDT)
Received: from localhost
 (p200300f65f47db046aec8c3a4b621e71.dip0.t-ipconnect.de.
 [2003:f6:5f47:db04:6aec:8c3a:4b62:1e71])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-490e2ac08d4sm1254095e9.1.2026.06.10.09.56.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:56:34 -0700 (PDT)
Date: Wed, 10 Jun 2026 18:56:32 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Alex Deucher <alexander.deucher@amd.com>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Markus Schneider-Pargmann <msp@baylibre.com>
Subject: Re: [PATCH] drm/radeon: Consistently define pci_device_ids using
 named initializers
Message-ID: <aimXCmtgcejwInNg@monoceros>
References: <20260430102958.136859-2-u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="j7i4oay3bo3iievo"
Content-Disposition: inline
In-Reply-To: <20260430102958.136859-2-u.kleine-koenig@baylibre.com>
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


--j7i4oay3bo3iievo
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/radeon: Consistently define pci_device_ids using
 named initializers
MIME-Version: 1.0

Hello,

On Thu, Apr 30, 2026 at 12:29:57PM +0200, Uwe Kleine-K=F6nig (The Capable H=
ub) wrote:
> ... and PCI device helpers.
>=20
> The struct pci_device_id array of supported device was initialized
> by list expressions. This isn't easily readable if you're not into PCI.
>=20
> Use PCI_DEVICE* helper macros and named initializers which is more
> explicit and thus easier to parse. Also skip explicit assignments of 0
> (which the compiler then takes care of).
>=20
> The secret plan is to make struct pci_device_id::driver_data an
> anonymous union (similar to
> https://lore.kernel.org/all/cover.1776579304.git.u.kleine-koenig@baylibre=
=2Ecom/)
> and that requires named initializers. But it's also a nice cleanup on
> its own.
>=20
> This change doesn't introduce changes to the compiled pci_device_id
> array. Tested on x86 and arm64.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@bayl=
ibre.com>

Similar to the amdgpu driver patch I just pinged, this patch would also
be great if it made it in for 7.2-rc1. Please?

Best regards
Uwe

--j7i4oay3bo3iievo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoplzwACgkQj4D7WH0S
/k6nhwf/ZR7t94IMy/YBqi6Y8FtHqpdDkwZQQv11BcXWULYNcavX4/q4cA1Jtdd8
C4r3zAf5g//QeQP++hduZ4/5b0aQTz57FVJYbQNwN7Q1pYDIieIRdqk5iSL60/fa
LKFWkXWES4SULEBeCHUJf1o51p9se8eI8a7hCUJ7JeoHpJlb406H8ei21SNzauEy
7ttwNW25irCTEZSEDm8vpoQ5pxLLFC1S6eRdo0v4WpbDMYyjFhN0RJlg5MqQpEK/
VoWGUzqTrggL7AyozMqLAbg7PkPDJJMbNoLF97PPf8NRWrdBsGH/2nAUjxHJgZ9K
ol05cbNMBcNSQNGYdo82mJzhQKt6Dw==
=1EG2
-----END PGP SIGNATURE-----

--j7i4oay3bo3iievo--
