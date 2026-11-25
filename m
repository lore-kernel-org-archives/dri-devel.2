Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F0F606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 10:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HggI8zO0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF68110E2B2;
	Wed, 25 Nov 2026 10:11:46 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3283A10E2B2
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 10:11:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 628C9626F8;
 Wed, 25 Nov 2026 10:11:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB1D1F000CA;
 Wed, 25 Nov 2026 10:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795601499;
 bh=vIMVK/H+ptXLRryf3xoUHbNWFpkUNhdBFRcG4RVJPPA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=HggI8zO06rx6k8G4RwkxR1RyZxRDsV+cpOF8pt726VzABaocp9OT1uFct/YtE2aMi
 6Z0sxequgsrYdrEnJW8vGGkytV2A048k6y2knY7kZ7FO+1Ui3OsROku3Qd2AS4TVQa
 uOda35zoIM6T8Dbec6EDNtXHR5dPhmns2gDf9+TToOPCyo/5GbT5dhgUBBoIbM7zbu
 Xzq5AyGw/Rgq+4LQObGFHMkrFEa37XVS5cJljSi8vR56pv42wCds1dkIVM7wy3b6QT
 OcX+v+vk9d1qKS3SQbOiK9m8V/nMc80hGtER8gAy9cctMbKvaXRY30h/4lMZ0Sma3h
 4KzcLf5ICQaRQ==
Date: Wed, 25 Nov 2026 11:11:36 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: =?utf-8?B?TcOgeGlt?= Pedraza Padilla <maximpedraza@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, Jyri Sarha <jyri.sarha@iki.fi>,
 Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/4] drm/tilcdc: Implement state readout support
Message-ID: <awazkzDVZtpUsdQb@houat>
References: <20261116142707.1299360-1-maximpedraza@gmail.com>
 <20261116142707.1299360-4-maximpedraza@gmail.com>
 <avs2dagfmQkv00H0@houat>
 <20261118212114.150992-1-maximpedraza@gmail.com>
 <20261124141119.441163-1-maximpedraza@gmail.com>
 <e58a5ff5-9c1b-40cc-a65d-c7fbfdaf18d1@ideasonboard.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="kqlxxfgbcki63lze"
Content-Disposition: inline
In-Reply-To: <e58a5ff5-9c1b-40cc-a65d-c7fbfdaf18d1@ideasonboard.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--kqlxxfgbcki63lze
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 3/4] drm/tilcdc: Implement state readout support
MIME-Version: 1.0

On Tue, Nov 24, 2026 at 04:38:43PM +0200, Tomi Valkeinen wrote:
> Hi,
>=20
> On 24/11/2026 16:11, M=E0xim Pedraza Padilla wrote:
> > On Wed, Nov 18, 2026 at 10:21:14PM +0100, M=E0xim Pedraza Padilla wrote:
> > > Makes sense, I'll use the same approach in tilcdc, and see if it can =
be
> > > turned into a common helper along the way.
> >=20
> > A follow-up on this one, now that I've rebased on v9. I ended up doing
> > it differently, so I'd rather explain why before sending the next
> > version.
> >=20
> > The tidss approach rounds the clock to the closest standard refresh rat=
e.
> > Panels driven by tilcdc often don't use one: with the timings from its
> > datasheet, the panel on this board runs at 56.8 Hz (33.3 MHz), which wo=
uld
> > be read back as 60 Hz and 35.19 MHz. The adopted mode would then never
> > match the panel mode, even with U-Boot programming exactly the same one.
>=20
> I felt that approach was a bit odd (and if I recall right, failed with my
> OLDI panel), and in my tidss version I just used the clock rate directly
> from the clk_get_rate() (see dispc_vp_readout_mode):

The problem is that you're losing information when setting the clock.
Especially for panels where you don't really have an established set of
pixel clocks, the clock is very likely to not be able to give the exact
frequency you asked for.

So when you're reading the clock frequency, the mode you're reading and
the one you'd set at first modeset will not necessarily match, so you
need to take that difference into account and try to get back on your
feet.

Maxime

--kqlxxfgbcki63lze
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCawa0WAAKCRAnX84Zoj2+
dgClAX9rukYht2cxkSUN2XMvv6LJwEaP4foPFEuJx1TpnX+0tKGD8XA06bHdq2Zi
ucgepYUBgNIVV1+x0othQMl5SJyLHUQKUCM9Bk1DyyQvYde1UW25dY2kST4L9kma
kIEeGQ4egQ==
=NfU7
-----END PGP SIGNATURE-----

--kqlxxfgbcki63lze--
