Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4734606A321
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oBqE2Nuu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 433BE11238E;
	Thu, 26 Nov 2026 11:49:11 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA22E112382
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:49:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9385140D75;
 Thu, 26 Nov 2026 11:49:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5726E1F000D0;
 Thu, 26 Nov 2026 11:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795693744;
 bh=Ne0wlh4hQKWwhxijn1uq14c1jU4TvA7Xtl+QoeDdTMY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oBqE2Nuu6Lwl/P/zW1Lx5kCLQ9OsQuGC4vnpWcAhqV/pYqYuKP7ZIk/XWbzm7RruW
 Li3mi6pwKIgmBxBGT+t2GpfFvHvNZYhYaUB6shed0gzfXmGC2T317MtNc7rgSK0/r2
 +CChkEqHexPk6v2voYiIJtrN6DsTJb8QtQlT7zZua4OdIR7IKai2Lkr3MegmwBQhwm
 f8+cskHayk+lADNonNLLs3AtDKt1Vp5cM1Mjh5fqzCnDcbhc0+8KI6xWfYPymEseqs
 lr4lAQq6ZR+TgDCrtHW9R+Bt5fOx5lD5BsSPuwVsJDbewV2Y4q+8xW8WNuxcb4IBfj
 5u69toqCicaeA==
Message-ID: <sashiko-outbox-235424@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 11/43] drm/vkms: Reference-count vkms_config and
 vkms_config_connector
To: "Louis Chauvet" <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261126-vkms-all-config-v7-11-21194cda2468@bootlin.com>
References: <20261126-vkms-all-config-v7-0-21194cda2468@bootlin.com>
 <20261126-vkms-all-config-v7-11-21194cda2468@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 11:49:03 +0000
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
- [High] drm/vkms: premature config put in vkms_create() due to __free()
- [High] drm/vkms: use-after-free in vkms_config_connector_release() on
  config drain
- [Low] drm/vkms: duplicate linux/list.h include in vkms_config.h
--

commit 58266f4f95b4eb422dfae060ca602a9c586df7ee
Author: Louis Chauvet <louis.chauvet@bootlin.com>

drm/vkms: Reference-count vkms_config and vkms_config_connector

This commit adds reference counting to struct vkms_config and struct
vkms_config_connector so configurations and connectors stay alive while
referenced outside configfs.

> diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vk=
ms_config.c
> index 6699ddae71260..8cd4fe6551fb8 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.c
> +++ b/drivers/gpu/drm/vkms/vkms_config.c
[ ... ]
> @@ -128,12 +133,31 @@ void vkms_config_destroy(struct vkms_config *config)
>  	list_for_each_entry_safe(encoder_cfg, encoder_tmp, &config->encoders, l=
ink)
>  		vkms_config_destroy_encoder(config, encoder_cfg);
> =20
> -	list_for_each_entry_safe(connector_cfg, connector_tmp, &config->connect=
ors, link)
> -		vkms_config_destroy_connector(connector_cfg);
> +	list_for_each_entry_safe(connector_cfg, connector_tmp, &config->connect=
ors, link) {
> +		/* The config is dying: drop the list's reference on each connector */
> +		vkms_config_connector_put(connector_cfg);
> +	}
> =20
>  	mutex_destroy(&config->lock);
>  	kfree_const(config->dev_name);
> -	kfree(config);
> +	kfree_rcu(config, rcu);
> +}
[ ... ]
> @@ -618,12 +644,48 @@ struct vkms_config_connector *vkms_config_create_co=
nnector(struct vkms_config *c
>  }
>  EXPORT_SYMBOL_IF_KUNIT(vkms_config_create_connector);
> =20
> -void vkms_config_destroy_connector(struct vkms_config_connector *connect=
or_cfg)
> +static void vkms_config_connector_release(struct kref *ref)
>  {
> +	struct vkms_config_connector *connector_cfg =3D
> +		container_of(ref, struct vkms_config_connector, refcnt);
>  	xa_destroy(&connector_cfg->possible_encoders);
> -	list_del_rcu(&connector_cfg->link);
> +	if (connector_cfg->unlinked) {
> +		/* Detached by vkms_config_destroy_connector(): drop its config pin */
> +		vkms_config_put(connector_cfg->config);
> +	} else {
> +		/* The config is dying and is draining us: just unlink */
> +		list_del_init(&connector_cfg->link);
> +	}
>  	kfree_rcu(connector_cfg, rcu);
>  }

[Severity: High]
Can vkms_config_connector_release() trigger a use-after-free on
config->connectors when a connector outlives its config without going
through vkms_config_destroy_connector()?

vkms_config_connector_get() increments connector_cfg->refcnt without
pinning connector_cfg->config.  If config is released while a connector
still linked in config->connectors holds an extra reference,
vkms_config_release() drops the list reference and frees config via
kfree_rcu() while connector_cfg->link stays attached to config->connectors
with connector_cfg->unlinked set to false.  When the final reference on
connector_cfg is later dropped, vkms_config_connector_release() runs
list_del_init(&connector_cfg->link) and writes into the freed
config->connectors list head.

> diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vk=
ms_config.h
> index 125273f67e7d7..95e5c3694742f 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.h
> +++ b/drivers/gpu/drm/vkms/vkms_config.h
> @@ -3,9 +3,14 @@
>  #ifndef _VKMS_CONFIG_H_
>  #define _VKMS_CONFIG_H_
> =20
> +#include <linux/cleanup.h>
> +#include <linux/kref.h>
>  #include <linux/list.h>
>  #include <linux/rculist.h>
>  #include <linux/mutex.h>
> +#include <linux/rcupdate.h>
> +#include <linux/string.h>
> +#include <linux/list.h>

[Severity: Low]
linux/list.h is included twice here.

> diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_=
drv.c
> index 4cbb1173fcc62..24572bc779b41 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.c
> +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> @@ -163,6 +163,10 @@ int vkms_create(struct vkms_config *config)
>  	struct faux_device *fdev;
>  	struct vkms_device *vkms_device;
>  	const char *dev_name;
> +	/* The device keeps the config alive for its whole lifetime */
> +	struct vkms_config *cfg __free(vkms_config_put) =3D config;
> +
> +	vkms_config_get(cfg);

[Severity: High]
Does __free(vkms_config_put) drop the device's reference on cfg as soon as
vkms_create() returns?

Because cfg is never passed to no_free_ptr() on the success path (and
vkms_destroy() does not call vkms_config_put()), the cleanup handler runs
when vkms_create() exits scope.  That leaves vkms_device->config without a
device-owned reference, so freeing the configuration while the DRM device
is still active causes a use-after-free when DRM or debugfs paths access
vkms_device->config.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-vkms-all-c=
onfig-v7-0-21194cda2468@bootlin.com?part=3D11
