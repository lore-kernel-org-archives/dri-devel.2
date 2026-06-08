Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C7A6CD8C92
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 08:59:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCF8B10EFCA;
	Mon,  8 Jun 2026 08:59:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HYuqE3zc";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ACC710EFCA
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 08:59:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 911726001D;
 Mon,  8 Jun 2026 08:59:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40D11F00893;
 Mon,  8 Jun 2026 08:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780909153;
 bh=F15FjrPiUcOp001UqF8Ece+tYdFZAYocbMu8t+2Bfv0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=HYuqE3zcX4KDnMco90EhFiOPuVuWdNaf0zxvXE8mk/vFg6l3Nm1QtPJdBNIiTfaqu
 /kJPuUQm1b2CbyB6SvP+DAmu9Qr+tqiJ5LypjqgEmpQGYvG8RHrpKxoljMSYJhLjie
 khGfSbiQHbXZcjWt/+zyAoyJR4fmVkkJ/qQA8VLf1VROYT/DXAT1wsfN/yQFCEweqy
 ZL2YweNF62D3Iw7H3LenI1p+7blD+1uhkpyf3MyWArntzk9cbi17eTxMOrGwIGyf1f
 s5X2K8EDeDmhzWZp4CnAj2NMeFciml1r1nDHXR7sLK8tmzvcIjl5+cGJSYdAsjCxUL
 vHtn5ewfZ1buQ==
Date: Mon, 8 Jun 2026 10:59:09 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Sean Nyekjaer <sean@geanix.com>, Sudarshan Shetty <tessolveupstream@gmail.com>,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 jonas@kwiboo.se, 
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 tzimmermann@suse.de, 
 airlied@gmail.com, simona@ffwll.ch, alexander.stein@ew.tq-group.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v4 2/2] drm: bridge: ti-sn65dsi83: Disable video burst
 mode for LVDS stability
Message-ID: <20260608-funny-cuscus-of-vigor-fff8f7@houat>
References: <ahsxWhXMhzbAj_3G@Seans-MacBook-Pro.local>
 <DJ17SSAYCT51.28YSD262KHNKK@bootlin.com>
 <20260605160946.GC4350@killaraus.ideasonboard.com>
 <20260608-talented-ginger-mandrill-97a290@houat>
 <20260608071436.GB370380@killaraus.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="pjbbve3uyntqr5ys"
Content-Disposition: inline
In-Reply-To: <20260608071436.GB370380@killaraus.ideasonboard.com>
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


--pjbbve3uyntqr5ys
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 2/2] drm: bridge: ti-sn65dsi83: Disable video burst
 mode for LVDS stability
MIME-Version: 1.0

On Mon, Jun 08, 2026 at 10:14:36AM +0300, Laurent Pinchart wrote:
> On Mon, Jun 08, 2026 at 09:09:18AM +0200, Maxime Ripard wrote:
> > On Fri, Jun 05, 2026 at 07:09:46PM +0300, Laurent Pinchart wrote:
> > > On Fri, Jun 05, 2026 at 05:18:43PM +0200, Luca Ceresoli wrote:
> > > > Hello Sean,
> > > > On Sat May 30, 2026 at 8:51 PM CEST, Sean Nyekjaer wrote:
> > > > > On Wed, May 27, 2026 at 02:27:36PM +0100, Sudarshan Shetty wrote:
> > > > >> The current DSI configuration enables MIPI_DSI_MODE_VIDEO_BURST.
> > > > >> while burst mode is supported by the hardware, its use
> > > > >> depends on continuous clock behavior from the DSI host. In pract=
ice,
> > > > >> burst mode may introduce instability depending on the host contr=
oller
> > > > >> implementation, as the DSI link may transition to low-power state
> > > > >> between bursts.
> > > > >>
> > > > >> Testing showed improved display stability when using non-burst m=
ode on
> > > > >> affected panels.
> > > > >>
> > > > >> Remove MIPI_DSI_MODE_VIDEO_BURST and use non-burst video mode.
> > > > >>
> > > > >
> > > > > We briefly talked about this at Embedded Recipes
> > > > > I promised to sent a link:
> > > > > https://lore.kernel.org/all/E35054BA-FBE5-4CEE-905C-1F5D20140590@=
geanix.com/
> > > >=20
> > > > Thanks for the discussion at ER and for this follow-up e-mail.
> > > >=20
> > > > > When burst mode is enabled, the LVDS clock gets way to high for my
> > > > > panel. I don't know if it's the DSI controller in the STM32MP1 or
> > > > > something not supported on the TI side.
> > > > >
> > > > > We have been running with this fix for 2 years :)
> > > >=20
> > > > If I can summarize the situation in the last 4 years:
> > > >=20
> > > >  * Several users reported the same trouble
> > > >  * Those users patch their kernel out of tree to disable burst mode=
 as a
