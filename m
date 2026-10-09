Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE2B6CA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 22:54:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1CC311230F;
	Fri,  9 Oct 2026 22:54:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iqdKGh8S";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012045.outbound.protection.outlook.com [52.101.48.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEB4C10EB6F
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 22:54:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qsot5trRIKJgnlaGBi1hksFCTw/YN/IM1YSKFKdC5drN7O34NeqgVyr5eHzvvzdeAWtzoTb+hyyYczguyTRXE42zWKhes22w35QMaUO+wcmA0P6zw5Dble9hsP1Wc1tZxTPHju0ZhwpBwKrZh5DoiOdupFhVuniSDdeAw4MbzQ1gzv4VJUYog7hkq1beBzu3B7uDTHzIDGfX9F0jjWvg0P+hATHPVvlP3StA1G5qxsSXDmBJ9UsqbspLmn5SyQhz40uju5xeMbs/weySblunW/Ab3zV5JBzaW4cIG4+tNXXJHDxccLZ3aXN0N9iA+wT3lzneAdGEWA0VeE9EJD3I2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDisLljZJLgqGD19IrQ97KjgsvcGEEdZ+hjuaw7wZU8=;
 b=s6TuF1fRdNysG5WCz0JMsmjQB06g+KzDNFIsUbL17U15AtTx3KUjUzUM/Ql9pmhZwFLi9VghZkAvSpIfGo76Uv78lDV/QFpukiEhxz2uZs1jQF+UXfRqTGhGcxvCMfGOLtL2vco6wJkCqJIdmy2e33ijFoeELQ5xrUs/ijdXYQwoxt+CBcWDUQzOSQDD5BdCC1fDsD2ueSSYnBjN+a/naWv+IGD9+OTokz/KkiUA+rSoXam1WQAAVXKbGlxtyq5Wh03vaF85hdHIWfiID4BxJUnPzDp23rQoBa8qv5mGZahu/wClOskWHbjumx3p94bHosPUYiNdnqJ/8eQNKaSREA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDisLljZJLgqGD19IrQ97KjgsvcGEEdZ+hjuaw7wZU8=;
 b=iqdKGh8SY+XUn3MHj9cUmlBo9nYcgYOtXl1QaxezfUOKiM/jRzJ8s8blgoxMqKDJXX/jU914nXA+eYGYOhZM8SCv7hwz/CxWtMoUymk+4zS0httLm3vG4oBF+HKsgyp1tBdnc1AVMA0Kj6B2/6/vM5plyLkp5LhSDe+KOr9nKvg=
Received: from BN9PR03CA0448.namprd03.prod.outlook.com (2603:10b6:408:113::33)
 by SJ5PPFCB5E1B8F5.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9a1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 22:54:05 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:408:113:cafe::82) by BN9PR03CA0448.outlook.office365.com
 (2603:10b6:408:113::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 9
 Oct 2026 22:54:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.0 via Frontend Transport; Fri, 9 Oct 2026 22:54:04 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 17:53:59 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Fri, 9 Oct 2026 17:53:59 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V4 17/19] accel/amdxdna: Enable AIE4 firmware logging to DRAM
