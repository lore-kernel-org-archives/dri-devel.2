Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24A76EC01B1
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 09:50:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 901C210E036;
	Mon, 23 Mar 2026 09:50:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="EChqPTeR";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AA9B10E036
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 09:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774259440; x=1805795440;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=LoTD6yQU6kUFqkIiRgFrYHuMrZ7+p06yFW0pyqLl5DQ=;
 b=EChqPTeRBF5UoOk94Gl6uhry8ZhgpECOvOHX0hxWv7/4dJ2VbBJdkVyO
 8jEhj9m9L2UoRwFpnk+umXH+Oj8E+gfd2Okq9zr5B2glPU4PSBnXRnjm6
 Vop60B+91yfbOcZNpYUAI0YPiHoAppWMiW+5p8cTgEOcgoFxTbOmvWQ1+
 W6ocZ8RMYeeMIrs40L4YB4gFTAQBPsurp5uS3e7S37fdcDdksPa8oThC1
 K2oA4nmLnMniXyPQxx3pOhFBRuxMwuTTTImTbIOiRQd8nhCcgt9vzk6DL
 w2J/5yBA87qk0vnuPvDmkCO1U8jO39YnTC3Grx4uJ3XQ7g9ieHfy5eXcN Q==;
X-CSE-ConnectionGUID: 3Rfm02CSS0yt/dUZZkmv/A==
X-CSE-MsgGUID: RTVxDJ68Q1WetvU/l2l5qQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="77862580"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; d="scan'208";a="77862580"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 02:50:39 -0700
X-CSE-ConnectionGUID: 15v1QZjBSuujZoCgJMmBrQ==
X-CSE-MsgGUID: kjuWa3qWQWiVJuA/k6XzxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; d="scan'208";a="217495791"
Received: from pl-npu-pc-kwachow.igk.intel.com ([10.91.220.239])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 02:50:37 -0700
From: Karol Wachowski <karol.wachowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com,
 maciej.falkowski@linux.intel.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com,
 Karol Wachowski <karol.wachowski@linux.intel.com>, stable@vger.kernel.org
Subject: [PATCH] accel/ivpu: Add disable clock relinquish workaround for NVL-A0
Date: Mon, 23 Mar 2026 10:50:29 +0100
Message-ID: <20260323095029.64613-1-karol.wachowski@linux.intel.com>
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

Turn on disable clock relinquish workaround for Nova Lake A0.
Without this workaround NPU may not power off correctly after
inference, leading to unexpected system behavior.

Fixes: 550f4dd2cedd ("accel/ivpu: Add support for Nova Lake's NPU")
Cc: <stable@vger.kernel.org> # v6.19+

Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_drv.h | 1 +
 drivers/accel/ivpu/ivpu_hw.c  | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_drv.h b/drivers/accel/ivpu/ivpu_drv.h
index 5b34b6f50e69..f1b6155065ff 100644
--- a/drivers/accel/ivpu/ivpu_drv.h
+++ b/drivers/accel/ivpu/ivpu_drv.h
@@ -35,6 +35,7 @@
 #define IVPU_HW_IP_60XX 60
 
 #define IVPU_HW_IP_REV_LNL_B0 4
+#define IVPU_HW_IP_REV_NVL_A0 0
 
 #define IVPU_HW_BTRS_MTL 1
 #define IVPU_HW_BTRS_LNL 2
diff --git a/drivers/accel/ivpu/ivpu_hw.c b/drivers/accel/ivpu/ivpu_hw.c
index d69cd0d93569..d4a9bcda4100 100644
--- a/drivers/accel/ivpu/ivpu_hw.c
+++ b/drivers/accel/ivpu/ivpu_hw.c
@@ -70,8 +70,10 @@ static void wa_init(struct ivpu_device *vdev)
 	if (ivpu_hw_btrs_gen(vdev) == IVPU_HW_BTRS_MTL)
 		vdev->wa.interrupt_clear_with_0 = ivpu_hw_btrs_irqs_clear_with_0_mtl(vdev);
 
-	if (ivpu_device_id(vdev) == PCI_DEVICE_ID_LNL &&
-	    ivpu_revision(vdev) < IVPU_HW_IP_REV_LNL_B0)
+	if ((ivpu_device_id(vdev) == PCI_DEVICE_ID_LNL &&
+	     ivpu_revision(vdev) < IVPU_HW_IP_REV_LNL_B0) ||
+	    (ivpu_device_id(vdev) == PCI_DEVICE_ID_NVL &&
+	     ivpu_revision(vdev) == IVPU_HW_IP_REV_NVL_A0))
 		vdev->wa.disable_clock_relinquish = true;
 
 	if (ivpu_test_mode & IVPU_TEST_MODE_CLK_RELINQ_ENABLE)
-- 
2.43.0

