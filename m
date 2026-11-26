Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E4C606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ghrSuNb7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DF6910E985;
	Thu, 26 Nov 2026 11:52:23 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F9B110E985
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:52:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 91BF2625D9;
 Thu, 26 Nov 2026 11:52:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 210441F008B2;
 Thu, 26 Nov 2026 11:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795693936;
 bh=pD5DG+ZJb2eXLBiWLfTxIYT9hgxMHl9WlfcRigkq2dI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ghrSuNb7hL+VDGZP7wqSXq9mS5GetsmgVhML43xGNMLP/vpBD18m6UUU/1SyuPYgy
 TFhoMJTiliCyfURLvT7TOeOD6MyUZLkmeikyEJ7ang3u/hY1C6JojO9gJydlN5CALJ
 0CUzq55ePlKPMrrctWBQ20aHtzDrqKk4WUHBPP5lrLDe30dx5QjiUZ1a3V/lAc6InQ
 0KQq/BgAruysBIS4sMG+VxoGV4EAgBKCS/znaXZIuHWM3jnIDMfgbTgmkhZSLitCP8
 2mQ23fOV5WFrxgduRt7Alhc43/jhpIUjMIMCrGeUipiECCNF9oohMtDTyBAV6J5mSl
 EY+ml+c4aDOyw==
Message-ID: <sashiko-outbox-235430@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 43/43] drm/vkms: Add ConfigFS interface for connector
 parent and port_id
To: "Louis Chauvet" <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261126-vkms-all-config-v7-43-21194cda2468@bootlin.com>
References: <20261126-vkms-all-config-v7-0-21194cda2468@bootlin.com>
 <20261126-vkms-all-config-v7-43-21194cda2468@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 11:52:15 +0000
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
- [Medium] drm/vkms: missing connector_is_enabled() check when linking
  parent
- [Low] drm/vkms: missing kernel-doc for parent_group in
  vkms_configfs_connector
--

commit dd9fbb5c3f8a19fd7c549287852b5449c92c86f4
Author: Louis Chauvet <louis.chauvet@bootlin.com>

drm/vkms: Add ConfigFS interface for connector parent and port_id

This commit adds configfs attributes and a default subgroup to configure a
connector's port_id and parent connector for DP MST topology emulation.

> diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/=
vkms_configfs.c
> index e6222db02a2e7..55de6a06ab2df 100644
> --- a/drivers/gpu/drm/vkms/vkms_configfs.c
> +++ b/drivers/gpu/drm/vkms/vkms_configfs.c
> @@ -112,6 +112,7 @@ struct vkms_configfs_encoder {
>  struct vkms_configfs_connector {
>  	struct config_group group;
>  	struct config_group possible_encoders_group;
> +	struct config_group parent_group;
>  	struct vkms_configfs_device *dev;
>  	struct vkms_config_connector *config;
>  };

[Severity: Low]
struct vkms_configfs_connector has a kernel-doc comment right above it,
so adding parent_group without documenting @parent_group triggers a W=3D1
kernel-doc warning.

[ ... ]

> @@ -1505,6 +1548,62 @@ static const struct config_item_type connector_pos=
sible_encoders_group_type =3D {
>  	.ct_owner	=3D THIS_MODULE,
>  };
> =20
> +static int connector_parent_connector_allow_link(struct config_item *src,
> +						 struct config_item *target)
> +{
> +	struct vkms_configfs_connector *connector;
> +	struct vkms_config_connector *connector_cfg;
> +	struct vkms_configfs_connector *parent;
> +	struct vkms_config_connector *parent_cfg;
> +
> +	if (target->ci_type !=3D &connector_item_type)
> +		return -EINVAL;
> +
> +	connector =3D connector_parent_item_to_vkms_configfs_connector(src);
> +	connector_cfg =3D connector->config;
> +	parent =3D connector_item_to_vkms_configfs_connector(target);
> +	parent_cfg =3D parent->config;
> +
> +	if (connector->dev !=3D parent->dev)
> +		return -EINVAL;
> +
> +	scoped_guard(mutex, &connector->dev->config->lock) {
> +		if (vkms_config_connector_get_parent(connector_cfg))
> +			return -EMLINK;
> +
> +		if (connector->dev->enabled && connector_cfg->enabled)
> +			return -EBUSY;
> +
> +		vkms_config_connector_attach_parent(connector_cfg,
> +						    parent_cfg);
> +	}
> +
> +	return 0;
> +}

[Severity: Medium]
Should this check connector_is_enabled(connector_cfg) instead of
connector_cfg->enabled, like connector_port_id_store() does?

Static connectors (!connector_cfg->dynamic) are always active when the
device is enabled even if userspace set their enabled attribute to 0 while
the device was disabled.  Checking connector_cfg->enabled directly allows
linking a parent to an active static connector while the device is enabled,
mutating connector_cfg->parent on a live connector and allowing a parent
cycle to be formed on an active device.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-vkms-all-c=
onfig-v7-0-21194cda2468@bootlin.com?part=3D43
