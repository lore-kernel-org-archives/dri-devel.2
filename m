Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D68C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 21:57:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D0E810E1B8;
	Mon, 31 Aug 2026 21:57:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="RhJC+ylv";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C43A10E121;
 Mon, 31 Aug 2026 21:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788213471; x=1819749471;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=1yzhN672F5qDXh1gYKhfULSneIovWsGKg3ZHs7CEAbY=;
 b=RhJC+ylv/mMYBwleMdkispIooeM4N8w8506L3YO1BJy3xQ6r0OZpSeQO
 i31d8wxu1eB8AsMimZshCOqkd43HKqsZMDKqHqBrEMTEPdzLRW7VfrvEK
 Ny9RlE1Lw+OdL/pX6SFtOnW7ZankZ+NLT2lc5IwSNSMm7XSWDnv50Q2nU
 +aruoMgFRbaqvbD3q8rDTvlMRqyPm7CLgskpkW/QNCQkCYUgHHqpqSE9R
 Hq4QPetkxYxwYv7rF7u2/A0KXU249ht4wN+ZJy6Sh2GW2KarZwLawisor
 cdqezRYzsigXsS+cm/2V6UKdNeRzz5K1k42/5Tfjyw1HtVfcdVUJKJgN5 g==;
X-CSE-ConnectionGUID: b4d7ZHOGQbOQg2GjYc0MNQ==
X-CSE-MsgGUID: 4XF5OCd3RMenOwu2hQbXDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88507176"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="88507176"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 14:57:51 -0700
X-CSE-ConnectionGUID: 4l7hzdwWQzyGZ0W9b1N2RQ==
X-CSE-MsgGUID: nNQLeoCLTYaTt56YhIpPHg==
X-ExtLoop1: 1
Received: from vbelgaum-ubuntu.fm.intel.com ([10.1.39.16])
 by fmviesa003.fm.intel.com with ESMTP; 31 Aug 2026 14:57:51 -0700
From: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
 Vinay Belgaumkar <vinay.belgaumkar@intel.com>,
 Alexander Kanevskiy <alexander.kanevskiy@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH v3] perf: Fix null pointer access in is_include_guest_event()
Date: Mon, 31 Aug 2026 14:52:14 -0700
Message-Id: <20260831215214.4169965-1-vinay.belgaumkar@intel.com>
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

Signature of the failure:

 Oops: general protection fault, kernel NULL pointer dereference
 ...
 RIP: 0010:_free_event+0x3e/0x370
 ...
 Call Trace:
 ...
 perf_event_release_kernel+0x260/0x2d0
 perf_release+0x12/0x20

While here, also add a null check inside perf_event_read_local() which can
cause a similar crash. Sashiko pointed out a possible race between when we
check for revoked state here and then actually access event-pmu inside
__perf_event_read_cpu(). So, add another null check there.

v2: Add another check to prevent null access (sashiko)
v3: Use READ_ONCE for checking pmu state (sashiko)

Fixes: eff95e170275 ("perf: Add APIs to create/release mediated guest vPMUs")
Cc: Alexander Kanevskiy <alexander.kanevskiy@intel.com>
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
Assisted-by: Claude:Claude-Sonnet-5
Signed-off-by: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
---
 kernel/events/core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 94ca277e0819..6ca464f10ba8 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4794,6 +4794,9 @@ static int __perf_event_read_cpu(struct perf_event *event, int event_cpu)
 	if ((unsigned)event_cpu >= nr_cpu_ids)
 		return event_cpu;
 
+	if (!event->pmu)
+		return -ENODEV;
+
 	if (event->group_caps & PERF_EV_CAP_READ_SCOPE) {
 		const struct cpumask *cpumask = perf_scope_cpu_topology_cpumask(event->pmu->scope, event_cpu);
 
@@ -4917,6 +4920,11 @@ int perf_event_read_local(struct perf_event *event, u64 *value,
 		goto out;
 	}
 
+	if (READ_ONCE(event->state) <= PERF_EVENT_STATE_REVOKED) {
+		ret = -ENODEV;
+		goto out;
+	}
+
 	/*
 	 * Get the event CPU numbers, and adjust them to local if the event is
 	 * a per-package event that can be read locally
@@ -6350,6 +6358,9 @@ static DEFINE_MUTEX(perf_mediated_pmu_mutex);
 /* !exclude_guest event of PMU with PERF_PMU_CAP_MEDIATED_VPMU */
 static inline bool is_include_guest_event(struct perf_event *event)
 {
+	if (!event->pmu)
+		return false;
+
 	if ((event->pmu->capabilities & PERF_PMU_CAP_MEDIATED_VPMU) &&
 	    !event->attr.exclude_guest)
 		return true;
@@ -12977,6 +12988,7 @@ static void __pmu_detach_event(struct pmu *pmu, struct perf_event *event,
 	exclusive_event_destroy(event);
 	module_put(pmu->module);
 
+	mediated_pmu_unaccount_event(event);
 	event->pmu = NULL; /* force fault instead of UAF */
 }
 
-- 
2.38.1

