Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39393606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 18:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jCIilBRK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C87C89819;
	Wed, 25 Nov 2026 18:21:58 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C64FE10FEF9
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 18:21:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 03B22635AD;
 Wed, 25 Nov 2026 18:21:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8609D1F000C6;
 Wed, 25 Nov 2026 18:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795630910;
 bh=czMOwjGvjzYcVlMMkBCtLRHbZcW55IfSuyA1dEltLMo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jCIilBRK96voysymIxNhMEKJ9o0abTU5hw8HhkCPCZWP8K17KoI6/34whC37EyCnH
 aXP4s+uTsZLxdZdNjjta+6LbYyheu3CAyrVjmI1jwkFvTYtcYPeVibe7pxKILwhgiX
 MjJbr9xG5rdGanBcXh8wY8RNS6MaY5oVScuNVbgW5Kk2ZW/a8GAWSthA+V5kkQtFoy
 IgsYrOLRF3lszSUXKTD5xwmhCrDsu3yk0fzVmONxO+VPyQjTGr3DflTv0asWfh9qZ1
 t+KYHQA2FmeCKAdenn5/6rvIgQhyf2W/OVSvUh1Q6KNOaPzkARM7qbjcTK2rA27iWo
 5IEvCOdXOrtlg==
Message-ID: <sashiko-outbox-233972@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/32] drm/display: bridge-connector: use a dynamic
 connector
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev, Frank.Li@kernel.org
In-Reply-To: <20261125-drm-bridge-hotplug-v4-9-822722850492@bootlin.com>
References: <20261125-drm-bridge-hotplug-v4-0-822722850492@bootlin.com>
 <20261125-drm-bridge-hotplug-v4-9-822722850492@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 18:21:50 +0000
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
- [High] drm/display: bridge-connector: double teardown in
  drmm_bridge_connector_fini()
- [Medium] drm/display: bridge-connector: reference leaks in
  drm_bridge_connector_initialize()
- [Low] drm/display: bridge-connector: missing colon in
  @has_cec_notifier kernel-doc
--

commit 17489de6cf9da07d5d4da90bca09f1c4add46b17
Author: Luca Ceresoli <luca.ceresoli@bootlin.com>

drm/display: bridge-connector: use a dynamic connector

This commit switches drm_bridge_connector initialization from drmm-managed
connector and CEC helpers to dynamic connector initialization and explicit
teardown in preparation for bridge hotplug.

> diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu=
/drm/display/drm_bridge_connector.c
> index f4a71801e8a3b..d81cfc7aa295b 100644
> --- a/drivers/gpu/drm/display/drm_bridge_connector.c
> +++ b/drivers/gpu/drm/display/drm_bridge_connector.c
> @@ -132,11 +132,27 @@ struct drm_bridge_connector {
>  	 * bridge connector.
>  	 */
>  	struct drm_connector_hdmi_funcs hdmi_funcs;
> +	/** @has_cec_adapter: true if a CEC adapter is registered */
> +	bool has_cec_adapter;
> +	/** @has_cec_notifier true if a CEC notifier is registered */
> +	bool has_cec_notifier;
>  };

[Severity: Low]
A colon is missing after @has_cec_notifier, which triggers a kernel-doc
warning for struct drm_bridge_connector.

[ ... ]

