Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED94C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 08:26:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9439610E3E3;
	Mon, 17 Aug 2026 08:26:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="f62v6xBV";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35D7310E3E3
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 08:26:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CD35B415CA;
 Mon, 17 Aug 2026 08:26:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5271F000E9;
 Mon, 17 Aug 2026 08:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786955201;
 bh=QnBWE/oqBZi19iBTIHXEmLTZjPrfIJT8hsF1UmIDt2E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=f62v6xBV33ZL6Og1AsJTYOKKtxIefDerN2nBcZG73loEM8GKNVOYYClxHqFlqW6FX
 IYFLGMqumwxe93TTnlLBAp9fWHe/aIW/Ijwvd531zrYuV3+VifAOmiLjM5QMuq2+D3
 WRCDco4U5RGSTb0v8MT0336E/VaxfowpN1DPXhOsJMJCBDtx6evJopHH89uaUHd/92
 SldVRLC+JT8JQwaEcsU2H3HKJaKj4KOf05dA8RQhc5gDp7VDJpRJF9eNESd02TArWW
 lqoVi0HZ1O0SZDJSnKY9j1/dMJoDQZ8FqUTs0MN6opoY4HQSx1KG3JKGoJN6Vf5xkh
 r5ucfNngPbPeQ==
Date: Mon, 17 Aug 2026 10:26:39 +0200
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
Message-ID: <20260817-wonderful-helpful-falcon-db81c9@houat>
References: <20260814-drm-bridge-every-panel-v1-0-19cd5277cc8d@bootlin.com>
 <20260814-drm-bridge-every-panel-v1-3-19cd5277cc8d@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="i5bqgsb6y4kuv5pw"
Content-Disposition: inline
In-Reply-To: <20260814-drm-bridge-every-panel-v1-3-19cd5277cc8d@bootlin.com>
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


--i5bqgsb6y4kuv5pw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 03/11] drm: of: drm_of_find_panel_or_bridge: prioritize
 the bridge, not the panel
MIME-Version: 1.0

Hi,

On Fri, Aug 14, 2026 at 04:05:51PM +0200, Luca Ceresoli wrote:
> By the documentation drm_of_find_panel_or_bridge() returns a "drm_panel or
> drm_bridge", without specifying which one is returned in case both exist.
>=20
> Definitely it never returns both. If both exist (and @bridge is !=3D NULL=
),
> the current implementation prioritizes the drm_panel pointer and returns
> that. In most cases (including devm_drm_of_get_bridge() and
> drmm_of_get_bridge()) this is used to implement the following logic
> (simplified):
>=20
>     drm_of_find_panel_or_bridge(..., &panel, &bridge);
>     if (panel)
>         bridge =3D [devm_]drm_panel_bridge_add[_typed](panel);
>=20
> Work is in progress to make every drm_panel automatically create a
> panel_bridge, so a panel_bridge will always be present for every
> drm_panel. This means the above logic would create a panel_bridge that
> already exists. Avoid it by returning the drm_bridge when both are presen=
t,
> instead of the drm_panel.
>=20
> For the case where @bridge =3D=3D NULL, this commit does not change anyth=
ing:
> the 'if (bridge)' body is never executed and the drm_panel (if found) is
> always returned.
>=20
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

I'm always a bit concerned about that kind of change, because you
basically change some part of the API we don't really know if a driver
relies on.

That being said, if we do create a panel_bridge for every panel, why do
we still need drm_of_find_panel_or_bridge()? We'll only really need
of_drm_find_bridge(), no?

Maxime

--i5bqgsb6y4kuv5pw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaoLFvwAKCRAnX84Zoj2+
dukxAX9Wzw0vUAsnDfnLRDWYZgHtwUIJEwLuUq2f501vIQPdF3NEE583hT/w5oNx
+YqiRukBf0MeTKbqcK8HATX1hDNH/3HiuJ0B3gjU1SRCV+A5Urh4qYnmIw1fct/Z
c/AD8nO35Q==
=jzve
-----END PGP SIGNATURE-----

--i5bqgsb6y4kuv5pw--
