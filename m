Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7848ECA9ED2
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 08:38:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9288A10EF59;
	Mon, 12 Oct 2026 08:38:21 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E63D910EF52
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 08:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791794293; x=1823330293;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1claXpxry6WcvVXqh1dKVVE3e332pZ8a0nzaZrCDHRc=;
 b=LrT0qAbLTfsu2+2dA5gi3uQRKqCgNpiGfQyQNbRdIqoVziWlcZEu8yf7
 QyjWTeSKX6WdWvo4EL6gkb36DqwAbq5gGlTx2+18dY8Dj7Z3O6r9L88n7
 WymRuqh3DdXFX9c6ersQiWlVD6whArmxClALcDqtDOC1xkNT7s8QP0hm5
 fg8jTp0UuBP9tnSDicIuWfsE/TGcVT/M6s5kSv9FahewrnJPPFGO3e/5V
 tz/p6GslmM/NzOAFVIs1avzGoJfaKULPFtYfPADUv1ayj7U9FupopQ+Dw
 Dvoya6/vtJ4/F+mPvSFvT1+BNPmeDyCnZvvuYLc9FIeuHc3SaPYENz3Fe w==;
X-CSE-ConnectionGUID: pFISvMdxSFW8WEOv7YaUOA==
X-CSE-MsgGUID: 9yjncv/wSQ2IX+nu6oI9ZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="501012"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="501012"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 01:38:12 -0700
X-CSE-ConnectionGUID: lbv/0r6HT+qbwQ+FqmJa/A==
X-CSE-MsgGUID: AUSe1xmJTCSAwJaClb3KYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="1030708"
Received: from pl-npu-pc-kwachow.igk.intel.com ([10.91.220.239])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 01:38:11 -0700
From: Karol Wachowski <karol.wachowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com, dawid.osuchowski@linux.intel.com,
 Karol Wachowski <karol.wachowski@linux.intel.com>
Subject: [PATCH 2/5] accel/ivpu: Merge NPU IP register headers
Date: Mon, 12 Oct 2026 10:37:59 +0200
Message-ID: <20261012083802.2778448-3-karol.wachowski@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012083802.2778448-1-karol.wachowski@linux.intel.com>
References: <20261012083802.2778448-1-karol.wachowski@linux.intel.com>
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

Most registers in the 37xx and 40xx IP headers are the same, with only
the prefix differing, which forces a lot of code to be duplicated per
generation.

Merge them into ivpu_hw_ip_reg.h. Each register is defined once with the
prefix of the first generation that has it. New or changed fields use
the prefix of the generation that introduced them. The CPU_SS registers
that moved in 40xx are defined right below the 37xx ones. This leaves
some 37xx and 40xx code paths identical, which the next patch merges.

No functional change.

Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_hw_40xx_reg.h         | 195 ------------------
 drivers/accel/ivpu/ivpu_hw_btrs.h             |   2 -
 drivers/accel/ivpu/ivpu_hw_ip.c               | 173 ++++++++--------
 .../{ivpu_hw_37xx_reg.h => ivpu_hw_ip_reg.h}  |  69 ++++++-
 4 files changed, 151 insertions(+), 288 deletions(-)
 delete mode 100644 drivers/accel/ivpu/ivpu_hw_40xx_reg.h
 rename drivers/accel/ivpu/{ivpu_hw_37xx_reg.h => ivpu_hw_ip_reg.h} (73%)

