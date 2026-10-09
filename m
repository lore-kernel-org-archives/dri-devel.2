Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3FF6CA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 22:54:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C980A112307;
	Fri,  9 Oct 2026 22:54:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ekPYr8T0";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010010.outbound.protection.outlook.com
 [52.101.193.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8CB4112308
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 22:54:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gSgN4GbEclOHgT7qqb77bIDkkRU5u9ilOL9d5BkqPYfr3xIZQ5oVY2oBUqvhrOAljGOksHw7sRsrfY/ZkD6pcmHpXJX885HUIRIE5ShVjdu67z1mOy3xZ4c9JZCT6ETKU1VjUZeAGewfeIXYdcK4FDSgJrFse4Ap1v8W7faLxPqVF39EtOKejqJHXah9vNeHO9WrIcfeuHjkfWp0L4GqwsHRrsgRSiIEvK2oN2gR3IWdwSz3SuGoiARqGTIy8kL/t6TIxSsmuRU9k1lnH7Th/BcCaZ9S7Huu/nFah2UDSIdTqKC15HI/IjyR9zRXgHp4eBMD3UUEhnVNlZjX9M1jyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qfgTOzp460vdwfgWU79qRh5+jQ60Erh0xkwtDm1rsY=;
 b=xKZyHvPEsNrWdWrc4n3V8HGOlmeAtV68/zDN8UzKa5YV4DrezWVmB4eDHHy5WkPtRq1GoGyQ/mynMiUVgEJG9nyb/PQXG8s5Y1fheJoqhedeis86EhUwz3Baoz60P5ax+ySXDIIZaZGeFtzGRDgb+QXvIaTDJJxpAX4F6U5WFFSYIHEY654WYgeT11osei4Z4MfaR2ee2ToFrWlkkzkhoyKkUUiqP+cImLkATmrqTq0VyAZEsT0BjP+wBp64FwUi3UJyNXzq9qVZCMtMF02UgW6TEhfV1balcXndVFhz8Gl4NVGCuQi1l2dYKEBaIv9fkBOtScijJhd2zU1VLI3dqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qfgTOzp460vdwfgWU79qRh5+jQ60Erh0xkwtDm1rsY=;
 b=ekPYr8T09Mlrfq9mBxA7SOItS/JWM16avfmCR8suM4h/67lAqvNxSw7EXNFa7HeX1IwB9MuPo1aoMtwQEVGnVmkFDUXw2En8e9G/CdenxXJseKGY/HUwRNFVgYMdSweZuGjuWT91A2WMw4Dmz0AGRfsGTTFNef9GxsltEVbW38M=
Received: from BN0PR04CA0131.namprd04.prod.outlook.com (2603:10b6:408:ed::16)
 by DS0PR12MB6584.namprd12.prod.outlook.com (2603:10b6:8:d0::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.18; Fri, 9 Oct 2026 22:54:02 +0000
Received: from BN2PEPF000055E0.namprd21.prod.outlook.com
 (2603:10b6:408:ed:cafe::3c) by BN0PR04CA0131.outlook.office365.com
 (2603:10b6:408:ed::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 9
 Oct 2026 22:54:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055E0.mail.protection.outlook.com (10.167.245.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.0 via Frontend Transport; Fri, 9 Oct 2026 22:54:02 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 17:53:56 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Fri, 9 Oct 2026 17:53:55 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>, Hayden Laccabue <Hayden.Laccabue@amd.com>
Subject: [PATCH V4 14/19] accel/amdxdna: Move HMM invalidate wait into common
 GEM code
Date: Fri, 9 Oct 2026 15:53:38 -0700
Message-ID: <20261009225343.3079074-15-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261009225343.3079074-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261009225343.3079074-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E0:EE_|DS0PR12MB6584:EE_
X-MS-Office365-Filtering-Correlation-Id: b522f53e-f124-444e-8c24-08df26583672
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|22082099003|18002099003|4143699003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: wZl9cCYNeGimyFLd1gfMRtPI5hZHA5m5YQ3NInKx6uWZGCBxBj/KeZJ/4jPz4H7EGdOOlLe61+CTNl8Vqqokz0wabxoJPT9ohr+P5YTpzO0jcn9XlLDcsm8JJq+Vruk8Dq84L4GqgX3ODftSYCUxlfAod04huNBtHHcgHUg+lVh9ulNZUbNLUQsefOQO8w49ccMBf+8HQ5ZvNvxjNd9Dy+hfD3bzCD+KgwIqm5o1bHM/FlLPKsJKQ/VDP5HD240a/Ksz/DtISAwiUruqXTEphjiegzlv/wcUD1kOmqyRD44rrjo1MkhmKlzXrtAHkWuDFuymfuyfIcQPdHK5RgRs2arvhLfKIgBHjEnUeq34w74/lZ8a9a2yRvYjyQ9MuLrB5DrDkmsDeJHw0UKGsRDuaTMEl8yZTvtYtPZhGcpAiwCzXOuTfjd7elEf98tLvBYz67q9hnteLFzIJmSiYYb6bvsK43FM7VatdrmF9NvdWye3F/BaLfKeo3fcB2V4QknIdz9A8JHs6GzuHIEoS7UtkP+g+xYgaP7LRzfpPeBWXfTGF4nBzLD2NrcezTkrTk+icx01uzf5z91fEW+GM7yfLOGJj3ywc1HZV+njcs35fj46LjBz+s5eA8lLdAvQ8pWz8l2a6XfiQbCq7WeYwtI9XgJhIeLGcCzc86AbKYx+v6P9yZJLXA1uunBoUVRTR+lIvqpzxzokZrvAqiZ5kPaT2Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(22082099003)(18002099003)(4143699003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DHMvL9mdFSOVT4MoyDolYNBwdNn7/YFQFjc1ys6hfI4p1x2Lxt0KBcq5B3xO0dGaGwkt7lWzWNXq8Qt7nR1qdKSgZzJNzMaXUTYg/yddQljyKWMyyy9vHjJgJBGJzT+fD/QY3BPRyPsza/cPgn0hOFajMikEk3UdruCjbQWBjRrosbVFyGfrYB6eyHMr6NkBGm8jrETE68tN7S+ngvG9sprpcYOZxTeJNY34cWo+O8TxJP+01eyjsWdeRoEz8xOYcVnN+cNwc7wJrGuAPxlnASFQmNynPk1tOVCRAAbtZQadOL/TlA8esEurvReA8l5V/1DKDJ3caSwXObSa8eJF5zCM5SkBczJzbIUHy0FXG3koY2wig1sM7kBb2KGCnEr1BuwRIEWTA3rgy0wxB8c2z4kCIcTEtVo3wJ0iaDfOROHTpqSDhn/NtT2rxSS83wK/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 22:54:02.1934 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b522f53e-f124-444e-8c24-08df26583672
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E0.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6584
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

When a user mapping of a BO is invalidated, the driver must wait for
the BO's reservation fences before the pages are released. AIE2 does
this in aie2_hmm_invalidate() through the .hmm_invalidate callback,
and AIE4 needs the same wait.

Do the wait directly in amdxdna_hmm_invalidate() in amdxdna_gem.c and
remove the .hmm_invalidate callback and aie2_hmm_invalidate(). Devices
that do not attach fences to user BOs return from the wait at once.

Make the wait uninterruptible. With an interruptible wait, a pending
signal, such as SIGKILL during process exit, ends the wait early and
the pages can be freed while the NPU may still access them.

Co-developed-by: Hayden Laccabue <Hayden.Laccabue@amd.com>
Signed-off-by: Hayden Laccabue <Hayden.Laccabue@amd.com>
Signed-off-by: David Zhang <yidong.zhang@amd.com>
---
 drivers/accel/amdxdna/aie2_ctx.c        | 15 ---------------
 drivers/accel/amdxdna/aie2_pci.c        |  1 -
 drivers/accel/amdxdna/aie2_pci.h        |  1 -
 drivers/accel/amdxdna/amdxdna_gem.c     | 14 ++++++++++++--
 drivers/accel/amdxdna/amdxdna_pci_drv.h |  1 -
 5 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index d927c8c9d557..8c1b29964f8f 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -1277,21 +1277,6 @@ int aie2_cmd_submit(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job,
 	return ret;
 }
 
-void aie2_hmm_invalidate(struct amdxdna_gem_obj *abo,
-			 unsigned long cur_seq)
-{
-	struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(abo)->dev);
-	struct drm_gem_object *gobj = to_gobj(abo);
-	long ret;
-
-	ret = dma_resv_wait_timeout(gobj->resv, DMA_RESV_USAGE_BOOKKEEP,
-				    true, MAX_SCHEDULE_TIMEOUT);
-	if (!ret)
-		XDNA_ERR(xdna, "Failed to wait for bo, ret %ld", ret);
-	else if (ret == -ERESTARTSYS)
-		XDNA_DBG(xdna, "Wait for bo interrupted by signal");
-}
-
 int aie2_hwctx_heap_expand(struct amdxdna_hwctx *hwctx,
 			   struct amdxdna_gem_obj *heap)
 {
diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
index 1b029d33a24b..690ad035463c 100644
--- a/drivers/accel/amdxdna/aie2_pci.c
+++ b/drivers/accel/amdxdna/aie2_pci.c
@@ -1228,7 +1228,6 @@ const struct amdxdna_dev_ops aie2_ops = {
 	.hwctx_config = aie2_hwctx_config,
 	.hwctx_sync_debug_bo = aie2_hwctx_sync_debug_bo,
 	.cmd_submit = aie2_cmd_submit,
-	.hmm_invalidate = aie2_hmm_invalidate,
 	.get_array = aie2_get_array,
 	.get_dev_revision = aie2_get_dev_rev,
 	.hwctx_heap_expand = aie2_hwctx_heap_expand,
diff --git a/drivers/accel/amdxdna/aie2_pci.h b/drivers/accel/amdxdna/aie2_pci.h
index 709e7545c65f..13391275df31 100644
--- a/drivers/accel/amdxdna/aie2_pci.h
+++ b/drivers/accel/amdxdna/aie2_pci.h
@@ -272,7 +272,6 @@ int aie2_hwctx_sync_debug_bo(struct amdxdna_hwctx *hwctx, u32 debug_bo_hdl);
 void aie2_hwctx_suspend(struct amdxdna_client *client);
 int aie2_hwctx_resume(struct amdxdna_client *client);
 int aie2_cmd_submit(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job, u64 *seq);
-void aie2_hmm_invalidate(struct amdxdna_gem_obj *abo, unsigned long cur_seq);
 int aie2_hwctx_heap_expand(struct amdxdna_hwctx *hwctx, struct amdxdna_gem_obj *heap);
 
 #endif /* _AIE2_PCI_H_ */
diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index f4832337ec31..e1b72cef51bd 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -12,6 +12,7 @@
 #include <drm/gpu_scheduler.h>
 #include <linux/dma-buf.h>
 #include <linux/dma-direct.h>
+#include <linux/dma-resv.h>
 #include <linux/iosys-map.h>
 #include <linux/pagemap.h>
 #include <linux/swap.h>
@@ -232,6 +233,7 @@ static bool amdxdna_hmm_invalidate(struct mmu_interval_notifier *mni,
 	struct amdxdna_umap *mapp = container_of(mni, struct amdxdna_umap, notifier);
 	struct amdxdna_gem_obj *abo = mapp->abo;
 	struct amdxdna_dev *xdna;
+	long ret;
 
 	if (!mmu_notifier_range_blockable(range))
 		return false;
@@ -249,8 +251,16 @@ static bool amdxdna_hmm_invalidate(struct mmu_interval_notifier *mni,
 	mmu_interval_set_seq(&mapp->notifier, cur_seq);
 	up_write(&xdna->notifier_lock);
 
-	if (xdna->dev_info->ops->hmm_invalidate)
-		xdna->dev_info->ops->hmm_invalidate(abo, cur_seq);
+	/*
+	 * Wait uninterruptibly. Returning early on a signal would let the
+	 * pages be freed while the NPU may still access them. This relies
+	 * on job fences signaling in finite time; job timeout detection
+	 * and recovery (TDR) for AIE4 will be added in a separate change.
+	 */
+	ret = dma_resv_wait_timeout(to_gobj(abo)->resv, DMA_RESV_USAGE_BOOKKEEP,
+				    false, MAX_SCHEDULE_TIMEOUT);
+	if (!ret)
+		XDNA_ERR(xdna, "Failed to wait for bo, ret %ld", ret);
 
 	if (range->event == MMU_NOTIFY_UNMAP) {
 		down_write(&xdna->notifier_lock);
diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h b/drivers/accel/amdxdna/amdxdna_pci_drv.h
index 11f46ec738d7..2a1d6b33363c 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.h
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.h
@@ -63,7 +63,6 @@ struct amdxdna_dev_ops {
 	int (*hwctx_config)(struct amdxdna_hwctx *hwctx, u32 type, u64 value, void *buf, u32 size);
 	int (*hwctx_sync_debug_bo)(struct amdxdna_hwctx *hwctx, u32 debug_bo_hdl);
 	int (*hwctx_heap_expand)(struct amdxdna_hwctx *hwctx, struct amdxdna_gem_obj *heap);
-	void (*hmm_invalidate)(struct amdxdna_gem_obj *abo, unsigned long cur_seq);
 	int (*cmd_submit)(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job, u64 *seq);
 	int (*cmd_wait)(struct amdxdna_hwctx *hwctx, u64 seq, u32 timeout);
 	int (*get_aie_info)(struct amdxdna_client *client, struct amdxdna_drm_get_info *args);
-- 
2.34.1

