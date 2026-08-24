Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45204C5DF94
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 07:48:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEFD410E0DD;
	Mon, 24 Aug 2026 07:48:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UILaa172";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E73610E0DD
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 07:48:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 477BE600AD;
 Mon, 24 Aug 2026 07:48:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EAC71F00A3A;
 Mon, 24 Aug 2026 07:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787557701;
 bh=gvxn56GCa/YC3zvxzECuLygDdT/mb/cSI/XsHlMFYow=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=UILaa172E/TaXhRlct/PtqjEdhf3BpRu65N3LHXaXM4ao+KP4VL2TL6DJw0QvvtI5
 OzEPoIb4qQxw7G41T1ujtm2EmltWBqCxOIhugG7I51fecEJuh5IkNIdpM2eJUv/Z1d
 rpYm3JW/8z5dnl4lfYbTXGAgEkBJewMfbpW3m5FFo4yIo36Alk3sDBlbFU78Dj0tUj
 VyR2SAgb8jWlt4U0ln/056vHanV2newxhFQsVKD9o5vV9mZn8vS4QGk8O/sd9QlkKf
 Vio2MCBS6EGENBBhHgp/EAqyNZti5xw3c8gNYvFFEon8h/6IzfN4QCdj6ANmvN0/uX
 847NjhkQOsu/g==
Date: Mon, 24 Aug 2026 09:48:17 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Linus Walleij <linusw@kernel.org>, Inki Dae <inki.dae@samsung.com>, 
 Jagan Teki <jagan@amarulasolutions.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] drm/panel: merge the drm_kms_helper module into
 the drm module
Message-ID: <20260824-cuddly-aardwark-of-reward-0d93d4@houat>
References: <DKR7VTBLRBQW.2LLJMDO74KXNO@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="54ramgk3ko4dclu3"
Content-Disposition: inline
In-Reply-To: <DKR7VTBLRBQW.2LLJMDO74KXNO@bootlin.com>
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


--54ramgk3ko4dclu3
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 04/11] drm/panel: merge the drm_kms_helper module into
 the drm module
MIME-Version: 1.0

On Mon, Aug 17, 2026 at 02:27:58PM +0200, Luca Ceresoli wrote:
> On Mon Aug 17, 2026 at 10:31 AM CEST, Maxime Ripard wrote:
> > On Fri, Aug 14, 2026 at 04:05:52PM +0200, Luca Ceresoli wrote:
> >> Work is in progress to make every drm_panel automatically create a
> >> panel_bridge [0][1].
> >>
> >> This requires the panel code to call the drm_panel_bridge APIs. However
> >> this would create a circular dependency loop on modular builds:
> >>
> >> __devm_drm_panel_alloc() [drm]
> >>    -> drm_panel_bridge_add() [drm_kms_helper]
> >>       -> drm_bridge.c APIs [drm]
> >>
> >> Moving just the panel_brige.o file from [drm_kms_helper] to [drm] does=
 not
> >> work because the panel bridge code uses the drm_atomic_helper and
> >> drm_probe_helper which add further dependencies on symbols in the
> >> [drm_kms_helper] module.
> >>
> >> So take a simple approach, and move the entire drm_kms_helper into the
> >> [drm] module.
> >>
> >> Link: https://lore.kernel.org/all/emuj2innmp6zmzd7pyakqzjqpdzhly6qfhak=
ya3ydwmd63pl26@5jwxaidpikjw/ [0]
> >> Link: https://lore.kernel.org/lkml/20250206-hotplug-drm-bridge-v6-8-9d=
6f2c9c3058@bootlin.com/ [1]
> >> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> >
> > So, that's not an option. However, why do we need drm_panel_bridge_add()
> > after this work is done? If we want to create a bridge for every panel,
> > then the bridge implementation can live in drm_panel.c, which is part of
> > the drm module.
> >
> > And we'd essentially move drm_panel_bridge into drm_panel.c, and make it
> > private.
>=20
> Yes in theory, but the panel_bridge code uses other parts of the
> drm_kms_helper module: drm_atomic_helper and drm_probe_helper, maybe more,
> so we'd have to move them into the drm module too.

Ah, right. What would happen if we were doing it the other way around
then? Move drm_panel out of the main drm module?

> Is it worth trying to identify only the closure of files in drm_kms_helpe=
rs
> that are actually used by the panel_bridg, and move only them? That'd mean
> having some *_helper.c files in the drm module and other *_helper.c files
> in the drm module.
>=20
> There's a licensing aspect too: drm_panel.c is MIT-licensed, bridge/panel=
=2Ec
> is GPL-2.0-or-later. However my understanding is that we can merge the two
> into a single file and the result would all be GPL-2.0-or-later, so that =
is
> an option.

Yeah, that's not a concern.

Maxime

--54ramgk3ko4dclu3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaov3OgAKCRAnX84Zoj2+
ds07AX4+9IZBiOb3MSorvCizFv+Fhr2qCnrhvsXiRRZlitvlGbNob6rxdNQghsOI
27nD19MBfjVtqBAHVQ3Peut0xqSE6FG/ln4hvJMeUZ7Bml+g5fi398Avr3x2o34u
WV7QmXNlCQ==
=zJmI
-----END PGP SIGNATURE-----

--54ramgk3ko4dclu3--
