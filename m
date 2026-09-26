Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B08B8C98328
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 06:32:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2F6110E1C2;
	Sat, 26 Sep 2026 06:32:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="GH25z9vN";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A31C10E1C2
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 06:32:27 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912d391aso10832125e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 23:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790404346; x=1791009146;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RKnDzIDzmT8Fb769giFnrQq/6P1KJS3fV65UjMQ0CGg=;
 b=GH25z9vN5Oev+zHGoiH4LUwH7iwK3i7GhCYW1GLhHuIadEUQLvGBnkXU/q5mm03uzu
 sg8F4ng8uNCklVLvgWgBFS0Fe18wEZqcp5bXn4P2C6EbK5Ad5R1/D6B2QD6loRkklx+R
 N4mz6/R1pHxw+EahTE0M1ge00hd8ZN5fLwmQY3AnBHooGKlgm48rTf3m9x12rJpSdh0O
 cCF9J6P9oNLW6qhDVwG8M+EWpffcmXQBB0J+UjpIlk2usOgRcCgn6DAgxZTFLvsFmgBF
 VU0RhYcW4Ls2SGrGXdaWuzvi3F0jfDReexcB0hqALwGmUUVS/7fyR+U2IjtiTRcCEUvV
 U/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790404346; x=1791009146;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RKnDzIDzmT8Fb769giFnrQq/6P1KJS3fV65UjMQ0CGg=;
 b=pC9B3OwtyLzc8U7nI44N5R5Hj5I0+ZhzCcdjaYBCgKZnXIMGh/fwzl+h1rI0C9RlAN
 h7e4bAQXyA/wjLdxXF0dKvW545oQigPkMmUueJkPz9Mp4Ihd5tUBZWSPA7Ur+C4kKQuA
 owl/XrMWxMdJMMsRtfboJXqT++a2JWjZ2Da+kVKQ52aUb8Uo6ndNRrq6KAfH/bV1dhk/
 I0vFfNAZbuT9ii1zTLbBCID9epiVU64QxW4NG6Lwy6DgYQdwGjuLw1FQs+b2TqCZKxWE
 T4G4CchON7ELRHwFllHpQSWtPg7fjuLvrYYkLsD4qVVArdD+wi7ETR1ArOm/jKKhhT5I
 PjvQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByTa0zLW4uJWjnVHUjLXKNKsGLu3hr2z7beBZ8o00BPTaHW5552y5QeAuPhvUk3z16dP9mrNh/y1XQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k5J/8WI6VKmo8ceyc0+S5OU/ef0EsZdi0UQOYXmEnjBYoRbdOB
 qLkk0LaVXNy5rtYtjwfeiMT5Y32eq39kMB9kgzJMmRDhMMKfARDAHN/6dBzirx5DxL0=
X-Gm-Gg: AYBFou3vXc5/5ELldPJQlPEsi5reXBwSrXCNdNZH1E3Y9YdERzlaXXgbP2xPY+AaQnu
 382d8djmLH5SGd68NQyyIES7jenkAOAGPJWULCxFS7AoauVNBQy+/Xw4Qct9upkMk/++TqPnVIB
 fZJnAY8Xbp00I5vp/BoCuQwda0fGidBh27g3/U68Wb+vj0IL2pcA4NcFVksg0DRXGdOId/4x0bn
 i57RCxc8VZXYfN47kU8byd3FdZSD0LQtjHUln/OcWTgliWnIDnMZCxqZUTo4KbDgpCB8Crobtf1
 /z5bFBGYuI+vrvog14k71bG1SBVEfh9kbbEjq+DYvdiV1nzWiJw9hUeDa0pxPKqX6PL0Z62UsX1
 O+9/9V9OQE/nbjEd9arqxhORFsqwsl1iaZpBvcvjY2AMV5fjeTd6E/H9KGB9DCpRku5ljALW2xH
 aW7w9fk7a6oqsLbk7FY9K5KHSEXgVGumB4cbcu/ol8PbQ4UneYrmL+UXcKtk8LziNH+on+1OMGN
 KXrIp/w409jUYo=
X-Received: by 2002:a05:600c:3486:b0:49f:f9d4:674d with SMTP id
 5b1f17b1804b1-49ff9d4695dmr17829285e9.13.1790404345436; 
 Fri, 25 Sep 2026 23:32:25 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-49ff06b6108sm130167325e9.8.2026.09.25.23.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 23:32:24 -0700 (PDT)
Date: Sat, 26 Sep 2026 08:32:22 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jiale Yao <yaojiale02@163.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Dmitry Baryshkov <lumag@kernel.org>, 
 Mehdi Djait <mehdi.djait@bootlin.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/tiny: sharp-memory: reject devices without match data
Message-ID: <ardmUk4lMFhnc76E@monoceros>
References: <20260925123608.2082429-1-yaojiale02@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="j7h5nzpwlz2f2g5n"
Content-Disposition: inline
In-Reply-To: <20260925123608.2082429-1-yaojiale02@163.com>
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


--j7h5nzpwlz2f2g5n
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/tiny: sharp-memory: reject devices without match data
MIME-Version: 1.0

Hello,

On Fri, Sep 25, 2026 at 08:36:08PM +0800, Jiale Yao wrote:
> SPI driver_override allows a device to bind to this driver without
> matching either the OF or SPI device ID table. In that case,
> spi_get_device_match_data() returns NULL.
>=20
> sharp_memory_probe() immediately dereferences the returned display mode
> to calculate the pitch and transmit buffer size, causing a NULL pointer
> dereference.
>=20
> Commit 572a00852635 ("iio: dac: ad5686: missing NULL check on match
> data") fixed the same driver_override issue in another SPI driver.
> Reject devices without match data before using the display mode.
>=20
> Fixes: b8f9f21716fe ("drm/tiny: Add driver for Sharp Memory LCD")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiale Yao <yaojiale02@163.com>

Note there is an effort to make it impossible to use driver_override in
the core and only allow a few dedicated drivers. (See
https://lore.kernel.org/lkml/20260922-driver-override-opt-out-v1-0-58c35ded=
3b83@nvidia.com/)

That should make your effort to implement that check in all the driver
redundant.

Best regards
Uwe

--j7h5nzpwlz2f2g5n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmq3ZvQACgkQj4D7WH0S
/k6Qcgf9G3X0KeSPaCKttnPz60x5oy+ze4Lrp0MR133CvtMOi/KpCFTC0JPCuv3a
M8mOGrUG7qRG9hwJz2xlMIeNTtr3Jib0Jgu6pZYvMaNnVJBmNdDF4sTWaZmx5hL7
A/qqL7LyP9lRn6Ko2yw/zhyWp276vGLp/yjW3tFDpUlJucJ8XPXfmYJlZVvgrvoV
4NAfE+Byneex1y222VYJX4lsZ70byfg0BVuBtxV3kxsdIRW9y9vo+ZBAyzgmd57s
Y6GxPfU0SKn/qiRPg54hhtwSAru7oele0BN3Hjwf41Ll2rt59Troh7l18UONatC4
tXudK822kPgqBO/Ax1CSPtsjwbLZgg==
=Gwu0
-----END PGP SIGNATURE-----

--j7h5nzpwlz2f2g5n--
