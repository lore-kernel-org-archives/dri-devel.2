Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6294BCA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 04:23:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCBAB10EF88;
	Tue,  6 Oct 2026 04:23:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pOcqbHMs";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013006.outbound.protection.outlook.com
 [40.107.201.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10F2110EF85
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 04:23:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vTXWMG9J20L3ocOqdR4AAzc56BVkj5P4XxdiNARX7j0TWUCi5VlCkUZhSq4bfbfY71LHEuOsUG+KjWBNJqClbi1KhAPtpEeszItGWq3R5QoFA+I5PmTqkXmsV4W4bI8611iM1TG7ofWB8FOdICF38wYgcDArPRKs921sK48gmDz3IwdVKFjjUBX8pEQusYyEsL+5MYnMlEBNbl6F23NriCkNRrxoekzGXiPTg7VX+v5u4BWFm/kV/F7bJkMeq2nFdABviF+F1XIub32p3cmcdDfyYZljm3DjchfgS6aX0Jnico2HmVZw+VSlO9b/w2dWHnxEQRO+oZVLIJDl5oVNbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9z1MJbAb3QoFFG6ohCB7PHzMGzLxWQ9nxM7aV4lMuw=;
 b=qKVWbfTncKUL0QnuxK/iiMkkj7Vd44+aZp3pZjzjMFk5GoiVmb6JSHUb6Mb13jRybFmAqnRE7GHqjASydAxrUnjohE8TC5m1MxqEIp7Cv1ufb3cr9EVO+cyNr08EuzHW5bSdjk0S67KOXkV8lI73hjnNyavVwh9FbZD7WJDOPpGi8deGrrd9in7PtMT5LykFzn+RHAT4L7KaK7eNBD3nsLuAfDT1ePaGvIbWyz5Cp16PV3tnRC5fltpYuhV0JVL65OZztS76Jh0KWSmCmJU4OPH8vK+8/o3fgaSrpyXpWAgzlgA4RWx3D/YPM2nhQ8ApzFQ8mOqqo1bDoht7qQYfOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9z1MJbAb3QoFFG6ohCB7PHzMGzLxWQ9nxM7aV4lMuw=;
 b=pOcqbHMshOGlaTO2rt3qbeezOMAHSqWqnV0LN4oHNazrIFFw79JwFT+dK9WdSFCwXOmEQDKK/phKfRz0zZWZbU21f7xUUPfycCwZsTOipyyNvkIppBz1DgDvgmaNU0e7pZbBS2epr64HfK7s9eCipqpqkeBttvfK2btwRHL/dLg=
Received: from BN9PR03CA0365.namprd03.prod.outlook.com (2603:10b6:408:f7::10)
 by DS6PR12MB519164.namprd12.prod.outlook.com (2603:10b6:8:52b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 04:23:05 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:f7:cafe::8) by BN9PR03CA0365.outlook.office365.com
 (2603:10b6:408:f7::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue, 6
 Oct 2026 04:23:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 04:23:04 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 23:23:03 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 23:23:02 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Mon, 5 Oct 2026 23:23:01 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V2 20/20] accel/amdxdna: Enable AIE4 firmware logging to DRAM
Date: Mon, 5 Oct 2026 21:22:30 -0700
Message-ID: <20261006042230.547807-21-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261006042230.547807-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261006042230.547807-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|DS6PR12MB519164:EE_
X-MS-Office365-Filtering-Correlation-Id: 35f8d536-5c7a-453d-94d8-08df2361846c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 6jLei1zRKwim2WbHxwGFeWl4tviAB4SfuMbEBsY9/xVXMgTSD1dGJVvgsXZ9ZVg0BYzJzwjDkQ2GEuXz+OP7oTgXOqN6hS2LEUDuaIw/Tar3KFZeVTj7yXb5uypnbZk/ogn3Cv2MQec+bZQpMqdmXMdZq65baQNHJbs4cKGVbZVN29ZGKtPz/pfAbjbjDxHQWIegvFftMwbP8d2ZzZjN+2Obj1Gj1Wg8wI5tLcLOr54Ckx33vJ8p8djtsNAsYBOi2URG9FXY9cJwWKDhOaNHyXa7V7nNmNuLo09ZDJXlIQQcBsT+R7D+ERarnvZ3tzdE/E5Azv0ZlgbFkxmRH3sATpZ+Yl2/bXnTYw3/BWvB1/FnnrymyHaom/CInUQA3HnyH+Frgdio721uL2UC7hlgeNfoDmjN0BQycMy7K6ADmM8ri5Z28Jhgcet4P6zg3uykdCVOGMO8KT9ANYmdvhQl85JL5F6jxRNxVZ3tN1f4xG6FMV2ApiO1L5B7tT7xcZzYxl73VbEaF2/bqh7HgXgY36mP2HUptwz0ehXEq1C/ZjGA8+qiQDGARDbT2WcuPtfHLtjh6SfXKpzMrOIm4thDcXb49Ji/X0u8vNr4ygwcvGtvX4mrDGvzKC+OI16Y4jY7oGp29dAhgFY0CSrGas4xM0vs/h+ah4eMVc9gjc+HG+P9g/w3G3FKAu2qPKHupiHu2De3/mXKK/nq88XFjOY95Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0yQbv8vXuiUDXBRrH2t84CtV9CjD7LlEvWyE4dRm0jh0egZMhjBcDMovEQsE7NlzKMfd07Uh8rUv1182ehSG1pPkjjUsaJOKh0L9OkBP7SptXjYkEVaywDeg6btVTfrhlznzuXYtCJjpbfM5Ym8Zs2dd7tT238GW/KBcmnPuoMXMNafqr/GpWSyfuOvfse5EPs8cLfpMuaSReu2ZFNYEb0F91fE5WkjSiMBSIZT4ovytIqsLjMM8omAGYA9ubdJirpSmuIr7fRxYHmTqU4RFY+5QiYi7H3/DyGjpRon1KQdyZ68xnvgVanzXiaTI/P+2NVMV4u5QQ5Jp3fAsLbvrICvnnd/hZdQBL6gv9es3P1hetWly+G4AYQnSOiNFfIauv7qUyt8C3ZBF+12io2rpIE4vY/wLEmz1X6Msvq05ztTCH04LYgmKYqikqbYFqNR6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 04:23:04.9986 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35f8d536-5c7a-453d-94d8-08df2361846c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB519164
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
index 5720aa88e6d6..89902492502c 100644
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
index c395052eb6fd..d2c3b48e8ec3 100644
--- a/drivers/accel/amdxdna/aie4_pci.c
+++ b/drivers/accel/amdxdna/aie4_pci.c
@@ -376,6 +376,16 @@ static int aie4_config_fw(struct amdxdna_dev_hdl *ndev)
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
 
@@ -934,6 +944,41 @@ static void aie4_free_work_buffer(struct amdxdna_dev_hdl *ndev)
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
@@ -946,6 +991,8 @@ static int aie4_pf_init(struct amdxdna_dev *xdna)
 	if (ret)
 		return ret;
 
+	aie4_alloc_fw_log_buffer(xdna->dev_handle);
+
 	ret = aie4_pf_hw_start(xdna->dev_handle);
 	if (ret)
 		goto free_work_buf;
@@ -953,6 +1000,7 @@ static int aie4_pf_init(struct amdxdna_dev *xdna)
 	return 0;
 
 free_work_buf:
+	aie4_free_fw_log_buffer(xdna->dev_handle);
 	aie4_free_work_buffer(xdna->dev_handle);
 	return ret;
 }
