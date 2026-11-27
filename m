Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D59A606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 16:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QwehBCuM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C5EF10E28E;
	Fri, 27 Nov 2026 16:11:47 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB007112BF1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 16:11:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EF50161FEA;
 Fri, 27 Nov 2026 16:11:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2818B1F000C1;
 Fri, 27 Nov 2026 16:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795795899;
 bh=W/uBD73Bs+VF3vdBsLFmIvE7l/eSTUyGu0zKLYYM6q0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=QwehBCuMTmhd1fPSQbQ4deY0LnTqqo31dsZ9VRZ+dWImDxXU/quXQx2ZBBbPuwbY9
 NWTh+TM23AmA+2GMEuBH455Pg05ooadfNkZS7IaMbQ2CioKJ3XkAcO73HZlPN0jOQC
 1fweE3nMu/gBJoIPeXOsZB8243v/eHFAv3gqJbbk2aTimHkllsrIa4FwCCOGCN56zx
 ThEVSHKI9Pckjz0hBDLGgBYfMEqU/JkFFzcokgfEZiYAPmVsX6gJF0ldMwNN0mG/n7
 k8CZiDuPdx3xtr8XVFKkPjBt/x2kjAAgMdX0lBw+WgEYgyo26rN2t247ehJfec6vK7
 FnqxskU/bMCxA==
Date: Fri, 27 Nov 2026 17:11:36 +0100
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
Message-ID: <awme8rFbamSrpyoQ@houat>
References: <20261116142707.1299360-1-maximpedraza@gmail.com>
 <20261116142707.1299360-4-maximpedraza@gmail.com>
 <avs2dagfmQkv00H0@houat>
 <20261118212114.150992-1-maximpedraza@gmail.com>
 <20261124141119.441163-1-maximpedraza@gmail.com>
 <e58a5ff5-9c1b-40cc-a65d-c7fbfdaf18d1@ideasonboard.com>
 <awazkzDVZtpUsdQb@houat>
 <d9a10f1f-7550-49ee-9085-6ad4c662080d@ideasonboard.com>
 <awbOkmmNIp2ng97n@houat>
 <4d93a4af-9e57-4394-913f-4f861e3e7954@ideasonboard.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="cmhg4wk6rut72ne3"
Content-Disposition: inline
In-Reply-To: <4d93a4af-9e57-4394-913f-4f861e3e7954@ideasonboard.com>
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


--cmhg4wk6rut72ne3
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 3/4] drm/tilcdc: Implement state readout support
MIME-Version: 1.0

On Wed, Nov 25, 2026 at 04:55:51PM +0200, Tomi Valkeinen wrote:
> Hi,
>=20
> On 25/11/2026 14:21, Maxime Ripard wrote:
> > On Wed, Nov 25, 2026 at 01:43:55PM +0200, Tomi Valkeinen wrote:
> > > Hi,
> > >=20
> > > On 25/11/2026 12:11, Maxime Ripard wrote:
> > > > On Tue, Nov 24, 2026 at 04:38:43PM +0200, Tomi Valkeinen wrote:
> > > > > Hi,
> > > > >=20
> > > > > On 24/11/2026 16:11, M=E0xim Pedraza Padilla wrote:
> > > > > > On Wed, Nov 18, 2026 at 10:21:14PM +0100, M=E0xim Pedraza Padil=
la wrote:
> > > > > > > Makes sense, I'll use the same approach in tilcdc, and see if=
 it can be
> > > > > > > turned into a common helper along the way.
> > > > > >=20
> > > > > > A follow-up on this one, now that I've rebased on v9. I ended u=
p doing
> > > > > > it differently, so I'd rather explain why before sending the ne=
xt
> > > > > > version.
> > > > > >=20
> > > > > > The tidss approach rounds the clock to the closest standard ref=
resh rate.
> > > > > > Panels driven by tilcdc often don't use one: with the timings f=
rom its
> > > > > > datasheet, the panel on this board runs at 56.8 Hz (33.3 MHz), =
which would
> > > > > > be read back as 60 Hz and 35.19 MHz. The adopted mode would the=
n never
> > > > > > match the panel mode, even with U-Boot programming exactly the =
same one.
> > > > >=20
> > > > > I felt that approach was a bit odd (and if I recall right, failed=
 with my
> > > > > OLDI panel), and in my tidss version I just used the clock rate d=
irectly
> > > > > from the clk_get_rate() (see dispc_vp_readout_mode):
> > > >=20
> > > > The problem is that you're losing information when setting the cloc=
k.
> > > > Especially for panels where you don't really have an established se=
t of
> > > > pixel clocks, the clock is very likely to not be able to give the e=
xact
> > > > frequency you asked for.
> > > >=20
> > > > So when you're reading the clock frequency, the mode you're reading=
 and
