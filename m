Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C41C982D6
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 15:49:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1841310EF8E;
	Thu, 17 Sep 2026 15:49:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pTUdyDum";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010064.outbound.protection.outlook.com [52.101.56.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB02E10EF78
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 15:49:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OBVTVGdLl8D6nadL0ggXnCs8DkxJoEZWDKb+gaDm1q7MXZ8SqOCypk5dVt6gcK62xJPIfqkcoFPofLQIAxSUFW5CAtcZkhan9D0f3ljiv/w2MtFI20Uic5Z/dMB8MMAw0xxb9iT8uL/uFbn23Lm01H9Te0GMAjQVvE0AxxPBtq445xiOaweuQzSaUrJJqZp8sc4ujCQlzq5Ne5WCpVo5YbFfZ/NBr62e8j3vdmnMw+7ZzIua7J1SAwgXiP83mWWX64CzPLj8/XO1cunrfOxIcUk6rjkN0fF2FE6qLQU8taCvtXd9sbtBwET1ItKV4AMpmapEe4/gL0vEB+2y+lgRaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bNiFAFv0kxfVGmVdOyMG2XJZ1pXtRzWdvvS4c1gua0o=;
 b=VcxGSWWGiDE28x8N2NbyKNbqr+zonWHOib9jrmfuh2M/GSrxxLZK12sgCQ1Im3RjnvRCbt3mAU/i2N8vo42/VkcBRscKn2IPfNhDlv5SUGJuaEfXUEOL2EXhquaCFgnZMPgWkRYYZhYD5SrbSQnWYowMGLXqQ5c9Pm9SwhpDrxmPlg3eUpfy66wpbjTqHaqzEi3SXf96hh12o4eZYJFyR31vAAqt4+O0xdos7XuAoC9P5RTshmYK7q2GFUf4f4N6RNUzuJSj/a6zQR7mcR0sh01sEhE9F2hyvwhhSk2XTGbNSfZQjCkfJ72qTSkA0KG3ZQRbbIWV5JypxvO6fNx0og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNiFAFv0kxfVGmVdOyMG2XJZ1pXtRzWdvvS4c1gua0o=;
 b=pTUdyDumWCxkwoKM6RgyxjcnSCAI/In068rgUJEo8VCFGnZCoIkRinN4cTNdbmFjmqQwXdQ02GRANbDXXggqctBM6KIzpzQdnSe/QIDTc7pPVJW9RvJf/9wGkfXqp1D0zUu+rjkDpOm82JsZmkovIwqWoKy60AVQNq5wkzwGo3o=
