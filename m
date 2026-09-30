Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25929CA5FAB
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 03:33:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5644510F15B;
	Wed, 30 Sep 2026 03:33:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eB7ixAEU";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010029.outbound.protection.outlook.com [52.101.46.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80A3B10E9E0
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 03:33:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gIpQl+mnuQyRsWhiA3eK7CL3NYbVV1Fh25mVuAogpo9/9N7TbbxfK84X4/nMNJ61/OBcB1eKTq8NaGlLcXBT/wcbRqmrcBtkFyxv68Ce3phGDW0rxJGnZ0+/E1T89c5xc9rWnOGVDE7BjL0/zXgtCQVypeT6e5S0XtH5UZsGOf0jgu91d3llravyZrTvDPcHAhYwf7XfBk6JObfzAXK9K3Zi0hFqUxjRpvx2Joq0+PIJaSJTnasjs6nNReGtIFkq74kFg4w7O9QvllRRkZuCCZmw+tcYxn67rGKmCSCvaVJCTYT3v/it2AfdN4uAT84RJ/Ag2dxr7CVBZcvwF3R67A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pz9ST9/OcaUhAWqi5yayrsTCCK3O1iN9gwCm2JQ2PUk=;
 b=LaepxweoYz0WxNVk41RxY1fZpVs8YiRHbv+kMVitXfNcI8jv1k9ZwJzlzXpk0w8yLT9oHvsRUa8eV41f/uJAdv8BSpitqurUwj5ZfbBzRYayL39GsI0/XX+B0H/XJIgwSkVlQswSn+GvC1svU/GaWxHeBj0KLf2LUGBoY2GaCXdsDwNKTqu6Ywv8n5ra3E7fMl2a34STqQ/1nOZMYZWXkSq/O8Ya6GfwKdzCrzl8tDv+RQjvFCW5alfzs4MyD0fSbUSpxjqICxHacTJYIQMeBsgfKiMWZp3KbfZBuXsJoBbeENKjHCy9hrsnk3I6HT/e2jyZeJr/VUdBmYVirzseUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pz9ST9/OcaUhAWqi5yayrsTCCK3O1iN9gwCm2JQ2PUk=;
 b=eB7ixAEUmxoXCbW3Jc99MhjEnrNWknQxj8ZHnKnY4FE28bbbgiHn9yjSf2+3hrcQGFCdf4UVRjTD9BUEQS9sjWJS5pAkqsJBD77z0tb4Cv6RL/7AQirChr2wJTls2XHOgxRu6turTojcUK8U1bGtkS4g7ctabOp0v3h04z/g480=
Received: from SJ0PR05CA0026.namprd05.prod.outlook.com (2603:10b6:a03:33b::31)
 by CH1PPF5A8F51299.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::60f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 03:33:10 +0000
Received: from SJ1PEPF00002323.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::2b) by SJ0PR05CA0026.outlook.office365.com
 (2603:10b6:a03:33b::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.11 via Frontend Transport; Wed,
 30 Sep 2026 03:33:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002323.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 03:33:10 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 22:33:03 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 22:33:02 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Tue, 29 Sep 2026 22:33:02 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V1 16/20] accel/amdxdna: Implement AIE4 suspend and resume
