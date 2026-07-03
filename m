Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED9EFC43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 03:15:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 524CD10F61B;
	Fri,  3 Jul 2026 03:15:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eL8wKO3b";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6F9410F61B
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 03:15:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3628560210;
 Fri,  3 Jul 2026 03:15:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B637D1F000E9;
 Fri,  3 Jul 2026 03:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783048527;
 bh=b0uATuJOXlHPX5p4Sp8IjK5lkLJEkuYJBEaytyAxbsw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eL8wKO3bHycTog86WpS5C7Hh/uBlvu5gwGVAh/ibHyjP8N6XG9J6GEuviZgt6nhnc
 tGGCdc3Xya6r9RhjXBT+AgJQGWw5s273b9+WzBqTKsvND9djo0nihJ8kuvkNlqp9xw
 QOFZVWlk2dzSRMzFaWra9oy1crry5KDJ7/4E5Ib6+wzDqVXdjfAdLGWONUq9YS0vbO
 kn+INZWI8L4nKCKY2LskYDARhyIL5e0xls/jzPAoEaMCqO1fAHEYMEKXskT56n+q+D
 Jd2XeaTBT2qYPiQejv1PnGLbvBNqsBTUzNFJE6O7lsZNJop3oPkQNMIAy3mAXW7dAK
 gQKOJ+9BzqLSg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 01/10] drm/vino: add DisplayLink DL3 dock
 skeleton and protocol framing
To: "Mike Lothian" <mike@fireburn.co.uk>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260703030217.2886-2-mike@fireburn.co.uk>
References: <20260617151249.2937-1-mike@fireburn.co.uk>
 <20260703030217.2886-1-mike@fireburn.co.uk>
 <20260703030217.2886-2-mike@fireburn.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 03:15:27 +0000
Message-Id: <20260703031527.B637D1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The `DRM_VINO` Kconfig selects a non-existent symbol `CRYPTO_LIB=
_RSA`.
- [Medium] Selecting `RUST_DRM_GEM_SHMEM_HELPER` without inheriting its `MM=
U` dependency.
- [Low] Enabling `CONFIG_DRM_VINO` breaks the kernel build because the modu=
le's root source file is missing.
--

commit 06fb786f2554d0076260c52a80817260c6d10437
Author: Mike Lothian <mike@fireburn.co.uk>

drm/vino: add DisplayLink DL3 dock skeleton and protocol framing

This commit introduces the module skeleton for the new DisplayLink DL3 USB
dock driver. It adds Kconfig and Makefile entries and includes standalone
wire framing protocol and randomness wrapper code.

> diff --git a/drivers/gpu/drm/vino/Kconfig b/drivers/gpu/drm/vino/Kconfig
> new file mode 100644
> index 0000000000000..f5fe6670a4886
> --- /dev/null
> +++ b/drivers/gpu/drm/vino/Kconfig
> @@ -0,0 +1,20 @@
> +# SPDX-License-Identifier: GPL-2.0
> +config DRM_VINO
> +	tristate "DisplayLink DL3 (Vino) open driver"
> +	depends on USB
> +	depends on DRM
> +	depends on RUST
> +	select DRM_KMS_HELPER
> +	select RUST_DRM_GEM_SHMEM_HELPER

[Severity: Medium]
Does DRM_VINO also need to depend on MMU? RUST_DRM_GEM_SHMEM_HELPER depends=
 on
DRM and MMU. Selecting it without inheriting the MMU dependency can trigger
unmet direct dependency warnings and potential build failures on MMU-less
architectures.

> +	select CRYPTO_LIB_RSA

[Severity: Medium]
Is CRYPTO_LIB_RSA the correct Kconfig symbol? It appears this symbol does n=
ot
exist in the kernel tree, and the correct symbol might be CRYPTO_RSA. Selec=
ting
a non-existent symbol causes the directive to be ignored and can silently l=
eave
crypto dependencies disabled.

> +	help
> +	  Open in-kernel Rust driver for DisplayLink DL3 USB docks (Dell

[ ... ]

> diff --git a/drivers/gpu/drm/vino/Makefile b/drivers/gpu/drm/vino/Makefile
> new file mode 100644
> index 0000000000000..6e39668040f30
> --- /dev/null
> +++ b/drivers/gpu/drm/vino/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_DRM_VINO) +=3D vino.o

[Severity: Low]
Could this break the build if CONFIG_DRM_VINO is enabled at this specific
commit? It looks like there is no corresponding vino.rs or vino.c added yet,
which causes a missing target error.

I noticed the missing source file is introduced in the subsequent commit
"drm/vino: add the DisplayLink DL3 dock driver", but this temporary state m=
ight
break kernel bisectability.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703030217.2886=
-1-mike@fireburn.co.uk?part=3D1