> > > > the one you'd set at first modeset will not necessarily match, so y=
ou
> > > > need to take that difference into account and try to get back on yo=
ur
> > > > feet.
> > >=20
> > > If I understand correctly, your code in tidss is trying to guess the =
pclk
> > > rate in (say) the simple-panel driver via assuming the refresh rate i=
s one
> > > of the standard ones?
> >=20
> > Yes, and I have yet to see a panel that would have a refresh rate that
> > isn't one of the standard ones.
>=20
> They often have quite wide ranges, and don't define clear nominal timings
> and refresh rate. But I agree, almost always one can have a 60Hz timing w=
ith
> them.
>=20
> That doesn't mean our panel/bridge drivers would define such neat clocks.=
 In
> my experience, the panel's timings are often based on X, which probably is
> something that happened to work on one platform, and was good enough. Tho=
se
> can be fixed to result timings close to the 60 Hz, but then we risk break=
ing
> the panel for some platforms.

I don't think we should accomodate those. If the pixel clock is not
properly defined, then we need to fix the panel. And if some panel
drivers make some controllers to setup something wrong, then we need to
fix the controller too.

And it's not like having an off pixel clock is harmless, at the very
least it means that the vblank interrupts don't get send at their
expected frequency anymore.

It would sound like a much better solution to me to have something that
takes a display_timing and adjust the blanking periods and / or the
porches within their acceptable range to make sure we always have the
right refresh rate despite having a rounded clock.

> Bridge drivers can also adjust the adjusted_mode's clock when they have
> special needs (DSI).
>=20
> > > I don't think that works... Even if the target refresh rate in the pa=
nel
> > > driver is close to (or exactly) those standard ones, it won't be the =
same
> > > clock rate except by luck. And u-boot may have a different PLL calcul=
ation,
> > > or different pclk in its dtso.
> > >=20
> > > I think the u-boot part should be fixed just by "fix your bootloader"=
: if
> > > you want SRO to work, make your bootloader use the same videomode (in=
cluding
> > > pclk) as the kernel.
> > >=20
> > > But even then it won't work. If the simple panel states pclk as 150.2=
74 MHz,
> > > it will cause the HW to set 150.0 MHz, and the SRO in this series will
> > > calculate 150.124675 MHz. This will cause a full modeset, and also th=
e SRO
> > > check will given an error.
> >=20
> > Not really, because it will try to match the closest, and then try to
> > keep that within a defined tolerance. So, in your example, if the
> > expected pclk is 150.274MHz, and what's programmed in hardware is 150MHz
> > (which also is the closest pick we can find), then it will be happy with
> > 150MHz.
>=20
> What will be happy?
>=20
> *ERROR* crtc-0 configuration mismatch in mode expected "1920x1200": 60
> 150274 1920 1952 2004 2028 1200 1224 1232 1235 0x48 0x0, got "1920x1200":=
 60
> 150124 1920 1952 2004 2028 1200 1224 1232 1235 0x40 0x5

Can you share more about what is going on here? What frequency is setup
by U-Boot? is happening only for the first modeset, or all the others?
Is the rounding of the clock similar between u-boot and the kernel?

> > And let's turn this around: what happens if your expected pclk is
> > 150.274MHz, and the actual rate programmed by u-boot is, say, 124MHz?
> >=20
> > Should we do a modeset then?
>=20
> If clk_set_rate(150274000) results in pclk of 124MHz, then it's the corre=
ct
> mode, no modeset needed. There are cases like that, but I'm fine with not
> targeting them at least initially.

No it's not the correct mode, it's completely off, a bootloader bug, and
the best thing the kernel needs to be doing is go through a new modeset
to fix it.

> > It's also a matter of consistency within the framework. The framework
> > expects the "ideal" mode everywhere. How is the pclk actually programmed
> > isn't tracked anywhere. So, if you have a regular modeset, we'd have
> > mode and adjusted_mode have the "ideal" pclk, but in the case of SRO
> > we'd have the actual one, possibly forever?
>=20
> With regular modeset, we'd have the ideal pclk in mode, and the real pclk=
 in
> adjusted_mode, right?

Except that you have no way to make sure that the clock in adjusted_mode
is going to be the "real" one.

> My worry is that we'll not be able to guess the ideal pclk very well. May=
be
> that can be solved with fixing the panel drivers when we encounter non-id=
eal
> timings, and having a clear rule that the provided timings have to result=
 in
> a "normal" refresh rate, even if the platform has to adjust them when
> applying.

Time will tell I guess, but I'd rather keep that in the back of our
heads as a last resort than admit defeat from the get-go :) Because,
yes, I do believe a lot of drivers are broken and it's an opportunity to
find and fix them.

> > > So... First, I think at least in the adjusted_mode we should have the=
 real
