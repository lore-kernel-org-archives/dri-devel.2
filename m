Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91AFBF9D0E7
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 16:56:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E052A10E009;
	Tue, 14 Apr 2026 16:56:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BlMRgtIq";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011007.outbound.protection.outlook.com [40.107.208.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D6D710E009
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 16:56:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8246mKLrbnFV7+xyzh5ZGRZ0BHgakXsQiueYUY9Te3oUR+7/pxrEN87YX+C4CJeW45F1B4V7k53vZTMs5Jf1db4xk4k9nuDU4CdKrO4A91ck5CijDvoGZhOIcN2gzl8Ox5czbDHChwHNOOY6Z4Rf4tZVjq4gFQgRfhCtAJBqkgFO9ZkystT2ZBc4ROYTRHBgr606smGN4wkwtrU2u1ExSP4cKCHKjolhDzowx1JMqngiPpJH8fae0D+8z11pTTM9HhYqb9GBETNCgqL3zOwpUUR1t41mO6gtuonOSK85w7/fUvKhnUUc0WurJkB1TSDiL5f766QczkN5BLtHls9GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZAIYUaY+iDmyux7rNhJwgLKUVEGQGYIahUSy79XvB4w=;
 b=yMLZMBGQ7RSOPq46JLW2zxWHotHcWpDKnF9keLqu3vkdkzinrkd5N/2ZehSYStJG1tvugZwCBrJal8730XqOtQ5B1SARK2RO6ZrMyB/kqy5mY25wGIwf3FXdV2WTUgGEZ46clUJQu6A3LsHwHIb3JLDngbM++KbHaFPBLXs2tIbOGXxGgmN2ys4sAn9oaFitRZju0yXBgwSrjaA6B8qT31CaLBDPjEpemB9k26pWI0Yk1IJRlOB2T04xMAw69oycL6o9q1WVu5dHpPYi9pLnQq6G/J/y9FMyWlwCW26t7IzoMgD0fbkljNWVrrFnP/XdiIPG71Ox7JPQgiQlsavsAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAIYUaY+iDmyux7rNhJwgLKUVEGQGYIahUSy79XvB4w=;
 b=BlMRgtIq+tldia3+0xB6qlE618amcbvyzDY/TrKyvRymYwMybiIdNx63M/gUXGt5d9G55NWG86VQSP/Ih21RMsS06PmmCMTRAq+FY0c84vQJ271p5274WDRbLX2V5zl8hAhLgnXCmszVsw9d20mTl2l8Hj3NX8xDPuNnE5qyozI=
