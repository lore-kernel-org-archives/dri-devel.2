Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32772606A322
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 10:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nMPRLJnt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6873E10E21D;
	Tue, 24 Nov 2026 10:03:03 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 372CF10E21D
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 10:02:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 957FB42D77;
 Tue, 24 Nov 2026 10:02:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A4B71F000D8;
 Tue, 24 Nov 2026 10:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795514576;
 bh=16XiWjVZBjf4CNZIZcFDOAr5tsyhnx7m0rS92SN1wWk=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=nMPRLJnt0RGQ6fVFW9gG+GBRYjQudpSMH4KG1CCMMi76lDpLqE7aW3z+0xuFnQ4Dm
 XO7VRXA7j5aTq6xWQbcTyodcLYe6zebyIFwaUlXXhxLVznxrWQVz7ReJ1RwIdrsiRO
 ZaZHu2j/GGqobQmiLeQMVCIKjUlXRWunRbzC0BfpvAd+KB++0sHcB8zl0mWv0n0mSp
 yYJT07hgCuszR+itTH7n0funWByk0oXqvQYqYHSqdzzm3HuGyfSREw/wsHg8lKLng4
 wkn24c1MgDdWBm3X7H9FI8gljPDyjKOAZ0GtBAw7Hgb1gLRZJOzV9D6zyO1SHRZKnX
 GJ8ak+Rr6SsaA==
Message-ID: <sashiko-outbox-230903@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] drm/bridge: tda998x: fix
 DRM_BRIDGE_ATTACH_NO_CONNECTOR support
To: "Luo Liu" <Luo.Liu@cixtech.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261124093928.3220071-5-Luo.Liu@cixtech.com>
References: <20261124093928.3220071-1-Luo.Liu@cixtech.com>
 <20261124093928.3220071-5-Luo.Liu@cixtech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 10:02:55 +0000
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
- [Medium] drm/bridge: tda998x: tda998x_detect_work() drops HPD before
  detect()
- [Medium] drm/bridge: tda998x: unreferenced bridge_connector UAF in
  tda998x_audio_get_eld()
- [Medium] drm/bridge: tda998x: tda998x_remove() destroys hpd_mutex
  before detect_work
--

commit 5c61daf84ccbb8e21901c3e3a497e52ae6903d78
Author: Luo Liu <Luo.Liu@cixtech.com>

drm/bridge: tda998x: fix DRM_BRIDGE_ATTACH_NO_CONNECTOR support

This commit caches the connector passed to the bridge detect and EDID read
callbacks so mode setting, ELD retrieval, and hotplug work use the external
bridge connector when attached with DRM_BRIDGE_ATTACH_NO_CONNECTOR, and
sets bridge.interlace_allowed.

> diff --git a/drivers/gpu/drm/bridge/tda998x_drv.c b/drivers/gpu/drm/bridg=
e/tda998x_drv.c
> index 0b966c9844e70..40379d74a53ac 100644
> --- a/drivers/gpu/drm/bridge/tda998x_drv.c
> +++ b/drivers/gpu/drm/bridge/tda998x_drv.c

[ ... ]

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

[Severity: Medium]
Can tda998x_detect_work() lock priv->bridge.hpd_mutex after
tda998x_remove() has destroyed it?

tda998x_remove() calls drm_bridge_remove(), which runs
mutex_destroy(&bridge->hpd_mutex), before disabling the HPD interrupt and
canceling edid_delay_timer and detect_work:

CPU0                                  CPU1 (kworker)
tda998x_remove()
  drm_bridge_remove(&priv->bridge)
    mutex_destroy(&bridge->hpd_mutex)
                                      tda998x_detect_work()
                                        drm_bridge_hpd_notify()
                                          mutex_lock(&bridge->hpd_mutex)
                                            <-- use-after-destroy
  ...
  cancel_work_sync(&priv->detect_work)

> +	else if (priv->connector.dev)
> +		drm_kms_helper_hotplug_event(priv->connector.dev);
>  }

[Severity: Medium]
Does gating drm_bridge_hpd_notify() on priv->bridge_connector drop hotplug
events before tda998x_bridge_detect() or tda998x_bridge_edid_read() has been
called?

When attached with DRM_BRIDGE_ATTACH_NO_CONNECTOR, priv->connector.dev is
NULL and priv->bridge_connector stays NULL until .detect() or .edid_read()
runs.  With client->irq present, drm_bridge_connector_init() sets
DRM_CONNECTOR_POLL_HPD and registers the HPD callback without calling
.detect() or .edid_read(), so an HPD interrupt arriving before the first
connector probe takes neither branch and is lost.

Since drm_bridge_hpd_notify() does not use priv->bridge_connector, checking
priv->connector.dev first and calling drm_bridge_hpd_notify() in the else
branch would avoid dropping early HPD events.

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

[Severity: Medium]
Can tda998x_audio_get_eld() read from a freed priv->bridge_connector when
the display driver unbinds?

priv->audio_pdev lives until tda998x_remove(), while the external connector
created by drm_bridge_connector_init() is allocated with drmm_kzalloc()
after the mode_config and encoder cleanup actions are registered.  During
DRM teardown, drm_managed_release() runs in reverse order and frees the
drm_bridge_connector before drm_encoder_cleanup() calls
tda998x_bridge_detach().  In addition, tda998x_get_connector() and
tda998x_bridge_detach() access priv->bridge_connector without holding
priv->audio_mutex or taking a connector reference:

CPU0                                  CPU1
                                      tda998x_audio_get_eld()
                                        connector =3D tda998x_get_connector=
()
drm_managed_release()
  free_dr() /* frees bridge_connector */
  ...
  drm_encoder_cleanup()
    tda998x_bridge_detach()
      priv->bridge_connector =3D NULL
                                        mutex_lock(&priv->audio_mutex)
                                        memcpy(buf, connector->eld, ...)
                                          <-- use-after-free

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124093928.3220=
071-1-Luo.Liu@cixtech.com?part=3D4
