Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74D5606A338
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 14:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UdOftBtB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 430DA10E036;
	Fri, 20 Nov 2026 14:02:00 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22D9A10E036
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 14:01:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BDF3B4328E;
 Fri, 20 Nov 2026 14:01:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3831F000C6;
 Fri, 20 Nov 2026 14:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795183313;
 bh=IjRX/ZARSbePPvu6nqAM2ISqfChnHnrHZWGmgoFHsdA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=UdOftBtBMMHnvehGQdCSVtK8G58CmXRpB93OVK1Pm2h6LuWcORJW9HD54tHnvPSad
 /doGsP5UrjY2lrRcdPpzB1Br0vQSQR1a1n0JowOpx8P3wy6Dp1G97h1Clf6I13dUCE
 A0kxCJo3CPM80QU/OMinzInlajZ4ErYPbGq1NRfrayfNjRH4djKbvSWsevb4S7Jh8U
 e59O0TmS7Xy16AmBSNHBsvpxD/GnVU3jlRgFe4V47F5baLT2LT6qf0VaCvznnguwDq
 z0ZG9svbtWO4L6FAOWHfbR4dgzkAPO16O0T73TH/tmG3dVKoz4CNdtZFEQuHdBWLyd
 K9OVK1Eikpp4w==
Date: Fri, 20 Nov 2026 15:01:50 +0100
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
Message-ID: <awBShK7cjwT5LTLg@houat>
References: <20261116142707.1299360-1-maximpedraza@gmail.com>
 <20261116142707.1299360-4-maximpedraza@gmail.com>
 <avs2dagfmQkv00H0@houat>
 <20261118212114.150992-1-maximpedraza@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="cykdwu6ffuxdpskn"
Content-Disposition: inline
In-Reply-To: <20261118212114.150992-1-maximpedraza@gmail.com>
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


--cykdwu6ffuxdpskn
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 3/4] drm/tilcdc: Implement state readout support
MIME-Version: 1.0

On Wed, Nov 18, 2026 at 10:21:14PM +0100, M=E0xim Pedraza Padilla wrote:
> On Mon, Nov 16, 2026 at 06:12:50PM +0100, Maxime Ripard wrote:
> > > - tilcdc_crtc_mode_fixup() is undone to get the requested mode, but a
> > >   positive sync can't be told from a mode that doesn't specify it.
> >
> > That's suprising as well, the polairity of signals is typically stored
> > somewhere in a register.
>=20
> It is, in RASTER_TIMING_2 (INVERT_HSYNC and INVERT_VSYNC), so the actual
> polarity is read back fine. What's lost is the difference between a mode
> that asks for DRM_MODE_FLAG_PHSYNC and one with no polarity flag at all:
> both end up with the same register value, and the readout can only pick
> one of them. I'll reword the commit message.

I think the real solution in this case is to fix the panel to report its
polarity properly.

Thanks again,
Maxime

--cykdwu6ffuxdpskn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCawBSzgAKCRAnX84Zoj2+
dt2fAYDR2QrK8n77atxdUi+++ZegIp96UoX2U9aX30W/Rn3nz3wBBJrpt+3FyPpQ
lIC+QkMBgIlJ0uyn5uj5JIqH0dqvG3+8SpaGV5kyAUTBRtMLu8Jm6P1F7NV1CsiB
9yQ8nyqTvQ==
=Q5Gb
-----END PGP SIGNATURE-----

--cykdwu6ffuxdpskn--
