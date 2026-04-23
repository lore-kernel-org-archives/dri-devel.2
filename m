Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F70FAD41D
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 05:57:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F150C10EEA7;
	Thu, 23 Apr 2026 05:57:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Z+lf1gz8";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEDCA10E2F2;
 Thu, 23 Apr 2026 05:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776923823; x=1808459823;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hsHgScCxQVJV/K6RTRvGy6DprJSpi4VsXf5vCbC/9Dc=;
 b=Z+lf1gz8c86Idx9lGDEVL4E9K/PuS2YXY1+6rAKDtG4KQpq05XSj4wo9
 EeUJIwYFuJ87AYvuDNFwQrOzQYvC/UUdP2Iz0vPq8b4f7+wksfJXHGsyd
 T7R4Bqp8JAhojlqJ9BlV4IgnCqGTFxaKCViEDKdBtdRr/oLmdpF/1Qe4y
 NcxHD7jNqYRdqXdP9QtiBFEYfz9kC/N2nk7dXdAoTMYNc9HgMUR17TDBA
 FQ/zOfbKQt/SIhW/C/RXIUlEpsyXWhUVx7+vyGXpdudIBDZryi1jUjrfx
 dWKUuMthadS6c64inE4x6jvDu1PiVStefmy/l/rIXkZYeGI+1+09I6ZDZ Q==;
X-CSE-ConnectionGUID: Z6w192bGTga90FMupLJ6hw==
X-CSE-MsgGUID: AsqlSCbXTGat74iflU/cCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="89273778"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; d="scan'208";a="89273778"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 22:57:03 -0700
X-CSE-ConnectionGUID: zWQzl2OtRBi/wi9RndzZ+g==
X-CSE-MsgGUID: ecl1muOFTxu4fdK7uynfjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; d="scan'208";a="255853896"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 22:57:03 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Carlos Santa <carlos.santa@intel.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Daniel Colascione <dancol@dancol.org>
Subject: [PATCH v2 3/5] drm/ttm: Introduce ttm_bo_shrink_kswap_fragmented()
Date: Wed, 22 Apr 2026 22:56:54 -0700
Message-Id: <20260423055656.1696379-4-matthew.brost@intel.com>
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

Introduce ttm_bo_shrink_kswap_fragmented() to allow TTM users to
distinguish background reclaim from kswapd that is likely driven by
high-order allocation failures under fragmentation.

The helper returns true when:
  - reclaim is running in kswapd, and
  - the target node is valid, and
  - one of the relevant zones reports free pages significantly above
    its high watermark (via zone_appears_fragmented()).

This provides a coarse signal that overall free memory is available,
and that reclaim activity may be driven by fragmentation rather than
true memory pressure.

The intent is to allow drivers to adjust shrinker behavior in this
case, for example by preferring purgeable or low-value objects instead
of aggressively evicting active working sets in the background reclaim
path.

The heuristic is intentionally simple and conservative, and is not
intended to replace core MM fragmentation or compaction decisions.

No functional change; this is a preparatory helper for TTM users.

Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Carlos Santa <carlos.santa@intel.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
CC: dri-devel@lists.freedesktop.org
Cc: Daniel Colascione <dancol@dancol.org>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/ttm/ttm_bo_util.c | 34 +++++++++++++++++++++++++++++++
 include/drm/ttm/ttm_bo.h          |  2 ++
 2 files changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
index f83b7d5ec6c6..46adcb7d9a0c 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -1169,3 +1169,37 @@ bool ttm_bo_shrink_avoid_wait(void)
 	return !current_is_kswapd();
 }
 EXPORT_SYMBOL(ttm_bo_shrink_avoid_wait);
+
+/**
+ * ttm_bo_shrink_kswap_fragmented() - Whether in kswap and memory appears
+ * fragmented
+ * @nid: current node being shrunk
+ *
+ * Return: true if in kswap and memory appears fragmented, false is not.
+ */
+bool ttm_bo_shrink_kswap_fragmented(int nid)
+{
+	enum zone_type zone_type;
+
+	if (!current_is_kswapd())
+		return false;
+
+	if (!numa_valid_node(nid))
+		return false;
+
+#if IS_ENABLED(CONFIG_ZONE_DMA32)
+	zone_type = ZONE_DMA32;
+#else
+	zone_type = ZONE_NORMAL;
+#endif
+
+	for (; zone_type <= ZONE_NORMAL; ++zone_type) {
+		struct zone *zone = &NODE_DATA(nid)->node_zones[zone_type];
+
+		if (zone_appears_fragmented(zone))
+			return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL(ttm_bo_shrink_kswap_fragmented);
diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
index 8310bc3d55f9..9a457fd667bb 100644
--- a/include/drm/ttm/ttm_bo.h
+++ b/include/drm/ttm/ttm_bo.h
@@ -262,6 +262,8 @@ bool ttm_bo_shrink_suitable(struct ttm_buffer_object *bo, struct ttm_operation_c
 
 bool ttm_bo_shrink_avoid_wait(void);
 
+bool ttm_bo_shrink_kswap_fragmented(int nid);
+
 /**
  * ttm_bo_reserve:
  *
-- 
2.34.1

