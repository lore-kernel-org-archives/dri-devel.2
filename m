Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE5D9C9831A
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 11:04:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D10E10E6CD;
	Thu, 24 Sep 2026 11:04:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="CKfB+S0L";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5A3410E6CD
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 11:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790247877; x=1821783877;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=pCcF2BWw2q+mztuxqZv0Usnp/hJS7sUdgi/3DkLcm+k=;
 b=CKfB+S0LXKjFqItMKm5os8BP9DhAIcq8XElnftLAvgq9Z1npQFXcE4Mj
 sQOPieKRCIFRUfdt4uD2savVBiR9z2woPijuJtSBZgwp2gpbVFDmTnM0S
 okZb1UFqqjOBM5bPuW2OXnrAMDJlhYJ2RWti8xuVY1/l/31c3YeIKF2z4
 vFF5JDTMm+qnosmLn6lb4H4an+tjKmbUmx8+3JGvlPKq2g2sV1QWI6cjB
 Fq/zQzd1hU76Ue89gbFyUh4/SSm0jv15CNeS2xfs4yb8+tec/G8cNFApr
 JsjDEYDv5jAUtX7FEB6/n2PU6lgTHujfqubQFpPkXB7nvyru2XM7d9wkW g==;
X-CSE-ConnectionGUID: 1ZvIujJjQsaeuLVI1Ulrzg==
X-CSE-MsgGUID: P3zG8kfVRSqN0cFIyhCGzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="101593633"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="101593633"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 04:04:37 -0700
X-CSE-ConnectionGUID: MSgcJlvZT0a5BYiBKAvq5w==
X-CSE-MsgGUID: UOXP9s03TKWxtMHBSKGW6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="282084954"
Received: from akacprow-dev3.igk.intel.com ([10.91.220.47])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 04:04:35 -0700
From: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com,
 karol.wachowski@linux.intel.com, lizhi.hou@amd.com,
 dawid.osuchowski@linux.intel.com,
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
Subject: [PATCH] accel/ivpu: Make BO free helper NULL-safe
Date: Thu, 24 Sep 2026 12:59:06 +0200
Message-ID: <20260924105906.489378-1-andrzej.kacprowski@linux.intel.com>
X-Mailer: git-send-email 2.43.0
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

Handle NULL buffers in ivpu_bo_free() so callers can use it as a
kfree-like cleanup helper.

Use the NULL-safe helper to simplify error paths and teardown code in
firmware, IPC, preemption buffer, and metric streamer cleanup. This
removes redundant conditional frees and collapses unwind labels that only
differed by which BOs had been allocated.

Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_fw.c  | 65 +++++++++++++++--------------------
 drivers/accel/ivpu/ivpu_gem.c |  3 ++
 drivers/accel/ivpu/ivpu_ipc.c | 11 +++---
 drivers/accel/ivpu/ivpu_job.c |  6 ++--
 drivers/accel/ivpu/ivpu_ms.c  | 17 ++++-----
 5 files changed, 44 insertions(+), 58 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_fw.c b/drivers/accel/ivpu/ivpu_fw.c
index b78b7c35cd9b..f9ddaa2420c4 100644
--- a/drivers/accel/ivpu/ivpu_fw.c
+++ b/drivers/accel/ivpu/ivpu_fw.c
@@ -364,6 +364,25 @@ static void ivpu_fw_release(struct ivpu_device *vdev)
 }
 
 
