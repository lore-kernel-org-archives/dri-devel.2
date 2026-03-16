Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB92D58B36
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 04:33:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B315310E2CC;
	Mon, 16 Mar 2026 04:33:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ArNjb5IL";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5B7E10E2BF;
 Mon, 16 Mar 2026 04:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773635583; x=1805171583;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wXwYaOySTGGfB3gf1/A0umyZ1UYq9uIH6hcSZLf6vZg=;
 b=ArNjb5ILaGhdfdV6yZ6m21X8DUczCyPn0y3wher78sSeA3vownxQXlil
 qEYkH2l6WmF64q47lJhrhXzCeFlRo3Ys3utVNU5Iclj8GHSjoqQF9ZoeI
 tBPfa5KuKlZqQ7PhBEMq58dln+vOvaUYZBlreGjxdjwVcx+sLhV6DvRX8
 eUuOU+7nPlmhp8ZUeS8hTRytZdA4QX774kL7CRbv3JylF1LYHb4Vh/h6W
 T3+L22Pw0+vF+440BTrLkNYEgxHdsaXluY8+sAHwfgWcgMuguhwwXhucn
 5OojNQerpPeQNzI4ey9cqmRA8LPmgBTm7LlcpXtA6agJWYhi7KfTZbA9T w==;
X-CSE-ConnectionGUID: kawWX14kS7mC2+vzajqMzQ==
X-CSE-MsgGUID: zNdLd6WpQn6KMVlzvoONRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="74683493"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; d="scan'208";a="74683493"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2026 21:33:02 -0700
X-CSE-ConnectionGUID: XGu9hq1yQ+Car6BhMFWGVQ==
X-CSE-MsgGUID: wJm0NCl9Qk+LB1vY2ecCOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; d="scan'208";a="221022167"
Received: from lstrano-desk.jf.intel.com ([10.54.39.91])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2026 21:33:03 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Subject: [RFC PATCH 04/12] drm/xe: Issue GGTT invalidation under lock in
 ggtt_node_remove
Date: Sun, 15 Mar 2026 21:32:47 -0700
Message-Id: <20260316043255.226352-5-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260316043255.226352-1-matthew.brost@intel.com>
References: <20260316043255.226352-1-matthew.brost@intel.com>
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

Async work (e.g., GuC queue teardowns) can call ggtt_node_remove, so the
operation must be performed under the GGTT lock to ensure the GGTT
online check remains stable. GGTT insertion and removal are heavyweight
operations (e.g., queue create/destroy), so the additional serialization
cost is negligible compared to ensuring correctness.

Fixes: 4f3a998a173b ("drm/xe: Open-code GGTT MMIO access protection")
Signed-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/xe_ggtt.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_ggtt.c b/drivers/gpu/drm/xe/xe_ggtt.c
index 017f679ba13f..353b324f7301 100644
--- a/drivers/gpu/drm/xe/xe_ggtt.c
+++ b/drivers/gpu/drm/xe/xe_ggtt.c
@@ -482,15 +482,10 @@ static void ggtt_node_remove(struct xe_ggtt_node *node)
 		xe_ggtt_clear(ggtt, xe_ggtt_node_addr(node), xe_ggtt_node_size(node));
 	drm_mm_remove_node(&node->base);
 	node->base.size = 0;
-	mutex_unlock(&ggtt->lock);
-
-	if (!bound)
-		goto free_node;
-
-	if (node->invalidate_on_remove)
+	if (bound && node->invalidate_on_remove)
 		xe_ggtt_invalidate(ggtt);
+	mutex_unlock(&ggtt->lock);
 
-free_node:
 	ggtt_node_fini(node);
 }
 
-- 
2.34.1

