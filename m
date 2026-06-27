Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D627C43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:50:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFD0C10F77C;
	Sat, 27 Jun 2026 03:50:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UguBMdB8";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C975210F77C
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 03:50:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4E211600AA;
 Sat, 27 Jun 2026 03:50:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A6E1F000E9;
 Sat, 27 Jun 2026 03:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782532251;
 bh=fl6U1m26YG/7kvOfONo+YgmauGGjlzrW5t9dV1EsFm8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UguBMdB8ZaiwlTl76g9Ha2KjkfVW9Zry9puVi36CEWKZbsvmACSGzep7iS9bPQePI
 95P8eCxB6vPd3EP58mzaxDOaVwyiE6zuuXAU9C0Yz4c/isB8Hp6E4Uq3G1sxadrwJO
 zFU7NR2yrkZoLnQf4GchNIGuISCgCn8dy4QgEBztujVmavgl+UZjODWNzUBvI2D96V
 AjXYfj+uJDx6zwTDT7MDDotDB3rXMRP7vmzY4gNpykx89IFKms5MzkQSeM+I8wGoea
 Io5e6Lp7+X4/Rr7UB5yeS/jhmgTRzQBpAteKpZncsNOHk7LVPLJAStclOXI8m+8HvG
 yPFvBdt4mgyDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 35/38] drm/vkms: Allow to hot-add connectors
To: "Louis Chauvet" <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260627-vkms-all-config-v5-35-854aa0840926@bootlin.com>
References: <20260627-vkms-all-config-v5-0-854aa0840926@bootlin.com>
 <20260627-vkms-all-config-v5-35-854aa0840926@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 03:50:50 +0000
Message-Id: <20260627035050.D3A6E1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Incorrect error check for kzalloc_obj() return value causes NULL p=
ointer dereference.
- [High] Using __free(kfree) on a dynamically initialized DRM connector byp=
asses necessary DRM core cleanup on error paths, causing UAF.
- [High] Calling drm_mode_config_reset() during dynamic hot-remove and atta=
ch blindly destroys the active atomic state of all display objects on the d=
evice.
- [High] Unconditional destruction of a potentially NULL colorspace propert=
y in the error path of vkms_connector_hot_add().
- [Medium] The dynamically allocated colorspace_property is permanently lea=
ked when a connector is destroyed.
--

commit 5cfc3cee3faffdbe590e3944a8bf682376206e74
Author: Louis Chauvet <louis.chauvet@bootlin.com>
drm/vkms: Allow to hot-add connectors

This commit adds the necessary infrastructure in vkms_connector to allow
creating dynamic connectors. It implements hot-add, hot-remove, and
hot-attach functionality for the vkms device.

> diff --git a/drivers/gpu/drm/vkms/vkms_connector.c b/drivers/gpu/drm/vkms=
/vkms_connector.c
> --- a/drivers/gpu/drm/vkms/vkms_connector.c
> +++ b/drivers/gpu/drm/vkms/vkms_connector.c
[ ... ]
> @@ -181,9 +181,98 @@ struct vkms_connector *vkms_connector_init_static(st=
ruct vkms_device *vkmsdev,
>  	return connector;
>  }
> =20
> +static void vkms_connector_dynamic_destroy(struct drm_connector *connect=
or)
> +{
> +	struct vkms_connector *vkms_connector;
> +
> +	drm_connector_cleanup(connector);
> +
> +	vkms_connector =3D drm_connector_to_vkms_connector(connector);
> +	kfree(vkms_connector);
> +}

[Severity: Medium]
Is the dynamically allocated colorspace property leaked here?

vkms_connector_init() creates this property via
drm_mode_create_hdmi_colorspace_property(), but it doesn't seem to be
destroyed with drm_property_destroy() before kfree() is called on the
connector.

[ ... ]
> +struct vkms_connector *vkms_connector_hot_add(struct vkms_device *vkmsde=
v,
> +					      struct vkms_config_connector *connector_cfg)
> +{
> +	struct vkms_config_encoder *encoder_cfg;
> +	struct vkms_connector __free(kfree) * connector =3D NULL;

[Severity: High]
Will this __free(kfree) cleanup create a use-after-free if the function
returns early after drm_connector_dynamic_init() succeeds?

If drm_connector_dynamic_init() partially registers the connector, returning
early and triggering just kfree() bypasses drm_connector_cleanup() and leav=
es
a dangling pointer in the DRM core.

> +	int ret;
> +	unsigned long idx =3D 0;
> +
> +	connector =3D kzalloc_obj(*connector, GFP_KERNEL);
> +	if (IS_ERR(connector))

[Severity: High]
Since kzalloc_obj() returns NULL on memory allocation failure, will this
IS_ERR() check fail to catch an allocation failure?

This looks like it would pass a NULL pointer to drm_connector_dynamic_init(=
).

> +		return connector;
> +	ret =3D drm_connector_dynamic_init(&vkmsdev->drm,
[ ... ]
> +	ret =3D drm_connector_dynamic_register(&connector->base);
> +	if (ret) {
> +		if (connector_cfg->type =3D=3D DRM_MODE_CONNECTOR_HDMIA ||
> +		    connector_cfg->type =3D=3D DRM_MODE_CONNECTOR_DisplayPort ||
> +		    connector_cfg->type =3D=3D DRM_MODE_CONNECTOR_eDP) {
> +			drm_property_destroy(connector->base.dev,
> +					     connector->base.colorspace_property);
> +		}

[Severity: High]
Could this unconditionally dereference a NULL property pointer?

If vkms_config_connector_get_supported_colorspaces() returns zero in
vkms_connector_init(), the colorspace_property pointer remains NULL.
Calling drm_property_destroy() on a NULL property leads to a dereference wh=
en
it accesses the enum_list.

> +		return ERR_PTR(ret);
> +	}
> +
> +	return_ptr(connector);
> +}
> +
> +void vkms_connector_hot_remove(struct vkms_device *vkmsdev,
> +			       struct vkms_connector *connector)
> +{
> +	drm_connector_unregister(&connector->base);
> +	drm_mode_config_reset(&vkmsdev->drm);
> +	drm_connector_put(&connector->base);
> +}
> +
> +int vkms_connector_hot_attach_encoder(struct vkms_device *vkmsdev,
> +				      struct vkms_connector *connector,
> +				      struct drm_encoder *encoder)
> +{
> +	int ret;
> +
> +	ret =3D drm_connector_attach_encoder(&connector->base, encoder);
> +	if (ret)
> +		return ret;
> +
> +	drm_mode_config_reset(&vkmsdev->drm);

[Severity: High]
Is it safe to call drm_mode_config_reset() during runtime hotplug events?

This iterates over every display object and unconditionally frees and
reallocates their active atomic state without holding modeset locks. Doing
this while the system is actively driving displays looks like it would corr=
upt
the global KMS state machine.

> +
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627-vkms-all-c=
onfig-v5-0-854aa0840926@bootlin.com?part=3D35
