Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C01A9C61DBE
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 15:40:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A6D310EACC;
	Tue, 25 Aug 2026 15:40:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="myYQ/4x5";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D241910EACC
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 15:40:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 827B2401A9;
 Tue, 25 Aug 2026 15:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B4D1F000E9;
 Tue, 25 Aug 2026 15:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787672415;
 bh=Mn6br+9Co6x0r31xelXT0YWAwaefCZPu2AD602S7UAs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=myYQ/4x5+cKoZ8Gr1l4I0uB/i8wp0TyEyzCD5YYkKrUlihMle+xNCFM9ndhjFv36+
 9CxS4t6/tlS/+B5GnMgJNhTGOCeWqB2WpCLlMfuESU+5w76hvbLaVoUnBBunu6AuNV
 /3KNJCoOat4/jd0AGlNJ+Z/ZxVN0mYIkPX1A/EKkXCgGjFnfjq5Ed6jNV0F7F3/bSx
 ip42nmFC5nKWIb38FUq8BqpADMYQxtXFmP7pTIDhoSm63XxSCNJgo+HuzS9HMk7KGk
 WyGNwTiGCv7iFsM79MDdgfQhDrzQgPFFeNghmE6n4ScUsJz/tZkRBMXB5+wX7UYj8Q
 X0+Xr3MDQWU9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] gpu: GPU_BUDDY_KUNIT_TEST should not select GPU_BUDDY
To: "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <e67a2cb0d599b75ae365882913c543e7b0c5b8a3.1787671708.git.geert@linux-m68k.org>
References: <e67a2cb0d599b75ae365882913c543e7b0c5b8a3.1787671708.git.geert@linux-m68k.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 15:40:14 +0000
Message-Id: <20260825154015.41B4D1F000E9@smtp.kernel.org>
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
- [Low] Adding `depends on DRM || COMPILE_TEST` to the `bool` symbol `GPU_B=
UDDY` causes a Kconfig unmet direct dependencies warning when `DRM=3Dm`, an=
d breaks manual selection of the KUnit test.
--

--- Patch [1]: [PATCH v2] gpu: GPU_BUDDY_KUNIT_TEST should not select GPU_B=
UDDY ---
commit 0c0f9dc26f6481afe68d4de6c66198acb6cb9883
Author: Geert Uytterhoeven <geert@linux-m68k.org>

gpu: GPU_BUDDY_KUNIT_TEST should not select GPU_BUDDY

This commit changes GPU_BUDDY_KUNIT_TEST to depend on GPU_BUDDY instead
of selecting it. It also adds a dependency on DRM or COMPILE_TEST to
GPU_BUDDY and makes it user-visible when KUNIT is enabled.

> diff --git a/drivers/gpu/Kconfig b/drivers/gpu/Kconfig
> index 3bcf08260d73a..d881ab6f7a006 100644
> --- a/drivers/gpu/Kconfig
> +++ b/drivers/gpu/Kconfig
> @@ -1,14 +1,15 @@
>  # SPDX-License-Identifier: GPL-2.0
> =20
>  config GPU_BUDDY
> -       bool
> +       bool "Page based buddy allocator for GPU memory" if KUNIT
> +       depends on DRM || COMPILE_TEST

[Severity: Low]
Does adding this dependency cause a Kconfig warning when DRM is configured
as a module?

Because GPU_BUDDY is a boolean symbol, this dependency restriction evaluates
to 'm' when CONFIG_DRM=3Dm and CONFIG_COMPILE_TEST=3Dn. This causes a confl=
ict
with the 'select' from DRM_BUDDY, resulting in an unmet direct dependencies
warning.

Additionally, could this prevent developers from manually enabling the KUnit
test when DRM=3Dm without COMPILE_TEST?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/e67a2cb0d599b75ae36=
5882913c543e7b0c5b8a3.1787671708.git.geert@linux-m68k.org?part=3D1
