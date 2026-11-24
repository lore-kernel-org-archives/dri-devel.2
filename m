Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4890A606A685
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 16:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hMTnc3+r
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75B5510E81E;
	Tue, 24 Nov 2026 16:53:00 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3AAC10E81E
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 16:52:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D8DC7627AF;
 Tue, 24 Nov 2026 16:52:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5BF1F000C0;
 Tue, 24 Nov 2026 16:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795539173;
 bh=jzSg+OoRedY79JWCBKXLvmzN+Y99cAtJiasdC/afqxQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=hMTnc3+rZ+l2kEtF8tVKs04jAuXdhO5+bCJ1GrJ+uNW1naPu0E6MCnQHAas3yy3AB
 KI5McAlyQUiZHjezgFWKJe0FLfRVX3p8ch/gGZGyd6pbot7vCn8iCneifyKFCO/XkX
 ctIc2quPW8iHoeefQAOryS+Roo2CSn1Csf1m0qLst7WTInldhZAlGIYmgOhpaIbs1R
 XRSIkak7u9NtXXNGUSaD11rt5sL25OBl4NWUE9G5OdStlCIS72Xtb7k5MIw4Z+sw0U
 lZfBCOKOBrD80xQEnZNfPrsryie+DTQVh5g9EGlmjjA5rZdkRmwT9Ag6hUjcpEB2AB
 F5kpx9WbY6zvg==
Date: Tue, 24 Nov 2026 16:52:43 +0000
From: Mark Brown <broonie@kernel.org>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Rob Herring <robh@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>,
 Andreas Kemnade <andreas@kemnade.info>,
 Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Russell King <linux@armlinux.org.uk>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
 Helge Deller <deller@gmx.de>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Peter Ujfalusi <peter.ujfalusi@gmail.com>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-leds@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
 letux-kernel@openphoenux.org, kernel@pyra-handheld.com
Subject: Re: [PATCH v2 00/20] ARM: omap3: pandora: Modernize audio and
 backlight to use Device Tree to finally remove pdata-quirks
Message-ID: <9ac986b9-3e16-4f40-b528-ac2d09051c8e@sirena.org.uk>
Mail-Followup-To: "H. Nikolaus Schaller" <hns@goldelico.com>,
 Rob Herring <robh@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Aaro Koskinen <aaro.koskinen@iki.fi>,
 Andreas Kemnade <andreas@kemnade.info>,
 Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Russell King <linux@armlinux.org.uk>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
 Helge Deller <deller@gmx.de>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
 Peter Ujfalusi <peter.ujfalusi@gmail.com>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-leds@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
 letux-kernel@openphoenux.org, kernel@pyra-handheld.com
References: <cover.1795505160.git.hns@goldelico.com>
 <20261124151318.GA536798-robh@kernel.org>
 <1DCFB59E-E5EA-4470-997E-EAA4ED35D906@goldelico.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NC8MlJRbbzgMG+mt"
Content-Disposition: inline
In-Reply-To: <1DCFB59E-E5EA-4470-997E-EAA4ED35D906@goldelico.com>
X-Cookie: Real Users never use the Help key.
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


--NC8MlJRbbzgMG+mt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 04:27:16PM +0100, H. Nikolaus Schaller wrote:

> > Which of the 7 maintainers do you expect to take this series?

> Well, as a contributor for a specific device one is not regularily thinki=
ng
> in maintainers work split but about a series to get a device fixed. Which=
 is
> obviously orthogonal.

> I didn't even recognize that this involves 7 maintainers.

> Maybe an extension of checkpatch (which already looks into the MAINTAINER
> list) could help here?

The very large CC list you've got here really ought to have been a
warning sign here, and all the bits in submitting-patches.rst about
splitting patches apply to serieses as much as to individual patches.
Note that sometimes extensive cross subsystem interactions are the right=20
thing to do since there are actually overlaps in what's being done, a
blanket rule will never cover everything.

> > Surely=20
> > this can be broken up into smaller series?

> Yes it (we?) can. It is just a question how to do it and properly describe
> the dependencies to avoid bisectability problems and avoid that the final
> goal is lost.

If your multiple serieses can't be applied without each other then hold
off on the dependencies until the earlier things have been applied.  It
is not managable to track a large stack of interdependencies.

--NC8MlJRbbzgMG+mt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmsFwNoACgkQJNaLcl1U
h9CuDQf7BqGPuSppsd0kIdO6roCbvvnIt8FJPXqT6iunVWr1caWiAciqqwXpVOK9
qLWHb4F/3O6N62eHJFGLNrx0XuolhWQl6CXFnS7y7n+ciuXZq4m7NvMPbbcwvqp0
P1bHhyEKmQnEVdmbHLO6RNW8j5ALFuU8FOE4ZM/BwqjHgjxjmxJMi7zncNArxaZE
gaqO2PG4Fs016MxBfMwdsOXvwpZXyAXMkIuXZx2otPF0jl/PX0OIm6tbKUnauPWk
tS8osgVdQFxe73tHon7Xr9rgckK2ZdjGwAhT2jeHNxtJKNIcoo/yPTPH2sD6TlgQ
ffEg/5BFXW+kwMEiVEnAOBL0CqtcJg==
=YERm
-----END PGP SIGNATURE-----

--NC8MlJRbbzgMG+mt--
