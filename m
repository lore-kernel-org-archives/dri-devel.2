Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B8ACA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 22:54:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6C371122F7;
	Fri,  9 Oct 2026 22:54:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AeeQ9M5i";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011062.outbound.protection.outlook.com [52.101.57.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9E2C10EB5C
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 22:54:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iPoKCrPZspf+VJGR8ISqnfY9m+8hRicdhy35wDMc0Xcdc5V9+YDz+QGEuTfcEReAc0jwj/ds0CxA36lDN86kyyfUeXEXVh5VaFB3GQyM8QsHV7va2GOddPaIOKsHVumfK8TFzFl6Tj0M9AW8qPtzdQqHtRzEsu4Vto0TZIkkoYnlCQUh7cvnmPaYPBkufcBp1NooAN85DAYkYU03dh55ufGHi3G8IotHxV76lO7CKvle3H21Kh+/CjL9kPt1Gz4ASvtSWMFH+DdHUnzKMVevsLnDFanbKBOU5BTm2lnBYrk9JVjPNpcA5McpZWdPvNOiRJv0TPrIIjMLBnUku8oEfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lA70idRhRnfuNJCx0x4FJ8Wus2h/NBLohrVRzXFmTvs=;
 b=Y9VnieM6dELUo56+sfziBBqCjK2MyWGSKMJk7wFtawIMMufQ5/fa53/aZsIm0ASGSsb13XeUn/SggexIV2T1dasLOFJPLxHNvUYpqWwkQ3tkiO5eWzgz7Y+T8pnKdaD8rBiZknEGfteMS8rRYF889U74vJkxote0ICyqDgmoaa5EbeeSYL6DBOOKCqPYBQm7I3r3Kz31OYuB9Pfw/yLIGzFVefh+wu0xgwdCa6PC94rnhMmfUUNldBUErP3G+tXqCN8/5cH781DI5Lb1qSkXXeHmXG3lKbi5tZYPCkpLqYUyH75DHkdD+uZzXaudaRyCuDSgRV5ABwiL/pCUm8a3mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lA70idRhRnfuNJCx0x4FJ8Wus2h/NBLohrVRzXFmTvs=;
 b=AeeQ9M5iuLZXT0BydofhjQALhFSAJII4pCekBO4DgGYCFmTMNFoSBFOG+CP2MUaG2/W04J3/7sObF96BD+yh3B/mv6FTW/xcPN8XW4jvpGLKVlw/Lq5gvqFrLaL54M9QJ8ULIbL/vjp1WF4FrsPZoq1ZD4TH7BturRZjWVGRr3k=
