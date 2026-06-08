Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C27CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 12:34:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8310510F31C;
	Mon,  8 Jun 2026 12:34:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JC6ME/Kg";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D515110F31C
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 12:34:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B3EEA423C1;
 Mon,  8 Jun 2026 12:34:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 253E41F00893;
 Mon,  8 Jun 2026 12:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780922096;
 bh=UNqQaOIfJNaZVR+CBoJFlLJLUJTFq5oaZgO7dOmVBmc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=JC6ME/KgOtTfnXLNZAJQRtLwg+EmrJ9EIzEBz7+EiC1DrXIrD7eaqbK/8LNTTJ6CD
 jDXSo978GpznzZEk5Q/ziQKkArfQk/TMD7vJmln55pUBjT8C/Oravm02YI6j8i0nZ6
 shUfKEUbhftiJ6H5/UleEGNyN7+K8qY9DGIZ9itjn1vLD6kBlWGXfxinria8zpSvJ6
 FMpsdO9Xpxyj6pUDG1YrdJd40MsUzbZ2uNq4AxSFMhhm14VkYCTbrcRihlxsdslkWn
 AxTMkycdHKhQ50DYkG7BPXdhhQRD7b6VUcr0u1YQsV3qh+fqB56Hq5ViYZRskwZxZv
 x2LsOkw/FObPQ==
Date: Mon, 8 Jun 2026 14:34:54 +0200
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
Subject: Re: [PATCH 30/37] drm/bridge: add drm_bridge_is_tail() to know
 whether a bridge completes the pipeline
Message-ID: <20260608-shapeless-opal-ferret-c8b105@houat>
References: <20260519-drm-bridge-hotplug-v1-0-45e2bdb3dfb4@bootlin.com>
 <20260519-drm-bridge-hotplug-v1-30-45e2bdb3dfb4@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="hnivroopehfpq7yz"
Content-Disposition: inline
In-Reply-To: <20260519-drm-bridge-hotplug-v1-30-45e2bdb3dfb4@bootlin.com>
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


--hnivroopehfpq7yz
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 30/37] drm/bridge: add drm_bridge_is_tail() to know
 whether a bridge completes the pipeline
MIME-Version: 1.0

On Tue, May 19, 2026 at 12:37:47PM +0200, Luca Ceresoli wrote:
> For bridge hotplug we need to successfully probe a card with an incomplete
> bridge chain, i.e. a chain whose last bridge currently in bridge_chain
> needs a next_bridge to work. Such a card would have no connector, and be
> able to add one as soon as the followong bridges are added up to the tail
> bridge (e.g. a panel_bridge or a connector_bridge).
>=20
> Currently common DRM code is unable to tell whether the last bridge
> currently in the chain is the tail bridge (=3D the pipeline is complete) =
or
> not.
>=20
> Add drm_bridge_is_tail(), and a .is_tail func for it to rely on, so common
> code can know whether a bridge is a tail bridge or needs a next_bridge.
>=20
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  drivers/gpu/drm/drm_bridge.c | 28 ++++++++++++++++++++++++++++
>  include/drm/drm_bridge.h     | 19 +++++++++++++++++++
>  2 files changed, 47 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index c62d17e84d4f..2b539c9749a6 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -646,6 +646,34 @@ void drm_bridge_detach(struct drm_bridge *bridge)
>  	drm_bridge_put(bridge);
>  }
> =20
> +/**
> + * drm_bridge_is_tail - check whether the bridge is the last required to
> + *                      have a full pipeline
> + * @bridge: the bridge to check
> + *
> + * Tell whether this is a tail bridge, i.e. a bridge that does not need a
> + * next bridge to work. E.g. a panel_bridge is final, a DSI-to-LVDS brid=
ge
> + * is not.
> + *
> + * In case of hotplug the last bridge currently in the chain (as in
> + * drm_bridge_chain_get_last_bridge()) might not be final, and be waiting
> + * for a pipeline tail to be connected.
> + *
> + * Return: true if this bridge does not need a next bridge to work, false
> + * otherwise
> + */
> +bool drm_bridge_is_tail(struct drm_bridge *bridge)
> +{
> +	if (!(bridge->ops & DRM_BRIDGE_OP_IS_TAIL)) {
> +		drm_warn_once(bridge->dev, "is_tail func not implemented by bridge %ps=
!",
> +			      bridge->funcs);
> +		return false;
> +	}
> +
> +	return bridge->funcs->is_tail(bridge);
> +}
> +EXPORT_SYMBOL(drm_bridge_is_tail);
> +
>  /**
>   * DOC: bridge operations
>   *
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index 4ba3a5deef9a..d783a6fb93a0 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -78,6 +78,19 @@ struct drm_bridge_funcs {
>  	int (*attach)(struct drm_bridge *bridge, struct drm_encoder *encoder,
>  		      enum drm_bridge_attach_flags flags);
> =20
> +	/**
> +	 * @is_tail:
> +	 *
> +	 * Returns true if this is a tail bridge, i.e. it does not need a
> +	 * next bridge to work. E.g. a panel_bridge is a tail bridge, a
> +	 * DSI-to-LVDS bridge is not a tail bridge (no matter whether the
> +	 * next bridge is present or not).

Why a DSI-to-LDVS bridge isn't a tail bridge? It only needs a panel
next, right?

> +	 * The @is_tail callback is optional but it is required if the
> +	 * bridge is part of a pipeline with hot-pluggable components.
> +	 */
> +	bool (*is_tail)(struct drm_bridge *bridge);
> +

I don't think that's the right way to think about it, if only because
you never really know at the driver level if you're supposed to be last
or not. A DSI-to-LVDS bridge might just as well be chained with an
LVDS-to-eDP bridge, or feed the panel directly without any additional
bridge.

I *think* that what you're trying to find out here is whether the chain
is complete or not. I think you can get the same information by checking
whether you have a connector for that bridge chain. If you don't, you
know the chain isn't complete, and if you do, it's supposed to be.
DRM_BRIDGE_ATTACH_NO_CONNECTOR could be useful too, because if all you
bridges support it but there's no connector, there's something wrong.

Anyway.

Maxime

>  	/**
>  	 * @destroy:
>  	 *
> @@ -1092,6 +1105,11 @@ enum drm_bridge_ops {
>  	 * &drm_bridge_funcs->hdmi_clear_spd_infoframe callbacks.
>  	 */
>  	DRM_BRIDGE_OP_HDMI_SPD_INFOFRAME =3D BIT(10),
> +	/**
> +	 * @DRM_BRIDGE_OP_IS_TAIL: The bridge implements the
> +	 * &drm_bridge_funcs->is_tail callback.
> +	 */
> +	DRM_BRIDGE_OP_IS_TAIL =3D BIT(11),
>  };

That part is confusing to me. This is meant for drm_bridge_connector,
but since we need to handle the case where we don't have a connector
(and thus no drm_bridge_connector) I don't think this should be used at
all?

Maxime

--hnivroopehfpq7yz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaia27QAKCRAnX84Zoj2+
djcoAX9LTD9Oxc7k2EL51l9KwC5S6GhVdB5QCdzG276hO+gNyylAprQxEuReihPY
ozhnG9kBfi/C9dSJLq9LqSs8A4OZzOqpk8bSpD4OxriCKCSAB/lFND8uOe32LJ9h
g/Jfw6PofA==
=c3m8
-----END PGP SIGNATURE-----

--hnivroopehfpq7yz--
