Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01811C5DF86
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 10:12:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52BC410ED9A;
	Wed, 19 Aug 2026 10:12:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GvfDx4DA";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CFE610ED9A
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 10:12:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 22C1D43F40;
 Wed, 19 Aug 2026 10:12:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA4D1F000E9;
 Wed, 19 Aug 2026 10:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787134334;
 bh=HArTLlziJfHqgApqqIgI5nBKk8GeLPGlxXt8OWMKOd4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=GvfDx4DAOQvd8bogz0kkJJo+qJAySQ5aqGcDIWWVzmVVDYx4OE/6O/ddKEXfRmJuw
 Gi2oiReElte5k5GXhUAvolXTbtWq+h4oaut4rG7A/1KsJ8SXENDs4FSYHUTO/3o5Lo
 GaJ81HoOtB5ophCkR9ekNWB3tzzkw4JhKucc/MwAIQdAru8/4yfsikBTuHVN63EtvA
 hOAqXeXFPbegjPXKKlNLV82sANwNtwPSi1ZB6ePm50rk0kAOc2R1lfez06zjop6RbP
 r4I2fRySGviG4IrjT30tbab/NQ0fC8wRYLsHNjNzRBDMJmRFMIzxFCnMkqfmnEab6d
 oEYefk7u99tcw==
Date: Wed, 19 Aug 2026 12:12:11 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Sandy Huang <hjc@rock-chips.com>,
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Algea Cao <algea.cao@rock-chips.com>, 
 Daniel Stone <daniels@collabora.com>, Liu Ying <victor.liu@nxp.com>,
 Phong LE <ple@baylibre.com>, 
 kernel@collabora.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-rockchip@lists.infradead.org, 
 Maud Spierings <maud_spierings@hotmail.com>,
 Diederik de Haas <diederik@cknow-tech.com>
Subject: Re: [PATCH v10 07/69] drm/connector: Add HDMI 2.0 scrambler
 infrastructure
Message-ID: <20260819-amigurumi-lorikeet-of-infinity-fd8c2d@houat>
References: <20260731-dw-hdmi-qp-scramb-v10-0-294364b2cf15@collabora.com>
 <20260731-dw-hdmi-qp-scramb-v10-7-294364b2cf15@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="syuvxrauwe4ibjcq"
Content-Disposition: inline
In-Reply-To: <20260731-dw-hdmi-qp-scramb-v10-7-294364b2cf15@collabora.com>
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


--syuvxrauwe4ibjcq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v10 07/69] drm/connector: Add HDMI 2.0 scrambler
 infrastructure
MIME-Version: 1.0

On Fri, Jul 31, 2026 at 07:19:14PM +0300, Cristian Ciocaltea wrote:
> Add the connector-level infrastructure to support HDMI 2.0 scrambling:
>=20
> - A drm_connector_hdmi_scrambler_supported() helper to report whether
>   the source supports the scrambling capability, based on the presence
>   of the newly introduced .scrambler_{enable|disable}() callbacks in
>   drm_connector_hdmi_funcs are mandatory
> - A scrambler_needed flag to be managed by the hdmi state helpers based
>   on the negotiated TMDS character rate and the source/sink scrambling
>   capabilities
> - A scrambler_enabled flag to track whether scrambling is currently
>   active
> - A delayed work item (scdc_work) to monitor sink-side scrambling status
>   and retry the setup if the sink resets it
> - A scdc_work_initialized flag to support lazy initialization of the
>   work item on the first scrambling enable and guard the teardown paths
>=20
> These are intended to be used by SCDC scrambling helpers to coordinate
> scrambling setup and teardown between the source driver and the DRM
> core.
>=20
> Tested-by: Maud Spierings <maud_spierings@hotmail.com>
> Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # NanoPC-T6 LTS, R=
ock 5B
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/gpu/drm/drm_connector.c | 31 ++++++++++++---
>  include/drm/drm_connector.h     | 83 +++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 109 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connec=
tor.c
> index 4721cdeafc84..a18410faf040 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -622,12 +622,29 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
>  	 * default with the actual controller capability. A value of zero keeps
>  	 * the limit inferred from supported_hdmi_ver.
>  	 */
> -	if (hdmi_funcs->supported_hdmi_ver >=3D HDMI_VERSION_2_0)
> +	if (hdmi_funcs->supported_hdmi_ver >=3D HDMI_VERSION_2_0) {
> +		if (!hdmi_funcs->scrambler_enable || !hdmi_funcs->scrambler_disable) {
> +			drm_err(dev, "Scrambler callbacks missing for HDMI 2.x\n");
> +			return -EINVAL;
> +		}
> +
>  		connector->hdmi.max_tmds_char_rate =3D HDMI_2_0_TMDS_CHAR_RATE_MAX_HZ;
> -	else if (hdmi_funcs->supported_hdmi_ver >=3D HDMI_VERSION_1_3)
> -		connector->hdmi.max_tmds_char_rate =3D HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ;
> -	else if (hdmi_funcs->supported_hdmi_ver >=3D HDMI_VERSION_1_0)
> -		connector->hdmi.max_tmds_char_rate =3D HDMI_1_0_TMDS_CHAR_RATE_MAX_HZ;
> +	} else {
> +		/*
> +		 * Scrambler callbacks are only valid for connectors advertising
> +		 * HDMI 2.0 capability. drm_connector_hdmi_scrambler_supported()
> +		 * relies on their presence to report scrambling support.
> +		 */
> +		if (hdmi_funcs->scrambler_enable || hdmi_funcs->scrambler_disable) {
> +			drm_err(dev, "Scrambler callbacks unexpected for HDMI 1.x\n");
> +			return -EINVAL;
> +		}
> +
> +		if (hdmi_funcs->supported_hdmi_ver >=3D HDMI_VERSION_1_3)
> +			connector->hdmi.max_tmds_char_rate =3D HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ;
> +		else if (hdmi_funcs->supported_hdmi_ver >=3D HDMI_VERSION_1_0)
> +			connector->hdmi.max_tmds_char_rate =3D HDMI_1_0_TMDS_CHAR_RATE_MAX_HZ;
> +	}

