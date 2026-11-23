Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40176606A31F
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 10:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q9O01lhF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB3C010E7A7;
	Mon, 23 Nov 2026 10:45:17 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E38A10E7A7
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 10:45:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 106154383A;
 Mon, 23 Nov 2026 10:45:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 553C41F000C0;
 Mon, 23 Nov 2026 10:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795430710;
 bh=WE6ErQRgC8wJSMhBoOsm1vUlEXt3CzOEmJvfGzWVO2U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Q9O01lhFujjJBzBnuEnYazam8NAPmXlSLSSX03JtBPh6GqA3cPeDKAm8z6wPKpqB3
 fjC5Txx4MYsYS2Knk9pIU+9WODPuyfMi+1N7WMo3rUJv6R/2Qye1j/tJX9iG32SAXf
 2E190GHwZW/jQdLxQXjvDQjOIlJol5BHZEYsbOy1vESrQuYhg9T9Wm2yY+ifjiqF/w
 nom7G1BIg0QJHu9GZZ8UUbvnJTV1HUuAKorJip5Ak45giyVzAnqLcnYe9BhgLAH3Q8
 TJGJnXQfFvo3YEjri1KFoyXUDEUXZdZ/WiouMhTHHEYV98Qs1Tm8trdIlGnhcs+Jh8
 7YTl0GImMCC2Q==
Date: Mon, 23 Nov 2026 11:45:08 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com, 
 Andrzej Hajda <andrzej.hajda@intel.com>, David Airlie <airlied@gmail.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>, Simona Vetter <simona@ffwll.ch>, 
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/8] drm/bridge: Add atomic_sro_install_state hook
Message-ID: <awQZEEqMK7bZ8dEq@houat>
References: <20261122153032.2782768-1-dario.binacchi@amarulasolutions.com>
 <20261122153032.2782768-2-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="sqipkz2e5yi745k7"
Content-Disposition: inline
In-Reply-To: <20261122153032.2782768-2-dario.binacchi@amarulasolutions.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--sqipkz2e5yi745k7
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 1/8] drm/bridge: Add atomic_sro_install_state hook
MIME-Version: 1.0

Hi,

Thanks a lot for looking into it :)

On Sun, Nov 22, 2026 at 04:30:01PM +0100, Dario Binacchi wrote:
> The CRTCs, planes, connectors and private objects can acquire the
> resources needed to keep the hardware state active when a state read
> out from the hardware is installed. Bridges can't, even though they
> usually hold a runtime PM reference and track their enable state
> while the pipeline is active.
>=20
> Add the atomic_sro_install_state hook to the bridge funcs. It is
> called only for the bridges of a pipeline that was read out as active.
>=20
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

This is now part of the v9, so you won't need it

Maxime

--sqipkz2e5yi745k7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCawQZMwAKCRAnX84Zoj2+
dnHvAYCET/dmHAvACi46xA5DrorXuIavkm1jIpnP0lKH4hlN98aoe+l62suseq/4
vJlgdoYBgLQ/tmWmV/ikNfs9bgmJ7kbYUKfll2wI0MItqSXErN2HdbWnHwCJT1UR
e3Dap0J+Cw==
=e6Qm
-----END PGP SIGNATURE-----

--sqipkz2e5yi745k7--
