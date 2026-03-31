Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47096109B492
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 16:04:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9629710E07C;
	Tue, 31 Mar 2026 16:04:53 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de
 (metis.whiteo.stw.pengutronix.de [185.203.201.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B46D10E07C
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 16:04:52 +0000 (UTC)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77]
 helo=[IPv6:::1]) by metis.whiteo.stw.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <l.stach@pengutronix.de>)
 id 1w7baE-0005BL-TH; Tue, 31 Mar 2026 18:04:50 +0200
Message-ID: <3b221a4997c367df716bf107a7e98ce10cd6860b.camel@pengutronix.de>
Subject: Re: [PATCH 2/3] drm: lcdif: Use dedicated set/clr registers for
 polarity/edge
From: Lucas Stach <l.stach@pengutronix.de>
To: Paul Kocialkowski <paulk@sys-base.io>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Marek
 Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Frank Li <Frank.Li@nxp.com>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Krzysztof =?UTF-8?Q?Ha=C5=82asa?=
 <khalasa@piap.pl>, Marco Felsch <m.felsch@pengutronix.de>, Liu Ying
 <victor.liu@nxp.com>
Date: Tue, 31 Mar 2026 18:04:48 +0200
In-Reply-To: <acvllbRTHyVFTgmS@collins>
References: <20260330224619.2620782-1-paulk@sys-base.io>
 <20260330224619.2620782-3-paulk@sys-base.io>
 <f5b628f50def756da356184ff6febb11cc9aaa68.camel@pengutronix.de>
 <acvllbRTHyVFTgmS@collins>
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

Am Dienstag, dem 31.03.2026 um 17:17 +0200 schrieb Paul Kocialkowski:
> Hi Lucas,
>=20
> Le Tue 31 Mar 26, 11:09, Lucas Stach a =C3=A9crit :
> > Hi Paul,
> >=20
> > Am Dienstag, dem 31.03.2026 um 00:46 +0200 schrieb Paul Kocialkowski:
> > > The lcdif v3 hardware comes with dedicated registers to set and clear
> > > polarity bits in the CTRL register. It is unclear if there is a
> > > difference with writing to the CTRL register directly.
> > >=20
> > > Follow the NXP BSP reference by using these registers, in case there =
is
> > > a subtle difference caused by using them.
> > >=20
> > I don't really like that patch, as it blows up what is currently a
> > single register access to three separate ones. If there is no clear
> > benefit (as in it has been shown to fix any issue), I would prefer this
> > code to stay as-is.
>=20
> Well I guess the cost of a few writes vs a single one is rather
> negligible.
>=20
Yea, a few writes don't really hurt. But I don't think there is a very
good reason to set this register this way, see below.

> I'm rather worried that there might be an undocumented
> reason why these registers exist in the first place and why they are
> used in the BSP.
>=20
> But yes this is only speculation and I could not witness any actual
> issue. My setup (lcdif3 with hdmi) uses all positive polarities which is
> the default state, so not a good way to check.
>=20
> It would be great if somebody from NXP could confirm whether this is
> needed or not. In the meantime I guess we can drop the patch. It'll stay
> on the list in case someone has polarity issues later :)

The separate clr/set registers are a rather common design feat found on
Freescale/NXP IP blocks from the MXS era. On some of those IP blocks
_all_ registers are presented as a base/clr/set triplet in the
registers space. As far as I can tell they are mostly useful when you
want to set/clear individual bits from a register without having to
remember or executing a readback of the current state.

In cases like the one changed in this patch, where the full register
state is set in one go, directly writing to the base register is the
right thing to do.

Regards,
Lucas
