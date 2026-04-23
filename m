Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 472DDFAD41B
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 05:57:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1582A10EEA9;
	Thu, 23 Apr 2026 05:57:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="K4P9/13k";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EEB610EAEE;
 Thu, 23 Apr 2026 05:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776923823; x=1808459823;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=X0WxjIbHx5z6Rxp6kXcxclzwuMByqWEn9gesMvle8Ng=;
 b=K4P9/13k/5H/9ksuFGU+7mjvwVY49SzPO45wD20mA/wKGjZFyd4JxyFB
 HHf7/7eXHdDHgm4ZNWK7IENYMuiYNDqBTD8gWi7Vraa1oYgOmc5bBFKSj
 MwGeSJTZJyxTk/T99NIRRO02HHLdtpKq7Dhl6pAn88CpyD4BQ3DZIAjmC
 UVzEyfqNlidV/fkcyCB9CImkIFvCszkX4MQ000JtHis8eHtIMKQAY8dOw
 vs5PS99tii8KumfUS82VIryI6uw0QXhrhuM4DCQ6Qj8vPrGmGU0LP6324
 +qTNSyIG1nWPwlVj4V6Hn0gq/funtrH2VwDxOwZMGuvIOjPV+QmXoQrNa Q==;
X-CSE-ConnectionGUID: 1YdroPYTT5WYtujgfE00mw==
X-CSE-MsgGUID: zKGzarYGRryFI1ysNdeutA==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="89273762"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; d="scan'208";a="89273762"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 22:57:02 -0700
X-CSE-ConnectionGUID: p8YasWqfSRiLJkJEpizvtQ==
X-CSE-MsgGUID: 8WOmptFtRWWVyY54GAlCVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; d="scan'208";a="255853890"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 22:57:02 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] mm: Introduce zone_appears_fragmented()
Date: Wed, 22 Apr 2026 22:56:52 -0700
Message-Id: <20260423055656.1696379-2-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260423055656.1696379-1-matthew.brost@intel.com>
References: <20260423055656.1696379-1-matthew.brost@intel.com>
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

Introduce zone_appears_fragmented() as a lightweight helper to allow
subsystems to make coarse decisions about reclaim behavior in the
presence of likely fragmentation.

The helper implements a simple heuristic: if the number of free pages
in a zone exceeds twice the high watermark, the zone is considered to
have ample free memory and allocation failures are more likely due to
fragmentation than overall memory pressure.

This is intentionally imprecise and is not meant to replace the core
MM compaction or fragmentation accounting logic. Instead, it provides
a cheap signal for callers (e.g., shrinkers) that wish to avoid
overly aggressive reclaim when sufficient free memory exists but
high-order allocations may still fail.

No functional changes; this is a preparatory helper for future users.

Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 include/linux/vmstat.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 3c9c266cf782..568d9f4f1a1f 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -483,6 +483,19 @@ static inline const char *zone_stat_name(enum zone_stat_item item)
 	return vmstat_text[item];
 }
 
+static inline bool zone_appears_fragmented(struct zone *zone)
+{
+	/*
+	 * Simple heuristic: if the number of free pages is more than twice the
+	 * high watermark, this strongly suggests that the zone is heavily
+	 * fragmented when called from a shrinker.
+	 */
+	if (zone_page_state(zone, NR_FREE_PAGES) > high_wmark_pages(zone) * 2)
+		return true;
+
+	return false;
+}
+
 #ifdef CONFIG_NUMA
 static inline const char *numa_stat_name(enum numa_stat_item item)
 {
-- 
2.34.1

