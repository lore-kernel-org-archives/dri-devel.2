Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A733CD8CB2
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 12:25:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA4BA890CE;
	Wed, 10 Jun 2026 12:25:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="X8jrCxP/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08E26890CE
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 12:25:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A5AD9441B5;
 Wed, 10 Jun 2026 12:25:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E7861F00893;
 Wed, 10 Jun 2026 12:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781094324;
 bh=oenxNDddIaO7Ux/pZur0ThEmNLfH0uHd2NZETnPUjZ8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=X8jrCxP/21X2fhsl/XV9jdzJNn1kABjf/pwgE5JsnPkoM+EzuNRJYU7VMXHjjjhfi
 G9b7XlB2lOL4L+8svMgfhv7YahvyBNVFDtkRz5eQxZNzyC0jN6Jv3eMJ5we31J/Cj8
 hti0h69u162EnAdu9YcFZfOCHQqZWEsHHOIy5SO3/p82pvHh96OJQlzvktmoLkcPDf
 +5OJVG/r/XN+zjxU47j0rqEU7G5ygGhgTisxewksH4H5KEpg7VDvJjVt0Dw46brdfi
 ysX0VPb8iNvIsMxZjM1ZOygquzs1COI92dokq4SdKnzUkYj0et5oS2TL0QgUmPWtFq
 HDS0rZ6gEL/ww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/tests: Move test EDID data to separate .c file
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260610-test-edid-array-definition-fix-v1-1-4467ba487886@collabora.com>
References: <20260610-test-edid-array-definition-fix-v1-1-4467ba487886@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 12:25:24 +0000
Message-Id: <20260610122524.6E7861F00893@smtp.kernel.org>
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
- [Low] Missing `EXPORT_SYMBOL_GPL()` for EDID test arrays causes module bu=
ild failure when `CONFIG_DRM_KUNIT_TEST=3Dm`.
--

commit 981eca4f730b2b2f411ac7f7d770b14bbb79bd75
Author: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

drm/tests: Move test EDID data to separate .c file

This commit moves test EDID arrays from a header file to a separate .c file
to prevent duplicate definitions. The array declarations in the header are
updated to use extern and explicitly state their sizes.

Link: https://lore.kernel.org/r/04ff70850213ae0f75486b1a27a7edb6fb4e71c3@in=
tel.com/

> diff --git a/drivers/gpu/drm/tests/Makefile b/drivers/gpu/drm/tests/Makef=
ile
> index 3b83e6616fb25..e7193b49cf91f 100644
> --- a/drivers/gpu/drm/tests/Makefile
> +++ b/drivers/gpu/drm/tests/Makefile

[ ... ]

> @@ -24,6 +24,7 @@ obj-$(CONFIG_DRM_KUNIT_TEST) +=3D \
>  	drm_probe_helper_test.o \
>  	drm_rect_test.o \
>  	drm_sysfb_modeset_test.o \
> -	drm_fixp_test.o
> +	drm_fixp_test.o \
> +	drm_kunit_edid.o
> =20
>  CFLAGS_drm_mm_test.o :=3D $(DISABLE_STRUCTLEAK_PLUGIN)
> diff --git a/drivers/gpu/drm/tests/drm_kunit_edid.c b/drivers/gpu/drm/tes=
ts/drm_kunit_edid.c
> new file mode 100644
> index 0000000000000..fae92e5bef30a
> --- /dev/null
> +++ b/drivers/gpu/drm/tests/drm_kunit_edid.c
> @@ -0,0 +1,217 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "drm_kunit_edid.h"
> +
> +const unsigned char test_edid_dvi_1080p[] =3D {

[Severity: Low]
Does this code need to export the array variables using EXPORT_SYMBOL_GPL()?

When CONFIG_DRM_KUNIT_TEST=3Dm, Kbuild compiles each .o file added to
obj-$(CONFIG_DRM_KUNIT_TEST) as a separate loadable kernel module.

Without exporting these newly moved test arrays, will compiling other test
modules that reference them fail with undefined symbol errors during modpos=
t?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610-test-edid-=
array-definition-fix-v1-1-4467ba487886@collabora.com?part=3D1
