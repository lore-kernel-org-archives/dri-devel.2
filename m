Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4395CA6007
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 03:25:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DF0610FBFC;
	Thu,  8 Oct 2026 03:25:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BhcwLc7G";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011067.outbound.protection.outlook.com [40.107.208.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A55A510FA7B
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 03:25:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iqvTxG0vMYHL20AyA5kRJAse39IlH2RVIbQt+qFk+ozUjzya2Gma57ozdu5Mgtx/PbjZsXR4d1YkStky6+bS+4V5WnSGkcSpOvIFqIGSQTNhIqt8NbZfgLjB0V2sTczjo+oeysGGVzbdHsUozfLhXyMVA8OqgVok/Pd5PaubYXLTtBtkxxk3tVwunRBQMN4HiG23UQNykmSIr/LMviXE3aSMkoImnyG7D4E5rudH+SuVIrk8A4+5SF+2Yq/5x5o6aaBKKQhe3ZVChhPu4u7nXg2KoMD9KTVuBs/Iqjw4g5NPtNdf5yDKSbQizw/C4crqk+QSjighhCPu0nX9vCiMZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNLH3PkyTfUbdk976y76NYAMWAVq+J4vkJ4ajEPJtMU=;
 b=l0eDmboVAv4NVVZ4hK0HBK+2Mr7YC7wMfV4WOQC5GIvQAK8vAutJACDZsjCP6SnjyPydOdg+l+8XK8+uwuF9uiSc/VqqcveOhiZLDAifQuEPGUPJqeaGGLU1TZQxffX2QdY000JxdBGNIntGGvBX9G77/9sgm1T4jah8Rlju/t5cw3LgZTasbs2X8c8Qx4hQuWqNZKrKq4tcDC9krViEaFoNIcTT8aBSKmJa9LNCN8AWsBUPOjQ35krpl0LBGdyriZOntc2YIJsUm/7bH56diilC6071b9p6bbuiPaJw2w6KW5u4YDUPosJFGwuMAtBt7GjOxDsHJeWTPG2Ez7p5kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNLH3PkyTfUbdk976y76NYAMWAVq+J4vkJ4ajEPJtMU=;
 b=BhcwLc7GJbKsEMoF0d4+lWnF2KgJLhhzFh0OUXnVS/u90YpV4gaJZzZeyqFg/QDoq0xZ1YMbEVwBDyeITzi5pm0RSXsMpzh8VPSDBc79KIrJsbiUeeucI53Ygf+hcC3DDIfMEWBX1N4u4qV1NfxkBMfh2rK4ocYrYdpwZSKqEig=
