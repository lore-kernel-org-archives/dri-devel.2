Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC01606D65D
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 23:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=JZrTxFXu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A382210E8FC;
	Wed, 18 Nov 2026 23:32:55 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011068.outbound.protection.outlook.com [52.101.52.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6B9510E8FC
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 23:32:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SZIAZGTkdb28H0NNhrrDS+gojy/zin7qxv2GSIDp4OW3FRy8ZTjc9Vnn6odn31DhkfNyTb+Ee4ImTCFqugMA8kIPFe46mGTUxH9cZW9lAy0CJxsZMN242T6DYU3Mz7djucYG/CrjlYvlgc6CTFqyLOCFYF2+99g0UPQOEam/nUgjRWddRHJ4zDoEXeoI8yYhf+krd+2n7u0+G05oWdzqtJhFub3g6QXnTplunpY3sPF8GZChbKHujuj1yhXOWwaxey3k+Ee/fLnlsKGbCHUMZ8/+V0E/ZSZ6hvZjSbzuAxZLM2oqcXMHTuFxQUovWsSonYhWilEvmMaArIHCiK6kZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXPOd06jfP/XETgWuA0VtG6FUwnfDIG2ba1zJqzcOPA=;
 b=OQ4mEA+hRI28rKh2V7A6N52P2R+a8dgFiHXAUzwAxcFjoRamZ2w8Rvu9k30ftFaVFT9OD+q0AGaflRHvdhodjizGMvOK0Yxpp77qdFTo/JeqrdLudkNqHG24JSsnIVA2T05DzjRSUDkP/gMBTmhDqvNfqifkwrkSt8TOIJ3FEUsaxPT0b4eLunTh9bZR1Tk9SXg04o4+HIAN7qb6tq2q2R+SLnG6XO+qppP+qthPxcHLG0ATDjAYqRWeDrK1NVdC+0ghZ3yMo8nFECsxyBuotWpywXu91FHGLWPQv3ti5OhOrp3LWtN2sfv0nIfB4fOSPtLWS7pVdgdwzMrGryFasg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXPOd06jfP/XETgWuA0VtG6FUwnfDIG2ba1zJqzcOPA=;
 b=JZrTxFXuakscNrkmaW1s4QJMvJ/EHKnOvZFQLtgIAT0J5rDgOdITMOvR2S6xjxWEARcoqyDdKj0+SN3j4wmZXIY6T0sXkxyVU3qEfrzxvsW6TihhNudVBF4ebTUXGD/FOq/y8rYx51EMygB4XvmbHf0oPkaNLuJfm78NO7qeNdw=
Received: from CH0PR03CA0240.namprd03.prod.outlook.com (2603:10b6:610:e7::35)
 by SJ2PR12MB9210.namprd12.prod.outlook.com (2603:10b6:a03:561::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Wed, 18 Nov
 2026 23:32:37 +0000
Received: from CH3PEPF0002457D.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::53) by CH0PR03CA0240.outlook.office365.com
 (2603:10b6:610:e7::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Wed,
 18 Nov 2026 23:32:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0002457D.mail.protection.outlook.com (10.167.252.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 23:32:37 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 17:32:36 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 17:32:36 -0600
Received: from xsjgregoryw50.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via
 Frontend Transport; Wed, 18 Nov 2026 17:32:36 -0600
From: Gregory Williams <gregory.williams@amd.com>
To: Oded Gabbay <ogabbay@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
Subject: [PATCH 13/15] accel/amd-ai-engine: Add pm ops for firmware calls
Date: Wed, 18 Nov 2026 15:32:09 -0800
Message-ID: <20261118233211.4121361-14-gregory.williams@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118233211.4121361-1-gregory.williams@amd.com>
References: <20261118233211.4121361-1-gregory.williams@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0002457D:EE_|SJ2PR12MB9210:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cb1ce78-2a9b-40e1-2e77-08df45cc3ace
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|22082099003|18002099003|6133799003|3023799007|11063799006|5023799004|10067099003|261022105027099003|261026121527099003|261022075727099003|261028144727099003|261021121427099003|261021123027099003|56012099006|261009223027099003|261102123227099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: kQ2fHS9K0F+nGpJTZ4OeqHSSQUN1bg3UJjtrFsegCLDO6ZwyLYN23eifNwURArUiIVqrbut31/Gj7BUYNPBqxT1anE6coWOKBvVDyx099LVgjO+QA5RQiM0h+svxiUgJuRlkNJSuN3V9xpgbF49loFdTOIxBbd/gi6Lb44rO93B6RWlS93V9MKwjze6dHatTFMYxtaoLndBD6w1k9NnmPFGA7fUUN08QJ5uBo1DlcDQqb9ZKWZM/i71pARF5WicbapYfLOgeGSlLWtNhxvzyjINrBLZ1ruqApwiPOnC2hM4Jr9+CwLHKdJ0hT5+J7p9wu8VepPs44ZfIzKrqGbnLF021yx+TyKK5omL5aKkcN9vXF37UuT/pZ7mtm5K1jCxzGmehlNfOs4V+05AEaLLtxzo2LoD0QRgFdzOInuPOL8bxY1vIVZ7D3dtbNLxYRZhQ/oyThK5jQybKfcbNkQVShbm0BxUaAnTK86OqXNOqqxTaL9gDB94NVmuOfRO1OQp+zrsbaeFWPGkVcprsdaLGW645LEObV3MOvwh4VYa5Tdqik8EI/xnE09zlDGaKyQQDIzq7l5lu+2EobdBbv/G4wNa899U9VA4gnTL+CFCVmFxlKDeNaiukVXer03hxcAVpxmCUxyk984xRJHIRChpSfDNVWaFKlPMZtngCUWTK+2hHAU027TeVnTWkUmFJkVUSQUsTCZrxPvJSm6kSZWuuUg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(22082099003)(18002099003)(6133799003)(3023799007)(11063799006)(5023799004)(10067099003)(261022105027099003)(261026121527099003)(261022075727099003)(261028144727099003)(261021121427099003)(261021123027099003)(56012099006)(261009223027099003)(261102123227099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0Fup7iQbFYQFlorisD939QSffIbSIWr4hvs/H3IKWVuw+ugQmmZikRPdm4/M5EYU5mJhAwPn+mvEJIR2cIzY8NgeOdmshrydr6IM1Hr518SYRDhPYVOD/S+UuR75oV0ARN7iR5vvKiymJHtd73lcjVlr13fSKerLQvD2Qs9/gaWacN2g9y7seevwAJ/kk40kfvc/jB9+Aog+/lB+F+q4HzToAGCsthHMYlqUjQYOFKQQ7PS91M/uTTuAjnz2FjML5jB3AzTy+VcbXXWWXBVZR1sFX56dXm0N2n9xiSYY88+6beH6Ebz4VhIEGeUZ/k1UOL7zmmyCmPhegL3IVzSP4jbeVMM2doLzKx+HBhbdCd/D08mEDRL0Z8d6QTSyA0p4k2bAJNofMd/DFckN3y0Nm/GOOKXSZWAd+Syiypw5xL1a1xnWoBP5fMZCAezNmOMk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 23:32:37.1540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb1ce78-2a9b-40e1-2e77-08df45cc3ace
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0002457D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9210
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

The AI engine array has privileged registers that can only be written to
by the trusted firmware. The registers are critical for device
functionality such as, memory resets, column and shim resets, routing of
NoC traffic and interrupts, and enabling/disabling of tile clocks.

Structures are defined for each operation type which contain an
operation type, length, and operation specific parameters. The ops are
packed into a buffer and passed directly to the firmware which will
execute operations sequentially.

Signed-off-by: Gregory Williams <gregory.williams@amd.com>
---
 drivers/accel/amd-ai-engine/Makefile          |   1 +
 drivers/accel/amd-ai-engine/ai-engine-dev.c   |  13 +-
 .../accel/amd-ai-engine/ai-engine-internal.h  | 168 ++++++-
 drivers/accel/amd-ai-engine/ai-engine-part.c  |  17 +-
 drivers/accel/amd-ai-engine/ai-engine-pm.c    | 472 ++++++++++++++++++
 include/linux/amd-ai-engine.h                 |  53 +-
 6 files changed, 714 insertions(+), 10 deletions(-)
 create mode 100644 drivers/accel/amd-ai-engine/ai-engine-pm.c

diff --git a/drivers/accel/amd-ai-engine/Makefile b/drivers/accel/amd-ai-engine/Makefile
index cb456ee7ec37..8b0d857d3347 100644
--- a/drivers/accel/amd-ai-engine/Makefile
+++ b/drivers/accel/amd-ai-engine/Makefile
@@ -8,4 +8,5 @@ amd-aie-$(CONFIG_DRM_ACCEL_AMDAIE) := \
 	ai-engine-aiemlv2.o	\
 	ai-engine-dev.o		\
 	ai-engine-part.o	\
+	ai-engine-pm.o		\
 	ai-engine-res.o
diff --git a/drivers/accel/amd-ai-engine/ai-engine-dev.c b/drivers/accel/amd-ai-engine/ai-engine-dev.c
index 7dad3004e30a..8866d3cf6ed8 100644
--- a/drivers/accel/amd-ai-engine/ai-engine-dev.c
+++ b/drivers/accel/amd-ai-engine/ai-engine-dev.c
@@ -8,15 +8,19 @@
 #include <linux/amd-ai-engine.h>
 #include <linux/clk.h>
 #include <linux/device.h>
+#include <linux/dma-mapping.h>
 #include <linux/io.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 
 #include "ai-engine-internal.h"
 
+#define AIE_DMA_BIT_MASK 48
+
 /**
  * aie_partition_request() - Request an AI engine partition
  * @dev: AI engine device pointer
@@ -115,8 +119,15 @@ static int amd_ai_engine_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	/* setup device layout configuration */
+	/* setup dma */
 	adev->dev = &pdev->dev;
+	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(AIE_DMA_BIT_MASK));
+	if (ret) {
+		dev_err(adev->dev, "Failed to set dma mask\n");
+		return ret;
+	}
+
+	/* setup device layout configuration */
 	adev->range.start.col = 0;
 	adev->range.size.col = match->num_columns;
 	adev->range.start.row = 0;
diff --git a/drivers/accel/amd-ai-engine/ai-engine-internal.h b/drivers/accel/amd-ai-engine/ai-engine-internal.h
index 61ebd7f4b3d1..d2857ec50033 100644
--- a/drivers/accel/amd-ai-engine/ai-engine-internal.h
+++ b/drivers/accel/amd-ai-engine/ai-engine-internal.h
@@ -74,6 +74,166 @@ struct aie_tile_attr {
 	u8 num_rows;
 };
 
+/**
+ * struct aie_op_start_num_col - start/number of columns op
+ * @type: operation type
+ * @len: operation struct length
+ * @start_col: start column
+ * @num_col: number of columns
+ */
+struct aie_op_start_num_col {
+	u16 type;
+	u16 len;
+	u16 start_col;
+	u16 num_col;
+} __aligned(4);
+
+/**
+ * struct aie_op_l2_ctrl_irq - l2 control irq ops
+ * @type: operation type.
+ * @len: length of the op
+ * @irq: irq value to be written to l2
+ */
+struct  aie_op_l2_ctrl_irq {
+	u16 type;
+	u16 len;
+	u16 irq;
+} __aligned(4);
+
+/**
+ * struct aie_op_type_len - op that just needs type
+ * @type: operation type
+ * @len: length of the op
+ */
+struct aie_op_type_len {
+	u16 type;
+	u16 len;
+} __aligned(4);
+
+/**
+ * struct aie_op_hw_err - hardware error op
+ * @type: operation type
+ * @len: length of the op
+ * @val: value of hardware interrupt mask or irq number
+ */
+struct aie_op_hw_err {
+	u16 type;
+	u16 len;
+	u16 val;
+} __aligned(4);
+
+/**
+ * struct aie_op_uc_zeroisation - zeroize uc memory op
+ * @type: operation type
+ * @len: length of the op
+ * @flag: flag contains the following data:
+ *	  bit(2) - zeroize uc data memory
+ *	  bit(1) - zeroize uc private data memory
+ *	  bit(0) - zeroize uc program memory
+ */
+struct aie_op_uc_zeroisation {
+	u16 type;
+	u16 len;
+	u16 flag;
+} __aligned(4);
+
+/**
+ * struct aie_op_handshake - set handshake region op
+ * @type: operation type
+ * @len: length of the op
+ * @offset: handshake region offset
+ * @high_addr: high part of physical address of buffer with handshake data
+ * @low_addr: low part of physical address of buffer with handshake data
+ */
+struct aie_op_handshake {
+	u16 type;
+	u16 len;
+	u32 offset;
+	u32 high_addr;
+	u32 low_addr;
+} __aligned(4);
+
+/**
+ * struct aie_op_nmu_switch - nmu switch ops
+ * @type: operation type
+ * @len: length of the op
+ * @c0_route: where to route nmu data in col 0
+ * @c1_route: where to route nmu data in col 1
+ */
+struct aie_op_nmu_switch {
+	u16 type;
+	u16 len;
+	u16 c0_route;
+	u16 c1_route;
+} __aligned(4);
+
+/**
+ * struct aie_op_aximm_isolation - set axi isolation ops
+ * @type: operation type
+ * @len: length of the op
+ * @traffic: value to write to axi isolation register
+ */
+struct aie_op_aximm_isolation {
+	u16 type;
+	u16 len;
+	u16 traffic;
+} __aligned(4);
+
+/**
+ * struct aie_op_ecc_scrub_period - set ecc scrub period op
+ * @type: operation type
+ * @len: length of the op
+ * @scrub_period: ECC scrub period
+ */
+struct aie_op_ecc_scrub_period {
+	u16 type;
+	u16 len;
+	u16 scrub_period;
+} __aligned(4);
+
+/**
+ * struct aie_op_tlast - tlast errors op
+ * @type: operation type
+ * @len: length of the op
+ * @state: state of the op
+ */
+struct aie_op_tlast {
+	u16 type;
+	u16 len;
+	u16 state;
+} __aligned(4);
+
+/**
+ * struct aie_pm_ops - AI engine pm calls struct.
+ * @pkt_va: pm ops data virtual address.
+ * @pkt_dma: pm ops data dma address.
+ * @size: size of pkt_va.
+ * @offset: offset within pkt_va;
+ * @op_range: pointer to pkt_va for latest range. All op headers added at offset
+ *	      will be for this range.
+ */
+struct aie_pm_ops {
+	void *pkt_va;
+	dma_addr_t pkt_dma;
+	size_t size;
+	size_t offset;
+	struct aie_op_start_num_col *op_range;
+};
+
+/**
+ * struct aie_op_handshake_addr - AI engine handshake region
+ * @hs_va: virtual address of handshake buffer
+ * @size: size of buffer.
+ * @offset: offset into buffer;
+ * @hs_dma: dma address of handshake buffer
+ */
+struct aie_op_handshake_addr {
+	void *hs_va;
+	size_t size;
+	size_t offset;
+	dma_addr_t hs_dma;
+};
+
 /**
  * struct aie_device - AI engine device structure
  * @partitions: list of partitions
@@ -116,6 +276,7 @@ struct aie_device {
  * @adev: pointer to AI device instance
  * @range: range of partition
  * @mlock: protection for AI engine partition operations
+ * @pm_ops: pm ops pkt and metadata for pm firmware calls
  */
 struct aie_partition {
 	struct list_head node;
@@ -123,6 +284,7 @@ struct aie_partition {
 	struct aie_device *adev;
 	struct aie_range range;
 	struct mutex mlock;
+	struct aie_pm_ops pm_ops;
 };
 
 /**
@@ -156,5 +318,9 @@ int aie_resource_check_region(struct aie_resource *res, u32 start,
 int aie_resource_get_region(struct aie_resource *res, u32 start,
 			    u32 count);
 void aie_resource_put_region(struct aie_resource *res, int start, u32 count);
-
+int aie_part_pm_ops_create(struct aie_partition *apart);
+void aie_part_pm_ops_destroy(struct aie_partition *apart);
+int aie_part_pm_ops_flush(struct aie_partition *apart);
+int aie_part_pm_ops(struct aie_partition *apart, void *data, u32 type,
+		    struct aie_range range, bool flush);
 #endif /* AIE_INTERNAL_H */
diff --git a/drivers/accel/amd-ai-engine/ai-engine-part.c b/drivers/accel/amd-ai-engine/ai-engine-part.c
index f80a6fa433aa..51580049f0e7 100644
--- a/drivers/accel/amd-ai-engine/ai-engine-part.c
+++ b/drivers/accel/amd-ai-engine/ai-engine-part.c
@@ -21,6 +21,7 @@ void aie_part_release(struct aie_partition *apart)
 	struct aie_device *adev = apart->adev;
 
 	list_del(&apart->node);
+	aie_part_pm_ops_destroy(apart);
 	aie_resource_put_region(&adev->cols_res,
 				apart->range.start.col -
 				adev->range.start.col,
@@ -47,6 +48,7 @@ struct aie_partition *aie_part_create(struct aie_device *adev,
 {
 	struct aie_partition *apart;
 	struct device *dev;
+	int ret;
 
 	apart = devm_kzalloc(adev->dev, sizeof(*apart), GFP_KERNEL);
 	if (!apart)
@@ -67,11 +69,22 @@ struct aie_partition *aie_part_create(struct aie_device *adev,
 	dev_set_drvdata(dev, apart);
 	dev->release = aie_part_release_device;
 
-	if (device_register(&apart->dev)) {
+	ret = device_register(&apart->dev);
+	if (ret) {
 		dev_err(adev->dev, "failed to register partition device\n");
 		put_device(dev);
-		return ERR_PTR(-ENODEV);
+		return ERR_PTR(ret);
+	}
+
+	ret = aie_part_pm_ops_create(apart);
+	if (ret) {
+		dev_err(&apart->dev, "failed to create pm ops buffer\n");
+		goto err;
 	}
 
 	return apart;
+
+err:
+	device_unregister(&apart->dev);
+	return ERR_PTR(ret);
 }
diff --git a/drivers/accel/amd-ai-engine/ai-engine-pm.c b/drivers/accel/amd-ai-engine/ai-engine-pm.c
new file mode 100644
index 000000000000..103879456f52
--- /dev/null
+++ b/drivers/accel/amd-ai-engine/ai-engine-pm.c
@@ -0,0 +1,472 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AMD AI Engine driver platform management implementations
+ *
+ * Copyright (C) 2026 Advanced Micro Devices, Inc.
+ */
+
+#include "ai-engine-internal.h"
+
+#include <linux/dma-mapping.h>
+#include <linux/firmware/xlnx-zynqmp.h>
+
+#define AIE_PM_OPS_PKT_SIZE	200
+
+int aie_part_pm_ops_create(struct aie_partition *apart)
+{
+	struct aie_pm_ops *pm_ops = &apart->pm_ops;
+
+	if (apart->adev->dev_gen != AIE_DEVICE_GEN_AIEMLV2)
+		return 0;
+
+	pm_ops->pkt_va = dma_alloc_coherent(apart->adev->dev,
+					    AIE_PM_OPS_PKT_SIZE,
+					    &pm_ops->pkt_dma, GFP_KERNEL);
+	if (!pm_ops->pkt_va)
+		return -ENOMEM;
+
+	pm_ops->size = AIE_PM_OPS_PKT_SIZE;
+	return 0;
+}
+
+void aie_part_pm_ops_destroy(struct aie_partition *apart)
+{
+	struct aie_pm_ops *pm_ops = &apart->pm_ops;
+
+	if (pm_ops->pkt_va)
+		dma_free_coherent(apart->adev->dev, pm_ops->size,
+				  pm_ops->pkt_va, pm_ops->pkt_dma);
+
+	pm_ops->pkt_va = NULL;
+}
+
+int aie_part_pm_ops_flush(struct aie_partition *apart)
+{
+	struct aie_pm_ops *pm_ops = &apart->pm_ops;
+	int ret = 0;
+
+	/*
+	 * If the last thing queued is a range header with no op after it,
+	 * drop it: firmware has nothing to do for that range.
+	 */
+	if (pm_ops->op_range &&
+	    pm_ops->offset == (size_t)((u8 *)pm_ops->op_range -
+				       (u8 *)pm_ops->pkt_va) +
+			      sizeof(*pm_ops->op_range))
+		pm_ops->offset -= sizeof(*pm_ops->op_range);
+
+	if (pm_ops->offset)
+		ret = versal2_pm_aie2ps_operation(apart->adev->fw_dev_id,
+						  pm_ops->offset,
+						  upper_32_bits(pm_ops->pkt_dma),
+						  lower_32_bits(pm_ops->pkt_dma));
+
+	pm_ops->offset = 0;
+	pm_ops->op_range = NULL;
+	memset(pm_ops->pkt_va, 0, AIE_PM_OPS_PKT_SIZE);
+
+	return ret;
+}
+
+int aie_part_pm_ops(struct aie_partition *apart, void *data, u32 type,
+		    struct aie_range range, bool flush)
+{
+	struct aie_pm_ops *pm_ops = &apart->pm_ops;
+	struct aie_op_start_num_col *op_range;
+	ssize_t end;
+	int ret = 0;
+
+again:
+	op_range = pm_ops->op_range;
+	if (!op_range ||
+	    op_range->num_col != range.size.col ||
+	    op_range->start_col != range.start.col) {
+		if (check_add_overflow(pm_ops->offset, sizeof(*op_range), &end) ||
+		    end >= pm_ops->size) {
+			ret = aie_part_pm_ops_flush(apart);
+			if (ret)
+				return ret;
+		}
+		pm_ops->op_range = pm_ops->pkt_va + pm_ops->offset;
+		pm_ops->offset += sizeof(*pm_ops->op_range);
+		op_range = pm_ops->op_range;
+		op_range->type = XILINX_AIE_OPS_START_NUM_COL;
+		op_range->start_col = range.start.col;
+		op_range->num_col = range.size.col;
+		op_range->len = sizeof(*op_range);
+	}
+
+	if (type & AIE_PART_INIT_OPT_COLUMN_RST) {
+		struct aie_op_type_len *op;
+
+		if (check_add_overflow(pm_ops->offset, sizeof(*op), &end) ||
+		    end >= pm_ops->size) {
+			ret = aie_part_pm_ops_flush(apart);
+			if (ret)
+				return ret;
+			goto again;
+		}
+		type &= ~AIE_PART_INIT_OPT_COLUMN_RST;
+		op = pm_ops->pkt_va + pm_ops->offset;
+		pm_ops->offset += sizeof(*op);
+		op->type = XILINX_AIE_OPS_COL_RST;
+		op->len = sizeof(*op);
+	}
+	if (type & AIE_PART_INIT_OPT_SHIM_RST) {
+		struct aie_op_type_len *op;
+
+		if (check_add_overflow(pm_ops->offset, sizeof(*op), &end) ||
+		    end >= pm_ops->size) {
+			ret = aie_part_pm_ops_flush(apart);
+			if (ret)
+				return ret;
+			goto again;
+		}
+		type &= ~AIE_PART_INIT_OPT_SHIM_RST;
+		op = pm_ops->pkt_va + pm_ops->offset;
+		pm_ops->offset += sizeof(*op);
+		op->type = XILINX_AIE_OPS_SHIM_RST;
+		op->len = sizeof(*op);
+	}
+	if (type & AIE_PART_INIT_OPT_BLOCK_NOCAXIMMERR) {
+		struct aie_op_type_len *op;
+
+		if (check_add_overflow(pm_ops->offset, sizeof(*op), &end) ||
+		    end >= pm_ops->size) {
+			ret = aie_part_pm_ops_flush(apart);
+			if (ret)
+				return ret;
+			goto again;
+		}
+		type &= ~AIE_PART_INIT_OPT_BLOCK_NOCAXIMMERR;
+		op = pm_ops->pkt_va + pm_ops->offset;
+		pm_ops->offset += sizeof(*op);
+		op->type = XILINX_AIE_OPS_ENB_AXI_MM_ERR_EVENT;
+		op->len = sizeof(*op);
+	}
+	if (type & AIE_PART_INIT_OPT_ENB_COLCLK_BUFF) {
+		struct aie_op_type_len *op;
+
+		if (check_add_overflow(pm_ops->offset, sizeof(*op), &end) ||
+		    end >= pm_ops->size) {
+			ret = aie_part_pm_ops_flush(apart);
+			if (ret)
+				return ret;
+			goto again;
+		}
+		type &= ~AIE_PART_INIT_OPT_ENB_COLCLK_BUFF;
+		op = pm_ops->pkt_va + pm_ops->offset;
+		pm_ops->offset += sizeof(*op);
+		op->type = XILINX_AIE_OPS_ENB_COL_CLK_BUFF;
+		op->len = sizeof(*op);
+	}
+	if (type & AIE_PART_INIT_OPT_DIS_COLCLK_BUFF) {
+		struct aie_op_type_len *op;
+
+		if (check_add_overflow(pm_ops->offset, sizeof(*op), &end) ||
+		    end >= pm_ops->size) {
+			ret = aie_part_pm_ops_flush(apart);
+			if (ret)
+				return ret;
+			goto again;
+		}
+		type &= ~AIE_PART_INIT_OPT_DIS_COLCLK_BUFF;
+		op = pm_ops->pkt_va + pm_ops->offset;
+		pm_ops->offset += sizeof(*op);
+		op->type = XILINX_AIE_OPS_DIS_COL_CLK_BUFF;
+		op->len = sizeof(*op);
+	}
+	if (type & AIE_PART_INIT_OPT_ZEROIZEMEM) {
+		struct aie_op_type_len *op;
+
+		if (check_add_overflow(pm_ops->offset, sizeof(*op), &end) ||
+		    end >= pm_ops->size) {
+			ret = aie_part_pm_ops_flush(apart);
+			if (ret)
+				return ret;
+			goto again;
+		}
+		type &= ~AIE_PART_INIT_OPT_ZEROIZEMEM;
+		op = pm_ops->pkt_va + pm_ops->offset;
+		pm_ops->offset += sizeof(*op);
+		op->type = XILINX_AIE_OPS_ZEROISATION;
+		op->len = sizeof(*op);
+	}
+	if (type & AIE_PART_INIT_OPT_UC_ENB_MEM_PRIV) {
+		struct aie_op_type_len *op;
+
+		if (check_add_overflow(pm_ops->offset, sizeof(*op), &end) ||
+		    end >= pm_ops->size) {
+			ret = aie_part_pm_ops_flush(apart);
+			if (ret)
+				return ret;
+			goto again;
+		}
+		type &= ~AIE_PART_INIT_OPT_UC_ENB_MEM_PRIV;
+		op = pm_ops->pkt_va + pm_ops->offset;
+		pm_ops->offset += sizeof(*op);
+		op->type = XILINX_AIE_OPS_ENB_MEM_PRIV;
+		op->len = sizeof(*op);
+	}
+	if (type & AIE_PART_INIT_OPT_UC_DIS_MEM_PRIV) {
+		struct aie_op_type_len *op;
+
+		if (check_add_overflow(pm_ops->offset, sizeof(*op), &end) ||
+		    end >= pm_ops->size) {
+			ret = aie_part_pm_ops_flush(apart);
+			if (ret)
+				return ret;
+			goto again;
+		}
+		type &= ~AIE_PART_INIT_OPT_UC_DIS_MEM_PRIV;
+		op = pm_ops->pkt_va + pm_ops->offset;
+		pm_ops->offset += sizeof(*op);
+		op->type = XILINX_AIE_OPS_DIS_MEM_PRIV;
+		op->len = sizeof(*op);
+	}
+	if (type & AIE_PART_INIT_OPT_ENB_NOC_DMA_PAUSE) {
+		struct aie_op_type_len *op;
+
+		if (check_add_overflow(pm_ops->offset, sizeof(*op), &end) ||
+		    end >= pm_ops->size) {
+			ret = aie_part_pm_ops_flush(apart);
+			if (ret)
+				return ret;
+			goto again;
+		}
+		type &= ~AIE_PART_INIT_OPT_ENB_NOC_DMA_PAUSE;
+		op = pm_ops->pkt_va + pm_ops->offset;
+		pm_ops->offset += sizeof(*op);
+		op->type = XILINX_AIE_OPS_ENB_NOC_DMA_PAUSE;
+		op->len = sizeof(*op);
+	}
+	if (type & AIE_PART_INIT_OPT_ENB_UC_DMA_PAUSE) {
+		struct aie_op_type_len *op;
+
+		if (check_add_overflow(pm_ops->offset, sizeof(*op), &end) ||
+		    end >= pm_ops->size) {
+			ret = aie_part_pm_ops_flush(apart);
+			if (ret)
+				return ret;
+			goto again;
+		}
+		type &= ~AIE_PART_INIT_OPT_ENB_UC_DMA_PAUSE;
+		op = pm_ops->pkt_va + pm_ops->offset;
+		pm_ops->offset += sizeof(*op);
+		op->type = XILINX_AIE_OPS_ENB_UC_DMA_PAUSE;
+		op->len = sizeof(*op);
+	}
+	if (type & AIE_PART_INIT_OPT_DIS_MEM_INTERLEAVE) {
+		struct aie_op_type_len *op;
+
+		if (check_add_overflow(pm_ops->offset, sizeof(*op), &end) ||
+		    end >= pm_ops->size) {
+			ret = aie_part_pm_ops_flush(apart);
+			if (ret)
+				return ret;
+			goto again;
+		}
+		type &= ~AIE_PART_INIT_OPT_DIS_MEM_INTERLEAVE;
+		op = pm_ops->pkt_va + pm_ops->offset;
+		pm_ops->offset += sizeof(*op);
+		op->type = XILINX_AIE_OPS_DIS_MEM_INTERLEAVE;
+		op->len = sizeof(*op);
+	}
+	if (type & AIE_PART_INIT_OPT_UC_ZEROIZATION) {
+		struct aie_op_uc_zeroisation *op;
+
+		if (check_add_overflow(pm_ops->offset, sizeof(*op), &end) ||
+		    end >= pm_ops->size) {
+			ret = aie_part_pm_ops_flush(apart);
+			if (ret)
+				return ret;
+			goto again;
+		}
+		type &= ~AIE_PART_INIT_OPT_UC_ZEROIZATION;
+		op = pm_ops->pkt_va + pm_ops->offset;
+		pm_ops->offset += sizeof(*op);
+		op->type = XILINX_AIE_OPS_UC_ZEROIZATION;
+		op->len = sizeof(*op);
+		op->flag = *((u16 *)data);
+	}
+	if (type & AIE_PART_INIT_OPT_ISOLATE) {
+		struct aie_op_aximm_isolation *op;
+
+		if (check_add_overflow(pm_ops->offset, sizeof(*op), &end) ||
+		    end >= pm_ops->size) {
+			ret = aie_part_pm_ops_flush(apart);
+			if (ret)
+				return ret;
+			goto again;
+		}
+		type &= ~AIE_PART_INIT_OPT_ISOLATE;
+		op = pm_ops->pkt_va + pm_ops->offset;
+		pm_ops->offset += sizeof(*op);
+		op->type = XILINX_AIE_OPS_AXIMM_ISOLATION;
+		op->len = sizeof(*op);
+		op->traffic = *((u16 *)data);
+	}
+	if (type & AIE_PART_INIT_OPT_SET_L2_IRQ) {
+		struct aie_op_l2_ctrl_irq *op;
+
+		if (check_add_overflow(pm_ops->offset, sizeof(*op), &end) ||
+		    end >= pm_ops->size) {
+			ret = aie_part_pm_ops_flush(apart);
+			if (ret)
+				return ret;
+			goto again;
+		}
+		type &= ~AIE_PART_INIT_OPT_SET_L2_IRQ;
+		op = pm_ops->pkt_va + pm_ops->offset;
+		pm_ops->offset += sizeof(*op);
+		op->type = XILINX_AIE_OPS_SET_L2_CTRL_NPI_INTR;
+		op->len = sizeof(*op);
+		op->irq = *((u16 *)data);
+	}
+	if (type & AIE_PART_INIT_OPT_NMU_CONFIG) {
+		struct aie_op_nmu_switch *op;
+
+		if (check_add_overflow(pm_ops->offset, sizeof(*op), &end) ||
+		    end >= pm_ops->size) {
+			ret = aie_part_pm_ops_flush(apart);
+			if (ret)
+				return ret;
+			goto again;
+		}
+		type &= ~AIE_PART_INIT_OPT_NMU_CONFIG;
+		op = pm_ops->pkt_va + pm_ops->offset;
+		pm_ops->offset += sizeof(*op);
+		op->type = XILINX_AIE_OPS_NMU_CONFIG;
+		op->len = sizeof(*op);
+		/*
+		 * Configure col0 to route data to east neighbor
+		 * Configure col1 to accept data from west neighbor
+		 */
+		op->c0_route = 0x1;
+		op->c1_route = 0x2;
+	}
+	if (type & AIE_PART_INIT_OPT_HW_ERR_INT) {
+		struct aie_op_hw_err *op;
+
+		if (check_add_overflow(pm_ops->offset, sizeof(*op), &end) ||
+		    end >= pm_ops->size) {
+			ret = aie_part_pm_ops_flush(apart);
+			if (ret)
+				return ret;
+			goto again;
+		}
+		type &= ~AIE_PART_INIT_OPT_HW_ERR_INT;
+		op = pm_ops->pkt_va + pm_ops->offset;
+		pm_ops->offset += sizeof(*op);
+		op->type = XILINX_AIE_OPS_HW_ERR_INT;
+		op->len = sizeof(*op);
+		op->val = *((u16 *)data);
+	}
+	if (type & AIE_PART_INIT_OPT_HW_ERR_MASK) {
+		struct aie_op_hw_err *op;
+
+		if (check_add_overflow(pm_ops->offset, sizeof(*op), &end) ||
+		    end >= pm_ops->size) {
+			ret = aie_part_pm_ops_flush(apart);
+			if (ret)
+				return ret;
+			goto again;
+		}
+		type &= ~AIE_PART_INIT_OPT_HW_ERR_MASK;
+		op = pm_ops->pkt_va + pm_ops->offset;
+		pm_ops->offset += sizeof(*op);
+		op->type = XILINX_AIE_OPS_HW_ERR_MASK;
+		op->len = sizeof(*op);
+		op->val = *((u16 *)data);
+	}
+	if (type & AIE_PART_INIT_OPT_SET_ECC_SCRUB_PERIOD) {
+		struct aie_op_ecc_scrub_period *op;
+
+		if (check_add_overflow(pm_ops->offset, sizeof(*op), &end) ||
+		    end >= pm_ops->size) {
+			ret = aie_part_pm_ops_flush(apart);
+			if (ret)
+				return ret;
+			goto again;
+		}
+		type &= ~AIE_PART_INIT_OPT_SET_ECC_SCRUB_PERIOD;
+		op = pm_ops->pkt_va + pm_ops->offset;
+		pm_ops->offset += sizeof(*op);
+		op->type = XILINX_AIE_OPS_SET_ECC_SCRUB_PERIOD;
+		op->len = sizeof(*op);
+		op->scrub_period = *((u16 *)data);
+	}
+	if (type & AIE_PART_INIT_OPT_HW_ERR_STS) {
+		struct aie_op_hw_err *op;
+
+		if (check_add_overflow(pm_ops->offset, sizeof(*op), &end) ||
+		    end >= pm_ops->size) {
+			ret = aie_part_pm_ops_flush(apart);
+			if (ret)
+				return ret;
+			goto again;
+		}
+		type &= ~AIE_PART_INIT_OPT_HW_ERR_STS;
+		op = pm_ops->pkt_va + pm_ops->offset;
+		pm_ops->offset += sizeof(*op);
+		op->type = XILINX_AIE_OPS_CLR_HW_ERR_STS;
+		op->len = sizeof(*op);
+		op->val = *((u16 *)data);
+		ret = aie_part_pm_ops_flush(apart);
+		if (ret)
+			return ret;
+		goto again;
+	}
+	if (type & AIE_PART_INIT_OPT_DIS_TLAST_ERROR) {
+		struct aie_op_tlast *op;
+
+		if (check_add_overflow(pm_ops->offset, sizeof(*op), &end) ||
+		    end >= pm_ops->size) {
+			ret = aie_part_pm_ops_flush(apart);
+			if (ret)
+				return ret;
+			goto again;
+		}
+		type &= ~AIE_PART_INIT_OPT_DIS_TLAST_ERROR;
+		op = pm_ops->pkt_va + pm_ops->offset;
+		pm_ops->offset += sizeof(*op);
+		op->type = XILINX_AIE_OPS_CTRL_PKT_TLAST_ERR;
+		op->len = sizeof(*op);
+		op->state = *((u16 *)data);
+	}
+	if (type & AIE_PART_INIT_OPT_HANDSHAKE) {
+		struct aie_op_handshake *op;
+		struct aie_op_handshake_addr *hs_addr = data;
+
+		if (check_add_overflow(pm_ops->offset, sizeof(*op), &end) ||
+		    end >= pm_ops->size) {
+			ret = aie_part_pm_ops_flush(apart);
+			if (ret)
+				return ret;
+			goto again;
+		}
+
+		type &= ~AIE_PART_INIT_OPT_HANDSHAKE;
+		op = pm_ops->pkt_va + pm_ops->offset;
+		pm_ops->offset += sizeof(*op);
+		op->type = XILINX_AIE_OPS_HANDSHAKE;
+		op->len = sizeof(*op) + hs_addr->size;
+		op->offset = hs_addr->offset;
+		op->low_addr = hs_addr->hs_dma & 0xFFFFFFFFULL;
+		op->high_addr = hs_addr->hs_dma >> 32;
+		if (flush)
+			ret = aie_part_pm_ops_flush(apart);
+
+		if (ret)
+			return ret;
+		goto again;
+	}
+
+	if (type)
+		dev_warn(&apart->dev, "Unknown ops type: 0x%x\n", type);
+
+	if (flush)
+		ret = aie_part_pm_ops_flush(apart);
+
+	return ret;
+}
diff --git a/include/linux/amd-ai-engine.h b/include/linux/amd-ai-engine.h
index f5750d219e21..9df3463985af 100644
--- a/include/linux/amd-ai-engine.h
+++ b/include/linux/amd-ai-engine.h
@@ -12,6 +12,16 @@
 #include <linux/list.h>
 #include <linux/mutex.h>
 
+/**
+ * struct aie_location - AIE location information
+ * @col: column id
+ * @row: row id
+ */
+struct aie_location {
+	u32 col;
+	u32 row;
+};
+
 #define AIE_PART_ID_START_COL_SHIFT	0U
 #define AIE_PART_ID_NUM_COLS_SHIFT	8U
 #define AIE_PART_ID_START_COL_MASK	(0xFFU << AIE_PART_ID_START_COL_SHIFT)
@@ -43,14 +53,45 @@ struct aie_partition_req {
 	u32 flag;
 };
 
+/*
+ * AI engine partition initialize options
+ */
+#define AIE_PART_INIT_OPT_START_NUM_COL		0U
+#define AIE_PART_INIT_OPT_COLUMN_RST		BIT(0)
+#define AIE_PART_INIT_OPT_SHIM_RST		BIT(1)
+#define AIE_PART_INIT_OPT_BLOCK_NOCAXIMMERR	BIT(2)
+#define AIE_PART_INIT_OPT_ISOLATE		BIT(3)
+#define AIE_PART_INIT_OPT_ZEROIZEMEM		BIT(4)
+#define AIE_PART_INIT_OPT_UC_ENB_MEM_PRIV	BIT(5)
+#define AIE_PART_INIT_ERROR_HANDLING		BIT(6)
+#define AIE_PART_INIT_OPT_DIS_COLCLK_BUFF	BIT(7)
+#define AIE_PART_INIT_OPT_SET_L2_IRQ		BIT(8)
+#define AIE_PART_INIT_OPT_HW_ERR_INT		BIT(9)
+#define AIE_PART_INIT_OPT_HW_ERR_MASK		BIT(10)
+#define AIE_PART_INIT_OPT_SET_ECC_SCRUB_PERIOD	BIT(11)
+#define AIE_PART_INIT_OPT_NMU_CONFIG		BIT(12)
+#define AIE_PART_INIT_OPT_ENB_COLCLK_BUFF	BIT(13)
+#define AIE_PART_INIT_OPT_UC_ZEROIZATION	BIT(14)
+#define AIE_PART_INIT_OPT_UC_DIS_MEM_PRIV	BIT(15)
+#define AIE_PART_INIT_OPT_ENB_NOC_DMA_PAUSE	BIT(16)
+#define AIE_PART_INIT_OPT_ENB_UC_DMA_PAUSE	BIT(17)
+#define AIE_PART_INIT_OPT_HW_ERR_STS		BIT(18)
+#define AIE_PART_INIT_OPT_DIS_MEM_INTERLEAVE	BIT(19)
+#define AIE_PART_INIT_OPT_HANDSHAKE		BIT(20)
+#define AIE_PART_INIT_OPT_DIS_TLAST_ERROR	BIT(21)
+#define AIE_PART_INIT_OPT_EN_TLAST_ERROR	BIT(22)
+
 /**
- * struct aie_location - AIE location information
- * @col: column id
- * @row: row id
+ * struct aie_op_handshake_data - AI engine uc handshake region information
+ * @addr: handshake data address from where the data needs to be copied.
+ * @size: handshake data size.
+ * @offset: offset for handshake region update.
  */
-struct aie_location {
-	u32 col;
-	u32 row;
+struct aie_op_handshake_data {
+	void *addr;
+	size_t size;
+	size_t offset;
+	struct aie_location loc;
 };
 
 struct device *aie_partition_request(struct device *dev, struct aie_partition_req *req);
-- 
2.34.1

