Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E71B5CD343F
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 09:28:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C8FE10E41D;
	Fri, 15 May 2026 09:28:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hQqpRUCI";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD3C210E41D
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 09:28:24 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 3420360008;
 Fri, 15 May 2026 09:28:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8635DC2BCB0;
 Fri, 15 May 2026 09:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778837303;
 bh=1lusloKra2BcMV6oSg1yvQoWUz9lgQJjDW5VorLGWfI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hQqpRUCI4pL8YaurygELdkvcOn0sVJ/3YZKDUGp/BZMWqoecAijk2Jpe1FGil8wvJ
 35XS/e/8G+bkQEYKO22+y/kQqoRg0tAKGmAmmtI79M6DWPm0Ijo7cLpAUmQMD2LbjG
 walH923XdXB+GLmAxt/zMAxM1HCaYnjpYJ/kqSTFRG7Zw1RH5r3WfTBRIpaHgrsC7D
 Ujxw4GqjEfC5c/v7EFM/kmjW1ZZHjKi7gEYjPgtVVj9jvojLYT8zCuhvXeEXrl0hb3
 LBvqY36WpTib4PB8Rbvuz1TL08vcSy7zRez1ttDfDgUGUkj+stRGB+q5WqFrhrxrgI
 9s7BCB2BSJHpQ==
Date: Fri, 15 May 2026 11:28:21 +0200
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
Subject: Re: [PATCH v4 3/3] drm/bridge: ite-it66121: Select HDMI or DVI mode
 based on sink type
Message-ID: <20260515-divergent-placid-avocet-ed0ffb@houat>
References: <20260515090220.809830-1-javierm@redhat.com>
 <20260515090220.809830-4-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="ae4ypa4vk7xyfysr"
Content-Disposition: inline
In-Reply-To: <20260515090220.809830-4-javierm@redhat.com>
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


--ae4ypa4vk7xyfysr
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 3/3] drm/bridge: ite-it66121: Select HDMI or DVI mode
 based on sink type
MIME-Version: 1.0

On Fri, May 15, 2026 at 11:02:11AM +0200, Javier Martinez Canillas wrote:
> The driver unconditionally sets the transmission mode to HDMI, which leads
> to display output not working with DVI monitors. Check connector's display
> information sink type to identify the correct mode to configure the bridg=
e.
>=20
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
>=20
> Changes in v4:
> - Convert the driver to use the HDMI helpers (Maxime Ripard).
> - Move .mode_set logic to .atomic_enable (Maxime Ripard).
>=20
> Changes in v3:
> - Move the HDMI/DVI mode set to the .atomic_enable handler (Maxime Ripard=
).
>=20
> Changes in v2:
> - Don't store the sink type in a per-commit bridge state (Maxime Ripard).
>=20
>  drivers/gpu/drm/bridge/ite-it66121.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridg=
e/ite-it66121.c
> index c8795247cfa8..95ee98a4a8df 100644
> --- a/drivers/gpu/drm/bridge/ite-it66121.c
> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
> @@ -184,6 +184,7 @@
> =20
>  #define IT66121_HDMI_MODE_REG			0xC0
>  #define IT66121_HDMI_MODE_HDMI			BIT(0)
> +#define IT66121_HDMI_MODE_DVI			0
> =20
>  #define IT66121_SYS_STATUS_REG			0x0E
>  #define IT66121_SYS_STATUS_ACTIVE_IRQ		BIT(7)
> @@ -658,6 +659,7 @@ static void it66121_set_mode(struct it66121_ctx *ctx,
>  			     struct drm_atomic_commit *state)
>  {
>  	struct drm_connector *connector =3D ctx->connector;
> +	unsigned int tx_mode =3D IT66121_HDMI_MODE_HDMI;
>  	const struct drm_crtc_state *crtc_state;
>  	const struct drm_display_mode *mode;
>  	struct drm_crtc *crtc;
> @@ -666,10 +668,13 @@ static void it66121_set_mode(struct it66121_ctx *ct=
x,
>  	crtc_state =3D drm_atomic_get_new_crtc_state(state, crtc);
>  	mode =3D &crtc_state->adjusted_mode;
> =20
> +	if (!connector->display_info.is_hdmi)
> +		tx_mode =3D IT66121_HDMI_MODE_DVI;
> +
>  	mutex_lock(&ctx->lock);
> =20
> -	/* Set TX mode to HDMI */
> -	if (regmap_write(ctx->regmap, IT66121_HDMI_MODE_REG, IT66121_HDMI_MODE_=
HDMI))
> +	/* Set TX mode to HDMI or DVI */
> +	if (regmap_write(ctx->regmap, IT66121_HDMI_MODE_REG, tx_mode))

A ternary operator would probably be better here?

Maxime

--ae4ypa4vk7xyfysr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCagbnNAAKCRAnX84Zoj2+
dhV0AYDOQYmT0ioUwk81s3iOZ18oO9qVkpMAS4n0orBtCspXw0lIxeueX/vlTcFn
mge5s9EBf1GERcsAS0jB4e7Z7w5uJDd7sadtsqBe/R8pYLjy0HoFkXiNKFHqEXGA
6rH35Axt3Q==
=x1+U
-----END PGP SIGNATURE-----

--ae4ypa4vk7xyfysr--
