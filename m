Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 480E1C61DC4
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 00:48:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D374410F202;
	Fri, 28 Aug 2026 00:47:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="XhO9weTp";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 480D710E430;
 Fri, 28 Aug 2026 00:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787878078; x=1819414078;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=LZI0QjipoM78jeCVy9H5ETYEC3AN8Zrx4bUQh59Hn/8=;
 b=XhO9weTp+2kWO9hK/fB2V66NjzM6dIn9ajM72zWIHv/kLBSfnvuEiHFV
 d80DFh1cGkEGGAAXY6cf0KNyJ9MwysH0w5UTYKffnkjYdMvYUF7o9z/AC
 k+74yunZnQjmqCoFdWrpem599NvXUquRO/cQq+nlf9no18ZArze/WPJbT
 QH9RMayA8SyP/htgfBtR92TCvpMnIZ+triFZD5KST0+S3t/YaLXlBH9IT
 dG2ZKMYANwCX386Fd00AugeLlTwMyWewi6yWsKN7zsia89cGNuE7749+K
 AeYF3nsiB53ywGPY3zNp5xJUxrP2Mmk2iIVDKhtTBAXKGOyQtm9bo2ckR Q==;
X-CSE-ConnectionGUID: Es34ggGVQreZnUmtfe1y4Q==
X-CSE-MsgGUID: mjBDPeciS1mU1Vd0DrnqWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="88244598"
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; d="scan'208";a="88244598"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 17:47:57 -0700
X-CSE-ConnectionGUID: 4/pLYgPTSJyMsZnqlYopvQ==
X-CSE-MsgGUID: nRLBhgKeQlyTjuTZURurZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; d="scan'208";a="266716344"
Received: from vbelgaum-ubuntu.fm.intel.com ([10.1.39.16])
 by orviesa010.jf.intel.com with ESMTP; 27 Aug 2026 17:47:56 -0700
From: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
 Vinay Belgaumkar <vinay.belgaumkar@intel.com>,
 Alexander Kanevskiy <alexander.kanevskiy@intel.com>
Subject: [PATCH] perf: Fix null pointer access in is_include_guest_event()
Date: Thu, 27 Aug 2026 17:42:08 -0700
Message-Id: <20260828004208.3906054-1-vinay.belgaumkar@intel.com>
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

Fixes: eff95e170275 ("perf: Add APIs to create/release mediated guest vPMUs")
Cc: Alexander Kanevskiy <alexander.kanevskiy@intel.com>
Assisted-by: Claude:Claude-Sonnet-5
Signed-off-by: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
---
 kernel/events/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 94ca277e0819..6bc493308234 100644
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
@@ -12977,6 +12980,8 @@ static void __pmu_detach_event(struct pmu *pmu, struct perf_event *event,
 	exclusive_event_destroy(event);
 	module_put(pmu->module);
 
+	mediated_pmu_unaccount_event(event);
+
 	event->pmu = NULL; /* force fault instead of UAF */
 }
 
-- 
2.38.1

