Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 138EAC5DF9B
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:20:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70B9F10E743;
	Mon, 24 Aug 2026 15:20:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="M0CGoCRZ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 864CB10E743
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 15:20:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B5AE76011F;
 Mon, 24 Aug 2026 15:20:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C0B51F000E9;
 Mon, 24 Aug 2026 15:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787584809;
 bh=wU9I9AHGjB5kMskH/aF6lnLOoR8eWjXkm3zZGjx+Mn8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=M0CGoCRZdSTnYMestYKHzuX6YU5eM9cEQswGLAe7/sY/1XTufn4mdahGGi44g3A9F
 h5JdRJpEqlmNe6WaxkOLBDeQqwgsx9W35dTR0Cld5CdKImAeamRTWi+TF4MAt4my9s
 SdBDmWfpm8TnZW26aYCq6urHtSYsfZNtsZJ6BScITtNeL41xkYaaUTu1AJNL5MTDez
 eM8ChCEocOWQD0O6lv55VaAw2rhJTWkYWZCYqM2LtLlJVdN857IsWREX7+nqYVp7D9
 YrbEc4Wt3k8dS/Ri4763VzxYp84ULTZuMaHouZJa2/ATUDqjzI9+nzpD1+j4zkY6VX
 shflDs/wQrV2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] gpu: GPU_BUDDY_KUNIT_TEST should not select GPU_BUDDY
To: "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <1e519fb24aa5521788d69cc7980665ccbc227b14.1787584184.git.geert@linux-m68k.org>
References: <1e519fb24aa5521788d69cc7980665ccbc227b14.1787584184.git.geert@linux-m68k.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 15:20:08 +0000
Message-Id: <20260824152009.4C0B51F000E9@smtp.kernel.org>
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
- [Medium] Missing `.kunitconfig` update causes `kunit.py` to fail due to u=
nmet dependencies.
--

--- Patch [1]: [PATCH] gpu: GPU_BUDDY_KUNIT_TEST should not select GPU_BUDD=
Y ---
commit cb5627cb79f60b67a5672a81939fd993a20abdd4
Author: Geert Uytterhoeven <geert@linux-m68k.org>

gpu: GPU_BUDDY_KUNIT_TEST should not select GPU_BUDDY

This commit changes the GPU_BUDDY_KUNIT_TEST Kconfig entry to depend on
GPU_BUDDY rather than selecting it. It also adds a dependency on DRM or
COMPILE_TEST to the GPU_BUDDY option.

> diff --git a/drivers/gpu/Kconfig b/drivers/gpu/Kconfig
> index 3bcf08260d73a..d881ab6f7a006 100644
> --- a/drivers/gpu/Kconfig
> +++ b/drivers/gpu/Kconfig

[ ... ]

> @@ -1,14 +1,15 @@
>  # SPDX-License-Identifier: GPL-2.0
> =20
>  config GPU_BUDDY
> -       bool
> +       bool "Page based buddy allocator for GPU memory" if KUNIT
> +       depends on DRM || COMPILE_TEST
>         help
>           A page based buddy allocator for GPU memory.
> =20
>  config GPU_BUDDY_KUNIT_TEST
>         tristate "KUnit tests for GPU buddy allocator" if !KUNIT_ALL_TESTS
>         depends on KUNIT
> -       select GPU_BUDDY
> +       depends on GPU_BUDDY

[Severity: Medium]
Since this changes from a select to a dependency, does the KUnit configurat=
ion
file at drivers/gpu/tests/.kunitconfig also need to be updated?

If CONFIG_COMPILE_TEST=3Dy and CONFIG_GPU_BUDDY=3Dy are not added to=20
.kunitconfig, running kunit.py will fail because CONFIG_GPU_BUDDY_KUNIT_TES=
T=20
will be silently dropped from the generated config due to unmet dependencie=
s.

>         default KUNIT_ALL_TESTS
>         help
>           KUnit tests for the GPU buddy allocator.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/1e519fb24aa5521788d=
69cc7980665ccbc227b14.1787584184.git.geert@linux-m68k.org?part=3D1
