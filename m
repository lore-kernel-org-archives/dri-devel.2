Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CB1606A336
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 18:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kSEHYqf9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43C4B10FEC7;
	Wed, 25 Nov 2026 18:14:16 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7496310FEC9
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 18:14:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C999C62675;
 Wed, 25 Nov 2026 18:14:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ADE61F000E0;
 Wed, 25 Nov 2026 18:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795630448;
 bh=U/J49RQBCn8X7I3oqHE+nT6dLJxQcWXeno10Iod3HNc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kSEHYqf9TjtOJKS1IYT0m7nR0/Z0sUhAY0e8mESseAL/Vb4hQVWeyfCmmoxog3oVU
 +JCPfiDYuB9NROOCAzMB2VhKe8a0qG9EvRgC4SG1W8f2tX1X71kAO9pP+riQxbK6La
 Qh8Hggb1Scp12VS0Yjr0yHcE/azH9rAOa4HFAlYU0xPPcOxdrlr6Cm+iHhs99nfP7q
 weXbHEBHrmo/F7N1UJ/zkwC7QbPIb8cz8f0Sy+TeAmbTyXMuX/ZSAsR5+ifrXkM/dY
 KGsekLOwJuIn9PMvU0pF2qf2lLH8WK2acq4Ridh5XIrRu9Yf3waOpeWDu1OSjV3kf6
 B3ItlG8ZPMNLg==
Message-ID: <sashiko-outbox-233929@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/32] drm/display: bridge-connector: add APIs to
 add/remove the connector dynamically
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev, Frank.Li@kernel.org
In-Reply-To: <20261125-drm-bridge-hotplug-v4-10-822722850492@bootlin.com>
References: <20261125-drm-bridge-hotplug-v4-0-822722850492@bootlin.com>
 <20261125-drm-bridge-hotplug-v4-10-822722850492@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 18:14:07 +0000
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

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] drm/display: bridge_connector UAF when mode_config cleanup
  precedes drmm
- [Medium] drm/display: bridge_connector memory leak on early init
  failure
- [Medium] drm/display: bridge and fwnode ref leaks in
  drm_bridge_connector_initialize()
- [Low] drm/display: missing kernel-doc, unused forward decl, and
  duplicated init
--

commit a02e04d142ea4a8a0fe3098841fdb782ae21bfc9
Author: Luca Ceresoli <luca.ceresoli@bootlin.com>

drm/display: bridge-connector: add APIs to add/remove the connector dynamic=
ally

This commit switches drm_bridge_connector allocation from drmm_kzalloc() to
kzalloc_obj() freed in the connector destroy callback, and adds
drm_bridge_connector_dynamic_add() and drm_bridge_connector_dynamic_remove(=
).

> diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu=
/drm/display/drm_bridge_connector.c
> index d81cfc7aa295b..07385f87b2e8d 100644
> --- a/drivers/gpu/drm/display/drm_bridge_connector.c
> +++ b/drivers/gpu/drm/display/drm_bridge_connector.c
> @@ -289,6 +289,7 @@ static void drm_bridge_connector_dynconn_destroy(stru=
ct drm_connector *connector
> =20
>  	drm_connector_cleanup(connector);
>  	drm_bridge_connector_put_bridges(bridge_connector);
> +	kfree(bridge_connector);
>  }
> =20
>  static const struct drm_connector_funcs drm_bridge_connector_funcs =3D {

[Severity: High]
Can freeing bridge_connector in drm_bridge_connector_dynconn_destroy() cause
a use-after-free in drmm_bridge_connector_fini() when a driver using
drm_bridge_connector_init() runs drm_mode_config_cleanup() before
drm_dev_put()?

drm_bridge_connector_init() registers drmm_bridge_connector_fini() with a r=
aw
bridge_connector pointer without taking an extra connector reference.
Drivers such as omapdrm (in omapdrm_cleanup()) and imx/dcss (in
dcss_kms_detach()) call drm_mode_config_cleanup() before drm_dev_put().
drm_mode_config_cleanup() drops the connector's sole reference and flushes
connector_free_work, invoking drm_bridge_connector_dynconn_destroy() and
freeing bridge_connector.  When drm_dev_put() later runs drmm actions,
drmm_bridge_connector_fini() calls drm_bridge_connector_fini() on the freed
bridge_connector, locking the destroyed connector->mutex and calling
drm_connector_put() on freed memory.

Conversely, when drmm_mode_config_init() is used so that
drmm_bridge_connector_fini() runs before drm_mode_config_cleanup(), if the
connector is still bound to an active CRTC (refcount 2),
drmm_bridge_connector_fini() only drops the refcount to 1.
drm_mode_config_cleanup() then drops the remaining reference from 1 to 0,
and drm_connector_cleanup() -> __drm_atomic_helper_connector_destroy_state()
calls drm_connector_put(state->connector) on a connector whose refcount is
already 0.

> @@ -1223,7 +1224,7 @@ struct drm_connector *drm_bridge_connector_init(str=
uct drm_device *drm,
>  	struct drm_connector *connector;
>  	int ret;
> =20
> -	bridge_connector =3D drmm_kzalloc(drm, sizeof(*bridge_connector), GFP_K=
ERNEL);
> +	bridge_connector =3D kzalloc_obj(*bridge_connector);
>  	if (!bridge_connector)
>  		return ERR_PTR(-ENOMEM);
> =20
> @@ -1238,3 +1239,24 @@ struct drm_connector *drm_bridge_connector_init(st=
ruct drm_device *drm,
>  	return connector;
>  }
>  EXPORT_SYMBOL_GPL(drm_bridge_connector_init);

[Severity: Medium]
Does switching from drmm_kzalloc() to kzalloc_obj() leak bridge_connector in
both drm_bridge_connector_init() and drm_bridge_connector_dynamic_add() when
drm_bridge_connector_initialize() fails before connector initialization
succeeds?

kfree(bridge_connector) is only called in
drm_bridge_connector_dynconn_destroy() via drm_connector_put().  If
drm_bridge_connector_initialize() returns an error during bridge chain
inspection, when connector_type is DRM_MODE_CONNECTOR_Unknown, or when
drm_connector_hdmi_dynamic_init() / drm_connector_dynamic_init() fails:

drivers/gpu/drm/display/drm_bridge_connector.c:drm_bridge_connector_initial=
ize() {
	...
	if (ret) {
		drm_bridge_connector_put_bridges(bridge_connector);
		return ERR_PTR(ret);
	}
	...
}

drm_connector_put() is never called on those paths, so bridge_connector is
never freed.

> +
> +struct drm_connector *drm_bridge_connector_dynamic_add(struct drm_device=
 *drm,
> +						       struct drm_encoder *encoder)
> +{
> +	struct drm_bridge_connector *bridge_connector;
> +
> +	bridge_connector =3D kzalloc_obj(*bridge_connector);
> +	if (!bridge_connector)
> +		return ERR_PTR(-ENOMEM);
> +
> +	return drm_bridge_connector_initialize(bridge_connector, drm, encoder);
> +}
> +EXPORT_SYMBOL_GPL(drm_bridge_connector_dynamic_add);

[Severity: Medium]
Does drm_bridge_connector_initialize() also leak bridge and fwnode referenc=
es
on its early error paths?

During the drm_for_each_bridge_in_chain() loop,
drm_bridge_connector_initialize() takes references with drm_bridge_get() and
fwnode_handle_get(), but returns ERR_PTR() directly on validation errors or
when connector_type =3D=3D DRM_MODE_CONNECTOR_Unknown without calling
drm_bridge_connector_put_bridges() or fwnode_handle_put(connector->fwnode):

drivers/gpu/drm/display/drm_bridge_connector.c:drm_bridge_connector_initial=
ize() {
		...
		if (bridge->ops & DRM_BRIDGE_OP_HDMI_CEC_ADAPTER) {
			if (bridge_connector->bridge_hdmi_cec)
				return ERR_PTR(-EBUSY);

			bridge_connector->bridge_hdmi_cec =3D drm_bridge_get(bridge);

			if (!bridge->funcs->hdmi_cec_enable ||
			    !bridge->funcs->hdmi_cec_log_addr ||
			    !bridge->funcs->hdmi_cec_transmit)
				return ERR_PTR(-EINVAL);
		}
		...
#ifdef CONFIG_OF
		if (drm_bridge_is_last(bridge) && bridge->of_node)
			connector->fwnode =3D fwnode_handle_get(of_fwnode_handle(bridge->of_node=
));
#endif
		...
	}

	if (connector_type =3D=3D DRM_MODE_CONNECTOR_Unknown)
		return ERR_PTR(-EINVAL);
	...
}

In addition, if drm_connector_dynamic_init() or
drm_connector_hdmi_dynamic_init() fails before drm_connector_cleanup() can
run, the error block calls drm_bridge_connector_put_bridges() but still lea=
ks
connector->fwnode.

> diff --git a/include/drm/drm_bridge_connector.h b/include/drm/drm_bridge_=
connector.h
> index 69630815fb093..de6ec91dbfabd 100644
> --- a/include/drm/drm_bridge_connector.h
> +++ b/include/drm/drm_bridge_connector.h
> @@ -9,8 +9,12 @@
>  struct drm_connector;
>  struct drm_device;
>  struct drm_encoder;
> +struct drm_bridge_connector;
> =20
>  struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
>  						struct drm_encoder *encoder);
> +struct drm_connector *drm_bridge_connector_dynamic_add(struct drm_device=
 *drm,
> +						       struct drm_encoder *encoder);
> +void drm_bridge_connector_dynamic_remove(struct drm_connector *connector=
);
> =20
>  #endif /* __DRM_BRIDGE_CONNECTOR_H__ */

[Severity: Low]
This isn't a bug, but struct drm_bridge_connector is internal to
drm_bridge_connector.c and unused in this header.  Also,
Documentation/gpu/drm-kms-helpers.rst pulls in drm_bridge_connector.c with
the :export: directive, so the newly exported
drm_bridge_connector_dynamic_add() and drm_bridge_connector_dynamic_remove()
functions should have kernel-doc comments, and drm_bridge_connector_init()
could call drm_bridge_connector_dynamic_add() (or move the allocation into
drm_bridge_connector_initialize()) to avoid duplicating the allocation and
initialization sequence.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125-drm-bridge=
-hotplug-v4-0-822722850492@bootlin.com?part=3D10
