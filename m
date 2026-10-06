Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B1A0CA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 04:23:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9129F10EF7E;
	Tue,  6 Oct 2026 04:23:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vqEndoZ0";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010037.outbound.protection.outlook.com [52.101.85.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6E5610EF77
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 04:23:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F46zMIEUiNlcm3pZ6NhxA9U/gx7MpdvyF5eBeF447cuXqs4int1PGIU7rGKOMy5IRUTchIjJGa/iIFJIzAvm7uBnxfHkrIz2Gw3jO86wWUD+g8qp2Bkd2RXqmY7sQ8vr6L7uu+hcZWDxcJWXtyS2ArCqsEZz/5xHS+AddkdQdIp5L6tXmFiT8JhoAr1jkeT23iwzFXwFLP7HZQ2KB3kzIEfPh9mPp9RGD174MwtN6C+xSeMwm3UBoe1jglD8gozwJdTccnV4X8KBkIbL3Zr7b5rc2jR+qdeLzCc6MY2d/7ePINXZDbUGB67PCHjBD1yw777PL3aMAGbduSGuKi83zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6kT1V10J0juX0MUrt1dPNrHILoraQWzQ/10kwy+yfVo=;
 b=ZSGqNTFAeMVPXgt5ppzVX6NjOdogHDvjjM2B9GlWcNfuRxZR8xGFH1JH4rcVTyujkKWuwl4/BgfdBgy0CDjZZpCKq7G/V9Gr25GzITlqg+zB5i0D7beUgdbL0/fdLXZtYCHmtMFapO3YTDNeOLTunPcMtIWS8HyhC8uQHYqNQ36F7871nZX0USVhaiGyn7IDGTkWLhiwT/sLrE3VSEqozOSAIjnAyTMyFugcWNDyYtSlDEsM7FFkN/VlW+hg2XuV1pgbejWaNvmX6aknm1rJhZjbAlJyW7GD/J9NA4p09+3eOYBTr8jtf5cuX+cGf2N5unsurXdiUYS1NOAkHr7/9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kT1V10J0juX0MUrt1dPNrHILoraQWzQ/10kwy+yfVo=;
 b=vqEndoZ0CePJVIYZUU2iDTCBAxoBN10gs57Y2ZM4KcHSV6CeMptefbdbcxCb3tqfLymtEL7WkGxDRuRdOiFOs/PtJqwm8zTcyGjR4fjXo8plP0Fw0y/boSNwFNdfXqrz76etkJuZCdsX2ACipvnBc51IwpmEUxZ05utzd4pFbkU=