diff --git a/drivers/accel/ivpu/ivpu_hw_40xx_reg.h b/drivers/accel/ivpu/ivpu_hw_40xx_reg.h
deleted file mode 100644
index fc0ee8d637f9..000000000000
--- a/drivers/accel/ivpu/ivpu_hw_40xx_reg.h
+++ /dev/null
@@ -1,195 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2020-2023 Intel Corporation
- */
-
-#ifndef __IVPU_HW_40XX_REG_H__
-#define __IVPU_HW_40XX_REG_H__
-
-#include <linux/bits.h>
-
-#define VPU_40XX_HOST_SS_CPR_CLK_EN					0x00000080u
-#define VPU_40XX_HOST_SS_CPR_CLK_EN_TOP_NOC_MASK			BIT_MASK(1)
-#define VPU_40XX_HOST_SS_CPR_CLK_EN_DSS_MAS_MASK			BIT_MASK(10)
-#define VPU_40XX_HOST_SS_CPR_CLK_EN_CSS_MAS_MASK			BIT_MASK(11)
-
-#define VPU_40XX_HOST_SS_CPR_CLK_SET					0x00000084u
-#define VPU_40XX_HOST_SS_CPR_CLK_SET_TOP_NOC_MASK			BIT_MASK(1)
-#define VPU_40XX_HOST_SS_CPR_CLK_SET_DSS_MAS_MASK			BIT_MASK(10)
-#define VPU_40XX_HOST_SS_CPR_CLK_SET_MSS_MAS_MASK			BIT_MASK(11)
-
-#define VPU_40XX_HOST_SS_CPR_RST_EN					0x00000090u
-#define VPU_40XX_HOST_SS_CPR_RST_EN_TOP_NOC_MASK			BIT_MASK(1)
-#define VPU_40XX_HOST_SS_CPR_RST_EN_DSS_MAS_MASK			BIT_MASK(10)
-#define VPU_40XX_HOST_SS_CPR_RST_EN_CSS_MAS_MASK			BIT_MASK(11)
-
-#define VPU_40XX_HOST_SS_CPR_RST_SET					0x00000094u
-#define VPU_40XX_HOST_SS_CPR_RST_SET_TOP_NOC_MASK			BIT_MASK(1)
-#define VPU_40XX_HOST_SS_CPR_RST_SET_DSS_MAS_MASK			BIT_MASK(10)
-#define VPU_40XX_HOST_SS_CPR_RST_SET_MSS_MAS_MASK			BIT_MASK(11)
-
-#define VPU_40XX_HOST_SS_CPR_RST_CLR					0x00000098u
-#define VPU_40XX_HOST_SS_CPR_RST_CLR_TOP_NOC_MASK			BIT_MASK(1)
-#define VPU_40XX_HOST_SS_CPR_RST_CLR_DSS_MAS_MASK			BIT_MASK(10)
-#define VPU_40XX_HOST_SS_CPR_RST_CLR_MSS_MAS_MASK			BIT_MASK(11)
-
-#define VPU_40XX_HOST_SS_HW_VERSION					0x00000108u
-#define VPU_40XX_HOST_SS_HW_VERSION_SOC_REVISION_MASK			GENMASK(7, 0)
-#define VPU_40XX_HOST_SS_HW_VERSION_SOC_NUMBER_MASK			GENMASK(15, 8)
-#define VPU_40XX_HOST_SS_HW_VERSION_VPU_GENERATION_MASK			GENMASK(23, 16)
-
-#define VPU_40XX_HOST_SS_SW_VERSION					0x0000010cu
-
-#define VPU_40XX_HOST_SS_GEN_CTRL					0x00000118u
-#define VPU_40XX_HOST_SS_GEN_CTRL_PS_MASK				GENMASK(31, 29)
-
-#define VPU_40XX_HOST_SS_NOC_QREQN					0x00000154u
-#define VPU_40XX_HOST_SS_NOC_QREQN_TOP_SOCMMIO_MASK			BIT_MASK(0)
-
-#define VPU_40XX_HOST_SS_NOC_QACCEPTN					0x00000158u
-#define VPU_40XX_HOST_SS_NOC_QACCEPTN_TOP_SOCMMIO_MASK			BIT_MASK(0)
-
-#define VPU_40XX_HOST_SS_NOC_QDENY					0x0000015cu
-#define VPU_40XX_HOST_SS_NOC_QDENY_TOP_SOCMMIO_MASK			BIT_MASK(0)
-
-#define VPU_40XX_TOP_NOC_QREQN						0x00000160u
-#define VPU_40XX_TOP_NOC_QREQN_CPU_CTRL_MASK				BIT_MASK(0)
-#define VPU_40XX_TOP_NOC_QREQN_HOSTIF_L2CACHE_MASK			BIT_MASK(2)
-
-#define VPU_40XX_TOP_NOC_QACCEPTN					0x00000164u
-#define VPU_40XX_TOP_NOC_QACCEPTN_CPU_CTRL_MASK				BIT_MASK(0)
-#define VPU_40XX_TOP_NOC_QACCEPTN_HOSTIF_L2CACHE_MASK			BIT_MASK(2)
-
-#define VPU_40XX_TOP_NOC_QDENY						0x00000168u
-#define VPU_40XX_TOP_NOC_QDENY_CPU_CTRL_MASK				BIT_MASK(0)
-#define VPU_40XX_TOP_NOC_QDENY_HOSTIF_L2CACHE_MASK			BIT_MASK(2)
-
-#define VPU_40XX_HOST_SS_FW_SOC_IRQ_EN					0x00000170u
-#define VPU_40XX_HOST_SS_FW_SOC_IRQ_EN_CSS_ROM_CMX_MASK			BIT_MASK(0)
-#define VPU_40XX_HOST_SS_FW_SOC_IRQ_EN_CSS_DBG_MASK			BIT_MASK(1)
-#define VPU_40XX_HOST_SS_FW_SOC_IRQ_EN_CSS_CTRL_MASK			BIT_MASK(2)
-#define VPU_40XX_HOST_SS_FW_SOC_IRQ_EN_DEC400_MASK			BIT_MASK(3)
-#define VPU_40XX_HOST_SS_FW_SOC_IRQ_EN_MSS_NCE_MASK			BIT_MASK(4)
-#define VPU_40XX_HOST_SS_FW_SOC_IRQ_EN_MSS_MBI_MASK			BIT_MASK(5)
-#define VPU_40XX_HOST_SS_FW_SOC_IRQ_EN_MSS_MBI_CMX_MASK			BIT_MASK(6)
-
-#define VPU_40XX_HOST_SS_ICB_STATUS_0					0x00010210u
-#define VPU_40XX_HOST_SS_ICB_STATUS_0_TIMER_0_INT_MASK			BIT_MASK(0)
-#define VPU_40XX_HOST_SS_ICB_STATUS_0_TIMER_1_INT_MASK			BIT_MASK(1)
-#define VPU_40XX_HOST_SS_ICB_STATUS_0_TIMER_2_INT_MASK			BIT_MASK(2)
-#define VPU_40XX_HOST_SS_ICB_STATUS_0_TIMER_3_INT_MASK			BIT_MASK(3)
-#define VPU_40XX_HOST_SS_ICB_STATUS_0_HOST_IPC_FIFO_INT_MASK		BIT_MASK(4)
-#define VPU_40XX_HOST_SS_ICB_STATUS_0_MMU_IRQ_0_INT_MASK		BIT_MASK(5)
-#define VPU_40XX_HOST_SS_ICB_STATUS_0_MMU_IRQ_1_INT_MASK		BIT_MASK(6)
-#define VPU_40XX_HOST_SS_ICB_STATUS_0_MMU_IRQ_2_INT_MASK		BIT_MASK(7)
-#define VPU_40XX_HOST_SS_ICB_STATUS_0_NOC_FIREWALL_INT_MASK		BIT_MASK(8)
-#define VPU_40XX_HOST_SS_ICB_STATUS_0_CPU_INT_REDIRECT_0_INT_MASK	BIT_MASK(30)
-#define VPU_40XX_HOST_SS_ICB_STATUS_0_CPU_INT_REDIRECT_1_INT_MASK	BIT_MASK(31)
-
-#define VPU_40XX_HOST_SS_ICB_STATUS_1					0x00010214u
-#define VPU_40XX_HOST_SS_ICB_STATUS_1_CPU_INT_REDIRECT_2_INT_MASK	BIT_MASK(0)
-#define VPU_40XX_HOST_SS_ICB_STATUS_1_CPU_INT_REDIRECT_3_INT_MASK	BIT_MASK(1)
-#define VPU_40XX_HOST_SS_ICB_STATUS_1_CPU_INT_REDIRECT_4_INT_MASK	BIT_MASK(2)
-
-#define VPU_40XX_HOST_SS_ICB_CLEAR_0					0x00010220u
-#define VPU_40XX_HOST_SS_ICB_CLEAR_1					0x00010224u
-#define VPU_40XX_HOST_SS_ICB_ENABLE_0					0x00010240u
-#define VPU_40XX_HOST_SS_ICB_ENABLE_1					0x00010244u
-
-#define VPU_40XX_HOST_SS_TIM_IPC_FIFO_ATM				0x000200f4u
-
-#define VPU_40XX_HOST_SS_TIM_IPC_FIFO_STAT				0x000200fcu
-#define VPU_40XX_HOST_SS_TIM_IPC_FIFO_STAT_FILL_LEVEL_MASK		GENMASK(23, 16)
-
-#define VPU_40XX_HOST_SS_AON_PWR_ISO_EN0				0x00030020u
-#define VPU_40XX_HOST_SS_AON_PWR_ISO_EN0_CSS_CPU_MASK			BIT_MASK(3)
-
-#define VPU_40XX_HOST_SS_AON_PWR_ISLAND_EN0				0x00030024u
-#define VPU_40XX_HOST_SS_AON_PWR_ISLAND_EN0_CSS_CPU_MASK		BIT_MASK(3)
-
-#define VPU_40XX_HOST_SS_AON_PWR_ISLAND_TRICKLE_EN0			0x00030028u
-#define VPU_40XX_HOST_SS_AON_PWR_ISLAND_TRICKLE_EN0_CSS_CPU_MASK	BIT_MASK(3)
-
-#define VPU_40XX_HOST_SS_AON_PWR_ISLAND_STATUS0				0x0003002cu
-#define VPU_40XX_HOST_SS_AON_PWR_ISLAND_STATUS0_CSS_CPU_MASK		BIT_MASK(3)
-
-#define VPU_50XX_HOST_SS_AON_PWR_ISLAND_EN_POST_DLY			0x00030068u
-#define VPU_50XX_HOST_SS_AON_PWR_ISLAND_EN_POST_DLY_POST_DLY_MASK	GENMASK(7, 0)
-#define VPU_50XX_HOST_SS_AON_PWR_ISLAND_EN_POST_DLY_POST1_DLY_MASK	GENMASK(15, 8)
-#define VPU_50XX_HOST_SS_AON_PWR_ISLAND_EN_POST_DLY_POST2_DLY_MASK	GENMASK(23, 16)
-
-#define VPU_50XX_HOST_SS_AON_PWR_ISLAND_STATUS_DLY			0x0003006cu
-#define VPU_50XX_HOST_SS_AON_PWR_ISLAND_STATUS_DLY_STATUS_DLY_MASK	GENMASK(7, 0)
-
-#define VPU_40XX_HOST_SS_AON_IDLE_GEN					0x00030200u
-#define VPU_40XX_HOST_SS_AON_IDLE_GEN_EN_MASK				BIT_MASK(0)
-#define VPU_40XX_HOST_SS_AON_IDLE_GEN_HW_PG_EN_MASK			BIT_MASK(1)
-
-#define VPU_40XX_HOST_SS_AON_DPU_ACTIVE					0x00030204u
-#define VPU_40XX_HOST_SS_AON_DPU_ACTIVE_DPU_ACTIVE_MASK			BIT_MASK(0)
-
-#define VPU_50XX_HOST_SS_AON_FABRIC_REQ_OVERRIDE			0x00030210u
-#define VPU_50XX_HOST_SS_AON_FABRIC_REQ_OVERRIDE_REQ_OVERRIDE_MASK      BIT_MASK(0)
-
-#define VPU_40XX_HOST_SS_VERIFICATION_ADDRESS_LO			0x00040040u
-#define VPU_40XX_HOST_SS_VERIFICATION_ADDRESS_LO_DONE_MASK		BIT_MASK(0)
-#define VPU_40XX_HOST_SS_VERIFICATION_ADDRESS_LO_IOSF_RS_ID_MASK	GENMASK(2, 1)
-#define VPU_40XX_HOST_SS_VERIFICATION_ADDRESS_LO_IMAGE_LOCATION_MASK	GENMASK(31, 3)
-
-#define VPU_40XX_HOST_SS_WORKPOINT_CONFIG_MIRROR			0x00082020u
-#define VPU_40XX_HOST_SS_WORKPOINT_CONFIG_MIRROR_FINAL_PLL_FREQ_MASK	GENMASK(15, 0)
-#define VPU_40XX_HOST_SS_WORKPOINT_CONFIG_MIRROR_CONFIG_ID_MASK		GENMASK(31, 16)
-
-#define VPU_40XX_HOST_IF_TCU_PTW_OVERRIDES				0x00360000u
-#define VPU_40XX_HOST_IF_TCU_PTW_OVERRIDES_CACHE_OVERRIDE_EN_MASK	BIT_MASK(0)
-#define VPU_40XX_HOST_IF_TCU_PTW_OVERRIDES_AWCACHE_OVERRIDE_MASK	BIT_MASK(1)
-#define VPU_40XX_HOST_IF_TCU_PTW_OVERRIDES_ARCACHE_OVERRIDE_MASK	BIT_MASK(2)
-#define VPU_40XX_HOST_IF_TCU_PTW_OVERRIDES_SNOOP_OVERRIDE_EN_MASK	BIT_MASK(3)
-#define VPU_40XX_HOST_IF_TCU_PTW_OVERRIDES_AW_SNOOP_OVERRIDE_MASK	BIT_MASK(4)
-#define VPU_40XX_HOST_IF_TCU_PTW_OVERRIDES_AR_SNOOP_OVERRIDE_MASK	BIT_MASK(5)
-#define VPU_40XX_HOST_IF_TCU_PTW_OVERRIDES_PTW_AW_CONTEXT_FLAG_MASK	GENMASK(10, 6)
-#define VPU_40XX_HOST_IF_TCU_PTW_OVERRIDES_PTW_AR_CONTEXT_FLAG_MASK	GENMASK(15, 11)
-
-#define VPU_40XX_HOST_IF_TBU_MMUSSIDV					0x00360004u
-#define VPU_40XX_HOST_IF_TBU_MMUSSIDV_TBU0_AWMMUSSIDV_MASK		BIT_MASK(0)
-#define VPU_40XX_HOST_IF_TBU_MMUSSIDV_TBU0_ARMMUSSIDV_MASK		BIT_MASK(1)
-#define VPU_40XX_HOST_IF_TBU_MMUSSIDV_TBU1_AWMMUSSIDV_MASK		BIT_MASK(2)
-#define VPU_40XX_HOST_IF_TBU_MMUSSIDV_TBU1_ARMMUSSIDV_MASK		BIT_MASK(3)
-#define VPU_40XX_HOST_IF_TBU_MMUSSIDV_TBU2_AWMMUSSIDV_MASK		BIT_MASK(4)
-#define VPU_40XX_HOST_IF_TBU_MMUSSIDV_TBU2_ARMMUSSIDV_MASK		BIT_MASK(5)
-#define VPU_40XX_HOST_IF_TBU_MMUSSIDV_TBU3_AWMMUSSIDV_MASK		BIT_MASK(6)
-#define VPU_40XX_HOST_IF_TBU_MMUSSIDV_TBU3_ARMMUSSIDV_MASK		BIT_MASK(7)
-#define VPU_40XX_HOST_IF_TBU_MMUSSIDV_TBU4_AWMMUSSIDV_MASK		BIT_MASK(8)
-#define VPU_40XX_HOST_IF_TBU_MMUSSIDV_TBU4_ARMMUSSIDV_MASK		BIT_MASK(9)
-
-#define VPU_40XX_CPU_SS_DSU_LEON_RT_BASE				0x04000000u
-#define VPU_40XX_CPU_SS_DSU_LEON_RT_DSU_CTRL				0x04000000u
-#define VPU_40XX_CPU_SS_DSU_LEON_RT_PC_REG				0x04400010u
-#define VPU_40XX_CPU_SS_DSU_LEON_RT_NPC_REG				0x04400014u
-#define VPU_40XX_CPU_SS_DSU_LEON_RT_DSU_TRAP_REG			0x04400020u
-
-#define VPU_40XX_CPU_SS_TIM_WATCHDOG					0x0102009cu
-#define VPU_40XX_CPU_SS_TIM_WDOG_EN					0x010200a4u
-#define VPU_40XX_CPU_SS_TIM_SAFE					0x010200a8u
-
-#define VPU_40XX_CPU_SS_TIM_GEN_CONFIG					0x01021008u
-#define VPU_40XX_CPU_SS_TIM_GEN_CONFIG_WDOG_TO_INT_CLR_MASK		BIT_MASK(9)
-
-#define VPU_40XX_CPU_SS_CPR_NOC_QREQN					0x01010030u
-#define VPU_40XX_CPU_SS_CPR_NOC_QREQN_TOP_MMIO_MASK			BIT_MASK(0)
-
-#define VPU_40XX_CPU_SS_CPR_NOC_QACCEPTN				0x01010034u
-#define VPU_40XX_CPU_SS_CPR_NOC_QACCEPTN_TOP_MMIO_MASK			BIT_MASK(0)
-
-#define VPU_40XX_CPU_SS_CPR_NOC_QDENY					0x01010038u
-#define VPU_40XX_CPU_SS_CPR_NOC_QDENY_TOP_MMIO_MASK			BIT_MASK(0)
-
-#define VPU_40XX_CPU_SS_TIM_IPC_FIFO					0x010200f0u
-#define VPU_40XX_CPU_SS_TIM_PERF_EXT_FREE_CNT				0x01029008u
-
-#define VPU_40XX_CPU_SS_DOORBELL_0					0x01300000u
-#define VPU_40XX_CPU_SS_DOORBELL_0_SET_MASK				BIT_MASK(0)
-
-#define VPU_40XX_CPU_SS_DOORBELL_1					0x01301000u
-
-#endif /* __IVPU_HW_40XX_REG_H__ */
diff --git a/drivers/accel/ivpu/ivpu_hw_btrs.h b/drivers/accel/ivpu/ivpu_hw_btrs.h
index e545284fcfa2..30c89ab8e4bd 100644
--- a/drivers/accel/ivpu/ivpu_hw_btrs.h
+++ b/drivers/accel/ivpu/ivpu_hw_btrs.h
@@ -7,8 +7,6 @@
 #define __IVPU_HW_BTRS_H__
 
 #include "ivpu_drv.h"
