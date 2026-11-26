Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974D0606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 12:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l1YVw0BZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 070BF10E28A;
	Thu, 26 Nov 2026 12:02:22 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E66431121D5
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 12:02:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9DE1E442F7;
 Thu, 26 Nov 2026 12:02:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CBE11F000C0;
 Thu, 26 Nov 2026 12:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795694535;
 bh=J2Fojx+eQR89FePvbsqK9ONEa2UVUsj/w+2jn4z68s8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=l1YVw0BZgeP0wuI6u4zj1F4737u4+hN9NTMrsvKuujuj63rwi6tYI2tnCucCm6Hvu
 VaqN0KEh/7Jy3FRblTg1iWOd1yJCOCXPm2NdzGlVpXA350eYpHkKKiIxnZfMAKXxO9
 e2cSwXz75AGO6isQwCges4yVUSSFa33IJ2Pw1B0bl0lQIP/5Iigk4Pw+0HoDosLNlS
 iVhWrtLdT1r6kN6TcqYhZLyOc2JuY5v/PTHdsPlFP6sbV3yKjFD/EMgNsE67C0us2s
 IZMeIzO0+3DlcRRPAhZc30SKAnA+A3svHrX/A+7ibedqSRljWeYcbo6aEJK3tw2Hx4
 9nrY02aZAEU9Q==
Message-ID: <sashiko-outbox-235470@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 41/43] drm/vkms: Introduce configfs for dynamic
 connector creation
To: "Louis Chauvet" <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261126-vkms-all-config-v7-41-21194cda2468@bootlin.com>
References: <20261126-vkms-all-config-v7-0-21194cda2468@bootlin.com>
 <20261126-vkms-all-config-v7-41-21194cda2468@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 12:02:15 +0000
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

Thank you for your contribution! Sashiko AI review found 6 potential
issues to consider:
- [High] drm/vkms: lock ordering inversion in connector_enabled_store()
  and release
- [High] drm/vkms: hot-attach before validation in
  connector_possible_encoders_allow_link()
- [High] drm/vkms: vkms_config_is_valid() in connector_enabled_store()
  blocks disable/hot-add
- [Medium] drm/vkms: static connector with enabled=3D0 bypasses -EBUSY
  check on encoder link
- [Medium] drm/vkms: missing connector_is_enabled() check on EDID store
  hotplug trigger
- [Medium] drm/vkms: race and dangling connector pointer between device
  enable and dynamic configfs
--

commit fa8dad28555bc1ce76cc884bdb3e5a07d26b3e35
Author: Louis Chauvet <louis.chauvet@bootlin.com>

drm/vkms: Introduce configfs for dynamic connector creation

This commit adds dynamic and enabled configfs attributes to VKMS
connectors to support creating, removing, and attaching encoders to
dynamic connectors at runtime.

> diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/=
vkms_configfs.c
> index 1822978879ff3..0681722e98e8d 100644
> --- a/drivers/gpu/drm/vkms/vkms_configfs.c
> +++ b/drivers/gpu/drm/vkms/vkms_configfs.c
[ ... ]
> @@ -1281,6 +1287,106 @@ static ssize_t connector_edid_store(struct config=
_item *item,
>  		    connector_status_disconnected)
>  			vkms_trigger_connector_hotplug(connector->dev->config->dev);
>  	}

[Severity: Medium]
Should connector_edid_store() and connector_edid_enabled_store() also
check connector_is_enabled() before calling
vkms_trigger_connector_hotplug(), as connector_status_store() does?

Because a newly created dynamic connector defaults to
connector_status_connected, configuring its EDID attributes while it is
still disabled triggers a hotplug event on the device before the connector
has been hot-added.

> +	return count;
> +}
> +
> +static ssize_t connector_enabled_show(struct config_item *item, char *pa=
ge)
> +{
> +	struct vkms_configfs_connector *connector;
> +	bool enabled;
> +
> +	connector =3D connector_item_to_vkms_configfs_connector(item);
> +
> +	scoped_guard(mutex, &connector->dev->config->lock)
> +		enabled =3D vkms_config_connector_is_enabled(connector->config);
> +
> +	return sprintf(page, "%d\n", enabled);
> +}
> +
> +static ssize_t connector_enabled_store(struct config_item *item,
> +				       const char *page, size_t count)
> +{
> +	struct vkms_configfs_connector *connector;
> +	struct vkms_config_connector *connector_cfg;
> +	bool enabled, was_enabled;
> +
> +	connector =3D connector_item_to_vkms_configfs_connector(item);
> +	connector_cfg =3D connector->config;
> +
> +	if (kstrtobool(page, &enabled))
> +		return -EINVAL;
> +	scoped_guard(mutex, &connector->dev->config->lock) {
> +		if (!connector->dev->enabled) {
> +			vkms_config_connector_set_enabled(connector_cfg, enabled);
> +		} else {
> +			// Only dynamic connector can be enabled/disabled at runtime
> +			if (!connector_cfg->dynamic)
> +				return -EBUSY;
> +
> +			was_enabled =3D vkms_config_connector_is_enabled(connector_cfg);
> +			vkms_config_connector_set_enabled(connector_cfg, enabled);
> +
> +			// Resulting configuration is invalid (missing encoder for example)
> +			// Early return to avoid drm core issue
> +			if (!vkms_config_is_valid(connector->dev->config)) {
> +				vkms_config_connector_set_enabled(connector_cfg,
> +								  was_enabled);
> +				return -EINVAL;
> +			}

[Severity: High]
Does running vkms_config_is_valid() across the whole device here prevent
enabling or disabling a dynamic connector whenever any disabled dynamic
connector has no encoder linked?

valid_connector_possible_encoders() requires every connector in
config->connectors to have at least one possible encoder, regardless of
whether it is enabled:

drivers/gpu/drm/vkms/vkms_config.c:valid_connector_possible_encoders() {
	...
	vkms_config_for_each_connector(config, connector_cfg) {
		if (xa_empty(&connector_cfg->possible_encoders)) {
			drm_info(dev,
				 "All connectors must have at least one possible encoder\n");
			return false;
		}
	}
	...
}

As a result, creating a new connector directory while the device is
enabled (which starts with dynamic=3Dtrue, enabled=3Dfalse and an empty
possible_encoders xarray) causes vkms_config_is_valid() to fail for all
connectors until that disabled connector is also given an encoder.
Similarly, if a user unlinks the encoder from a dynamic connector and then
writes 0 to enabled to remove it, connector_enabled_store() rejects the
disable with -EINVAL.

> +
> +			if (!was_enabled && enabled) {
> +				struct vkms_connector *conn;
> +
> +				// Adding the connector
> +				conn =3D vkms_connector_hot_add(connector->dev->config->dev,
> +							      connector_cfg);
> +				if (IS_ERR(conn)) {
> +					vkms_config_connector_set_enabled(connector_cfg, was_enabled);
> +					return PTR_ERR(conn);
> +				}
> +				connector_cfg->connector =3D conn;
> +			} else if (was_enabled && !enabled) {
> +				vkms_connector_hot_remove(connector_cfg->connector);
> +			}
> +		}
> +	}
> +	return count;
> +}

