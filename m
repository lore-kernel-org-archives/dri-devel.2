Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B16D6C43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:43:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1656210F75C;
	Sat, 27 Jun 2026 03:43:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XvoMSCFk";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7683E10F75C
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 03:43:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D2C81600AA;
 Sat, 27 Jun 2026 03:43:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D161F000E9;
 Sat, 27 Jun 2026 03:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782531800;
 bh=8PEwIauDXQ5E2y1AbHX2nBedTS/75bZ0HMBAHtxU4LA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XvoMSCFkQ+wEbjR6GaoKBZ5rnBc5JUYFX97aztYckUj7by3LiMn7MXsWBqC3aChHT
 kNs4lvNdGZurfJpnj+dkAP7JezfwQFVHIwcOaldSiR3p8bVvQdy1E1hj36gE/m4fLT
 dzxpCEUe/QGA6r4ugc9B9Ex8q7pXw2odlvuzsqvpx/4WGKtR893PdSyiNNSoDpru6T
 peWyAAmuUNI9l2qRyCRnbNV9VTsl1pIeYLsC29fX1an2EQxUl4lgb4p2m6GDa9NEnl
 MV7eQYW9Qwly4FH5W1YnIrJlRgW4/WckvxkTmsgE8hQ95MVLEmBwO9A07KRcXqQai6
 RcZAe5sEw4Axg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 18/38] drm/vkms: Introduce config for plane color
 encoding
To: "Louis Chauvet" <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260627-vkms-all-config-v5-18-854aa0840926@bootlin.com>
References: <20260627-vkms-all-config-v5-0-854aa0840926@bootlin.com>
 <20260627-vkms-all-config-v5-18-854aa0840926@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 03:43:19 +0000
Message-Id: <20260627034320.56D161F000E9@smtp.kernel.org>
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
- [High] Type mismatch and format string vulnerabilities in show_bitfield c=
ausing build failures and KCFI panics
--

commit 2751d72859c546f6b3eb551641e51316a31f2b9f
Author: Louis Chauvet <louis.chauvet@bootlin.com>

drm/vkms: Introduce config for plane color encoding

VKMS driver supports all the color encoding on planes, but for testing it
can be useful to only advertise few of them. This new configuration
interface will allow configuring the color encoding per planes.

> diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vk=
ms_config.c
> index ca3ee3aa2c41f..2fa467f5e17ed 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.c
> +++ b/drivers/gpu/drm/vkms/vkms_config.c
[ ... ]
> @@ -373,6 +395,22 @@ bool vkms_config_is_valid(const struct vkms_config *=
config)
>  }
>  EXPORT_SYMBOL_IF_KUNIT(vkms_config_is_valid);
> =20
> +static void show_bitfield(struct seq_file *m, uint32_t value, const char=
 *callback(unsigned int))
> +{
> +	u32 offset =3D 0;
> +	bool first =3D true;
> +
> +	while (value >=3D BIT(offset) && offset < 32) {
> +		if (value & BIT(offset)) {
> +			if (!first)
> +				seq_puts(m, ",");
> +			seq_printf(m, callback(offset));

[Severity: High]
Does this trigger a format-security build error?=20

Passing the result of callback() directly to seq_printf() without a format
string literal can cause format string vulnerabilities and typically breaks
the build under -Werror=3Dformat-security.

Should this use seq_printf(m, "%s", callback(offset)) instead?

> +			first =3D false;
> +		}
> +		offset +=3D 1;
> +	}
> +}
> +
>  static int vkms_config_show(struct seq_file *m, void *data)
>  {
[ ... ]
> @@ -398,6 +436,12 @@ static int vkms_config_show(struct seq_file *m, void=
 *data)
>  			   DRM_ROTATION_FMT_ARGS(vkms_config_plane_get_supported_rotations(pl=
ane_cfg)));
>  		seq_printf(m, "\tdefault rotation=3D" DRM_ROTATION_FMT "\n",
>  			   DRM_ROTATION_FMT_ARGS(vkms_config_plane_get_default_rotation(plane=
_cfg)));
> +		seq_puts(m, "\tsupported color encoding=3D");
> +		show_bitfield(m, vkms_config_plane_get_supported_color_encodings(plane=
_cfg),
> +			      drm_get_color_encoding_name);

[Severity: High]
Can this mismatch cause a KCFI kernel panic and compiler warnings?

The show_bitfield() function expects a callback taking an unsigned int, but
drm_get_color_encoding_name() takes an enum drm_color_encoding. Because C
treats enums and unsigned ints as distinct types for function signatures,
this mismatch triggers a -Wincompatible-pointer-types warning.

If executed on a kernel with Kernel Control-Flow Integrity (KCFI) enabled,
this indirect call mismatch will result in a kernel panic when a user reads
the debugfs endpoint.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627-vkms-all-c=
onfig-v5-0-854aa0840926@bootlin.com?part=3D18