-#include "ivpu_hw_37xx_reg.h"
-#include "ivpu_hw_40xx_reg.h"
 #include "ivpu_hw_reg_io.h"
 
 #define PLL_PROFILING_FREQ_DEFAULT   38400000
diff --git a/drivers/accel/ivpu/ivpu_hw_ip.c b/drivers/accel/ivpu/ivpu_hw_ip.c
index 36730f4338f0..55931d896e45 100644
--- a/drivers/accel/ivpu/ivpu_hw_ip.c
+++ b/drivers/accel/ivpu/ivpu_hw_ip.c
@@ -7,10 +7,9 @@
 #include "ivpu_fw.h"
 #include "ivpu_gem.h"
 #include "ivpu_hw.h"
-#include "ivpu_hw_37xx_reg.h"
-#include "ivpu_hw_40xx_reg.h"
 #include "ivpu_hw_btrs.h"
 #include "ivpu_hw_ip.h"
+#include "ivpu_hw_ip_reg.h"
 #include "ivpu_hw_reg_io.h"
 #include "ivpu_mmu.h"
 #include "ivpu_pm.h"
@@ -32,17 +31,17 @@
 
 #define ICB_0_1_IRQ_MASK_37XX ((((u64)ICB_1_IRQ_MASK_37XX) << 32) | ICB_0_IRQ_MASK_37XX)
 
-#define ICB_0_IRQ_MASK_40XX ((REG_FLD(VPU_40XX_HOST_SS_ICB_STATUS_0, HOST_IPC_FIFO_INT)) | \
-			     (REG_FLD(VPU_40XX_HOST_SS_ICB_STATUS_0, MMU_IRQ_0_INT)) | \
-			     (REG_FLD(VPU_40XX_HOST_SS_ICB_STATUS_0, MMU_IRQ_1_INT)) | \
-			     (REG_FLD(VPU_40XX_HOST_SS_ICB_STATUS_0, MMU_IRQ_2_INT)) | \
-			     (REG_FLD(VPU_40XX_HOST_SS_ICB_STATUS_0, NOC_FIREWALL_INT)) | \
-			     (REG_FLD(VPU_40XX_HOST_SS_ICB_STATUS_0, CPU_INT_REDIRECT_0_INT)) | \
-			     (REG_FLD(VPU_40XX_HOST_SS_ICB_STATUS_0, CPU_INT_REDIRECT_1_INT)))
+#define ICB_0_IRQ_MASK_40XX ((REG_FLD(VPU_37XX_HOST_SS_ICB_STATUS_0, HOST_IPC_FIFO_INT)) | \
+			     (REG_FLD(VPU_37XX_HOST_SS_ICB_STATUS_0, MMU_IRQ_0_INT)) | \
+			     (REG_FLD(VPU_37XX_HOST_SS_ICB_STATUS_0, MMU_IRQ_1_INT)) | \
+			     (REG_FLD(VPU_37XX_HOST_SS_ICB_STATUS_0, MMU_IRQ_2_INT)) | \
+			     (REG_FLD(VPU_37XX_HOST_SS_ICB_STATUS_0, NOC_FIREWALL_INT)) | \
+			     (REG_FLD(VPU_37XX_HOST_SS_ICB_STATUS_0, CPU_INT_REDIRECT_0_INT)) | \
+			     (REG_FLD(VPU_37XX_HOST_SS_ICB_STATUS_0, CPU_INT_REDIRECT_1_INT)))
 
