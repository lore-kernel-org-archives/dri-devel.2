Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57438CD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 12:06:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B503F10F48F;
	Fri, 12 Jun 2026 12:06:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kMSkzSzW";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D762F10F47F
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 12:06:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 252E5600AB;
 Fri, 12 Jun 2026 12:06:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB3D1F000E9;
 Fri, 12 Jun 2026 12:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781265991;
 bh=jR50a81IxiDBn56oWWFPyUlJDk//wHbnB3DYWlUT9x4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=kMSkzSzWMeXL+OsB2eVrT0bTnlZbCubqG6qaotFF+XT8pDdgAl8WSLM7+t2LOo89z
 zPVoLtejnkGzduXs/OfewzZod/fU+tAOwXjuaz2MiKC3hGyO7RC+WkntXyXlNfN3fl
 ykLX0Ozk1e11viX7u0vwr01fIZimt/x8nbK4LKCMVbfNgtGhLZAXsWAl1pOP22ebja
 L194BJfYnSz1Lm0Q27SHehbwkutHe/Ml6HnmCW6bFsdluS1U7bF3KJvJhytn5VpZrP
 G4KqFKEY74W3fFOgIMxXhDuTgnhrzvppBRMzYEtQzNE43xgtkZFdXD1PbW896dEnK4
 TLpXWpUx8edNw==
Date: Fri, 12 Jun 2026 14:06:29 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Sandy Huang <hjc@rock-chips.com>,
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Daniel Stone <daniels@collabora.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v7 02/30] drm/connector: Add HDMI 2.0 scrambler
 infrastructure
Message-ID: <20260612-subtle-shapeless-rattlesnake-4b6af8@houat>
References: <20260602-dw-hdmi-qp-scramb-v7-0-445eb54ee1ed@collabora.com>
 <20260602-dw-hdmi-qp-scramb-v7-2-445eb54ee1ed@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="jvytzggqrwbv5ab3"
Content-Disposition: inline
In-Reply-To: <20260602-dw-hdmi-qp-scramb-v7-2-445eb54ee1ed@collabora.com>
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


--jvytzggqrwbv5ab3
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 02/30] drm/connector: Add HDMI 2.0 scrambler
 infrastructure
MIME-Version: 1.0

