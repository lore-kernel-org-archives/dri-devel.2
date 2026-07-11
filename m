Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D707C4450B
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 02:56:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9DA810E2DA;
	Sat, 11 Jul 2026 02:56:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="LxfhpiTv";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D91110E2C3;
 Sat, 11 Jul 2026 02:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783738590; x=1815274590;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0Ygs/J+tJ2GUeHHaseAhNeLr6cTq7ecVyU2Iw8p25K4=;
 b=LxfhpiTv7qoKFy6c8UPlR/8rrDYp5GY7BukRBhn5wuU8vhw7Y3pfeu0Q
 c+eyFzJKOu5nbxnk5D6QKT+/t4G9ptJE4c9277UmevUdgIsmA5+RHt+Jb
 pUusNKrKmAAVBXwTzdvkSn8trAqrmAsNORaqDKRrcuVe0G9yCVFTTLkrg
 o0t8gl5Q2+engAv6aph4aZqT6ZkZTwNWKOMDLppxiLy1Gb93IO07HMeEp
 kX9JfJsXSdrxQ+QxYUUmYeko9Q6eayoqnnVSyB0c62J8DjDeKFBHYOYUu
 jE+r//uSsatlNErPPJ0phjGjw5YiARbQNmzPq0o7xxd/vL8ACqjVcZ4Ri w==;
X-CSE-ConnectionGUID: 6hb3z0G/SEqGf4CzocTpcw==
X-CSE-MsgGUID: yT6XDs7HQCObv6HHXNZTuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="101986275"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="101986275"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 19:56:29 -0700
X-CSE-ConnectionGUID: mRdUxlh3TnOtBCyoOvbXag==
X-CSE-MsgGUID: 6kxmoT7iSYON26fKJBISag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="256987722"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 19:56:28 -0700
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
Subject: [PATCH v3 16/33] drm/xe: Back off beneficial-order reclaim under
 defrag pressure
Date: Fri, 10 Jul 2026 19:56:02 -0700
Message-Id: <20260711025619.2540575-17-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260711025619.2540575-1-matthew.brost@intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
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

Once a meaningful number of BOs are already tracked as being backed at a
sub-optimal order, continuing to push hard for beneficial-order pages
during populate mostly wastes time in reclaim/compaction.

In xe_ttm_tt_populate(), set ctx->beneficial_reclaim_backoff when the
device defrag count reaches XE_BO_DEFRAG_RECLAIM_BACKOFF_THRESHOLD (2)
so the TTM pool backs off and allocations make forward progress. The
deferred defrag pass is responsible for upgrading these objects to
beneficial order later.

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
 drivers/gpu/drm/xe/xe_bo.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index ff324caab6da..02395968d613 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -41,6 +41,14 @@
 #include "xe_vm.h"
 #include "xe_vram_types.h"
 
+/*
+ * Once this many BOs are tracked on the device defrag list (i.e. were backed
+ * with a sub-optimal page order), request that the TTM pool backs off from
+ * aggressive reclaim at the beneficial order during populate, so that
+ * allocations make forward progress instead of stalling.
+ */
+#define XE_BO_DEFRAG_RECLAIM_BACKOFF_THRESHOLD	2
+
 const char *const xe_mem_type_to_name[TTM_NUM_MEM_TYPES]  = {
 	[XE_PL_SYSTEM] = "system",
 	[XE_PL_TT] = "gtt",
@@ -598,6 +606,12 @@ static int xe_ttm_tt_populate(struct ttm_device *ttm_dev, struct ttm_tt *tt,
 	if (ttm_tt_is_backed_up(tt) && !xe_tt->purgeable) {
 		err = ttm_tt_restore(ttm_dev, tt, ctx);
 	} else {
+		struct xe_device *xe = ttm_to_xe_device(ttm_dev);
+
+		if (atomic_read(&xe->mem.defrag.count) >=
+		    XE_BO_DEFRAG_RECLAIM_BACKOFF_THRESHOLD)
+			ctx->beneficial_reclaim_backoff = true;
+
 		ttm_tt_clear_backed_up(tt);
 		err = ttm_pool_alloc(&ttm_dev->pool, tt, ctx);
 	}
-- 
2.34.1