-#define ICB_1_IRQ_MASK_40XX ((REG_FLD(VPU_40XX_HOST_SS_ICB_STATUS_1, CPU_INT_REDIRECT_2_INT)) | \
-			     (REG_FLD(VPU_40XX_HOST_SS_ICB_STATUS_1, CPU_INT_REDIRECT_3_INT)) | \
-			     (REG_FLD(VPU_40XX_HOST_SS_ICB_STATUS_1, CPU_INT_REDIRECT_4_INT)))
+#define ICB_1_IRQ_MASK_40XX ((REG_FLD(VPU_37XX_HOST_SS_ICB_STATUS_1, CPU_INT_REDIRECT_2_INT)) | \
+			     (REG_FLD(VPU_37XX_HOST_SS_ICB_STATUS_1, CPU_INT_REDIRECT_3_INT)) | \
+			     (REG_FLD(VPU_37XX_HOST_SS_ICB_STATUS_1, CPU_INT_REDIRECT_4_INT)))
 
 #define ICB_0_1_IRQ_MASK_40XX ((((u64)ICB_1_IRQ_MASK_40XX) << 32) | ICB_0_IRQ_MASK_40XX)
 
@@ -54,13 +53,13 @@
 					  (REG_FLD(VPU_37XX_HOST_SS_FW_SOC_IRQ_EN, MSS_MBI)) | \
 					  (REG_FLD(VPU_37XX_HOST_SS_FW_SOC_IRQ_EN, MSS_MBI_CMX)))
 
