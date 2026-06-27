Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A033EC43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:55:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12DA210F78D;
	Sat, 27 Jun 2026 03:55:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="k0+Xd/jK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94C8E10F791
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 03:55:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 70CFB4079D;
 Sat, 27 Jun 2026 03:55:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2AB1F000E9;
 Sat, 27 Jun 2026 03:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782532512;
 bh=KfLqGUXAsXbggAIpa9zMCzbsWFs69IJgtcmlfRLqsjs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=k0+Xd/jKCnlSjerxsCEtNyPDOj52SiQHxRBDx1IAVitNFOpDwWnD8GZbFHFT5DWIx
 /ufUNZMZjgVDcNXDcQrDln4uWfkjuXw5t1elbVCqTnnSI9X/ZpxsXAsbTN7YsG70EK
 woChXWQhIKGFxRR+8YmnHn3ZflEWJ5SNqiVHNSYmzTkAoMIhMBRjgIXXwEiykQTpWe
 rRj/1hxMm352qDk9E846C28fD3mA/y5cqmOImnCZlugk+DzlQqWcQQO4sGxuzYz87B
 WRg+HbDfHvBXXdt+cotK7kpXfsEVtilrEkxLdHzgAdVdOhsK8fqEgn/P5W4PU0ud7h
 dq3UMyzXZ8fvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 36/38] drm/vkms: Introduce configfs for dynamic
 connector creation
To: "Louis Chauvet" <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260627-vkms-all-config-v5-36-854aa0840926@bootlin.com>
References: <20260627-vkms-all-config-v5-0-854aa0840926@bootlin.com>
 <20260627-vkms-all-config-v5-36-854aa0840926@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 03:55:11 +0000
Message-Id: <20260627035512.2D2AB1F000E9@smtp.kernel.org>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 10 potential issue=
(s) to consider:

New issues:
- [Critical] Calling drm_mode_config_reset() dynamically at runtime destroy=
s active atomic states, leading to Use-After-Free.
- [High] Mixing goto-based error handling with scoped_guard causes a data r=
ace on rollback.
- [High] Removing a connector via rmdir bypasses validation checks, leaving=
 the device in an invalid state.
- [High] Uncaught NULL pointer dereference due to incorrect IS_ERR() check =
on memory allocations.
- [High] Using __free(kfree) on a dynamically initialized DRM connector cau=
ses memory leaks and list corruption.
- [High] Dangling pointer in connector_cfg->connector causes state corrupti=
on via aliasing.
- [Medium] Missing rollback when configfs internal allocation fails after h=
ot-attaching an encoder.
- [Medium] Dropping a symlink for an active dynamic connector removes the e=
ncoder from ConfigFS but fails to detach it from the live DRM connector.

Pre-existing issues:
- [High] Userspace can rmdir static connectors while the DRM device is acti=
vated, causing use-after-free.
- [High] Lockless iteration over vkmsdev->config->connectors races with con=
figfs item removal.
--

commit fa75c62308f0301b4607b37a03a00f5ce157f6a0
Author: Louis Chauvet <louis.chauvet@bootlin.com>

drm/vkms: Introduce configfs for dynamic connector creation

This commit adds two configfs attributes to connectors to allow emulating
dynamic connector creation after the device. The dynamic attribute marks a
connector as dynamic, and the enabled attribute can set it as present or not
at runtime.

> diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/=
vkms_configfs.c
> index f79a796c2017f..f92b172e75cf3 100644
> --- a/drivers/gpu/drm/vkms/vkms_configfs.c
> +++ b/drivers/gpu/drm/vkms/vkms_configfs.c
[ ... ]
> @@ -1290,6 +1296,107 @@ static ssize_t connector_edid_store(struct config=
_item *item,
[ ... ]
> +			if (!was_enabled && enabled) {
> +				// Adding the connector
> +				connector_cfg->connector =3D vkms_connector_hot_add(connector->dev->=
config->dev,
> +										  connector_cfg);

[Severity: High]
Is it possible for vkms_connector_hot_add() to return a NULL pointer that g=
ets
missed?

Looking at vkms_connector_hot_add() in drivers/gpu/drm/vkms/vkms_connector.=
c:

drivers/gpu/drm/vkms/vkms_connector.c:vkms_connector_hot_add() {
	...
	connector =3D kzalloc_obj(*connector, GFP_KERNEL);
	if (IS_ERR(connector))
		return connector;
	...
}

kzalloc_obj() returns NULL on failure, but the IS_ERR() check evaluates to
false for NULL. The NULL pointer would then be immediately passed to
drm_connector_dynamic_init(), resulting in a kernel panic.

[Severity: High]
Does vkms_connector_hot_add() leak memory or corrupt lists on error?

In the same function:

drivers/gpu/drm/vkms/vkms_connector.c:vkms_connector_hot_add() {
	struct vkms_connector __free(kfree) * connector =3D NULL;
	...
}

If drm_connector_dynamic_init() succeeds, it registers the connector in core
DRM structures. If a subsequent initialization step fails, the function
returns an error, triggering the __free(kfree) cleanup.

The raw kfree() frees the memory without invoking drm_connector_cleanup() or
dropping references, leaving dangling pointers in the DRM core lists and
leaking internal property allocations.

> +				if (IS_ERR(connector_cfg->connector)) {
> +					count =3D PTR_ERR(connector_cfg->connector);
> +					goto rollback;
> +				}
> +			} else if (was_enabled && !enabled) {
> +				vkms_connector_hot_remove(connector->dev->config->dev,
> +							  connector_cfg->connector);

[Severity: High]
Does this leave a dangling pointer in connector_cfg->connector?

When a dynamic connector is disabled, vkms_connector_hot_remove() unregiste=
rs
and frees the DRM connector. However, connector_cfg->connector is not clear=
ed.

Reusing memory for a new dynamic connector may result in the same pointer
address, and iteration logic that matches against it will match the dangling
pointer, corrupting connector configuration states.

[Severity: Critical]
Is it safe to call drm_mode_config_reset() dynamically at runtime?

Looking at vkms_connector_hot_remove() and vkms_connector_hot_attach_encode=
r():

drivers/gpu/drm/vkms/vkms_connector.c:vkms_connector_hot_remove() {
	...
	drm_mode_config_reset(&vkmsdev->drm);
	...
}

This helper loops over all CRTCs, planes, and connectors, unconditionally
freeing their current active atomic states and allocating fresh empty state=
s.

Executing this while userspace has an active modeset destroys the structures
currently in use without proper teardown or synchronization, leading to
use-after-free regressions.

> +			}
> +		}
> +	}
> +	return count;
> +
> +rollback:
> +	vkms_config_connector_set_enabled(connector_cfg, was_enabled);

[Severity: High]
Can this modification on rollback race with concurrent accesses?

A goto rollback jumps out of the scoped_guard block, releasing the lock
implicitly:

