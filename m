Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 831FEC9832A
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 01:36:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D99810FD12;
	Sat, 26 Sep 2026 01:36:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B9EJPonK";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013015.outbound.protection.outlook.com
 [40.107.201.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 833E610FD10
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 01:35:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eo90L98bw2ngCYLBBUDOOuOE5oG1oac61lSYroJxmxzz9T88cV1oZDkqVXzIcjaajZGcwv6g7tKdPfcjksYTiuWBpLu3907IdAtMB7NYEZIff94kKcIqhUzmSrFujQGLptQo5AoLI/6mlQonhC1jcYIsvStZd0Pz/P5Gwynw5d0sWZuV6DQp6zI72xGd4U+aMYv0rtrKzOd2BqrIymRkXuWnlr29sKYktiRQoHikl6St953n35Y01i7FBsrNR+rxACVvjN4lJhw7UCvjig27opcpXx/iLGCv0wKxEjgR2ejaGgbMvf6BRNyLCiy8sBT13NpH4umJ48F4aWoivOZuWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PHKUUYuDAGPzvYJGhUpXIkyUbtijIoGAOPzhnAF9Ncc=;
 b=caz243q/R55eiAAMHRaTZmwq3rXk+6kEMJ0e5vQeF14pJy43UU7R7UneDHqYs1g5egETnd+DhALzzOmqG7vKtKpHhIwWQxT7RfzgN7J/tzE0PQRLiGDI+121s/woNfmsU4KeCcf61ItuuwprojafjkgorPZik65BxZ+WT7bXKoaEZUkQkITha15s/gewIwQTeHlC0Y0yb4C+khYmvuHxQjNL+AE/rwPHkdOPCMEFKPXv4gHJWnigqG8AT/he9WrgKbix2yHl/3GTg8+OnTw/yvnnZo/teT8DsYqLzrt7dbH97zhfagwzsq6dRf5m0f1nMU+NMY5DDujwHnNXjlvvmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHKUUYuDAGPzvYJGhUpXIkyUbtijIoGAOPzhnAF9Ncc=;
 b=B9EJPonKj3LJ0vgR7NW6Ibu46JkCo1hfC8Y737V1alsaFOuuLofyHLyM88rH7ZdVoRq/N/dmuL+n4ECIhaKyloHrFGawaCJxc7ADr6M7LtOP68p1gGVPan21VlXMmPtg+I/1WaOUClAlCsIdyjdUVfR/3vlPJ711DSSVmATQGfo=
Received: from BN9PR03CA0783.namprd03.prod.outlook.com (2603:10b6:408:13f::8)
 by BL1PR12MB5755.namprd12.prod.outlook.com (2603:10b6:208:392::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Sat, 26 Sep
 2026 01:35:34 +0000
Received: from BN2PEPF0000A801.namprd02.prod.outlook.com
 (2603:10b6:408:13f:cafe::40) by BN9PR03CA0783.outlook.office365.com
 (2603:10b6:408:13f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Sat,
 26 Sep 2026 01:35:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A801.mail.protection.outlook.com (10.167.245.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Sat, 26 Sep 2026 01:35:34 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 25 Sep
 2026 20:35:27 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Fri, 25 Sep 2026 20:35:26 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>, Wendy Liang <wendy.liang@amd.com>
Subject: [PATCH V0 12/21] accel/amdxdna: Decouple AIE4 doorbell and MSI-X
 notification transport hooks
Date: Fri, 25 Sep 2026 18:34:39 -0700
Message-ID: <20260926013448.3840921-13-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260926013448.3840921-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20260926013448.3840921-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A801:EE_|BL1PR12MB5755:EE_
X-MS-Office365-Filtering-Correlation-Id: aa7e84be-7cfc-496b-5262-08df1b6e75a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|10067099003|56012099006|6133799003|18002099003|22082099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: D50umme44NYlIMpIZFBCiUCh2lESv8NXnRlSA0OfkrSVMYbSLG6sT/MZtcbOMFAbYY82QgDBZM4Rzvqxwu4qCdmxnhIFcHOIIsP2A/iL7HbwJtM6vEJtEOHQjQlZ6cRogiPtKtaf1AaFaptPCe6NlRLPH4eC/MYR0+2i5WbpLHDs3ZX2rqlhzYs6Xwur1rNi0SNmEkwkr8mCrgGmg6yoEvQnX34m1ctkBqeHojd/EYll21chLxtX3pEs364/X02BiR+e7wX9dBb2b4zc/FvkEdjcS1SqnKoOUXRI7OpoS353AQCYeuk4ldp1UNKhhL90DlofOKc9d6RYfYE26/YWZuXa2LQSdX0qJQyWhbKLrQOiGHTWMIQvPudue1ezoVayngxqtNxfNd+N8WNl8J2nPbqZA0zBeTts7Z05M0Do5TCaKcco9FPydwBj9GVPs2L41i6Rc7hR8jnKsLhiZ/BdESXVA+GFW6BePegwez5/hB1tKdldZwTD9s8wHcgXho0d+bPgCRKQ1991jKyFR3WK0kRLDN1w6v2JqbPBUyhjf5zGNm9XUpfjMqBbwhWxpM9wigRhD5q7pH9IaxsqNA23vCCle/hDeSS3WAA5GLvn7yw1pZf61t2ZEIU5dlaSie4+6yHhpDTiz57YklAssTca1UMI/jAMgVF5FO0DJ/pMeUnt+YvUbi63496cPZRKYmGlXnljQwowM7Oyuqbwm9Z8vg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: URBpBfa+Pej4piKem7Vo8bM14DOIM1yC+3QaSBnAdQHpa/TGAGwBn8M8H+NxAHuX8x3TJ0wWS4+G7Btq1gsBoWjrrRdCfqhMYslfsIqZOBEpyyXHZPoVJX31nj0pcvkOvzWDIHkQiZ1CfF40bxyF3ci4y7tznQRVe6Fy4z/N9utYPzq7HF68reLjqPKtKbmhOwZDjtxtVMhhqW8eMRypOAoCWwZUCdbvNj0CHaHLIzgUph9NbUR29K80TKZRK+Pzx0mm3xqAVgOdSckEBf65Y9v0BWuIdC8T4WiwucyhR4scUspNk7syEzZxU3guqq4SlkaRshe1jQ3hWJuwoboc7Gwpr8cnMO8I+54T3rwfCwML/CqqIdevPrSyz5DfAEbj6ACe6/sfZpDkjmKJRVOq9EpyocMMcN5uuvbOBNK1M/sd8r77IkFr42iZSO0Hefzo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2026 01:35:34.3505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa7e84be-7cfc-496b-5262-08df1b6e75a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A801.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5755
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
index 90da4e8c4f54..fba4ef25ffbe 100644
--- a/drivers/accel/amdxdna/aie4_ctx.c
+++ b/drivers/accel/amdxdna/aie4_ctx.c
@@ -21,18 +21,9 @@
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
 
@@ -50,32 +41,27 @@ static struct cert_comp *aie4_lookup_cert_comp(struct amdxdna_dev_hdl *ndev, u32
 
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
@@ -89,7 +75,7 @@ static void cert_comp_release(struct kref *kref)
 	drm_WARN_ON(&ndev->aie.xdna->ddev, !mutex_is_locked(&ndev->cert_comp_lock));
 
 	xa_erase(&ndev->cert_comp_xa, cert_comp->msix_idx);
-	free_irq(cert_comp->irq, cert_comp);
+	aie4_free_notification(cert_comp);
 	kfree(cert_comp);
 }
 
@@ -99,6 +85,7 @@ static void aie4_put_cert_comp(struct cert_comp *cert_comp)
 
 	ndev = cert_comp->ndev;
 	guard(mutex)(&ndev->cert_comp_lock);
+
 	kref_put(&cert_comp->kref, cert_comp_release);
 }
 
diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
index 1e2b120c4972..7b36bd001b64 100644
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
index 6e78bab8a02c..1529e7507fed 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.h
+++ b/drivers/accel/amdxdna/amdxdna_ctx.h
@@ -6,9 +6,11 @@
 #ifndef _AMDXDNA_CTX_H_
 #define _AMDXDNA_CTX_H_
 
+#include <drm/gpu_scheduler.h>
 #include <linux/bitfield.h>
 
 #include "amdxdna_gem.h"
+#include "drm/amdxdna_accel.h"
 
 struct amdxdna_hwctx_priv;
 
-- 
2.34.1

