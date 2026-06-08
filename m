Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A23DCD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 06:33:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1282110ED81;
	Mon,  8 Jun 2026 06:33:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=geanix.com header.i=@geanix.com header.b="yQHnmxOX";
	dkim-atps=neutral
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A51E10ED81
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 06:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
 s=protonmail3; t=1780900389; x=1781159589;
 bh=S9ZYT4sdqAZ9XeVMbqK4PqwnISe3gkiViZMHrB/l9Dk=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=yQHnmxOXsTMTK9kSOYIQ76gweNsLkx6mTJ4+G42pUAg7zvNNK+tP6s05bu+Vog4kb
 6ZDl74CBxF2FZvGoznyFEpoAGsb0Oxh+j6ux5DkPw/InewH3JrIGy7fInEvUFkehpi
 GL9H79xFxMBE18PVVwUq+ANMGwuL8WQDt8ifYSM7sbvxoQe5L2iEH24J2B1Y47O4P7
 Ij/OezfLjdUPAeN96lAbszEazcpP6SAWkpdjo8P29DuwDMeuBUdDkO7yYcfDO1R1fE
 hbcOd5VPJutJgu3YXiB82TZZaZ3SQX+AciEHqRpObV2xC5+g/UMr6ue6p3eXQjCpFd
 4+WwEO6Y18e1g==
Date: Mon, 08 Jun 2026 06:33:03 +0000
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
From: Sean Nyekjaer <sean@geanix.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Sudarshan Shetty <tessolveupstream@gmail.com>, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, rfoss@kernel.org, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 alexander.stein@ew.tq-group.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v4 2/2] drm: bridge: ti-sn65dsi83: Disable video burst
 mode for LVDS stability
Message-ID: <aiZeiiZxUQT8t36g@Seans-MBP.snzone.dk>
In-Reply-To: <20260605173156.GA108156@killaraus.ideasonboard.com>
References: <ahsxWhXMhzbAj_3G@Seans-MacBook-Pro.local>
 <DJ17SSAYCT51.28YSD262KHNKK@bootlin.com>
 <20260605160946.GC4350@killaraus.ideasonboard.com>
 <DJ19VYINRU7X.MAJ2N3K941SP@bootlin.com>
 <20260605173156.GA108156@killaraus.ideasonboard.com>