I'd put it into a separate test (possibly earlier). Merging both the
tmds rate default and the scrambler callbacks check makes it messier
than it would be if we had two separate tests.

>  	if (hdmi_funcs->supported_tmds_char_rate) {
>  		if (hdmi_funcs->supported_tmds_char_rate > connector->hdmi.max_tmds_ch=
ar_rate) {
> @@ -635,6 +652,7 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
>  				connector->hdmi.max_tmds_char_rate);
>  			return -EINVAL;
>  		}
> +
>  		connector->hdmi.max_tmds_char_rate =3D hdmi_funcs->supported_tmds_char=
_rate;
>  	}
> =20
> @@ -918,6 +936,9 @@ void drm_connector_cleanup(struct drm_connector *conn=
ector)
>  		    DRM_CONNECTOR_REGISTERED))
>  		drm_connector_unregister(connector);
> =20
> +	if (connector->hdmi.scdc_work_initialized)
> +		cancel_delayed_work_sync(&connector->hdmi.scdc_work);
> +
>  	platform_device_unregister(connector->hdmi_audio.codec_pdev);
> =20
>  	if (connector->privacy_screen) {
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index a6de3e63b462..89a140d6f064 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -28,6 +28,7 @@
>  #include <linux/ctype.h>
>  #include <linux/hdmi.h>
>  #include <linux/notifier.h>
> +#include <linux/workqueue.h>
>  #include <drm/drm_mode_object.h>
>  #include <drm/drm_util.h>
>  #include <drm/drm_property.h>
> @@ -1131,6 +1132,17 @@ struct drm_connector_hdmi_state {
>  	 * @tmds_char_rate: TMDS Character Rate, in Hz.
>  	 */
>  	unsigned long long tmds_char_rate;
> +
> +	/**
> +	 * @scrambler_needed: Whether HDMI 2.0 SCDC scrambling is required
> +	 * for the negotiated mode/bpc/format.
> +	 *
> +	 * Computed by drm_atomic_helper_connector_hdmi_check() according to
> +	 * the HDMI 2.0 specification: scrambling is mandatory above a 340 MHz
> +	 * TMDS character rate. Optional scrambling at lower rates is
> +	 * deliberately not requested by the helper.
> +	 */
> +	bool scrambler_needed;
>  };
> =20
>  /**
> @@ -1481,6 +1493,36 @@ struct drm_connector_hdmi_funcs {
>  	 */
>  	const struct drm_edid *(*read_edid)(struct drm_connector *connector);
> =20
> +	/**
> +	 * @scrambler_enable:
> +	 *
> +	 * The callback is invoked via @drm_connector_hdmi_enable_scrambling
> +	 * during commit to setup SCDC scrambling and high TMDS clock ratio on
> +	 * the source side.
> +	 *
> +	 * The @scrambler_enable callback is mandatory if HDMI 2.0 is to be
> +	 * supported.
> +	 *
> +	 * Returns:
> +	 * 0 on success, a negative error code otherwise
> +	 */
> +	int (*scrambler_enable)(struct drm_connector *connector);
> +
> +	/**
> +	 * @scrambler_disable:
> +	 *
> +	 * The callback is invoked via @drm_connector_hdmi_disable_scrambling
> +	 * during commit to tear down SCDC scrambling and high TMDS clock ratio
> +	 * on the source side.
> +	 *
> +	 * The @scrambler_disable callback is mandatory if HDMI 2.0 is to be
> +	 * supported.
> +	 *
> +	 * Returns:
> +	 * 0 on success, a negative error code otherwise
> +	 */
> +	int (*scrambler_disable)(struct drm_connector *connector);
> +
>  	/**
>  	 * @avi:
>  	 *
> @@ -2111,6 +2153,25 @@ struct drm_connector_hdmi {
>  	 */
>  	unsigned long long max_tmds_char_rate;
> =20
> +	/**
> +	 * @scrambler_enabled: Tracks whether HDMI 2.0 scrambler is currently e=
nabled.
> +	 */
> +	bool scrambler_enabled;
> +
> +	/**
> +	 * @scdc_work: Work item currently used to monitor sink-side scrambling
> +	 * status and retry setup if the sink resets it.
> +	 */
> +	struct delayed_work scdc_work;
> +
> +	/**
> +	 * @scdc_work_initialized: Tracks whether @scdc_work has been set up via
> +	 * INIT_DELAYED_WORK(). The work item is initialized lazily on the first
> +	 * scrambling enable, so this guards the teardown paths against touching
> +	 * an uninitialized work item.
> +	 */
> +	bool scdc_work_initialized;
> +

Why should we track whether it's initialized or not? I'd always
initialize it, but only ever schedule something if we're using the
scrambler.

Maxime

--syuvxrauwe4ibjcq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaoWBbwAKCRAnX84Zoj2+
dlhmAX97RqIPyEXaFYpYG3l7TZ7Us8mqlWL1MjtrGnTqAM40X0uT+VOsdVcLawCQ
NS8yiHwBegO4ZITksuu0ciIrn6hDl8gqAvu/jj1nD+9BLfD0FYKvYonhxbmknMuw
4ggX/lyOBw==
=E2Mz
-----END PGP SIGNATURE-----

--syuvxrauwe4ibjcq--