Received: from BL1P222CA0011.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::16)
 by DM4PR12MB5771.namprd12.prod.outlook.com (2603:10b6:8:62::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.35; Fri, 9 Oct
 2026 22:53:57 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:208:2c7:cafe::37) by BL1P222CA0011.outlook.office365.com
 (2603:10b6:208:2c7::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 9
 Oct 2026 22:53:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.0 via Frontend Transport; Fri, 9 Oct 2026 22:53:56 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 17:53:51 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 17:53:51 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Fri, 9 Oct 2026 17:53:50 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>, Nishad Saraf <nishads@amd.com>
Subject: [PATCH V4 09/19] accel/amdxdna: Add context switch hysteresis with
 debugfs control
Date: Fri, 9 Oct 2026 15:53:33 -0700
Message-ID: <20261009225343.3079074-10-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261009225343.3079074-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261009225343.3079074-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|DM4PR12MB5771:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a5879fa-809a-4f12-6048-08df26583336
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|10067099003|6133799003|18002099003|22082099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: BTMGBJ8BM857SXTFEI09R7xzBpbs6qDpoKT9u3Uesi5+PHFFFTnvcxgEGU/IPbs0P7qGEynchIexJJ1ShR2DZd3UCxIire0LXim+eANNzhQB/vJ9VT1F+y254AHOdXAcEr3TT6ueMMCuzAiccQvJSWdHgGkRHdEn08Z6pT8+NhIxPrXUyWfcXiLzsuMwxIRiuluZQg0jAYPLXXGbvXSaqR3VVZFmlrsyj7ZnwMVYxwZGxJrioMVTu5OQ/Q//pLbajUv8KKgwBLXH9MfiX+08rXmuwCoetDkjuA1T6C7AlZBTHhrQefZJGuHayTuzJWdBMKbaDOlsBSnnpmLhogyCqXSmamtO1Rg7RvnAWueS09WyZKwm/Qu9lPyDgVaAkzz8gU3YvOaIHG7X6wBSo3X/x/qUU162VKJHrH/uQ4ScMnBSQcNfRyknkI7ZbJwjBIVd2EWNrea3e0/ThQsZ5SQNcc9xlObiJzvGl7LTc+5teZJEvl1ahhLt4TJ8Q9WrTZwMLiTiNfRtHa507eaaqiTcVwzVNro4oofpCn0lQsve7JpavN+7QlkEJSUqp8cysw2aiWTelmNrlZYDbgJ1XYP09Mkz4ol3hrrAeYqZ/XOMA8IfvXQCbR8DjuLwYqoEaZxsNoQtyg/KEKHfZyct4rppGoFpJizx2E0X0FTdBu57Gko=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(10067099003)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zJgUzgZCMkswvRE/djJBDmjK7PklohK+hQJb3DASiPukTdRkv6hiH1m3VrWGeHoUBcIUNd9eQvd+ofpTm040POqanQESEnjRsOtuJk/+W/Y0d4WTLk1DvXXolXaO/qjiCrcOOaPwWpLnGYSSzeTd+H/9n7ICo3B6CxxVtLLi14/sVUl0HaubdXS9+cvg+pipL8QpST67eYNjiH08AMV5I1+FXcJI4dQXbapauT+PQWIwfYC3XRQieD5OtrT7gkmonXkcVfhh0yHluCZb7fWtZ9ifMaGeyy6G/O5g7devCHsN95KJsUyj/tq/7gg3VdVEoc4sLH1gGsjZnUGVrUeFSpbn1AapRncwhFwSHzrSHZlCE0gzYmthLgNQtBSIlFLqIX7d2mi7zcqWpzrxhCO0h6h0f+dV9XNfDcP0lGVVfBweurjDzKxFunvtyrskzowL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 22:53:56.7639 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a5879fa-809a-4f12-6048-08df26583336
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5771
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
 drivers/accel/amdxdna/aie4_message.c    | 43 +++++++++++++
 drivers/accel/amdxdna/aie4_msg_priv.h   | 24 +++++++
 drivers/accel/amdxdna/aie4_pci.c        | 83 ++++++++++++++++++++++++-
 drivers/accel/amdxdna/aie4_pci.h        |  9 +++
 drivers/accel/amdxdna/amdxdna_debugfs.c |  3 +
 drivers/accel/amdxdna/amdxdna_pci_drv.h |  1 +
 6 files changed, 161 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/amdxdna/aie4_message.c b/drivers/accel/amdxdna/aie4_message.c
index 263e23aff69f..2820cfb6f9ed 100644
--- a/drivers/accel/amdxdna/aie4_message.c
+++ b/drivers/accel/amdxdna/aie4_message.c
@@ -263,3 +263,46 @@ int aie4_msg_set_power_mode(struct amdxdna_dev_hdl *ndev, u8 power_mode)
 
 	return ret;
 }
