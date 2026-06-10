Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B94ECD8CB2
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 15:14:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81B6910E4D4;
	Wed, 10 Jun 2026 15:14:24 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2E7410E4D4
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 15:14:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7D8DB406C0;
 Wed, 10 Jun 2026 15:14:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E202E1F00893;
 Wed, 10 Jun 2026 15:14:21 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Lucas De Marchi <demarchi@kernel.org>, Juston Li <justonli@chromium.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH resend 2] gpu/trace: TRACE_GPU_MEM should depend on DRM
Date: Wed, 10 Jun 2026 17:14:19 +0200
Message-ID: <600d327c8fc37decc1acaccc96439825d12c57e3.1781104422.git.geert+renesas@glider.be>
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

GPU memory usage tracepoints are only used by DRM GPU drivers.
Hence add a dependency on DRM, to prevent asking the user about this
functionality when configuring a kernel without DRM GPU support.

Fixes: 5d95cbf21a4a550f ("gpu/trace: make TRACE_GPU_MEM configurable")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/gpu/trace/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/trace/Kconfig b/drivers/gpu/trace/Kconfig
index cd3d19c4a201c9c6..7f405ce7df5a0a42 100644
--- a/drivers/gpu/trace/Kconfig
+++ b/drivers/gpu/trace/Kconfig
@@ -2,6 +2,7 @@
 
 config TRACE_GPU_MEM
 	bool "Enable GPU memory usage tracepoints"
+	depends on DRM || COMPILE_TEST
 	default n
 	help
 	  Choose this option to enable tracepoints for tracking
-- 
2.43.0