+static void ivpu_fw_mem_fini(struct ivpu_device *vdev)
+{
+	struct ivpu_fw_info *fw = vdev->fw;
+
+	ivpu_bo_free(fw->mem_shave_nn);
+	ivpu_bo_free(fw->mem_log_verb);
+	ivpu_bo_free(fw->mem_log_crit);
+	ivpu_bo_free(fw->mem);
+	ivpu_bo_free(fw->mem_fw_ver);
+	ivpu_bo_free(fw->mem_bp);
+
+	fw->mem_shave_nn = NULL;
+	fw->mem_log_verb = NULL;
+	fw->mem_log_crit = NULL;
+	fw->mem = NULL;
+	fw->mem_fw_ver = NULL;
+	fw->mem_bp = NULL;
+}
+
 static int ivpu_fw_mem_init(struct ivpu_device *vdev)
 {
 	struct ivpu_fw_info *fw = vdev->fw;
@@ -382,7 +401,7 @@ static int ivpu_fw_mem_init(struct ivpu_device *vdev)
 	if (!fw->mem_fw_ver) {
 		ivpu_err(vdev, "Failed to create firmware version memory buffer\n");
 		ret = -ENOMEM;
-		goto err_free_bp;
+		goto err_free;
 	}
 
 	fw->mem = ivpu_bo_create_runtime(vdev, fw->runtime_addr, fw->runtime_size,
@@ -390,14 +409,14 @@ static int ivpu_fw_mem_init(struct ivpu_device *vdev)
 	if (!fw->mem) {
 		ivpu_err(vdev, "Failed to create firmware runtime memory buffer\n");
 		ret = -ENOMEM;
-		goto err_free_fw_ver;
+		goto err_free;
 	}
 
 	ret = ivpu_mmu_context_set_pages_ro(vdev, &vdev->gctx, fw->read_only_addr,
 					    fw->read_only_size);
 	if (ret) {
 		ivpu_err(vdev, "Failed to set firmware image read-only\n");
-		goto err_free_fw_mem;
+		goto err_free;
 	}
 
 	fw->mem_log_crit = ivpu_bo_create_global(vdev, IVPU_FW_CRITICAL_BUFFER_SIZE,
@@ -405,7 +424,7 @@ static int ivpu_fw_mem_init(struct ivpu_device *vdev)
 	if (!fw->mem_log_crit) {
 		ivpu_err(vdev, "Failed to create critical log buffer\n");
 		ret = -ENOMEM;
-		goto err_free_fw_mem;
+		goto err_free;
 	}
 
 	if (ivpu_fw_log_level <= IVPU_FW_LOG_INFO)
@@ -418,7 +437,7 @@ static int ivpu_fw_mem_init(struct ivpu_device *vdev)
 	if (!fw->mem_log_verb) {
 		ivpu_err(vdev, "Failed to create verbose log buffer\n");
 		ret = -ENOMEM;
-		goto err_free_log_crit;
+		goto err_free;
 	}
 
 	if (fw->shave_nn_size) {
@@ -427,47 +446,17 @@ static int ivpu_fw_mem_init(struct ivpu_device *vdev)
 		if (!fw->mem_shave_nn) {
 			ivpu_err(vdev, "Failed to create shavenn buffer\n");
 			ret = -ENOMEM;
-			goto err_free_log_verb;
+			goto err_free;
 		}
 	}
 
 	return 0;
 
-err_free_log_verb:
-	ivpu_bo_free(fw->mem_log_verb);
-err_free_log_crit:
-	ivpu_bo_free(fw->mem_log_crit);
-err_free_fw_mem:
-	ivpu_bo_free(fw->mem);
-err_free_fw_ver:
-	ivpu_bo_free(fw->mem_fw_ver);
-err_free_bp:
-	ivpu_bo_free(fw->mem_bp);
+err_free:
+	ivpu_fw_mem_fini(vdev);
 	return ret;
 }
 
-static void ivpu_fw_mem_fini(struct ivpu_device *vdev)
-{
-	struct ivpu_fw_info *fw = vdev->fw;
-
-	if (fw->mem_shave_nn) {
-		ivpu_bo_free(fw->mem_shave_nn);
-		fw->mem_shave_nn = NULL;
-	}
-
-	ivpu_bo_free(fw->mem_log_verb);
-	ivpu_bo_free(fw->mem_log_crit);
-	ivpu_bo_free(fw->mem);
-	ivpu_bo_free(fw->mem_fw_ver);
-	ivpu_bo_free(fw->mem_bp);
-
-	fw->mem_log_verb = NULL;
-	fw->mem_log_crit = NULL;
-	fw->mem = NULL;
-	fw->mem_fw_ver = NULL;
-	fw->mem_bp = NULL;
-}
-
 int ivpu_fw_init(struct ivpu_device *vdev)
 {
 	int ret;
diff --git a/drivers/accel/ivpu/ivpu_gem.c b/drivers/accel/ivpu/ivpu_gem.c
index 4f2005a8d496..62dbc2ef6e9d 100644
--- a/drivers/accel/ivpu/ivpu_gem.c
+++ b/drivers/accel/ivpu/ivpu_gem.c
@@ -471,6 +471,9 @@ struct ivpu_bo *ivpu_bo_create_global(struct ivpu_device *vdev, u64 size, u32 fl
 
 void ivpu_bo_free(struct ivpu_bo *bo)
 {
+	if (!bo)
+		return;
+
 	struct iosys_map map = IOSYS_MAP_INIT_VADDR(bo->base.vaddr);
 
 	if (bo->flags & DRM_IVPU_BO_MAPPABLE) {
diff --git a/drivers/accel/ivpu/ivpu_ipc.c b/drivers/accel/ivpu/ivpu_ipc.c
index 8e960293b77a..79d34f9b1f07 100644
--- a/drivers/accel/ivpu/ivpu_ipc.c
+++ b/drivers/accel/ivpu/ivpu_ipc.c
@@ -509,7 +509,7 @@ int ivpu_ipc_init(struct ivpu_device *vdev)
 	if (!ipc->mem_rx) {
 		ivpu_err(vdev, "Failed to allocate mem_rx\n");
 		ret = -ENOMEM;
-		goto err_free_tx;
+		goto err_free_bo;
 	}
 
 	ipc->mm_tx = devm_gen_pool_create(vdev->drm.dev, __ffs(IVPU_IPC_ALIGNMENT),
@@ -517,13 +517,13 @@ int ivpu_ipc_init(struct ivpu_device *vdev)
 	if (IS_ERR(ipc->mm_tx)) {
 		ret = PTR_ERR(ipc->mm_tx);
 		ivpu_err(vdev, "Failed to create gen pool, %pe\n", ipc->mm_tx);
-		goto err_free_rx;
+		goto err_free_bo;
 	}
 
 	ret = gen_pool_add(ipc->mm_tx, ipc->mem_tx->vpu_addr, ivpu_bo_size(ipc->mem_tx), -1);
 	if (ret) {
 		ivpu_err(vdev, "gen_pool_add failed, ret %d\n", ret);
-		goto err_free_rx;
+		goto err_free_bo;
 	}
 
 	spin_lock_init(&ipc->cons_lock);
@@ -532,14 +532,13 @@ int ivpu_ipc_init(struct ivpu_device *vdev)
 	ret = drmm_mutex_init(&vdev->drm, &ipc->lock);
 	if (ret) {
 		ivpu_err(vdev, "Failed to initialize ipc->lock, ret %d\n", ret);
-		goto err_free_rx;
+		goto err_free_bo;
 	}
 	ivpu_ipc_reset(vdev);
 	return 0;
 
-err_free_rx:
+err_free_bo:
 	ivpu_bo_free(ipc->mem_rx);
-err_free_tx:
 	ivpu_bo_free(ipc->mem_tx);
 err_destroy_cache:
 	kmem_cache_destroy(ipc->rx_msg_cache);
diff --git a/drivers/accel/ivpu/ivpu_job.c b/drivers/accel/ivpu/ivpu_job.c
index b3de5dd29d1e..c436cd418bca 100644
--- a/drivers/accel/ivpu/ivpu_job.c
+++ b/drivers/accel/ivpu/ivpu_job.c
@@ -64,10 +64,8 @@ static int ivpu_preemption_buffers_create(struct ivpu_device *vdev,
 static void ivpu_preemption_buffers_free(struct ivpu_device *vdev,
 					 struct ivpu_file_priv *file_priv, struct ivpu_cmdq *cmdq)
 {
-	if (cmdq->primary_preempt_buf)
-		ivpu_bo_free(cmdq->primary_preempt_buf);
-	if (cmdq->secondary_preempt_buf)
-		ivpu_bo_free(cmdq->secondary_preempt_buf);
+	ivpu_bo_free(cmdq->primary_preempt_buf);
+	ivpu_bo_free(cmdq->secondary_preempt_buf);
 }
 
 static int ivpu_preemption_job_init(struct ivpu_device *vdev, struct ivpu_file_priv *file_priv,
diff --git a/drivers/accel/ivpu/ivpu_ms.c b/drivers/accel/ivpu/ivpu_ms.c
index cd176e77b9a0..489ab51d3341 100644
--- a/drivers/accel/ivpu/ivpu_ms.c
+++ b/drivers/accel/ivpu/ivpu_ms.c
@@ -69,7 +69,7 @@ int ivpu_ms_start_ioctl(struct drm_device *dev, void *data, struct drm_file *fil
 
 	ret = ivpu_jsm_metric_streamer_info(vdev, ms->mask, 0, 0, &sample_size, NULL);
 	if (ret)
-		goto err_free_ms;
+		goto err_free;
 
 	buf_size = PAGE_ALIGN((u64)args->read_period_samples * sample_size *
 			      MS_READ_PERIOD_MULTIPLIER * MS_NUM_BUFFERS);
@@ -77,14 +77,14 @@ int ivpu_ms_start_ioctl(struct drm_device *dev, void *data, struct drm_file *fil
 		ivpu_dbg(vdev, IOCTL, "Requested MS buffer size %llu exceeds range size %llu\n",
 			 buf_size, ivpu_hw_range_size(&vdev->hw->ranges.global));
 		ret = -EINVAL;
-		goto err_free_ms;
+		goto err_free;
 	}
 
 	ms->bo = ivpu_bo_create_global(vdev, buf_size, DRM_IVPU_BO_CACHED | DRM_IVPU_BO_MAPPABLE);
 	if (!ms->bo) {
 		ivpu_dbg(vdev, IOCTL, "Failed to allocate MS buffer (size %llu)\n", buf_size);
 		ret = -ENOMEM;
-		goto err_free_ms;
+		goto err_free;
 	}
 
 	ms->buff_size = ivpu_bo_size(ms->bo) / MS_NUM_BUFFERS;
@@ -96,16 +96,15 @@ int ivpu_ms_start_ioctl(struct drm_device *dev, void *data, struct drm_file *fil
 	ret = ivpu_jsm_metric_streamer_start(vdev, ms->mask, args->sampling_period_ns,
 					     ms->active_buff_vpu_addr, ms->buff_size);
 	if (ret)
-		goto err_free_bo;
+		goto err_free;
 
 	args->sample_size = sample_size;
 	args->max_data_size = ivpu_bo_size(ms->bo);
 	list_add_tail(&ms->ms_instance_node, &file_priv->ms_instance_list);
 	goto unlock;
 
-err_free_bo:
+err_free:
 	ivpu_bo_free(ms->bo);
-err_free_ms:
 	kfree(ms);
 unlock:
 	mutex_unlock(&file_priv->ms_lock);
@@ -322,10 +321,8 @@ void ivpu_ms_cleanup(struct ivpu_file_priv *file_priv)
 
 	mutex_lock(&file_priv->ms_lock);
 
-	if (file_priv->ms_info_bo) {
-		ivpu_bo_free(file_priv->ms_info_bo);
-		file_priv->ms_info_bo = NULL;
-	}
+	ivpu_bo_free(file_priv->ms_info_bo);
+	file_priv->ms_info_bo = NULL;
 
 	list_for_each_entry_safe(ms, tmp, &file_priv->ms_instance_list, ms_instance_node)
 		free_instance(file_priv, ms);
-- 
2.43.0