On Tue, Jun 02, 2026 at 01:44:02AM +0300, Cristian Ciocaltea wrote:
> Add the connector-level infrastructure to support HDMI 2.0 scrambling:
>=20
> - A scrambler_supported flag to indicate whether the source supports the
>   scrambling capability, in which case the newly introduced
>   .scrambler_{enable|disable}() callbacks in drm_connector_hdmi_funcs
>   are mandatory
> - A scrambler_needed flag to be managed by the hdmi state helpers based
>   on the negotiated TMDS character rate and the source/sink scrambling
>   capabilities
> - A scrambler_enabled flag to track whether scrambling is currently
>   active
> - A delayed work item (scdc_work) with an associated callback (scdc_cb)
>   to monitor sink-side scrambling status and retry the setup if the sink
>   resets it
>=20
> These are intended to be used by SCDC scrambling helpers to coordinate
> scrambling setup and teardown between the source driver and the DRM
> core.
>=20
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/gpu/drm/drm_connector.c | 18 +++++++++
>  include/drm/drm_connector.h     | 81 +++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 99 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connec=
tor.c
> index a5d13b92b665..526dc2931b8a 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -220,6 +220,19 @@ void drm_connector_free_work_fn(struct work_struct *=
work)
>  	}
>  }
> =20
> +static void drm_connector_hdmi_scdc_work(struct work_struct *work)
> +{
> +	struct drm_connector *connector;
> +	struct drm_connector_hdmi *hdmi;
> +
> +	hdmi =3D container_of(to_delayed_work(work), struct drm_connector_hdmi,
> +			    scdc_work);
> +	connector =3D container_of(hdmi, struct drm_connector, hdmi);
> +
> +	if (hdmi->scdc_cb)
> +		hdmi->scdc_cb(connector);
> +}
> +
>  static int drm_connector_init_only(struct drm_device *dev,
>  				   struct drm_connector *connector,
>  				   const struct drm_connector_funcs *funcs,
> @@ -285,6 +298,7 @@ static int drm_connector_init_only(struct drm_device =
*dev,
>  	mutex_init(&connector->edid_override_mutex);
>  	mutex_init(&connector->hdmi.infoframes.lock);
>  	mutex_init(&connector->hdmi_audio.lock);
> +	INIT_DELAYED_WORK(&connector->hdmi.scdc_work, drm_connector_hdmi_scdc_w=
ork);
>  	connector->edid_blob_ptr =3D NULL;
>  	connector->epoch_counter =3D 0;
>  	connector->tile_blob_ptr =3D NULL;
> @@ -606,6 +620,10 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
>  	    !hdmi_funcs->hdmi.write_infoframe)
>  		return -EINVAL;
> =20
> +	if (connector->hdmi.scrambler_supported &&
> +	    (!hdmi_funcs->scrambler_enable || !hdmi_funcs->scrambler_disable))
> +		return -EINVAL;
> +
>  	ret =3D drmm_connector_init(dev, connector, funcs, connector_type, ddc);
>  	if (ret)
>  		return ret;
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index 529755c2e862..f1c5c15a6cce 100644
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
> @@ -1057,6 +1058,19 @@ struct drm_connector_hdmi_state {
>  	 * @tmds_char_rate: TMDS Character Rate, in Hz.
>  	 */
>  	unsigned long long tmds_char_rate;
> +
> +	/**
> +	 * @scrambler_needed: Whether HDMI 2.0 SCDC scrambling is required
> +	 * for the negotiated mode/bpc/format.
> +	 *
> +	 * Computed by drm_atomic_helper_connector_hdmi_check() from
> +	 * @tmds_char_rate and the source/sink scrambling capabilities.
> +	 *
> +	 * Per HDMI 2.0, scrambling is mandatory above 340 MHz TMDS
> +	 * character rate. Optional scrambling at lower rates is
> +	 * deliberately not requested by the helper.
> +	 */
> +	bool scrambler_needed;
>  };
> =20
>  /**
> @@ -1358,6 +1372,36 @@ struct drm_connector_hdmi_funcs {
>  	 */
>  	const struct drm_edid *(*read_edid)(struct drm_connector *connector);
> =20
> +	/**
> +	 * @scrambler_enable:
> +	 *
> +	 * This callback is invoked through @drm_scdc_start_scrambling during
> +	 * a commit to setup SCDC scrambling and high TMDS clock ratio on
> +	 * source side.
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
> +	 * This callback is invoked through @drm_scdc_stop_scrambling during
> +	 * a commit to disable SCDC scrambling and high TMDS clock ratio on
> +	 * source side.
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
> @@ -1960,6 +2004,43 @@ struct drm_connector_hdmi {
>  	 */
>  	unsigned long supported_formats;
> =20
> +	/**
> +	 * @scrambler_supported: Indicates whether the HDMI controller
> +	 * (source) supports HDMI 2.0 SCDC scrambling.
> +	 *
> +	 * When true, @drm_connector_hdmi_funcs.scrambler_enable and
> +	 * @drm_connector_hdmi_funcs.scrambler_disable are mandatory.
> +	 * This is enforced by drmm_connector_hdmi_init().
> +	 *
> +	 * For HDMI bridge based drivers using drm_bridge_connector_init(),
> +	 * this is propagated automatically from bridges that set the
> +	 * DRM_BRIDGE_OP_HDMI_SCRAMBLER flag in their &drm_bridge->ops.
> +	 * Other drivers must set this field on @connector->hdmi before calling
> +	 * drmm_connector_hdmi_init().
> +	 */
> +	bool scrambler_supported;
> +
> +	/**
> +	 * @scrambler_enabled: Tracks whether HDMI 2.0 scrambler is currently e=
nabled.
> +	 */
> +	bool scrambler_enabled;

This is already in the state. Why do you need to copy it over here, and
if you do, you'll need a lock.

Maxime

--jvytzggqrwbv5ab3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaiv2RQAKCRAnX84Zoj2+
dpOzAX9fWVyZgzIa+Lwod4+RU9bVyTQIx/zbt9tFgexdmHs0vTf1n0ZU73nrvkpF
RDnEJ6EBfAztXT42zpjOHCEXHtNxA/RtY+modkrjS8RhNEgWKZ1SifKU6JxOd1OF
1sNJW47dJQ==
=ViGe
-----END PGP SIGNATURE-----

--jvytzggqrwbv5ab3--
