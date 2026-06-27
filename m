Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8082FC43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:48:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE7BE10F785;
	Sat, 27 Jun 2026 03:48:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ShS/OnQF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2100110F77A
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 03:48:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 88A4E600AA;
 Sat, 27 Jun 2026 03:48:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A6871F000E9;
 Sat, 27 Jun 2026 03:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782532109;
 bh=9cK1Wh5lqv19EiKk1+10WWtobHH8JjRt49uku7UH0Ys=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ShS/OnQF3X7yQ56ztal40b8xqG+JAhd3LZ15aDZmGL6aozQsPXqCbC+oDLou5RH5Y
 OFV5HskfFAdLDzfI7SUlgzRqki9FkBsQRmvCgD/o4fnwWAfiTa24cwsjRJxUaVjGvJ
 8J5tHlCV7T5yBzNjubADDukJZtjuNbM1qKB2iX5YkUgDyWk78kZUUgyBnzv5y+IJ61
 2GV8bXbNHrDIPecDcYruNoz3VZR9c8cAuVJ1N7W2EcDtdsO8JwcC6eFDSvl1ae9DvJ
 88CxYBVqvosQ8tpI9nrI+WeB7pc3Z7f0P7styq+CJdKkRLiHIaPKPRN+bR4ebk22BH
 RfTB8ex/1jhoA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 32/38] drm/vkms: Introduce config for connector EDID
To: "Louis Chauvet" <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260627-vkms-all-config-v5-32-854aa0840926@bootlin.com>
References: <20260627-vkms-all-config-v5-0-854aa0840926@bootlin.com>
 <20260627-vkms-all-config-v5-32-854aa0840926@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 03:48:28 +0000
Message-Id: <20260627034829.1A6871F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] The custom EDID buffer allocated in `vkms_config_connector_set_e=
did()` is never freed when the connector configuration is destroyed, leadin=
g to a memory leak.
- [Medium] Disabling EDID on a connector fails to clear the previously set =
EDID property from the DRM connector object.
- [Low] Pointer type mismatch when passing `&edid_len` to `vkms_config_conn=
ector_get_edid()`, which causes an incompatible-pointer-types warning.
- [Low] `vkms_config_connector_set_edid()` fails silently if memory allocat=
ion fails, providing no way for callers to handle the error.
--

commit 496ec62fb3c1660fbef4e163900774284133adaa
Author: Louis Chauvet <louis.chauvet@bootlin.com>

    drm/vkms: Introduce config for connector EDID
   =20
    Allows configuration of EDID for each connector.

> diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vk=
ms_config.h
> index 80bbc13aad79b..7e361b6e45b0e 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.h
> +++ b/drivers/gpu/drm/vkms/vkms_config.h
[ ... ]
> @@ -274,6 +280,75 @@ vkms_config_connector_get_supported_colorspaces(cons=
t struct vkms_config_connect
[ ... ]
> +static inline void
> +vkms_config_connector_set_edid(struct vkms_config_connector *connector_c=
fg,
> +			       const u8 *edid, unsigned int len)
> +{
> +	if (len) {
> +		void *edid_tmp =3D krealloc(connector_cfg->edid, len, GFP_KERNEL);

[Severity: Medium]
Does this code leak the memory allocated for the EDID buffer?

The buffer is dynamically allocated here, but it doesn't appear to be freed
when the connector configuration is torn down in
vkms_config_destroy_connector(). This could cause a leak when userspace
creates and destroys dynamic connectors with EDID data via configfs.

[Severity: Low]
Should this function return an error code rather than void?

If the krealloc() allocation fails, it fails silently. Callers (like
userspace writing to the configfs attribute) will assume the operation
succeeded, leaving the connector with an inconsistent or outdated EDID.

> +
> +		if (edid_tmp) {
> +			connector_cfg->edid =3D edid_tmp;
> +			memcpy(connector_cfg->edid, edid, len);
> +			connector_cfg->edid_len =3D len;
> +		}
> +	} else {
> +		kfree(connector_cfg->edid);
> +		connector_cfg->edid =3D NULL;
> +		connector_cfg->edid_len =3D len;
> +	}
> +}
> +
[ ... ]
> diff --git a/drivers/gpu/drm/vkms/vkms_connector.c b/drivers/gpu/drm/vkms=
/vkms_connector.c
> index a1f08167def1d..fe42ab2ba7b10 100644
> --- a/drivers/gpu/drm/vkms/vkms_connector.c
> +++ b/drivers/gpu/drm/vkms/vkms_connector.c
> @@ -42,13 +42,55 @@ static const struct drm_connector_funcs vkms_connecto=
r_funcs =3D {
>  	.atomic_destroy_state =3D drm_atomic_helper_connector_destroy_state,
>  };
> =20
> +static int vkms_connector_read_block(void *context, u8 *buf, unsigned in=
t block, size_t len)
> +{
> +	struct vkms_config_connector *config =3D context;
> +	unsigned int edid_len;
> +	const u8 *edid =3D vkms_config_connector_get_edid(config, &edid_len);

[Severity: Low]
Does this cause a compiler warning about incompatible pointer types?

The variable edid_len is declared as unsigned int, but its address is passed
to vkms_config_connector_get_edid(), which expects an int pointer for its
length parameter.

> +
> +	if (block * len + len > edid_len)
> +		return 1;
> +	memcpy(buf, &edid[block * len], len);
> +	return 0;
> +}
> +
>  static int vkms_conn_get_modes(struct drm_connector *connector)
>  {
[ ... ]
> +			/*
> +			 * Unconditionally update the connector. If the EDID was read
> +			 * successfully, fill in the connector information derived from the
> +			 * EDID. Otherwise, if the EDID is NULL, clear the connector
> +			 * information.
> +			 */
> +			drm_edid_connector_update(connector, drm_edid);
> +
> +			count =3D drm_edid_connector_add_modes(connector);
> +
> +			drm_edid_free(drm_edid);
> +		} else {
> +			count =3D drm_add_modes_noedid(connector, XRES_MAX, YRES_MAX);
> +			drm_set_preferred_mode(connector, XRES_DEF, YRES_DEF);

[Severity: Medium]
Should we call drm_edid_connector_update(connector, NULL) in this else bran=
ch?

If a connector is configured with EDID enabled, drm_edid_connector_update()
is called above to attach the property. If it is later dynamically changed
to disable EDID, this branch fails to clear the DRM connector object's EDID
property, which could leave stale EDID data exposed to userspace.

> +		}
> +	}
> =20
>  	return count;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627-vkms-all-c=
onfig-v5-0-854aa0840926@bootlin.com?part=3D32
