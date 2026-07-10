Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2252AC44509
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:55:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE09F10F9B9;
	Fri, 10 Jul 2026 21:55:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="cu6yR+BR";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB40010F99B;
 Fri, 10 Jul 2026 21:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783720497; x=1815256497;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3y3GOvv88nZe1Tgh1BZjwdGD9qcA0l45lP8zkl5QVtE=;
 b=cu6yR+BRzNs18u6d11sJv8MkPobkcBT+UPXDjvmDqaTkNa6J3XwqpLbF
 QKoL/OiSH6JiJi5Gu8m7jhMWoTfBjxspfIzz875j/UDHrSxbFLadrayAa
 f7Um4PPXeDPGdNHf5VM6Knwe2Vun0ZvwZGlGygX2KZ869pXBiX10+2x4L
 Xo6KjxlGHnPHg/K6qIWBY6gtcFd4OU4hwQw7h2FH5ipNG4vbE8ehmAQTA
 l44ZlOidv1rndRfSaue+WgsQ3k/A+EpzgMsrcZk+g6HloWC24Mrb0NxrQ
 wa5FCc4l11QXPxSiKfWe36ZvFJF2RQvkUAWUtWHWlfCgOmcP35NaqJX+c w==;
X-CSE-ConnectionGUID: 8fhVY7RVRH+sRFP8XpN+LQ==
X-CSE-MsgGUID: D/qgtulsQRSuV4ptHwe7BA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="83543258"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="83543258"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 14:54:57 -0700
X-CSE-ConnectionGUID: YcbAqTwVQNi97rST7Zeb3A==
X-CSE-MsgGUID: PUUfqL/iTwuLC5pYVVi4NQ==
X-ExtLoop1: 1
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 14:54:56 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Subject: [PATCH v2 29/33] drm/xe: Add per-device dependency scheduler for IOVA
 defrag finalize
Date: Fri, 10 Jul 2026 14:54:38 -0700
Message-Id: <20260710215442.2444235-30-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260710215442.2444235-1-matthew.brost@intel.com>
References: <20260710215442.2444235-1-matthew.brost@intel.com>
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

A future patch performs the destination DMA mapping of a defrag move in
two stages when the BO is IOVA mapped: a temporary contiguous mapping of
just tht changed pages used for the GPU copy, followed by a post-copy
finalize stet that tears that mapping down and links the new backing
into the (transferred) IOVA reservation. The finalize step must run only
after the GPU copy it depends on has completed, so it is dispatched as
an xe_dep_job,

Add a per-device xe_dep_scheduler dedicated to these finalize jobs,
created in xe_bo_defrag_init() (after the migrate contexts are up) and
torn down in xe_bo_defrag_fini(). No users yet; the job itself is added
in a later patch.

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
Assisted-by: GitHub_Copilot:claude-opus-4.8
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/xe_bo.c           | 15 +++++++++++++++
 drivers/gpu/drm/xe/xe_device_types.h | 10 ++++++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index f3d76ad9a105..ec034518e2ea 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -25,6 +25,7 @@
 #include <trace/events/gpu_mem.h>
 
 #include "xe_device.h"
+#include "xe_dep_scheduler.h"
 #include "xe_dma_buf.h"
 #include "xe_drm_client.h"
 #include "xe_ggtt.h"
@@ -1300,6 +1301,10 @@ static void xe_bo_defrag_fini(void *arg)
 	struct xe_device *xe = arg;
 
 	disable_delayed_work_sync(&xe->mem.defrag.worker);
+	if (xe->mem.defrag.iova_sched) {
+		xe_dep_scheduler_fini(xe->mem.defrag.iova_sched);
+		xe->mem.defrag.iova_sched = NULL;
+	}
 }
 
 /**
@@ -1336,6 +1341,16 @@ void xe_bo_defrag_init_early(struct xe_device *xe)
  */
 int xe_bo_defrag_init(struct xe_device *xe)
 {
+#define XE_BO_MAX_IOVA_DEFRAG_JOBS	16	/* Picking a reasonable value */
+	struct xe_dep_scheduler *iova_sched;
+
+	iova_sched = xe_dep_scheduler_create(xe, NULL, "xe_iova_defrag",
+					     XE_BO_MAX_IOVA_DEFRAG_JOBS);
+	if (IS_ERR(iova_sched))
+		return PTR_ERR(iova_sched);
+	xe->mem.defrag.iova_sched = iova_sched;
+#undef XE_BO_MAX_IOVA_DEFRAG_JOBS
+
 	return devm_add_action_or_reset(xe->drm.dev, xe_bo_defrag_fini, xe);
 }
 
diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index 6e68add4d652..b55d549d5e30 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -38,6 +38,7 @@
 
 struct drm_pagemap_shrinker;
 struct intel_display;
+struct xe_dep_scheduler;
 struct intel_dg_nvm_dev;
 struct xe_ggtt;
 struct xe_i2c;
@@ -325,6 +326,15 @@ struct xe_device {
 			 * @mem.defrag.worker, in milliseconds.
 			 */
 			unsigned int interval_ms;
+			/**
+			 * @mem.defrag.iova_sched: Dependency scheduler used to
+			 * run the post-copy IOVA finalize job for defrag moves
+			 * of IOVA-mapped BOs. The job tears down the temporary
+			 * copy-step IOVA mapping and links the new backing into
+			 * the (transferred) reservation once the GPU copy that
+			 * its dependencies gate has completed.
+			 */
+			struct xe_dep_scheduler *iova_sched;
 		} defrag;
 	} mem;
 
-- 
2.34.1

