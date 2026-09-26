Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F12C9832A
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 01:36:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6C6310FD18;
	Sat, 26 Sep 2026 01:36:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s+tQFIsL";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011057.outbound.protection.outlook.com [40.107.208.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E354010FD0C
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 01:35:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I84+t86WHwhnCfkx6Yi704vyotVhkwIYvQXZ840bOiP3q170z8EghFjd3fDUoU/SBUQFOuBMPPBwMn3E/aU8LBuHlvnEzx1jbz4wY3tygURO3y62tePrI6drGJ5g7ZI4GE73EVrrSl0D5ZT/XcKyRy+Khuk4HrXZBAFVVHQuxKxzd1JCxHtXKDoWGETtCEhDrzCdV5xsyAAji5tOVNNiBahAChxLj9Wj6zu18UZ8FIrRjh9C2yYpIUDxhfSaFkU2d8a93z1rQ0DDdYb8SZG7FCrR+uebOD/j5FZtoHTy/rgr9eHR6GA+t4JDQ2RIqFlnfVZaorK/ni1Y239LluU5ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xm2a+1erPqOay5pgUpS/VbeBJe4u2XJDoN8MWLmYYTc=;
 b=S3gw5aFXU7FJN/p+r2K6Qxm2ZBQUuPwiTg/3aFvn8pQ8S1n3oQHSKP9fLFPkTWNKcKM+Y5c+Ze9bPyFUsnOdpp1uPw7KknYQyfgJJWiBkYKKqE92W4Ow51S+OmEQsPHK1XH9bsIsCac4qBL3s0U1Gy0op2PQTEpCVD2K0qnmfrcW/0S4e7QhqkTa+6sa9497VlDNXAAnCsMOV+K1UNu4mSSOotnCrx48lbF25e/VqUQNWYk268SHgPQk8NPXLaWFb27BcMM2Gg6iQYITnha/RwSTxK3FzpZdbkp9XnUthbYsQsMn8CdFhmkSeGslIH/Is/cBi1DLtZXT/4gto/2ZuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xm2a+1erPqOay5pgUpS/VbeBJe4u2XJDoN8MWLmYYTc=;
 b=s+tQFIsLgQukYlwAoewc/5T+iXMYGNlglLLOb6kk0ofnWsqPHUTekrhz1OU8NZ7LhwyMTf81KE9IcBMNhhsBnCkel+Ryofr/CEAivkZqy1gyj1ZCX6tYy5oyuotaCCwAZOhN3Ds7mCqjd6pxDG3Qfb0gL9kmiNf85ThF6SS/yOo=
