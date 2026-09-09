Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F667C79FB6
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 12:56:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0B8F10F135;
	Wed,  9 Sep 2026 12:56:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tZCVUflz";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013021.outbound.protection.outlook.com
 [40.107.201.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26BD810F135
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 12:56:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dEPu6jtMvDrd9k/J2g1lyZ5QzI/HwQygNOdCRuK2/ik+brQOS+boqYsc4xMaE6wUxDqm9CIFlZO0r60TWmINhsF8pyhYQiE1eMa3CjjQwm5ctoLPUtcQs9jrflhkRmSsZFnZAmk9+FeieiUK8QsL9t409xa9nt5vrnTO0BUCzVOmz1NKzx4BFN63dDbMzMmSgDSVQDHNTWgcU2NatTxfgRnGXTW72i3WT6meTrbCp6K3NVvZxDsCmxmu4lXfTP7+jfbycyRous07I00Z3pTsigLUBwV0vBvW/am0aSkncoma7b6Y1u8GugblIR7iJ0xANvB7YHI+2gktWCQZ19Lo+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E1Et2oyUmy24tDoBL18cNQA6oNpsg/++EergC99QmWc=;
 b=F8oT51dlGJV56lS+4QgaSc55ZMI9XTAs0TBFeuehT9s0bXIipM2x0bm4o8ztpjXQW/z0idSHDMmPQXOnJHzljye5kDdBc4X9lgIaAE+aWxEiyTPZenU7fqReC4mgx0rYwMVio8LDFGTVet7aQfAOSW+BS/ZSVImKWYEGiljhacc+x2MCJp9snruz9Ne0eBeZlntDbSug8aob1sjZIMA/63UbsFM669oZyrwitCRErQHfk/vDo9+J/5gwn1m1t5dHkq1loz9m3PttVmflGV3+CuTqdphsoMHgPPjiDlaL9R2FZGtOVKa8aTMK+u3LbIp5O+3qupxt4Jf8f9JjXNaeFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1Et2oyUmy24tDoBL18cNQA6oNpsg/++EergC99QmWc=;
 b=tZCVUflz/L3fs4sPmMJDZVPSHNhO5rZz0u0q00IUnEABla2SR7KOIwWTz6u4m0NSpMUM9IHApO/qvSQFTDR+R65Sb+VrhJHfiB3qB6Lmt1N+mwqpZDVumfYlCX9E8842FSu/DkNw2PqFEptSbMOoIFxAEn95fe+GFdGWhK7tlY8=
Received: from BL1PR13CA0006.namprd13.prod.outlook.com (2603:10b6:208:256::11)
 by SJ2PR12MB9006.namprd12.prod.outlook.com (2603:10b6:a03:540::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 9 Sep
 2026 12:56:45 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:208:256:cafe::6f) by BL1PR13CA0006.outlook.office365.com
 (2603:10b6:208:256::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Wed, 9
 Sep 2026 12:56:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Wed, 9 Sep 2026 12:56:43 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 9 Sep
 2026 07:56:42 -0500
Received: from amd-B550M-DS3H.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 9 Sep 2026 07:56:31 -0500
From: Syed Saba Kareem <syed.sabakareem@amd.com>
To: <vkoul@kernel.org>
CC: <broonie@kernel.org>, <Sunil-kumar.Dommati@amd.com>,
 <Mario.Limonciello@amd.com>, <venkataprasad.potturu@amd.com>,
 <yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>, "Syed
 Saba Kareem" <Syed.SabaKareem@amd.com>, Vijendar Mukunda
 <Vijendar.Mukunda@amd.com>, Liam Girdwood <lgirdwood@gmail.com>, "Jaroslav
 Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Peter Ujfalusi
 <peter.ujfalusi@linux.intel.com>, Daniel Baluta <daniel.baluta@nxp.com>, "Kai
 Vehmanen" <kai.vehmanen@linux.intel.com>, Sumit Semwal
 <sumit.semwal@linaro.org>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Simon Trimmer <simont@opensource.cirrus.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>, Mario Limonciello
 <mario.limonciello@amd.com>, "open list:SOUNDWIRE SUBSYSTEM"
 <linux-sound@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS"
 <sound-open-firmware@alsa-project.org>, "open list:BPF
 [MISC]:Keyword:(?:\\b|_)bpf(?:\\b|_)" <bpf@vger.kernel.org>, "open list:DMA
 BUFFER SHARING FRAMEWORK:Keyword:\\bdma_(?:buf|fence|resv)\\b"
 <linux-media@vger.kernel.org>, "open list:DMA BUFFER SHARING
 FRAMEWORK:Keyword:\\bdma_(?:buf|fence|resv)\\b"
 <dri-devel@lists.freedesktop.org>, "moderated list:DMA BUFFER SHARING
 FRAMEWORK:Keyword:\\bdma_(?:buf|fence|resv)\\b"
 <linaro-mm-sig@lists.linaro.org>
Subject: [PATCH 4/4] soundwire: amd: Add BRA/BPT firmware download support
Date: Wed, 9 Sep 2026 18:25:56 +0530
Message-ID: <20260909125605.280973-5-syed.sabakareem@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909125605.280973-1-syed.sabakareem@amd.com>
References: <20260909125605.280973-1-syed.sabakareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|SJ2PR12MB9006:EE_
X-MS-Office365-Filtering-Correlation-Id: 49167696-4f33-4937-6736-08df0e71cc86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|7416014|376014|6133799003|18002099003|22082099003|56012099006|5023799004|11063799006|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info: rNxf4QIiO3K0l6GU27rsKMa0kSVrTy+DNagDjMCTkl/8YREwjr/gdpUWUsOUwYXGDZOVPMxObGRcT0rvS4hWutYL5IiwOOpeT3Tf9EdtT7imS4LGy3uL3foLuBNFPYFv6EVhonMPQEgn1y6OECbXW6VU1TPrlck79xO4j04hIp5VRsTEmOTdihU9sQWf6UKyxEVflVHxdzUbffjy2+KuW+RBI8Zh9OFYqZ3w6YpGIXYE+CmUAuX4klI8cL9R7bA6OgIxlgiPO7ddq4+urTIJSJ179wscRyXSajd+eGZ3MQw5pj3csMW4JKceBQRBtarwADK2GOXmCG9Hgtfln4mOcWiWk5seT2BlqUczIQNvFa8ruobYbWIUI9R3Sd0h+UqL0MiYzzGdpUZZsJjiCXefRuIPgGxVMNpJYpM0VuuJuMqvDl9Rf+LSNEnc8Y4QIHh4+uOSLvYuLNZUWmPN8imND6/dYCRifBrpqT2rFZJEXbhn7NK4tWrFBCbx0pmm2CcRMxoYKHcvEOVUypdNZxk2IwLksXgltg2CMgIMQ7EEghGywgrc6QhTnmZM2BG54z5FAyq8vE0tDjTcArd3oEzZuI4uWrX8wnxtHeAhPjbeXGoXKu1aMoflmIxOK5OZluHqgCHXya378gJDfw127LSso2lA/PeKCOXN5CQkJXUiZLdOln2uLOCkuLADZJpQwgRaWA/GJFW67Kmw0bHHcR8/Xg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(7416014)(376014)(6133799003)(18002099003)(22082099003)(56012099006)(5023799004)(11063799006)(3023799007)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jrdLAMrUcTdtxKD8Vq0TQPHj3g8NZDGjYOg7wmRAa7R394YcEpGVdMLPIL24ybrX0cLKwsykbhCzQRIKloKzhIbkHe5lGutxPOpbNW9JGpp5eseytCjwcEeeI7cRqbuz3MSDX5uxDRfjNoZfUO30+4qfwPk6gbSPvaXcukRo4JIs0TLvsjCCEvlp9TIQkLZk/dHu405A3wiU4SjRjaNmXebXNzW07ZDNDvw5yC6/V1qr809gmMx3g5beSxsIuH0rVlu9WrXfJW9C8EbMWXdQ6AAmByT68oMWZ9jLkWeQx2AUd9RKKmDoqN5jj7DSSdA90Smjqn0Kgm7JOwYkUbPQgaFuZQfjqlKHB0SgRVGwCGx7zJ4bpQ5EQQCXoguXFy+1LRioD+QRfNo9eDe7wdMiE5b5WPSi8++wOBtVtX8+k//MTaVzTKy/Xrl9OYaMzU59
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 12:56:43.4871 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49167696-4f33-4937-6736-08df0e71cc86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9006
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

From: Syed Saba Kareem <Syed.SabaKareem@amd.com>

Add Bulk Register Access (BRA) / Bulk Payload Transport (BPT) support
for AMD SoundWire platforms. This enables high-speed firmware download
to SoundWire peripherals via DP0, using the ACP BRA DMA engine.

Key design points:

- Uses the SoundWire stream framework (sdw_prepare_stream,
  sdw_enable_stream, sdw_disable_stream, sdw_deprepare_stream)
  for all DP0 port programming and bank switches. No manual DP0
  register writes or bank mirrors are needed.

- BRA transport parameters (hstart, hstop, SampleInterval,
  BytesPerFrame) are computed dynamically from the current bus
  frame shape, not hardcoded.

- The ACP BPT DMA engine is triggered by the bank switch
  performed inside sdw_enable_stream(), and stopped by the
  bank switch in sdw_disable_stream().

- Non-contiguous firmware sections are handled by iterating
  per-section: large sections use BRA DMA, small sections
  (< one BRA frame) fall back to sdw_nwrite/sdw_nread.

- BPT stream m_rt entries are skipped in audio compute_params
  to prevent BPT transport parameters from corrupting audio
  port block offset calculations.

- DP0 port_params, xport_params, and port_enable callbacks
  return early for BPT streams since the ACP BRA descriptor
  registers handle DP0 configuration independently.

- bus->bpt_stream is published with WRITE_ONCE() only after the stream
  runtime is added and bpt_stream_refcount is raised under bus_lock, and
  is cleared before the runtime is removed and the stream is freed, so
  the lockless DP0 port callbacks never observe a half-initialised or
  freed stream pointer.

- bus->bpt_fw_download is set around the transfer so sdw_master_rt_alloc()
  admits the BPT allocation while audio streams on the same bus are
  allocated but idle (for example an amplifier left DISABLED across a
  power-off-mode suspend that must re-download firmware on resume). It is
  cleared on the close and open error paths. An audio stream that is
  actively using the bus still blocks the transfer.

- On an aborted or timed-out transfer the ACP BPT DMA engine is disarmed
  (PORT_EN=0) before the sdw_disable_stream() bank switch, so the bank
  switch cannot re-trigger a DMA write into the buffer that is freed once
  the transfer returns.

- A per-manager bpt_lock serialises concurrent BPT transfers
  from multiple slave probes. pm_runtime keeps the bus clock
  active during transfers.

- PTE-based ACP ATU mapping provides DMA scatter-gather for the
  firmware buffer. The ATU maps up to 512 4KB pages (2 MB per
  transfer); each transfer is additionally bounded by the SoundWire
  BPT limit of 1 MB (SDW_BPT_MSG_MAX_BYTES), which the driver enforces.

Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
---
 drivers/soundwire/amd_init.c      |    1 +
 drivers/soundwire/amd_manager.c   | 1315 ++++++++++++++++++++++++++++-
 drivers/soundwire/amd_manager.h   |   17 +-
 include/linux/soundwire/sdw_amd.h |   29 +
 sound/soc/amd/ps/acp63.h          |    2 +
 sound/soc/amd/ps/pci-ps.c         |    2 +
 sound/soc/sof/amd/acp.c           |    2 +
 sound/soc/sof/amd/acp.h           |    2 +
 8 files changed, 1365 insertions(+), 5 deletions(-)

diff --git a/drivers/soundwire/amd_init.c b/drivers/soundwire/amd_init.c
index 8e419ddfa516..00f4a87da7cb 100644
--- a/drivers/soundwire/amd_init.c
+++ b/drivers/soundwire/amd_init.c
@@ -120,6 +120,7 @@ static struct sdw_amd_ctx *sdw_amd_probe_controller(struct sdw_amd_res *res)
 
 		sdw_pdata[index].instance = index;
 		sdw_pdata[index].acp_sdw_lock = res->acp_lock;
+		sdw_pdata[index].acp_bra_lock = res->acp_bra_lock;
 		sdw_pdata[index].acp_rev = res->acp_rev;
 		pdevinfo[index].name = "amd_sdw_manager";
 		pdevinfo[index].id = index;
diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index a3316efdf8ac..a1e53a55c188 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -9,6 +9,7 @@
 #include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/io.h>
+#include <linux/dma-mapping.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -16,6 +17,7 @@
 #include <linux/soundwire/sdw.h>
 #include <linux/soundwire/sdw_registers.h>
 #include <linux/pm_runtime.h>
+#include <linux/sched.h>
 #include <linux/wait.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
@@ -23,15 +25,53 @@
 #include "amd_init.h"
 #include "amd_manager.h"
 
+/* ATU register offsets */
+#define ACPAXI2AXI_ATU_PAGE_SIZE_GRP_1		0x0000C00
+#define ACPAXI2AXI_ATU_BASE_ADDR_GRP_1		0x0000C04
+#define ACPAXI2AXI_ATU_CTRL			0x0000C40
+#define ACP_SCRATCH_REG_0			0x0010000
+
 #define DRV_NAME "amd_sdw_manager"
 
 #define to_amd_sdw(b)	container_of(b, struct amd_sdw_manager, bus)
 
+#define AMD_BPT_MSG_BYTE_MIN 16
+
+/*
+ * BRA PTE/ATU Configuration Constants
+ *
+ * BRA DMA uses ATU GRP_1 with 4KB pages. GRP_1 PTE table base sits at
+ * ACP_SCRATCH_REG_0 (offset 0x03800000 from MMIO base). The AXI window
+ * for GRP_1 starts at ACP_BRA_MEM_WINDOW_START (0x4000000). PTE entries
+ * are 8 bytes each and start at scratch offset ACP_BRA_PTE_OFFSET (0x0).
+ * ATU_PAGE_SIZE = 0x0 means DISABLED; set ACP_BRA_PAGE_SIZE_4K_ENABLE (0x2)
+ * to enable 4KB page translation.
+ */
+#define ACP_BRA_SRAM_GRP1_BASE		0x03800000
+#define ACP_BRA_PAGE_SIZE_4K_ENABLE	0x2
+#define ACP_BRA_PTE_OFFSET		0x0
+#define ACP_BRA_MEM_WINDOW_START	0x4000000
+#define ACP_BRA_ATU_PTE_ENTRY_SIZE	8
+#define ACP_BRA_MAX_PTE_ENTRIES		512
+struct amd_bra_params {
+	u32 sample_interval;
+	u32 bytes_per_frame;
+	u8 hstart;
+	u8 hstop;
+	u8 word_length;
+	u8 dev_addr;
+	bool write_mode;
+	u32 peripheral_first_byte_addr;
+	u32 dma_base_addr;
+	u32 transfer_length;
+};
+
 static int amd_sdw_clk_init_ctrl(struct amd_sdw_manager *amd_manager)
 {
 	struct sdw_bus *bus = &amd_manager->bus;
 	struct sdw_master_prop *prop = &bus->prop;
-	u32 divider;
+	u32 val;
+	int divider;
 
 	dev_dbg(amd_manager->dev, "mclk %d max %d row %d col %d frame_rate:%d\n",
 		prop->mclk_freq, prop->max_clk_freq, prop->default_row,
@@ -44,16 +84,28 @@ static int amd_sdw_clk_init_ctrl(struct amd_sdw_manager *amd_manager)
 	}
 
 	/* Set clock divider */
+	dev_dbg(amd_manager->dev, "bus params curr_dr_freq: %d\n",
+		bus->params.curr_dr_freq);
 	divider = (prop->mclk_freq / bus->params.curr_dr_freq);
+
 	writel(divider, amd_manager->mmio + ACP_SW_CLK_FREQUENCY_CTRL);
+	val = readl(amd_manager->mmio + ACP_SW_CLK_FREQUENCY_CTRL);
+	dev_dbg(amd_manager->dev, "ACP_SW_CLK_FREQUENCY_CTRL:0x%x\n", val);
 
 	/* Set frame shape base on the actual bus frequency. */
 	prop->default_col = bus->params.curr_dr_freq /
 			    prop->default_frame_rate / prop->default_row;
+
+	dev_dbg(amd_manager->dev, "default_frame_rate:%d default_row: %d default_col: %d\n",
+		prop->default_frame_rate, prop->default_row, prop->default_col);
 	amd_manager->cols_index = sdw_find_col_index(prop->default_col);
 	amd_manager->rows_index = sdw_find_row_index(prop->default_row);
 	bus->params.col = prop->default_col;
 	bus->params.row = prop->default_row;
+	dev_dbg(amd_manager->dev, "rows_index: %d cols_index: %d\n",
+		amd_manager->rows_index, amd_manager->cols_index);
+	dev_dbg(amd_manager->dev, "params.col:0x%x params.row:0x%x\n",
+		bus->params.col, bus->params.row);
 	return 0;
 }
 
@@ -267,7 +319,8 @@ static u64 amd_sdw_send_cmd_get_resp(struct amd_sdw_manager *amd_manager, u32 lo
 	}
 
 	if (sts & AMD_SDW_IMM_RES_VALID) {
-		dev_err(amd_manager->dev, "SDW%x manager is in bad state\n", amd_manager->instance);
+		dev_warn(amd_manager->dev, "SDW%x stale IMM response cleared\n",
+			 amd_manager->instance);
 		writel(AMD_SDW_IMM_RES_VALID, amd_manager->mmio + ACP_SW_IMM_CMD_STS);
 	}
 	writel(upper_data, amd_manager->mmio + ACP_SW_IMM_CMD_UPPER_WORD);
@@ -465,12 +518,51 @@ static u32 amd_sdw_read_ping_status(struct sdw_bus *bus)
 	return slave_stat;
 }
 
+/*
+ * amd_sdw_bra_sample_interval() - Derive the BRA SampleInterval
+ *
+ * The ACP BRA hardware descriptor and the peripheral DP0 must be
+ * programmed with an identical SampleInterval, otherwise the frame
+ * layout seen by the two ends diverges and the transfer misaligns.
+ * Both amd_sdw_compute_params() (peripheral DP0) and
+ * amd_sdw_calculate_bra_params() (ACP BRA descriptor) use this helper
+ * so the value can never diverge.
+ *
+ * BlockCount algorithm (col_width = hstop - hstart + 1):
+ *  - col_width >= 8: BlockCount = 1, SI = nc
+ *  - col_width == 1: SI = nc * 8
+ *  - otherwise:      smallest BlockCount in [2..8] such that
+ *                    (BlockCount * col_width >= 8) && (nr % BlockCount == 0),
+ *                    SI = nc * BlockCount
+ *
+ * Returns 0 if no valid BlockCount can be found.
+ */
+static u32 amd_sdw_bra_sample_interval(u32 nr, u32 nc, u8 hstart, u8 hstop)
+{
+	u8 col_width = hstop - hstart + 1;
+	u32 block_count;
+
+	if (col_width >= 8)
+		return nc;		/* BlockCount = 1 */
+	if (col_width == 1)
+		return nc * 8;
+
+	for (block_count = 2; block_count <= 8; block_count++) {
+		if ((block_count * col_width >= 8) &&
+		    (nr % block_count == 0))
+			return nc * block_count;
+	}
+
+	return 0;
+}
+
 static int amd_sdw_compute_params(struct sdw_bus *bus, struct sdw_stream_runtime *stream)
 {
 	struct amd_sdw_manager *amd_manager = to_amd_sdw(bus);
 	struct sdw_transport_data t_data = {0};
 	struct sdw_master_runtime *m_rt;
 	struct sdw_port_runtime *p_rt;
+	struct sdw_slave_runtime *s_rt;
 	struct sdw_bus_params *b_params = &bus->params;
 	int port_bo, hstart, hstop, sample_int;
 	unsigned int rate, bps, channels;
@@ -478,6 +570,60 @@ static int amd_sdw_compute_params(struct sdw_bus *bus, struct sdw_stream_runtime
 	static unsigned int next_offset[AMD_SDW_MAX_MANAGER_COUNT] = {1};
 	unsigned int inst_id = amd_manager->instance;
 
+	/*
+	 * BPT stream: compute DP0 transport/port params so the SoundWire stream
+	 * framework can program peripheral DP0 registers in sdw_prepare_stream().
+	 */
+	if (stream->type == SDW_STREAM_BPT) {
+		u32 nc = bus->params.col;
+		u8 bpt_hstart = amd_manager->bra_hstart;
+		u8 bpt_hstop = amd_manager->bra_hstop;
+		u32 bpt_si = amd_sdw_bra_sample_interval(bus->params.row, nc,
+							 bpt_hstart, bpt_hstop);
+
+		if (!bpt_si || bpt_si > bus->params.row * nc) {
+			dev_err(bus->dev,
+				"BPT: cannot derive SI: NR=%u NC=%u hstart=%u hstop=%u\n",
+				bus->params.row, nc, bpt_hstart, bpt_hstop);
+			return -EINVAL;
+		}
+
+		dev_dbg(bus->dev, "BPT compute: NC=%u hstart=%u hstop=%u SI=%u\n",
+			nc, bpt_hstart, bpt_hstop, bpt_si);
+
+		list_for_each_entry(m_rt, &bus->m_rt_list, bus_node) {
+			if (m_rt->stream != stream)
+				continue;
+
+			list_for_each_entry(p_rt, &m_rt->port_list, port_node) {
+				sdw_fill_xport_params(&p_rt->transport_params,
+						      p_rt->num, false,
+						      SDW_BLK_GRP_CNT_1, bpt_si,
+						      0, 0, bpt_hstart, bpt_hstop,
+						      SDW_BLK_PKG_PER_PORT, 0);
+				sdw_fill_port_params(&p_rt->port_params,
+						     p_rt->num, 8,
+						     SDW_PORT_FLOW_MODE_ISOCH,
+						     SDW_PORT_DATA_MODE_NORMAL);
+			}
+
+			list_for_each_entry(s_rt, &m_rt->slave_rt_list, m_rt_node) {
+				list_for_each_entry(p_rt, &s_rt->port_list, port_node) {
+					sdw_fill_xport_params(&p_rt->transport_params,
+							      p_rt->num, false,
+							      SDW_BLK_GRP_CNT_1, bpt_si,
+							      0, 0, bpt_hstart, bpt_hstop,
+							      SDW_BLK_PKG_PER_PORT, 0);
+					sdw_fill_port_params(&p_rt->port_params,
+							     p_rt->num, 8,
+							     SDW_PORT_FLOW_MODE_ISOCH,
+							     SDW_PORT_DATA_MODE_NORMAL);
+				}
+			}
+		}
+		return 0;
+	}
+
 	port_bo = 0;
 	hstart = 1;
 	hstop = bus->params.col - 1;
@@ -485,6 +631,14 @@ static int amd_sdw_compute_params(struct sdw_bus *bus, struct sdw_stream_runtime
 	t_data.hstart = hstart;
 
 	list_for_each_entry(m_rt, &bus->m_rt_list, bus_node) {
+		/*
+		 * Skip BPT stream entries when computing audio params.
+		 * BPT may have stream params (rate/bps) that don't match the
+		 * assumptions below and can lead to division by zero.
+		 */
+		if (m_rt->stream->type == SDW_STREAM_BPT)
+			continue;
+
 		rate = m_rt->stream->params.rate;
 		bps = m_rt->stream->params.bps;
 		channels = m_rt->stream->params.ch_count;
@@ -557,6 +711,13 @@ static int amd_sdw_port_params(struct sdw_bus *bus, struct sdw_port_params *p_pa
 	struct amd_sdw_manager *amd_manager = to_amd_sdw(bus);
 	u32 frame_fmt_reg, dpn_frame_fmt;
 
+	/*
+	 * BPT uses dedicated ACP BRA descriptor registers; ignore DP0 ops only.
+	 * Allow DPn audio port ops to proceed even while BPT is active.
+	 */
+	if (READ_ONCE(bus->bpt_stream) && p_params->num == 0)
+		return 0;
+
 	dev_dbg(amd_manager->dev, "p_params->num:0x%x\n", p_params->num);
 	switch (amd_manager->acp_rev) {
 	case ACP63_PCI_REV_ID:
@@ -601,6 +762,13 @@ static int amd_sdw_transport_params(struct sdw_bus *bus,
 	u32 frame_fmt_reg, sample_int_reg, hctrl_dp0_reg;
 	u32 offset_reg, lane_ctrl_ch_en_reg;
 
+	/*
+	 * BPT uses dedicated ACP BRA descriptor registers; ignore DP0 ops only.
+	 * Allow DPn audio port ops to proceed even while BPT is active.
+	 */
+	if (READ_ONCE(bus->bpt_stream) && params->port_num == 0)
+		return 0;
+
 	switch (amd_manager->acp_rev) {
 	case ACP63_PCI_REV_ID:
 		switch (amd_manager->instance) {
@@ -673,6 +841,13 @@ static int amd_sdw_port_enable(struct sdw_bus *bus,
 	u32 dpn_ch_enable;
 	u32 lane_ctrl_ch_en_reg;
 
+	/*
+	 * BPT port enable/disable is handled in execute_bra_transfer; ignore
+	 * DP0 ops only. Allow DPn audio port ops even while BPT is active.
+	 */
+	if (READ_ONCE(bus->bpt_stream) && enable_ch->port_num == 0)
+		return 0;
+
 	switch (amd_manager->acp_rev) {
 	case ACP63_PCI_REV_ID:
 		switch (amd_manager->instance) {
@@ -710,6 +885,1013 @@ static int amd_sdw_port_enable(struct sdw_bus *bus,
 	return 0;
 }
 
+static int amd_sdw_calculate_bra_params(struct amd_sdw_manager *amd_manager,
+					struct amd_bra_params *params,
+					u8 peripheral_addr)
+{
+	struct sdw_bus *bus = &amd_manager->bus;
+	u32 nr = bus->params.row;  /* current rows - NOT enlarged */
+	u32 nc = bus->params.col;  /* current cols */
+	u8 hstart = amd_manager->bra_hstart;
+	u8 hstop  = amd_manager->bra_hstop;
+	u8 col_width = hstop - hstart + 1;
+	u32 sample_interval;
+	u32 bits_per_frame;
+	u32 bpf;
+
+	params->hstart      = hstart;
+	params->hstop       = hstop;
+	params->word_length = 8;  /* BRA is always byte-oriented: WL=8 */
+
+	/*
+	 * Derive SampleInterval via the shared helper so the ACP BRA
+	 * descriptor and the peripheral DP0 (programmed in
+	 * amd_sdw_compute_params()) always agree.
+	 */
+	sample_interval = amd_sdw_bra_sample_interval(nr, nc, hstart, hstop);
+
+	if (!sample_interval || sample_interval > nr * nc) {
+		dev_err(amd_manager->dev,
+			"BPT: cannot derive SI: col_width=%u NR=%u NC=%u\n",
+			col_width, nr, nc);
+		return -EINVAL;
+	}
+
+	bits_per_frame = ((nr * nc) / sample_interval) * params->word_length;
+	bpf = bits_per_frame / 8;
+	if (bpf <= 10) {
+		dev_err(amd_manager->dev,
+			"BPT: frame too small: %u bytes (NR=%u NC=%u SI=%u)\n",
+			bpf, nr, nc, sample_interval);
+		return -EINVAL;
+	}
+	bpf -= 10;  /* subtract BRA protocol overhead */
+	if (bpf > 511)
+		bpf = 511;
+
+	params->sample_interval = sample_interval;
+	params->bytes_per_frame = bpf;
+	params->dev_addr        = peripheral_addr;
+
+	dev_dbg(amd_manager->dev,
+		"BPT calc_params: NR=%u NC=%u col_width=%u WL=%u SI=%u BPF=%u hstart=%u hstop=%u dev=%u\n",
+		nr, nc, col_width, params->word_length, sample_interval,
+		bpf, hstart, hstop, peripheral_addr);
+	return 0;
+}
+
+static u32 amd_sdw_bra_configure_pte(struct amd_sdw_manager *amd_manager,
+				     dma_addr_t dma_addr, size_t size)
+{
+	u32 num_pages = (u32)(PAGE_ALIGN(size) >> PAGE_SHIFT);
+	u32 low, high, val;
+	u16 page_idx;
+	dma_addr_t addr = dma_addr;
+
+	if (num_pages > ACP_BRA_MAX_PTE_ENTRIES) {
+		dev_err(amd_manager->dev,
+			"BRA buffer too large: %u pages (max %u)\n",
+			num_pages, ACP_BRA_MAX_PTE_ENTRIES);
+		return 0;
+	}
+
+	/*
+	 * Program ATU GRP_1 with 4KB pages. PTE entries start at scratch offset
+	 * ACP_BRA_PTE_OFFSET (0x0); DMA AXI base = ACP_BRA_MEM_WINDOW_START.
+	 *
+	 * The ATU and scratch registers are ACP-global, so they must be
+	 * accessed via acp_mmio (the shared ACP base) rather than mmio
+	 * (which carries the per-instance SDW_MANAGER_REG_OFFSET). Otherwise
+	 * SoundWire instance 1 would program the wrong physical addresses.
+	 */
+	writel(ACP_BRA_SRAM_GRP1_BASE | BIT(31),
+	       amd_manager->acp_mmio + ACPAXI2AXI_ATU_BASE_ADDR_GRP_1);
+	writel(ACP_BRA_PAGE_SIZE_4K_ENABLE,
+	       amd_manager->acp_mmio + ACPAXI2AXI_ATU_PAGE_SIZE_GRP_1);
+
+	val = ACP_BRA_PTE_OFFSET;
+	for (page_idx = 0; page_idx < num_pages; page_idx++) {
+		low  = lower_32_bits(addr);
+		high = upper_32_bits(addr) | BIT(31);
+		writel(low,  amd_manager->acp_mmio + ACP_SCRATCH_REG_0 + val);
+		writel(high, amd_manager->acp_mmio + ACP_SCRATCH_REG_0 + val + 4);
+		val += ACP_BRA_ATU_PTE_ENTRY_SIZE;
+		addr += PAGE_SIZE;
+	}
+
+	/* Flush ATU cache to ensure PTE update takes effect */
+	writel(0x1, amd_manager->acp_mmio + ACPAXI2AXI_ATU_CTRL);
+
+	dev_dbg(amd_manager->dev,
+		"BRA PTE: phys=0x%llx pages=%u ACP=0x%08x\n",
+		(u64)dma_addr, num_pages, ACP_BRA_MEM_WINDOW_START);
+
+	return ACP_BRA_MEM_WINDOW_START;
+}
+
+static void amd_sdw_bra_deconfigure_pte(struct amd_sdw_manager *amd_manager,
+					size_t size)
+{
+	u32 num_pages = (u32)(PAGE_ALIGN(size) >> PAGE_SHIFT);
+	u32 val;
+	u16 page_idx;
+
+	if (num_pages > ACP_BRA_MAX_PTE_ENTRIES)
+		num_pages = ACP_BRA_MAX_PTE_ENTRIES;
+
+	/* Clear all BRA PTE entries at scratch[ACP_BRA_PTE_OFFSET..] */
+	val = ACP_BRA_PTE_OFFSET;
+	for (page_idx = 0; page_idx < num_pages; page_idx++) {
+		writel(0, amd_manager->acp_mmio + ACP_SCRATCH_REG_0 + val);
+		writel(0, amd_manager->acp_mmio + ACP_SCRATCH_REG_0 + val + 4);
+		val += ACP_BRA_ATU_PTE_ENTRY_SIZE;
+	}
+
+	/* Flush ATU cache */
+	writel(0x1, amd_manager->acp_mmio + ACPAXI2AXI_ATU_CTRL);
+}
+
+static int amd_sdw_config_bra_descriptor(struct amd_sdw_manager *amd_manager,
+					 struct amd_bra_params *params)
+{
+	u32 frame_format, hctrl;
+	u32 int_mask;
+
+	if (params->dev_addr > 15 ||
+	    params->sample_interval == 0 || params->sample_interval > 65536 ||
+	    params->hstart > 15 || params->hstop > 15 ||
+	    params->word_length == 0 || params->word_length > 64 ||
+	    params->bytes_per_frame > 511)
+		return -EINVAL;
+
+	/*
+	 * ACP BPT_PORT_HCTRL: encode as (hstart << 4) | hstop.
+	 * The ACP BRA engine starts reading from column hstart (including
+	 * the BRA frame header).  No offset adjustment is needed.
+	 */
+	hctrl = (u32)((params->hstart << 4) | params->hstop);
+
+	frame_format =
+		((u32)(params->word_length - 1) << 2)  |  /* [7:2]  WordLength-1       */
+		(params->write_mode ? BIT(10) : 0U)    |  /* [10]   Write/Read         */
+		((u32)params->bytes_per_frame << 11)   |  /* [19:11] BytesPerFrame     */
+		((u32)params->dev_addr << 20);		   /* [23:20] DeviceAddr        */
+
+	/* Mask BRA error interrupts while programming descriptor */
+	int_mask = readl(amd_manager->mmio + ACP_SW_ERROR_INTR_MASK);
+	int_mask &= ~(u32)AMD_SDW_BPT_ERR_INTR_MASK;
+	writel(int_mask, amd_manager->mmio + ACP_SW_ERROR_INTR_MASK);
+
+	writel(frame_format,                  amd_manager->mmio + ACP_SW_BPT_PORT_FRAME_FORMAT);
+	writel(params->sample_interval - 1,   amd_manager->mmio + ACP_SW_BPT_PORT_SAMPLEINTERVAL);
+	writel(hctrl,                         amd_manager->mmio + ACP_SW_BPT_PORT_HCTRL);
+	writel(0,                             amd_manager->mmio + ACP_SW_BPT_PORT_OFFSET);
+	writel(BIT(3),                        amd_manager->mmio + ACP_SW_BPT_PORT_CHANNEL_ENABLE);
+	writel(params->peripheral_first_byte_addr,
+	       amd_manager->mmio + ACP_SW_BPT_PORT_FIRST_BYTE_ADDR);
+	writel(params->dma_base_addr,         amd_manager->mmio + ACP_SW_BRA_BASE_ADDRESS);
+	writel(params->transfer_length,       amd_manager->mmio + ACP_SW_BRA_TRANSFER_SIZE);
+
+	int_mask |= AMD_SDW_BPT_ERR_INTR_MASK;
+	writel(int_mask, amd_manager->mmio + ACP_SW_ERROR_INTR_MASK);
+
+	dev_dbg(amd_manager->dev,
+		"BPT config_desc: FF=0x%08x SI=0x%x HC=0x%02x CE=0x%02x periph=0x%08x dma=0x%08x xfer=%u\n",
+		frame_format, params->sample_interval - 1, hctrl, (u32)BIT(3),
+		params->peripheral_first_byte_addr, params->dma_base_addr,
+		params->transfer_length);
+	return 0;
+}
+
+static void amd_sdw_deconfig_bra_descriptor(struct amd_sdw_manager *amd_manager)
+{
+	writel(0, amd_manager->mmio + ACP_SW_BPT_PORT_FRAME_FORMAT);
+	writel(0, amd_manager->mmio + ACP_SW_BPT_PORT_SAMPLEINTERVAL);
+	writel(0, amd_manager->mmio + ACP_SW_BPT_PORT_HCTRL);
+	writel(0, amd_manager->mmio + ACP_SW_BPT_PORT_OFFSET);
+	writel(0, amd_manager->mmio + ACP_SW_BPT_PORT_CHANNEL_ENABLE);
+	writel(0, amd_manager->mmio + ACP_SW_BPT_PORT_FIRST_BYTE_ADDR);
+	writel(0, amd_manager->mmio + ACP_SW_BRA_BASE_ADDRESS);
+	writel(0, amd_manager->mmio + ACP_SW_BRA_TRANSFER_SIZE);
+}
+
+static int amd_sdw_execute_bra_transfer(struct amd_sdw_manager *amd_manager,
+					struct sdw_slave *slave,
+					bool *dma_unsafe)
+{
+	struct sdw_bus *bus = &amd_manager->bus;
+	u32 i2s_err_offset;
+	u32 saved_intr_mask;
+	u32 reg_addr, len;
+	u32 val;
+	int ret, ret_disable;
+
+	/* Read descriptor regs before enabling the DMA engine. */
+	reg_addr = readl(amd_manager->mmio + ACP_SW_BPT_PORT_FIRST_BYTE_ADDR);
+	len = readl(amd_manager->mmio + ACP_SW_BRA_TRANSFER_SIZE);
+
+	i2s_err_offset = (amd_manager->instance == 0) ?
+			 ACP_SW_I2S_ERROR_REASON : ACP_P1_SW_I2S_ERROR_REASON;
+
+	/*
+	 * Save and disable the error interrupt mask for manual error
+	 * checking.  acp_bra_lock is held across the whole BPT sequence by
+	 * amd_sdw_bpt_wait(), which serialises this shared-register
+	 * read-modify-write against the other manager instance.
+	 */
+	saved_intr_mask = readl(amd_manager->mmio + ACP_SW_ERROR_INTR_MASK);
+	writel(0, amd_manager->mmio + ACP_SW_ERROR_INTR_MASK);
+	writel(0, amd_manager->acp_mmio + i2s_err_offset);
+	writel(0, amd_manager->mmio + ACP_SW_ERROR_REASON1);
+
+	/* Arm the ACP BPT DMA engine */
+	writel(1, amd_manager->mmio + ACP_SW_BPT_PORT_EN);
+
+	/*
+	 * Use the framework's sdw_enable_stream() to write CHANNELEN and
+	 * perform a bank switch.  The ACP BPT hardware uses the bank switch
+	 * as the trigger to start the DMA transfer.  The framework manages
+	 * bank state consistently, eliminating the need for a manual bank
+	 * switch or DP0 bank mirror.
+	 */
+	dev_dbg(amd_manager->dev,
+		"BPT: pre-enable: curr_bank=%u next_bank=%u BPT_EN_STATUS=0x%x stream_state=%d\n",
+		bus->params.curr_bank, bus->params.next_bank,
+		readl(amd_manager->mmio + ACP_SW_BPT_PORT_EN_STATUS),
+		bus->bpt_stream->state);
+
+	ret = sdw_enable_stream(bus->bpt_stream);
+	if (ret < 0) {
+		dev_err(amd_manager->dev,
+			"BPT: sdw_enable_stream failed: %d\n", ret);
+		/*
+		 * Disarm the engine and wait for the port to quiesce before
+		 * returning: the caller (amd_sdw_bra_transfer()) then deconfigures
+		 * the BRA descriptor unconditionally, zeroing BASE_ADDRESS and
+		 * TRANSFER_SIZE, so the port must be idle first -- mirrors the
+		 * disable path below.
+		 */
+		writel(0, amd_manager->mmio + ACP_SW_BPT_PORT_EN);
+		ret_disable = readl_poll_timeout(amd_manager->mmio + ACP_SW_BPT_PORT_EN_STATUS,
+						 val, !val, ACP_DELAY_US, AMD_SDW_TIMEOUT);
+		if (ret_disable < 0) {
+			dev_err(amd_manager->dev, "BPT: PORT_EN disable timeout\n");
+			*dma_unsafe = true;
+		}
+		goto restore_intr;
+	}
+
+	dev_dbg(amd_manager->dev,
+		"BPT: DMA started: curr_bank=%u next_bank=%u BPT_EN_STATUS=0x%x stream_state=%d\n",
+		bus->params.curr_bank, bus->params.next_bank,
+		readl(amd_manager->mmio + ACP_SW_BPT_PORT_EN_STATUS),
+		bus->bpt_stream->state);
+
+	/* Poll DMA_BUSY until transfer completes */
+	{
+		unsigned long timeout;
+
+		timeout = jiffies + msecs_to_jiffies(BRA_DMA_TIMEOUT_MS);
+		do {
+			val = readl(amd_manager->mmio + ACP_SW_BRA_DMA_BUSY);
+			/*
+			 * Side-effectful read: reading ACP_SW_BRA_CURRENT_TRANSFER_SIZE
+			 * advances the BRA DMA engine to the next frame.  The value is
+			 * intentionally discarded (hence the (void) cast); removing this
+			 * read stalls multi-frame transfers, which then time out.
+			 */
+			(void)readl(amd_manager->mmio + ACP_SW_BRA_CURRENT_TRANSFER_SIZE);
+			if (!(val & 0x01))
+				break;
+			if (time_after(jiffies, timeout)) {
+				dev_err(amd_manager->dev,
+					"BPT: DMA timeout: periph=0x%08x len=%u EN_STATUS=0x%x RESP=0x%x I2S_ERR=0x%08x\n",
+					reg_addr, len,
+					readl(amd_manager->mmio + ACP_SW_BPT_PORT_EN_STATUS),
+					readl(amd_manager->mmio + ACP_SW_BRA_RESP),
+					readl(amd_manager->acp_mmio + i2s_err_offset));
+				ret = -ETIMEDOUT;
+				break;
+			}
+			/*
+			 * Runs in process context. Yield the CPU so a
+			 * multi-frame transfer cannot busy-spin for up to
+			 * BRA_DMA_TIMEOUT_MS and trip the soft lockup
+			 * watchdog on non-preemptible kernels. cond_resched()
+			 * keeps the poll cadence tight -- reading
+			 * ACP_SW_BRA_CURRENT_TRANSFER_SIZE every iteration is
+			 * required to advance the DMA engine between frames,
+			 * so usleep_range() (which would space out the reads)
+			 * is deliberately not used here.
+			 */
+			cond_resched();
+		} while (1);
+	}
+
+	/* Check for I2S/BRA errors */
+	val = readl(amd_manager->acp_mmio + i2s_err_offset);
+	if (val & AMD_SDW_BRA_I2S_ERROR_MASK) {
+		dev_err(amd_manager->dev,
+			"BPT: BRA failed I2S_ERROR_REASON=0x%08x (NAK=%u Clash=%u HdrResp=%u FtrResp=%u CRC=%u DMA=%u Cmd=%u)\n",
+			val,
+			!!(val & BIT(18)), !!(val & BIT(19)),
+			!!(val & BIT(26)), !!(val & BIT(27)),
+			!!(val & BIT(28)), !!(val & BIT(29)), !!(val & BIT(30)));
+		writel(0, amd_manager->acp_mmio + i2s_err_offset);
+		if (!ret)
+			ret = -EIO;
+	} else if (!ret) {
+		dev_dbg(amd_manager->dev,
+			"BPT: DMA done: periph=0x%08x len=%u\n", reg_addr, len);
+	}
+
+	/*
+	 * On an aborted or timed-out transfer the ACP BPT DMA engine can still
+	 * be armed (PORT_EN=1, DMA_BUSY=1). sdw_disable_stream() below performs
+	 * a bank switch, which is the BPT DMA start trigger, so disarm the engine
+	 * first -- otherwise the bank switch could (re)start a DMA write into
+	 * dma_buf, which amd_sdw_bpt_wait() frees as soon as this transfer
+	 * returns. On the success path the DMA has already completed, so this
+	 * early clear is a no-op.
+	 */
+	if (ret < 0)
+		writel(0, amd_manager->mmio + ACP_SW_BPT_PORT_EN);
+
+	/*
+	 * Disable the stream via framework (writes CHANNELEN=0 + bank switch).
+	 * This cleanly stops the port and keeps bank state consistent.
+	 * Propagate a disable failure: it leaves the stream in
+	 * SDW_STREAM_ENABLED, and sdw_enable_stream() returns 0 early for an
+	 * already-ENABLED stream without the bank switch that triggers the BRA
+	 * DMA, so the next section would be silently skipped rather than
+	 * transferred.  Report the failure to the caller so it stops instead of
+	 * chaining a section whose DMA never starts.
+	 */
+	ret_disable = sdw_disable_stream(bus->bpt_stream);
+	if (ret_disable < 0) {
+		dev_err(amd_manager->dev, "BPT: sdw_disable_stream failed: %d\n",
+			ret_disable);
+		if (!ret)
+			ret = ret_disable;
+	}
+
+	dev_dbg(amd_manager->dev,
+		"BPT: post-disable: curr_bank=%u next_bank=%u stream_state=%d\n",
+		bus->params.curr_bank, bus->params.next_bank,
+		bus->bpt_stream->state);
+
+	/*
+	 * Disarm the ACP BPT DMA engine and wait for the port to quiesce.
+	 * Like the manager enable/disable sequence (ACP_SW_EN paired with
+	 * ACP_SW_EN_STATUS), ACP_SW_BPT_PORT_EN_STATUS reflects the real port
+	 * state, so polling it here guarantees a non-contiguous transfer's next
+	 * section cannot re-arm PORT_EN before the current one has torn down.
+	 */
+	writel(0, amd_manager->mmio + ACP_SW_BPT_PORT_EN);
+	ret_disable = readl_poll_timeout(amd_manager->mmio + ACP_SW_BPT_PORT_EN_STATUS,
+					 val, !val, ACP_DELAY_US, AMD_SDW_TIMEOUT);
+	if (ret_disable < 0) {
+		dev_err(amd_manager->dev, "BPT: PORT_EN disable timeout\n");
+		if (!ret)
+			ret = ret_disable;
+		*dma_unsafe = true;
+	}
+	writel(0, amd_manager->acp_mmio + i2s_err_offset);
+	writel(0, amd_manager->mmio + ACP_SW_ERROR_REASON1);
+	/*
+	 * Clearing the immediate-command response-valid status races with the
+	 * immediate-command path (amd_sdw_send_cmd_get_resp()), which polls and
+	 * clears the same ACP_SW_IMM_CMD_STS bit under bus->msg_lock. The BPT DMA
+	 * poll loop above drops all locks, so a concurrent slave enumeration or
+	 * register access (amd_sdw_work / IRQ thread / codec regmap) can be
+	 * mid-command here. Take msg_lock so this teardown clear cannot erase a
+	 * response the command path has not yet consumed, which would make that
+	 * command time out. This msg_lock nests inside acp_bra_lock and bpt_lock,
+	 * both already held by the enclosing amd_sdw_bpt_wait(), preserving the
+	 * bpt_lock -> acp_bra_lock -> msg_lock order. do_bank_switch() inside
+	 * sdw_enable_stream()/sdw_disable_stream() only takes msg_lock for
+	 * multi-link managers, so this single-link manager establishes that order
+	 * via the explicit msg_lock here and in the non-contiguous
+	 * sdw_nwrite_no_pm()/sdw_nread_no_pm() fallback.
+	 */
+	mutex_lock(&bus->msg_lock);
+	writel(AMD_SDW_IMM_RES_VALID, amd_manager->mmio + ACP_SW_IMM_CMD_STS);
+	mutex_unlock(&bus->msg_lock);
+
+restore_intr:
+	writel(saved_intr_mask, amd_manager->mmio + ACP_SW_ERROR_INTR_MASK);
+	return ret;
+}
+
+/**
+ * amd_sdw_bra_transfer() - Execute a single-shot BRA DMA transfer
+ * @amd_manager: AMD SoundWire manager
+ * @slave: SoundWire slave device
+ * @reg_addr: Peripheral register start address
+ * @acp_base_addr: Pre-configured ACP system address for the DMA buffer
+ * @len: Total number of bytes to transfer
+ * @write: true for write, false for read
+ *
+ * Programs the BRA descriptor once with the full transfer length and triggers
+ * a single DMA operation.  The ACP BRA hardware autonomously slices the
+ * buffer into BPF-sized BRA frames, auto-incrementing PERIPHERAL_FIRST_BYTE_ADDR
+ * and DMA_BASE_ADDRESS between frames.  The last frame may be shorter than BPF;
+ * the hardware handles partial final frames correctly.
+ *
+ * The poll loop in amd_sdw_execute_bra_transfer() reads
+ * ACP_SW_BRA_CURRENT_TRANSFER_SIZE in every iteration, which is required
+ * to advance the DMA engine between frames.
+ */
+static int amd_sdw_bra_transfer(struct amd_sdw_manager *amd_manager,
+				struct sdw_slave *slave, u32 reg_addr,
+				u32 acp_base_addr, size_t len, bool write,
+				bool *dma_unsafe)
+{
+	struct amd_bra_params params = {0};
+	int ret;
+
+	ret = amd_sdw_calculate_bra_params(amd_manager, &params,
+					   (u8)slave->dev_num);
+	if (ret < 0)
+		return ret;
+
+	params.peripheral_first_byte_addr = reg_addr;
+	params.dma_base_addr = acp_base_addr;
+	params.transfer_length = (u32)len;
+	params.write_mode = write;
+
+	ret = amd_sdw_config_bra_descriptor(amd_manager, &params);
+	if (ret < 0)
+		return ret;
+
+	ret = amd_sdw_execute_bra_transfer(amd_manager, slave, dma_unsafe);
+	amd_sdw_deconfig_bra_descriptor(amd_manager);
+
+	return ret;
+}
+
+/**
+ * amd_sdw_bpt_open_stream() - Allocate and prepare BPT stream
+ * @amd_manager: AMD SoundWire manager
+ * @slave: SoundWire slave device
+ * @msg: BPT message with transfer direction
+ *
+ * Allocates a SoundWire BPT stream and adds slave and master runtime
+ * entries so that transport column params are visible to the port ops
+ * callbacks. DP0 is programmed through the SoundWire stream framework in
+ * amd_sdw_bpt_wait() immediately before the DMA transfer.
+ */
+static int amd_sdw_bpt_open_stream(struct amd_sdw_manager *amd_manager,
+				   struct sdw_slave *slave,
+				   struct sdw_bpt_msg *msg)
+{
+	struct sdw_bus *bus = &amd_manager->bus;
+	struct sdw_stream_config sconfig = {0};
+	struct sdw_port_config pconfig = {0};
+	struct sdw_stream_runtime *stream;
+	int ret;
+
+	stream = sdw_alloc_stream("BPT", SDW_STREAM_BPT);
+	if (!stream)
+		return -ENOMEM;
+
+	/*
+	 * BPT has no PCM sample rate, but sdw_prepare_stream() still validates
+	 * the stream rate against the bus clock: _sdw_prepare_stream() rejects a
+	 * rate that does not evenly divide max_clk_freq ("Async mode not
+	 * supported"). Use the bus frame rate, which the driver derives as
+	 * curr_dr_freq / (rows * cols) and therefore divides the SoundWire clock
+	 * by construction; this passes on any valid clock instead of only when
+	 * max_clk_freq happens to be a multiple of 48 kHz. The DP0 sample interval
+	 * used for the transfer is computed from the BRA frame geometry in
+	 * amd_sdw_compute_params(), not from this rate.
+	 */
+	sconfig.frame_rate = bus->prop.default_frame_rate;
+	sconfig.ch_count = 1;
+	sconfig.bps = 8;
+	sconfig.direction = (msg->flags & SDW_MSG_FLAG_WRITE) ?
+			    SDW_DATA_DIR_TX : SDW_DATA_DIR_RX;
+	sconfig.type = SDW_STREAM_BPT;
+
+	pconfig.num = 0;
+	pconfig.ch_mask = BIT(0);
+
+	/*
+	 * Flag this BPT transfer as a firmware download that may run while
+	 * audio streams on this bus are allocated but idle. sdw_stream_add_slave()
+	 * allocates the master runtime, and sdw_master_rt_alloc() consults
+	 * bus->bpt_fw_download to permit that allocation even when idle audio
+	 * streams are still allocated. The peripheral does not start its own
+	 * audio stream until the download has completed, so no stream is made
+	 * active on the bus for the duration.
+	 */
+	WRITE_ONCE(bus->bpt_fw_download, true);
+
+	ret = sdw_stream_add_slave(slave, &sconfig, &pconfig, 1, stream);
+	if (ret < 0) {
+		dev_err(amd_manager->dev,
+			"add slave to BPT stream failed: %d\n", ret);
+		goto remove_rt;
+	}
+
+	ret = sdw_stream_add_master(bus, &sconfig, &pconfig, 1, stream);
+	if (ret < 0) {
+		dev_err(amd_manager->dev,
+			"add master to BPT stream failed: %d\n", ret);
+		goto remove_rt;
+	}
+
+	/*
+	 * Publish bus->bpt_stream only after the runtime is added and
+	 * bus->bpt_stream_refcount has been raised under bus_lock. The refcount
+	 * is raised by sdw_stream_add_slave() above (via sdw_master_rt_alloc());
+	 * sdw_stream_add_master() then reuses that runtime through
+	 * sdw_master_rt_find() without incrementing it again.
+	 * sdw_program_params() keys off bpt_stream; publishing it last keeps
+	 * it consistent with the refcount, so an audio path that observes
+	 * refcount == 0 under bus_lock also sees bpt_stream == NULL and
+	 * programs its own parameters instead of being skipped.
+	 */
+	WRITE_ONCE(bus->bpt_stream, stream);
+
+	return 0;
+
+remove_rt:
+	/*
+	 * sdw_stream_add_slave() allocates the master runtime and raises
+	 * bus->bpt_stream_refcount. If it or the following sdw_stream_add_master()
+	 * fails, sdw_stream_remove_slave() frees only the slave runtime and
+	 * sdw_release_stream() only frees the stream, leaving the master runtime on
+	 * bus->m_rt_list dangling at the freed stream with bpt_stream_refcount stuck
+	 * non-zero -- which rejects every future BPT transfer with -EBUSY. Mirror
+	 * the amd_sdw_bpt_close_stream() teardown and remove the slave then the
+	 * master runtime (dropping the refcount) before releasing the stream; both
+	 * removes are no-ops when nothing was allocated.
+	 */
+	WRITE_ONCE(bus->bpt_fw_download, false);
+	sdw_stream_remove_slave(slave, stream);
+	sdw_stream_remove_master(bus, stream);
+	sdw_release_stream(stream);
+	return ret;
+}
+
+/**
+ * amd_sdw_bpt_close_stream() - Deprepare and release BPT stream
+ * @amd_manager: AMD SoundWire manager
+ * @slave: SoundWire slave device
+ *
+ * Deprepares slave DP0 and removes the stream/master/slave entries.
+ * Hardware teardown (CHANNELEN=0, bank-switch, PORT_EN=0) was handled by
+ * execute_bra_transfer()'s cleanup path.
+ */
+static void amd_sdw_bpt_close_stream(struct amd_sdw_manager *amd_manager,
+				     struct sdw_slave *slave)
+{
+	struct sdw_bus *bus = &amd_manager->bus;
+	struct sdw_stream_runtime *stream = READ_ONCE(bus->bpt_stream);
+	int ret;
+
+	if (!stream)
+		return;
+
+	/*
+	 * Deprepare DP0 via SoundWire framework to leave the peripheral in a
+	 * clean state for subsequent audio streams. Only deprepare when the
+	 * stream actually reached a depreparable state: on early-failure paths
+	 * (e.g. DMA buffer alloc failed before sdw_prepare_stream()) the stream
+	 * is still SDW_STREAM_CONFIGURED and sdw_deprepare_stream() would reject
+	 * it with -EINVAL. In that case DP0 was never programmed, so there is
+	 * nothing to clean up.
+	 */
+	dev_dbg(amd_manager->dev,
+		"BPT: pre-deprepare: curr_bank=%u next_bank=%u stream_state=%d\n",
+		bus->params.curr_bank, bus->params.next_bank,
+		stream->state);
+
+	/*
+	 * A failed sdw_disable_stream() during the transfer can leave the
+	 * stream in SDW_STREAM_ENABLED. Disable it first so it reaches a
+	 * depreparable state and the peripheral DP0 is not left active.
+	 */
+	if (stream->state == SDW_STREAM_ENABLED) {
+		ret = sdw_disable_stream(stream);
+		if (ret < 0)
+			dev_err(amd_manager->dev,
+				"BPT: sdw_disable_stream (cleanup) failed: %d\n", ret);
+	}
+
+	if (stream->state == SDW_STREAM_PREPARED ||
+	    stream->state == SDW_STREAM_DISABLED) {
+		ret = sdw_deprepare_stream(stream);
+		if (ret < 0)
+			dev_err(amd_manager->dev,
+				"BPT: sdw_deprepare_stream failed: %d\n", ret);
+		else
+			dev_dbg(amd_manager->dev,
+				"BPT: deprepared: curr_bank=%u next_bank=%u stream_state=%d\n",
+				bus->params.curr_bank, bus->params.next_bank,
+				stream->state);
+	}
+
+	if (stream->state == SDW_STREAM_ENABLED)
+		dev_warn(amd_manager->dev,
+			 "BPT: stream still ENABLED after cleanup; DP0 may remain active, peripheral may need re-enumeration\n");
+
+	/*
+	 * Clear bus->bpt_stream while bpt_stream_refcount is still raised so
+	 * the two remain consistent for lockless observers.
+	 * sdw_stream_remove_master() drops the refcount under bus_lock, so
+	 * clearing bpt_stream first means any audio path that observes
+	 * refcount == 0 also sees bpt_stream == NULL and programs its own
+	 * parameters rather than skipping them in sdw_program_params().
+	 */
+	WRITE_ONCE(bus->bpt_stream, NULL);
+	WRITE_ONCE(bus->bpt_fw_download, false);
+
+	ret = sdw_stream_remove_slave(slave, stream);
+	if (ret < 0)
+		dev_err(amd_manager->dev,
+			"remove slave from BPT stream failed: %d\n", ret);
+
+	ret = sdw_stream_remove_master(bus, stream);
+	if (ret < 0)
+		dev_err(amd_manager->dev,
+			"remove master from BPT stream failed: %d\n", ret);
+
+	sdw_release_stream(stream);
+}
+
+/**
+ * amd_sdw_bpt_send_async() - Validate a BPT message before transfer
+ * @bus: SoundWire bus
+ * @slave: SoundWire slave device
+ * @msg: BPT message with transfer sections
+ *
+ * For AMD the BRA engine transfer is synchronous, so the entire transfer
+ * (stream open/prepare, DMA, poll and teardown) is performed in
+ * amd_sdw_bpt_wait().  This callback only validates the message so a bad
+ * request fails fast.  Deliberately, no lock, runtime-PM reference or
+ * stream is taken here: nothing is held across the send_async()/wait()
+ * boundary, so a caller that never reaches bpt_wait() cannot leak the BPT
+ * lock or a runtime-PM reference.
+ */
+static int amd_sdw_bpt_send_async(struct sdw_bus *bus,
+				  struct sdw_slave *slave,
+				  struct sdw_bpt_msg *msg)
+{
+	struct amd_sdw_manager *amd_manager = to_amd_sdw(bus);
+	size_t total_len = 0;
+	int i;
+
+	for (i = 0; i < msg->sections; i++)
+		total_len += msg->sec[i].len;
+
+	if (total_len < AMD_BPT_MSG_BYTE_MIN) {
+		dev_err(amd_manager->dev,
+			"BPT msg length %zu < minimum %d bytes\n",
+			total_len, AMD_BPT_MSG_BYTE_MIN);
+		return -EINVAL;
+	}
+
+	if (total_len > SDW_BPT_MSG_MAX_BYTES) {
+		dev_err(amd_manager->dev,
+			"BPT msg length %zu > maximum %d bytes\n",
+			total_len, SDW_BPT_MSG_MAX_BYTES);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static bool amd_sdw_sections_are_contiguous(struct sdw_bpt_msg *msg)
+{
+	int i;
+
+	for (i = 1; i < msg->sections; i++) {
+		if (msg->sec[i].addr != msg->sec[i - 1].addr + msg->sec[i - 1].len)
+			return false;
+	}
+	return true;
+}
+
+/**
+ * amd_sdw_bpt_wait() - Execute a BPT transfer and release all resources
+ * @bus: SoundWire bus
+ * @slave: SoundWire slave device
+ * @msg: BPT message with transfer sections
+ *
+ * Performs the whole BPT transfer for AMD: it serialises against other BPT
+ * transfers, holds a runtime-PM reference, opens/prepares the BPT stream,
+ * allocates the DMA buffer, configures the PTE mapping, runs the BRA DMA
+ * transfer and finally tears everything down.  Acquiring and releasing the
+ * BPT lock and the runtime-PM reference within this single function
+ * guarantees they cannot leak across the send_async()/wait() boundary.
+ */
+static int amd_sdw_bpt_wait(struct sdw_bus *bus,
+			    struct sdw_slave *slave,
+			    struct sdw_bpt_msg *msg)
+{
+	struct amd_sdw_manager *amd_manager = to_amd_sdw(bus);
+	bool is_write = (msg->flags & SDW_MSG_FLAG_WRITE);
+	struct amd_bra_params prep_params = {0};
+	u32 acp_sys_addr;
+	dma_addr_t dma_addr = 0;
+	u8 *dma_buf = NULL;
+	size_t offset = 0;
+	size_t total_len = 0;
+	int ret = 0;
+	int i;
+	bool dma_unsafe = false;
+
+	for (i = 0; i < msg->sections; i++)
+		total_len += msg->sec[i].len;
+
+	if (total_len < AMD_BPT_MSG_BYTE_MIN) {
+		dev_err(amd_manager->dev,
+			"BPT msg length %zu < minimum %d bytes\n",
+			total_len, AMD_BPT_MSG_BYTE_MIN);
+		return -EINVAL;
+	}
+
+	if (total_len > SDW_BPT_MSG_MAX_BYTES) {
+		dev_err(amd_manager->dev,
+			"BPT msg length %zu > maximum %d bytes\n",
+			total_len, SDW_BPT_MSG_MAX_BYTES);
+		return -EINVAL;
+	}
+
+	/*
+	 * Take the runtime-PM reference that keeps the bus clock alive before
+	 * acquiring bpt_lock, not after.  When the manager is runtime
+	 * suspended, pm_runtime_get_sync() runs amd_resume_runtime()
+	 * synchronously in this task, and that callback acquires bpt_lock to
+	 * clear bpt_disabled.  Taking the reference while already holding
+	 * bpt_lock would therefore deadlock against ourselves.
+	 */
+	ret = pm_runtime_get_sync(amd_manager->dev);
+	/*
+	 * -EACCES only occurs when runtime PM is disabled, which for this
+	 * device happens across the system suspend/resume window.  amd_suspend()
+	 * sets bpt_disabled before the clock is stopped and amd_resume_runtime()
+	 * clears it only once the clock is back, so the bpt_disabled check below
+	 * rejects the transfer with -ESHUTDOWN before any BRA access whenever the
+	 * clock could be down.  A merely runtime-suspended manager (clock stopped,
+	 * PM still enabled) is resumed by the get above and returns success, not
+	 * -EACCES; tolerating -EACCES therefore never drives the BRA engine on a
+	 * stopped clock.
+	 */
+	if (ret < 0 && ret != -EACCES) {
+		pm_runtime_put_noidle(amd_manager->dev);
+		dev_err(amd_manager->dev, "BPT: pm_runtime_get failed: %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * The ACP BRA engine is a single shared resource.  Serialise all BPT
+	 * transfers so concurrent slave probes do not race over the hardware.
+	 */
+	mutex_lock(&amd_manager->bpt_lock);
+
+	/*
+	 * Refuse the transfer if the bus is being (or has been) clock-stopped
+	 * for system suspend.  Driving the BRA/command channel while the clock
+	 * is stopping wedges the channel and leaves the peripheral unable to
+	 * re-enumerate on resume; the codec retries once it re-attaches.
+	 */
+	if (amd_manager->bpt_disabled) {
+		mutex_unlock(&amd_manager->bpt_lock);
+		pm_runtime_mark_last_busy(amd_manager->dev);
+		pm_runtime_put_autosuspend(amd_manager->dev);
+		return -ESHUTDOWN;
+	}
+
+	/* BRA always uses all available data columns (1..NC-1). */
+	amd_manager->bra_hstart = 1;
+	amd_manager->bra_hstop  = bus->params.col - 1;
+
+	/*
+	 * Open the BPT stream so the framework stream state machine tracks the
+	 * transfer.  Slave DP0 is prepared below before bra_transfer().
+	 */
+	ret = amd_sdw_bpt_open_stream(amd_manager, slave, msg);
+	if (ret < 0)
+		goto close_stream;
+
+	/* Allocate single DMA buffer for entire BPT message */
+	dma_buf = dma_alloc_coherent(amd_manager->dev->parent, total_len,
+				     &dma_addr, GFP_KERNEL);
+	if (!dma_buf) {
+		ret = -ENOMEM;
+		goto close_stream;
+	}
+
+	/*
+	 * The ATU GRP_1 and scratch PTE registers programmed here are
+	 * ACP-global and shared by both SoundWire manager instances, as is the
+	 * BRA DMA engine that reads through them.  bpt_lock is per-manager and
+	 * does not serialise across instances, so hold the ACP-wide
+	 * acp_bra_lock across the whole configure -> transfer -> deconfigure
+	 * sequence to stop the other instance reprogramming the shared PTEs
+	 * mid-transfer.
+	 *
+	 * A dedicated lock (not acp_sdw_lock) is used so that a transfer, which
+	 * can last up to BRA_DMA_TIMEOUT_MS, does not block the brief
+	 * ACP_EXTERNAL_INTR_CNTL updates done under acp_sdw_lock by
+	 * amd_enable_sdw_interrupts()/amd_disable_sdw_interrupts() and the PDM
+	 * interrupt helpers, which touch a different ACP-global register.
+	 */
+	mutex_lock(amd_manager->acp_bra_lock);
+	acp_sys_addr = amd_sdw_bra_configure_pte(amd_manager, dma_addr, total_len);
+	if (!acp_sys_addr) {
+		ret = -ENOMEM;
+		mutex_unlock(amd_manager->acp_bra_lock);
+		goto free_dma;
+	}
+
+	/* For writes, copy all section data into the DMA buffer */
+	if (is_write) {
+		for (i = 0; i < msg->sections; i++) {
+			memcpy(dma_buf + offset, msg->sec[i].buf, msg->sec[i].len);
+			offset += msg->sec[i].len;
+		}
+	}
+
+	dev_dbg(amd_manager->dev,
+		"BPT %s start: dev_num=%d sections=%d total_len=%zu dma_addr=0x%llx\n",
+		is_write ? "write" : "read",
+		msg->dev_num, msg->sections, total_len, (unsigned long long)dma_addr);
+
+	/*
+	 * Calculate BRA parameters for this device. We use bytes_per_frame to
+	 * decide whether a section is too small for BRA DMA and must fallback
+	 * to register read/write commands.
+	 */
+	ret = amd_sdw_calculate_bra_params(amd_manager, &prep_params,
+					   (u8)slave->dev_num);
+	if (ret < 0) {
+		dev_err(amd_manager->dev,
+			"BPT: failed to calc params: %d\n", ret);
+		goto deconfigure_pte;
+	}
+
+	/*
+	 * Prepare DP0 via SoundWire framework so the core programs the
+	 * peripheral DP0 transport/port registers and issues PREPARECTRL.
+	 * This is invoked from the BPT transfer context (firmware callback)
+	 * and not from update_status(), so it is safe w.r.t. sdw_dev_lock.
+	 */
+	ret = sdw_prepare_stream(bus->bpt_stream);
+	if (ret < 0) {
+		dev_err(amd_manager->dev,
+			"BPT: sdw_prepare_stream failed: %d\n", ret);
+		goto deconfigure_pte;
+	}
+	dev_dbg(amd_manager->dev,
+		"BPT: stream prepared, curr_bank=%u next_bank=%u state=%d\n",
+		bus->params.curr_bank, bus->params.next_bank,
+		bus->bpt_stream->state);
+
+	if (amd_sdw_sections_are_contiguous(msg)) {
+		/*
+		 * All sections are contiguous in peripheral address space.
+		 * A single BRA call covers the entire firmware image.
+		 */
+		ret = amd_sdw_bra_transfer(amd_manager, slave,
+					   msg->sec[0].addr,
+					   acp_sys_addr,
+					   total_len, is_write,
+					   &dma_unsafe);
+		if (ret < 0) {
+			dev_err(amd_manager->dev,
+				"BPT contiguous transfer failed: addr=0x%x len=%zu ret=%d\n",
+				msg->sec[0].addr, total_len, ret);
+			/*
+			 * Skip the read-back copy below so a failed read
+			 * cannot return stale DMA buffer contents to the
+			 * caller as if the transfer had succeeded.
+			 */
+			goto deconfigure_pte;
+		}
+	} else {
+		/*
+		 * Non-contiguous sections: each section targets a different
+		 * peripheral address range.  The ACP BRA DMA engine is
+		 * triggered by sdw_enable_stream() (bank switch + CHANNELEN), so
+		 * each section needs its own full config -> activate ->
+		 * run_dma -> deactivate -> deconfig cycle.
+		 *
+		 * Sections smaller than one BRA frame (bytes_per_frame)
+		 * cannot be transferred via DMA because the engine never
+		 * starts for sub-frame payloads.  Use regular SDW register
+		 * read/write commands for those tiny sections instead.
+		 */
+		offset = 0;
+		for (i = 0; i < msg->sections; i++) {
+			if (i < 3 || i == msg->sections - 1)
+				dev_dbg(amd_manager->dev,
+					"BPT nc sec[%d/%d]: periph=0x%08x len=%u acp=0x%08x\n",
+					i, msg->sections, msg->sec[i].addr,
+					msg->sec[i].len,
+					acp_sys_addr + (u32)offset);
+			if (msg->sec[i].len < prep_params.bytes_per_frame) {
+				/*
+				 * Section too small for BRA DMA -- use
+				 * regular SDW byte-level commands instead.
+				 */
+				if (is_write)
+					ret = sdw_nwrite_no_pm(slave,
+							       msg->sec[i].addr,
+							       msg->sec[i].len,
+							       dma_buf + offset);
+				else
+					ret = sdw_nread_no_pm(slave,
+							      msg->sec[i].addr,
+							      msg->sec[i].len,
+							      dma_buf + offset);
+				if (ret < 0)
+					dev_err(amd_manager->dev,
+						"BPT reg %s failed: sec=%d/%d addr=0x%x len=%u ret=%d\n",
+						is_write ? "write" : "read",
+						i, msg->sections,
+						msg->sec[i].addr,
+						msg->sec[i].len, ret);
+				else
+					dev_dbg(amd_manager->dev,
+						"BPT sec[%d/%d]: used reg %s for %u bytes at 0x%08x\n",
+						i, msg->sections,
+						is_write ? "write" : "read",
+						msg->sec[i].len,
+						msg->sec[i].addr);
+			} else {
+				ret = amd_sdw_bra_transfer(amd_manager, slave,
+							   msg->sec[i].addr,
+							   acp_sys_addr + (u32)offset,
+							   msg->sec[i].len, is_write,
+							   &dma_unsafe);
+				if (ret < 0)
+					dev_err(amd_manager->dev,
+						"BPT failed: sec=%d/%d addr=0x%x len=%u ret=%d\n",
+						i, msg->sections, msg->sec[i].addr,
+						msg->sec[i].len, ret);
+			}
+			if (ret < 0)
+				break;
+			offset += msg->sec[i].len;
+		}
+		if (ret < 0)
+			goto deconfigure_pte;
+	}
+
+	offset = 0;
+	/* For reads, copy all section data out of the DMA buffer */
+	if (!is_write) {
+		for (i = 0; i < msg->sections; i++) {
+			memcpy(msg->sec[i].buf, dma_buf + offset, msg->sec[i].len);
+			offset += msg->sec[i].len;
+		}
+	}
+
+deconfigure_pte:
+	if (dma_unsafe) {
+		/*
+		 * PORT_EN_STATUS never cleared: the ACP BPT DMA engine did not
+		 * confirm it stopped and may still be bus-mastering through the
+		 * ATU into dma_buf.  PORT_EN=0 is the only stop control the
+		 * hardware exposes -- the audio DMA path relies on the same
+		 * enable-clear-then-poll-status primitive -- so there is no
+		 * stronger barrier to force it off here.  Leave the ATU PTEs
+		 * pointing at dma_buf and do NOT free the buffer: returning
+		 * these pages to the allocator while a wedged engine can still
+		 * write would corrupt memory reused for another purpose.
+		 * Deliberately leak the buffer instead -- the only memory-safe
+		 * option, matching the guarantee the managed-buffer audio path
+		 * gets from the PCM core (buffer never reused while the engine
+		 * may be active).
+		 */
+		dev_err(amd_manager->dev,
+			"BPT: engine did not quiesce; leaking %zu bytes to avoid corruption\n",
+			total_len);
+		mutex_unlock(amd_manager->acp_bra_lock);
+		goto close_stream;
+	}
+	amd_sdw_bra_deconfigure_pte(amd_manager, total_len);
+	mutex_unlock(amd_manager->acp_bra_lock);
+free_dma:
+	dma_free_coherent(amd_manager->dev->parent, total_len, dma_buf, dma_addr);
+close_stream:
+	amd_sdw_bpt_close_stream(amd_manager, slave);
+	/*
+	 * Release in the reverse of the acquire order documented at the top:
+	 * drop bpt_lock before releasing the runtime-PM reference (matching the
+	 * bpt_disabled early-exit path above), so the lock is never held across
+	 * the PM put.
+	 */
+	mutex_unlock(&amd_manager->bpt_lock);
+	pm_runtime_mark_last_busy(amd_manager->dev);
+	pm_runtime_put_autosuspend(amd_manager->dev);
+	return ret;
+}
+
 static int sdw_master_read_amd_prop(struct sdw_bus *bus)
 {
 	struct amd_sdw_manager *amd_manager = to_amd_sdw(bus);
@@ -761,6 +1943,20 @@ static const struct sdw_master_ops amd_sdw_ops = {
 	.read_prop = amd_prop_read,
 	.xfer_msg = amd_sdw_xfer_msg,
 	.read_ping_status = amd_sdw_read_ping_status,
+	.bpt_send_async = amd_sdw_bpt_send_async,
+	.bpt_wait = amd_sdw_bpt_wait,
+};
+
+/*
+ * BRA/BPT was validated only on ACP70 and later.  ACP63 uses a different
+ * BPT register layout (see the per-revision port/transport-params tables),
+ * so it must not advertise the BPT callbacks -- doing so would let a BPT
+ * transfer program the wrong registers and corrupt audio DMA state.
+ */
+static const struct sdw_master_ops amd_sdw_ops_no_bpt = {
+	.read_prop = amd_prop_read,
+	.xfer_msg = amd_sdw_xfer_msg,
+	.read_ping_status = amd_sdw_read_ping_status,
 };
 
 static int amd_sdw_hw_params(struct snd_pcm_substream *substream,
@@ -1012,6 +2208,16 @@ static void amd_sdw_irq_thread(struct work_struct *work)
 
 	dev_dbg(amd_manager->dev, "[SDW%d] SDW INT: 0to7=0x%x, 8to11=0x%x\n",
 		amd_manager->instance, status_change_0to7, status_change_8to11);
+
+	/*
+	 * Clear non-slave-status bits before processing.
+	 * Bit 18 (BRA DMA completion) and bit 17 (command response)
+	 * are informational -- not tied to slave state changes.
+	 * Leaving them set can confuse the slave status update path.
+	 */
+	status_change_8to11 &= ~(AMD_SDW_BRA_DMA_COMPLETION_STAT |
+				   AMD_SDW_CMD_RESP_INTR_STAT);
+
 	if (status_change_8to11 & AMD_SDW_WAKE_STAT_MASK)
 		return amd_sdw_process_wake_event(amd_manager);
 
@@ -1081,11 +2287,15 @@ static int amd_sdw_manager_probe(struct platform_device *pdev)
 	amd_manager->mmio = amd_manager->acp_mmio +
 			    (amd_manager->instance * SDW_MANAGER_REG_OFFSET);
 	amd_manager->acp_sdw_lock = pdata->acp_sdw_lock;
+	amd_manager->acp_bra_lock = pdata->acp_bra_lock;
 	amd_manager->acp_rev = pdata->acp_rev;
 	amd_manager->cols_index = sdw_find_col_index(AMD_SDW_DEFAULT_COLUMNS);
 	amd_manager->rows_index = sdw_find_row_index(AMD_SDW_DEFAULT_ROWS);
 	amd_manager->dev = dev;
-	amd_manager->bus.ops = &amd_sdw_ops;
+	if (amd_manager->acp_rev >= ACP70_PCI_REV_ID)
+		amd_manager->bus.ops = &amd_sdw_ops;
+	else
+		amd_manager->bus.ops = &amd_sdw_ops_no_bpt;
 	amd_manager->bus.port_ops = &amd_sdw_port_ops;
 	amd_manager->bus.compute_params = &amd_sdw_compute_params;
 	amd_manager->bus.clk_stop_timeout = 200;
@@ -1132,6 +2342,10 @@ static int amd_sdw_manager_probe(struct platform_device *pdev)
 	prop = &amd_manager->bus.prop;
 	prop->mclk_freq = AMD_SDW_BUS_BASE_FREQ;
 
+	ret = devm_mutex_init(dev, &amd_manager->bpt_lock);
+	if (ret)
+		return ret;
+
 	ret = sdw_bus_master_add(&amd_manager->bus, dev, dev->fwnode);
 	if (ret) {
 		dev_err(dev, "Failed to register SoundWire manager(%d)\n", ret);
@@ -1154,9 +2368,32 @@ static void amd_sdw_manager_remove(struct platform_device *pdev)
 	struct amd_sdw_manager *amd_manager = dev_get_drvdata(&pdev->dev);
 	int ret;
 
+	/*
+	 * A BPT firmware transfer runs in the codec's firmware-download
+	 * context (amd_sdw_bpt_wait()) and holds bpt_lock for its entire
+	 * duration.  Latch bpt_disabled under the lock (mirroring amd_suspend())
+	 * before tearing anything down: draining alone is not enough, because as
+	 * soon as bpt_lock is released a task already blocked on it could start a
+	 * new transfer that then races sdw_bus_master_delete() into a
+	 * use-after-free.  Setting bpt_disabled makes any such transfer bail out
+	 * with -ESHUTDOWN instead, and the drain below waits for a transfer that
+	 * is already in flight to finish, so sdw_bus_master_delete() cannot free
+	 * bus structures still in use by amd_sdw_bpt_wait().
+	 */
+	mutex_lock(&amd_manager->bpt_lock);
+	amd_manager->bpt_disabled = true;
+	mutex_unlock(&amd_manager->bpt_lock);
+
 	pm_runtime_disable(&pdev->dev);
-	cancel_work_sync(&amd_manager->amd_sdw_work);
+	/*
+	 * Disable interrupts first so the ACP ISR can no longer schedule
+	 * amd_sdw_irq_thread, then drain the IRQ bottom-half before the
+	 * slave-status work: amd_sdw_irq_thread may schedule amd_sdw_work, so
+	 * it must be cancelled first (mirrors the suspend path ordering).
+	 */
 	amd_disable_sdw_interrupts(amd_manager);
+	cancel_work_sync(&amd_manager->amd_sdw_irq_thread);
+	cancel_work_sync(&amd_manager->amd_sdw_work);
 	sdw_bus_master_delete(&amd_manager->bus);
 	ret = amd_disable_sdw_manager(amd_manager);
 	if (ret)
@@ -1290,6 +2527,22 @@ static int __maybe_unused amd_suspend(struct device *dev)
 		return 0;
 	}
 
+	/*
+	 * Close the window between a BPT transfer and the clock stop below.
+	 * A codec's async firmware download runs in a workqueue
+	 * (amd_sdw_bpt_wait()) and its runtime-PM reference does not block
+	 * system-suspend clock stop.  Taking bpt_lock drains any transfer
+	 * already in progress (it completes on the still-live bus), and
+	 * setting bpt_disabled under the lock makes every subsequent transfer
+	 * bail with -ESHUTDOWN instead of racing amd_sdw_clock_stop().  A
+	 * plain drain is not enough: a re-enumeration-triggered download can
+	 * start a new BPT after the drain but before the clock stop.
+	 * amd_resume_runtime() clears the flag when the bus comes back.
+	 */
+	mutex_lock(&amd_manager->bpt_lock);
+	amd_manager->bpt_disabled = true;
+	mutex_unlock(&amd_manager->bpt_lock);
+
 	if (amd_manager->power_mode_mask & AMD_SDW_CLK_STOP_MODE) {
 		cancel_work_sync(&amd_manager->amd_sdw_work);
 		amd_sdw_wake_enable(amd_manager, false);
@@ -1340,6 +2593,26 @@ static int __maybe_unused amd_suspend_runtime(struct device *dev)
 			bus->link_id);
 		return 0;
 	}
+	/*
+	 * A BPT (firmware) transfer holds bpt_lock for its whole duration and
+	 * keeps a runtime-PM reference across it (pm_runtime_get_sync() in
+	 * amd_sdw_bpt_wait() until the matching put), so usage_count stays > 0
+	 * and this callback cannot be entered while a transfer is in flight; the
+	 * trylock below is a belt-and-braces guard for that invariant.
+	 *
+	 * Unlike the system-suspend path, runtime PM is still enabled here, so
+	 * there is no need to latch bpt_disabled to close the window between this
+	 * unlock and amd_sdw_clock_stop(): a BPT that starts in that window calls
+	 * pm_runtime_get_sync() first, and because the device is RPM_SUSPENDING
+	 * the PM core makes that get wait for this suspend to complete and then
+	 * resume the manager - restoring the clock - before it returns, so the
+	 * transfer never drives the BRA engine on a stopped clock. (The
+	 * system-suspend path must latch bpt_disabled because there runtime PM is
+	 * disabled and pm_runtime_get_sync() returns -EACCES instead of resuming.)
+	 */
+	if (!mutex_trylock(&amd_manager->bpt_lock))
+		return -EBUSY;
+	mutex_unlock(&amd_manager->bpt_lock);
 	if (amd_manager->power_mode_mask & AMD_SDW_CLK_STOP_MODE) {
 		amd_sdw_wake_enable(amd_manager, true);
 		if (amd_manager->acp_rev >= ACP70_PCI_REV_ID) {
@@ -1397,6 +2670,15 @@ static int __maybe_unused amd_resume_runtime(struct device *dev)
 		ret = amd_sdw_clock_stop_exit(amd_manager);
 		if (ret)
 			return ret;
+		/*
+		 * The bus clock is live again as soon as clock_stop_exit()
+		 * succeeds, so re-allow BPT here.  Doing it before the host-wake
+		 * step below means a spurious host_wake_enable() error cannot
+		 * leave BPT wedged at -ESHUTDOWN on an otherwise running clock.
+		 */
+		mutex_lock(&amd_manager->bpt_lock);
+		amd_manager->bpt_disabled = false;
+		mutex_unlock(&amd_manager->bpt_lock);
 		if (amd_manager->acp_rev >= ACP70_PCI_REV_ID) {
 			ret = amd_sdw_host_wake_enable(amd_manager, false);
 			if (ret)
@@ -1432,11 +2714,36 @@ static int __maybe_unused amd_resume_runtime(struct device *dev)
 			return ret;
 		amd_sdw_set_frameshape(amd_manager);
 	}
+
+	/*
+	 * Re-allow BPT transfers now that the bus clock is restored.  amd_suspend()
+	 * latches bpt_disabled under bpt_lock before stopping the clock; this
+	 * callback (which serves both runtime and system resume) clears it once the
+	 * clock-restore steps above have succeeded, before the BPT-independent
+	 * set_device_state() call below.  A BPT that tolerated a
+	 * pm_runtime_get_sync() -EACCES during the system-resume window still sees
+	 * bpt_disabled and bails out with -ESHUTDOWN instead of driving the BRA
+	 * engine on a not-yet-running clock.
+	 *
+	 * These paths differ in when the flag is cleared.  POWER_OFF_MODE clears it
+	 * only here, so a clock-restore step that fails returns above with
+	 * bpt_disabled still set and a failed resume correctly leaves BPT blocked.
+	 * CLK_STOP_MODE instead clears it right after clock_stop_exit() succeeds --
+	 * the clock is already live there -- so a subsequent host_wake_enable()
+	 * failure returns with BPT already re-allowed, which is intentional: blocking
+	 * BPT on a running clock would be needlessly conservative.  For the same
+	 * reason a set_device_state() failure below also leaves BPT enabled.
+	 */
+	mutex_lock(&amd_manager->bpt_lock);
+	amd_manager->bpt_disabled = false;
+	mutex_unlock(&amd_manager->bpt_lock);
+
 	if (amd_manager->acp_rev >= ACP70_PCI_REV_ID) {
 		ret = amd_sdw_set_device_state(amd_manager, AMD_SDW_DEVICE_STATE_D0);
 		if (ret)
 			return ret;
 	}
+
 	return 0;
 }
 
diff --git a/drivers/soundwire/amd_manager.h b/drivers/soundwire/amd_manager.h
index 88cf8a426a0c..1e355a597520 100644
--- a/drivers/soundwire/amd_manager.h
+++ b/drivers/soundwire/amd_manager.h
@@ -96,6 +96,17 @@
 #define ACP_SW_CLK_RESUME_DELAY_CNTR			0x0003184
 #define ACP_SW_BUS_RESET_CTRL				0x0003188
 #define ACP_SW_PRBS_ERR_STATUS				0x000318c
+#define ACP_SW_ERROR_REASON1					0x00031cc
+/*
+ * ACP_SW_I2S_ERROR_REASON is in the codec/I2S address space (not the SDW
+ * controller space) and must be accessed via acp_mmio (not mmio).
+ * Instance 0 and instance 1 have separate registers.
+ * bit 18: NAK response  bit 19: bus clash
+ * bits 26-30: BRA errors (header/footer/CRC/DMA/command response)
+ */
+#define ACP_SW_I2S_ERROR_REASON				0x000018b4
+#define ACP_P1_SW_I2S_ERROR_REASON			0x00001a50
+#define AMD_SDW_BRA_I2S_ERROR_MASK			0x7ffc0000
 #define ACP_SW_IMM_CMD_UPPER_WORD			0x0003230
 #define ACP_SW_IMM_CMD_LOWER_QWORD			0x0003234
 #define ACP_SW_IMM_RESP_UPPER_WORD			0x0003238
@@ -105,7 +116,6 @@
 #define ACP_SW_BRA_TRANSFER_SIZE			0x0003248
 #define ACP_SW_BRA_DMA_BUSY				0x000324c
 #define ACP_SW_BRA_RESP					0x0003250
-#define ACP_SW_BRA_RESP_FRAME_ADDR			0x0003254
 #define ACP_SW_BRA_CURRENT_TRANSFER_SIZE		0x0003258
 #define ACP_SW_STATE_CHANGE_STATUS_0TO7			0x000325c
 #define ACP_SW_STATE_CHANGE_STATUS_8TO11		0x0003260
@@ -117,6 +127,7 @@
 
 #define ACP_DELAY_US					10
 #define AMD_SDW_TIMEOUT					1000
+#define BRA_DMA_TIMEOUT_MS				1000
 #define AMD_SDW_DEFAULT_CLK_FREQ			12000000
 
 #define AMD_SDW_MCP_RESP_ACK				BIT(0)
@@ -154,6 +165,8 @@
 #define AMD_SDW_IRQ_MASK_0TO7		0x77777777
 #define AMD_SDW_IRQ_MASK_8TO11		0x000c7777
 #define AMD_SDW_IRQ_ERROR_MASK		0xff
+/* BRA DMA error interrupt bits [5:7] in ACP_SW_ERROR_INTR_MASK */
+#define AMD_SDW_BPT_ERR_INTR_MASK	(BIT(5) | BIT(6) | BIT(7))
 #define AMD_SDW_MAX_FREQ_NUM		1
 #define AMD_ACP63_SDW0_MAX_TX_PORTS		3
 #define AMD_ACP63_SDW0_MAX_RX_PORTS		3
@@ -189,6 +202,8 @@
 #define AMD_SDW0_PAD_KEEPER_DISABLE_MASK		0x1e
 #define AMD_SDW1_PAD_KEEPER_DISABLE_MASK		0xf
 #define AMD_SDW_PREQ_INTR_STAT				BIT(19)
+#define AMD_SDW_BRA_DMA_COMPLETION_STAT			BIT(18)
+#define AMD_SDW_CMD_RESP_INTR_STAT			BIT(17)
 #define AMD_SDW_CLK_STOP_DONE				1
 #define AMD_SDW_CLK_RESUME_REQ				2
 #define AMD_SDW_CLK_RESUME_DONE				3
diff --git a/include/linux/soundwire/sdw_amd.h b/include/linux/soundwire/sdw_amd.h
index 470360a2723c..11faf00f32de 100644
--- a/include/linux/soundwire/sdw_amd.h
+++ b/include/linux/soundwire/sdw_amd.h
@@ -37,6 +37,8 @@ struct acp_sdw_pdata {
 	u32 acp_rev;
 	/* mutex to protect acp common register access */
 	struct mutex *acp_sdw_lock;
+	/* mutex to protect the SoundWire BRA transfer vs the other manager instance */
+	struct mutex *acp_bra_lock;
 };
 
 /**
@@ -63,6 +65,7 @@ struct sdw_amd_dai_runtime {
  * @amd_sdw_irq_thread: SoundWire manager irq workqueue
  * @amd_sdw_work: peripheral status work queue
  * @acp_sdw_lock: mutex to protect acp share register access
+ * @acp_bra_lock: mutex to protect the SoundWire BRA transfer vs the other manager instance
  * @status: peripheral devices status array
  * @num_din_ports: number of input ports
  * @num_dout_ports: number of output ports
@@ -89,6 +92,8 @@ struct amd_sdw_manager {
 	struct work_struct amd_sdw_work;
 	/* mutex to protect acp common register access */
 	struct mutex *acp_sdw_lock;
+	/* mutex to protect the SoundWire BRA transfer vs the other manager instance */
+	struct mutex *acp_bra_lock;
 
 	enum sdw_slave_status status[SDW_MAX_DEVICES + 1];
 
@@ -108,6 +113,27 @@ struct amd_sdw_manager {
 	bool clk_stopped;
 
 	struct sdw_amd_dai_runtime **dai_runtime_array;
+
+	/* Transport columns allocated for the active BPT transfer */
+	u8 bra_hstart;
+	u8 bra_hstop;
+
+	/*
+	 * Serialises concurrent BPT requests from multiple slaves on the
+	 * same bus.  Acquired at the start of amd_sdw_bpt_wait() and released
+	 * before it returns, so that only one slave can use the single ACP BRA
+	 * engine at a time.  amd_sdw_bpt_send_async() deliberately takes no
+	 * lock; the whole transfer is serialised in amd_sdw_bpt_wait().
+	 */
+	struct mutex bpt_lock;
+
+	/*
+	 * Set true while the bus clock is stopped for system suspend so
+	 * that amd_sdw_bpt_wait() refuses new BPT transfers: starting one
+	 * on a clock-stopped bus wedges the command channel and leaves the
+	 * peripheral unable to re-enumerate on resume.  Guarded by bpt_lock.
+	 */
+	bool bpt_disabled;
 };
 
 /**
@@ -153,6 +179,7 @@ struct sdw_amd_ctx {
  * @parent: parent device
  * @dev: device implementing hwparams and free callbacks
  * @acp_lock: mutex protecting acp common registers access
+ * @acp_bra_lock: mutex protecting the SoundWire BRA transfer vs the other manager instance
  */
 struct sdw_amd_res {
 	u32 acp_rev;
@@ -166,6 +193,8 @@ struct sdw_amd_res {
 	struct device *dev;
 	/* use to protect acp common registers access */
 	struct mutex *acp_lock;
+	/* use to protect the SoundWire BRA transfer vs the other manager instance */
+	struct mutex *acp_bra_lock;
 };
 
 int sdw_amd_probe(struct sdw_amd_res *res, struct sdw_amd_ctx **ctx);
diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
index 62cb6bef17ab..fdbb0262c86a 100644
--- a/sound/soc/amd/ps/acp63.h
+++ b/sound/soc/amd/ps/acp63.h
@@ -322,6 +322,7 @@ struct acp_hw_ops {
  * sdw_dma_dev: platform device for SoundWire DMA controller
  * @mach_dev: platform device for machine driver to support ACP PDM/SoundWire configuration
  * @acp_lock: used to protect acp common registers
+ * @acp_bra_lock: protect the SoundWire BRA transfer against the other manager instance
  * @info: SoundWire AMD information found in ACPI tables
  * @sdw: SoundWire context for all SoundWire manager instances
  * @machine: ACPI machines for SoundWire interface
@@ -356,6 +357,7 @@ struct acp63_dev_data {
 	struct platform_device *sdw_dma_dev;
 	struct platform_device *mach_dev;
 	struct mutex acp_lock; /* protect shared registers */
+	struct mutex acp_bra_lock; /* protect BRA transfer vs the other manager instance */
 	struct sdw_amd_acpi_info info;
 	/* sdw context allocated by SoundWire driver */
 	struct sdw_amd_ctx *sdw;
diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index 729f9aaba69e..db42404a904d 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -287,6 +287,7 @@ static int amd_sdw_probe(struct device *dev)
 	sdw_res.parent = dev;
 	sdw_res.dev = dev;
 	sdw_res.acp_lock = &acp_data->acp_lock;
+	sdw_res.acp_bra_lock = &acp_data->acp_bra_lock;
 	sdw_res.count = acp_data->info.count;
 	sdw_res.mmio_base = acp_data->acp63_base;
 	sdw_res.acp_rev = acp_data->acp_rev;
@@ -630,6 +631,7 @@ static int snd_acp63_probe(struct pci_dev *pci,
 	pci_set_master(pci);
 	pci_set_drvdata(pci, adata);
 	mutex_init(&adata->acp_lock);
+	mutex_init(&adata->acp_bra_lock);
 	ret = acp_hw_init_ops(adata, pci);
 	if (ret) {
 		dev_err(&pci->dev, "ACP hw ops init failed\n");
diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index f89ad86260b4..343045b1e09e 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -889,6 +889,7 @@ static int amd_sof_sdw_probe(struct snd_sof_dev *sdev)
 	sdw_res.parent = sdev->dev;
 	sdw_res.dev = sdev->dev;
 	sdw_res.acp_lock = &acp_data->acp_lock;
+	sdw_res.acp_bra_lock = &acp_data->acp_bra_lock;
 	sdw_res.count = acp_data->info.count;
 	sdw_res.link_mask = acp_data->info.link_mask;
 	sdw_res.mmio_base = sdev->bar[ACP_DSP_BAR];
@@ -968,6 +969,7 @@ int amd_sof_acp_probe(struct snd_sof_dev *sdev)
 	adata->reg_range = chip->reg_end_addr - chip->reg_start_addr;
 	adata->pci_rev = pci->revision;
 	mutex_init(&adata->acp_lock);
+	mutex_init(&adata->acp_bra_lock);
 	sdev->pdata->hw_pdata = adata;
 
 	ret = acp_init(sdev);
diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
index 1cd9904c2908..3b1c56331fc1 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -245,6 +245,8 @@ struct acp_dev_data {
 	struct platform_device *dmic_dev;
 	/* mutex lock to protect ACP common registers access */
 	struct mutex acp_lock;
+	/* protect the SoundWire BRA transfer vs the other manager instance */
+	struct mutex acp_bra_lock;
 	/* ACPI information stored between scan and probe steps */
 	struct sdw_amd_acpi_info info;
 	/* sdw context allocated by SoundWire driver */
-- 
2.43.0