> @@ -849,10 +860,6 @@ drm_bridge_connector_initialize(struct drm_bridge_co=
nnector *bridge_connector,
>  	int connector_type;
>  	int ret;
> =20
> -	ret =3D drmm_add_action(drm, drm_bridge_connector_put_bridges, bridge_c=
onnector);
> -	if (ret)
> -		return ERR_PTR(ret);
> -
>  	bridge_connector->encoder =3D encoder;
> =20
>  	/*
> @@ -1053,17 +1060,21 @@ drm_bridge_connector_initialize(struct drm_bridge=
_connector *bridge_connector,
>  				drm_bridge_connector_scrambler_disable;
>  		}
> =20
> -		ret =3D drmm_connector_hdmi_init(drm, connector,
> -					       &drm_bridge_connector_funcs,
> -					       &bridge_connector->hdmi_funcs,
> -					       connector_type, ddc);
> +		ret =3D drm_connector_hdmi_dynamic_init(drm, connector,
> +						      &drm_bridge_connector_funcs,
> +						      &bridge_connector->hdmi_funcs,
> +						      connector_type, ddc);
>  	} else {
> -		ret =3D drmm_connector_init(drm, connector,
> -					  &drm_bridge_connector_funcs,
> -					  connector_type, ddc);
> +		ret =3D drm_connector_dynamic_init(drm, connector,
> +						 &drm_bridge_connector_funcs,
> +						 connector_type, ddc);
> +	}
> +	if (ret) {
> +		drm_bridge_connector_put_bridges(bridge_connector);
> +		return ERR_PTR(ret);
>  	}
> -	if (ret)
> -		return ret;
> +
> +	/* From now on the connector is referenced and has to be put */

[Severity: Medium]
Does removing the upfront drmm_add_action() leak bridge_connector->bridge_*
and connector->fwnode references when drm_bridge_connector_initialize()
fails earlier?

During drm_for_each_bridge_in_chain(), the loop acquires references with
drm_bridge_get() and fwnode_handle_get(), but any early return inside the
loop or at the connector_type =3D=3D DRM_MODE_CONNECTOR_Unknown check retur=
ns
directly without calling drm_bridge_connector_put_bridges() or
fwnode_handle_put(connector->fwnode).  In addition, if
drm_connector_dynamic_init() fails (or drm_connector_hdmi_dynamic_init()
fails before reaching drm_connector_cleanup()), the error block above puts
the bridges but still leaks connector->fwnode.

[ ... ]

> +static void drm_bridge_connector_fini(struct drm_bridge_connector *bridg=
e_connector)
> +{
> +	struct drm_connector *connector =3D &bridge_connector->base;
> +
> +	drm_connector_unregister(connector);
> +	if (bridge_connector->has_cec_adapter)
> +		drm_connector_hdmi_cec_unregister(connector);
> +	if (bridge_connector->has_cec_notifier)
> +		drm_connector_hdmi_cec_notifier_unregister(connector);
> +
> +#ifdef CONFIG_OF
> +	if (connector->fwnode) {
> +		fwnode_handle_put(connector->fwnode);
> +		connector->fwnode =3D NULL;
> +	}
> +#endif
> +
> +	drm_connector_put(connector);
> +}
> +
> +static void drmm_bridge_connector_fini(struct drm_device *dev, void *res)
> +{
> +	struct drm_bridge_connector *bridge_connector =3D (struct drm_bridge_co=
nnector *)res;
> +
> +	drm_bridge_connector_fini(bridge_connector);
>  }
> =20
>  /**
> @@ -1155,6 +1221,7 @@ struct drm_connector *drm_bridge_connector_init(str=
uct drm_device *drm,
>  {
>  	struct drm_bridge_connector *bridge_connector;
>  	struct drm_connector *connector;
> +	int ret;
> =20
>  	bridge_connector =3D drmm_kzalloc(drm, sizeof(*bridge_connector), GFP_K=
ERNEL);
>  	if (!bridge_connector)
> @@ -1164,6 +1231,10 @@ struct drm_connector *drm_bridge_connector_init(st=
ruct drm_device *drm,
>  	if (IS_ERR(connector))
>  		return connector;
> =20
> +	ret =3D drmm_add_action_or_reset(drm, drmm_bridge_connector_fini, bridg=
e_connector);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
>  	return connector;
>  }

[Severity: High]
Can drmm_bridge_connector_fini() tear down a connector that has already
been destroyed by drm_mode_config_cleanup()?

Drivers such as omapdrm, tegra, exynos, imx/dcss and kmb create connectors
with drm_bridge_connector_init() and explicitly call
drm_mode_config_cleanup() before drm_dev_put().  Because the connector is
on dev->mode_config.connector_list with a single reference,
drm_mode_config_cleanup() drops that reference and flushes
connector_free_work, running drm_bridge_connector_dynconn_destroy() ->
drm_connector_cleanup(), which destroys connector->mutex and zeroes
*connector (including connector->cec.data).  When drm_dev_put() then runs
drmm_bridge_connector_fini(), drm_connector_unregister() locks the
destroyed connector->mutex and drm_connector_hdmi_cec_unregister()
dereferences NULL connector->cec.data; once commit "drm/display:
bridge-connector: add APIs to add/remove the connector dynamically" adds
kfree(bridge_connector) to drm_bridge_connector_dynconn_destroy(),
drmm_bridge_connector_fini() also becomes a use-after-free on
bridge_connector.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125-drm-bridge=
-hotplug-v4-0-822722850492@bootlin.com?part=3D9
