Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BE5606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 06:46:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3717310E4D9;
	Tue, 17 Nov 2026 06:46:12 +0000 (UTC)
Received: from OS8PR02CU002.outbound.protection.outlook.com
 (mail-japanwestazon11022106.outbound.protection.outlook.com [40.107.75.106])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E3ED10E00C
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 06:46:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iwl3Z39WH/lc32/ACSBhYZwG8O05YDOkMXhZtADmt22+sKUpn+048CuH+1ZGLXibsC9osHwhmnTtPsdCG03KELQvI11cuiLi+5+p/4ma3OlQE3jwksBPCXujZIJaW0iSqGhnIt4uMV6gTpZ3VFK/FwjXWlL4t0R3pd2BE6o2LlUjdmYSeDHwFfynpsyjfYfuzvxK8KALuS6naleFBE4j3QWa6O9K0LxSWZ5P5jpwXEYfdpqjQSI2lY5KtTmhXINYH45n2PDi7nuAUMXp8G87FlyBni4w6VkHlEJfAr9gPm1yMU79pB3+xQQw8L6f851hShBSnh5SYphQmFkmjx/ghQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMhcDjam5eaaapNz1y/vNDuMgiDLts6GqtNhLn295aY=;
 b=BAkx+EdOQWqfEgE7FlTVwK9TmaG3QYyJ0XXPUSzinR81h3/kmMuEzr4kQ2KwSHipQ6Er39KrEcjY76H9nr++lLd2k80c1DJcaBcU4YFO1l3MfYNRdG8m8OnYE1A3/Zo/zeXovujg87nVhQG/OmIEil1RVTsxnGO920n2nqh889KQ3XbalyeDcj1WTG9yTod0hXhotJ6wCCTbym7kIs1ZaDdUWl8jMW3FOfMEu4YYzJtcW7SbwLqKtddlnQ6Thqj0OrZuSuSua9HsTn30MHJtxjTQeiVrAksS4D+2VlqBZMX26xHqeynCbCMFF7O1dMIDt/+OHpWBgipZJuQJBHgrBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cixtech.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR02CA0132.apcprd02.prod.outlook.com (2603:1096:4:188::15)
 by TY0PR06MB5681.apcprd06.prod.outlook.com (2603:1096:400:275::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.7; Tue, 17 Nov
 2026 06:45:55 +0000
Received: from OSA0EPF000000C9.apcprd02.prod.outlook.com
 (2603:1096:4:188:cafe::7d) by SG2PR02CA0132.outlook.office365.com
 (2603:1096:4:188::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Tue,
 17 Nov 2026 06:45:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000C9.mail.protection.outlook.com (10.167.240.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 06:45:53 +0000
Received: from localhost.localdomain (unknown [172.16.66.33])
 by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id CAC0740920E2;
 Tue, 17 Nov 2026 14:45:52 +0800 (CST)
From: Luo Liu <Luo.Liu@cixtech.com>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 Luo.Liu@cixtech.com, wuyi.shen@cixtech.com, cix-kernel-upstream@cixtech.com
Subject: [PATCH v2 2/2] drm/cix: add Sky1 DisplayPort transmitter driver
Date: Tue, 17 Nov 2026 14:45:52 +0800
Message-Id: <20261117064552.85256-3-Luo.Liu@cixtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261117064552.85256-1-Luo.Liu@cixtech.com>
References: <20261117064552.85256-1-Luo.Liu@cixtech.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C9:EE_|TY0PR06MB5681:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 50941482-3d7e-482b-9013-08df44766d4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|42112799006|36860700016|23010399003|6133799003|18002099003|18092099006|22082099003|261009221227099003|261009221727099003|261009220027099003|261009223027099003|261009223327099003|3023799007|261021123027099003|261022105027099003|261022075727099003|261022113327099003|261021121427099003|261026140227099003|261026121527099003|261028144727099003|56012099006|10067099003|5023799004|261102123227099003;
X-Microsoft-Antispam-Message-Info: LMR7pSqCPCl6621aXt3Q6fD8radLbQJ9kuT1TtSon1oIm0AAabDzok2UHcdPnu41+pRRH6kq1Nvz9m9yVrH1IHmuJJ8diY7+L41J9g6X5+KHafJnU/oQ1bvxtnHfttcxGcRJQeZgHZT9BAhfzV2lUU0zShPmvlX8Yiyy51Q9EmQPVohQqTiTxLZWiTjul3sgOWPezustzMGOoDuWJhiBl7e2uwadMkmj9cL0wx1my7HjlzgNF/6odabiSEOE6/+KyyNZj1GPZnDnNkrBB9sYgYYXtXWBxZAwr7itA0/Un3YqA7r26Rtu5Y0ZofHxSJU/8GuNSxOC6+UQSyAOjzFi8PRvE/WnhHtJXZQtTnrJTrFO38nG+b5iEf7ZfwaNsYjdkgVAOZB+Be1U50bLe9FszQOcnP29KsNMMnCevQdFm3ccIzGgtLLCCoAm6RMNZKnr//ygKCflo/bJEZCqC2N6L88FBK3w5nZxrVgu+0XlNYImcCPKb+CwF8ms6ps1mEdwAwNbIwXnXxN4NCefGHIOIE8lYz12OXKk/p+8mIOqJTzgl3lMIC29BObe50If7DlmlPzEcdFDGroM/94tR1PWz5O7+tT7Da+vMLqn4EHWyariwGe0jRtV+me84Ld04UHLTL+B1Y5IeAsc452LMTE0Urdm6CpK4O4iEn9icxt+yccKXs0c6kWSVbC8CZobVF/0kr6+ymsXT2MKXpOD4w5WVg==
X-Forefront-Antispam-Report: CIP:222.71.101.198; CTRY:CN; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtprelay.cixcomputing.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(42112799006)(36860700016)(23010399003)(6133799003)(18002099003)(18092099006)(22082099003)(261009221227099003)(261009221727099003)(261009220027099003)(261009223027099003)(261009223327099003)(3023799007)(261021123027099003)(261022105027099003)(261022075727099003)(261022113327099003)(261021121427099003)(261026140227099003)(261026121527099003)(261028144727099003)(56012099006)(10067099003)(5023799004)(261102123227099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UaX1FMfhGFZsg+5zk2JiE0Af3Z6fe/bYR2hNkprWlPONuz48GUXTKmvY8hERoeSUob8v4HH+rAqP6vF+P5W0wQFl2484KIvoAK1JQVMLzjeWeSqpj3Y334YySt7nuqiIAt7wVYc7b1QKX3xnCnr5GaKDvmsMuTa1o6Yf+pp34VPkM+yo9S1nkV37Ih+R8VjgmLHwkNU2bnGycziKY21B5ftTJglUY1rLBMGtfR5Wy6P0S47DJYjpoupDlx0K0ye/lj3/shhKZt4OKCfds7hm9KY42ymlewbNAoiBsWEqP1F4dVXvmplIR49UWEiLI+Aqq3T4XeueH49XleC2m/KMLlttFkTOaAQsLnffWLIzHBQzZqscU6iGqJkZcfApJsL+ot56N06qNx4CvfZqYycPC+LUUXaelgqpi3AS2yGLEtiIq+ZiuRRb/u18LrEeMqu8
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 06:45:53.8010 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50941482-3d7e-482b-9013-08df44766d4c
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811; Ip=[222.71.101.198];
 Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: OSA0EPF000000C9.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5681
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a DRM bridge driver for the CIX Sky1 DisplayPort transmitter. The
controller implements the DP link training and the source side of the
DisplayPort protocol, and is fed by one of the SoC display pipelines.

The transmitter is exposed as a DRM bridge. The Komeda display pipeline
(ARM Mali DPU on Sky1) that feeds these outputs is not part of this
series. Komeda calls drm_bridge_attach() with attach flags 0 and does
not register a connector, so this driver registers a DisplayPort
drm_connector from .attach(). That matches how Sky1 is integrated today
and gives userspace a connector on the encoder.

The connector reads EDID, validates modes against link bandwidth,
supports YCbCr 4:2:0 and signals hotplug through
drm_helper_hpd_irq_event().

The DisplayPort PHY is driven through the generic PHY API: link-rate and
voltage-swing updates are forwarded to the PHY and the link is retrained
when the sink requests it. Audio and DSC are not supported yet.

Signed-off-by: Luo Liu <Luo.Liu@cixtech.com>
---
 MAINTAINERS                             |    1 +
 drivers/gpu/drm/Kconfig                 |    1 +
 drivers/gpu/drm/Makefile                |    1 +
 drivers/gpu/drm/cix/Kconfig             |    3 +
 drivers/gpu/drm/cix/Makefile            |    3 +
 drivers/gpu/drm/cix/dptx/Kconfig        |   17 +
 drivers/gpu/drm/cix/dptx/Makefile       |    4 +
 drivers/gpu/drm/cix/dptx/cix_dptx.c     | 2434 +++++++++++++++++++++++
 drivers/gpu/drm/cix/dptx/cix_dptx.h     |  408 ++++
 drivers/gpu/drm/cix/dptx/cix_dptx_drm.c |  771 +++++++
 drivers/gpu/drm/cix/dptx/cix_dptx_drm.h |   16 +
 11 files changed, 3659 insertions(+)
 create mode 100644 drivers/gpu/drm/cix/Kconfig
 create mode 100644 drivers/gpu/drm/cix/Makefile
 create mode 100644 drivers/gpu/drm/cix/dptx/Kconfig
 create mode 100644 drivers/gpu/drm/cix/dptx/Makefile
 create mode 100644 drivers/gpu/drm/cix/dptx/cix_dptx.c
 create mode 100644 drivers/gpu/drm/cix/dptx/cix_dptx.h
 create mode 100644 drivers/gpu/drm/cix/dptx/cix_dptx_drm.c
 create mode 100644 drivers/gpu/drm/cix/dptx/cix_dptx_drm.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e3557e931c94..3cc8c8865793 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6529,6 +6529,7 @@ R:	CIX Linux Kernel Upstream Group <cix-kernel-upstream@cixtech.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/display/cix,sky1-dp.yaml
+F:	drivers/gpu/drm/cix/dptx/
 
 CLANG CONTEXT ANALYSIS
 M:	Marco Elver <elver@google.com>
diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 61111d50b1c6..a1808db8b9c8 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -311,6 +311,7 @@ source "drivers/gpu/drm/aspeed/Kconfig"
 source "drivers/gpu/drm/ast/Kconfig"
 source "drivers/gpu/drm/atmel-hlcdc/Kconfig"
 source "drivers/gpu/drm/bridge/Kconfig"
+source "drivers/gpu/drm/cix/Kconfig"
 source "drivers/gpu/drm/etnaviv/Kconfig"
 source "drivers/gpu/drm/exynos/Kconfig"
 source "drivers/gpu/drm/fsl-dcu/Kconfig"
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 2c6bc093a923..6ed7456bb993 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -169,6 +169,7 @@ obj-y			+= tests/
 obj-$(CONFIG_DRM_MIPI_DBI) += drm_mipi_dbi.o
 obj-$(CONFIG_DRM_MIPI_DSI) += drm_mipi_dsi.o
 obj-y			+= arm/
+obj-y			+= cix/
 obj-y			+= clients/
 obj-y			+= display/
 obj-$(CONFIG_DRM_TTM)	+= ttm/
diff --git a/drivers/gpu/drm/cix/Kconfig b/drivers/gpu/drm/cix/Kconfig
new file mode 100644
index 000000000000..6cbaa5bf9fe9
--- /dev/null
+++ b/drivers/gpu/drm/cix/Kconfig
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+source "drivers/gpu/drm/cix/dptx/Kconfig"
diff --git a/drivers/gpu/drm/cix/Makefile b/drivers/gpu/drm/cix/Makefile
new file mode 100644
index 000000000000..a93591fc49e8
--- /dev/null
+++ b/drivers/gpu/drm/cix/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_DRM_CIX_DP) += dptx/
diff --git a/drivers/gpu/drm/cix/dptx/Kconfig b/drivers/gpu/drm/cix/dptx/Kconfig
new file mode 100644
index 000000000000..547d50209612
--- /dev/null
+++ b/drivers/gpu/drm/cix/dptx/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config DRM_CIX_DP
+	tristate "Cix DisplayPort Controller Driver"
+	depends on ARCH_CIX || COMPILE_TEST
+	depends on COMMON_CLK && DRM && OF
+	depends on GENERIC_PHY
+	select DRM_KMS_HELPER
+	select DRM_DISPLAY_HELPER
+	select DRM_DISPLAY_DP_HELPER
+	help
+	  DRM/KMS driver for the Cix DisplayPort controller. It implements
+	  the standard DRM bridge interface and drives an external
+	  DisplayPort PHY through the generic PHY framework.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called cix-dptx.
diff --git a/drivers/gpu/drm/cix/dptx/Makefile b/drivers/gpu/drm/cix/dptx/Makefile
new file mode 100644
index 000000000000..d156178d9a34
--- /dev/null
+++ b/drivers/gpu/drm/cix/dptx/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+cix-dptx-y := cix_dptx.o cix_dptx_drm.o
+obj-$(CONFIG_DRM_CIX_DP) += cix-dptx.o
diff --git a/drivers/gpu/drm/cix/dptx/cix_dptx.c b/drivers/gpu/drm/cix/dptx/cix_dptx.c
new file mode 100644
index 000000000000..882c4a92f511
--- /dev/null
+++ b/drivers/gpu/drm/cix/dptx/cix_dptx.c
@@ -0,0 +1,2434 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * CIX Sky1 DisplayPort transmitter driver
+ *
+ * Copyright (C) 2026 Trilinear Technologies
+ * Copyright 2026 Cix Technology Group Co., Ltd.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/iopoll.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+#include <linux/sched.h>
+
+#include <drm/drm_probe_helper.h>
+
+#include "cix_dptx.h"
+#include "cix_dptx_drm.h"
+
+#define DEFAULT_DP_POWER_ON_DELAY_MS 4
+#define AUX_READ_BIT 0x1
+#define DP_HPD_MAX_TRIES 100
+
+#define CFG_ADAPTER_VIDEO0_OFFSET 0x300
+#define CFG_ADAPTER_VIDEO1_OFFSET 0x304
+#define CFG_ADAPTER_VIDEO_OFFSET_DP2 0x320
+#define DPTX_SDP_DB_MAX 32
+#define DPTX_MST_SOURCE_NUMBER 2
+
+/*
+ * Frequency of the DPC APB clock. The AUX channel divider is derived from it
+ * (see cix_dp_aux_clk_divider()), and the DP PHY registers are only reachable
+ * while it runs at this rate.
+ */
+#define CIX_DP_APB_CLK_RATE 200000000UL
+
+/* RCSU adapter video-config bits, per (port, pipe) */
+struct cix_rcsu_video_bits {
+	u32 fmt_mask;	/* mask of the format field */
+	u32 yuv422;	/* YCbCr422 value to set */
+	u32 yuv420;	/* YCbCr420 value to set */
+	u32 ppc_bit;	/* 2 pixels/cycle flag */
+};
+
+enum {
+	LINK_TRAIN_CLOCK_RECOVERY = 100,
+	LINK_TRAIN_CHANNEL_EQUALIZATION,
+};
+
+static const char * const stream_clk_names[] = {
+	"vid0", "vid1",
+};
+
+struct cix_dp_soc_data {
+	bool native_dp;
+};
+
+static unsigned int cix_dp_power_on_delay_ms = DEFAULT_DP_POWER_ON_DELAY_MS;
+module_param_named(power_on_delay_ms, cix_dp_power_on_delay_ms, uint, 0444);
+MODULE_PARM_DESC(power_on_delay_ms,
+		 "Delay after powering the sink up, in msec (default: 4)");
+
+static void cix_dp_write(struct cix_dp *dp, int offset, u32 val)
+{
+	writel(val, dp->dp_iomem + offset);
+}
+
+static u32 cix_dp_read(struct cix_dp *dp, int offset)
+{
+	return readl(dp->dp_iomem + offset);
+}
+
+static bool cix_dp_get_hpd_state(struct cix_dp *dp)
+{
+	return (cix_dp_read(dp, CIX_DPTX_HPD_INPUT_STATE) & 0x01) ||
+	       (READ_ONCE(dp->force_hpd) == connector_status_connected);
+}
+
+/*
+ * Serialize link training, HPD work and host register access on one mutex.
+ * A path that keeps the mutex across several internal steps takes it once at
+ * the top level; helpers that expect it to be held use the _locked suffix.
+ */
+static void cix_dp_session_lock(struct cix_dp *dp)
+{
+	mutex_lock(&dp->session_lock);
+}
+
+static void cix_dp_session_unlock(struct cix_dp *dp)
+{
+	mutex_unlock(&dp->session_lock);
+}
+
+/* Caller holds session_lock. apb_clk stays on until that section ends. */
+static bool cix_dp_regs_accessible(struct cix_dp *dp)
+{
+	lockdep_assert_held(&dp->session_lock);
+
+	return !(dp->state & DPTX_STATE_SUSPENDED) &&
+	       (dp->state & DPTX_STATE_INITIALIZED);
+}
+
+static int cix_dp_phy_link_rate_update(struct cix_dp *dp, u8 bw_code)
+{
+	union phy_configure_opts opts = { 0 };
+
+	opts.dp.link_rate = drm_dp_bw_code_to_link_rate(bw_code) / 100;
+	opts.dp.set_rate = 1;
+
+	return phy_configure(dp->phy, &opts);
+}
+
+static int cix_dp_phy_vs_emph_update(struct cix_dp *dp)
+{
+	union phy_configure_opts opts = { 0 };
+	u8 train;
+	int i;
+	int ret = 0;
+
+	opts.dp.lanes = dp->mode.lane_cnt;
+	for (i = 0; i < opts.dp.lanes; i++) {
+		train = dp->train_set[i];
+		opts.dp.voltage[i] =
+			(train & DP_TRAIN_VOLTAGE_SWING_MASK) >>
+			DP_TRAIN_VOLTAGE_SWING_SHIFT;
+		opts.dp.pre[i] = (train & DP_TRAIN_PRE_EMPHASIS_MASK) >>
+			DP_TRAIN_PRE_EMPHASIS_SHIFT;
+	}
+
+	opts.dp.set_voltages = 1;
+	ret = phy_configure(dp->phy, &opts);
+
+	return ret;
+}
+
+static int cix_dp_phy_ready(struct cix_dp *dp)
+{
+	u32 value;
+	u32 ready;
+
+	ready = (1 << dp->num_lanes) - 1;
+
+	return readl_poll_timeout(dp->dp_iomem + CIX_DPTX_PHY_STATUS, value,
+				  (value & ready) == ready, 1000, 100 * 1000);
+}
+
+static void cix_dp_mode_set(struct cix_dp *dp, u8 bw_code, int link_rate,
+			    u8 lane_cnt, int pclock)
+{
+	dp->mode.bw_code = bw_code;
+	dp->mode.link_rate = link_rate;
+	dp->mode.lane_cnt = lane_cnt;
+	dp->mode.pclock = pclock;
+}
+
+static int cix_dp_get_lanes(struct cix_dp *dp, int link_rate, int pclk, u8 bpp)
+{
+	int max_lanes = dp->link_config.max_lanes;
+	int i;
+
+	for (i = 1; i <= max_lanes; i <<= 1) {
+		if (pclk <= CIX_DP_MAX_RATE(link_rate, i, bpp ? bpp : 24))
+			return i;
+	}
+
+	return 0;
+}
+
+static int cix_dp_mode_configure(struct cix_dp *dp, int pclk, u8 bw, u8 bpp,
+				 bool downshift)
+{
+	int max_rate = dp->link_config.max_rate;
+	int lane_cnt;
+	int bw_code;
+	int link_rate;
+
+	if (!downshift)
+		bw_code = bw;
+	else
+		switch (bw) {
+		case DP_LINK_BW_8_1:
+			bw_code = DP_LINK_BW_5_4;
+			break;
+		case DP_LINK_BW_5_4:
+			bw_code = DP_LINK_BW_2_7;
+			break;
+		case DP_LINK_BW_2_7:
+			bw_code = DP_LINK_BW_1_62;
+			break;
+		case DP_LINK_BW_1_62:
+			bw_code = DP_LINK_BW_1_62;
+			break;
+		default:
+			bw_code = drm_dp_link_rate_to_bw_code(max_rate);
+			break;
+		}
+
+	link_rate = drm_dp_bw_code_to_link_rate(bw_code);
+	lane_cnt = cix_dp_get_lanes(dp, link_rate, pclk, bpp);
+	if (!lane_cnt)
+		return -EINVAL;
+
+	cix_dp_mode_set(dp, bw_code, link_rate, lane_cnt, pclk);
+
+	return 0;
+}
+
+static void cix_dp_adjust_train(struct cix_dp *dp, u8 *link_status)
+{
+	u8 voltage = 0;
+	u8 preemphasis = 0;
+	u8 v;
+	u8 p;
+	int i;
+
+	for (i = 0; i < dp->mode.lane_cnt; i++) {
+		v = drm_dp_get_adjust_request_voltage(link_status, i);
+		p = drm_dp_get_adjust_request_pre_emphasis(link_status, i);
+		if (v > voltage)
+			voltage = v;
+		if (p > preemphasis)
+			preemphasis = p;
+	}
+
+	if (voltage >= DP_TRAIN_VOLTAGE_SWING_LEVEL_3)
+		voltage |= DP_TRAIN_MAX_SWING_REACHED;
+
+	if (preemphasis >= DP_TRAIN_PRE_EMPH_LEVEL_2)
+		preemphasis |= DP_TRAIN_MAX_PRE_EMPHASIS_REACHED;
+
+	for (i = 0; i < dp->mode.lane_cnt; i++)
+		dp->train_set[i] = voltage | preemphasis;
+}
+
+static int cix_dp_update_vs_emph(struct cix_dp *dp)
+{
+	int ret;
+
+	ret = drm_dp_dpcd_write(&dp->aux, DP_TRAINING_LANE0_SET, dp->train_set,
+				dp->mode.lane_cnt);
+	if (ret < 0)
+		return ret;
+
+	return cix_dp_phy_vs_emph_update(dp);
+}
+
+static int cix_dp_link_set_pattern(struct cix_dp *dp, int phase)
+{
+	u32 pattern;
+
+	switch (phase) {
+	case LINK_TRAIN_CLOCK_RECOVERY:
+		pattern = DP_TRAINING_PATTERN_1;
+		break;
+	case LINK_TRAIN_CHANNEL_EQUALIZATION:
+		if (dp->caps.tps4_supported)
+			pattern = DP_TRAINING_PATTERN_4;
+		else if (dp->caps.tps3_supported)
+			pattern = DP_TRAINING_PATTERN_3;
+		else
+			pattern = DP_TRAINING_PATTERN_2;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (pattern == DP_TRAINING_PATTERN_4) {
+		cix_dp_write(dp, CIX_DPTX_TRAINING_PATTERN_SET, 0x4);
+		cix_dp_write(dp, CIX_DPTX_DISABLE_SCRAMBLING, 0);
+
+	} else {
+		cix_dp_write(dp, CIX_DPTX_TRAINING_PATTERN_SET, pattern);
+		pattern = pattern | DP_LINK_SCRAMBLING_DISABLE;
+	}
+
+	return drm_dp_dpcd_writeb(&dp->aux, DP_TRAINING_PATTERN_SET, pattern);
+}
+
+static int cix_dp_link_configure(struct cix_dp *dp)
+{
+	u8 bw_code = dp->mode.bw_code;
+	u8 lane_cnt = dp->mode.lane_cnt;
+	int ret;
+
+	cix_dp_write(dp, CIX_DPTX_LANE_COUNT_SET, lane_cnt);
+
+	if (dp->caps.enhanced_framing) {
+		cix_dp_write(dp, CIX_DPTX_ENHANCED_FRAMING_ENABLE, 1);
+		lane_cnt |= DP_LANE_COUNT_ENHANCED_FRAME_EN;
+	}
+
+	if (dp->dpcd[DP_MAX_DOWNSPREAD] & DP_MAX_DOWNSPREAD_0_5) {
+		cix_dp_write(dp, CIX_DPTX_DOWNSPREAD_CONTROL, 1);
+		drm_dp_dpcd_writeb(&dp->aux, DP_DOWNSPREAD_CTRL,
+				   DP_SPREAD_AMP_0_5);
+	} else {
+		cix_dp_write(dp, CIX_DPTX_DOWNSPREAD_CONTROL, 0);
+		drm_dp_dpcd_writeb(&dp->aux, DP_DOWNSPREAD_CTRL, 0);
+	}
+
+	ret = drm_dp_dpcd_writeb(&dp->aux, DP_LANE_COUNT_SET, lane_cnt);
+	if (ret < 0)
+		return ret;
+
+	ret = drm_dp_dpcd_writeb(&dp->aux, DP_MAIN_LINK_CHANNEL_CODING_SET,
+				 DP_SET_ANSI_8B10B);
+	if (ret < 0)
+		return ret;
+
+	ret = drm_dp_dpcd_writeb(&dp->aux, DP_LINK_BW_SET, bw_code);
+	if (ret < 0)
+		return ret;
+
+	cix_dp_write(dp, CIX_DPTX_LINK_BW_SET, bw_code);
+	ret = cix_dp_phy_link_rate_update(dp, bw_code);
+	if (ret)
+		return ret;
+
+	return cix_dp_phy_ready(dp);
+}
+
+static int cix_dp_link_train_clock_recovery(struct cix_dp *dp)
+{
+	u8 link_status[DP_LINK_STATUS_SIZE];
+	u8 lane_cnt = dp->mode.lane_cnt;
+	bool train_done = false;
+	u8 prev = 0;
+	int tries = 0;
+	int i;
+	int ret;
+
+	ret = cix_dp_link_set_pattern(dp, LINK_TRAIN_CLOCK_RECOVERY);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < 512; i++) {
+		ret = cix_dp_update_vs_emph(dp);
+		if (ret)
+			return ret;
+
+		drm_dp_link_train_clock_recovery_delay(&dp->aux, dp->dpcd);
+		ret = drm_dp_dpcd_read_link_status(&dp->aux, link_status);
+		if (ret < 0)
+			return ret;
+
+		train_done = drm_dp_clock_recovery_ok(link_status, lane_cnt);
+		if (train_done)
+			break;
+
+		if ((dp->train_set[0] &
+		     (DP_TRAIN_VOLTAGE_SWING_MASK |
+		      DP_TRAIN_PRE_EMPHASIS_MASK)) == prev)
+			tries++;
+		else
+			tries = 0;
+
+		if (tries == DP_MAX_TRAINING_TRIES)
+			break;
+
+		prev = dp->train_set[0] &
+		       (DP_TRAIN_VOLTAGE_SWING_MASK |
+			DP_TRAIN_PRE_EMPHASIS_MASK);
+		cix_dp_adjust_train(dp, link_status);
+	}
+
+	if (train_done)
+		return 0;
+
+	return -EIO;
+}
+
+static int cix_dp_link_train_channel_equalization(struct cix_dp *dp)
+{
+	u8 link_status[DP_LINK_STATUS_SIZE];
+	u8 lane_cnt = dp->mode.lane_cnt;
+	bool train_done = false;
+	int i;
+	int ret;
+
+	ret = cix_dp_link_set_pattern(dp, LINK_TRAIN_CHANNEL_EQUALIZATION);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < DP_MAX_TRAINING_TRIES; i++) {
+		ret = cix_dp_update_vs_emph(dp);
+		if (ret)
+			return ret;
+
+		drm_dp_link_train_channel_eq_delay(&dp->aux, dp->dpcd);
+		ret = drm_dp_dpcd_read_link_status(&dp->aux, link_status);
+		if (ret < 0)
+			return ret;
+
+		train_done = drm_dp_channel_eq_ok(link_status, lane_cnt);
+		if (train_done)
+			break;
+
+		cix_dp_adjust_train(dp, link_status);
+	}
+
+	if (train_done)
+		return 0;
+
+	return -EIO;
+}
+
+static void cix_dp_train_end(struct cix_dp *dp)
+{
+	drm_dp_dpcd_writeb(&dp->aux, DP_TRAINING_PATTERN_SET, 0);
+
+	cix_dp_write(dp, CIX_DPTX_TRAINING_PATTERN_SET, 0);
+	cix_dp_write(dp, CIX_DPTX_DISABLE_SCRAMBLING, 0);
+}
+
+static int cix_dp_train(struct cix_dp *dp)
+{
+	int ret;
+
+	ret = cix_dp_link_configure(dp);
+	if (ret < 0)
+		return ret;
+
+	cix_dp_write(dp, CIX_DPTX_DISABLE_SCRAMBLING, 1);
+	memset(dp->train_set, 0, sizeof(dp->train_set));
+
+	ret = cix_dp_link_train_clock_recovery(dp);
+	if (ret)
+		goto end;
+
+	ret = cix_dp_link_train_channel_equalization(dp);
+
+end:
+	cix_dp_train_end(dp);
+
+	return ret;
+}
+
+static void cix_dp_mode_set_transfer_unit(struct cix_dp *dp,
+					  int stream_id,
+					  struct drm_display_mode *mode,
+					  int bpp)
+{
+	u32 tu = CIX_DPTX_MSA_TRANSFER_UNIT_SIZE_TU_SIZE_DEF;
+	u32 bw;
+	u32 video_kbytes;
+	u32 bytes_per_tu_scaled;
+	u32 symbols_per_tu;
+	u32 frac_symbols_per_tu;
+
+	video_kbytes = mode->clock * bpp / 8;
+	bw = drm_dp_bw_code_to_link_rate(dp->mode.bw_code);
+
+	/*
+	 * Scaled by 1000 (fixed point) so the fraction below can be split
+	 * into integer symbols + 1/16 fractional symbols without floating
+	 * point.
+	 */
+	bytes_per_tu_scaled = video_kbytes * tu /
+			      (dp->mode.lane_cnt * bw / 1000);
+
+	/* bit 23:16 - SYMBOLS_PER_TU */
+	symbols_per_tu = (bytes_per_tu_scaled / 1000) & 0xff;
+	tu |= (symbols_per_tu << 16);
+
+	/*
+	 * bit 27:24 - FRAC_SYMBOLS_PER_TU: sets the fractional number of
+	 * valid symbols per TU in units of 1/16th. An accumulator is used
+	 * to increase the number of data per transaction unit by 1 every
+	 * 1/N TUs.
+	 */
+	frac_symbols_per_tu = ((bytes_per_tu_scaled % 1000) * 16 / 1000) & 0x0f;
+	tu |= (frac_symbols_per_tu << 24);
+
+	cix_dp_write(dp, CIX_DPTX_TU_CONFIG(stream_id), tu);
+}
+
+static void cix_dp_mode_set_timing(struct cix_dp *dp, int stream_id,
+				   struct drm_display_mode *mode, int bpp)
+{
+	u8 lane_cnt = dp->mode.lane_cnt;
+	u32 data_control = CIX_DPTX_DATA_CONTROL_DEFAULT;
+	u32 value;
+
+	if (dp->pixel_per_cycle == 2 && dp->mode.lane_cnt == 4 &&
+	    dp->mode.link_rate == 810000)
+		data_control = CIX_DPTX_DATA_CONTROL_2PPC_4LANE_HBR3;
+
+	cix_dp_write(dp, CIX_DPTX_MAIN_STREAM_HTOTAL(stream_id), mode->htotal);
+	cix_dp_write(dp, CIX_DPTX_MAIN_STREAM_VTOTAL(stream_id), mode->vtotal);
+
+	value = (!!(mode->flags & DRM_MODE_FLAG_PVSYNC)
+		 << CIX_DPTX_MAIN_STREAM_POLARITY_VSYNC_SHIFT) |
+		(!!(mode->flags & DRM_MODE_FLAG_PHSYNC)
+		 << CIX_DPTX_MAIN_STREAM_POLARITY_HSYNC_SHIFT);
+
+	cix_dp_write(dp, CIX_DPTX_MAIN_STREAM_POLARITY(stream_id), value);
+	cix_dp_write(dp, CIX_DPTX_USER_SYNC_POLARITY(stream_id),
+		     CIX_DPTX_MAIN_STREAM_POLARITY_DATAENABLE_HIGH | value);
+
+	cix_dp_write(dp, CIX_DPTX_MAIN_STREAM_HSWIDTH(stream_id),
+		     mode->hsync_end - mode->hsync_start);
+	cix_dp_write(dp, CIX_DPTX_MAIN_STREAM_VSWIDTH(stream_id),
+		     mode->vsync_end - mode->vsync_start);
+	cix_dp_write(dp, CIX_DPTX_MAIN_STREAM_HRES(stream_id), mode->hdisplay);
+	cix_dp_write(dp, CIX_DPTX_MAIN_STREAM_VRES(stream_id), mode->vdisplay);
+	cix_dp_write(dp, CIX_DPTX_MAIN_STREAM_HSTART(stream_id),
+		     mode->htotal - mode->hsync_start);
+	cix_dp_write(dp, CIX_DPTX_MAIN_STREAM_VSTART(stream_id),
+		     mode->vtotal - mode->vsync_start);
+
+	value = ((mode->hdisplay * bpp + 7) / 8 + lane_cnt - 1) / lane_cnt;
+	cix_dp_write(dp, CIX_DPTX_USER_DATA_COUNT(stream_id), value);
+
+	value = (mode->htotal - mode->hdisplay) *
+		(dp->mode.link_rate / 40) * 9 / mode->clock;
+
+	cix_dp_write(dp, CIX_DPTX_SECONDARY_DATA_WINDOW(stream_id), value);
+	cix_dp_write(dp, CIX_DPTX_DATA_CONTROL(stream_id), data_control);
+	cix_dp_write(dp, CIX_DPTX_USER_PIXEL_COUNT(stream_id),
+		     dp->pixel_per_cycle);
+}
+
+static struct drm_display_mode *cix_dp_get_mode(struct cix_dp *dp,
+						int stream_id)
+{
+	struct drm_crtc *crtc;
+
+	if (stream_id < 0 || stream_id >= dp->max_streams)
+		return NULL;
+
+	if (!dp->active_panels[stream_id] || !dp->bridge.encoder)
+		return NULL;
+
+	crtc = dp->bridge.encoder->crtc;
+	if (!crtc || !crtc->state)
+		return NULL;
+
+	return &crtc->state->adjusted_mode;
+}
+
+/*
+ * Link retraining can lower the bandwidth or the lane count while a stream
+ * is already enabled. TU and timing were programmed for the previous link,
+ * so write them again from the trained mode.
+ */
+static void cix_dp_update_active_streams(struct cix_dp *dp)
+{
+	struct cix_dp_panel *panel;
+	struct drm_display_mode *mode;
+	int bpp;
+	int i;
+
+	for (i = 0; i < dp->max_streams; i++) {
+		panel = dp->active_panels[i];
+		if (!panel || !panel->connector)
+			continue;
+
+		mode = cix_dp_get_mode(dp, i);
+		if (!mode)
+			continue;
+
+		bpp = panel->connector->config.bpp;
+		cix_dp_mode_set_transfer_unit(dp, panel->source_id, mode,
+					      bpp);
+		cix_dp_mode_set_timing(dp, panel->source_id, mode, bpp);
+	}
+}
+
+static int cix_dp_train_loop(struct cix_dp *dp)
+{
+	struct cix_dp_mode *mode = &dp->mode;
+	u8 bpp = dp->connector.config.bpp;
+	u8 prev_bw = mode->bw_code;
+	u8 prev_lanes = mode->lane_cnt;
+	u8 bw_code = mode->bw_code;
+	int i;
+	int j;
+	int ret;
+
+	for (i = 0; i < DP_MAX_TRAINING_LOOP; i++) {
+		for (j = 0; j <= 3; j++) {
+			if (!(dp->state & DPTX_STATE_READY))
+				return 0;
+
+			ret = cix_dp_train(dp);
+			if (!ret) {
+				if (dp->active_stream_cnt &&
+				    (mode->bw_code != prev_bw ||
+				     mode->lane_cnt != prev_lanes))
+					cix_dp_update_active_streams(dp);
+				return 0;
+			}
+
+			ret = cix_dp_mode_configure(dp, mode->pclock, bw_code,
+						    bpp, true);
+			if (ret < 0)
+				break;
+
+			bw_code = dp->mode.bw_code;
+		}
+
+		ret = cix_dp_mode_configure(dp, mode->pclock, 0, bpp, true);
+		if (ret < 0)
+			return ret;
+
+		bw_code = dp->mode.bw_code;
+	}
+
+	return -EIO;
+}
+
+static int cix_dp_aux_cmd_submit(struct cix_dp *dp, u32 cmd, u32 addr,
+				 u8 *buf, u32 bytes, u8 *reply)
+{
+	bool is_read = cmd & AUX_READ_BIT;
+	u32 value;
+	int i, ret;
+
+	value = cix_dp_read(dp, CIX_DPTX_AUX_STATUS);
+	if (value & (CIX_DPTX_AUX_STATUS_REQUEST_IN_PROGRESS |
+		     CIX_DPTX_AUX_STATUS_REPLY_IN_PROGRESS))
+		return -EBUSY;
+
+	cix_dp_write(dp, CIX_DPTX_AUX_ADDRESS, addr);
+
+	if (!is_read)
+		for (i = 0; i < bytes; i++)
+			cix_dp_write(dp, CIX_DPTX_AUX_WRITE_FIFO, buf[i]);
+
+	value = cmd << CIX_DPTX_AUX_COMMAND_CMD_SHIFT;
+	if (!buf || !bytes)
+		value |= CIX_DPTX_AUX_COMMAND_ADDRESS_ONLY;
+	else
+		value |= (bytes - 1) << CIX_DPTX_AUX_COMMAND_BYTES_SHIFT;
+
+	cix_dp_write(dp, CIX_DPTX_AUX_COMMAND, value);
+
+	ret = readl_poll_timeout(dp->dp_iomem + CIX_DPTX_AUX_STATUS, value,
+				 value & (CIX_DPTX_AUX_STATUS_REPLY_RECEIVED |
+					  CIX_DPTX_AUX_STATUS_REPLY_ERROR),
+				 1000, 4000);
+	if (ret)
+		return -ETIMEDOUT;
+	if (value & CIX_DPTX_AUX_STATUS_REPLY_ERROR)
+		return -ETIMEDOUT;
+	if (!(value & CIX_DPTX_AUX_STATUS_REPLY_RECEIVED))
+		return -ETIMEDOUT;
+
+	value = cix_dp_read(dp, CIX_DPTX_AUX_REPLY_CODE);
+	if (reply)
+		*reply = value;
+
+	if (is_read &&
+	    (value == CIX_DPTX_AUX_REPLY_CODE_AUX_ACK ||
+	     value == CIX_DPTX_AUX_REPLY_CODE_I2C_ACK)) {
+		value = cix_dp_read(dp, CIX_DPTX_AUX_REPLY_DATA_COUNT);
+		if ((value & CIX_DPTX_REPLY_DATA_COUNT_MASK) != bytes)
+			return -EIO;
+
+		for (i = 0; i < bytes; i++)
+			buf[i] = cix_dp_read(dp, CIX_DPTX_AUX_REPLY_DATA);
+	}
+
+	return 0;
+}
+
+static ssize_t cix_dp_aux_transfer(struct drm_dp_aux *aux,
+				   struct drm_dp_aux_msg *msg)
+{
+	struct cix_dp *dp = container_of(aux, struct cix_dp, aux);
+	size_t to_access = 0;
+	size_t accessed_bytes = 0;
+	u32 reply_mask;
+	u32 reply_ack;
+	u32 state;
+	ssize_t ret;
+
+	/*
+	 * AUX has its own lock instead of session_lock: the driver calls
+	 * drm_dp_*() helpers while holding session_lock, and those helpers
+	 * re-enter aux->transfer. host_init() and host_deinit() take this
+	 * lock while they enable or gate the APB clock.
+	 */
+	mutex_lock(&dp->aux_lock);
+
+	state = READ_ONCE(dp->state);
+	if (!(state & DPTX_STATE_INITIALIZED) ||
+	    (state & DPTX_STATE_SUSPENDED) ||
+	    (!cix_dp_get_hpd_state(dp) && !READ_ONCE(dp->aux_ignore_hpd))) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	/*
+	 * A native transaction only reports the native reply; an I2C-over-AUX
+	 * transaction reports both the native and the I2C reply. Check only
+	 * the reply fields that the request type actually uses.
+	 */
+	switch (msg->request) {
+	case DP_AUX_NATIVE_WRITE:
+	case DP_AUX_NATIVE_READ:
+		reply_mask = DP_AUX_NATIVE_REPLY_MASK;
+		reply_ack = DP_AUX_NATIVE_REPLY_ACK;
+		break;
+	default:
+		reply_mask = DP_AUX_NATIVE_REPLY_MASK | DP_AUX_I2C_REPLY_MASK;
+		reply_ack = DP_AUX_NATIVE_REPLY_ACK | DP_AUX_I2C_REPLY_ACK;
+		break;
+	}
+
+	do {
+		to_access = min_t(size_t, DP_AUX_MAX_PAYLOAD_BYTES,
+				  msg->size - accessed_bytes);
+		ret = cix_dp_aux_cmd_submit(dp, msg->request,
+					    msg->address + accessed_bytes,
+					    msg->buffer + accessed_bytes,
+					    to_access, &msg->reply);
+		if (ret) {
+			ret = accessed_bytes ? (ssize_t)accessed_bytes : ret;
+			goto out;
+		}
+
+		/*
+		 * NACK and DEFER are reported through msg->reply. Stop here
+		 * so a later chunk cannot overwrite that reply.
+		 */
+		if ((msg->reply & reply_mask) != reply_ack) {
+			ret = accessed_bytes;
+			goto out;
+		}
+
+		accessed_bytes += to_access;
+	} while (accessed_bytes < msg->size);
+
+	ret = msg->size;
+out:
+	mutex_unlock(&dp->aux_lock);
+	return ret;
+}
+
+static int cix_dp_aux_register(struct cix_dp *dp)
+{
+	int ret;
+
+	dp->aux.name = "Cix DP AUX";
+	dp->aux.dev = dp->dev;
+	dp->aux.drm_dev = dp->drm;
+	dp->aux.transfer = cix_dp_aux_transfer;
+
+	ret = drm_dp_aux_register(&dp->aux);
+	if (ret)
+		return ret;
+
+	dp->aux_registered = true;
+
+	return 0;
+}
+
+static void cix_dp_aux_clk_divider(struct cix_dp *dp)
+{
+	unsigned int rate;
+
+	rate = dp->aux_clock_divider;
+	if (!rate) {
+		if (!IS_ERR_OR_NULL(dp->apb_clk))
+			rate = clk_get_rate(dp->apb_clk) / (1000 * 1000);
+		if (!rate)
+			rate = 25;
+		dp->aux_clock_divider = rate;
+	}
+
+	cix_dp_write(dp, CIX_DPTX_AUX_CLOCK_DIVIDER, rate);
+}
+
+static void cix_dp_aux_cleanup(struct cix_dp *dp)
+{
+	if (!dp->aux_registered)
+		return;
+
+	drm_dp_aux_unregister(&dp->aux);
+	dp->aux.drm_dev = NULL;
+	dp->aux_registered = false;
+}
+
+static int cix_dpcd_power_up(struct cix_dp *dp)
+{
+	struct drm_dp_aux *aux = &dp->aux;
+	u8 value;
+	int ret;
+
+	ret = drm_dp_dpcd_readb(aux, DP_SET_POWER, &value);
+	if (ret < 0)
+		return ret;
+
+	value = (value & ~DP_SET_POWER_MASK) | DP_SET_POWER_D0;
+
+	ret = drm_dp_dpcd_writeb(aux, DP_SET_POWER, value);
+	if (ret < 0)
+		return ret;
+
+	msleep(cix_dp_power_on_delay_ms);
+
+	return 0;
+}
+
+static int cix_dpcd_power_down(struct cix_dp *dp)
+{
+	struct drm_dp_aux *aux = &dp->aux;
+	u8 value;
+	int ret;
+
+	if (!cix_dp_get_hpd_state(dp))
+		return 0;
+
+	ret = drm_dp_dpcd_readb(aux, DP_SET_POWER, &value);
+	if (ret < 0)
+		return ret;
+
+	value = (value & ~DP_SET_POWER_MASK) | DP_SET_POWER_D3;
+
+	ret = drm_dp_dpcd_writeb(aux, DP_SET_POWER, value);
+	if (ret < 0)
+		return ret;
+
+	usleep_range(200, 205);
+
+	return 0;
+}
+
+static void cix_dp_update_misc(struct cix_dp *dp, int stream_id,
+			       struct cix_dp_config *config)
+{
+	cix_dp_write(dp, CIX_DPTX_MAIN_STREAM_MISC0(stream_id), config->misc0);
+	cix_dp_write(dp, CIX_DPTX_MAIN_STREAM_MISC1(stream_id), config->misc1);
+	cix_dp_write(dp, CIX_DPTX_MAIN_STREAM_OVERRIDE(stream_id),
+		     config->override);
+}
+
+static bool cix_dp_needs_vsc_sdp(enum cix_dp_format output_format,
+				 int colorspace)
+{
+	if (output_format == CIX_DP_FORMAT_YCBCR420)
+		return true;
+
+	switch (colorspace) {
+	case DRM_MODE_COLORIMETRY_SYCC_601:
+	case DRM_MODE_COLORIMETRY_OPYCC_601:
+	case DRM_MODE_COLORIMETRY_BT2020_YCC:
+	case DRM_MODE_COLORIMETRY_BT2020_RGB:
+	case DRM_MODE_COLORIMETRY_BT2020_CYCC:
+		return true;
+	default:
+		break;
+	}
+
+	return false;
+}
+
+static int cix_dp_set_misc(struct cix_dp *dp,
+			   struct cix_dp_panel *dp_panel)
+{
+	struct cix_dp_config *config;
+
+	if (!dp_panel || !dp_panel->connector)
+		return -EINVAL;
+
+	config = &dp_panel->connector->config;
+
+	/*
+	 * YCbCr 4:2:0 is only signalled by a VSC SDP. Programming it into the
+	 * RCSU adapter without that SDP leaves the sink with no pixel format.
+	 */
+	if (config->format == CIX_DP_FORMAT_YCBCR420 &&
+	    !dp->caps.vsc_supported)
+		return -EINVAL;
+
+	config->misc0 &= ~CIX_DPTX_STREAM_MISC0_SYNC_LOCK;
+	config->misc1 &= ~CIX_DPTX_VSC_COLORIMETRY_EN;
+	config->override = 0;
+
+	if (dp->caps.vsc_supported &&
+	    cix_dp_needs_vsc_sdp(config->format, config->colorspace)) {
+		config->misc1 |= CIX_DPTX_VSC_COLORIMETRY_EN;
+
+		switch (config->bpc) {
+		case 6:
+			config->override = CIX_DPTX_STREAM_OVERRIDE_BPC_6;
+			break;
+		case 8:
+			config->override = CIX_DPTX_STREAM_OVERRIDE_BPC_8;
+			break;
+		case 10:
+			config->override = CIX_DPTX_STREAM_OVERRIDE_BPC_10;
+			break;
+		case 12:
+			config->override = CIX_DPTX_STREAM_OVERRIDE_BPC_12;
+			break;
+		case 16:
+			config->override = CIX_DPTX_STREAM_OVERRIDE_BPC_16;
+			break;
+		default:
+			config->override = CIX_DPTX_STREAM_OVERRIDE_BPC_8;
+			break;
+		}
+
+		switch (config->format) {
+		case CIX_DP_FORMAT_YCBCR444:
+			config->override |= CIX_DPTX_STREAM_OVERRIDE_YCbCR_444;
+			break;
+		case CIX_DP_FORMAT_YCBCR422:
+			config->override |= CIX_DPTX_STREAM_OVERRIDE_YCbCR_422;
+			break;
+		case CIX_DP_FORMAT_YCBCR420:
+			config->override |= CIX_DPTX_STREAM_OVERRIDE_YCbCR_420;
+			break;
+		default:
+			break;
+		}
+
+		config->override |= CIX_DPTX_STREAM_OVERRIDE_ENABLE;
+		config->dynamic_range = DP_DYNAMIC_RANGE_CTA;
+
+		goto end;
+	}
+
+	config->misc0 &= ~CIX_DPTX_STREAM_MISC0_COMP_FORMAT_MASK;
+	config->misc1 &= ~CIX_DPTX_STREAM_MISC1_Y_ONLY_EN;
+
+	switch (config->format) {
+	case CIX_DP_FORMAT_RGB:
+		config->misc0 |= CIX_DPTX_STREAM_MISC0_COMP_FORMAT_RGB;
+		break;
+
+	case CIX_DP_FORMAT_YCBCR444:
+		config->misc0 |= CIX_DPTX_STREAM_MISC0_COMP_FORMAT_YCRCB_444;
+		break;
+
+	case CIX_DP_FORMAT_YCBCR422:
+		config->misc0 |= CIX_DPTX_STREAM_MISC0_COMP_FORMAT_YCRCB_422;
+		break;
+
+	case CIX_DP_FORMAT_YONLY:
+		config->misc1 |= CIX_DPTX_STREAM_MISC1_Y_ONLY_EN;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	config->misc0 &= ~CIX_DPTX_STREAM_MISC0_BPC_MASK;
+
+	switch (config->bpc) {
+	case 6:
+		config->misc0 |= CIX_DPTX_STREAM_MISC0_BPC_6;
+		break;
+	case 8:
+		config->misc0 |= CIX_DPTX_STREAM_MISC0_BPC_8;
+		break;
+	case 10:
+		config->misc0 |= CIX_DPTX_STREAM_MISC0_BPC_10;
+		break;
+	case 12:
+		config->misc0 |= CIX_DPTX_STREAM_MISC0_BPC_12;
+		break;
+	case 16:
+		config->misc0 |= CIX_DPTX_STREAM_MISC0_BPC_16;
+		break;
+	default:
+		config->misc0 |= CIX_DPTX_STREAM_MISC0_BPC_8;
+		break;
+	}
+
+end:
+	cix_dp_update_misc(dp, dp_panel->source_id, config);
+	return 0;
+}
+
+static void cix_dp_cfg_adapter(struct cix_dp *dp, int pipe_id)
+{
+	struct cix_rcsu_video_bits fmt_bits;
+	u32 value;
+	int offset;
+
+	if (dp->native_dp) {
+		/* Native DP/eDP transmitter */
+		offset = CFG_ADAPTER_VIDEO_OFFSET_DP2;
+		if (pipe_id == 0) {
+			fmt_bits.fmt_mask = GENMASK(18, 17);
+			fmt_bits.yuv422 = FIELD_PREP(GENMASK(18, 17), 2);
+			fmt_bits.yuv420 = FIELD_PREP(GENMASK(18, 17), 3);
+			fmt_bits.ppc_bit = BIT(16);
+		} else {
+			fmt_bits.fmt_mask = GENMASK(21, 20);
+			fmt_bits.yuv422 = FIELD_PREP(GENMASK(21, 20), 2);
+			fmt_bits.yuv420 = FIELD_PREP(GENMASK(21, 20), 3);
+			fmt_bits.ppc_bit = BIT(19);
+		}
+	} else {
+		/* USB-C DP transmitter */
+		offset = pipe_id == 0 ? CFG_ADAPTER_VIDEO0_OFFSET :
+				       CFG_ADAPTER_VIDEO1_OFFSET;
+		if (pipe_id == 0) {
+			fmt_bits.fmt_mask = GENMASK(31, 30);
+			fmt_bits.yuv422 = FIELD_PREP(GENMASK(31, 30), 2);
+			fmt_bits.yuv420 = FIELD_PREP(GENMASK(31, 30), 3);
+			fmt_bits.ppc_bit = BIT(29);
+		} else {
+			fmt_bits.fmt_mask = GENMASK(20, 19);
+			fmt_bits.yuv422 = FIELD_PREP(GENMASK(20, 19), 2);
+			fmt_bits.yuv420 = FIELD_PREP(GENMASK(20, 19), 3);
+			fmt_bits.ppc_bit = BIT(18);
+		}
+	}
+
+	value = readl(dp->rcsu_iomem + offset);
+
+	value &= ~fmt_bits.fmt_mask;
+	if (dp->connector.config.format == CIX_DP_FORMAT_YCBCR422)
+		value |= fmt_bits.yuv422;
+	else if (dp->connector.config.format == CIX_DP_FORMAT_YCBCR420)
+		value |= fmt_bits.yuv420;
+
+	if (dp->pixel_per_cycle == 2)
+		value |= fmt_bits.ppc_bit;
+	else
+		value &= ~fmt_bits.ppc_bit;
+
+	writel(value, dp->rcsu_iomem + offset);
+}
+
+static void dptx_infoframe_write_content(struct cix_dp *dp, u32 stream_id,
+					 struct dp_sdp *sdp)
+{
+	int i;
+
+	cix_dp_write(dp, CIX_DPTX_INFOFRAME_DATA(stream_id),
+		     sdp->sdp_header.HB0);
+	cix_dp_write(dp, CIX_DPTX_INFOFRAME_DATA(stream_id),
+		     sdp->sdp_header.HB1);
+	cix_dp_write(dp, CIX_DPTX_INFOFRAME_DATA(stream_id),
+		     sdp->sdp_header.HB2);
+	cix_dp_write(dp, CIX_DPTX_INFOFRAME_DATA(stream_id),
+		     sdp->sdp_header.HB3);
+
+	for (i = 0; i < DPTX_SDP_DB_MAX; i++)
+		cix_dp_write(dp, CIX_DPTX_INFOFRAME_DATA(stream_id),
+			     sdp->db[i]);
+}
+
+static void dptx_infoframe_select_buffer_pre(struct cix_dp *dp,
+					     u32 stream_id, u32 select)
+{
+	u32 value;
+
+	value = cix_dp_read(dp, CIX_DPTX_INFOFRAME_ENABLE(stream_id));
+	cix_dp_write(dp, CIX_DPTX_INFOFRAME_ENABLE(stream_id),
+		     value & ~(1 << select));
+	cix_dp_write(dp, CIX_DPTX_INFOFRAME_SELECT(stream_id), select);
+}
+
+static void dptx_infoframe_select_buffer_end(struct cix_dp *dp,
+					     u32 stream_id, u32 select)
+{
+	u32 value;
+
+	value = cix_dp_read(dp, CIX_DPTX_INFOFRAME_ENABLE(stream_id));
+	cix_dp_write(dp, CIX_DPTX_INFOFRAME_ENABLE(stream_id),
+		     value | (1 << select));
+}
+
+static void dptx_infoframe_rate(struct cix_dp *dp, u32 stream_id, u32 select,
+				u32 rate)
+{
+	u32 value = cix_dp_read(dp, CIX_DPTX_INFOFRAME_RATE(stream_id));
+
+	if (rate)
+		cix_dp_write(dp, CIX_DPTX_INFOFRAME_RATE(stream_id),
+			     value | (1 << select));
+	else
+		cix_dp_write(dp, CIX_DPTX_INFOFRAME_RATE(stream_id),
+			     value & ~(1 << select));
+}
+
+static void infoframe_write_packet(struct cix_dp *dp, u32 stream_id,
+				   u32 select, struct dp_sdp *sdp, u32 rate)
+{
+	if (stream_id >= DPTX_MST_SOURCE_NUMBER)
+		return;
+
+	if (select >= CIX_MAX_SDP)
+		return;
+
+	dptx_infoframe_select_buffer_pre(dp, stream_id, select);
+	dptx_infoframe_write_content(dp, stream_id, sdp);
+	dptx_infoframe_rate(dp, stream_id, select, rate);
+	dptx_infoframe_select_buffer_end(dp, stream_id, select);
+}
+
+static enum dp_pixelformat cix_dp_vsc_pixelformat(enum cix_dp_format format)
+{
+	switch (format) {
+	case CIX_DP_FORMAT_YCBCR444:
+		return DP_PIXELFORMAT_YUV444;
+	case CIX_DP_FORMAT_YCBCR422:
+		return DP_PIXELFORMAT_YUV422;
+	case CIX_DP_FORMAT_YCBCR420:
+		return DP_PIXELFORMAT_YUV420;
+	case CIX_DP_FORMAT_YONLY:
+		return DP_PIXELFORMAT_Y_ONLY;
+	case CIX_DP_FORMAT_RGB:
+	default:
+		return DP_PIXELFORMAT_RGB;
+	}
+}
+
+static enum dp_colorimetry cix_dp_vsc_colorimetry(enum cix_dp_format format,
+						  u32 colorspace)
+{
+	switch (colorspace) {
+	case DRM_MODE_COLORIMETRY_BT709_YCC:
+		return DP_COLORIMETRY_BT709_YCC;
+	case DRM_MODE_COLORIMETRY_XVYCC_601:
+		return DP_COLORIMETRY_XVYCC_601;
+	case DRM_MODE_COLORIMETRY_XVYCC_709:
+		return DP_COLORIMETRY_XVYCC_709;
+	case DRM_MODE_COLORIMETRY_SYCC_601:
+		return DP_COLORIMETRY_SYCC_601;
+	case DRM_MODE_COLORIMETRY_OPYCC_601:
+		return DP_COLORIMETRY_OPYCC_601;
+	case DRM_MODE_COLORIMETRY_BT2020_CYCC:
+		return DP_COLORIMETRY_BT2020_CYCC;
+	case DRM_MODE_COLORIMETRY_BT2020_RGB:
+		return DP_COLORIMETRY_BT2020_RGB;
+	case DRM_MODE_COLORIMETRY_BT2020_YCC:
+		return DP_COLORIMETRY_BT2020_YCC;
+	case DRM_MODE_COLORIMETRY_DCI_P3_RGB_D65:
+	case DRM_MODE_COLORIMETRY_DCI_P3_RGB_THEATER:
+		return DP_COLORIMETRY_DCI_P3_RGB;
+	default:
+		break;
+	}
+
+	/* Unspecified RGB is sRGB. Unspecified YCbCr is BT.709. */
+	if (format == CIX_DP_FORMAT_RGB)
+		return DP_COLORIMETRY_DEFAULT;
+
+	return DP_COLORIMETRY_BT709_YCC;
+}
+
+static int dptx_setup_vsc_sdp(struct dp_sdp *sdp,
+			      struct cix_dp_config *config)
+{
+	struct drm_dp_vsc_sdp vsc = {};
+	ssize_t len;
+
+	vsc.sdp_type = DP_SDP_VSC;
+	vsc.revision = 0x5;
+	vsc.length = 0x13;
+	vsc.pixelformat = cix_dp_vsc_pixelformat(config->format);
+	vsc.colorimetry = cix_dp_vsc_colorimetry(config->format,
+						 config->colorspace);
+	switch (config->bpc) {
+	case 6:
+	case 8:
+	case 10:
+	case 12:
+	case 16:
+		vsc.bpc = config->bpc;
+		break;
+	default:
+		vsc.bpc = 8;
+		break;
+	}
+	vsc.dynamic_range = config->dynamic_range;
+	vsc.content_type = config->content_type;
+
+	/*
+	 * drm_dp_vsc_sdp_pack() clears the packet, so a later modeset cannot
+	 * keep the previous pixel format or colorimetry.
+	 */
+	len = drm_dp_vsc_sdp_pack(&vsc, sdp);
+	if (len < 0)
+		return len;
+
+	return 0;
+}
+
+static int cix_dp_panel_setup_colorimetry_sdp(struct cix_dp *dp,
+					      struct cix_dp_panel *dp_panel)
+{
+	struct cix_connector *conn = dp_panel->connector;
+
+	if (conn->config.override & CIX_DPTX_STREAM_OVERRIDE_ENABLE) {
+		int ret;
+
+		ret = dptx_setup_vsc_sdp(&conn->sdp[CIX_VSC_SDP],
+					 &conn->config);
+		if (ret)
+			return ret;
+
+		infoframe_write_packet(dp, dp_panel->source_id, CIX_VSC_SDP,
+				       &conn->sdp[CIX_VSC_SDP], 1);
+	}
+
+	return 0;
+}
+
+static int cix_dp_ctrl_enable_stream_clocks(struct cix_dp *dp,
+					    int stream_id, bool enable)
+{
+	struct clk *stream_clk;
+	int ret;
+
+	if (stream_id < 0 || stream_id >= DP_STREAM_MAX)
+		return -EINVAL;
+
+	stream_clk = dp->stream_clk[stream_id];
+	if (IS_ERR_OR_NULL(stream_clk))
+		return -EINVAL;
+
+	if (enable) {
+		ret = clk_prepare_enable(stream_clk);
+		if (ret)
+			return ret;
+	} else {
+		clk_disable_unprepare(stream_clk);
+	}
+
+	return 0;
+}
+
+static int cix_dp_panel_hw_cfg(struct cix_dp *dp, int stream_id)
+{
+	struct cix_dp_panel *dp_panel = dp->active_panels[stream_id];
+	struct drm_display_mode *mode = cix_dp_get_mode(dp, stream_id);
+	struct cix_connector *conn;
+	int ret;
+
+	if (!mode)
+		return -EINVAL;
+
+	conn = dp_panel->connector;
+
+	ret = cix_dp_set_misc(dp, dp_panel);
+	if (ret)
+		return ret;
+
+	cix_dp_cfg_adapter(dp, stream_id);
+
+	ret = cix_dp_panel_setup_colorimetry_sdp(dp, dp_panel);
+	if (ret)
+		return ret;
+
+	cix_dp_mode_set_transfer_unit(dp, dp_panel->source_id, mode,
+				      conn->config.bpp);
+	cix_dp_mode_set_timing(dp, dp_panel->source_id, mode, conn->config.bpp);
+	return 0;
+}
+
+static int cix_dp_ctrl_stream_on(struct cix_dp *dp, int stream_id)
+{
+	struct drm_display_mode *mode;
+	struct clk *stream_clk;
+	unsigned long rate;
+	int ret;
+
+	if (stream_id < 0 || stream_id >= dp->max_streams)
+		return -EINVAL;
+
+	mode = cix_dp_get_mode(dp, stream_id);
+	if (!mode)
+		return -EINVAL;
+
+	/*
+	 * Firmware only pre-programs the video clock of the port it drove
+	 * during boot; the others come up without a rate, which leaves the
+	 * stream with no pixel clock. Reading the rate first also refreshes
+	 * the SCMI clock state, without which setting it fails.
+	 */
+	stream_clk = dp->stream_clk[stream_id];
+	if (!IS_ERR_OR_NULL(stream_clk)) {
+		rate = (unsigned long)mode->clock * 1000;
+		if (clk_get_rate(stream_clk) != rate) {
+			ret = clk_set_rate(stream_clk, rate);
+			if (ret)
+				return ret;
+		}
+	}
+
+	ret = cix_dp_ctrl_enable_stream_clocks(dp, stream_id, true);
+	if (ret)
+		return ret;
+
+	ret = cix_dp_panel_hw_cfg(dp, stream_id);
+	if (ret) {
+		cix_dp_ctrl_enable_stream_clocks(dp, stream_id, false);
+		return ret;
+	}
+
+	cix_dp_write(dp, CIX_DPTX_VIDEO_STREAM_ENABLE(stream_id), 1);
+	cix_dp_write(dp, CIX_DPTX_SECONDARY_STREAM_ENABLE(stream_id), 1);
+
+	dp->active_stream_cnt++;
+	return 0;
+}
+
+static int cix_dp_ctrl_stream_off(struct cix_dp *dp, int stream_id)
+{
+	if (stream_id < 0 || stream_id >= dp->max_streams)
+		return -EINVAL;
+
+	cix_dp_write(dp, CIX_DPTX_INFOFRAME_ENABLE(stream_id), 0);
+	cix_dp_write(dp, CIX_DPTX_INFOFRAME_SELECT(stream_id), 0);
+	cix_dp_write(dp, CIX_DPTX_INFOFRAME_RATE(stream_id), 0);
+	cix_dp_write(dp, CIX_DPTX_SECONDARY_STREAM_ENABLE(stream_id), 0);
+	cix_dp_write(dp, CIX_DPTX_VIDEO_STREAM_ENABLE(stream_id), 0);
+
+	cix_dp_ctrl_enable_stream_clocks(dp, stream_id, false);
+
+	dp->active_stream_cnt--;
+	return 0;
+}
+
+static int cix_dp_panel_read_sink_caps(struct cix_dp *dp)
+{
+	struct drm_dp_aux *drm_aux = &dp->aux;
+	struct cix_dp_link_config *config = &dp->link_config;
+	u8 value = 0;
+	u8 lanes;
+	int ret;
+
+	/* Never leave the previous sink's capabilities behind on failure. */
+	memset(&dp->caps, 0, sizeof(dp->caps));
+
+	ret = drm_dp_read_dpcd_caps(drm_aux, dp->dpcd);
+	if (ret)
+		return ret;
+
+	ret = drm_dp_read_downstream_info(drm_aux, dp->dpcd,
+					  dp->downstream_ports);
+	if (ret)
+		return ret;
+
+	dp->caps.enhanced_framing = drm_dp_enhanced_frame_cap(dp->dpcd);
+	dp->caps.tps3_supported = drm_dp_tps3_supported(dp->dpcd);
+	dp->caps.tps4_supported = drm_dp_tps4_supported(dp->dpcd);
+
+	/*
+	 * DP_DPRX_FEATURE_ENUMERATION_LIST is DP 1.3+. A NACK here just means
+	 * an older sink, so degrade to "unsupported" instead of failing.
+	 */
+	if (dp->dpcd[DP_DPCD_REV] >= DP_DPCD_REV_13 &&
+	    drm_dp_dpcd_readb(drm_aux, DP_DPRX_FEATURE_ENUMERATION_LIST,
+			      &value) == 1)
+		dp->caps.vsc_supported =
+			!!(value & DP_VSC_SDP_EXT_FOR_COLORIMETRY_SUPPORTED);
+
+	lanes = drm_dp_max_lane_count(dp->dpcd);
+	if (lanes > 0) {
+		config->max_lanes = min_t(u8, lanes, dp->num_lanes);
+		config->max_rate = min_t(int, drm_dp_max_link_rate(dp->dpcd),
+					 dp->max_rate);
+	}
+
+	return 0;
+}
+
+static int cix_dp_core_on(struct cix_dp *dp)
+{
+	int enable_sources = (1 << dp->dp_panel.source_id);
+	int i;
+	int ret;
+
+	if (dp->state & DPTX_STATE_READY)
+		return 0;
+
+	dp->state |= DPTX_STATE_READY;
+
+	for (i = 0; i < dp->max_streams; i++)
+		cix_dp_write(dp, CIX_DPTX_VIDEO_STREAM_ENABLE(i), 0);
+
+	ret = phy_power_on(dp->phy);
+	if (ret)
+		goto err;
+
+	ret = cix_dpcd_power_up(dp);
+	if (ret)
+		goto err_power;
+
+	ret = cix_dp_panel_read_sink_caps(dp);
+	if (ret)
+		goto err_power;
+
+	ret = cix_dp_train_loop(dp);
+	if (ret)
+		goto err_power;
+
+	cix_dp_write(dp, CIX_DPTX_SOFT_RESET, enable_sources);
+	cix_dp_write(dp, CIX_DPTX_SOURCE_ENABLE, enable_sources);
+	cix_dp_write(dp, CIX_DPTX_FORCE_SCRAMBLER_RESET, enable_sources);
+	cix_dp_write(dp, CIX_DPTX_MST_ENABLE, 0);
+	cix_dp_write(dp, CIX_DPTX_SST_SOURCE_SELECT, dp->dp_panel.source_id);
+
+	dp->state |= DPTX_STATE_INIT_TRAIN;
+
+	return 0;
+
+err_power:
+	phy_power_off(dp->phy);
+err:
+	dp->state &= ~DPTX_STATE_READY;
+	return ret;
+}
+
+static int cix_dp_core_off(struct cix_dp *dp)
+{
+	if (!(dp->state & DPTX_STATE_READY))
+		return 0;
+
+	cix_dpcd_power_down(dp);
+
+	phy_power_off(dp->phy);
+
+	cix_dp_write(dp, CIX_DPTX_MST_ENABLE, 0);
+	cix_dp_write(dp, CIX_DPTX_SOURCE_ENABLE, 0);
+	cix_dp_write(dp, CIX_DPTX_SOFT_RESET, 0);
+	cix_dp_write(dp, CIX_DPTX_FORCE_SCRAMBLER_RESET, 0);
+
+	dp->state &= ~(DPTX_STATE_READY | DPTX_STATE_INIT_TRAIN);
+
+	return 0;
+}
+
+static int reset_dp_and_reinit(struct cix_dp *dp)
+{
+	int ret;
+
+	reset_control_assert(dp->reset);
+	usleep_range(10, 20);
+	reset_control_deassert(dp->reset);
+
+	ret = phy_reset(dp->phy);
+	if (ret)
+		return ret;
+
+	usleep_range(100, 200);
+
+	cix_dp_write(dp, CIX_DPTX_TRANSMITTER_ENABLE, 1);
+	cix_dp_write(dp, CIX_DPTX_INTERRUPT_MASK, CIX_DPTX_INTERRUPT_CFG);
+	cix_dp_aux_clk_divider(dp);
+
+	ret = phy_init(dp->phy);
+	if (ret)
+		return ret;
+
+	return ret;
+}
+
+static int cix_dp_host_init(struct cix_dp *dp)
+{
+	int ret;
+
+	if (dp->state & DPTX_STATE_INITIALIZED)
+		return 0;
+
+	mutex_lock(&dp->aux_lock);
+
+	/*
+	 * APB is shared with the DP PHY. Enable it before phy_init/phy_reset
+	 * and pair phy_init with phy_exit in host_deinit(). Link bring-up uses
+	 * phy_power_on/off from core_on/off only.
+	 */
+	if (!IS_ERR_OR_NULL(dp->apb_clk)) {
+		/*
+		 * Firmware leaves the APB clock of ports the bootloader never
+		 * brought up without a rate, so the whole DP block is dead
+		 * until we program it ourselves.
+		 */
+		if (!clk_get_rate(dp->apb_clk)) {
+			ret = clk_set_rate(dp->apb_clk, CIX_DP_APB_CLK_RATE);
+			if (ret) {
+				dev_err(dp->dev,
+					"failed to set apb clock rate: %d\n",
+					ret);
+				goto out;
+			}
+		}
+
+		ret = clk_prepare_enable(dp->apb_clk);
+		if (ret)
+			goto out;
+	}
+
+	ret = reset_dp_and_reinit(dp);
+	if (ret)
+		goto err_clk;
+
+	dp->state |= DPTX_STATE_INITIALIZED;
+	goto out;
+
+err_clk:
+	if (!IS_ERR_OR_NULL(dp->apb_clk))
+		clk_disable_unprepare(dp->apb_clk);
+out:
+	mutex_unlock(&dp->aux_lock);
+	return ret;
+}
+
+static void cix_dp_host_deinit(struct cix_dp *dp)
+{
+	if (dp->active_stream_cnt)
+		return;
+
+	/* Suspend can arrive before the failed enable rolls the PHY back. */
+	if (dp->state & DPTX_STATE_READY)
+		cix_dp_core_off(dp);
+
+	if (!(dp->state & DPTX_STATE_INITIALIZED))
+		return;
+
+	mutex_lock(&dp->aux_lock);
+
+	/* Drop DPTx state while APB is still held by this driver. */
+	cix_dp_write(dp, CIX_DPTX_TRANSMITTER_ENABLE, 0);
+	cix_dp_write(dp, CIX_DPTX_INTERRUPT_MASK,
+		     CIX_DPTX_INTERRUPT_MASK_ALL);
+
+	phy_exit(dp->phy);
+
+	/*
+	 * Balance host_init; do not use __clk_is_enabled() with a shared
+	 * clock.
+	 */
+	if (!IS_ERR_OR_NULL(dp->apb_clk))
+		clk_disable_unprepare(dp->apb_clk);
+
+	dp->state &= ~(DPTX_STATE_INITIALIZED | DPTX_STATE_INIT_TRAIN);
+
+	mutex_unlock(&dp->aux_lock);
+}
+
+/*
+ * Undo cix_dp_pm_prepare(). The display controller can enable the pipeline
+ * before this device's resume callback runs, so both paths share it.
+ * enable_irq() stays paired with that one disable_irq().
+ */
+static int cix_dp_resume_locked(struct cix_dp *dp)
+{
+	int ret;
+
+	lockdep_assert_held(&dp->session_lock);
+
+	if (!(dp->state & DPTX_STATE_SUSPENDED))
+		return 0;
+
+	ret = cix_dp_host_init(dp);
+	if (ret)
+		return ret;
+
+	if (READ_ONCE(dp->irq_suspended)) {
+		enable_irq(dp->irq);
+		WRITE_ONCE(dp->irq_suspended, false);
+	}
+
+	dp->state &= ~DPTX_STATE_SUSPENDED;
+	return 0;
+}
+
+static int cix_dp_handle_connect_locked(struct cix_dp *dp)
+{
+	int ret;
+
+	lockdep_assert_held(&dp->session_lock);
+
+	if (dp->state & DPTX_STATE_CONNECTED)
+		return 0;
+
+	if (dp->state & DPTX_STATE_SUSPENDED)
+		return 0;
+
+	ret = cix_dp_panel_read_sink_caps(dp);
+	if (!ret)
+		dp->state |= DPTX_STATE_CONNECTED;
+
+	return ret;
+}
+
+static int cix_dp_handle_disconnect_locked(struct cix_dp *dp)
+{
+	lockdep_assert_held(&dp->session_lock);
+
+	dp->state &= ~DPTX_STATE_CONNECTED;
+
+	return 0;
+}
+
+/*
+ * Report the HPD level and, when a sink is present, read its DPCD before
+ * mode validation.  cix_dp_handle_connect_locked() is a no-op once that read
+ * has succeeded, so poll and atomic check can call this freely.
+ *
+ * The host is initialized by probe, resume and cix_dp_prepare().  Bail out
+ * loudly if this runs before that: cix_dp_read() is a plain readl() and would
+ * hang on a gated APB clock.  __cix_dp_detect() expects session_lock held so
+ * host_deinit() cannot gate the clock between the check and the readl().
+ */
+static int __cix_dp_detect(struct cix_dp *dp)
+{
+	int ret;
+
+	lockdep_assert_held(&dp->session_lock);
+
+	/*
+	 * This task is the HPD worker and suspend is already published.
+	 * Leave the IRQ and the host down. A modeset on another task still
+	 * goes through cix_dp_resume_locked().
+	 */
+	if ((dp->state & DPTX_STATE_SUSPENDED) &&
+	    READ_ONCE(dp->hpd_worker) == current)
+		return -EBUSY;
+
+	ret = cix_dp_resume_locked(dp);
+	if (ret)
+		return ret;
+
+	if (!(dp->state & DPTX_STATE_INITIALIZED)) {
+		dev_warn_once(dp->dev, "detect with uninitialized host\n");
+		return -ENODEV;
+	}
+
+	if (!cix_dp_get_hpd_state(dp))
+		return -ENODEV;
+
+	cix_dp_handle_connect_locked(dp);
+
+	return 0;
+}
+
+static int cix_dp_detect(struct cix_dp *dp)
+{
+	int ret;
+
+	cix_dp_session_lock(dp);
+	ret = __cix_dp_detect(dp);
+	cix_dp_session_unlock(dp);
+
+	return ret;
+}
+
+static void cix_dp_sw_hpd_irq_work_func(struct work_struct *work)
+{
+	struct cix_dp *dp =
+		container_of(work, struct cix_dp, sw_hpd_irq_work.work);
+
+	if (READ_ONCE(dp->hpd_stopped) ||
+	    (dp->state & DPTX_STATE_SUSPENDED))
+		return;
+
+	/*
+	 * The out-of-band hotplug callback only reports the Type-C plug
+	 * event; handle it like any other IRQ_HPD and let the generic link
+	 * status check decide whether a retrain is needed.
+	 */
+	queue_delayed_work(system_freezable_wq, &dp->hpd_irq_work, 0);
+}
+
+/*
+ * USB-C combo PHY only. Its HPD pin is not wired to this controller, so a
+ * sink that was plugged in before the connector existed never raises
+ * HPD_EVENT. Replay that plug once the PHY is already in DP mode and AUX
+ * answers.
+ *
+ * A native DP port wires HPD to the controller and leaves the PHY mode at
+ * PHY_MODE_INVALID, so the checks below skip it. That port is reported by
+ * the HPD interrupt instead.
+ */
+static void cix_dp_replay_deferred_hotplug(struct cix_dp *dp)
+{
+	struct phy *phy = dp->phy;
+	union phy_configure_opts opts = { 0 };
+	u8 dpcd_rev;
+	ssize_t ret;
+	bool hpd;
+
+	cix_dp_session_lock(dp);
+	if (!cix_dp_regs_accessible(dp) ||
+	    dp->force_hpd != connector_status_unknown) {
+		cix_dp_session_unlock(dp);
+		return;
+	}
+	hpd = cix_dp_get_hpd_state(dp);
+	cix_dp_session_unlock(dp);
+	if (hpd) {
+		/*
+		 * Native HPD may have fired before the connector existed.
+		 * Read the DPCD from the work now that it does.
+		 */
+		schedule_delayed_work(&dp->hpd_event_work, 0);
+		return;
+	}
+
+	phy_validate(phy, PHY_MODE_DP, 0, &opts);
+	if (phy_get_mode(phy) != PHY_MODE_DP)
+		return;
+
+	/*
+	 * The combo PHY is already muxed to DP, so the sink may have been
+	 * plugged in before the connector existed. HPD is unwired here, so
+	 * admit this one AUX transaction before force_hpd is set.
+	 */
+	cix_dp_session_lock(dp);
+	if (!cix_dp_regs_accessible(dp) ||
+	    dp->force_hpd != connector_status_unknown) {
+		cix_dp_session_unlock(dp);
+		return;
+	}
+	dp->aux_ignore_hpd = true;
+	cix_dp_session_unlock(dp);
+
+	ret = drm_dp_dpcd_readb(&dp->aux, DP_DPCD_REV, &dpcd_rev);
+
+	cix_dp_session_lock(dp);
+	dp->aux_ignore_hpd = false;
+	if (ret < 0 || !cix_dp_regs_accessible(dp)) {
+		cix_dp_session_unlock(dp);
+		return;
+	}
+	dp->force_hpd = connector_status_connected;
+	dp->status = connector_status_unknown;
+	cix_dp_session_unlock(dp);
+
+	schedule_delayed_work(&dp->hpd_event_work, 0);
+}
+
+static void cix_dp_hpd_event_work_func(struct work_struct *work)
+{
+	struct cix_dp *dp = container_of(work, struct cix_dp,
+					 hpd_event_work.work);
+	struct phy *phy = dp->phy;
+	union phy_configure_opts opts = { 0 };
+	enum drm_connector_status old_status;
+	enum drm_connector_status status;
+	enum phy_mode mode;
+	bool hpd;
+	int i;
+
+	WRITE_ONCE(dp->hpd_worker, current);
+
+	if (READ_ONCE(dp->hpd_stopped) || !dp->dp_panel.connector)
+		goto out;
+
+	/*
+	 * Sample before the PHY wait. A probe during that wait updates
+	 * dp->status, and reading it afterwards drops the hotplug uevent.
+	 */
+	cix_dp_session_lock(dp);
+	old_status = dp->status;
+	if (READ_ONCE(dp->hpd_stopped) || !dp->dp_panel.connector ||
+	    !cix_dp_regs_accessible(dp)) {
+		cix_dp_session_unlock(dp);
+		goto out;
+	}
+	hpd = cix_dp_get_hpd_state(dp);
+	cix_dp_session_unlock(dp);
+
+	/*
+	 * On a USB-C DP alt-mode PHY the hotplug only becomes valid once the
+	 * PHY has been switched to DP mode, so wait for the mode change.
+	 * A native DP PHY has no ->set_mode() operation, which leaves the
+	 * mode at PHY_MODE_INVALID forever; there is nothing to wait for.
+	 */
+	if (hpd && phy_get_mode(phy) != PHY_MODE_INVALID) {
+		for (i = 0; i < DP_HPD_MAX_TRIES; i++) {
+			phy_validate(phy, PHY_MODE_DP, 0, &opts);
+			mode = phy_get_mode(phy);
+			if (mode == PHY_MODE_DP)
+				break;
+			msleep(100);
+		}
+	}
+
+	cix_dp_session_lock(dp);
+	if (READ_ONCE(dp->hpd_stopped) || !dp->dp_panel.connector ||
+	    !cix_dp_regs_accessible(dp)) {
+		cix_dp_session_unlock(dp);
+		goto out;
+	}
+	cix_dp_session_unlock(dp);
+
+	drm_helper_probe_detect(&dp->connector.base, NULL, false);
+
+	cix_dp_session_lock(dp);
+	status = dp->status;
+	if (READ_ONCE(dp->hpd_stopped) || !dp->dp_panel.connector ||
+	    !cix_dp_regs_accessible(dp)) {
+		cix_dp_session_unlock(dp);
+		goto out;
+	}
+	if (status == connector_status_connected)
+		cix_dp_handle_connect_locked(dp);
+	else
+		cix_dp_handle_disconnect_locked(dp);
+	cix_dp_session_unlock(dp);
+
+	if (old_status != status && dp->drm)
+		drm_helper_hpd_irq_event(dp->drm);
+out:
+	WRITE_ONCE(dp->hpd_worker, NULL);
+}
+
+static void cix_dp_hpd_irq_work_func(struct work_struct *work)
+{
+	struct cix_dp *dp = container_of(work, struct cix_dp,
+					 hpd_irq_work.work);
+	u8 status[DP_LINK_STATUS_SIZE + 2];
+	int ret;
+
+	cix_dp_session_lock(dp);
+
+	if (READ_ONCE(dp->hpd_stopped) ||
+	    !cix_dp_regs_accessible(dp) ||
+	    !(dp->state & DPTX_STATE_ENABLED) ||
+	    !cix_dp_get_hpd_state(dp))
+		goto end;
+
+	ret = drm_dp_dpcd_read(&dp->aux, DP_SINK_COUNT, status,
+			       DP_LINK_STATUS_SIZE + 2);
+	if (ret < 0)
+		goto end;
+
+	if (drm_dp_clock_recovery_ok(&status[2], dp->mode.lane_cnt) &&
+	    drm_dp_channel_eq_ok(&status[2], dp->mode.lane_cnt))
+		goto end;
+
+	cix_dp_train_loop(dp);
+
+end:
+	cix_dp_session_unlock(dp);
+}
+
+/*
+ * INTERRUPT_CAUSE read clears all pending bits (Sky1 DPTX TRM). Do not use
+ * INTERRUPT_STATE for acknowledge; that register is poll-only.
+ */
+static irqreturn_t cix_dp_irq_handler(int irq, void *data)
+{
+	struct cix_dp *dp = data;
+	u32 value;
+	u32 mask;
+
+	value = cix_dp_read(dp, CIX_DPTX_INTERRUPT_CAUSE);
+	mask = cix_dp_read(dp, CIX_DPTX_INTERRUPT_MASK);
+	if (!(value & ~mask))
+		return IRQ_NONE;
+
+	if (value & CIX_DPTX_INTERRUPT_GP_TIMER_IRQ)
+		dev_dbg_ratelimited(dp->dev, "gp tmr\n");
+
+	if (value & CIX_DPTX_INTERRUPT_REPLY_TIMEOUT)
+		dev_dbg_ratelimited(dp->dev, "reply timeout\n");
+
+	if (value & CIX_DPTX_INTERRUPT_REPLY_RECIEVED)
+		dev_dbg_ratelimited(dp->dev, "reply received\n");
+
+	if (READ_ONCE(dp->hpd_stopped))
+		return IRQ_HANDLED;
+
+	if (value & CIX_DPTX_INTERRUPT_HPD_EVENT)
+		queue_delayed_work(system_freezable_wq, &dp->hpd_event_work, 0);
+
+	if (value & CIX_DPTX_INTERRUPT_HPD_IRQ)
+		queue_delayed_work(system_freezable_wq, &dp->hpd_irq_work, 0);
+
+	return IRQ_HANDLED;
+}
+
+/* disable_irq() nests. A failed resume leaves the line already off. */
+static void cix_dp_irq_off(struct cix_dp *dp)
+{
+	if (READ_ONCE(dp->irq_suspended))
+		return;
+
+	disable_irq(dp->irq);
+	WRITE_ONCE(dp->irq_suspended, true);
+}
+
+/* sw_hpd queues hpd_irq, so it has to finish before that work is cancelled. */
+static void cix_dp_cancel_hpd_works(struct cix_dp *dp)
+{
+	cancel_delayed_work_sync(&dp->sw_hpd_irq_work);
+	cancel_delayed_work_sync(&dp->hpd_irq_work);
+	cancel_delayed_work_sync(&dp->hpd_event_work);
+}
+
+/*
+ * Stop hotplug works before the connector goes away. The IRQ line stays
+ * enabled afterwards: the next interrupt still reads (and clears) CAUSE,
+ * but hpd_stopped suppresses scheduling new HPD work.
+ */
+static void cix_dp_quiesce_hpd(struct cix_dp *dp)
+{
+	bool irq_was_off;
+
+	cix_dp_session_lock(dp);
+	WRITE_ONCE(dp->hpd_stopped, true);
+	cix_dp_session_unlock(dp);
+
+	irq_was_off = READ_ONCE(dp->irq_suspended);
+	if (!irq_was_off)
+		disable_irq(dp->irq);
+
+	cix_dp_cancel_hpd_works(dp);
+
+	if (!irq_was_off)
+		enable_irq(dp->irq);
+}
+
+static int cix_dp_pm_prepare(struct cix_dp *dp)
+{
+	if (dp->drm && dp->drm->mode_config.poll_enabled)
+		drm_kms_helper_poll_disable(dp->drm);
+
+	cix_dp_irq_off(dp);
+
+	/*
+	 * Publish SUSPENDED before the cancel. oob and a running HPD
+	 * worker then leave the IRQ and the host down.
+	 */
+	cix_dp_session_lock(dp);
+	dp->state |= DPTX_STATE_SUSPENDED;
+	cix_dp_session_unlock(dp);
+
+	cix_dp_cancel_hpd_works(dp);
+
+	cix_dp_session_lock(dp);
+	if (!dp->active_stream_cnt)
+		cix_dp_host_deinit(dp);
+	dp->status = connector_status_unknown;
+	dp->state &= ~DPTX_STATE_CONNECTED;
+	cix_dp_session_unlock(dp);
+
+	return 0;
+}
+
+static int cix_dp_pm_complete(struct cix_dp *dp)
+{
+	int ret = 0;
+
+	cix_dp_session_lock(dp);
+
+	ret = cix_dp_resume_locked(dp);
+	if (!ret && dp->drm && dp->drm->mode_config.poll_enabled)
+		drm_kms_helper_poll_enable(dp->drm);
+	cix_dp_session_unlock(dp);
+	if (ret)
+		return ret;
+
+	/*
+	 * Suspend cleared DPTX_STATE_CONNECTED. Probe again so mode
+	 * validation sees this sink's DPCD before the next modeset.
+	 */
+	if (!READ_ONCE(dp->hpd_stopped) && dp->dp_panel.connector)
+		schedule_delayed_work(&dp->hpd_event_work, 0);
+
+	return 0;
+}
+
+static int cix_dp_prepare(struct cix_dp *dp)
+{
+	int ret;
+
+	cix_dp_session_lock(dp);
+
+	ret = cix_dp_resume_locked(dp);
+	if (ret)
+		goto end;
+
+	if (dp->state & DPTX_STATE_ENABLED) {
+		ret = 0;
+		goto end;
+	}
+
+	if (!(dp->state & DPTX_STATE_INITIALIZED)) {
+		ret = cix_dp_host_init(dp);
+		if (ret)
+			goto end;
+	} else if (dp->state & DPTX_STATE_READY) {
+		/* core_on() finished, but the stream never became ENABLED. */
+		cix_dp_core_off(dp);
+	}
+
+	if (cix_dp_get_hpd_state(dp) &&
+	    !(dp->state & DPTX_STATE_CONNECTED))
+		cix_dp_handle_connect_locked(dp);
+
+	/*
+	 * Mode selection reads this link_config. Training runs later, after
+	 * that selection, from cix_dp_start_link_locked().
+	 */
+	if (!(cix_dp_get_hpd_state(dp) && (dp->state & DPTX_STATE_CONNECTED))) {
+		ret = -ENODEV;
+		goto end;
+	}
+
+	ret = 0;
+
+end:
+	cix_dp_session_unlock(dp);
+	return ret;
+}
+
+static int cix_dp_unprepare_locked(struct cix_dp *dp)
+{
+	lockdep_assert_held(&dp->session_lock);
+
+	if (dp->active_stream_cnt)
+		return 0;
+
+	if (!(dp->state & (DPTX_STATE_ENABLED | DPTX_STATE_READY)))
+		return 0;
+
+	cix_dp_core_off(dp);
+
+	if (dp->state & DPTX_STATE_SUSPENDED)
+		cix_dp_host_deinit(dp);
+
+	dp->state &= ~DPTX_STATE_ENABLED;
+
+	return 0;
+}
+
+static int cix_dp_unprepare(struct cix_dp *dp)
+{
+	int ret;
+
+	cix_dp_session_lock(dp);
+	ret = cix_dp_unprepare_locked(dp);
+	cix_dp_session_unlock(dp);
+
+	return ret;
+}
+
+static int cix_dp_enable_locked(struct cix_dp *dp, int stream_id)
+{
+	struct cix_dp_panel *dp_panel;
+	int ret;
+
+	lockdep_assert_held(&dp->session_lock);
+
+	if (stream_id < 0 || stream_id >= dp->max_streams)
+		return -EINVAL;
+
+	dp_panel = &dp->dp_panel;
+
+	if (!(dp->state & DPTX_STATE_INITIALIZED) ||
+	    !(dp->state & DPTX_STATE_READY)) {
+		dev_dbg(dp->dev, "enable skipped, state=0x%x\n", dp->state);
+		return 0;
+	}
+
+	dp->active_panels[stream_id] = dp_panel;
+	ret = cix_dp_ctrl_stream_on(dp, stream_id);
+	if (ret) {
+		dp->active_panels[stream_id] = NULL;
+		return ret;
+	}
+
+	dp->state |= DPTX_STATE_ENABLED;
+
+	return 0;
+}
+
+static int cix_dp_disable_locked(struct cix_dp *dp, int stream_id)
+{
+	struct cix_dp_panel *dp_panel;
+	struct cix_connector *conn;
+
+	lockdep_assert_held(&dp->session_lock);
+
+	if (stream_id < 0 || stream_id >= dp->max_streams)
+		return -EINVAL;
+
+	dp_panel = &dp->dp_panel;
+
+	if (!(dp->state & DPTX_STATE_ENABLED))
+		return 0;
+
+	if (!(dp->state & DPTX_STATE_INITIALIZED))
+		return 0;
+
+	if (dp->active_stream_cnt && dp->active_panels[stream_id]) {
+		cix_dp_ctrl_stream_off(dp, stream_id);
+		dp->active_panels[stream_id] = NULL;
+	}
+
+	conn = dp_panel->connector;
+	if (conn)
+		memset(conn->sdp, 0, sizeof(conn->sdp));
+
+	return 0;
+}
+
+static int cix_dp_start_link_locked(struct cix_dp *dp)
+{
+	lockdep_assert_held(&dp->session_lock);
+
+	if (!cix_dp_regs_accessible(dp) ||
+	    !(dp->state & DPTX_STATE_CONNECTED))
+		return -ENODEV;
+
+	return cix_dp_core_on(dp);
+}
+
+static int cix_dp_encoder_enable(struct cix_dp *dp, int stream_id, int enable)
+{
+	int ret;
+
+	cix_dp_session_lock(dp);
+
+	if (enable) {
+		ret = cix_dp_start_link_locked(dp);
+		if (ret)
+			goto out;
+
+		ret = cix_dp_enable_locked(dp, stream_id);
+		if (ret)
+			cix_dp_unprepare_locked(dp);
+	} else {
+		if (!(dp->state & DPTX_STATE_INITIALIZED)) {
+			ret = 0;
+			goto out;
+		}
+
+		ret = cix_dp_disable_locked(dp, stream_id);
+		if (ret)
+			goto out;
+
+		ret = cix_dp_unprepare_locked(dp);
+	}
+
+out:
+	cix_dp_session_unlock(dp);
+	return ret;
+}
+
+static int cix_dp_init(struct cix_dp *dp)
+{
+	int ret;
+
+	INIT_DELAYED_WORK(&dp->hpd_event_work, cix_dp_hpd_event_work_func);
+	INIT_DELAYED_WORK(&dp->hpd_irq_work, cix_dp_hpd_irq_work_func);
+	INIT_DELAYED_WORK(&dp->sw_hpd_irq_work, cix_dp_sw_hpd_irq_work_func);
+
+	mutex_init(&dp->session_lock);
+	mutex_init(&dp->aux_lock);
+	dp->state |= (DPTX_STATE_CONFIGURED);
+
+	ret = cix_dp_host_init(dp);
+	if (ret)
+		goto end1;
+
+	irq_set_status_flags(dp->irq, IRQ_DISABLE_UNLAZY);
+	ret = devm_request_threaded_irq(dp->dev, dp->irq, NULL,
+					cix_dp_irq_handler, IRQF_ONESHOT,
+				       dev_name(dp->dev), dp);
+	if (ret < 0)
+		goto end2;
+
+	return 0;
+
+end2:
+	cix_dp_session_lock(dp);
+	cix_dp_host_deinit(dp);
+	cix_dp_session_unlock(dp);
+end1:
+	dp->state &= ~DPTX_STATE_CONFIGURED;
+	mutex_destroy(&dp->session_lock);
+	mutex_destroy(&dp->aux_lock);
+	return ret;
+}
+
+/*
+ * Drop video and pixel clocks before host_deinit() powers the PHY down.
+ * active_stream_cnt stays in step with those clocks.
+ */
+static void cix_dp_stop_streams_locked(struct cix_dp *dp)
+{
+	struct cix_connector *conn;
+	int i;
+
+	lockdep_assert_held(&dp->session_lock);
+
+	if (!(dp->state & DPTX_STATE_INITIALIZED))
+		return;
+
+	for (i = 0; i < dp->max_streams; i++) {
+		if (!dp->active_panels[i])
+			continue;
+
+		conn = dp->active_panels[i]->connector;
+		cix_dp_ctrl_stream_off(dp, i);
+		dp->active_panels[i] = NULL;
+		if (conn)
+			memset(conn->sdp, 0, sizeof(conn->sdp));
+	}
+
+	if (!dp->active_stream_cnt)
+		dp->state &= ~DPTX_STATE_ENABLED;
+}
+
+static void cix_dp_deinit(struct cix_dp *dp)
+{
+	if (!(dp->state & DPTX_STATE_CONFIGURED))
+		return;
+
+	cix_dp_session_lock(dp);
+	WRITE_ONCE(dp->hpd_stopped, true);
+	cix_dp_session_unlock(dp);
+
+	cix_dp_irq_off(dp);
+	cix_dp_cancel_hpd_works(dp);
+
+	cix_dp_session_lock(dp);
+	cix_dp_stop_streams_locked(dp);
+	cix_dp_host_deinit(dp);
+	dp->state &= ~(DPTX_STATE_CONFIGURED);
+	cix_dp_session_unlock(dp);
+
+	mutex_destroy(&dp->session_lock);
+	mutex_destroy(&dp->aux_lock);
+}
+
+static void cix_dptx_dev_release(struct device *dev, void *res)
+{
+	struct cix_dp *dp = res;
+
+	cix_dp_deinit(dp);
+}
+
+static int cix_dp_parse_dt(struct cix_dp *dp)
+{
+	struct device *dev = dp->dev;
+	struct platform_device *pdev = to_platform_device(dev);
+	int i;
+
+	dp->dp_iomem = devm_platform_ioremap_resource_byname(pdev, "dp");
+	if (IS_ERR(dp->dp_iomem))
+		return dev_err_probe(dev, PTR_ERR(dp->dp_iomem),
+				     "failed to map dp registers\n");
+
+	dp->rcsu_iomem = devm_platform_ioremap_resource_byname(pdev, "rcsu");
+	if (IS_ERR(dp->rcsu_iomem))
+		return dev_err_probe(dev, PTR_ERR(dp->rcsu_iomem),
+				     "failed to map rcsu registers\n");
+
+	dp->phy = devm_phy_get(dev, NULL);
+	if (IS_ERR(dp->phy))
+		return dev_err_probe(dev, PTR_ERR(dp->phy),
+				     "failed to get dp phy\n");
+
+	dp->reset = devm_reset_control_get(dev, NULL);
+	if (IS_ERR(dp->reset))
+		return dev_err_probe(dev, PTR_ERR(dp->reset),
+				     "failed to get reset\n");
+
+	dp->apb_clk = devm_clk_get(dev, "apb");
+	if (IS_ERR(dp->apb_clk))
+		return dev_err_probe(dev, PTR_ERR(dp->apb_clk),
+				     "failed to get apb clock\n");
+
+	for (i = 0; i < dp->max_streams &&
+	     i < ARRAY_SIZE(stream_clk_names); i++) {
+		dp->stream_clk[i] = devm_clk_get(dev, stream_clk_names[i]);
+		if (IS_ERR(dp->stream_clk[i]))
+			return dev_err_probe(dev, PTR_ERR(dp->stream_clk[i]),
+					     "failed to get %s\n",
+					     stream_clk_names[i]);
+	}
+
+	dp->irq = platform_get_irq(pdev, 0);
+	if (dp->irq < 0)
+		return dev_err_probe(dev, dp->irq, "failed to get irq\n");
+
+	return 0;
+}
+
+static const struct cix_dp_ops cix_dp_hw_ops = {
+	.detect				= cix_dp_detect,
+	.prepare			= cix_dp_prepare,
+	.unprepare			= cix_dp_unprepare,
+	.session_lock			= cix_dp_session_lock,
+	.session_unlock			= cix_dp_session_unlock,
+	.encoder_enable			= cix_dp_encoder_enable,
+	.mode_configure			= cix_dp_mode_configure,
+	.aux_register			= cix_dp_aux_register,
+	.aux_cleanup			= cix_dp_aux_cleanup,
+	.replay_deferred_hotplug	= cix_dp_replay_deferred_hotplug,
+	.quiesce_hpd			= cix_dp_quiesce_hpd,
+};
+
+static int cix_dptx_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct cix_dp_soc_data *soc_data;
+	struct cix_dp *dp;
+	int ret;
+
+	soc_data = of_device_get_match_data(dev);
+	if (!soc_data)
+		return -ENODEV;
+
+	dp = cix_dp_bridge_alloc(dev);
+	if (IS_ERR(dp))
+		return PTR_ERR(dp);
+
+	dp->dev = dev;
+	dp->native_dp = soc_data->native_dp;
+	dp->ops = &cix_dp_hw_ops;
+	dp->status = connector_status_unknown;
+	dp->force_hpd = connector_status_unknown;
+	dp->num_lanes = CIX_DPTX_MAX_LANES;
+	dp->max_rate = CIX_DP_LINK_RATE_HBR2;
+	dp->max_streams = DPTX_MST_SOURCE_NUMBER;
+	dp->dp_panel.source_id = 0;
+	dp->state = DPTX_STATE_DISCONNECTED;
+	dp->pixel_per_cycle = 1;
+
+	ret = cix_dp_parse_dt(dp);
+	if (ret)
+		return ret;
+
+	dp->link_config.max_lanes = dp->num_lanes;
+	dp->link_config.max_rate = dp->max_rate;
+
+	ret = cix_dp_init(dp);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(dev, cix_dptx_dev_release, dp);
+	if (ret)
+		return ret;
+
+	dev_set_drvdata(dev, dp);
+
+	dp->bridge.of_node = dev->of_node;
+
+	drm_bridge_add(&dp->bridge);
+
+	return 0;
+}
+
+static void cix_dptx_remove(struct platform_device *pdev)
+{
+	struct cix_dp *dp = dev_get_drvdata(&pdev->dev);
+
+	if (!dp)
+		return;
+
+	drm_bridge_remove(&dp->bridge);
+}
+
+static int cix_dptx_pm_suspend(struct device *dev)
+{
+	struct cix_dp *dp = dev_get_drvdata(dev);
+
+	if (!dp)
+		return 0;
+
+	return cix_dp_pm_prepare(dp);
+}
+
+static int cix_dptx_pm_resume(struct device *dev)
+{
+	struct cix_dp *dp = dev_get_drvdata(dev);
+
+	if (!dp)
+		return 0;
+
+	return cix_dp_pm_complete(dp);
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(cix_dptx_pm_ops, cix_dptx_pm_suspend,
+				cix_dptx_pm_resume);
+
+static void cix_dptx_shutdown(struct platform_device *pdev)
+{
+	struct cix_dp *dp = platform_get_drvdata(pdev);
+
+	if (dp) {
+		cix_dp_session_lock(dp);
+		cix_dp_stop_streams_locked(dp);
+		cix_dp_session_unlock(dp);
+		cix_dp_pm_prepare(dp);
+	}
+}
+
+static const struct cix_dp_soc_data sky1_usbdp_data = {
+	.native_dp = false,
+};
+
+static const struct cix_dp_soc_data sky1_dp_data = {
+	.native_dp = true,
+};
+
+static const struct of_device_id cix_dptx_dt_ids[] = {
+	{ .compatible = "cix,sky1-usbdp", .data = &sky1_usbdp_data },
+	{ .compatible = "cix,sky1-dp", .data = &sky1_dp_data },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, cix_dptx_dt_ids);
+
+static struct platform_driver cix_dp_driver = {
+	.probe  = cix_dptx_probe,
+	.remove = cix_dptx_remove,
+	.shutdown = cix_dptx_shutdown,
+	.driver = {
+		.name = "cix-dptx",
+		.of_match_table = cix_dptx_dt_ids,
+		.pm = pm_sleep_ptr(&cix_dptx_pm_ops),
+	},
+};
+
+module_platform_driver(cix_dp_driver);
+
+MODULE_AUTHOR("Luo Liu <Luo.Liu@cixtech.com>");
+MODULE_AUTHOR("Wuyi Shen <wuyi.shen@cixtech.com>");
+MODULE_DESCRIPTION("Cix DisplayPort Controller Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/cix/dptx/cix_dptx.h b/drivers/gpu/drm/cix/dptx/cix_dptx.h
new file mode 100644
index 000000000000..cfac8fa2b413
--- /dev/null
+++ b/drivers/gpu/drm/cix/dptx/cix_dptx.h
@@ -0,0 +1,408 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * CIX Sky1 DisplayPort transmitter driver
+ *
+ * Copyright (C) 2026 Trilinear Technologies
+ * Copyright 2026 Cix Technology Group Co., Ltd.
+ */
+
+#ifndef CIX_DPTX_H
+#define CIX_DPTX_H
+
+#include <linux/bits.h>
+#include <linux/phy/phy.h>
+
+#include <drm/display/drm_dp_helper.h>
+#include <drm/drm_bridge.h>
+#include <drm/drm_connector.h>
+
+struct task_struct;
+
+#define CIX_DP_MAX_RATE(rate, lanes, bpp) ((rate) * (lanes) * 8 / (bpp))
+
+#define bridge_to_dp(_bridge) \
+	container_of(_bridge, struct cix_dp, bridge)
+#define connector_to_cix(connector) \
+	container_of(connector, struct cix_connector, base)
+
+#define CIX_DP_MAX_FREQ 600000
+/*
+ * DP link rates in units of 10 kbit/s, i.e. the DPCD bandwidth code
+ * (0x06, 0x0a, 0x14, 0x1e) times 27000, as returned by
+ * drm_dp_bw_code_to_link_rate(). For these 8b/10b rates the value also
+ * equals the link symbol clock in kHz.
+ */
+#define CIX_DP_LINK_RATE_RBR 162000
+#define CIX_DP_LINK_RATE_HBR 270000
+#define CIX_DP_LINK_RATE_HBR2 540000
+#define CIX_DP_LINK_RATE_HBR3 810000
+#define DP_MAX_TRAINING_TRIES 5
+#define DP_MAX_TRAINING_LOOP 3
+
+#define CIX_VSC_SDP 1
+#define CIX_MAX_SDP 7
+
+#define CIX_DPTX_MAX_LANES 4
+
+#define DP_STREAM_MAX 4
+
+/* ------------------------------------------------------------------------ */
+/*  Register offsets */
+/* ------------------------------------------------------------------------ */
+/* link configuration */
+#define CIX_DPTX_LINK_BW_SET			0x000ul
+#define CIX_DPTX_LANE_COUNT_SET		0x004ul
+#define CIX_DPTX_ENHANCED_FRAMING_ENABLE	0x008ul
+#define CIX_DPTX_TRAINING_PATTERN_SET	0x00cul
+#define CIX_DPTX_DISABLE_SCRAMBLING		0x014ul
+#define CIX_DPTX_DOWNSPREAD_CONTROL		0x018ul
+
+/* core enables */
+#define CIX_DPTX_TRANSMITTER_ENABLE	0x080ul
+#define CIX_DPTX_SOFT_RESET			0x090ul
+#define CIX_DPTX_SOURCE_ENABLE		0x094ul
+
+/* misc control */
+#define CIX_DPTX_FORCE_SCRAMBLER_RESET	0x0c0ul
+
+/* AUX channel */
+#define CIX_DPTX_AUX_COMMAND			0x100ul
+#define CIX_DPTX_AUX_WRITE_FIFO		0x104ul
+#define CIX_DPTX_AUX_ADDRESS			0x108ul
+#define CIX_DPTX_AUX_CLOCK_DIVIDER	0x10cul
+#define CIX_DPTX_HPD_INPUT_STATE		0x128ul
+#define CIX_DPTX_AUX_REPLY_DATA		0x134ul
+#define CIX_DPTX_AUX_REPLY_CODE		0x138ul
+#define CIX_DPTX_INTERRUPT_CAUSE		0x140ul
+#define CIX_DPTX_INTERRUPT_MASK		0x144ul
+#define CIX_DPTX_AUX_REPLY_DATA_COUNT	0x148ul
+#define CIX_DPTX_AUX_STATUS			0x14cul
+
+/* PHY status */
+#define CIX_DPTX_PHY_STATUS			0x280ul
+
+/* MST / SST control */
+#define CIX_DPTX_MST_ENABLE			0x500ul
+#define CIX_DPTX_SST_SOURCE_SELECT		0x50cul
+
+/* main stream control, virtual source 0 (bases for per-stream helpers) */
+#define CIX_DPTX_SRC0_VIDEO_STREAM_ENABLE	0x800ul
+#define CIX_DPTX_SRC0_SECONDARY_STREAM_ENABLE	0x804ul
+#define CIX_DPTX_SRC0_SECONDARY_DATA_WINDOW	0x808ul
+#define CIX_DPTX_SRC0_DATA_CONTROL		0x810ul
+#define CIX_DPTX_SRC0_MAIN_STREAM_OVERRIDE	0x814ul
+#define CIX_DPTX_SRC0_MAIN_STREAM_HTOTAL	0x820ul
+#define CIX_DPTX_SRC0_MAIN_STREAM_VTOTAL	0x824ul
+#define CIX_DPTX_SRC0_MAIN_STREAM_POLARITY	0x828ul
+#define CIX_DPTX_SRC0_MAIN_STREAM_HSWIDTH	0x82cul
+#define CIX_DPTX_SRC0_MAIN_STREAM_VSWIDTH	0x830ul
+#define CIX_DPTX_SRC0_MAIN_STREAM_HRES	0x834ul
+#define CIX_DPTX_SRC0_MAIN_STREAM_VRES	0x838ul
+#define CIX_DPTX_SRC0_MAIN_STREAM_HSTART	0x83cul
+#define CIX_DPTX_SRC0_MAIN_STREAM_VSTART	0x840ul
+#define CIX_DPTX_SRC0_MAIN_STREAM_MISC0	0x844ul
+#define CIX_DPTX_SRC0_MAIN_STREAM_MISC1	0x848ul
+#define CIX_DPTX_SRC0_TU_CONFIG		0x850ul
+#define CIX_DPTX_SRC0_USER_PIXEL_COUNT	0x858ul
+#define CIX_DPTX_SRC0_USER_DATA_COUNT	0x85cul
+#define CIX_DPTX_SRC0_USER_SYNC_POLARITY	0x864ul
+
+/* secondary channel, source 0 */
+#define CIX_DPTX_SEC0_INFOFRAME_ENABLE	0x910ul
+#define CIX_DPTX_SEC0_INFOFRAME_RATE		0x914ul
+#define CIX_DPTX_SEC0_INFOFRAME_SELECT	0x934ul
+#define CIX_DPTX_SEC0_INFOFRAME_DATA		0x938ul
+
+/* spacing between consecutive virtual source register blocks */
+#define CIX_DPTX_SOURCE_OFFSET		0x200ul
+
+/* per-stream helpers, indexed by source/stream id */
+#define CIX_DPTX_INFOFRAME_ENABLE(stream_id) \
+	(CIX_DPTX_SEC0_INFOFRAME_ENABLE + \
+	 CIX_DPTX_SOURCE_OFFSET * (stream_id))
+#define CIX_DPTX_INFOFRAME_SELECT(stream_id) \
+	(CIX_DPTX_SEC0_INFOFRAME_SELECT + \
+	 CIX_DPTX_SOURCE_OFFSET * (stream_id))
+#define CIX_DPTX_INFOFRAME_RATE(stream_id) \
+	(CIX_DPTX_SEC0_INFOFRAME_RATE + \
+	 CIX_DPTX_SOURCE_OFFSET * (stream_id))
+#define CIX_DPTX_INFOFRAME_DATA(stream_id) \
+	(CIX_DPTX_SEC0_INFOFRAME_DATA + \
+	 CIX_DPTX_SOURCE_OFFSET * (stream_id))
+#define CIX_DPTX_VIDEO_STREAM_ENABLE(stream_id) \
+	(CIX_DPTX_SRC0_VIDEO_STREAM_ENABLE + \
+	 CIX_DPTX_SOURCE_OFFSET * (stream_id))
+#define CIX_DPTX_SECONDARY_STREAM_ENABLE(stream_id) \
+	(CIX_DPTX_SRC0_SECONDARY_STREAM_ENABLE + \
+	 CIX_DPTX_SOURCE_OFFSET * (stream_id))
+#define CIX_DPTX_MAIN_STREAM_MISC0(stream_id) \
+	(CIX_DPTX_SRC0_MAIN_STREAM_MISC0 + \
+	 CIX_DPTX_SOURCE_OFFSET * (stream_id))
+#define CIX_DPTX_MAIN_STREAM_MISC1(stream_id) \
+	(CIX_DPTX_SRC0_MAIN_STREAM_MISC1 + \
+	 CIX_DPTX_SOURCE_OFFSET * (stream_id))
+#define CIX_DPTX_MAIN_STREAM_OVERRIDE(stream_id) \
+	(CIX_DPTX_SRC0_MAIN_STREAM_OVERRIDE + \
+	 CIX_DPTX_SOURCE_OFFSET * (stream_id))
+#define CIX_DPTX_MAIN_STREAM_HTOTAL(stream_id) \
+	(CIX_DPTX_SRC0_MAIN_STREAM_HTOTAL + \
+	 CIX_DPTX_SOURCE_OFFSET * (stream_id))
+#define CIX_DPTX_MAIN_STREAM_VTOTAL(stream_id) \
+	(CIX_DPTX_SRC0_MAIN_STREAM_VTOTAL + \
+	 CIX_DPTX_SOURCE_OFFSET * (stream_id))
+#define CIX_DPTX_MAIN_STREAM_POLARITY(stream_id) \
+	(CIX_DPTX_SRC0_MAIN_STREAM_POLARITY + \
+	 CIX_DPTX_SOURCE_OFFSET * (stream_id))
+#define CIX_DPTX_MAIN_STREAM_HSWIDTH(stream_id) \
+	(CIX_DPTX_SRC0_MAIN_STREAM_HSWIDTH + \
+	 CIX_DPTX_SOURCE_OFFSET * (stream_id))
+#define CIX_DPTX_MAIN_STREAM_VSWIDTH(stream_id) \
+	(CIX_DPTX_SRC0_MAIN_STREAM_VSWIDTH + \
+	 CIX_DPTX_SOURCE_OFFSET * (stream_id))
+#define CIX_DPTX_MAIN_STREAM_HRES(stream_id) \
+	(CIX_DPTX_SRC0_MAIN_STREAM_HRES + \
+	 CIX_DPTX_SOURCE_OFFSET * (stream_id))
+#define CIX_DPTX_MAIN_STREAM_VRES(stream_id) \
+	(CIX_DPTX_SRC0_MAIN_STREAM_VRES + \
+	 CIX_DPTX_SOURCE_OFFSET * (stream_id))
+#define CIX_DPTX_MAIN_STREAM_HSTART(stream_id) \
+	(CIX_DPTX_SRC0_MAIN_STREAM_HSTART + \
+	 CIX_DPTX_SOURCE_OFFSET * (stream_id))
+#define CIX_DPTX_MAIN_STREAM_VSTART(stream_id) \
+	(CIX_DPTX_SRC0_MAIN_STREAM_VSTART + \
+	 CIX_DPTX_SOURCE_OFFSET * (stream_id))
+#define CIX_DPTX_TU_CONFIG(stream_id) \
+	(CIX_DPTX_SRC0_TU_CONFIG + \
+	 CIX_DPTX_SOURCE_OFFSET * (stream_id))
+#define CIX_DPTX_USER_DATA_COUNT(stream_id) \
+	(CIX_DPTX_SRC0_USER_DATA_COUNT + \
+	 CIX_DPTX_SOURCE_OFFSET * (stream_id))
+#define CIX_DPTX_SECONDARY_DATA_WINDOW(stream_id) \
+	(CIX_DPTX_SRC0_SECONDARY_DATA_WINDOW + \
+	 CIX_DPTX_SOURCE_OFFSET * (stream_id))
+#define CIX_DPTX_DATA_CONTROL(stream_id) \
+	(CIX_DPTX_SRC0_DATA_CONTROL + \
+	 CIX_DPTX_SOURCE_OFFSET * (stream_id))
+#define CIX_DPTX_USER_PIXEL_COUNT(stream_id) \
+	(CIX_DPTX_SRC0_USER_PIXEL_COUNT + \
+	 CIX_DPTX_SOURCE_OFFSET * (stream_id))
+#define CIX_DPTX_USER_SYNC_POLARITY(stream_id) \
+	(CIX_DPTX_SRC0_USER_SYNC_POLARITY + \
+	 CIX_DPTX_SOURCE_OFFSET * (stream_id))
+
+/* ------------------------------------------------------------------------ */
+/*  Register CIX_DPTX_AUX_COMMAND bits */
+/* ------------------------------------------------------------------------ */
+#define CIX_DPTX_AUX_COMMAND_CMD_SHIFT 8
+#define CIX_DPTX_AUX_COMMAND_ADDRESS_ONLY BIT(12)
+#define CIX_DPTX_AUX_COMMAND_BYTES_SHIFT 0
+#define CIX_DPTX_AUX_STATUS_REPLY_ERROR BIT(3)
+#define CIX_DPTX_AUX_STATUS_REQUEST_IN_PROGRESS BIT(2)
+#define CIX_DPTX_AUX_STATUS_REPLY_IN_PROGRESS BIT(1)
+#define CIX_DPTX_AUX_STATUS_REPLY_RECEIVED BIT(0)
+#define CIX_DPTX_AUX_REPLY_CODE_AUX_ACK (0)
+#define CIX_DPTX_AUX_REPLY_CODE_I2C_ACK (0)
+
+/* ------------------------------------------------------------------------ */
+/*  Register CIX_DPTX_REPLY_DATA_COUNT bits */
+/* ------------------------------------------------------------------------ */
+#define CIX_DPTX_REPLY_DATA_COUNT_MASK 0xff
+
+/* ------------------------------------------------------------------------ */
+/*  Register CIX_DPTX_MAIN_STREAM_MISC0 bits */
+/* ------------------------------------------------------------------------ */
+#define CIX_DPTX_STREAM_MISC0_SYNC_LOCK BIT(0)
+#define CIX_DPTX_STREAM_MISC0_COMP_FORMAT_RGB (0 << 1)
+#define CIX_DPTX_STREAM_MISC0_COMP_FORMAT_YCRCB_422 (5 << 1)
+#define CIX_DPTX_STREAM_MISC0_COMP_FORMAT_YCRCB_444 (6 << 1)
+#define CIX_DPTX_STREAM_MISC0_COMP_FORMAT_MASK (7 << 1)
+#define CIX_DPTX_STREAM_MISC0_BPC_6 (0 << 5)
+#define CIX_DPTX_STREAM_MISC0_BPC_8 BIT(5)
+#define CIX_DPTX_STREAM_MISC0_BPC_10 (2 << 5)
+#define CIX_DPTX_STREAM_MISC0_BPC_12 (3 << 5)
+#define CIX_DPTX_STREAM_MISC0_BPC_16 (4 << 5)
+#define CIX_DPTX_STREAM_MISC0_BPC_MASK (7 << 5)
+
+/* ------------------------------------------------------------------------ */
+/*  Register CIX_DPTX_MAIN_STREAM_MISC1 bits */
+/* ------------------------------------------------------------------------ */
+#define CIX_DPTX_STREAM_MISC1_Y_ONLY_EN BIT(7)
+
+#define CIX_DPTX_VSC_COLORIMETRY_EN BIT(6)
+#define CIX_DPTX_STREAM_OVERRIDE_ENABLE BIT(6)
+/*
+ * Pixel format in bits [5:3]. 0 is RGB. 4:2:2 and 4:4:4 use the same
+ * component-format codes as MISC0 bits [2:1]. 4:2:0 cannot be carried
+ * in MISC0, so it has its own value.
+ */
+#define CIX_DPTX_STREAM_OVERRIDE_YCbCR_422 (1 << 3)
+#define CIX_DPTX_STREAM_OVERRIDE_YCbCR_444 (2 << 3)
+#define CIX_DPTX_STREAM_OVERRIDE_YCbCR_420 (4 << 3)
+#define CIX_DPTX_STREAM_OVERRIDE_BPC_6 (0)
+#define CIX_DPTX_STREAM_OVERRIDE_BPC_8 (1)
+#define CIX_DPTX_STREAM_OVERRIDE_BPC_10 (2)
+#define CIX_DPTX_STREAM_OVERRIDE_BPC_12 (3)
+#define CIX_DPTX_STREAM_OVERRIDE_BPC_16 (4)
+
+#define CIX_DPTX_MSA_TRANSFER_UNIT_SIZE_TU_SIZE_DEF 64
+#define CIX_DPTX_MAIN_STREAM_POLARITY_HSYNC_SHIFT 0
+#define CIX_DPTX_MAIN_STREAM_POLARITY_VSYNC_SHIFT 1
+#define CIX_DPTX_MAIN_STREAM_POLARITY_DATAENABLE_HIGH 0xc
+
+#define CIX_DPTX_DATA_CONTROL_DEFAULT		(BIT(13) | BIT(2))
+#define CIX_DPTX_DATA_CONTROL_2PPC_4LANE_HBR3	BIT(2)
+
+#define CIX_DPTX_INTERRUPT_GP_TIMER_IRQ BIT(4)
+#define CIX_DPTX_INTERRUPT_REPLY_TIMEOUT BIT(3)
+#define CIX_DPTX_INTERRUPT_REPLY_RECIEVED BIT(2)
+#define CIX_DPTX_INTERRUPT_HPD_IRQ BIT(1)
+#define CIX_DPTX_INTERRUPT_HPD_EVENT BIT(0)
+
+#define CIX_DPTX_INTERRUPT_MASK_ALL 0x3f
+#define CIX_DPTX_INTERRUPT_CFG 0x1c
+
+enum cix_dp_format {
+	CIX_DP_FORMAT_RGB,
+	CIX_DP_FORMAT_YCBCR444,
+	CIX_DP_FORMAT_YCBCR422,
+	CIX_DP_FORMAT_YCBCR420,
+	CIX_DP_FORMAT_YONLY,
+};
+
+enum cix_dptx_state {
+	DPTX_STATE_DISCONNECTED = 0,
+	DPTX_STATE_CONFIGURED = BIT(0),
+	DPTX_STATE_INITIALIZED = BIT(1),
+	DPTX_STATE_READY = BIT(2),
+	DPTX_STATE_CONNECTED = BIT(3),
+	DPTX_STATE_ENABLED = BIT(6),
+	DPTX_STATE_SUSPENDED = BIT(7),
+	DPTX_STATE_INIT_TRAIN = BIT(8),
+};
+
+struct cix_dp_link_config {
+	int max_rate;
+	int max_lanes;
+};
+
+struct cix_dp_mode {
+	u8 bw_code;
+	u8 lane_cnt;
+	int pclock;
+	int link_rate;
+};
+
+struct cix_dp_config {
+	u8 misc0;
+	u8 misc1;
+	int bpp;
+	int bpc;
+	u8 override;
+	enum cix_dp_format format;
+	u32 colorspace;
+	u8 dynamic_range;
+	u8 content_type;
+};
+
+/* Output configuration and SDP packets of the DisplayPort link. */
+struct cix_connector {
+	struct drm_connector base;
+	struct cix_dp *dp;
+	struct cix_dp_config config;
+	struct dp_sdp sdp[CIX_MAX_SDP];
+};
+
+struct cix_dp_link_caps {
+	bool enhanced_framing;
+	bool tps3_supported;
+	bool tps4_supported;
+	bool vsc_supported;
+};
+
+struct cix_dp_panel {
+	u32 source_id;
+	struct cix_connector *connector;
+};
+
+struct cix_dp;
+
+struct cix_dp_ops {
+	int (*detect)(struct cix_dp *dp);
+	int (*prepare)(struct cix_dp *dp);
+	int (*unprepare)(struct cix_dp *dp);
+	void (*session_lock)(struct cix_dp *dp);
+	void (*session_unlock)(struct cix_dp *dp);
+	int (*encoder_enable)(struct cix_dp *dp, int stream_id, int enable);
+	int (*mode_configure)(struct cix_dp *dp, int pclk, u8 bw, u8 bpp,
+			      bool downshift);
+	int (*aux_register)(struct cix_dp *dp);
+	void (*aux_cleanup)(struct cix_dp *dp);
+	void (*replay_deferred_hotplug)(struct cix_dp *dp);
+	void (*quiesce_hpd)(struct cix_dp *dp);
+};
+
+struct cix_dp {
+	struct drm_bridge bridge;
+	struct cix_connector connector;
+	struct device *dev;
+	struct drm_device *drm;
+	struct clk *apb_clk;
+	struct clk *stream_clk[DP_STREAM_MAX];
+	void __iomem *dp_iomem;
+	void __iomem *rcsu_iomem;
+	struct reset_control *reset;
+	struct drm_dp_aux aux;
+	bool aux_registered;
+	struct phy *phy;
+	int irq;
+	/*
+	 * disable_irq() is outstanding. pm_prepare() and deinit must not
+	 * disable again until a resume path has called enable_irq().
+	 */
+	bool irq_suspended;
+	/* detach/remove: do not queue HPD work or touch the connector. */
+	bool hpd_stopped;
+	/* HPD event task. Its detect must not undo suspend. */
+	struct task_struct *hpd_worker;
+	u32 max_rate;
+	u32 num_lanes;
+	u32 max_streams;
+	u32 aux_clock_divider;
+	bool native_dp;
+	u8 dpcd[DP_RECEIVER_CAP_SIZE];
+	u8 downstream_ports[DP_MAX_DOWNSTREAM_PORTS];
+	struct delayed_work hpd_event_work;
+	struct delayed_work hpd_irq_work;
+	struct delayed_work sw_hpd_irq_work;
+	enum drm_connector_status status;
+	enum drm_connector_status force_hpd;
+	/* USB-C plug probe may issue one AUX transfer before HPD is known. */
+	bool aux_ignore_hpd;
+	struct cix_dp_link_config link_config;
+	struct cix_dp_mode mode;
+	struct cix_dp_link_caps caps;
+	enum cix_dptx_state state;
+	u32 pixel_per_cycle;
+	u8 train_set[CIX_DPTX_MAX_LANES];
+	u32 active_stream_cnt;
+	/*
+	 * Serializes link training, HPD, stream enable and register access.
+	 * Top-level entry points take it once and call the _locked helpers.
+	 *
+	 * Lock order: session_lock -> aux_lock. aux_transfer() takes only
+	 * aux_lock, so the reverse order never happens.
+	 */
+	struct mutex session_lock;
+	/*
+	 * Serializes AUX transfers with host_init()/host_deinit(), which
+	 * enable and gate the APB clock under this lock. Kept separate from
+	 * session_lock because drm_dp_*() helpers called with session_lock
+	 * held re-enter aux->transfer.
+	 */
+	struct mutex aux_lock;
+	struct cix_dp_panel dp_panel;
+	struct cix_dp_panel *active_panels[DP_STREAM_MAX];
+	const struct cix_dp_ops *ops;
+};
+
+#endif /* CIX_DPTX_H */
diff --git a/drivers/gpu/drm/cix/dptx/cix_dptx_drm.c b/drivers/gpu/drm/cix/dptx/cix_dptx_drm.c
new file mode 100644
index 000000000000..5fc350daebfd
--- /dev/null
+++ b/drivers/gpu/drm/cix/dptx/cix_dptx_drm.c
@@ -0,0 +1,771 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * CIX Sky1 DisplayPort DRM bridge helpers
+ *
+ * Copyright 2026 Cix Technology Group Co., Ltd.
+ */
+
+#include "cix_dptx_drm.h"
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/math64.h>
+#include <linux/mutex.h>
+
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_bridge.h>
+#include <drm/drm_edid.h>
+#include <drm/drm_probe_helper.h>
+
+#include "cix_dptx.h"
+
+#define CIX_DPTX_MIN_H_BACKPORCH 12
+#define CIX_DP_MIN_BPP		(6 * 3)
+
+#define connector_to_dp(connector) (connector_to_cix(connector)->dp)
+
+struct fmt_prio_entry {
+	int format;
+	int bpc;
+};
+
+/* SST: RGB -> YUV422 10 -> YUV422 8 -> RGB 6 -> YUV420 8 */
+static const struct fmt_prio_entry fmt_prio[] = {
+	{ DRM_OUTPUT_COLOR_FORMAT_RGB444, 0 },   /* use suggest_bpc (8 or 10) */
+	{ DRM_OUTPUT_COLOR_FORMAT_YCBCR422, 10 }, /* YUV422 10bit second */
+	{ DRM_OUTPUT_COLOR_FORMAT_YCBCR422, 8 },  /* YUV422 8bit third */
+	{ DRM_OUTPUT_COLOR_FORMAT_RGB444, 6 },    /* RGB 6bit fourth */
+	{ DRM_OUTPUT_COLOR_FORMAT_YCBCR420, 8 },  /* YUV420 8bit last */
+};
+
+static const int dp_common_link_rates[] = {
+	CIX_DP_LINK_RATE_RBR,
+	CIX_DP_LINK_RATE_HBR,
+	CIX_DP_LINK_RATE_HBR2,
+	CIX_DP_LINK_RATE_HBR3
+};
+
+static enum drm_connector_status
+cix_dp_connector_detect(struct drm_connector *connector, bool force)
+{
+	struct cix_dp *dp = connector_to_dp(connector);
+	enum drm_connector_status status;
+
+	if (dp->ops->detect(dp))
+		status = connector_status_disconnected;
+	else
+		status = connector_status_connected;
+
+	dp->ops->session_lock(dp);
+	dp->status = status;
+	dp->ops->session_unlock(dp);
+	drm_dp_set_subconnector_property(connector, status, dp->dpcd,
+					 dp->downstream_ports);
+
+	return status;
+}
+
+static void cix_dp_oob_hotplug_event(struct drm_connector *connector,
+				     enum drm_connector_status hpd_state)
+{
+	struct cix_dp *dp = connector_to_dp(connector);
+
+	dp->ops->session_lock(dp);
+	if (READ_ONCE(dp->hpd_stopped)) {
+		dp->ops->session_unlock(dp);
+		return;
+	}
+
+	if (dp->state & DPTX_STATE_SUSPENDED) {
+		dp->force_hpd = connector_status_disconnected;
+		dp->ops->session_unlock(dp);
+		return;
+	}
+
+	if (dp->force_hpd != hpd_state) {
+		dp->force_hpd = hpd_state;
+		schedule_delayed_work(&dp->hpd_event_work, 0);
+	}
+
+	if (hpd_state == connector_status_connected)
+		schedule_delayed_work(&dp->sw_hpd_irq_work, 1);
+	dp->ops->session_unlock(dp);
+}
+
+static int cix_dp_connector_get_modes(struct drm_connector *connector)
+{
+	struct cix_dp *dp = connector_to_dp(connector);
+	const struct drm_edid *edid;
+	struct drm_display_mode *mode;
+	int ret;
+
+	edid = drm_edid_read_ddc(connector, &dp->aux.ddc);
+	if (!edid) {
+		drm_edid_connector_update(connector, NULL);
+
+		mode = drm_dp_downstream_mode(connector->dev, dp->dpcd,
+					      dp->downstream_ports);
+		if (!mode)
+			return 0;
+
+		drm_mode_probed_add(connector, mode);
+		return 1;
+	}
+
+	drm_edid_connector_update(connector, edid);
+	ret = drm_edid_connector_add_modes(connector);
+	drm_edid_free(edid);
+
+	return ret;
+}
+
+static struct drm_encoder *
+cix_dp_connector_best_encoder(struct drm_connector *connector)
+{
+	struct cix_dp *dp = connector_to_dp(connector);
+
+	return dp->bridge.encoder;
+}
+
+static u32 cix_dp_pick_ppc(const struct drm_display_mode *mode,
+			   enum cix_dp_format format)
+{
+	if (mode->clock > CIX_DP_MAX_FREQ &&
+	    mode->clock < CIX_DP_MAX_FREQ * 2 &&
+	    format != CIX_DP_FORMAT_YCBCR420)
+		return 2;
+
+	return 1;
+}
+
+static enum drm_mode_status
+cix_dp_connector_mode_valid(struct drm_connector *connector,
+			    const struct drm_display_mode *mode)
+{
+	const struct drm_display_info *info = &connector->display_info;
+	struct cix_dp *dp = connector_to_dp(connector);
+	int max_lanes = dp->link_config.max_lanes;
+	int max_rate = dp->link_config.max_rate;
+	int clock = mode->clock;
+	u32 pixel_per_cycle = cix_dp_pick_ppc(mode, CIX_DP_FORMAT_RGB);
+	int minbpp = CIX_DP_MIN_BPP;
+
+	if (drm_mode_is_420_only(info, mode)) {
+		if (!connector->ycbcr_420_allowed || !dp->caps.vsc_supported)
+			return MODE_NO_420;
+
+		minbpp = 8 * 3 / 2;
+		pixel_per_cycle = 1;
+	}
+
+	if (pixel_per_cycle == 1 && clock > CIX_DP_MAX_FREQ) {
+		drm_mode_debug_printmodeline(mode);
+		return MODE_CLOCK_HIGH;
+	}
+
+	if (clock > CIX_DP_MAX_RATE(max_rate, max_lanes, minbpp)) {
+		drm_mode_debug_printmodeline(mode);
+		return MODE_CLOCK_HIGH;
+	}
+
+	return MODE_OK;
+}
+
+static bool cix_dp_bt2020_colorspace(const struct drm_connector_state *state)
+{
+	return state->colorspace >= DRM_MODE_COLORIMETRY_BT2020_CYCC &&
+	       state->colorspace <= DRM_MODE_COLORIMETRY_BT2020_YCC;
+}
+
+static int cix_dp_cal_bpc(struct drm_connector_state *connector_state, int bpc)
+{
+	struct drm_display_info *info =
+		&connector_state->connector->display_info;
+
+	/*
+	 * BT.2020 stays at 10 bpc when the caller asks for more. A lower
+	 * value is a bandwidth fallback and has to be left alone.
+	 */
+	if (cix_dp_bt2020_colorspace(connector_state) && bpc > 10)
+		bpc = 10;
+
+	if (info->bpc && bpc > info->bpc)
+		bpc = info->bpc;
+
+	if (connector_state->max_requested_bpc &&
+	    bpc > connector_state->max_requested_bpc)
+		bpc = connector_state->max_requested_bpc;
+
+	return bpc;
+}
+
+static int cix_dp_cal_bpp(struct cix_dp *dp, int bpc, int format)
+{
+	int bpp = bpc * 3;
+
+	switch (format) {
+	case DRM_OUTPUT_COLOR_FORMAT_RGB444:
+	case DRM_OUTPUT_COLOR_FORMAT_YCBCR444:
+		bpp = bpc * 3;
+		break;
+	case DRM_OUTPUT_COLOR_FORMAT_YCBCR422:
+		bpp = bpc * 2;
+		break;
+	case DRM_OUTPUT_COLOR_FORMAT_YCBCR420:
+		bpp = bpc * 3 / 2;
+		break;
+	default:
+		dev_warn(dp->dev, "invalid color format %d\n", format);
+	}
+	return bpp;
+}
+
+static void cix_dp_adjust_mode(struct drm_display_mode *mode,
+			       struct drm_display_mode *adjusted_mode)
+{
+	int diff = mode->htotal - mode->hsync_end;
+
+	/*
+	 * Cix DP requires horizontal backporch to be greater than 12.
+	 * This limitation may not be compatible with the sink device.
+	 *
+	 * Everything below is derived from @mode instead of accumulating on
+	 * @adjusted_mode, so that repeated atomic checks of the same state
+	 * produce the same result.
+	 */
+	if (diff < CIX_DPTX_MIN_H_BACKPORCH) {
+		adjusted_mode->htotal = mode->htotal +
+					CIX_DPTX_MIN_H_BACKPORCH - diff;
+		adjusted_mode->clock =
+			div_u64(mul_u32_u32(mode->clock, adjusted_mode->htotal),
+				mode->htotal);
+	}
+
+	/* The sync polarities are inverted with respect to the source mode. */
+	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
+		adjusted_mode->flags &= ~DRM_MODE_FLAG_PVSYNC;
+	else
+		adjusted_mode->flags |= DRM_MODE_FLAG_PVSYNC;
+
+	if (mode->flags & DRM_MODE_FLAG_PHSYNC)
+		adjusted_mode->flags &= ~DRM_MODE_FLAG_PHSYNC;
+	else
+		adjusted_mode->flags |= DRM_MODE_FLAG_PHSYNC;
+}
+
+static int compute_available_clock_rate(struct cix_dp *dp,
+					struct drm_connector_state *conn_state,
+					int suggest_bpc, int clock,
+					int color_format, int *rt_bpc,
+					int *rt_bpp)
+{
+	int max_lanes = dp->link_config.max_lanes;
+	int max_rate = dp->link_config.max_rate;
+	int rate;
+	int bpc;
+	int bpp;
+
+	bpc = cix_dp_cal_bpc(conn_state, suggest_bpc);
+	bpp = cix_dp_cal_bpp(dp, bpc, color_format);
+	rate = CIX_DP_MAX_RATE(max_rate, max_lanes, bpp);
+
+	/* clock is adjusted_mode->clock, also in kHz */
+	if (clock <= rate) {
+		*rt_bpc = bpc;
+		*rt_bpp = bpp;
+
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+/*
+ * @mode still has the CEA timings and sync flags. adjusted_mode has had
+ * its polarities inverted, so it no longer matches a VIC.
+ */
+static bool cix_dp_format_ok(struct cix_dp *dp,
+			     const struct drm_display_info *info,
+			     const struct drm_display_mode *mode,
+			     const struct drm_display_mode *adjusted_mode,
+			     int info_formats, int format)
+{
+	if (format == DRM_OUTPUT_COLOR_FORMAT_YCBCR420) {
+		if (!dp->caps.vsc_supported)
+			return false;
+
+		/*
+		 * Y420VDB sets the sink-wide 420 bit for every mode. This
+		 * VIC has to be 420-only or 420-also. 420 is one pixel
+		 * per cycle.
+		 */
+		if (!drm_mode_is_420(info, mode))
+			return false;
+
+		return adjusted_mode->clock <= CIX_DP_MAX_FREQ;
+	}
+
+	if (drm_mode_is_420_only(info, mode))
+		return false;
+
+	return info_formats & BIT(format);
+}
+
+static int cix_dp_pick_format_bpc(struct cix_dp *dp,
+				  struct drm_connector_state *conn_state,
+				  const struct drm_display_mode *mode,
+				  struct drm_display_mode *adjusted_mode,
+				  int info_formats, int suggest_bpc,
+				  int *color_format, int *bpc, int *bpp)
+{
+	struct drm_display_info *info =
+		&conn_state->connector->display_info;
+	int curr_bpc;
+	int format;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(fmt_prio); i++) {
+		format = fmt_prio[i].format;
+		curr_bpc = fmt_prio[i].bpc ? fmt_prio[i].bpc : suggest_bpc;
+
+		if (!cix_dp_format_ok(dp, info, mode, adjusted_mode,
+				      info_formats, format))
+			continue;
+
+		/*
+		 * First entry (RGB): prefer 10bit before falling back to
+		 * suggest_bpc, and step down to 8bit before giving up on RGB.
+		 * BT.2020 also tries 10 first when suggest_bpc is lower.
+		 * The DPU always outputs RGB, so a lower RGB depth is still
+		 * preferable to a converted YUV format.
+		 */
+		if (i == 0) {
+			if (cix_dp_bt2020_colorspace(conn_state) &&
+			    suggest_bpc < 10 &&
+			    !compute_available_clock_rate(dp, conn_state, 10,
+							  adjusted_mode->clock,
+							  format, bpc, bpp)) {
+				if (color_format)
+					*color_format = format;
+				return 0;
+			}
+
+			if (suggest_bpc > 10 &&
+			    !compute_available_clock_rate(dp, conn_state, 10,
+							  adjusted_mode->clock,
+							  format, bpc, bpp)) {
+				if (color_format)
+					*color_format = format;
+				return 0;
+			}
+
+			if (!compute_available_clock_rate(dp, conn_state,
+							  suggest_bpc,
+							  adjusted_mode->clock,
+							  format, bpc, bpp)) {
+				if (color_format)
+					*color_format = format;
+				return 0;
+			}
+
+			if (suggest_bpc > 8 &&
+			    !compute_available_clock_rate(dp, conn_state, 8,
+							  adjusted_mode->clock,
+							  format, bpc, bpp)) {
+				if (color_format)
+					*color_format = format;
+				return 0;
+			}
+
+			continue;
+		}
+
+		if (!compute_available_clock_rate(dp, conn_state, curr_bpc,
+						  adjusted_mode->clock,
+						  format, bpc, bpp)) {
+			if (color_format)
+				*color_format = format;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static enum cix_dp_format cix_dp_drm_format_to_dp(int color_format)
+{
+	switch (color_format) {
+	case DRM_OUTPUT_COLOR_FORMAT_YCBCR444:
+		return CIX_DP_FORMAT_YCBCR444;
+	case DRM_OUTPUT_COLOR_FORMAT_YCBCR422:
+		return CIX_DP_FORMAT_YCBCR422;
+	case DRM_OUTPUT_COLOR_FORMAT_YCBCR420:
+		return CIX_DP_FORMAT_YCBCR420;
+	default:
+		return CIX_DP_FORMAT_RGB;
+	}
+}
+
+static int cix_dp_pick_link_rate(struct cix_dp *dp,
+				 struct drm_display_mode *adjusted_mode,
+				 int bpp)
+{
+	int max_rate = dp->link_config.max_rate;
+	int max_lanes = dp->link_config.max_lanes;
+	int link_rate = max_rate;
+	int rate;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(dp_common_link_rates); i++) {
+		if (dp_common_link_rates[i] > max_rate)
+			break;
+		rate = CIX_DP_MAX_RATE(dp_common_link_rates[i], max_lanes, bpp);
+		if (adjusted_mode->clock <= rate) {
+			link_rate = dp_common_link_rates[i];
+			break;
+		}
+	}
+
+	return link_rate;
+}
+
+static int cix_dp_pick_config(struct cix_dp *dp,
+			      struct drm_connector_state *conn_state,
+			      const struct drm_display_mode *mode,
+			      struct drm_display_mode *adjusted_mode,
+			      int *color_format, int *bpc, int *bpp)
+{
+	struct drm_display_info *info = &conn_state->connector->display_info;
+	u32 color_formats = info->color_formats;
+	int suggest_bpc;
+
+	/*
+	 * RGB444 is mandatory for DP sources and some sinks do not advertise
+	 * it in their EDID, so always keep it in the candidate set.
+	 */
+	color_formats |= BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444);
+
+	/* bpc 0 is unspecified. Start at 8, and never below 6. */
+	suggest_bpc = info->bpc ? info->bpc : 8;
+	if (suggest_bpc < 6)
+		suggest_bpc = 6;
+
+	return cix_dp_pick_format_bpc(dp, conn_state, mode, adjusted_mode,
+				      color_formats, suggest_bpc,
+				      color_format, bpc, bpp);
+}
+
+static int cix_dp_bridge_mode_set(struct cix_dp *dp,
+				  struct drm_crtc_state *crtc_state,
+				  struct drm_connector_state *conn_state)
+{
+	struct drm_display_mode *adjusted_mode = &crtc_state->adjusted_mode;
+	struct cix_connector *cix_conn = &dp->connector;
+	int color_format;
+	int link_rate;
+	int bw_code;
+	int bpc;
+	int bpp;
+	int ret;
+
+	/*
+	 * prepare() has read the sink DPCD into link_config. Refresh it
+	 * outside session_lock; detect() takes the lock itself.
+	 */
+	ret = dp->ops->detect(dp);
+	if (ret)
+		return ret;
+
+	/*
+	 * Hold the session lock across the mode write so a retrain cannot
+	 * observe a torn dp->mode or connector config.
+	 */
+	dp->ops->session_lock(dp);
+
+	ret = cix_dp_pick_config(dp, conn_state, &crtc_state->mode,
+				 adjusted_mode, &color_format, &bpc, &bpp);
+	if (ret)
+		goto out;
+
+	cix_conn->config.format = cix_dp_drm_format_to_dp(color_format);
+	cix_conn->config.colorspace = conn_state->colorspace;
+	cix_conn->config.content_type = conn_state->content_type;
+	cix_conn->config.bpc = bpc;
+	cix_conn->config.bpp = bpp;
+	dp->pixel_per_cycle = cix_dp_pick_ppc(adjusted_mode,
+					      cix_conn->config.format);
+
+	link_rate = cix_dp_pick_link_rate(dp, adjusted_mode, bpp);
+	bw_code = drm_dp_link_rate_to_bw_code(link_rate);
+
+	ret = dp->ops->mode_configure(dp, adjusted_mode->clock, bw_code,
+				      bpp, false);
+	if (ret)
+		goto out;
+
+	dev_dbg(dp->dev,
+		"%dx%d@%d fmt=%d bpc=%d bpp=%d link=%u lanes=%u ppc=%u\n",
+		adjusted_mode->hdisplay, adjusted_mode->vdisplay,
+		drm_mode_vrefresh(adjusted_mode), cix_conn->config.format,
+		bpc, bpp, bw_code, dp->mode.lane_cnt,
+		dp->pixel_per_cycle);
+out:
+	dp->ops->session_unlock(dp);
+	return ret;
+}
+
+static int cix_dp_bridge_atomic_check(struct drm_bridge *bridge,
+				      struct drm_bridge_state *bridge_state,
+				      struct drm_crtc_state *crtc_state,
+				      struct drm_connector_state *conn_state)
+{
+	struct cix_dp *dp = bridge_to_dp(bridge);
+	int bpc;
+	int bpp;
+	int ret;
+
+	cix_dp_adjust_mode(&crtc_state->mode, &crtc_state->adjusted_mode);
+
+	/*
+	 * The DPU always outputs RGB, so only validate that the mode fits the
+	 * link. The colour format used to drive the sink is picked again when
+	 * the bridge is enabled. Read the sink first: this check runs before
+	 * the encoder enable path.
+	 */
+	dp->ops->detect(dp);
+
+	ret = cix_dp_pick_config(dp, conn_state, &crtc_state->mode,
+				 &crtc_state->adjusted_mode,
+				 NULL, &bpc, &bpp);
+	if (ret)
+		return ret;
+
+	/*
+	 * The colour space is programmed through a VSC SDP, so a change of
+	 * the requested colour space requires a full modeset.
+	 */
+	if (dp->caps.vsc_supported) {
+		const struct drm_connector_state *old_conn_state;
+
+		old_conn_state =
+			drm_atomic_get_old_connector_state(bridge_state->base.state,
+							   conn_state->connector);
+		if (old_conn_state &&
+		    old_conn_state->colorspace != conn_state->colorspace)
+			crtc_state->mode_changed = true;
+	}
+
+	return 0;
+}
+
+static void
+cix_dp_bridge_atomic_enable(struct drm_bridge *bridge,
+			    struct drm_atomic_commit *state)
+{
+	struct cix_dp *dp = bridge_to_dp(bridge);
+	struct drm_connector_state *conn_state;
+	struct drm_crtc_state *crtc_state;
+	struct drm_connector *connector;
+	int ret;
+
+	connector = drm_atomic_get_new_connector_for_encoder(state,
+							     bridge->encoder);
+	if (!connector)
+		return;
+
+	conn_state = drm_atomic_get_new_connector_state(state, connector);
+	if (!conn_state || !conn_state->crtc)
+		return;
+
+	crtc_state = drm_atomic_get_new_crtc_state(state, conn_state->crtc);
+	if (!crtc_state)
+		return;
+
+	ret = dp->ops->prepare(dp);
+	if (ret) {
+		if (ret != -ENODEV)
+			dev_err(dp->dev, "failed to prepare DP output: %d\n",
+				ret);
+		return;
+	}
+
+	ret = cix_dp_bridge_mode_set(dp, crtc_state, conn_state);
+	if (ret) {
+		dev_err(dp->dev, "failed to set DP mode: %d\n", ret);
+		goto err_unprepare;
+	}
+
+	ret = dp->ops->encoder_enable(dp, dp->dp_panel.source_id, true);
+	if (ret) {
+		dev_err(dp->dev, "failed to enable DP output: %d\n", ret);
+		goto err_unprepare;
+	}
+
+	return;
+
+err_unprepare:
+	dp->ops->unprepare(dp);
+}
+
+static void
+cix_dp_bridge_atomic_disable(struct drm_bridge *bridge,
+			     struct drm_atomic_commit *state)
+{
+	struct cix_dp *dp = bridge_to_dp(bridge);
+
+	dp->ops->encoder_enable(dp, dp->dp_panel.source_id, false);
+}
+
+static int cix_dp_connector_atomic_check(struct drm_connector *conn,
+					 struct drm_atomic_commit *state)
+{
+	struct drm_connector_state *new_con_state =
+		drm_atomic_get_new_connector_state(state, conn);
+
+	if (!new_con_state)
+		return 0;
+
+	/* PSR is not implemented, so never advertise self refresh support. */
+	new_con_state->self_refresh_aware = false;
+
+	return 0;
+}
+
+static const struct drm_connector_funcs cix_dp_connector_funcs = {
+	.detect = cix_dp_connector_detect,
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.destroy = drm_connector_cleanup,
+	.reset = drm_atomic_helper_connector_reset,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+	.oob_hotplug_event = cix_dp_oob_hotplug_event,
+};
+
+static const struct drm_connector_helper_funcs
+cix_dp_connector_helper_funcs = {
+	.get_modes = cix_dp_connector_get_modes,
+	.best_encoder = cix_dp_connector_best_encoder,
+	.mode_valid = cix_dp_connector_mode_valid,
+	.atomic_check = cix_dp_connector_atomic_check,
+};
+
+static void cix_dp_add_properties(struct drm_connector *connector)
+{
+	if (!drm_mode_create_dp_colorspace_property(connector, 0))
+		drm_connector_attach_colorspace_property(connector);
+
+	drm_connector_attach_max_bpc_property(connector, 8, 10);
+	drm_connector_attach_dp_subconnector_property(connector);
+	drm_connector_attach_content_type_property(connector);
+}
+
+static int cix_dp_connector_create(struct cix_dp *dp,
+				   struct drm_encoder *encoder)
+{
+	struct cix_connector *conn = &dp->connector;
+	struct drm_connector *connector = &conn->base;
+	int ret;
+
+	conn->dp = dp;
+
+	connector->polled = DRM_CONNECTOR_POLL_HPD;
+	connector->ycbcr_420_allowed = true;
+
+	ret = drm_connector_init_with_ddc(encoder->dev, connector,
+					  &cix_dp_connector_funcs,
+					  DRM_MODE_CONNECTOR_DisplayPort,
+					  &dp->aux.ddc);
+	if (ret)
+		return ret;
+
+	drm_connector_helper_add(connector, &cix_dp_connector_helper_funcs);
+
+	drm_atomic_helper_connector_reset(connector);
+
+	ret = drm_connector_attach_encoder(connector, encoder);
+	if (ret)
+		goto err_cleanup;
+
+	cix_dp_add_properties(connector);
+
+	dp->dp_panel.connector = conn;
+
+	return 0;
+
+err_cleanup:
+	drm_connector_cleanup(connector);
+	return ret;
+}
+
+static int cix_dp_bridge_attach(struct drm_bridge *bridge,
+				struct drm_encoder *encoder,
+				enum drm_bridge_attach_flags flags)
+{
+	struct cix_dp *dp = bridge_to_dp(bridge);
+	int ret;
+
+	dp->drm = bridge->dev;
+	WRITE_ONCE(dp->hpd_stopped, false);
+
+	ret = dp->ops->aux_register(dp);
+	if (ret)
+		goto err_clear_drm;
+
+	/*
+	 * Komeda (ARM Mali DPU on Sky1, not in this series) calls
+	 * drm_bridge_attach() with attach flags 0 and does not register a
+	 * connector; create one here so userspace gets a DP output.
+	 */
+	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)
+		return 0;
+
+	ret = cix_dp_connector_create(dp, encoder);
+	if (ret)
+		goto err_aux;
+
+	/* The bridge may have been attached long after the sink was plugged. */
+	dp->ops->replay_deferred_hotplug(dp);
+
+	return 0;
+
+err_aux:
+	dp->ops->aux_cleanup(dp);
+err_clear_drm:
+	dp->drm = NULL;
+	return ret;
+}
+
+static void cix_dp_bridge_detach(struct drm_bridge *bridge)
+{
+	struct cix_dp *dp = bridge_to_dp(bridge);
+
+	/* Stop workers before the connector goes away. */
+	dp->ops->quiesce_hpd(dp);
+
+	dp->dp_panel.connector = NULL;
+
+	if (dp->connector.base.dev)
+		drm_connector_cleanup(&dp->connector.base);
+
+	dp->ops->aux_cleanup(dp);
+
+	dp->drm = NULL;
+}
+
+static const struct drm_bridge_funcs cix_dp_bridge_funcs = {
+	.attach = cix_dp_bridge_attach,
+	.detach = cix_dp_bridge_detach,
+	.atomic_check = cix_dp_bridge_atomic_check,
+	.atomic_enable = cix_dp_bridge_atomic_enable,
+	.atomic_disable = cix_dp_bridge_atomic_disable,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
+	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
+};
+
+struct cix_dp *cix_dp_bridge_alloc(struct device *dev)
+{
+	return devm_drm_bridge_alloc(dev, struct cix_dp, bridge,
+				     &cix_dp_bridge_funcs);
+}
diff --git a/drivers/gpu/drm/cix/dptx/cix_dptx_drm.h b/drivers/gpu/drm/cix/dptx/cix_dptx_drm.h
new file mode 100644
index 000000000000..3ac57faa349e
--- /dev/null
+++ b/drivers/gpu/drm/cix/dptx/cix_dptx_drm.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * CIX Sky1 DisplayPort DRM helpers
+ *
+ * Copyright 2026 Cix Technology Group Co., Ltd.
+ */
+
+#ifndef CIX_DPTX_DRM_H
+#define CIX_DPTX_DRM_H
+
+struct cix_dp;
+struct device;
+
+struct cix_dp *cix_dp_bridge_alloc(struct device *dev);
+
+#endif /* CIX_DPTX_DRM_H */
