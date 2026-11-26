Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6004606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J6yLs0gh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F167B10E3B3;
	Thu, 26 Nov 2026 11:46:48 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B168112380
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:46:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B3FE36284D;
 Thu, 26 Nov 2026 11:46:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00DA11F000C0;
 Thu, 26 Nov 2026 11:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795693600;
 bh=9UaZC92oNEtkuiRX5gr12Aj5Vbn1haALXFmoZQfMfr0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=J6yLs0gh5d6jr6Td2gURNEXzlT4xvVH642Up2kcQ2w0lAEwvR5x4ATafO8O6w14TZ
 146K2JtUS7zlzmB+U5HrM7qts6YFHoLqbD79apmIorkkSTdL3YAe8wr0yWljUtwSH5
 fe3JNPhiN+5SH/myuc6F85Xe0NBU3t4et9rNojQstuJrl423LsbeHdV0R62uLWRWh+
 vKhMPvodEi6TbnyLcD2xGBiSLjV6o3IXZc81lx1EOFqlFg3UCRfkZzGr9bEtY6t39r
 IN3W+4c3gGT5P53kxAZuQqmZMg6K72m22lwAVkqrfgw1hKSBaeL8DSpoUnbneVbCoa
 6uARS4NZ0zmhg==
Message-ID: <sashiko-outbox-235418@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 25/43] drm/vkms: Introduce config for plane format
To: "Louis Chauvet" <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261126-vkms-all-config-v7-25-21194cda2468@bootlin.com>
References: <20261126-vkms-all-config-v7-0-21194cda2468@bootlin.com>
 <20261126-vkms-all-config-v7-25-21194cda2468@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 11:46:39 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/vkms: malformed kernel-doc on plane format helpers in
  vkms_config.h
--

commit d93bc0319c8e32277faad2010bf0ce947960f6bf
Author: Louis Chauvet <louis.chauvet@bootlin.com>

drm/vkms: Introduce config for plane format

This commit adds configuration helpers to customize the list of supported
pixel formats per plane in vkms_config.

> diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vk=
ms_config.h
> index 20369e8d7c6e3..1b353556166c1 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.h
> +++ b/drivers/gpu/drm/vkms/vkms_config.h

[ ... ]

> @@ -528,6 +532,53 @@ bool vkms_config_valid_plane_color_range(const struc=
t vkms_config *config,
>  					 const struct vkms_config_plane *plane_cfg);
>  #endif
> =20
> +static inline u32 *
> +vkms_config_plane_get_supported_formats(const struct vkms_config_plane *=
plane_cfg)
> +{
> +	return plane_cfg->supported_formats;
> +}
> +
> +static inline unsigned int
> +vkms_config_plane_get_supported_formats_count(struct vkms_config_plane *=
plane_cfg)
> +{
> +	return plane_cfg->supported_formats_count;
> +}
> +
> +/** vkms_config_plane_add_format - Add a format to the list of supported=
 format of a plane
> + *
> + * The passed drm_format can already be present in the list. This may fa=
il if the allocation of a
> + * bigger array fails.
> + *
> + * @plane_cfg: Plane to add the format to
> + * @drm_format: Format to add to this plane
> + *
> + * Returns: 0 on success, -ENOMEM if array allocation fails, -EINVAL if =
the format is not supported
> + * by VKMS
> + */
> +int __must_check vkms_config_plane_add_format(struct vkms_config_plane *=
plane_cfg, u32 drm_format);
> +
> +/**
> + * vkms_config_plane_add_all_formats - Helper to quickly add all the sup=
ported formats
> + * @plane_cfg: Plane to add the formats to
> + *
> + * Returns: 0 on success, -ENOMEM if array allocation fails
> + * by VKMS
> + */
> +int __must_check vkms_config_plane_add_all_formats(struct vkms_config_pl=
ane *plane_cfg);

[Severity: Low]
In the kernel-doc comment for vkms_config_plane_add_format(), the function
name is on the opening /** line instead of the next line, and the body text
precedes the @plane_cfg and @drm_format parameter descriptions, which
scripts/kernel-doc rejects.  Also, the Returns description for
vkms_config_plane_add_all_formats() has a stray "by VKMS" line left over
from vkms_config_plane_add_format().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-vkms-all-c=
onfig-v7-0-21194cda2468@bootlin.com?part=3D25
