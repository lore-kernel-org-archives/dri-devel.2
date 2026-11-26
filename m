Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880E5606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gjfMgT9J
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7B0310E98C;
	Thu, 26 Nov 2026 11:55:15 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 580E910E98C
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:55:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 65C1A62372;
 Thu, 26 Nov 2026 11:55:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9A01F000C0;
 Thu, 26 Nov 2026 11:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795694108;
 bh=zRUQqDI7ks1uag0JAh4pXS+NxKy2mQlWu4M0QQ5Bdj8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gjfMgT9JlfxpfHYaX49Uob/AtAgBWPuVyXaLrUi66yJlah66/ipOF0w1kfihlqdnx
 GpvKisghVJdyLgoxACwm5Lm0lCY9rY0RCzelQ5eJWycYUJNZdODik2KBGWs5kGUD5S
 oJMyyzZYbwaL5lZHF0SApUD3wd47FhmqWPr9V4GlwX5FKHL9dCOS+r1djTVsq400WN
 fLx/HF4F0E6WOfZdqZydDgLCpy3H2hYdrxR6Cm7UTUGluAAZIeKZo5uLKOVT+yQG1n
 +xs2zq4EBCGit5dfn+kOj+xP9tXU1nK6rjvfFY9ffffvIfd3qsy8L8bZlLlnjeHJ4K
 mvaJgAsBPAyUQ==
Message-ID: <sashiko-outbox-235436@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 30/43] drm/vkms: Introduce back pointer to connector
To: "Louis Chauvet" <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261126-vkms-all-config-v7-30-21194cda2468@bootlin.com>
References: <20261126-vkms-all-config-v7-0-21194cda2468@bootlin.com>
 <20261126-vkms-all-config-v7-30-21194cda2468@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 11:55:07 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] drm/vkms: use-after-free of vkms_config via drmm ref in
  vkms_connector_init()
- [High] drm/vkms: deadlock on config->lock in vkms_connector_detect()
  on hotplug
--

commit 7fc6833db3a67c967212a1eb72d07220a1c7dbd2
Author: Louis Chauvet <louis.chauvet@bootlin.com>

drm/vkms: Introduce back pointer to connector

This commit stores a reference-counted pointer to vkms_config_connector in
vkms_connector, released via a drmm action on device cleanup, and uses it
in vkms_connector_detect() instead of iterating the configuration list.

