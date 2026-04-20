Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30747F36C5D
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 08:33:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C74A110E469;
	Mon, 20 Apr 2026 08:33:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="TvWlJkMD";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F9EE10E122;
 Mon, 20 Apr 2026 08:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1776674005;
 bh=R/96uZ5fqh8sHy0/coNH0vTTtGdeF6AbJ0GU05YtAKk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TvWlJkMD428u9ludIRye6j//QyGU4235eP1/P/TexRtO24b+nzUE60izn5Dj/zwXW
 hkmqBIp57L52cUzOTVpHlbvcQ9rTauLk6QTyvhqioAuDazG54pRLorBdTNW09XFYrA
 uKaRZlal4UqnZoHPLLDTrbzgT/vcDmMk2eB8fdhhoC5cV0oedywyDOIj/s9T2ZMWep
 5XiS28bPIEV8KhSSWlN/wOdc9cmQ0CyNeJ/fmGNwtervUufsLeHq4uEJbLviIlZIaq
 izjND7tdAezZQikjdWPMVs58v0j0EhCxvw1f8yTW0yV/Zt/Tps9ZbbPw8KTM1RhHBN
 PMavriENMbwlg==
From: Maarten Lankhorst <dev@lankhorst.se>
To: dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: Maarten Lankhorst <dev@lankhorst.se>
Subject: [PATCH 1/4] drm/doc/rfc: Remove i915_gem_lmem.rst
Date: Mon, 20 Apr 2026 10:33:19 +0200
Message-ID: <20260420083318.92038-7-dev@lankhorst.se>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420083318.92038-6-dev@lankhorst.se>
References: <20260420083318.92038-6-dev@lankhorst.se>
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

The doc talks about DG1, but we do already support DG2 in i915, and
a new driver was created specifically to handle all lmem cases
even better.

Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
---
 Documentation/gpu/rfc/i915_gem_lmem.rst | 22 ----------------------
 Documentation/gpu/rfc/index.rst         |  6 +-----
 2 files changed, 1 insertion(+), 27 deletions(-)
 delete mode 100644 Documentation/gpu/rfc/i915_gem_lmem.rst

diff --git a/Documentation/gpu/rfc/i915_gem_lmem.rst b/Documentation/gpu/rfc/i915_gem_lmem.rst
deleted file mode 100644
index b421a3c1806ec..0000000000000
--- a/Documentation/gpu/rfc/i915_gem_lmem.rst
+++ /dev/null
@@ -1,22 +0,0 @@
-=========================
-I915 DG1/LMEM RFC Section
-=========================
-
-Upstream plan
-=============
-For upstream the overall plan for landing all the DG1 stuff and turning it for
-real, with all the uAPI bits is:
-
-* Merge basic HW enabling of DG1(still without pciid)
-* Merge the uAPI bits behind special CONFIG_BROKEN(or so) flag
-        * At this point we can still make changes, but importantly this lets us
-          start running IGTs which can utilize local-memory in CI
-* Convert over to TTM, make sure it all keeps working. Some of the work items:
-        * TTM shrinker for discrete
-        * dma_resv_lockitem for full dma_resv_lock, i.e not just trylock
-        * Use TTM CPU pagefault handler
-        * Route shmem backend over to TTM SYSTEM for discrete
-        * TTM purgeable object support
-        * Move i915 buddy allocator over to TTM
-* Send RFC(with mesa-dev on cc) for final sign off on the uAPI
-* Add pciid for DG1 and turn on uAPI for real
diff --git a/Documentation/gpu/rfc/index.rst b/Documentation/gpu/rfc/index.rst
index ef19b0ba2a3ea..8313194af0683 100644
--- a/Documentation/gpu/rfc/index.rst
+++ b/Documentation/gpu/rfc/index.rst
@@ -20,10 +20,6 @@ host such documentation:
 
     gpusvm.rst
 
-.. toctree::
-
-    i915_gem_lmem.rst
-
 .. toctree::
 
     i915_scheduler.rst
@@ -37,4 +33,4 @@ host such documentation:
     i915_vm_bind.rst
 
 .. toctree::
-    color_pipeline.rst
\ No newline at end of file
+    color_pipeline.rst
-- 
2.53.0