+
+int aie4_set_runtime_cfg(struct amdxdna_dev_hdl *ndev, u32 type,
+			 const void *data, size_t size)
+{
+	DECLARE_AIE_MSG(aie4_msg_set_runtime_cfg, AIE4_MSG_OP_SET_RUNTIME_CONFIG);
+	u8 buf[sizeof(req.type) + AIE4_RUNTIME_CFG_MAX_DATA_SIZE] __aligned(4) = { 0 };
+	int ret;
+
+	if (size > AIE4_RUNTIME_CFG_MAX_DATA_SIZE)
+		return -EINVAL;
+
+	/* Stage runtime config type and payload for firmware mailbox message. */
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
index fe78df9e23c8..636bf8d04c76 100644
--- a/drivers/accel/amdxdna/aie4_msg_priv.h
+++ b/drivers/accel/amdxdna/aie4_msg_priv.h
@@ -12,6 +12,7 @@
 enum aie4_msg_opcode {
 	AIE4_MSG_OP_IDENTIFY                         = 0x10002,
 	AIE4_MSG_OP_SUSPEND                          = 0x10003,
+	AIE4_MSG_OP_SET_RUNTIME_CONFIG               = 0x10007,
 	AIE4_MSG_OP_QUERY_CERT_FIRMWARE_VERSION      = 0x1000F,
 
 	AIE4_MSG_OP_CREATE_VFS                       = 0x20001,
@@ -65,6 +66,29 @@ struct aie4_msg_suspend_resp {
 	enum aie4_msg_status status;
 } __packed;
 
+/* Type selector for AIE4_MSG_OP_SET_RUNTIME_CONFIG. */
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
+/* Maximum payload for runtime config firmware message. */
+#define AIE4_RUNTIME_CFG_MAX_DATA_SIZE 16
+
+/* Context switch hysteresis timeout in microseconds (0 disables). */
+struct aie4_msg_runtime_config_ctx_switch_hysteresis {
+	__u32 timeout_us;
+} __packed;
+
 struct aie4_msg_create_vfs_req {
 	__u32 vf_cnt;
 } __packed;
diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
index 5593dfb6c7ed..446ab2f47c7d 100644
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
 
@@ -322,6 +324,22 @@ int aie4_restore_power_mode(struct amdxdna_dev_hdl *ndev)
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
+	ret = aie4_set_ctx_hysteresis(ndev, ndev->ctx_switch_hysteresis_us);
+	if (ret == -ETIME)
+		return ret;
+
+	return 0;
+}
+
 static int aie4_pf_hw_start(struct amdxdna_dev_hdl *ndev)
 {
 	int ret;
@@ -334,7 +352,7 @@ static int aie4_pf_hw_start(struct amdxdna_dev_hdl *ndev)
 	if (ret)
 		goto stop_fw;
 
-	ret = aie4_attach_work_buffer(ndev);
+	ret = aie4_config_fw(ndev);
 	if (ret)
 		goto mbox_fini;
 
@@ -418,7 +436,7 @@ static int aie4_classic_hw_start(struct amdxdna_dev_hdl *ndev)
 	if (ret)
 		goto mailbox_fini;
 
-	ret = aie4_attach_work_buffer(ndev);
+	ret = aie4_config_fw(ndev);
 	if (ret)
 		goto mailbox_fini;
 
@@ -573,6 +591,7 @@ static int aie4m_pcidev_init(struct amdxdna_dev *xdna)
 
 	ndev->priv = xdna->dev_info->dev_priv;
 	ndev->aie.xdna = xdna;
+	ndev->ctx_switch_hysteresis_us = AIE4_CTX_HYSTERESIS_US;
 	ndev->pw_mode = POWER_MODE_DEFAULT;
 	xdna->dev_handle = ndev;
 
@@ -918,15 +937,74 @@ static void aie4_classic_fini(struct amdxdna_dev *xdna)
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
+	/* Context switch hysteresis is only supported on PF and classic devices. */
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
@@ -937,6 +1015,7 @@ const struct amdxdna_dev_ops aie4_vf_ops = {
 const struct amdxdna_dev_ops aie4_classic_ops = {
 	.init			= aie4_classic_init,
 	.fini			= aie4_classic_fini,
+	.debugfs_init		= aie4_debugfs_init,
 	.hwctx_init		= aie4_hwctx_init,
 	.hwctx_fini		= aie4_hwctx_fini,
 	.cmd_wait		= aie4_cmd_wait,
diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
index 6e9e7f874a44..959ef3695813 100644
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
@@ -69,6 +72,9 @@ struct amdxdna_dev_hdl {
 
 	u8				pw_mode;
 
+	/* Context switch hysteresis timeout in microseconds. */
+	u32				ctx_switch_hysteresis_us;
+
 	struct amdxdna_drm_query_firmware_version cert_version;
 };
 
@@ -92,6 +98,9 @@ int aie4_init_dpm_freq_table(struct amdxdna_dev_hdl *ndev);
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

