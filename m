Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83253CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 07:12:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF34510EE08;
	Mon,  8 Jun 2026 07:12:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BVVhXfB/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5634310EE08
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 07:12:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 343C3439EA;
 Mon,  8 Jun 2026 07:12:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C7D1F00893;
 Mon,  8 Jun 2026 07:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780902748;
 bh=vMw1i/1cUVAQ2+3LEEvhRQKBEIGPo8NmusLe4u2OhXY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=BVVhXfB//doIRJYUfqhe/3kBsV4+JEwSxOfPrjy4/IMeseclv3PPXrVtmC0a0Mmew
 Dy83HPrQigun58Rg2H4q6WauoV/NrbYvuJQEYzy4Jy50yo+K241lo/4nKIh0BfpnYp
 /C69DDwjCZsOqd5eTyeiycTT4iI3rcWEKKyEi9SIzzg+LlvNHPG+ZYCOR8Dg8BaUU5
 IeMbghq08M/mE1ms5gJgg7SsSOXKHRxwJZRmjR1tNHZCZVkumW3/LhQ5blp+TDQydj
 L3HRyZggJ2xp8hkUcRuIJ5UdWhtKusXoFuV3JuEEhli2io3Ld5JgG2A0HXuWkqgIYE
 Pv0SyK+FJHCDw==
Date: Mon, 8 Jun 2026 09:12:25 +0200
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
Message-ID: <20260608-ambrosial-jasper-jackrabbit-f1e7ee@houat>
References: <ahsxWhXMhzbAj_3G@Seans-MacBook-Pro.local>
 <DJ17SSAYCT51.28YSD262KHNKK@bootlin.com>
 <20260605160946.GC4350@killaraus.ideasonboard.com>
 <DJ19VYINRU7X.MAJ2N3K941SP@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="fhceaio6knq7nvsw"
Content-Disposition: inline
In-Reply-To: <DJ19VYINRU7X.MAJ2N3K941SP@bootlin.com>
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


--fhceaio6knq7nvsw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 2/2] drm: bridge: ti-sn65dsi83: Disable video burst
 mode for LVDS stability
MIME-Version: 1.0

On Fri, Jun 05, 2026 at 06:56:54PM +0200, Luca Ceresoli wrote:
> Hi Laurent,
>=20
> On Fri Jun 5, 2026 at 6:09 PM CEST, Laurent Pinchart wrote:
> > On Fri, Jun 05, 2026 at 05:18:43PM +0200, Luca Ceresoli wrote:
> >> Hello Sean,
> >>
> >> +Cc Marek, Maxime.
> >>
> >> On Sat May 30, 2026 at 8:51 PM CEST, Sean Nyekjaer wrote:
> >> > On Wed, May 27, 2026 at 02:27:36PM +0100, Sudarshan Shetty wrote:
> >> >> The current DSI configuration enables MIPI_DSI_MODE_VIDEO_BURST.
> >> >> while burst mode is supported by the hardware, its use
> >> >> depends on continuous clock behavior from the DSI host. In practice,
> >> >> burst mode may introduce instability depending on the host controll=
er
> >> >> implementation, as the DSI link may transition to low-power state
> >> >> between bursts.
> >> >>
> >> >> Testing showed improved display stability when using non-burst mode=
 on
> >> >> affected panels.
> >> >>
> >> >> Remove MIPI_DSI_MODE_VIDEO_BURST and use non-burst video mode.
> >> >>
> >> >
> >> > We briefly talked about this at Embedded Recipes
> >> > I promised to sent a link:
> >> > https://lore.kernel.org/all/E35054BA-FBE5-4CEE-905C-1F5D20140590@gea=
nix.com/
> >>
> >> Thanks for the discussion at ER and for this follow-up e-mail.
> >>
> >> > When burst mode is enabled, the LVDS clock gets way to high for my
> >> > panel. I don't know if it's the DSI controller in the STM32MP1 or
> >> > something not supported on the TI side.
> >> >
> >> > We have been running with this fix for 2 years :)
> >>
> >> If I can summarize the situation in the last 4 years:
> >>
> >>  * Several users reported the same trouble
> >>  * Those users patch their kernel out of tree to disable burst mode as=
 a
> >>    workaround
> >>  * According to Marek the correct way to make burst mode work is
> >>    implementing link negotiation
> >>  * Nobody is willing to implement link negotiation as of now
> >>
> >> And this leads me to some questions.
> >>
> >>  * Do we want to keep the current situation (everybody beats their hea=
d on
> >>    the wall until they discover disabling burst mode "fixes" their pan=
el,
> >>    and keep an out of tree patch)?
> >>
> >>  * Assuming the priority is getting a screen working (and not saving p=
ower
> >>    on a black screen), would it make sense to apply this patch, and let
> >>    people improve in the future by implementing link negotiation?
> >>
> >>    Let's pretend for a moment this is a new driver being developed: wo=
uld
> >>    it be OK to have a basic working driver, without some power optimiz=
ation
> >>    features which can be added later on? The only valid answer to this
> >>    question is obviously "yes". Doesn't the same principle apply here?=
 If
> >>    it doesn't, why?
> >>
> >>  * What is the expected power saving with burst mode?
> >>
> >>    I'm afraid I don't have precise numbers but I measured the total bo=
ard
> >>    consumption with or without burst mode (the former with a black scr=
een
> >>    but backlight enabled) and found no difference: exactly 12.74 W in =
both
> >>    cases.
> >>
> >> Thanks for you rpatience in reading this. I hope it helps in finding a
> >> better solution.
> >
> > Rephrasing this a bit, is the discussion about dropping support for a
> > supported feature (burst mode) because users who suffer from the lack of
> > another feature (link negotiation) are not willing to spend time
> > implementing it,
>=20
> That's the question I have, more or less. I have no answer yet, I'm mostly
> trying to clarify the situation in the first place, for myself and anyone
> interested.
>=20
> Maybe it's worth pointing out that AFAICU any driver enabling burst mode =
is
> buggy because in lack of link negotiation it may work or not, based on pu=
re
> luck.
>
> > and would prefer if users of burst mode were forced to
> > do the work instead ? That doesn't seem very fair to me.
>=20
> Link negotiation is not just "another feature" w.r.t. burts mode. It's a
> prerequisite for burst mode to work reliably. So hard-enabling burst mode
> was building a roof without solid walls (link negotiation).
>=20
> So I'm rephrasing your the question :) as: shouldn't users of burst mode =
be
> forced to implement link negotiation, since _they_ need it?
>=20
> Again: AFAICU, I'm trying to understand and improve things.

It doesn't matter though? Take the perspective of a user. You have a
system running somewhere, working, and with an expected power draw. You
update, and now it either doesn't work anymore, or you overshoot your
power budget. But they shouldn't worry, because it was working by luck
before! And now it's better!

It's an absurd argumentation. A system that used to work wouldn't
anymore. It's a regression, and we don't do that (willingly).

Maxime

--fhceaio6knq7nvsw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaiZrWQAKCRAnX84Zoj2+
dtOmAYDpCezvx0UtrgLCs7CaJhFmpAJDJGsQBqemwmsKKMN38dqLGDkJqtp4Cp7c
XkcOgR8BgMWffiB9ePOX+BzZj4B1Na7CylCs265Zb+VDeFwu05P14dcstEfnuR6a
86cw5i5jqw==
=Y+sp
-----END PGP SIGNATURE-----

--fhceaio6knq7nvsw--