Date: Tue, 29 Sep 2026 20:32:29 -0700
Message-ID: <20260930033233.1727265-17-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930033233.1727265-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20260930033233.1727265-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002323:EE_|CH1PPF5A8F51299:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a5e36a7-2963-4730-f1d3-08df1ea38ce9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|18002099003|22082099003|6133799003|10067099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: 9qKY9RcThtRBks0x6M5PtWGkF8/auKSp0c4jFXJe3CsSHNxL2MrDQEL2a67HXWLsU6gU2lUC1rrpH5kdMZ+5NaIurDFEgd6VFjSiqFvEOPlbNFVeH3wOGYHVaCpLOsH3NReSLW6KGtKnV4zH9eC2PqBgsglLmGHCyOALARAEn98FnERgUBnzyPVfsL3fa0SEo+KNfX9yd8bDOdTrORwUHJynpDMeppUmNhFuxY3km/gJbMmewmFvt/wVkXO1ZGvZpI+3jp1s263yrRIfGsPK8/V9YacIVrtXVo3oGVPHKtrnj1c7fvkBElqWJMs2QQ6QdtXmK3SCQadWgsGJW4d+kiGO2ko845Iug0Ty/sG9AXqnlwheKmlQAhWInJyhnQXSwTkORDwoMcyIMS7jNXk3Q5osV/oyW8Sf5ZF3V2ciM7Fu1cpEu0F0sZfAEGq/Zg8RxH+N+2velh3nWq0tmbMaPyqEN+kHDSp51rdbLWfsQFEolG7JU0heNMl+L+7skMplceoNxuh4dKqOBwXYc7uAF/NHYbdYhf+J1O8nNpLbJcUoYQMhlt8XyInUeaCC57n7R8+fE1ihzoRx0nGbsKmoOoNVI/ZEfzIBDibj97KXOLPjNHpTRIt4EYiT12Hc2Re/RlGDmkEsXiojKQzQtGL7JGALHLTmr0lJ5YOoimbeOAdsblPLPLhFXMfvg3TsKA/BdYqKmlqtJx7FhuvWcHY/Sw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(22082099003)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KEw3ipeSxoihiNX1+ald7ScgpDMFej6l5bLEInfXcBgtW+ZXf9kgA1iue0fVTiP+pLXAYSzclqfsYJlpun+Mnv4LyU4ojOGfx/20i8DcbNnrJU98L69qsSw7BwAHTdpyloAGR00N9+kX7DPzyr9/ZB+UVkg1eN2VRaYw69QYRMG0EWGvuZE9F93hi7n+YJaFH7vB/82CPjiU0bFoN6EVOaYE03auPj25FcjdI7NvB7HSO7A3veYXShlDmo8x4KDNaOro4AaRHeEULDb6R71ugoT/I8KTg5Th11VvST5xZZiKbuAZDpGNtYg/czKfNMH9pLxTIOPjnXhnwwNOihkzqYzjxE9sAYtXnWbkYX+rxltR2GolK6P9OzkyBHwi3W1g6yXWuu+x9igp932ioreCGG/++/FM7PX6C0q5sj+Cz9Pb9h5WzNl5Otedyikfuszf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 03:33:10.1536 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a5e36a7-2963-4730-f1d3-08df1ea38ce9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002323.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF5A8F51299
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
 drivers/accel/amdxdna/aie4_ctx.c        |  18 +-
 drivers/accel/amdxdna/aie4_pci.c        | 243 ++++++++++++++++++++++++
 drivers/accel/amdxdna/aie4_pci.h        |   9 +
 drivers/accel/amdxdna/aie4_sriov.c      |   4 +-
 drivers/accel/amdxdna/amdxdna_pci_drv.h |   3 +
 5 files changed, 275 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/amdxdna/aie4_ctx.c b/drivers/accel/amdxdna/aie4_ctx.c
index e9ba1ed93997..c55138a754fd 100644
--- a/drivers/accel/amdxdna/aie4_ctx.c
+++ b/drivers/accel/amdxdna/aie4_ctx.c
@@ -262,7 +262,7 @@ void aie4_hwctx_destroy(struct amdxdna_hwctx *hwctx, enum aie4_hwctx_flags flags
 	if (has_reset)
 		wake_up_all(&priv->job_list_wq);
 
-	if (flags != AIE4_HWCTX_DISCONNECT)
+	if (flags != AIE4_HWCTX_DISCONNECT && priv->hw_ctx_id != CTX_INVALID_ID)
 		aie4_msg_destroy_context(ndev, priv->hw_ctx_id);
 
 	priv->hw_ctx_id = CTX_INVALID_ID;
@@ -393,6 +393,7 @@ int aie4_hwctx_init(struct amdxdna_hwctx *hwctx)
 		return -ENOMEM;
 	hwctx->priv = priv;
 	priv->hwctx = hwctx;
+	priv->hw_ctx_id = CTX_INVALID_ID;
 
 	/*
 	 * io_lock guards the per-hwctx cert_comp binding (the connected sentinel)
@@ -974,6 +975,21 @@ int aie4_hwctx_wait_for_running(struct amdxdna_hwctx *hwctx)
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
 /*
  * Submit the command(s) carried by @job into the host queue. Called with
  * io_lock held. A single ERT_START_DPU maps to one queue entry; an
diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
index f180983a692d..6a50c1499ec9 100644
--- a/drivers/accel/amdxdna/aie4_pci.c
+++ b/drivers/accel/amdxdna/aie4_pci.c
@@ -1096,11 +1096,250 @@ static void aie4_debugfs_init(struct amdxdna_dev *xdna)
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
@@ -1113,6 +1352,8 @@ const struct amdxdna_dev_ops aie4_vf_ops = {
 	.cmd_wait		= aie4_cmd_wait,
 	.get_aie_info		= aie4_get_info,
 	.set_aie_state		= aie4_set_state,
+	.resume			= aie4_vf_resume,
+	.suspend		= aie4_vf_suspend,
 };
 
 const struct amdxdna_dev_ops aie4_classic_ops = {
@@ -1125,4 +1366,6 @@ const struct amdxdna_dev_ops aie4_classic_ops = {
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