Received: from DS7PR03CA0099.namprd03.prod.outlook.com (2603:10b6:5:3b7::14)
 by DS2PR12MB9798.namprd12.prod.outlook.com (2603:10b6:8:2b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 16:56:10 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:5:3b7:cafe::ba) by DS7PR03CA0099.outlook.office365.com
 (2603:10b6:5:3b7::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Tue,
 14 Apr 2026 16:56:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 16:56:10 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Apr
 2026 11:56:09 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 14 Apr 2026 11:56:09 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <maciej.falkowski@linux.intel.com>
CC: Max Zhen <max.zhen@amd.com>, <linux-kernel@vger.kernel.org>,
 <sonal.santan@amd.com>, Lizhi Hou <lizhi.hou@amd.com>
Subject: [PATCH V1] accel/amdxdna: Add hardware scheduler time quantum support
Date: Tue, 14 Apr 2026 09:56:02 -0700
Message-ID: <20260414165602.788811-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|DS2PR12MB9798:EE_
X-MS-Office365-Filtering-Correlation-Id: fe666bb0-c632-482f-4ad6-08de9a46bac4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: n3UGJURfpokOHhM5AzCyqtjfIphPO5K+Q96lSaHe1oYlgzf6eddTgG1FYteFzjRaJs4b4W/1HaWAIdpphTuaZvSdxjaGlpD+3fsIOtF3HpUyFm+8oqFBJwHBN1OM4GcvPHJst4wbjoVo+1L8B12s1G5g6L6XSABGTMs9MlLeYrK1kJy3CzNmzUVOIAMJ38HmnQAYEMnm3hlY4AzTtWgrqPed33Az5xgfLHmjhmXFYiVEnwsngWCSqK4Q5ANyqeVStCzfS5FdnVBYiO/n+hXT3grQBOgglALWYCzAYAyUXsEwvtDl/HwL5SmpiwboHFzm+h84W5kS4Xo28+SeU4sAvCV5vxiUraovoGlujvLnsA+G94FDMQ3KOOlnFeFOK842PyKNaKUsTcm+IhpE4AAVSIplZGZmIMdYK6IK9R26o+JCneAPptL8nwz0f6oNR6u5pxw+z5J26EHJFkTD2JDKQHiPo7Nbcl9oFRvyg27LZ1bNKwwtTeARHJEDmGUt5/r4EsAav0V9FdV65DL5tQVc5YIZxrtpxN712xWWWdJu3aTZWSJtpCDH7jHpFJXGgiMxUi4/RVsanKmj6FRUvtqRhFKyqbHyfmd48TSW1w72FVgZlXgZyKWWofGAgEq2Vw0CIUNNj+nB9xZ8IrgPlYQER3QfouE3EsrYJnjuldr05lI5MVAqEtFrrLdv3EpjjXqfSLlslqkfFNz60z7eER1rdwMS2KqpGHuWpbiGBXN/nBBuJtRek5HRyU+Fx49hBS5rz2A9qhW0HlHKQXt9HVz/Wg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: O77MaPJYCgiusNELGtuHlCMzenZt4pcaai0TTYUAIZZ3ltnJnWvPhWwA+M0kbZmfVpLz311yHgvXkHyS2z7JH9lJafd3qN+/Jsw+XoT0aSLg+OF1Aw8jmm/q2IJz0HvVu8FDsRFxKzUDcHgbkMnHu0xkGuXNJnl/yj48/WvOzD/bsaB3nW8+mwttBZs9l+X73NdDaz7fPkHU+lAGlPcGQel81CrQAP8EIMdX23sgbec+B0jT0Uw65o7Ffrp/FmhWyJVwKwYvqPy95/Pf2+ZsNObLsReFOom6xx63f3Y2Ku0iAigg0gKSaYXZi2uMleWdJn6mZQhYpdbCZqpGGSHTKIfdO4I83QWg7ANNx97R16q6UowC1r+pUrV7tLKpGypzFw6PBaiIZ/oZizvWR8wZzba15LsOzTnvZCJtknjwrt8lyTyqbgUvxmRlCXbw9kKL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 16:56:10.4069 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe666bb0-c632-482f-4ad6-08de9a46bac4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9798
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

From: Max Zhen <max.zhen@amd.com>

Add support for configuring the hardware scheduler time quantum to
improve fairness across concurrent contexts.

The scheduler enforces a fixed time slice per context, preventing
long-running workloads from monopolizing the device and allowing
other contexts to make forward progress.

The default time quantum is 30ms and can be configured via the
time_quantum_ms module parameter.

Signed-off-by: Max Zhen <max.zhen@amd.com>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie2_message.c  | 44 +++++++++++++++++++++++++++
 drivers/accel/amdxdna/aie2_msg_priv.h | 16 ++++++++++
 drivers/accel/amdxdna/aie2_pci.c      | 16 ++++++++++
 drivers/accel/amdxdna/aie2_pci.h      |  2 ++
 drivers/accel/amdxdna/npu4_regs.c     |  3 +-
 5 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/amdxdna/aie2_message.c
index e52dc7ea9fc7..976ad6281078 100644
--- a/drivers/accel/amdxdna/aie2_message.c
+++ b/drivers/accel/amdxdna/aie2_message.c
@@ -1200,3 +1200,47 @@ int aie2_query_app_health(struct amdxdna_dev_hdl *ndev, u32 context_id,
 	aie2_free_msg_buffer(ndev, buf_size, buf, dma_addr);
 	return ret;
 }
+
+static int
+aie2_runtime_update_ctx_prop(struct amdxdna_dev_hdl *ndev,
+			     struct amdxdna_hwctx *ctx, u32 type, u32 value)
+{
+	DECLARE_AIE_MSG(update_property, MSG_OP_UPDATE_PROPERTY);
+	struct amdxdna_dev *xdna = ndev->aie.xdna;
+	int ret;
+
+	if (!AIE_FEATURE_ON(&ndev->aie, AIE2_UPDATE_PROPERTY))
+		return -EOPNOTSUPP;
+
+	if (ctx)
+		req.context_id = ctx->fw_ctx_id;
+	else
+		req.context_id = AIE2_UPDATE_PROPERTY_ALL_CTX;
+
+	req.time_quota_us = value;
+	req.type = type;
+
+	ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
+	if (ret) {
+		XDNA_ERR(xdna, "%s update property failed, type %d ret %d",
+			 ctx ? ctx->name : "ctx.all", type, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+int aie2_update_prop_time_quota(struct amdxdna_dev_hdl *ndev, u32 us)
+{
+	struct amdxdna_dev *xdna = ndev->aie.xdna;
+	int ret;
+
+	ret = aie2_runtime_update_ctx_prop(ndev, NULL, UPDATE_PROPERTY_TIME_QUOTA, us);
+	if (ret == -EOPNOTSUPP) {
+		XDNA_DBG(xdna, "update time quota not support, skipped");
+		ret = 0;
+	} else if (!ret) {
+		XDNA_DBG(xdna, "Ctx exec time quantum updated to %u us", us);
+	}
+	return ret;
+}
diff --git a/drivers/accel/amdxdna/aie2_msg_priv.h b/drivers/accel/amdxdna/aie2_msg_priv.h
index f18e89a39e35..fc2e99510980 100644
--- a/drivers/accel/amdxdna/aie2_msg_priv.h
+++ b/drivers/accel/amdxdna/aie2_msg_priv.h
@@ -31,6 +31,7 @@ enum aie2_msg_opcode {
 	MSG_OP_SET_RUNTIME_CONFIG          = 0x10A,
 	MSG_OP_GET_RUNTIME_CONFIG          = 0x10B,
 	MSG_OP_REGISTER_ASYNC_EVENT_MSG    = 0x10C,
+	MSG_OP_UPDATE_PROPERTY             = 0x113,
 	MSG_OP_GET_APP_HEALTH              = 0x114,
 	MSG_OP_MAX_DRV_OPCODE,
 	MSG_OP_GET_PROTOCOL_VERSION        = 0x301,
@@ -503,4 +504,19 @@ struct get_app_health_resp {
 	__u32 required_buffer_size;
 	__u32 reserved[7];
 } __packed;
+
+struct update_property_req {
+#define UPDATE_PROPERTY_TIME_QUOTA 0
+	__u32 type;
+#define AIE2_UPDATE_PROPERTY_ALL_CTX	0xFF
+	__u8 context_id;
+	__u8 reserved[7];
+	__u32 time_quota_us;
+	__u32 reserved1;
+} __packed;
+
+struct update_property_resp {
+	enum aie2_msg_status status;
+} __packed;
+
 #endif /* _AIE2_MSG_PRIV_H_ */
diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
index c9c23c889c78..7ed99ea471a9 100644
--- a/drivers/accel/amdxdna/aie2_pci.c
+++ b/drivers/accel/amdxdna/aie2_pci.c
@@ -33,6 +33,11 @@ static int aie2_max_col = XRS_MAX_COL;
 module_param(aie2_max_col, uint, 0600);
 MODULE_PARM_DESC(aie2_max_col, "Maximum column could be used");
 
+#define MAX_TIME_QUANTUM_MS 2000 /* milliseconds */
+static uint time_quantum_ms = 30; /* milliseconds */
+module_param(time_quantum_ms, uint, 0400);
+MODULE_PARM_DESC(time_quantum_ms, "Execution time quantum. Default 30 ms, MAX 2000 ms");
+
 static char *npu_fw[] = {
 	"npu_7.sbin",
 	"npu.sbin"
@@ -186,6 +191,17 @@ static int aie2_mgmt_fw_init(struct amdxdna_dev_hdl *ndev)
 		return ret;
 	}
 
+	if (time_quantum_ms > MAX_TIME_QUANTUM_MS) {
+		XDNA_ERR(ndev->aie.xdna, "Bad time quantum %u", time_quantum_ms);
+		return -EINVAL;
+	}
+
+	ret = aie2_update_prop_time_quota(ndev, time_quantum_ms * 1000);
+	if (ret) {
+		XDNA_ERR(ndev->aie.xdna, "Failed to update execution time quantum");
+		return ret;
+	}
+
 	ret = aie2_xdna_reset(ndev);
 	if (ret) {
 		XDNA_ERR(ndev->aie.xdna, "Reset firmware failed");
diff --git a/drivers/accel/amdxdna/aie2_pci.h b/drivers/accel/amdxdna/aie2_pci.h
index f83deca2b51a..69b53c7bcb86 100644
--- a/drivers/accel/amdxdna/aie2_pci.h
+++ b/drivers/accel/amdxdna/aie2_pci.h
@@ -222,6 +222,7 @@ enum aie2_fw_feature {
 	AIE2_PREEMPT,
 	AIE2_TEMPORAL_ONLY,
 	AIE2_APP_HEALTH,
+	AIE2_UPDATE_PROPERTY,
 	AIE2_FEATURE_MAX
 };
 
@@ -308,6 +309,7 @@ int aie2_sync_bo(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job,
 		 int (*notify_cb)(void *, void __iomem *, size_t));
 int aie2_config_debug_bo(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job,
 			 int (*notify_cb)(void *, void __iomem *, size_t));
+int aie2_update_prop_time_quota(struct amdxdna_dev_hdl *ndev, u32 us);
 void *aie2_alloc_msg_buffer(struct amdxdna_dev_hdl *ndev, u32 *size,
 			    dma_addr_t *dma_addr);
 void aie2_free_msg_buffer(struct amdxdna_dev_hdl *ndev, size_t size,
diff --git a/drivers/accel/amdxdna/npu4_regs.c b/drivers/accel/amdxdna/npu4_regs.c
index a3b6df56abd0..6ebf75ad5fb4 100644
--- a/drivers/accel/amdxdna/npu4_regs.c
+++ b/drivers/accel/amdxdna/npu4_regs.c
@@ -93,9 +93,10 @@ const struct dpm_clk_freq npu4_dpm_clk_table[] = {
 
 const struct amdxdna_fw_feature_tbl npu4_fw_feature_table[] = {
 	{ .major = 6, .min_minor = 12 },
-	{ .features = BIT_U64(AIE2_NPU_COMMAND), .major = 6, .min_minor = 15 },
 	{ .features = BIT_U64(AIE2_PREEMPT), .major = 6, .min_minor = 12 },
 	{ .features = BIT_U64(AIE2_TEMPORAL_ONLY), .major = 6, .min_minor = 12 },
+	{ .features = BIT_U64(AIE2_NPU_COMMAND), .major = 6, .min_minor = 15 },
+	{ .features = BIT_U64(AIE2_UPDATE_PROPERTY), .major = 6, .min_minor = 15 },
 	{ .features = BIT_U64(AIE2_APP_HEALTH), .major = 6, .min_minor = 18 },
 	{ .features = AIE2_ALL_FEATURES, .major = 7 },
 	{ 0 }
-- 
2.34.1

