Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9179A606A327
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 10:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YSxUaAn1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9F7110E726;
	Tue, 24 Nov 2026 10:03:48 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7BED10E726
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 10:03:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 902F044200;
 Tue, 24 Nov 2026 10:03:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BCBF1F000E0;
 Tue, 24 Nov 2026 10:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795514622;
 bh=e4h7YyFWFRQcMymmrwKmls1XEbFoewaxV7aZcvfzhtU=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=YSxUaAn1voeImmzsuy8zSYy+gWN87gsNzaIXSHBRhSCvzIxZpgiXM9J8mfqRKyux8
 EC2Im7ryFbIkXZ3YhSsAsjbvq4dvEQNNJ5DiwKhtieQPuXL9b3UKaH5pj8NYCTnRT1
 jQBzN/0l9mR9+1dL780LcPdCsPvvLcAoTBi7uVS5nfWkZrgoUQ4YAeWcICMdauwZFH
 jN/NfH13AgcSNykZ/7UuFElVokRn0tuLDXmTQnkqfEhA+cqgzwadMjROMiLJ3TIJaH
 7c5HU+3bmI37lG1n9rIDgQtzyn22GI/pchZvPBbX072vbamiawn2PycxZ6mhJChACD
 O7f8k6mevpl6w==
Message-ID: <sashiko-outbox-230904@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] drm/bridge: tda998x: fix
 DRM_BRIDGE_ATTACH_NO_CONNECTOR support
To: "Luo Liu" <Luo.Liu@cixtech.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261124094119.3220267-5-Luo.Liu@cixtech.com>
References: <20261124094119.3220267-1-Luo.Liu@cixtech.com>
 <20261124094119.3220267-5-Luo.Liu@cixtech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 10:03:41 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] drm/bridge: tda998x: UAF on cached bridge_connector in
  tda998x_audio_get_eld()
- [Medium] drm/bridge: tda998x: tda998x_detect_work() drops HPD before
  detect/edid_read
- [Medium] drm/bridge: tda998x: unlocked connector->eld read in
  tda998x_audio_get_eld()
--

commit 99202632262d8379c5cf8d903d42f1dd5e5ce3eb
Author: Luo Liu <Luo.Liu@cixtech.com>

drm/bridge: tda998x: fix DRM_BRIDGE_ATTACH_NO_CONNECTOR support

This commit caches the drm_connector pointer passed to the bridge detect and
EDID read callbacks so mode setting, infoframe generation, ELD retrieval, a=
nd
hotplug notifications use the external bridge connector when attached with
DRM_BRIDGE_ATTACH_NO_CONNECTOR, and enables interlaced mode support on the
bridge.

> diff --git a/drivers/gpu/drm/bridge/tda998x_drv.c b/drivers/gpu/drm/bridg=
e/tda998x_drv.c
> index 0b966c9844e70..40379d74a53ac 100644
> --- a/drivers/gpu/drm/bridge/tda998x_drv.c
> +++ b/drivers/gpu/drm/bridge/tda998x_drv.c

[ ... ]

> @@ -769,6 +783,14 @@ static int tda998x_edid_delay_wait(struct tda998x_pr=
iv *priv)
>  	return wait_event_killable(priv->edid_delay_waitq, !priv->edid_delay_ac=
tive);
>  }
> =20
> +static enum drm_connector_status tda998x_conn_detect(struct tda998x_priv=
 *priv)