drivers/gpu/drm/vkms/vkms_configfs.c:connector_enabled_store() {
	scoped_guard(mutex, &connector->dev->lock) {
...
				if (IS_ERR(connector_cfg->connector)) {
					count =3D PTR_ERR(connector_cfg->connector);
					goto rollback;
				}
...
	}
...
rollback:
	vkms_config_connector_set_enabled(connector_cfg, was_enabled);

The rollback executes without the lock held. This violates the subsystem ru=
le
against mixing goto and scope-based cleanup helpers.

[ ... ]
> @@ -1306,19 +1415,28 @@ static struct configfs_attribute *connector_item_=
attrs[] =3D {
[ ... ]
>  static void connector_release(struct config_item *item)
>  {
>  	struct vkms_configfs_connector *connector;
> +	struct vkms_config_connector *connector_cfg;
>  	struct mutex *lock;
> =20
>  	connector =3D connector_item_to_vkms_configfs_connector(item);
> +	connector_cfg =3D connector->config;
>  	lock =3D &connector->dev->lock;
> =20
>  	scoped_guard(mutex, lock) {
> +		if (connector->dev->enabled && connector_cfg->dynamic && connector_cfg=
->enabled)
> +			vkms_connector_hot_remove(connector->dev->config->dev,
> +						  connector_cfg->connector);
> +

[Severity: High]
Does this allow userspace to bypass topological validation?

Disabling a connector via the enabled sysfs attribute correctly checks
vkms_config_is_valid(). However, removing a dynamic connector entirely via
rmdir calls connector_release(), which performs vkms_connector_hot_remove()
unconditionally.

This bypasses validation checks (e.g., removing the only connected connecto=
r),
breaking the internal DRM configuration rules while the device is running.

>  		vkms_config_destroy_connector(connector->config);
> +

[Severity: High]
This is a pre-existing issue, but can userspace remove static connectors wh=
ile
the DRM device is activated, causing a use-after-free?

Userspace can remove a static connector via rmdir while the DRM device is
fully enabled. connector_release() bypasses vkms_connector_hot_remove() for
static connectors and immediately destroys the configuration structure.

The active DRM device retains pointers to the destroyed configuration and w=
ill
dereference it.

[Severity: High]
This is a pre-existing issue, but does lockless iteration over connectors r=
ace
with configfs item removal?

When userspace invokes rmdir on a connector, connector_release() frees the
connector_cfg structure. Concurrently, functions like vkms_connector_detect=
()
and vkms_conn_get_modes() iterate over vkmsdev->config->connectors lockless=
ly:

drivers/gpu/drm/vkms/vkms_connector.c:vkms_connector_detect() {
	...
	vkms_config_for_each_connector(vkmsdev->config, connector_cfg) {
		if (connector_cfg->connector =3D=3D vkms_connector)
			status =3D vkms_config_connector_get_status(connector_cfg);
	}
	...
}

This lockless iteration traverses freed memory, causing a use-after-free
regression.

>  		kfree(connector);
>  	}
>  }
> @@ -1337,6 +1455,7 @@ static int connector_possible_encoders_allow_link(s=
truct config_item *src,
[ ... ]
>  	scoped_guard(mutex, &connector->dev->lock) {
> -		if (connector->dev->enabled)
> -			return -EBUSY;
> +		if (connector->dev->enabled && connector_cfg->enabled) {
> +			if (!connector_cfg->dynamic)
> +				return -EBUSY;
> +
> +			ret =3D vkms_connector_hot_attach_encoder(connector->dev->config->dev,
> +								connector->config->connector,
> +								encoder->config->encoder);
> +			if (ret)
> +				return ret;
> +		}
> =20
>  		ret =3D vkms_config_connector_attach_encoder(connector->config,
>  							   encoder->config);
> +		if (ret)
> +			return ret;

[Severity: Medium]
Is there a missing rollback if the internal configfs allocation fails?

vkms_connector_hot_attach_encoder() updates the live hardware state.
Immediately after, vkms_config_connector_attach_encoder() performs a memory
allocation to update the configfs state.

If this allocation fails, the error is returned without undoing the hardware
attachment, leaving the active DRM device out of sync with the configfs
representation.

[Severity: Medium]
Does dropping a symlink for an active dynamic connector fail to detach the
encoder from the live DRM connector?

Looking at the corresponding drop function:

drivers/gpu/drm/vkms/vkms_configfs.c:connector_possible_encoders_drop_link(=
) {
	...
	scoped_guard(mutex, &connector->dev->lock) {
		vkms_config_connector_detach_encoder(connector->config,
						     encoder->config);
	}
}

It successfully removes the encoder from the internal configfs state, but if
the device is enabled, it fails to interact with the DRM core to actually
detach the encoder from the hardware state.

This creates a state divergence where configfs thinks the encoder is unlink=
ed,
but DRM continues to use it.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627-vkms-all-c=
onfig-v5-0-854aa0840926@bootlin.com?part=3D36
