Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A16A0CD8CB9
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 15:32:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB74610E158;
	Tue,  9 Jun 2026 15:32:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="I6WceBb+";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E6E110E158
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 15:32:04 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-45eec22fab7so2942936f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 08:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1781019123; x=1781623923;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Y8s7Qwnb7/jxBSgOlg8nCSNxOUU5XDQ7ABL6iYYnpM8=;
 b=I6WceBb+zMbVDMTx7sVNDyfDMd/8/LN8oSV48iUmUCkNCcbMquaQH9byt/jX7DbTJP
 +4zbE9NFN9ZSOqx6S4LwGkSfk8NByj65K/QtB8O9Z14US10rzDkrwePryQII/TxqG9ZJ
 2Z4VhQJxbiU6woNU+ONdBFcyrjPCNn+KMB4CNRlH1VAeoyoiNIbYhq05+bHYr2fUIiQk
 30ptIfG8mC/QONe9FtiGTRffRWYpRPYQ1o54TCZenqAyEqtfJ49+bIm3vpVXGK1mtONZ
 Vksx9QQm0cXNn9dcP/JO4kDnVhyW6JNYmjdvbdtX0N3tL6WM3g8XYsE86VDymc70meSu
 uvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781019123; x=1781623923;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y8s7Qwnb7/jxBSgOlg8nCSNxOUU5XDQ7ABL6iYYnpM8=;
 b=otAsjtTsaecq0idQDc9tHMmPeU7ijez8ZQRmM0C5ShIc3iahnIyKXgOzYmLXQ4IdOw
 q3wwlDiVupTEFieKh7tF0UgsthFp0NgAXGXIdBr5kWGtLhOUVnHvPLY/7PXZaertBiGH
 1rdRjyztuLEiI7wzUYUwxxxLBRNG4D3Od+vAQhTKOt+g1MDE6FgrcSRDGD3aI6aUbp/C
 57Kv440lre9BhrPjR0pOyQPxzK6JbOFEJCl8E8hII2tniXImXOY3EWpM3+F4qPy1v1bo
 xrR7p8hvwVkecDFmEHv/i7On6iqYyvTM0UEz+TpcL/+S/A1Eouuyn3NZmAcHKrs+4rR6
 FURQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Luf8W8r78g9sXVYCWB+D3hiqkemUcbk7K1b0bIencw/KQH7wDEH/gjVxC21z2JvUri+Yo2xP/eL4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyt+6m8eP4U8sV1W/tyd2W06LBPukELFuxOnmyisQAZ1MNTu7zz
 FSEHLstNSVWP7+QkiuumSHiOYbiTY8uRu6kwgEvERWFr/tlF/LSACSfE1ZAiXbxHQiM=
X-Gm-Gg: Acq92OHtipYimn4wQFS5BgKzPK2JAMBakpmTkYUPGd9A9dwH4PaFh+gohMJ8r3D9i1u
 OnKLvenKl4LqCQ9Bo9ZDEEVV5fAyor06/U369ZEc3y0MG6cx4U6pm4HKk8yPFvw2mbbjURo1/p7
 Z7JQa8Ap9B8tEPGp5DRvCvxbGmc0m8Thh/1GHNLsLWG9iptYIrt6VEQQ5VTY6GaElSocS7WhqYo
 g2oT5wMAWIDiqxNUIaC0KS4BF1HK0sMoWKeVF7fZii1Wl3uXTGSmBSsxaK8UTuLVoZbnURoBIqY
 6xc3QyvxC+AEjomkbL1S3rD84uXV2rAY2EWLo+1h51x5/qwQmFKbRdi1QgM5AhkwpEa7DXa56+l
 IE8GXR+9FC3NP0PWuHSUxu3zgIz7DeuOCoLB9hop9e9tVkBYe3gHeGFXla0p1Z5rf9Z4K/+KSA/
 TFaJZ+aTkWMKQpjnHAimdU45s85pn1eR9GedZw4txSWr4TpUX5ZimirA4NRXD2S2Fu30puM6Nvh
 9lKMOybIXSOL927OF8Rc7QT0A==
X-Received: by 2002:a05:6000:4609:b0:460:3234:4472 with SMTP id
 ffacd0b85a97d-460323444d8mr28986691f8f.40.1781019123266; 
 Tue, 09 Jun 2026 08:32:03 -0700 (PDT)
Received: from localhost
 (p200300f65f47db045b0dbdd314d8a71f.dip0.t-ipconnect.de.
 [2003:f6:5f47:db04:5b0d:bdd3:14d8:a71f])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-4601f344762sm67967138f8f.23.2026.06.09.08.32.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 08:32:02 -0700 (PDT)
Date: Tue, 9 Jun 2026 17:32:00 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Alex Deucher <alexander.deucher@amd.com>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>, 
 Lijo Lazar <lijo.lazar@amd.com>, Vitaly Prosyak <vitaly.prosyak@amd.com>, 
 Kees Cook <kees@kernel.org>,
 =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>, 
 "Mario Limonciello (AMD)" <superm1@kernel.org>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amdgpu: Don't use UTS_RELEASE directly
Message-ID: <aigx2xn-59FmGw63@monoceros>
References: <20260428144704.1114562-2-u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="orjnrmynt4uzf4h5"
Content-Disposition: inline
In-Reply-To: <20260428144704.1114562-2-u.kleine-koenig@baylibre.com>
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


--orjnrmynt4uzf4h5
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/amdgpu: Don't use UTS_RELEASE directly
MIME-Version: 1.0

Hello,

On Tue, Apr 28, 2026 at 04:47:03PM +0200, Uwe Kleine-K=F6nig (The Capable H=
ub) wrote:
> UTS_RELEASE evaluates to a static string and changes quite easily (e.g.
> uncommitted changes in the source tree or new commits). So when checking
> if a patch introduces changes to the resulting binary each usage of
> UTS_RELEASE is source of annoyance.
>=20
> Instead of using UTS_RELEASE directly use init_utsname()->release which
> evaluates to the same string but with that a change of UTS_RELEASE
> doesn't affect amdgpu_dev_coredump.o.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@bayl=
ibre.com>

Is this patch still on someone's radar?

Best regards
Uwe

--orjnrmynt4uzf4h5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmooMe0ACgkQj4D7WH0S
/k7C6AgAk5oykrj4mKghFtxQ6MLq7XvvDTtDyq6p1wIJK4mHnUAQbHKuGi0FRi/8
hmCko49bG+cT/A3VenZlq5ELpaPU0ve5+GsOaiGwUJ9LCSvGRRIst42AVcastH8f
ev7B6v5WopQxxY2DUrA+k1MiQSkS+23vNy4bnWq7DnR7Ao4+8NXamZbqluIdp4b+
C0JDIPX+idjM9u5CwJDQyJyluDQiZ2ucc0SplXzocf+qT1+dTKshcYprC4IZa9b9
Aw+mvPDiVzKZWSPtDpgCOGRZrtX5b5cRPzMLT4+A90OeNO0RvxX+KL81GcQg3tOH
miEughCuvcVaS4xTYiILVCgK48uPTg==
=Wrer
-----END PGP SIGNATURE-----

--orjnrmynt4uzf4h5--
