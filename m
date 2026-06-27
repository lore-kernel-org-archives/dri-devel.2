Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24ABEC43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:48:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78C0410F779;
	Sat, 27 Jun 2026 03:48:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WY+y1Thz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D77C910F77B
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 03:48:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BFE3C43B9F;
 Sat, 27 Jun 2026 03:48:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73CD11F000E9;
 Sat, 27 Jun 2026 03:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782532120;
 bh=kSWCnOdpfB1AcXOvBeOQFc21Vxbrd8NpUlPsGGpwSDo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WY+y1Thzf8fMb6lPvr9fBtFBkcJqdK3ZiH8ZL8fnowxRahMupTGnEc21qcaWhGoXh
 16X+rJvcvCAngZNYEgn3qTbvRZx1vW8ZKXBBQG30Ny0zF3bQrKXnmz44kQJ+Nkot4d
 KIvHlCVXTG+lucXmbr6gsSCYk866hLmnAzf/v1yz6UAMUpLiDu1mzfXqFhmgqfZd42
 finw/NfeuXcpbyXaWfF6k5vTJFft7gyyZdKc9cXEDC6BOwwhDhkC1W4B5Ka0+ShPDC
 oKfyai2jjWsbaJGBKIwGp45IABo8znvZEUF2C4CiD2BPLfT3OZIpUQ8CaIkZjbRun9
 GfwUsOMbEzb3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 31/38] drm/vkms: Introduce configfs for connector
 supported colorspace
To: "Louis Chauvet" <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260627-vkms-all-config-v5-31-854aa0840926@bootlin.com>
References: <20260627-vkms-all-config-v5-0-854aa0840926@bootlin.com>
 <20260627-vkms-all-config-v5-31-854aa0840926@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 03:48:40 +0000
Message-Id: <20260627034840.73CD11F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Missing validation for `supported_colorspaces` against connector=
 types, leading to silent configuration failure.
- [Low] Passing an `int *` to `kstrtouint()` instead of an `unsigned int *`=
, and mismatched variable types for colorspaces.
--

commit 2994a2a64dd308b728cfd70f48204aeb77b66762
Author: Louis Chauvet <louis.chauvet@bootlin.com>

drm/vkms: Introduce configfs for connector supported colorspace
   =20
Add the attribute supported_colorspaces to configure the supported
colorspace of a connector. It will allows emulating some HDR features of
displays. This feature is only supported for HDMI, DP and eDP connectors.

> diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/=
vkms_configfs.c
> index 8b414f1950e8e..e1f6e7817f972 100644
> --- a/drivers/gpu/drm/vkms/vkms_configfs.c
> +++ b/drivers/gpu/drm/vkms/vkms_configfs.c
[ ... ]
> @@ -1180,12 +1180,52 @@ static ssize_t connector_type_store(struct config=
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
> +	scoped_guard(mutex, &connector->dev->lock)
> +	colorspaces =3D vkms_config_connector_get_supported_colorspaces(connect=
or->config);

[Severity: Low]
Does this code assign a u32 value to a signed int?

vkms_config_connector_get_supported_colorspaces() returns a u32, but
colorspaces is declared as an int.

> +
> +	return sprintf(page, "%u", colorspaces);
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

[Severity: Low]
Does this code pass an int pointer to an API expecting an unsigned int poin=
ter?

kstrtouint() expects an unsigned int * for its third argument, but val is
declared as an int.

> +	if (ret)
> +		return ret;
> +
> +	if ((val & -BIT(DRM_MODE_COLORIMETRY_COUNT)) !=3D 0)
> +		return -EINVAL;
> +
> +	scoped_guard(mutex, &connector->dev->lock) {
> +		if (connector->dev->enabled)
> +			return -EBUSY;
> +
> +		vkms_config_connector_set_supported_colorspaces(connector->config, val=
);

[Severity: Medium]
Since this feature is only supported for HDMI, DP, and eDP connectors, is
there any validation that prevents users from configuring this on unsupport=
ed
connector types?

If users configure this attribute on an unsupported connector (like the def=
ault
VIRTUAL type), it appears it will be accepted here but silently ignored lat=
er
when the device is initialized.

Would it make sense to reject unsupported configurations in
vkms_config_is_valid() or similar validation logic to prevent misleading
userspace?

> +	}
> +
> +	return count;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627-vkms-all-c=
onfig-v5-0-854aa0840926@bootlin.com?part=3D31
