Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FBD7CDE008
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:09:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DB7210E33B;
	Fri, 26 Jun 2026 10:09:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YZ2AOjui";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B986810E33B
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 10:09:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1831043858;
 Fri, 26 Jun 2026 10:09:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC791F000E9;
 Fri, 26 Jun 2026 10:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782468546;
 bh=/8m16LbO8lK2QhthwpfA6cSLy6pKWANJXso5ew8q1+0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=YZ2AOjui3EJK37FD6DnOgFAp49V/8laiD6Qd3DzQR16Jym+3ikcoWbQoxeRDIdSmG
 t/icJvQZwAiw5eAuH4WI38LaVngWy+STSt1nOjFxe8Atexkj+aZ7YE33XIGXr5rfUT
 k0TjVR+nCbHsCcpTmPEWKxWhWanEpDOLy5qq9N386nD1ILR19x1lc0mtIMEwPmz+ZD
 cLOZPdz0Tn43PiegaqC12tQnU0OMzMMKMeng7z1sceIyVnawpXDN3yLafK5pY5IT1t
 GnpLDKaFCBn76yidbGhJ56hQq7oEb3+C5obHC71aLYz5BDGuTnoiPkVIRCFi61TgHt
 FOYfYeCwSqWlA==
Date: Fri, 26 Jun 2026 12:09:03 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
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
Message-ID: <20260626-polite-hairy-perch-25e1aa@houat>
References: <20260519-drm-bridge-hotplug-v1-0-45e2bdb3dfb4@bootlin.com>
 <20260519-drm-bridge-hotplug-v1-5-45e2bdb3dfb4@bootlin.com>
 <20260608-mindful-heavy-frigatebird-be9faf@houat>
 <DJ735MTNMYD1.3LPNV404V8PIU@bootlin.com>
 <20260624-proud-unbiased-pony-ecc3c3@houat>
 <DJHEAWSEZR79.19UFIKS8QJBQ7@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="afpil2l4mwf7jssr"
Content-Disposition: inline
In-Reply-To: <DJHEAWSEZR79.19UFIKS8QJBQ7@bootlin.com>
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


--afpil2l4mwf7jssr
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 05/37] drm/display: bridge-connector: split code creating
 the connector to a subfunction
MIME-Version: 1.0

On Wed, Jun 24, 2026 at 05:47:10PM +0200, Luca Ceresoli wrote:
> On Wed Jun 24, 2026 at 1:41 PM CEST, Maxime Ripard wrote:
> > Hi,x
> >
> > On Fri, Jun 12, 2026 at 02:56:24PM +0200, Luca Ceresoli wrote:
> >> On Mon Jun 8, 2026 at 1:40 PM CEST, Maxime Ripard wrote:
> >> > On Tue, May 19, 2026 at 12:37:22PM +0200, Luca Ceresoli wrote:
> >> >> In preparation to introduce bridge hotplug, split out from
> >> >> drm_bridge_connector_init() the code adding the drm_connector into a
> >> >> dedicated function. This will be needed to be able to add (and re-a=
dd) the
> >> >> connector from different code paths.
> >> >
> >> > Same story here, explaining what you need later on that calls for th=
at
> >> > change would be nice.
> >>
> >> Here's a more verbose version:
> >>
> >>     Currently drm_bridge_connector_init() does two things:
> >>
> >>      * allocate and initialize the drm_bridge_connector
> >>        (which embeds a drm_connector)
> >>      * initialize and register the embedded drm_connector
> >>
> >>     For bridge hotplug we need to separate these two actions:
> >>
> >>      * the drm_connector needs to be added and removed at any time bas=
ed on
> >>        hotplug events
> >>      * the drm_bridge_connector is designated to create and remove the
> >>        drm_connector, so it must be persistent for the card lifetime
> >>
> >>     As the lifetimes of drm_bridge_connector and drm_connector become
> >>     different, we need to create them in different moments.
> >>
> >>     In preparation to support that, split out from
> >>     drm_bridge_connector_init() the code adding the drm_connector into=
 a
> >>     dedicated function. No functional changes, just moving code around=
 for
> >>     now. A future commit will make the drm_connector be created based =
on
> >>     hotplug events.
> >>
> >> Looks good?
> >
> > The message itself, yes, thanks.
> >
> > However, I have questions now :)
> >
> > Do we really expect drm_bridge_connector to stick around when a bridge
> > gets unplugged? If so, how does it cope with having, say, an HDMI
> > connector, and then swapping out the hotplugged part for an LVDS one?
> > Does the HDMI connector sticks around indefinitely?
>=20
> In your example, the HDMI drm_connector would be unregistered and put on
> hotunplug. Its allocation will stick around until the last put but that's
> quite irrelevant. Then, on plugging the LVDS addon, a new LVDS
> drm_connector will be created and registered.
>
> > *Especially* if we're using overlays for this, I'd expect everything
> >  after the first hotplugged bridge to be destroyed, no?
>=20
> As said, it would be unregistered immediately but might be freed later on
> if still refcounted.
>=20
> This is visible in patches 36+15, the path to follow is:
>=20
>  drm_bridge_connector_handle_event(event =3D DRM_BRIDGE_DETACHED) [patch =
36]
>  -> drm_bridge_connector_dynconn_release()                      [patch 15]
>=20
> Does this solve your concern?

Not really, I'm talking about drm_bridge_connector. The fact that
bridges are destroyed make sense to me. The fact that
drm_bridge_connector sticks around doesn't. It's supposed to be a
connector for bridges. If you don't have bridges because they got
destroyed, and connector, drm_bridge_connector doesn't have a reason to
exist anymore, unless it's drm_bridge_hotplug in a trench coat :)

Maxime

--afpil2l4mwf7jssr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaj5PvwAKCRAnX84Zoj2+
dtwEAX4ijuVNE181/mqCOafyW3Jbn1VsUVf2J9rGzifU5uKrZMsSWTfU5SxviGjz
/GWmgbsBewf9Dp8zYwfQlX4fBaDezy5TaiuhnwNUA6T1Jrq2ZsoSQTjxbco2obCp
WVWtqMxZ5Q==
=L4Fb
-----END PGP SIGNATURE-----

--afpil2l4mwf7jssr--