> > > >    workaround
> > > >  * According to Marek the correct way to make burst mode work is
> > > >    implementing link negotiation
> > > >  * Nobody is willing to implement link negotiation as of now
> > > >=20
> > > > And this leads me to some questions.
> > > >=20
> > > >  * Do we want to keep the current situation (everybody beats their =
head on
> > > >    the wall until they discover disabling burst mode "fixes" their =
panel,
> > > >    and keep an out of tree patch)?
> > > >=20
> > > >  * Assuming the priority is getting a screen working (and not savin=
g power
> > > >    on a black screen), would it make sense to apply this patch, and=
 let
> > > >    people improve in the future by implementing link negotiation?
> > > >=20
> > > >    Let's pretend for a moment this is a new driver being developed:=
 would
> > > >    it be OK to have a basic working driver, without some power opti=
mization
> > > >    features which can be added later on? The only valid answer to t=
his
> > > >    question is obviously "yes". Doesn't the same principle apply he=
re? If
> > > >    it doesn't, why?
> > > >=20
> > > >  * What is the expected power saving with burst mode?
> > > >=20
> > > >    I'm afraid I don't have precise numbers but I measured the total=
 board
> > > >    consumption with or without burst mode (the former with a black =
screen
> > > >    but backlight enabled) and found no difference: exactly 12.74 W =
in both
> > > >    cases.
> > > >=20
> > > > Thanks for you rpatience in reading this. I hope it helps in findin=
g a
> > > > better solution.
> > >=20
> > > Rephrasing this a bit, is the discussion about dropping support for a
> > > supported feature (burst mode) because users who suffer from the lack=
 of
> > > another feature (link negotiation) are not willing to spend time
> > > implementing it, and would prefer if users of burst mode were forced =
to
> > > do the work instead ? That doesn't seem very fair to me.
> >=20
> > Yeah, that's my take on it too. The question quickly turns into "we want
> > to regress current users because some new ones don't want to bother",
> > and, honestly, no. We don't do that.
> >=20
> > I really don't buy into the "but it's too hard!" argument, because you
> > can apply for pretty much everything: a review, a requested preliminary
> > work, etc.
>=20
> Without going that far, I think we need a good technical analysis and
> development plan first to back the "it's too hard" argument. If the
> amount of work indeed turns to be huge, we can then try to figure out
> how to split the effort.

Either way, we won't regress existing users. If it's indeed pretty
involved (but I'm not sure why it would be more involved than, say,
formats), then I guess we can discuss mitigating the issue, but we're
still not going to create a regression even if it's hard.

Maxime

--pjbbve3uyntqr5ys
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaiaEVgAKCRAnX84Zoj2+
di1AAYC12xCN8++B5WFdApF4UjyYxbki/ZaO50aHhY6iyio+zg2uWaNgy0rPlwJd
S0OrilYBgLHJb7+yZNszbGISYHJQCquSlDjMxAUslA4bGOGwXKva02OtKIXxMJns
VmRBRGQWOw==
=EE6g
-----END PGP SIGNATURE-----

--pjbbve3uyntqr5ys--