Feedback-ID: 134068486:user:proton
X-Pm-Message-ID: 0e999f1130da0e1f67744f47a5bf475648fe07bd
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Fri, Jun 05, 2026 at 08:31:56PM +0100, Laurent Pinchart wrote:
> On Fri, Jun 05, 2026 at 06:56:54PM +0200, Luca Ceresoli wrote:
> > On Fri Jun 5, 2026 at 6:09 PM CEST, Laurent Pinchart wrote:
> > > On Fri, Jun 05, 2026 at 05:18:43PM +0200, Luca Ceresoli wrote:
> > >> Hello Sean,
> > >>
> > >> +Cc Marek, Maxime.
> > >>
> > >> On Sat May 30, 2026 at 8:51 PM CEST, Sean Nyekjaer wrote:
> > >> > On Wed, May 27, 2026 at 02:27:36PM +0100, Sudarshan Shetty wrote:
> > >> >> The current DSI configuration enables MIPI_DSI_MODE_VIDEO_BURST.
> > >> >> while burst mode is supported by the hardware, its use
> > >> >> depends on continuous clock behavior from the DSI host. In practi=
ce,
> > >> >> burst mode may introduce instability depending on the host contro=
ller
> > >> >> implementation, as the DSI link may transition to low-power state
> > >> >> between bursts.
> > >> >>
> > >> >> Testing showed improved display stability when using non-burst mo=
de on
> > >> >> affected panels.
> > >> >>
> > >> >> Remove MIPI_DSI_MODE_VIDEO_BURST and use non-burst video mode.
> > >> >
> > >> > We briefly talked about this at Embedded Recipes
> > >> > I promised to sent a link:
> > >> > https://lore.kernel.org/all/E35054BA-FBE5-4CEE-905C-1F5D20140590@g=
eanix.com/
> > >>
> > >> Thanks for the discussion at ER and for this follow-up e-mail.
> > >>
> > >> > When burst mode is enabled, the LVDS clock gets way to high for my
> > >> > panel. I don't know if it's the DSI controller in the STM32MP1 or
> > >> > something not supported on the TI side.
> > >> >
> > >> > We have been running with this fix for 2 years :)
> > >>
> > >> If I can summarize the situation in the last 4 years:
> > >>
> > >>  * Several users reported the same trouble
> > >>  * Those users patch their kernel out of tree to disable burst mode =
as a
> > >>    workaround
> > >>  * According to Marek the correct way to make burst mode work is
> > >>    implementing link negotiation
> > >>  * Nobody is willing to implement link negotiation as of now
> > >>
> > >> And this leads me to some questions.
> > >>
> > >>  * Do we want to keep the current situation (everybody beats their h=
ead on
> > >>    the wall until they discover disabling burst mode "fixes" their p=
anel,
> > >>    and keep an out of tree patch)?
> > >>
> > >>  * Assuming the priority is getting a screen working (and not saving=
 power
> > >>    on a black screen), would it make sense to apply this patch, and =
let
> > >>    people improve in the future by implementing link negotiation?
> > >>
> > >>    Let's pretend for a moment this is a new driver being developed: =
would
> > >>    it be OK to have a basic working driver, without some power optim=
ization
> > >>    features which can be added later on? The only valid answer to th=
is
> > >>    question is obviously "yes". Doesn't the same principle apply her=
e? If
> > >>    it doesn't, why?
> > >>
> > >>  * What is the expected power saving with burst mode?
> > >>
> > >>    I'm afraid I don't have precise numbers but I measured the total =
board
> > >>    consumption with or without burst mode (the former with a black s=
creen
> > >>    but backlight enabled) and found no difference: exactly 12.74 W i=
n both
> > >>    cases.
> > >>
> > >> Thanks for you rpatience in reading this. I hope it helps in finding=
 a
> > >> better solution.
> > >
> > > Rephrasing this a bit, is the discussion about dropping support for a
> > > supported feature (burst mode) because users who suffer from the lack=
 of
> > > another feature (link negotiation) are not willing to spend time
> > > implementing it,
> >=20
> > That's the question I have, more or less. I have no answer yet, I'm mos=
tly
> > trying to clarify the situation in the first place, for myself and anyo=
ne
> > interested.
> >=20
> > Maybe it's worth pointing out that AFAICU any driver enabling burst mod=
e is
> > buggy because in lack of link negotiation it may work or not, based on =
pure
> > luck.
> >=20
> > > and would prefer if users of burst mode were forced to
> > > do the work instead ? That doesn't seem very fair to me.
> >=20
> > Link negotiation is not just "another feature" w.r.t. burts mode. It's =
a
> > prerequisite for burst mode to work reliably. So hard-enabling burst mo=
de
> > was building a roof without solid walls (link negotiation).
> >=20
> > So I'm rephrasing your the question :) as: shouldn't users of burst mod=
e be
> > forced to implement link negotiation, since _they_ need it?
>=20
> It's quite annoying when both positions have compelling arguments :-)
>=20
> Has anyone analyzed what work would be needed to implement the link
> negotiation ? Dropping burst mode without any plan to support it will be
> demotivating for some people. If asking for link negotiation support to
> support non-burst mode is too much yak shaving, would researching a
> technical plan be an acceptable middleground ?
>=20
> > Again: AFAICU, I'm trying to understand and improve things.

I'm by no means an expert on this.

As far as I know, burst mode is a power-saving feature. I haven't heard
of burst mode being used specifically for LVDS.

Since this is a DSI-to-LVDS converter, it looks like the bridge doesn't
support burst mode properly, it shouldn't increase the LVDS clock by 20%.

I'm in favor of disabling this "optional" feature, to enable more
display's to work out of the box.

/Sean

