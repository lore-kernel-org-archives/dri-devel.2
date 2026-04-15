Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C39D6F4385A
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 17:11:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CBF610E180;
	Wed, 15 Apr 2026 17:11:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sByCOLwo";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010025.outbound.protection.outlook.com [52.101.61.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0930710E180
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 17:11:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=adZP+Gv+KOCGHz1ksEmdRJ4m6jKZU29jFlhfCVUnKpqehfNEZwmi2J/uDgQKCN2yiPzekw7wd9TkzKDs6OZoxHyOLRz4j/Y0KNaiTOgA4ikAlJ6LHmfTBpRwYD2Ey0w0zf3G01PzN6HCOM0NtP/UkxBFwv1ZB02s+PXihwhIlZruFZRzQSnRHoPBMSVc08hhrjEtTV0zT6GZ48viBkqYXyPYS10iEqf/PyKDVZY7k2rRXGz8VIEl4Jx4F1qS8/vf4/xUyqxDQN5uzxRzqZOtTcweDoKDzW6fknEgylJv1oBpc0Q5thDM2daMEc7V5s+xYg/9elJea2P0L1BJLvaTdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kz7sMBgpou/hun9wQHidVHX1XReczPK5j2Ln77d957o=;
 b=CtRV723A1BY4WEYLwFSa6GGnm6461kmnSjLjQPRY37aOvIix+wlm5MSo+L5MZFCvQxENfCevzT3VPNVwOZFWTUeYw4ZKLbZPTNpTycNQ1CK+NNpyROCnQnx/kKSAW8ztawpL734b6fJPtieLrYks3stdsHxi0+9stFmf+zldhLAImUNLoD7AvU9jKEFcCTcBnUzLyJX4V9VN3arAfO+ouVF1eSz5fP365hPNQfNo0AQFOYjhi3vELRPZhax6p46q69/w0GhkUmuwFEgEPbA276v64Od2dpmjyTqoqyBLMPPfCInDf2rAtc4gTEEzny8dDdt7G9p3WsXKaHhBSRSasg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kz7sMBgpou/hun9wQHidVHX1XReczPK5j2Ln77d957o=;
 b=sByCOLwo4sH/7Dp4BhcMAhML/Rsq39R7AHHuvUARuimDz8zh9qpDHfls6Bc4X3yfLT+/KzIOQs4Wnj/cDP//jShZhmmegcNl0lrq5PWMpgzW/kncRKzdsorpKk6jZGzgiwGN6zESrCQ+6O2Wmeli47ShUgiwXrbtoOnpPPARQpQ=
