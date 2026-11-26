Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51431606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dDANz/Hl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD39711236B;
	Thu, 26 Nov 2026 11:46:30 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 508F511236B
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:46:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0D44A40C18;
 Thu, 26 Nov 2026 11:46:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2FD21F000C6;
 Thu, 26 Nov 2026 11:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795693583;
 bh=JWcH7NrT14KTkD8IoOKjqzv0ZAtTjgMD5+03Ddh61MI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dDANz/HlMExsD3pDvVr1vtyMiIs+DOARuaTw36Z8NAHqIxNgL47+ZvdPIK0Kbza+s
 rKVj6y7enYeiQbiuKPw9gSWv1NBI2R6iyaRSLq+mT6OjurJ6OEYBKgi3f2dMyYkm6R
 TbimzwkLbU1lwcLX+q/RiAWLuk+/O38iBIyItw6LAinx/A8NDZwG+2oa1oNgGkSblm
 qixanrZxSgKgq5D5YSPrvyxTUBn4Z9p6RnS8xmxYVM/vw6IFuW4crACiQABkBnPZyR
 b1e8Rj/TUoLw8dW+hiJ6G/Y4XLVe2InCk3FUsUG7613KMfJ5Ye2+dOOfUpO88pvBIo
 e74ZMqryolfcw==
Message-ID: <sashiko-outbox-235416@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 28/43] drm/vkms: Introduce config for plane zpos
 property
To: "Louis Chauvet" <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261126-vkms-all-config-v7-28-21194cda2468@bootlin.com>
References: <20261126-vkms-all-config-v7-0-21194cda2468@bootlin.com>
 <20261126-vkms-all-config-v7-28-21194cda2468@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 11:46:23 +0000
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
- [Low] drm/vkms: missing EXPORT_SYMBOL_IF_KUNIT for
  vkms_config_valid_plane_zpos()
- [Low] drm/vkms: signed %d format used for unsigned int zpos in
  vkms_config_show()
- [Low] drm/vkms: missing trailing newline in drm_info() in
  vkms_config_is_valid()
--

commit 95ea58aa0af1d2c1724667a97c3ee561ebede801
Author: Louis Chauvet <louis.chauvet@bootlin.com>

drm/vkms: Introduce config for plane zpos property

This commit adds configuration fields, accessors, validation, debugfs outpu=
t,
and KUnit tests for the plane zpos property in VKMS, and creates mutable or
immutable zpos properties during plane initialization when enabled.

> diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vk=
ms_config.c
> index 230346e56877f..342b844bfc6d4 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.c
> +++ b/drivers/gpu/drm/vkms/vkms_config.c
[ ... ]
> @@ -282,6 +285,33 @@ bool vkms_config_valid_plane_color_range(const struc=
t vkms_config *config,
>  }
>  EXPORT_SYMBOL_IF_KUNIT(vkms_config_valid_plane_color_range);
> =20
> +VISIBLE_IF_KUNIT
> +bool vkms_config_valid_plane_zpos(const struct vkms_config *config,
> +				  const struct vkms_config_plane *plane_cfg)
> +{
> +	struct drm_device *dev =3D config->dev ? &config->dev->drm : NULL;
> +
> +	if (!vkms_config_plane_get_zpos_enabled(plane_cfg) ||
> +	    !vkms_config_plane_get_zpos_mutable(plane_cfg))
> +		return true;
> +
> +	if (vkms_config_plane_get_zpos_initial(plane_cfg) >
> +	    vkms_config_plane_get_zpos_max(plane_cfg)) {
> +		drm_info(dev, "Configured initial zpos value bigger than zpos max\n");
> +		return false;
> +	}
> +
> +	if (vkms_config_plane_get_zpos_max(plane_cfg) <
> +	    vkms_config_plane_get_zpos_min(plane_cfg) ||
> +	    vkms_config_plane_get_zpos_initial(plane_cfg) <
> +	    vkms_config_plane_get_zpos_min(plane_cfg)) {
> +		drm_info(dev, "Configured zpos value outside (zpos min; zpos max)\n");
> +		return false;
> +	}
> +
> +	return true;
> +}

[Severity: Low]
Should vkms_config_valid_plane_zpos() have an
EXPORT_SYMBOL_IF_KUNIT(vkms_config_valid_plane_zpos) macro?

It is marked VISIBLE_IF_KUNIT and declared in vkms_config.h under
CONFIG_KUNIT, so calling it from vkms_config_test.c when CONFIG_DRM_VKMS and
CONFIG_DRM_VKMS_KUNIT_TEST are built as separate modules will fail to link =
at
modpost.

Also, unlike the sibling rotation, color encoding, and color range tests,
vkms_config_test_valid_plane_zpos() in vkms_config_test.c never calls
vkms_config_valid_plane_zpos() directly, repeats the zpos_mutable=3Dfalse t=
est
block with min=3D0 and max=3D0 instead of testing min > max while immutable=
, and
does not test the multi-plane mixed zpos_enabled rejection path in
vkms_config_is_valid().

> @@ -469,6 +502,19 @@ bool vkms_config_is_valid(const struct vkms_config *=
config)
>  				 "Both supported color encodings and color ranges must be set, or no=
ne\n");
>  			return false;
>  		}
> +
> +		if (!vkms_config_valid_plane_zpos(config, plane_cfg))
> +			return false;
> +
> +		if (vkms_config_plane_get_zpos_enabled(plane_cfg))
> +			has_zpos_enabled =3D true;
> +		else
> +			has_zpos_disabled =3D true;
> +	}
> +
> +	if (has_zpos_enabled && has_zpos_disabled) {
> +		drm_info(dev, "In the same device, all planes must have zpos enabled o=
r none of them");
> +		return false;
> +	}

[Severity: Low]
This isn't a bug, but the drm_info() format string here is missing a traili=
ng
newline.

> @@ -576,6 +622,16 @@ static int vkms_config_show(struct seq_file *m, void=
 *data)
>  			show_formats(m, vkms_config_plane_get_supported_formats(plane_cfg),
>  				     vkms_config_plane_get_supported_formats_count(plane_cfg));
>  			seq_puts(m, "\n");
> +			seq_printf(m, "\tzpos_enabled=3D%s\n",
> +				   str_true_false(vkms_config_plane_get_zpos_enabled(plane_cfg)));
> +			seq_printf(m, "\tzpos_mutable=3D%s\n",
> +				   str_true_false(vkms_config_plane_get_zpos_mutable(plane_cfg)));
> +			seq_printf(m, "\tzpos_min=3D%d\n",
> +				   vkms_config_plane_get_zpos_min(plane_cfg));
> +			seq_printf(m, "\tzpos_initial=3D%d\n",
> +				   vkms_config_plane_get_zpos_initial(plane_cfg));
> +			seq_printf(m, "\tzpos_max=3D%d\n",
> +				   vkms_config_plane_get_zpos_max(plane_cfg));
>  		}

[Severity: Low]
Should zpos_min, zpos_initial, and zpos_max be formatted with %u instead of
%d?  The underlying fields and getters use unsigned int, so values above
INT_MAX are printed as negative numbers in debugfs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-vkms-all-c=
onfig-v7-0-21194cda2468@bootlin.com?part=3D28
