Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66EE1C43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:50:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB68110F77D;
	Sat, 27 Jun 2026 03:50:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OBm1FhY8";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53DED10F77C
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 03:50:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B8079600AA;
 Sat, 27 Jun 2026 03:50:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49CC01F000E9;
 Sat, 27 Jun 2026 03:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782532204;
 bh=xvpo7qK2oxAqV9ffg+ToEQMlPQ+vUTdM54J4XAKYcIw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OBm1FhY8aCPaMpvtwF/Ph7BhoSStP6ByM6oGQexdCnqfOE3InZEzQzhM/+ZTGnqnE
 7dxVrHQg4eN2hZlgRNT90zv3ka7IwpJkwBaV3NSuCqrCpXfPAli5mKToZdIxROSxxa
 9/EdzR2UiusHmiITpBMRX/fabeb5De5CilNCe/hvm0ofJrvFA+Duet/602MXiu59fN
 NPxc6AJH7Xqcuc9Z0KO3ZW1UoQ/52nj9cAWRrH5RVAyedpwwBti8LEQT2/iYx7gVUA
 tnSThG2ilav9EVrghS1fY3ei7R//HGzbiHwPzbYVmSCxjXBsYjc/DbM6leYMBzvRd9
 +VE7umMNx5JGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 33/38] drm/vkms: Introduce configfs for connector EDID
To: "Louis Chauvet" <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260627-vkms-all-config-v5-33-854aa0840926@bootlin.com>
References: <20260627-vkms-all-config-v5-0-854aa0840926@bootlin.com>
 <20260627-vkms-all-config-v5-33-854aa0840926@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 03:50:03 +0000
Message-Id: <20260627035004.49CC01F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] Concurrent update of the EDID blob via ConfigFS and reading via DR=
M ioctls leads to a Use-After-Free.
- [Medium] The dynamically allocated `connector_cfg->edid` buffer is never =
freed when a connector configuration is destroyed, leading to a memory leak.
- [Medium] Memory allocation failure when storing an EDID is silently ignor=
ed, returning success to userspace and falsely triggering a hotplug event.
- [Medium] Toggling `edid_enabled` at runtime via ConfigFS is broken in bot=
h directions and fails to correctly synchronize with the KMS EDID property.
- [Medium] Using a standard ConfigFS string attribute for binary EDID data =
causes valid 4096-byte EDIDs to be truncated.
- [Medium] Calling `memcpy` with a potentially `NULL` source pointer in `co=
nnector_edid_show` triggers undefined behavior.
- [Low] Passing `unsigned int *` to a function expecting `int *` causes an =
incompatible pointer type compiler warning/error.
--

commit e55896ded21ff0567eff633eae34bfa27b5899cf
Author: Louis Chauvet <louis.chauvet@bootlin.com>

drm/vkms: Introduce configfs for connector EDID

This commit introduces new attributes in configfs to configure the EDID
of a vkms connector. It adds edid_enable and edid attributes.

> diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/=
vkms_configfs.c
> index e1f6e7817f972..f79a796c2017f 100644
> --- a/drivers/gpu/drm/vkms/vkms_configfs.c
> +++ b/drivers/gpu/drm/vkms/vkms_configfs.c
[ ... ]
> @@ -1218,14 +1218,94 @@ static ssize_t connector_supported_colorspaces_st=
ore(struct config_item *item,
[ ... ]
> +static ssize_t connector_edid_show(struct config_item *item, char *page)
> +{
> +	struct vkms_configfs_connector *connector;
> +
> +	connector =3D connector_item_to_vkms_configfs_connector(item);
> +
> +	scoped_guard(mutex, &connector->dev->lock)
> +	{
> +		unsigned int len =3D 0;
> +		const u8 *edid =3D vkms_config_connector_get_edid(connector->config, &=
len);

[Severity: Low]
Does this trigger an incompatible-pointer-types warning during the build?

The vkms_config_connector_get_edid() function expects an int pointer for
the length, but we are passing an unsigned int pointer here.

> +
> +		memcpy(page, edid, min(len, PAGE_SIZE));

[Severity: Medium]
Could this trigger undefined behavior and a UBSAN warning if edid is not se=
t?

If len is 0, vkms_config_connector_get_edid() returns a NULL pointer, causi=
ng
us to call memcpy(page, NULL, 0) unconditionally.

> +		return min(len, PAGE_SIZE);
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static ssize_t connector_edid_store(struct config_item *item,
> +				    const char *page, size_t count)
> +{
> +	struct vkms_configfs_connector *connector;
> +
> +	connector =3D connector_item_to_vkms_configfs_connector(item);
> +
> +	scoped_guard(mutex, &connector->dev->lock)
> +	{
> +		vkms_config_connector_set_edid(connector->config, page, count);

[Severity: Medium]
Does this code assume the set operation always succeeds?=20

Looking at vkms_config_connector_set_edid() in vkms_config.h, it uses=20
krealloc() to allocate memory for the EDID but returns void. If the
allocation fails, the old EDID remains unmodified and no error is returned.

This caller then assumes success, returns the written count to userspace,
and falsely triggers a hotplug event below even if the system was out of
memory.

[Severity: High]
Can writing to this attribute cause a use-after-free during concurrent DRM
ioctl reads?

When vkms_config_connector_set_edid() is called here, it holds the
connector->dev->lock. Inside that function, krealloc() frees the old
edid pointer.

However, the DRM read path in vkms_connector_read_block() accesses the EDID
locklessly. If thread A writes a new EDID to configfs, thread B executing
a DRM_IOCTL_MODE_GETCONNECTOR ioctl might dereference the freed pointer whi=
le
copying.

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
Will this string attribute truncate valid 4096-byte EDID payloads?

Since this is defined as a standard CONFIGFS_ATTR rather than a binary
attribute (CONFIGFS_BIN_ATTR), configfs reserves one byte for the null
terminator. A user writing exactly 4096 bytes (a valid 32-block EDID)
would have their write truncated to 4095 bytes.

> diff --git a/drivers/gpu/drm/vkms/vkms_connector.c b/drivers/gpu/drm/vkms=
/vkms_connector.c
> index fe42ab2ba7b10..f726c79955240 100644
> --- a/drivers/gpu/drm/vkms/vkms_connector.c
> +++ b/drivers/gpu/drm/vkms/vkms_connector.c
> @@ -175,6 +175,9 @@ struct vkms_connector *vkms_connector_init_static(str=
uct vkms_device *vkmsdev,
> =20
>  	drm_connector_helper_add(&connector->base, &vkms_conn_helper_funcs);
> =20
> +	if (vkms_config_connector_get_edid_enabled(connector_cfg))
> +		drm_connector_attach_edid_property(&connector->base);
> +

[Severity: Medium]
Is toggling the edid_enabled attribute at runtime broken?

This code only conditionally attaches the property at initialization. If
edid_enabled is false at init, the property is never attached, so changing
it to true later via configfs will fail to expose the EDID.

Conversely, if it is toggled to false at runtime, vkms_conn_get_modes()
fails to call drm_edid_connector_update(connector, NULL). This results in
the DRM core continuing to serve the stale EDID data to userspace.

One additional question about the EDID memory lifecycle:

[Severity: Medium]
Does this change introduce a memory leak when a connector is destroyed?

The dynamically allocated connector_cfg->edid buffer does not appear to be
freed when a connector configuration directory is removed. When configfs
tears down the item, vkms_config_destroy_connector() in vkms_config.c
frees the connector_cfg struct, but it doesn't free the edid field.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627-vkms-all-c=
onfig-v5-0-854aa0840926@bootlin.com?part=3D33
