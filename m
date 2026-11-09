Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0324606A323
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Q34DdMJ7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE8E710F2F3;
	Mon,  9 Nov 2026 13:56:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD74210F2E4;
 Mon,  9 Nov 2026 13:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794232573; x=1825768573;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wZjXXL2W1d1Hc/u3igjPzuuc/NSY9AQedXkz65xvxy0=;
 b=Q34DdMJ7r1FIdrymdkJHcsmO7a5u+IIgss31qiSbQrkM5HAkeAfCqz0n
 pzV3z2B5DFw+e4gEwlx7GyKpBLo3yVw+VRRlg7nqBebnRKpyUrHcQclwq
 Bgz8D/mOFQir4EevLzqAZBNCyRONPhaZA8v9WrpQvf8nhDmVUrUjaxOTJ
 yOpCqRpXI2U+xHpvBQIe1g4eNPekAVS5lEOCNFZUr9S6gU1a8323hMho+
 s19BYn59ix4hmT5Hofh6481mDusiYCDaA0wHFnE4ryyoR/Ojz+i0hmaD+
 01SUVc/JLD+S18TDk35oBZWKf/0Z9QUHY98Nb+MpH4WEu0djec2RsQixe g==;
X-CSE-ConnectionGUID: BuFVRP18Sw6p+MVsU3J+Wg==
X-CSE-MsgGUID: C7X6dI3SSIWDFYLWa0KjzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2850699"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2850699"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 05:56:12 -0800
X-CSE-ConnectionGUID: tPDQ0PkXSCSMyjnVFz2MRw==
X-CSE-MsgGUID: m0EAUA44QgyUT9q187oemg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="8202506"
Received: from pgcooper-mobl2.ger.corp.intel.com (HELO
 mkuoppal-desk.home.arpa) ([10.245.246.220])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 05:56:07 -0800
From: Mika Kuoppala <mika.kuoppala@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: simona.vetter@ffwll.ch, matthew.brost@intel.com, christian.koenig@amd.com,
 thomas.hellstrom@linux.intel.com, joonas.lahtinen@linux.intel.com,
 gustavo.sousa@intel.com, jan.maslak@intel.com,
 dominik.karol.piatkowski@intel.com, rodrigo.vivi@intel.com,
 andrzej.hajda@intel.com, matthew.auld@intel.com,
 maciej.patelczyk@intel.com, gwan-gyeong.mun@intel.com,
 michal.wajdeczko@intel.com, dri-devel@lists.freedesktop.org,
 Mika Kuoppala <mika.kuoppala@linux.intel.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 01/20] drm/ttm: Add ttm_bo_access_locked()
Date: Mon,  9 Nov 2026 15:55:26 +0200
Message-ID: <20261109135549.4128280-2-mika.kuoppala@linux.intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109135549.4128280-1-mika.kuoppala@linux.intel.com>
References: <20261109135549.4128280-1-mika.kuoppala@linux.intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ttm_bo_access() reserves the buffer object itself, so a caller that
already holds the reservation cannot use it. Split the body out as
ttm_bo_access_locked(), which asserts the reservation is held, and leave
ttm_bo_access() as reserve, access, unreserve.

The first user, eudebug vm access, has to wait for the move fences and
access the object under one reservation.

Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Michel Dänzer <michel.daenzer@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Mika Kuoppala <mika.kuoppala@linux.intel.com>
---
 drivers/gpu/drm/ttm/ttm_bo_vm.c | 61 +++++++++++++++++++++++----------
 include/drm/ttm/ttm_bo.h        |  2 ++
 2 files changed, 44 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
index 872bf444b1f0..9a252bce9091 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
@@ -405,6 +405,47 @@ static int ttm_bo_vm_access_kmap(struct ttm_buffer_object *bo,
 	return len;
 }
 
+/**
+ * ttm_bo_access_locked - Helper to access a reserved buffer object
+ *
+ * @bo: ttm buffer object, reserved by the caller
+ * @offset: access offset into buffer object
+ * @buf: pointer to caller memory to read into or write from
+ * @len: length of access
+ * @write: write access
+ *
+ * Same as ttm_bo_access(), for a caller that already holds the reservation,
+ * for instance to wait for fences before the access without the placement
+ * changing in between.
+ *
+ * Returns:
+ * @len if successful, negative error code on failure.
+ */
+int ttm_bo_access_locked(struct ttm_buffer_object *bo, unsigned long offset,
+			 void *buf, int len, int write)
+{
+	dma_resv_assert_held(bo->base.resv);
+
+	if (len < 1 || (offset + len) > bo->base.size)
+		return -EIO;
+
+	if (!bo->resource)
+		return -ENODATA;
+
+	switch (bo->resource->mem_type) {
+	case TTM_PL_SYSTEM:
+		fallthrough;
+	case TTM_PL_TT:
+		return ttm_bo_vm_access_kmap(bo, offset, buf, len, write);
+	default:
+		if (bo->bdev->funcs->access_memory)
+			return bo->bdev->funcs->access_memory
+				(bo, offset, buf, len, write);
+		return -EIO;
+	}
+}
+EXPORT_SYMBOL(ttm_bo_access_locked);
+
 /**
  * ttm_bo_access - Helper to access a buffer object
  *
@@ -433,26 +474,8 @@ int ttm_bo_access(struct ttm_buffer_object *bo, unsigned long offset,
 	if (ret)
 		return ret;
 
-	if (!bo->resource) {
-		ret = -ENODATA;
-		goto unlock;
-	}
-
-	switch (bo->resource->mem_type) {
-	case TTM_PL_SYSTEM:
-		fallthrough;
-	case TTM_PL_TT:
-		ret = ttm_bo_vm_access_kmap(bo, offset, buf, len, write);
-		break;
-	default:
-		if (bo->bdev->funcs->access_memory)
-			ret = bo->bdev->funcs->access_memory
-				(bo, offset, buf, len, write);
-		else
-			ret = -EIO;
-	}
+	ret = ttm_bo_access_locked(bo, offset, buf, len, write);
 
-unlock:
 	ttm_bo_unreserve(bo);
 
 	return ret;
diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
index 32791c4db2a9..3b08baa33ffd 100644
--- a/include/drm/ttm/ttm_bo.h
+++ b/include/drm/ttm/ttm_bo.h
@@ -441,6 +441,8 @@ s64 ttm_bo_evict_cgroup(struct ttm_device *bdev,
 			struct dmem_cgroup_pool_state *limit_pool,
 			s64 target_bytes,
 			struct ttm_operation_ctx *ctx);
+int ttm_bo_access_locked(struct ttm_buffer_object *bo, unsigned long offset,
+			 void *buf, int len, int write);
 int ttm_bo_access(struct ttm_buffer_object *bo, unsigned long offset,
 		  void *buf, int len, int write);
 vm_fault_t ttm_bo_vm_reserve(struct ttm_buffer_object *bo,
-- 
2.53.0

