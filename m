Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B8F606A32E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 10:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B+HkAfqI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9175B10E059;
	Mon, 23 Nov 2026 10:54:47 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E09D10EC77
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 10:54:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D690C414CC;
 Mon, 23 Nov 2026 10:54:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1486F1F000C0;
 Mon, 23 Nov 2026 10:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795431280;
 bh=nY4HpnOeJm9f7N0343VcVoNAFZl7ji0e8FhQZkE72C0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=B+HkAfqILuHNPPN8/Sl4DKazlQO7HO2ZNkxWWMZUr1/I933pYdwWHnYZ1ddjD9poe
 kxphZOYC3znSesOtg5ths/CryB1n8gOfPlycOJQ11ozp3eb17wIHr7gjUCjZ3GzUpm
 1guq7mm2+UF6rhgtLycU3L2TyR1oBK+ry9usuO87hAL8i7224GdmE0RIDRv38tLfby
 XUUxFjYM6lThRtb8zH7xbkj6QOJLgckEO9WGvPAu5zgbTsN77jKZbB7MXKTDFiOlXH
 V9smxi7ie+ZhzmK0nfA+KkSco7ZXhvBBShI5Dw7wIMWLX2LaeZjup3Ncr0+CUJ0DNM
 F4SWSEp3l7B4A==
Date: Mon, 23 Nov 2026 11:54:37 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com, 
 David Airlie <airlied@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Frank Li <Frank.Li@nxp.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Marek Vasut <marex@denx.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Simona Vetter <simona@ffwll.ch>, Stefan Agner <stefan@agner.ch>, 
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/8] drm/mxsfb: Switch to
 drm_mode_config_create_initial_state()
Message-ID: <awQbNQISBuGdJfP-@houat>
References: <20261122153032.2782768-1-dario.binacchi@amarulasolutions.com>
 <20261122153032.2782768-5-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="kjnzkckcgnomfnc3"
Content-Disposition: inline
In-Reply-To: <20261122153032.2782768-5-dario.binacchi@amarulasolutions.com>
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


--kjnzkckcgnomfnc3
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 4/8] drm/mxsfb: Switch to
 drm_mode_config_create_initial_state()
MIME-Version: 1.0

On Sun, Nov 22, 2026 at 04:30:04PM +0100, Dario Binacchi wrote:
> The hardware state is read out only when the initial state is created
> with drm_mode_config_create_initial_state().
>=20
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

That's 99da25e15ccb in drm-misc-next

Maxime

--kjnzkckcgnomfnc3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCawQbbQAKCRAnX84Zoj2+
dsIGAYDAC2sZr5f+s2srMCKxcdwRZcoVK48DzCukP1fGlntM+89p1ItwoAcudHdj
iMXpmq4BgIB/NpvzxiPRHFHw2OVMyVyWgzN9Tw7rgLoOkxbZoaIlAi6Cyz8BxX8h
EDlPGGTJ/A==
=SNhV
-----END PGP SIGNATURE-----

--kjnzkckcgnomfnc3--
