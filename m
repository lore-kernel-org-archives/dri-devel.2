Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99996CA5FFD
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 03:24:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2B0B10FA7F;
	Thu,  8 Oct 2026 03:24:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tq0tya+/";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011068.outbound.protection.outlook.com [52.101.57.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0247410FA7B
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 03:24:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ECJ8EQ9AJ5MU7e7B70AWRYZaWN6dcUBJAZWLHOD173yci/YO6bXzGvw2SVNsWmw0YYrRsGQ26lgX27Rhr52Yd2wunhwOBPYxFwJR3OxhQIt6fnG+pE5CmPCER7RcsgDn2ola1eiaEya2nFTrZ0gQXjJ9o7KacFutdofgdbkETyCyfeJhNV5atT5X7cfL6GUm9Pm86xXleyh1jQj+2/U2oOK3nisYcWB7MAaH4M7n1z4R6NC+QkMRQcuIs5k/mz8LXAYNEvAfs8ZthNSe1B1f7a1qybP3QMohV+YroNb/i5j14fkMoc4AZf2RP+bOFlaTND0+haQN9hemS/TuCLx5fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5toxe0SKMPLa9Wz5weEBaMETFF5TsTxrQr4YN0BItMs=;
 b=AXR23BNMuq8f4clrZeO4OExkn+InPDSXMsnF3rMvEbRNhlV/Vr5G+vqouJ00rZ5vJrtyPwz6W08r8KohVBvDA47qYyl9JkM3OvenSPWVMy+oMUU6IX1tWC1aPdE+iS5WrdvTxHZI8/R4C78PdnQ19L4Ipy1hhV0nl/uM+dLIFDd29ImBY5td2vJ6uYzpghjdHa7zdZA/j6E7KuhvpZ1b9cApiSVaEJf4tpIStqgHU9jdb0uU26qjy+kH01m33hCcvgmPzQlfuahnZHeoLaGyeVsbtclxW08C47p3LUDVao7latH8Zy6vg9vtbREZbvVI/pHGSEUcsleyeQCxW8khKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5toxe0SKMPLa9Wz5weEBaMETFF5TsTxrQr4YN0BItMs=;
 b=tq0tya+/3uAnrhEN4N3xZl9O72fVyqOc/9GvRQGvWaadrSYqr6OE58kx48RE2SAQ1wYpQcAPpoBMc8zjb5znPcO09BXGtQfRw1Ey1cUgcaSetc4mkEy4muV4cjLzpxzxq3cMlJS2S7NvxibxAqe/UUAdYe9dy6shZlIyJE8yofQ=
Received: from SJ0PR05CA0019.namprd05.prod.outlook.com (2603:10b6:a03:33b::24)
 by BN7PPFFC4F04B28.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6ea) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Thu, 8 Oct
 2026 03:24:13 +0000
