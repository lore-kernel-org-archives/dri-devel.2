Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7609C624D4
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 21:25:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C36010EF34;
	Tue,  1 Sep 2026 21:25:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="l0WxLz9I";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAA9E10EF2C;
 Tue,  1 Sep 2026 21:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788297927; x=1819833927;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IzhWanvyi5HfHn/a0V0Xf8rCpv6Uls47OvqR6IGBo2Y=;
 b=l0WxLz9Ilj7hcqg4jPkrkfSzwue1lf+FIwwiFw9pynSvHZgi6ogKBr/0
 w8yyYkUhluBQyqp2x1QmFxNAaInIFyEppjWZierftIu+tnnpznOKTQo9M
 Y+yFQw6VpkcitLSuw8VQPyKa6mC9lW6NufY9U3UOhs6mJE7bbA0lAvx4x
 zBIrM4dnX9T9gQyCcZvbLeiO+83g6W0qiCOJmU1sjW0wX2jYAPg2bMLXq
 /q7l7rbN4fl0tRye9T1IbtP/BOpy+uuYLpt11ivTuIvFDT+c5hABtC7VC
 zQpyE6j8ig1Pi2MufqWW5Xa5VF5siGAuuUNMm8aGJt96hhWYr9A+MM/kJ w==;
X-CSE-ConnectionGUID: 5dGUmdewR+W11sbmp37bwA==
X-CSE-MsgGUID: oboL7Er+TqGm7/u9b3r62Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="92442102"
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; d="scan'208";a="92442102"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 14:25:01 -0700
X-CSE-ConnectionGUID: pvr6zHIBQQ6PlE5brG7NDw==
X-CSE-MsgGUID: iW71ErrUSxaK9RAZcUS6XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; d="scan'208";a="265970560"
Received: from vbelgaum-ubuntu.fm.intel.com ([10.1.39.16])
 by fmviesa007.fm.intel.com with ESMTP; 01 Sep 2026 14:25:00 -0700
From: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
 Vinay Belgaumkar <vinay.belgaumkar@intel.com>,
 Alexander Kanevskiy <alexander.kanevskiy@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH v5 1/2] perf: Fix null pointer access in
 is_include_guest_event()
Date: Tue,  1 Sep 2026 14:19:14 -0700
Message-Id: <20260901211915.127704-2-vinay.belgaumkar@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260901211915.127704-1-vinay.belgaumkar@intel.com>
References: <20260901211915.127704-1-vinay.belgaumkar@intel.com>
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
cause of this crash. Adding a check to is_include_guest_event() ensures
we don't accidentally access a null ptr.

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

