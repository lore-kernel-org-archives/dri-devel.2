Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EED90C5B572
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 18:09:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F49110E34F;
	Tue, 11 Aug 2026 18:09:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UCU8L3fV";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7D6310E34F
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 18:09:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 76B474068A;
 Tue, 11 Aug 2026 18:09:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD1E1F000E9;
 Tue, 11 Aug 2026 18:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786471766;
 bh=fp0I+WEOJYjIihNljaA30yRbFo0fxG9dkAdF1R7NHwc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=UCU8L3fVCCuUJVT/V4RVLOGDK+nmw4dsEG2ZS/rljXqnPmOMylfs+x14VoazoQIBs
 QDED7Im4nx7eyBHMdjca2re+EvHQ4y75B9ZuhrZtPpPbvUtphSVGdvk81i5yochkAi
 Ke+5O4YSr0r6w7EjfWdl29yExS186q250UW6SkrLZ36y+WF3yi4EMQy5vuCwallBnI
 mp+KBe9Uy8uFCWvPMe47pLaDs7fmUQe9QS+Zs4AbYCjlqn6lzvW5D5GfkrPQDj/omU
 6+zqzhwbx2s2vD+k+dpOmFKxzqP5KMr4tzSRmv2KwfcYdqHIEbWaqwr/dh5E99yt1z
 T6rFrO5awJtMg==
Date: Tue, 11 Aug 2026 19:09:15 +0100
From: Mark Brown <broonie@kernel.org>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Grond <grond66@riseup.net>, Stefan Leichter <sle85276@gmx.de>,
 Grazvydas Ignotas <notasas@gmail.com>, Tony Lindgren <tony@atomide.com>,
 Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Andreas Kemnade <andreas@kemnade.info>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Sen Wang <sen@ti.com>, Richard Fitzgerald <rf@opensource.cirrus.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 Niranjan H Y <niranjan.hy@ti.com>, letux-kernel@openphoenux.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 kernel@pyra-handheld.com, mfd@lists.linux.dev
Subject: Re: [PATCH 02/16] regulator: twl: Expose the TWL4030's REGEN signal
 as a regulator
Message-ID: <40172b9e-7435-41b7-8fb4-04095d4ba1ed@sirena.org.uk>
Mail-Followup-To: "H. Nikolaus Schaller" <hns@goldelico.com>,
 Grond <grond66@riseup.net>, Stefan Leichter <sle85276@gmx.de>,
 Grazvydas Ignotas <notasas@gmail.com>,
 Tony Lindgren <tony@atomide.com>,
 Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Andreas Kemnade <andreas@kemnade.info>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Aaro Koskinen <aaro.koskinen@iki.fi>,
 Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Sen Wang <sen@ti.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 Niranjan H Y <niranjan.hy@ti.com>, letux-kernel@openphoenux.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 kernel@pyra-handheld.com, mfd@lists.linux.dev
References: <cover.1783749722.git.hns@goldelico.com>
 <1746667e5c17e2d39fc0747d7e098b32b3d7b479.1783749722.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YozZDkin/iTDr57l"
Content-Disposition: inline
In-Reply-To: <1746667e5c17e2d39fc0747d7e098b32b3d7b479.1783749722.git.hns@goldelico.com>
X-Cookie: Anything is possible, unless it's not.
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


--YozZDkin/iTDr57l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 11, 2026 at 08:01:49AM +0200, H. Nikolaus Schaller wrote:
> From: Grond <grond66@riseup.net>
>=20
> This is needed on some boards (for example, the Pandora), where REGEN is
> used to drive external regulators.

Is this a regulator or a GPIO?  It sounds an awful lot like a GPIO.

--YozZDkin/iTDr57l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmp7ZUoACgkQJNaLcl1U
h9C2sAf/dYpOrF3gel//SuWNj2En9HCdjFRvmlfEP+Hk69wcbhAG1amOMbhl5jhY
YLCA99bUq+a8dG3W29+y/GRDgvbsT9jbkPHMhmJM27G5rT/OoQ4ffXdFOciNi0xQ
t/M0Y1M5gSXaBdJbtUITVNXIlc6pwyAqb30a2yXj+JXuo0oKD5Ex7JyKCCnDdEx6
IikziTt0bKUaLdXJ7eH62kgnnF9Bsh/H1ndKzgsUAFFNLCcT0qrkgj4LXjEXAkNc
G9dYq2vzKqz17K3dm70t2b6L0MMfe0K8WjFUyNqOe8rzog6LQ65bAj439xtW1T9d
n4kMTcDV+bq+pl2o2p5hnbAm2GIR6Q==
=O/3/
-----END PGP SIGNATURE-----

--YozZDkin/iTDr57l--
