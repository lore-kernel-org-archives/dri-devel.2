Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC031061B16
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 16:44:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 697BE10E5C4;
	Mon, 30 Mar 2026 16:44:39 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de
 (metis.whiteo.stw.pengutronix.de [185.203.201.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0AAB10E612
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 16:44:38 +0000 (UTC)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77]
 helo=[IPv6:::1]) by metis.whiteo.stw.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <l.stach@pengutronix.de>)
 id 1w7Fiu-0002FJ-Fk; Mon, 30 Mar 2026 18:44:20 +0200
Message-ID: <0e8863b39cc9cab3ef16aedde480c70a158c4cbe.camel@pengutronix.de>
Subject: Re: i.MX8MP: Fix HDMI LCDIF FIFO underruns
From: Lucas Stach <l.stach@pengutronix.de>
To: Paul Kocialkowski <paulk@sys-base.io>, Krzysztof =?UTF-8?Q?Ha=C5=82asa?=
 <khalasa@piap.pl>
Cc: Liu Ying <victor.liu@nxp.com>, Maxime Ripard <mripard@kernel.org>, Marco
 Felsch <m.felsch@pengutronix.de>, Marek Vasut <marex@nabladev.com>, Stefan
 Agner <stefan@agner.ch>,  Simona Vetter <simona@ffwll.ch>,
 imx@lists.linux.dev, Fabio Estevam <festevam@gmail.com>, Pengutronix Kernel
 Team <kernel@pengutronix.de>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Sascha Hauer
 <s.hauer@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
 linux-kernel@vger.kernel.org,  dri-devel@lists.freedesktop.org, Thomas
 Zimmermann <tzimmermann@suse.de>,  David Airlie <airlied@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Date: Mon, 30 Mar 2026 18:44:17 +0200
In-Reply-To: <acqgO5b8_1fL9t_U@shepard>
References: <m3ms04caaj.fsf@t19.piap.pl>
 <32317022-3c44-4ead-9e2d-04caa12b28cb@nabladev.com>
 <m36pvjbo4xy2rtdymshjpmwu7icl3wlyiwcmmjaozo7jpe5lqk@zt7byx7iwmym>
 <20260320-amiable-hairy-bullfinch-28bfda@houat>
 <m3a4w2d4ds.fsf@t19.piap.pl> <ecd02f87-c4b7-44ed-8ecf-98e0990af34a@nxp.com>
 <m3se9onkv0.fsf@t19.piap.pl> <acqgO5b8_1fL9t_U@shepard>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: dri-devel@lists.freedesktop.org
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

Hi Paul,

Am Montag, dem 30.03.2026 um 18:09 +0200 schrieb Paul Kocialkowski:
> Hi folks,
>=20
> On Wed 25 Mar 26, 13:40, Krzysztof Ha=C5=82asa wrote:
> > Why did the first (boot) sequence result in success and this second one
> > in failure? This is somehow reproducible.
>=20
> I've been seeing the same issue that is described in this thread when dri=
ving
> a regular 1080p@60 monitor, which shows a solid color background with a p=
ixel
> from the previous frame when reconfiguring the mode from time to time.
>=20
> When that happens, I see the lcdif fifo underrun/empty status until a new=
 mode
> is applied, which often resolves the situation. This situation never happ=
ens
> with the downstream nxp bsp driver.
>=20
> After weeks of investigation I finally narrowed it down to a part of the =
nxp
> original code that is missing in the upstream driver:
> https://github.com/phytec/linux-phytec-imx/blob/v6.6.23-2.0.0-phy/drivers=
/gpu/imx/lcdifv3/lcdifv3-common.c#L492
>=20
Thanks for tracking this down! It was also on my list of things to look
at.

> A big old sleep that waits for the DMA engine to finish handling the curr=
ent
> frame before it is disabled. When this delay is not respected, there seem=
s to
> be "unlucky" times when disabling the DMA engine too early will confuse t=
he
> unit and make it unable to resume proper operation later.
>=20
I think we can be a bit more clever than a indiscriminate sleep. If we
set the shadow load enable bit in the disable sequence, we should be
able to wait for this bit to be cleared by the hardware. All the DMA
parameters (presumably including the enable state) should be applied by
the hardware when this bit is cleared.

I guess the read_poll_timeout in lcdif_disable_controller() was
supposed to do exactly that wait, but as it was actually copied from
the mxsfb driver, it's not working as intended. It's my understanding
that the old lcdif HW only cleared the enable bit once it is actually
done, but on the lcdifv3 on i.MX8MP those states are double buffered,
so the bit in the register would be cleared instantaneously, rendering
the wait in the current code a no-op. The only reliable indicator to
see if the HW has updated it's internal state is to set the shadow load
enable bit and wait for it to be cleared.

> It is a bit surprising that the issue is not actually related to configur=
ing
> the display engine but to disabling it. This is why the first mode set al=
ways
> works but subsequentil ones might fail. The crtc is essentially disabled =
and
> re-enabled each time a new mode is applied.
>=20
> Adding the sleep solves the issue on my side and all mode sets now work
> reliably. It does add a delay before returning to userspace when configur=
ing
> a new mode, but it seems legitimate to me if the underlying hardware is s=
till
> in-flight. I'm also unsure if it would apply to an async atomic commit.
>=20
This hardware doesn't support async commits. All DMA state changes are
applied during vblank when the shadow load enable bit is set.

Regards,
Lucas

> I will send a patch adding the delay and the undocumented fifo clear
> bit that was discovered in this thread too.
>=20
> All the best,
>=20
> Paul
>=20
> Perhaps there is a more elegant way to handle this=20
>=20
>=20
> > Interestingly, Weston usually starts fine in subsequent launches.
> >=20
> > How is this first (actually second - after the first VSYNC) frame
> > different from all the others? Maybe we're programming UPDATE_SHADOW
> > after the actual start of blanking period, but before DE, so it has no
> > chance to reload registers, yet the DMA is somehow not ready?
> >=20
> > The manual (LCDIF display control Register (CTRL)) suggests that the DM=
A
> > (with present settings) starts to fetch FB data at the end of the
> > previous active video pixel time (DE and pixel data going inactive):
> > fetch_start_option (bits 9-8): Indicates when to start fetching for new
> > frame. This signals also decide the shadow load, fifo clear time
> > 00b - fetch start as soon as FPV begins(as the end of the data_enable).
> >=20
> > This should leave a lot of time to fill the FIFO (before the next DE),
> > shouldn't it?
> >=20
> > 297 MHz pixclk, 3840x2160, 30 Hz, H back porch 296 pixclks, Vfp 176,
> > V back porch 72 lines, Hfp 8 lines, VSYNC 10 lines, HSYNC 88 pixclks.
> > HTotal =3D 4400 pixels which makes Vactive time =3D 4400 * 2160/297e6 =
=3D
> > 32 ms, with the remaining 1.3333 ms for all the V sync stuff.
> > --=20
> > Krzysztof "Chris" Ha=C5=82asa
> >=20
> > Sie=C4=87 Badawcza =C5=81ukasiewicz
> > Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
> > Al. Jerozolimskie 202, 02-486 Warszawa
>=20

