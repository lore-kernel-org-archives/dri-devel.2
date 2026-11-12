Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A354606A889
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HfTqlqmz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2ED011209C;
	Thu, 12 Nov 2026 12:23:13 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D33B1112096;
 Thu, 12 Nov 2026 12:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794486186; x=1826022186;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=OJ9of+YFQ7QZOg35gvWbh0VD45HpR3CN407SRKIcd8w=;
 b=HfTqlqmzUdr8PddRYO3HILJyNj7+V6xag38HkrSCb/mc77ob6g3yVY8g
 XxLEopmHvFuHUYeznmfWhIYtkmdDfwxesGm+Qj0HH3DxjIVPNaK2nswdR
 WJ2JNIEoVrkToMHdEkFUkoi91bBTtPJ+ti0vSt078GuieIrP33DbrnYoB
 /IBXi17FRWAEXCtNp7syeURUIdHX1qxyF/SalbI1wlDI0Yt3ixFpLs0u9
 bIwdQIn4TV56Rt3TY8MpuCReFlFXS8aiwErMS/XJEycBdvFl6fhMpiRCV
 i6C8MZkHFVcZ7o6srtxTFYr+8wrlu/ydwGIsjYL3w3tads3YyxaoSyteA A==;
X-CSE-ConnectionGUID: UgHVrRoFQCWzNZGPoi8PuQ==
X-CSE-MsgGUID: dNqSAbfJTKWgBW1ZRHWcug==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3149760"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3149760"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 04:23:06 -0800
X-CSE-ConnectionGUID: T1DpV4KIQeuli3C8VKTDaQ==
X-CSE-MsgGUID: 0sQqGKclSJ+/X42RbivNlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="9207562"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO mwauld-desk.intel.com)
 ([10.245.244.57])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 04:23:05 -0800
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Matthew Brost <matthew.brost@intel.com>
Subject: [PATCH] drm: increase 64-bit mmap_range size to 8TB
Date: Thu, 12 Nov 2026 12:20:50 +0000
Message-ID: <20261112122049.1990826-2-matthew.auld@intel.com>
X-Mailer: git-send-email 2.56.0
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Every GEM/TTM buffer object, including imported dma-bufs, allocates a
fake mmap offset from the per-device drm_vma_offset_manager. On multi-GPU
systems with large VRAM, peer-to-peer dma-buf imports across devices and
processes can exhaust the current 1 TiB 64-bit range and fail BO creation
or PRIME import with -ENOSPC. Skipping mmap offset allocation for
imported sg buffers is not straightforward without risking userspace
regressions, as existing userspace (such as Intel compute-runtime) still
queries mmap_offset on imported host dma-bufs even when mapping the
dma-buf fd directly.

Increase DRM_FILE_PAGE_OFFSET_SIZE on 64-bit kernels so the fake offset
range spans up to 8 TiB (SZ_8T). This stays strictly below panthor's
DRM_PANTHOR_USER_MMIO_OFFSET_32BIT (1ULL << 43) carveout and within
32-bit compat mmap2's pgoff limit (16 TiB with 4K pages).

Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Matthew Brost <matthew.brost@intel.com>
---
 include/drm/drm_vma_manager.h | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/drm/drm_vma_manager.h b/include/drm/drm_vma_manager.h
index 6c2a2f21dbf0..2c3233f9dec4 100644
--- a/include/drm/drm_vma_manager.h
+++ b/include/drm/drm_vma_manager.h
@@ -26,16 +26,23 @@
 #include <drm/drm_mm.h>
 #include <linux/mm.h>
 #include <linux/rbtree.h>
+#include <linux/sizes.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
 
-/* We make up offsets for buffer objects so we can recognize them at
+/*
+ * We make up offsets for buffer objects so we can recognize them at
  * mmap time. pgoff in mmap is an unsigned long, so we need to make sure
- * that the faked up offset will fit
+ * that the faked up offset will fit.
+ *
+ * On 64-bit, cap the range at 8 TiB (SZ_8T) so offsets remain below both
+ * panthor's DRM_PANTHOR_USER_MMIO_OFFSET_32BIT (1ULL << 43) and 32-bit
+ * compat mmap2's pgoff ceiling (16 TiB with 4K pages).
  */
 #if BITS_PER_LONG == 64
 #define DRM_FILE_PAGE_OFFSET_START ((0xFFFFFFFFUL >> PAGE_SHIFT) + 1)
-#define DRM_FILE_PAGE_OFFSET_SIZE ((0xFFFFFFFFUL >> PAGE_SHIFT) * 256)
+#define DRM_FILE_PAGE_OFFSET_SIZE ((SZ_8T >> PAGE_SHIFT) - \
+				   DRM_FILE_PAGE_OFFSET_START)
 #else
 #define DRM_FILE_PAGE_OFFSET_START ((0xFFFFFFFUL >> PAGE_SHIFT) + 1)
 #define DRM_FILE_PAGE_OFFSET_SIZE ((0xFFFFFFFUL >> PAGE_SHIFT) * 16)
-- 
2.56.0

