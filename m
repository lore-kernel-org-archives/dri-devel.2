Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A230CD3423
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 18:23:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B42F10F404;
	Thu, 30 Apr 2026 18:23:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="m2KycJb4";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9831310E480;
 Thu, 30 Apr 2026 18:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777573422; x=1809109422;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GHkxm0wYYb4SrQQJzp26BvqDgj5d1MTHLdsthOQOpLE=;
 b=m2KycJb4kB8VjqQSiNji/2vtsV1cope3gWWpseJdQAoTivd4iRddC60a
 tMDdTbwWjgRilNwgS9mSn44lkD3gQNLsqPT7FPsRHWw8yJQySLHR5KR/u
 77sMchg4JwTHjY2xQYBJY86OYcP/G4cBteZ2x/XlE6cXMGEAZ5O+BLdqQ
 1oC+w0srQOkuJYio0Mcg3OXiW0oUaVowPpQ8zHzFoWb+1KrlHHa5QJ/Ql
 j/TuEYhcu+j6kumTMTHQ8b1RTqXDN2d9a/u8f+TYxidJRo0nrWlz1u4qB
 1Qvos3vBUAdQhcsdX1Te3ghQgOMSyY98/6N1Wes5LYy+GZCwFFeiluyCb g==;
X-CSE-ConnectionGUID: m9xW0HwnT/iqozCK/U5uEw==
X-CSE-MsgGUID: +c6xqV4SSHeQKn6FOxPklA==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="82388997"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="82388997"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 11:23:41 -0700
X-CSE-ConnectionGUID: j8ntlywORQaX6R++juekDw==
X-CSE-MsgGUID: VDeEfBTvQ664s14Kaz6mMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="231532218"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 11:23:41 -0700
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
Subject: [PATCH v3 2/6] mm: Introduce zone_maybe_fragmented_in_shrinker()
Date: Thu, 30 Apr 2026 11:23:31 -0700
Message-Id: <20260430182335.2132382-3-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430182335.2132382-1-matthew.brost@intel.com>
References: <20260430182335.2132382-1-matthew.brost@intel.com>
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

Introduce zone_maybe_fragmented_in_shrinker() as a lightweight helper to
allow subsystems to make coarse decisions about reclaim behavior in the
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

v3: s/zone_appear_fragmented/zone_maybe_fragmented_in_shrinker (David
    Hildenbrand)
---
 include/linux/vmstat.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 3c9c266cf782..1ad48f70c9d9 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -483,6 +483,18 @@ static inline const char *zone_stat_name(enum zone_stat_item item)
 	return vmstat_text[item];
 }
 
+static inline bool zone_maybe_fragmented_in_shrinker(struct zone *zone)
+{
+	/*
+	 * Simple heuristic: if the number of free pages is more than twice the
+	 * high watermark, this may suggest that the zone is heavily fragmented.
+	 * When called from a shrinker, aggressively evicting memory in this case
+	 * may do more harm to overall system performance than good.
+	 */
+	return zone_page_state(zone, NR_FREE_PAGES) >
+		high_wmark_pages(zone) * 2;
+}
+
 #ifdef CONFIG_NUMA
 static inline const char *numa_stat_name(enum numa_stat_item item)
 {
-- 
2.34.1

