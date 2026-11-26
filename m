Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8E5606A321
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KSyAP4Sj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AD5711238A;
	Thu, 26 Nov 2026 11:50:22 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A093111238A
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:50:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 871A5424AC;
 Thu, 26 Nov 2026 11:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA8F41F000C4;
 Thu, 26 Nov 2026 11:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795693815;
 bh=ycgPUSf/sYu55gj+vuuG9fVcUjtl6OmWsR3zNKKc25Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KSyAP4Sj0ZYCb/m4ISEvjEfrcMmOcIdHsNdL2V7fFWjddCSTUHitkQM0QLxZ2/5w+
 v0rCG0F18kqX/DvoJwtT4e6kWVP3sJkSQVJwgL6gPlSUMBZThTjR7O5mDqgERgXtjg
 hByYlat2IYUn6/SaU+yv1O6071ZQb++jFjRn23hVD/k+mGCNkfRjOp9+9MMuSHZguU
 nEov6YZG0oj/IT0P7y48RHKnZuZQ1PQJX62riJGzw2G+THONINRvOU+3DlkkhlyIeo
 lJZMGktqtrVDBigODfn3upsOvv2/yoTIBGGYj5I+3qSIh542H0n4ZcILfWYQvK0Ksu
 WXPgE0UJVpb+w==
Message-ID: <sashiko-outbox-235426@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 01/43] drm/vkms: Lock the config dump against
 concurrent configfs changes
To: "Louis Chauvet" <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261126-vkms-all-config-v7-1-21194cda2468@bootlin.com>
References: <20261126-vkms-all-config-v7-0-21194cda2468@bootlin.com>
 <20261126-vkms-all-config-v7-1-21194cda2468@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 11:50:15 +0000
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
- [High] drm/vkms: const discarded locking config->lock in
  vkms_connector_detect()
- [High] drm/vkms: self-deadlock on config->lock in
  connector_status_store()
- [Medium] drm/vkms: unlocked RCU list walk and UAF in
  vkms_connector_detect()
- [Medium] drm/vkms: races from dropping config->lock in
  device_enabled_store()
- [Medium] drm/vkms: RCU lockdep warning in vkms_config_for_each_*
  during vkms_create()
- [Low] drm/vkms: commit message and vkms_config_show() comment mismatch
  with code
--

commit e3fcd80e0d55e7be8d3c20f129777ead0dbe15ab
Author: Louis Chauvet <louis.chauvet@bootlin.com>

drm/vkms: Lock the config dump against concurrent configfs changes

This commit moves the configuration lock into struct vkms_config, converts
the configuration lists to RCU-protected lists, and updates configfs,
debugfs, and connector detection to synchronize configuration access.

> diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vk=
ms_config.c
> index f9e30a4e5a3f8..6699ddae71260 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.c
> +++ b/drivers/gpu/drm/vkms/vkms_config.c
[ ... ]
> @@ -348,28 +350,38 @@ static int vkms_config_show(struct seq_file *m, voi=
d *data)
>  	struct vkms_config_encoder *encoder_cfg;
>  	struct vkms_config_connector *connector_cfg;
> =20
> -	dev_name =3D vkms_config_get_device_name((struct vkms_config *)vkmsdev-=
>config);
> -	seq_printf(m, "dev_name=3D%s\n", dev_name);
> -
> -	vkms_config_for_each_plane(vkmsdev->config, plane_cfg) {
> -		seq_puts(m, "plane:\n");
> -		seq_printf(m, "\ttype=3D%d\n",
> -			   vkms_config_plane_get_type(plane_cfg));
> -	}
> +	/*
> +	 * The configuration lists are mutated by the configfs under the
> +	 * configuration lock. Walk them under RCU instead: mutations use
> +	 * list_{add,del}_rcu and free the objects after a grace period,
> +	 * so this reader holds no lock and cannot block the configfs
> +	 * paths (the disable path removes this file while holding the
> +	 * lock, and the debugfs removal waits for this reader to drain).
> +	 */
> +	scoped_guard(rcu) {

[Severity: Low]
This isn't a bug, but both the commit message and this comment appear out of
sync with the code.  The commit message says "Move the configuration lock
into struct vkms_config and run the dump under it", whereas
vkms_config_show() uses scoped_guard(rcu).  In addition, this comment says
the disable path removes the debugfs file while holding the lock, but
device_enabled_store() drops dev->config->lock before calling vkms_destroy(=
).

> diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vk=
ms_config.h
> index 56805b0c9b145..125273f67e7d7 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.h
> +++ b/drivers/gpu/drm/vkms/vkms_config.h
[ ... ]
> @@ -126,7 +139,9 @@ struct vkms_config_connector {
>   * @plane_cfg: &struct vkms_config_plane pointer used as cursor
>   */
>  #define vkms_config_for_each_plane(config, plane_cfg) \
> -	list_for_each_entry((plane_cfg), &(config)->planes, link)
> +	list_for_each_entry_rcu((plane_cfg), &(config)->planes, link, \
> +				      lockdep_is_held(&(config)->lock) || \
> +				      !(config)->dev)

[Severity: Medium]
Does this lockdep condition trigger an RCU_LOCKDEP_WARN splat during
vkms_create() when CONFIG_PROVE_RCU_LIST=3Dy is enabled?

In vkms_create(), config->dev is assigned before calling vkms_modeset_init(=
):

drivers/gpu/drm/vkms/vkms_drv.c:vkms_create() {
	...
	vkms_device->faux_dev =3D fdev;
	vkms_device->config =3D config;
	config->dev =3D vkms_device;
	...
	ret =3D vkms_modeset_init(vkms_device);
}

Neither vkms_init() nor device_enabled_store() holds config->lock or
rcu_read_lock() across vkms_create(), so config->dev is non-NULL when
vkms_modeset_init() -> vkms_output_init() and vkms_config_is_valid() iterate
the configuration lists with vkms_config_for_each_{plane,crtc,encoder,conne=
ctor}().

> diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/=
vkms_configfs.c
> index af097967ca6fc..6bb24f5835db1 100644
> --- a/drivers/gpu/drm/vkms/vkms_configfs.c
> +++ b/drivers/gpu/drm/vkms/vkms_configfs.c
[ ... ]
> @@ -548,7 +546,7 @@ static ssize_t connector_status_store(struct config_i=
tem *item,
>  	    status !=3D connector_status_unknown)
>  		return -EINVAL;
> =20
> -	scoped_guard(mutex, &connector->dev->lock) {
> +	scoped_guard(mutex, &connector->dev->config->lock) {
>  		vkms_config_connector_set_status(connector->config, status);
> =20
>  		if (connector->dev->enabled)
>  			vkms_trigger_connector_hotplug(connector->dev->config->dev);
>  	}

[Severity: High]
Does calling vkms_trigger_connector_hotplug() while holding
connector->dev->config->lock self-deadlock on config->lock when a connector=
's
configfs status is written on an enabled device?

connector_status_store()
  mutex_lock(&connector->dev->config->lock)
  vkms_trigger_connector_hotplug()
    drm_kms_helper_hotplug_event()
      ...
        drm_helper_probe_single_connector_modes()
          vkms_connector_detect()
            mutex_lock(&vkmsdev->config->lock)  <-- deadlocks

This also inverts the lock order against normal DRM connector probing (such
as drm_mode_getconnector()), which acquires dev->mode_config.mutex before
calling vkms_connector_detect() -> mutex_lock(&vkmsdev->config->lock).

[ ... ]

> @@ -711,21 +709,34 @@ static ssize_t device_enabled_store(struct config_i=
tem *item, const char *page,
>  	if (kstrtobool(page, &enabled))
>  		return -EINVAL;
> =20
> -	scoped_guard(mutex, &dev->lock) {
> -		if (!dev->enabled && enabled) {
> -			if (!vkms_config_is_valid(dev->config))
> -				return -EINVAL;
> +	scoped_guard(mutex, &dev->config->lock) {
> +		if (dev->enabled =3D=3D enabled)
> +			return (ssize_t)count;
> =20
> -			ret =3D vkms_create(dev->config);
> -			if (ret)
> -				return ret;
> -		} else if (dev->enabled && !enabled) {
> -			vkms_destroy(dev->config);
> -		}
> +		if (!dev->enabled && !vkms_config_is_valid(dev->config))
> +			return -EINVAL;
> =20
>  		dev->enabled =3D enabled;
>  	}
> =20
> +	/*
> +	 * Do not hold config->lock while creating/destroying the device:
> +	 * vkms_destroy() unregisters the DRM device, which removes the
> +	 * vkms_config debugfs file and waits for its readers to drain, and
> +	 * vkms_connector_detect() takes config->lock to read the connector
> +	 * status.
> +	 */
> +	if (enabled) {
> +		ret =3D vkms_create(dev->config);
> +		if (ret) {
> +			scoped_guard(mutex, &dev->config->lock)
> +				dev->enabled =3D false;
> +			return ret;
> +		}
> +	} else {
> +		vkms_destroy(dev->config);
> +	}

[Severity: Medium]
Can dropping dev->config->lock after setting dev->enabled leave vkms_create=
()
and vkms_destroy() open to concurrent configfs operations?

CPU0                              CPU1
device_enabled_store(1)
  mutex_lock(&config->lock)
  dev->enabled =3D true
  mutex_unlock(&config->lock)
                                  connector_status_store()
                                    mutex_lock(&config->lock)
                                    if (connector->dev->enabled)
                                      vkms_trigger_connector_hotplug(
                                        config->dev)
                                        <-- NULL pointer dereference
  vkms_create(dev->config)
    config->dev =3D vkms_device

Because config->lock is released before vkms_create() or vkms_destroy() run=
s:
- a second write to enabled on another file descriptor can run vkms_destroy=
()
  concurrently with vkms_create() (or mutate the configuration after
  dev->enabled is cleared to false while vkms_destroy() is still running);
- configfs unlink (*_drop_link) and rmdir (*_release) callbacks do not check
  dev->enabled, so they can acquire config->lock after vkms_config_is_valid=
()
  returns and detach or free planes, CRTCs, encoders, or connectors while
  vkms_create() -> vkms_output_init() is initializing the device.

> diff --git a/drivers/gpu/drm/vkms/vkms_connector.c b/drivers/gpu/drm/vkms=
/vkms_connector.c
> index 57138027966f5..080a0240d5e92 100644
> --- a/drivers/gpu/drm/vkms/vkms_connector.c
> +++ b/drivers/gpu/drm/vkms/vkms_connector.c
> @@ -27,8 +27,10 @@ static enum drm_connector_status vkms_connector_detect=
(struct drm_connector *con
>  	status =3D connector->status;
> =20
>  	vkms_config_for_each_connector(vkmsdev->config, connector_cfg) {
> -		if (connector_cfg->connector =3D=3D vkms_connector)
> -			status =3D vkms_config_connector_get_status(connector_cfg);
> +		if (connector_cfg->connector =3D=3D vkms_connector) {
> +			scoped_guard(mutex, &vkmsdev->config->lock)
> +				status =3D vkms_config_connector_get_status(connector_cfg);
> +		}
>  	}

[Severity: High]
Does passing &vkmsdev->config->lock to scoped_guard(mutex, ...) fail to bui=
ld
under CONFIG_WERROR=3Dy?  In struct vkms_device, config is declared as
const struct vkms_config *, so &vkmsdev->config->lock discards the const
qualifier (-Werror=3Ddiscarded-qualifiers).  This is rewritten in a later p=
atch
in the series, commit "drm/vkms: Introduce back pointer to connector", but
breaks bisection at this commit.

[Severity: Medium]
Can walking vkmsdev->config->connectors here without rcu_read_lock() or
holding config->lock across the loop trigger an RCU lockdep warning and race
with connector_release()?

CPU0                              CPU1
vkms_connector_detect()
  vkms_config_for_each_connector()
    if (connector_cfg->connector =3D=3D ...)
                                  connector_release()
                                    mutex_lock(&config->lock)
                                    vkms_config_destroy_connector()
                                      list_del_rcu(&connector_cfg->link)
                                      kfree_rcu(connector_cfg, rcu)
                                    mutex_unlock(&config->lock)
                                  /* RCU grace period elapses */
      mutex_lock(&config->lock)
      vkms_config_connector_get_status(
        connector_cfg)            <-- use-after-free

Because vkmsdev->config->dev is non-NULL and neither rcu_read_lock() nor
config->lock is held across vkms_config_for_each_connector(), every call to
vkms_connector_detect() triggers RCU_LOCKDEP_WARN under
CONFIG_PROVE_RCU_LIST=3Dy, and connector_cfg can be freed while CPU0 is
preempted or blocked on config->lock.  Later patches in the series (commit
"drm/vkms: Reference-count vkms_config and vkms_config_connector" and commit
"drm/vkms: Introduce back pointer to connector") replace this traversal with
a reference-counted back-pointer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-vkms-all-c=
onfig-v7-0-21194cda2468@bootlin.com?part=3D1
