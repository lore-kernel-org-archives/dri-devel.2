Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51443C5CFC1
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 08:32:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B188110E6D3;
	Mon, 17 Aug 2026 08:32:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oGduTKlK";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0AD210E6D3
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 08:31:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 05307600AE;
 Mon, 17 Aug 2026 08:31:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB091F000E9;
 Mon, 17 Aug 2026 08:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786955517;
 bh=DjvN9I+WiqrDRVWKGAcxEQxe3u5A5q92qU/dyJKtweY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=oGduTKlKZtNGH0fL0vjCr4oOuG53BSVJXccrMN+T9IjX8zTXh60uHYABRw8jn3LEq
 OjqXOJ+bjk8DSSlQZrWH28ekGsEkSqNGt+rD1xb0vS9KUeEt5JWY60ZPo6bqqRg4gW
 +kHDsn/TEeZyoHfKFLJ68B6ynlR9lMOmbNVJPVUTxJp5eEh+8DRwsS7hNFrYOeofjL
 y0wEucSJDRJBApcOiBuYzoIlnd670V/WMUtIAgrqr0+AaOVS1uAnVdCJKVDoMuWnzu
 wu1mM3ykqM8uVDObX/HFUasdNLs/6nv7LPPVqfuCk/p4pqjNZxmpeKZGUjxUSrb7hk
 DZUl5smbyI/ow==
Date: Mon, 17 Aug 2026 10:31:55 +0200
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
Message-ID: <20260817-lumpy-wooden-bird-4bdfb4@houat>
References: <20260814-drm-bridge-every-panel-v1-0-19cd5277cc8d@bootlin.com>
 <20260814-drm-bridge-every-panel-v1-4-19cd5277cc8d@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="f22edln4f6seruam"
Content-Disposition: inline
In-Reply-To: <20260814-drm-bridge-every-panel-v1-4-19cd5277cc8d@bootlin.com>
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


--f22edln4f6seruam
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 04/11] drm/panel: merge the drm_kms_helper module into
 the drm module
MIME-Version: 1.0

On Fri, Aug 14, 2026 at 04:05:52PM +0200, Luca Ceresoli wrote:
> Work is in progress to make every drm_panel automatically create a
> panel_bridge [0][1].
>=20
> This requires the panel code to call the drm_panel_bridge APIs. However
> this would create a circular dependency loop on modular builds:
>=20
> __devm_drm_panel_alloc() [drm]
>    -> drm_panel_bridge_add() [drm_kms_helper]
>       -> drm_bridge.c APIs [drm]
>=20
> Moving just the panel_brige.o file from [drm_kms_helper] to [drm] does not
> work because the panel bridge code uses the drm_atomic_helper and
> drm_probe_helper which add further dependencies on symbols in the
> [drm_kms_helper] module.
>=20
> So take a simple approach, and move the entire drm_kms_helper into the
> [drm] module.
>=20
> Link: https://lore.kernel.org/all/emuj2innmp6zmzd7pyakqzjqpdzhly6qfhakya3=
ydwmd63pl26@5jwxaidpikjw/ [0]
> Link: https://lore.kernel.org/lkml/20250206-hotplug-drm-bridge-v6-8-9d6f2=
c9c3058@bootlin.com/ [1]
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

So, that's not an option. However, why do we need drm_panel_bridge_add()
after this work is done? If we want to create a bridge for every panel,
then the bridge implementation can live in drm_panel.c, which is part of
the drm module.

And we'd essentially move drm_panel_bridge into drm_panel.c, and make it
private.

Maxime

--f22edln4f6seruam
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaoLG+wAKCRAnX84Zoj2+
dutBAX0T7wF4IXEZg8CkFyzW4tBIz9tMu/FMHfXQc7tpKZYnKkZV7lXA//AIl7vk
0odgEEABgOFBtDMl9SoXyhqJFzh7YNbWgX2xm5TZ7YU3k3ncEWyI3o0hAye6MYH9
bsliHhEkbw==
=4hMm
-----END PGP SIGNATURE-----

--f22edln4f6seruam--