Received: from BN0PR02CA0048.namprd02.prod.outlook.com (2603:10b6:408:e5::23)
 by SA1PR12MB8723.namprd12.prod.outlook.com (2603:10b6:806:385::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Tue, 6 Oct
 2026 04:22:59 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:e5:cafe::93) by BN0PR02CA0048.outlook.office365.com
 (2603:10b6:408:e5::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue, 6
 Oct 2026 04:22:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 04:22:59 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 23:22:55 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 23:22:55 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Mon, 5 Oct 2026 23:22:54 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>, Wendy Liang <wendy.liang@amd.com>
Subject: [PATCH V2 11/20] accel/amdxdna: Decouple AIE4 doorbell and MSI-X
 notify transport hooks
Date: Mon, 5 Oct 2026 21:22:21 -0700
Message-ID: <20261006042230.547807-12-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261006042230.547807-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261006042230.547807-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|SA1PR12MB8723:EE_
X-MS-Office365-Filtering-Correlation-Id: 80422e86-be0e-41a4-83bd-08df236180f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|23010399003|1800799024|10067099003|56012099006|4143699003|5023799004|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Pf97VM66yKnGA7SoruzyR3PnOqY8ujwPgFZ0tskEYSBqMhhvRqT3WN/YtBo2DAikWu3PV0wcjSa2QsSxk5hNzoi5uvWOM0RQQSWDmF8Msot9hhD9Fvc8r/LqSC6Zrzee38lSru54iDB7t4xHaJ6QixFUx+es0cN4PmfS1zXruiP8o62k9YUUCqfEsZyIAk++/XjyVfLiEUc9dswtMkvxLfGgxzq1dywQehZyoeXSzhxIKYVyZBgzWuvztH1FE2sq6IIQcUvzWbrt28RaJR6cyVQ899Nl0xQm+Ta0uj7B7P7gLDaC3b6jGnLPYZVz+fKSJqBw20jIfwXrouXhAhmUkciFfD0GYh97b3mdlU3ORAETkIqgB+pj3X3QghycTfEPySGUI9xOtxfQmqZepUEE147a8Olf+GYwEOnZl8ohtkkVEONhXTTTgVRxgy0a5ut4TvD2NSSQ4PbNgN8k7Y4zeh4IPWlRZ6j0d+83jdelMCkVHRUlkiMKAxkv20Gcf7KEmOlGIWJOwaPLHmYQmX83k6NuzygQl3I0Dq4yywVv5vfnDqjKBi6LcDmzOxDVVJssk7+WMTTbkd5VCQqHC55f7LETCSuFaiYynZCKCBZcVhRPl+vQs42l3C1B4f4JA98pAnlZPfg3vl/0E7RURv9ijP+BAqLAhgIFFCCZWjRiXGrKsAnh5myVpA//3Z9AEm6pVAQEXf0dDu/Qhm12YmKYUg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(23010399003)(1800799024)(10067099003)(56012099006)(4143699003)(5023799004)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zYNidhgewliwIXzZcJHb33P6WmBOrFeryeatS2x6Cn+fZgDfj8SM65QNvJdOtG8mof7otq/DXMePMr2lH6C+FT8XbXdvussC+GmpzNFv1bN/Caj8+GWf9NF8Ax2uiZ6YoKciF4astK9QWUGstkVEj4bw1U9/cL4/R9RkwwWNQjrY/OzDaMGE/Bjb9BwyrvjrsbXXC+v0CEe+u70LmwLLf4+IxsI8v3JyGEjB07i0jFyEyRrntHCz5FOlglbewpdP19aQxKiUxvLr+z6lzZmKLkEpXQNw+lLlpwUhwt4tLkacU9dbEUIXpyBzPynq2DwBreo+PS8QuvJbM8zQ8cLpKJxVgUHUEVh8q8lUL38cNzd78RjC+f14wcrW7NO0HPcnznWyFefv3K/tvfv7R2bDTYIbrB4YKpvrAEQJUna+zcs/ryMP5weryOrKzsTM7ja5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 04:22:59.2058 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80422e86-be0e-41a4-83bd-08df236180f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8723
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
index 4a5f30b42743..9d970d4da435 100644
--- a/drivers/accel/amdxdna/aie4_pci.c
+++ b/drivers/accel/amdxdna/aie4_pci.c
@@ -14,6 +14,7 @@
 
 #include "aie.h"
 #include "aie4_msg_priv.h"
+#include "amdxdna_ctx.h"
 #include "aie4_pci.h"
 #include "amdxdna_mailbox.h"
 #include "amdxdna_mailbox_helper.h"
@@ -110,6 +111,69 @@ static void aie4_mailbox_fini(struct amdxdna_dev_hdl *ndev)
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
@@ -623,6 +687,7 @@ static int aie4m_pcidev_init(struct amdxdna_dev *xdna)
 		set_bit(SMU_REG_BAR(ndev, i), &bars);
 	set_bit(xdna->dev_info->mbox_bar, &bars);
 	set_bit(xdna->dev_info->sram_bar, &bars);
+	set_bit(xdna->dev_info->doorbell_bar, &bars);
 
 	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
 		if (!test_bit(i, &bars))
@@ -636,6 +701,7 @@ static int aie4m_pcidev_init(struct amdxdna_dev *xdna)
 
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

