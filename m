Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D73FFD877D
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 14:19:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D7B110E67E;
	Tue, 17 Mar 2026 14:19:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="NpfGFV+M";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0B0710E686;
 Tue, 17 Mar 2026 14:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773757169; x=1805293169;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Cl0mFV0d7COkPjBdW7a6kGa1YCGJO0GYnCCCL4DYXbM=;
 b=NpfGFV+MdeOfyzj1sgWFKJWNSraaRb3jK26XAmfrbjmcn1ubTJRJln9m
 DQRrIePt0cIK6LAoBDNGaIQ1kMrpEHbLMoOyjB6ZwUGOy6Y7KSRlaPXOu
 9aDVAOpvyGXLFr31pZs0Ims5MjYC30ZNdVrRSxD83uebeb8z0cHNXuJvX
 dbzWkLDRuonqP7b7cAnVIkbZR6QS3PT6URMJyE1JCm9a963V1mcuvkHW0
 L+To0SzBFZkLEqGTIrMWPQ1kemBZ2i0mhCrmxOWN7T67XKPvFwS/dJRbA
 /xV6hLpqieCXzCCwBAChbL/jtQ+B3BMs4jMAGaBDWWOnfkXP5Yr+is2BK w==;
X-CSE-ConnectionGUID: CIt+e4A9RMW86QUUVVD81w==
X-CSE-MsgGUID: BFWGPr6RTjCEbL1ULc69Cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="74973148"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="74973148"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 07:19:29 -0700
X-CSE-ConnectionGUID: cTMKT0RkRUy6YYOMJeI1dA==
X-CSE-MsgGUID: jh5TpPzgQjudEZIo6KNGLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="260184989"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO fedora)
 ([10.245.245.163])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 07:19:27 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Matthew Brost <matthew.brost@intel.com>,
 Matthew Auld <matthew.auld@intel.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v2 3/3] drm/ttm: Update the struct ttm_operation_ctx kerneldoc
Date: Tue, 17 Mar 2026 15:18:56 +0100
Message-ID: <20260317141856.237876-4-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317141856.237876-1-thomas.hellstrom@linux.intel.com>
References: <20260317141856.237876-1-thomas.hellstrom@linux.intel.com>
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

Update the kerneldoc with a more elaborate description of some members,
including the gfp_retry_mayfail member. Use inline kerneldoc.

Suggested-by: Simona Vetter <simona.vetter@ffwll.ch>
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 include/drm/ttm/ttm_bo.h | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
index bca3a8849d47..8310bc3d55f9 100644
--- a/include/drm/ttm/ttm_bo.h
+++ b/include/drm/ttm/ttm_bo.h
@@ -167,24 +167,34 @@ struct ttm_bo_kmap_obj {
 /**
  * struct ttm_operation_ctx
  *
- * @interruptible: Sleep interruptible if sleeping.
- * @no_wait_gpu: Return immediately if the GPU is busy.
- * @gfp_retry_mayfail: Set the __GFP_RETRY_MAYFAIL when allocation pages.
- * @allow_res_evict: Allow eviction of reserved BOs. Can be used when multiple
- * BOs share the same reservation object.
- * faults. Should only be used by TTM internally.
- * @resv: Reservation object to allow reserved evictions with.
- * @bytes_moved: Statistics on how many bytes have been moved.
- *
  * Context for TTM operations like changing buffer placement or general memory
  * allocation.
  */
 struct ttm_operation_ctx {
+	/** @interruptible: Sleep interruptible if sleeping. */
 	bool interruptible;
+	/** @no_wait_gpu: Return immediately if the GPU is busy. */
 	bool no_wait_gpu;
+	/**
+	 * @gfp_retry_mayfail: Use __GFP_RETRY_MAYFAIL | __GFP_NOWARN
+	 * when allocation pages. This is to avoid invoking the OOM
+	 * killer when populating a buffer object, in order to
+	 * forward the error for it to be dealt with.
+	 */
 	bool gfp_retry_mayfail;
+	/**
+	 * @allow_res_evict: Allow eviction of reserved BOs. Can be used
+	 * when multiple BOs share the same reservation object @resv.
+	 */
 	bool allow_res_evict;
+	/**
+	 * @resv: Reservation object to be used together with
+	 * @allow_res_evict.
+	 */
 	struct dma_resv *resv;
+	/**
+	 * @bytes_moved: Statistics on how many bytes have been moved.
+	 */
 	uint64_t bytes_moved;
 };
 
-- 
2.53.0

