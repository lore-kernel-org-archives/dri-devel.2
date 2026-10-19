Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6474606A331
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 16:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=4u80bVFi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C45010EF4C;
	Mon, 19 Oct 2026 16:48:44 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013032.outbound.protection.outlook.com
 [40.93.196.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7F5F10EF2B
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 16:48:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kUofeV+LxHEAYRC+lHCv1TLddmDHMG/gajzRr1rXLch/ApD7ryrKf+3UA9ms4C0tvSO1QT+TbSI7nFIDAxWO5FxFre5kO2mPaOZy3tpuXECdDWaJBNGqfrJMGRJM3UNWA/UBc/GTgF6GqevXALHMmXE1x0OgzaGEcy/VxBdUXZ9HUWc6oEsdSGCR3gfiKlpInU8oHiU/sbJWjaRPN7CkDcriDxAtIsVnuFh+g1H3pw0W3yPolncCZCeZQL4+ulRuvuYan7HWay4a2KFuXOoFMT3LKc42zb0CDyKj0uwVaK4ZvCTNIp2GjSEeI4YdmH4IOIeB1OK0F3+mMwhUXQd9mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgh3HJMsVd4MC86n/XTSzlPGP3bLhaL34JkJlkWNVbg=;
 b=OfaMmqGO5Zc88Bk4dbkGU7FeejbRgvcMW9kh+3m4FMoxfX+Muln7g5tmf09OecT5czdJ6B4KtWgUBtwe8z4dwXy1uuu48O9GVdbTFZ8O6cnfObDihV3rxEtu0eUyWYmQ/PjFtuZ4nn0ApIQZigBadMgLMnbfHShcbM/DBa6esHqZFhZBmahchKRkVbW+lIBC4crVO7pvEe0uoFZweRcfD3OTOuX2PX4iZQWtHI8pklNDG+SIhhnjFDa5Vkb48YWmw1DPgVVn1nqRvkTJUdqYcoXrVJldg/h5MXaZdTnQbZwrT/+ZQ2eBJUy7vW8EKq1oMf8LVr/Tf3w7SigytJpJpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgh3HJMsVd4MC86n/XTSzlPGP3bLhaL34JkJlkWNVbg=;
 b=4u80bVFigt9tyIabXTtsSpCCJKJQP+qIx36ErDO5U1IUl+jLKu3B84fW3vqqCzCP/fq9WxTCbduv0Xp77jPhxF4+dV8EH6IaGq54jlEKd/aDNkH0bWopE6JLU8xXbrwuh9+r7eSSR/CFp+Vk0VovQIhCAbG27SccRZx0nijpehw=
Received: from PH7P220CA0118.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::18)
 by PH7PR12MB5928.namprd12.prod.outlook.com (2603:10b6:510:1db::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 16:48:20 +0000
Received: from PH1PEPF00062F23.namprd02.prod.outlook.com
 (2603:10b6:510:32d:cafe::52) by PH7P220CA0118.outlook.office365.com
 (2603:10b6:510:32d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 19
 Oct 2026 16:48:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 PH1PEPF00062F23.mail.protection.outlook.com (10.167.243.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 16:48:20 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 11:47:58 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via
 Frontend Transport; Mon, 19 Oct 2026 11:47:57 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V5 19/19] accel/amdxdna: Implement runtime suspend and resume
 support
Date: Mon, 19 Oct 2026 09:47:46 -0700
Message-ID: <20261019164746.827277-20-yidong.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: PH1PEPF00062F23:EE_|PH7PR12MB5928:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bb87278-0c27-494c-2854-08df2e00c819
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|11063799006|4143699003|56012099006|261009221727099003|261009220027099003|261009223027099003|260925021911599003|261009221227099003|260925022911599003|261009223327099003|260925021311599003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: TGoZ9DRBlTpxP1X40sdhk5uKavv85Fj4YkVrGZneVPxS+0CPWvpjo7arQcffYV7fOTprgb9qMAOj78sn6IdCCzgXPN3kXvPjH1jto8KfSpocx+ky8DfLVK630mwyLZj4cG/XN1dBVQfHiR5ntmJQp1VVLFJBiQyqdU/Xh9CWOoGoY5cA9FpG/bqe1je6y1GS3RUlkeLj0OkJN0YkcsS2bd6AkheoLB4RAjhifd8ohCBiqKDn2n7YWpL8OYjtoShG3tflw/OLQHoPujlJYrFdHifB8hMvNNI/QwVMjGDDk2gnbxz6csUsl/ZReGc37ZRtniZkY0Cg/WomRs3qvw+7kSbwQ2s3GLZhRK0YYeaA0l/rEl4saCxz58+A9n9JK/a7sHbhNHUV3f0Adhz+mxSg4Xcjb6XG+GhAILyTqrHcQYI3mAg0hfNM9/+dnj/9KVNCmKzT3bJuk3Z5tMexGw8GnpIOCbwCBuT1cRDzUNPyu9u11Q9NHIC8UvMnJwPe2Yfqo0Q2ptSdM+e2aHJXPIqZbljBJnmrctnls9ID5oKI41+RylRYe/700U1mZGeATez7Zf7cLddOfn03Kihbi4XbWkF4NEX9lut93vpgTqhm/FlVKOP2eZUrnnWhARQL3OTENQEqdHAeOB4cUWmWtml0CDFXZ5KB2Tto7oMWsJQ7kHhpM2uMylKVbEmxZDVjrFteExldv0jUyQEIA7h/VeXEgg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(11063799006)(4143699003)(56012099006)(261009221727099003)(261009220027099003)(261009223027099003)(260925021911599003)(261009221227099003)(260925022911599003)(261009223327099003)(260925021311599003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: juilQ+uM+VhRi4eoQc7bXBETmHPAmpyhwq+/aakfwZ4ShEUTMYLsLuIQAg5DCbLx4RViBgkmFXQm5nEwi+GiP6GI1p5EdDNXxVN+TZ5j5W+w0zRq7n22S4KrleDOKtv+JHD+T43kUcd6s+q3U1AHTHbMu26Ybi+3COul22N9fHnVCixdZvgdazx9FjhsdtxeZezoh5U6Cx6rvgE4xeuUhRntFKxIFXJrhtIodTEHapbqIfApuMrkk67kgT0ORQ2FtX55coOEm3oIogCE60FnAlQ7c1y3q7lTTKWiTHvNS89+HzwXHOdafIWkRVJdAfwxaUAsftIX/S4PGDUxTzpd0bLZr9OvfMRhWaBvyX6qAQstVhy0ZWKGrBic47zilLdx+j1tsjqnovC07Kr1+dTCLQOc2mgpihnzR07Sj8hM+nxUQNecShlbRSueYmSGCO/E
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 16:48:20.0726 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bb87278-0c27-494c-2854-08df2e00c819
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH1PEPF00062F23.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5928
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

Add runtime suspend/resume for the AIE4 classic device by using its
system suspend/resume handlers.

Runtime suspend returns -EBUSY for a device without runtime_suspend,
so the PM core keeps it active instead of entering an error state.

A context suspended by runtime PM makes the command wait return
-EAGAIN. Resume the device in the wait ioctl and wait again, so a
command wait does not fail because of power management.

Take a runtime PM reference in aie4_get_info(), aie4_set_state() and
the context switch hysteresis debugfs write before sending mailbox
messages.

Wrap .driver.pm and the AIE4 PM callbacks with pm_ptr(), so they are
discarded when CONFIG_PM is disabled.

Signed-off-by: David Zhang <yidong.zhang@amd.com>
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie2_pci.c        |  2 ++
 drivers/accel/amdxdna/aie4_ctx.c        | 10 +++++-
 drivers/accel/amdxdna/aie4_pci.c        | 27 ++++++++++++++
 drivers/accel/amdxdna/amdxdna_ctx.c     | 47 ++++++++++++++++++-------
 drivers/accel/amdxdna/amdxdna_pci_drv.c |  4 +--
 drivers/accel/amdxdna/amdxdna_pci_drv.h |  2 ++
 drivers/accel/amdxdna/amdxdna_pm.c      | 26 ++++++++++++++
 drivers/accel/amdxdna/amdxdna_pm.h      |  2 ++
 8 files changed, 105 insertions(+), 15 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
index 690ad035463c..a3866e8933e6 100644
--- a/drivers/accel/amdxdna/aie2_pci.c
+++ b/drivers/accel/amdxdna/aie2_pci.c
@@ -1221,6 +1221,8 @@ const struct amdxdna_dev_ops aie2_ops = {
 	.fini = aie2_fini,
 	.resume = aie2_hw_resume,
 	.suspend = aie2_hw_suspend,
+	.runtime_resume = aie2_hw_resume,
+	.runtime_suspend = aie2_hw_suspend,
 	.get_aie_info = aie2_get_info,
 	.set_aie_state = aie2_set_state,
 	.hwctx_init = aie2_hwctx_init,
diff --git a/drivers/accel/amdxdna/aie4_ctx.c b/drivers/accel/amdxdna/aie4_ctx.c
index a2b6b0fa2934..a3f0a69b93b7 100644
--- a/drivers/accel/amdxdna/aie4_ctx.c
+++ b/drivers/accel/amdxdna/aie4_ctx.c
@@ -22,6 +22,7 @@
 #include "amdxdna_mailbox.h"
 #include "amdxdna_mailbox_helper.h"
 #include "amdxdna_pci_drv.h"
+#include "amdxdna_pm.h"
 
 #define CTX_INVALID_ID			(~0U)
 #define CTX_INVALID_DOORBELL		AMDXDNA_INVALID_DOORBELL_OFFSET
@@ -377,10 +378,14 @@ int aie4_hwctx_init(struct amdxdna_hwctx *hwctx)
 	if (ret)
 		goto destroy_lock;
 
-	ret = aie4_hwctx_create(hwctx);
+	ret = amdxdna_pm_resume_get_locked(xdna);
 	if (ret)
 		goto umq_fini;
 
+	ret = aie4_hwctx_create(hwctx);
+	if (ret)
+		goto suspend_put;
+
 	priv->job_work_q = alloc_ordered_workqueue("aie4_job_%d_%d", 0,
 						   client->pid, hwctx->fw_ctx_id);
 	if (!priv->job_work_q) {
@@ -388,12 +393,15 @@ int aie4_hwctx_init(struct amdxdna_hwctx *hwctx)
 		ret = -ENOMEM;
 		goto destroy_ctx;
 	}
+	amdxdna_pm_suspend_put(xdna);
 
 	XDNA_DBG(xdna, "hwctx %d.%d init completed", client->pid, hwctx->fw_ctx_id);
 	return 0;
 
 destroy_ctx:
 	aie4_hwctx_destroy(hwctx, AIE4_HWCTX_NORMAL);
+suspend_put:
+	amdxdna_pm_suspend_put(xdna);
 umq_fini:
 	aie4_hwctx_umq_fini(hwctx);
 destroy_lock:
diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
index 33f594835309..02dcb2f813d4 100644
--- a/drivers/accel/amdxdna/aie4_pci.c
+++ b/drivers/accel/amdxdna/aie4_pci.c
@@ -20,6 +20,7 @@
 #include "amdxdna_mailbox.h"
 #include "amdxdna_mailbox_helper.h"
 #include "amdxdna_pci_drv.h"
+#include "amdxdna_pm.h"
 
 #define NO_IOHUB		0
 #define PSP_NOTIFY_INTR		0xD007BE11
@@ -817,6 +818,10 @@ static int aie4_get_info(struct amdxdna_client *client, struct amdxdna_drm_get_i
 	if (!drm_dev_enter(&xdna->ddev, &idx))
 		return -ENODEV;
 
+	ret = amdxdna_pm_resume_get_locked(xdna);
+	if (ret)
+		goto dev_exit;
+
 	switch (args->param) {
 	case DRM_AMDXDNA_QUERY_AIE_METADATA:
 		ret = amdxdna_get_metadata(&ndev->aie, client, args);
@@ -841,8 +846,10 @@ static int aie4_get_info(struct amdxdna_client *client, struct amdxdna_drm_get_i
 		ret = -EOPNOTSUPP;
 	}
 
+	amdxdna_pm_suspend_put(xdna);
 	XDNA_DBG(xdna, "Got param %d", args->param);
 
+dev_exit:
 	drm_dev_exit(idx);
 	return ret;
 }
@@ -893,6 +900,10 @@ static int aie4_set_state(struct amdxdna_client *client,
 	if (!drm_dev_enter(&xdna->ddev, &idx))
 		return -ENODEV;
 
+	ret = amdxdna_pm_resume_get_locked(xdna);
+	if (ret)
+		goto dev_exit;
+
 	switch (args->param) {
 	case DRM_AMDXDNA_SET_POWER_MODE:
 		ret = aie4_set_power_mode(client, args);
@@ -903,6 +914,9 @@ static int aie4_set_state(struct amdxdna_client *client,
 		break;
 	}
 
+	amdxdna_pm_suspend_put(xdna);
+
+dev_exit:
 	drm_dev_exit(idx);
 	return ret;
 }
@@ -1031,6 +1045,7 @@ static int aie4_classic_init(struct amdxdna_dev *xdna)
 	if (ret)
 		goto free_work_buf;
 
+	amdxdna_pm_init(xdna);
 	return 0;
 
 free_work_buf:
@@ -1054,6 +1069,7 @@ static void aie4_vf_fini(struct amdxdna_dev *xdna)
 
 static void aie4_classic_fini(struct amdxdna_dev *xdna)
 {
+	amdxdna_pm_fini(xdna);
 	aie4_classic_hw_stop(xdna->dev_handle);
 	aie4_free_fw_log_buffer(xdna->dev_handle);
 	aie4_free_work_buffer(xdna->dev_handle);
@@ -1083,9 +1099,18 @@ static int aie4_ctx_hysteresis_set(void *data, u64 val)
 		return -ENODEV;
 
 	mutex_lock(&xdna->dev_lock);
+
+	ret = amdxdna_pm_resume_get_locked(xdna);
+	if (ret)
+		goto unlock;
+
 	ret = aie4_set_ctx_hysteresis(ndev, (u32)val);
 	if (!ret)
 		ndev->ctx_switch_hysteresis_us = (u32)val;
+
+	amdxdna_pm_suspend_put(xdna);
+
+unlock:
 	mutex_unlock(&xdna->dev_lock);
 	drm_dev_exit(idx);
 
@@ -1389,4 +1414,6 @@ const struct amdxdna_dev_ops aie4_classic_ops = {
 	.set_aie_state		= aie4_set_state,
 	.resume			= pm_ptr(aie4_classic_resume),
 	.suspend		= pm_ptr(aie4_classic_suspend),
+	.runtime_resume		= pm_ptr(aie4_classic_resume),
+	.runtime_suspend	= pm_ptr(aie4_classic_suspend),
 };
diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
index 608b86fe8f6b..f4004630dc1b 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.c
+++ b/drivers/accel/amdxdna/amdxdna_ctx.c
@@ -761,13 +761,32 @@ int amdxdna_drm_submit_cmd_ioctl(struct drm_device *dev, void *data, struct drm_
 	return -EINVAL;
 }
 
+static int amdxdna_hwctx_wait_cmd(struct amdxdna_client *client,
+				  struct amdxdna_drm_wait_cmd *args)
+{
+	struct amdxdna_dev *xdna = client->xdna;
+	struct amdxdna_hwctx *hwctx;
+	int ret, idx;
+
+	idx = srcu_read_lock(&client->hwctx_srcu);
+	hwctx = xa_load(&client->hwctx_xa, args->hwctx);
+	if (!hwctx) {
+		XDNA_DBG(xdna, "PID %d failed to get ctx %d", client->pid, args->hwctx);
+		ret = -EINVAL;
+	} else {
+		ret = xdna->dev_info->ops->cmd_wait(hwctx, args->seq, args->timeout);
+	}
+	srcu_read_unlock(&client->hwctx_srcu, idx);
+
+	return ret;
+}
+
 int amdxdna_drm_wait_cmd_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 {
 	struct amdxdna_client *client = filp->driver_priv;
 	struct amdxdna_dev *xdna = to_xdna_dev(dev);
 	struct amdxdna_drm_wait_cmd *args = data;
-	struct amdxdna_hwctx *hwctx;
-	int ret, idx;
+	int ret;
 
 	XDNA_DBG(xdna, "PID %d ctx %d timeout set %d ms for cmd %llu",
 		 client->pid, args->hwctx, args->timeout, args->seq);
@@ -775,22 +794,26 @@ int amdxdna_drm_wait_cmd_ioctl(struct drm_device *dev, void *data, struct drm_fi
 	if (!xdna->dev_info->ops->cmd_wait)
 		return -EOPNOTSUPP;
 
-	idx = srcu_read_lock(&client->hwctx_srcu);
-	hwctx = xa_load(&client->hwctx_xa, args->hwctx);
-	if (!hwctx) {
-		XDNA_DBG(xdna, "PID %d failed to get ctx %d", client->pid, args->hwctx);
-		ret = -EINVAL;
-		goto unlock_ctx_srcu;
+	ret = amdxdna_hwctx_wait_cmd(client, args);
+	if (ret == -EAGAIN) {
+		/*
+		 * Suspended by power management before the command completed.
+		 * Resume the device, which reconnects the context, and wait
+		 * again. Take the PM reference outside hwctx_srcu: runtime
+		 * resume takes dev_lock, which hwctx destroy holds across
+		 * synchronize_srcu().
+		 */
+		ret = amdxdna_pm_resume_get(xdna);
+		if (ret)
+			return ret;
+		ret = amdxdna_hwctx_wait_cmd(client, args);
+		amdxdna_pm_suspend_put(xdna);
 	}
 
-	ret = xdna->dev_info->ops->cmd_wait(hwctx, args->seq, args->timeout);
-
 	XDNA_DBG(xdna, "PID %d ctx %d cmd %lld wait finished, ret %d",
 		 client->pid, args->hwctx, args->seq, ret);
 
 	trace_amdxdna_debug_point(current->comm, args->seq, "job returned to user");
 
-unlock_ctx_srcu:
-	srcu_read_unlock(&client->hwctx_srcu, idx);
 	return ret;
 }
diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
index a8c29546d49c..edf807c93144 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
@@ -471,7 +471,7 @@ static void amdxdna_remove(struct pci_dev *pdev)
 
 static const struct dev_pm_ops amdxdna_pm_ops = {
 	SYSTEM_SLEEP_PM_OPS(amdxdna_pm_suspend, amdxdna_pm_resume)
-	RUNTIME_PM_OPS(amdxdna_pm_suspend, amdxdna_pm_resume, NULL)
+	RUNTIME_PM_OPS(amdxdna_pm_runtime_suspend, amdxdna_pm_runtime_resume, NULL)
 };
 
 static int amdxdna_sriov_configure(struct pci_dev *pdev, int num_vfs)
@@ -490,7 +490,7 @@ static struct pci_driver amdxdna_pci_driver = {
 	.id_table = pci_ids,
 	.probe = amdxdna_probe,
 	.remove = amdxdna_remove,
-	.driver.pm = &amdxdna_pm_ops,
+	.driver.pm = pm_ptr(&amdxdna_pm_ops),
 	.sriov_configure = amdxdna_sriov_configure,
 };
 
diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h b/drivers/accel/amdxdna/amdxdna_pci_drv.h
index 815977560440..27593190dcf6 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.h
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.h
@@ -57,6 +57,8 @@ struct amdxdna_dev_ops {
 	void (*debugfs_init)(struct amdxdna_dev *xdna);
 	int (*resume)(struct amdxdna_dev *xdna);
 	int (*suspend)(struct amdxdna_dev *xdna);
+	int (*runtime_resume)(struct amdxdna_dev *xdna);
+	int (*runtime_suspend)(struct amdxdna_dev *xdna);
 	int (*sriov_configure)(struct amdxdna_dev *xdna, int num_vfs);
 	int (*hwctx_init)(struct amdxdna_hwctx *hwctx);
 	void (*hwctx_stop)(struct amdxdna_hwctx *hwctx);
diff --git a/drivers/accel/amdxdna/amdxdna_pm.c b/drivers/accel/amdxdna/amdxdna_pm.c
index b1fafddd7ad5..9503693102dc 100644
--- a/drivers/accel/amdxdna/amdxdna_pm.c
+++ b/drivers/accel/amdxdna/amdxdna_pm.c
@@ -37,6 +37,32 @@ int amdxdna_pm_resume(struct device *dev)
 	return ret;
 }
 
+int amdxdna_pm_runtime_suspend(struct device *dev)
+{
+	struct amdxdna_dev *xdna = to_xdna_dev(dev_get_drvdata(dev));
+	int ret = -EBUSY;
+
+	guard(mutex)(&xdna->dev_lock);
+	if (xdna->dev_info->ops->runtime_suspend)
+		ret = xdna->dev_info->ops->runtime_suspend(xdna);
+
+	XDNA_DBG(xdna, "Runtime suspend done ret %d", ret);
+	return ret;
+}
+
+int amdxdna_pm_runtime_resume(struct device *dev)
+{
+	struct amdxdna_dev *xdna = to_xdna_dev(dev_get_drvdata(dev));
+	int ret = -EOPNOTSUPP;
+
+	guard(mutex)(&xdna->dev_lock);
+	if (xdna->dev_info->ops->runtime_resume)
+		ret = xdna->dev_info->ops->runtime_resume(xdna);
+
+	XDNA_DBG(xdna, "Runtime resume done ret %d", ret);
+	return ret;
+}
+
 int amdxdna_pm_resume_get(struct amdxdna_dev *xdna)
 {
 	struct device *dev = xdna->ddev.dev;
diff --git a/drivers/accel/amdxdna/amdxdna_pm.h b/drivers/accel/amdxdna/amdxdna_pm.h
index 3d26b973e0e3..02beef6448f1 100644
--- a/drivers/accel/amdxdna/amdxdna_pm.h
+++ b/drivers/accel/amdxdna/amdxdna_pm.h
@@ -10,6 +10,8 @@
 
 int amdxdna_pm_suspend(struct device *dev);
 int amdxdna_pm_resume(struct device  *dev);
+int amdxdna_pm_runtime_suspend(struct device *dev);
+int amdxdna_pm_runtime_resume(struct device *dev);
 int amdxdna_pm_resume_get(struct amdxdna_dev *xdna);
 void amdxdna_pm_suspend_put(struct amdxdna_dev *xdna);
 void amdxdna_pm_init(struct amdxdna_dev *xdna);
-- 
2.34.1

