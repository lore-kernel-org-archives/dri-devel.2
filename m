Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D73AFAD41D
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 05:57:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABCC410EF71;
	Thu, 23 Apr 2026 05:57:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="IakmG9jO";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F142610EAEE;
 Thu, 23 Apr 2026 05:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776923824; x=1808459824;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pqkXaby60d8tyPEVKZKrwShQVwf0Bu4B9zoMaLztWAE=;
 b=IakmG9jOd7pEVHTyOujJvJO8fL03MUL1iouSL8jNxx66F0n6HBlw8wvE
 bZbws7OwKDvxOvS3HtuUk7hLoP0huPdNn0DtPfiWYIV7r/LK6rJQUB4F+
 1N1mjUbPuOida7iz1hZgPfJyQN6tg4TvFil2Cq0qilC4h+YIr+lfP88LV
 ibAOHtobOmOevlEwldBvR9nc7/46aPJLx/wloY4zlbGN0LeGqN+TL1wKy
 fIjPrXvMfIgGXWFC3E+O6q2fzGOZrgVaIvA33cAIa111Zpx05KdQj0ZSp
 t3ISzKRQS7+ldcwKhHjq8rzbTF6WiSnAjHW3dsSYPHGXOiivm1ZOTLSoA A==;
X-CSE-ConnectionGUID: 3+aJgYz3SZ612epZjE0jdQ==
X-CSE-MsgGUID: gna5LJB4SKaHrSgxO2KTxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="89273782"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; d="scan'208";a="89273782"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 22:57:03 -0700
X-CSE-ConnectionGUID: APDUzY8cRY6kRzk7jmpJ1w==
X-CSE-MsgGUID: pXNy55PmTMOvjMlBsk2LMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; d="scan'208";a="255853904"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 22:57:03 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Carlos Santa <carlos.santa@intel.com>,
 Matthew Auld <matthew.auld@intel.com>
Subject: [PATCH v2 5/5] drm/xe: Avoid shrinker reclaim from kswapd under
 fragmentation
Date: Wed, 22 Apr 2026 22:56:56 -0700
Message-Id: <20260423055656.1696379-6-matthew.brost@intel.com>
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

When the Xe shrinker is invoked from kswapd, a large amount of free
memory in usable zones relative to the high watermark is a strong
signal that reclaim is being driven by fragmentation rather than true
memory pressure.

In this case, shrinking Xe memory is unlikely to help kswapd make
forward progress. Instead it can evict active GPU memory despite the
system still having substantial free memory, increasing residency churn
and reducing GPU forward progress.

Detect this case and bail out early from the Xe shrinker when running in
kswapd and any usable zone has more than 2x its high watermark free.

Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Carlos Santa <carlos.santa@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/xe_shrinker.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_shrinker.c b/drivers/gpu/drm/xe/xe_shrinker.c
index 83374cd57660..e28e5e90c198 100644
--- a/drivers/gpu/drm/xe/xe_shrinker.c
+++ b/drivers/gpu/drm/xe/xe_shrinker.c
@@ -236,6 +236,9 @@ static unsigned long xe_shrinker_scan(struct shrinker *shrink, struct shrink_con
 	if (nr_scanned >= nr_to_scan || !can_backup)
 		goto out;
 
+	if (ttm_bo_shrink_kswap_fragmented(sc->nid))
+		goto out;
+
 	/* If we didn't wake before, try to do it now if needed. */
 	if (!runtime_pm)
 		runtime_pm = xe_shrinker_runtime_pm_get(shrinker, true, 0, can_backup);
-- 
2.34.1

