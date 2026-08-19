Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D13EC5DF6D
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 07:38:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 915B810EB1F;
	Wed, 19 Aug 2026 07:38:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LTLwCynn";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F75A10EB1F
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 07:38:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8D71560A58;
 Wed, 19 Aug 2026 07:38:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2714F1F00A3A;
 Wed, 19 Aug 2026 07:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787125114;
 bh=s8Huy3Upxy9lGtdRKBlBuSN3IvKsB6c97D5tWgCIXP4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LTLwCynnVewzajI7MfK49GOrV/m6SuYPNmDXt2rqXnW2PXHVK8LxTBu1AGpK1wMG2
 K2EvtdUYcBKX+vJTvj7XBhhBdMk9BB+zOxGhWhsl2cxp6bgebA6KkDj0zOEGxUBrYr
 sqyxGYrVrPTEz1ucfqufQmS1LqP0tvUdVtq2LPd1cSyTUJ3ZFcvihhxSfFbRpCCXjC
 pzee6cMNZJiW4RoDs87kfRfc8etoOiqOAQJVwS4s1WRtPc520ZRh3JKv2GxFX57aa1
 BnAnzNtPxc9ayjcKQZ/4TEAlkHeu2aJ7DpI/CkFE9nYLkpg7EnxpYRY/TW7Q6h2OZ0
 W5msMQlbJvdfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/gud: validate TV mode names before creating enum
 property
To: "Tao Yu" <tao1.yu@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260819072835.4074130-1-tao1.yu@intel.com>
References: <20260819072835.4074130-1-tao1.yu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 07:38:33 +0000
Message-Id: <20260819073834.2714F1F00A3A@smtp.kernel.org>
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

Pre-existing issues:
- [High] A malicious or non-compliant USB device can cause a kernel NULL po=
inter dereference in `drm_object_attach_property` by ordering TV properties=
 such that `GUD_PROPERTY_TV_MODE` is returned after other TV properties.
--

--- Patch [1]: [PATCH] drm/gud: validate TV mode names before creating enum=
 property ---
commit db9280e75e6e04eacd06127a0240a5d76af230f9
Author: Tao Yu <tao1.yu@intel.com>

drm/gud: validate TV mode names before creating enum property

The GUD protocol returns TV mode names as fixed-size entries that require
NUL-termination. This commit validates that each returned TV mode name
contains a NUL terminator within its fixed-size slot before passing it to
the DRM property code, preventing an out-of-bounds read in strlen().

> diff --git a/drivers/gpu/drm/gud/gud_connector.c b/drivers/gpu/drm/gud/gu=
d_connector.c
> index ea0cca58b7c89..8141c3a1e30ad 100644
> --- a/drivers/gpu/drm/gud/gud_connector.c
> +++ b/drivers/gpu/drm/gud/gud_connector.c
> @@ -396,8 +396,16 @@ static int gud_connector_add_tv_mode(struct gud_devi=
ce *gdrm, struct drm_connect
>  	}
> =20
>  	num_modes =3D ret / GUD_CONNECTOR_TV_MODE_NAME_LEN;
> -	for (i =3D 0; i < num_modes; i++)
> -		modes[i] =3D &buf[i * GUD_CONNECTOR_TV_MODE_NAME_LEN];
> +	for (i =3D 0; i < num_modes; i++) {
> +		char *mode =3D &buf[i * GUD_CONNECTOR_TV_MODE_NAME_LEN];
> +
> +		if (!memchr(mode, '\0', GUD_CONNECTOR_TV_MODE_NAME_LEN)) {
> +			ret =3D -EIO;
> +			goto free;
> +		}
> +
> +		modes[i] =3D mode;
> +	}
> =20
>  	ret =3D drm_mode_create_tv_properties_legacy(connector->dev, num_modes,=
 modes);

[Severity: High]
This is a pre-existing issue, but can a malicious or non-compliant USB devi=
ce
cause a kernel NULL pointer dereference in drm_object_attach_property() by
ordering TV properties such that GUD_PROPERTY_TV_MODE is returned after oth=
er
TV properties?

If a USB device returns GUD_PROPERTY_TV_HUE (or similar TV properties) befo=
re
GUD_PROPERTY_TV_MODE, gud_connector_add_properties() processes it and calls
drm_mode_create_tv_properties_legacy(drm, 0, NULL). This initializes
dev->mode_config.tv_select_subconnector_property but leaves
legacy_tv_mode_property as NULL since num_modes is 0.

Later, when GUD_PROPERTY_TV_MODE is processed, gud_connector_add_tv_mode()
calls drm_mode_create_tv_properties_legacy() here with actual modes. Because
tv_select_subconnector_property is already set, this second call hits an
early return in drm_mode_create_tv_properties_legacy():

drivers/gpu/drm/drm_connector.c:drm_mode_create_tv_properties_legacy() {
	if (dev->mode_config.tv_select_subconnector_property)
		return 0;
...

This immediately succeeds without creating legacy_tv_mode_property.
gud_connector_property_lookup() is then called for GUD_PROPERTY_TV_MODE and
returns the uninitialized config->legacy_tv_mode_property, which is NULL.

In gud_connector_add_properties():

	property =3D gud_connector_property_lookup(connector, prop);
	if (drm_WARN_ON(drm, IS_ERR(property)))
		continue;

The IS_ERR(property) check fails to catch NULL, and
drm_object_attach_property() is called with the NULL property,
unconditionally dereferencing property->dev.

>  free:
>  	kfree(buf);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819072835.4074=
130-1-tao1.yu@intel.com?part=3D1
