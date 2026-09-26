Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD3AAC9830E
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 01:36:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08D7610FCF5;
	Sat, 26 Sep 2026 01:36:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2/d3diYJ";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011061.outbound.protection.outlook.com [40.107.208.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B423F10FCF5
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 01:35:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LxhpPlFNeNe08LljExqzDNSJQZpuftGpYd3oj2jI011lrkL070SZ7rGNiv0iXzYqUWR0V+EbqGWvkg8yPcYifWrFNrSj7uM2T+l/WUmu1O4CenhJti/Oyw/3v0uB4jxn3zjcL9V98wrurXDw8EA60U/YPvH5DsvbO+tMCtffEHH7/jA5G8dKTYDLT/+vzbfeD998pnEE/r4J5khHLiMN655STuhXS5o2oQkJbIVy92GhTzoPLxtoaXyyPNs5tPJTZSqDk7qbLsCqXJ9BHE2yySGlNwYQOgmE3bGJO6StJTW/Fp7GajXJj5AaWw34h5GcuMYZYWlH0XW3h6RL+GagLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d/w7amBgWeJA2ZqfUVneBpDeAuYz6/htadr9JL0d5yw=;
 b=RwkPozg6n2EIORiJEMmnaj29QnM2jEJ5qQ7HPIa7p2nLmD0qcK0/0sAKCG8vg0h0KTuiONKNqyucDNhPKyntFQnzUldDuZEg+lmO2UmsTFwFGnTiWpfddIS5kItJ0Hgp9QKy8mhMvBX6Pmzufg/jlzI5zJU8QVLIyuoBR6FTK0+gXcfe+cp7QZ+KdPBWFrneaacySfd9eTGOz2F5u2nf/I2/LFzgf6UXUE4OX4qIIQ/Bnvd2fYk2vo3QkqAcGuWqHAE1x7Km82r+6UeAdoGVWGCL3csDhl4KU11XqyZB3hTxl74vms/HDU3J6cOWuoCfLSj6Mr16sxzhbqMaf2rrtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/w7amBgWeJA2ZqfUVneBpDeAuYz6/htadr9JL0d5yw=;
 b=2/d3diYJaXEyQgJR3CZfEtgiXDSK2cGBIQSJKbToo8OLXkCCou68nZ5y0vHjjHH3k6tn2biRslWeqBEUyRNvgHNo7t4Ip9bboxlQaAikemPl+IIGdFfF5XOxPONPN+H2/E/rHiyKrqEznXCpBgRjEd5jmfVNtkdu2fuEqNgCtrU=
