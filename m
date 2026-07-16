Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E83F3C44501
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 13:22:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6039E10F30C;
	Thu, 16 Jul 2026 13:22:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="e3jU/vXL";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D54B610F30C
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 13:22:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B7ED743768;
 Thu, 16 Jul 2026 13:22:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE8F1F000E9;
 Thu, 16 Jul 2026 13:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784208163;
 bh=J1RcUzFubrLSPOJNAhV5g/NysrNzTE7RrFaLaVTbccY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=e3jU/vXLz1kCVPN9lk57N/39U6sesNTekwEhhOhKLCJpwWQeRRkvy85ApYKpAbHr7
 OHbvhz2KSV8mgXOlnjzugYt1f0B0lj2c8fjKuzxe4P4ekCdmrOKTtGmMKDZJjD9Oi+
 pkIC2Ub5uINhYp7N27YXS3MtVPn2lfeb6bUArRfW1pR+l0/g3UI+UKbodoubFHdYJd
 uCLqVTxT/2ZUzWHbZpsffXcIiRHfFGPkLaq/WukCsLFBtqfC/1jLrkdnSucx7W+6Xt
 +8RHcpBDa2cownZYwQP+9CqmbTuaJtcqAkyAFqEWKdw0K3VADVqJOSXDd6Jg6bAxsH
 l3c7SMtzsOzMA==
Date: Thu, 16 Jul 2026 15:22:41 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, Inki Dae <inki.dae@samsung.com>, 
 Jagan Teki <jagan@amarulasolutions.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Hui Pu <Hui.Pu@gehealthcare.com>, 
 Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 05/37] drm/display: bridge-connector: split code creating
 the connector to a subfunction
Message-ID: <20260716-stoic-muskox-from-asgard-c12b65@houat>
References: <DJ735MTNMYD1.3LPNV404V8PIU@bootlin.com>
 <20260624-proud-unbiased-pony-ecc3c3@houat>
 <DJHEAWSEZR79.19UFIKS8QJBQ7@bootlin.com>
 <20260626-polite-hairy-perch-25e1aa@houat>
 <DJJ1MPCEJGZD.UZM9183V6ZE5@bootlin.com>
 <20260626-classy-nightingale-of-romance-1cacad@houat>
 <DJJ4X22CJ3FG.5EYF84LVRNOG@bootlin.com>
 <20260707-warping-goshawk-of-swiftness-beea4a@penduick>
 <20260707123205.GB211515@killaraus.ideasonboard.com>
 <DJZUXUBO8DI4.2J2NI3S0KYNUE@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="hy4gwehtz7opgsid"
Content-Disposition: inline
In-Reply-To: <DJZUXUBO8DI4.2J2NI3S0KYNUE@bootlin.com>
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


--hy4gwehtz7opgsid
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 05/37] drm/display: bridge-connector: split code creating
 the connector to a subfunction
MIME-Version: 1.0

On Thu, Jul 16, 2026 at 10:37:24AM +0200, Luca Ceresoli wrote:
> >> > Now if the bridges start doing it themselves we should go back to
> >> > those encoder drivers and ditch all the drm_bridge_connector from
> >> > there?
> >> >
> >> > I must be missing something. Can you elaborate on this?
> >>
> >> drm_bridge_connectors bring together a (complete) bridge chain and a
> >> connector. If you don't have either anymore, then we shouldn't keep it
> >> around.
> >>
> >> What I was suggesting before was only a suggestion. I guess we could
> >> also make the encoder own the hotplug handling code and create the
> >> drm_bridge_connector when the chain is complete, and remove it when it=
's
> >> no longer the case.
> >
> > That's an interesting option. We don't have to keep drm_bridge_connector
> > in its current form, but I don't think we should go back to individual
> > bridge driver creating connectors, especially now that we have bridge
> > chains where the connector ops are implemented collectively by multiple
> > bridges.
>=20
> I definitely agree we don't want to add burden back on the encoder.

I don't think Laurent mentioned the encoder anywhere.

> >> We can discuss alternatives too. But either way, we shouldn't have it
> >> stick around.
>=20
> Bottom line, I roughly see three ideas mentioned:
>=20
>  1. (this series) extend the drm_bridge_connector to create the
>     drm_connector based on bridge hotplug events [+rename it]
>  2. - keep the drm_bridge_connector (mostly) as is
>     - let each encoder driver add/remove it based on bridge hotplug events
>     =3D> more burden on encoder drivers -> no

Can you motivate that with *any* reason? Because I really feel like it's
the best solution going forward.

Maxime

--hy4gwehtz7opgsid
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaljbHAAKCRAnX84Zoj2+
dqTdAX929rSvBRbObFUgBFSbAjeGJKAihEQm5mwvUemnQR8RPQTHUpIFoxoU64cT
+ncZYoIBf2oprQXmliswkjFLbOXkrIghOFzxcuJlTTV7xnm4UrAXDjJgcRCFFbs8
Equ80zFtIg==
=nsi0
-----END PGP SIGNATURE-----

--hy4gwehtz7opgsid--
