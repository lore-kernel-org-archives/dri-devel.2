Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E79DCCA5FBA
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 03:33:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E512510F168;
	Wed, 30 Sep 2026 03:33:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t4xwTDKx";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013012.outbound.protection.outlook.com
 [40.107.201.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A66F10E9E0
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 03:33:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VyK0vN5hl1KbKMEgY37Zq7VgZSJ2gl0s9kwYic/0vMzhLHHxLKTV7NvRCWxl36sOAqaHqUahWyPLrN7kUeoDM/CeUlM34QSDdm5TxZPwYc1WNMskI/3PRm486VDHX9TvCsRvqfevFuieO5tOpihYh+ewkbHJdbRGXAzsuUY7Rr28+Pss2l0IBLeblC/aX4r+IkUWRfJMLRI+pdDL2UQvc+Pm6Mvqfl9bFmvVhV4qzOETySXfP2CqTudn5TeZ9g7fezOv3aDikpIx6E9sxrpBpn70LsWyWk3MPh+UkabB/Rj8jo0cfrNcu8yOPij1yytqKl6wfDjrn0YPlmv/cALRQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHuf2jYAe85ZVZayujpprp1bjsVr3J46+Js0b3xuqTA=;
 b=ouX+a+CAAw6nPEc8VtFpVa6M4Kt9mChgVnziFP0Fo0BX9CFe/x1VVvqVzt6fMDhdPpDvhBVoaSrJgo7urUMs4BEPboWax80NTfSJMQKXfzJuWnItGtpncLip0Eox3kHetOje6HfjjvVH+TW/2cyYmCcZqpZtK34KnzycIPRWwOHqGmwyayGzxWBvxJDgQJih9/jjGQr58m2cLcyi2IjE3/349L8GW6q7ERjIWNx9CDx1uLPpWy54ZzSI37FLKGfEx77Hovu65nbcT12ZLYx4eixJylmQTmd5O75+DKdTIppcjQvwfy3/Yk6USx8BVE828LKxNY5v+atE/NqcHSpQ/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHuf2jYAe85ZVZayujpprp1bjsVr3J46+Js0b3xuqTA=;
 b=t4xwTDKxEpUHuoWFe7t8MMkJksmp3T7SgKHkE23tMdY0U8qVfhJcLosS07khv3OaNv0IA5guCK1LBdJ/SmiNNRBYHVjLUgP6YQI4EJRTdqK+HHGZPxJuQ+PS5UPW01SnNaAQDuWX4zXeWz4heSawd0eAgSTAlsgjn4bvyDCbpDQ=
Received: from SJ0PR03CA0334.namprd03.prod.outlook.com (2603:10b6:a03:39c::9)
 by MN0PR12MB5956.namprd12.prod.outlook.com (2603:10b6:208:37f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 03:33:12 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:a03:39c:cafe::66) by SJ0PR03CA0334.outlook.office365.com
 (2603:10b6:a03:39c::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Wed,
 30 Sep 2026 03:33:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 03:33:12 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 22:33:06 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 22:33:06 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Tue, 29 Sep 2026 22:33:05 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V1 20/20] accel/amdxdna: Enable AIE4 firmware logging to DRAM
Date: Tue, 29 Sep 2026 20:32:33 -0700
Message-ID: <20260930033233.1727265-21-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930033233.1727265-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20260930033233.1727265-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|MN0PR12MB5956:EE_
X-MS-Office365-Filtering-Correlation-Id: 816eb010-bda8-4640-3677-08df1ea38e64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|4143699003|10067099003|56012099006|11063799006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: Ncvpu+sw1J3G3dw18wulsxWgALdr9qFcric9Z4ktEcq/hqLNz09x++zNQbzKzj7f84D6JrcUvBHbBIyJPZXLMPuLvoKAspBbC4bIN6rus9N06IBqaX7vKwuK5lL/JkDKXI+TSa2r4N5qZPUtP/pqKvmNPaiYSZ2ezvY2Heh+V2HgqT7nkHkDs1JLgNif6rUuS3fUs5hmrcW4RS1ljAreaQVe9KYAxZYcVblFmKwZbkQifsSqzBmBk/0ksjip7l8CoVdLY93F/+BWxJtIvMv4bZq8sFd6NgwtiI55Shq+VOquQtp7RkAhak0/dS7l4DCF5p8X5H0EykM+m+OY4mIqU2106GT74z05ahnM5l/pFILoVgUTqTd2ljj6tAaFX+HQs+2BsQg5DtEXmzhXl3qjPrMUWrRQhbNbf1TkN0uezHuTzZag5KZd2MNX+YESWh4LqUfwZEWozz/Iu0sW1vVJEbwFoLZkwV11auGtjzTkU9Kg6Ckb5GF99jIPW/uYeP2oCicJiAkNyD4Bo/2Y1zDtLre1OnKIS/aJb/fCypVB7b3hUQDbo4mL3cIOJWDRtqxTJtHSZ7OX8S+eYj+tXvTli+GYDRl+dXsdBlMS0IxbDNRuQwzjaAvk4ckjVSmKf/+Z1+usybF5a1k4aztsCraRJdUAyUq16GUdyL1eJh6d9LTBnv8Og9ABJWxXoWZzjhzO2lm2u7bfpfBFYft++mE8yg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(4143699003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sUxBkOr3PcCY9odeIIy2R58mAlPX3sqop3c9cmqfq/XdT7wNqKcIl/sixlHLi0zE5mKz+8GzciXENVyBHfM+yjKL5MIXDBAK42Lae01VqDtcyYVa/nDChgTx3r6kQ3wfmkB1d21BWxNdN5cgJinGjeG+f5EEiozwYVh5K8vGsUNTZSWURXNEesEOXmuSc3Cwd7sgtU06jxqf9z8F2wCw6saM4fMJIdi7I+Gm4RkGtnylCRJTBupSM6Y06CYd5H3/PYBBuCH7zCgGZc1XOIWUpmNwWIdiOo2rrfMqXhyjdGeS5hXaMiz8AcRu082ZU69tN3SBwnWGpuN8dqlkoBemZuMFIDs7ca8+ZdOFr3Xq2dnQSyA6bsKi7XWxPMSMnfYYdzoK5oXm5WfltHXozYS42yxv33ikXd/fLqz2r54eCXXXic34TLOCGNb9Jx1wXUPl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 03:33:12.6636 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 816eb010-bda8-4640-3677-08df1ea38e64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5956
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
 drivers/accel/amdxdna/aie4_pci.c      | 54 +++++++++++++++++++++++++++
 drivers/accel/amdxdna/aie4_pci.h      |  5 +++
 4 files changed, 103 insertions(+)

diff --git a/drivers/accel/amdxdna/aie4_message.c b/drivers/accel/amdxdna/aie4_message.c
index 1bddcb183db6..936fa2f43d91 100644
--- a/drivers/accel/amdxdna/aie4_message.c
+++ b/drivers/accel/amdxdna/aie4_message.c
@@ -232,6 +232,26 @@ int aie4_attach_work_buffer(struct amdxdna_dev_hdl *ndev)
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
index 77984683a7b6..51e7f4b5ed53 100644
--- a/drivers/accel/amdxdna/aie4_msg_priv.h
+++ b/drivers/accel/amdxdna/aie4_msg_priv.h
@@ -29,6 +29,7 @@ enum aie4_msg_opcode {
 	AIE4_MSG_OP_GET_CURRENT_DPM_LEVEL            = 0x30013,
 
 	AIE4_MSG_OP_ATTACH_WORK_BUFFER               = 0x40001,
+	AIE4_MSG_OP_START_FW_LOG                     = 0x40003,
 };
 
 enum aie4_msg_status {
@@ -275,4 +276,27 @@ struct aie4_msg_attach_work_buffer_resp {
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
index 62ee7dfc7bd3..480bd64b0020 100644
--- a/drivers/accel/amdxdna/aie4_pci.c
+++ b/drivers/accel/amdxdna/aie4_pci.c
@@ -404,6 +404,13 @@ static int aie4_config_fw(struct amdxdna_dev_hdl *ndev)
 	/* Best-effort tuning knob; failure is warned inside and does not fail hw start */
 	aie4_set_ctx_hysteresis(ndev, ndev->ctx_switch_hysteresis_us);
 
+	/*
+	 * Give the firmware high performance DRAM to log into with less
+	 * verbose level.
+	 */
+	if (ndev->fw_log_buf)
+		aie4_start_fw_log(ndev, AIE4_FW_LOG_LEVEL_ERR);
+
 	return 0;
 }
 
@@ -960,6 +967,45 @@ static void aie4_free_work_buffer(struct amdxdna_dev_hdl *ndev)
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
+/*
+ * Only called from the fini paths, after hw stop has already stopped the
+ * firmware, so the firmware cannot still be writing into the buffer. This
+ * mirrors the work buffer, which has no detach message either.
+ */
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
@@ -972,6 +1018,8 @@ static int aie4_pf_init(struct amdxdna_dev *xdna)
 	if (ret)
 		return ret;
 
+	aie4_alloc_fw_log_buffer(xdna->dev_handle);
+
 	ret = aie4_pf_hw_start(xdna->dev_handle);
 	if (ret)
 		goto free_work_buf;
@@ -979,6 +1027,7 @@ static int aie4_pf_init(struct amdxdna_dev *xdna)
 	return 0;
 
 free_work_buf:
+	aie4_free_fw_log_buffer(xdna->dev_handle);
 	aie4_free_work_buffer(xdna->dev_handle);
 	return ret;
 }
@@ -1006,6 +1055,8 @@ static int aie4_classic_init(struct amdxdna_dev *xdna)
 	if (ret)
 		return ret;
 
+	aie4_alloc_fw_log_buffer(xdna->dev_handle);
+
 	ret = aie4_classic_hw_start(xdna->dev_handle);
 	if (ret)
 		goto free_work_buf;
@@ -1013,6 +1064,7 @@ static int aie4_classic_init(struct amdxdna_dev *xdna)
 	return 0;
 
 free_work_buf:
+	aie4_free_fw_log_buffer(xdna->dev_handle);
 	aie4_free_work_buffer(xdna->dev_handle);
 	return ret;
 }
@@ -1021,6 +1073,7 @@ static void aie4_pf_fini(struct amdxdna_dev *xdna)
 {
 	aie4_sriov_stop(xdna->dev_handle);
 	aie4_pf_hw_stop(xdna->dev_handle);
+	aie4_free_fw_log_buffer(xdna->dev_handle);
 	aie4_free_work_buffer(xdna->dev_handle);
 }
 
@@ -1032,6 +1085,7 @@ static void aie4_vf_fini(struct amdxdna_dev *xdna)
 static void aie4_classic_fini(struct amdxdna_dev *xdna)
 {
 	aie4_classic_hw_stop(xdna->dev_handle);
+	aie4_free_fw_log_buffer(xdna->dev_handle);
 	aie4_free_work_buffer(xdna->dev_handle);
 }
 
diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
index 062275be7ee7..18d1f03247d3 100644
--- a/drivers/accel/amdxdna/aie4_pci.h
+++ b/drivers/accel/amdxdna/aie4_pci.h
@@ -120,6 +120,10 @@ struct amdxdna_dev_hdl {
 	dma_addr_t			work_buf_addr;
 	u32				work_buf_size;
 
+	void				*fw_log_buf;
+	dma_addr_t			fw_log_buf_addr;
+	u32				fw_log_buf_size;
+
 	u8				pw_mode;
 
 	/*
@@ -143,6 +147,7 @@ int aie4_query_aie_version(struct amdxdna_dev_hdl *ndev,
 			   struct amdxdna_drm_query_aie_version *version);
 int aie4_suspend_fw(struct amdxdna_dev_hdl *ndev);
 int aie4_attach_work_buffer(struct amdxdna_dev_hdl *ndev);
+int aie4_start_fw_log(struct amdxdna_dev_hdl *ndev, u32 level);
 int aie4_query_npu_firmware_version(struct amdxdna_dev_hdl *ndev,
 				    struct amdxdna_drm_query_firmware_version *fw_version);
 int aie4_query_cert_firmware_version(struct amdxdna_dev_hdl *ndev,
-- 
2.34.1

