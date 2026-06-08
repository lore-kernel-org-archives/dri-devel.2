Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B22F6CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 06:37:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBC9210ED8D;
	Mon,  8 Jun 2026 06:37:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="QBCB5ljV";
	dkim-atps=neutral
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 558AD10ED8D
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 06:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=3yTlLq5YkmsxRcx7tULhULolH7BME7lNf6yPrsXGBWk=; b=QBCB5ljV11UcuuhYyshy3eo8hy
 tRO6o72FtArqIKK/blWrNZjFfAco+s/0As59Rwxn6wP2xDDVBMKexRVjc+R85+o8q1qruOLet+xmT
 IY1AJwHtJZN1F4dpGFHnSf53K2JcdNx5wXMTD0saWdmKmPst/obv4kog8HvDqi+Bb1u2YxDoVhbKL
 7Gt5AUtbZrJtoXi7CFQWGFOWHenj6/0Xm3UcEkStzKSYzRedOPh/Hq00hiSj5f+7bRAETJNXSUccw
 Ulx02OG7bIV15mLJZqlYW5EJiFgk/pE6HK415vODmF7wJu3fU/p7Dkh5L/C1gidyCSPqR8JLWpgyg
 RptdaU7Q==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1wWTbk-000GxU-0l; Mon, 08 Jun 2026 08:37:12 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy07.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1wWTbk-000ESW-0k; Mon, 08 Jun 2026 08:37:11 +0200
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Sean Nyekjaer <sean@geanix.com>,
 Sudarshan Shetty <tessolveupstream@gmail.com>, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, rfoss@kernel.org, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v4 2/2] drm: bridge: ti-sn65dsi83: Disable video burst
 mode for LVDS stability
Date: Mon, 08 Jun 2026 08:37:10 +0200
Message-ID: <2840179.mvXUDI8C0e@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20260605160946.GC4350@killaraus.ideasonboard.com>
References: <ahsxWhXMhzbAj_3G@Seans-MacBook-Pro.local>
 <DJ17SSAYCT51.28YSD262KHNKK@bootlin.com>
 <20260605160946.GC4350@killaraus.ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Virus-Scanned: Clear (ClamAV 1.4.3/28024/Sun Jun  7 08:28:50 2026)
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

Hi,

Am Freitag, 5. Juni 2026, 18:09:46 CEST schrieb Laurent Pinchart:
> On Fri, Jun 05, 2026 at 05:18:43PM +0200, Luca Ceresoli wrote:
> > Hello Sean,
> >=20
> > +Cc Marek, Maxime.
> >=20
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

I've never heard of link negotiation for DSI. What is this about? Can you
elaborate a bit?

Best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


