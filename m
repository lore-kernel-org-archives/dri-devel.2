Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1716FCD4F3C
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 07:52:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6876610F23B;
	Thu, 21 May 2026 07:52:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VY9uYzHG";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F84310F23B
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 07:52:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 79B3460172;
 Thu, 21 May 2026 07:52:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA61A1F000E9;
 Thu, 21 May 2026 07:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779349964;
 bh=99oskG8ubBjeKtd2Yc7IdU7MjYpfc9O1o+mlnd5bJ64=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=VY9uYzHGIt/BsHyCKP9I1NqWgX9O4iTlWhh2Rp9yo3C4d9f7BE3dbELq/xo24h8UF
 ZdkprFalox6G3NFRy2H9iccPb2+XRJvsHF+Eswz7k8ySSbB2nibIGi6bjEEuuYFUDI
 AJvUKOJ6RW3AIMn88VPG2ObB4uI6YYwrSKx/YLVVRIbKXyLoJShJt9i2xJyPsIfe7j
 wyowEfKbTWlInSw2RqinKKXH8wDSDqwQ5w+mQU2UjhA0exLlbI9qbQDRHzGZujyV+1
 wMrQo6RvEc4IsehY0JtUOuMGjHNLyl2PvipzKCMKpdw6IoFQeewU/WcbUUuH/UF5Fh
 Nocb94U9AVTmA==
Date: Thu, 21 May 2026 09:52:41 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Sandy Huang <hjc@rock-chips.com>, 
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Daniel Stone <daniels@collabora.com>,
 kernel@collabora.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v6 02/22] drm/connector: Add HDMI 2.0 scrambler
 infrastructure
Message-ID: <20260521-sweet-devout-panther-44d73c@penduick>
References: <20260520-dw-hdmi-qp-scramb-v6-0-24b74603b782@collabora.com>
 <20260520-dw-hdmi-qp-scramb-v6-2-24b74603b782@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="7urdiivgg5qj3q55"
Content-Disposition: inline
In-Reply-To: <20260520-dw-hdmi-qp-scramb-v6-2-24b74603b782@collabora.com>
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


--7urdiivgg5qj3q55
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 02/22] drm/connector: Add HDMI 2.0 scrambler
 infrastructure
MIME-Version: 1.0

Hi,

Thanks for working on this!

On Wed, May 20, 2026 at 09:38:13PM +0300, Cristian Ciocaltea wrote:
> Add the connector-level infrastructure to support HDMI 2.0 scrambling:
>=20
> - .scrambler_src_{enable|disable}() callbacks in
>   drm_connector_hdmi_funcs for source-side scrambling control
> - A delayed work item (scdc_work) with an associated callback (scdc_cb)
>   for periodic monitoring of sink-side scrambling status
> - A scrambler_enabled flag to track whether scrambling is currently
>   active
>=20
> These are intended to be used by SCDC scrambling helpers to coordinate
> scrambling setup and teardown between the source driver and the DRM
> core.
>=20
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/gpu/drm/drm_connector.c | 14 +++++++++++
>  include/drm/drm_connector.h     | 52 +++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 66 insertions(+)

So we would need kunit tests for this.

> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connec=
tor.c
> index 3fa4d2082cd7..91e58362fbc0 100644
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
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index 5ad62c207d00..49eaa30b1329 100644
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
> @@ -1358,6 +1359,36 @@ struct drm_connector_hdmi_funcs {
>  	 */
>  	const struct drm_edid *(*read_edid)(struct drm_connector *connector);
> =20
> +	/**
> +	 * @scrambler_src_enable:
> +	 *
> +	 * This callback is invoked through @drm_scdc_start_scrambling during
> +	 * a commit to setup SCDC scrambling and high TMDS clock ratio on
> +	 * source side.
> +	 *
> +	 * The @scrambler_src_enable callback is mandatory if HDMI 2.0 is
> +	 * to be supported.
> +	 *
> +	 * Returns:
> +	 * 0 on success, a negative error code otherwise
> +	 */
> +	int (*scrambler_src_enable)(struct drm_connector *connector);
> +
> +	/**
> +	 * @scrambler_src_disable:
> +	 *
> +	 * This callback is invoked through @drm_scdc_stop_scrambling during
> +	 * a commit to disable SCDC scrambling and high TMDS clock ratio on
> +	 * source side.
> +	 *
> +	 * The @scrambler_src_disable callback is mandatory if HDMI 2.0 is
> +	 * to be supported.
> +	 *
> +	 * Returns:
> +	 * 0 on success, a negative error code otherwise
> +	 */
> +	int (*scrambler_src_disable)(struct drm_connector *connector);
> +
>  	/**
>  	 * @avi:
>  	 *
> @@ -1944,6 +1975,27 @@ struct drm_connector_hdmi {
>  	 */
>  	unsigned long supported_formats;
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
> +	/** @scdc_cb: Callback to be invoked as part of @scdc_work.
> +	 *
> +	 * Currently used to monitor sink-side scrambling status and retry
> +	 * setup if the sink resets it.
> +	 *
> +	 * This is assigned by the framework when making use of
> +	 * drm_scdc_start_scrambling() helper.
> +	 */
> +	void (*scdc_cb)(struct drm_connector *connector);
> +

I'm really not sure what the monitor thing is about. If we have setup
the scrambler at enable time, and we set it again on hotplugging, why
would we need to monitor anything?

Also, scrambling is only relevant for HDMI 2.0. We need a way to expose
that somehow and make sure that HDMI 2.0 drivers actually have
scrambling setup.

Maxime

--7urdiivgg5qj3q55
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCag65yQAKCRAnX84Zoj2+
dll/AX9tG3cFDmLeklMW+rTi4SvWHROIptUKpuz9LyW39s751r/XlVPbiMZzGzln
wOcOdVgBgOFZq4n9DJJiQB+RNsx5GUFvhIPAEhol5wo1K6QtdXFp5MVvpk7rmgb8
wlbWVhy0VA==
=R3rI
-----END PGP SIGNATURE-----

--7urdiivgg5qj3q55--
