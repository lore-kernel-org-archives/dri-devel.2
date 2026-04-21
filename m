Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3D4F327CD
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 09:39:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF3C310EC02;
	Tue, 21 Apr 2026 09:39:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="hznBc/ic";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FFC810EBF5
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 09:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776764354; x=1808300354;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=KAt5Cg388QvdjdnYL57FJJisJDlpZkQ4ibMVUBMN4ds=;
 b=hznBc/icssxw5dDzLjGxDyFkyvEbu2+50jz9af2B52R8Yukcqip3M8Nb
 NYbdyWRxHizUHMDKS3rne9TsB+i/sV+oMWFCUAbFbu3RSgfzmIkt7Pnda
 gxCuu+Wn0l2g9XkPVDNcZyHeNl7adsNIceoxCByplut8P3NWvjuFhZ0Ai
 H6LztdLlEgW98/ao1Q/B/5w//D3lKBD8Nm67go0vR9mp9BSRNCB6BEkcX
 ZCDM37ZOmWj6FyRHQ5hsyXOQLNQDMVxG3k6XhrIUEllzWKwXlERH589Or
 +bB79TfkutBti79GN1lcpuBYzZW/F3XyHJ5R9mgoYrOPdngxUV9x360Gj Q==;
X-CSE-ConnectionGUID: Lh0TC5ZOSb6Hrf4Oo+SJ3g==
X-CSE-MsgGUID: DNZyShUeRkGU4xpTlzaXBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77707494"
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; d="scan'208";a="77707494"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2026 02:39:14 -0700
X-CSE-ConnectionGUID: eGRJHPItQI+79P5mWJit5w==
X-CSE-MsgGUID: c/u5YjWuTZq/pVTUntFFcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; d="scan'208";a="255258829"
Received: from pl-npu-pc-kwachow.igk.intel.com ([10.91.220.239])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2026 02:39:12 -0700
From: Karol Wachowski <karol.wachowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com,
 maciej.falkowski@linux.intel.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com,
 Karol Wachowski <karol.wachowski@linux.intel.com>
Subject: [PATCH] accel/ivpu: Fix swapped register names in pwr_island_drive
 functions
Date: Tue, 21 Apr 2026 11:39:07 +0200
Message-ID: <20260421093907.37304-1-karol.wachowski@linux.intel.com>
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

pwr_island_drive_37xx and pwr_island_drive_40xx functions had incorrectly
swapped registers definitions. Bug is purely cosmetic as those registers
have exactly same offsets and layout in both 37XX and 40XX.

Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_hw_ip.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_hw_ip.c b/drivers/accel/ivpu/ivpu_hw_ip.c
index 37f95a0551ed..81f0b1f8f5a6 100644
--- a/drivers/accel/ivpu/ivpu_hw_ip.c
+++ b/drivers/accel/ivpu/ivpu_hw_ip.c
@@ -308,26 +308,26 @@ static void pwr_island_trickle_drive_40xx(struct ivpu_device *vdev, bool enable)
 
 static void pwr_island_drive_37xx(struct ivpu_device *vdev, bool enable)
 {
-	u32 val = REGV_RD32(VPU_40XX_HOST_SS_AON_PWR_ISLAND_EN0);
+	u32 val = REGV_RD32(VPU_37XX_HOST_SS_AON_PWR_ISLAND_EN0);
 
 	if (enable)
-		val = REG_SET_FLD(VPU_40XX_HOST_SS_AON_PWR_ISLAND_EN0, CSS_CPU, val);
+		val = REG_SET_FLD(VPU_37XX_HOST_SS_AON_PWR_ISLAND_EN0, MSS_CPU, val);
 	else
-		val = REG_CLR_FLD(VPU_40XX_HOST_SS_AON_PWR_ISLAND_EN0, CSS_CPU, val);
+		val = REG_CLR_FLD(VPU_37XX_HOST_SS_AON_PWR_ISLAND_EN0, MSS_CPU, val);
 
-	REGV_WR32(VPU_40XX_HOST_SS_AON_PWR_ISLAND_EN0, val);
+	REGV_WR32(VPU_37XX_HOST_SS_AON_PWR_ISLAND_EN0, val);
 }
 
 static void pwr_island_drive_40xx(struct ivpu_device *vdev, bool enable)
 {
-	u32 val = REGV_RD32(VPU_37XX_HOST_SS_AON_PWR_ISLAND_EN0);
+	u32 val = REGV_RD32(VPU_40XX_HOST_SS_AON_PWR_ISLAND_EN0);
 
 	if (enable)
-		val = REG_SET_FLD(VPU_37XX_HOST_SS_AON_PWR_ISLAND_EN0, MSS_CPU, val);
+		val = REG_SET_FLD(VPU_40XX_HOST_SS_AON_PWR_ISLAND_EN0, CSS_CPU, val);
 	else
-		val = REG_CLR_FLD(VPU_37XX_HOST_SS_AON_PWR_ISLAND_EN0, MSS_CPU, val);
+		val = REG_CLR_FLD(VPU_40XX_HOST_SS_AON_PWR_ISLAND_EN0, CSS_CPU, val);
 
-	REGV_WR32(VPU_37XX_HOST_SS_AON_PWR_ISLAND_EN0, val);
+	REGV_WR32(VPU_40XX_HOST_SS_AON_PWR_ISLAND_EN0, val);
 }
 
 static void pwr_island_enable(struct ivpu_device *vdev)
-- 
2.43.0

