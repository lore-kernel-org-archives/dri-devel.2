Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3398606A323
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 10:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lhtQCyCk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A8CA10E046;
	Wed, 25 Nov 2026 10:07:28 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DF2310E046
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 10:07:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 498E460F7C;
 Wed, 25 Nov 2026 10:07:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724F81F000D1;
 Wed, 25 Nov 2026 10:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795601240;
 bh=t5t2s7Ii+LFKy46c9t+nabqsrotZJfh3u1iVlFeZZJ4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=lhtQCyCk0LHIE2S2NytEYTRnql/je5PXZxgn3EPkj1G2lccSl5wh6167eZMrDAslP
 /PLHs7fI0VB3ThkJrY64+EhQP+p2qCIJYGNAPwYS5pZs22u3KE53u96mbqruz1CPwY
 Ctf7KIMm7yT8OG3qP3bCBtdvAeSd8zeYCNZz4j/E86SzmZdzpspsJ02/NaNccP0U8r
 AdbU/3K900ogg2bfB91w8DCIR3TsmjmfCatpLlA4Q8tBp5yal/lrNFwfcNd/WYFGAw
 X7Oi+daG8SmXgnfF/n1cRz4H3mmVEifl+PM83NWXXq2k70M/9AgzX2OXCSW3RECdFS
 ZReup0mCFYCOA==
Date: Wed, 25 Nov 2026 11:07:17 +0100
From: Maxime Ripard <mripard@kernel.org>
To: =?utf-8?B?TcOgeGlt?= Pedraza Padilla <maximpedraza@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
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
Message-ID: <awau4IF7KE7hUg6U@houat>
References: <20261116142707.1299360-1-maximpedraza@gmail.com>
 <20261116142707.1299360-4-maximpedraza@gmail.com>
 <avs2dagfmQkv00H0@houat>
 <20261118212114.150992-1-maximpedraza@gmail.com>
 <20261124141119.441163-1-maximpedraza@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="6ijf6s26eb2pqdmi"
Content-Disposition: inline
In-Reply-To: <20261124141119.441163-1-maximpedraza@gmail.com>
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


--6ijf6s26eb2pqdmi
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 3/4] drm/tilcdc: Implement state readout support
MIME-Version: 1.0

On Tue, Nov 24, 2026 at 03:11:19PM +0100, M=E0xim Pedraza Padilla wrote:
> On Wed, Nov 18, 2026 at 10:21:14PM +0100, M=E0xim Pedraza Padilla wrote:
> > Makes sense, I'll use the same approach in tilcdc, and see if it can be
> > turned into a common helper along the way.
>=20
> A follow-up on this one, now that I've rebased on v9. I ended up doing
> it differently, so I'd rather explain why before sending the next
> version.
>=20
> The tidss approach rounds the clock to the closest standard refresh rate.
> Panels driven by tilcdc often don't use one: with the timings from its
> datasheet, the panel on this board runs at 56.8 Hz (33.3 MHz), which would
> be read back as 60 Hz and 35.19 MHz. The adopted mode would then never
> match the panel mode, even with U-Boot programming exactly the same one.

This is *very* surprising. Do you have the datasheet available somewhere?

> So the readout keeps the actual rate (rounded to the nearest kHz), and
> tilcdc's CRTC compare hook accepts a 1% difference on the pixel clock
> before calling drm_atomic_helper_crtc_compare_state(). That's what the
> leeway is needed for: tilcdc_crtc_set_clk() only gets as close as the
> clock tree allows. I checked it with modesets at 20 pixel clocks between
> 16.9 and 45 MHz: the PLL misses some of them by up to 0.015%, which the
> exact comparison reported as mismatches, and they all pass now.

Yes, that's why we need the above mentionned helper, and more generally
why a lot of drivers allow some deviation from the clock.

> Testing on v9 also found a bug in my readout: re-enabling the CRTC
> (ACTIVE=3D0 then 1) with the adopted framebuffer crashed in set_scanout(),
> since it has no GEM object. It now keeps the DMA address the bootloader
> programmed.

It should be fixed in v10, I'm now creating a gem object.

Maxime

--6ijf6s26eb2pqdmi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCawazVAAKCRAnX84Zoj2+
duDQAYD3l+AIc0jBEhcEx3zw9GYOTIEqQ6qLxBxX11q81+y3MIRBQOxNNnTGnIWK
3wKSJwgBfiML+3gV/MN9hoyRBHy2vr9iDT99Js+wWKGc5hUe1MRVkU2CuRA9plqu
iANu/2EzIQ==
=GcoH
-----END PGP SIGNATURE-----

--6ijf6s26eb2pqdmi--
