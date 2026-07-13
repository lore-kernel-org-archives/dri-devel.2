Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F1ADC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 05:48:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 969EC10E7A8;
	Mon, 13 Jul 2026 05:48:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LD6ZAr8e";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CA7C10E7A8
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 05:48:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 97FE14328D;
 Mon, 13 Jul 2026 05:48:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5435A1F000E9;
 Mon, 13 Jul 2026 05:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783921723;
 bh=84agCsdfIKzQxWoPiUaE8OGnbw4Baiigi1dlH6qtqmQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LD6ZAr8e+w5gg9deM2pPu/ZWXVdHbmyflsWRuBlu0x8aRLd/uowMvbx+nnIRlTF73
 q/bOcD2P94TXy7XpzG68KOEp5Lr0C8WlAn79oSD4hzIiQRZm77EaoF0DD4qCNFuXW4
 m0HKv+EaEYfswm+eKKZlsb9XGdpDJh/Jnxjsb7+zAYklKkdf39LirmhxnXBY47kX7r
 Vx3KGzCzNcLTZsQWyNRLjQeujj2Zl55i5tSL0Jq9QxhJFJeXr5T50E4lI1Dd6BDVkC
 zGAPlQrh5ZGfsGgZ3KtLWs3lmWJkZf5TiyWJoakW1JUgG4GuhSzUA//QMbFr7aL1TJ
 gpsnZUk5oYj6w==
From: sashiko-bot@kernel.org
Subject: Re: [CI v4 01/14] drm/colorop: Add DRM_COLOROP_FIXED_MATRIX
To: "Chaitanya Kumar Borah" <chaitanya.kumar.borah@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260713051516.4087420-2-chaitanya.kumar.borah@intel.com>
References: <20260713051516.4087420-1-chaitanya.kumar.borah@intel.com>
 <20260713051516.4087420-2-chaitanya.kumar.borah@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 05:48:42 +0000
Message-Id: <20260713054843.5435A1F000E9@smtp.kernel.org>
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
- [Medium] The `u64 supported_fm` bitmask is incorrectly validated using th=
e 32-bit `BIT()` macro, causing the validation to ignore invalid high bits =
on 32-bit systems.
--

--- Patch [1]: [CI v4 01/14] drm/colorop: Add DRM_COLOROP_FIXED_MATRIX ---
commit c09a55528ad3801e2bc4cab04c676078a00cc4e2
Author: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>

drm/colorop: Add DRM_COLOROP_FIXED_MATRIX

Introduce DRM_COLOROP_FIXED_MATRIX, a new colorop type representing a
hardware that performs a fixed matrix operation. Userspace selects one of
the predefined hardware modes via a new FIXED_MATRIX_TYPE enum property.

> diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
> index 682fcc6515259..483defad699c0 100644
> --- a/drivers/gpu/drm/drm_colorop.c
> +++ b/drivers/gpu/drm/drm_colorop.c

[ ... ]

> @@ -453,6 +462,80 @@ int drm_plane_colorop_3dlut_init(struct drm_device *=
dev, struct drm_colorop *col
>  }
>  EXPORT_SYMBOL(drm_plane_colorop_3dlut_init);
> =20
> +/**
> + * drm_plane_colorop_fixed_matrix_init - Initialize a DRM_COLOROP_FIXED_=
MATRIX
> + *
> + * @dev: DRM device
> + * @colorop: The drm_colorop object to initialize
> + * @plane: The associated drm_plane
> + * @funcs: control functions for the new colorop
> + * @supported_fm: A bitfield of supported drm_colorop_fixed_matrix_type =
enum values,
> + *               created using BIT(fixed_matrix_type) and combined with =
the OR '|'
> + *               operator.
> + * @flags: bitmask of misc, see DRM_COLOROP_FLAG_* defines.
> + * @return zero on success, -E value on failure
> + */
> +int drm_plane_colorop_fixed_matrix_init(struct drm_device *dev, struct d=
rm_colorop *colorop,
> +					struct drm_plane *plane,
> +					const struct drm_colorop_funcs *funcs,
> +					u64 supported_fm, uint32_t flags)
> +{
> +	struct drm_prop_enum_list enum_list[DRM_COLOROP_FM_COUNT];
> +	int i, len;
> +	struct drm_property *prop;
> +	int ret;
> +
> +	if (!supported_fm) {
> +		drm_err(dev,
> +			"No supported FM type op for new Fixed Matrix colorop on [PLANE:%d:%s=
]\n",
> +			plane->base.id, plane->name);
> +		return -EINVAL;
> +	}
> +
> +	if ((supported_fm & -BIT(DRM_COLOROP_FM_COUNT)) !=3D 0) {

[Severity: Medium]
Will this check ignore invalid high bits in supported_fm on 32-bit systems?

Since supported_fm is a u64, using the 32-bit BIT() macro on a 32-bit
architecture means -BIT(DRM_COLOROP_FM_COUNT) will result in a 32-bit
unsigned long (e.g., 0xFFFFFFE0UL). When bitwise-ANDed with a u64, this mask
zero-extends to 0x00000000FFFFFFE0ULL, causing any invalid bits set in the
upper 32 bits to be silently ignored instead of returning -EINVAL.

Would it be safer to use BIT_ULL() or GENMASK_ULL() here?

> +		drm_err(dev, "Unknown Fixed Matrix provided on [PLANE:%d:%s]\n",
> +			plane->base.id, plane->name);
> +		return -EINVAL;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713051516.4087=
420-1-chaitanya.kumar.borah@intel.com?part=3D1
