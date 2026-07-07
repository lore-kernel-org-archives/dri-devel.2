Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E22DC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 09:56:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75BDB10E474;
	Tue,  7 Jul 2026 09:56:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dSbu4sez";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 575D1899B3
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 09:55:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8925D618AE;
 Tue,  7 Jul 2026 09:55:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E5041F000E9;
 Tue,  7 Jul 2026 09:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783418158;
 bh=CRr4dvDSTrtgIM0uL2TEeCIgJbcPdJkwFKqZsm9On88=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=dSbu4sezCpiyZYiGx0PLDZAQ55o+ZeIKfjWWXZYfT7bA+FsgQHZN5Optg9YptTxjc
 6Ts0kg8S7I/y2DmY9LrQ60hFpWf2JXFT/EhFO+4vYT48lkCPy1v34uiUNTsCYysXe8
 l7byjyy2QjcGH8pgXrxdS9dpdEOfSmLrbri92hbWYD73+0J3oC4nzYnKeYzjQqulCY
 PizqRD5BicV39E55wY/U7TMtNah8F7G4a5kMvhlOI+X/s6iTgSTvO9JMyeaXLyQx8y
 Y52od4UC+Ky9QjRPxgo/DcSNvyvwrPu1dILUXBsQjHR577uU7Z9OfNHOI6QsroQSFp
 R6ETxyqFCaCMA==
Date: Tue, 7 Jul 2026 11:55:54 +0200
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
Message-ID: <20260707-warping-goshawk-of-swiftness-beea4a@penduick>
References: <20260519-drm-bridge-hotplug-v1-0-45e2bdb3dfb4@bootlin.com>
 <20260519-drm-bridge-hotplug-v1-5-45e2bdb3dfb4@bootlin.com>
 <20260608-mindful-heavy-frigatebird-be9faf@houat>
 <DJ735MTNMYD1.3LPNV404V8PIU@bootlin.com>
 <20260624-proud-unbiased-pony-ecc3c3@houat>
 <DJHEAWSEZR79.19UFIKS8QJBQ7@bootlin.com>
 <20260626-polite-hairy-perch-25e1aa@houat>
 <DJJ1MPCEJGZD.UZM9183V6ZE5@bootlin.com>
 <20260626-classy-nightingale-of-romance-1cacad@houat>
 <DJJ4X22CJ3FG.5EYF84LVRNOG@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="x6pdrlblnduy4h5o"
Content-Disposition: inline
In-Reply-To: <DJJ4X22CJ3FG.5EYF84LVRNOG@bootlin.com>
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


--x6pdrlblnduy4h5o
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 05/37] drm/display: bridge-connector: split code creating
 the connector to a subfunction
MIME-Version: 1.0

On Fri, Jun 26, 2026 at 06:51:14PM +0200, Luca Ceresoli wrote:
> On Fri Jun 26, 2026 at 4:38 PM CEST, Maxime Ripard wrote:
> > On Fri, Jun 26, 2026 at 04:16:39PM +0200, Luca Ceresoli wrote:
> >> Hi Maxime,
> >>
> >> On Fri Jun 26, 2026 at 12:09 PM CEST, Maxime Ripard wrote:
> >> > On Wed, Jun 24, 2026 at 05:47:10PM +0200, Luca Ceresoli wrote:
> >> >> On Wed Jun 24, 2026 at 1:41 PM CEST, Maxime Ripard wrote:
> >> >> > Hi,x
> >> >> >
> >> >> > On Fri, Jun 12, 2026 at 02:56:24PM +0200, Luca Ceresoli wrote:
> >> >> >> On Mon Jun 8, 2026 at 1:40 PM CEST, Maxime Ripard wrote:
> >> >> >> > On Tue, May 19, 2026 at 12:37:22PM +0200, Luca Ceresoli wrote:
> >> >> >> >> In preparation to introduce bridge hotplug, split out from
> >> >> >> >> drm_bridge_connector_init() the code adding the drm_connector=
 into a
