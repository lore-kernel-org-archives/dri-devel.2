Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B52CF5A8D1
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 01:26:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 628EC10E789;
	Tue, 21 Apr 2026 01:26:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="BlPX1i0E";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D7C410E77F;
 Tue, 21 Apr 2026 01:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776734776; x=1808270776;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RobSH1+EByorRkYSWfZ+tblnyoIKvggNRyp7OoZWA3I=;
 b=BlPX1i0Eg3bTu/X4yocZtNdxTtvFmleECt5E0mef1uVAm2W7HpPS0CEE
 Gm8MzIf1UvZgNEaDAxU3ZgvFXbxN2RWGSIADRQk1LFT3nOVDfyRMsYRD9
 e4KhD9sZ9iV4BRB+3JOWlLUCBvIePNOA7/goRcPiDLu8qCk4yd+Drjuw1
 KGlNsVkJhsuJD6IB28I98RlCD6Bi+u/yD9G5TDgKePSYAXCqsQxDitzZ1
 8aadgVjhPS0QGb1rEvyAq24/FPkexJVjqP2q2/x1wnWhy6Lp/qPXbFxz/
 gaBwNkGqVKFTaO6VQVtNIENgImCrrph2vhpKH5984u1WxWN2SFmOf+R9d Q==;
X-CSE-ConnectionGUID: 1hggxvAnSJeUhWAkKmj0mQ==
X-CSE-MsgGUID: YO6W/BA9SQyT+u/drVuMuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="88280335"
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; d="scan'208";a="88280335"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2026 18:26:15 -0700
X-CSE-ConnectionGUID: jJOCwPoMR76rqLvham2Mrg==
X-CSE-MsgGUID: CM9AWdv3Re+0j/njFKxrMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; d="scan'208";a="236872346"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2026 18:26:15 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Carlos Santa <carlos.santa@intel.com>,
 Matthew Auld <matthew.auld@intel.com>
Subject: [PATCH 3/3] drm/xe: Avoid shrinker reclaim from kswapd under
 fragmentation
Date: Mon, 20 Apr 2026 18:26:08 -0700
Message-Id: <20260421012608.1474950-4-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260421012608.1474950-1-matthew.brost@intel.com>
References: <20260421012608.1474950-1-matthew.brost@intel.com>
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

When the Xe shrinker is invoked from kswapd, a large amount of free
memory in ZONE_NORMAL relative to the high watermark is a strong signal
that reclaim is being driven by fragmentation rather than true memory
pressure.

In this case, shrinking Xe memory is unlikely to help kswapd make
forward progress. Instead it can evict active GPU memory despite the
system still having substantial free memory, increasing residency churn
and reducing GPU forward progress.

Detect this case and bail out early from the Xe shrinker when running in
kswapd and ZONE_NORMAL has more than 2x its high watermark free.

Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Carlos Santa <carlos.santa@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/xe_shrinker.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_shrinker.c b/drivers/gpu/drm/xe/xe_shrinker.c
index 83374cd57660..e56afde83de6 100644
--- a/drivers/gpu/drm/xe/xe_shrinker.c
+++ b/drivers/gpu/drm/xe/xe_shrinker.c
@@ -236,6 +236,19 @@ static unsigned long xe_shrinker_scan(struct shrinker *shrink, struct shrink_con
 	if (nr_scanned >= nr_to_scan || !can_backup)
 		goto out;
 
+	if (current_is_kswapd()) {
+		struct zone *zone = &NODE_DATA(sc->nid)->node_zones[ZONE_NORMAL];
+		unsigned long free_pages = zone_page_state(zone, NR_FREE_PAGES);
+		unsigned long high_wmark = high_wmark_pages(zone);
+
+		/*
+		 * If we have 2x the high watermark free, this is definitely
+		 * fragmentation
+		 */
+		if (free_pages > (high_wmark * 2))
+			goto out;
+	}
+
 	/* If we didn't wake before, try to do it now if needed. */
 	if (!runtime_pm)
 		runtime_pm = xe_shrinker_runtime_pm_get(shrinker, true, 0, can_backup);
-- 
2.34.1