> diff --git a/drivers/gpu/drm/vkms/vkms_connector.c b/drivers/gpu/drm/vkms=
/vkms_connector.c
> index 080a0240d5e92..bb023b5af4e43 100644
> --- a/drivers/gpu/drm/vkms/vkms_connector.c
> +++ b/drivers/gpu/drm/vkms/vkms_connector.c
> @@ -11,11 +11,9 @@
>  static enum drm_connector_status vkms_connector_detect(struct drm_connec=
tor *connector,
>  						       bool force)
>  {
> -	struct drm_device *dev =3D connector->dev;
> -	struct vkms_device *vkmsdev =3D drm_device_to_vkms_device(dev);
>  	struct vkms_connector *vkms_connector;
> +	struct vkms_config_connector *cfg;
>  	enum drm_connector_status status;
> -	struct vkms_config_connector *connector_cfg;
> =20
>  	vkms_connector =3D drm_connector_to_vkms_connector(connector);
> =20
> @@ -26,11 +24,12 @@ static enum drm_connector_status vkms_connector_detec=
t(struct drm_connector *con
>  	 */
>  	status =3D connector->status;
> =20
> -	vkms_config_for_each_connector(vkmsdev->config, connector_cfg) {
> -		if (connector_cfg->connector =3D=3D vkms_connector) {
> -			scoped_guard(mutex, &vkmsdev->config->lock)
> -				status =3D vkms_config_connector_get_status(connector_cfg);
> -		}
> +	cfg =3D vkms_connector->cfg;
> +	if (cfg) {
> +		cfg =3D vkms_config_connector_get(cfg);
> +		scoped_guard(mutex, &cfg->config->lock)
> +			status =3D vkms_config_connector_get_status(cfg);
> +		vkms_config_connector_put(cfg);
>  	}

[Severity: High]
Does locking cfg->config->lock here deadlock when a connector's configfs
status attribute is updated while the device is enabled?

connector_status_store() holds config->lock while calling
vkms_trigger_connector_hotplug(), which synchronously notifies the in-kernel
fbdev client and probes the connector on the same thread:

connector_status_store()
  mutex_lock(&connector->dev->config->lock)
  vkms_trigger_connector_hotplug()
    ...
      drm_client_modeset_probe()
        mutex_lock(&dev->mode_config.mutex)
        ...
          vkms_connector_detect()
            mutex_lock(&cfg->config->lock)  <-- self-deadlock

This also inverts the lock order against normal DRM connector probing (such
as DRM_IOCTL_MODE_GETCONNECTOR), which acquires dev->mode_config.mutex
before vkms_connector_detect() takes cfg->config->lock.

> @@ -70,7 +69,16 @@ static const struct drm_connector_helper_funcs vkms_co=
nn_helper_funcs =3D {
>  	.best_encoder =3D vkms_conn_best_encoder,
>  };
> =20
> -struct vkms_connector *vkms_connector_init(struct vkms_device *vkmsdev)
> +static void vkms_connector_static_cfg_release(struct drm_device *dev, vo=
id *res)
> +{
> +	struct vkms_connector *connector =3D res;
> +
> +	vkms_config_connector_put(connector->cfg);
> +}
> +
> +
> +struct vkms_connector *vkms_connector_init(struct vkms_device *vkmsdev,
> +					   struct vkms_config_connector *connector_cfg)
>  {
>  	struct drm_device *dev =3D &vkmsdev->drm;
>  	struct vkms_connector *connector;
> @@ -87,6 +95,13 @@ struct vkms_connector *vkms_connector_init(struct vkms=
_device *vkmsdev)
> =20
>  	drm_connector_helper_add(&connector->base, &vkms_conn_helper_funcs);
> =20
> +	connector->cfg =3D connector_cfg;
> +	vkms_config_connector_get(connector_cfg);
> +	ret =3D drmm_add_action_or_reset(dev, vkms_connector_static_cfg_release,
> +				       connector);
> +	if (ret)
> +		return ERR_PTR(ret);

[Severity: High]
Can tying connector->cfg to a drmm action cause a use-after-free of
connector_cfg->config if an open DRM file descriptor keeps struct
drm_device alive past vkms_config_destroy()?

vkms_config_connector_get() only increments connector_cfg->refcnt;
connector_cfg does not pin connector_cfg->config unless it was individually
detached via vkms_config_destroy_connector() (which sets
connector_cfg->unlinked =3D true and calls vkms_config_get()).  In addition,
vkms_create() declares cfg with __free(vkms_config_put), so its reference on
config is dropped as soon as vkms_create() returns.

If the device and config are torn down while userspace still holds an open
DRM fd, vkms_config_release() drops the list reference on connector_cfg
(from 2 to 1) without unlinking it and frees config:

drivers/gpu/drm/vkms/vkms_config.c:vkms_config_release() {
    ...
	list_for_each_entry_safe(connector_cfg, connector_tmp, &config->connectors=
, link) {
		/* The config is dying: drop the list's reference on each connector */
		vkms_config_connector_put(connector_cfg);
	}

	mutex_destroy(&config->lock);
	kfree_const(config->dev_name);
	kfree_rcu(config, rcu);
}

After that point, vkms_connector_detect() dereferences freed memory at
&cfg->config->lock.  When the final drm_dev_put() later runs
vkms_connector_static_cfg_release(), vkms_config_connector_release() sees
connector_cfg->unlinked =3D=3D false and executes
list_del_init(&connector_cfg->link), writing to the freed
config->connectors list head.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-vkms-all-c=
onfig-v7-0-21194cda2468@bootlin.com?part=3D30