@@ -980,6 +1028,8 @@ static int aie4_classic_init(struct amdxdna_dev *xdna)
 	if (ret)
 		return ret;
 
+	aie4_alloc_fw_log_buffer(xdna->dev_handle);
+
 	ret = aie4_classic_hw_start(xdna->dev_handle);
 	if (ret)
 		goto free_work_buf;
@@ -987,6 +1037,7 @@ static int aie4_classic_init(struct amdxdna_dev *xdna)
 	return 0;
 
 free_work_buf:
+	aie4_free_fw_log_buffer(xdna->dev_handle);
 	aie4_free_work_buffer(xdna->dev_handle);
 	return ret;
 }
@@ -995,6 +1046,7 @@ static void aie4_pf_fini(struct amdxdna_dev *xdna)
 {
 	aie4_sriov_stop(xdna->dev_handle);
 	aie4_pf_hw_stop(xdna->dev_handle);
+	aie4_free_fw_log_buffer(xdna->dev_handle);
 	aie4_free_work_buffer(xdna->dev_handle);
 }
 
@@ -1006,6 +1058,7 @@ static void aie4_vf_fini(struct amdxdna_dev *xdna)
 static void aie4_classic_fini(struct amdxdna_dev *xdna)
 {
 	aie4_classic_hw_stop(xdna->dev_handle);
+	aie4_free_fw_log_buffer(xdna->dev_handle);
 	aie4_free_work_buffer(xdna->dev_handle);
 }
 
diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
index a03c39457ab8..b6cca62abcbc 100644
--- a/drivers/accel/amdxdna/aie4_pci.h
+++ b/drivers/accel/amdxdna/aie4_pci.h
@@ -108,6 +108,10 @@ struct amdxdna_dev_hdl {
 	dma_addr_t			work_buf_addr;
 	u32				work_buf_size;
 
+	void				*fw_log_buf;
+	dma_addr_t			fw_log_buf_addr;
+	u32				fw_log_buf_size;
+
 	u8				pw_mode;
 
 	/* Context switch hysteresis timeout in microseconds. */
@@ -128,6 +132,7 @@ int aie4_query_aie_version(struct amdxdna_dev_hdl *ndev,
 			   struct amdxdna_drm_query_aie_version *version);
 int aie4_suspend_fw(struct amdxdna_dev_hdl *ndev);
 int aie4_attach_work_buffer(struct amdxdna_dev_hdl *ndev);
+int aie4_start_fw_log(struct amdxdna_dev_hdl *ndev, u32 level);
 int aie4_query_npu_firmware_version(struct amdxdna_dev_hdl *ndev,
 				    struct amdxdna_drm_query_firmware_version *fw_version);
 int aie4_query_cert_firmware_version(struct amdxdna_dev_hdl *ndev,
-- 
2.34.1