Received: from MN0P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::25)
 by IA0PR12MB8905.namprd12.prod.outlook.com (2603:10b6:208:484::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 17:11:42 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:531:cafe::3e) by MN0P222CA0019.outlook.office365.com
 (2603:10b6:208:531::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.49 via Frontend Transport; Wed,
 15 Apr 2026 17:11:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 17:11:41 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 15 Apr
 2026 12:11:41 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 15 Apr 2026 12:11:40 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <maciej.falkowski@linux.intel.com>
CC: Max Zhen <max.zhen@amd.com>, <linux-kernel@vger.kernel.org>,
 <sonal.santan@amd.com>, Lizhi Hou <lizhi.hou@amd.com>
Subject: [PATCH V2] accel/amdxdna: Add hardware scheduler time quantum support
Date: Wed, 15 Apr 2026 10:11:39 -0700
Message-ID: <20260415171139.904947-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|IA0PR12MB8905:EE_
X-MS-Office365-Filtering-Correlation-Id: f77f8ddc-a8f4-44fa-4eb3-08de9b121051
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: vdRPlR9JEqJ2676ZpiC/Yttt56cOtGC/UEx7u7v50BHfXDN2GmKGtmV4ZglHwn+EFecfEwC2QXzYI07sTw+o8zCvM3mIHxG//NiPaooomfyRKkwzyyAPrL4JhMjhsoFcVpG+zFObPOfC1BzTq9gt6eDjolLBw/mOZ2pG+B4T+jxDKYKwmgHN7wSN9MjmN2abmHEbf2V9KdkzC07melptCaJ8VN36GGWH/ohTVhIh9IAGdYdiRn6IuQz4AliSRdT1mYUBg6IJG0U+vNOg5OaovJkzL8D1EcKrCI3GuHnJ4C6VAV8dB/ZrfcmNRXNMyWjApz/SZmZTrWZk2l/rBUnd/AR4YNf8BP4dXV8xIe3Z0KqKlkBc+OEqgg64qE8fftkZj9mFeHChhq5E7XEMeMVYlQRVxLsgcHuKtLbAo299krwQ0tEznlciNCNuFTWM0Z24+vJkRpXgneKGmdUwqI/C7v9IO1AY+ilQFcP85UzGwZOCgF1vJ1/S7kAh5BeQydB0aWcAtXFFTVrr2Ndga6Xjyo0zYyJWkGnG8bZzPI3DmJ8cUtkWIN2RcQs+NeRazlbxH075ld7UGgb1RE9oGQe/xmiwiunpzCWx0mvLQgcYUY4LyBzXBkxPXq9+R8SpxlXryq1O0oYI2pj8+agEqrpjGXdkBh2vyb3JWONOSMAMI/8JbyNCtvmzEmZJguNYw7qh2NHHcdRMZ6Czh1ccogesjiZutwSUfOYZbRBDmOxai+HQc3mJrlxnC7g/tjQ4/377KMiawfxjz8YrXiiWwmNt7Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: czsRezN1lfo5AKtovmDgCHJGwdR/C7Aa+BTHJ122SuZSjJpdCHVTrawQ0bmK1Mcn1vtkZIt6VyNVwadk3XhRsHUOMfT0AmUBO0hbGQbVBA712tOvvM4/xB49Me/ss253JdecbsXOKStZf3H+YemGuQ3BEFNqrUcP7KGXOMEZchJVos4KWmn7wSMnhRF5qcHZ5ZC4mQePqkxaHNgPE9EBqMICpoFlXOedfpUoM4lS0CLq+x7fZHCu++wpfG3wRoo/37R08MgnLZS78xDIi0R3wnhrx3RsHds54cwXeK+X5RGmvGtNsr8Vh9UnQB9A6M3vxogcbksBB9hJKgbA85bBkAOj8SOfoJIRKQP8M6h+hZA69cWepsVIPWhdSi1h5zFtmh6LeV+oxOHNS1Un95fL3ZrRwIjB+sO7VVTSyjs4AkvPXO50C2uINtNzn2dL7CJJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 17:11:41.8237 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f77f8ddc-a8f4-44fa-4eb3-08de9b121051
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8905
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
 drivers/accel/amdxdna/aie2_pci.c      |  8 +++++
 drivers/accel/amdxdna/aie2_pci.h      |  2 ++
 drivers/accel/amdxdna/npu4_regs.c     |  3 +-
 5 files changed, 72 insertions(+), 1 deletion(-)

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
index c9c23c889c78..afbe3f8f67ce 100644
--- a/drivers/accel/amdxdna/aie2_pci.c
+++ b/drivers/accel/amdxdna/aie2_pci.c
@@ -33,6 +33,8 @@ static int aie2_max_col = XRS_MAX_COL;
 module_param(aie2_max_col, uint, 0600);
 MODULE_PARM_DESC(aie2_max_col, "Maximum column could be used");
 
+#define DEFAULT_TIME_QUANTUM 30000 /* microseconds */
+
 static char *npu_fw[] = {
 	"npu_7.sbin",
 	"npu.sbin"
@@ -186,6 +188,12 @@ static int aie2_mgmt_fw_init(struct amdxdna_dev_hdl *ndev)
 		return ret;
 	}
 
+	ret = aie2_update_prop_time_quota(ndev, DEFAULT_TIME_QUANTUM);
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

