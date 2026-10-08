Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A6ACA5FFD
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 03:24:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74DCE10FA75;
	Thu,  8 Oct 2026 03:24:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QFwz8b03";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010004.outbound.protection.outlook.com
 [52.101.193.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68E6A10FA86
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 03:24:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nBYBZ6aaf+hq3dkOTIX3DjO3B2EDFywILU2q4k6n0PPvIGB/EqWdCE0YSF3Qg7DAK04Gcl+5TU4hDHEdy1GJlO6dYRkoUak67CMlNlmzfsUHGWfhy23E4MQHM1hs8k1c4zoV1YUJo/vReYXaTix9xZXQ/TCObE9NhsFg3fAlGBuRvt4WAtBvL5qROGgEHWclRwZ5Om3Wt+sIlzfrX8I3JrRfYX90mm3JQIAIrJRRmIBxi+xzQLCL0Nn6Y22Pu459Ymf3W3cryCjNVwze3nMbC5ASa0rowXmEE5buf3R/9+jaPCx7hgFnlxW3dSBRDWkoqfAHf/i8pdfatHf5boNWyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/jO5ewTNFhuciVkKBGCmWAaWY0iiALa/Ptj8lROqkE=;
 b=onxY+eOZzwhxfXCWPBeWltg0Hl+tou9Tyqs6aX6QqL67zwwJ8NuTp7UGPPCbhkFC9IYoiT7/fP2y6qvuhLPIzAogN/PrefNmQUF2SQoLajYZNRBMgSB4u++5jtSbZyTLfQj4cfvGU+27VDY+s4RrpoVXess3X/dOqph/mmIgqo7SUEJb/0xP3lQRu/HFLDpzxr3CVaIcZR+uejh8qU7f7y/B2xNKzw5idWF4iCwd6HoPxCVczk2AMkj+myEpOcUCHP6i0xrqA6obrZTNS5o8/B+hfhM/ORftytCASZSsmDMQqmERTMxkaJiazSlyESoSJtrF0YLeUn9lJgxRlgd9Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/jO5ewTNFhuciVkKBGCmWAaWY0iiALa/Ptj8lROqkE=;
 b=QFwz8b03NGAvAYIIYzWxnIOH4eS6y2AZlq62RO2IkmDqxMYV5W+Fj11Bf/OrZ855X1HzGBEpeOIbumPAVCbzYzUeZBgKNM828WxK5eMtgo92/xAFEKAwW82d0ayTWQFGUVslOcCdulcfmLIrJiHAG7fbp/tc9RIsDDTLl1ZNP7M=
Received: from SJ0PR05CA0005.namprd05.prod.outlook.com (2603:10b6:a03:33b::10)
 by IA4PR12MB469045.namprd12.prod.outlook.com (2603:10b6:207:108::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Thu, 8 Oct
 2026 03:24:16 +0000
Received: from SJ1PEPF000037AC.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::58) by SJ0PR05CA0005.outlook.office365.com
 (2603:10b6:a03:33b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Thu, 8
 Oct 2026 03:24:16 +0000
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
 15.21.496.14 via Frontend Transport; Thu, 8 Oct 2026 03:24:16 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 22:24:07 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Wed, 7 Oct 2026 22:24:07 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>, Hayden Laccabue <Hayden.Laccabue@amd.com>
Subject: [PATCH V3 14/19] accel/amdxdna: Move HMM invalidate wait into common
 GEM code
Date: Wed, 7 Oct 2026 20:23:43 -0700
Message-ID: <20261008032348.2044667-15-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008032348.2044667-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261008032348.2044667-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AC:EE_|IA4PR12MB469045:EE_
X-MS-Office365-Filtering-Correlation-Id: 0755eb66-93be-44b8-bc29-08df24eba1da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|18002099003|22082099003|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: HzrGK4xeERr0AOsvyupbw2w2ztY6swpbrdb2XsLxDmjxhMtzynkK6f1YGLJR88KqVakIW8DBOOGz4yp1yB7BjaWw6hHTd2krJUbdOePVe74PjiGXfmP10Yg2lueICX6fnvkv94CCxDGuMQ7MTq5BFWmqduoibr+EvUA0AA58tP42J+rCKt+CxzqW/lz9gn9aEESE9cLOwQ2bfCyRXXlVRd2JWzxcPmVoZ/CZzwVCS+u3FIKYCB2mlE+sNb7xF44BmK0LxQ+unPNKHhU7QFnQjt/RIuvjla3tH6MLppeFdTclQmjUh4SX/qOL7Km503tBJvks6HARwTp37g89XdVAxmZCecnOYaIxfZh00qPQ6zG7qbkHZAeQT0bLrqpiXdI+dv+MKNmdXUeNNQdfVGkpOvflL9nV/TRv3DKDIpSqaryaiiQHqLjtxudWFzPHkencLR3S9HaUOoylwYuDUBFuuxFf8hY4rndBNNAJ0bG7eIc6NZw4Eh2mxMo9DztLSJWoCdie45iuYPeAQ/acWVRFhLBFn9IKobmSbj+v7CD7dXE0qsl7KgZMalftj0i399orecKL6eYdsZfYBK7DzUPAphhz69XSFT81Jztf9xtxKYVQbnk8wtR86r1NTWfXtxS+M4NuFHBmGCTH3sBxwn8cN4qvrOspSOH/kCx/cZ4pjoSjpP/BdhKbgyjWzt89UetrrYy/twUGsVskYIbO8H7+5g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: n5hGwd0/9E5mcZO2fv2+vlx5MoW1oP5Mcv54VClvZMtxbOzAOjLCgN/ecegyBr02MGKJ5wz/FGsM8txrJcJDAkRagJiP02vhtXNbViU/Z6OwKlE7+Vj4o8AyTlXmbFkReYcTSWqrNt4tfDGeDRfIHn1EfkSuonEPCJcyHrHhZ2YAp60MIl+QAfkxP8IIbZHNuIpQlQMrryiJ38wQenmWw7GXzmJMHz0SSNRy51TzjHKdVyfg9FgmVuAQleYM4HePVeYlg6JQULV2gGeBBks4tcVnUHnQRGbPmGFmTBxhHpZ/Ax7Xsa9ZEPQu9ay46O4g4OyOIMed6jpI1yg+2MWE2DzaLnN1rcNkBWIJfLiEZu0ZTiooZ7nBEEDlMizL2dLXcPwnMNFJtUWZ2ofrPJIUgvYbOtJj8EuFyzEAvdbCkPVa+rSIEg4u2NnTmHe2bJnx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 03:24:16.0000 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0755eb66-93be-44b8-bc29-08df24eba1da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB469045
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
No functional change for AIE2.

Co-developed-by: Hayden Laccabue <Hayden.Laccabue@amd.com>
Signed-off-by: Hayden Laccabue <Hayden.Laccabue@amd.com>
Signed-off-by: David Zhang <yidong.zhang@amd.com>
---
 drivers/accel/amdxdna/aie2_ctx.c        | 15 ---------------
 drivers/accel/amdxdna/aie2_pci.c        |  1 -
 drivers/accel/amdxdna/aie2_pci.h        |  1 -
 drivers/accel/amdxdna/amdxdna_gem.c     | 10 ++++++++--
 drivers/accel/amdxdna/amdxdna_pci_drv.h |  1 -
 5 files changed, 8 insertions(+), 20 deletions(-)

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
index 29b6d6a3e0bd..3d9ddd40908d 100644
--- a/drivers/accel/amdxdna/aie2_pci.c
+++ b/drivers/accel/amdxdna/aie2_pci.c
@@ -1227,7 +1227,6 @@ const struct amdxdna_dev_ops aie2_ops = {
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
index f4832337ec31..eebd93b6f2c3 100644
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
@@ -249,8 +251,12 @@ static bool amdxdna_hmm_invalidate(struct mmu_interval_notifier *mni,
 	mmu_interval_set_seq(&mapp->notifier, cur_seq);
 	up_write(&xdna->notifier_lock);
 
-	if (xdna->dev_info->ops->hmm_invalidate)
-		xdna->dev_info->ops->hmm_invalidate(abo, cur_seq);
+	ret = dma_resv_wait_timeout(to_gobj(abo)->resv, DMA_RESV_USAGE_BOOKKEEP,
+				    true, MAX_SCHEDULE_TIMEOUT);
+	if (!ret)
+		XDNA_ERR(xdna, "Failed to wait for bo, ret %ld", ret);
+	else if (ret == -ERESTARTSYS)
+		XDNA_DBG(xdna, "Wait for bo interrupted by signal");
 
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

