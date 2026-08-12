Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A948C5CFDB
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 21:44:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05C4410F10E;
	Wed, 12 Aug 2026 21:44:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vlQRyn8q";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010029.outbound.protection.outlook.com
 [40.93.198.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF85F10F10E
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 21:44:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vmEVxgZf8a6AtvDS6dF2IjaX7lDCH6QAmgO3QROqpsHY7Rwdz94fqGZ1q9yXEFxJ4GfSlf5tzZJF8kU4q2iVABYLK9eok0gkLA1DKukTzeURcR0OCLWLCAL3RJzgL8oSxHHExEWOBYOov61VOF9QHQ2i6wh/GV6HBwINmSwU/hzhcHOkjfx7x72x0r5K4JoYEiSUVsg13fEGYCZajNofdgmniMbkejna4l9hLTOGz6Qv6agfepSgStaxk9Wbk3Rjf1/al+mUL3BFEfo9WyEDPz6ZqLCAv/Bjv3jTVQhN/vShrM1PwPK42ijl1kUAcZB/OQS6UFWOLRB4k8ueDqANhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/mmpejhRGfbNBqMKMWTRaQ+cdwIZpTf/b0NZCtoRQo=;
 b=c3FCQndmkvkzPLZyOFTcE648wuYxrGzoOjgCMw+mOHaZVMaYJHcvwL6tjcnSHiPIeA1VgpYB+GPfBlIQLOsQD2O+t4O9kk7FN5AbLbWFPhzcTQLrKvH1Rl2/UFUiQNQhu1pE2vpySvwEHvcvBD5ptC+qrZwuPuRZJNTBlimEybZI6+oGeYiQq/P0r4clW5s+87RaQgf6N08OHrfD6M9HBxZsdfjuJ/jHecLy5uHXBuECYdTUKx5rMp6OoD09SqKOA7M+lIEwQIMUComJAlvq7W6LFwCvUPg/+0FhYD5nADQwOImgmGN2om8+qguH0a11IFkiPqlbG8xycKvYlfmw6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=amd.com; 
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/mmpejhRGfbNBqMKMWTRaQ+cdwIZpTf/b0NZCtoRQo=;
 b=vlQRyn8qIQ0B9g0xuixYKYQav+WojF95UN3Hy98dlbTfUxvQI96PJGXKRAM9GBfRe7et8Schmf23tgbnIhO6MGW+qtyKVS8hS3nF5GXjcZxc7wLXjUqao4MPoJZm2sMVfkfjwCcptNgZOiqC+pYVXCaQyCDpbUYObYk8xFKmPqo=
Received: from BN9PR03CA0232.namprd03.prod.outlook.com (2603:10b6:408:f8::27)
 by CH3PR12MB8233.namprd12.prod.outlook.com (2603:10b6:610:129::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Wed, 12 Aug
 2026 21:44:20 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:408:f8:cafe::3c) by BN9PR03CA0232.outlook.office365.com
 (2603:10b6:408:f8::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Wed,
 12 Aug 2026 21:44:20 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Wed, 12 Aug 2026 21:44:19 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 12 Aug
 2026 16:44:19 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Wed, 12 Aug 2026 16:44:18 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>
Subject: [PATCH V1] accel/amdxdna: Fix unexpected wait when flushing
 notifier_wq
Date: Wed, 12 Aug 2026 14:44:03 -0700
Message-ID: <20260812214403.817307-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|CH3PR12MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: 119af8f9-ff8f-48a6-380a-08def8badd87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: HdZLB6st+D9UnaAWNvQ3wHBoegfDSiR9Uml/m1enzE34ZKVNd7fdMuHQ0Zw35yF0Z1y1BIWhg80XJrUA/XKHxuWtcL/HTjJH4+IfNAub8LmqTvloWwM3cxWyUoXKazE6R0ON5nHEAC8g/D4nW7kALykyK0rflRW25pe+tHB0GlFJRP0DeBGAsV6WWGQAvD0K8eh68IOB9TtxrDyU9tdTaUOqnlMmKPJBXBH9hI0KWDrwz2NAuz754a/97Wm24lDUVJaP9kUtY0Dek4R5U98SsunrNEBs/brM9EvxwSrJk3G18RqAfe3uRtCZ7P2TV4sPSQLbj3yjO0z58swcXjoAZO1IR9AJeKZMnc3OFoBGG7UIO0juK0Sq/dZzAPYgAI2+BTV/RwMtrZxv+yuOi9aEULHncYBGqEd3O/hsO8C2kGqIEotwCHT/easa6tr2rjYdxoeJheLNHqE0jq177MdG5UPzgUTZLubyKz62gCqwCF/HsJcFJGO84kFjf99l1b3bYqp+2AvHKKePt3m0tI1LEuhXb5DJ3xMhG8ieE9Zw+xvEFrxqeK2DQwQknoBBlDAEvdKfMYqfgwbSdbXpl6hjIH3lix2o6ZZdQJfwEb97/EieCLbZBRriLkfblDwWNQyHxizjDvShlQzcp2cQcdprrR2e/ae9dKHUNqhNcJyJiM3Xo6acYSiHWtRbvKKIpqaDAuYV3jUFDvlm1hTeb3KeJw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vQW3tuJYUMNEWLRwh9S1v3Qa+H5rISHV4rb3909xFjUn9Mbm82r7EzIpVeMQ/QeqnZHak4OCr325WJrGvXxwnJUWrUTp16eGrKedmxePn/VCthtK4ibV5Il75YXkQwEyva08JyovZ/iWnmda3j89/PfV2BqUg9fwdfjJqTKOyuaHx7wv5AhHThQTI2VWFJx5fJ3n/Umby1RagAUcu1VZ6rtAU338THLya5Pm85jLdqipuk5vhc4az0NLlGC+AbeV0n+P5DGX8iaFBBx59cZUIef9G8bMJSRL9O95p/Nl12zrHwEh6Zu6Eq6UEbsjEHBl/vK/3Wj2t+algYG7sj4aBhVxbduOHOEpKqL33XzU86YTkkKQcnGEa6ZMyAt/tyufzGaxIaseEPd5411Ythspthr9lqGu4H+0CYi4/g23fVU95IpWtrn7Xl/Yognr0W6M
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 21:44:19.6976 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 119af8f9-ff8f-48a6-380a-08def8badd87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8233
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

In amdxdna_gem_obj_free(), flush_workqueue(xdna->notifier_wq) waits for
all pending work items on the device-global notifier workqueue, rather
than only the work items associated with the BO being freed.

If another BO has a pending hmm_unreg_work, freeing an unrelated BO can
be unnecessarily blocked until that work completes.

mmu_interval_notifier_remove() is deferred to a workqueue because it
cannot be called from the MMU notifier callback itself. The BO free path
is not a notifier callback, so call mmu_interval_notifier_remove()
directly there and avoid the workqueue.

Fixes: e486147c912f ("accel/amdxdna: Add BO import and export")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/amdxdna_gem.c | 60 +++++++++++++++++++----------
 drivers/accel/amdxdna/amdxdna_gem.h |  1 +
 2 files changed, 41 insertions(+), 20 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index 1c63eff0a4a8..d6aa862e2d5b 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -301,33 +301,40 @@ static void amdxdna_hmm_unregister(struct amdxdna_gem_obj *abo,
 
 	down_write(&xdna->notifier_lock);
 	list_for_each_entry(mapp, &abo->mem.umap_list, node) {
-		if (!vma || compare_range(mapp, vma->vm_mm, vma->vm_start, vma->vm_end)) {
-			if (!mapp->unmapped) {
-				queue_work(xdna->notifier_wq, &mapp->hmm_unreg_work);
-				mapp->unmapped = true;
-			}
-			if (vma)
-				break;
-		}
+		if (!compare_range(mapp, vma->vm_mm, vma->vm_start, vma->vm_end))
+			continue;
+
+		queue_work(xdna->notifier_wq, &mapp->hmm_unreg_work);
+		mapp->unmapped = true;
 	}
 	up_write(&xdna->notifier_lock);
 }
 
-static void amdxdna_umap_release(struct kref *ref)
+static void amdxdna_hmm_unregister_all(struct amdxdna_gem_obj *abo)
 {
-	struct amdxdna_umap *mapp = container_of(ref, struct amdxdna_umap, refcnt);
-	struct amdxdna_gem_obj *abo = mapp->abo;
-	struct amdxdna_dev *xdna;
-
-	mmu_interval_notifier_remove(&mapp->notifier);
+	struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(abo)->dev);
+	struct amdxdna_umap *mapp, *tmp;
+	LIST_HEAD(dead);
 
-	xdna = to_xdna_dev(to_gobj(mapp->abo)->dev);
 	down_write(&xdna->notifier_lock);
-	list_del(&mapp->node);
-	if (list_empty(&abo->mem.umap_list))
-		abo->mem.uva = AMDXDNA_INVALID_ADDR;
+	list_for_each_entry_safe(mapp, tmp, &abo->mem.umap_list, node) {
+		mapp->unmapped = true;
+		mapp->cleanup = true;
+		list_move(&mapp->node, &dead);
+	}
 	up_write(&xdna->notifier_lock);
 
+	list_for_each_entry_safe(mapp, tmp, &dead, node) {
+		cancel_work_sync(&mapp->hmm_unreg_work);
+		amdxdna_umap_put(mapp);
+	}
+}
+
+static void amdxdna_umap_release(struct kref *ref)
+{
+	struct amdxdna_umap *mapp = container_of(ref, struct amdxdna_umap, refcnt);
+
+	mmu_interval_notifier_remove(&mapp->notifier);
 	kvfree(mapp->range.hmm_pfns);
 	kfree(mapp);
 }
@@ -341,6 +348,20 @@ static void amdxdna_hmm_unreg_work(struct work_struct *work)
 {
 	struct amdxdna_umap *mapp = container_of(work, struct amdxdna_umap,
 						 hmm_unreg_work);
+	struct amdxdna_gem_obj *abo = mapp->abo;
+	struct amdxdna_dev *xdna;
+
+	xdna = to_xdna_dev(to_gobj(mapp->abo)->dev);
+	down_write(&xdna->notifier_lock);
+	if (mapp->cleanup) {
+		up_write(&xdna->notifier_lock);
+		return;
+	}
+
+	list_del(&mapp->node);
+	if (list_empty(&abo->mem.umap_list))
+		abo->mem.uva = AMDXDNA_INVALID_ADDR;
+	up_write(&xdna->notifier_lock);
 
 	amdxdna_umap_put(mapp);
 }
@@ -643,8 +664,7 @@ static void amdxdna_gem_obj_free(struct drm_gem_object *gobj)
 	struct amdxdna_dev *xdna = to_xdna_dev(gobj->dev);
 	struct amdxdna_gem_obj *abo = to_xdna_obj(gobj);
 
-	amdxdna_hmm_unregister(abo, NULL);
-	flush_workqueue(xdna->notifier_wq);
+	amdxdna_hmm_unregister_all(abo);
 
 	if (abo->pinned)
 		amdxdna_gem_unpin(abo);
diff --git a/drivers/accel/amdxdna/amdxdna_gem.h b/drivers/accel/amdxdna/amdxdna_gem.h
index 1e90e32bf3cd..fb033ced1045 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.h
+++ b/drivers/accel/amdxdna/amdxdna_gem.h
@@ -20,6 +20,7 @@ struct amdxdna_umap {
 	struct kref			refcnt;
 	bool				invalid;
 	bool				unmapped;
+	bool				cleanup;
 };
 
 struct amdxdna_mem {
-- 
2.34.1

