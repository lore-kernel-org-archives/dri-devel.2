Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA50C61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 21:34:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4621410F493;
	Fri, 28 Aug 2026 21:34:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="JIxKf8XO";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F80710E052;
 Fri, 28 Aug 2026 21:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787952847; x=1819488847;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=RxqZfaHxvd/J0XUnWZSiVHleC7E1Q72epDLe9aDqxJo=;
 b=JIxKf8XOJ8Cur3OEOiC2fmx6NJtQkI7ni658FynyIvJFFrSigGXyJIhT
 WdEyOyvq5CVgWLCdz9RjEdb4zvBE7rDLtjFFh2CQf5KXtbILOsjIHcFYi
 9RLBcMjvfjZ0jbQGmynRF05fL6GiEL02AVBeIbemctcnhOtdPYahjsEqd
 em6QZhCEdWeAK7XWJ6M1+ronWAqGZ6Hw7zfNA3BUB8NgVCIAzr9NDUamA
 D5/djHoLiBPGoZDxPChC2HAqOOCyBGzwkSDbrYBCnk0GkwUaBjYTenLLo
 ieQpB1D3w1YK81dq8HQpIPtWEz0Ss9wnbFMoz9x7EQnGKvBoyeSxb9hxB Q==;
X-CSE-ConnectionGUID: zu/ZwNUERgemwS9lGfjZnw==
X-CSE-MsgGUID: xH4xT+YUS0Chzf974yj8Ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11889"; a="99976289"
X-IronPort-AV: E=Sophos;i="6.25,249,1779174000"; d="scan'208";a="99976289"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 14:34:07 -0700
X-CSE-ConnectionGUID: bWy8j6U0SaCCenZsYY499g==
X-CSE-MsgGUID: 5CNDWL8RTkiAtyz26bS/8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,249,1779174000"; d="scan'208";a="265690913"
Received: from vbelgaum-ubuntu.fm.intel.com ([10.1.39.16])
 by fmviesa008.fm.intel.com with ESMTP; 28 Aug 2026 14:34:06 -0700
From: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
 Vinay Belgaumkar <vinay.belgaumkar@intel.com>,
 Alexander Kanevskiy <alexander.kanevskiy@intel.com>
Subject: [PATCH v2] perf: Fix null pointer access in is_include_guest_event()
Date: Fri, 28 Aug 2026 14:28:03 -0700
Message-Id: <20260828212803.3963976-1-vinay.belgaumkar@intel.com>
X-Mailer: git-send-email 2.38.1
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

A kernel panic is observed when an application has a perf connection open
and the driver managing the pmu event unbinds. The issue occurs when
perf_pmu_unregister() is called while there is an active perf session. The
null pointer error is seen when the event is freed through __free_event()
and mediated_pmu_unaccount_event is called. There is a missing null check
inside is_include_guest_event(). Also call mediated_pmu_unaccount_event()
inside __pmu_detach_event() similar to __free_event().

v2: Add another check to prevent null access (sashiko)

Fixes: eff95e170275 ("perf: Add APIs to create/release mediated guest vPMUs")
Cc: Alexander Kanevskiy <alexander.kanevskiy@intel.com>
Assisted-by: Claude:Claude-Sonnet-5
Signed-off-by: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
---
 kernel/events/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 94ca277e0819..88e0d5e476a8 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4917,6 +4917,11 @@ int perf_event_read_local(struct perf_event *event, u64 *value,
 		goto out;
 	}
 
+	if (event->state <= PERF_EVENT_STATE_REVOKED) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	/*
 	 * Get the event CPU numbers, and adjust them to local if the event is
 	 * a per-package event that can be read locally
@@ -6350,6 +6355,9 @@ static DEFINE_MUTEX(perf_mediated_pmu_mutex);
 /* !exclude_guest event of PMU with PERF_PMU_CAP_MEDIATED_VPMU */
 static inline bool is_include_guest_event(struct perf_event *event)
 {
+	if (!event->pmu)
+		return false;
+
 	if ((event->pmu->capabilities & PERF_PMU_CAP_MEDIATED_VPMU) &&
 	    !event->attr.exclude_guest)
 		return true;
@@ -12977,6 +12985,7 @@ static void __pmu_detach_event(struct pmu *pmu, struct perf_event *event,
 	exclusive_event_destroy(event);
 	module_put(pmu->module);
 
+	mediated_pmu_unaccount_event(event);
 	event->pmu = NULL; /* force fault instead of UAF */
 }
 
-- 
2.38.1

