Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E69606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LxfcvSyC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77F36112397;
	Thu, 26 Nov 2026 11:59:36 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99C4A112397
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:59:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BBCC16288D;
 Thu, 26 Nov 2026 11:59:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FDA11F000D0;
 Thu, 26 Nov 2026 11:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795694368;
 bh=c82cRepRR2bwQgyCyyOuq+B/VvmiJgvMfdt10Oo7pik=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LxfcvSyCALhRWsMZF3YbBEm3NQI/KC9dmuL1wjUs33onUDXHM0s6GllbJ7on5n/In
 hjMbnRpshjlrded7T6uNyGLGkapx/P+V6VHzJ9lLSAQXyXGfkdSUa8C4b7xngCj3LL
 zcPgkD3O52D9/zzhUbJhL8TvYGH1JnZka7gJmnFF9ysLGkfExwlfgFWtmGKlOylgIY
 XaMHEOKMyaQTCsGt7uaCntZlilWruRlhJbPSsLYfjE+7D5x127HeTekFFy1nqYdrE7
 ZN9njv/Y3GDFl7LkEKdtX6D8LGybsbptHLFSbmWnfZraKl2i2uFui69KuyFNYqRtGZ
 ZGfJjMN63qPTQ==
Message-ID: <sashiko-outbox-235457@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 37/43] drm/vkms: Introduce configfs for connector EDID
To: "Louis Chauvet" <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261126-vkms-all-config-v7-37-21194cda2468@bootlin.com>
References: <20261126-vkms-all-config-v7-0-21194cda2468@bootlin.com>
 <20261126-vkms-all-config-v7-37-21194cda2468@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 11:59:27 +0000
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
- [High] drm/vkms: self-deadlock on config->lock in connector EDID store
  callbacks
- [High] drm/vkms: sleeping allocations under rcu_read_lock() in
  vkms_conn_get_modes()
- [Medium] drm/vkms: race with device_enabled_store() passes NULL dev on
  EDID store
- [Medium] drm/vkms: CONFIGFS_ATTR for connector edid truncates 4K EDID
  and blocks clear
--

commit 08c0713c865d891af6ca094b53a173337d1d80d5
Author: Louis Chauvet <louis.chauvet@bootlin.com>

drm/vkms: Introduce configfs for connector EDID

This commit adds the edid_enabled and edid configfs attributes to configure
connector EDID data and trigger a connector hotplug when updated.

> diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/=
vkms_configfs.c
> index 7377d967be75d..32ac4d7c41944 100644
> --- a/drivers/gpu/drm/vkms/vkms_configfs.c
> +++ b/drivers/gpu/drm/vkms/vkms_configfs.c
[ ... ]
> @@ -1191,14 +1192,111 @@ static ssize_t connector_supported_colorspaces_s=
tore(struct config_item *item,
>  	return count;
>  }
> =20
> +static ssize_t connector_edid_enabled_show(struct config_item *item, cha=
r *page)
> +{
> +	struct vkms_configfs_connector *connector;
> +	bool enabled;
> +
> +	connector =3D connector_item_to_vkms_configfs_connector(item);
> +
> +	scoped_guard(mutex, &connector->dev->config->lock)
> +		enabled =3D vkms_config_connector_get_edid_enabled(connector->config);
> +
> +	return sprintf(page, "%d\n", enabled);
> +}
> +
> +static ssize_t connector_edid_enabled_store(struct config_item *item,
> +					    const char *page, size_t count)
> +{
> +	struct vkms_configfs_connector *connector;
> +	struct vkms_config_connector *connector_cfg;
> +	bool enabled;
> +
> +	connector =3D connector_item_to_vkms_configfs_connector(item);
> +	connector_cfg =3D connector->config;
> +
> +	if (kstrtobool(page, &enabled))
> +		return -EINVAL;
> +
> +	scoped_guard(mutex, &connector->dev->config->lock)
> +	{
> +		vkms_config_connector_set_edid_enabled(connector_cfg, enabled);
> +
> +		if (connector->dev->enabled &&
> +		    vkms_config_connector_get_status(connector_cfg) !=3D
> +		    connector_status_disconnected)
> +			vkms_trigger_connector_hotplug(connector->dev->config->dev);
> +	}

[Severity: High]
Does calling vkms_trigger_connector_hotplug() under
connector->dev->config->lock self-deadlock on config->lock (both here and in
connector_edid_store() below)?

vkms_create() registers in-kernel DRM clients with drm_client_setup(), so
hotplug notification probes the connector synchronously on the same task:

connector_edid_enabled_store()
  mutex_lock(&connector->dev->config->lock)
  vkms_trigger_connector_hotplug()
    drm_kms_helper_hotplug_event()
      drm_client_dev_hotplug()
        ...
          drm_client_modeset_probe()
            drm_helper_probe_single_connector_modes()
              drm_helper_probe_detect()
                vkms_connector_detect()
                  mutex_lock(&cfg->config->lock)  <-- deadlocks

This also inverts the mode_config.mutex -> mode_config.connection_mutex ->
config->lock hierarchy used during normal connector probing. Dropping
config->lock before calling vkms_trigger_connector_hotplug() avoids the
deadlock.

[Severity: Medium]
Can connector->dev->config->dev still be NULL or unregistered when
connector->dev->enabled is true here and in connector_edid_store()?

device_enabled_store() sets dev->enabled =3D true and releases
dev->config->lock before calling vkms_create(dev->config):

CPU0                                  CPU1
device_enabled_store()
  mutex_lock(&dev->config->lock)
  dev->enabled =3D true
  mutex_unlock(&dev->config->lock)
                                      connector_edid_enabled_store()
                                        mutex_lock(&dev->config->lock)
                                        if (connector->dev->enabled && ...)
                                          vkms_trigger_connector_hotplug(NU=
LL)
                                            drm_kms_helper_hotplug_event()
                                              <-- NULL pointer dereference
  vkms_create(dev->config)

[Severity: High]
When connector_edid_enabled_store() sets edid_enabled to true and triggers
mode probing, does vkms_conn_get_modes() sleep inside an RCU read-side
critical section?

connector_edid_enabled_store() is the first caller of
vkms_config_connector_set_edid_enabled(), activating the edid_enabled branch
in vkms_conn_get_modes():

drivers/gpu/drm/vkms/vkms_connector.c:vkms_conn_get_modes() {
	if (vkms_config_connector_get_edid_enabled(cfg)) {
		/*
		 * Hold rcu_read_lock() for the entire duration so that
		 * the EDID data accessed via the callback remains valid.
		 */
		rcu_read_lock();
		drm_edid =3D drm_edid_read_custom(connector,
						vkms_connector_read_block, cfg);

		drm_edid_connector_update(connector, drm_edid);

		count =3D drm_edid_connector_add_modes(connector);

		drm_edid_free(drm_edid);
		rcu_read_unlock();
	}
}

drm_edid_read_custom(), drm_edid_connector_update(), and
drm_edid_connector_add_modes() all perform GFP_KERNEL allocations and acqui=
re
sleeping mutexes (such as connector->edid_override_mutex,
connector->eld_mutex, and dev->mode_config.blob_lock). Taking rcu_read_lock=
()
only inside vkms_connector_read_block() while dereferencing and copying the
EDID block would avoid sleeping under RCU.

> +	return count;
> +}
> +
> +static ssize_t connector_edid_show(struct config_item *item, char *page)
> +{
> +	struct vkms_configfs_connector *connector;
> +	ssize_t ret =3D 0;
> +
> +	connector =3D connector_item_to_vkms_configfs_connector(item);
> +
> +	scoped_guard(mutex, &connector->dev->config->lock)
> +	{
> +		int len =3D 0;
> +		const u8 *edid;
> +		size_t copy_len;
> +
> +		/*
> +		 * vkms_config_connector_get_edid() is an RCU reader; hold
> +		 * the read-side critical section while copying the data to
> +		 * the userspace page, like the debugfs reader does.
> +		 */
> +		rcu_read_lock();
> +		edid =3D vkms_config_connector_get_edid(connector->config, &len);
> +		if (edid && len > 0) {
> +			copy_len =3D min_t(size_t, (size_t)len, PAGE_SIZE);
> +			memcpy(page, edid, copy_len);
> +			ret =3D copy_len;
> +		}
> +		rcu_read_unlock();
> +	}
> +
> +	return ret;
> +}
> +
> +static ssize_t connector_edid_store(struct config_item *item,
> +				    const char *page, size_t count)
> +{
> +	struct vkms_configfs_connector *connector;
> +
> +	connector =3D connector_item_to_vkms_configfs_connector(item);
> +
> +	scoped_guard(mutex, &connector->dev->config->lock)
> +	{
> +		int ret;
> +
> +		ret =3D vkms_config_connector_set_edid(connector->config, page, count);
> +		if (ret)
> +			return ret;
> +
> +		if (connector->dev->enabled &&
> +		    vkms_config_connector_get_status(connector->config) !=3D
> +		    connector_status_disconnected)
> +			vkms_trigger_connector_hotplug(connector->dev->config->dev);
> +	}
> +
> +	return count;
> +}
> +
>  CONFIGFS_ATTR(connector_, status);
>  CONFIGFS_ATTR(connector_, type);
>  CONFIGFS_ATTR(connector_, supported_colorspaces);
> +CONFIGFS_ATTR(connector_, edid_enabled);
> +CONFIGFS_ATTR(connector_, edid);

[Severity: Medium]
Should edid be registered with CONFIGFS_BIN_ATTR() instead of
CONFIGFS_ATTR()?

Because CONFIGFS_ATTR() uses configfs text attribute handling
(SIMPLE_ATTR_SIZE =3D=3D 4096):

1. fill_write_buffer() accepts at most SIMPLE_ATTR_SIZE - 1 (4095) bytes so
   it can append a trailing NUL. Writing a 4096-byte (32-block) EDID trunca=
tes
   the last checksum byte on the first write, and if userspace writes the
   remaining 1 byte in a second write() call, connector_edid_store() replac=
es
   the entire EDID with a 1-byte buffer.

2. The ABI documentation says writing zero bytes clears the EDID, and
   vkms_config_connector_set_edid() checks for !len, but vfs_write() and
   configfs_write_iter() never invoke .store() when count =3D=3D 0, nor on
   O_TRUNC, making the !len clear path unreachable.

3. In connector_edid_show(), copy_len is clamped to PAGE_SIZE rather than
   SIMPLE_ATTR_SIZE (4096), which triggers WARN_ON_ONCE(count >
   SIMPLE_ATTR_SIZE) and returns -EIO in fill_read_buffer() on architectures
   with PAGE_SIZE > 4096.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-vkms-all-c=
onfig-v7-0-21194cda2468@bootlin.com?part=3D37
