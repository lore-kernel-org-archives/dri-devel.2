Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3692CD98E1
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 16:19:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FA3110E7D2;
	Tue, 16 Jun 2026 16:19:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PepJIcc3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D65D210E7D2
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 16:18:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A2DAF40BE2;
 Tue, 16 Jun 2026 16:18:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0031F00A3A;
 Tue, 16 Jun 2026 16:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781626739;
 bh=a4TVW1iAgiR4F/Fu6MIJKJHtKiqZZcDeWhxrhbvM+Ew=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=PepJIcc3w/gLERZDj5rURiNlBveNJIdaKGAoZeJt32Bj/xVBfT8gcELV5XjI6Q/39
 auCbSfmCg9DJU7Ym7Y0fmu54nqVnnvCaCORNeWHWEP7lIfl+mUTltQ11CwaaCH8JyE
 i6OIaoiotmwwOLt00ikgTdtmJRQNm9dlnaffgd7RnRF9Klv3XbxA+238GuOcPVg6Fp
 Thj8c0lLJH3/f+DYcu2rY+x0daoS6mqg9oOn7PDTZ60hIojpMDXFaTY4wpIcMweVHG
 G4l2gLhrrdubPWRy9IobX/Tn1y23g9lQSXPHgsyBQQOW7LGakguzsGRwa2DMNVHMF8
 tGHIP0kRMt0Fg==
Date: Tue, 16 Jun 2026 18:18:56 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
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
Message-ID: <20260616-copper-malamute-of-speed-74d6bd@houat>
References: <ahsxWhXMhzbAj_3G@Seans-MacBook-Pro.local>
 <DJ17SSAYCT51.28YSD262KHNKK@bootlin.com>
 <20260605160946.GC4350@killaraus.ideasonboard.com>
 <DJ19VYINRU7X.MAJ2N3K941SP@bootlin.com>
 <20260605173156.GA108156@killaraus.ideasonboard.com>
 <DJABYEB3V5O9.3N8KN13VZ70B1@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="dlrinhcp7ebfwdk2"
Content-Disposition: inline
In-Reply-To: <DJABYEB3V5O9.3N8KN13VZ70B1@bootlin.com>
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


--dlrinhcp7ebfwdk2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 2/2] drm: bridge: ti-sn65dsi83: Disable video burst
 mode for LVDS stability
MIME-Version: 1.0

On Tue, Jun 16, 2026 at 10:28:07AM +0200, Luca Ceresoli wrote:
> Hello Laurent, Marek,
>=20
> On Fri Jun 5, 2026 at 7:31 PM CEST, Laurent Pinchart wrote:
> > On Fri, Jun 05, 2026 at 06:56:54PM +0200, Luca Ceresoli wrote:
> >> On Fri Jun 5, 2026 at 6:09 PM CEST, Laurent Pinchart wrote:
> >> > On Fri, Jun 05, 2026 at 05:18:43PM +0200, Luca Ceresoli wrote:
> >> >> Hello Sean,
> >> >>
> >> >> +Cc Marek, Maxime.
> >> >>
> >> >> On Sat May 30, 2026 at 8:51 PM CEST, Sean Nyekjaer wrote:
> >> >> > On Wed, May 27, 2026 at 02:27:36PM +0100, Sudarshan Shetty wrote:
> >> >> >> The current DSI configuration enables MIPI_DSI_MODE_VIDEO_BURST.
> >> >> >> while burst mode is supported by the hardware, its use
> >> >> >> depends on continuous clock behavior from the DSI host. In pract=
ice,
> >> >> >> burst mode may introduce instability depending on the host contr=
oller
> >> >> >> implementation, as the DSI link may transition to low-power state
> >> >> >> between bursts.
> >> >> >>
> >> >> >> Testing showed improved display stability when using non-burst m=
ode on
> >> >> >> affected panels.
> >> >> >>
> >> >> >> Remove MIPI_DSI_MODE_VIDEO_BURST and use non-burst video mode.
> >> >> >
> >> >> > We briefly talked about this at Embedded Recipes
> >> >> > I promised to sent a link:
> >> >> > https://lore.kernel.org/all/E35054BA-FBE5-4CEE-905C-1F5D20140590@=
geanix.com/
> >> >>
> >> >> Thanks for the discussion at ER and for this follow-up e-mail.
> >> >>
> >> >> > When burst mode is enabled, the LVDS clock gets way to high for my
> >> >> > panel. I don't know if it's the DSI controller in the STM32MP1 or
> >> >> > something not supported on the TI side.
> >> >> >
> >> >> > We have been running with this fix for 2 years :)
> >> >>
> >> >> If I can summarize the situation in the last 4 years:
> >> >>
> >> >>  * Several users reported the same trouble
> >> >>  * Those users patch their kernel out of tree to disable burst mode=
 as a
