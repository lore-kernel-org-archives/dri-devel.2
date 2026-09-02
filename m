Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D2BC624D6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 14:24:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6EE910F20F;
	Wed,  2 Sep 2026 14:24:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="bDDLTJzz";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9B0E10F20F;
 Wed,  2 Sep 2026 14:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788359049; x=1819895049;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=E3ZXddGQvDMVMDCZVUnrJk1V0CUpaHzJBFjF2HOHxO8=;
 b=bDDLTJzzAJIqT0G6mLK4MtAhJBeGdtjZToVbIuEySmJW6v3634e5t0Og
 iVA0W4xvT0wu178ZsNdNlBJ4UbdcKKxUoRFPWa03G5W7BwmL6zE3Hk3E4
 IPHpc6qUgqgF+KdvmjIjKl/HBNUP7p11eMHwtZqHJGOiP1pARlDNBQJ+Y
 RCncIHssTZMVhiZpUynLDEi9Amd/LnJ/4m+pvb27o76/s53MaEZGZdW9G
 p670EhxDqP1cXtQXZ/scMNLBGFPwmRI7V3sPGZW4TVUtYuiqWibUW5zfZ
 cAHWU5PkM8Ybxa+qZ0rf4yex+IAZ4v7MLz265wlTcdKYSZfmeJLLT0uqw A==;
X-CSE-ConnectionGUID: d5gXe7RrQMKW8tzguiWymg==
X-CSE-MsgGUID: 412/rcttReG79s28C4DTPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="88581617"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; d="scan'208";a="88581617"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 07:24:08 -0700
X-CSE-ConnectionGUID: +B5XVXg0R8Ct85wSP/jtiA==
X-CSE-MsgGUID: kRokep9tSgib9nJOSDCvaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; d="scan'208";a="266186410"
Received: from vbelgaum-ubuntu.fm.intel.com ([10.1.39.16])
 by fmviesa007.fm.intel.com with ESMTP; 02 Sep 2026 07:24:08 -0700
From: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
 Vinay Belgaumkar <vinay.belgaumkar@intel.com>,
 Alexander Kanevskiy <alexander.kanevskiy@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH v6 1/2] perf: Fix null pointer access in
 is_include_guest_event()
Date: Wed,  2 Sep 2026 07:18:23 -0700
Message-Id: <20260902141824.733112-2-vinay.belgaumkar@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260902141824.733112-1-vinay.belgaumkar@intel.com>
References: <20260902141824.733112-1-vinay.belgaumkar@intel.com>
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

A typical module unload occurring event when there is an active perf
connection leads to freeing of the pmu pointer. The call log is something
like:
 ..
 __pmu_detach_event
 pmu_detach_event
 pmu_detach_events
 perf_pmu_unregister
 ..

__pmu_detach_event() sets event->pmu to null. When the perf connection
finally is closed, the following stack trace is observed:

 Oops: general protection fault, kernel NULL pointer dereference
 ...
 RIP: 0010:_free_event+0x3e/0x370
 ...
 Call Trace:
 ...
 perf_event_release_kernel+0x260/0x2d0
 perf_release+0x12/0x20

A call to mediated_pmu_unaccount_event() inside _free_event() is the root
cause of this crash. Adding a check inside is_include_guest_event() ensures
we don't accidentally access a null pmu ptr. In addition to this, we will
now call mediated_pmu_unaccount_event() before clearing the pmu ptr so that
nr_include_guest_events counts are maintained correctly.

v2: Add another check to prevent null access (sashiko)
v3: Use READ_ONCE for checking pmu state (sashiko)
v4: READ_ONCE for the pmu check as well (sashiko)
v5: Improve commit message and split patch into 2 (Dapeng)

Fixes: eff95e170275 ("perf: Add APIs to create/release mediated guest vPMUs")
Cc: Alexander Kanevskiy <alexander.kanevskiy@intel.com>
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
Assisted-by: Claude:Claude-Sonnet-5
Signed-off-by: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
---
 kernel/events/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 94ca277e0819..f19d27ac411d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6350,6 +6350,9 @@ static DEFINE_MUTEX(perf_mediated_pmu_mutex);
 /* !exclude_guest event of PMU with PERF_PMU_CAP_MEDIATED_VPMU */
 static inline bool is_include_guest_event(struct perf_event *event)
 {
+	if (!event->pmu)
+		return false;
+
 	if ((event->pmu->capabilities & PERF_PMU_CAP_MEDIATED_VPMU) &&
 	    !event->attr.exclude_guest)
 		return true;
@@ -12977,6 +12980,7 @@ static void __pmu_detach_event(struct pmu *pmu, struct perf_event *event,
 	exclusive_event_destroy(event);
 	module_put(pmu->module);
 
+	mediated_pmu_unaccount_event(event);
 	event->pmu = NULL; /* force fault instead of UAF */
 }
 
-- 
2.38.1

