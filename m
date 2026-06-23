Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 907ACCDE000
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 22:27:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A6A110ED04;
	Tue, 23 Jun 2026 22:27:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="kpVvYPSV";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86EAD10ECD9;
 Tue, 23 Jun 2026 22:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782253660; x=1813789660;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=tEJFr2fDjpUfYCgKOOzG+fHo7UeIHO0zx0ZRb9MAMlI=;
 b=kpVvYPSVuwN3SNBjUiQgcfiCJXkMsVuGsHhbV8RqWAX9zR4Nj72CqEh0
 D+0Dm1zvgdc7BHZ+e7bxk1o4bXenOZUMk18hy6K3ZyoV70khUZdLUG8vH
 n49UeZthD77M2z+qSJNtjHMKY6WsBwvAND/9emzEpGhi6SBjMW9wdZEDR
 85XgzqH0Qgjq7+BOXnDYVF46q9LnWgpu9asMNa/wUN9jSem/syO9/4Yso
 GZY+MgVtdZ9r1YyDZpviWvO8smt0p3XBt+Qj4B3NX1aWcKM3bjOaE4PXo
 Cj+JeGgXiQb6yP/8ZwGdByql7Fj6lYqB5+3aCI51WGn7ZT4DkXsqf0B0J g==;
X-CSE-ConnectionGUID: +RCVQ+f5SVCSPAFP7TN49g==
X-CSE-MsgGUID: TWN6x3TmTyStD46b/7H3uQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="83048831"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="83048831"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 15:27:39 -0700
X-CSE-ConnectionGUID: Lstpb9x9Sb2JjXjrjraPGg==
X-CSE-MsgGUID: vyGiZUktR1685xor2skC5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="273335812"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 15:27:40 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [RFC PATCH 11/12] drm/xe: Add DRM_XE_DEBUG_DEFRAG Kconfig option for
 debugging memory fragmentation
Date: Tue, 23 Jun 2026 15:27:31 -0700
Message-Id: <20260623222732.360872-12-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260623222732.360872-1-matthew.brost@intel.com>
References: <20260623222732.360872-1-matthew.brost@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add a new debug configuration option DRM_XE_DEBUG_DEFRAG that forces
beneficial_reclaim_backoff when defragmentation is disabled in
xe_ttm_tt_populate(). This helps force defragmentation to run.

When enabled, the driver will always set beneficial_reclaim_backoff to
true for non-defrag allocations, preventing aggressive reclaim attempts
that could prevent defragmentation from running.

The option depends on EXPERT and is disabled by default, intended only
for driver developers debugging memory fragmentation issues.

Cc: Carlos Santa <carlos.santa@intel.com>
Cc: Ryan Neph <ryanneph@google.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Assisted-by: GitHub_Copilot:claude-haiku-4.5
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/Kconfig.debug | 13 +++++++++++++
 drivers/gpu/drm/xe/xe_bo.c       |  3 ++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/Kconfig.debug b/drivers/gpu/drm/xe/Kconfig.debug
index 01227c77f6d7..f9cbb58dbcc3 100644
--- a/drivers/gpu/drm/xe/Kconfig.debug
+++ b/drivers/gpu/drm/xe/Kconfig.debug
@@ -102,6 +102,19 @@ config DRM_XE_DEBUG_GUC
 
           If in doubt, say "N".
 
+config DRM_XE_DEBUG_DEFRAG
+	bool "Enable extra defragmentation debugging"
+	depends on EXPERT
+	default n
+	help
+	  Choose this option when debugging memory defragmentation issues.
+	  Forces beneficial_reclaim_backoff when defrag is disabled to help
+	  force defragmentation.
+
+	  Recommended for driver developers only.
+
+	  If in doubt, say "N".
+
 config DRM_XE_USERPTR_INVAL_INJECT
        bool "Inject userptr invalidation -EINVAL errors"
        depends on DRM_GPUSVM
diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 1612e4ece1e1..f74fd6f5504a 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -592,7 +592,8 @@ static int xe_ttm_tt_populate(struct ttm_device *ttm_dev, struct ttm_tt *tt,
 
 		if (ctx->defrag)
 			ctx->beneficial_reclaim_backoff = false;
-		else if (atomic_read(&xe->mem.defrag.count) >=
+		else if (IS_ENABLED(CONFIG_DRM_XE_DEBUG_DEFRAG) ||
+			 atomic_read(&xe->mem.defrag.count) >=
 			 XE_BO_DEFRAG_RECLAIM_BACKOFF_THRESHOLD)
 			ctx->beneficial_reclaim_backoff = true;
 
-- 
2.34.1

