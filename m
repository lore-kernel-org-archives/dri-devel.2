Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FB0606A321
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RsvShkgH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D162112380;
	Thu, 26 Nov 2026 11:48:56 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 792E410E99D
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:48:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5C73D401BF;
 Thu, 26 Nov 2026 11:48:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D001F000C0;
 Thu, 26 Nov 2026 11:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795693728;
 bh=MDIVdmeJBiloUxPpFw4sRs6VK6oRprcu9BMGIHyCn70=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RsvShkgHn6J/pFJXpUJ3rkdyTDx1BuwzyeNzs/fm36GtrmQSdlLupELc+YELiaqPA
 9kJ/oeEtsvbn+725tUksD0m/4YPiC+3E345YvxaLOOw/ExXl9ohU6Ps6vGKdAIDre9
 NqcDEJsmYBdmNBG4y9tLg8fcI4j2n5JLMuNfSBUSOptcy7PP1bYgKz5cjfyUmIhY8H
 GIZNRxMRlPST+kbJYJtBlDTFBLaxWdq9XIFhhrpsemkq837Ms7i2E1RK3fTB4VeSiD
 X6o3AyEdxKdtZaT4e47PqjrMBo6yftV7qLvHjF8a+dv+cGs8rERpsAr/7WEgWOR7nA
 fFFIbIXzlifFg==
Message-ID: <sashiko-outbox-235421@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 34/43] drm/vkms: Introduce config for connector
 supported colorspace
To: "Louis Chauvet" <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261126-vkms-all-config-v7-34-21194cda2468@bootlin.com>
References: <20261126-vkms-all-config-v7-0-21194cda2468@bootlin.com>
 <20261126-vkms-all-config-v7-34-21194cda2468@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 11:48:47 +0000
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
- [Medium] drm/vkms: incomplete colorspace validation in
  valid_connector_colorspaces()
- [Low] drm/vkms: malformed kernel-doc parameter syntax in
  vkms_connector_init()
--

commit 2738e3373c723cbcc39db7e98d237f52472fa93d
Author: Louis Chauvet <louis.chauvet@bootlin.com>

drm/vkms: Introduce config for connector supported colorspace

This commit adds connector colorspace configuration to VKMS and attaches
the corresponding DRM colorspace and HDR output metadata properties on
HDMI, DisplayPort, and eDP connectors.

> diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vk=
ms_config.c
> index b415d4bf6edb0..fa4ca256b4b91 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.c
> +++ b/drivers/gpu/drm/vkms/vkms_config.c
> @@ -466,6 +466,38 @@ static bool valid_connector_possible_encoders(const =
struct vkms_config *config)
>  	return true;
>  }
> =20
> +static bool valid_connector_colorspaces(const struct vkms_config *config)
> +{
> +	struct drm_device *dev =3D config->dev ? &config->dev->drm : NULL;
> +	struct vkms_config_connector *connector_cfg;
> +
> +	vkms_config_for_each_connector(config, connector_cfg) {
> +		u32 colorspaces =3D vkms_config_connector_get_supported_colorspaces(co=
nnector_cfg);
> +
> +		if (!colorspaces)
> +			continue;
> +
> +		switch (connector_cfg->type) {
> +		case DRM_MODE_CONNECTOR_HDMIA:
> +		case DRM_MODE_CONNECTOR_HDMIB:
> +		case DRM_MODE_CONNECTOR_DisplayPort:
> +		case DRM_MODE_CONNECTOR_eDP:
> +			break;
> +		default:
> +			drm_info(dev,
> +				 "Colorspaces are only supported on HDMI, DisplayPort and eDP connec=
tors\n");
> +			return false;
> +		}
> +
> +		if (colorspaces & ~(BIT(DRM_MODE_COLORIMETRY_COUNT) - 1)) {
> +			drm_info(dev, "Colorspace value contains invalid bits\n");
> +			return false;
> +		}
> +	}
> +
> +	return true;
> +}

[Severity: Medium]
Can valid_connector_colorspaces() accept a colorspaces mask that later
causes vkms_connector_init() to fail with -EINVAL?

drm_mode_create_hdmi_colorspace_property() and
drm_mode_create_dp_colorspace_property() mask a non-zero
supported_colorspaces argument with hdmi_colorspaces or dp_colorspaces
before calling drm_mode_create_colorspace_property(), which rejects a
zero mask with -EINVAL.  Neither mask includes
BIT(DRM_MODE_COLORIMETRY_DEFAULT), and each excludes values specific to
the other connector type (such as DRM_MODE_COLORIMETRY_RGB_WIDE_FIXED on
HDMI or DRM_MODE_COLORIMETRY_SMPTE_170M_YCC on DP).  If only excluded
bits are set, vkms_config_is_valid() succeeds, but vkms_connector_init()
fails and aborts device creation; if valid and excluded bits are mixed,
vkms_config_show() reports the unsupported bits in debugfs even though
DRM strips them from the property.

> diff --git a/drivers/gpu/drm/vkms/vkms_connector.c b/drivers/gpu/drm/vkms=
/vkms_connector.c
> index 7264ca84f910f..552d767c3976e 100644
> --- a/drivers/gpu/drm/vkms/vkms_connector.c
> +++ b/drivers/gpu/drm/vkms/vkms_connector.c
> @@ -76,6 +76,53 @@ static void vkms_connector_static_cfg_release(struct d=
rm_device *dev, void *res)
>  	vkms_config_connector_put(connector->cfg);
>  }
> =20
> +/**
> + * vkms_connector_init - Common initialization for all vkms connectors
> + *
> + * @connector - Already allocated connector
> + * @connector_cfg - Configuration to apply
> + *
> + * Returns: 0 on success, errno on error;
> + */
> +static int __must_check vkms_connector_init(struct vkms_connector *conne=
ctor,
> +					    struct vkms_config_connector *connector_cfg)

[Severity: Low]
This kernel-doc comment uses hyphens instead of colons after @connector
and @connector_cfg, which causes scripts/kernel-doc (W=3D1) to warn that
both function parameters are not described.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-vkms-all-c=
onfig-v7-0-21194cda2468@bootlin.com?part=3D34