[Severity: High]
Can calling vkms_connector_hot_add() and vkms_connector_hot_remove() under
connector->dev->config->lock in connector_enabled_store() (and in
connector_release() below) cause an ABBA deadlock with connector probing?

Both vkms_connector_hot_add() and vkms_connector_hot_remove() acquire
mode_config.mutex while config->lock is held.  During connector probing,
the DRM core holds mode_config.mutex and calls vkms_connector_detect(),
which takes config->lock:

CPU0                              CPU1
----                              ----
lock(&config->lock)
                                  lock(&dev->mode_config.mutex)
lock(&dev->mode_config.mutex)
                                  lock(&config->lock)

 *** DEADLOCK ***

CPU0: connector_enabled_store() -> vkms_connector_hot_add()
CPU1: drm_mode_getconnector() -> ... -> vkms_connector_detect()

[Severity: Medium]
Can connector_enabled_store(), connector_release(), or
connector_possible_encoders_allow_link() race with device_enabled_store()
and dereference an uninitialized or stale connector_cfg->connector or
config->dev pointer?

device_enabled_store() sets dev->enabled =3D true under config->lock and
then drops the lock before calling vkms_create().  In addition, when a
device is disabled, vkms_connector_dynamic_destroy() frees the dynamic
vkms_connector without clearing connector_cfg->connector.

CPU0                              CPU1
device_enabled_store()
  lock(&config->lock)
  dev->enabled =3D true
  unlock(&config->lock)
                                  connector_enabled_store()
                                    lock(&config->lock)
                                    if (connector->dev->enabled)
                                      vkms_connector_hot_remove(
                                        connector_cfg->connector)
                                        <-- NULL or use-after-free
  vkms_create()
    ...
    connector_cfg->connector =3D ...

[ ... ]

> @@ -1335,14 +1452,24 @@ static int connector_possible_encoders_allow_link=
(struct config_item *src,
>  		return -EINVAL;
> =20
>  	connector =3D connector_possible_encoders_item_to_vkms_configfs_connect=
or(src);
> +	connector_cfg =3D connector->config;
>  	encoder =3D encoder_item_to_vkms_configfs_encoder(target);
> =20
>  	scoped_guard(mutex, &connector->dev->config->lock) {
> -		if (connector->dev->enabled)
> -			return -EBUSY;
> +		if (connector->dev->enabled && connector_cfg->enabled) {
> +			if (!connector_cfg->dynamic)
> +				return -EBUSY;
> +
> +			ret =3D vkms_connector_hot_attach_encoder(connector->config->connecto=
r,
> +								encoder->config->encoder);
> +			if (ret)
> +				return ret;
> +		}
> =20
>  		ret =3D vkms_config_connector_attach_encoder(connector->config,
>  							   encoder->config);
> +		if (ret)
> +			return ret;
>  	}
> =20
>  	return ret;

[Severity: High]
Can calling vkms_connector_hot_attach_encoder() before
vkms_config_connector_attach_encoder() cause a NULL pointer dereference
when linking an encoder from another disabled VKMS device?

vkms_config_connector_attach_encoder() is what checks
connector_cfg->config !=3D encoder_cfg->config and checks for duplicate or
failed xarray insertions.  Because vkms_connector_hot_attach_encoder()
runs first, linking an encoder that belongs to a different, disabled VKMS
device passes a NULL encoder->config->encoder to
drm_connector_attach_encoder() -> drm_encoder_mask().  Even for an encoder
on the same device, if vkms_config_connector_attach_encoder() fails with
-EEXIST or -ENOMEM, the encoder bit added to the live DRM connector by
vkms_connector_hot_attach_encoder() is not rolled back.

[Severity: Medium]
Should connector_possible_encoders_allow_link() check
connector_is_enabled(connector_cfg) instead of connector_cfg->enabled?

While the device is disabled, connector_enabled_store() allows setting
connector_cfg->enabled =3D false on a static connector.  When the device is
subsequently enabled, vkms_output_init() still registers all static
connectors, so checking connector_cfg->enabled here skips the -EBUSY check
and allows mutating connector_cfg->possible_encoders on a live static
connector.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-vkms-all-c=
onfig-v7-0-21194cda2468@bootlin.com?part=3D41
