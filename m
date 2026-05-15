Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FAAECD343F
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 09:23:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4B9E10E0A0;
	Fri, 15 May 2026 09:23:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JitVZqBR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0519910E0A0
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 09:23:44 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 312A160008;
 Fri, 15 May 2026 09:23:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 890E1C2BCB8;
 Fri, 15 May 2026 09:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778837022;
 bh=mJV8pixwnFV4lB2rrH7aZq2tGvu64ikU86/6Enkz6Ic=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JitVZqBRSC1OIdHHklzMxjSGuJeFF54/NsJqMal2FpKjl8aUKzxHy1gzwPcvXqckN
 z6ZZ96lmeeaRAZFc4sNmwQ5xOu6DqDX43evngkoyBUUKACCLXDz+XQVLIkUQPiWiCe
 qpFsycwXMKng4RMIrFzlRPoFIocvd1+Vyb8u+3zalBER1XKVn4nXeyo3enqqU1uYRG
 6apKtICeBU9UBLFntg4pweyI8oavaehOJJ72rJrLbBiHMw+gIh9jt9ziezWjzxQKEl
 eRalHujFBo73plSQBuLiobXPAmTeLcPzq4lbRzM5PN7vQlrniY1Ov4BGwujARMf7xY
 nQQSQ2Lp5cwTw==
Date: Fri, 15 May 2026 11:23:40 +0200
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
Message-ID: <20260515-magnificent-boisterous-dragonfly-2560d4@houat>
References: <20260515090220.809830-1-javierm@redhat.com>
 <20260515090220.809830-2-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="l35sxo3szxdjhnfb"
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


--l35sxo3szxdjhnfb
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 1/3] drm/bridge: ite-it66121: Switch to the HDMI
 connector helpers
MIME-Version: 1.0

