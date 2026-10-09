Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 431EDCA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 22:54:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B6FE1122F9;
	Fri,  9 Oct 2026 22:54:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PP0a4XdV";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013040.outbound.protection.outlook.com
 [40.107.201.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28937112308
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 22:54:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FS6jxftMfxE5C12XAFrPGbYQqd+PUzTehvB6bYsTBnbZumHyXYlEsN6SItQcZFi5kiDV9gqKdbhRUKaD/LOnsscSDdVhbgyoSBbxoWJRZWOX3oHdVgu1+SCZZtH7lhW5ZTJcchtRJgeTSyQgiBCH/JMxwH50poKNcxbooLe2puVc3c8KYoouty7kCV6ZHuDe7AtjD55islNnxyXPVgXGXx2zu2y0c5rXdjbKr1sSyvtitiRXFh1WIjrhsb/Qx9fB9wtYGEtqkjz/oEYNImXqJxfSiORNF+e5BJDCMMlXLNFoajTEjuTj2ibGjqLYBIs+wg/X/dXAZXDxoEk7vtA51A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYChyx6ntPpkc0yiee7AjpBmeGoVEYVqNJpSfDqib18=;
 b=dvGOGGhK6WeYXOqvWHnEC6hsN1f6DNMLbRRz6XoN712/DwYmNh5PYC+SSY3/htw58JGEq1YOCqFtp5kEtJrsynsxo/qqT7kZ8hTlQRj7DbMtsiNYAZIGI+Wq4TwEubCULuFC+wFg3uY7ayw/lGdRYfsBRJHcvV4jjPwlQF5442QcwedYrDFtpw2xNjZqliHVYG1eD93XjeuzOLQGmK5kK0IFlxvdx/KKqFSFNaj+bRO1uMKJMrURu0HeseG7+J62kw2jwZGK6OR+IfaI3g72R/bhNZaUjV44kmeYisRrXclEAcnSV4bUbl6Lz7hYjaw7emQ2dfzQhYDgTupOjmQpyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYChyx6ntPpkc0yiee7AjpBmeGoVEYVqNJpSfDqib18=;
 b=PP0a4XdV9wUDrRttN36M8BQXjoT7ut8JY2gAY+MAurmO2noEgM4YtjTz/pyzk7yxRFOlqhjG+fWvVj1DR2nSPYhzN8TorRrYBZkQJs54VZuU/FEUbYNwp0VYSQvbIK8MDJ1DoKWUHJgQ1iuAYnPur4nXMsAKb64ReQJV+B1xQrI=
Received: from BL1P222CA0016.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::21)
 by DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.16; Fri, 9 Oct 2026 22:53:59 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:208:2c7:cafe::98) by BL1P222CA0016.outlook.office365.com
 (2603:10b6:208:2c7::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 9
 Oct 2026 22:53:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.0 via Frontend Transport; Fri, 9 Oct 2026 22:53:58 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 17:53:53 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 17:53:53 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Fri, 9 Oct 2026 17:53:52 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>, Wendy Liang <wendy.liang@amd.com>
Subject: [PATCH V4 11/19] accel/amdxdna: Decouple AIE4 doorbell and MSI-X
 notify transport hooks
Date: Fri, 9 Oct 2026 15:53:35 -0700
Message-ID: <20261009225343.3079074-12-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261009225343.3079074-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261009225343.3079074-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|DS0PR12MB6390:EE_
X-MS-Office365-Filtering-Correlation-Id: 52c394bb-e84b-433b-3d34-08df2658346b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|10067099003|5023799004|56012099006|6133799003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ZpJ+16p1muTD/GSavVtuAaqqSKek1qGrZHRkOwUPVD1GRKySnpELjOQ+bSBO/XPAiyWusFtciIBRFfOBpQ3W2WLoyqh1U/k+WCCf1OiN8CeIuJCWMBVwDCN1FvUFU2VIPjhwivifIaQTGfidj1XPcrr1oXFLVZdbBrAOcbw0f8cp2J6rJUW5tPwpTKnbSBiqnx9t419BjvVg86FeXWsk6awO8040a2h782G5Q/kDSt+nCDTzGFxJImSyNsboroYpRcmA+uzgJO7RCF8DsF8VgLf+UZAh3niZECt5Z6PfKUkktpHVHz+I7G40tmCtYoC4u1TPLhY12SwwjRAOza+5s2ueuts+dR88xiqH5nquk8e7kR+hBYdmZfFMQbBhKwRkNI+Sv685kEE/r2a1SMfMo4sIoj3IYjbtWEWbkilX9MXyT21Jv7ueBtOs2I/sXnP7zdPHyCx0q+Ne/8z/XdY8BtQuoQbI7JAxkhg5oziPzYsTxPj4ELz+HC1CivY/F8U/5JWxz5+NlFztlsldltkC9gERbJLAiVJJ26jlsLV0iLVn+UFrttX9kvx7g4GR8Ij3SiDTYcPF9P+HlzjyFy50igle0DH9wRmV2ybVzY7shyCWW86jedU3VJB39YjJJNyjR1TMjetb9JvJL2Owh7Ykdi6f0jTy3kQzIhFFhSjylUM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(10067099003)(5023799004)(56012099006)(6133799003)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1gzXzOXeCruagbZfmJxgfqIK3/+kq9fwO3i8oepFt6ZnWWgqPpWP/Tpe/ePCkiF++ZUWemr3BSWF1bNP4Xd7T/I0/dxox4MuFKV7gsevsRuq56HRDKdvyMcgxk9Y9trkH0YYiLX20FaC7v5dolkbJKhCq3jUlotuWdKB7U4AmjW16PCjWLSnC5GUsFia/GHvmr1JGNf/WWgZPiRJC2tAPYL73mdBWpPSx75AZ2pgQR+nMdsOzjPIZvZIqhSBvCD92tgWnorQccImMbZwm0inf3u5dBhpCKig3LKTd/BTDs81jj9xGC087MaK0zl9ZtvXqAMIBI31ms2cd05PLMZHLTquRNsDkJuiFLlw0utWHMeaTckudodivwP3oDSGidjlwip08UTO46peCmSMvpB9yxxOZ048CREtUABaW2Nen+KnVlK8y1U4I0Mv2T9flRSY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 22:53:58.7895 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c394bb-e84b-433b-3d34-08df2658346b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6390
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

The new transport functions are wired in later patches in this series.
Doorbell ringing is not invoked until full context setup and BAR
validation are done, so no NULL dereference or BAR boundary bypass can
occur.

Co-developed-by: Wendy Liang <wendy.liang@amd.com>
Signed-off-by: Wendy Liang <wendy.liang@amd.com>
Signed-off-by: David Zhang <yidong.zhang@amd.com>
---
 drivers/accel/amdxdna/aie4_ctx.c    | 38 ++++++-----------
 drivers/accel/amdxdna/aie4_pci.c    | 66 +++++++++++++++++++++++++++++
 drivers/accel/amdxdna/aie4_pci.h    | 14 ++++++
 drivers/accel/amdxdna/amdxdna_ctx.h |  2 +
 4 files changed, 96 insertions(+), 24 deletions(-)

diff --git a/drivers/accel/amdxdna/aie4_ctx.c b/drivers/accel/amdxdna/aie4_ctx.c
index 5eb918e1d58c..20b725de6ab7 100644
--- a/drivers/accel/amdxdna/aie4_ctx.c
+++ b/drivers/accel/amdxdna/aie4_ctx.c
@@ -22,63 +22,52 @@
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
 
-	guard(mutex)(&ndev->cert_comp_lock);
-
+	mutex_lock(&ndev->cert_comp_lock);
 	cert_comp = xa_load(&ndev->cert_comp_xa, msix_idx);
 	if (cert_comp) {
 		kref_get(&cert_comp->kref);
+		mutex_unlock(&ndev->cert_comp_lock);
 		return cert_comp;
 	}
 
 	cert_comp = kzalloc_obj(*cert_comp);
 	if (!cert_comp)
-		return NULL;
+		goto unlock;
 
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
+	mutex_unlock(&ndev->cert_comp_lock);
 
 	return cert_comp;
 
 free_irq:
-	free_irq(cert_comp->irq, cert_comp);
+	aie4_free_notification(cert_comp);
 free_cert_comp:
 	kfree(cert_comp);
+unlock:
+	mutex_unlock(&ndev->cert_comp_lock);
 	return NULL;
 }
 
