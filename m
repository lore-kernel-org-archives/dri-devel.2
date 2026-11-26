Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001B4606A32A
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 12:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QDgSBDo+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E3191121D5;
	Thu, 26 Nov 2026 12:06:01 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A8D31121D5
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 12:05:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6225160D45;
 Thu, 26 Nov 2026 12:05:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7C41F000C0;
 Thu, 26 Nov 2026 12:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795694754;
 bh=lz0NuUMEv2r15qVr15I0x+HlOskiSsUamx/nTYZ+8sA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QDgSBDo+B9D7JghxQ4PGPTuejkHVspAEsJ/E3d53cTMcMHPdolpH+Eb4GDgKOmvIQ
 NODZstS/U8Qwa44XZldhFtnRWqGiqLdD8YaCxiTfj8Sm+lpy//BwQ1sMjeTSRpmwDA
 WSqH3xtdBk6tRBch5nm/DH0RK/T1BbUHOwoatWZliukSnMvIIUNX+zassHEXJGNUto
 4HXcOjEW1gNfWxPAUjl24HHZtghfFcrrtWmDT+lf/6nk4WPKVylvHKJK8ttXq4C/1v
 3zLuzK6ztJ3QQg45adVESj9pWIBXg/UykOZQhKhc0PIGaZve3VJBslVLDYdOYIOMDn
 /E9xStN+WyfIw==
Message-ID: <sashiko-outbox-235474@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 40/43] drm/vkms: Allow to hot-add connectors
To: "Louis Chauvet" <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261126-vkms-all-config-v7-40-21194cda2468@bootlin.com>
References: <20261126-vkms-all-config-v7-0-21194cda2468@bootlin.com>
 <20261126-vkms-all-config-v7-40-21194cda2468@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 12:05:53 +0000
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

Thank you for your contribution! Sashiko AI review found 8 potential
issues to consider:
- [High] drm/vkms: dynamic create/destroy of colorspace_property causes
  UAF and WARN_ON
- [High] drm/vkms: ERR_PTR or dangling connector_cfg->connector
  dereferenced in configfs
- [High] drm/vkms: lock inversion and race between mode_config.mutex and
  config->lock
- [High] drm/vkms: missing unregistered check in vkms_connector_detect()
  leaks connectors
- [High] drm/vkms: AB-BA deadlock in vkms_connector_hot_remove() on
  mode_config.mutex
- [Medium] drm/vkms: vkms_connector_hot_attach_encoder() hits WARN_ON on
  active connector
- [Medium] drm/vkms: unlocked RCU list and XArray traversal in
  vkms_output_init()
- [Medium] drm/vkms: unsynchronized runtime mutation of
  connector->base.possible_encoders
--

commit 972205cf7741df00d32510d0edacb3bc8edd0c9e
Author: Louis Chauvet <louis.chauvet@bootlin.com>

drm/vkms: Allow to hot-add connectors

This commit adds helpers to hot-add and hot-remove dynamic VKMS
connectors and attach or detach their possible encoders at runtime.