On Fri, May 15, 2026 at 11:02:09AM +0200, Javier Martinez Canillas wrote:
> Instead of open coding the HDMI AVI Infoframes buffer management,
> use the helpers provided by the HDMI connector framework.
>=20
> Suggested-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
>=20
> Changes in v4:
> - New patch for v4
>=20
>  drivers/gpu/drm/bridge/Kconfig       |   2 +
>  drivers/gpu/drm/bridge/ite-it66121.c | 132 ++++++++++++++++-----------
>  2 files changed, 83 insertions(+), 51 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kcon=
fig
> index f81b566c82a1..4a57d49b4c6d 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -205,6 +205,8 @@ config DRM_LONTIUM_LT8713SX
>  config DRM_ITE_IT66121
>  	tristate "ITE IT66121 HDMI bridge"
>  	depends on OF
> +	select DRM_DISPLAY_HDMI_STATE_HELPER
> +	select DRM_DISPLAY_HELPER
>  	select DRM_KMS_HELPER
>  	select REGMAP_I2C
>  	help
> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridg=
e/ite-it66121.c
> index 19a027d75b61..947b7a0f0a45 100644
> --- a/drivers/gpu/drm/bridge/ite-it66121.c
> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
> @@ -20,6 +20,8 @@
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/regulator/consumer.h>
> =20
> +#include <drm/display/drm_hdmi_helper.h>
> +#include <drm/display/drm_hdmi_state_helper.h>
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_bridge.h>
>  #include <drm/drm_edid.h>
> @@ -304,7 +306,6 @@ struct it66121_ctx {
>  	struct i2c_client *client;
>  	u32 bus_width;
>  	struct mutex lock; /* Protects fields below and device registers */
> -	struct hdmi_avi_infoframe hdmi_avi_infoframe;
>  	struct {
>  		struct platform_device *pdev;
>  		u8 ch_enable;
> @@ -727,6 +728,10 @@ static void it66121_bridge_enable(struct drm_bridge =
*bridge,
>  	struct it66121_ctx *ctx =3D container_of(bridge, struct it66121_ctx, br=
idge);
> =20
>  	ctx->connector =3D drm_atomic_get_new_connector_for_encoder(state, brid=
ge->encoder);
> +	if (!ctx->connector)
> +		return;
> +
> +	drm_atomic_helper_connector_hdmi_update_infoframes(ctx->connector, stat=
e);
> =20
>  	it66121_set_mute(ctx, false);
>  }
> @@ -764,40 +769,10 @@ void it66121_bridge_mode_set(struct drm_bridge *bri=
dge,
>  			     const struct drm_display_mode *mode,
>  			     const struct drm_display_mode *adjusted_mode)
>  {
> -	u8 buf[HDMI_INFOFRAME_SIZE(AVI)];
>  	struct it66121_ctx *ctx =3D container_of(bridge, struct it66121_ctx, br=
idge);
> -	int ret;
> =20
>  	mutex_lock(&ctx->lock);
> =20
> -	ret =3D drm_hdmi_avi_infoframe_from_display_mode(&ctx->hdmi_avi_infofra=
me, ctx->connector,
> -						       adjusted_mode);
> -	if (ret) {
> -		DRM_ERROR("Failed to setup AVI infoframe: %d\n", ret);
> -		goto unlock;
> -	}
> -
> -	ret =3D hdmi_avi_infoframe_pack(&ctx->hdmi_avi_infoframe, buf, sizeof(b=
uf));
> -	if (ret < 0) {
> -		DRM_ERROR("Failed to pack infoframe: %d\n", ret);
> -		goto unlock;
> -	}
> -
> -	/* Write new AVI infoframe packet */
> -	ret =3D regmap_bulk_write(ctx->regmap, IT66121_AVIINFO_DB1_REG,
> -				&buf[HDMI_INFOFRAME_HEADER_SIZE],
> -				HDMI_AVI_INFOFRAME_SIZE);
> -	if (ret)
> -		goto unlock;
> -
> -	if (regmap_write(ctx->regmap, IT66121_AVIINFO_CSUM_REG, buf[3]))
> -		goto unlock;
> -
> -	/* Enable AVI infoframe */
> -	if (regmap_write(ctx->regmap, IT66121_AVI_INFO_PKT_REG,
> -			 IT66121_AVI_INFO_PKT_ON | IT66121_AVI_INFO_PKT_RPT))
> -		goto unlock;
> -
>  	/* Set TX mode to HDMI */
>  	if (regmap_write(ctx->regmap, IT66121_HDMI_MODE_REG, IT66121_HDMI_MODE_=
HDMI))
>  		goto unlock;
> @@ -825,24 +800,6 @@ void it66121_bridge_mode_set(struct drm_bridge *brid=
ge,
>  	mutex_unlock(&ctx->lock);
>  }
> =20
> -static enum drm_mode_status it66121_bridge_mode_valid(struct drm_bridge =
*bridge,
> -						      const struct drm_display_info *info,
> -						      const struct drm_display_mode *mode)
> -{
> -	struct it66121_ctx *ctx =3D container_of(bridge, struct it66121_ctx, br=
idge);
> -	unsigned long max_clock;
> -
> -	max_clock =3D (ctx->bus_width =3D=3D 12) ? 74250 : 148500;
> -
> -	if (mode->clock > max_clock)
> -		return MODE_CLOCK_HIGH;
> -
> -	if (mode->clock < 25000)
> -		return MODE_CLOCK_LOW;
> -
> -	return MODE_OK;
> -}
> -
>  static enum drm_connector_status
>  it66121_bridge_detect(struct drm_bridge *bridge, struct drm_connector *c=
onnector)
>  {
> @@ -873,6 +830,72 @@ static void it66121_bridge_hpd_disable(struct drm_br=
idge *bridge)
>  		dev_err(ctx->dev, "failed to disable HPD IRQ\n");
>  }
> =20
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
> +
> +static int it66121_bridge_hdmi_clear_avi_infoframe(struct drm_bridge *br=
idge)
> +{
> +	struct it66121_ctx *ctx =3D container_of(bridge, struct it66121_ctx, br=
idge);
> +
> +	return regmap_write(ctx->regmap, IT66121_AVI_INFO_PKT_REG, 0);
> +}
> +
> +static int it66121_bridge_hdmi_clear_hdmi_infoframe(struct drm_bridge *b=
ridge)
> +{
> +	return 0;
> +}
> +
> +static int it66121_bridge_hdmi_write_avi_infoframe(struct drm_bridge *br=
idge,
> +						   const u8 *buffer, size_t len)
> +{
> +	struct it66121_ctx *ctx =3D container_of(bridge, struct it66121_ctx, br=
idge);
> +	int ret;
> +
> +	mutex_lock(&ctx->lock);
> +
> +	/* Write new AVI infoframe packet */
> +	ret =3D regmap_bulk_write(ctx->regmap, IT66121_AVIINFO_DB1_REG,
> +				&buffer[HDMI_INFOFRAME_HEADER_SIZE],
> +				HDMI_AVI_INFOFRAME_SIZE);
> +	if (ret)
> +		goto unlock;
> +
> +	ret =3D regmap_write(ctx->regmap, IT66121_AVIINFO_CSUM_REG, buffer[3]);
> +	if (ret)
> +		goto unlock;
> +
> +	/* Enable AVI infoframe */
> +	ret =3D regmap_write(ctx->regmap, IT66121_AVI_INFO_PKT_REG,
> +			   IT66121_AVI_INFO_PKT_ON | IT66121_AVI_INFO_PKT_RPT);
> +
> +unlock:
> +	mutex_unlock(&ctx->lock);
> +	return ret;
> +}
> +
> +static int it66121_bridge_hdmi_write_hdmi_infoframe(struct drm_bridge *b=
ridge,
> +						    const u8 *buffer, size_t len)
> +{
> +	return 0;
> +}
> +

When the code says it's mandatory, it means "it needs to be implemented" ;)

Looks good otherwise
Maxime

--l35sxo3szxdjhnfb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCagbmFQAKCRAnX84Zoj2+
dmCSAXwLl1OoGNAf0h2U2k0BHNwvWtALDxtPlZfea/0lLJD6LuS/o/VVWE15dcT5
fTJiaG8BfjeZryK/9zvSrYozbrgilFMtbwrV/XrM68+s/8e/y8udW2NssySfnGIu
x5gqzOVWkQ==
=UTGF
-----END PGP SIGNATURE-----

--l35sxo3szxdjhnfb--
