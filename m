Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA0CC43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:45:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE56D10F772;
	Sat, 27 Jun 2026 03:45:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gpXQFKfx";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7AB610F772
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 03:45:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A0E1B436AD;
 Sat, 27 Jun 2026 03:45:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5163B1F000E9;
 Sat, 27 Jun 2026 03:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782531949;
 bh=Pg5sVIL4axxgWNRPjt1UJ7gvPtvCh7QwX4hId3QGyig=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gpXQFKfxGH2y+A7EyzZBqoCKdtr3Ien5U87El8/T0EC9Ie2hiBZ/7up+2BwGyCMjJ
 36gOQaVPsmMcMLNoDDAjW8NsUh8/NxOZVO9UYDMaowfDx8Sj4yCY+gqqSr/+NH4Kaz
 pOZ8qx/DHUMcRHcGd35fQYpfK+kmwkjdKSC0QYGHiG4JTQp8PNeEsMnwq/leNmpeEF
 O831jshebZ0AjLQj9a31CDbOstKhzOXULvFBe/Q0GMnpd/WWLV1feYieKEpOd6Rv7T
 sg1CBdMamUjEDpSfOQP4kzRVIaV2zGE6JL9prFFIbEHGzO7Vhd1NK26So/xcn7XnTi
 nQAqkxyeDRXvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 38/38] drm/vkms: Add ConfigFS interface for connector
 parent and port_id
To: "Louis Chauvet" <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260627-vkms-all-config-v5-38-854aa0840926@bootlin.com>
References: <20260627-vkms-all-config-v5-0-854aa0840926@bootlin.com>
 <20260627-vkms-all-config-v5-38-854aa0840926@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 03:45:48 +0000
Message-Id: <20260627034549.5163B1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The function `connector_parent_connector_allow_link` returns an un=
initialized variable `ret` on success, which can cause state desynchronizat=
ion and a Use-After-Free vulnerability.
--

commit bf8b7f51f1321ae67ea645909d25e75e04da5354
Author: Louis Chauvet <louis.chauvet@bootlin.com>

drm/vkms: Add ConfigFS interface for connector parent and port_id

This commit adds configuration interfaces for a connector's parent and port=
_id
using configfs. It allows port_id to hold any u8 value and permits the pare=
nt
to contain at most one symlink to another connector.

> diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/=
vkms_configfs.c
> index dd2a9e450150b..4f4ec99448042 100644
> --- a/drivers/gpu/drm/vkms/vkms_configfs.c
> +++ b/drivers/gpu/drm/vkms/vkms_configfs.c

[ ... ]

> @@ -1512,6 +1555,63 @@ static const struct config_item_type connector_pos=
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
> +	int ret;
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
> +	scoped_guard(mutex, &connector->dev->lock) {
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
> +	return ret;

[Severity: High]
Could this return an uninitialized value on the success path?=20

In connector_parent_connector_allow_link(), ret is declared but never
initialized before being returned at the end of the function.=20

If ret happens to contain a non-zero value from the stack, configfs will=20
treat the link creation as a failure and abort creating the symlink.=20
However, the internal VKMS state has already been modified to point to the=
=20
target connector via vkms_config_connector_attach_parent().=20

If the user subsequently removes the target connector using rmdir, does=20
this leave a dangling pointer in the VKMS configuration that could result=20
in a use-after-free later on?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627-vkms-all-c=
onfig-v5-0-854aa0840926@bootlin.com?part=3D38
