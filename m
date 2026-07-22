Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD7EC44539
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:55:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38EBE10E457;
	Wed, 22 Jul 2026 13:55:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RqNd13yX";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D86310E457
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 13:55:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4E87343DE3;
 Wed, 22 Jul 2026 13:55:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124141F000E9;
 Wed, 22 Jul 2026 13:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784728512;
 bh=NxyHmn4vudlfdLvx06AlOd6smMyo4k/WJSnVw00nRIw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RqNd13yX6v6lK5V3STh31vVeX1HVxT6cG1v3xZwgfDMv3c32HqWBCKR/M091SBywk
 RT7fK4sTCs0vO7/FlAgktLJk7lP4WTJQeUVQGuyjJqhl37ThX8JbVFxrPkOnOjlxHK
 j3t/hg0//cYYRtSC93Najc6nTMuD+CWV72OfDSWWf1XrXXvOoT75fpfhAqRP7LJTWM
 1NshbhoHJBYd+C0VPjxqKsWYvnS7qMCT5T5/vbRq0AQdiZ5EJUJQJ+YNUG4g5GhKKW
 HUo7mZejk76B2p4+MBjbM27vPm/XpjEsDQGC2scYHQjaGXESstN+ew9tG94p4urEXW
 SzKt2lzD53ULQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/11] drm/colorop: Add DRM_COLOROP_FIXED_MATRIX
To: "Harry Wentland" <harry.wentland@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260722134607.136293-2-harry.wentland@amd.com>
References: <20260722134607.136293-1-harry.wentland@amd.com>
 <20260722134607.136293-2-harry.wentland@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 13:55:11 +0000
Message-Id: <20260722135512.124141F000E9@smtp.kernel.org>
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
- [Medium] Validation check for a 64-bit bitmask on 32-bit platforms incorr=
ectly uses the 32-bit `BIT()` macro, causing upper bits to be silently igno=
red.
--

--- Patch [1]: [PATCH v4 01/11] drm/colorop: Add DRM_COLOROP_FIXED_MATRIX -=
--
commit e2a1cc91ee8bca2062d87fc6c62ee5b47046aaf8
Author: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Subject: drm/colorop: Add DRM_COLOROP_FIXED_MATRIX

This commit introduces DRM_COLOROP_FIXED_MATRIX, a new colorop type
representing hardware that performs a fixed matrix operation. It adds a new
FIXED_MATRIX_TYPE enum property to select predefined hardware modes instead
of using programmable coefficients.

> diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
> index 682fcc6515259..e7ccf7d053b89 100644
> --- a/drivers/gpu/drm/drm_colorop.c
> +++ b/drivers/gpu/drm/drm_colorop.c
[ ... ]
> +int drm_plane_colorop_fixed_matrix_init(struct drm_device *dev, struct d=
rm_colorop *colorop,
> +					struct drm_plane *plane,
> +					const struct drm_colorop_funcs *funcs,
> +					u64 supported_fm, uint32_t flags)
> +{
[ ... ]
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
Since supported_fm is a u64, will this check properly mask the upper 32 bit=
s on
32-bit platforms where BIT() evaluates to a 32-bit unsigned long?

When -BIT(DRM_COLOROP_FM_COUNT) is promoted to 64 bits for the bitwise AND,=
 it
will be zero-extended, causing the upper 32 bits of the mask to be zero. Th=
is
could allow invalid upper bits in supported_fm to pass validation silently.

Should this use BIT_ULL() instead?

> +		drm_err(dev, "Unknown Fixed Matrix provided on [PLANE:%d:%s]\n",
> +			plane->base.id, plane->name);
> +		return -EINVAL;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722134607.1362=
93-1-harry.wentland@amd.com?part=3D1