Received: from SJ1PEPF000037AC.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::9b) by SJ0PR05CA0019.outlook.office365.com
 (2603:10b6:a03:33b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Thu, 8
 Oct 2026 03:24:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037AC.mail.protection.outlook.com (10.167.244.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Thu, 8 Oct 2026 03:24:12 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 22:24:05 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 22:24:04 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Wed, 7 Oct 2026 22:24:04 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>, Wendy Liang <wendy.liang@amd.com>
Subject: [PATCH V3 11/19] accel/amdxdna: Decouple AIE4 doorbell and MSI-X
 notify transport hooks
Date: Wed, 7 Oct 2026 20:23:40 -0700
Message-ID: <20261008032348.2044667-12-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008032348.2044667-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261008032348.2044667-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AC:EE_|BN7PPFFC4F04B28:EE_
X-MS-Office365-Filtering-Correlation-Id: 76fed133-b3c2-4648-893a-08df24eb9fd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|56012099006|10067099003|5023799004|11063799006|4143699003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: fkogHC0f+VMb9N+n+SrbZIGIDt/hfF0tFM4IQ/19mKRjwPvNG8ylMWpw4zxBcQfgXk1XCCwA9Pq/p8oKRMwhS6t+4+w6jHhU7W3ookNPMYvIla0Y6Ae5wdm3Sf6mmLFu2gP8Q9CVubYX1Pt5mtB79qFRluXnxLUZDaxSyydi3F0a07KSyOxeiCLp88DzTgCq5+cB8PDe+tpKwnj1FPKS+X7HpzNYsbBGjD4WuaqGlf3px7ZUhjjf6S5WUmiESPFt6CnO3WNHx18R2Ss897lYD7U7qMuPNwnwJjxKiea76lcA0tNuEMoX8ft5aop2Mt/ldka7jO4+sqfkyqHd3SOSAv3pMwdNN1hJi4jZaxajEFTgSUqc3I7PNAA63vTr3vYkRyZOqlsmNeXFCPNc0UmDSGBXap1xlXQmm85W8aZWPVDYnR1BN1agxbybU6Sh5x7WIXddQ9s1VRyO85z7GvUY1dWH1OK8uXJBJKHKP3HXtPb4ZQlT8mMVxe97Us3YYWkzedwjZndNmh5y0kf3nlv0QqiOEIVHyjgU5YUu2UsJQTxjuuPJWuSS/9bHcO8WLSx+GSrT2bsZ4QyHHU/s+UFrMIu2jXBvnKOqL1enlcP5hs73DHciR5f9BtU7Kr/0Hr0RyTtE5CebfWYDnh0W4F2No3rGeZiuYTuPLK9rZWyz0NfuUzDPmtAdCI9Xqt5v9Ij1Fk06oLtSUn8WL+rxJX0Opw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(56012099006)(10067099003)(5023799004)(11063799006)(4143699003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FqaK06TEDJSfjdmC5AMjWkaPTILFWlUBNo4IN1yzkTQZcBpJla7b+ZLeBwPfnjn8oRNPUdwvf3qS3dKN35xLDJhdtxLy1AhTsdZhdZBLcF3FVeNSP6cICzDOFNWZq7pEd3yFlaufruTfddvx2Bx0WND/25O7BABPZrE4NYuLvjgaziAXedH1w5IK6p4bkrj7yHs8UoTpY/hSL9ro0Q9Oer5RMTW6mGIIPFeYDuGDfzBRFFT5YO2Jz97ue4VBtEL1HShLnXvnVxp0DsFUpHu7ZzPW7WPeIjbm4ae3Pzw89z5XF3t/RMWL/aqUejbRBq6PCxBYkjo1Gc9tJ5cCB4EloT+bcpeXvTXYihn66WTh6X2yylgimoBi2KvEcRvmRsqao8Vb68XdAqE7sD3sHb9qRBSwFvTgGr0cD+DPSdncSxorOE4hWpaOX3jtg7lXfckz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 03:24:12.6523 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76fed133-b3c2-4648-893a-08df24eb9fd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFFC4F04B28
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

Separate PCI-specific doorbell and interrupt notification handling from
the transport-neutral context code.

Note that new transport functions are wired in later patches in this
series. Neither NULL dereference nor BAR boundary bypass can occur
because doorbell ringing is not invoked until full context setup and BAR
validation are established.

Co-developed-by: Wendy Liang <wendy.liang@amd.com>
Signed-off-by: Wendy Liang <wendy.liang@amd.com>
Signed-off-by: David Zhang <yidong.zhang@amd.com>
---
 drivers/accel/amdxdna/aie4_ctx.c    | 29 ++++---------
 drivers/accel/amdxdna/aie4_pci.c    | 66 +++++++++++++++++++++++++++++
 drivers/accel/amdxdna/aie4_pci.h    | 14 ++++++
 drivers/accel/amdxdna/amdxdna_ctx.h |  2 +
 4 files changed, 90 insertions(+), 21 deletions(-)

diff --git a/drivers/accel/amdxdna/aie4_ctx.c b/drivers/accel/amdxdna/aie4_ctx.c
index 5eb918e1d58c..5a2fc19bad20 100644
--- a/drivers/accel/amdxdna/aie4_ctx.c
+++ b/drivers/accel/amdxdna/aie4_ctx.c
@@ -22,18 +22,9 @@
 #include "amdxdna_mailbox_helper.h"
 #include "amdxdna_pci_drv.h"
 
-static irqreturn_t cert_comp_isr(int irq, void *p)
-{
-	struct cert_comp *cert_comp = p;
-
-	wake_up_all(&cert_comp->waitq);
-	return IRQ_HANDLED;
-}
-
 static struct cert_comp *aie4_lookup_cert_comp(struct amdxdna_dev_hdl *ndev, u32 msix_idx)
 {
 	struct amdxdna_dev *xdna = ndev->aie.xdna;
-	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
 	struct cert_comp *cert_comp;
 	int ret;
 
@@ -51,32 +42,27 @@ static struct cert_comp *aie4_lookup_cert_comp(struct amdxdna_dev_hdl *ndev, u32
 
 	cert_comp->ndev = ndev;
 	cert_comp->msix_idx = msix_idx;
+	cert_comp->irq = -ENOENT;
 	init_waitqueue_head(&cert_comp->waitq);
 	kref_init(&cert_comp->kref);
 
-	ret = pci_irq_vector(pdev, cert_comp->msix_idx);
-	if (ret < 0) {
-		XDNA_ERR(xdna, "MSI-X idx %u is invalid, ret:%d", msix_idx, ret);
-		goto free_cert_comp;
-	}
-	cert_comp->irq = ret;
-
-	ret = request_irq(cert_comp->irq, cert_comp_isr, 0, "xdna_hsa", cert_comp);
+	/* Transport-specific: PCI wires an MSI-X irq, platform an IPI callback. */
+	ret = aie4_request_notification(cert_comp);
 	if (ret) {
-		XDNA_ERR(xdna, "request irq %d failed %d", cert_comp->irq, ret);
+		XDNA_ERR(xdna, "request notification for msix idx %u failed %d", msix_idx, ret);
 		goto free_cert_comp;
 	}
 
 	ret = xa_err(xa_store(&ndev->cert_comp_xa, msix_idx, cert_comp, GFP_KERNEL));
 	if (ret) {
-		XDNA_ERR(xdna, "store cert_comp for msix idx %d failed %d", msix_idx, ret);
+		XDNA_ERR(xdna, "store cert_comp for msix idx %u failed %d", msix_idx, ret);
 		goto free_irq;
 	}
 
 	return cert_comp;
 
 free_irq:
-	free_irq(cert_comp->irq, cert_comp);
+	aie4_free_notification(cert_comp);
 free_cert_comp:
 	kfree(cert_comp);
 	return NULL;
@@ -90,7 +76,7 @@ static void cert_comp_release(struct kref *kref)
 	drm_WARN_ON(&ndev->aie.xdna->ddev, !mutex_is_locked(&ndev->cert_comp_lock));
 
 	xa_erase(&ndev->cert_comp_xa, cert_comp->msix_idx);
-	free_irq(cert_comp->irq, cert_comp);
+	aie4_free_notification(cert_comp);
 	kfree(cert_comp);
 }
 
@@ -100,6 +86,7 @@ static void aie4_put_cert_comp(struct cert_comp *cert_comp)
 
 	ndev = cert_comp->ndev;
 	guard(mutex)(&ndev->cert_comp_lock);
+
 	kref_put(&cert_comp->kref, cert_comp_release);
 }
 
diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
index 8fbbbea0d800..0d59d036a06c 100644
--- a/drivers/accel/amdxdna/aie4_pci.c
+++ b/drivers/accel/amdxdna/aie4_pci.c
@@ -14,6 +14,7 @@
 
 #include "aie.h"
 #include "aie4_msg_priv.h"
+#include "amdxdna_ctx.h"
 #include "aie4_pci.h"
 #include "amdxdna_error.h"
 #include "amdxdna_mailbox.h"
@@ -111,6 +112,69 @@ static void aie4_mailbox_fini(struct amdxdna_dev_hdl *ndev)
 	ndev->mbox = NULL;
 }
 
+static irqreturn_t cert_comp_isr(int irq, void *p)
+{
+	struct cert_comp *cert_comp = p;
+
+	wake_up_all(&cert_comp->waitq);
+	return IRQ_HANDLED;
+}
+
+/* Wire per-cert completion notification interrupt. */
+int aie4_request_notification(struct cert_comp *comp)
+{
+	struct pci_dev *pdev = to_pci_dev(comp->ndev->aie.xdna->ddev.dev);
+	int ret;
+
+	ret = pci_irq_vector(pdev, comp->msix_idx);
+	if (ret < 0)
+		return ret;
+	comp->irq = ret;
+
+	ret = request_irq(comp->irq, cert_comp_isr, 0, "xdna_hsa", comp);
+	if (ret) {
+		comp->irq = -ENOENT;
+		return ret;
+	}
+
+	return 0;
+}
+
+/* Tear down per-cert completion notification interrupt. */
+void aie4_free_notification(struct cert_comp *comp)
+{
+	if (comp->irq >= 0)
+		free_irq(comp->irq, comp);
+}
+
+/* Validate and configure hardware context doorbell target. */
+int aie4_doorbell_setup(struct amdxdna_hwctx *hwctx,
+			const struct aie4_msg_create_hw_context_resp *resp)
+{
+	struct amdxdna_dev *xdna = hwctx->client->xdna;
+	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
+	struct amdxdna_hwctx_priv *priv = hwctx->priv;
+	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
+	u64 db_off = (u64)ndev->priv->doorbell_off + resp->doorbell_offset;
+
+	/* Validate doorbell offset against mapped BAR bounds. */
+	if (db_off + sizeof(u32) >
+	    pci_resource_len(pdev, xdna->dev_info->doorbell_bar)) {
+		XDNA_ERR(xdna, "doorbell offset 0x%llx out of BAR", db_off);
+		return -EINVAL;
+	}
+
+	priv->doorbell_addr = ndev->doorbell_base + ndev->priv->doorbell_off +
+			      resp->doorbell_offset;
+	return 0;
+}
+
+/* Ring context doorbell to notify CERT. */
+void aie4_doorbell_ring(struct amdxdna_hwctx *hwctx)
+{
+	writel(0, hwctx->priv->doorbell_addr);
+}
+
 static int aie4_irq_init(struct amdxdna_dev *xdna)
 {
 	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
@@ -629,6 +693,7 @@ static int aie4m_pcidev_init(struct amdxdna_dev *xdna)
 		set_bit(SMU_REG_BAR(ndev, i), &bars);
 	set_bit(xdna->dev_info->mbox_bar, &bars);
 	set_bit(xdna->dev_info->sram_bar, &bars);
+	set_bit(xdna->dev_info->doorbell_bar, &bars);
 
 	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
 		if (!test_bit(i, &bars))
@@ -642,6 +707,7 @@ static int aie4m_pcidev_init(struct amdxdna_dev *xdna)
 
 	ndev->mbox_base = tbl[xdna->dev_info->mbox_bar];
 	ndev->rbuf_base = tbl[xdna->dev_info->sram_bar];
+	ndev->doorbell_base = tbl[xdna->dev_info->doorbell_bar];
 
 	pci_set_master(pdev);
 
diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
index 959ef3695813..9fcdfcc5a15f 100644
--- a/drivers/accel/amdxdna/aie4_pci.h
+++ b/drivers/accel/amdxdna/aie4_pci.h
@@ -32,6 +32,8 @@ struct amdxdna_hwctx_priv {
 
 	struct cert_comp                *cert_comp;
 	u32                             hw_ctx_id;
+
+	void                    __iomem *doorbell_addr;
 };
 
 struct amdxdna_dev_priv {
@@ -54,6 +56,7 @@ struct amdxdna_dev_hdl {
 	const struct amdxdna_dev_priv	*priv;
 	void			__iomem *mbox_base;
 	void			__iomem *rbuf_base;
+	void			__iomem *doorbell_base;
 
 	struct mailbox			*mbox;
 	u32				partition_id;
@@ -111,6 +114,17 @@ int aie4_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq, u32 timeout);
 /* aie4_pci.c */
 int aie4_restore_power_mode(struct amdxdna_dev_hdl *ndev);
 
+/*
+ * Transport hooks implemented by PCI backend. Doorbell hooks are wired during
+ * kernel queue creation and command submission in later patches in the series.
+ */
+struct aie4_msg_create_hw_context_resp;
+int aie4_doorbell_setup(struct amdxdna_hwctx *hwctx,
+			const struct aie4_msg_create_hw_context_resp *resp);
+void aie4_doorbell_ring(struct amdxdna_hwctx *hwctx);
+int aie4_request_notification(struct cert_comp *comp);
+void aie4_free_notification(struct cert_comp *comp);
+
 /* aie4_sriov.c */
 #if IS_ENABLED(CONFIG_PCI_IOV)
 int aie4_sriov_configure(struct amdxdna_dev *xdna, int num_vfs);
diff --git a/drivers/accel/amdxdna/amdxdna_ctx.h b/drivers/accel/amdxdna/amdxdna_ctx.h
index 6e78bab8a02c..9bbc3db4ebde 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.h
+++ b/drivers/accel/amdxdna/amdxdna_ctx.h
@@ -6,6 +6,8 @@
 #ifndef _AMDXDNA_CTX_H_
 #define _AMDXDNA_CTX_H_
 
+#include <drm/amdxdna_accel.h>
+#include <drm/gpu_scheduler.h>
 #include <linux/bitfield.h>
 
 #include "amdxdna_gem.h"
-- 
2.34.1