Date: Fri, 9 Oct 2026 15:53:41 -0700
Message-ID: <20261009225343.3079074-18-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261009225343.3079074-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261009225343.3079074-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|SJ5PPFCB5E1B8F5:EE_
X-MS-Office365-Filtering-Correlation-Id: 57041070-4a22-409a-2f40-08df2658381e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|22082099003|10067099003|18002099003|3023799007|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: ZTQDEq4oWnDneNkqCOc7Cuqy/+w0K57fXJs1eioFMz95CdNpCTd2pPp6lx8QsM72IlD9M6uC7ZAeOJtM0TjyfPoTDYUMQy0p4+lN+xyY1gF/JpLcMBfhgZUo08h3aYFhykOTaoIqGrZZmPQrxfH/1LCm80Kbxbak2FxhgaQe09uQMswSvAH3q7lio9ApWPt3e22cYF8g2X116xosTYUSp5jX20gBjqEy1QzmNS6CXr7zq3xCVcPawJGIcKzbosFO6yF6CvOl4NqLy568anSKHDlcnSEdPQcdCYfmZlmp/455OK+zr8n+ZGx4Po40klqj54mV3ElXeCIW2QBWY5yKVdroJjG5eRtMfE60qwyyHNy93XJU3YH7SqxKEhmZWUS2Uw+7AhTkhL/y2JSdsYm9C5trqA5Ax3mb0RrMYUM0vglxbkiPpPys/oS6p0RrdmJv4ETz3pax4ZpjiVP55Mskudzqx6J+K7LV2/EYM8PzRt/Kcex/N+L80cGbeoSJ6E4sUr9n+Ho5Tbz9qA2CGkKuuuamfmcF+G3SfE+fDbj+ARUw5/FoeXTij0bZ+9AsQyq60nwXnp3EufmNPWNZ9kx7Rjyube8eun+MTGrYdA/WAEKxRvaV9D4iqiLPdr1i14gKV3oIINzQyIn3JaZUeOmdAAS0rSZvFvRGCXaPXHsLwZ+3SCwJZNDZBWa1gO9UvP24Rco1oINFCRu+zqlpN0vsQA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(22082099003)(10067099003)(18002099003)(3023799007)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7X8fYIF0AViOCvry/72I5MQ8an7RxVMgrjM1Tky2JbbiZeifvXA0eA7jd0n1P/rvCdBle52CwD1AwH5D2o4hRk2kwZE5ctAa6hiYquxQdOVp3ZdbMMGvVPGMMT0p9iyTY7F9RGSZkMYjyaR6m/iz12JDY6fv+URUH0yjHHLjOyf7XSnMNS/6yo+nu8OqVcYmZ5R5HFrkbbilFAv1umyjU6V/VA3uN+NU5MnHvAF6kdng2FqOLrh1hw632vYwTXLQsdKVVDEJGqvgWnxqJ9wKo/PTNqk8OwrRfcfvZXlGQ5gK1uMnIBVn4SiuJXDGu2iEra0NItxX2UjG61AHPlaVPzh7IuIaV9msZIyRPSWPgKOLlKg49sNe3y2/iSij+ye3SgmDS8zJX3/VqyXV1zP6RNNIEisO1y/WISrS6+YQuIX1lrE6odzOH++8I0+plkf9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 22:54:04.9957 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57041070-4a22-409a-2f40-08df2658381e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFCB5E1B8F5
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
index 2820cfb6f9ed..96ccc28e5360 100644
--- a/drivers/accel/amdxdna/aie4_message.c
+++ b/drivers/accel/amdxdna/aie4_message.c
@@ -247,6 +247,26 @@ int aie4_attach_work_buffer(struct amdxdna_dev_hdl *ndev)
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
index 7f4238f76bc2..e09d24d85cdf 100644
--- a/drivers/accel/amdxdna/aie4_pci.c
+++ b/drivers/accel/amdxdna/aie4_pci.c
@@ -383,6 +383,16 @@ static int aie4_config_fw(struct amdxdna_dev_hdl *ndev)
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
 
@@ -941,6 +951,41 @@ static void aie4_free_work_buffer(struct amdxdna_dev_hdl *ndev)
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
@@ -953,6 +998,8 @@ static int aie4_pf_init(struct amdxdna_dev *xdna)
 	if (ret)
 		return ret;
 
+	aie4_alloc_fw_log_buffer(xdna->dev_handle);
+
 	ret = aie4_pf_hw_start(xdna->dev_handle);
 	if (ret)
 		goto free_work_buf;
@@ -960,6 +1007,7 @@ static int aie4_pf_init(struct amdxdna_dev *xdna)
 	return 0;
 
 free_work_buf:
+	aie4_free_fw_log_buffer(xdna->dev_handle);
 	aie4_free_work_buffer(xdna->dev_handle);
 	return ret;
 }
@@ -987,6 +1035,8 @@ static int aie4_classic_init(struct amdxdna_dev *xdna)
 	if (ret)
 		return ret;
 
+	aie4_alloc_fw_log_buffer(xdna->dev_handle);
+
 	ret = aie4_classic_hw_start(xdna->dev_handle);
 	if (ret)
 		goto free_work_buf;
@@ -994,6 +1044,7 @@ static int aie4_classic_init(struct amdxdna_dev *xdna)
 	return 0;
 
 free_work_buf:
+	aie4_free_fw_log_buffer(xdna->dev_handle);
 	aie4_free_work_buffer(xdna->dev_handle);
 	return ret;
 }
@@ -1002,6 +1053,7 @@ static void aie4_pf_fini(struct amdxdna_dev *xdna)
 {
 	aie4_sriov_stop(xdna->dev_handle);
 	aie4_pf_hw_stop(xdna->dev_handle);
+	aie4_free_fw_log_buffer(xdna->dev_handle);
 	aie4_free_work_buffer(xdna->dev_handle);
 }
 
@@ -1013,6 +1065,7 @@ static void aie4_vf_fini(struct amdxdna_dev *xdna)
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

