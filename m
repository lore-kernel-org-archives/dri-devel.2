Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309F9606A32C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 09:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pny9fciZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C65A311291E;
	Fri, 27 Nov 2026 09:53:55 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3048110E56B
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 09:53:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 193824166D;
 Fri, 27 Nov 2026 09:53:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B471F000C1;
 Fri, 27 Nov 2026 09:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795773212;
 bh=BhtTwakQWtgSZJXOvwDEeFMMlQVjXPLF5C6qOnOHtgU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Pny9fciZjUcKNV2chnlD3t7RI59NfzSFH65ftRtNycfh4D+BNgeca6d2IsvVbykh8
 Peu8ty5dyLYc2Qh5ID6blrya7kMNZ32VlsDJQvIOoDW96httkIkSW+++xIdLf63scU
 WrwmzuyR6zjWGyIkolH9zGSrD/H4ql4trv6nqJMLyWb1YMDs39YpGbSQiVZZd470g9
 FdP0SLTJfTTH30vL8e2+siKB4OujF07gZYNeFUP08xE+Eb80zZ1zMf+moMW1jF54kF
 PGRx8c9KQSm9fAQVt1Hdw3QEPtnvhCmsl1pOPDaSZJ+QmLOQNL1bt/wVWwn4IsmEhI
 3zfeQL/Vb4hsQ==
Date: Fri, 27 Nov 2026 10:53:29 +0100
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
Message-ID: <awlJD_6Ff2oGQ2bM@houat>
References: <20261116142707.1299360-1-maximpedraza@gmail.com>
 <20261116142707.1299360-4-maximpedraza@gmail.com>
 <avs2dagfmQkv00H0@houat>
 <20261118212114.150992-1-maximpedraza@gmail.com>
 <20261124141119.441163-1-maximpedraza@gmail.com>
 <awau4IF7KE7hUg6U@houat>
 <20261125133150.507558-1-maximpedraza@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="fzwyrulvhvot56sy"
Content-Disposition: inline
In-Reply-To: <20261125133150.507558-1-maximpedraza@gmail.com>
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


--fzwyrulvhvot56sy
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 3/4] drm/tilcdc: Implement state readout support
MIME-Version: 1.0

Hi,

On Wed, Nov 25, 2026 at 02:31:49PM +0100, M=E0xim Pedraza Padilla wrote:
> On Wed, Nov 25, 2026 at 11:07:17AM +0100, Maxime Ripard wrote:
> > > The tidss approach rounds the clock to the closest standard refresh r=
ate.
> > > Panels driven by tilcdc often don't use one: with the timings from its
> > > datasheet, the panel on this board runs at 56.8 Hz (33.3 MHz), which =
would
> > > be read back as 60 Hz and 35.19 MHz. The adopted mode would then never
> > > match the panel mode, even with U-Boot programming exactly the same o=
ne.
> >
> > This is *very* surprising. Do you have the datasheet available somewher=
e?
>=20
> You were right to be surprised, I got it wrong, sorry. The datasheet
> counts the sync pulse within the back porch: a line is 1056 clocks
> (800 + 46 + 210) and a frame 525 lines (480 + 23 + 22), so 60.06 Hz at
> 33.3 MHz. The board DT added the sync lengths on top of the porches,
> hence the 56.8 Hz. The bootloader had the same mistake, and also ran the
> panel at 16.94 MHz.
>=20
> With the timings fixed, and the bootloader programming the same mode as
> the kernel, the readout adopts exactly the DT mode (33300 kHz, 60 Hz),
> and the first commit from userspace with that mode doesn't need a
> modeset at all.

Awesome :)

> > > So the readout keeps the actual rate (rounded to the nearest kHz), and
> > > tilcdc's CRTC compare hook accepts a 1% difference on the pixel clock
> > > before calling drm_atomic_helper_crtc_compare_state(). [...]
> >
> > Yes, that's why we need the above mentionned helper, and more generally
> > why a lot of drivers allow some deviation from the clock.
>=20
> If it helps, I can write that helper: dispc_find_closest_refresh_rate_fro=
m_clk()
> turned into a DRM helper, with the tolerance as a parameter since drivers
> want different ones (5% for tidss, 0.5% for most). Something like:
>=20
> 	int drm_mode_set_clock_from_rate(struct drm_display_mode *mode,
> 					 unsigned long rate,
> 					 unsigned int tolerance);
>=20
> with the tolerance in per mille, so 0.5% can be expressed. It would fill
> mode->clock with the ideal clock of the closest standard refresh rate, or
> return an error if none is close enough. tidss would then use it, and so
> would tilcdc instead of its own compare hook. I'm also fine with you
> folding it into your series if you'd rather do it yourself, just let me
> know.

This is part of v10 now, together with some unit tests.

Maxime

--fzwyrulvhvot56sy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCawlTGAAKCRAnX84Zoj2+
dsusAX4polzpDxLM/JzsPTZ+aWWNCgNuR3Pls8tn7dg+ZaT49xEUpX3up2WAlDhe
LX/H/OEBgNgVsDrYu+c3dmtUbaLwAjl7aODJRJ8YMj1eHFBQ5UftUpVr9aK575y5
wc+LXEq75g==
=JxUI
-----END PGP SIGNATURE-----

--fzwyrulvhvot56sy--
