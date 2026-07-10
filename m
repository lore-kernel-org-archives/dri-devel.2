Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A25B4C44501
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 10:13:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11AA410F811;
	Fri, 10 Jul 2026 10:13:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="esPcvSPb";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BEC610F811
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 10:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783678422; x=1815214422;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=7/lKNtHw4qncyy37qLbzZAlC3rpns9yLNFzHAvS7iaM=;
 b=esPcvSPbeJIYwTTGntpnyOSA7TTvgU8IjMTpXcuM0QRTGnRdQWWKPLuU
 MKvRjm5mgNUuPfMjzU+AhGWWwOFZNOIIFoipinXjvC3ZNcJZupwK/SzyI
 jPAyc174aloH4AvWRcJr8hLJt4QJRSTAue4NmHTuiZKfu/s3lVx8IQ6gD
 exAlN9mvqWxtL1LeIC5lEQCb887Omh66Gh9+yAKtIulBSz3AOWGssGpEK
 F4zi8UCdHf5zl7telwwKOM3SneUvHhmCSBI0VpsXGLvjoJUOpb7VAWCVN
 TehR5O3UpamaWgLRhU2TqhK2JLL2zmMJZP3Jh+S4gGaQBzBxjfWR/dtQf A==;
X-CSE-ConnectionGUID: LTMoDIrtRneQ5LqmNo8q+w==
X-CSE-MsgGUID: 0knMc+baT7GzFaPO0DJCpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95529542"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="95529542"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 03:13:40 -0700
X-CSE-ConnectionGUID: i2gLTwWYS2euPWImCCX3sA==
X-CSE-MsgGUID: +i6HW2TkQaa6fY6HJAwtug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="248477826"
Received: from pl-npu-pc-kwachow.igk.intel.com ([10.91.220.239])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 03:13:38 -0700
From: Karol Wachowski <karol.wachowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com, dawid.osuchowski@linux.intel.com,
 Karol Wachowski <karol.wachowski@linux.intel.com>
Subject: [PATCH] accel/ivpu: Fix wrong register read in LNL failure diagnostics
Date: Fri, 10 Jul 2026 12:13:31 +0200
Message-ID: <20260710101331.1899505-1-karol.wachowski@linux.intel.com>
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

diagnose_failure_lnl() read VPU_HW_BTRS_MTL_INTERRUPT_STAT instead of
VPU_HW_BTRS_LNL_INTERRUPT_STAT, which on LNL and newer parts is a
different register with a different bit layout, so failure diagnostics
decoded the wrong register and reported a bogus error cause.
Read the LNL interrupt status register instead.

Fixes: 8a27ad81f7d3 ("accel/ivpu: Split IP and buttress code")
Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_hw_btrs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/ivpu/ivpu_hw_btrs.c b/drivers/accel/ivpu/ivpu_hw_btrs.c
index dac935164e11..a17c829adb89 100644
--- a/drivers/accel/ivpu/ivpu_hw_btrs.c
+++ b/drivers/accel/ivpu/ivpu_hw_btrs.c
@@ -927,7 +927,7 @@ static void diagnose_failure_mtl(struct ivpu_device *vdev)
 
 static void diagnose_failure_lnl(struct ivpu_device *vdev)
 {
-	u32 reg = REGB_RD32(VPU_HW_BTRS_MTL_INTERRUPT_STAT) & BTRS_LNL_IRQ_MASK;
+	u32 reg = REGB_RD32(VPU_HW_BTRS_LNL_INTERRUPT_STAT) & BTRS_LNL_IRQ_MASK;
 
 	if (REG_TEST_FLD(VPU_HW_BTRS_LNL_INTERRUPT_STAT, ATS_ERR, reg)) {
 		ivpu_err(vdev, "ATS_ERR_LOG1 0x%08x ATS_ERR_LOG2 0x%08x\n",
-- 
2.43.0

