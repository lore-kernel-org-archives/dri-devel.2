Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B206FC9830E
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 03:33:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8DED10E9F6;
	Wed, 30 Sep 2026 03:33:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fIEWmPWD";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010011.outbound.protection.outlook.com [52.101.85.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 009A310E9E0
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 03:33:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mo1mil58jjt6WE5+qNiOQfo45z1comNYc61KiAtKiI6irrfONaJqC1SJLJeVG9o0BHqt3PmTwDtmQGfu7QivgKFAxAItkesB5Z6CUvgpR4vyrnuSLRFxjqVgaO6FhgDcEjp0rOHR7/PNmeCqUO0SLErz0Ha4PrjVi4GiQAUgoQ9AnLPK60544XTVsWMsB9sAB6byX0b6IA35ikVf8Ku8l1SE0rqzUumzvuXvWzWkXD8f6OEcRr5hHqRG6kZcZxqO3qjfrKqcpKBdCTUNREPokPtgGGKZPijonWF+vmGbh3Amu6rp7hXdtJ7akvAZlsngFi37Vy/9STEsaiDtbdhLzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGavhoDndKOWV94xN/onfIEZPe36omQhIeKEBedtJZE=;
 b=BOcAGegctsxIO1a3i7LxjRXDtbvIjiNeJ+BmDMVi3eoQOsyn2IDPwPEagkuRKIBw/CxjIaxqzVicE0QNS5RR/Pr4Syln12SSAuJohCK4IFjGN8h11KXatmMSpr3as5j3n67oYoQJTgqvBb3NSGXtbmAq2F1+VKhIcaxRuuB+VIT8i2A/L47NEj5/Wwx9DbpjGNIjglbdS47srcDvX97yd0PUGSleG3YppLUKjYELkDbvLDPThaPST0ZyaHn2bNnQ3DF1KjOlcxjoqRXIc950t8xN6yGcNPus7THhtms7CyoC63LEUN2RRCXoqTi6AQjk0jamt8PrBMxdgL9edR3hfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGavhoDndKOWV94xN/onfIEZPe36omQhIeKEBedtJZE=;
 b=fIEWmPWDyRltRieuR5a3JLgwptXPMYYx1MGA+UH5Q5+XvKgkB5cSBwWodW3zsWDVYRTVCPQt9D4MKj4hqZfMmIBDUaIxV2cKJFaaRgtRZY9vEACc4n4x/ZSP4wr6b3uBCNavQ2+t596bBOS0S/b74YyLcQ25MV7sSQIZxb3XD4M=
Received: from SJ0PR05CA0029.namprd05.prod.outlook.com (2603:10b6:a03:33b::34)
 by CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Wed, 30 Sep
 2026 03:33:04 +0000
