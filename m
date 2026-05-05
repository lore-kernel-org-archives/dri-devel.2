Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89019FF8855
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 16:10:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE2B610E469;
	Tue,  5 May 2026 16:10:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4jaKmDo4";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011026.outbound.protection.outlook.com
 [40.93.194.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EE2A10E468
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 16:10:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oXIPrB6msMpo5zXsrH3tM8S9xKI+FH1xE3Y4HjeRRjD0bIRz8B3VN+KoJHvq3MpxgbhzRna4dBwvBV/TYPyDvyncrTRAPk0mSnaF6oySmiBzrhpAEDcmFIcmrFaoaevtfC+uVi+VBlsNEiqZD82mOQ/N3ToYsYnbvKrrSuTD3lYTc5sFSUvjAhSx+GotpXowqtseyNuQInGJhhKCvTNC5khKNb8l+ZW5HaSjhu7VRZfcQppVxU9HEBSzXLZYDddUH3Pg8lTsU801LmHwLdJgGOf6JDxSpFR7CqVeWLfDRAsXBNuO6SlcnXML7tMF1b2gvnPPmAilX0llQI23rIyErQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24o+BN7ZolTz0ZiGXJ2doKTr9r6RKop11Cj7qeFUOCA=;
 b=cPAYc46l8ZgRdUBmMdPrsPH/w2LjGLUy748G2UkgV2NK/sfqknwR++Pyb8xMsA5t/uJhf1vwq1G2E+PKDN1OG6KeBp+4Uer5mHs150ZBmBg/uOh0u2p5RSJGEztUEe5NRqyXq5tlSew4QUZ8g1VNt33v6I19dV1gCkoWh8TByIdAYuzIMJkJuQgAjYxr97tvM7ikJhT80gYzQODo9jSjm1YzKxZ0GQk+uB6jrSku/rNWGoejCLh6+q9v4Y+y6fPXfJhGlF0XlbuEsnvzi8icJGWevOAvd43BEtW8jt1Qf6KvtzNT+m+rdjDCpTkJNohX9VerGx99LTfKpXlRKaSFmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24o+BN7ZolTz0ZiGXJ2doKTr9r6RKop11Cj7qeFUOCA=;
 b=4jaKmDo4iW6+U+ZK8AHIu0EARA5YLasqiuNj7KU7/YUQBwhvo+6tQ+e7ukQNzCxoWgb4SSuDVe6YRIblYiTDbAdF4HN9F2G36HFQliNuISV6Z19xe9X9uSG3a46GqlRAR44dtU0eHcK4xoKMg6w1sQCr0ehROS+LRzkaSh36zjA=
Received: from PH7P220CA0100.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::14)
 by LV3PR12MB9437.namprd12.prod.outlook.com (2603:10b6:408:21d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 16:10:37 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:510:32d:cafe::35) by PH7P220CA0100.outlook.office365.com
 (2603:10b6:510:32d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Tue,
 5 May 2026 16:10:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 16:10:37 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 5 May
 2026 11:10:23 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 May
 2026 11:09:46 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 5 May 2026 11:09:45 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>
CC: David Zhang <yidong.zhang@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>, Hayden Laccabue
 <Hayden.Laccabue@amd.com>, Lizhi Hou <lizhi.hou@amd.com>
Subject: [PATCH V1 3/6] accel/amdxdna: Add AIE4 VF hardware context create and
 destroy
Date: Tue, 5 May 2026 09:09:33 -0700
Message-ID: <20260505160936.3917732-4-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505160936.3917732-1-lizhi.hou@amd.com>
References: <20260505160936.3917732-1-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|LV3PR12MB9437:EE_
X-MS-Office365-Filtering-Correlation-Id: 78ffaf26-4dd6-4ece-db85-08deaac0d86b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 6nk7vDIire1Bpb2q1xywxRkPvaUoLEDVrwaYXURkYPiAV7SAobRjVokoY9aCxGfN+T/NZ4ChbvOiSZOwXeObXAAuCFRXUXP3J+hm7svW05ieEEqOW/jie5tGppciBnmCpVSy0lc0o+SvhdSwLHAJy6InWaZQeJqjTuP/kG8LJKloAexUSF3X+o5YjzJXUeEHWMBbFeudPjoUOAXS2wCQrSswAAWLZkWIxuq9+L/R4+KA8lPBaoYAIKCxpvBy+BgR/LUBdul7zC1CCx4vepRWpCr5pjsfB8upJ41oXW8fiQVhlxerzjtYaGvXshrIo3V0N93BJOFnX9WJXR3ysx4duqQgy9QqUg71KkCJriJmmXqH6GoHPctX2iNI5I8rvLxxaTOUKVVTBEqY1dWiiGqD0fQfVgijt44Zu6CpCH6hGATBZUR0TTmWtXEDzIVMMwb+Dxvl0vgZwa6j9vzMmA4hNARGObV7Dq0oEI7uEWiYo5uhM6hGRRaSF1mQoHscnZ7DrxwlgX9MY+6epZ4PVMHMgaFprba8zA2uOJrj8IHteNxXpjDLpMb2c5T+9d+xvn3iKS2B9xZeqib4AARHbnfJ10C957AFWgUsdgdJb3FFjPIzQY178XJjo87rFwCLc8f7gxrZfLtVDrLmEaFZej8SGZAXeAEZcdN+eb5PJx7nMWH7no43UJJSJLCWLZsVSOodVN/3uT2Tq35BKbvs1XFQHb9ee6uM3J583+nTwUi5A68=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: a2MB6/mfhaI8zAi/4lME7TMsi9tWE6ZiCfMw2aQ0ySwEO9ywqFKxrxU3VVcUIeW8eIM8Y/m6MS7xN6TbLLL5IyUxX/zrdozyWOeDGEBqfNhXRTxrBsDRCcYdoZ0z9lIQ6XrFSUpmmARXKXSFFXWHuXq64RaWJoLlQkvHmXk8vXyDz8BMAw7bq2CxXtcn0EYFZ234TNJyYj89XaelahD5L/+OhFqL+PtvHJGTSQhuSHPvaiL09Gvm/QPbheTx7y5Q1y0HUTzGkRjq2AanEc/ks4NAzt/V67geaF15BgPUyt7SnKXYTn5glnfvRz1gxFNK1MAeT0205kEP0xLfq2ZGc/PkC/0qFNL1+lVZqpbn+IO5pPWWPM1TLLVKvW03itiyHdwLZC4cInj698zi/KpxQJmUtJYDoLpEF7J5jy8gTTmmYsT0pvivD93HyqTRodLg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 16:10:37.3709 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ffaf26-4dd6-4ece-db85-08deaac0d86b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9437
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

From: David Zhang <yidong.zhang@amd.com>

Implement hardware context creation and destruction for AIE4 VF devices.

Co-developed-by: Hayden Laccabue <Hayden.Laccabue@amd.com>
Signed-off-by: Hayden Laccabue <Hayden.Laccabue@amd.com>
Signed-off-by: David Zhang <yidong.zhang@amd.com>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/Makefile          |   1 +
 drivers/accel/amdxdna/aie4_ctx.c        | 258 ++++++++++++++++++++++++
 drivers/accel/amdxdna/aie4_host_queue.h |  22 ++
 drivers/accel/amdxdna/aie4_msg_priv.h   |  29 +++
 drivers/accel/amdxdna/aie4_pci.c        |   5 +
 drivers/accel/amdxdna/aie4_pci.h        |  24 +++
 drivers/accel/amdxdna/amdxdna_ctx.c     |   6 +
 drivers/accel/amdxdna/amdxdna_ctx.h     |   3 +
 include/uapi/drm/amdxdna_accel.h        |   1 +
 9 files changed, 349 insertions(+)
 create mode 100644 drivers/accel/amdxdna/aie4_ctx.c
 create mode 100644 drivers/accel/amdxdna/aie4_host_queue.h

diff --git a/drivers/accel/amdxdna/Makefile b/drivers/accel/amdxdna/Makefile
index d7720c8c8a98..05cce0a38692 100644
--- a/drivers/accel/amdxdna/Makefile
+++ b/drivers/accel/amdxdna/Makefile
@@ -10,6 +10,7 @@ amdxdna-y := \
 	aie2_pci.o \
 	aie2_pm.o \
 	aie2_solver.o \
+	aie4_ctx.o \
 	aie4_message.o \
 	aie4_pci.o \
 	amdxdna_cbuf.o \
diff --git a/drivers/accel/amdxdna/aie4_ctx.c b/drivers/accel/amdxdna/aie4_ctx.c
new file mode 100644
index 000000000000..84ac706d0ffb
--- /dev/null
+++ b/drivers/accel/amdxdna/aie4_ctx.c
@@ -0,0 +1,258 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026, Advanced Micro Devices, Inc.
+ */
+
+#include <drm/amdxdna_accel.h>
+#include <drm/drm_device.h>
+#include <drm/drm_gem.h>
+#include <drm/drm_gem_shmem_helper.h>
+#include <drm/drm_print.h>
+#include <drm/gpu_scheduler.h>
+#include <linux/types.h>
+
+#include "aie.h"
+#include "aie4_host_queue.h"
+#include "aie4_msg_priv.h"
+#include "aie4_pci.h"
+#include "amdxdna_ctx.h"
+#include "amdxdna_gem.h"
+#include "amdxdna_mailbox.h"
+#include "amdxdna_mailbox_helper.h"
+#include "amdxdna_pci_drv.h"
+
+static irqreturn_t cert_comp_isr(int irq, void *p)
+{
+	struct cert_comp *cert_comp = p;
+
+	wake_up_all(&cert_comp->waitq);
+	return IRQ_HANDLED;
+}
+
+static struct cert_comp *aie4_lookup_cert_comp(struct amdxdna_dev_hdl *ndev, u32 msix_idx)
+{
+	struct amdxdna_dev *xdna = ndev->aie.xdna;
+	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
+	struct cert_comp *cert_comp;
+	int ret;
+
+	guard(mutex)(&ndev->cert_comp_lock);
+
+	cert_comp = xa_load(&ndev->cert_comp_xa, msix_idx);
+	if (cert_comp) {
+		kref_get(&cert_comp->kref);
+		return cert_comp;
+	}
+
+	cert_comp = kzalloc_obj(*cert_comp);
+	if (!cert_comp)
+		return NULL;
+
+	cert_comp->ndev = ndev;
+	cert_comp->msix_idx = msix_idx;
+	init_waitqueue_head(&cert_comp->waitq);
+	kref_init(&cert_comp->kref);
+
+	ret = pci_irq_vector(pdev, cert_comp->msix_idx);
+	if (ret < 0) {
+		XDNA_ERR(xdna, "MSI-X idx %u is invalid, ret:%d", msix_idx, ret);
+		goto free_cert_comp;
+	}
+	cert_comp->irq = ret;
+
+	ret = request_irq(cert_comp->irq, cert_comp_isr, 0, "xdna_hsa", cert_comp);
+	if (ret) {
+		XDNA_ERR(xdna, "request irq %d failed %d", cert_comp->irq, ret);
+		goto free_cert_comp;
+	}
+
+	ret = xa_err(xa_store(&ndev->cert_comp_xa, msix_idx, cert_comp, GFP_KERNEL));
+	if (ret) {
+		XDNA_ERR(xdna, "store cert_comp for msix idx %d failed %d", msix_idx, ret);
+		goto free_irq;
+	}
+
+	return cert_comp;
+
+free_irq:
+	free_irq(cert_comp->irq, cert_comp);
+free_cert_comp:
+	kfree(cert_comp);
+	return NULL;
+}
+
+static void cert_comp_release(struct kref *kref)
+{
+	struct cert_comp *cert_comp = container_of(kref, struct cert_comp, kref);
+	struct amdxdna_dev_hdl *ndev = cert_comp->ndev;
+
+	drm_WARN_ON(&ndev->aie.xdna->ddev, !mutex_is_locked(&ndev->cert_comp_lock));
+
+	xa_erase(&ndev->cert_comp_xa, cert_comp->msix_idx);
+	free_irq(cert_comp->irq, cert_comp);
+	kfree(cert_comp);
+}
+
+static void aie4_put_cert_comp(struct cert_comp *cert_comp)
+{
+	struct amdxdna_dev_hdl *ndev;
+
+	ndev = cert_comp->ndev;
+	guard(mutex)(&ndev->cert_comp_lock);
+	kref_put(&cert_comp->kref, cert_comp_release);
+}
+
+static int aie4_msg_destroy_context(struct amdxdna_dev_hdl *ndev, u32 hw_context_id)
+{
+	DECLARE_AIE_MSG(aie4_msg_destroy_hw_context, AIE4_MSG_OP_DESTROY_HW_CONTEXT);
+
+	req.hw_context_id = hw_context_id;
+	return aie_send_mgmt_msg_wait(&ndev->aie, &msg);
+}
+
+static int aie4_hwctx_create(struct amdxdna_hwctx *hwctx)
+{
+	DECLARE_AIE_MSG(aie4_msg_create_hw_context, AIE4_MSG_OP_CREATE_HW_CONTEXT);
+	struct amdxdna_client *client = hwctx->client;
+	struct amdxdna_hwctx_priv *priv = hwctx->priv;
+	struct amdxdna_dev *xdna = hwctx->client->xdna;
+	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
+	int ret;
+
+	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
+
+	if (!ndev->partition_id || !hwctx->num_tiles) {
+		XDNA_ERR(xdna, "invalid request partition_id %d, num_tiles %d",
+			 ndev->partition_id, hwctx->num_tiles);
+		return -EINVAL;
+	}
+
+	req.partition_id = ndev->partition_id;
+	req.request_num_tiles = hwctx->num_tiles;
+	req.pasid = FIELD_PREP(AIE4_MSG_PASID, client->pasid) |
+		FIELD_PREP(AIE4_MSG_PASID_VLD, 1);
+	req.priority_band = hwctx->qos.priority;
+
+	req.hsa_addr_high = upper_32_bits(amdxdna_gem_dev_addr(priv->umq_bo));
+	req.hsa_addr_low = lower_32_bits(amdxdna_gem_dev_addr(priv->umq_bo));
+
+	XDNA_DBG(xdna, "pasid 0x%x, num_tiles %d, hsa[0x%x 0x%x]",
+		 req.pasid, req.request_num_tiles, req.hsa_addr_high, req.hsa_addr_low);
+
+	ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
+	if (ret) {
+		XDNA_ERR(xdna, "create ctx failed: %d", ret);
+		return ret;
+	}
+
+	XDNA_DBG(xdna, "resp msix: %d, ctx id: %d, doorbell: %d",
+		 resp.job_complete_msix_idx,
+		 resp.hw_context_id,
+		 resp.doorbell_offset);
+
+	/* setup interrupt completion per msix index */
+	priv->cert_comp = aie4_lookup_cert_comp(ndev, resp.job_complete_msix_idx);
+	if (!priv->cert_comp) {
+		aie4_msg_destroy_context(ndev, resp.hw_context_id);
+		return -EINVAL;
+	}
+
+	priv->hw_ctx_id = resp.hw_context_id;
+	hwctx->doorbell_offset = resp.doorbell_offset;
+
+	return 0;
+}
+
+static void aie4_hwctx_destroy(struct amdxdna_hwctx *hwctx)
+{
+	struct amdxdna_client *client = hwctx->client;
+	struct amdxdna_hwctx_priv *priv = hwctx->priv;
+	struct amdxdna_dev *xdna = client->xdna;
+	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
+
+	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
+
+	aie4_msg_destroy_context(ndev, priv->hw_ctx_id);
+	aie4_put_cert_comp(priv->cert_comp);
+}
+
+static void aie4_hwctx_umq_fini(struct amdxdna_hwctx *hwctx)
+{
+	if (hwctx->priv && hwctx->priv->umq_bo)
+		amdxdna_gem_put_obj(hwctx->priv->umq_bo);
+}
+
+static int aie4_hwctx_umq_init(struct amdxdna_hwctx *hwctx)
+{
+	struct amdxdna_hwctx_priv *priv = hwctx->priv;
+	struct amdxdna_dev *xdna = hwctx->client->xdna;
+	struct amdxdna_gem_obj *umq_bo;
+	struct host_queue_header *qhdr;
+	int ret;
+
+	umq_bo = amdxdna_gem_get_obj(hwctx->client, hwctx->umq_bo_hdl, AMDXDNA_BO_SHARE);
+	if (!umq_bo) {
+		XDNA_ERR(xdna, "cannot find umq_bo handle %d", hwctx->umq_bo_hdl);
+		return -ENOENT;
+	}
+	if (umq_bo->mem.size < sizeof(*qhdr)) {
+		XDNA_ERR(xdna, "umq_bo size is too small");
+		ret = -EINVAL;
+		goto put_umq_bo;
+	}
+
+	/* get kva address for host queue read index and write index */
+	qhdr = amdxdna_gem_vmap(umq_bo);
+	if (!qhdr) {
+		ret = -ENOMEM;
+		goto put_umq_bo;
+	}
+
+	priv->umq_bo = umq_bo;
+	priv->umq_read_index = &qhdr->read_index;
+	priv->umq_write_index = &qhdr->write_index;
+
+	return 0;
+
+put_umq_bo:
+	amdxdna_gem_put_obj(umq_bo);
+	return ret;
+}
+
+int aie4_hwctx_init(struct amdxdna_hwctx *hwctx)
+{
+	struct amdxdna_client *client = hwctx->client;
+	struct amdxdna_dev *xdna = client->xdna;
+	struct amdxdna_hwctx_priv *priv;
+	int ret;
+
+	priv = kzalloc_obj(*priv);
+	if (!priv)
+		return -ENOMEM;
+	hwctx->priv = priv;
+
+	ret = aie4_hwctx_umq_init(hwctx);
+	if (ret)
+		goto free_priv;
+
+	ret = aie4_hwctx_create(hwctx);
+	if (ret)
+		goto umq_fini;
+
+	XDNA_DBG(xdna, "hwctx %s init completed", hwctx->name);
+	return 0;
+
+umq_fini:
+	aie4_hwctx_umq_fini(hwctx);
+free_priv:
+	kfree(priv);
+	hwctx->priv = NULL;
+	return ret;
+}
+
+void aie4_hwctx_fini(struct amdxdna_hwctx *hwctx)
+{
+	aie4_hwctx_destroy(hwctx);
+	aie4_hwctx_umq_fini(hwctx);
+	kfree(hwctx->priv);
+}
diff --git a/drivers/accel/amdxdna/aie4_host_queue.h b/drivers/accel/amdxdna/aie4_host_queue.h
new file mode 100644
index 000000000000..eb6a38dfb53e
--- /dev/null
+++ b/drivers/accel/amdxdna/aie4_host_queue.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2026, Advanced Micro Devices, Inc.
+ */
+
+#ifndef _AIE4_HOST_QUEUE_H_
+#define _AIE4_HOST_QUEUE_H_
+
+#include <linux/types.h>
+
+struct host_queue_header {
+	__u64 read_index;
+	struct {
+		__u16 major;
+		__u16 minor;
+	} version;
+	__u32 capacity; /* Queue capacity, must be power of two. */
+	__u64 write_index;
+	__u64 data_address; /* The xdna dev addr for payload. */
+};
+
+#endif /* _AIE4_HOST_QUEUE_H_ */
diff --git a/drivers/accel/amdxdna/aie4_msg_priv.h b/drivers/accel/amdxdna/aie4_msg_priv.h
index cada53257921..7faa01ca3436 100644
--- a/drivers/accel/amdxdna/aie4_msg_priv.h
+++ b/drivers/accel/amdxdna/aie4_msg_priv.h
@@ -16,6 +16,8 @@ enum aie4_msg_opcode {
 
 	AIE4_MSG_OP_CREATE_PARTITION                 = 0x30001,
 	AIE4_MSG_OP_DESTROY_PARTITION                = 0x30002,
+	AIE4_MSG_OP_CREATE_HW_CONTEXT                = 0x30003,
+	AIE4_MSG_OP_DESTROY_HW_CONTEXT               = 0x30004,
 };
 
 enum aie4_msg_status {
@@ -67,4 +69,31 @@ struct aie4_msg_destroy_partition_resp {
 	enum aie4_msg_status status;
 } __packed;
 
+struct aie4_msg_create_hw_context_req {
+	__u32 partition_id;
+	__u32 request_num_tiles;
+	__u32 hsa_addr_high;
+	__u32 hsa_addr_low;
+#define AIE4_MSG_PASID GENMASK(19, 0)
+#define AIE4_MSG_PASID_VLD GENMASK(31, 31)
+	__u32 pasid;
+	__u32 priority_band;
+} __packed;
+
+struct aie4_msg_create_hw_context_resp {
+	enum aie4_msg_status status;
+	__u32 hw_context_id;
+	__u32 doorbell_offset;
+	__u32 job_complete_msix_idx;
+} __packed;
+
+struct aie4_msg_destroy_hw_context_req {
+	__u32 hw_context_id;
+	__u32 resvd1;
+} __packed;
+
+struct aie4_msg_destroy_hw_context_resp {
+	enum aie4_msg_status status;
+} __packed;
+
 #endif /* _AIE4_MSG_PRIV_H_ */
diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
index 13f5d45e388d..3be9066b7178 100644
--- a/drivers/accel/amdxdna/aie4_pci.c
+++ b/drivers/accel/amdxdna/aie4_pci.c
@@ -451,6 +451,9 @@ static int aie4m_pcidev_init(struct amdxdna_dev *xdna)
 	ndev->aie.xdna = xdna;
 	xdna->dev_handle = ndev;
 
+	xa_init_flags(&ndev->cert_comp_xa, XA_FLAGS_ALLOC);
+	mutex_init(&ndev->cert_comp_lock);
+
 	/* Enable managed PCI device */
 	ret = pcim_enable_device(pdev);
 	if (ret) {
@@ -542,4 +545,6 @@ const struct amdxdna_dev_ops aie4_pf_ops = {
 const struct amdxdna_dev_ops aie4_vf_ops = {
 	.init			= aie4_vf_init,
 	.fini			= aie4_vf_fini,
+	.hwctx_init		= aie4_hwctx_init,
+	.hwctx_fini		= aie4_hwctx_fini,
 };
diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
index 620fb5bd23e4..6103007e6d2f 100644
--- a/drivers/accel/amdxdna/aie4_pci.h
+++ b/drivers/accel/amdxdna/aie4_pci.h
@@ -13,6 +13,23 @@
 #include "aie.h"
 #include "amdxdna_mailbox.h"
 
+struct cert_comp {
+	struct amdxdna_dev_hdl          *ndev;
+	u32                             msix_idx;
+	int                             irq;
+	struct kref                     kref;
+	wait_queue_head_t               waitq;
+};
+
+struct amdxdna_hwctx_priv {
+	struct amdxdna_gem_obj          *umq_bo;
+	u64                             *umq_read_index;
+	u64                             *umq_write_index;
+
+	struct cert_comp                *cert_comp;
+	u32                             hw_ctx_id;
+};
+
 struct amdxdna_dev_priv {
 	const char              *npufw_path;
 	const char              *certfw_path;
@@ -32,11 +49,18 @@ struct amdxdna_dev_hdl {
 
 	struct mailbox			*mbox;
 	u32				partition_id;
+
+	struct xarray                   cert_comp_xa; /* device level indexed by msix id */
+	struct mutex                    cert_comp_lock; /* protects cert_comp operations*/
 };
 
 /* aie4_message.c */
 int aie4_suspend_fw(struct amdxdna_dev_hdl *ndev);
 
+/* aie4_ctx.c */
+int aie4_hwctx_init(struct amdxdna_hwctx *hwctx);
+void aie4_hwctx_fini(struct amdxdna_hwctx *hwctx);
+
 /* aie4_sriov.c */
 #if IS_ENABLED(CONFIG_PCI_IOV)
 int aie4_sriov_configure(struct amdxdna_dev *xdna, int num_vfs);
diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
index 2c2c21992c87..b5ad60d4b734 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.c
+++ b/drivers/accel/amdxdna/amdxdna_ctx.c
@@ -207,6 +207,9 @@ int amdxdna_drm_create_hwctx_ioctl(struct drm_device *dev, void *data, struct dr
 	if (args->ext || args->ext_flags)
 		return -EINVAL;
 
+	if (!xdna->dev_info->ops->hwctx_init)
+		return -EOPNOTSUPP;
+
 	hwctx = kzalloc_obj(*hwctx);
 	if (!hwctx)
 		return -ENOMEM;
@@ -220,6 +223,8 @@ int amdxdna_drm_create_hwctx_ioctl(struct drm_device *dev, void *data, struct dr
 	hwctx->client = client;
 	hwctx->fw_ctx_id = -1;
 	hwctx->num_tiles = args->num_tiles;
+	hwctx->umq_bo_hdl = args->umq_bo;
+	hwctx->doorbell_offset = AMDXDNA_INVALID_DOORBELL_OFFSET;
 	hwctx->mem_size = args->mem_size;
 	hwctx->max_opc = args->max_opc;
 
@@ -252,6 +257,7 @@ int amdxdna_drm_create_hwctx_ioctl(struct drm_device *dev, void *data, struct dr
 
 	args->handle = hwctx->id;
 	args->syncobj_handle = hwctx->syncobj_hdl;
+	args->umq_doorbell = hwctx->doorbell_offset;
 
 	atomic64_set(&hwctx->job_submit_cnt, 0);
 	atomic64_set(&hwctx->job_free_cnt, 0);
diff --git a/drivers/accel/amdxdna/amdxdna_ctx.h b/drivers/accel/amdxdna/amdxdna_ctx.h
index 355798687376..c5622718b4d5 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.h
+++ b/drivers/accel/amdxdna/amdxdna_ctx.h
@@ -14,6 +14,7 @@ struct amdxdna_hwctx_priv;
 
 enum ert_cmd_opcode {
 	ERT_START_CU = 0,
+	ERT_START_DPU = 18,
 	ERT_CMD_CHAIN = 19,
 	ERT_START_NPU = 20,
 	ERT_START_NPU_PREEMPT = 21,
@@ -105,6 +106,8 @@ struct amdxdna_hwctx {
 	u32				*col_list;
 	u32				start_col;
 	u32				num_col;
+	u32				umq_bo_hdl;
+	u32				doorbell_offset;
 	u32				num_unused_col;
 
 	struct amdxdna_qos_info		     qos;
diff --git a/include/uapi/drm/amdxdna_accel.h b/include/uapi/drm/amdxdna_accel.h
index 34212feee15c..ad9b33dd7b13 100644
--- a/include/uapi/drm/amdxdna_accel.h
+++ b/include/uapi/drm/amdxdna_accel.h
@@ -18,6 +18,7 @@ extern "C" {
 #define AMDXDNA_INVALID_CTX_HANDLE	0
 #define AMDXDNA_INVALID_BO_HANDLE	0
 #define AMDXDNA_INVALID_FENCE_HANDLE	0
+#define AMDXDNA_INVALID_DOORBELL_OFFSET	(~0U)
 
 /*
  * Define hardware context priority
-- 
2.34.1

