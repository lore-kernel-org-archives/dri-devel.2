Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA9CC4452B
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 14:28:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E473B10E95A;
	Mon, 20 Jul 2026 14:28:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="I+BL4sgR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B41DF10E95A
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 14:28:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A990260A6A;
 Mon, 20 Jul 2026 14:28:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBCD81F000E9;
 Mon, 20 Jul 2026 14:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784557726;
 bh=QAQHbsBV90WnR9+tdGtScEWvzclJKWcmodue1Ffc3Cs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=I+BL4sgRlsEcHDDq90cf0u4HVNvGks9J7Nc1O0fePHO7OzmTlag8sOST9OgwiTEVA
 8Gvt+Hn261WmF1Z8y41WojxA3qRtFu8ZrV4Ogj54MYaxwYJMmQqxVmN34j1zN69hMz
 b/BstZP7t3yhRp05FTQ491iKZY69Ipyuw8R1OjspqV/OWpN5df3DaJA1YRfbkk2xsN
 fW2CVwFQU/NLPHoaKIngzeZ0nuTWru1LUXdptx1wEmHBmDPfRJufYiZwp12YqWHao4
 Xk8dE/NvT6tIi8OH5p0IOl2u+UmgXJ6YmTdA5uOeMVv67JcIqkaHtTKGKEjGuuBM+r
 4TpoqJS/aWaBQ==
Date: Mon, 20 Jul 2026 16:28:43 +0200
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
Message-ID: <20260720-eel-of-immense-triumph-3e24e0@penduick>
References: <DJHEAWSEZR79.19UFIKS8QJBQ7@bootlin.com>
 <20260626-polite-hairy-perch-25e1aa@houat>
 <DJJ1MPCEJGZD.UZM9183V6ZE5@bootlin.com>
 <20260626-classy-nightingale-of-romance-1cacad@houat>
 <DJJ4X22CJ3FG.5EYF84LVRNOG@bootlin.com>
 <20260707-warping-goshawk-of-swiftness-beea4a@penduick>
 <20260707123205.GB211515@killaraus.ideasonboard.com>
 <DJZUXUBO8DI4.2J2NI3S0KYNUE@bootlin.com>
 <20260716-stoic-muskox-from-asgard-c12b65@houat>
 <DK0QXI6KF7PC.3DJW38KB8MJED@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="lp6wptr2qw22x2tg"
Content-Disposition: inline
In-Reply-To: <DK0QXI6KF7PC.3DJW38KB8MJED@bootlin.com>
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


--lp6wptr2qw22x2tg
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 05/37] drm/display: bridge-connector: split code creating
 the connector to a subfunction
MIME-Version: 1.0

On Fri, Jul 17, 2026 at 11:41:33AM +0200, Luca Ceresoli wrote:
> Hi Maxime,
>=20
> On Thu Jul 16, 2026 at 3:22 PM CEST, Maxime Ripard wrote:
> > On Thu, Jul 16, 2026 at 10:37:24AM +0200, Luca Ceresoli wrote:
> >> >> > Now if the bridges start doing it themselves we should go back to
> >> >> > those encoder drivers and ditch all the drm_bridge_connector from
> >> >> > there?
> >> >> >
> >> >> > I must be missing something. Can you elaborate on this?
> >> >>
> >> >> drm_bridge_connectors bring together a (complete) bridge chain and a
> >> >> connector. If you don't have either anymore, then we shouldn't keep=
 it
> >> >> around.
> >> >>
> >> >> What I was suggesting before was only a suggestion. I guess we could
> >> >> also make the encoder own the hotplug handling code and create the
> >> >> drm_bridge_connector when the chain is complete, and remove it when=
 it's
> >> >> no longer the case.
> >> >
> >> > That's an interesting option. We don't have to keep drm_bridge_conne=
ctor
> >> > in its current form, but I don't think we should go back to individu=
al
> >> > bridge driver creating connectors, especially now that we have bridge
> >> > chains where the connector ops are implemented collectively by multi=
ple
> >> > bridges.
> >>
> >> I definitely agree we don't want to add burden back on the encoder.
> >
> > I don't think Laurent mentioned the encoder anywhere.
>=20
> Ah, indeed, sorry! However, I think both the bridges and the encoder
> drivers should equally have the minimum burden on them.
>=20
> Right now the recommended practice is:
>=20
>  - bridges do not create connectors (thanks to DRM_BRIDGE_ATTACH_NO_CONNE=
CTOR)
>  - encoders just call drm_bridge_connector_init(), which does all the
>    common operations to populate a suitable drm_connector
>=20
> So all common operations involved in connector creation and bridge chain
> analysis are implemented in common code, not per-bridge or
> per-encoder. That's good.

