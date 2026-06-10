Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FBA1CD8CB9
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 14:41:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 703CD10E9ED;
	Wed, 10 Jun 2026 14:41:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QMoTPnmI";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D26D510E9ED
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 14:41:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9CB73435EB;
 Wed, 10 Jun 2026 14:41:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659E71F00893;
 Wed, 10 Jun 2026 14:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781102460;
 bh=mvP6NEMtBHUKqCXRC2qMbrjVdyXpuQg8QhCZEjLoQvQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QMoTPnmId1+pbIjG7Z7iCoXNud6yROIvlnlAMZj9qQNmw6Ie74fLyNs/LEw/yjFLB
 CUPAl6q0UPJ3MLbE14fsPNOfA/o0BjL1q3PrLEp0ZcbhvuEX15eSFUPoq/ZhUrsoyC
 B0Q6rvaWzS0z4tfdsokTR47E9pPA8lWxLdr0+EfgxlHffX9pX/5iD14Ccf+qCL0fau
 RG+6+zDQRmjyqZvK+uDkzKuPuBcrXXHCNuW9eTYaeX8TVxxbVN4uppctkcnnwLHBsp
 HrqAlZRvCKmCTxrn7Nh8xMgqeSikmvv0mDv7VDeniFXqyivK+IH2tA8rS6EZZbpKy2
 ymgyEYwibWY1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/tests: Move test EDID data to separate .c file
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260610-test-edid-array-definition-fix-v2-1-9de4605c4869@collabora.com>
References: <20260610-test-edid-array-definition-fix-v2-1-9de4605c4869@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 14:40:59 +0000
Message-Id: <20260610144100.659E71F00893@smtp.kernel.org>
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
- [Low] The newly added drm_kunit_edid.c file is built as a loadable module=
 but lacks a MODULE_LICENSE() declaration.
--

commit 6969a389dfc7ebf286991ec9afae031d0abd753f
Author: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

drm/tests: Move test EDID data to separate .c file

This commit moves the test EDID array definitions from a header file into a=
 newly created drm_kunit_edid.c file. The arrays are exported so they can b=
e shared among different KUnit tests without duplicating data across multip=
le users.

Link: https://lore.kernel.org/r/04ff70850213ae0f75486b1a27a7edb6fb4e71c3@in=
tel.com/

> diff --git a/drivers/gpu/drm/tests/Makefile b/drivers/gpu/drm/tests/Makef=
ile
> index 3b83e6616fb25..e7193b49cf91f 100644
> --- a/drivers/gpu/drm/tests/Makefile
> +++ b/drivers/gpu/drm/tests/Makefile
> @@ -24,6 +24,7 @@ obj-$(CONFIG_DRM_KUNIT_TEST) +=3D \
>  	drm_probe_helper_test.o \
>  	drm_rect_test.o \
>  	drm_sysfb_modeset_test.o \
> -	drm_fixp_test.o
> +	drm_fixp_test.o \
> +	drm_kunit_edid.o

[ ... ]

> diff --git a/drivers/gpu/drm/tests/drm_kunit_edid.c b/drivers/gpu/drm/tes=
ts/drm_kunit_edid.c
> new file mode 100644
> index 0000000000000..0976372860627
> --- /dev/null
> +++ b/drivers/gpu/drm/tests/drm_kunit_edid.c
> @@ -0,0 +1,991 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/export.h>
> +
> +#include "drm_kunit_edid.h"

[Severity: Low]
Because drm_kunit_edid.o is added directly to obj-$(CONFIG_DRM_KUNIT_TEST) =
in
the Makefile, it will be built as a standalone module when that config is s=
et
to 'm'. Does this new file need to include <linux/module.h> and provide a
MODULE_LICENSE() declaration to prevent modpost warnings and a tainted kern=
el
when loaded?

> +
> +/*
> + * edid-decode (hex):
> + *
> + * 00 ff ff ff ff ff ff 00 31 d8 2a 00 00 00 00 00

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610-test-edid-=
array-definition-fix-v2-1-9de4605c4869@collabora.com?part=3D1
