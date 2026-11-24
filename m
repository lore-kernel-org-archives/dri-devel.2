Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8BA606A332
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JtVddkaI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C261810F535;
	Tue, 24 Nov 2026 12:06:02 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E1C010F535
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 12:05:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 275C340598;
 Tue, 24 Nov 2026 12:05:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 580E41F000C4;
 Tue, 24 Nov 2026 12:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795521956;
 bh=0ARS0v6hibJb4Knj3M+C/3JdOmgCFDQR3VObQHYAdrs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=JtVddkaIAO32sQA+hsx1h4/JcGjCV7sOarJQrXEhjbyVDCLNYagX4d216uvTWUv3U
 rD4Df9LCD4DyeLmzK+GOoVu4mtQZOjT5nI8gl0EytgWkEAPmIx2QBydDw3KW/BXW8d
 fbAGUobxtTpELM6KCQyiW7y4ig0oYZQ5TbqxgqJ4OwQltVUEAhTlVGnEn9BeZ+NqOU
 UPZz4x0WHwaPMNzMh23H3IiaBEYukjqhd7fSeN0AtlUi8PFXilT9je5n1l0u8CtbIj
 SFlbzs7DeHznmpCEzjp6SGr0YNSkmU9+S7JkWVKSUqEmONXVDRpUEsj4x6VumlYx80
 uY66Y0gtK2aSw==
Date: Tue, 24 Nov 2026 12:05:46 +0000
From: Mark Brown <broonie@kernel.org>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Rob Herring <robh@kernel.org>,
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
Subject: Re: [PATCH v2 04/20] dt-bindings: sound: pcm1754: Describe PCM1773
Message-ID: <608d13a4-6634-406e-aba8-b48114895cc0@sirena.org.uk>
Mail-Followup-To: "H. Nikolaus Schaller" <hns@goldelico.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@kernel.org>,
 Rob Herring <robh@kernel.org>,
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
 <a92d44c4ba920358003d475d4cac7541af037f41.1795505160.git.hns@goldelico.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Lm8vroyyHW3AIhzz"
Content-Disposition: inline
In-Reply-To: <a92d44c4ba920358003d475d4cac7541af037f41.1795505160.git.hns@goldelico.com>
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


--Lm8vroyyHW3AIhzz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 24, 2026 at 08:25:44AM +0100, H. Nikolaus Schaller wrote:
> Extend the PCM1754 device tree binding to describe the related
> PCM1773 stereo DAC.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--Lm8vroyyHW3AIhzz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmsFfZoACgkQJNaLcl1U
h9DhAQf+ILG2LleXAdzUJxA3hqS5WnJ0Cy1v4TXb/eWcYXraujstqUqC/WkBrPJF
1jm5ac0s0BM2yOF8OeMd+NZTic2OwQM665medO5X0orp1gH6FtoWYSd6KUScXDYj
BLMOMa81R9qZ0Iy/7vV9aV7pyhxZvOz2qJzmDdPnFn9RMyjcz1a3rg2aMUHPA5zy
TwsfM2Aq4Gi0Z4DgJZSBxwDKqBATI8zqVX2i1F2JXbk/ajufHZtQJC4bm+WBAvx9
rzQg69Yt5QJb9kCku5+t4+97Ei5FaQm0qD3gWz8Djb+GpK+7jNTEuK9o0nac12u5
/8CFTKpyGVx0NdLYRUDx42dLwrklRA==
=oiP8
-----END PGP SIGNATURE-----

--Lm8vroyyHW3AIhzz--
