Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D9DCC5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:05:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 995A210ED99;
	Wed, 26 Aug 2026 17:05:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QFrAfF1/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2D0010ED99
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 17:05:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BB65A60AAA;
 Wed, 26 Aug 2026 17:05:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE541F00A3A;
 Wed, 26 Aug 2026 17:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787763900;
 bh=LCC++odvPoYrmsovxjJYGveOOazKmtuZz+wRo6OlP+g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QFrAfF1/UjfM7EVaKrXw7ojmmWq+T4AKTjSjtxXUClu8lcM5jxToTu/bx18rjKH04
 oiiOEiNtuAfOrpSAIOsZ50Z4VhGjJrj3xbm9uGi0W3LjGorw1T5+ba6wpI8zztmpKo
 2RXZ5nbZY+Ae1XoQim3Uqnpm+DrIVLuO3kdi9DB22xzOzBtA1cqBNnoDnFYH5uzT4g
 A/NkMKgU4xSJJK8fJSsB1nu1SxPpgxAOcHbEXzSM7Aa3beY3cc5mn8059eRVUpOqQF
 NKqqj1gqQhuSe5BH6YswukhJVsJJqCdEUDBoXBN4I9W4jwnjBeGzxamZTUVASEn/f4
 XyofIpJr0R+rQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 12/13] drm/vino: allow the driver to be built
To: "Mike Lothian" <mike@fireburn.co.uk>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260826163913.7052-13-mike@fireburn.co.uk>
References: <20260826163913.7052-1-mike@fireburn.co.uk>
 <20260826163913.7052-13-mike@fireburn.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 17:04:59 +0000
Message-Id: <20260826170459.ECE541F00A3A@smtp.kernel.org>
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
- [Low] Selecting CRYPTO_RSA without inheriting its dependency on CRYPTO ca=
uses unmet direct dependency warnings.
- [Low] The Kconfig selects non-existent config symbols: RUST_CRYPTO_AKCIPH=
ER, RUST_CRYPTO_LIB_AES, and RUST_CRYPTO_LIB_SHA256.
--

commit 580f8ac72cc85f194a430cb59459a83ca73e95c1
Author: Mike Lothian <mike@fireburn.co.uk>

drm/vino: allow the driver to be built

This commit adds the Kconfig entry, Makefile rule, and MAINTAINERS record
for the DRM driver for DisplayLink DL3 devices, allowing the driver to be
built as a module.

> diff --git a/drivers/gpu/drm/vino/Kconfig b/drivers/gpu/drm/vino/Kconfig
> new file mode 100644
> index 0000000000000..fcc761b4654b7
> --- /dev/null
> +++ b/drivers/gpu/drm/vino/Kconfig
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: GPL-2.0
> +config DRM_VINO
> +	tristate "DisplayLink DL3 (Vino) open driver"
> +	depends on USB
> +	depends on DRM
> +	depends on RUST
> +	# RUST_DRM_GEM_SHMEM_HELPER depends on MMU; inherit that dependency her=
e so the
> +	# select below cannot generate an unmet-direct-dependency warning on no=
mmu.
> +	depends on MMU
> +	select DRM_KMS_HELPER
> +	select RUST_DRM_GEM_SHMEM_HELPER
> +	select CRYPTO_RSA

[Severity: Low]
Will this select statement cause unmet direct dependency warnings if the
CRYPTO core is disabled?

Selecting CRYPTO_RSA without inheriting its dependency on CRYPTO can cause
Kconfig warnings and potential build failures (linking errors for missing
crypto core functions) if CRYPTO_RSA is forcibly enabled while the CRYPTO
core is disabled.

> +	select RUST_CRYPTO_AKCIPHER
> +	select RUST_CRYPTO_LIB_AES
> +	select RUST_CRYPTO_LIB_SHA256

[Severity: Low]
Are these Kconfig symbols actually defined in the kernel tree?

It appears that RUST_CRYPTO_AKCIPHER, RUST_CRYPTO_LIB_AES, and
RUST_CRYPTO_LIB_SHA256 do not exist anywhere in Kconfig. Selecting
non-existent symbols has no effect, which can lead to silent build failures
(like missing Rust bindings for crypto) because the intended dependencies
are not actually enabled.

> +	select FW_LOADER
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826163913.7052=
-1-mike@fireburn.co.uk?part=3D12