@@ -90,7 +79,7 @@ static void cert_comp_release(struct kref *kref)
 	drm_WARN_ON(&ndev->aie.xdna->ddev, !mutex_is_locked(&ndev->cert_comp_lock));
 
 	xa_erase(&ndev->cert_comp_xa, cert_comp->msix_idx);
-	free_irq(cert_comp->irq, cert_comp);
+	aie4_free_notification(cert_comp);
 	kfree(cert_comp);
 }
 
@@ -100,6 +89,7 @@ static void aie4_put_cert_comp(struct cert_comp *cert_comp)
 
 	ndev = cert_comp->ndev;
 	guard(mutex)(&ndev->cert_comp_lock);
+
 	kref_put(&cert_comp->kref, cert_comp_release);
 }
 
diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
index ffe78c0c4e8b..93594211c169 100644
--- a/drivers/accel/amdxdna/aie4_pci.c
+++ b/drivers/accel/amdxdna/aie4_pci.c
@@ -14,6 +14,7 @@
 
 #include "aie.h"
 #include "aie4_msg_priv.h"
+#include "amdxdna_ctx.h"
 #include "aie4_pci.h"
 #include "amdxdna_error.h"
 #include "amdxdna_mailbox.h"
@@ -112,6 +113,69 @@ static void aie4_mailbox_fini(struct amdxdna_dev_hdl *ndev)
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
@@ -630,6 +694,7 @@ static int aie4m_pcidev_init(struct amdxdna_dev *xdna)
 		set_bit(SMU_REG_BAR(ndev, i), &bars);
 	set_bit(xdna->dev_info->mbox_bar, &bars);
 	set_bit(xdna->dev_info->sram_bar, &bars);
+	set_bit(xdna->dev_info->doorbell_bar, &bars);
 
 	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
 		if (!test_bit(i, &bars))
@@ -643,6 +708,7 @@ static int aie4m_pcidev_init(struct amdxdna_dev *xdna)
 
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

