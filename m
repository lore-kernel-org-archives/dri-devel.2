Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AEE7CA9EBB
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 22:54:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87E03112310;
	Fri,  9 Oct 2026 22:54:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sX6dsJzi";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012042.outbound.protection.outlook.com [40.107.209.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9F0A112308
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 22:54:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GFjzqjjxmRqtOJEcPgoJW+u7Is8kYI8fQYwG8GwjCmH52hCngWobfs+eFfNLK3dbniDpyBjoxAqUlh3VCrggc4t1f472YCj3bD3XwOkGLSY+FJgIRKQyRYZPmfw4R9PHuVuvEadVPGKVK6p14590DhQ26IWmaGZleMCfaiXwhoCHPWkBDSjbpf2aCWQZaVy9g6LmL3P1Httezy5ccT4P68LOz3i/WqPe+sW9D5GAzWWRQNuAtj9y++0vCePLHijF2OUTmNKRCBJtRApsvNNkzGTA+2AZZLtPbOhXW5nisWRt6AOGJeq4/AbuYAjGXPexq9c3qTTNIPJZKZYTYb1CDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbiFTPbzkpKuCtLcad/GAm+YO0agF6ENpUaec6C9cgQ=;
 b=Cgl2AFv4oAp17lUNQW4HOdjoOBifwD2n1p69do58A6aaPM7DCmq7w1qNx+Lg2j6tNaW+e32hUlDqOCM0bH/ZATT0PbRs2rXj95WQ1EaOLAveckWQ9hIVH2Zg2XiWpj51v7aUtE/Zr65GeRHeSMn5buL2GnQwQv5e2kLl5ml86e252mjOcSLdKbpf9VHHyO8RhyCBhmXzU966JH7Gc4AneXud2UJhsI4wKTZrWX+t6druqJFXSBuUKaremCpBqrZFYdtsmQX8D9+MNOYePQ/0YgEw5/7Mf3i5t31RG1TsYSdQX7cWXpN0a2741yJx3zkLFVxV1CMf8bSny+ka3/cdQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbiFTPbzkpKuCtLcad/GAm+YO0agF6ENpUaec6C9cgQ=;
 b=sX6dsJzivC0Tu5JmIkb9DrSdYld21vTHHaSIx3psTATXgRPz130N+WV6Ss98NApKVOR3MKkkz6QhTi10PYma70zkyUloBOPE3+PgbQMXwbC+5HIk/Ux6RjSAoSOFzWu+DtA2XYe93mfaiRSD9o8X92ZrZd9eTPa2FMcUlRO96wo=
Received: from BN9PR03CA0440.namprd03.prod.outlook.com (2603:10b6:408:113::25)
 by DS5PPFBABE93B01.namprd12.prod.outlook.com (2603:10b6:f:fc00::65f)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 22:54:07 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:408:113:cafe::6c) by BN9PR03CA0440.outlook.office365.com
 (2603:10b6:408:113::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 9
 Oct 2026 22:54:07 +0000
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
 15.21.546.0 via Frontend Transport; Fri, 9 Oct 2026 22:54:07 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 17:54:01 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 17:54:00 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Fri, 9 Oct 2026 17:54:00 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V4 18/19] accel/amdxdna: Implement AIE4 suspend and resume