Received: from CH2PR12CA0004.namprd12.prod.outlook.com (2603:10b6:610:57::14)
 by MW5PR12MB5650.namprd12.prod.outlook.com (2603:10b6:303:19e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Sat, 26 Sep
 2026 01:35:32 +0000
Received: from BN2PEPF0000A7FE.namprd02.prod.outlook.com
 (2603:10b6:610:57:cafe::d) by CH2PR12CA0004.outlook.office365.com
 (2603:10b6:610:57::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.19 via Frontend Transport; Sat,
 26 Sep 2026 01:35:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A7FE.mail.protection.outlook.com (10.167.245.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Sat, 26 Sep 2026 01:35:31 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 25 Sep
 2026 20:35:26 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 25 Sep
 2026 20:35:26 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Fri, 25 Sep 2026 20:35:25 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>, Nishad Saraf <nishads@amd.com>
Subject: [PATCH V0 10/21] accel/amdxdna: Add context switch hysteresis with
 debugfs control
Date: Fri, 25 Sep 2026 18:34:37 -0700
Message-ID: <20260926013448.3840921-11-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260926013448.3840921-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20260926013448.3840921-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A7FE:EE_|MW5PR12MB5650:EE_
X-MS-Office365-Filtering-Correlation-Id: a8a2b1b4-5066-4270-255d-08df1b6e7432
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|6133799003|3023799007|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: s8pZMmwOTWKvRWPrGB87PJbTWMLHKmGKTlQlXRweY/MhnYL2ROscnFif0ZeL879D9d6LUHLZgA85MrhMlraZFedpToZPHCV/VG7ULoqLdsNBix/VK0J5qh0VlHri2LRQQsAK0zuT5AOH7jiCMGFNH9nqTqxAfUyJy3DcuTycJwdMLIeXtk1guoYb9qfJeM/CcM5B+4Abzz+jScGj5ZadXQJqgDmCOTbLm/gJNVbX3Q2rHdB8Dwk9sh2PsOaDPcRweVjqz8wnkLHsbLBq1n0A7TUo7kAt7RgGDIkfnaX4TKGx6Z9prusCCfVLhaXfoMVjfofpxFquuBVXRfVrqdDC0dpYdATFQrnJEWhUAgHYZBiUvj8o/zEvbNi6ClZd8O3aTkqE1mAEY1r9jDnL3I9RyPzgGd04Vig4fsy5m2BP/8Rfh237AwTqP2GSKyFxPG/8RVw2Bj6lLCz3lvs0lNjetZNrQBQJ/eQvTljZTN0k9qgvvDS4LOniKVzbU1+/zOhLNEVeo322dGQkRrCbQRqZ2R9xPsD9qo24WcsDEEnvNpugK8IQDA7v/Xf/vj/Uy0/AmePMG1k6bjvmxFO0BEVMY2H9fio4EnA3cvH/2GQYHrrQfgPL/ptTLTPBjSTuajX1ON8qPxIBmwJ3BpDHBocarLkooVeOlyxVDVgyvQNgqzCKb4p+5Hpef/UT6sknsA5v4SB0chHCq43L8uwplbMYZg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 58lAdsCF49Q+PPmpWBo154ZZuO7CydzadaaGHiA/DjvPfLnTC4t5UEz6vC/Dv5UxALEBbopqFL3jrvjiDt9R0GvN5o9RbzRNI35ZsSAjcc+dPpwLDEWmGx+esUaeDTYgyTewmNTClBjoTbE5cMLTlZH3YQkCEJi4Ok01Jpvi+hE53oVsjLAL6jrQmfqUpunGCVmFZFFf3n9jF68W29tlushz5mL2EJH61rwwdTXYtr95w11twAMaxK01MvfHMfQ1C3gHQ5nRviljUMn2b/ONJtqCKD1U6VjKJyt2PeOO8HPWlvFeLrZuxvCVYxtzttKUD8EjzBo1RkLbpC2qB9iiwIL+TP+Ad7EoN3q8CFF4SQxXq2IbT4WjLpq3AR2uibKY5mdZn9R4vygkffKZi74misl0SD+PqVmmsAWXIVwLAThCAvSMuIawn39xShuk8RZI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2026 01:35:31.9222 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a2b1b4-5066-4270-255d-08df1b6e7432
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A7FE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5650
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

Add aie4_set_ctx_hysteresis() to configure the AIE4 context switch
hysteresis timeout via the SET_RUNTIME_CONFIG message, applied at hw
start (PF and classic paths) with a default of 1000 us.

Expose a debugfs node 'ctx_switch_hysteresis_us' to change the timeout
at runtime (0 disables hysteresis). The stored value is re-applied on
every hw start so it survives runtime suspend/resume.

Co-developed-by: Nishad Saraf <nishads@amd.com>
Signed-off-by: Nishad Saraf <nishads@amd.com>
Signed-off-by: David Zhang <yidong.zhang@amd.com>
---
 drivers/accel/amdxdna/aie4_message.c    | 50 +++++++++++++++
 drivers/accel/amdxdna/aie4_msg_priv.h   | 36 +++++++++++
 drivers/accel/amdxdna/aie4_pci.c        | 85 ++++++++++++++++++++++++-
 drivers/accel/amdxdna/aie4_pci.h        | 12 ++++
 drivers/accel/amdxdna/amdxdna_debugfs.c |  3 +
 drivers/accel/amdxdna/amdxdna_pci_drv.h |  1 +
 6 files changed, 185 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/amdxdna/aie4_message.c b/drivers/accel/amdxdna/aie4_message.c
index 6d1f1561638b..ff776f478733 100644
--- a/drivers/accel/amdxdna/aie4_message.c
+++ b/drivers/accel/amdxdna/aie4_message.c
@@ -247,3 +247,53 @@ int aie4_msg_set_power_mode(struct amdxdna_dev_hdl *ndev, u8 power_mode)
 
 	return ret;
 }
+
+int aie4_set_runtime_cfg(struct amdxdna_dev_hdl *ndev, u32 type,
+			 const void *data, size_t size)
+{
+	DECLARE_AIE_MSG(aie4_msg_set_runtime_cfg, AIE4_MSG_OP_SET_RUNTIME_CONFIG);
+	u8 buf[sizeof(req.type) + AIE4_RUNTIME_CFG_MAX_DATA_SIZE] = { 0 };
+	int ret;
+
+	if (size > AIE4_RUNTIME_CFG_MAX_DATA_SIZE)
+		return -EINVAL;
+
+	/*
+	 * Firmware expects a 4-byte @type immediately followed by the
+	 * per-type payload (size validated against the struct npu_msg_-
+	 * runtime_config_* picked by @type). The shared request struct
+	 * carries an inline @data[4] slot, so stage only the 4-byte @type
+	 * header plus the variable payload contiguously and send exactly
+	 * that many bytes on the wire.
+	 */
+	req.type = type;
+	memcpy(buf, &req.type, sizeof(req.type));
+	memcpy(buf + sizeof(req.type), data, size);
+
+	msg.send_data = buf;
+	msg.send_size = sizeof(req.type) + size;
+
+	ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
+	if (ret)
+		XDNA_ERR(ndev->aie.xdna, "Failed to set runtime cfg %u: %d", type, ret);
+	return ret;
+}
+
+int aie4_set_ctx_hysteresis(struct amdxdna_dev_hdl *ndev, u32 timeout_us)
+{
+	struct aie4_msg_runtime_config_ctx_switch_hysteresis cfg = {
+		.timeout_us = timeout_us,
+	};
+	int ret;
+
+	ret = aie4_set_runtime_cfg(ndev, AIE4_RUNTIME_CONFIG_CTX_SWITCH_HYSTERESIS,
+				   &cfg, sizeof(cfg));
+	if (ret)
+		XDNA_WARN(ndev->aie.xdna,
+			  "Failed to set ctx switch hysteresis to %u us (%d), using fw default",
+			  timeout_us, ret);
+	else
+		XDNA_DBG(ndev->aie.xdna, "Context switch hysteresis set to %u us", timeout_us);
+
+	return ret;
+}
diff --git a/drivers/accel/amdxdna/aie4_msg_priv.h b/drivers/accel/amdxdna/aie4_msg_priv.h
index fe78df9e23c8..77984683a7b6 100644
--- a/drivers/accel/amdxdna/aie4_msg_priv.h
+++ b/drivers/accel/amdxdna/aie4_msg_priv.h
@@ -12,6 +12,7 @@
 enum aie4_msg_opcode {
 	AIE4_MSG_OP_IDENTIFY                         = 0x10002,
 	AIE4_MSG_OP_SUSPEND                          = 0x10003,
+	AIE4_MSG_OP_SET_RUNTIME_CONFIG               = 0x10007,
 	AIE4_MSG_OP_QUERY_CERT_FIRMWARE_VERSION      = 0x1000F,
 
 	AIE4_MSG_OP_CREATE_VFS                       = 0x20001,
@@ -65,6 +66,41 @@ struct aie4_msg_suspend_resp {
 	enum aie4_msg_status status;
 } __packed;
 
+/*
+ * Type selector for AIE4_MSG_OP_SET_RUNTIME_CONFIG. Values match the firmware
+ * ABI enum npu_msg_runtime_config_type; only the configs the driver programs
+ * are enumerated here.
+ */
+enum aie4_msg_runtime_config_type {
+	AIE4_RUNTIME_CONFIG_CTX_SWITCH_HYSTERESIS	= 0xD,
+	AIE4_MAX_RUNTIME_CONFIG
+};
+
+struct aie4_msg_set_runtime_cfg_req {
+	__u32 type;
+	__u8 data[4];
+} __packed;
+
+struct aie4_msg_set_runtime_cfg_resp {
+	enum aie4_msg_status status;
+} __packed;
+
+/* Maximum trailing per-type payload (struct npu_msg_runtime_config_*) in the
+ * firmware ABI; today the largest is npu_msg_runtime_config_event_trace_status
+ * at 12 bytes. Rounded up to leave headroom for future configs.
+ */
+#define AIE4_RUNTIME_CFG_MAX_DATA_SIZE 16
+
+/*
+ * Context switch hysteresis configuration.
+ *
+ * @timeout_us: Hysteresis time in microseconds for keeping a context loaded
+ *              in the AIE after it becomes idle, or 0 to disable hysteresis.
+ */
+struct aie4_msg_runtime_config_ctx_switch_hysteresis {
+	__u32 timeout_us;
+} __packed;
+
 struct aie4_msg_create_vfs_req {
 	__u32 vf_cnt;
 } __packed;
diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
index 05c181626173..e1484d384d3d 100644
--- a/drivers/accel/amdxdna/aie4_pci.c
+++ b/drivers/accel/amdxdna/aie4_pci.c
@@ -5,8 +5,10 @@
 
 #include <drm/amdxdna_accel.h>
 #include <drm/drm_drv.h>
+#include <drm/drm_file.h>
 #include <drm/drm_managed.h>
 #include <drm/drm_print.h>
+#include <linux/debugfs.h>
 #include <linux/firmware.h>
 #include <linux/sizes.h>
 
@@ -325,6 +327,20 @@ int aie4_restore_power_mode(struct amdxdna_dev_hdl *ndev)
 	return aie4_msg_set_power_mode(ndev, ndev->pw_mode);
 }
 
+static int aie4_config_fw(struct amdxdna_dev_hdl *ndev)
+{
+	int ret;
+
+	ret = aie4_attach_work_buffer(ndev);
+	if (ret)
+		return ret;
+
+	/* Best-effort tuning knob; failure is warned inside and does not fail hw start */
+	aie4_set_ctx_hysteresis(ndev, ndev->ctx_switch_hysteresis_us);
+
+	return 0;
+}
+
 static int aie4_pf_hw_start(struct amdxdna_dev_hdl *ndev)
 {
 	int ret;
@@ -337,7 +353,7 @@ static int aie4_pf_hw_start(struct amdxdna_dev_hdl *ndev)
 	if (ret)
 		goto stop_fw;
 
-	ret = aie4_attach_work_buffer(ndev);
+	ret = aie4_config_fw(ndev);
 	if (ret)
 		goto mbox_fini;
 
@@ -419,7 +435,7 @@ static int aie4_classic_hw_start(struct amdxdna_dev_hdl *ndev)
 	if (ret)
 		goto mailbox_fini;
 
-	ret = aie4_attach_work_buffer(ndev);
+	ret = aie4_config_fw(ndev);
 	if (ret)
 		goto mailbox_fini;
 
@@ -574,6 +590,7 @@ static int aie4m_pcidev_init(struct amdxdna_dev *xdna)
 
 	ndev->priv = xdna->dev_info->dev_priv;
 	ndev->aie.xdna = xdna;
+	ndev->ctx_switch_hysteresis_us = AIE4_CTX_HYSTERESIS_US;
 	ndev->pw_mode = POWER_MODE_DEFAULT;
 	xdna->dev_handle = ndev;
 
@@ -920,15 +937,78 @@ static void aie4_classic_fini(struct amdxdna_dev *xdna)
 	aie4_free_work_buffer(xdna->dev_handle);
 }
 
+static int aie4_ctx_hysteresis_get(void *data, u64 *val)
+{
+	struct amdxdna_dev_hdl *ndev = data;
+	struct amdxdna_dev *xdna = ndev->aie.xdna;
+
+	guard(mutex)(&xdna->dev_lock);
+	*val = ndev->ctx_switch_hysteresis_us;
+
+	return 0;
+}
+
+static int aie4_ctx_hysteresis_set(void *data, u64 val)
+{
+	struct amdxdna_dev_hdl *ndev = data;
+	struct amdxdna_dev *xdna = ndev->aie.xdna;
+	int ret, idx;
+
+	if (val > U32_MAX)
+		return -EINVAL;
+
+	if (!drm_dev_enter(&xdna->ddev, &idx))
+		return -ENODEV;
+
+	mutex_lock(&xdna->dev_lock);
+
+	ret = amdxdna_pm_resume_get_locked(xdna);
+	if (ret)
+		goto unlock;
+
+	ret = aie4_set_ctx_hysteresis(ndev, (u32)val);
+	if (!ret)
+		ndev->ctx_switch_hysteresis_us = (u32)val;
+
+	amdxdna_pm_suspend_put(xdna);
+
+unlock:
+	mutex_unlock(&xdna->dev_lock);
+	drm_dev_exit(idx);
+
+	return ret;
+}
+
+/* Context switch hysteresis timeout in microseconds; 0 disables hysteresis. */
+DEFINE_DEBUGFS_ATTRIBUTE(aie4_ctx_hysteresis_fops, aie4_ctx_hysteresis_get,
+			 aie4_ctx_hysteresis_set, "%llu\n");
+
+static void aie4_debugfs_init(struct amdxdna_dev *xdna)
+{
+	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
+
+	/*
+	 * Context switch hysteresis is a system-control runtime config that is
+	 * only programmed on the PF/classic hw start paths, never on a VF.
+	 * Only expose the knob where the driver actually applies it.
+	 */
+	if (!to_pci_dev(xdna->ddev.dev)->is_virtfn)
+		debugfs_create_file_unsafe("ctx_switch_hysteresis_us", 0600,
+					   xdna->ddev.accel->debugfs_root, ndev,
+					   &aie4_ctx_hysteresis_fops);
+}
+
 const struct amdxdna_dev_ops aie4_pf_ops = {
 	.init			= aie4_pf_init,
 	.fini			= aie4_pf_fini,
+	.debugfs_init		= aie4_debugfs_init,
 	.sriov_configure        = aie4_sriov_configure,
 };
 
 const struct amdxdna_dev_ops aie4_vf_ops = {
 	.init			= aie4_vf_init,
 	.fini			= aie4_vf_fini,
+	.debugfs_init		= aie4_debugfs_init,
 	.hwctx_init		= aie4_hwctx_init,
 	.hwctx_fini		= aie4_hwctx_fini,
 	.cmd_wait		= aie4_cmd_wait,
@@ -939,6 +1019,7 @@ const struct amdxdna_dev_ops aie4_vf_ops = {
 const struct amdxdna_dev_ops aie4_classic_ops = {
 	.init			= aie4_classic_init,
 	.fini			= aie4_classic_fini,
+	.debugfs_init		= aie4_debugfs_init,
 	.hwctx_init		= aie4_hwctx_init,
 	.hwctx_fini		= aie4_hwctx_fini,
 	.cmd_wait		= aie4_cmd_wait,
diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
index 6e9e7f874a44..063cedfe3c9d 100644
--- a/drivers/accel/amdxdna/aie4_pci.h
+++ b/drivers/accel/amdxdna/aie4_pci.h
@@ -14,6 +14,9 @@
 #include "aie4_msg_priv.h"
 #include "amdxdna_mailbox.h"
 
+/* Default context switch hysteresis timeout in microseconds. */
+#define AIE4_CTX_HYSTERESIS_US	1000
+
 struct cert_comp {
 	struct amdxdna_dev_hdl          *ndev;
 	u32                             msix_idx;
@@ -69,6 +72,12 @@ struct amdxdna_dev_hdl {
 
 	u8				pw_mode;
 
+	/*
+	 * Context switch hysteresis timeout in microseconds; pushed to the
+	 * firmware at hw start and tunable at runtime via debugfs.
+	 */
+	u32				ctx_switch_hysteresis_us;
+
 	struct amdxdna_drm_query_firmware_version cert_version;
 };
 
@@ -92,6 +101,9 @@ int aie4_init_dpm_freq_table(struct amdxdna_dev_hdl *ndev);
 int aie4_query_dpm_level(struct amdxdna_dev_hdl *ndev,
 			 u32 *aieclk_dpm_level, u32 *npuhclk_dpm_level);
 int aie4_msg_set_power_mode(struct amdxdna_dev_hdl *ndev, u8 power_mode);
+int aie4_set_runtime_cfg(struct amdxdna_dev_hdl *ndev, u32 type,
+			 const void *data, size_t size);
+int aie4_set_ctx_hysteresis(struct amdxdna_dev_hdl *ndev, u32 timeout_us);
 u32 aie4_msg_pasid(struct amdxdna_client *client);
 
 /* aie4_ctx.c */
diff --git a/drivers/accel/amdxdna/amdxdna_debugfs.c b/drivers/accel/amdxdna/amdxdna_debugfs.c
index a6ec17c63629..1f63cc91b168 100644
--- a/drivers/accel/amdxdna/amdxdna_debugfs.c
+++ b/drivers/accel/amdxdna/amdxdna_debugfs.c
@@ -126,4 +126,7 @@ void amdxdna_debugfs_init(struct amdxdna_dev *xdna)
 				    xdna,
 				    amdxdna_dbgfs_files[i].fops);
 	}
+
+	if (xdna->dev_info->ops->debugfs_init)
+		xdna->dev_info->ops->debugfs_init(xdna);
 }
diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h b/drivers/accel/amdxdna/amdxdna_pci_drv.h
index 953bf783b3f7..11f46ec738d7 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.h
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.h
@@ -54,6 +54,7 @@ struct amdxdna_sched_job;
 struct amdxdna_dev_ops {
 	int (*init)(struct amdxdna_dev *xdna);
 	void (*fini)(struct amdxdna_dev *xdna);
+	void (*debugfs_init)(struct amdxdna_dev *xdna);
 	int (*resume)(struct amdxdna_dev *xdna);
 	int (*suspend)(struct amdxdna_dev *xdna);
 	int (*sriov_configure)(struct amdxdna_dev *xdna, int num_vfs);
-- 
2.34.1