> diff --git a/drivers/gpu/drm/vkms/vkms_connector.c b/drivers/gpu/drm/vkms=
/vkms_connector.c
> index 71a0ae15be653..93bceba0a1ae6 100644
> --- a/drivers/gpu/drm/vkms/vkms_connector.c
> +++ b/drivers/gpu/drm/vkms/vkms_connector.c
[ ... ]
> @@ -197,9 +198,146 @@ struct vkms_connector *vkms_connector_init_static(s=
truct vkms_device *vkmsdev,
>  	return connector;
>  }
> =20
> +static void vkms_connector_dynamic_destroy(struct drm_connector *connect=
or)
> +{
> +	struct vkms_connector *vkms_connector =3D drm_connector_to_vkms_connect=
or(connector);
> +
> +	if (connector->colorspace_property) {
> +		drm_property_destroy(connector->dev,
> +				     connector->colorspace_property);
> +		connector->colorspace_property =3D NULL;
> +	}

[Severity: High]
Can connector->colorspace_property be created and destroyed dynamically
while the DRM device is registered?

struct drm_property is a non-refcounted modeset object (free_cb is NULL)
linked into dev->mode_config.property_list without any lock.  When
vkms_connector_hot_add() calls vkms_connector_init() after
drm_dev_register() on an HDMI, DisplayPort or eDP connector with
supported_colorspaces set, drm_property_create() hits
WARN_ON(!dev->driver->load && dev->registered && !obj_free_cb) in
__drm_mode_object_add() and performs an unlocked list_add_tail() on
dev->mode_config.property_list.

When the dynamic connector is destroyed, calling drm_property_destroy()
here hits the matching WARN_ON in drm_mode_object_unregister(), does an
unlocked list_del() on dev->mode_config.property_list, and frees the
property while a concurrent drm_mode_getproperty_ioctl() can be reading
property->values and property->enum_list without a reference:

CPU0                                  CPU1
drm_mode_getproperty_ioctl()
  property =3D drm_property_find(...)
                                      vkms_connector_hot_remove()
                                        drm_connector_put()
                                          vkms_connector_dynamic_destroy()
                                            drm_property_destroy(property)
                                              kfree(property)
  copy_to_user(..., property->values)  <-- use-after-free

In addition, if a dynamic connector reference outlives the connector loop
in drm_mode_config_cleanup() during device teardown,
drm_mode_config_cleanup() frees every property on property_list without
clearing connector->colorspace_property, and the later
vkms_connector_dynamic_destroy() double frees it.

> +
> +	drm_connector_cleanup(connector);
> +
> +	if (vkms_connector->cfg)
> +		vkms_config_connector_put(vkms_connector->cfg);
> +	kfree(vkms_connector);
> +}
[ ... ]
> +void vkms_connector_hot_remove(struct vkms_connector *connector)
> +{
> +	/*
> +	 * Userspace probes are serialized by mode_config.mutex:
> +	 * drm_mode_getconnector() holds it for the whole duration of the
> +	 * probe and the detect()/get_modes() callbacks read the connector
> +	 * state, including connector->cfg. Take the same mutex here so the
> +	 * unregistration and the config detachment are not visible in the
> +	 * middle of an in-flight probe.
> +	 */
> +	mutex_lock(&connector->base.dev->mode_config.mutex);
> +
> +	drm_connector_unregister(&connector->base);

[Severity: High]
Does calling drm_connector_unregister() under mode_config.mutex cause an
ABBA deadlock with the connector's sysfs attributes?

drm_connector_unregister() calls drm_sysfs_connector_remove() ->
device_unregister(connector->kdev), which waits in kernfs_drain() for
active sysfs reads or writes on that connector to complete, while sysfs
callbacks such as modes_show(), status_store() and edid_show() acquire
dev->mode_config.mutex:

CPU0                              CPU1
----                              ----
lock(&dev->mode_config.mutex)
                                  kernfs_fop_read_iter() (kn->active)
                                  lock(&dev->mode_config.mutex)
kernfs_drain() (waits kn->active)

 *** DEADLOCK ***

CPU0: vkms_connector_hot_remove() -> drm_connector_unregister() ->
      drm_sysfs_connector_remove() -> device_unregister()
CPU1: vfs_read() -> modes_show()

Calling drm_connector_unregister() before acquiring mode_config.mutex
avoids this inversion.

> +
> +	/*
> +	 * Only detach the config from the connector: in-flight userspace
> +	 * probes may still be reading connector->cfg (see vkms_connector_detec=
t()
> +	 * and vkms_conn_get_modes()), so the reference taken in
> +	 * vkms_connector_hot_add() must be kept until the connector is
> +	 * finally destroyed. vkms_connector_dynamic_destroy() releases it.
> +	 */
> +	if (connector->cfg)
> +		connector->cfg->connector =3D NULL;
> +
> +	mutex_unlock(&connector->base.dev->mode_config.mutex);

[Severity: High]
How do vkms_connector_hot_add() and vkms_connector_hot_remove() serialize
with config->lock?

During connector probing, drm_mode_getconnector() holds
dev->mode_config.mutex and calls vkms_connector_detect(), which acquires
cfg->config->lock, establishing the lock order mode_config.mutex ->
config->lock.  If vkms_connector_hot_add() or vkms_connector_hot_remove()
is called while holding config->lock, acquiring mode_config.mutex inside
these functions inverts that order:

CPU0                              CPU1
----                              ----
lock(&config->lock)
                                  lock(&dev->mode_config.mutex)
lock(&dev->mode_config.mutex)
                                  lock(&config->lock)

 *** DEADLOCK ***

CPU0: configfs hot-add / hot-remove -> vkms_connector_hot_add()
CPU1: drm_mode_getconnector() -> ... -> vkms_connector_detect()

Conversely, if vkms_connector_hot_remove() is called without config->lock,
clearing connector->cfg->connector under mode_config.mutex races with
connector_possible_encoders_drop_link(), which reads and dereferences
connector->config->connector under config->lock without holding
mode_config.mutex:

CPU0                                  CPU1
vkms_connector_hot_remove()           connector_possible_encoders_drop_link=
()
                                        lock(&config->lock)
                                        conn =3D connector->config->connect=
or
  lock(&mode_config.mutex)
  connector->cfg->connector =3D NULL
  unlock(&mode_config.mutex)
  drm_connector_put()
    kfree(connector)
                                        vkms_connector_hot_detach_encoder(c=
onn)
                                          <-- use-after-free

> +
> +	drm_connector_put(&connector->base);
> +}

