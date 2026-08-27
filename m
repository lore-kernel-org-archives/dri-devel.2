Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3740BC61DC2
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 10:18:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27D3810EF85;
	Thu, 27 Aug 2026 10:18:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="apqI9r9r";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B58D710E64B;
 Thu, 27 Aug 2026 10:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787825915; x=1819361915;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=v+ubg/WH+Jrm6SS46xZYZl0sYLgCstwo6pwtqD0Wwu0=;
 b=apqI9r9rB6cby/5mQCvITDdPoM+K3ZUvglDpvD+Pf7a5njTs67NxzV6q
 Rv7ZYoUQ7cOFmfnrx5RyzCnD5UzYPDHDV3/OaHSgyAGEGvuZZW86lvhW0
 c+Hf9JO0nxGEnUrJSad5hWxWIx1mNhXBYdPv/cppQx7eauv3QFzKPPb+b
 s2tSVpf6LoaqlR9kx5RbkzUZtKeZU5y048ZzYYUbFJpC+TxFl2pNZrwPt
 56uOM/YN6mH5lj2uqede4lkNNCxrgsyHRIIUENmL7WqoDv3I/ncwS0d3+
 SXPsb0MLu6p//JK3oCedfaL+Vc0jGryZ5EuZ8G+ws0uQTzq3biTQWRRaJ w==;
X-CSE-ConnectionGUID: gh3RS9P8SmaSz34Zaj6bJA==
X-CSE-MsgGUID: syaq+buORbeyWKeYsofzVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="88445861"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="88445861"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 03:18:35 -0700
X-CSE-ConnectionGUID: md38KBS/ReWvzw/x2I8TEQ==
X-CSE-MsgGUID: uXf5umhaTE+N0cJlGYENkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="306057617"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 03:18:34 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com
Subject: [PATCH 03/13] drm/xe: Drop queued page faults when device I/O is
 blocked
Date: Thu, 27 Aug 2026 15:47:51 +0530
Message-ID: <20260827101801.1247654-4-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827101801.1247654-1-arvind.yadav@intel.com>
References: <20260827101801.1247654-1-arvind.yadav@intel.com>
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

Page-fault work may still be queued when PCI error recovery starts or
the device becomes permanently wedged. Servicing these faults can migrate
memory or update page tables after device I/O has been blocked.

Check the device state before and after fault servicing to cover a reset
racing with the worker. Drop the active fault and its chained faults
without sending a hardware response, and invalidate the cached fault
state.

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_pagefault.c | 40 +++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_pagefault.c b/drivers/gpu/drm/xe/xe_pagefault.c
index 2e415995f067..f486165f2323 100644
--- a/drivers/gpu/drm/xe/xe_pagefault.c
+++ b/drivers/gpu/drm/xe/xe_pagefault.c
@@ -592,6 +592,38 @@ static void xe_pagefault_save_to_vm(struct xe_device *xe, struct xe_pagefault *p
 	xe_vm_put(vm);
 }
 
+static bool
+xe_pagefault_drop_if_blocked(struct xe_pagefault_queue *pf_queue,
+			     struct xe_pagefault_work *pf_work,
+			     struct xe_pagefault *pf,
+			     u64 *cache_start)
+{
+	struct xe_pagefault *next;
+
+	if (!xe_device_io_blocked(pf_work->xe))
+		return false;
+
+	/*
+	 * cache_start is private to this worker invocation. pf_work->cache is
+	 * shared with fault producers and must be invalidated under the queue
+	 * lock.
+	 */
+	xe_pagefault_cache_start_invalidate(*cache_start);
+
+	guard(spinlock_irq)(&pf_queue->lock);
+
+	xe_pagefault_cache_invalidate(pf_queue, pf_work);
+
+	while (pf) {
+		next = pf->consumer.next;
+		pf->consumer.next = NULL;
+		pf->consumer.alloc_state = XE_PAGEFAULT_ALLOC_STATE_FREE;
+		pf = next;
+	}
+
+	return true;
+}
+
 static void xe_pagefault_queue_work(struct work_struct *w)
 {
 	struct xe_pagefault_work *pf_work =
@@ -615,6 +647,10 @@ static void xe_pagefault_queue_work(struct work_struct *w)
 		int err = 0;
 		bool invalidated = false;
 
+		if (xe_pagefault_drop_if_blocked(pf_queue, pf_work, pf,
+						 &cache_start))
+			continue;
+
 		/* Last fault same address, ack immediately */
 		if (xe_pagefault_match(pf, cache_start, cache_end, cache_asid)) {
 			xe_gt_stats_incr(gt, XE_GT_STATS_ID_LAST_PAGEFAULT_COUNT, 1);
@@ -623,6 +659,10 @@ static void xe_pagefault_queue_work(struct work_struct *w)
 
 		err = xe_pagefault_service(pf);
 
+		if (xe_pagefault_drop_if_blocked(pf_queue, pf_work, pf,
+						 &cache_start))
+			continue;
+
 		if (err) {
 			if (!(pf->consumer.access_type & XE_PAGEFAULT_ACCESS_PREFETCH)) {
 				xe_pagefault_save_to_vm(gt_to_xe(gt), pf);
-- 
2.43.0