> >> >>    workaround
> >> >>  * According to Marek the correct way to make burst mode work is
> >> >>    implementing link negotiation
> >> >>  * Nobody is willing to implement link negotiation as of now
> >> >>
> >> >> And this leads me to some questions.
> >> >>
> >> >>  * Do we want to keep the current situation (everybody beats their =
head on
> >> >>    the wall until they discover disabling burst mode "fixes" their =
panel,
> >> >>    and keep an out of tree patch)?
> >> >>
> >> >>  * Assuming the priority is getting a screen working (and not savin=
g power
> >> >>    on a black screen), would it make sense to apply this patch, and=
 let
> >> >>    people improve in the future by implementing link negotiation?
> >> >>
> >> >>    Let's pretend for a moment this is a new driver being developed:=
 would
> >> >>    it be OK to have a basic working driver, without some power opti=
mization
> >> >>    features which can be added later on? The only valid answer to t=
his
> >> >>    question is obviously "yes". Doesn't the same principle apply he=
re? If
> >> >>    it doesn't, why?
> >> >>
> >> >>  * What is the expected power saving with burst mode?
> >> >>
> >> >>    I'm afraid I don't have precise numbers but I measured the total=
 board
> >> >>    consumption with or without burst mode (the former with a black =
screen
> >> >>    but backlight enabled) and found no difference: exactly 12.74 W =
in both
> >> >>    cases.
> >> >>
> >> >> Thanks for you rpatience in reading this. I hope it helps in findin=
g a
> >> >> better solution.
> >> >
> >> > Rephrasing this a bit, is the discussion about dropping support for a
> >> > supported feature (burst mode) because users who suffer from the lac=
k of
> >> > another feature (link negotiation) are not willing to spend time
> >> > implementing it,
> >>
> >> That's the question I have, more or less. I have no answer yet, I'm mo=
stly
> >> trying to clarify the situation in the first place, for myself and any=
one
> >> interested.
> >>
> >> Maybe it's worth pointing out that AFAICU any driver enabling burst mo=
de is
> >> buggy because in lack of link negotiation it may work or not, based on=
 pure
> >> luck.
> >>
> >> > and would prefer if users of burst mode were forced to
> >> > do the work instead ? That doesn't seem very fair to me.
> >>
> >> Link negotiation is not just "another feature" w.r.t. burts mode. It's=
 a
> >> prerequisite for burst mode to work reliably. So hard-enabling burst m=
ode
> >> was building a roof without solid walls (link negotiation).
> >>
> >> So I'm rephrasing your the question :) as: shouldn't users of burst mo=
de be
> >> forced to implement link negotiation, since _they_ need it?
> >
> > It's quite annoying when both positions have compelling arguments :-)
> >
> > Has anyone analyzed what work would be needed to implement the link
> > negotiation ?
>=20
> Marek did multiple attempts in the past, I think it's the best analysis
> available in public as of now. Following the link provided by Sean Nyekja=
er
> in this thread on May 30 leads to them:
>=20
>  * https://lore.kernel.org/dri-devel/20220801131113.182487-1-marex@denx.d=
e/
>  * https://lore.kernel.org/all/20220219002844.362157-1-marex@denx.de/
>=20
> > Dropping burst mode without any plan to support it will be
> > demotivating for some people. If asking for link negotiation support to
> > support non-burst mode is too much yak shaving, would researching a
> > technical plan be an acceptable middleground ?
>=20
> On my side I haven't gone into the details. But I'm not sure having a plan
> would help: Marek had one, but it didn't fly.

I'm not sure it's a fair assessment of the situation. Marek made a
proposal, it was reviewed, it's kernel development as usual. I'm not
sure why there wasn't any follow-up, but I don't think it's because of a
plan (or lack thereof), probably more about a lack of time.

I still stand by what I said earlier though. It all looks fairly similar
to what we did for the formats, where bridges might want the output
clock rate of the previous bridge. If we did it for formats, and unless
we have other experiments that clearly show that it's not practical, I'm
not sure why we should make any kind of exception.

Maxime

--dlrinhcp7ebfwdk2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCajF3bAAKCRAnX84Zoj2+
dulQAX4tl1twFrkicAFv4bxjgtG6DSRhfQU2jalSUgEdrBmghqaai3ZKtglr9CZL
uFd3728BgJxZ6ARRMxBiFMQSxlQ0MV5iEVQ5cyN9EiuUnahEhGiFXGNnoTawGuOR
qg1IoGp8nA==
=oA7R
-----END PGP SIGNATURE-----

--dlrinhcp7ebfwdk2--
