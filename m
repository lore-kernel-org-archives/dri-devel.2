Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28EEECD342A
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 19:18:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 020C110F42D;
	Thu, 30 Apr 2026 19:18:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="G2LrFU6I";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E0CD10F423;
 Thu, 30 Apr 2026 19:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777576696; x=1809112696;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4bEaboavwvba/lkphuRIAp9zSE075OT9HVs3VNTQaTs=;
 b=G2LrFU6ISxD6eb8JdMLV+PEpbT9i3Z4h/iSaOnACtV8tsSmwZH0PVyhZ
 Y1hCT65fkSIusIPKFYSFggiUjJLphBfVaE3jj6WTvhhxyamTEokW6JemD
 OFtFCFCtIIT2rybuz689X+hByuTNogcjhbeo7K20Fv4SlqbwkyBzoPeta
 GpQoLhP/RUWlyigEp0CVSEDZscr5sfr0GrSe+aJIBF0lilATdlXDH/mtT
 VDHdEz/im1CyF8M4gBIBYsxS2DBvC0ygkv7vrI4lVc7rwVFJoSEBP6Eg3
 tQX/k67ddbLNtQNdjQdnCJcQ2BZ88TCg+/YnoPxDU/zm6rZF/hPabKF/U w==;
X-CSE-ConnectionGUID: fHhYKg5GRSWzF3/8vpVQDA==
X-CSE-MsgGUID: H3ZLT/jKQWWD6Oo4yzdJwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="77706764"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="77706764"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 12:18:15 -0700
X-CSE-ConnectionGUID: bxahZJR/QFeibOBQrWtRzQ==
X-CSE-MsgGUID: XK8BFD2mQSquN1mXeePEPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="233801157"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 12:18:14 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Carlos Santa <carlos.santa@intel.com>,
 Matthew Auld <matthew.auld@intel.com>
Subject: [PATCH v4 6/6] drm/xe: Avoid shrinker reclaim from kswapd under
 fragmentation
Date: Thu, 30 Apr 2026 12:18:09 -0700
Message-Id: <20260430191809.2142544-7-matthew.brost@intel.com>
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

When the Xe shrinker is invoked from kswapd, a large amount of free
memory in usable zones relative to the high watermark is a strong
signal that reclaim is being driven by fragmentation rather than true
memory pressure.

In this case, shrinking Xe memory is unlikely to help kswapd make
forward progress. Instead it can evict active GPU memory despite the
system still having substantial free memory, increasing residency churn
and reducing GPU forward progress.

Detect this case and bail out early from the Xe shrinker when running in
kswapd, shrinker invocation is a higher order, and any usable zone has
more than 2x its high watermark free.

Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Carlos Santa <carlos.santa@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>

---

v3:
 - Wire in order to heuristic (Thomas)
---
 drivers/gpu/drm/xe/xe_shrinker.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_shrinker.c b/drivers/gpu/drm/xe/xe_shrinker.c
index 83374cd57660..792e0e216442 100644
--- a/drivers/gpu/drm/xe/xe_shrinker.c
+++ b/drivers/gpu/drm/xe/xe_shrinker.c
@@ -236,6 +236,9 @@ static unsigned long xe_shrinker_scan(struct shrinker *shrink, struct shrink_con
 	if (nr_scanned >= nr_to_scan || !can_backup)
 		goto out;
 
+	if (ttm_bo_shrink_kswap_maybe_fragmented(sc->nid, sc->order))
+		goto out;
+
 	/* If we didn't wake before, try to do it now if needed. */
 	if (!runtime_pm)
 		runtime_pm = xe_shrinker_runtime_pm_get(shrinker, true, 0, can_backup);
-- 
2.34.1

