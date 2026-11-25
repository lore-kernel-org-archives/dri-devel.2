Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0A3606A683
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 12:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IiW8cgEc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A7CA10E368;
	Wed, 25 Nov 2026 12:21:50 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE46510E6E0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 12:21:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8F1E241076;
 Wed, 25 Nov 2026 12:21:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C670E1F00A3D;
 Wed, 25 Nov 2026 12:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795609303;
 bh=KSKY5AkoNR4cfmVgakjrHEibPfbCAPJXXfo87x2Z9iY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=IiW8cgEcqMLprbYNxuhE1DkEneRyqQ81OLolA7y7YATEmk/9TO+8jpvHmheL0cqXn
 3YsNjDObA0JqOuutJijhj4vCTa/r31Y0q7JvtlbaJvqKFziImi1UddfiWJpaZPhTbG
 kCDNaSTdbJHD7v/68RunIHLdyr/+thdx2Q9fVvW1zmyKBHZMFZJBok5Uld8FCF0FJQ
 xQ272eoBvR86+51j/fUSIhqV0mKCnlYZWpCeYiX1p2Khp0I07uuGj1I2We9qjx00KU
 BWUulGBh0FhRtW3YYwnqye6cWZwVb57NrlBkCHUjGUToCt15Q2Uc1LYCvBcNHlcvpa
 zWUT05x8nAx+Q==
Date: Wed, 25 Nov 2026 13:21:40 +0100
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
Message-ID: <awbOkmmNIp2ng97n@houat>
References: <20261116142707.1299360-1-maximpedraza@gmail.com>
 <20261116142707.1299360-4-maximpedraza@gmail.com>
 <avs2dagfmQkv00H0@houat>
 <20261118212114.150992-1-maximpedraza@gmail.com>
 <20261124141119.441163-1-maximpedraza@gmail.com>
 <e58a5ff5-9c1b-40cc-a65d-c7fbfdaf18d1@ideasonboard.com>
 <awazkzDVZtpUsdQb@houat>
 <d9a10f1f-7550-49ee-9085-6ad4c662080d@ideasonboard.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="o7u5ewptzas4feh6"
Content-Disposition: inline
In-Reply-To: <d9a10f1f-7550-49ee-9085-6ad4c662080d@ideasonboard.com>
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


--o7u5ewptzas4feh6
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 3/4] drm/tilcdc: Implement state readout support
MIME-Version: 1.0

On Wed, Nov 25, 2026 at 01:43:55PM +0200, Tomi Valkeinen wrote:
> Hi,
>=20
> On 25/11/2026 12:11, Maxime Ripard wrote:
> > On Tue, Nov 24, 2026 at 04:38:43PM +0200, Tomi Valkeinen wrote:
> > > Hi,
> > >=20
> > > On 24/11/2026 16:11, M=E0xim Pedraza Padilla wrote:
> > > > On Wed, Nov 18, 2026 at 10:21:14PM +0100, M=E0xim Pedraza Padilla w=
rote:
> > > > > Makes sense, I'll use the same approach in tilcdc, and see if it =
can be
> > > > > turned into a common helper along the way.
> > > >=20
> > > > A follow-up on this one, now that I've rebased on v9. I ended up do=
ing
> > > > it differently, so I'd rather explain why before sending the next
> > > > version.
> > > >=20
> > > > The tidss approach rounds the clock to the closest standard refresh=
 rate.
> > > > Panels driven by tilcdc often don't use one: with the timings from =
its
> > > > datasheet, the panel on this board runs at 56.8 Hz (33.3 MHz), whic=
h would
> > > > be read back as 60 Hz and 35.19 MHz. The adopted mode would then ne=
ver
> > > > match the panel mode, even with U-Boot programming exactly the same=
 one.