Received: from MW4PR04CA0290.namprd04.prod.outlook.com (2603:10b6:303:89::25)
 by BN7PPF48E601ED5.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6ce) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 15:48:54 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:303:89:cafe::97) by MW4PR04CA0290.outlook.office365.com
 (2603:10b6:303:89::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Thu,
 17 Sep 2026 15:48:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Thu, 17 Sep 2026 15:48:53 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 10:48:53 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 10:48:53 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 17 Sep 2026 10:48:52 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <mario.limonciello@amd.com>, <karol.wachowski@linux.intel.com>,
 <dri-devel@lists.freedesktop.org>, <max.zhen@amd.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <sonal.santan@amd.com>
Subject: [PATCH V1] accel/amdxdna: Fix race between unmap and free BO
Date: Thu, 17 Sep 2026 08:48:24 -0700
Message-ID: <20260917154824.1872220-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|BN7PPF48E601ED5:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d2800e5-5664-423d-165d-08df14d32d3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|10067099003|6133799003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: suHFVkHUnvT79arKb3v/Lg9OnlBVrd5WRuOzXAD+K6AtAOiGG3hFZj8eiv126Jek8WQAZmRswV6kNcyhYhKSVEiPtw2quQeUzuMnWpAoZKU+QX8eHLuYFpNckczn6HJrD62RZWSbpjT/p/EQnglFaP8DMcW9GUdtiFUaF6tf1niuPwmbdD686n7SGBPM+LYMXuVI6MCsVjit3KNbmxxZXveVbhfnokZfg+r7FCHbCNWSqjcN8XrEHYhNkBdrUsCbyTGF6qUJsZrpiztvU4KUN76TOjI1Qtb61dNq85PAX42wiMKnsXC6I62gkFdrxBJzTvVUbmC4n3aPpt3IRB6bRIpcdUXglKDj1Ec+MrDX8zKPbuD8xhm1XXD7k3HpCfZLskMMRap/jWagP0eiZdxYoXONUZqwDl1hKc+3jF5lRJh11jPgsUBIQuEQohSQ4LEmyQ4syV1YHL/vwNyCC8Z22+i92ec8U+DMnQ7dXX+4eqKX3bRChVAQmMmKoAtjys7mPDLzRYeU4BVGzeYibTu7p9cS0L/PTJ+RsyFe3yWer6frYucJoS8QAE3RjEvKOuKUjpZVm8uHWZOQ84yxffIxy9UAOA7VwP1tqdNg7Z9ivEGbUcKkfLJwKu3rtyEcKGOf3/pLXr+LPVGBEXdGzKjmFkKJyiUGKMVmvSTceIj6q/NEZc3yFvgSxeYeBBI5+bwqxBGNScAV/7VtS4ip1GkO2A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(10067099003)(6133799003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: viFE+3MkwR2H8m+9i85ok14KSBjFCwWPm1ZOVb7DFUax4WAgE166ChdKOEQkopNaNBqOF3r5TtjYw90LCQXFR7AgWFBLUx5Y4UxHxwpcBN5Yrz88J8+X6h7yFutE3JCCrpY8GU7asAVfIS4vi+6/SZ8aJbIceZ8xKT32U78Df7l6rRcvO8gELd6dQ8krAFWoq5dTPR3HaDzQLHQTdqEj6SC6gjRrXLwMIIzuKy1GwJ1cRiYpIc/lZX0p2uiVX0WTWTa3plYOP9Lt3tVblzEfpKMTkXC6O0vdqN++NUzKRK4L1f6FpzEnXUXB2GTyxmxp98IAhtGt1hdGaE6HwvoIi3aSmsr1N9eordl2Mz+Ir7nBj/KbWNhg6d12e0jVDaHCjkOnZkmIHZ2lQ2pQJVV3iVbBCoCdh9DDSYfzwTTcxXrYM5a1HuIBQ1/e4gAXLkXR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 15:48:53.9038 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d2800e5-5664-423d-165d-08df14d32d3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF48E601ED5
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

A userspace process can concurrently trigger an unmap, which queues
hmm_unreg_work, and free BO. If amdxdna_hmm_unreg_work() executes
list_del(&mapp->node) and is preempted before calling amdxdna_umap_put(),
amdxdna_hmm_unregister_all() can fail to find the mapping in the list
and return without calling cancel_work_sync(). This allows object
destruction to proceed while the worker still holds a pointer to the BO
in the umap structure.

Moving the work item from struct amdxdna_umap to struct amdxdna_gem_obj.
The worker no longer holds a pointer to an individual mapping, so there
is no longer a window where the umap has been unlinked from umap_list but
work is still pending against it. The work item now lives in the BO
itself, so use a single cancel_work_sync() in the free path to drain the
work.

Fixes: 445d20910429 ("accel/amdxdna: Fix unexpected wait when flushing notifier_wq")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/amdxdna_gem.c | 95 +++++++++++++----------------
 drivers/accel/amdxdna/amdxdna_gem.h |  3 +-
 2 files changed, 42 insertions(+), 56 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index e861db6f9369..398d0a58b53a 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -164,30 +164,6 @@ void amdxdna_gem_heap_free(struct amdxdna_client *client, struct amdxdna_gem_obj
 	mutex_unlock(&client->mm_lock);
 }
 
-static struct amdxdna_gem_obj *
-amdxdna_gem_create_obj(struct drm_device *dev, size_t size)
-{
-	struct amdxdna_gem_obj *abo;
-
-	abo = kzalloc_obj(*abo);
-	if (!abo)
-		return ERR_PTR(-ENOMEM);
-
-	abo->pinned = false;
-	abo->assigned_hwctx = AMDXDNA_INVALID_CTX_HANDLE;
-	mutex_init(&abo->lock);
-
-	abo->mem.dma_addr = AMDXDNA_INVALID_ADDR;
-	abo->mem.uva = AMDXDNA_INVALID_ADDR;
-	abo->mem.size = size;
-	abo->open_ref = 0;
-	abo->internal = false;
-	INIT_LIST_HEAD(&abo->mem.umap_list);
-	xa_init_flags(&abo->heap_xa, XA_FLAGS_ALLOC);
-
-	return abo;
-}
-
 static void
 amdxdna_gem_destroy_obj(struct amdxdna_gem_obj *abo)
 {
@@ -278,10 +254,8 @@ static bool amdxdna_hmm_invalidate(struct mmu_interval_notifier *mni,
 
 	if (range->event == MMU_NOTIFY_UNMAP) {
 		down_write(&xdna->notifier_lock);
-		if (!mapp->unmapped) {
-			queue_work(xdna->notifier_wq, &mapp->hmm_unreg_work);
-			mapp->unmapped = true;
-		}
+		mapp->unmapped = true;
+		queue_work(xdna->notifier_wq, &abo->hmm_unreg_work);
 		up_write(&xdna->notifier_lock);
 	}
 
@@ -311,13 +285,13 @@ static void amdxdna_hmm_unregister(struct amdxdna_gem_obj *abo,
 		if (!compare_range(mapp, vma->vm_mm, vma->vm_start, vma->vm_end))
 			continue;
 
-		queue_work(xdna->notifier_wq, &mapp->hmm_unreg_work);
 		mapp->unmapped = true;
+		queue_work(xdna->notifier_wq, &abo->hmm_unreg_work);
 	}
 	up_write(&xdna->notifier_lock);
 }
 
-static void amdxdna_hmm_unregister_all(struct amdxdna_gem_obj *abo)
+static void amdxdna_hmm_unreg_umaps(struct amdxdna_gem_obj *abo, bool force)
 {
 	struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(abo)->dev);
 	struct amdxdna_umap *mapp, *tmp;
@@ -325,16 +299,18 @@ static void amdxdna_hmm_unregister_all(struct amdxdna_gem_obj *abo)
 
 	down_write(&xdna->notifier_lock);
 	list_for_each_entry_safe(mapp, tmp, &abo->mem.umap_list, node) {
+		if (!force && !mapp->unmapped)
+			continue;
+
 		mapp->unmapped = true;
-		mapp->cleanup = true;
 		list_move(&mapp->node, &dead);
 	}
+	if (list_empty(&abo->mem.umap_list))
+		abo->mem.uva = AMDXDNA_INVALID_ADDR;
 	up_write(&xdna->notifier_lock);
 
-	list_for_each_entry_safe(mapp, tmp, &dead, node) {
-		cancel_work_sync(&mapp->hmm_unreg_work);
+	list_for_each_entry_safe(mapp, tmp, &dead, node)
 		amdxdna_umap_put(mapp);
-	}
 }
 
 static void amdxdna_umap_release(struct kref *ref)
@@ -353,24 +329,10 @@ void amdxdna_umap_put(struct amdxdna_umap *mapp)
 
 static void amdxdna_hmm_unreg_work(struct work_struct *work)
 {
-	struct amdxdna_umap *mapp = container_of(work, struct amdxdna_umap,
-						 hmm_unreg_work);
-	struct amdxdna_gem_obj *abo = mapp->abo;
-	struct amdxdna_dev *xdna;
+	struct amdxdna_gem_obj *abo = container_of(work, struct amdxdna_gem_obj,
+						   hmm_unreg_work);
 
-	xdna = to_xdna_dev(to_gobj(mapp->abo)->dev);
-	down_write(&xdna->notifier_lock);
-	if (mapp->cleanup) {
-		up_write(&xdna->notifier_lock);
-		return;
-	}
-
-	list_del(&mapp->node);
-	if (list_empty(&abo->mem.umap_list))
-		abo->mem.uva = AMDXDNA_INVALID_ADDR;
-	up_write(&xdna->notifier_lock);
-
-	amdxdna_umap_put(mapp);
+	amdxdna_hmm_unreg_umaps(abo, false);
 }
 
 static int amdxdna_hmm_register(struct amdxdna_gem_obj *abo,
@@ -422,8 +384,6 @@ static int amdxdna_hmm_register(struct amdxdna_gem_obj *abo,
 	mapp->abo = abo;
 	kref_init(&mapp->refcnt);
 
-	INIT_WORK(&mapp->hmm_unreg_work, amdxdna_hmm_unreg_work);
-
 	ret = mmu_interval_notifier_insert_locked(&mapp->notifier,
 						  current->mm,
 						  addr,
@@ -449,6 +409,31 @@ static int amdxdna_hmm_register(struct amdxdna_gem_obj *abo,
 	return ret;
 }
 
+static struct amdxdna_gem_obj *
+amdxdna_gem_create_obj(struct drm_device *dev, size_t size)
+{
+	struct amdxdna_gem_obj *abo;
+
+	abo = kzalloc_obj(*abo);
+	if (!abo)
+		return ERR_PTR(-ENOMEM);
+
+	abo->pinned = false;
+	abo->assigned_hwctx = AMDXDNA_INVALID_CTX_HANDLE;
+	mutex_init(&abo->lock);
+
+	abo->mem.dma_addr = AMDXDNA_INVALID_ADDR;
+	abo->mem.uva = AMDXDNA_INVALID_ADDR;
+	abo->mem.size = size;
+	abo->open_ref = 0;
+	abo->internal = false;
+	INIT_LIST_HEAD(&abo->mem.umap_list);
+	xa_init_flags(&abo->heap_xa, XA_FLAGS_ALLOC);
+	INIT_WORK(&abo->hmm_unreg_work, amdxdna_hmm_unreg_work);
+
+	return abo;
+}
+
 static void amdxdna_gem_dev_obj_free(struct drm_gem_object *gobj)
 {
 	struct amdxdna_dev *xdna = to_xdna_dev(gobj->dev);
@@ -756,7 +741,9 @@ static void amdxdna_gem_obj_free(struct drm_gem_object *gobj)
 	struct amdxdna_dev *xdna = to_xdna_dev(gobj->dev);
 	struct amdxdna_gem_obj *abo = to_xdna_obj(gobj);
 
-	amdxdna_hmm_unregister_all(abo);
+	/* No notifier survives this, so no new work can be queued. */
+	amdxdna_hmm_unreg_umaps(abo, true);
+	cancel_work_sync(&abo->hmm_unreg_work);
 
 	if (abo->pinned)
 		amdxdna_gem_unpin(abo);
diff --git a/drivers/accel/amdxdna/amdxdna_gem.h b/drivers/accel/amdxdna/amdxdna_gem.h
index 5dfefdcf1356..9b4aa21a37c9 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.h
+++ b/drivers/accel/amdxdna/amdxdna_gem.h
@@ -14,13 +14,11 @@
 struct amdxdna_umap {
 	struct mmu_interval_notifier	notifier;
 	struct hmm_range		range;
-	struct work_struct		hmm_unreg_work;
 	struct amdxdna_gem_obj		*abo;
 	struct list_head		node;
 	struct kref			refcnt;
 	bool				invalid;
 	bool				unmapped;
-	bool				cleanup;
 };
 
 struct amdxdna_mem {
@@ -44,6 +42,7 @@ struct amdxdna_gem_obj {
 	struct mutex			lock; /* Protects: pinned, mem.kva, open_ref */
 	struct amdxdna_mem		mem;
 	int				open_ref;
+	struct work_struct		hmm_unreg_work;
 
 	/* Below members are initialized when needed */
 	struct drm_mm_node		mm_node; /* For AMDXDNA_BO_DEV */
-- 
2.34.1