Date: Fri, 9 Oct 2026 15:53:42 -0700
Message-ID: <20261009225343.3079074-19-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261009225343.3079074-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261009225343.3079074-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|DS5PPFBABE93B01:EE_
X-MS-Office365-Filtering-Correlation-Id: 78a32e3e-1ca2-484c-8b52-08df265839a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|10067099003|56012099006|11063799006|22082099003|6133799003|4143699003|18002099003;
X-Microsoft-Antispam-Message-Info: 1yqC8uwdlY7uKZ8RYOgsJK01znaXIgoZegc75coXIYpY7E/VCVQCZeJhfNIfsViRyAg8lkRWJEpivA0LxU1tWTrjUpdDbnpElb9GGcSBWjAjX2R4Y7dsi/CRTJP0VpakIawWr3ZaJ6NPO6MF5fhkxmrXgN4y5D5soehb7mOl+YeP9qsVL8nnGm/kGSSEYHkrjBXZ1URU9WE9khbYNp0F9jGb+Stpe00fSKP9bfCq0sKMesE//+sPS2geGCLhw2rH5tP+cC+leXetEQ0iBW332Sh09ALukZl7XWL329e+M04Em6xiBW83mlQUgjAFPltWSXd33MXJ9HUr0ClzqPh1dZOjCOTKJcJ8asyCNeRzETMrmeHvTLFYbwCc4w6QKIUtnnKB7S84PEVawFgwYAGbSDUdhSS73knesh7ZpOO6AZhmHqgXF/B/PPD8VTEqnGfViAdQF35KvAvlqAMTiJ3+uZ2iRrVRy8lRWQ2c6GeedbpHFrQa/9tqILEkT/7733Kq9vJBJOp9sBTyn1FCPEEdEJhM4NRHZPTUOSWcfP5VdVYYdT09nhc4cL5smvx2KbeD+jMfLKTos9v5GmBvozGXP3e8RzhDf9/3sLHA5Ekm4HdlGMqEGbpBOrV6PqXF2XRMwZRhZ2h4klk1ld//nOGQb6tQ3awbD6FUqGU3pc1iFS8qLLZ4LfXX/gJ3HSIjXkfvEDT6s0CO5rdgmXJEOm6uoQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(10067099003)(56012099006)(11063799006)(22082099003)(6133799003)(4143699003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3NaJck1ySVk5ycGJwi0k0ERDurkap3yWiTgASi/+8+UNqYTh9HTQZMFRZZVeBK0UPglMEAH93bJEPqAND95Dc11ELlf5CS7MqmRXOQwz6/VNIbxHj/G2c8EivK5XGqVdIZngnPDAwtdO9mmkRU6iV6Ld3qZrKGmOVBkq8IfxQMvHpY9CV0Y5AU+R5fYqBVWzMVb2dN+Ch2FWh5IE1XQdzcuy7Zsy8/LOm25JqXac58ha5gSOoKi5JpY96doO4PFZCntYK0FZJ1U045MJ3ohFeyzdw897ACwB+w4iF7Fvu7xHfpkvuPudCda8PLGL4mQ5/dL0cUCYc1yL16JBSyXzYaxO8DQw53nvH3tIl2MHA1vOY18aevRjRfaFs8UBk7oDPNUMa4vYKVjvwv2DxIhClm1CNTU+kfysbkiLvzGN3jGYR0sZGc9yeA627+sXPiJT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 22:54:07.5630 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a32e3e-1ca2-484c-8b52-08df265839a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFBABE93B01
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

Implement suspend and resume callbacks for AIE4 Physical Function (PF),
Virtual Function (VF), and Classic device types:
- Implement aie4_hwctx_suspend_all() to destroy or drain contexts across
  all registered clients and wait for in-flight jobs.
- Implement aie4_hwctx_resume_all() to recreate firmware contexts and
  kick doorbells via aie4_hwctx_resume_jobs() to resume hardware queue
  consumption.
- Guard firmware destroy message in aie4_hwctx_destroy() when context
  ID is invalid.
- Restore SR-IOV virtual functions on PF resume via aie4_restore_sriov().
- Link each VF to the PF with a stateless device link when SR-IOV is
  enabled, so system suspend handles VFs before the PF and resume
  handles the PF before VFs. The link survives VF driver rebind and is
  removed before SR-IOV is disabled.

Signed-off-by: David Zhang <yidong.zhang@amd.com>
---
 drivers/accel/amdxdna/aie4_ctx.c        |  18 +-
 drivers/accel/amdxdna/aie4_pci.c        | 251 ++++++++++++++++++++++++
 drivers/accel/amdxdna/aie4_pci.h        |  11 ++
 drivers/accel/amdxdna/aie4_sriov.c      |  66 ++++++-
 drivers/accel/amdxdna/amdxdna_pci_drv.h |   3 +
 5 files changed, 347 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/amdxdna/aie4_ctx.c b/drivers/accel/amdxdna/aie4_ctx.c
index 43d26454be6c..a2b6b0fa2934 100644
--- a/drivers/accel/amdxdna/aie4_ctx.c
+++ b/drivers/accel/amdxdna/aie4_ctx.c
@@ -255,7 +255,7 @@ void aie4_hwctx_destroy(struct amdxdna_hwctx *hwctx, enum aie4_hwctx_flags flags
 	if (has_error)
 		wake_up_all(&priv->job_list_wq);
 
-	if (flags != AIE4_HWCTX_DISCONNECT)
+	if (flags != AIE4_HWCTX_DISCONNECT && priv->hw_ctx_id != CTX_INVALID_ID)
 		aie4_msg_destroy_context(ndev, priv->hw_ctx_id);
 
 	if (cert_comp)
@@ -363,6 +363,7 @@ int aie4_hwctx_init(struct amdxdna_hwctx *hwctx)
 		return -ENOMEM;
 	hwctx->priv = priv;
 	priv->hwctx = hwctx;
+	priv->hw_ctx_id = CTX_INVALID_ID;
 
 	/* Initialize io_lock guarding cert_comp binding. */
 	mutex_init(&priv->io_lock);
@@ -951,6 +952,21 @@ int aie4_hwctx_wait_for_running(struct amdxdna_hwctx *hwctx)
 	return ret;
 }
 
