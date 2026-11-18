Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46FA60A2600
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 23:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3ZmybCcD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7B1610ECD0;
	Wed, 18 Nov 2026 23:33:07 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012032.outbound.protection.outlook.com [40.107.209.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 375A810E8FC
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 23:32:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KawIr8dmJK/YzVmt6qS9VsJkKeewQxq9WQ93rvGAzTUJay7/aZuzFSwiFWLGnvTHpdtrS3deoUur6Dr/y7AVjNyGGEeEvkaZlkZ9Yf/eyKn8r0nM/wG40XKNVVnyAt8iHFmfMBVxvs6l38I2jNqZnZolHnzvYTU93UvmHJer3D2vxdZIGwFgtWuDWiMgTUMMyZ5opvib+Aie8QyB09s8Zq+m7P9y/tYdcIyq4++KLHeEk/GUguz7VFoSckzJgtitL7uZUkxHMwcOZEV/B9/2uYthzfhIg7u0+IsZm8YaFChQMHr8talAYoHvoEnMTrEDJGmYSwWMWoadC5zga0iIaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qpxVLapIkNPfrph8ijihUA4vpC9xwkryfWf+cqA6XWs=;
 b=lv7mVp+y9q8kBn4bMsSbU9ZxywymbVkjR78c6jnez+AmTOgLTmBCQKyF6EjmYkKS+trQRgQiDkI6LMC3ikUw9VTpx6u74Cub+uAbPuUa/yn56TcN7RC0+P+LPZ2Ml50Ykcsn6d6xqN6LZ571EnMF4zPx9ovyiYLk8A1SOTIyqQTXTHosFrvYIW7y3FeKUmT9xm0YBIQYpPTKdR6qFYnLXSp6KrW9VtpG+jvR/shY1o8nHTsh9LCehAIW7C77mMLG9Hi2jEMeyVRQNtX8AjSywelJMd3CTti5Jzaixpb0lGgTDex9T8QhHevPKktTY9vqci7JbeYV32l5yFUhWP/cEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpxVLapIkNPfrph8ijihUA4vpC9xwkryfWf+cqA6XWs=;
 b=3ZmybCcDAE53x1418OtlXFXRzKCKcuhcgZ9s+2JTYGzlahips+tuYXTjiVVrepIMDj/c5/hzvu8ST1Ln4C8+Qfn3SsagRQWoX0WswB2LG3746QBfgyX6OwqvDNK4KYJjYNJMij5V4+ZFrr5b5hu6AXwWIMYUrdR8ZlVyUXIvySI=
Received: from CH3P221CA0023.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::23)
 by IA0PPF44635DB8D.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bcc) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 23:32:40 +0000