[Severity: High]
Does hot-removing a connected dynamic connector leak the drm_connector and
its connector_ida slot?

When a dynamic connector has an active modeset, references to
connector->base are held by its connector state and by the in-kernel DRM
client.  vkms_connector_hot_remove() calls drm_connector_unregister() and
keeps connector->cfg non-NULL, but vkms_connector_detect() does not check
drm_connector_is_unregistered():

drivers/gpu/drm/vkms/vkms_connector.c:vkms_connector_detect() {
	...
	cfg =3D vkms_connector->cfg;
	if (cfg) {
		cfg =3D vkms_config_connector_get(cfg);
		scoped_guard(mutex, &cfg->config->lock)
			status =3D vkms_config_connector_get_status(cfg);
		vkms_config_connector_put(cfg);
	}

	return status;
}

Subsequent hotplug probes keep seeing the unregistered connector as
connector_status_connected, so clients never disable its CRTC or drop
their references, leaking the connector and exhausting the 32-connector
limit after repeated hot-removes.  Checking
drm_connector_is_unregistered(connector) in vkms_connector_detect() and
returning connector_status_disconnected would allow clients to release it.

> +
> +int vkms_connector_hot_attach_encoder(struct vkms_connector *connector,
> +				      struct drm_encoder *encoder)
> +{
> +	return drm_connector_attach_encoder(&connector->base, encoder);
> +}

[Severity: Medium]
Does vkms_connector_hot_attach_encoder() trigger a WARN_ON and fail with
-EINVAL whenever the connector has an active modeset?

drm_connector_attach_encoder() starts with:

drivers/gpu/drm/drm_connector.c:drm_connector_attach_encoder() {
	if (WARN_ON(connector->encoder))
		return -EINVAL;

	connector->possible_encoders |=3D drm_encoder_mask(encoder);

	return 0;
}

When a modeset is active on the connector (for instance via the in-kernel
fbdev client), drm_atomic_helper_update_legacy_modeset_state() sets
connector->encoder =3D new_conn_state->best_encoder, so hot-attaching
another encoder at runtime hits WARN_ON(connector->encoder) and fails.

