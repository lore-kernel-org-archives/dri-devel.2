Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEFE4CD6E50
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 15:21:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 521221120D0;
	Fri, 29 May 2026 15:21:00 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de
 (metis.whiteo.stw.pengutronix.de [185.203.201.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 072E51120D0
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 15:21:00 +0000 (UTC)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77]
 helo=[IPv6:::1])
 by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
 (envelope-from <l.stach@pengutronix.de>)
 id 1wSz16-0002oU-Rc; Fri, 29 May 2026 17:20:56 +0200
Message-ID: <7ca82ce17e772bfe3b12c5c82ace96386eaff387.camel@pengutronix.de>
Subject: Re: [PATCH v2 0/2] drm: lcdif: FIFO underrun/solid color bug fix
From: Lucas Stach <l.stach@pengutronix.de>
To: Frieder Schrempf <frieder.schrempf@kontron.de>, Paul Kocialkowski	
 <paulk@sys-base.io>, dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann	 <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter	 <simona@ffwll.ch>, Frank Li
 <Frank.Li@nxp.com>, Sascha Hauer	 <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>,  Fabio Estevam <festevam@gmail.com>,
 Krzysztof =?UTF-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>, Marco Felsch	
 <m.felsch@pengutronix.de>, Liu Ying <victor.liu@nxp.com>
Date: Fri, 29 May 2026 17:20:54 +0200
In-Reply-To: <01c33cda-e6ac-44a8-b1eb-8a8d7118175e@kontron.de>
References: <20260402183351.3281123-1-paulk@sys-base.io>
 <01c33cda-e6ac-44a8-b1eb-8a8d7118175e@kontron.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
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

Am Mittwoch, dem 27.05.2026 um 12:35 +0200 schrieb Frieder Schrempf:
> On 02.04.26 20:33, Paul Kocialkowski wrote:
> > This series brings a fix for the FIFO underrun/solid color bug (in the
> > last commit) and two other changes that may help with reliability.
> >=20
> > Paul Kocialkowski (2):
> >   drm: lcdif: Set undocumented bit to clear FIFO at vsync
> >   drm: lcdif: Wait for vblank before disabling DMA
> >=20
> >  drivers/gpu/drm/mxsfb/lcdif_kms.c  | 18 ++++++++++++++----
> >  drivers/gpu/drm/mxsfb/lcdif_regs.h |  1 +
> >  2 files changed, 15 insertions(+), 4 deletions(-)
> >=20
>=20
> Can this series be applied, please?
>=20
Applied to drm-misc-next.

Regards,
Lucas