> > >=20
> > > I felt that approach was a bit odd (and if I recall right, failed wit=
h my
> > > OLDI panel), and in my tidss version I just used the clock rate direc=
tly
> > > from the clk_get_rate() (see dispc_vp_readout_mode):
> >=20
> > The problem is that you're losing information when setting the clock.
> > Especially for panels where you don't really have an established set of
> > pixel clocks, the clock is very likely to not be able to give the exact
> > frequency you asked for.
> >=20
> > So when you're reading the clock frequency, the mode you're reading and
> > the one you'd set at first modeset will not necessarily match, so you
> > need to take that difference into account and try to get back on your
> > feet.
>
> If I understand correctly, your code in tidss is trying to guess the pclk
> rate in (say) the simple-panel driver via assuming the refresh rate is one
> of the standard ones?

Yes, and I have yet to see a panel that would have a refresh rate that
isn't one of the standard ones.

> I don't think that works... Even if the target refresh rate in the panel
> driver is close to (or exactly) those standard ones, it won't be the same
> clock rate except by luck. And u-boot may have a different PLL calculatio=
n,
> or different pclk in its dtso.
>=20
> I think the u-boot part should be fixed just by "fix your bootloader": if
> you want SRO to work, make your bootloader use the same videomode (includ=
ing
> pclk) as the kernel.
>=20
> But even then it won't work. If the simple panel states pclk as 150.274 M=
Hz,
> it will cause the HW to set 150.0 MHz, and the SRO in this series will
> calculate 150.124675 MHz. This will cause a full modeset, and also the SRO
> check will given an error.

Not really, because it will try to match the closest, and then try to
keep that within a defined tolerance. So, in your example, if the
expected pclk is 150.274MHz, and what's programmed in hardware is 150MHz
(which also is the closest pick we can find), then it will be happy with
150MHz.

And let's turn this around: what happens if your expected pclk is
150.274MHz, and the actual rate programmed by u-boot is, say, 124MHz?

Should we do a modeset then?

It's also a matter of consistency within the framework. The framework
expects the "ideal" mode everywhere. How is the pclk actually programmed
isn't tracked anywhere. So, if you have a regular modeset, we'd have
mode and adjusted_mode have the "ideal" pclk, but in the case of SRO
we'd have the actual one, possibly forever?

> So... First, I think at least in the adjusted_mode we should have the real
> pclk.

You can't have that. The closest you'd have would be calling
clk_round_rate() at atomic_check, but you have no guarantee that it's
actually going to be the same rate by the time you call clk_set_rate().

Either way, assuming we would do that, it would give you adjusted_mode.
You'd still need mode, and mode is what is shown to userspace.

> The SRO check should pass only an equals check there. For mode's pclk,
> I think setting the actual pclk makes sense, at least more than guessing =
it.
> Or could we, at that stage, see what modes the connector advertises, and
> pick a clock from there?

It's difficult, because then you assume that A) the bootloader will have
used a mode reported by the monitor and B) crtcs need to be readout
before connectors.

> If we can't get the pclks from the connector, the mode->clock won't match,
> and we should either skip checking that in the SRO checks, or have plenty=
 of
> tolerance.

tidss has 5% of tolerance when most of the drivers have .5%. How much do
you need?

> I think it still leads to a full modeset, but can the driver check if
> setting the mode->clock would results in the current pclk, and somehow
> abort the full modeset?

I'd rather discuss an actual bug here. Do you have a case you can share
where the logic we currently have doesn't work and is not an instance of
poor panel timings?

Maxime

--o7u5ewptzas4feh6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCawbSzQAKCRAnX84Zoj2+
dndcAYDbWbAAcKwkfi9LpkQKn+I67UpFNCRiOr+uPDQ7WaGqupVIE54Tsbj0L2Ir
QnUaRyIBgOQz88Ztz1Xq3pnQ28mrgqaWL0qkeny23Kk9FoYnx0oLQ1tRhmdBWaUW
UnFH+yCugg==
=f+EW
-----END PGP SIGNATURE-----

--o7u5ewptzas4feh6--
