Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6888DC4450A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 08:38:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B74CC10F235;
	Thu, 16 Jul 2026 08:38:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="VoBlphD4";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A3C010E749
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 08:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784191121; x=1815727121;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=kh/ybRj/mxB1fVGFVes7NRxjdUS+SuzvyHhDQmmbwjg=;
 b=VoBlphD4BI7ILIiX7TKc9+7DMnDTygbeCOw4Uhw9t0Z7wk8KCHnj1iaF
 qQU0UdLxfxIUnIhyGXCnHROdK2fTSfrPqpoKFsuCVoOJsDli8OGbmkv6q
 7wRJccA0we3LUc78039dX2yh9aeXL13fQTJ/c0BJkr4ZqIpTUmZam9a9N
 +zCx2cqUxHjeznLhWc3uchDpw4g8ysZxCbuovXBJdt6NYRbXkarcum3vC
 /TtfJTMnlyxoXNBdzmmaYBmW0uFvCtQk2t4GRzg8qgl/FtSQJqllfu6Jf
 fdLmHppRRm2zTaCAL/TirX58Lf2X7GiaXjkHj+QjZp2VGTk3YqPclfAeB w==;
X-CSE-ConnectionGUID: b8tjOg1NQ82eszKijjCxkg==
X-CSE-MsgGUID: ZqsaSTYqQPq23u49Ik0oLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84957840"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; d="scan'208";a="84957840"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2026 01:38:36 -0700
X-CSE-ConnectionGUID: oC0xbZ6+TQmitg3dhMxZhw==
X-CSE-MsgGUID: f267okOESyKAe2L1on8Clg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; d="scan'208";a="257079870"
Received: from akacprow-dev3.igk.intel.com ([10.91.220.47])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2026 01:38:34 -0700
From: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 karol.wachowski@linux.intel.com, andrzej.kacprowski@linux.intel.com
Subject: [PATCH] accel/ivpu: Remove unnecessary min_t()/max_t() usage
Date: Thu, 16 Jul 2026 10:33:50 +0200
Message-ID: <20260716083350.248419-1-andrzej.kacprowski@linux.intel.com>
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

Remove unnecessary min_t()/max_t() usage in ivpu_fw.c
and ivpu_mmu_context.c. The min()/max() macros are
sufficient as the types are compatible and
there is no risk of overflow.

Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_fw.c          | 2 +-
 drivers/accel/ivpu/ivpu_mmu_context.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_fw.c b/drivers/accel/ivpu/ivpu_fw.c
index 5a8f7dfb54e6..b78b7c35cd9b 100644
--- a/drivers/accel/ivpu/ivpu_fw.c
+++ b/drivers/accel/ivpu/ivpu_fw.c
@@ -318,7 +318,7 @@ static int ivpu_fw_parse(struct ivpu_device *vdev)
 	fw->shave_nn_size = PAGE_ALIGN(fw_hdr->shave_nn_fw_size);
 	fw->cold_boot_entry_point = fw_hdr->entry_point;
 
-	fw->trace_level = min_t(u32, ivpu_fw_log_level, IVPU_FW_LOG_FATAL);
+	fw->trace_level = min(ivpu_fw_log_level, IVPU_FW_LOG_FATAL);
 	fw->trace_destination_mask = VPU_TRACE_DESTINATION_VERBOSE_TRACING;
 	fw->trace_hw_component_mask = -1;
 
diff --git a/drivers/accel/ivpu/ivpu_mmu_context.c b/drivers/accel/ivpu/ivpu_mmu_context.c
index c4014c83e727..bb3ca81838e3 100644
--- a/drivers/accel/ivpu/ivpu_mmu_context.c
+++ b/drivers/accel/ivpu/ivpu_mmu_context.c
@@ -588,8 +588,8 @@ void ivpu_mmu_context_init(struct ivpu_device *vdev, struct ivpu_mmu_context *ct
 		start = vdev->hw->ranges.runtime.start;
 		end = vdev->hw->ranges.shave.end;
 	} else {
-		start = min_t(u64, vdev->hw->ranges.user.start, vdev->hw->ranges.shave.start);
-		end = max_t(u64, vdev->hw->ranges.user.end, vdev->hw->ranges.dma.end);
+		start = min(vdev->hw->ranges.user.start, vdev->hw->ranges.shave.start);
+		end = max(vdev->hw->ranges.user.end, vdev->hw->ranges.dma.end);
 	}
 
 	drm_mm_init(&ctx->mm, start, end - start);
-- 
2.43.0