Received: from CH0PR13CA0001.namprd13.prod.outlook.com (2603:10b6:610:b1::6)
 by MN0PR12MB6221.namprd12.prod.outlook.com (2603:10b6:208:3c3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.16; Sat, 26 Sep
 2026 01:35:34 +0000
Received: from BN5PEPF00046989.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::4d) by CH0PR13CA0001.outlook.office365.com
 (2603:10b6:610:b1::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.19 via Frontend Transport; Sat,
 26 Sep 2026 01:35:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN5PEPF00046989.mail.protection.outlook.com (10.167.245.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Sat, 26 Sep 2026 01:35:33 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 25 Sep
 2026 20:35:32 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Fri, 25 Sep 2026 20:35:31 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V0 18/21] accel/amdxdna: Implement AIE4 suspend and resume
Date: Fri, 25 Sep 2026 18:34:45 -0700
Message-ID: <20260926013448.3840921-19-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260926013448.3840921-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20260926013448.3840921-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PEPF00046989:EE_|MN0PR12MB6221:EE_
X-MS-Office365-Filtering-Correlation-Id: 78044f69-6341-4f52-01a4-08df1b6e7564
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|10067099003|11063799006|56012099006|6133799003|22082099003|18002099003|260925022911599003|4143699003|260925021311599003|260925021911599003;
X-Microsoft-Antispam-Message-Info: OmZjW/lDKR7KyyCA5iMngURMbEJe7BMslq/S1l/xu3RX/yxcsb3w9LNkoRh50fQx0VcJr23PNe1OnhaxmgwmlG5J7k00Oyms4Qu/+zJUtmCF7e4RDUKewt8eO6TVne+6LefzCKjmYYh9Rpyh+Vh2N9jayn1C78pecUMcFAXrMiXGCfArcmUOrNBZCB7eRMKUzTQWaV832Ly0e2R83ipf+JufOW1Pow8tIrLscFTo8nFFnfyx19/yBdZv2CeqTrjqyAr2336z2medTtEm9Fd+atHFgYg5r/TOpqQYV+/0gBR0QJsegU/vPzcQMB7gr6e84GZYFi/U9VxwE7lJJzRdn4RsdFUMiqwl3SzykwXHfSABQ522NsuAz5j1IuTBo8MzHqI5YjunVI468/TEsn/LiYNvS6v1cGNV6SLjcAXJ1jp50PslzMjnVG3w7H3pbJTLyjvXm6sdb6xHw+WtaCX+nz4cBYSHV74Smclu/n5rk16k2DIstH4bl8JwWevaL2l5bDAjdQdwaHXh/W5/3i0L2ZyWKWlXAInT066TiePOoOnV5+9cx8oCH5GyiKtvPuIrnJJMGTgdu+TqvPiciDfFioGn31z4mEk1RRgth6nS0XwjWfW18oU7C04myXt6BZxebVDma9tWvhZnyq5+5AD39N1RMsCUa/ntxKT/DzG0q5AxKy10fCRdstJhKkk8UChlJBRnia9OwsTSt5K00479xA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(10067099003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003)(260925022911599003)(4143699003)(260925021311599003)(260925021911599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IED4PaDH30yMmYPsaoluYCz4nbV0Ao534qi2xNrJ0R7FBDXna9xWcDvRyMVAZqMK8G8n/Ds62XLCs59VejGkLVfPGQ5pR1VuqpoXyJnG5V5DURlIUrPvj9ggYuzHw5MWhczPuG4AZQ1asjFfyxAssRzWLoRgwzJ2o64RShRDG2+YgrBH9rvCEurt/2o4CDeHRpCqSC5r7AizKIxgWPf6mBvx43EkOOoJ+AV3TI+rOBs70zQ0apPa2mqK2BCbO2WNp34FymZ0Jkxy25IFO7h1eB9qOK+JO85fddN1bnWggZkHtehw/wiAvcIGYmzoGZw2HAbyi/K7z4vGFGVhXWhegHDMy1w4wKq/fy87qEnnFiCq6faFgzjwKXdYNwSdjZFhRYyTC4dBpG+fNwBbdQ7G6u3bzmVtSqZEgxYU6PorhqkUt9DAiQ3NedUs8UaVuDeq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2026 01:35:33.9312 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78044f69-6341-4f52-01a4-08df1b6e7564
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN5PEPF00046989.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6221
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
- Add .suspend and .resume hooks in amdxdna_dev_ops for aie4_pf_ops,
  aie4_vf_ops, and aie4_classic_ops.
- Implement aie4_hwctx_suspend_all() to destroy or drain contexts across
  all registered clients and wait for in-flight jobs.
- Implement aie4_hwctx_resume_all() to recreate firmware contexts and
  kick doorbells via aie4_hwctx_resume_jobs() to resume hardware queue
  consumption.
- Guard firmware destroy message in aie4_hwctx_destroy() when context
  ID is invalid.
- Restore SR-IOV virtual functions on PF resume via aie4_restore_sriov().

Signed-off-by: David Zhang <yidong.zhang@amd.com>
---
 drivers/accel/amdxdna/aie4_ctx.c        |  17 +-
 drivers/accel/amdxdna/aie4_pci.c        | 243 ++++++++++++++++++++++++
 drivers/accel/amdxdna/aie4_pci.h        |   9 +
 drivers/accel/amdxdna/aie4_sriov.c      |   4 +-
 drivers/accel/amdxdna/amdxdna_pci_drv.h |   3 +
 5 files changed, 274 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/amdxdna/aie4_ctx.c b/drivers/accel/amdxdna/aie4_ctx.c
index ec00ea0bbc55..016baf5b02c7 100644
--- a/drivers/accel/amdxdna/aie4_ctx.c
+++ b/drivers/accel/amdxdna/aie4_ctx.c
@@ -260,7 +260,7 @@ void aie4_hwctx_destroy(struct amdxdna_hwctx *hwctx, enum aie4_hwctx_flags flags
 	if (has_reset)
 		wake_up_all(&priv->job_list_wq);
 
-	if (flags != AIE4_HWCTX_DISCONNECT)
+	if (flags != AIE4_HWCTX_DISCONNECT && priv->hw_ctx_id != CTX_INVALID_ID)
 		aie4_msg_destroy_context(ndev, priv->hw_ctx_id);
 
 	priv->hw_ctx_id = CTX_INVALID_ID;
@@ -391,6 +391,7 @@ int aie4_hwctx_init(struct amdxdna_hwctx *hwctx)
 		return -ENOMEM;
 	hwctx->priv = priv;
 	priv->hwctx = hwctx;
+	priv->hw_ctx_id = CTX_INVALID_ID;
 
 	/*
 	 * io_lock guards the per-hwctx cert_comp binding (the connected sentinel)
@@ -972,6 +973,20 @@ int aie4_hwctx_wait_for_running(struct amdxdna_hwctx *hwctx)
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
 /*
  * Submit the command(s) carried by @job into the host queue. Called with
  * io_lock held. A single ERT_START_DPU maps to one queue entry; an
diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
index e5266237977c..3c190003865a 100644
--- a/drivers/accel/amdxdna/aie4_pci.c
+++ b/drivers/accel/amdxdna/aie4_pci.c
@@ -1095,11 +1095,250 @@ static void aie4_debugfs_init(struct amdxdna_dev *xdna)
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
+		return ret;
+	}
+	pci_set_master(pdev);
+
+	ret = aie4_vf_hw_start(ndev);
+	if (ret) {
+		XDNA_ERR(xdna, "hw_start failed %d", ret);
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
+		return ret;
+	}
+	pci_set_master(pdev);
+
+	ret = aie4_classic_hw_start(ndev);
+	if (ret) {
+		XDNA_ERR(xdna, "hw_start failed %d", ret);
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
+	.resume			= aie4_pf_resume,
+	.suspend		= aie4_pf_suspend,
 };
 
 const struct amdxdna_dev_ops aie4_vf_ops = {
@@ -1112,6 +1351,8 @@ const struct amdxdna_dev_ops aie4_vf_ops = {
 	.cmd_wait		= aie4_cmd_wait,
 	.get_aie_info		= aie4_get_info,
 	.set_aie_state		= aie4_set_state,
+	.resume			= aie4_vf_resume,
+	.suspend		= aie4_vf_suspend,
 };
 
 const struct amdxdna_dev_ops aie4_classic_ops = {
@@ -1124,4 +1365,6 @@ const struct amdxdna_dev_ops aie4_classic_ops = {
 	.cmd_wait		= aie4_cmd_wait,
 	.get_aie_info		= aie4_get_info,
 	.set_aie_state		= aie4_set_state,
+	.resume			= aie4_classic_resume,
+	.suspend		= aie4_classic_suspend,
 };
diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
index 6b67c9da560e..df15c63317b1 100644
--- a/drivers/accel/amdxdna/aie4_pci.h
+++ b/drivers/accel/amdxdna/aie4_pci.h
@@ -109,6 +109,7 @@ struct amdxdna_dev_hdl {
 	u32				total_col;
 	u32				max_aieclk_level;
 	u32				max_npuhclk_level;
+	u32				num_vfs;
 
 	struct dpm_clk_freq		dpm_clk_tbl[AIE4_MAX_DPM_LEVEL_COUNT];
 
@@ -170,8 +171,11 @@ int aie4_cmd_submit(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job,
 int aie4_hwctx_create(struct amdxdna_hwctx *hwctx);
 void aie4_hwctx_destroy(struct amdxdna_hwctx *hwctx, enum aie4_hwctx_flags);
 int aie4_hwctx_wait_for_running(struct amdxdna_hwctx *hwctx);
+void aie4_hwctx_resume_jobs(struct amdxdna_hwctx *hwctx);
 
 /* aie4_pci.c */
+void aie4_hwctx_suspend_all(struct amdxdna_dev_hdl *ndev, int clean_jobs);
+int aie4_hwctx_resume_all(struct amdxdna_dev_hdl *ndev);
 int aie4_restore_power_mode(struct amdxdna_dev_hdl *ndev);
 
 /*
@@ -191,9 +195,14 @@ void aie4_free_notification(struct cert_comp *comp);
 
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
 #define aie4_sriov_configure NULL
 static inline int aie4_sriov_stop(struct amdxdna_dev_hdl *ndev)
 {
diff --git a/drivers/accel/amdxdna/aie4_sriov.c b/drivers/accel/amdxdna/aie4_sriov.c
index e1ce633768a5..0eea28f62676 100644
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
@@ -55,6 +55,7 @@ int aie4_sriov_stop(struct amdxdna_dev_hdl *ndev)
 	}
 
 	pci_disable_sriov(pdev);
+	ndev->num_vfs = 0;
 	return aie4_destroy_vfs(ndev);
 }
 
@@ -75,6 +76,7 @@ static int aie4_sriov_start(struct amdxdna_dev_hdl *ndev, int num_vfs)
 		return ret;
 	}
 
+	ndev->num_vfs = num_vfs;
 	return num_vfs;
 }
 
diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h b/drivers/accel/amdxdna/amdxdna_pci_drv.h
index 11f46ec738d7..45170c945d71 100644
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

