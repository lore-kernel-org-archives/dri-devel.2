Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10CBBC43211
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:46:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36AA510F775;
	Sat, 27 Jun 2026 03:46:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OYGDWAi1";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A66E710F774
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 03:46:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2AE07600AB;
 Sat, 27 Jun 2026 03:46:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A7B1F000E9;
 Sat, 27 Jun 2026 03:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782532014;
 bh=LeKsvUIoPa79aNui+8MjGn3ZiF/cprndXUQa9CnQGkE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OYGDWAi1quBE9QozjAcXyztGQN94lX4lZZ5E+UiA7mKqtIiG2kBD2cZmFSNtSjeKN
 EY/cKKDlTPp3VuDe1Paq7fhqt0taPK30EdtSCvgpkxdBeuyDViQlmvlXau5V/fjO6D
 rDTZecpYuooXpvgi4lkyOv3Qazb2HV0E6DKFCly9YM5mfH+yyanFGp1K1d4/eW6QqJ
 QGFMerBd+6WokBLmlaJRpNN5ioA10rHtsxkDsvtqk20JzzZQ1eHNgHSjEwkaOVPLjH
 Pha3GBbJjFy++OXTE91xr04swMJUbIzm2Xl/RN92D8qiV/0d5e28ffDTr38SQy0Is+
 YxuTU4uzc2qMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 17/38] drm/vkms: Introduce configfs for plane rotation
To: "Louis Chauvet" <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260627-vkms-all-config-v5-17-854aa0840926@bootlin.com>
References: <20260627-vkms-all-config-v5-0-854aa0840926@bootlin.com>
 <20260627-vkms-all-config-v5-17-854aa0840926@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 03:46:54 +0000
Message-Id: <20260627034654.B0A7B1F000E9@smtp.kernel.org>
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
- [Medium] `plane_default_rotation_store()` uses base 10 for string parsing=
, incorrectly rejecting documented hexadecimal values.
--

commit 5edae796c7d28ebd799b4c01972a95ad90e32c05
Author: Louis Chauvet <louis.chauvet@bootlin.com>
Subject: drm/vkms: Introduce configfs for plane rotation

This commit introduces a new configfs interface to configure available and
default rotations per plane in VKMS. It adds supported_rotations and
default_rotation attributes, allowing userspace to select any combination of
rotations and reflections.

> diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/=
vkms_configfs.c
> index 0744ac40814d8..47b3a4aeee8dd 100644
> --- a/drivers/gpu/drm/vkms/vkms_configfs.c
> +++ b/drivers/gpu/drm/vkms/vkms_configfs.c

[ ... ]

> +static ssize_t plane_default_rotation_store(struct config_item *item,
> +					    const char *page, size_t count)
> +{
> +	struct vkms_configfs_plane *plane =3D plane_item_to_vkms_configfs_plane=
(item);
> +	int ret, val =3D 0;
> +
> +	ret =3D kstrtouint(page, 10, &val);

[Severity: Medium]
Does this code incorrectly reject the documented hexadecimal values?

The ABI documentation specifies the rotation values as hex bitmasks (e.g.,
0x01, 0x10). While plane_supported_rotations_store() correctly uses base 0
for kstrtouint(), using base 10 here forces it to reject hexadecimal string=
s.
This breaks userspace tools or scripts attempting to write the documented
hexadecimal values to default_rotation, forcing them to use base-10 instead.

> +	if (ret)
> +		return ret;
> +
> +	/* Should be a supported value */
> +	if (val & ~(DRM_MODE_ROTATE_MASK | DRM_MODE_REFLECT_MASK))
> +		return -EINVAL;
> +
> +	/* Should contain exactly one rotation */
> +	if (!is_power_of_2(val & DRM_MODE_ROTATE_MASK))
> +		return -EINVAL;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627-vkms-all-c=
onfig-v5-0-854aa0840926@bootlin.com?part=3D17
