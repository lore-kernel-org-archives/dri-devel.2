Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A736C5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:12:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A62FC10E5FD;
	Mon, 24 Aug 2026 15:12:37 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B741D10E5FD
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 15:12:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9F6F840A96;
 Mon, 24 Aug 2026 15:12:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B011F000E9;
 Mon, 24 Aug 2026 15:12:34 +0000 (UTC)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Krzysztof Karas <krzysztof.karas@intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>,
 Maarten Lankhorst <dev@lankhorst.se>,
 Andi Shyti <andi.shyti@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] gpu: GPU_BUDDY_KUNIT_TEST should not select GPU_BUDDY
Date: Mon, 24 Aug 2026 17:12:30 +0200
Message-ID: <1e519fb24aa5521788d69cc7980665ccbc227b14.1787584184.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Message-ID: <20260824151230.XuHT5veUT8Oi5un54yAsIsxDMMalaTNf64h7qW1s0ow@z>

Enabling a (modular) test should not silently enable additional kernel
functionality, as that may increase the attack vector for a product.

Fix this by reverting the select to a dependency.  Make sure the GPU
buddy allocator can be tested without enabling another driver that uses
DRM_BUDDY by making GPU_BUDDY visible if KUNIT is enabled.

The page based buddy allocator for GPU memory is only used by DRM.
Hence add a dependency on DRM to GPU_BUDDY, to prevent asking the user
about this code when configuring a kernel without DRM support.

Fixes: 8fe3fc37564920ae ("gpu: Fix dependencies in CONFIG_GPU_BUDDY_KUNIT_TEST")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/gpu/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/Kconfig b/drivers/gpu/Kconfig
index 3bcf08260d73a782..d881ab6f7a006a3b 100644
--- a/drivers/gpu/Kconfig
+++ b/drivers/gpu/Kconfig
@@ -1,14 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0
 
 config GPU_BUDDY
-       bool
+       bool "Page based buddy allocator for GPU memory" if KUNIT
+       depends on DRM || COMPILE_TEST
        help
          A page based buddy allocator for GPU memory.
 
 config GPU_BUDDY_KUNIT_TEST
        tristate "KUnit tests for GPU buddy allocator" if !KUNIT_ALL_TESTS
        depends on KUNIT
-       select GPU_BUDDY
+       depends on GPU_BUDDY
        default KUNIT_ALL_TESTS
        help
          KUnit tests for the GPU buddy allocator.
-- 
2.43.0

