Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECC4606A321
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=guA8JxkO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9503F11238C;
	Thu, 26 Nov 2026 11:50:39 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 420DC11238C
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:50:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 151F844305;
 Thu, 26 Nov 2026 11:50:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E8D1F00A00;
 Thu, 26 Nov 2026 11:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795693833;
 bh=kA8x2oRsW6uU6sCSFbR/mXS1B7KKRelBL8TOdZonTwk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=guA8JxkOTk9bLZt07+tmbPym6cAL7Np7DaPV9YO08Oiy5Ne+UzVJsX0R5sHnRh3sZ
 5BXY3mIZhD1PBmmOk0GHownnwOmSMxmyVkJdFij6rTSHXPJv23LuQtovvDcOTktsK7
 1kEpBCHW3+9DpU5l1hsWFz7K6Nopp4Q/8wHJffl/uJDRenPSfSSI9LAgrEHTnL65eL
 xXwAqNbpDZ3HZuOpzDobp4uuFR3eqrTMXgnx0O4wZsolFrSx9sYymrpcjYcowf7+5Z
 7r51/Y3EgAWmHFpB4cPaYkytaCyaieoGFW1473AWBjYJRxnrxLl0tyUNuoay9eVRj/
 0Bh8wd6RKskiA==
Message-ID: <sashiko-outbox-235427@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 35/43] drm/vkms: Introduce configfs for connector
 supported colorspace
To: "Louis Chauvet" <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261126-vkms-all-config-v7-35-21194cda2468@bootlin.com>
References: <20261126-vkms-all-config-v7-0-21194cda2468@bootlin.com>
 <20261126-vkms-all-config-v7-35-21194cda2468@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 11:50:32 +0000
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
- [Medium] drm/vkms: connector_supported_colorspaces_store() accepts
  invalid bitmasks
- [Low] drm/vkms: connector_supported_colorspaces_store() rejects hex
  bitmasks
--

commit 803cc9979c038fca8f2b7f6789254e4be3274951
Author: Louis Chauvet <louis.chauvet@bootlin.com>

drm/vkms: Introduce configfs for connector supported colorspace

This commit adds a supported_colorspaces configfs attribute to configure
the supported colorspaces of VKMS connectors and updates the VKMS configfs
documentation.

> diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
> index f2622b3fd8afd..11058b6e62507 100644
> --- a/Documentation/gpu/vkms.rst
> +++ b/Documentation/gpu/vkms.rst
> @@ -137,11 +137,16 @@ Last but not least, create one or more connectors::
> =20
>    sudo mkdir /config/vkms/my-vkms/connectors/connector0
> =20
> -Connectors have 2 configurable attribute:
> +Connectors have 3 configurable attribute:
> =20
>  - status: Connection status: 1 connected, 2 disconnected, 3 unknown (sam=
e values
>    as those exposed by the "status" property of a connector)
>  - type: Type of connector. Same values as exposed by the "type" field in=
 drm_connector.
> +- supported_colorspaces: Supported colorspaces values for HDMI, DP and e=
DP connectors.
> +  If supported_colorspaces is not 0, the HDR_OUTPUT_METADATA will also b=
e created.
> +  Value is a bitfield, 0x1 =3D NO_DATA, 0x2 =3D SMPTE_170M_YCC... see en=
um drm_colorspace
> +  for full list.
> +
> =20
>  To finish the configuration, link the different pipeline items::
> =20
> diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/=
vkms_configfs.c
> index fef731bdb0590..7377d967be75d 100644
> --- a/drivers/gpu/drm/vkms/vkms_configfs.c
> +++ b/drivers/gpu/drm/vkms/vkms_configfs.c
> @@ -1153,12 +1153,52 @@ static ssize_t connector_type_store(struct config=
_item *item,
>  	return count;
>  }
> =20
> +static ssize_t connector_supported_colorspaces_show(struct config_item *=
item, char *page)
> +{
> +	struct vkms_configfs_connector *connector;
> +	int colorspaces;
> +
> +	connector =3D connector_item_to_vkms_configfs_connector(item);
> +
> +	scoped_guard(mutex, &connector->dev->config->lock)
> +	colorspaces =3D vkms_config_connector_get_supported_colorspaces(connect=
or->config);
> +
> +	return sprintf(page, "%u\n", colorspaces);
> +}
> +
> +static ssize_t connector_supported_colorspaces_store(struct config_item =
*item,
> +						     const char *page, size_t count)
> +{
> +	struct vkms_configfs_connector *connector;
> +	int val, ret;
> +
> +	connector =3D connector_item_to_vkms_configfs_connector(item);
> +
> +	ret =3D kstrtouint(page, 10, &val);
> +	if (ret)
> +		return ret;

[Severity: Low]
Should kstrtouint() use base 0 instead of base 10 here?
Documentation/gpu/vkms.rst documents supported_colorspaces using
hexadecimal bitmasks ("0x1 =3D NO_DATA, 0x2 =3D SMPTE_170M_YCC..."), and the
plane supported_* bitmask attributes in vkms_configfs.c accept hex input,
but base 10 rejects 0x-prefixed strings with -EINVAL.

> +
> +	if ((val & -BIT(DRM_MODE_COLORIMETRY_COUNT)) !=3D 0)
> +		return -EINVAL;

[Severity: Medium]
Does connector_supported_colorspaces_store() allow non-zero bitmasks that
later cause device enablement to fail in vkms_connector_init()?

Both Documentation/ABI/testing/configfs-vkms and
Documentation/gpu/vkms.rst document bit 0 (1 / 0x1 =3D NO_DATA) and bit 1
(2 / 0x2 =3D SMPTE_170M_YCC) as valid supported_colorspaces values.
However, drm_mode_create_hdmi_colorspace_property() and
drm_mode_create_dp_colorspace_property() mask non-zero supported_colorspaces
against hdmi_colorspaces (bits 1..12) and dp_colorspaces (bits 2..11 and
13..15) before calling drm_mode_create_colorspace_property(), which
automatically adds BIT(DRM_MODE_COLORIMETRY_DEFAULT) only after checking
that the masked value is non-zero.

As a result, setting supported_colorspaces to 1 on any connector (or to
an HDMI-only bit such as 2 on a DP/eDP connector) succeeds here and passes
valid_connector_colorspaces(), but enabling the device fails in
drm_mode_create_colorspace_property() with drm_err("No supported
colorspaces provded...") and -EINVAL.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-vkms-all-c=
onfig-v7-0-21194cda2468@bootlin.com?part=3D35