-#define ITF_FIREWALL_VIOLATION_MASK_40XX ((REG_FLD(VPU_40XX_HOST_SS_FW_SOC_IRQ_EN, CSS_ROM_CMX)) | \
-					  (REG_FLD(VPU_40XX_HOST_SS_FW_SOC_IRQ_EN, CSS_DBG)) | \
-					  (REG_FLD(VPU_40XX_HOST_SS_FW_SOC_IRQ_EN, CSS_CTRL)) | \
-					  (REG_FLD(VPU_40XX_HOST_SS_FW_SOC_IRQ_EN, DEC400)) | \
-					  (REG_FLD(VPU_40XX_HOST_SS_FW_SOC_IRQ_EN, MSS_NCE)) | \
-					  (REG_FLD(VPU_40XX_HOST_SS_FW_SOC_IRQ_EN, MSS_MBI)) | \
-					  (REG_FLD(VPU_40XX_HOST_SS_FW_SOC_IRQ_EN, MSS_MBI_CMX)))
+#define ITF_FIREWALL_VIOLATION_MASK_40XX ((REG_FLD(VPU_37XX_HOST_SS_FW_SOC_IRQ_EN, CSS_ROM_CMX)) | \
+					  (REG_FLD(VPU_37XX_HOST_SS_FW_SOC_IRQ_EN, CSS_DBG)) | \
+					  (REG_FLD(VPU_37XX_HOST_SS_FW_SOC_IRQ_EN, CSS_CTRL)) | \
+					  (REG_FLD(VPU_37XX_HOST_SS_FW_SOC_IRQ_EN, DEC400)) | \
+					  (REG_FLD(VPU_37XX_HOST_SS_FW_SOC_IRQ_EN, MSS_NCE)) | \
+					  (REG_FLD(VPU_37XX_HOST_SS_FW_SOC_IRQ_EN, MSS_MBI)) | \
+					  (REG_FLD(VPU_37XX_HOST_SS_FW_SOC_IRQ_EN, MSS_MBI_CMX)))
 
 static int wait_for_ip_bar(struct ivpu_device *vdev)
 {
@@ -90,9 +89,9 @@ static int host_ss_noc_qreqn_check_37xx(struct ivpu_device *vdev, u32 exp_val)
 
 static int host_ss_noc_qreqn_check_40xx(struct ivpu_device *vdev, u32 exp_val)
 {
-	u32 val = REGV_RD32(VPU_40XX_HOST_SS_NOC_QREQN);
+	u32 val = REGV_RD32(VPU_37XX_HOST_SS_NOC_QREQN);
 
-	if (!REG_TEST_FLD_NUM(VPU_40XX_HOST_SS_NOC_QREQN, TOP_SOCMMIO, exp_val, val))
+	if (!REG_TEST_FLD_NUM(VPU_37XX_HOST_SS_NOC_QREQN, TOP_SOCMMIO, exp_val, val))
 		return -EIO;
 
 	return 0;
@@ -118,9 +117,9 @@ static int host_ss_noc_qacceptn_check_37xx(struct ivpu_device *vdev, u32 exp_val
 
 static int host_ss_noc_qacceptn_check_40xx(struct ivpu_device *vdev, u32 exp_val)
 {
-	u32 val = REGV_RD32(VPU_40XX_HOST_SS_NOC_QACCEPTN);
+	u32 val = REGV_RD32(VPU_37XX_HOST_SS_NOC_QACCEPTN);
 
-	if (!REG_TEST_FLD_NUM(VPU_40XX_HOST_SS_NOC_QACCEPTN, TOP_SOCMMIO, exp_val, val))
+	if (!REG_TEST_FLD_NUM(VPU_37XX_HOST_SS_NOC_QACCEPTN, TOP_SOCMMIO, exp_val, val))
 		return -EIO;
 
 	return 0;
@@ -146,9 +145,9 @@ static int host_ss_noc_qdeny_check_37xx(struct ivpu_device *vdev, u32 exp_val)
 
 static int host_ss_noc_qdeny_check_40xx(struct ivpu_device *vdev, u32 exp_val)
 {
-	u32 val = REGV_RD32(VPU_40XX_HOST_SS_NOC_QDENY);
+	u32 val = REGV_RD32(VPU_37XX_HOST_SS_NOC_QDENY);
 
-	if (!REG_TEST_FLD_NUM(VPU_40XX_HOST_SS_NOC_QDENY, TOP_SOCMMIO, exp_val, val))
+	if (!REG_TEST_FLD_NUM(VPU_37XX_HOST_SS_NOC_QDENY, TOP_SOCMMIO, exp_val, val))
 		return -EIO;
 
 	return 0;
@@ -175,9 +174,9 @@ static int top_noc_qrenqn_check_37xx(struct ivpu_device *vdev, u32 exp_val)
 
 static int top_noc_qrenqn_check_40xx(struct ivpu_device *vdev, u32 exp_val)
 {
-	u32 val = REGV_RD32(VPU_40XX_TOP_NOC_QREQN);
+	u32 val = REGV_RD32(VPU_37XX_TOP_NOC_QREQN);
 
-	if (!REG_TEST_FLD_NUM(VPU_40XX_TOP_NOC_QREQN, CPU_CTRL, exp_val, val) ||
+	if (!REG_TEST_FLD_NUM(VPU_37XX_TOP_NOC_QREQN, CPU_CTRL, exp_val, val) ||
 	    !REG_TEST_FLD_NUM(VPU_40XX_TOP_NOC_QREQN, HOSTIF_L2CACHE, exp_val, val))
 		return -EIO;
 
@@ -238,14 +237,14 @@ static void idle_gen_drive_37xx(struct ivpu_device *vdev, bool enable)
 
 static void idle_gen_drive_40xx(struct ivpu_device *vdev, bool enable)
 {
-	u32 val = REGV_RD32(VPU_40XX_HOST_SS_AON_IDLE_GEN);
+	u32 val = REGV_RD32(VPU_37XX_HOST_SS_AON_VPU_IDLE_GEN);
 
 	if (enable)
-		val = REG_SET_FLD(VPU_40XX_HOST_SS_AON_IDLE_GEN, EN, val);
+		val = REG_SET_FLD(VPU_37XX_HOST_SS_AON_VPU_IDLE_GEN, EN, val);
 	else
-		val = REG_CLR_FLD(VPU_40XX_HOST_SS_AON_IDLE_GEN, EN, val);
+		val = REG_CLR_FLD(VPU_37XX_HOST_SS_AON_VPU_IDLE_GEN, EN, val);
 
-	REGV_WR32(VPU_40XX_HOST_SS_AON_IDLE_GEN, val);
+	REGV_WR32(VPU_37XX_HOST_SS_AON_VPU_IDLE_GEN, val);
 }
 
 void ivpu_hw_ip_idle_gen_enable(struct ivpu_device *vdev)
@@ -308,14 +307,14 @@ static void pwr_island_trickle_drive_37xx(struct ivpu_device *vdev, bool enable)
 
 static void pwr_island_trickle_drive_40xx(struct ivpu_device *vdev, bool enable)
 {
-	u32 val = REGV_RD32(VPU_40XX_HOST_SS_AON_PWR_ISLAND_TRICKLE_EN0);
+	u32 val = REGV_RD32(VPU_37XX_HOST_SS_AON_PWR_ISLAND_TRICKLE_EN0);
 
 	if (enable)
-		val = REG_SET_FLD(VPU_40XX_HOST_SS_AON_PWR_ISLAND_TRICKLE_EN0, CSS_CPU, val);
+		val = REG_SET_FLD(VPU_37XX_HOST_SS_AON_PWR_ISLAND_TRICKLE_EN0, MSS_CPU, val);
 	else
-		val = REG_CLR_FLD(VPU_40XX_HOST_SS_AON_PWR_ISLAND_TRICKLE_EN0, CSS_CPU, val);
+		val = REG_CLR_FLD(VPU_37XX_HOST_SS_AON_PWR_ISLAND_TRICKLE_EN0, MSS_CPU, val);
 
-	REGV_WR32(VPU_40XX_HOST_SS_AON_PWR_ISLAND_TRICKLE_EN0, val);
+	REGV_WR32(VPU_37XX_HOST_SS_AON_PWR_ISLAND_TRICKLE_EN0, val);
 }
 
 static void pwr_island_drive_37xx(struct ivpu_device *vdev, bool enable)
@@ -332,14 +331,14 @@ static void pwr_island_drive_37xx(struct ivpu_device *vdev, bool enable)
 
 static void pwr_island_drive_40xx(struct ivpu_device *vdev, bool enable)
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
 
 static void pwr_island_enable(struct ivpu_device *vdev)
@@ -364,7 +363,7 @@ static int wait_for_pwr_island_status(struct ivpu_device *vdev, u32 exp_val)
 		return REGV_POLL_FLD(VPU_37XX_HOST_SS_AON_PWR_ISLAND_STATUS0, MSS_CPU, exp_val,
 				     vdev->timeout.pwr_island_status);
 	else
-		return REGV_POLL_FLD(VPU_40XX_HOST_SS_AON_PWR_ISLAND_STATUS0, CSS_CPU, exp_val,
+		return REGV_POLL_FLD(VPU_37XX_HOST_SS_AON_PWR_ISLAND_STATUS0, MSS_CPU, exp_val,
 				     vdev->timeout.pwr_island_status);
 }
 
@@ -382,14 +381,14 @@ static void pwr_island_isolation_drive_37xx(struct ivpu_device *vdev, bool enabl
 
 static void pwr_island_isolation_drive_40xx(struct ivpu_device *vdev, bool enable)
 {
-	u32 val = REGV_RD32(VPU_40XX_HOST_SS_AON_PWR_ISO_EN0);
+	u32 val = REGV_RD32(VPU_37XX_HOST_SS_AON_PWR_ISO_EN0);
 
 	if (enable)
-		val = REG_SET_FLD(VPU_40XX_HOST_SS_AON_PWR_ISO_EN0, CSS_CPU, val);
+		val = REG_SET_FLD(VPU_37XX_HOST_SS_AON_PWR_ISO_EN0, MSS_CPU, val);
 	else
-		val = REG_CLR_FLD(VPU_40XX_HOST_SS_AON_PWR_ISO_EN0, CSS_CPU, val);
+		val = REG_CLR_FLD(VPU_37XX_HOST_SS_AON_PWR_ISO_EN0, MSS_CPU, val);
 
-	REGV_WR32(VPU_40XX_HOST_SS_AON_PWR_ISO_EN0, val);
+	REGV_WR32(VPU_37XX_HOST_SS_AON_PWR_ISO_EN0, val);
 }
 
 static void pwr_island_isolation_drive(struct ivpu_device *vdev, bool enable)
@@ -512,13 +511,13 @@ static void host_ss_noc_qreqn_top_socmmio_drive_37xx(struct ivpu_device *vdev, b
 
 static void host_ss_noc_qreqn_top_socmmio_drive_40xx(struct ivpu_device *vdev, bool enable)
 {
-	u32 val = REGV_RD32(VPU_40XX_HOST_SS_NOC_QREQN);
+	u32 val = REGV_RD32(VPU_37XX_HOST_SS_NOC_QREQN);
 
 	if (enable)
-		val = REG_SET_FLD(VPU_40XX_HOST_SS_NOC_QREQN, TOP_SOCMMIO, val);
+		val = REG_SET_FLD(VPU_37XX_HOST_SS_NOC_QREQN, TOP_SOCMMIO, val);
 	else
-		val = REG_CLR_FLD(VPU_40XX_HOST_SS_NOC_QREQN, TOP_SOCMMIO, val);
-	REGV_WR32(VPU_40XX_HOST_SS_NOC_QREQN, val);
+		val = REG_CLR_FLD(VPU_37XX_HOST_SS_NOC_QREQN, TOP_SOCMMIO, val);
+	REGV_WR32(VPU_37XX_HOST_SS_NOC_QREQN, val);
 }
 
 static void host_ss_noc_qreqn_top_socmmio_drive(struct ivpu_device *vdev, bool enable)
@@ -550,17 +549,17 @@ static int host_ss_axi_drive(struct ivpu_device *vdev, bool enable)
 
 static void top_noc_qreqn_drive_40xx(struct ivpu_device *vdev, bool enable)
 {
-	u32 val = REGV_RD32(VPU_40XX_TOP_NOC_QREQN);
+	u32 val = REGV_RD32(VPU_37XX_TOP_NOC_QREQN);
 
 	if (enable) {
-		val = REG_SET_FLD(VPU_40XX_TOP_NOC_QREQN, CPU_CTRL, val);
+		val = REG_SET_FLD(VPU_37XX_TOP_NOC_QREQN, CPU_CTRL, val);
 		val = REG_SET_FLD(VPU_40XX_TOP_NOC_QREQN, HOSTIF_L2CACHE, val);
 	} else {
-		val = REG_CLR_FLD(VPU_40XX_TOP_NOC_QREQN, CPU_CTRL, val);
+		val = REG_CLR_FLD(VPU_37XX_TOP_NOC_QREQN, CPU_CTRL, val);
 		val = REG_CLR_FLD(VPU_40XX_TOP_NOC_QREQN, HOSTIF_L2CACHE, val);
 	}
 
-	REGV_WR32(VPU_40XX_TOP_NOC_QREQN, val);
+	REGV_WR32(VPU_37XX_TOP_NOC_QREQN, val);
 }
 
 static void top_noc_qreqn_drive_37xx(struct ivpu_device *vdev, bool enable)
@@ -604,9 +603,9 @@ static int top_noc_qacceptn_check_37xx(struct ivpu_device *vdev, u32 exp_val)
 
 static int top_noc_qacceptn_check_40xx(struct ivpu_device *vdev, u32 exp_val)
 {
-	u32 val = REGV_RD32(VPU_40XX_TOP_NOC_QACCEPTN);
+	u32 val = REGV_RD32(VPU_37XX_TOP_NOC_QACCEPTN);
 
-	if (!REG_TEST_FLD_NUM(VPU_40XX_TOP_NOC_QACCEPTN, CPU_CTRL, exp_val, val) ||
+	if (!REG_TEST_FLD_NUM(VPU_37XX_TOP_NOC_QACCEPTN, CPU_CTRL, exp_val, val) ||
 	    !REG_TEST_FLD_NUM(VPU_40XX_TOP_NOC_QACCEPTN, HOSTIF_L2CACHE, exp_val, val))
 		return -EIO;
 
@@ -634,9 +633,9 @@ static int top_noc_qdeny_check_37xx(struct ivpu_device *vdev, u32 exp_val)
 
 static int top_noc_qdeny_check_40xx(struct ivpu_device *vdev, u32 exp_val)
 {
-	u32 val = REGV_RD32(VPU_40XX_TOP_NOC_QDENY);
+	u32 val = REGV_RD32(VPU_37XX_TOP_NOC_QDENY);
 
-	if (!REG_TEST_FLD_NUM(VPU_40XX_TOP_NOC_QDENY, CPU_CTRL, exp_val, val) ||
+	if (!REG_TEST_FLD_NUM(VPU_37XX_TOP_NOC_QDENY, CPU_CTRL, exp_val, val) ||
 	    !REG_TEST_FLD_NUM(VPU_40XX_TOP_NOC_QDENY, HOSTIF_L2CACHE, exp_val, val))
 		return -EIO;
 
@@ -758,7 +757,7 @@ static void ivpu_hw_ip_snoop_disable_37xx(struct ivpu_device *vdev)
 
 static void ivpu_hw_ip_snoop_disable_40xx(struct ivpu_device *vdev)
 {
-	u32 val = REGV_RD32(VPU_40XX_HOST_IF_TCU_PTW_OVERRIDES);
+	u32 val = REGV_RD32(VPU_37XX_HOST_IF_TCU_PTW_OVERRIDES);
 
 	val = REG_SET_FLD(VPU_40XX_HOST_IF_TCU_PTW_OVERRIDES, SNOOP_OVERRIDE_EN, val);
 	val = REG_SET_FLD(VPU_40XX_HOST_IF_TCU_PTW_OVERRIDES, AW_SNOOP_OVERRIDE, val);
@@ -768,7 +767,7 @@ static void ivpu_hw_ip_snoop_disable_40xx(struct ivpu_device *vdev)
 	else
 		val = REG_CLR_FLD(VPU_40XX_HOST_IF_TCU_PTW_OVERRIDES, AR_SNOOP_OVERRIDE, val);
 
-	REGV_WR32(VPU_40XX_HOST_IF_TCU_PTW_OVERRIDES, val);
+	REGV_WR32(VPU_37XX_HOST_IF_TCU_PTW_OVERRIDES, val);
 }
 
 void ivpu_hw_ip_snoop_disable(struct ivpu_device *vdev)
@@ -793,16 +792,16 @@ static void ivpu_hw_ip_tbu_mmu_enable_37xx(struct ivpu_device *vdev)
 
 static void ivpu_hw_ip_tbu_mmu_enable_40xx(struct ivpu_device *vdev)
 {
-	u32 val = REGV_RD32(VPU_40XX_HOST_IF_TBU_MMUSSIDV);
+	u32 val = REGV_RD32(VPU_37XX_HOST_IF_TBU_MMUSSIDV);
 
-	val = REG_SET_FLD(VPU_40XX_HOST_IF_TBU_MMUSSIDV, TBU0_AWMMUSSIDV, val);
-	val = REG_SET_FLD(VPU_40XX_HOST_IF_TBU_MMUSSIDV, TBU0_ARMMUSSIDV, val);
-	val = REG_SET_FLD(VPU_40XX_HOST_IF_TBU_MMUSSIDV, TBU1_AWMMUSSIDV, val);
-	val = REG_SET_FLD(VPU_40XX_HOST_IF_TBU_MMUSSIDV, TBU1_ARMMUSSIDV, val);
-	val = REG_SET_FLD(VPU_40XX_HOST_IF_TBU_MMUSSIDV, TBU2_AWMMUSSIDV, val);
-	val = REG_SET_FLD(VPU_40XX_HOST_IF_TBU_MMUSSIDV, TBU2_ARMMUSSIDV, val);
+	val = REG_SET_FLD(VPU_37XX_HOST_IF_TBU_MMUSSIDV, TBU0_AWMMUSSIDV, val);
+	val = REG_SET_FLD(VPU_37XX_HOST_IF_TBU_MMUSSIDV, TBU0_ARMMUSSIDV, val);
+	val = REG_SET_FLD(VPU_37XX_HOST_IF_TBU_MMUSSIDV, TBU1_AWMMUSSIDV, val);
+	val = REG_SET_FLD(VPU_37XX_HOST_IF_TBU_MMUSSIDV, TBU1_ARMMUSSIDV, val);
+	val = REG_SET_FLD(VPU_37XX_HOST_IF_TBU_MMUSSIDV, TBU2_AWMMUSSIDV, val);
+	val = REG_SET_FLD(VPU_37XX_HOST_IF_TBU_MMUSSIDV, TBU2_ARMMUSSIDV, val);
 
-	REGV_WR32(VPU_40XX_HOST_IF_TBU_MMUSSIDV, val);
+	REGV_WR32(VPU_37XX_HOST_IF_TBU_MMUSSIDV, val);
 }
 
 void ivpu_hw_ip_tbu_mmu_enable(struct ivpu_device *vdev)
@@ -1007,9 +1006,9 @@ static u32 ipc_rx_count_get_37xx(struct ivpu_device *vdev)
 
 static u32 ipc_rx_count_get_40xx(struct ivpu_device *vdev)
 {
-	u32 count = readl(vdev->regv + VPU_40XX_HOST_SS_TIM_IPC_FIFO_STAT);
+	u32 count = readl(vdev->regv + VPU_37XX_HOST_SS_TIM_IPC_FIFO_STAT);
 
-	return REG_GET_FLD(VPU_40XX_HOST_SS_TIM_IPC_FIFO_STAT, FILL_LEVEL, count);
+	return REG_GET_FLD(VPU_37XX_HOST_SS_TIM_IPC_FIFO_STAT, FILL_LEVEL, count);
 }
 
 u32 ivpu_hw_ip_ipc_rx_count_get(struct ivpu_device *vdev)
@@ -1026,8 +1025,8 @@ void ivpu_hw_ip_irq_enable(struct ivpu_device *vdev)
 		REGV_WR32(VPU_37XX_HOST_SS_FW_SOC_IRQ_EN, ITF_FIREWALL_VIOLATION_MASK_37XX);
 		REGV_WR64(VPU_37XX_HOST_SS_ICB_ENABLE_0, ICB_0_1_IRQ_MASK_37XX);
 	} else {
-		REGV_WR32(VPU_40XX_HOST_SS_FW_SOC_IRQ_EN, ITF_FIREWALL_VIOLATION_MASK_40XX);
-		REGV_WR64(VPU_40XX_HOST_SS_ICB_ENABLE_0, ICB_0_1_IRQ_MASK_40XX);
+		REGV_WR32(VPU_37XX_HOST_SS_FW_SOC_IRQ_EN, ITF_FIREWALL_VIOLATION_MASK_40XX);
+		REGV_WR64(VPU_37XX_HOST_SS_ICB_ENABLE_0, ICB_0_1_IRQ_MASK_40XX);
 	}
 }
 
@@ -1037,8 +1036,8 @@ void ivpu_hw_ip_irq_disable(struct ivpu_device *vdev)
 		REGV_WR64(VPU_37XX_HOST_SS_ICB_ENABLE_0, 0x0ull);
 		REGV_WR32(VPU_37XX_HOST_SS_FW_SOC_IRQ_EN, 0x0);
 	} else {
-		REGV_WR64(VPU_40XX_HOST_SS_ICB_ENABLE_0, 0x0ull);
-		REGV_WR32(VPU_40XX_HOST_SS_FW_SOC_IRQ_EN, 0x0ul);
+		REGV_WR64(VPU_37XX_HOST_SS_ICB_ENABLE_0, 0x0ull);
+		REGV_WR32(VPU_37XX_HOST_SS_FW_SOC_IRQ_EN, 0x0ul);
 	}
 }
 
@@ -1061,18 +1060,18 @@ static void diagnose_failure_37xx(struct ivpu_device *vdev)
 
 static void diagnose_failure_40xx(struct ivpu_device *vdev)
 {
-	u32 reg = REGV_RD32(VPU_40XX_HOST_SS_ICB_STATUS_0) & ICB_0_IRQ_MASK_40XX;
+	u32 reg = REGV_RD32(VPU_37XX_HOST_SS_ICB_STATUS_0) & ICB_0_IRQ_MASK_40XX;
 
 	if (ipc_rx_count_get_40xx(vdev))
 		ivpu_err(vdev, "IPC FIFO queue not empty, missed IPC IRQ");
 
-	if (REG_TEST_FLD(VPU_40XX_HOST_SS_ICB_STATUS_0, CPU_INT_REDIRECT_0_INT, reg))
+	if (REG_TEST_FLD(VPU_37XX_HOST_SS_ICB_STATUS_0, CPU_INT_REDIRECT_0_INT, reg))
 		ivpu_err(vdev, "WDT MSS timeout detected\n");
 
-	if (REG_TEST_FLD(VPU_40XX_HOST_SS_ICB_STATUS_0, CPU_INT_REDIRECT_1_INT, reg))
+	if (REG_TEST_FLD(VPU_37XX_HOST_SS_ICB_STATUS_0, CPU_INT_REDIRECT_1_INT, reg))
 		ivpu_err(vdev, "WDT NCE timeout detected\n");
 
-	if (REG_TEST_FLD(VPU_40XX_HOST_SS_ICB_STATUS_0, NOC_FIREWALL_INT, reg))
+	if (REG_TEST_FLD(VPU_37XX_HOST_SS_ICB_STATUS_0, NOC_FIREWALL_INT, reg))
 		ivpu_err(vdev, "NOC Firewall irq detected\n");
 }
 
@@ -1089,7 +1088,7 @@ void ivpu_hw_ip_irq_clear(struct ivpu_device *vdev)
 	if (ivpu_hw_ip_gen(vdev) == IVPU_HW_IP_37XX)
 		REGV_WR64(VPU_37XX_HOST_SS_ICB_CLEAR_0, ICB_0_1_IRQ_MASK_37XX);
 	else
-		REGV_WR64(VPU_40XX_HOST_SS_ICB_CLEAR_0, ICB_0_1_IRQ_MASK_40XX);
+		REGV_WR64(VPU_37XX_HOST_SS_ICB_CLEAR_0, ICB_0_1_IRQ_MASK_40XX);
 }
 
 static void irq_wdt_nce_handler(struct ivpu_device *vdev)
@@ -1148,32 +1147,32 @@ bool ivpu_hw_ip_irq_handler_37xx(struct ivpu_device *vdev, int irq)
 /* Handler for IRQs from NPU core */
 bool ivpu_hw_ip_irq_handler_40xx(struct ivpu_device *vdev, int irq)
 {
-	u32 status = REGV_RD32(VPU_40XX_HOST_SS_ICB_STATUS_0) & ICB_0_IRQ_MASK_40XX;
+	u32 status = REGV_RD32(VPU_37XX_HOST_SS_ICB_STATUS_0) & ICB_0_IRQ_MASK_40XX;
 
 	if (!status)
 		return false;
 
-	REGV_WR32(VPU_40XX_HOST_SS_ICB_CLEAR_0, status);
+	REGV_WR32(VPU_37XX_HOST_SS_ICB_CLEAR_0, status);
 
-	if (REG_TEST_FLD(VPU_40XX_HOST_SS_ICB_STATUS_0, MMU_IRQ_0_INT, status))
+	if (REG_TEST_FLD(VPU_37XX_HOST_SS_ICB_STATUS_0, MMU_IRQ_0_INT, status))
 		ivpu_mmu_irq_evtq_handler(vdev);
 
-	if (REG_TEST_FLD(VPU_40XX_HOST_SS_ICB_STATUS_0, HOST_IPC_FIFO_INT, status))
+	if (REG_TEST_FLD(VPU_37XX_HOST_SS_ICB_STATUS_0, HOST_IPC_FIFO_INT, status))
 		ivpu_ipc_irq_handler(vdev);
 
-	if (REG_TEST_FLD(VPU_40XX_HOST_SS_ICB_STATUS_0, MMU_IRQ_1_INT, status))
+	if (REG_TEST_FLD(VPU_37XX_HOST_SS_ICB_STATUS_0, MMU_IRQ_1_INT, status))
 		ivpu_dbg(vdev, IRQ, "MMU sync complete\n");
 
-	if (REG_TEST_FLD(VPU_40XX_HOST_SS_ICB_STATUS_0, MMU_IRQ_2_INT, status))
+	if (REG_TEST_FLD(VPU_37XX_HOST_SS_ICB_STATUS_0, MMU_IRQ_2_INT, status))
 		ivpu_mmu_irq_gerr_handler(vdev);
 
-	if (REG_TEST_FLD(VPU_40XX_HOST_SS_ICB_STATUS_0, CPU_INT_REDIRECT_0_INT, status))
+	if (REG_TEST_FLD(VPU_37XX_HOST_SS_ICB_STATUS_0, CPU_INT_REDIRECT_0_INT, status))
 		irq_wdt_mss_handler(vdev);
 
-	if (REG_TEST_FLD(VPU_40XX_HOST_SS_ICB_STATUS_0, CPU_INT_REDIRECT_1_INT, status))
+	if (REG_TEST_FLD(VPU_37XX_HOST_SS_ICB_STATUS_0, CPU_INT_REDIRECT_1_INT, status))
 		irq_wdt_nce_handler(vdev);
 
-	if (REG_TEST_FLD(VPU_40XX_HOST_SS_ICB_STATUS_0, NOC_FIREWALL_INT, status))
+	if (REG_TEST_FLD(VPU_37XX_HOST_SS_ICB_STATUS_0, NOC_FIREWALL_INT, status))
 		irq_noc_firewall_handler(vdev);
 
 	return true;
@@ -1208,7 +1207,7 @@ u32 ivpu_hw_ip_ipc_rx_addr_get(struct ivpu_device *vdev)
 	if (ivpu_hw_ip_gen(vdev) == IVPU_HW_IP_37XX)
 		return REGV_RD32(VPU_37XX_HOST_SS_TIM_IPC_FIFO_ATM);
 	else
-		return REGV_RD32(VPU_40XX_HOST_SS_TIM_IPC_FIFO_ATM);
+		return REGV_RD32(VPU_37XX_HOST_SS_TIM_IPC_FIFO_ATM);
 }
 
 void ivpu_hw_ip_ipc_tx_set(struct ivpu_device *vdev, u32 vpu_addr)
diff --git a/drivers/accel/ivpu/ivpu_hw_37xx_reg.h b/drivers/accel/ivpu/ivpu_hw_ip_reg.h
similarity index 73%
rename from drivers/accel/ivpu/ivpu_hw_37xx_reg.h
rename to drivers/accel/ivpu/ivpu_hw_ip_reg.h
index cf5e2f01049c..126df1012f23 100644
--- a/drivers/accel/ivpu/ivpu_hw_37xx_reg.h
+++ b/drivers/accel/ivpu/ivpu_hw_ip_reg.h
@@ -1,18 +1,28 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (C) 2020-2023 Intel Corporation
+ * Copyright (C) 2020-2026 Intel Corporation
  */
 
-#ifndef __IVPU_HW_37XX_REG_H__
-#define __IVPU_HW_37XX_REG_H__
+#ifndef __IVPU_HW_IP_REG_H__
+#define __IVPU_HW_IP_REG_H__
 
 #include <linux/bits.h>
 
+#define VPU_40XX_HOST_SS_CPR_CLK_EN					0x00000080u
+#define VPU_40XX_HOST_SS_CPR_CLK_EN_TOP_NOC_MASK			BIT_MASK(1)
+#define VPU_40XX_HOST_SS_CPR_CLK_EN_DSS_MAS_MASK			BIT_MASK(10)
+#define VPU_40XX_HOST_SS_CPR_CLK_EN_CSS_MAS_MASK			BIT_MASK(11)
+
 #define VPU_37XX_HOST_SS_CPR_CLK_SET					0x00000084u
 #define VPU_37XX_HOST_SS_CPR_CLK_SET_TOP_NOC_MASK			BIT_MASK(1)
 #define VPU_37XX_HOST_SS_CPR_CLK_SET_DSS_MAS_MASK			BIT_MASK(10)
 #define VPU_37XX_HOST_SS_CPR_CLK_SET_MSS_MAS_MASK			BIT_MASK(11)
 
+#define VPU_40XX_HOST_SS_CPR_RST_EN					0x00000090u
+#define VPU_40XX_HOST_SS_CPR_RST_EN_TOP_NOC_MASK			BIT_MASK(1)
+#define VPU_40XX_HOST_SS_CPR_RST_EN_DSS_MAS_MASK			BIT_MASK(10)
+#define VPU_40XX_HOST_SS_CPR_RST_EN_CSS_MAS_MASK			BIT_MASK(11)
+
 #define VPU_37XX_HOST_SS_CPR_RST_SET					0x00000094u
 #define VPU_37XX_HOST_SS_CPR_RST_SET_TOP_NOC_MASK			BIT_MASK(1)
 #define VPU_37XX_HOST_SS_CPR_RST_SET_DSS_MAS_MASK			BIT_MASK(10)
@@ -29,6 +39,8 @@
 #define VPU_37XX_HOST_SS_HW_VERSION_SOC_NUMBER_MASK			GENMASK(15, 8)
 #define VPU_37XX_HOST_SS_HW_VERSION_VPU_GENERATION_MASK			GENMASK(23, 16)
 
+#define VPU_40XX_HOST_SS_SW_VERSION					0x0000010cu
+
 #define VPU_37XX_HOST_SS_GEN_CTRL					0x00000118u
 #define VPU_37XX_HOST_SS_GEN_CTRL_PS_MASK				GENMASK(31, 29)
 
@@ -44,14 +56,17 @@
 #define VPU_37XX_TOP_NOC_QREQN						0x00000160u
 #define VPU_37XX_TOP_NOC_QREQN_CPU_CTRL_MASK				BIT_MASK(0)
 #define VPU_37XX_TOP_NOC_QREQN_HOSTIF_L2CACHE_MASK			BIT_MASK(1)
+#define VPU_40XX_TOP_NOC_QREQN_HOSTIF_L2CACHE_MASK			BIT_MASK(2)
 
 #define VPU_37XX_TOP_NOC_QACCEPTN					0x00000164u
 #define VPU_37XX_TOP_NOC_QACCEPTN_CPU_CTRL_MASK				BIT_MASK(0)
 #define VPU_37XX_TOP_NOC_QACCEPTN_HOSTIF_L2CACHE_MASK			BIT_MASK(1)
+#define VPU_40XX_TOP_NOC_QACCEPTN_HOSTIF_L2CACHE_MASK			BIT_MASK(2)
 
 #define VPU_37XX_TOP_NOC_QDENY						0x00000168u
 #define VPU_37XX_TOP_NOC_QDENY_CPU_CTRL_MASK				BIT_MASK(0)
 #define VPU_37XX_TOP_NOC_QDENY_HOSTIF_L2CACHE_MASK			BIT_MASK(1)
+#define VPU_40XX_TOP_NOC_QDENY_HOSTIF_L2CACHE_MASK			BIT_MASK(2)
 
 #define VPU_37XX_HOST_SS_FW_SOC_IRQ_EN					0x00000170u
 #define VPU_37XX_HOST_SS_FW_SOC_IRQ_EN_CSS_ROM_CMX_MASK			BIT_MASK(0)
@@ -83,6 +98,7 @@
 #define VPU_37XX_HOST_SS_ICB_CLEAR_0					0x00010220u
 #define VPU_37XX_HOST_SS_ICB_CLEAR_1					0x00010224u
 #define VPU_37XX_HOST_SS_ICB_ENABLE_0					0x00010240u
+#define VPU_40XX_HOST_SS_ICB_ENABLE_1					0x00010244u
 
 #define VPU_37XX_HOST_SS_TIM_IPC_FIFO_ATM				0x000200f4u
 
@@ -104,12 +120,29 @@
 #define VPU_37XX_HOST_SS_AON_PWR_ISLAND_STATUS0				0x0003002cu
 #define VPU_37XX_HOST_SS_AON_PWR_ISLAND_STATUS0_MSS_CPU_MASK		BIT_MASK(3)
 
+#define VPU_50XX_HOST_SS_AON_PWR_ISLAND_EN_POST_DLY			0x00030068u
+#define VPU_50XX_HOST_SS_AON_PWR_ISLAND_EN_POST_DLY_POST_DLY_MASK	GENMASK(7, 0)
+#define VPU_50XX_HOST_SS_AON_PWR_ISLAND_EN_POST_DLY_POST1_DLY_MASK	GENMASK(15, 8)
+#define VPU_50XX_HOST_SS_AON_PWR_ISLAND_EN_POST_DLY_POST2_DLY_MASK	GENMASK(23, 16)
+
+#define VPU_50XX_HOST_SS_AON_PWR_ISLAND_STATUS_DLY			0x0003006cu
+#define VPU_50XX_HOST_SS_AON_PWR_ISLAND_STATUS_DLY_STATUS_DLY_MASK	GENMASK(7, 0)
+
 #define VPU_37XX_HOST_SS_AON_VPU_IDLE_GEN				0x00030200u
 #define VPU_37XX_HOST_SS_AON_VPU_IDLE_GEN_EN_MASK			BIT_MASK(0)
+#define VPU_40XX_HOST_SS_AON_VPU_IDLE_GEN_HW_PG_EN_MASK			BIT_MASK(1)
 
 #define VPU_37XX_HOST_SS_AON_DPU_ACTIVE					0x00030204u
 #define VPU_37XX_HOST_SS_AON_DPU_ACTIVE_DPU_ACTIVE_MASK			BIT_MASK(0)
 
+#define VPU_50XX_HOST_SS_AON_FABRIC_REQ_OVERRIDE			0x00030210u
+#define VPU_50XX_HOST_SS_AON_FABRIC_REQ_OVERRIDE_REQ_OVERRIDE_MASK      BIT_MASK(0)
+
+#define VPU_40XX_HOST_SS_VERIFICATION_ADDRESS_LO			0x00040040u
+#define VPU_40XX_HOST_SS_VERIFICATION_ADDRESS_LO_DONE_MASK		BIT_MASK(0)
+#define VPU_40XX_HOST_SS_VERIFICATION_ADDRESS_LO_IOSF_RS_ID_MASK	GENMASK(2, 1)
+#define VPU_40XX_HOST_SS_VERIFICATION_ADDRESS_LO_IMAGE_LOCATION_MASK	GENMASK(31, 3)
+
 #define VPU_37XX_HOST_SS_LOADING_ADDRESS_LO				0x00041040u
 #define VPU_37XX_HOST_SS_LOADING_ADDRESS_LO_DONE_MASK			BIT_MASK(0)
 #define VPU_37XX_HOST_SS_LOADING_ADDRESS_LO_IOSF_RS_ID_MASK		GENMASK(2, 1)
@@ -126,6 +159,9 @@
 #define VPU_37XX_HOST_IF_TCU_PTW_OVERRIDES_NOSNOOP_OVERRIDE_EN_MASK	BIT_MASK(3)
 #define VPU_37XX_HOST_IF_TCU_PTW_OVERRIDES_AW_NOSNOOP_OVERRIDE_MASK	BIT_MASK(4)
 #define VPU_37XX_HOST_IF_TCU_PTW_OVERRIDES_AR_NOSNOOP_OVERRIDE_MASK	BIT_MASK(5)
+#define VPU_40XX_HOST_IF_TCU_PTW_OVERRIDES_SNOOP_OVERRIDE_EN_MASK	BIT_MASK(3)
+#define VPU_40XX_HOST_IF_TCU_PTW_OVERRIDES_AW_SNOOP_OVERRIDE_MASK	BIT_MASK(4)
+#define VPU_40XX_HOST_IF_TCU_PTW_OVERRIDES_AR_SNOOP_OVERRIDE_MASK	BIT_MASK(5)
 #define VPU_37XX_HOST_IF_TCU_PTW_OVERRIDES_PTW_AW_CONTEXT_FLAG_MASK	GENMASK(10, 6)
 #define VPU_37XX_HOST_IF_TCU_PTW_OVERRIDES_PTW_AR_CONTEXT_FLAG_MASK	GENMASK(15, 11)
 
@@ -141,6 +177,17 @@
 #define VPU_37XX_HOST_IF_TBU_MMUSSIDV_TBU4_AWMMUSSIDV_MASK		BIT_MASK(8)
 #define VPU_37XX_HOST_IF_TBU_MMUSSIDV_TBU4_ARMMUSSIDV_MASK		BIT_MASK(9)
 
+#define VPU_40XX_CPU_SS_CPR_NOC_QREQN					0x01010030u
+#define VPU_40XX_CPU_SS_CPR_NOC_QREQN_TOP_MMIO_MASK			BIT_MASK(0)
+
+#define VPU_40XX_CPU_SS_CPR_NOC_QACCEPTN				0x01010034u
+#define VPU_40XX_CPU_SS_CPR_NOC_QACCEPTN_TOP_MMIO_MASK			BIT_MASK(0)
+
+#define VPU_40XX_CPU_SS_CPR_NOC_QDENY					0x01010038u
+#define VPU_40XX_CPU_SS_CPR_NOC_QDENY_TOP_MMIO_MASK			BIT_MASK(0)
+
+#define VPU_40XX_CPU_SS_TIM_PERF_EXT_FREE_CNT				0x01029008u
+
 #define VPU_37XX_CPU_SS_DSU_LEON_RT_BASE				0x04000000u
 #define VPU_37XX_CPU_SS_DSU_LEON_RT_DSU_CTRL				0x04000000u
 #define VPU_37XX_CPU_SS_DSU_LEON_RT_PC_REG				0x04400010u
@@ -161,18 +208,32 @@
 #define VPU_37XX_CPU_SS_MSSCPU_CPR_LEON_RT_VEC_IRQI_RSTVEC_MASK		GENMASK(31, 4)
 
 #define VPU_37XX_CPU_SS_TIM_WATCHDOG					0x0602009cu
+#define VPU_40XX_CPU_SS_TIM_WATCHDOG					0x0102009cu
+
 #define VPU_37XX_CPU_SS_TIM_WDOG_EN					0x060200a4u
+#define VPU_40XX_CPU_SS_TIM_WDOG_EN					0x010200a4u
+
 #define VPU_37XX_CPU_SS_TIM_SAFE					0x060200a8u
+#define VPU_40XX_CPU_SS_TIM_SAFE					0x010200a8u
+
 #define VPU_37XX_CPU_SS_TIM_IPC_FIFO					0x060200f0u
+#define VPU_40XX_CPU_SS_TIM_IPC_FIFO					0x010200f0u
 
 #define VPU_37XX_CPU_SS_TIM_GEN_CONFIG					0x06021008u
 #define VPU_37XX_CPU_SS_TIM_GEN_CONFIG_WDOG_TO_INT_CLR_MASK		BIT_MASK(9)
 
+#define VPU_40XX_CPU_SS_TIM_GEN_CONFIG					0x01021008u
+#define VPU_40XX_CPU_SS_TIM_GEN_CONFIG_WDOG_TO_INT_CLR_MASK		BIT_MASK(9)
+
 #define VPU_37XX_CPU_SS_TIM_PERF_FREE_CNT				0x06029000u
 
 #define VPU_37XX_CPU_SS_DOORBELL_0					0x06300000u
 #define VPU_37XX_CPU_SS_DOORBELL_0_SET_MASK				BIT_MASK(0)
 
+#define VPU_40XX_CPU_SS_DOORBELL_0					0x01300000u
+#define VPU_40XX_CPU_SS_DOORBELL_0_SET_MASK				BIT_MASK(0)
+
 #define VPU_37XX_CPU_SS_DOORBELL_1					0x06301000u
+#define VPU_40XX_CPU_SS_DOORBELL_1					0x01301000u
 
-#endif /* __IVPU_HW_37XX_REG_H__ */
+#endif /* __IVPU_HW_IP_REG_H__ */
-- 
2.43.0

