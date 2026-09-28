Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 840B5CA5FA6
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 17:52:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C54010E950;
	Mon, 28 Sep 2026 17:52:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OrHkv8Ij";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013065.outbound.protection.outlook.com
 [40.93.196.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A2B410E098;
 Mon, 28 Sep 2026 17:52:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h+NrcNrMN1nr4k+fiFAMjnwqUtSe/T/O6WkCOJ8yGOSLoXERYr8lhi9lh+3RDdfUCxvAhSeIgSWyJbcCqOhdqM79RTzexnGL7OtJU/A1nR6H+pRgnUZL1rrH1cSiX1/ND94ETnRkn7GRpKiGNX41BI1IevC24ZEy+qN1lMLMZvEO3BXQRYokc2bNxd6Gki+skefWkz5z3RrrZjjSmNjOIqgNdQ5nokMevwh4ibvgIdJ+0xJ7tMOQJMBjgRHHUVrC0BDudp36zJDenBuoUTvVtYdvriruo1PnUhmz12dIv95pckWmgJqYbBxnhfNsh0u1ISYh03ZAzs6MLXtxvWM6/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxpPLdOSVxBdeXvvm0/Y5++4DhOo+DvfnJu50qGKSFc=;
 b=aLGpMIqqsPwY59kXvqe1fhWpD14IyJE8NZP8USBLOxoPhND0ebQ1QsXlw5gi4xDi5mMevYtrO57qvvDxTdUwap+qeNrR085G2W/XIaVJ5b+apUmDFbf5X9yS6gY9zaaSh9V/bwd/6sAqKSeWaX5uiTs/sNbV9JrPN86G3n/KgzVrpQGni+7MvnLPy46h0+xULHOHCIYVhbZD/auL3dj2OOOgwxRB1F11GSX2puxWOosX0L3JPdO7NbsGIW7BVVlsHrA73IifTFUGf3eEtq2XP6fwot8cQW6kcg93Mq5SRiB9/TTn+xPZNk5n1P874FO9BjDDttPtRyBlK7XuYdFxZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxpPLdOSVxBdeXvvm0/Y5++4DhOo+DvfnJu50qGKSFc=;
 b=OrHkv8Ij/xCnGqc37UDHDsB9Tf5wCHCYiwiTAULDmx8m1EyLoP1G6x31qyGh1l2izGHpux/PTXn2HzK1CGX9YQotL0epDjawLZCt8hkuyQS9v3LXHzS/mc3vi/KwFh6FQeF+DMsXl8yAGuH+PWjWkgmLjy3T7/GFWecz29e52hc=
Received: from MN2PR15CA0045.namprd15.prod.outlook.com (2603:10b6:208:237::14)
 by SA1PR12MB8841.namprd12.prod.outlook.com (2603:10b6:806:376::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 17:51:55 +0000
Received: from BN1PEPF00018547.namprd05.prod.outlook.com
 (2603:10b6:208:237:cafe::86) by MN2PR15CA0045.outlook.office365.com
 (2603:10b6:208:237::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Mon,
 28 Sep 2026 17:51:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018547.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 28 Sep 2026 17:51:55 +0000
Received: from rtg-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 28 Sep 2026 12:51:51 -0500
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
To: <matthew.auld@intel.com>, <dri-devel@lists.freedesktop.org>,
 <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <Anand.Raghavendra@amd.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH 1/2] gpu/buddy: fix missing split-undo on allocation-search
 exhaustion
Date: Mon, 28 Sep 2026 23:21:27 +0530
Message-ID: <20260928175128.257266-1-arunpravin.paneerselvam@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018547:EE_|SA1PR12MB8841:EE_
X-MS-Office365-Filtering-Correlation-Id: 042d45b8-1fe0-4326-faf5-08df1d892f47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: EGuv61OFBl4K8M19ES3ZGlLlQwNMVFaKU/THCxNXOg6bVZaMz3tD2Nc5u8navy0P0csx9Do/nKmpoHiqw+YF9xbAm5AeSLboZ2CmjqGXwMHFM70eHFAC9j3fEzYg98/ed6eWjSqOy5fJCCaUsBBm3+AOJirxYSz9wiZNMTujnYH2euFoGPOqcZ4We/07IjstgKuGnS7eDGIVvOHuBZsIo/uOAVf5o9+oRyPPq/lZU4XUytbLsFAb7cnckvXATUOphWY4Nqlyt82NE8sVk4cu3s60adnxKcZDIG9Y1WmGmwtWixtk9QsdiGefSr7avod+tohcaDWGqUGj3GjlGKGnRkQ5uO0YhS7zXobKiB+MWsHJSi/jmgHVCwcqPd4fyrYHFlL+5CTNGt4qwX7cO1QKllyeM10KYAVVXqmGKZ+fXMqTgGmvIxS7AUAYp+Ml4kJ1xDmiM6uerRt3+DPgyIUb/56b/gm/8PyqPjOAqA5w+y8jgXT7ksL9DyHVRpwk6bkcrAjsUB/reVaa3KyYaLaGlwkdYM/9Cg4YOEfHp9LX62WhKAGkqyVz/dKM0PaAUN2YQk6xPFw1tVCiK3zFyel4aqlJ1BQ26VNtcWRVghkemvfMolBz0YPAhN42FpNtD9F8dv7We/jTnVrwQTslZXx+9ctbYDpaSZLlrZXPGK1tq5bwxZBkdFltC4+TROJqarxgjmZb71b8s4irmSzZhUeVXA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ny1osJYez7wMc0EPDrtm9dUlNrYMZGv7RPvI6ZnQI2fQZ5g0xsENt5NRo8v+xiFS74HfaA7u95gJQpAkANhiLsvnkX+TLEa4h99ASQmjlBZVxc4co3FokSStNxxTnaHJpzRlKoC+Py8c003yFdH0E2TU+oL2RtnAO68updBlL3bBRPifZK5I0beSkSOGuci0+JHulMRpqg6i6ZxOpwCviIA0nGyeM8HDFeBAZegN6b4bOWHPEGf6O77XagOQvDre7NxF5mDrN/9ZHaMh76FG+sg8kh3RbTz2CNBNdl0g+qIhEfg2q94kmEsIWEokf/W8cWs2Lwb0WCB6kOJuvsZz8JNHyq2+3acsgffvR3c/rkelpH/KGDbC4ur72CJpoILUIBdjmtwIkXEvhzqMlJNViViZdKzJJR05UKcqzJX1XTiV0Nbme7A6twws8HU6vgPn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 17:51:55.0447 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 042d45b8-1fe0-4326-faf5-08df1d892f47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018547.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8841
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

From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

__alloc_range_bias() and __alloc_range() only undid splits made during
their search when split_block() itself failed. Their DFS-exhaustion
failure paths (-ENOSPC, when no suitable block is found) skipped the
undo, leaving the buddy tree needlessly fragmented over repeated
failed allocation attempts.

Fix by recording every successful split_block() call in a list and
unconditionally undoing those splits on every failure exit, via a
new single-level gpu_buddy_merge_one_level() helper (the original
__gpu_buddy_undo_splits() cascaded merges upward, which is unsafe
when called per split-list entry).

Resolves the igt@kms_plane@plane-panning-bottom-right@pipe-a/pipe-b
regression.

Fixes: 1ad5e807f716 ("gpu/buddy: replace dual-tree/force_merge with decoupled dirty tracker")
Assisted-by: Claude:claude-opus-4-8
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/buddy.c | 64 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 58 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
index 2f2aaadafe35..b741160d3d16 100644
--- a/drivers/gpu/buddy.c
+++ b/drivers/gpu/buddy.c
@@ -1240,6 +1240,52 @@ static void __gpu_buddy_undo_splits(struct gpu_buddy *mm,
 	}
 }
 
+static void gpu_buddy_merge_one_level(struct gpu_buddy *mm,
+				      struct gpu_buddy_block *block)
+{
+	struct gpu_buddy_block *buddy = __get_buddy(block);
+	struct gpu_buddy_block *parent = block->parent;
+	enum gpu_block_state block_state;
+
+	if (!buddy || !gpu_buddy_block_is_free(block) ||
+	    !gpu_buddy_block_is_free(buddy))
+		return;
+
+	block_state = gpu_block_cached_state(block);
+	if (gpu_block_cached_state(buddy) != block_state)
+		block_state = GPU_BLOCK_MIXED;
+
+	rbtree_remove(mm, block);
+	rbtree_remove(mm, buddy);
+	mm->free_scoreboard[gpu_buddy_block_order(block)] -= 2;
+
+	gpu_block_free(mm, block);
+	gpu_block_free(mm, buddy);
+
+	__mark_free(mm, parent, block_state);
+}
+
+static void gpu_buddy_undo_splits(struct gpu_buddy *mm,
+				  struct gpu_buddy_block *block,
+				  struct list_head *splits)
+{
+	if (block)
+		gpu_buddy_merge_one_level(mm, block);
+
+	while (!list_empty(splits)) {
+		struct gpu_buddy_block *parent =
+			list_first_entry(splits, struct gpu_buddy_block,
+					 tmp_link);
+
+		list_del(&parent->tmp_link);
+
+		if (!gpu_buddy_block_is_split(parent))
+			continue;
+
+		gpu_buddy_merge_one_level(mm, parent->left);
+	}
+}
+
 static struct gpu_buddy_block *
 __alloc_range_bias(struct gpu_buddy *mm,
 		   u64 start, u64 end,
@@ -1249,6 +1295,7 @@ __alloc_range_bias(struct gpu_buddy *mm,
 	u64 req_size = mm->chunk_size << order;
 	struct gpu_buddy_block *block;
 	LIST_HEAD(dfs);
+	LIST_HEAD(splits);
 	int err;
 	int i;
 
@@ -1313,6 +1360,8 @@ __alloc_range_bias(struct gpu_buddy *mm,
 			err = split_block(mm, block);
 			if (unlikely(err))
 				goto err_undo;
+
+			list_add(&block->tmp_link, &splits);
 		}
 
 		/*
@@ -1349,7 +1398,7 @@ __alloc_range_bias(struct gpu_buddy *mm,
 		}
 	} while (1);
 
-	return ERR_PTR(-ENOSPC);
+	err = -ENOSPC;
 
 err_undo:
 	/*
@@ -1357,7 +1406,8 @@ __alloc_range_bias(struct gpu_buddy *mm,
 	 * bigger is better, so make sure we merge everything back before we
 	 * free the allocated blocks.
 	 */
-	__gpu_buddy_undo_splits(mm, block);
+	gpu_buddy_undo_splits(mm, block, &splits);
+
 	return ERR_PTR(err);
 }
 
@@ -1580,6 +1630,7 @@ static int __alloc_range(struct gpu_buddy *mm,
 	struct gpu_buddy_block *block;
 	u64 total_allocated = 0;
 	LIST_HEAD(allocated);
+	LIST_HEAD(splits);
 	u64 end;
 	int err;
 
@@ -1605,7 +1656,7 @@ static int __alloc_range(struct gpu_buddy *mm,
 
 		if (gpu_buddy_block_is_allocated(block)) {
 			err = -ENOSPC;
-			goto err_free;
+			goto err_undo;
 		}
 
 		if (contains(start, end, block_start, block_end)) {
@@ -1634,6 +1685,8 @@ static int __alloc_range(struct gpu_buddy *mm,
 			err = split_block(mm, block);
 			if (unlikely(err))
 				goto err_undo;
+
+			list_add(&block->tmp_link, &splits);
 		}
 
 		list_add(&block->right->tmp_link, dfs);
@@ -1642,7 +1695,7 @@ static int __alloc_range(struct gpu_buddy *mm,
 
 	if (total_allocated < size) {
 		err = -ENOSPC;
-		goto err_free;
+		goto err_undo;
 	}
 
 	list_splice_tail(&allocated, blocks);
@@ -1655,9 +1708,8 @@ static int __alloc_range(struct gpu_buddy *mm,
 	 * bigger is better, so make sure we merge everything back before we
 	 * free the allocated blocks.
 	 */
-	__gpu_buddy_undo_splits(mm, block);
+	gpu_buddy_undo_splits(mm, block, &splits);
 
-err_free:
 	if (err == -ENOSPC && total_allocated_on_err) {
 		list_splice_tail(&allocated, blocks);
 		*total_allocated_on_err = total_allocated;

base-commit: 90780f2c3d30187116128f71bcf92c8ab63400e7
-- 
2.43.0

