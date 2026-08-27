Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C3EC61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 10:29:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AF3E10EF93;
	Thu, 27 Aug 2026 10:29:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="lbhd7ZQd";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67AB810EF93
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 10:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787826571; x=1819362571;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=R2i8bF8LbxoB3S0yvidye80F+6/08ElMFw5/FwfgP/M=;
 b=lbhd7ZQdZCSPwx+1o8vxiRvreLtUxm7DMDH8R57NeOEE7buHmtE8gAKW
 PfRRvUwCeHCEodzCGi6pHQM/ps0FvbEO+40BosfvXfOTZTxzWUHEb6FoI
 deSZKhdERvJlHdV1e/DybqxsmfI/DgXMo89mckqM3tFYjR1lh79uAPk5W
 /oVp0mCA7zUOpXnzLHX0XfowD1xTW+qXqYbWaSFzKh614unCTHtF9DzX7
 Ki6uK4xsfZFNP2serHdRizCHMHazPry/vTwU3eLbgot8ZeFYr65iWtWi/
 04iPHmjYvrRDKObPCLw9qRXax35OyqF/pCKHov1BvexQ8UAAK9HIAo6oP A==;
X-CSE-ConnectionGUID: 1NmKHhztThKLvNbwd6GZ7A==
X-CSE-MsgGUID: c+76YTE0S4i3faIxD01PBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="98920686"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="98920686"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 03:29:31 -0700
X-CSE-ConnectionGUID: nVhqKwGfQRCV32gaVneBgA==
X-CSE-MsgGUID: G5DmhbXTQ+uW/sHccESRkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="261711636"
Received: from try2-8594.igk.intel.com ([10.91.220.58])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 03:29:29 -0700
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com,
 karol.wachowski@linux.intel.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com,
 Magdalena Schulfer <magdalena.schulfer@intel.com>, stable@vger.kernel.org,
 Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Subject: [PATCH 1/2] accel/ivpu: Validate full buffer range in ivpu_to_cpu_addr
Date: Thu, 27 Aug 2026 12:23:38 +0200
Message-ID: <20260827102339.281799-2-dawid.osuchowski@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827102339.281799-1-dawid.osuchowski@linux.intel.com>
References: <20260827102339.281799-1-dawid.osuchowski@linux.intel.com>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-31
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

From: Magdalena Schulfer <magdalena.schulfer@intel.com>

Add a size parameter to ivpu_to_cpu_addr() and validate that the
whole [vpu_addr, vpu_addr + size) range stays within the BO.

Cc: stable@vger.kernel.org
Fixes: 647371a6609d ("accel/ivpu: Add GEM buffer object management")
Signed-off-by: Magdalena Schulfer <magdalena.schulfer@intel.com>
Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_gem.h | 14 +++++++++++---
 drivers/accel/ivpu/ivpu_ipc.c |  7 ++++---
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_gem.h b/drivers/accel/ivpu/ivpu_gem.h
index 0c3350f22b55..b1ae020a4fc2 100644
--- a/drivers/accel/ivpu/ivpu_gem.h
+++ b/drivers/accel/ivpu/ivpu_gem.h
@@ -87,15 +87,23 @@ static inline bool ivpu_bo_is_resident(struct ivpu_bo *bo)
 	return !!bo->base.pages;
 }
 
-static inline void *ivpu_to_cpu_addr(struct ivpu_bo *bo, u32 vpu_addr)
+static inline void *ivpu_to_cpu_addr(struct ivpu_bo *bo, u64 vpu_addr, u64 size)
 {
+	u64 bo_size = ivpu_bo_size(bo);
+	u64 offset;
+
 	if (vpu_addr < bo->vpu_addr)
 		return NULL;
 
-	if (vpu_addr >= (bo->vpu_addr + ivpu_bo_size(bo)))
+	if (size > bo_size)
+		return NULL;
+
+	offset = vpu_addr - bo->vpu_addr;
+
+	if (offset > bo_size - size)
 		return NULL;
 
-	return ivpu_bo_vaddr(bo) + (vpu_addr - bo->vpu_addr);
+	return ivpu_bo_vaddr(bo) + offset;
 }
 
 static inline u32 cpu_to_vpu_addr(struct ivpu_bo *bo, void *cpu_addr)
diff --git a/drivers/accel/ivpu/ivpu_ipc.c b/drivers/accel/ivpu/ivpu_ipc.c
index 978bc3d8704f..8f69fb133e2e 100644
--- a/drivers/accel/ivpu/ivpu_ipc.c
+++ b/drivers/accel/ivpu/ivpu_ipc.c
@@ -79,7 +79,7 @@ ivpu_ipc_tx_prepare(struct ivpu_device *vdev, struct ivpu_ipc_consumer *cons,
 		return -ENOMEM;
 	}
 
-	tx_buf = ivpu_to_cpu_addr(ipc->mem_tx, tx_buf_vpu_addr);
+	tx_buf = ivpu_to_cpu_addr(ipc->mem_tx, tx_buf_vpu_addr, sizeof(*tx_buf));
 	if (drm_WARN_ON(&vdev->drm, !tx_buf)) {
 		gen_pool_free(ipc->mm_tx, tx_buf_vpu_addr, sizeof(*tx_buf));
 		return -EIO;
@@ -420,7 +420,7 @@ void ivpu_ipc_irq_handler(struct ivpu_device *vdev)
 			return;
 		}
 
-		ipc_hdr = ivpu_to_cpu_addr(ipc->mem_rx, vpu_addr);
+		ipc_hdr = ivpu_to_cpu_addr(ipc->mem_rx, vpu_addr, sizeof(*ipc_hdr));
 		if (!ipc_hdr) {
 			ivpu_warn_ratelimited(vdev, "IPC msg 0x%x out of range\n", vpu_addr);
 			continue;
@@ -429,7 +429,8 @@ void ivpu_ipc_irq_handler(struct ivpu_device *vdev)
 
 		jsm_msg = NULL;
 		if (ipc_hdr->channel != IVPU_IPC_CHAN_BOOT_MSG) {
-			jsm_msg = ivpu_to_cpu_addr(ipc->mem_rx, ipc_hdr->data_addr);
+			jsm_msg = ivpu_to_cpu_addr(ipc->mem_rx, ipc_hdr->data_addr,
+						   sizeof(*jsm_msg));
 			if (!jsm_msg) {
 				ivpu_warn_ratelimited(vdev, "JSM msg 0x%x out of range\n",
 						      ipc_hdr->data_addr);
-- 
2.43.0

