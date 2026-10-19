Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE6C606A31F
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 16:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=VLyvF7nQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AD2910ECC4;
	Mon, 19 Oct 2026 16:48:29 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013040.outbound.protection.outlook.com
 [40.93.201.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 964C210ECC4
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 16:48:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NAZVrNMTFwH8ELvNOL5K11c76c93lmlrG7a4Stc3W+zfXZtN8r9a+8LZMAskoegxu01XqLpg1qNxyhQlM798jmqo6lXiXDxeljE5SUe3i7lFPPAPppLK0w2iJkhWa+SxXjCXMINqVtr/I/v89AYp5xGN9WGecVc77dAK4G2GXEPJ4U6zao1OCbkhRu4baZhtukyfwAE6G16f2tTAxAVftT0uBUzJk6dK6o/0dZ8hXIs6L9VOrHqpRxbkV5GHgnvoLHUUB/yGY4fnrXn7NIPrmvxUeRz5bKJe8g7n+KAmiH02fOT6KgHOjTTHU8FRXXbVCieEExj6VrSsBMUwxhldEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7CzrDmx/O+MRpkAkYlx6Ugvt8fZTfUpqX0l383z4GPk=;
 b=AcK4FQRr4iMIFwD5LXLZ69w9vd8eVDTma9rBRlqi8Ud6RVsq2ZSlVkFln6R9Qeg+7/lM/7RaxLFoQVIrtQVMHhCETrfeIX5JcwU5dMqSpAtp5tg4iX8/OBukDrf7ry+2p77NE124K2ffgLI70WVhFNg2UKKNnv05G4vMkz3uSI+jFMlwRMvv6uNYqqs7atUeWEE3r1VWyrXFEFVO2drxKyfMiNRj67BRIuTrwXJrRiy1l2hhmW7j0Lpb1xmCHlZuuAH4Z+/bBTamFVe9DeJI+Qx4R9dTpRWLozjakmDhDej/ntQH+BLFx2GgrNKuaTI8sFkfKZ85xizfT5acoiHM+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CzrDmx/O+MRpkAkYlx6Ugvt8fZTfUpqX0l383z4GPk=;
 b=VLyvF7nQZK40RNd9SIhZDQMeOmrB2l4MGqMEshWe8VOC29k3wyQRMLk6LLJhodNHfN2Aos9OoKLDM4MTtgPrP/ZKdEKz3ZzeSvXzoexCGMjDr/BDTc4rpC/hwuNoZaI9K2CVSqybvMy0R8qRbWfpIYhR01eVLp1hmsNN00oXKY8=
Received: from PH7P220CA0137.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::22)
 by MN2PR12MB4406.namprd12.prod.outlook.com (2603:10b6:208:268::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Mon, 19 Oct
 2026 16:48:19 +0000
Received: from PH1PEPF00062F27.namprd02.prod.outlook.com
 (2603:10b6:510:327:cafe::51) by PH7P220CA0137.outlook.office365.com
 (2603:10b6:510:327::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon,
 19 Oct 2026 16:48:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 PH1PEPF00062F27.mail.protection.outlook.com (10.167.243.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 16:48:18 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 11:47:56 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via
 Frontend Transport; Mon, 19 Oct 2026 11:47:56 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V5 17/19] accel/amdxdna: Enable AIE4 firmware logging to DRAM
Date: Mon, 19 Oct 2026 09:47:44 -0700
Message-ID: <20261019164746.827277-18-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019164746.827277-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261019164746.827277-1-yidong.zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH1PEPF00062F27:EE_|MN2PR12MB4406:EE_
X-MS-Office365-Filtering-Correlation-Id: be6f4354-738e-4018-1c27-08df2e00c73c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|376014|36860700016|10067099003|22082099003|18002099003|3023799007|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 0vQo402IWcF47nwqcwafIFL6mza5QP7ijwrKx1iuRQcSS78Pq1EeMnk8zCzMlHjBVcTs6PqRLs9pESzi1/NztXaMCWUB7tShYR8cctZqtyaMeHyXt94d/ra/HGF3wcxi6Eq1LSFwiFIRFrjbMKPvbYKaCu/oP/FVq6k8tRq/4L9ppUQlFgMUlKjMZHQaA9a+T7mxRJG9ymFv4uvqO7BHf7okhmLFSAWbIiFvbxbWly1uzTrtd3D4oku8n0rKpb+XJ0nHjHBLQS10qF8Vl/bkryZsHjonfOQskQ2OK9rQNQqHF7pE1BkbPkxkqFlCcrMmnlLo6dCpy5NozrkyCIl2657HRjBt+WhAzIxDtZIF51P2YVby7YXHsMpkS06SS/cuUOiCQ9y5UyWx/Vmz32KTXlvSqnDOYAu5m0oNHG+YBZWmK3wKFe3yKsDhrUcgv0/AtNnrSiw5vdfo7K4vK54Be9MqIfHabGqJ8a1IUWVkkdy2R9U6DiNuZ68iYu4Iq0HCl+QG1VatYtJBCZ0t/g3UVksy/XR3AxWboNFqh5pXg1CCexYNzUk02BYNPctIqW7HeVbkJgAJbwZ54GqBAm75iGuJfUkPwoZm2V7j1oykCGL5yGgjPY9Ea+f5gbTv4SyhuF6prmsYBVvfGiSx4LkYZb1g0sLpJfNNEnNk6BUJyDRz/9UpZYBvfiKTtqErifE5YuqWh92mZ8yNi81p0ZMz+g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(376014)(36860700016)(10067099003)(22082099003)(18002099003)(3023799007)(4143699003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bUop8g224g7L09nP+VQQO6vu191kp9gcd4VAp1vxjMUVrqDuadSOdn91BMcCf56X8Y2FOaWrNM/rZ6Pcilp3FBr4l3qdcpF+YtIJvdd26dcbr27vlfjhR8o05u+zACQL0SszfRBcVWsQQKGMTmiPHRhESlsugN0oKQFUVyDNpXBoNLNKkK2ki3pOusK0Y/vpAn8j4o/W5JoAW3MrcC+nUJI0Rzuyt6xTO1Q1s268wgeu7ynLH2/IW5OKi6cTctquvKUXWvD2cGVpPR6/HcAh/3cBtEi+Nw1EWg4KIoKS6rtdqROiF9gx8CO4cevlF1okEZU9h7kRtutuieLl1HPIdJM6tZZMZmphx6+x9j4WLTI+Xeha4e24TcXm6CHjraWkKrDIVA/1enoHjNUqw+GoCSaA9xkOmkawf6/+BuuhzTy2l6bBfngNshjcBsm4R/3R
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 16:48:18.6268 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be6f4354-738e-4018-1c27-08df2e00c73c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH1PEPF00062F27.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4406
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Allocate a DRAM buffer for firmware logging, and also set the log level
to less verbose. This will give the best performance numbers.

Signed-off-by: David Zhang <yidong.zhang@amd.com>
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie4_message.c  | 20 ++++++++++
 drivers/accel/amdxdna/aie4_msg_priv.h | 24 ++++++++++++
 drivers/accel/amdxdna/aie4_pci.c      | 53 +++++++++++++++++++++++++++
 drivers/accel/amdxdna/aie4_pci.h      |  5 +++
 4 files changed, 102 insertions(+)

diff --git a/drivers/accel/amdxdna/aie4_message.c b/drivers/accel/amdxdna/aie4_message.c
index 8d2ce013c69b..060e199f4006 100644
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
index a4cf70f65203..71ce1842bd58 100644
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
 
@@ -931,6 +941,41 @@ static void aie4_free_work_buffer(struct amdxdna_dev_hdl *ndev)
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
@@ -943,6 +988,8 @@ static int aie4_pf_init(struct amdxdna_dev *xdna)
 	if (ret)
 		return ret;
 
+	aie4_alloc_fw_log_buffer(xdna->dev_handle);
+
 	ret = aie4_pf_hw_start(xdna->dev_handle);
 	if (ret)
 		goto free_work_buf;
@@ -950,6 +997,7 @@ static int aie4_pf_init(struct amdxdna_dev *xdna)
 	return 0;
 
 free_work_buf:
+	aie4_free_fw_log_buffer(xdna->dev_handle);
 	aie4_free_work_buffer(xdna->dev_handle);
 	return ret;
 }
@@ -977,6 +1025,8 @@ static int aie4_classic_init(struct amdxdna_dev *xdna)
 	if (ret)
 		return ret;
 
+	aie4_alloc_fw_log_buffer(xdna->dev_handle);
+
 	ret = aie4_classic_hw_start(xdna->dev_handle);
 	if (ret)
 		goto free_work_buf;
@@ -984,6 +1034,7 @@ static int aie4_classic_init(struct amdxdna_dev *xdna)
 	return 0;
 
 free_work_buf:
+	aie4_free_fw_log_buffer(xdna->dev_handle);
 	aie4_free_work_buffer(xdna->dev_handle);
 	return ret;
 }
@@ -992,6 +1043,7 @@ static void aie4_pf_fini(struct amdxdna_dev *xdna)
 {
 	aie4_sriov_stop(xdna->dev_handle);
 	aie4_pf_hw_stop(xdna->dev_handle);
+	aie4_free_fw_log_buffer(xdna->dev_handle);
 	aie4_free_work_buffer(xdna->dev_handle);
 }
 
@@ -1003,6 +1055,7 @@ static void aie4_vf_fini(struct amdxdna_dev *xdna)
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

