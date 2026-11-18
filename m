Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C76606D66A
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 23:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=TSnNu+2k
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10B9810EC71;
	Wed, 18 Nov 2026 23:32:55 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013017.outbound.protection.outlook.com
 [40.93.201.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 303B410EC71
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 23:32:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wcrf/JZ7y9vuPTqWqlO5sq1qIYU9VMvRbu48Y6RYuvp8oPEnYHo5+oqYpMbYWa7jnhUHafPsDF4MoIqcQs+5xlLWvzZr3x2aH7lOoJACYiewJXhsV+aZR8+MLIb0RRSSgQlfsPWuQ7dQrsliNDh/n9P+MS9wack1K/SFW0aRSztc2IEBqeTM8YxWraZvyzbK+gFtcvfRIaEFSRIv+uiroDrQM8z6HpJcUAvZnYXmU+LITcQHmm32oJXMGHqLRaJTjVuWDAlLr54jvb2x6qWS6NOPka1JmfhX3Da3jL6Zbaybl+VCxa4Fger5AzPVM7M7R1iz6psNeiz5gaqfkvlSLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NH99dfoG6hKdTlQnZB+tmXtdz76WkigJYBvld/rezs8=;
 b=GZde3WWBhNWr4MRMiUAGHV7EHuxabGdNivxKKHFs9kqcOglCwfvJ+BOW4tlnveITIc37FmBRFF87DgJFgNk6O8oJ4gAZjtV8Jfrlp/HsM8+TJK4w8k/aHw++Yi7ftNMg+EAYSl8Ua6KAwzqaEPeB+g8Kbw+XB5U3cyeTlIRpwGZ09f2VBSqyot3JYB8hHb1DM3KtTqVartGgyjlAebY32/CN8cAFN/E0pKkzvm0fwb34oELY+2BSNHVgUmnvQPzIYEvpzvrWE/EOWZPTt1AfKLlz22vrkYfSptCre4Ag95b0b3+KMvg6i8UCYbhHQP8TxeNZoJiKfU92rEkhMpX4KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NH99dfoG6hKdTlQnZB+tmXtdz76WkigJYBvld/rezs8=;
 b=TSnNu+2kwkcLrWat3SxEaL/D6ml8OwMnRqwwB++H1JZBTrOtMQRnDbQwWydoB0Ew+QBQTtdIg1gmEEyi+2Lb/yXyMzMb0cOw1aRA5eFqLJI9SwUA7JMmnbUYPS9r4mdijAdTmNr+J7oE00gq1Ac0dqZhNrCaKaiO1Nor/2ZnR1I=
Received: from CH5P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::24)
 by MW4PR12MB7240.namprd12.prod.outlook.com (2603:10b6:303:226::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 23:32:43 +0000
Received: from CH3PEPF00024580.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::c) by CH5P220CA0012.outlook.office365.com
 (2603:10b6:610:1ef::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Wed,
 18 Nov 2026 23:32:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00024580.mail.protection.outlook.com (10.167.252.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 23:32:42 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 17:32:42 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 17:32:42 -0600
Received: from xsjgregoryw50.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via
 Frontend Transport; Wed, 18 Nov 2026 17:32:41 -0600
From: Gregory Williams <gregory.williams@amd.com>
To: Oded Gabbay <ogabbay@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
Subject: [PATCH 15/15] accel/amd-ai-engine: Add reset operations
Date: Wed, 18 Nov 2026 15:32:11 -0800
Message-ID: <20261118233211.4121361-16-gregory.williams@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118233211.4121361-1-gregory.williams@amd.com>
References: <20261118233211.4121361-1-gregory.williams@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00024580:EE_|MW4PR12MB7240:EE_
X-MS-Office365-Filtering-Correlation-Id: 649d40e1-250f-4281-b404-08df45cc3e33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|261102123227099003|10067099003|261021121427099003|56012099006|11063799006|261021123027099003|261026121527099003|261026140227099003|261022105027099003|261028144727099003|261102130727099003|261022075727099003|261009223027099003|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: GPsCY12bU7T+s9T1qmgZY+c6YaOBL2eoX/sUP6/EjIEChCSWew7nve7FJe1rD4jeIVNFChygitrvcP7mL89py4BkVNzIpMfpc507xFD2QCoSjPps3yLe2Kw3JsRMydD3lZy+tPkYlAL/0Rn/aYaQCpVXdTc1Ct6EuK3OXg/YIlflFEksvMfNhV0VL5I7PtT0eBmzGxFdHEln6gEXKw1Ze97ukicIcCDuO6F0EHHnblsUyAHIW3onJs2zN/RpUsWCzb9QhZAS9GusAflJFG78MsENGsOb4Sl1dSK6BQAKJzhPRpL86AuWSHaAogr5+wSN0uDjEm+u5YeKUnAB2FDBh5UE4zPUBElWvHoHQ5BkQVeCXoi5YJxsX5q5aXmW66VIfc5hPk5DcCs6WtXc0LsgcO2d6i4yqEpLH2+Vc7y5xfi/XDx460LZtSVaqL0Bi2SU9H6bmyoKQcu0Y6+GzOPS6TKuO9C5GdZtGI0DIXCe0HSw3Or5QxguFXZu2QT/drFdsgD4jraBWx8C4PtbkF+EHKARTDh0DVHpQDhTvqPJosuvlwbLuPM40v/SoiQpFslukCvhfIm2PiFlY2i1qu7ysFHjO7a4gNeUWCkaXPdWDoeJZ2bF3QTAVeqfhaK3p9t2zkmw3gtUzpABu+lE2U//nrzwBu0oNqHjGTDUyh4wzvAF/JWkeYCrpn0dsPkGC58w6oLnEkoOBAUuWejWCQGBWg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(261102123227099003)(10067099003)(261021121427099003)(56012099006)(11063799006)(261021123027099003)(261026121527099003)(261026140227099003)(261022105027099003)(261028144727099003)(261102130727099003)(261022075727099003)(261009223027099003)(22082099003)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hzsk1rzLQ6cfBm5uKkGLFv579idOVSme4GUWxB0gEBTXCiRM32RWtW102OO4YHOl/jEMvM0m6tFEpk+Xh05ZsmcIsS1tpQ5FvgJmqBasUqpwq6B2NKm3JJU5QsguTzvkdwx62TbGKtaPcrSg+DdjhKSGIyzIipNRnCC++nDeNsZvq75HAA1Aw2JLxF3HbbAjAzyiImVL1UioP6MtYb+q6rL2mtmuLHD4FxnJSlI7D+fwstBp9G+ndl/C9LEybQe2KELvhzW8t6fDHb7Jfofq2qml0B3N9PDqUOnqI4vnzA9iZZf6D4HKqyAoFsY/+QnnmW9eJyIM2gRYJ9SOik9vEX/OPOfIxES0/4qUxmhQs3buC5RiUQR5XUYHyygJoEMrLOzJvr2TOiDQl1fruyVYYf1kVKz1a0K98iADy2d7sqoskqXks/Qm+qr0dkx4c8Nl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 23:32:42.8576 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 649d40e1-250f-4281-b404-08df45cc3e33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00024580.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7240
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

Add reset operations partition initialize/teardown.
aie_partition_initialize should be called before application start,
aie_partition_teardown should be called after application has finished.

Initialize will reset the device configuration, clear memories, enable
clocks of used tiles, configure hardware error reporting and NMUs, and
will enable ECC scrubbing.

Teardown will clear tile memories and disable tile clocks.

Signed-off-by: Gregory Williams <gregory.williams@amd.com>
---
 drivers/accel/amd-ai-engine/Makefile          |   3 +-
 .../accel/amd-ai-engine/ai-engine-aiemlv2.c   | 244 ++++++++++++++++++
 .../accel/amd-ai-engine/ai-engine-internal.h  |   8 +
 drivers/accel/amd-ai-engine/ai-engine-part.c  |  32 +++
 drivers/accel/amd-ai-engine/ai-engine-res.c   |  16 ++
 drivers/accel/amd-ai-engine/ai-engine-reset.c |  69 +++++
 include/linux/amd-ai-engine.h                 |  16 ++
 7 files changed, 387 insertions(+), 1 deletion(-)
 create mode 100644 drivers/accel/amd-ai-engine/ai-engine-reset.c

diff --git a/drivers/accel/amd-ai-engine/Makefile b/drivers/accel/amd-ai-engine/Makefile
index c6d090257d6e..d5b6ccde0a35 100644
--- a/drivers/accel/amd-ai-engine/Makefile
+++ b/drivers/accel/amd-ai-engine/Makefile
@@ -10,4 +10,5 @@ amd-aie-$(CONFIG_DRM_ACCEL_AMDAIE) := \
 	ai-engine-clock.o	\
 	ai-engine-part.o	\
 	ai-engine-pm.o		\
-	ai-engine-res.o
+	ai-engine-res.o		\
+	ai-engine-reset.o
diff --git a/drivers/accel/amd-ai-engine/ai-engine-aiemlv2.c b/drivers/accel/amd-ai-engine/ai-engine-aiemlv2.c
index 26dd1d726bfa..910a9bda2305 100644
--- a/drivers/accel/amd-ai-engine/ai-engine-aiemlv2.c
+++ b/drivers/accel/amd-ai-engine/ai-engine-aiemlv2.c
@@ -16,12 +16,16 @@
 /*
  * Register offsets
  */
+#define AIEMLV2_SHIMNOC_AXI_OUTSTANDING_TX_REGOFF	0x00002120U
 #define AIEMLV2_SHIMPL_COLCLOCK_CTRL_REGOFF		0x0007FF20U
+#define AIEMLV2_SHIMUC_AXI_OUTSTANDING_TX_REGOFF	0x000C0024U
 
 /*
  * Register masks
  */
+#define AIEMLV2_SHIMNOC_AXI_OUTSTANDING_TX_MASK		BIT(0)
 #define AIEMLV2_SHIMPL_COLCLOCK_CTRL_MASK		GENMASK(1, 0)
+#define AIEMLV2_SHIMUC_AXI_OUTSTANDING_TX_MASK		GENMASK(1, 0)
 
 static u32 aiemlv2_get_tile_type(struct aie_device *adev, struct aie_location *loc)
 {
@@ -173,10 +177,250 @@ static int aiemlv2_set_part_clocks(struct aie_partition *apart)
 	return aie_part_pm_ops_flush(apart);
 }
 
+static int aiemlv2_maskpoll_uc_outstanding_aximm_txn(struct aie_partition *apart)
+{
+	u32 end_col = apart->range.start.col + apart->range.size.col;
+	struct aie_location loc = {.row = 0};
+	int ret = 0;
+	u32 regoff;
+
+	for (loc.col = apart->range.start.col; loc.col < end_col; loc.col++) {
+		regoff = aie_cal_regoff(apart->adev, loc,
+					AIEMLV2_SHIMUC_AXI_OUTSTANDING_TX_REGOFF);
+		ret = aie_part_maskpoll_register(apart, regoff, 0x0,
+						 AIEMLV2_SHIMUC_AXI_OUTSTANDING_TX_MASK,
+						 2000000);
+		if (ret < 0) {
+			dev_err(&apart->dev,
+				"failed due to outstanding UC AXIMM transactions!\n");
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int aiemlv2_maskpoll_noc_outstanding_aximm_txn(struct aie_partition *apart)
+{
+	u32 end_col = apart->range.start.col + apart->range.size.col;
+	struct aie_location loc = {.row = 0};
+	int ret = 0;
+	u32 regoff;
+
+	for (loc.col = apart->range.start.col; loc.col < end_col; loc.col++) {
+		regoff = aie_cal_regoff(apart->adev, loc,
+					AIEMLV2_SHIMNOC_AXI_OUTSTANDING_TX_REGOFF);
+		ret = aie_part_maskpoll_register(apart, regoff, 0x0,
+						 AIEMLV2_SHIMNOC_AXI_OUTSTANDING_TX_MASK,
+						 2000000);
+		if (ret < 0) {
+			dev_err(&apart->dev,
+				"failed due to outstanding NoC AXIMM transactions!\n");
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int aiemlv2_part_init(struct aie_partition *apart,
+			     struct aie_partition_init_args *args)
+{
+	u32 opts;
+	int ret;
+
+	mutex_lock(&apart->mlock);
+	opts = AIE_PART_INIT_OPT_ENB_UC_DMA_PAUSE | AIE_PART_INIT_OPT_ENB_NOC_DMA_PAUSE;
+	ret = aie_part_pm_ops(apart, NULL, opts, apart->range, 1);
+	if (ret)
+		goto out;
+
+	ret = aiemlv2_maskpoll_noc_outstanding_aximm_txn(apart);
+	if (ret)
+		goto out;
+
+	ret = aiemlv2_maskpoll_uc_outstanding_aximm_txn(apart);
+	if (ret)
+		goto out;
+
+	aie_resource_clear_all(&apart->tiles_inuse);
+	aie_resource_clear_all(&apart->cores_clk_state);
+
+	/* First lets send non-data aie_op_type_len ops */
+	opts = 0;
+	/* This operation will do first 4 steps of sequence */
+	opts |= (args->init_opts & AIE_PART_INIT_OPT_COLUMN_RST);
+	opts |= (args->init_opts & AIE_PART_INIT_OPT_SHIM_RST);
+	opts |= (args->init_opts & AIE_PART_INIT_OPT_BLOCK_NOCAXIMMERR);
+	opts |= (args->init_opts & AIE_PART_INIT_OPT_ENB_COLCLK_BUFF);
+
+	/*
+	 * push opts to pm and flush, these ops need to be completed before we
+	 * call the next ones
+	 */
+	ret = aie_part_pm_ops(apart, NULL, opts, apart->range, 1);
+	if (ret) {
+		dev_err(&apart->dev, "pm ops: 0x%x failed: %d\n", opts, ret);
+		goto out;
+	}
+
+	if (args->init_opts & AIE_PART_INIT_OPT_ZEROIZEMEM) {
+		opts |= AIE_PART_INIT_OPT_ZEROIZEMEM;
+		ret = aie_part_pm_ops(apart, NULL, AIE_PART_INIT_OPT_ZEROIZEMEM,
+				      apart->range, 1);
+		if (ret)
+			goto out;
+	}
+
+	if (args->init_opts & AIE_PART_INIT_OPT_UC_ZEROIZATION) {
+		u16 data = 0x6;
+
+		opts |= AIE_PART_INIT_OPT_UC_ZEROIZATION;
+		ret = aie_part_pm_ops(apart, &data, AIE_PART_INIT_OPT_UC_ZEROIZATION,
+				      apart->range, 1);
+		if (ret)
+			goto out;
+	}
+
+	if (args->init_opts & AIE_PART_INIT_OPT_NMU_CONFIG) {
+		struct aie_range range = {0};
+
+		opts |= AIE_PART_INIT_OPT_NMU_CONFIG;
+		if (apart->range.start.col == 0) {
+			range.size.col = 2;
+			ret = aie_part_pm_ops(apart, NULL, AIE_PART_INIT_OPT_NMU_CONFIG,
+					      range, 0);
+			if (ret)
+				goto out;
+		}
+	}
+
+	if (args->init_opts & AIE_PART_INIT_OPT_HW_ERR_INT) {
+		u16 data = 0;
+
+		opts |= AIE_PART_INIT_OPT_HW_ERR_INT;
+		ret = aie_part_pm_ops(apart, &data, AIE_PART_INIT_OPT_HW_ERR_INT,
+				      apart->range, 0);
+		if (ret)
+			goto out;
+	}
+
+	if (args->init_opts & AIE_PART_INIT_OPT_HW_ERR_MASK) {
+		u16 data = 0x2;
+
+		opts |= AIE_PART_INIT_OPT_HW_ERR_MASK;
+		ret = aie_part_pm_ops(apart, &data, AIE_PART_INIT_OPT_HW_ERR_MASK,
+				      apart->range, 0);
+		if (ret)
+			goto out;
+	}
+
+	if (args->init_opts & AIE_PART_INIT_OPT_SET_ECC_SCRUB_PERIOD) {
+		u16 data;
+
+		if (args->ecc_scrub > U16_MAX) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		data = args->ecc_scrub;
+		opts |= AIE_PART_INIT_OPT_SET_ECC_SCRUB_PERIOD;
+		ret = aie_part_pm_ops(apart, &data,
+				      AIE_PART_INIT_OPT_SET_ECC_SCRUB_PERIOD,
+				      apart->range, 0);
+		if (ret)
+			goto out;
+	}
+
+	if (args->init_opts & AIE_PART_INIT_OPT_UC_ENB_MEM_PRIV) {
+		opts |= AIE_PART_INIT_OPT_UC_ENB_MEM_PRIV;
+
+		ret = aie_part_pm_ops(apart, NULL, AIE_PART_INIT_OPT_UC_ENB_MEM_PRIV,
+				      apart->range, 0);
+		if (ret)
+			goto out;
+	}
+
+	/* Request tile locations */
+	ret = aie_part_request_tiles(apart, args->num_tiles, args->locs);
+	if (ret)
+		goto out;
+
+	if (args->init_opts & AIE_PART_INIT_OPT_DIS_TLAST_ERROR) {
+		u16 data = 0;
+
+		opts |= AIE_PART_INIT_OPT_DIS_TLAST_ERROR;
+		ret = aie_part_pm_ops(apart, &data,
+				      AIE_PART_INIT_OPT_DIS_TLAST_ERROR,
+				      apart->range, 1);
+		if (ret)
+			goto out;
+	}
+
+	if (opts != args->init_opts)
+		dev_warn(&apart->dev, "Invalid init_opts: 0x%x\n", opts ^ args->init_opts);
+
+out:
+	mutex_unlock(&apart->mlock);
+	return ret;
+}
+
+static int aiemlv2_part_teardown(struct aie_partition *apart)
+{
+	u32 opts;
+	u16 data;
+	int ret;
+
+	mutex_lock(&apart->mlock);
+
+	opts = AIE_PART_INIT_OPT_ENB_UC_DMA_PAUSE | AIE_PART_INIT_OPT_ENB_NOC_DMA_PAUSE;
+	ret = aie_part_pm_ops(apart, NULL, opts, apart->range, 1);
+	if (ret)
+		goto out;
+
+	ret = aiemlv2_maskpoll_noc_outstanding_aximm_txn(apart);
+	if (ret)
+		goto out;
+
+	ret = aiemlv2_maskpoll_uc_outstanding_aximm_txn(apart);
+	if (ret)
+		goto out;
+
+	opts = AIE_PART_INIT_OPT_COLUMN_RST |
+	       AIE_PART_INIT_OPT_SHIM_RST |
+	       AIE_PART_INIT_OPT_ZEROIZEMEM;
+	ret = aie_part_pm_ops(apart, NULL, opts, apart->range, 0);
+	if (ret)
+		goto out;
+
+	/* Zeroizes the uc-DM and uc shared DM */
+	data = 0x6;
+	ret = aie_part_pm_ops(apart, &data, AIE_PART_INIT_OPT_UC_ZEROIZATION, apart->range, 1);
+	if (ret)
+		goto out;
+	ret = aie_part_pm_ops(apart, NULL, AIE_PART_INIT_OPT_DIS_COLCLK_BUFF, apart->range, 0);
+	if (ret)
+		goto out;
+	ret = aie_part_pm_ops_flush(apart);
+	if (ret)
+		goto out;
+
+	/* Clear resources */
+	aie_resource_clear_all(&apart->tiles_inuse);
+	aie_resource_clear_all(&apart->cores_clk_state);
+
+out:
+	mutex_unlock(&apart->mlock);
+
+	return ret;
+}
+
 static const struct aie_tile_operations aiemlv2_ops = {
 	.get_tile_type = aiemlv2_get_tile_type,
 	.scan_part_clocks = aiemlv2_scan_part_clocks,
 	.set_part_clocks = aiemlv2_set_part_clocks,
+	.part_init = aiemlv2_part_init,
+	.part_teardown = aiemlv2_part_teardown,
 };
 
 /**
diff --git a/drivers/accel/amd-ai-engine/ai-engine-internal.h b/drivers/accel/amd-ai-engine/ai-engine-internal.h
index 572476c97aad..64691223ff9c 100644
--- a/drivers/accel/amd-ai-engine/ai-engine-internal.h
+++ b/drivers/accel/amd-ai-engine/ai-engine-internal.h
@@ -49,6 +49,8 @@ struct aie_partition;
  *		     caller to apply partition lock before calling this
  *		     function. The caller function will need to set the bitmap
  *		     on which tiles are required to be clocked on.
+ * @part_init: initialize partition with user options.
+ * @part_teardown: teardown partition
  * Different AI engine device version has its own device
  * operation.
  */
@@ -56,6 +58,9 @@ struct aie_tile_operations {
 	u32 (*get_tile_type)(struct aie_device *adev, struct aie_location *loc);
 	int (*scan_part_clocks)(struct aie_partition *apart);
 	int (*set_part_clocks)(struct aie_partition *apart);
+	int (*part_init)(struct aie_partition *apart,
+			 struct aie_partition_init_args *args);
+	int (*part_teardown)(struct aie_partition *apart);
 };
 
 /**
@@ -360,10 +365,13 @@ int aie_resource_get_region(struct aie_resource *res, u32 start,
 void aie_resource_put_region(struct aie_resource *res, int start, u32 count);
 int aie_resource_set(struct aie_resource *res, u32 start, u32 count);
 int aie_resource_clear(struct aie_resource *res, u32 start, u32 count);
+int aie_resource_clear_all(struct aie_resource *res);
 bool aie_resource_testbit(struct aie_resource *res, u32 bit);
 int aie_part_pm_ops_create(struct aie_partition *apart);
 void aie_part_pm_ops_destroy(struct aie_partition *apart);
 int aie_part_pm_ops_flush(struct aie_partition *apart);
 int aie_part_pm_ops(struct aie_partition *apart, void *data, u32 type,
 		    struct aie_range range, bool flush);
+int aie_part_maskpoll_register(struct aie_partition *apart, u32 offset, u32 data,
+			       u32 mask, u32 timeout);
 #endif /* AIE_INTERNAL_H */
diff --git a/drivers/accel/amd-ai-engine/ai-engine-part.c b/drivers/accel/amd-ai-engine/ai-engine-part.c
index 35451d1ed88a..2cd93c02246e 100644
--- a/drivers/accel/amd-ai-engine/ai-engine-part.c
+++ b/drivers/accel/amd-ai-engine/ai-engine-part.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/amd-ai-engine.h>
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
@@ -106,3 +107,34 @@ struct aie_partition *aie_part_create(struct aie_device *adev,
 	device_unregister(&apart->dev);
 	return ERR_PTR(ret);
 }
+
+/**
+ * aie_part_maskpoll_register() - Mask polls an address for a data in a partition.
+ * @apart: AI engine partition.
+ * @offset: AI engine register offset.
+ * @data: data to poll.
+ * @mask: if it is non 0, it is mask read.
+ * @timeout: Timeout in microseconds.
+ *
+ * Return: zero for success, or -EBUSY for failure
+ */
+int aie_part_maskpoll_register(struct aie_partition *apart, u32 offset, u32 data,
+			       u32 mask, u32 timeout)
+{
+	u32 usleep_time = 10;
+	u32 value;
+	u32 i;
+
+	for (i = 0; i < timeout; i += usleep_time) {
+		value = readl(apart->adev->base + offset);
+		if ((value & mask) == data)
+			return 0;
+		usleep_range(usleep_time, usleep_time + 10);
+	}
+
+	value = readl(apart->adev->base + offset);
+	if ((value & mask) == data)
+		return 0;
+
+	return -EBUSY;
+}
diff --git a/drivers/accel/amd-ai-engine/ai-engine-res.c b/drivers/accel/amd-ai-engine/ai-engine-res.c
index 45b9447d896f..d35c27141cdd 100644
--- a/drivers/accel/amd-ai-engine/ai-engine-res.c
+++ b/drivers/accel/amd-ai-engine/ai-engine-res.c
@@ -151,6 +151,22 @@ int aie_resource_clear(struct aie_resource *res, u32 start, u32 count)
 	return 0;
 }
 
+/**
+ * aie_resource_clear_all() - clear all the AI engine resource bits
+ * @res: pointer to AI engine resource
+ * @return: 0 for success and negative value for failure
+ *
+ * This function clears all the bits in the resource.
+ */
+int aie_resource_clear_all(struct aie_resource *res)
+{
+	if (!res || !res->bitmap)
+		return -EINVAL;
+
+	bitmap_clear(res->bitmap, 0, res->total);
+	return 0;
+}
+
 /**
  * aie_resource_testbit() - test if a bit is set in a AI engine resource
  * @res: pointer to AI engine resource
diff --git a/drivers/accel/amd-ai-engine/ai-engine-reset.c b/drivers/accel/amd-ai-engine/ai-engine-reset.c
new file mode 100644
index 000000000000..f34d8d687d0e
--- /dev/null
+++ b/drivers/accel/amd-ai-engine/ai-engine-reset.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AMD AI Engine device driver reset implementation
+ *
+ * Copyright (C) 2025 Advanced Micro Devices, Inc.
+ */
+
+#include <linux/amd-ai-engine.h>
+#include <linux/firmware/xlnx-zynqmp.h>
+#include <linux/io.h>
+#include <linux/mutex.h>
+
+#include "ai-engine-internal.h"
+
+/**
+ * aie_partition_initialize() - AI engine partition initialization
+ * @dev: AI engine partition device
+ * @args: User initialization options
+ *
+ * Return: 0 for success and negative value for failure
+ *
+ * Based on user passed options this function will:
+ * - enable column and shim reset
+ * - ungate all columns
+ * - disable column reset
+ * - zeroize memories
+ * - setup NMU traffic and hardware error reporting
+ */
+int aie_partition_initialize(struct device *dev,
+			     struct aie_partition_init_args *args)
+{
+	struct aie_partition *apart;
+
+	if (!dev || !args)
+		return -EINVAL;
+
+	apart = dev_to_aiepart(dev);
+	if (apart->adev->ops->part_init)
+		return apart->adev->ops->part_init(apart, args);
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(aie_partition_initialize);
+
+/**
+ * aie_partition_teardown() - AI engine partition teardown
+ * @dev: AI engine partition device
+ *
+ * Return: 0 for success and negative value for failure
+ *
+ * This function will:
+ * - reset columns and shim
+ * - zeroize memories
+ * - gate all columns
+ */
+int aie_partition_teardown(struct device *dev)
+{
+	struct aie_partition *apart;
+
+	if (!dev)
+		return -EINVAL;
+
+	apart = dev_to_aiepart(dev);
+	if (apart->adev->ops->part_teardown)
+		return apart->adev->ops->part_teardown(apart);
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(aie_partition_teardown);
diff --git a/include/linux/amd-ai-engine.h b/include/linux/amd-ai-engine.h
index 229434372fc0..95884b782742 100644
--- a/include/linux/amd-ai-engine.h
+++ b/include/linux/amd-ai-engine.h
@@ -94,6 +94,22 @@ struct aie_op_handshake_data {
 	struct aie_location loc;
 };
 
+/*
+ * struct aie_partition_init_args - AIE partition initialization arguments
+ * @locs: Allocated array of tile locations that will be used
+ * @num_tiles: Number of tiles to use
+ * @init_opts: Partition initialization options
+ * @ecc_scrub: ecc_scrub period.
+ */
+struct aie_partition_init_args {
+	struct aie_location *locs;
+	u32 num_tiles;
+	u32 init_opts;
+	u32 ecc_scrub;
+};
+
 struct device *aie_partition_request(struct device *dev, struct aie_partition_req *req);
 void aie_partition_release(struct device *dev);
+int aie_partition_initialize(struct device *dev, struct aie_partition_init_args *args);
+int aie_partition_teardown(struct device *dev);
 #endif
-- 
2.34.1

