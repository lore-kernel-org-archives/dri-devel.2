Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D60606D664
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 23:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=zVPtcJYY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0C8A10EC7A;
	Wed, 18 Nov 2026 23:32:52 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010060.outbound.protection.outlook.com [52.101.201.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC44C10E46D
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 23:32:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YzJnmBDurk+k/4HLDGSIgpayOtLh/nTJ/jSP/+RxeWB0m2HSvgM9aRGb6S7ezwaH1GC2hIiSkpi1KnzpKzij5dZFGx7qzh4jLtvrKELv5sNe1QnQkZNysYDD85N+O7UxdbKCQNQnGJD0m/oEigAUymPN/BLJf2BhbI7meV8zptVKI6fKz2VFIWVLhQjLneC2zqapIl065rwVzs3lw9wQlaQ04PWGYWw0auTCQHvTzkUtInzoz+4YRmTagRKz6rQKjqNhHoCjLTd5GWeVD2neMAxnmPrJEzJETyFgZQTYOwUbbSlQUZ82sqNcir9Z4UU8X7gFpU//FovfXm4PVvp5cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kOor3iSONH2/y4lGYexkCSVix3HVZloanguX0Na05U=;
 b=fz15gQS4WenDuxIDCssA7z65MT4AdIhC84/QVi/zLGIc72gCv2XyOGu48BsAQvtT4fh9XzTebIM/VEMm4InV2PhVmt+INQKIsxDnL9UvXqLt4d9i7byzt0xvG2iA/uSN6FNeewcNo+GSfMqDy363o9MkGVvK9A461uqQih7L3u0B/NxJIfWjvsLSjpTe6EzOr2p6q9y2YmfdjX+LA0VHpESuZiWTRd4KVQRb18Puo42lC/+gbeEpX/9RWLnBdLNUoiX3azDHlMbs8A4X6O53r3AlZavM/0SfXmArZ7ffcZ0HjTkBIprNaaQJo3lEQ6wtEjA2AdxKznhH/eOMD5OHTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kOor3iSONH2/y4lGYexkCSVix3HVZloanguX0Na05U=;
 b=zVPtcJYYICvHStz82HZUPFkq9K1g9Us4/GSWJZU6XT5dLIodQc5nwZCPdNNYQcGOCQZEoVpZjufol1yXA0Seqfr9BKlJHduzKmKuXV6F/iTwDgiIQEU4rxY41M+1rm1HeEsuja7o62FgXuKe+bQgu8oL0BOK6pLx+YhdMNj8eSY=
Received: from IA1P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:464::15)
 by DSWPR12MB999175.namprd12.prod.outlook.com (2603:10b6:8:36f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 23:32:36 +0000
Received: from IA0PEPF00000037.namprd03.prod.outlook.com
 (2603:10b6:208:464:cafe::62) by IA1P220CA0015.outlook.office365.com
 (2603:10b6:208:464::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Wed,
 18 Nov 2026 23:32:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 IA0PEPF00000037.mail.protection.outlook.com (10.167.249.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 23:32:35 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 17:32:33 -0600
Received: from xsjgregoryw50.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via
 Frontend Transport; Wed, 18 Nov 2026 17:32:33 -0600
From: Gregory Williams <gregory.williams@amd.com>
To: Oded Gabbay <ogabbay@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
Subject: [PATCH 12/15] accel/amd-ai-engine: Add AMD AI Engine device driver
Date: Wed, 18 Nov 2026 15:32:08 -0800
Message-ID: <20261118233211.4121361-13-gregory.williams@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118233211.4121361-1-gregory.williams@amd.com>
References: <20261118233211.4121361-1-gregory.williams@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF00000037:EE_|DSWPR12MB999175:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ab3dea7-0b36-4f39-cbe6-08df45cc3a16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|261102123227099003|261102130727099003|261022105027099003|261021123027099003|261021121427099003|261022075727099003|261026121527099003|261028144727099003|5023799004|11063799006|261026140227099003|56012099006|10067099003|18002099003|22082099003|6133799003|20046099003|261009223027099003|13003099007;
X-Microsoft-Antispam-Message-Info: D/BBJ9Qqq+j2HCe05XLGkBdB8IW6+g7SzGF3+KRBuV0k2lF52GjB1wjOeQpmGOn6dTbab/W8uKQ1stXlbqG+c1inPB06HKp5EylSud8mXwKGnWBW45agMYPl0VC6NVywrxqvOm+INUYgWCIVa1EyTrLeqms7aMuD+jN51JEXj2wHuFGWyy0dFnUnj2FpfFuhpVbE3EA95y17N9JiiGsDrYrUGrllyaW69ZF5AdlZ+qT4/gBe2WrST0X5RWf7fG7iCUvYSw6xW+dFNO+Oj/yGnoxeeXLv75kGb7bdsJqTGTb8fYY/8TCVEXdblg2TtiuFtIhCBZniSbC9130G45bloUNMD2f93S6obWFjdgFSsWCc3cwLmU//d03qut4O9IUBliHUBkw4OALzxRFxpRyN8bVkAgUn8+VIgDHlDsCjJ98QRdBhS4/D/Z95R+iqXP75U70tDSAwe1L92SDB0R6gD2nZTd3NGgcWFJ2P4qxrk+DG2PVh7q0r3KSgP2cHvi0fWMjiVKuO9e6nWzBCsxdt1PgZsUStQozKREZwKkIv9ID9sfz+mjF87kkALnbsiP7U8jho7lAA8MUKuT9BpVUr7EgfxaQaCYztiChrs9SjSCAuqRDZZh4ycRk4+TzlhC7qbeFXRV6qVZ5GsyDvpR1mXRhV8si99Wna+Z2dHEWAKZ4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(261102123227099003)(261102130727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261022075727099003)(261026121527099003)(261028144727099003)(5023799004)(11063799006)(261026140227099003)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003)(20046099003)(261009223027099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ri0g60M4/Z1HB2XNq9kLhvN21hu4wLspmpgSmPAhcUwemsvTJnWwtBPYxNjzxxo+sb3tH/IcBDpbmcW3C5eerP+Qtkv8mAaj1RXGqbNsrvKA3WTQ8ALGSG8sFnwWCuRdj/4wpmZ34hP/ePhLRgriSXwOwrrHHf6XFmambdye3kDc4exUW3IdSuXPx1PnucTUunYasHT4VCary7P3+fmTHTwuCFu+i3wncDElbuoU4Ln+A0mEyZ5KQ3Id9cihNQN+ULDmZCJoBEtMe1gTZdjgg8dw5wyolsQ4WbVrXqSy6ctJ5M9wMxgeXiz4TdyTsTnr+Pn8VuE9Qk+mShPTQAheB/liEeuXr+F34LT3TVxdHIHYuF2KceD5Wxr4D2Jfw1pOp9TK3piFcRZY0+4+tVd/3Tt7KaX8ggEp+VIu84gYxwM8jA2b/GWHKCw6qCZjGWGn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 23:32:35.9760 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ab3dea7-0b36-4f39-cbe6-08df45cc3a16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF00000037.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR12MB999175
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

Add support for AMD AI Engine on AMD Versal devices. AMD AI Engine is a
tile array based accelerator for applications like beamforming and machine
learning inference [1].

AI Engine device driver is responsible for the management of AI engine
partitions (groups of AI engine columns). At runtime applications request
a partition from the AI engine device. Applications use the partition
handle for application setup and control.

The driver architecture:
  +-------------------------------------------+
  |                 AIE Device                |
  | +----------------+     +----------------+ |
  | |   partition_0  | ... |   partition_X  | |
  | +----------------+     +----------------+ |
  +-------------------------------------------+

The driver provides the following functionality:
- AI Engine device probe
- Partition request and release

[1] https://www.amd.com/en/products/adaptive-socs-and-fpgas/technologies/ai-engine.html

Signed-off-by: Gregory Williams <gregory.williams@amd.com>
---
 MAINTAINERS                                   |   9 +
 drivers/accel/Kconfig                         |   1 +
 drivers/accel/Makefile                        |   3 +-
 drivers/accel/amd-ai-engine/Kconfig           |  15 ++
 drivers/accel/amd-ai-engine/Makefile          |  11 +
 .../accel/amd-ai-engine/ai-engine-aiemlv2.c   |  47 ++++
 drivers/accel/amd-ai-engine/ai-engine-dev.c   | 244 ++++++++++++++++++
 .../accel/amd-ai-engine/ai-engine-internal.h  | 160 ++++++++++++
 drivers/accel/amd-ai-engine/ai-engine-part.c  |  77 ++++++
 drivers/accel/amd-ai-engine/ai-engine-res.c   | 112 ++++++++
 include/linux/amd-ai-engine.h                 |  59 +++++
 11 files changed, 737 insertions(+), 1 deletion(-)
 create mode 100644 drivers/accel/amd-ai-engine/Kconfig
 create mode 100644 drivers/accel/amd-ai-engine/Makefile
 create mode 100644 drivers/accel/amd-ai-engine/ai-engine-aiemlv2.c
 create mode 100644 drivers/accel/amd-ai-engine/ai-engine-dev.c
 create mode 100644 drivers/accel/amd-ai-engine/ai-engine-internal.h
 create mode 100644 drivers/accel/amd-ai-engine/ai-engine-part.c
 create mode 100644 drivers/accel/amd-ai-engine/ai-engine-res.c
 create mode 100644 include/linux/amd-ai-engine.h

diff --git a/MAINTAINERS b/MAINTAINERS
index bcade5bfbafe..d8bfa7cbf8f6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1080,6 +1080,15 @@ L:	linux-sound@vger.kernel.org
 S:	Supported
 F:	sound/soc/amd/
 
+AMD AI ENGINE DRIVER
+M:	Gregory Williams <gregory.williams@amd.com>
+L:	dri-devel@lists.freedesktop.org
+S:	Maintained
+T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	Documentation/devicetree/bindings/soc/xilinx/xlnx,ai-engine.yaml
+F:	drivers/accel/amd-ai-engine/
+F:	include/linux/amd-ai-engine.h
+
 AMD AXI I3C MASTER DRIVER
 M:	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
 M:	Shubham Patil <shubhamsanjay.patil@amd.com>
diff --git a/drivers/accel/Kconfig b/drivers/accel/Kconfig
index bdf48ccafcf2..b20a1445629d 100644
--- a/drivers/accel/Kconfig
+++ b/drivers/accel/Kconfig
@@ -24,6 +24,7 @@ menuconfig DRM_ACCEL
 	  different device files, called accel/accel* (in /dev, sysfs
 	  and debugfs).
 
+source "drivers/accel/amd-ai-engine/Kconfig"
 source "drivers/accel/amdxdna/Kconfig"
 source "drivers/accel/ethosu/Kconfig"
 source "drivers/accel/habanalabs/Kconfig"
diff --git a/drivers/accel/Makefile b/drivers/accel/Makefile
index 1d3a7251b950..f0f09f3b6a56 100644
--- a/drivers/accel/Makefile
+++ b/drivers/accel/Makefile
@@ -1,8 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
+obj-$(CONFIG_DRM_ACCEL_AMDAIE)		+= amd-ai-engine/
 obj-$(CONFIG_DRM_ACCEL_AMDXDNA)		+= amdxdna/
 obj-$(CONFIG_DRM_ACCEL_ARM_ETHOSU)	+= ethosu/
 obj-$(CONFIG_DRM_ACCEL_HABANALABS)	+= habanalabs/
 obj-$(CONFIG_DRM_ACCEL_IVPU)		+= ivpu/
 obj-$(CONFIG_DRM_ACCEL_QAIC)		+= qaic/
-obj-$(CONFIG_DRM_ACCEL_ROCKET)		+= rocket/
\ No newline at end of file
+obj-$(CONFIG_DRM_ACCEL_ROCKET)		+= rocket/
diff --git a/drivers/accel/amd-ai-engine/Kconfig b/drivers/accel/amd-ai-engine/Kconfig
new file mode 100644
index 000000000000..7f32928cb20f
--- /dev/null
+++ b/drivers/accel/amd-ai-engine/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config DRM_ACCEL_AMDAIE
+	tristate "AMD Versal AI Engine"
+	depends on ARM64 || COMPILE_TEST
+	depends on ZYNQMP_FIRMWARE
+	depends on DRM_ACCEL
+	help
+	  This option enables support for the AMD AI engine driver.
+	  One AMD AI engine device can have multiple partitions (groups of
+	  AI engine tiles). AMD AI engine device driver instance manages
+	  AI engine partitions. Applications access its partitions through
+	  AI engine partition device instance.
+
+	  If unsure, say N.
diff --git a/drivers/accel/amd-ai-engine/Makefile b/drivers/accel/amd-ai-engine/Makefile
new file mode 100644
index 000000000000..cb456ee7ec37
--- /dev/null
+++ b/drivers/accel/amd-ai-engine/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for AMD AI engine device driver
+
+obj-$(CONFIG_DRM_ACCEL_AMDAIE)	+= amd-aie.o
+
+amd-aie-$(CONFIG_DRM_ACCEL_AMDAIE) := \
+	ai-engine-aiemlv2.o	\
+	ai-engine-dev.o		\
+	ai-engine-part.o	\
+	ai-engine-res.o
diff --git a/drivers/accel/amd-ai-engine/ai-engine-aiemlv2.c b/drivers/accel/amd-ai-engine/ai-engine-aiemlv2.c
new file mode 100644
index 000000000000..0c9c7ccdd54e
--- /dev/null
+++ b/drivers/accel/amd-ai-engine/ai-engine-aiemlv2.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AMD AI Engine driver AIEMLv2 device specific implementation
+ *
+ * Copyright(C) 2026 Advanced Micro Devices, Inc. All rights reserved.
+ */
+
+#include <linux/amd-ai-engine.h>
+
+#include "ai-engine-internal.h"
+
+#define AIEMLV2_ARRAY_SHIFT		32U
+#define AIEMLV2_COL_SHIFT		25U
+#define AIEMLV2_ROW_SHIFT		20U
+
+static u32 aiemlv2_get_tile_type(struct aie_device *adev, struct aie_location *loc)
+{
+	u8 num_mem_rows = adev->ttype_attr[AIE_TILE_TYPE_MEMORY].num_rows;
+
+	if (loc->row > num_mem_rows)
+		return AIE_TILE_TYPE_TILE;
+	if (loc->row)
+		return AIE_TILE_TYPE_MEMORY;
+
+	return AIE_TILE_TYPE_SHIMNOC;
+}
+
+static const struct aie_tile_operations aiemlv2_ops = {
+	.get_tile_type = aiemlv2_get_tile_type,
+};
+
+/**
+ * aiemlv2_device_init() - Initialize AI engine device struct AIEMLV2 specific
+ * @adev: AI engine device
+ *
+ * This function initialize the AI engine device structure device version
+ * specific elements such as register addressing related array shift,
+ * column shift, and row shift; AIEMLV2 device specific device operations, device
+ * columns resource.
+ */
+void aiemlv2_device_init(struct aie_device *adev)
+{
+	adev->array_shift = AIEMLV2_ARRAY_SHIFT;
+	adev->col_shift = AIEMLV2_COL_SHIFT;
+	adev->row_shift = AIEMLV2_ROW_SHIFT;
+	adev->ops = &aiemlv2_ops;
+}
diff --git a/drivers/accel/amd-ai-engine/ai-engine-dev.c b/drivers/accel/amd-ai-engine/ai-engine-dev.c
new file mode 100644
index 000000000000..7dad3004e30a
--- /dev/null
+++ b/drivers/accel/amd-ai-engine/ai-engine-dev.c
@@ -0,0 +1,244 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AMD AI Engine device driver
+ *
+ * Copyright(C) 2026 Advanced Micro Devices, Inc. All rights reserved.
+ */
+
+#include <linux/amd-ai-engine.h>
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+
+#include "ai-engine-internal.h"
+
+/**
+ * aie_partition_request() - Request an AI engine partition
+ * @dev: AI engine device pointer
+ * @req: AI engine partition request arguments
+ *
+ * Return: pointer to the AI engine partition device, error pointer value for
+ *	   failure.
+ */
+struct device *aie_partition_request(struct device *dev, struct aie_partition_req *req)
+{
+	struct aie_device *adev = dev_get_drvdata(dev);
+	struct aie_partition *apart = NULL;
+	u8 start_col, num_col, end_col;
+	int ret;
+
+	if (!req)
+		return ERR_PTR(-EINVAL);
+
+	start_col = aie_part_id_get_start_col(req->partition_id);
+	num_col = aie_part_id_get_num_cols(req->partition_id);
+	if (num_col == 0) {
+		start_col = adev->range.start.col;
+		num_col = adev->range.size.col;
+	}
+
+	end_col = start_col + num_col - 1;
+	if (start_col < adev->range.start.col ||
+	    end_col >= (adev->range.start.col + adev->range.size.col)) {
+		dev_err(adev->dev, "partition is outside of device range\n");
+		return ERR_PTR(-ERANGE);
+	}
+
+	mutex_lock(&adev->mlock);
+	ret = aie_resource_get_region(&adev->cols_res,
+				      start_col - adev->range.start.col,
+				      num_col);
+	if (ret != (u32)start_col - adev->range.start.col) {
+		/* column range returned is not what user requested */
+		if (ret > 0)
+			aie_resource_put_region(&adev->cols_res, ret, num_col);
+		mutex_unlock(&adev->mlock);
+		dev_err(adev->dev, "partition requested is busy\n");
+		return ERR_PTR(-EBUSY);
+	}
+
+	apart = aie_part_create(adev, start_col, num_col);
+	if (IS_ERR(apart)) {
+		aie_resource_put_region(&adev->cols_res, ret, num_col);
+		ret = PTR_ERR(apart);
+		mutex_unlock(&adev->mlock);
+		dev_err(adev->dev, "failed to create partition\n");
+		return ERR_PTR(ret);
+	}
+
+	list_add_tail(&apart->node, &adev->partitions);
+	mutex_unlock(&adev->mlock);
+	dev_dbg(adev->dev, "Partition (%u, %u) created successfully.\n",
+		apart->range.start.col, apart->range.size.col);
+
+	return &apart->dev;
+}
+EXPORT_SYMBOL_GPL(aie_partition_request);
+
+/**
+ * aie_partition_release() - Release the AI engine partition
+ * @dev: AI engine partition device pointer
+ */
+void aie_partition_release(struct device *dev)
+{
+	struct aie_partition *apart = dev_to_aiepart(dev);
+
+	mutex_lock(&apart->adev->mlock);
+	aie_part_release(apart);
+	mutex_unlock(&apart->adev->mlock);
+}
+EXPORT_SYMBOL_GPL(aie_partition_release);
+
+static int amd_ai_engine_probe(struct platform_device *pdev)
+{
+	const struct aie_device_cfg *match;
+	struct aie_device *adev;
+	u32 pm_reg;
+	int ret;
+
+	adev = devm_kzalloc(&pdev->dev, sizeof(*adev), GFP_KERNEL);
+	if (!adev)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, adev);
+	INIT_LIST_HEAD(&adev->partitions);
+	mutex_init(&adev->mlock);
+
+	match = of_device_get_match_data(&pdev->dev);
+	if (!match) {
+		dev_err(&pdev->dev, "Failed to find aie device configuration\n");
+		return -ENODEV;
+	}
+
+	/* setup device layout configuration */
+	adev->dev = &pdev->dev;
+	adev->range.start.col = 0;
+	adev->range.size.col = match->num_columns;
+	adev->range.start.row = 0;
+	adev->range.size.row = match->mem_num_row + match->core_num_row + 1;
+	adev->ttype_attr[AIE_TILE_TYPE_SHIMPL].start_row = 0;
+	adev->ttype_attr[AIE_TILE_TYPE_SHIMPL].num_rows = 1;
+	adev->ttype_attr[AIE_TILE_TYPE_SHIMNOC].start_row = 0;
+	adev->ttype_attr[AIE_TILE_TYPE_SHIMNOC].num_rows = 0;
+	adev->ttype_attr[AIE_TILE_TYPE_TILE].start_row = match->core_start_row;
+	adev->ttype_attr[AIE_TILE_TYPE_TILE].num_rows = match->core_num_row;
+	adev->ttype_attr[AIE_TILE_TYPE_MEMORY].start_row = match->mem_start_row;
+	adev->ttype_attr[AIE_TILE_TYPE_MEMORY].num_rows = match->mem_num_row;
+
+	adev->dev_gen = match->aie_gen;
+	if (adev->dev_gen == AIE_DEVICE_GEN_AIEMLV2) {
+		aiemlv2_device_init(adev);
+	} else {
+		dev_err(&pdev->dev, "Device generation not supported\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * AI Engine platform management node ID is required for requesting
+	 * services from firmware driver.
+	 */
+	ret = of_property_read_u32(pdev->dev.of_node, "xlnx,firmware-device-id",
+				   &pm_reg);
+	if (ret < 0) {
+		dev_err(&pdev->dev,
+			"Failed to read power management information\n");
+		return ret;
+	}
+	adev->fw_dev_id = pm_reg;
+
+	adev->clk = devm_clk_get(&pdev->dev, "aclk0");
+	if (IS_ERR(adev->clk)) {
+		dev_err(&pdev->dev, "Failed to get device clock.\n");
+		return PTR_ERR(adev->clk);
+	}
+
+	adev->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(adev->base)) {
+		dev_err(&pdev->dev, "Failed to map IO resources\n");
+		return PTR_ERR(adev->base);
+	}
+
+	/*
+	 * Initialize columns resource map to remember which columns have been
+	 * assigned. Used for partition management.
+	 */
+	ret = aie_resource_initialize(&adev->cols_res,
+				      adev->range.size.col);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to initialize columns resource.\n");
+		return ret;
+	}
+
+	dev_dbg(&pdev->dev,
+		"AMD AI Engine device probed. Device generation: %u. Clock frequency: %luHz.\n",
+		adev->dev_gen, clk_get_rate(adev->clk));
+	dev_dbg(&pdev->dev,
+		"AI engine cols(%u, %u) aie_tile_rows(%u, %u) memory_tile_rows(%u, %u)\n",
+		adev->range.start.col, adev->range.size.col,
+		adev->ttype_attr[AIE_TILE_TYPE_TILE].start_row,
+		adev->ttype_attr[AIE_TILE_TYPE_TILE].num_rows,
+		adev->ttype_attr[AIE_TILE_TYPE_MEMORY].start_row,
+		adev->ttype_attr[AIE_TILE_TYPE_MEMORY].num_rows);
+	return 0;
+}
+
+static void amd_ai_engine_remove(struct platform_device *pdev)
+{
+	struct aie_device *adev = platform_get_drvdata(pdev);
+	struct aie_partition *apart, *lapart;
+
+	mutex_lock(&adev->mlock);
+	list_for_each_entry_safe(apart, lapart, &adev->partitions, node)
+		aie_part_release(apart);
+	mutex_unlock(&adev->mlock);
+
+	aie_resource_uninitialize(&adev->cols_res);
+}
+
+static const struct aie_device_cfg versal2_aieml = {
+	.num_columns = 32,
+	.mem_start_row = 1,
+	.mem_num_row = 2,
+	.core_start_row = 3,
+	.core_num_row = 4,
+	.aie_gen = AIE_DEVICE_GEN_AIEMLV2,
+};
+
+static const struct of_device_id amd_ai_engine_of_match[] = {
+	{
+		.compatible = "xlnx,versal2-aieml",
+		.data = &versal2_aieml,
+	},
+	{ /* end of table */ },
+};
+MODULE_DEVICE_TABLE(of, amd_ai_engine_of_match);
+
+static struct platform_driver amd_ai_engine_driver = {
+	.probe			= amd_ai_engine_probe,
+	.remove			= amd_ai_engine_remove,
+	.driver			= {
+		.name		= "amd-ai-engine",
+		.of_match_table	= amd_ai_engine_of_match,
+	},
+};
+
+static int __init amd_ai_engine_init(void)
+{
+	return platform_driver_register(&amd_ai_engine_driver);
+}
+module_init(amd_ai_engine_init);
+
+static void __exit amd_ai_engine_exit(void)
+{
+	platform_driver_unregister(&amd_ai_engine_driver);
+}
+module_exit(amd_ai_engine_exit);
+
+MODULE_AUTHOR("Advanced Micro Devices, Inc.");
+MODULE_DESCRIPTION("AMD Versal AI Engine driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/accel/amd-ai-engine/ai-engine-internal.h b/drivers/accel/amd-ai-engine/ai-engine-internal.h
new file mode 100644
index 000000000000..61ebd7f4b3d1
--- /dev/null
+++ b/drivers/accel/amd-ai-engine/ai-engine-internal.h
@@ -0,0 +1,160 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * AMD AI Engine driver internal header
+ *
+ * Copyright(C) 2026 Advanced Micro Devices, Inc. All rights reserved.
+ */
+
+#ifndef AIE_INTERNAL_H
+#define AIE_INTERNAL_H
+
+#include <linux/amd-ai-engine.h>
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+
+#define AIE_DEVICE_GEN_AIEMLV2	3U
+
+/*
+ * Macros for AI engine tile type
+ */
+enum aie_tile_type {
+	AIE_TILE_TYPE_TILE,
+	AIE_TILE_TYPE_SHIMPL,
+	AIE_TILE_TYPE_SHIMNOC,
+	AIE_TILE_TYPE_MEMORY,
+	AIE_TILE_TYPE_MAX
+};
+
+struct aie_device;
+struct aie_partition;
+
+/**
+ * struct aie_tile_operations - AI engine device operations
+ * @get_tile_type: get type of tile based on tile operation
+ * Different AI engine device version has its own device
+ * operation.
+ */
+struct aie_tile_operations {
+	u32 (*get_tile_type)(struct aie_device *adev, struct aie_location *loc);
+};
+
+/**
+ * struct aie_resource - AI engine resource structure
+ * @bitmap: resource bitmap
+ * @total: total number of resource
+ */
+struct aie_resource {
+	unsigned long *bitmap;
+	u32 total;
+};
+
+/**
+ * struct aie_range - AIE range information
+ * @start: start tile location
+ * @size: size of the range, number of columns and rows
+ */
+struct aie_range {
+	struct aie_location start;
+	struct aie_location size;
+};
+
+/**
+ * struct aie_tile_attr - AI engine device tile type attributes
+ * @start_row: start row
+ * @num_rows: number of rows
+ */
+struct aie_tile_attr {
+	u8 start_row;
+	u8 num_rows;
+};
+
+/**
+ * struct aie_device - AI engine device structure
+ * @partitions: list of partitions
+ * @dev: device pointer for the AI engine device
+ * @mlock: protection for AI engine device operations
+ * @clk: AI engine device clock
+ * @base: AI engine base virtual address
+ * @ops: tile operations
+ * @cols_res: AI engine columns resources to indicate
+ *	      while columns are occupied by partitions.
+ * @ttype_attr: tile type attributes
+ * @range: range of whole AI engine
+ * @array_shift: array address shift
+ * @col_shift: column address shift
+ * @row_shift: row address shift
+ * @dev_gen: aie hardware device generation
+ * @fw_dev_id: AI Engine firmware device ID
+ */
+struct aie_device {
+	struct list_head partitions;
+	struct device *dev;
+	struct mutex mlock;
+	struct clk *clk;
+	void __iomem *base;
+	const struct aie_tile_operations *ops;
+	struct aie_resource cols_res;
+	struct aie_tile_attr ttype_attr[AIE_TILE_TYPE_MAX];
+	struct aie_range range;
+	u32 array_shift;
+	u32 col_shift;
+	u32 row_shift;
+	u32 dev_gen;
+	u32 fw_dev_id;
+};
+
+/**
+ * struct aie_partition - AI engine partition structure
+ * @node: list node
+ * @dev: AI Engine partition device
+ * @adev: pointer to AI device instance
+ * @range: range of partition
+ * @mlock: protection for AI engine partition operations
+ */
+struct aie_partition {
+	struct list_head node;
+	struct device dev;
+	struct aie_device *adev;
+	struct aie_range range;
+	struct mutex mlock;
+};
+
+/**
+ * struct aie_device_cfg - AI engine device configuration and layout
+ * @num_columns: number of columns in the device
+ * @mem_start_row: start row index for memory tiles
+ * @mem_num_row: number of memory tile rows
+ * @core_start_row: start row index for core tiles
+ * @core_num_row: number of core tile rows
+ * @aie_gen: AI Engine generation
+ */
+struct aie_device_cfg {
+	u8 num_columns;
+	u8 mem_start_row;
+	u8 mem_num_row;
+	u8 core_start_row;
+	u8 core_num_row;
+	u8 aie_gen;
+};
+
+#define dev_to_aiepart(_dev) container_of((_dev), struct aie_partition, dev)
+
+void aiemlv2_device_init(struct aie_device *adev);
+struct aie_partition *aie_part_create(struct aie_device *adev,
+				      u8 start_col, u8 num_col);
+void aie_part_release(struct aie_partition *apart);
+int aie_resource_initialize(struct aie_resource *res, int count);
+void aie_resource_uninitialize(struct aie_resource *res);
+int aie_resource_check_region(struct aie_resource *res, u32 start,
+			      u32 count);
+int aie_resource_get_region(struct aie_resource *res, u32 start,
+			    u32 count);
+void aie_resource_put_region(struct aie_resource *res, int start, u32 count);
+
+#endif /* AIE_INTERNAL_H */
diff --git a/drivers/accel/amd-ai-engine/ai-engine-part.c b/drivers/accel/amd-ai-engine/ai-engine-part.c
new file mode 100644
index 000000000000..f80a6fa433aa
--- /dev/null
+++ b/drivers/accel/amd-ai-engine/ai-engine-part.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AMD AI Engine partition implementation
+ *
+ * Copyright(C) 2026 Advanced Micro Devices, Inc. All rights reserved.
+ */
+
+#include <linux/amd-ai-engine.h>
+#include <linux/device.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+
+#include "ai-engine-internal.h"
+
+/**
+ * aie_part_release() - release an AI engine partition instance
+ * @apart: AI engine partition device
+ */
+void aie_part_release(struct aie_partition *apart)
+{
+	struct aie_device *adev = apart->adev;
+
+	list_del(&apart->node);
+	aie_resource_put_region(&adev->cols_res,
+				apart->range.start.col -
+				adev->range.start.col,
+				apart->range.size.col);
+	device_unregister(&apart->dev);
+}
+
+static void aie_part_release_device(struct device *dev)
+{
+	(void)dev;
+}
+
+/**
+ * aie_part_create() - create AI engine partition instance
+ * @adev: AI engine device
+ * @start_col: start column of AI engine partition
+ * @num_col: number of columns of AI engine partition
+ *
+ * Return: created AI engine partition pointer for success, and PTR_ERR
+ *	   for failure.
+ */
+struct aie_partition *aie_part_create(struct aie_device *adev,
+				      u8 start_col, u8 num_col)
+{
+	struct aie_partition *apart;
+	struct device *dev;
+
+	apart = devm_kzalloc(adev->dev, sizeof(*apart), GFP_KERNEL);
+	if (!apart)
+		return ERR_PTR(-ENOMEM);
+
+	apart->adev = adev;
+	mutex_init(&apart->mlock);
+	apart->range.start.col = start_col;
+	apart->range.size.col = num_col;
+	apart->range.start.row = adev->range.start.row;
+	apart->range.size.row = adev->range.size.row;
+
+	/* create partition device */
+	dev = &apart->dev;
+	dev->parent = apart->adev->dev;
+	dev_set_name(dev, "aiepart_%u_%u", apart->range.start.col,
+		     apart->range.size.col);
+	dev_set_drvdata(dev, apart);
+	dev->release = aie_part_release_device;
+
+	if (device_register(&apart->dev)) {
+		dev_err(adev->dev, "failed to register partition device\n");
+		put_device(dev);
+		return ERR_PTR(-ENODEV);
+	}
+
+	return apart;
+}
diff --git a/drivers/accel/amd-ai-engine/ai-engine-res.c b/drivers/accel/amd-ai-engine/ai-engine-res.c
new file mode 100644
index 000000000000..62df26edf87d
--- /dev/null
+++ b/drivers/accel/amd-ai-engine/ai-engine-res.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AMD AI Engine resource implementation
+ *
+ * Copyright(C) 2026 Advanced Micro Devices, Inc. All rights reserved.
+ */
+
+#include <linux/bitmap.h>
+
+#include "ai-engine-internal.h"
+
+/**
+ * aie_resource_initialize() - initialize AI engine resource
+ * @res: pointer to AI engine resource
+ * @count: total number of element of this resource
+ *
+ * Return: 0 for success, negative value for failure.
+ *
+ * This function will initialize the data structure for the
+ * resource.
+ */
+int aie_resource_initialize(struct aie_resource *res, int count)
+{
+	res->bitmap = bitmap_zalloc(count, GFP_KERNEL);
+	if (!res->bitmap)
+		return -ENOMEM;
+	res->total = count;
+
+	return 0;
+}
+
+/**
+ * aie_resource_uninitialize() - uninitialize AI engine resource
+ * @res: pointer to AI engine resource
+ *
+ * This function will release the AI engine resource data members.
+ */
+void aie_resource_uninitialize(struct aie_resource *res)
+{
+	res->total = 0;
+	if (res->bitmap)
+		bitmap_free(res->bitmap);
+}
+
+/**
+ * aie_resource_check_region() - check availability of requested resource
+ * @res: pointer to AI engine resource to check
+ * @start: start index of the required resource
+ * @count: number of requested element
+ *
+ * Return: start resource id if the requested number of resources are available
+ *	   It will return negative value of errors.
+ *
+ * This function will check the availability. It will return start resource id
+ * if the requested number of resources are available.
+ */
+int aie_resource_check_region(struct aie_resource *res,
+			      u32 start, u32 count)
+{
+	unsigned long id;
+
+	if (!res || !res->bitmap || !count)
+		return -EINVAL;
+	id = bitmap_find_next_zero_area(res->bitmap, res->total, start,
+					count, 0);
+	if (id >= res->total)
+		return -ERANGE;
+
+	return (int)id;
+}
+
+/**
+ * aie_resource_get_region() - get requested AI engine resource
+ * @res: pointer to AI engine resource to check
+ * @start: start index of the required resource
+ * @count: number of requested element
+ *
+ * Return: start resource id for success, and negative value for failure.
+ *
+ * This function check if the requested AI engine resource is available.
+ * If it is available, mark it used and return the start resource id.
+ */
+int aie_resource_get_region(struct aie_resource *res, u32 start, u32 count)
+{
+	unsigned long off;
+
+	if (!res || !res->bitmap || !count)
+		return -EINVAL;
+	off = bitmap_find_next_zero_area(res->bitmap, res->total, start,
+					 count, 0);
+	if (off >= res->total)
+		return -ERANGE;
+
+	bitmap_set(res->bitmap, off, count);
+
+	return (int)off;
+}
+
+/**
+ * aie_resource_put_region() - release requested AI engine resource
+ * @res: pointer to AI engine resource to check
+ * @start: start index of the resource to release
+ * @count: number of elements to release
+ *
+ * This function release the requested AI engine resource.
+ */
+void aie_resource_put_region(struct aie_resource *res, int start, u32 count)
+{
+	if (!res || !count)
+		return;
+	bitmap_clear(res->bitmap, start, count);
+}
diff --git a/include/linux/amd-ai-engine.h b/include/linux/amd-ai-engine.h
new file mode 100644
index 000000000000..f5750d219e21
--- /dev/null
+++ b/include/linux/amd-ai-engine.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * amd-ai-engine.h - AMD AI engine external interface
+ *
+ * Copyright(C) 2026 Advanced Micro Devices, Inc. All rights reserved.
+ */
+
+#ifndef _AMD_AI_ENGINE_H_
+#define _AMD_AI_ENGINE_H_
+
+#include <linux/device.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+
+#define AIE_PART_ID_START_COL_SHIFT	0U
+#define AIE_PART_ID_NUM_COLS_SHIFT	8U
+#define AIE_PART_ID_START_COL_MASK	(0xFFU << AIE_PART_ID_START_COL_SHIFT)
+#define AIE_PART_ID_NUM_COLS_MASK	(0xFFU << AIE_PART_ID_NUM_COLS_SHIFT)
+
+#define aie_part_id_get_val(part_id, F) \
+	(((part_id) & AIE_PART_ID_##F ##_MASK) >> AIE_PART_ID_##F ##_SHIFT)
+#define aie_part_id_get_start_col(part_id) \
+	aie_part_id_get_val((part_id), START_COL)
+#define aie_part_id_get_num_cols(part_id) \
+	aie_part_id_get_val((part_id), NUM_COLS)
+#define aie_calc_part_id(start_col, num_col) \
+	(((start_col) << AIE_PART_ID_START_COL_SHIFT) + \
+	 ((num_col) << AIE_PART_ID_NUM_COLS_SHIFT))
+
+/**
+ * struct aie_partition_req - AIE request partition arguments
+ * @partition_id: partition node id. It is used to identify the AI engine
+ *		  partition. Its format is:
+ *		  Reserved_16bits | start_col_8bits | num_cols_8bits
+ * @meta_data: meta data to indicate which resources used by application.
+ * @flag: used for application to indicate particular driver requirements
+ *	  application wants to have for the partition. e.g. do not clean
+ *	  resource when closing the partition.
+ */
+struct aie_partition_req {
+	u32 partition_id;
+	u64 meta_data;
+	u32 flag;
+};
+
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
+struct device *aie_partition_request(struct device *dev, struct aie_partition_req *req);
+void aie_partition_release(struct device *dev);
+
+#endif
-- 
2.34.1