> +{
> +	u8 val =3D cec_read(priv, REG_CEC_RXSHPDLEV);
> +
> +	return (val & CEC_RXSHPDLEV_HPD) ? connector_status_connected :
> +			connector_status_disconnected;
> +}
> +
>  /*
>   * We need to run the KMS hotplug event helper outside of our threaded
>   * interrupt routine as this can call back into our get_modes method,
> @@ -778,10 +800,11 @@ static void tda998x_detect_work(struct work_struct =
*work)
>  {
>  	struct tda998x_priv *priv =3D
>  		container_of(work, struct tda998x_priv, detect_work);
> -	struct drm_device *dev =3D priv->connector.dev;
> =20
> -	if (dev)
> -		drm_kms_helper_hotplug_event(dev);
> +	if (priv->bridge_connector)
> +		drm_bridge_hpd_notify(&priv->bridge, tda998x_conn_detect(priv));
> +	else if (priv->connector.dev)
> +		drm_kms_helper_hotplug_event(priv->connector.dev);
>  }

[Severity: Medium]
Does checking priv->bridge_connector here drop HPD events that arrive before
tda998x_bridge_detect() or tda998x_bridge_edid_read() has been called?

When attached with DRM_BRIDGE_ATTACH_NO_CONNECTOR, priv->connector.dev is
NULL and priv->bridge_connector is only populated inside .detect() and
.edid_read().  drm_bridge_connector_init() and drm_kms_helper_poll_init() ->
drm_bridge_connector_enable_hpd() enable HPD without calling either callback
and without starting periodic polling when DRM_BRIDGE_OP_HPD is set.  If an
HPD interrupt fires before any caller probes the connector (or if a
downstream bridge in the chain handles DRM_BRIDGE_OP_DETECT and
DRM_BRIDGE_OP_EDID), both pointers are NULL and the notification is lost,
even though drm_bridge_hpd_notify() only needs &priv->bridge.

[ ... ]

> @@ -1152,10 +1176,10 @@ static int tda998x_audio_get_eld(struct device *d=
ev, void *data,
>  				 uint8_t *buf, size_t len)
>  {
>  	struct tda998x_priv *priv =3D dev_get_drvdata(dev);
> +	struct drm_connector *connector =3D tda998x_get_connector(priv);
> =20
>  	mutex_lock(&priv->audio_mutex);
> -	memcpy(buf, priv->connector.eld,
> -	       min(sizeof(priv->connector.eld), len));
> +	memcpy(buf, connector->eld, min(sizeof(connector->eld), len));
>  	mutex_unlock(&priv->audio_mutex);
> =20
>  	return 0;
>  }

[Severity: Medium]
Should tda998x_audio_get_eld() hold connector->eld_mutex while copying
connector->eld?

drm_edid_connector_update() zeroes and populates connector->eld under
connector->eld_mutex without holding priv->audio_mutex, so a concurrent
ALSA ELD read can copy a partially updated or transiently zeroed ELD buffer.

[ ... ]

> @@ -1390,6 +1406,8 @@ static void tda998x_bridge_detach(struct drm_bridge=
 *bridge)
>  {
>  	struct tda998x_priv *priv =3D bridge_to_tda998x_priv(bridge);
> =20
> +	priv->bridge_connector =3D NULL;
> +
>  	if (priv->connector.dev)
>  		drm_connector_cleanup(&priv->connector);
>  }

[ ... ]

> @@ -1701,6 +1720,9 @@ tda998x_bridge_edid_read(struct drm_bridge *bridge,
>  	const struct drm_edid *drm_edid;
>  	const struct edid *edid;
> =20
> +	if (connector)
> +		priv->bridge_connector =3D connector;
> +
>  	drm_edid =3D tda998x_edid_read(priv, connector);
>  	if (!drm_edid) {
>  		dev_dbg(&priv->hdmi->dev, "failed to get edid\n");
> @@ -1729,6 +1751,9 @@ tda998x_bridge_detect(struct drm_bridge *bridge,
>  {
>  	struct tda998x_priv *priv =3D bridge_to_tda998x_priv(bridge);
> =20
> +	if (connector)
> +		priv->bridge_connector =3D connector;
> +
>  	return tda998x_conn_detect(priv);
>  }

[Severity: High]
Can caching the raw connector pointer in priv->bridge_connector cause a
use-after-free in tda998x_audio_get_eld()?

include/drm/drm_bridge.h forbids storing the connector parameter passed to
.edid_read() for future use.  Display controller drivers such as tilcdc
register their encoder with drmm before calling drm_bridge_connector_init():

drivers/gpu/drm/tilcdc/tilcdc_encoder.c:tilcdc_encoder_create() {
    ...
	encoder =3D drmm_simple_encoder_alloc(ddev, struct tilcdc_encoder,
					    base, DRM_MODE_ENCODER_NONE);
    ...
	return tilcdc_attach_bridge(ddev, bridge);
}

Because drmm release actions run in reverse registration order while
priv->audio_pdev remains registered until tda998x_remove(), DRM teardown
frees the drm_bridge_connector before tda998x_bridge_detach() clears
priv->bridge_connector (and neither access is serialized by
priv->audio_mutex):

CPU0                                  CPU1
drm_managed_release()
  drmm_connector_init_release()
  drmm_kfree()  /* frees connector */
                                      tda998x_audio_get_eld()
                                        connector =3D tda998x_get_connector=
()
                                        memcpy(buf, connector->eld, ...)
                                          <-- use-after-free
  drmm_encoder_alloc_release()
    drm_encoder_cleanup()
      drm_bridge_detach()
        tda998x_bridge_detach()
          priv->bridge_connector =3D NULL;

In addition, if a downstream bridge in the chain handles
DRM_BRIDGE_OP_DETECT and DRM_BRIDGE_OP_EDID, drm_bridge_connector never
calls tda998x_bridge_detect() or tda998x_bridge_edid_read(), leaving
priv->bridge_connector NULL during tda998x_bridge_mode_set().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124094119.3220=
267-1-Luo.Liu@cixtech.com?part=3D4
