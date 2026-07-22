Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B4DC44536
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 23:05:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B0A610E4E6;
	Wed, 22 Jul 2026 23:05:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aBLivUoJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2B3D10E4E6
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 23:05:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6AA4E41175
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 23:05:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0041F000E9;
 Wed, 22 Jul 2026 23:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784761539;
 bh=UuK94EEC/rmkB+O7X+R91GKwq0wCj59QI02rdPbar0o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aBLivUoJMFiEdkNuAGzxTM+7d+61fLpcgOgNZ8gjtYg+08p5JcCH+d+qAon9JjODJ
 oi7140I6ca3Se5DqmNk4/pD868CHcjCYEltresA/8jhaUVrRyR5Kbzk6vnBsISMX9t
 aibe63wFV0zkdedVrknEbuyOIOV2AGbJsnAe1r0eRUril1v7oX8F+dxXYB+kzB2Gpo
 WQjLGD0hN7VfHHI6QeyODSgo/c+RyyzQOINur18JlXGjr7uSGXDZaFuhI9A64yU+Zy
 fPDSvcihWe+0j1KhW0T5ZX8ZifV8lthe3ZWEe5sY/zyclL4Kr9X0BzzbcJgtcrpU9q
 9N0w8AYqdDG8w==
From: sashiko-bot@kernel.org
Subject: Re: Semantic conflict between 04b177544a04 in drm-misc-fixes and
 0b6b1bb28482 in -mm
To: "Nathan Chancellor" <nathan@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260722225605.GA1910198@ax162>
References: <20260722225605.GA1910198@ax162>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 23:05:38 +0000
Message-Id: <20260722230539.2B0041F000E9@smtp.kernel.org>
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
- [High] Incomplete fix: clang build failure and undefined behavior remain =
when CONFIG_ARCH_HAS_PMD_SOFTLEAVES is disabled.
--

--- Patch [1]: Semantic conflict between 04b177544a04 in drm-misc-fixes and=
 0b6b1bb28482 in -mm ---
commit 7a0a17a611e56673b6f5328de62e23da9f7ca1e8
Author: Nathan Chancellor <nathan@kernel.org>

Semantic conflict between 04b177544a04 in drm-misc-fixes and 0b6b1bb28482 i=
n -mm

This commit resolves a semantic conflict by replacing
CONFIG_ARCH_ENABLE_THP_MIGRATION with CONFIG_ARCH_HAS_PMD_SOFTLEAVES.

> diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
> index 4a794544b7dcf..f00c27edbfb96 100644
> --- a/drivers/gpu/drm/drm_pagemap.c
> +++ b/drivers/gpu/drm/drm_pagemap.c
> @@ -12,7 +12,7 @@
>  #include <drm/drm_pagemap_util.h>
>  #include <drm/drm_print.h>
> =20
> -#if IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION)
> +#if IS_ENABLED(CONFIG_ARCH_HAS_PMD_SOFTLEAVES)
>  #define DRM_PAGEMAP_PMD_ORDER	HPAGE_PMD_ORDER
>  #else
>  #define DRM_PAGEMAP_PMD_ORDER	(-1)
         ^^^^

[Severity: High]
This is a pre-existing issue, but does this still leave an unresolved build
failure and undefined behavior when CONFIG_ARCH_HAS_PMD_SOFTLEAVES is
disabled?

When the configuration is disabled, the fallback branch defines
DRM_PAGEMAP_PMD_ORDER as (-1). Its usage later in drm_pagemap_cpages()
and drm_pagemap_migrate_to_devmem() results in undefined behavior:

drivers/gpu/drm/drm_pagemap.c:drm_pagemap_migrate_to_devmem() {
    ...
    order =3D DRM_PAGEMAP_PMD_ORDER;
    ...
    for (j =3D 1; j < NR_PAGES(order) && i + j < npages; j++)
    ...
}

NR_PAGES(-1) expands to 1U << 4294967295, causing Clang to stop generating
code and emit a trap instruction, which triggers the objtool warning and
will panic the kernel at runtime if reached.

Could this fallback be adjusted to prevent the undefined behavior when
the config is not enabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722225605.GA19=
10198@ax162?part=3D1
