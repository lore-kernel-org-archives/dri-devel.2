Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB061D6AAF4
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 18:29:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F9FF10E178;
	Thu,  2 Apr 2026 18:29:36 +0000 (UTC)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D7EA10E178
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 18:29:34 +0000 (UTC)
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 7F3D41F8005D
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 18:29:27 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 412F0B4012D; Thu,  2 Apr 2026 18:29:25 +0000 (UTC)
Received: from shepard (unknown [192.168.1.1])
 by laika.paulk.fr (Postfix) with ESMTPSA id 8C9FCB40126;
 Thu,  2 Apr 2026 18:29:23 +0000 (UTC)
Date: Thu, 2 Apr 2026 20:29:21 +0200
From: Paul Kocialkowski <paulk@sys-base.io>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
 Marco Felsch <m.felsch@pengutronix.de>, Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH 3/3] drm: lcdif: Wait for vblank before disabling DMA
Message-ID: <ac61gYLcka7e5Tj-@shepard>
References: <20260330224619.2620782-1-paulk@sys-base.io>
 <20260330224619.2620782-4-paulk@sys-base.io>
 <3305c7ec621987a30043f274b2705f739bddd497.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tDItNukm9imF4pG6"
Content-Disposition: inline
In-Reply-To: <3305c7ec621987a30043f274b2705f739bddd497.camel@pengutronix.de>
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


--tDItNukm9imF4pG6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

On Tue 31 Mar 26, 11:14, Lucas Stach wrote:
> Am Dienstag, dem 31.03.2026 um 00:46 +0200 schrieb Paul Kocialkowski:
> > It is necessary to wait for the full frame to finish streaming
> > through the DMA engine before we can safely disable it by removing
> > the DISP_PARA_DISP_ON bit. Disabling it in-flight can leave the
> > hardware confused and unable to resume streaming for the next frame.
> >=20
> > This causes the FIFO underrun and empty status bits to be set and
> > a single solid color to be shown on the display, coming from one of
> > the pixels of the previous frame. The issue occurs sporadically when
> > a new mode is set, which triggers the crtc disable and enable paths.
> >=20
> > Setting the shadow load bit and waiting for it to be cleared by the
> > DMA engine allows waiting for completion.
> >=20
> > The NXP BSP driver addresses this issue with a hardcoded 25 ms sleep.
> >=20
> > Fixes: 9db35bb349a0 ("drm: lcdif: Add support for i.MX8MP LCDIF variant=
")
> > Signed-off-by: Paul Kocialkowski <paulk@sys-base.io>
> > Co-developed-by: Lucas Stach <l.stach@pengutronix.de>
> > ---
> >  drivers/gpu/drm/mxsfb/lcdif_kms.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/mxsfb/lcdif_kms.c b/drivers/gpu/drm/mxsfb/=
lcdif_kms.c
> > index 1aac354041c7..7dce7f48d938 100644
> > --- a/drivers/gpu/drm/mxsfb/lcdif_kms.c
> > +++ b/drivers/gpu/drm/mxsfb/lcdif_kms.c
> > @@ -393,6 +393,22 @@ static void lcdif_disable_controller(struct lcdif_=
drm_private *lcdif)
> >  	if (ret)
> >  		drm_err(lcdif->drm, "Failed to disable controller!\n");
> > =20
> You can drop this no-op poll above...

You're right, it looks a bit weird to keep it as it's not needed.

> > +	/*
> > +	 * It is necessary to wait for the full frame to finish streaming
> > +	 * through the DMA engine before we can safely disable it by removing
> > +	 * the DISP_PARA_DISP_ON bit. Disabling it in-flight can leave the
> > +	 * hardware confused and unable to resume streaming for the next fram=
e.
> > +	 */
> > +	reg =3D readl(lcdif->base + LCDC_V8_CTRLDESCL0_5);
> > +	reg |=3D CTRLDESCL0_5_SHADOW_LOAD_EN;
> > +	writel(reg, lcdif->base + LCDC_V8_CTRLDESCL0_5);
> > +
> .. then setting the shadow load enable bit can be merged with the
> access clearing the DMA enable bit.

I've just tried it out and it works just as well!

> > +	ret =3D readl_poll_timeout(lcdif->base + LCDC_V8_CTRLDESCL0_5,
> > +				 reg, !(reg & CTRLDESCL0_5_SHADOW_LOAD_EN),
> > +				 0, 36000);	/* Wait ~2 frame times max */
>=20
> I know this is just a copy from the existing poll, but I don't think
> the busy looping makes a lot of sense. I guess relaxing the poll by a
> 100us or even 200us wait between checks wouldn't hurt.

Yeah good point too. I think 200 us is definitely fine since we're looking
at an average wait of a few ms.

Will respin the series then!

Thanks for the review,

Paul

> > +	if (ret)
> > +		drm_err(lcdif->drm, "Failed to disable controller!\n");
> > +
> >  	reg =3D readl(lcdif->base + LCDC_V8_DISP_PARA);
> >  	reg &=3D ~DISP_PARA_DISP_ON;
> >  	writel(reg, lcdif->base + LCDC_V8_DISP_PARA);
>=20

--=20
Paul Kocialkowski,

Independent contractor - sys-base - https://www.sys-base.io/
Free software developer - https://www.paulk.fr/

Expert in multimedia, graphics and embedded hardware support with Linux.

--tDItNukm9imF4pG6
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmnOtYEACgkQhP3B6o/u
lQxIWRAAhTBm6l6e4boYz1kz6WDMKGGEtQUkKJOH1nrv6J0LkyeyaNqcPQX3sFyZ
MuQRXuThf5BiOPwhJ0iZfu0kAwpbmLL3Xv/tjd3ioK4lpIz6SnOBPL6UqopvMFDa
RUDMd30EychK4puPjWj0Ur+jw21I116JerBrPYX6DU1QWFFjQJtE3zI4y6WR+yBP
+03CbDhqctGmTKzR/KByVAHlMfLiZJbXu332T6wVB5X1edgdp/xz3i92LgpdBVyG
2Ae6yOO4qmeTmoCQCOUATV7MAwhlsH3GdFpTqUn35ZGvV/9NkQjUJBy6oHbaKal5
tl2wqvKxI9MmYtE+mYJnU2Y60ll46/I2x2qb9VbQS7vhlHnIvOknezIansj5YB9u
+fP16K48QofV2qblnXcpxmaViPFgzkDhIkhj05gekPlHX+O5OQGYQdGo23htJSIQ
436Lut5JWS0tCunOBJpGP21HW5V3FNP7tMdWXi4C8VJqOu497Hxq2hkiX/gTU7d3
Pgk1H3Od2FPfuuTlCaoruyQMJeU88L9X3uC7I3/QeYc8fvL/5BxccoP2gkZkz1Wb
PJyqRcDTti7BMjyevVKwbt32GEyRQkUmR+DixOMNyNqKaaXFw/rsUYUKYcRl0Alv
CpFP44ONxv/R/cZBJx66NEUJkNLtQymOk/RNOP9s74sjFAG8cwo=
=neHO
-----END PGP SIGNATURE-----

--tDItNukm9imF4pG6--