Received: from CH3PEPF0002457C.namprd04.prod.outlook.com
 (2603:10b6:610:1e7:cafe::33) by CH3P221CA0023.outlook.office365.com
 (2603:10b6:610:1e7::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Wed,
 18 Nov 2026 23:32:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0002457C.mail.protection.outlook.com (10.167.252.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 23:32:39 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 17:32:39 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 17:32:39 -0600
Received: from xsjgregoryw50.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via
 Frontend Transport; Wed, 18 Nov 2026 17:32:39 -0600
From: Gregory Williams <gregory.williams@amd.com>
To: Oded Gabbay <ogabbay@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
Subject: [PATCH 14/15] accel/amd-ai-engine: Add support to enable/disable tile
 clocks
Date: Wed, 18 Nov 2026 15:32:10 -0800
Message-ID: <20261118233211.4121361-15-gregory.williams@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118233211.4121361-1-gregory.williams@amd.com>
References: <20261118233211.4121361-1-gregory.williams@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0002457C:EE_|IA0PPF44635DB8D:EE_
X-MS-Office365-Filtering-Correlation-Id: b7bab16c-f3f7-4bf2-00c5-08df45cc3c76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|5023799004|261026140227099003|261022105027099003|261028144727099003|56012099006|261021123027099003|11063799006|261021121427099003|10067099003|261009223027099003|261102123227099003|261022075727099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: fJtReCC5te5mOGzZopOc+94ueykP71kJdvV0sYAo7SO2JHIlJAHkGSQDDbGTFOZOYe4otAxWrZDFGlkjfS8cChcCtDe61jR1rNcCUonkQMvrsXZWwDg9WDvzylzmeQZ06Xs/vUfBlQXZ0bRZxHOI8QtjyWnIqTuAiIJIgryGl9om6g6WrzrVt7VuRqeExKBDkdu/nx3cXIvPlSU6QmGyTtcrO2FhryV5rL+lkcDEgogSSnDyHQH5c9EXKk41iGqojG7Cu9o+ADrZuOBa3omHuylGFhlLrpb1If8pd1ZM03BtLHchorNVU1OmustrfNwEyaVnGdFPcULYgLh557BJv58vUlfOMftSSo0uH+yU5mwuhceHHqGx9bjjn8wcEEIeQjgFPDLeKbgnJt65XhUYzOMM8d/jmqYddF6bQYl3hlVgR7hAAjuoaJGsUsCFBvmatnYlrtdnuFPFZiGv4QQ2fokD29ZxtzwiDIDgC8bgV6hr3wzyp6AlxAqGWfTfLhLXBNNvXcEB2NvwnlHaW3rN8mciqvrOny11dBCYPWsuMA8Yxcp4mGgmjaQS5r32C3IjwuaLOh6DXypPa8N+lkNbAYKU386lWe6TSSU7JtDFz9rHqzBMN2wxOdV7zXrGw3yuVjRLO5ZR8qZl2pTWE2MaSzLyMY9WWgIIhdUt3fuWdMbUCMDbsr0qppAIj9EE2Ib6BH201nK93mUmWS+jT1Iv9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(5023799004)(261026140227099003)(261022105027099003)(261028144727099003)(56012099006)(261021123027099003)(11063799006)(261021121427099003)(10067099003)(261009223027099003)(261102123227099003)(261022075727099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tEogdq2ikNYhCOhV8LCDUn3I9q5oKYp1MUdgJtABOavb0EeJmjsUPysUNKyKkH8t8kxqK6ywicoQAkoxOia3CsINfVYAdAG5QlbzUNB5padAzeE9uKfObkb9L0yC+bl66pOrIA2GofpgA6dkORbo5L0LqZGes3gT6viS2wYxuFdbgQF5UaIamYf9tm2GKSO/+weNT1kUpVnzCySMsJjGhlPPgyi7KWoisp8AE2iBo3jdx8ujifOS4qznip04knO1ESkJoChoquiybuBM7+KeybMApJ7l1KQM4vJY5O8HZIFGaxvoq6kvpPEEy3VJBRz3Tw2lhT8TAHqGylCEO8Vi/5tVcE83j6QavFQBr/sZlQmjTklTNXHj0FSIlxISFoOXmJ2810EKesBj6Iv1qj4AYSKDAoUW7+Q4vqIN88Bt8I806dnTjVZqZ9VmJbZ6g6ai
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 23:32:39.9335 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7bab16c-f3f7-4bf2-00c5-08df45cc3c76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0002457C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF44635DB8D
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

Add support for enabling tile clocks and requesting/releasing tiles.
Requesting tiles will enable the clocks of the tiles requested, releasing
tiles will disable the tile clocks.

Signed-off-by: Gregory Williams <gregory.williams@amd.com>
---
 drivers/accel/amd-ai-engine/Makefile          |   1 +
 .../accel/amd-ai-engine/ai-engine-aiemlv2.c   | 150 +++++++++++++++++
 drivers/accel/amd-ai-engine/ai-engine-clock.c | 154 ++++++++++++++++++
 .../accel/amd-ai-engine/ai-engine-internal.h  |  43 +++++
 drivers/accel/amd-ai-engine/ai-engine-part.c  |  18 ++
 drivers/accel/amd-ai-engine/ai-engine-res.c   |  56 +++++++
 include/linux/amd-ai-engine.h                 |   1 -
 7 files changed, 422 insertions(+), 1 deletion(-)
 create mode 100644 drivers/accel/amd-ai-engine/ai-engine-clock.c

diff --git a/drivers/accel/amd-ai-engine/Makefile b/drivers/accel/amd-ai-engine/Makefile
index 8b0d857d3347..c6d090257d6e 100644
--- a/drivers/accel/amd-ai-engine/Makefile
+++ b/drivers/accel/amd-ai-engine/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_DRM_ACCEL_AMDAIE)	+= amd-aie.o
 amd-aie-$(CONFIG_DRM_ACCEL_AMDAIE) := \
 	ai-engine-aiemlv2.o	\
 	ai-engine-dev.o		\
+	ai-engine-clock.o	\
 	ai-engine-part.o	\
 	ai-engine-pm.o		\
 	ai-engine-res.o
diff --git a/drivers/accel/amd-ai-engine/ai-engine-aiemlv2.c b/drivers/accel/amd-ai-engine/ai-engine-aiemlv2.c
index 0c9c7ccdd54e..26dd1d726bfa 100644
--- a/drivers/accel/amd-ai-engine/ai-engine-aiemlv2.c
+++ b/drivers/accel/amd-ai-engine/ai-engine-aiemlv2.c
@@ -13,6 +13,16 @@
 #define AIEMLV2_COL_SHIFT		25U
 #define AIEMLV2_ROW_SHIFT		20U
 
+/*
+ * Register offsets
+ */
+#define AIEMLV2_SHIMPL_COLCLOCK_CTRL_REGOFF		0x0007FF20U
+
+/*
+ * Register masks
+ */
+#define AIEMLV2_SHIMPL_COLCLOCK_CTRL_MASK		GENMASK(1, 0)
+
 static u32 aiemlv2_get_tile_type(struct aie_device *adev, struct aie_location *loc)
 {
 	u8 num_mem_rows = adev->ttype_attr[AIE_TILE_TYPE_MEMORY].num_rows;
@@ -25,8 +35,148 @@ static u32 aiemlv2_get_tile_type(struct aie_device *adev, struct aie_location *l
 	return AIE_TILE_TYPE_SHIMNOC;
 }
 
+static int aiemlv2_scan_part_clocks(struct aie_partition *apart)
+{
+	struct aie_range *range = &apart->range;
+	struct aie_device *adev = apart->adev;
+	struct aie_location loc;
+
+	/* Clear the bitmap of cores and memories clock state */
+	aie_resource_put_region(&apart->cores_clk_state, 0,
+				apart->cores_clk_state.total);
+
+	/*
+	 * If the clock buffer on shim tile is enabled, then all tiles above in
+	 * the same column are also enabled.
+	 */
+
+	loc.row = 0;
+	for (loc.col = range->start.col;
+	     loc.col < range->start.col + range->size.col;
+	     loc.col++) {
+		void __iomem *va;
+		u32 val, nbitpos;
+
+		nbitpos = (loc.col - range->start.col) * (range->size.row - 1) + loc.row;
+
+		va = adev->base +
+		     aie_cal_regoff(adev, loc,
+				    AIEMLV2_SHIMPL_COLCLOCK_CTRL_REGOFF);
+		val = readl(va);
+
+		if (!((val & AIEMLV2_SHIMPL_COLCLOCK_CTRL_MASK) % 2))
+			continue;
+
+		aie_resource_set(&apart->cores_clk_state, nbitpos,
+				 range->size.row - 1);
+	}
+	/*
+	 * Set the tiles in use bitmap.
+	 * In case of scanning, tiles which are powered on are considered as
+	 * tiles in use.
+	 */
+	bitmap_copy(apart->tiles_inuse.bitmap, apart->cores_clk_state.bitmap,
+		    apart->tiles_inuse.total);
+
+	return 0;
+}
+
+static int aiemlv2_set_part_clocks(struct aie_partition *apart)
+{
+	struct aie_range *range = &apart->range;
+	struct aie_range prev_range = {};
+	struct aie_location loc;
+	int ret = -EINVAL;
+	u32 prev_ops = 0;
+
+	for (loc.col = 0; loc.col < range->size.col; loc.col++) {
+		u32 startbit, col_inuse = 0;
+
+		startbit = loc.col * (range->size.row - 1);
+
+		for (loc.row = range->start.row + 1;
+		     loc.row < range->start.row + range->size.row;
+		     loc.row++) {
+			u32 nbitpos = startbit + loc.row - 1;
+
+			if (aie_resource_testbit(&apart->tiles_inuse, nbitpos)) {
+				col_inuse = 1;
+				break;
+			}
+		}
+
+		if (col_inuse) {
+			struct aie_range op_range = {
+				.start.col = loc.col + range->start.col,
+				.size.col = 1,
+			};
+
+			ret = aie_resource_set(&apart->tiles_inuse, startbit,
+					       apart->range.size.row - 1);
+			if (ret)
+				return ret;
+			ret = aie_resource_set(&apart->cores_clk_state, startbit,
+					       apart->range.size.row - 1);
+			if (ret)
+				return ret;
+
+			if (!prev_ops) {
+				prev_range = op_range;
+				prev_ops = AIE_PART_INIT_OPT_ENB_COLCLK_BUFF;
+				continue;
+			}
+			if (prev_ops == AIE_PART_INIT_OPT_ENB_COLCLK_BUFF &&
+			    ((prev_range.start.col + prev_range.size.col) == op_range.start.col)) {
+				prev_range.size.col += op_range.size.col;
+				continue;
+			}
+			ret = aie_part_pm_ops(apart, NULL, prev_ops, prev_range, 0);
+			if (ret)
+				return ret;
+			prev_ops = AIE_PART_INIT_OPT_ENB_COLCLK_BUFF;
+			prev_range = op_range;
+		} else {
+			struct aie_range op_range = {
+				.start.col = loc.col + range->start.col,
+				.size.col = 1,
+			};
+
+			ret = aie_resource_clear(&apart->tiles_inuse, startbit,
+						 apart->range.size.row - 1);
+			if (ret)
+				return ret;
+			ret = aie_resource_clear(&apart->cores_clk_state, startbit,
+						 apart->range.size.row - 1);
+			if (ret)
+				return ret;
+			if (!prev_ops) {
+				prev_range = op_range;
+				prev_ops = AIE_PART_INIT_OPT_DIS_COLCLK_BUFF;
+				continue;
+			}
+			if (prev_ops == AIE_PART_INIT_OPT_DIS_COLCLK_BUFF &&
+			    ((prev_range.start.col + prev_range.size.col) == op_range.start.col)) {
+				prev_range.size.col += op_range.size.col;
+				continue;
+			}
+			ret = aie_part_pm_ops(apart, NULL, prev_ops, prev_range, 0);
+			if (ret)
+				return ret;
+			prev_ops = AIE_PART_INIT_OPT_DIS_COLCLK_BUFF;
+			prev_range = op_range;
+		}
+	}
+	if (prev_ops)
+		ret = aie_part_pm_ops(apart, NULL, prev_ops, prev_range, 0);
+	if (ret)
+		return ret;
+	return aie_part_pm_ops_flush(apart);
+}
+
 static const struct aie_tile_operations aiemlv2_ops = {
 	.get_tile_type = aiemlv2_get_tile_type,
+	.scan_part_clocks = aiemlv2_scan_part_clocks,
+	.set_part_clocks = aiemlv2_set_part_clocks,
 };
 
 /**
diff --git a/drivers/accel/amd-ai-engine/ai-engine-clock.c b/drivers/accel/amd-ai-engine/ai-engine-clock.c
new file mode 100644
index 000000000000..f2bf373c1da0
--- /dev/null
+++ b/drivers/accel/amd-ai-engine/ai-engine-clock.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AMD AI Engine clock operations
+ *
+ * Copyright(C) 2026 Advanced Micro Devices, Inc. All rights reserved.
+ */
+
+#include <linux/amd-ai-engine.h>
+#include <linux/clk.h>
+#include <linux/firmware/xlnx-zynqmp.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+
+#include "ai-engine-internal.h"
+
+/**
+ * aie_part_init_clk_state() - initialize clock state and tiles in use bitmaps
+ * @apart: AI engine partition
+ *
+ * Return: error code for error 0 for success
+ */
+int aie_part_init_clk_state(struct aie_partition *apart)
+{
+	u32 num_tiles;
+	int ret;
+
+	/* SHIM row always enabled so it is not needed in the bitmap */
+	num_tiles = apart->range.size.col * (apart->range.size.row - 1);
+	ret = aie_resource_initialize(&apart->cores_clk_state, num_tiles);
+	if (ret) {
+		dev_err(&apart->dev, "failed to initialize clock state resource.\n");
+		return ret;
+	}
+
+	ret = aie_resource_initialize(&apart->tiles_inuse, num_tiles);
+	if (ret) {
+		dev_err(&apart->dev, "failed to initialize tiles in use resource.\n");
+		aie_resource_uninitialize(&apart->cores_clk_state);
+		return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * aie_part_get_clk_state_bit() - return bit position of the clock state of a
+ *				  tile
+ * @apart: AI engine partition
+ * @loc: AI engine tile location
+ *
+ * Return: bit position for success, negative value for failure
+ */
+static int aie_part_get_clk_state_bit(struct aie_partition *apart,
+				      struct aie_location *loc)
+{
+	u32 ttype = apart->adev->ops->get_tile_type(apart->adev, loc);
+
+	if (ttype != AIE_TILE_TYPE_TILE && ttype != AIE_TILE_TYPE_MEMORY)
+		return -EINVAL;
+
+	if (loc->col < apart->range.start.col)
+		return -EINVAL;
+
+	return (loc->col - apart->range.start.col) *
+	       (apart->range.size.row - 1) + loc->row - 1;
+}
+
+/**
+ * aie_part_scan_clk_state() - scan the clock states of tiles of the AI engine
+ *			       partition
+ * @apart: AI engine partition
+ *
+ * Return: 0 for success, negative value for failure.
+ *
+ * This function will scan the clock status of both the memory and core
+ * modules.
+ */
+int aie_part_scan_clk_state(struct aie_partition *apart)
+{
+	return apart->adev->ops->scan_part_clocks(apart);
+}
+
+/**
+ * aie_part_request_tiles() - request tiles from an AI engine partition.
+ * @apart: AI engine partition
+ * @num_tiles: number of tiles to request. If it is 0, it means all tiles
+ * @locs: the AI engine tiles locations array which will be requested
+ *
+ * Return: 0 for success, negative value for failure.
+ *
+ * This function will enable clocks of the specified tiles.
+ */
+int aie_part_request_tiles(struct aie_partition *apart, u32 num_tiles,
+			   struct aie_location *locs)
+{
+	int ret;
+
+	if (num_tiles == 0) {
+		aie_resource_set(&apart->tiles_inuse, 0,
+				 apart->tiles_inuse.total);
+	} else {
+		u32 n;
+
+		if (!locs)
+			return -EINVAL;
+
+		for (n = 0; n < num_tiles; n++) {
+			int bit = aie_part_get_clk_state_bit(apart, &locs[n]);
+
+			if (bit >= 0)
+				aie_resource_set(&apart->tiles_inuse, bit, 1);
+		}
+	}
+	ret = apart->adev->ops->set_part_clocks(apart);
+
+	return ret;
+}
+
+/**
+ * aie_part_release_tiles() - release tiles from an AI engine partition.
+ * @apart: AI engine partition
+ * @num_tiles: number of tiles to release. If it is 0, it means all tiles
+ * @locs: the AI engine tiles locations array which will be released
+ *
+ * Return: 0 for success, negative value for failure.
+ *
+ * This function will disable clocks of the specified tiles.
+ */
+int aie_part_release_tiles(struct aie_partition *apart, u32 num_tiles,
+			   struct aie_location *locs)
+{
+	int ret;
+
+	if (num_tiles == 0) {
+		aie_resource_clear(&apart->tiles_inuse, 0,
+				   apart->tiles_inuse.total);
+	} else {
+		u32 n;
+
+		if (!locs)
+			return -EINVAL;
+
+		for (n = 0; n < num_tiles; n++) {
+			int bit = aie_part_get_clk_state_bit(apart, &locs[n]);
+
+			if (bit >= 0)
+				aie_resource_clear(&apart->tiles_inuse, bit, 1);
+		}
+	}
+
+	ret = apart->adev->ops->set_part_clocks(apart);
+
+	return ret;
+}
diff --git a/drivers/accel/amd-ai-engine/ai-engine-internal.h b/drivers/accel/amd-ai-engine/ai-engine-internal.h
index d2857ec50033..572476c97aad 100644
--- a/drivers/accel/amd-ai-engine/ai-engine-internal.h
+++ b/drivers/accel/amd-ai-engine/ai-engine-internal.h
@@ -37,11 +37,25 @@ struct aie_partition;
 /**
  * struct aie_tile_operations - AI engine device operations
  * @get_tile_type: get type of tile based on tile operation
+ * @scan_part_clocks: scan partition modules to check whether the modules are
+ *		      clock gated or not, and update the soft clock states
+ *		      structure. It is required to be called when the partition
+ *		      is requested so that the driver knows which modules are
+ *		      clock gated when the partition is requested. This function
+ *		      expects the caller to apply partition lock before calling
+ *		      this function.
+ * @set_part_clocks: set partition modules clocks gate registers based on the
+ *		     partition clock states bitmap. This function expects the
+ *		     caller to apply partition lock before calling this
+ *		     function. The caller function will need to set the bitmap
+ *		     on which tiles are required to be clocked on.
  * Different AI engine device version has its own device
  * operation.
  */
 struct aie_tile_operations {
 	u32 (*get_tile_type)(struct aie_device *adev, struct aie_location *loc);
+	int (*scan_part_clocks)(struct aie_partition *apart);
+	int (*set_part_clocks)(struct aie_partition *apart);
 };
 
 /**
@@ -275,6 +289,8 @@ struct aie_device {
  * @dev: AI Engine partition device
  * @adev: pointer to AI device instance
  * @range: range of partition
+ * @cores_clk_state: bitmap to indicate the power state of core and mem tiles
+ * @tiles_inuse: bitmap to indicate if a tile is in use
  * @mlock: protection for AI engine partition operations
  * @pm_ops: pm ops pkt and metadata for pm firmware calls
  */
@@ -283,6 +299,8 @@ struct aie_partition {
 	struct device dev;
 	struct aie_device *adev;
 	struct aie_range range;
+	struct aie_resource cores_clk_state;
+	struct aie_resource tiles_inuse;
 	struct mutex mlock;
 	struct aie_pm_ops pm_ops;
 };
@@ -307,10 +325,32 @@ struct aie_device_cfg {
 
 #define dev_to_aiepart(_dev) container_of((_dev), struct aie_partition, dev)
 
+/**
+ * aie_cal_regoff() - calculate register offset to the whole AI engine
+ *		      device start address
+ * @adev: AI engine device
+ * @loc: AI engine tile location
+ * @regoff_intile: register offset within a tile
+ *
+ * Return: register offset to the whole AI engine device start address
+ */
+static inline u32 aie_cal_regoff(struct aie_device *adev,
+				 struct aie_location loc, u32 regoff_intile)
+{
+	return regoff_intile + (loc.col << adev->col_shift) +
+	       (loc.row << adev->row_shift);
+}
+
 void aiemlv2_device_init(struct aie_device *adev);
 struct aie_partition *aie_part_create(struct aie_device *adev,
 				      u8 start_col, u8 num_col);
 void aie_part_release(struct aie_partition *apart);
+int aie_part_init_clk_state(struct aie_partition *apart);
+int aie_part_scan_clk_state(struct aie_partition *apart);
+int aie_part_request_tiles(struct aie_partition *apart, u32 num_tiles,
+			   struct aie_location *locs);
+int aie_part_release_tiles(struct aie_partition *apart, u32 num_tiles,
+			   struct aie_location *locs);
 int aie_resource_initialize(struct aie_resource *res, int count);
 void aie_resource_uninitialize(struct aie_resource *res);
 int aie_resource_check_region(struct aie_resource *res, u32 start,
@@ -318,6 +358,9 @@ int aie_resource_check_region(struct aie_resource *res, u32 start,
 int aie_resource_get_region(struct aie_resource *res, u32 start,
 			    u32 count);
 void aie_resource_put_region(struct aie_resource *res, int start, u32 count);
+int aie_resource_set(struct aie_resource *res, u32 start, u32 count);
+int aie_resource_clear(struct aie_resource *res, u32 start, u32 count);
+bool aie_resource_testbit(struct aie_resource *res, u32 bit);
 int aie_part_pm_ops_create(struct aie_partition *apart);
 void aie_part_pm_ops_destroy(struct aie_partition *apart);
 int aie_part_pm_ops_flush(struct aie_partition *apart);
diff --git a/drivers/accel/amd-ai-engine/ai-engine-part.c b/drivers/accel/amd-ai-engine/ai-engine-part.c
index 51580049f0e7..35451d1ed88a 100644
--- a/drivers/accel/amd-ai-engine/ai-engine-part.c
+++ b/drivers/accel/amd-ai-engine/ai-engine-part.c
@@ -26,6 +26,8 @@ void aie_part_release(struct aie_partition *apart)
 				apart->range.start.col -
 				adev->range.start.col,
 				apart->range.size.col);
+	aie_resource_uninitialize(&apart->cores_clk_state);
+	aie_resource_uninitialize(&apart->tiles_inuse);
 	device_unregister(&apart->dev);
 }
 
@@ -82,6 +84,22 @@ struct aie_partition *aie_part_create(struct aie_device *adev,
 		goto err;
 	}
 
+	ret = aie_part_init_clk_state(apart);
+	if (ret) {
+		dev_err(&apart->dev, "failed to initialize clock state\n");
+		aie_part_pm_ops_destroy(apart);
+		goto err;
+	}
+
+	ret = aie_part_scan_clk_state(apart);
+	if (ret) {
+		dev_err(&apart->dev, "failed to scan clock state.");
+		aie_part_pm_ops_destroy(apart);
+		aie_resource_uninitialize(&apart->cores_clk_state);
+		aie_resource_uninitialize(&apart->tiles_inuse);
+		goto err;
+	}
+
 	return apart;
 
 err:
diff --git a/drivers/accel/amd-ai-engine/ai-engine-res.c b/drivers/accel/amd-ai-engine/ai-engine-res.c
index 62df26edf87d..45b9447d896f 100644
--- a/drivers/accel/amd-ai-engine/ai-engine-res.c
+++ b/drivers/accel/amd-ai-engine/ai-engine-res.c
@@ -110,3 +110,59 @@ void aie_resource_put_region(struct aie_resource *res, int start, u32 count)
 		return;
 	bitmap_clear(res->bitmap, start, count);
 }
+
+/**
+ * aie_resource_set() - set the AI engine resource bits
+ * @res: pointer to AI engine resource
+ * @start: start bit to set
+ * @count: number of bits to set
+ *
+ * Return: 0 for success and negative value for failure
+ *
+ * This function sets the specified number bits in the resource.
+ */
+int aie_resource_set(struct aie_resource *res, u32 start, u32 count)
+{
+	if (!res || !res->bitmap || !count ||
+	    start > res->total || count > res->total - start)
+		return -EINVAL;
+
+	bitmap_set(res->bitmap, start, count);
+	return 0;
+}
+
+/**
+ * aie_resource_clear() - clear the AI engine resource bits
+ * @res: pointer to AI engine resource
+ * @start: start bit to set
+ * @count: number of bits to clear
+ *
+ * Return: 0 for success and negative value for failure
+ *
+ * This function clears the specified number bits in the resource.
+ */
+int aie_resource_clear(struct aie_resource *res, u32 start, u32 count)
+{
+	if (!res || !res->bitmap || !count ||
+	    start > res->total || count > res->total - start)
+		return -EINVAL;
+
+	bitmap_clear(res->bitmap, start, count);
+	return 0;
+}
+
+/**
+ * aie_resource_testbit() - test if a bit is set in a AI engine resource
+ * @res: pointer to AI engine resource
+ * @bit: bit to check
+ *
+ * Return: true for set, false for not set
+ */
+bool aie_resource_testbit(struct aie_resource *res, u32 bit)
+{
+	if (!res || !res->bitmap || bit >= res->total)
+		return false;
+
+	/* Locate the unsigned long the required bit belongs to */
+	return test_bit(bit, res->bitmap);
+}
diff --git a/include/linux/amd-ai-engine.h b/include/linux/amd-ai-engine.h
index 9df3463985af..229434372fc0 100644
--- a/include/linux/amd-ai-engine.h
+++ b/include/linux/amd-ai-engine.h
@@ -96,5 +96,4 @@ struct aie_op_handshake_data {
 
 struct device *aie_partition_request(struct device *dev, struct aie_partition_req *req);
 void aie_partition_release(struct device *dev);
-
 #endif
-- 
2.34.1

