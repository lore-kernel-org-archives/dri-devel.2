Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F51CD3431
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 19:18:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD13F10F433;
	Thu, 30 Apr 2026 19:18:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="aCEOg9hz";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9742D10E473;
 Thu, 30 Apr 2026 19:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777576696; x=1809112696;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=92+FDe4gHC+T6fpOI9/mqI9PXCfenempEWYsk8gMilQ=;
 b=aCEOg9hzzMBq3gkGQTFPRT1qX/V7a6524EFlkrQtao4DDVojf+ZkqYV+
 DHqShPFToBgab7sXoLjE2w87CEholwwirV+3tT/7ayVrp7yPiKeLnjKKP
 0zVOZyWh6STSHNUOXS2ozjs+fg94O38wEcLjFkwlgJitgR+tRrRv3QO6a
 Fcu+oCEkCBkEcYw2qv6jyrjWaobWBgnzfJe/js1SOAH7Bv9Q1tC71x40Z
 ah8W4tS9XlvQIm2vl7dMGthaxY2+C3C//IgLwNqOLPTFmsxNP2SJUNPZw
 rh7kL1xqGhxXHcELJM1xX2Ohqcy+leDCF5zhe1OwNcSg8hJaoboQmxUZm Q==;
X-CSE-ConnectionGUID: ixkhQLP5Saa0aFCABdOWfQ==
X-CSE-MsgGUID: nXg4OAgOR56bd+w81LsBFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="77706760"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="77706760"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 12:18:14 -0700
X-CSE-ConnectionGUID: fl+F7u5CRZ6OKnX3feThwA==
X-CSE-MsgGUID: 89DiQWwxSOmkvp2wu7YWgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="233801152"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 12:18:14 -0700
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
Subject: [PATCH v4 4/6] drm/ttm: Introduce
 ttm_bo_shrink_kswap_maybe_fragmented()
Date: Thu, 30 Apr 2026 12:18:07 -0700
Message-Id: <20260430191809.2142544-5-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430191809.2142544-1-matthew.brost@intel.com>
References: <20260430191809.2142544-1-matthew.brost@intel.com>
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

Introduce ttm_bo_shrink_kswap_maybe_fragmented() to allow TTM users to
distinguish background reclaim from kswapd that is likely driven by
high-order allocation failures under fragmentation.

The helper returns true when:
  - order of shrinker invocation is zero
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

v3:
 - s/ttm_bo_shrink_kswap_fragmented/ttm_bo_shrink_kswap_maybe_fragmented
   (Andi)
 - Wire in order (Thomas)
---
 drivers/gpu/drm/ttm/ttm_bo_util.c | 38 +++++++++++++++++++++++++++++++
 include/drm/ttm/ttm_bo.h          |  2 ++
 2 files changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
index f83b7d5ec6c6..a6a4255c10cc 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -1169,3 +1169,41 @@ bool ttm_bo_shrink_avoid_wait(void)
 	return !current_is_kswapd();
 }
 EXPORT_SYMBOL(ttm_bo_shrink_avoid_wait);
+
+/**
+ * ttm_bo_shrink_kswap_maybe_fragmented() - Whether in kswap and memory might be
+ * fragmented
+ * @nid: current node being shrunk
+ * @order: order of shrinker invocation
+ *
+ * Return: true if in kswap and memory appears fragmented, false is not.
+ */
+bool ttm_bo_shrink_kswap_maybe_fragmented(int nid, s8 order)
+{
+	enum zone_type zone_type;
+
+	if (!order)
+		return false;
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
+		if (zone_maybe_fragmented_in_shrinker(zone))
+			return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL(ttm_bo_shrink_kswap_maybe_fragmented);
diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
index 8310bc3d55f9..4d00f9aa90a1 100644
--- a/include/drm/ttm/ttm_bo.h
+++ b/include/drm/ttm/ttm_bo.h
@@ -262,6 +262,8 @@ bool ttm_bo_shrink_suitable(struct ttm_buffer_object *bo, struct ttm_operation_c
 
 bool ttm_bo_shrink_avoid_wait(void);
 
+bool ttm_bo_shrink_kswap_maybe_fragmented(int nid, s8 order);
+
 /**
  * ttm_bo_reserve:
  *
-- 
2.34.1

