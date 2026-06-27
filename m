Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 090F0C43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:57:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54E7410F792;
	Sat, 27 Jun 2026 03:57:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AlEaijR8";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7E3010F7A3
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 03:57:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 31259600AA;
 Sat, 27 Jun 2026 03:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C171F000E9;
 Sat, 27 Jun 2026 03:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782532625;
 bh=G4ZAxIAw+CtFyqMHrLFMTZU5oiBhGBV8vBQBZZFTQ0M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AlEaijR8RJczoK2B822SqfbOXfpy84mYLcxmpqxF+CGHb/DPv4rJiHDMh67bPnI0m
 M8mzjp8sDCs+FpPDj8+oVTFYq3Rv1eNwqNZSRFQOTU+03TvsflJWgS97xtHe7sqg/t
 S5ZZ2w9z85BXHOuBBXZTYejYOhOBy7Luaxm3dRzFHs5Le1BPZh1r1h6Z0joBklAOME
 FhiZTc1ta1Tw9jZ1IUgUNsf/qt2V2pO0U3EDD7CAjCMlBLX36ry88LRHxn0AarBHjZ
 Z66RtopP24oXSM0QQayE/EDAzIde+3Yx1p3HHXNhWS8LHl6tDZAOF8G0+xpCVmVCva
 BLHxTj6OXh7Mw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 37/38] drm/vkms: Add connector parent configuration
 in vkms_config
To: "Louis Chauvet" <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260627-vkms-all-config-v5-37-854aa0840926@bootlin.com>
References: <20260627-vkms-all-config-v5-0-854aa0840926@bootlin.com>
 <20260627-vkms-all-config-v5-37-854aa0840926@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 03:57:04 +0000
Message-Id: <20260627035705.B6C171F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Error paths in `vkms_connector_hot_add()` free the connector via `=
__free(kfree)` without tearing down the DRM connector, causing a Use-After-=
Free and IDA leak.
- [Medium] The MST PATH property generation creates a malformed string and =
silently drops a valid port ID when the connector hierarchy depth exceeds 1=
6.
- [Medium] Dynamic configuration of connector parent relationships results =
in inconsistent or stale DRM PATH properties.
--

commit 3d7cb6751094b4d573bbf296f74ba57a8170fe00
Author: Louis Chauvet <louis.chauvet@bootlin.com>

drm/vkms: Add connector parent configuration in vkms_config
   =20
This patch adds support for configuring the parent connector and port_id
in vkms_config to emulate MST connectors. It updates the PATH property
strings for nested MST configurations and manages dynamic connector
lifecycles.

> diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vk=
ms_config.c
> --- a/drivers/gpu/drm/vkms/vkms_config.c
> +++ b/drivers/gpu/drm/vkms/vkms_config.c
> @@ -996,8 +996,16 @@ struct vkms_config_connector *vkms_config_create_con=
nector(struct vkms_config *c
>  }
>  EXPORT_SYMBOL_IF_KUNIT(vkms_config_create_connector);
> =20
> -void vkms_config_destroy_connector(struct vkms_config_connector *connect=
or_cfg)
> +void vkms_config_destroy_connector(struct vkms_config *config,
> +				   struct vkms_config_connector *connector_cfg)
>  {
> +	struct vkms_config_connector *connector_cfg_tmp;
> +
> +	vkms_config_for_each_connector(config, connector_cfg_tmp) {
> +		if (connector_cfg_tmp->parent =3D=3D connector_cfg)
> +			connector_cfg_tmp->parent =3D NULL;
> +	}
> +

[Severity: Medium]
When dynamically destroying a parent connector, this unlinks it from the
child connectors, but doesn't it leave the active children with stale
DRM PATH properties pointing to destroyed DRM object IDs?

Also, if a child is dynamically added before its parent, the child's PATH
property is silently skipped in vkms_connector_build_path_property() due to
the missing root, and it appears it is never retroactively updated.

[ ... ]

> diff --git a/drivers/gpu/drm/vkms/vkms_connector.c b/drivers/gpu/drm/vkms=
/vkms_connector.c
> --- a/drivers/gpu/drm/vkms/vkms_connector.c
> +++ b/drivers/gpu/drm/vkms/vkms_connector.c
> @@ -8,6 +8,76 @@
>  #include "vkms_config.h"
>  #include "vkms_connector.h"
> =20
> +/**
> + * vkms_connector_build_path_property() - Build the PATH property string=
 for MST connectors
[ ... ]
> +	if (!root_cfg || !root_cfg->connector)
> +		return;
> +
> +	root_connector =3D root_cfg->connector;
> +
> +	len =3D snprintf(path, sizeof(path), "mst:%d", root_connector->base.bas=
e.id);
> +
> +	for (i =3D port_count - 2; i >=3D 0; i--) {

[Severity: Medium]
If the connector hierarchy exceeds 16 nodes, port_count will hit the
ARRAY_SIZE(port_ids) limit of 16. Does starting the loop at port_count - 2
(which evaluates to 14) accidentally skip the last recorded array element at
port_ids[15]?

Since the root node is not stored in the array when truncation occurs, it
seems this drops a valid intermediate node from the PATH property string.

> +		int added =3D snprintf(path + len, sizeof(path) - len,
> +				     "-%u", port_ids[i]);
> +		if (added < 0 || len + added >=3D sizeof(path))
> +			return;
> +		len +=3D added;
> +	}
> +
> +	drm_connector_set_path_property(&connector->base, path);
> +}

[ ... ]

> @@ -240,6 +312,8 @@ struct vkms_connector *vkms_connector_hot_add(struct =
vkms_device *vkmsdev,
>  	if (ret)
>  		return ERR_PTR(ret);

[Severity: High]
Can this error path lead to a Use-After-Free and IDA leak?

The connector struct is allocated with __free(kfree). Earlier in this
function, drm_connector_dynamic_init() registers the connector base object
into the DRM mode object IDR and allocates IDAs.

If a subsequent step fails and we return ERR_PTR(ret) here, the __free(kfre=
e)
attribute will directly free the connector memory without calling
drm_connector_cleanup(), leaving dangling pointers in the DRM IDR.

> =20
> +	vkms_connector_build_path_property(connector, connector_cfg);
> +
>  	ret =3D drm_connector_dynamic_register(&connector->base);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627-vkms-all-c=
onfig-v5-0-854aa0840926@bootlin.com?part=3D37