I agree, but another way to phrase it is: bridges aren't aware of how
the chain is setup, the encoder ties it all together.

> >> >> We can discuss alternatives too. But either way, we shouldn't have =
it
> >> >> stick around.
> >>
> >> Bottom line, I roughly see three ideas mentioned:
> >>
> >>  1. (this series) extend the drm_bridge_connector to create the
> >>     drm_connector based on bridge hotplug events [+rename it]
> >>  2. - keep the drm_bridge_connector (mostly) as is
> >>     - let each encoder driver add/remove it based on bridge hotplug ev=
ents
> >>     =3D> more burden on encoder drivers -> no
> >
> > Can you motivate that with *any* reason? Because I really feel like it's
> > the best solution going forward.
>=20
> My understanding of your idea (maybe a bit overstressed just to ensure it=
's
> clear) is that:
>=20
>  - the drm_bridge_connector should stay (almost) unmodified

Yes, and bridges should ideally remain as lightly affected as possible.
We have probably around 100 bridge drivers at the moment, having some
kind of opt-in to enable hotplug would mean that we can't expect hotplug
to work on a new platform, which should be a last resort.

>  - there should be no new "manager" component (not sure this is actually
>    your opinion, can you comment on this specifically?)
>  - every encoder driver would have to:
>    - register to receive hotplug events
>    - when receiving one such event, find out whether the hardware is
>      complete or not (by calling drm_bridge_connector_pipeline_is_complet=
e()
>      or so)
>    - create/destroy a drm_bridge_connector based on hotplug events
>=20
> Is this somewhat close to what you have in mind?

Yes. To make things a bit more precise, we need two things: the encoder
to put the chain together, and "something" (that you used to call
manager) to react to hotplug events and handle the bridge
detach/destruction, connector creation/destruction, etc and should stick
around when we enable hotplug.

What I'm suggesting is that, since the encoder already owns and creates
the chain in the first place, and is there forever, it's only natural
for the encoder to be that "something", and we don't necessarily mean
creating a new entity or piece of code. A bunch of helpers and hooks a
probably going to be enough.

This is where the opt-in part should be, and I'd like, if possible, for
hotplug-enabled encoders to work with any bridge.

> To me the best solution to add hotplug support is that encoder drivers
> replace the single drm_bridge_connector_init() call with a single call to
> something new (let's call it a hotplug manager), which takes care of all
> the common aspects: registering to receive bridge hotplug events, finding
> out whether the hardware pipeline is complete or not, and add/remove the
> drm_connector based on that.
>=20
> In other words, the changes on encoder drivers would be similar to patch
> 37. In a nutshell:
>=20
>   -	connector =3D drm_bridge_connector_init(lcdif->drm, encoder);
>   +	drm_hotplug_manager =3D drm_hotplug_manager_init(lcdif->drm, encoder);
>=20
> All the hotplug logic would be in common code, and any maintenance and
> future improvements to it would stay in a single place, benefitting all
> encoders at once.
>=20
> What do you think about this?

=46rom a high level point-of-view, I think we mostly agree. We can argue
on the name, and if we should merge it with something else
(drm_encoder_init, drm_bridge_attach, something else?) but that's the
path forward I think.

Maxime

--lp6wptr2qw22x2tg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCal4wmgAKCRAnX84Zoj2+
dgktAX4228G96x+8Z0Dw6IjUdAVLYXmjmJyQlMI/D0b0Lbb/y7NEWM86n6g9VaJT
M3uZYKYBf0U1YCLtV3vGID4exmQjHi60MDFrDBb6zVc4tvw3U2CZ0uFcTrkLpMW3
MpRElEYqOg==
=UEBc
-----END PGP SIGNATURE-----

--lp6wptr2qw22x2tg--
