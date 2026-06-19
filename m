Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD785CD98F6
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 10:03:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E882810E062;
	Fri, 19 Jun 2026 10:03:39 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 048E910E062
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 10:03:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A640243CB8;
 Fri, 19 Jun 2026 10:03:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E4F71F000E9;
 Fri, 19 Jun 2026 10:03:35 +0000 (UTC)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: driver-core@lists.linux.dev, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] base: Remove unused DMA_FENCE_TRACE Kconfig symbol
Date: Fri, 19 Jun 2026 12:03:31 +0200
Message-ID: <16fb40ded203d1e2b72f4eeecad3fd0c0d23ad6f.1781863296.git.geert@linux-m68k.org>
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

Commit d72277b6c37db66b ("dma-buf: nuke DMA_FENCE_TRACE macros v2") in
v5.16 removed all users of DMA_FENCE_TRACE on the premise that the
Kconfig symbol did not exist.  Apparently one failed to notice the
symbol did exist since almost five years before: it was renamed from
FENCE_TRACE to DMA_FENCE_TRACE in commit f54d1867005c3323 ("dma-buf:
Rename struct fence to dma_fence") in v4.10.

Time passed by, so remove the Kconfig symbol, as no one seems to have
missed the functionality.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/base/Kconfig | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index f7d385cbd3ba4b2b..43f20ca95a2a6ba9 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -222,15 +222,6 @@ config DMA_SHARED_BUFFER
 	  APIs extension; the file's descriptor can then be passed on to other
 	  driver.
 
-config DMA_FENCE_TRACE
-	bool "Enable verbose DMA_FENCE_TRACE messages"
-	depends on DMA_SHARED_BUFFER
-	help
-	  Enable the DMA_FENCE_TRACE printks. This will add extra
-	  spam to the console log, but will make it easier to diagnose
-	  lockup related problems for dma-buffers shared across multiple
-	  devices.
-
 config GENERIC_ARCH_TOPOLOGY
 	bool
 	help
-- 
2.43.0

