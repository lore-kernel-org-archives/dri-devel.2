Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99157CD4851
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 09:40:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 035C210F4B9;
	Fri, 15 May 2026 09:40:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mdhi0bYs";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A387210F4B9
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 09:40:23 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 6E3EE407F2;
 Fri, 15 May 2026 09:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C460DC2BCB3;
 Fri, 15 May 2026 09:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778838023;
 bh=YbA63muPT1j+SiLdwpBi9NUcDUJ48wiB1wKU/0auu4U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mdhi0bYsTe9hPYeTGbaziWa0hPvrNs2gzFCxzw74VBzNIFuE6aCNbRPnfB72Jqs5F
 eOu3lc674pngzZoTKfHcwJA+ABwvOeSxWRPILWYtYqJqXW4r+LnV/BCNJ5zSgprKnA
 BxWj9zVajP7uTB7Vu8UpaeC/9IgLW2iUXPgZsqhdEy3Nr52DsUYT5IeWPRM2V85Jlj
 7HF7RQor4Nf+7Llp2gEeVM+cvaLN4TPKN12FDwDicWykITuVN3UcSk+UvcXI2RTXoS
 msa5f7/dR6iBPSi9aGM/FDQ1M+Ng45yexWF17PtzqL9Ag4kHmiKRxV0fvYEfQozoR8
 KgDlABn6aBJ4A==
Date: Fri, 15 May 2026 11:40:20 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrzej Hajda <andrzej.hajda@intel.com>, 
 David Airlie <airlied@gmail.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Phong LE <ple@baylibre.com>,
 Robert Foss <rfoss@kernel.org>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, 
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 1/3] drm/bridge: ite-it66121: Switch to the HDMI
 connector helpers
Message-ID: <20260515-solemn-knowing-malamute-b0d6e1@houat>
References: <20260515090220.809830-1-javierm@redhat.com>
 <20260515090220.809830-2-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="zl32isfo2xwc3feo"
Content-Disposition: inline
In-Reply-To: <20260515090220.809830-2-javierm@redhat.com>
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


--zl32isfo2xwc3feo
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 1/3] drm/bridge: ite-it66121: Switch to the HDMI
 connector helpers
MIME-Version: 1.0

On Fri, May 15, 2026 at 11:02:09AM +0200, Javier Martinez Canillas wrote:
> +static enum drm_mode_status
> +it66121_bridge_hdmi_tmds_char_rate_valid(const struct drm_bridge *bridge,
> +					 const struct drm_display_mode *mode,
> +					 unsigned long long tmds_rate)
> +{
> +	const struct it66121_ctx *ctx =3D
> +		container_of(bridge, const struct it66121_ctx, bridge);
> +	unsigned long max_clock;
> +
> +	max_clock =3D (ctx->bus_width =3D=3D 12) ? 74250 : 148500;
> +
> +	if (mode->clock > max_clock)
> +		return MODE_CLOCK_HIGH;
> +
> +	if (mode->clock < 25000)
> +		return MODE_CLOCK_LOW;
> +
> +	return MODE_OK;
> +}

You must not use mode->clock here, use the tdms_rate passed as an argument.

>  static irqreturn_t it66121_irq_threaded_handler(int irq, void *dev_id)
> @@ -1588,7 +1615,10 @@ static int it66121_probe(struct i2c_client *client)
> =20
>  	ctx->bridge.of_node =3D dev->of_node;
>  	ctx->bridge.type =3D DRM_MODE_CONNECTOR_HDMIA;
> -	ctx->bridge.ops =3D DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID;
> +	ctx->bridge.ops =3D DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID |
> +			  DRM_BRIDGE_OP_HDMI;
> +	ctx->bridge.vendor =3D "ITE";
> +	ctx->bridge.product =3D "IT66121";
>  	if (client->irq > 0) {
>  		ctx->bridge.ops |=3D DRM_BRIDGE_OP_HPD;

It's not really for today, but ideally we should move to the audio
helpers at some point too.

Maxime

--zl32isfo2xwc3feo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCagbqBAAKCRAnX84Zoj2+
dlU1AX9dNvJ0B8i1AnQWTfJ1CS1pLa9y+TX5n0XrjfSXZTwQrUUbOv9X2rvHkJQ7
xIn0ul4BgPqzWI0GLNBPjvA/Q+nnloBt7fwq8eEInl8WRZxUVqXzIQglKqrQTBko
OOApmpsAUg==
=5FCV
-----END PGP SIGNATURE-----

--zl32isfo2xwc3feo--