Received: from SJ0PR05CA0016.namprd05.prod.outlook.com (2603:10b6:a03:33b::21)
 by LVUPR12MB999159.namprd12.prod.outlook.com (2603:10b6:408:3a4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 03:24:18 +0000
Received: from SJ1PEPF000037AC.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::63) by SJ0PR05CA0016.outlook.office365.com
 (2603:10b6:a03:33b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Thu, 8
 Oct 2026 03:24:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037AC.mail.protection.outlook.com (10.167.244.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Thu, 8 Oct 2026 03:24:18 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 22:24:10 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Wed, 7 Oct 2026 22:24:10 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V3 17/19] accel/amdxdna: Enable AIE4 firmware logging to DRAM
Date: Wed, 7 Oct 2026 20:23:46 -0700
Message-ID: <20261008032348.2044667-18-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008032348.2044667-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261008032348.2044667-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AC:EE_|LVUPR12MB999159:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fe59f79-3b9c-4e36-ef52-08df24eba31d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|4143699003|11063799006|10067099003|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: PjuI6PCBBNCeL7aSPD/9mYYVnXjFSQQInD366QWATpFgmIaE8LzWkkKz3v2K5vtFtn9P4dlcFLBrifNZriKT0dkNSrWZjH4Z0R0MIJvQlaiDfglFAAh6Ac5x9HQ/9ZNSFlidBW3hEaNpN1cxpfaLt/UfRT6UlN8uFmMzzMDBpbCFtKrKgKjz5Y6oFJzOiP/MSM/B2UIy8l0WwEAoFk/GjQkT8tPVYu8jgbwCWTMEdxp93jiTyV50Rz7Sd8X/PcF0QgQwQ8WnMG9Bjux4Dg7uxoE8ooahbtG2XhGWtqkdq5kNcZQBB6l2B+GPwKcCTlcMEWaqsF06zofK0XyFbZv/UKuedxfQGk2BKhjc5rajF1c2sZq1VfxSBgot+biGe5UutN0OCjb5cD0adLIKkBFg9c9hv4A5xlfGfXWhHQZuTBC+giS22xvtJwJLBdlGRywjuh3sq/fNuqOoE062+rbKrDv7dW+7wOkZF/l4/zmHhB7F4mweMQiajC9fLZPt00PaCr+o4hp2wmJy9MReMyGyC7BYNaMSK33u6EvlO4H8wYT36RtFuMJNqlPWZAutBYAHXP17b/1m/+eKg5luk16Fx7y7hLK1ZiowTQAr7+f/yocUxVwQkhKUH5VXMkX72GqmGRTOzLSNcac7NInRDwRRfYeC068dLBgxIIWC1OJe46vzcr7YEpowiAyxAgQ7HtI0znz1MH2aB4DRZF/rLx/fDA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(4143699003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QnDXfgk42L8vW519d4wBNIDuv7TRhTwBjKbKO9EH0uOSaA1vGXuui/9btgLiVIR2pIaUyqlWOySP2f3G4R654VgGIR5whimjFZ3EnxVnbVyZku7CsQUUWkhKWS55JTohz/UfNQcdiakkRcQmoAz3NcazOei8QN06tdQPlYSzx9vp4dkAoQN6d95bC7SDBk+nxdGBCgElMOu5tBNjCYkPhUznbiXk72LADXrxckHPWSwRsHelIZdyUMMhiGTHqPvAG8sdVucj46NhMHQqf4hCEhlewHxBrYER6iBCn+w8qXedVRfY40ptItO4hxRBAR2IwISfKuXt6QA9HupsI59KNGC201eZnQcMoYBibxxTgOG15ZYVXFnzcKFRagMy0g4O4aqmNTye4A2VxSguNCz/P05xpNtsrdeWiDWE31WkdMygVC5vmP4pfzuQ1dP3wb/9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 03:24:18.1185 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fe59f79-3b9c-4e36-ef52-08df24eba31d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999159
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

Allocate a DRAM buffer for firmware logging, and also set the log level
to less verbose. This will give the best performance numbers.

Signed-off-by: David Zhang <yidong.zhang@amd.com>
---
 drivers/accel/amdxdna/aie4_message.c  | 20 ++++++++++
 drivers/accel/amdxdna/aie4_msg_priv.h | 24 ++++++++++++
 drivers/accel/amdxdna/aie4_pci.c      | 53 +++++++++++++++++++++++++++
 drivers/accel/amdxdna/aie4_pci.h      |  5 +++
 4 files changed, 102 insertions(+)

diff --git a/drivers/accel/amdxdna/aie4_message.c b/drivers/accel/amdxdna/aie4_message.c
index fc0b498b2923..2f451eda197a 100644
--- a/drivers/accel/amdxdna/aie4_message.c
+++ b/drivers/accel/amdxdna/aie4_message.c
@@ -246,6 +246,26 @@ int aie4_attach_work_buffer(struct amdxdna_dev_hdl *ndev)
 	return ret;
 }
 
+int aie4_start_fw_log(struct amdxdna_dev_hdl *ndev, u32 level)
+{
+	DECLARE_AIE_MSG(aie4_msg_start_fw_log, AIE4_MSG_OP_START_FW_LOG);
+	struct amdxdna_dev *xdna = ndev->aie.xdna;
+	int ret;
+
+	req.buff_addr = ndev->fw_log_buf_addr;
+	req.buff_size = ndev->fw_log_buf_size;
+	req.log_level = level;
+
+	ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
+	if (ret)
+		XDNA_WARN(xdna, "Failed to start fw log, ret %d", ret);
+	else
+		XDNA_DBG(xdna, "Started fw log, level %u size 0x%x",
+			 level, ndev->fw_log_buf_size);
+
+	return ret;
+}
+
 int aie4_msg_set_power_mode(struct amdxdna_dev_hdl *ndev, u8 power_mode)
 {
 	DECLARE_AIE_MSG(aie4_msg_power_override, AIE4_MSG_OP_POWER_OVERRIDE);
diff --git a/drivers/accel/amdxdna/aie4_msg_priv.h b/drivers/accel/amdxdna/aie4_msg_priv.h
index 636bf8d04c76..566f6abc9e2d 100644
--- a/drivers/accel/amdxdna/aie4_msg_priv.h
+++ b/drivers/accel/amdxdna/aie4_msg_priv.h
@@ -29,6 +29,7 @@ enum aie4_msg_opcode {
 	AIE4_MSG_OP_GET_CURRENT_DPM_LEVEL            = 0x30013,
 
 	AIE4_MSG_OP_ATTACH_WORK_BUFFER               = 0x40001,
+	AIE4_MSG_OP_START_FW_LOG                     = 0x40003,
 };
 
 enum aie4_msg_status {
@@ -263,4 +264,27 @@ struct aie4_msg_attach_work_buffer_resp {
 	enum aie4_msg_status status;
 } __packed;
 
+/* Dynamic firmware log levels. */
+enum aie4_fw_log_level {
+	AIE4_FW_LOG_LEVEL_OFF,
+	AIE4_FW_LOG_LEVEL_ERR,
+	AIE4_FW_LOG_LEVEL_WRN,
+	AIE4_FW_LOG_LEVEL_INF,
+	AIE4_FW_LOG_LEVEL_DBG,
+	AIE4_FW_LOG_LEVEL_MAX,
+};
+
+#define AIE4_FW_LOG_BUF_SIZE      SZ_1M
+
+struct aie4_msg_start_fw_log_req {
+	__u64 buff_addr;
+	__u32 buff_size;
+	__u32 log_level;
+	__u32 reserved;
+} __packed;
+
+struct aie4_msg_start_fw_log_resp {
+	enum aie4_msg_status status;
+} __packed;
+
 #endif /* _AIE4_MSG_PRIV_H_ */
diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
index aa383b3c5228..ae5b42287ef5 100644
--- a/drivers/accel/amdxdna/aie4_pci.c
+++ b/drivers/accel/amdxdna/aie4_pci.c
@@ -382,6 +382,16 @@ static int aie4_config_fw(struct amdxdna_dev_hdl *ndev)
 	if (ret == -ETIME)
 		return ret;
 
+	/*
+	 * Give the firmware high performance DRAM to log into with less
+	 * verbose level.
+	 */
+	if (ndev->fw_log_buf) {
+		ret = aie4_start_fw_log(ndev, AIE4_FW_LOG_LEVEL_ERR);
+		if (ret == -ETIME)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -940,6 +950,41 @@ static void aie4_free_work_buffer(struct amdxdna_dev_hdl *ndev)
 	ndev->work_buf = NULL;
 }
 
+/*
+ * Firmware logging is best effort: a device that cannot spare the buffer still
+ * runs, it just does not log. Never fail hw start or probe on this.
+ */
+static void aie4_alloc_fw_log_buffer(struct amdxdna_dev_hdl *ndev)
+{
+	struct amdxdna_dev *xdna = ndev->aie.xdna;
+	u32 buf_size = AIE4_FW_LOG_BUF_SIZE;
+
+	ndev->fw_log_buf = amdxdna_alloc_msg_buffer(xdna, &buf_size,
+						    &ndev->fw_log_buf_addr);
+	if (IS_ERR(ndev->fw_log_buf)) {
+		XDNA_WARN(xdna, "Failed to alloc fw log buffer, size 0x%x",
+			  AIE4_FW_LOG_BUF_SIZE);
+		ndev->fw_log_buf = NULL;
+		return;
+	}
+
+	ndev->fw_log_buf_size = buf_size;
+	XDNA_DBG(xdna, "FW log buffer allocated: size 0x%x", buf_size);
+}
+
+/* Free logging buffer after firmware execution has stopped. */
+static void aie4_free_fw_log_buffer(struct amdxdna_dev_hdl *ndev)
+{
+	struct amdxdna_dev *xdna = ndev->aie.xdna;
+
+	if (!ndev->fw_log_buf)
+		return;
+
+	amdxdna_free_msg_buffer(xdna, ndev->fw_log_buf_size, ndev->fw_log_buf,
+				ndev->fw_log_buf_addr);
+	ndev->fw_log_buf = NULL;
+}
+
 static int aie4_pf_init(struct amdxdna_dev *xdna)
 {
 	int ret;
@@ -952,6 +997,8 @@ static int aie4_pf_init(struct amdxdna_dev *xdna)
 	if (ret)
 		return ret;
 
+	aie4_alloc_fw_log_buffer(xdna->dev_handle);
+
 	ret = aie4_pf_hw_start(xdna->dev_handle);
 	if (ret)
 		goto free_work_buf;
@@ -959,6 +1006,7 @@ static int aie4_pf_init(struct amdxdna_dev *xdna)
 	return 0;
 
 free_work_buf:
+	aie4_free_fw_log_buffer(xdna->dev_handle);
 	aie4_free_work_buffer(xdna->dev_handle);
 	return ret;
 }
@@ -986,6 +1034,8 @@ static int aie4_classic_init(struct amdxdna_dev *xdna)
 	if (ret)
 		return ret;
 
+	aie4_alloc_fw_log_buffer(xdna->dev_handle);
+
 	ret = aie4_classic_hw_start(xdna->dev_handle);
 	if (ret)
 		goto free_work_buf;
@@ -993,6 +1043,7 @@ static int aie4_classic_init(struct amdxdna_dev *xdna)
 	return 0;
 
 free_work_buf:
+	aie4_free_fw_log_buffer(xdna->dev_handle);
 	aie4_free_work_buffer(xdna->dev_handle);
 	return ret;
 }
@@ -1001,6 +1052,7 @@ static void aie4_pf_fini(struct amdxdna_dev *xdna)
 {
 	aie4_sriov_stop(xdna->dev_handle);
 	aie4_pf_hw_stop(xdna->dev_handle);
+	aie4_free_fw_log_buffer(xdna->dev_handle);
 	aie4_free_work_buffer(xdna->dev_handle);
 }
 
@@ -1012,6 +1064,7 @@ static void aie4_vf_fini(struct amdxdna_dev *xdna)
 static void aie4_classic_fini(struct amdxdna_dev *xdna)
 {
 	aie4_classic_hw_stop(xdna->dev_handle);
+	aie4_free_fw_log_buffer(xdna->dev_handle);
 	aie4_free_work_buffer(xdna->dev_handle);
 }
 
diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
index da5aa57bc43f..4b7367af7cf1 100644
--- a/drivers/accel/amdxdna/aie4_pci.h
+++ b/drivers/accel/amdxdna/aie4_pci.h
@@ -105,6 +105,10 @@ struct amdxdna_dev_hdl {
 	dma_addr_t			work_buf_addr;
 	u32				work_buf_size;
 
+	void				*fw_log_buf;
+	dma_addr_t			fw_log_buf_addr;
+	u32				fw_log_buf_size;
+
 	u8				pw_mode;
 
 	/* Context switch hysteresis timeout in microseconds. */
@@ -125,6 +129,7 @@ int aie4_query_aie_version(struct amdxdna_dev_hdl *ndev,
 			   struct amdxdna_drm_query_aie_version *version);
 int aie4_suspend_fw(struct amdxdna_dev_hdl *ndev);
 int aie4_attach_work_buffer(struct amdxdna_dev_hdl *ndev);
+int aie4_start_fw_log(struct amdxdna_dev_hdl *ndev, u32 level);
 int aie4_query_npu_firmware_version(struct amdxdna_dev_hdl *ndev,
 				    struct amdxdna_drm_query_firmware_version *fw_version);
 int aie4_query_cert_firmware_version(struct amdxdna_dev_hdl *ndev,
-- 
2.34.1

