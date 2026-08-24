Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C81AC5DF94
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:22:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79CE410E0AD;
	Mon, 24 Aug 2026 15:22:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EBkQVmyF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C5CE10E0AD
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 15:22:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 65785434B0;
 Mon, 24 Aug 2026 15:22:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F0811F000E9;
 Mon, 24 Aug 2026 15:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787584928;
 bh=dzbjSWbs+hDl2LTltLc0mEWz108HrZ6dsbjjyWi6cUQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EBkQVmyFP7j2POW7bl6Akyty+dpzL76iXk2M5/WhBlcXD+2XFMSEGHk46mMbdcZmM
 gFnTVkpwxTujUU3JDJc9HTi21mAYB6rYy+VL0Jj5FI7Fd1E/V7rwIrapVhFqn2iOoO
 zmmPr2iZOvnZyTTsg6SnBKobYcaKjLnCVeFZNX61xHzxZUBhmNVkQtZgXiKfc0fqnB
 /DjrYAncj5geKM2e3RUhYVAz8GiWdpD8QGw0W5V1zbwHJaa1JFTcXZC/m+jOsUdRrF
 JOIQX/WEUfRbhECq3x9fbCLitseKTQjEHzWlKFYRivOM1z8WROn7KjWaKIJgnKda0A
 XS+p3brhutQ6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] gpu: GPU_BUDDY_KUNIT_TEST should not select GPU_BUDDY
To: "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260824151230.XuHT5veUT8Oi5un54yAsIsxDMMalaTNf64h7qW1s0ow@z>
References: <20260824151230.XuHT5veUT8Oi5un54yAsIsxDMMalaTNf64h7qW1s0ow@z>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 15:22:07 +0000
Message-Id: <20260824152208.1F0811F000E9@smtp.kernel.org>
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
- [Medium] Missing explicit Kconfig dependencies in `.kunitconfig` causes t=
he test to be silently dropped.
- [Medium] Adding a tristate dependency to a `bool` config causes Kconfig w=
arnings and hides the configuration prompt when DRM is a module.
--

--- Patch [1]: [PATCH] gpu: GPU_BUDDY_KUNIT_TEST should not select GPU_BUDD=
Y ---
commit ffd08cabf5088a2a96497e1ac48e8e50484ee037
Author: Geert Uytterhoeven <geert@linux-m68k.org>

gpu: GPU_BUDDY_KUNIT_TEST should not select GPU_BUDDY

This commit changes the Kconfig rules for GPU_BUDDY_KUNIT_TEST to depend on
GPU_BUDDY rather than selecting it. It also adds a dependency on DRM or
COMPILE_TEST for the GPU_BUDDY allocator itself.

> diff --git a/drivers/gpu/Kconfig b/drivers/gpu/Kconfig
> --- a/drivers/gpu/Kconfig
> +++ b/drivers/gpu/Kconfig
> @@ -1,14 +1,15 @@
>  # SPDX-License-Identifier: GPL-2.0
> =20
>  config GPU_BUDDY
> -       bool
> +       bool "Page based buddy allocator for GPU memory" if KUNIT
> +       depends on DRM || COMPILE_TEST

[Severity: Medium]
Will adding a tristate dependency (DRM) to a bool config cause Kconfig
warnings?

If a kernel is configured with CONFIG_DRM=3Dm and CONFIG_COMPILE_TEST=3Dn, a
tristate driver that selects GPU_BUDDY will force it to y. Kconfig will
compare the selected value (y) against the dependency limit (m from DRM) and
issue an unmet direct dependencies detected warning.

Additionally, users cannot manually enable the test because Kconfig hides
prompts for bool configs when their dependencies evaluate to m.

>         help
>           A page based buddy allocator for GPU memory.
> =20
>  config GPU_BUDDY_KUNIT_TEST
>         tristate "KUnit tests for GPU buddy allocator" if !KUNIT_ALL_TESTS
>         depends on KUNIT
> -       select GPU_BUDDY
> +       depends on GPU_BUDDY

[Severity: Medium]
Does this change cause the test to be silently dropped when running kunit.p=
y?

Because GPU_BUDDY_KUNIT_TEST now explicitly depends on GPU_BUDDY, which in
turn depends on DRM || COMPILE_TEST, if drivers/gpu/tests/.kunitconfig is
not updated to include CONFIG_DRM=3Dy (or CONFIG_COMPILE_TEST=3Dy) and
CONFIG_GPU_BUDDY=3Dy, Kconfig will evaluate these unmet dependencies as n.

This will silently drop CONFIG_GPU_BUDDY_KUNIT_TEST=3Dy from the generated
configuration during automated testing.

>         default KUNIT_ALL_TESTS
>         help
>           KUnit tests for the GPU buddy allocator.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824151230.XuHT=
5veUT8Oi5un54yAsIsxDMMalaTNf64h7qW1s0ow@z?part=3D1
