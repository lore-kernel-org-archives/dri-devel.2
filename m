Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D86DDCD8C9F
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 12:07:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09FB910F2A7;
	Mon,  8 Jun 2026 12:07:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QIhH3Dkj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05DF310F2A7
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 12:07:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CB7434063B;
 Mon,  8 Jun 2026 12:07:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6921F00893;
 Mon,  8 Jun 2026 12:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780920438;
 bh=fzKmRE/c3YW6bME9j/93sSqsxS7lu6l7nbyxWtTfJ8w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=QIhH3DkjuFmZdQJiQwpq3z684KdzevYBZ3FxzsTNbThYX0AQhcPzqB3KTwHEG5Qdn
 ir9AJIIbef4rlhl9JvHh46kwAoWNhJS8i2+G+GFyHAB9ezdL/Sm1bUWTgM6xAC4HoK
 JadouGx25hTowYD2ig0NRkQRzORb+h0elb1YPRgqjV8Snrlg7Suhk9/tI00wtigEPi
 tZZBdYmfA6Wv6gy0E65flr9h5Xctz1ekFWXmI0Da2Tqh240k1/k1uuF6V/xlR50nLc
 HEAtN4Be53++XNBN3GS7P0CljkTzNz1yIV9OWHFUZvwNLAd0UdnAh1dB0EKUa4Dd8q
 7C84hvM99oYzQ==
Date: Mon, 8 Jun 2026 14:07:16 +0200
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
Subject: Re: [PATCH 25/37] drm/bridge: shutdown and cleanup on bridge unplug
Message-ID: <20260608-resilient-outgoing-panther-9efc53@houat>
References: <20260519-drm-bridge-hotplug-v1-0-45e2bdb3dfb4@bootlin.com>
 <20260519-drm-bridge-hotplug-v1-25-45e2bdb3dfb4@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="runcsy6vq4746hhd"
Content-Disposition: inline
In-Reply-To: <20260519-drm-bridge-hotplug-v1-25-45e2bdb3dfb4@bootlin.com>
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


--runcsy6vq4746hhd
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 25/37] drm/bridge: shutdown and cleanup on bridge unplug
MIME-Version: 1.0

Hi,

On Tue, May 19, 2026 at 12:37:42PM +0200, Luca Ceresoli wrote:
> With the upcoming support for DRM bridge hot(un)plugging, bridges can be
> removed at any time withotu tearing down the entire card. When this
> happens, shutdown the pipeline and detach from the encoder chain the brid=
ge
> being removed along with all the following ones.
>=20
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  drivers/gpu/drm/drm_bridge.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 7f2d1a81d730..d45fb74ec8c2 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -462,9 +462,17 @@ EXPORT_SYMBOL(devm_drm_bridge_add);
>   * it won't be found by users via of_drm_find_and_get_bridge(), and add =
it
>   * to the lingering bridge list, to keep track of it until its allocated
>   * memory is eventually freed.
> + *
> + * If the bridge is attached, also disable the active output and detach
> + * this bridge and the following ones.
>   */
>  void drm_bridge_remove(struct drm_bridge *bridge)
>  {
> +	if (bridge->encoder) {
> +		drm_atomic_shutdown(bridge->dev);
> +		drm_encoder_cleanup_from(bridge->encoder, bridge);
> +	}
> +
>  	mutex_lock(&bridge_lock);
>  	list_move_tail(&bridge->list, &bridge_lingering_list);
>  	mutex_unlock(&bridge_lock);

I don't think this makes a lot of sense to disable the whole device at
once. The connector, encoder, and the CRTC might, but the whole device
doesn't.

Even then, I'm not sure we should disable anything. How does DP-MST
handles removal?

Maxime

--runcsy6vq4746hhd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaiawdAAKCRAnX84Zoj2+
dlutAXwLb/lzFiY4Bqaim2RwnNqhbTo/NPoCNzh8V/tQ1zxLugn7ChtaL/weqRTw
httlwgABgNm0m35oh5VFSw6suBNeI5wca6gsWhRHRBjDmIOSoS/q5nAmz4DyindF
FISfGAzktg==
=7d4e
-----END PGP SIGNATURE-----

--runcsy6vq4746hhd--
