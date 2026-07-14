Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49117C4450A
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 17:00:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95B9B10E0B1;
	Tue, 14 Jul 2026 17:00:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="J7ML6q+b";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B7D710E086;
 Tue, 14 Jul 2026 17:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784048432; x=1815584432;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=CtzHXLm4rqQfESPrSLFYzqXudFQYcZGZv7gLN/aBxbc=;
 b=J7ML6q+bJK+FhNXP8hh6aI1Q/9LnSGtz0t5UqOxTk7xOHcmYGOkgSkne
 IUULzPbcLGwJoWZLf4zqKoBNAmlDGoPQZlFYVNdxGIPB04OMiseCHs+f6
 X2yihKRF3hXkS6D/q8OcIi/ZanombNHEk9yzJcZUvTlRhzTIAM/EnabU/
 2sspZKfsjK1/xg3Dq0rkeL6Z/6t4G8wwPXGvj6slYZD9n5lyR2b7/RT6d
 jJ9WSYK7WljTqWGCiPnUSDD29q7yKRJC07k1TfT4wXeinvX9q/VN5yHJd
 Dc1/d8rYxp4DnkpqcGALZTGV6EA8UXpKn74swUjG/JImajbV4dpwXjnqb w==;
X-CSE-ConnectionGUID: jUi8BFIuRlG4WLIhn+wAlw==
X-CSE-MsgGUID: 8Nv/Ix1FSfSLRR+YH9snLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="95031411"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; d="scan'208";a="95031411"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2026 10:00:31 -0700
X-CSE-ConnectionGUID: Oe7vmsbuTyuYxEBUwATK1w==
X-CSE-MsgGUID: NQTjB/69Rr6qxHiLC1iJIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; d="scan'208";a="294124194"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2026 10:00:31 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: [PATCH] drm/gpusvm: Fix MM reference leak in drm_gpusvm_range_evict
Date: Tue, 14 Jul 2026 10:00:25 -0700
Message-Id: <20260714170025.3487974-1-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
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

If kvmalloc_array() fails in drm_gpusvm_range_evict(), the MM
reference acquired earlier is not released, resulting in a reference
leak.

Fix this by dropping the MM reference on the kvmalloc_array()
failure path.

Fixes: 99624bdff867 ("drm/gpusvm: Add support for GPU Shared Virtual Memory")
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/drm_gpusvm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index f45bf1d59a06..ac1f135abe68 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -1778,8 +1778,10 @@ int drm_gpusvm_range_evict(struct drm_gpusvm *gpusvm,
 		return -EFAULT;
 
 	pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
-	if (!pfns)
+	if (!pfns) {
+		mmput(mm);
 		return -ENOMEM;
+	}
 
 	hmm_range.hmm_pfns = pfns;
 	while (!time_after(jiffies, timeout)) {
-- 
2.34.1

