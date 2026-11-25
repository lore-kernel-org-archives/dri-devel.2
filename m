Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8930C606A695
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 18:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iHn2yFdR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E493C10FEBC;
	Wed, 25 Nov 2026 18:11:07 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9902110FEBC
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 18:11:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 54DD5464C1;
 Wed, 25 Nov 2026 18:11:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A95DB1F000C0;
 Wed, 25 Nov 2026 18:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795630261;
 bh=TJrmhBW7Whp4RXUd078bF5KWceT6mDGpYQfhxFEGlJ0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iHn2yFdR4j4w7fYHIlX9ceyFkm+QGtXZ/CDahNmgoEc0b/ln5oY+z0F1uOp0G5ock
 Wzpx8dB+elPa9FjExo568357Xof7gZlZjAncxuKTcBGn1D4+D45t8a+Q2Mc+OLjAtB
 OOO7V2BwNcWrfomj3bZ//WARwYWZ6e3IAhgdI1qpe00gGnsmmjgp6xU3s4Uinx/E3h
 kSKYdR6OLZkNDQaRirLO19fTgM68G79RUiC7Li99HbQvWaosbCkGIy7IytASQUxUV6
 QmgxR97IEIpi8kFNMFzC5+LiV2Vac1Bvq/oMYt/mUdLRxrQjj1c1Pa7zahrK4XznnE
 r+WGhAAaUa3hg==
Message-ID: <sashiko-outbox-233916@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/32] drm/connector: add
 drm_connector_hdmi_dynamic_init()
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev, Frank.Li@kernel.org
In-Reply-To: <20261125-drm-bridge-hotplug-v4-6-822722850492@bootlin.com>
References: <20261125-drm-bridge-hotplug-v4-0-822722850492@bootlin.com>
 <20261125-drm-bridge-hotplug-v4-6-822722850492@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 18:10:56 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] drm/connector: dynamic HDMI init creates non-refcounted
  drm_property post-reg
--

commit 3a8f2d8e52f1964bd9a6d73f9170a7532ea70354
Author: Luca Ceresoli <luca.ceresoli@bootlin.com>

drm/connector: add drm_connector_hdmi_dynamic_init()

This commit adds drm_connector_hdmi_dynamic_init() to initialize dynamically
created HDMI connectors for hotpluggable bridges.

> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connec=
tor.c
> index 20120b6a05d52..021f2e120fdc7 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -704,6 +704,49 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
>  }
>  EXPORT_SYMBOL(drmm_connector_hdmi_init);
> =20
> +/**
> + * drm_connector_hdmi_dynamic_init - Init a preallocated dynamic HDMI co=
nnector
> + * @dev: DRM device
> + * @connector: A pointer to the HDMI connector to init
> + * @funcs: callbacks for this connector
> + * @hdmi_funcs: HDMI-related callbacks and capabilities for this connect=
or
> + * @connector_type: user visible type of the connector
> + * @ddc: optional pointer to the associated ddc adapter
> + *
> + * Initialises a preallocated dynamic HDMI connector. Connectors can be
> + * subclassed as part of driver connector objects.
> + *
> + * See drm_connector_dynamic_init(), the same constraints apply here. Th=
is
> + * is just the HDMI version.
> + *
> + * Returns:
> + * Zero on success, error code on failure.
> + */
> +int drm_connector_hdmi_dynamic_init(struct drm_device *dev,
> +				    struct drm_connector *connector,
> +				    const struct drm_connector_funcs *funcs,
> +				    const struct drm_connector_hdmi_funcs *hdmi_funcs,
> +				    int connector_type,
> +				    struct i2c_adapter *ddc)
> +{
> +	int ret;
> +
> +	ret =3D drm_connector_hdmi_sanity_checks(dev, connector, hdmi_funcs, co=
nnector_type);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D drm_connector_dynamic_init(dev, connector, funcs, connector_typ=
e, ddc);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D drm_connector_hdmi_initialize(dev, connector, hdmi_funcs);
> +	if (ret)
> +		drm_connector_cleanup(connector);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(drm_connector_hdmi_dynamic_init);

[Severity: High]
Can drm_connector_hdmi_initialize() be called safely after drm_dev_register=
()
has registered the DRM device?

On a fresh connector, drm_connector_hdmi_initialize() calls
drm_connector_attach_max_bpc_property() and
drm_connector_attach_color_format_property(), which create new drm_property
objects via drm_property_create_range() and drm_property_create_enum().
Because DRM properties are non-refcounted mode objects (obj_free_cb is NULL=
),
calling drm_property_create() -> drm_mode_object_add() when dev->registered=
 is
true triggers:

drivers/gpu/drm/drm_mode_object.c:__drm_mode_object_add() {
	WARN_ON(!dev->driver->load && dev->registered && !obj_free_cb);
}

In addition, drm_property_create() adds the property to
dev->mode_config.property_list without locking and publishes it in
dev->mode_config.object_idr before initializing its fields and enum_list,
allowing a concurrent drm_mode_getproperty_ioctl() to observe an
uninitialized property.  Finally, drm_connector_cleanup() does not destroy
connector->max_bpc_property or connector->color_format_property, so those
properties and their mode object IDs are leaked if
drm_connector_attach_color_format_property() fails or each time an HDMI
connector is hot-unplugged and re-plugged.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125-drm-bridge=
-hotplug-v4-0-822722850492@bootlin.com?part=3D6
