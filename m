Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E235C61DD6
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 21:25:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82C9C10EF38;
	Tue,  1 Sep 2026 21:25:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="O9agFkyZ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3263810EF33;
 Tue,  1 Sep 2026 21:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788297927; x=1819833927;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YN4EJ4px2KICrrwv4lTLG4gWDV+gmZkGd3lnkmGYvjc=;
 b=O9agFkyZRbPEWMPvJCgOwb7sjrka8X5/m1wSVoiYHH6MoKQPoPVAOoxu
 I0rhwexOuLVBLpmRQseR/xWbk8EgOy4dQNjr0QEfyb0us0E96CcEXd0gq
 wi0udrUD5TcArC2gevDSZJzMbkpA24aXn9hyqI1STE5BbS/L967EQyBuS
 4jwFGZF7QqnaSUxni9tn7sJ/bpVqRO9wWAv0pe0ahZ7GXK7lDIQNKhV3X
 6VIoXp0kKTw7pkhljf56mI4z6ZJcN22TIh15NmuygrGgLT6Z9/4PmrVPm
 003NjtAnt64JEkbttfwA0CkWW9792Y5Or6gDyFTgtQDrKyyJG7CeMRyH4 A==;
X-CSE-ConnectionGUID: nb5Os/6XTneeyoJAvDADRA==
X-CSE-MsgGUID: Gr3VLrGASdSOM9sJZqvxcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="92442105"
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; d="scan'208";a="92442105"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 14:25:03 -0700
X-CSE-ConnectionGUID: mAIVHRVpSdq082uJYjBL0A==
X-CSE-MsgGUID: CLUCJMjoTqSUlJk8mQ15jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; d="scan'208";a="265970578"
Received: from vbelgaum-ubuntu.fm.intel.com ([10.1.39.16])
 by fmviesa007.fm.intel.com with ESMTP; 01 Sep 2026 14:25:03 -0700
From: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
 Vinay Belgaumkar <vinay.belgaumkar@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH v5 2/2] perf: Add checks to prevent null ptr access
Date: Tue,  1 Sep 2026 14:19:15 -0700
Message-Id: <20260901211915.127704-3-vinay.belgaumkar@intel.com>
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

Sashiko recommended some additional checks to prevent null pointer
access. Check for revoked states inside perf_event_read_local(), as
the pmu event may have already been freed at this point. Add a null
check inside __perf_event_read_cpu() as well before accessing the pmu
ptr.

Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
---
 kernel/events/core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f19d27ac411d..bb90034a2054 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4788,14 +4788,19 @@ static inline const struct cpumask *perf_scope_cpu_topology_cpumask(unsigned int
 
 static int __perf_event_read_cpu(struct perf_event *event, int event_cpu)
 {
+	struct pmu *pmu = READ_ONCE(event->pmu);
 	int local_cpu = smp_processor_id();
 	u16 local_pkg, event_pkg;
 
 	if ((unsigned)event_cpu >= nr_cpu_ids)
 		return event_cpu;
 
+	if (!pmu)
+		return -ENODEV;
+
 	if (event->group_caps & PERF_EV_CAP_READ_SCOPE) {
-		const struct cpumask *cpumask = perf_scope_cpu_topology_cpumask(event->pmu->scope, event_cpu);
+		const struct cpumask *cpumask = perf_scope_cpu_topology_cpumask(pmu->scope,
+										event_cpu);
 
 		if (cpumask && cpumask_test_cpu(local_cpu, cpumask))
 			return local_cpu;
@@ -4917,6 +4922,11 @@ int perf_event_read_local(struct perf_event *event, u64 *value,
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
-- 
2.38.1