> +
> +int vkms_connector_hot_detach_encoder(struct vkms_connector *connector,
> +				      struct drm_encoder *encoder)
> +{
> +	return drm_connector_detach_encoder(&connector->base, encoder);
> +}

[Severity: Medium]
Can mutating connector->base.possible_encoders on a registered connector
race with drm_mode_getconnector() and write past the userspace encoder
buffer?

drm_mode_getconnector() computes encoders_count from
connector->possible_encoders without any lock, checks that the userspace
buffer has space for encoders_count entries, and then re-reads
connector->possible_encoders in drm_connector_for_each_possible_encoder():

CPU0                                  CPU1
drm_mode_getconnector()
  encoders_count =3D hweight32(
    connector->possible_encoders)
  if (out_resp->count_encoders >=3D
      encoders_count)
                                      vkms_connector_hot_attach_encoder()
                                        connector->possible_encoders |=3D .=
..
    drm_connector_for_each_possible_encoder()
      put_user(..., encoder_ptr + copied)  <-- writes past count_encoders

> diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vk=
ms_output.c
> index fb30cffc10ef8..b100ed0c91e6b 100644
> --- a/drivers/gpu/drm/vkms/vkms_output.c
> +++ b/drivers/gpu/drm/vkms/vkms_output.c
> @@ -115,5 +115,18 @@ int vkms_output_init(struct vkms_device *vkmsdev)
>  		}
>  	}
> =20
> -	return drm_mode_config_create_initial_state(dev);
> +	ret =3D drm_mode_config_create_initial_state(dev);
> +	if (ret)
> +		return ret;
> +
> +	vkms_config_for_each_connector_dynamic(vkmsdev->config, connector_cfg) {

[Severity: Medium]
Doesn't vkms_config_for_each_connector_dynamic() trigger an RCU lockdep
warning here and race with concurrent configfs removals?

vkms_config_for_each_connector_dynamic() expands to
list_for_each_entry_rcu() with the lockdep condition
lockdep_is_held(&config->lock) || !config->dev.  In device_enabled_store(),
config->lock is dropped before vkms_create() sets config->dev =3D vkms_devi=
ce
and calls vkms_output_init(), so neither config->lock nor rcu_read_lock()
is held during this loop, and vkms_connector_hot_add() sleeps while
iterating connector_cfg->possible_encoders.  While config->lock is not
held, connector_release() and connector_possible_encoders_drop_link() can
concurrently unlink connector_cfg or erase entries from
connector_cfg->possible_encoders.

> +		if (connector_cfg->enabled) {
> +			connector_cfg->connector =3D vkms_connector_hot_add(vkmsdev, connecto=
r_cfg);
> +
> +			if (IS_ERR(connector_cfg->connector))
> +				return PTR_ERR(connector_cfg->connector);
> +		}
> +	}

[Severity: High]
Can connector_cfg->connector be left holding an ERR_PTR or a dangling
pointer that connector_possible_encoders_drop_link() later dereferences?

If vkms_connector_hot_add() fails here, connector_cfg->connector retains a
non-NULL ERR_PTR value.  Likewise, when a device is torn down via
vkms_destroy(), drm_mode_config_cleanup() destroys dynamic connectors via
vkms_connector_dynamic_destroy() without clearing
vkms_connector->cfg->connector (and if connector_cfg->enabled is later set
to false before re-enabling the device, this loop skips it and leaves the
old pointer intact).

Because connector_possible_encoders_drop_link() only tests
connector->config->connector for non-NULL before calling
vkms_connector_hot_detach_encoder(connector->config->connector,
encoder->config->encoder), unlinking an encoder in configfs can
dereference an ERR_PTR or freed vkms_connector.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-vkms-all-c=
onfig-v7-0-21194cda2468@bootlin.com?part=3D40
