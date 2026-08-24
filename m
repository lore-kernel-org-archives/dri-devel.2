Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C767C5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 08:17:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DCC110E69F;
	Mon, 24 Aug 2026 08:16:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WjxOUup5";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92B8310E69F
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 08:16:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4C3A740921;
 Mon, 24 Aug 2026 08:16:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE4761F000E9;
 Mon, 24 Aug 2026 08:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787559417;
 bh=ERLDzPQOXeD+X7Jl0or9tZeRLkXNAWK7vmrLd+9Fnzs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=WjxOUup5Sdq66xxznpS/NJf3MriqTgUQ4+zyGQNqYWC8gX72Ob/+UU+8dQX/uSefL
 fhlltiXXJWZv3OCBSCt/PPxa4PWCTH10GiGhsM0fYLPwgrrCyULTo5/ooRZrQmDcVS
 jKjuf3c/7KzPw6iN6963ZBm96mKW6cpgOB4fYUvhO983fIpGQ4PSOpqKawbKgiAWcS
 fmZ8p10g95L7GW3EoNszFgoXz2h7qFlJT+M1g5OZ/agoGubymhszkU+c3htrIA0io0
 p96Tax5ebtaIjRWP6YoMhs4+vKJwvUBeoqLzI+SS9nifLO8huwY/jOm7Fz757NBgSo
 kWmhZ6PeALG+w==
Date: Mon, 24 Aug 2026 10:16:53 +0200
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
Subject: Re: [PATCH 03/11] drm: of: drm_of_find_panel_or_bridge: prioritize
 the bridge, not the panel
Message-ID: <20260824-bouncy-papaya-cat-2c2073@houat>
References: <20260814-drm-bridge-every-panel-v1-0-19cd5277cc8d@bootlin.com>
 <20260814-drm-bridge-every-panel-v1-3-19cd5277cc8d@bootlin.com>
 <20260817-wonderful-helpful-falcon-db81c9@houat>
 <DKR7S2SRVHJG.2Z6RK35N9X4JU@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="r2qltygawcsnjzrg"
Content-Disposition: inline
In-Reply-To: <DKR7S2SRVHJG.2Z6RK35N9X4JU@bootlin.com>
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


--r2qltygawcsnjzrg
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 03/11] drm: of: drm_of_find_panel_or_bridge: prioritize
 the bridge, not the panel
MIME-Version: 1.0

On Mon, Aug 17, 2026 at 02:23:05PM +0200, Luca Ceresoli wrote:
> > That being said, if we do create a panel_bridge for every panel, why do
> > we still need drm_of_find_panel_or_bridge()? We'll only really need
> > of_drm_find_bridge(), no?
>=20
> Yes, in the long term we can get rid of drm_of_find_panel_or_bridge(), but
> not in the short term due to the above mentioned drivers, and others which
> use it in "creative" ways.
>=20
> The point is about the transition. This patch was an attempt to convert at
> once all the many drivers which use the most common pattern:
>=20
>       | drm_of_find_panel_or_bridge(..., &panel, &bridge);
>       | if (panel)
>       |     bridge =3D drm_panel_bridge_add();
>=20
> to then fix manually the remaining drivers (patches 6-11).
>=20
> But this approach doesn't fly due to the legacy users of
> drm_of_find_panel_or_bridge() as mentioned above.
>=20
> So what about this other approach instead:
>=20
>  1. leave drm_of_find_panel_or_bridge() as is (it's already deprecated an=
yway)
>  2. keep patch 5 (which "breaks" mayt drivers which would create an addit=
ional
>     panel_bridge)
>  3. perhaps add a warning when an additional bridge is created for the
>     some panel
>  4. *in the same series*, manually convert *all* drivers to use
>     of_drm_find_bridge() or of_drm_get_bridge_by_endpoint() -- like patch=
es
>     6-11, but done on all drivers
>  5. apply the series atomically, because it wouldn't be bisectable between
>     items 2 and 4
>=20
> Your opinion?

If we look at the drivers causing us troubles, fsl-ldb, samsung-dsim,
tc358767 and waveshare-dsi can be converted directly to
devm_drm_of_get_bridge().

mcde-dsi is a mess and would be hard to fix indeed, but since it's the
only really troublesome one, maybe we can just duplicate the code in the
driver and drop / rewrite the common code however we see fit.

Maxime

--r2qltygawcsnjzrg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaov99AAKCRAnX84Zoj2+
dm5RAYDFgncWfB8HNVBV3A4Zy3M1e1HjfjQlHBNI/8wz2WrjIFMjDK3NHra4s3x1
HWUTpmMBgIl7aZq/J/YJAo6vpIB/4wV7ZaQtf1Qmu3VMOYg+lkL7S3tA5Due5REl
ljvLSizFiA==
=7yEV
-----END PGP SIGNATURE-----

--r2qltygawcsnjzrg--