+void aie4_hwctx_resume_jobs(struct amdxdna_hwctx *hwctx)
+{
+	struct amdxdna_hwctx_priv *priv = hwctx->priv;
+
+	mutex_lock(&priv->io_lock);
+	if (list_empty(&priv->running_job_list)) {
+		mutex_unlock(&priv->io_lock);
+		return;
+	}
+	aie4_doorbell_ring(hwctx);
+	mutex_unlock(&priv->io_lock);
+
+	queue_work(priv->job_work_q, &priv->job_work);
+}
+
 static void put_cmd_bos(struct amdxdna_sched_job *job)
 {
 	u32 i;
diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
index e09d24d85cdf..70a052ab5f77 100644
--- a/drivers/accel/amdxdna/aie4_pci.c
+++ b/drivers/accel/amdxdna/aie4_pci.c
@@ -1126,11 +1126,258 @@ static void aie4_debugfs_init(struct amdxdna_dev *xdna)
 					   &aie4_ctx_hysteresis_fops);
 }
 
+void aie4_hwctx_suspend_all(struct amdxdna_dev_hdl *ndev, int clean_jobs)
+{
+	struct amdxdna_dev *xdna = ndev->aie.xdna;
+	struct amdxdna_client *client;
+	struct amdxdna_hwctx *hwctx;
+	unsigned long hwctx_id;
+	int idx;
+
+	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
+
+	amdxdna_for_each_client(xdna, client) {
+		idx = srcu_read_lock(&client->hwctx_srcu);
+		amdxdna_for_each_hwctx(client, hwctx_id, hwctx) {
+			/* clean up workers and drain running jobs */
+			if (clean_jobs) {
+				int ret;
+
+				aie4_hwctx_destroy(hwctx, AIE4_HWCTX_ERROR);
+				ret = aie4_hwctx_wait_for_running(hwctx);
+				if (ret)
+					XDNA_WARN(xdna, "hwctx %s wait for running failed %d",
+						  hwctx->name, ret);
+			} else {
+				aie4_hwctx_destroy(hwctx, AIE4_HWCTX_NORMAL);
+			}
+		}
+		srcu_read_unlock(&client->hwctx_srcu, idx);
+	}
+
+	XDNA_DBG(xdna, "Finished hwctx suspend");
+}
+
+int aie4_hwctx_resume_all(struct amdxdna_dev_hdl *ndev)
+{
+	struct amdxdna_dev *xdna = ndev->aie.xdna;
+	struct amdxdna_client *client;
+	struct amdxdna_hwctx *hwctx;
+	unsigned long hwctx_id;
+	int ret, idx;
+
+	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
+
+	amdxdna_for_each_client(xdna, client) {
+		idx = srcu_read_lock(&client->hwctx_srcu);
+		amdxdna_for_each_hwctx(client, hwctx_id, hwctx) {
+			ret = aie4_hwctx_create(hwctx);
+			if (ret)
+				goto error;
+			aie4_hwctx_resume_jobs(hwctx);
+		}
+		srcu_read_unlock(&client->hwctx_srcu, idx);
+	}
+
+	XDNA_DBG(xdna, "Finished hwctx resume");
+	return 0;
+error:
+	srcu_read_unlock(&client->hwctx_srcu, idx);
+	XDNA_DBG(xdna, "Failed hwctx resume");
+	return ret;
+}
+
+static int aie4_restore_sriov(struct amdxdna_dev_hdl *ndev)
+{
+	struct amdxdna_dev *xdna = ndev->aie.xdna;
+	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
+	int ret;
+
+	if (ndev->num_vfs) {
+		if (pci_num_vf(pdev) != ndev->num_vfs) {
+			XDNA_ERR(xdna, "inconsistent vf number");
+			return -EINVAL;
+		}
+		ret = aie4_create_vfs(ndev, ndev->num_vfs);
+		if (ret) {
+			XDNA_ERR(xdna, "create vfs failed, %d", ret);
+			return ret;
+		}
+		XDNA_DBG(xdna, "restored num_vfs %d", ndev->num_vfs);
+	}
+
+	return 0;
+}
+
+static int aie4_pf_suspend(struct amdxdna_dev *xdna)
+{
+	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
+	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
+
+	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
+	aie4_pf_hw_stop(ndev);
+	pci_disable_device(pdev);
+
+	XDNA_DBG(xdna, "pf suspend done");
+	return 0;
+}
+
+static int aie4_pf_resume(struct amdxdna_dev *xdna)
+{
+	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
+	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
+	int ret;
+
+	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
+
+	ret = pci_enable_device(pdev);
+	if (ret) {
+		XDNA_ERR(xdna, "enable pci device failed %d", ret);
+		return ret;
+	}
+	pci_set_master(pdev);
+
+	ret = aie4_pf_hw_start(ndev);
+	if (ret) {
+		XDNA_ERR(xdna, "hw_start failed %d", ret);
+		goto pci_disable;
+	}
+
+	ret = aie4_restore_sriov(ndev);
+	if (ret)
+		goto hw_stop;
+
+	XDNA_DBG(xdna, "pf resume done");
+	return 0;
+hw_stop:
+	aie4_pf_hw_stop(ndev);
+pci_disable:
+	pci_disable_device(pdev);
+	return ret;
+}
+
+static int aie4_vf_suspend(struct amdxdna_dev *xdna)
+{
+	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
+	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
+
+	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
+	aie4_hwctx_suspend_all(ndev, false);
+	/*
+	 * partition_fini and mailbox messages should not be called here
+	 * because PF suspend will do the cleanup for all VFs.
+	 */
+	aie4_mailbox_fini(ndev);
+	pci_disable_device(pdev);
+
+	XDNA_DBG(xdna, "vf suspend done");
+	return 0;
+}
+
+static int aie4_vf_resume(struct amdxdna_dev *xdna)
+{
+	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
+	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
+	int ret;
+
+	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
+
+	ret = pci_enable_device(pdev);
+	if (ret) {
+		XDNA_ERR(xdna, "enable pci device failed %d", ret);
+		/* Contexts cannot reconnect; fail waiters and abort running jobs. */
+		aie4_hwctx_suspend_all(ndev, true);
+		return ret;
+	}
+	pci_set_master(pdev);
+
+	ret = aie4_vf_hw_start(ndev);
+	if (ret) {
+		XDNA_ERR(xdna, "hw_start failed %d", ret);
+		/* Contexts cannot reconnect; fail waiters and abort running jobs. */
+		aie4_hwctx_suspend_all(ndev, true);
+		goto pci_disable;
+	}
+
+	ret = aie4_hwctx_resume_all(ndev);
+	if (ret) {
+		XDNA_ERR(xdna, "hwctx_resume failed %d", ret);
+		goto hw_clear;
+	}
+
+	XDNA_DBG(xdna, "vf resume done");
+	return 0;
+
+hw_clear:
+	aie4_hwctx_suspend_all(ndev, true);
+	aie4_vf_hw_stop(ndev);
+pci_disable:
+	pci_disable_device(pdev);
+	return ret;
+}
+
+static int aie4_classic_suspend(struct amdxdna_dev *xdna)
+{
+	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
+	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
+
+	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
+	aie4_hwctx_suspend_all(ndev, false);
+	aie4_classic_hw_stop(ndev);
+	pci_disable_device(pdev);
+
+	XDNA_DBG(xdna, "classic suspend done");
+	return 0;
+}
+
+static int aie4_classic_resume(struct amdxdna_dev *xdna)
+{
+	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
+	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
+	int ret;
+
+	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
+
+	ret = pci_enable_device(pdev);
+	if (ret) {
+		XDNA_ERR(xdna, "enable pci device failed %d", ret);
+		/* Contexts cannot reconnect; fail waiters and abort running jobs. */
+		aie4_hwctx_suspend_all(ndev, true);
+		return ret;
+	}
+	pci_set_master(pdev);
+
+	ret = aie4_classic_hw_start(ndev);
+	if (ret) {
+		XDNA_ERR(xdna, "hw_start failed %d", ret);
+		/* Contexts cannot reconnect; fail waiters and abort running jobs. */
+		aie4_hwctx_suspend_all(ndev, true);
+		goto pci_disable;
+	}
+
+	ret = aie4_hwctx_resume_all(ndev);
+	if (ret) {
+		XDNA_ERR(xdna, "hwctx_resume failed %d", ret);
+		goto hw_clear;
+	}
+
+	XDNA_DBG(xdna, "classic resume done");
+	return 0;
+hw_clear:
+	aie4_hwctx_suspend_all(ndev, true);
+	aie4_classic_hw_stop(ndev);
+pci_disable:
+	pci_disable_device(pdev);
+	return ret;
+}
+
 const struct amdxdna_dev_ops aie4_pf_ops = {
 	.init			= aie4_pf_init,
 	.fini			= aie4_pf_fini,
 	.debugfs_init		= aie4_debugfs_init,
 	.sriov_configure        = aie4_sriov_configure,
+	.resume			= pm_ptr(aie4_pf_resume),
+	.suspend		= pm_ptr(aie4_pf_suspend),
 };
 
 const struct amdxdna_dev_ops aie4_vf_ops = {
@@ -1144,6 +1391,8 @@ const struct amdxdna_dev_ops aie4_vf_ops = {
 	.cmd_wait		= aie4_cmd_wait,
 	.get_aie_info		= aie4_get_info,
 	.set_aie_state		= aie4_set_state,
+	.resume			= pm_ptr(aie4_vf_resume),
+	.suspend		= pm_ptr(aie4_vf_suspend),
 };
 
 const struct amdxdna_dev_ops aie4_classic_ops = {
@@ -1157,4 +1406,6 @@ const struct amdxdna_dev_ops aie4_classic_ops = {
 	.cmd_wait		= aie4_cmd_wait,
 	.get_aie_info		= aie4_get_info,
 	.set_aie_state		= aie4_set_state,
+	.resume			= pm_ptr(aie4_classic_resume),
+	.suspend		= pm_ptr(aie4_classic_suspend),
 };
diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
index 4b7367af7cf1..fdc55e498246 100644
--- a/drivers/accel/amdxdna/aie4_pci.h
+++ b/drivers/accel/amdxdna/aie4_pci.h
@@ -95,6 +95,7 @@ struct amdxdna_dev_hdl {
 	u32				total_col;
 	u32				max_aieclk_level;
 	u32				max_npuhclk_level;
+	u32				num_vfs;
 
 	struct dpm_clk_freq		dpm_clk_tbl[AIE4_MAX_DPM_LEVEL_COUNT];
 
@@ -159,8 +160,11 @@ int aie4_cmd_submit(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job,
 int aie4_hwctx_create(struct amdxdna_hwctx *hwctx);
 void aie4_hwctx_destroy(struct amdxdna_hwctx *hwctx, enum aie4_hwctx_flags);
 int aie4_hwctx_wait_for_running(struct amdxdna_hwctx *hwctx);
+void aie4_hwctx_resume_jobs(struct amdxdna_hwctx *hwctx);
 
 /* aie4_pci.c */
+void aie4_hwctx_suspend_all(struct amdxdna_dev_hdl *ndev, int clean_jobs);
+int aie4_hwctx_resume_all(struct amdxdna_dev_hdl *ndev);
 int aie4_restore_power_mode(struct amdxdna_dev_hdl *ndev);
 
 /*
@@ -176,10 +180,17 @@ void aie4_free_notification(struct cert_comp *comp);
 
 /* aie4_sriov.c */
 #if IS_ENABLED(CONFIG_PCI_IOV)
+int aie4_create_vfs(struct amdxdna_dev_hdl *ndev, int num_vfs);
 int aie4_sriov_configure(struct amdxdna_dev *xdna, int num_vfs);
 int aie4_sriov_stop(struct amdxdna_dev_hdl *ndev);
 #else
+static inline int aie4_create_vfs(struct amdxdna_dev_hdl *ndev, int num_vfs)
+{
+	return 0;
+}
+
 #define aie4_sriov_configure NULL
+
 static inline int aie4_sriov_stop(struct amdxdna_dev_hdl *ndev)
 {
 	return 0;
diff --git a/drivers/accel/amdxdna/aie4_sriov.c b/drivers/accel/amdxdna/aie4_sriov.c
index e1ce633768a5..d3df36644914 100644
--- a/drivers/accel/amdxdna/aie4_sriov.c
+++ b/drivers/accel/amdxdna/aie4_sriov.c
@@ -26,7 +26,7 @@ static int aie4_destroy_vfs(struct amdxdna_dev_hdl *ndev)
 	return ret;
 }
 
-static int aie4_create_vfs(struct amdxdna_dev_hdl *ndev, int num_vfs)
+int aie4_create_vfs(struct amdxdna_dev_hdl *ndev, int num_vfs)
 {
 	DECLARE_AIE_MSG(aie4_msg_create_vfs, AIE4_MSG_OP_CREATE_VFS);
 	int ret;
@@ -39,6 +39,59 @@ static int aie4_create_vfs(struct amdxdna_dev_hdl *ndev, int num_vfs)
 	return ret;
 }
 
+static int aie4_for_each_vfs(struct amdxdna_dev *xdna,
+			     int (*cb)(struct amdxdna_dev *, struct pci_dev *))
+{
+	struct pci_dev *pdev_pf = to_pci_dev(xdna->ddev.dev);
+	struct pci_dev *pdev_vf;
+	int pos, ret;
+	u16 vf_did;
+
+	pos = pci_find_ext_capability(pdev_pf, PCI_EXT_CAP_ID_SRIOV);
+	if (!pos)
+		return 0;
+	ret = pci_read_config_word(pdev_pf, pos + PCI_SRIOV_VF_DID, &vf_did);
+	if (ret) {
+		XDNA_ERR(xdna, "read VF Device ID failed %d", ret);
+		return -ENODEV;
+	}
+
+	for (pdev_vf = pci_get_device(pdev_pf->vendor, vf_did, NULL);
+	     pdev_vf;
+	     pdev_vf = pci_get_device(pdev_pf->vendor, vf_did, pdev_vf)) {
+		if (!pdev_vf->is_virtfn || pdev_vf->physfn != pdev_pf)
+			continue;
+
+		ret = cb(xdna, pdev_vf);
+		if (ret) {
+			/* Release reference on early return. */
+			pci_dev_put(pdev_vf);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int aie4_link_vf(struct amdxdna_dev *xdna, struct pci_dev *pdev_vf)
+{
+	struct pci_dev *pdev_pf = to_pci_dev(xdna->ddev.dev);
+
+	/* Stateless so the link survives VF driver rebind. */
+	if (!device_link_add(&pdev_vf->dev, &pdev_pf->dev, DL_FLAG_STATELESS)) {
+		XDNA_ERR(xdna, "Failed to link VF %s", pci_name(pdev_vf));
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int aie4_unlink_vf(struct amdxdna_dev *xdna, struct pci_dev *pdev_vf)
+{
+	device_link_remove(&pdev_vf->dev, xdna->ddev.dev);
+	return 0;
+}
+
 int aie4_sriov_stop(struct amdxdna_dev_hdl *ndev)
 {
 	struct amdxdna_dev *xdna = ndev->aie.xdna;
@@ -54,7 +107,9 @@ int aie4_sriov_stop(struct amdxdna_dev_hdl *ndev)
 		return -EPERM;
 	}
 
+	aie4_for_each_vfs(xdna, aie4_unlink_vf);
 	pci_disable_sriov(pdev);
+	ndev->num_vfs = 0;
 	return aie4_destroy_vfs(ndev);
 }
 
@@ -75,6 +130,15 @@ static int aie4_sriov_start(struct amdxdna_dev_hdl *ndev, int num_vfs)
 		return ret;
 	}
 
+	ret = aie4_for_each_vfs(xdna, aie4_link_vf);
+	if (ret) {
+		aie4_for_each_vfs(xdna, aie4_unlink_vf);
+		pci_disable_sriov(pdev);
+		aie4_destroy_vfs(ndev);
+		return ret;
+	}
+
+	ndev->num_vfs = num_vfs;
 	return num_vfs;
 }
 
diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h b/drivers/accel/amdxdna/amdxdna_pci_drv.h
index eccb461d32bc..505477b4a292 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.h
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.h
@@ -168,6 +168,9 @@ struct amdxdna_client {
 #define amdxdna_for_each_hwctx(client, hwctx_id, entry)		\
 	xa_for_each(&(client)->hwctx_xa, hwctx_id, entry)
 
+#define amdxdna_for_each_client(xdna, client)			\
+	list_for_each_entry(client, &(xdna)->client_list, node)
+
 /* Add device info below */
 extern const struct amdxdna_dev_info dev_npu1_info;
 extern const struct amdxdna_dev_info dev_npu3_classic_info;
-- 
2.34.1