> > > pclk.
> >=20
> > You can't have that. The closest you'd have would be calling
> > clk_round_rate() at atomic_check, but you have no guarantee that it's
> > actually going to be the same rate by the time you call clk_set_rate().
>=20
> Why is that?

Because clk_round_rate() depends on the current context for that clock:
its parent rates, the ranges the other users have requested, etc.
Between atomic_check and atomic_commit, that context might have change
and you might have a different result.

> Can't we do the clk_round_rate in SRO? The SRO state has the adjusted
> timings, doesn't it?

I'm not really concerned about SRO, I'm concerned about everything after
it: the mode we expose to userspace, the consistency between an SRO
state and a committed state, etc.

> Yes, I guess clk_round_rate() there and clk_set_rate() later might result=
 in
> different rates in theory, but can that happen in practice? If the clock =
is
> being kept on, it's unlikely that its parent clocks would change.

On some platforms, maybe. On others it's absolutely the case. That's why
we have clk_set_rate_exclusive(), and why
https://lore.kernel.org/linux-clk/20260327-clk-scaling-v8-0-86cd0aba3c5f@re=
dhat.com/
is a thing.

> So it's not immediately clear to me when this could happen.

Even from a purely software PoV, if you have two users, and one calls
clk_round_rate for 42MHz which isn't rounded, and then the second does a
clk_set_max_rate(40MHz), then clk_round_rate will now return 40MHz.

> > Either way, assuming we would do that, it would give you adjusted_mode.
> > You'd still need mode, and mode is what is shown to userspace.
>=20
> Yes.
>=20
> > > The SRO check should pass only an equals check there. For mode's pclk,
> > > I think setting the actual pclk makes sense, at least more than guess=
ing it.
> > > Or could we, at that stage, see what modes the connector advertises, =
and
> > > pick a clock from there?
> >=20
> > It's difficult, because then you assume that A) the bootloader will have
> > used a mode reported by the monitor and B) crtcs need to be readout
> > before connectors.
>=20
> Isn't A) needed anyway for fully working SRO and smooth transition to the
> userspace app's display? The userspace's modeset will most likely use the
> preferred mode from the display, and if that's different than the
> bootloader's it will then cause a full modeset.

It's a reasonable assumption at first, but my point was more about "What
happens if it isn't?"

Also, once SRO works, I would expect the splash screen, plymouth, and so
on to revert the logic and go for something like "if it's enabled, use
that, otherwise use the preferred mode and do a modeset".

> Or how do apps usually work? Do they try to get the current mode from the
> crtc, and use that, even if it's not the connector's advertised default
> mode?
>=20
> > > If we can't get the pclks from the connector, the mode->clock won't m=
atch,
> > > and we should either skip checking that in the SRO checks, or have pl=
enty of
> > > tolerance.
> >=20
> > tidss has 5% of tolerance when most of the drivers have .5%. How much do
> > you need?
>=20
> I was referring to the SRO code, which currently gives errors if the modes
> don't match exactly.

Which isn't true? There are warnings, and we're literally discussing a
function that does introduce a tolerance when trying to match the modes.

Let's turn this around. I think we both agree that matching exactly
won't work. I guess it wouldn't be hard to agree that a panel running at
half the refresh rate, with different polarities, or with different
timings shouldn't be considered a match.

So my question is: where do you want to draw the line?

> > > I think it still leads to a full modeset, but can the driver check if
> > > setting the mode->clock would results in the current pclk, and somehow
> > > abort the full modeset?
> >=20
> > I'd rather discuss an actual bug here. Do you have a case you can share
> > where the logic we currently have doesn't work and is not an instance of
> > poor panel timings?
>
> It's the case with the OLDI panel. You should be able to test it with
> AM62-SK even without an actual panel, just load the
> k3-am625-sk-microtips-mf101hie-panel.dtbo. Ah, actually, there's the
> touchscreen in the dtbo, so you may need to disable that in the dtso.
> Although I guess even if it's enabled, you'll just possibly see an error
> from the touch driver, and it doesn't affect the display.
>=20
> So even if you don't have bootloader that enabled the OLDI panel, you sho=
uld
> see the configuration mismatch errors.

But it wouldn't have enabled the clock at the right rate though, right?

Maxime

--cmhg4wk6rut72ne3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCawmrsgAKCRAnX84Zoj2+
dkOCAYDa+ZIo+Psj8RHaKdhieo2xrkpEABr8rqdo/cc5Y5kjP23wg06UIPvs9Czv
RCETyqMBgNR19kodDHhY6jP7AwgwLhdqY9zV4d0lZSl3/tdqDf6XH6WuMW/rNSwa
P6s8tbEUtQ==
=5SCy
-----END PGP SIGNATURE-----

--cmhg4wk6rut72ne3--
