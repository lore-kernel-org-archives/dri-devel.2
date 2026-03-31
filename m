Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E2DFF60EF
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 09:09:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68BE610E9F7;
	Tue, 31 Mar 2026 09:09:39 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de
 (metis.whiteo.stw.pengutronix.de [185.203.201.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4448710E9E6
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 09:09:38 +0000 (UTC)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77]
 helo=[IPv6:::1]) by metis.whiteo.stw.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <l.stach@pengutronix.de>)
 id 1w7V6O-0004Pv-N3; Tue, 31 Mar 2026 11:09:36 +0200
Message-ID: <f5b628f50def756da356184ff6febb11cc9aaa68.camel@pengutronix.de>
Subject: Re: [PATCH 2/3] drm: lcdif: Use dedicated set/clr registers for
 polarity/edge
From: Lucas Stach <l.stach@pengutronix.de>
To: Paul Kocialkowski <paulk@sys-base.io>, dri-devel@lists.freedesktop.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Frank Li
 <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>,  Fabio Estevam <festevam@gmail.com>,
 Krzysztof =?UTF-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>, Marco Felsch
 <m.felsch@pengutronix.de>, Liu Ying <victor.liu@nxp.com>
Date: Tue, 31 Mar 2026 11:09:35 +0200
In-Reply-To: <20260330224619.2620782-3-paulk@sys-base.io>
References: <20260330224619.2620782-1-paulk@sys-base.io>
 <20260330224619.2620782-3-paulk@sys-base.io>
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

Am Dienstag, dem 31.03.2026 um 00:46 +0200 schrieb Paul Kocialkowski:
> The lcdif v3 hardware comes with dedicated registers to set and clear
> polarity bits in the CTRL register. It is unclear if there is a
> difference with writing to the CTRL register directly.
>=20
> Follow the NXP BSP reference by using these registers, in case there is
> a subtle difference caused by using them.
>=20
I don't really like that patch, as it blows up what is currently a
single register access to three separate ones. If there is no clear
benefit (as in it has been shown to fix any issue), I would prefer this
code to stay as-is.

Regards,
Lucas

> Signed-off-by: Paul Kocialkowski <paulk@sys-base.io>
> ---
>  drivers/gpu/drm/mxsfb/lcdif_kms.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/mxsfb/lcdif_kms.c b/drivers/gpu/drm/mxsfb/lc=
dif_kms.c
> index a00c4f6d63f4..1aac354041c7 100644
> --- a/drivers/gpu/drm/mxsfb/lcdif_kms.c
> +++ b/drivers/gpu/drm/mxsfb/lcdif_kms.c
> @@ -296,18 +296,27 @@ static void lcdif_set_formats(struct lcdif_drm_priv=
ate *lcdif,
>  static void lcdif_set_mode(struct lcdif_drm_private *lcdif, u32 bus_flag=
s)
>  {
>  	struct drm_display_mode *m =3D &lcdif->crtc.state->adjusted_mode;
> -	u32 ctrl =3D 0;
> +	u32 ctrl;
> =20
>  	if (m->flags & DRM_MODE_FLAG_NHSYNC)
> -		ctrl |=3D CTRL_INV_HS;
> +		writel(CTRL_INV_HS, lcdif->base + LCDC_V8_CTRL + REG_SET);
> +	else
> +		writel(CTRL_INV_HS, lcdif->base + LCDC_V8_CTRL + REG_CLR);
> +
>  	if (m->flags & DRM_MODE_FLAG_NVSYNC)
> -		ctrl |=3D CTRL_INV_VS;
> +		writel(CTRL_INV_VS, lcdif->base + LCDC_V8_CTRL + REG_SET);
> +	else
> +		writel(CTRL_INV_VS, lcdif->base + LCDC_V8_CTRL + REG_CLR);
> +
>  	if (bus_flags & DRM_BUS_FLAG_DE_LOW)
> -		ctrl |=3D CTRL_INV_DE;
> -	if (bus_flags & DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE)
> -		ctrl |=3D CTRL_INV_PXCK;
> +		writel(CTRL_INV_DE, lcdif->base + LCDC_V8_CTRL + REG_SET);
> +	else
> +		writel(CTRL_INV_DE, lcdif->base + LCDC_V8_CTRL + REG_CLR);
> =20
> -	writel(ctrl, lcdif->base + LCDC_V8_CTRL);
> +	if (bus_flags & DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE)
> +		writel(CTRL_INV_PXCK, lcdif->base + LCDC_V8_CTRL + REG_SET);
> +	else
> +		writel(CTRL_INV_PXCK, lcdif->base + LCDC_V8_CTRL + REG_CLR);
> =20
>  	writel(DISP_SIZE_DELTA_Y(m->vdisplay) |
>  	       DISP_SIZE_DELTA_X(m->hdisplay),

