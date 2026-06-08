Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B63D2CD8C9F
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 07:09:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17DC410EDF9;
	Mon,  8 Jun 2026 07:09:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="D2fR3/XX";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF01F10EDF9
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 07:09:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9258643536;
 Mon,  8 Jun 2026 07:09:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F057B1F00898;
 Mon,  8 Jun 2026 07:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780902562;
 bh=GtHBwKjQpE/Mcl5T1e9tUQO7Io2D4sQEEIldSv1mUDQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=D2fR3/XXbsEcbQAbeap9XFYifirulIxI+BpMpBQM+ZOME54fi8Nj2TzjliS/9TiBv
 jC25QGoVH3gUbHl6gNhvWo5CQOF4H3yzQDG+fKaLmH91N3OdgUOKW+C5s7y8LFgNd8
 fT8b04QqnKG/hWxSo2YOcTATcpmdrxLgpUcLAxkNBjF68eGteC1CDUTpVmQloaHKeh
 PxP95qf/jVFVkjG/v/RybFWwZ+v2sJm3n9yBGG1BfOizZcb8pVT31J3Da3gJckPimT
 dm5D1q3cSBde+0awtCyEmZ3Vruejqb9+cmTWSqPDv+DbFz9bAFculS9jxelu3coTLd
 TvurY8fVCeI5Q==
Date: Mon, 8 Jun 2026 09:09:18 +0200
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
Message-ID: <20260608-talented-ginger-mandrill-97a290@houat>
References: <ahsxWhXMhzbAj_3G@Seans-MacBook-Pro.local>
 <DJ17SSAYCT51.28YSD262KHNKK@bootlin.com>
 <20260605160946.GC4350@killaraus.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="ifasbfczctszzhtm"
Content-Disposition: inline
In-Reply-To: <20260605160946.GC4350@killaraus.ideasonboard.com>
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


--ifasbfczctszzhtm
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 2/2] drm: bridge: ti-sn65dsi83: Disable video burst
 mode for LVDS stability
MIME-Version: 1.0

On Fri, Jun 05, 2026 at 07:09:46PM +0300, Laurent Pinchart wrote:
> On Fri, Jun 05, 2026 at 05:18:43PM +0200, Luca Ceresoli wrote:
> > Hello Sean,
> > On Sat May 30, 2026 at 8:51 PM CEST, Sean Nyekjaer wrote:
> > > On Wed, May 27, 2026 at 02:27:36PM +0100, Sudarshan Shetty wrote:
> > >> The current DSI configuration enables MIPI_DSI_MODE_VIDEO_BURST.
> > >> while burst mode is supported by the hardware, its use
> > >> depends on continuous clock behavior from the DSI host. In practice,
> > >> burst mode may introduce instability depending on the host controller
> > >> implementation, as the DSI link may transition to low-power state
> > >> between bursts.
> > >>
> > >> Testing showed improved display stability when using non-burst mode =
on
> > >> affected panels.
> > >>
> > >> Remove MIPI_DSI_MODE_VIDEO_BURST and use non-burst video mode.
> > >>
> > >
> > > We briefly talked about this at Embedded Recipes
> > > I promised to sent a link:
> > > https://lore.kernel.org/all/E35054BA-FBE5-4CEE-905C-1F5D20140590@gean=
ix.com/
> >=20
> > Thanks for the discussion at ER and for this follow-up e-mail.
> >=20
> > > When burst mode is enabled, the LVDS clock gets way to high for my
> > > panel. I don't know if it's the DSI controller in the STM32MP1 or
> > > something not supported on the TI side.
> > >
> > > We have been running with this fix for 2 years :)
> >=20
> > If I can summarize the situation in the last 4 years:
> >=20
> >  * Several users reported the same trouble
> >  * Those users patch their kernel out of tree to disable burst mode as a
> >    workaround
> >  * According to Marek the correct way to make burst mode work is
> >    implementing link negotiation
> >  * Nobody is willing to implement link negotiation as of now
> >=20
> > And this leads me to some questions.
> >=20
> >  * Do we want to keep the current situation (everybody beats their head=
 on
> >    the wall until they discover disabling burst mode "fixes" their pane=
l,
> >    and keep an out of tree patch)?
> >=20
> >  * Assuming the priority is getting a screen working (and not saving po=
wer
> >    on a black screen), would it make sense to apply this patch, and let
> >    people improve in the future by implementing link negotiation?
> >=20
> >    Let's pretend for a moment this is a new driver being developed: wou=
ld
> >    it be OK to have a basic working driver, without some power optimiza=
tion
> >    features which can be added later on? The only valid answer to this
> >    question is obviously "yes". Doesn't the same principle apply here? =
If
> >    it doesn't, why?
> >=20
> >  * What is the expected power saving with burst mode?
> >=20
> >    I'm afraid I don't have precise numbers but I measured the total boa=
rd
> >    consumption with or without burst mode (the former with a black scre=
en
> >    but backlight enabled) and found no difference: exactly 12.74 W in b=
oth
> >    cases.
> >=20
> > Thanks for you rpatience in reading this. I hope it helps in finding a
> > better solution.
>=20
> Rephrasing this a bit, is the discussion about dropping support for a
> supported feature (burst mode) because users who suffer from the lack of
> another feature (link negotiation) are not willing to spend time
> implementing it, and would prefer if users of burst mode were forced to
> do the work instead ? That doesn't seem very fair to me.

Yeah, that's my take on it too. The question quickly turns into "we want
to regress current users because some new ones don't want to bother",
and, honestly, no. We don't do that.

I really don't buy into the "but it's too hard!" argument, because you
can apply for pretty much everything: a review, a requested preliminary
work, etc.

If downstream users want to patch out the kernel and prefer to take on
technical debt, that's on them.

Maxime

--ifasbfczctszzhtm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaiZqlAAKCRAnX84Zoj2+
dm+/AYDrrPahfAhn5997t5a5gnjEcvAOYTkRmcsFmKuXI1R7UN3Z08Omg84uNug8
5OKCrakBgIehDV050JemhB540J3byKydZfCQdpulH08VSTMvVXH+pNXejuWHviMK
4RAj8zTEzw==
=fVIc
-----END PGP SIGNATURE-----

--ifasbfczctszzhtm--
