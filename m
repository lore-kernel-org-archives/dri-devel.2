Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D32E9C4451B
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 05:22:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DA9D10E138;
	Mon, 20 Jul 2026 05:22:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IH4voaOO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4238910E138
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 05:22:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E839C41FEC;
 Mon, 20 Jul 2026 05:22:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13D91F000E9;
 Mon, 20 Jul 2026 05:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784524934;
 bh=Y3lyBAjtdefH8aeMSrI8KcN0EpFlZxHXmGHD6JHDn1M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IH4voaOOtFHvcsteF3xC4GjVNc5pTKvPTSdXnZ8jpU2cXK6jn5FMnpJJcEuUgrEt4
 ih30z9LLV9XF2F3o0JlgNsryToKx7loHJh1NFVcKtiMYYqAj/SlkIEiKWRkT4mZZuO
 7UNfQA3Sx2l+k+fOvpb2J0RbFiX6/l8Ie950hk9K8P6yj7b08gdeVnAht13damPk5k
 tJg4mSHFWQw9LZc9gkqJH1URE/fnpXhFMYGSPq/MUfMtuL790hj/HspwQcwgfIulj+
 6M8z9bF4uJ0GCD04agKtLfE98wDWHQ4o6KWTl2O7d4Kdj++1mJ4bOfwQsNuplpdsa/
 IwP2VtDnd8RrQ==
From: sashiko-bot@kernel.org
Subject: Re: [v5 01/14] drm/colorop: Add DRM_COLOROP_FIXED_MATRIX
To: "Chaitanya Kumar Borah" <chaitanya.kumar.borah@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260720045131.971650-2-chaitanya.kumar.borah@intel.com>
References: <20260720045131.971650-1-chaitanya.kumar.borah@intel.com>
 <20260720045131.971650-2-chaitanya.kumar.borah@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 05:22:14 +0000
Message-Id: <20260720052214.A13D91F000E9@smtp.kernel.org>
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
- [Medium] Validation of the 64-bit `supported_fm` mask uses the 32-bit `BI=
T()` macro, causing invalid bits in the upper 32 bits to silently bypass va=
lidation on 32-bit architectures.
--

--- Patch [1]: [v5 01/14] drm/colorop: Add DRM_COLOROP_FIXED_MATRIX ---
commit 25b997b331b57b2649988bc81ff156f876274b02
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
[ ... ]
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
Since supported_fm is a u64, could using the 32-bit BIT() macro here cause
validation issues on 32-bit architectures?

On 32-bit architectures, BIT() evaluates to an unsigned long (32 bits). When
negated and then promoted to u64 for the bitwise AND with supported_fm, it
zero-extends the upper 32 bits (e.g., 0x00000000FFFFFFE0ULL). This means any
invalid bits set in the upper 32 bits of supported_fm would be zeroed out
during the operation and silently bypass this validation check.

Would it be better to use BIT_ULL(DRM_COLOROP_FM_COUNT) or GENMASK_ULL to
ensure the mask is properly validated across its entire 64-bit range?

> +		drm_err(dev, "Unknown Fixed Matrix provided on [PLANE:%d:%s]\n",
> +			plane->base.id, plane->name);
> +		return -EINVAL;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720045131.9716=
50-1-chaitanya.kumar.borah@intel.com?part=3D1