> >> >> >> >> dedicated function. This will be needed to be able to add (an=
d re-add) the
> >> >> >> >> connector from different code paths.
> >> >> >> >
> >> >> >> > Same story here, explaining what you need later on that calls =
for that
> >> >> >> > change would be nice.
> >> >> >>
> >> >> >> Here's a more verbose version:
> >> >> >>
> >> >> >>     Currently drm_bridge_connector_init() does two things:
> >> >> >>
> >> >> >>      * allocate and initialize the drm_bridge_connector
> >> >> >>        (which embeds a drm_connector)
> >> >> >>      * initialize and register the embedded drm_connector
> >> >> >>
> >> >> >>     For bridge hotplug we need to separate these two actions:
> >> >> >>
> >> >> >>      * the drm_connector needs to be added and removed at any ti=
me based on
> >> >> >>        hotplug events
> >> >> >>      * the drm_bridge_connector is designated to create and remo=
ve the
> >> >> >>        drm_connector, so it must be persistent for the card life=
time
> >> >> >>
> >> >> >>     As the lifetimes of drm_bridge_connector and drm_connector b=
ecome
> >> >> >>     different, we need to create them in different moments.
> >> >> >>
> >> >> >>     In preparation to support that, split out from
> >> >> >>     drm_bridge_connector_init() the code adding the drm_connecto=
r into a
> >> >> >>     dedicated function. No functional changes, just moving code =
around for
> >> >> >>     now. A future commit will make the drm_connector be created =
based on
> >> >> >>     hotplug events.
> >> >> >>
> >> >> >> Looks good?
> >> >> >
> >> >> > The message itself, yes, thanks.
> >> >> >
> >> >> > However, I have questions now :)
> >> >> >
> >> >> > Do we really expect drm_bridge_connector to stick around when a b=
ridge
> >> >> > gets unplugged? If so, how does it cope with having, say, an HDMI
> >> >> > connector, and then swapping out the hotplugged part for an LVDS =
one?
> >> >> > Does the HDMI connector sticks around indefinitely?
> >> >>
> >> >> In your example, the HDMI drm_connector would be unregistered and p=
ut on
> >> >> hotunplug. Its allocation will stick around until the last put but =
that's
> >> >> quite irrelevant. Then, on plugging the LVDS addon, a new LVDS
> >> >> drm_connector will be created and registered.
> >> >>
> >> >> > *Especially* if we're using overlays for this, I'd expect everyth=
ing
> >> >> >  after the first hotplugged bridge to be destroyed, no?
> >> >>
> >> >> As said, it would be unregistered immediately but might be freed la=
ter on
> >> >> if still refcounted.
> >> >>
> >> >> This is visible in patches 36+15, the path to follow is:
> >> >>
> >> >>  drm_bridge_connector_handle_event(event =3D DRM_BRIDGE_DETACHED) [=
patch 36]
> >> >>  -> drm_bridge_connector_dynconn_release()                      [pa=
tch 15]
> >> >>
> >> >> Does this solve your concern?
> >> >
> >> > Not really, I'm talking about drm_bridge_connector. The fact that
> >> > bridges are destroyed make sense to me. The fact that
> >> > drm_bridge_connector sticks around doesn't. It's supposed to be a
> >> > connector for bridges. If you don't have bridges because they got
> >> > destroyed, and connector, drm_bridge_connector doesn't have a reason=
 to
> >> > exist anymore, unless it's drm_bridge_hotplug in a trench coat :)
> >>
> >> It is not a hotplug-bridge in a trench coat, no :) The code is clear a=
bout
> >> this.
> >>
> >> I'd say with this series a "drm_bridge_connector" is just becoming
> >> something more (perhaps something else too). Somewhat as "a drm_bridge=
 is
> >> either a bridge or something else". :)
> >>
> >>
> >> But let's leave names aside for a moment. If just looking at the curre=
nt
> >> code, the drm_bridge_connector is "a handler, owned by the card/encode=
r and
> >> having the same lifetime, which takes care of drm_connector
> >> creation/destruction at card probe/removal".
> >>
> >> What we need now is just the same plug " and on hotplug events" append=
ed.
> >>
> >> So in both cases there needs to be "a handler persitent with the card".
> >>
> >> Do we agree so far?
> >
> > Ish. If we go for that, then we need to update the name.
>=20
> drm_connector_manager?
> drm_bridge_connector_manager?
>=20
> > drm_bridge_connector for something that is neither a bridge or a
> > connector is not great.
> >
> > But even then, I'm not even sure why we need to have that "manager" in
> > the first place. You want to make bridges be aware if they are the last
> > in the chain or not. Use that property in attach to either create a
> > drm_bridge_connector instance if you're last, or attach the next bridge
> > if you aren't.
>=20
> What? o_O
>=20
> Several encoder drivers have been painfully converted to create a
> drm_bridge_connector.

I mean, it was done at a time where bridge hotplug wasn't a thing and
the assumption was that the bridge chain is static. You're now breaking
that assumption, it shouldn't come as a surprise that it might break
other things.

And I know that you have experienced it already, which makes your
reaction even more surprising to me :)

> Now if the bridges start doing it themselves we should go back to
> those encoder drivers and ditch all the drm_bridge_connector from
> there?
>=20
> I must be missing something. Can you elaborate on this?

drm_bridge_connectors bring together a (complete) bridge chain and a
connector. If you don't have either anymore, then we shouldn't keep it
around.

What I was suggesting before was only a suggestion. I guess we could
also make the encoder own the hotplug handling code and create the
drm_bridge_connector when the chain is complete, and remove it when it's
no longer the case.

We can discuss alternatives too. But either way, we shouldn't have it
stick around.

Maxime

--x6pdrlblnduy4h5o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCakzNIQAKCRAnX84Zoj2+
du+qAX43kljZZucgvri1zfEzUShKq54Eo19xSTUSYyjPDqJ97MVWyR/twJsiom7M
c1IT+5gBgPOy0Sqp9zNOEu4WUU2GiUkEcQulYkP9buQk0paAeCEbBX7WLLC9xT12
W3H+U3JZYg==
=wzdu
-----END PGP SIGNATURE-----

--x6pdrlblnduy4h5o--