Received: from SJ1PEPF00002323.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::2c) by SJ0PR05CA0029.outlook.office365.com
 (2603:10b6:a03:33b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.11 via Frontend Transport; Wed,
 30 Sep 2026 03:33:04 +0000
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
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 03:33:04 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 22:32:58 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Tue, 29 Sep 2026 22:32:58 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>, Wendy Liang <wendy.liang@amd.com>
Subject: [PATCH V1 11/20] accel/amdxdna: Decouple AIE4 doorbell and MSI-X
 notification transport hooks
Date: Tue, 29 Sep 2026 20:32:24 -0700
Message-ID: <20260930033233.1727265-12-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930033233.1727265-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20260930033233.1727265-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002323:EE_|CH2PR12MB4133:EE_
X-MS-Office365-Filtering-Correlation-Id: aa746b17-838e-441a-4fcb-08df1ea3894f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|18002099003|6133799003|10067099003|56012099006|11063799006|4143699003|22082099003;
X-Microsoft-Antispam-Message-Info: ac0gSZgV2erAIFxc5uWUzg7WGJtDi7YZyYtXxsEKt3cjJZ+IV5lgYMHJsIu/7+ijW0iaqyJYzIAK5aSvZpVsFMXrH5LeQoWDwsl+0vQvECei4dd3qAP15jIpbSMwHjzwgqeU9v26kQROm8yaIaDV3vkRqin5z/h83xnKCYaQf1nVLTDP3V0w3QyCZcG86Wu5Zy+VRCCZJjUYmmIw2ppJYQNeTVCIrgyKF2QHyNa41hW3V42Jsourr2trNZHpNypAHGged031eboIJRXszmK01oW8OjK+AZauf/B7Jz1NdDKBSJ/DNdb0Fy8hdKaN0ZiJNQDdiU4qRKi0LHZDpukmWOlOVFdfDNEVuiq5cKkId4VgZVK9h4JzNcXPqCCb8TDefb1lSwYVkatq8z5FYpbFVOBN5G8X4FaHfbMm1e6OWY/qf0Z1XSM8eB1TvJ73d/l8bTgfqXeSzyUKT7WS7hbhNxycJMmI/3NZXfP3Bz4Hy7wVG1YdItLOvU8ohSEtSclLDt705mDfevPhiscJokFti+HEKrOZcOm7oQlmoKmYf8nER8mviFbW/NlWrbJCE/eHOmc49eW3/wTC3LV3KLg1cj1q+6NgO25Dxri41mXapruNT/DDBBZUhwKzkGn6xMm+IeP3MUAo4br/N6l7Y1H2NuBpO1RVvQ79kQ7VYHZY6D9VG3fITg6ZSlUl0Qgrcg6GbjEqDNLCD3SFYWmmILn4Xw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(18002099003)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ou8kKJAIcwqZp3YBQKS7Hb/CCwUjZjiRYrhGPXY+BaUCr7hvSEV/Xk3aSbgIEHcORNpt9yREdMOG0AgacUzJC2Swh5cx5kznfcz4K8SAZRC5R4OkXQRxs+VZwOag2crq3O797cZxjUA5M+NZFZvCXdfXbt6BKX+Kxhmohw0HBjFn1glc5VX13RoqqtDJ6z1RUbBpDfvbtyjVidSqreoMP+a9Yt/TX3fbIup5dY2gw7cLujrSB5XE2NkEQyOKTO9/QDW+wGN/5w8t46KnuGlO33pes1F9SFY/a/DsKq2pn9zB4cSkD3cul7Dzkzgd3I6+3sQucnWBcE2aIU9rh5eBBvnsfSBj8p+UYXL0T4HrY130c9Tj3gAu0jTFX2/oQ57G7ZYoV9uy9BYnN0p6KhhqHeoeq94ZckQYl3RXzfi9t6tWPOf5BHBVd5LQKKFIjSRj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 03:33:04.1073 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa746b17-838e-441a-4fcb-08df1ea3894f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002323.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4133
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
the transport-neutral context code:
- Move MSI-X ISR and registration out of aie4_ctx.c into transport hooks
  aie4_request_notification() and aie4_free_notification() in aie4_pci.c.
- Add transport hooks aie4_doorbell_setup() and aie4_doorbell_ring() to
  validate the doorbell offset against the mapped doorbell BAR and ring
  the hardware doorbell.
- Map the doorbell BAR (BAR 2) via pcim_iomap() in aie4m_pcidev_init()
  and record ndev->doorbell_base. The doorbells are used exclusively by
  kernel submit driver on VF and classic devices. PF devices only perform
  management functions, and never host hardware contexts, thus never use
  the doorbells.

Co-developed-by: Wendy Liang <wendy.liang@amd.com>
Signed-off-by: Wendy Liang <wendy.liang@amd.com>
Signed-off-by: David Zhang <yidong.zhang@amd.com>
---
 drivers/accel/amdxdna/aie4_ctx.c    | 29 +++--------
 drivers/accel/amdxdna/aie4_pci.c    | 79 +++++++++++++++++++++++++++++
 drivers/accel/amdxdna/aie4_pci.h    | 18 +++++++
 drivers/accel/amdxdna/amdxdna_ctx.h |  2 +
 4 files changed, 107 insertions(+), 21 deletions(-)

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
index b1742116bedd..f5fdc24689f8 100644
--- a/drivers/accel/amdxdna/aie4_pci.c
+++ b/drivers/accel/amdxdna/aie4_pci.c
@@ -14,6 +14,7 @@
 
 #include "aie.h"
 #include "aie4_msg_priv.h"
+#include "amdxdna_ctx.h"
 #include "aie4_pci.h"
 #include "amdxdna_mailbox.h"
 #include "amdxdna_mailbox_helper.h"
@@ -110,6 +111,82 @@ static void aie4_mailbox_fini(struct amdxdna_dev_hdl *ndev)
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
+/*
+ * Transport hook: wire the per-cert completion notification.  PCI maps the
+ * firmware-provided MSI-X index to a Linux irq and registers cert_comp_isr;
+ * the platform build registers an IPI mailbox callback instead.
+ */
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
+/* Transport hook: tear down the completion notification wired by the hook above. */
+void aie4_free_notification(struct cert_comp *comp)
+{
+	if (comp->irq >= 0)
+		free_irq(comp->irq, comp);
+}
+
+/*
+ * Transport hook: take what this transport needs from the create-context
+ * response.  PCI validates the firmware-provided doorbell offset against the
+ * mapped doorbell BAR and stores this context's kick target.
+ */
+int aie4_doorbell_setup(struct amdxdna_hwctx *hwctx,
+			const struct aie4_msg_create_hw_context_resp *resp)
+{
+	struct amdxdna_dev *xdna = hwctx->client->xdna;
+	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
+	struct amdxdna_hwctx_priv *priv = hwctx->priv;
+	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
+	u64 db_off = (u64)ndev->priv->doorbell_off + resp->doorbell_offset;
+
+	/*
+	 * doorbell_base is a pcim_iomap() of the whole doorbell BAR.  The offset
+	 * comes from firmware (or, on a VF, the PF/hypervisor); reject one that
+	 * would place the u32 doorbell write past the mapped BAR before
+	 * aie4_doorbell_ring() ever dereferences priv->doorbell_addr.
+	 */
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
+/* Transport hook: ring this context's doorbell (kick CERT). */
+void aie4_doorbell_ring(struct amdxdna_hwctx *hwctx)
+{
+	writel(0, hwctx->priv->doorbell_addr);
+}
+
 static int aie4_irq_init(struct amdxdna_dev *xdna)
 {
 	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
@@ -634,6 +711,7 @@ static int aie4m_pcidev_init(struct amdxdna_dev *xdna)
 		set_bit(SMU_REG_BAR(ndev, i), &bars);
 	set_bit(xdna->dev_info->mbox_bar, &bars);
 	set_bit(xdna->dev_info->sram_bar, &bars);
+	set_bit(xdna->dev_info->doorbell_bar, &bars);
 
 	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
 		if (!test_bit(i, &bars))
@@ -647,6 +725,7 @@ static int aie4m_pcidev_init(struct amdxdna_dev *xdna)
 
 	ndev->mbox_base = tbl[xdna->dev_info->mbox_bar];
 	ndev->rbuf_base = tbl[xdna->dev_info->sram_bar];
+	ndev->doorbell_base = tbl[xdna->dev_info->doorbell_bar];
 
 	pci_set_master(pdev);
 
diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
index 063cedfe3c9d..c6e7f6a80f69 100644
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
@@ -114,6 +117,21 @@ int aie4_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq, u32 timeout);
 /* aie4_pci.c */
 int aie4_restore_power_mode(struct amdxdna_dev_hdl *ndev);
 
+/*
+ * Transport hooks: one definition per build (aie4_pci.c for PCI; a future
+ * OF/platform transport provides its own), selected at compile time.  aie4_ctx.c is
+ * transport-neutral and reaches the doorbell kick and the completion interrupt
+ * only through these.  The cert_comp object itself (allocation/xarray/kref/
+ * waitq) is firmware-driven and stays neutral in aie4_ctx.c; only the notification
+ * wiring (PCI MSI-X vs platform IPI callback) is transport-specific.
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

