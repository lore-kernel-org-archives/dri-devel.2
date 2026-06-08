Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E76CD8C9F
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 11:58:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87CA610F285;
	Mon,  8 Jun 2026 11:58:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aDYQlrpc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A385910F283
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 11:58:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7AB8F42DA1;
 Mon,  8 Jun 2026 11:58:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0CB31F00893;
 Mon,  8 Jun 2026 11:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780919909;
 bh=+0xzfXSHX2hdCkKNzJTDZp7i9BrsG509qQpWeW5OEvo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=aDYQlrpcGFobcKIUJiaIWSI7GgV6ZwBP9VMIiVGLqAXMgpBFM/wDuMA56rF+pqpwB
 UUkOAn+tKT+sMWP2fsXkqxHfaCA3GBPGXDaaMqqn7bLpPdKhNKOTWOgzmtIdl5IO6z
 Zu1fi+gxh6etnvlsd8Ynmxt6nmKmfCIxl/tgnsm449z4C9dMTD9dYSGCEQruS4pIx0
 7G/eryQ5r/Wojf+90+OtjnKw36ukjwmwpSVlzYu50/IVfGLgoY4qTVV0jfpOGIfkGt
 i6VNaB8LHTDptdmCbca6bFcO1Wlx6esyraR+/GS+cldnacLpPgOyAXs/K9jcgEPsaB
 Q+IzWS2rnXSFg==
Date: Mon, 8 Jun 2026 13:58:27 +0200
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
Subject: Re: [PATCH 19/37] drm/bridge: samsung-dsim: move drm_bridge_add()
 call to probe
Message-ID: <20260608-mellow-weasel-of-politeness-a56172@houat>
References: <20260519-drm-bridge-hotplug-v1-0-45e2bdb3dfb4@bootlin.com>
 <20260519-drm-bridge-hotplug-v1-19-45e2bdb3dfb4@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="jujnlpdemf3itkb7"
Content-Disposition: inline
In-Reply-To: <20260519-drm-bridge-hotplug-v1-19-45e2bdb3dfb4@bootlin.com>
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


--jujnlpdemf3itkb7
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 19/37] drm/bridge: samsung-dsim: move drm_bridge_add()
 call to probe
MIME-Version: 1.0

On Tue, May 19, 2026 at 12:37:36PM +0200, Luca Ceresoli wrote:
> This bridge driver calls drm_bridge_add() in the DSI host .attach callback
> instead of in the probe function.
>=20
> This works for current use cases but is problematic for supporting hotplug
> of DRM bridges. The problematic case is when this DSI host is always
> present while its DSI device is hot-pluggable. In such case with the
> current code the DRM card will not be populated until after the DSI device
> attaches to the host, which could happen a very long time after booting, =
or
> even not happen at all.
>=20
> The reason is that the previous pipeline component (the encoder in this
> case) when probing cannot find the samsung-dsim bridge. What happens is:
>=20
>  [1 and 2 can happen in any order, same result]
>  1) samsung-dsim probes (does not drm_bridge_add() itself)
>  2) The lcdif starts probing multiple times, but
>     lcdif_probe
>     -> lcdif_load
>        -> lcdif_attach_bridge
>           -> devm_drm_of_get_bridge() returns -EPROBE_DEFER because
>              the samsung-dsim is not in the global bridge_list
>              (deferred probe pending: imx-lcdif: Cannot connect bridge)
>=20
> The samsung-dsim will not drm_bridge_add() itself until a DSI device will
> try to mipi_dsi_attach() to the DSI Host, which can happen arbitratily la=
te
> on hot-pluggable hardware.
>=20
> As a preliminary step to supporting hotplug move drm_bridge_add() at probe
> time, so that the samsung-dsim DSI host bridge is available during boot,
> even without a connected DSI device. This results in:
>=20
>  1) samsung-dsim probes (and adds to drm_bridge_add() itself)
>  2) The lcdif starts probing multiple times, but
>     lcdif_probe
>     -> lcdif_load
>        -> lcdif_attach_bridge
>           -> devm_drm_of_get_bridge() --> OK, returns samsung-dsim ptr
>=20
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

We should probably amend
https://www.kernel.org/doc/html/latest/gpu/drm-kms-helpers.html#special-car=
e-with-mipi-dsi-bridges

To mention this use case here

Maxime

--jujnlpdemf3itkb7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaiauYgAKCRAnX84Zoj2+
duwQAYD6rpNKQLtVMjc9E/imbAZsWo++IjphqgU5DZIVqU3hkZzlEIwB45cAN7I4
97jNSiQBf0ZHBdJnO+5AbFv2QNHwL3tfCc1fF7wkOQBoYYjrgK9MzVhOAevUADgP
mIe4JqQvww==
=0a06
-----END PGP SIGNATURE-----

--jujnlpdemf3itkb7--
