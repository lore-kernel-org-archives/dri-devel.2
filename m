Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC428C54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 07:08:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0D6F10F194;
	Fri, 31 Jul 2026 07:08:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5psCwIoN";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011025.outbound.protection.outlook.com [52.101.57.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C123210F190;
 Fri, 31 Jul 2026 07:08:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=US8YimmMEROMl6UlkWZc8f6RBt4FWqKk7aDwjCOskbB3s6u4rvnKOXYR2CaBtzf0/lPWx1s2U39lE6yaLeAjyKFdDt1jUuXnaGJc5/ZrkT+MaKdbq6y6PZAlx/Rg0npp7nuesUVvdIP6U9e44Dyq8kwxx6BHNpu9StNX0rPjySI3vsADEdIMPlMO94dIrk65Q/OB8RN+whB2FilrXgSyzYTlnmJtfE3pq3HLdPcANNyLd4XeWgRq9YN86FgDryiIjYN4jnvcKeyA1F2o48MBXWcb4mXgfNl+RWE70fiTXo7fGD/PLkN8MViBWP5EbyXmyTgrxBLL3rTECDB3jIsvOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MidEUMX8od+O6NUpSrHts/CZlYm+ivOx99eOVUUfTdg=;
 b=uNPn1i8N1/qFG+FJXcoJZfwgrbF/4Bp7YajiLP4GB9mF/e81ynIlryyZhxPW00VdUIDmHY7QJHJg8I57KZY5kmPxSr6tjg+onomUvk6meevTZR6lZd4nvDOu3Gwwo/DFqQXvfFBABiZKAHSNFljgTwUH2fs4hWcl+tfnoFcCNGE5EBlYyKlS1APZMeJYf3l8/1XL3rfsr8XbNuRRSRmGO5AEl9F8crNpL4LVhDPS3CATIEWqmvvT6o1It86ZzZbqXIZq3fXfkMbgEE4429iMlxspJZ/YLRatG/1c7S5hAlTQLd0N5g3878GAtepn8L3D3Me9G4BBOxeKcv9bY1m56A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MidEUMX8od+O6NUpSrHts/CZlYm+ivOx99eOVUUfTdg=;
 b=5psCwIoNn9UvKo8C6s2HTkcRyt0arGkOyaLOI8TFf4GTCk412kMqsRakdSj+oX8jOUc6oSiwuJ+eElPix8Jh4NDwcbAgPFe8k2gnWSHY5GvyijiGTTxVVonwU7yRvAgI/TR3ipURcDrmOJlrQbfPJsEM2HnzV/Spcmua6LQFKxE=
Received: from BL1P223CA0007.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::12)
 by CH3PR12MB8073.namprd12.prod.outlook.com (2603:10b6:610:126::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 07:08:01 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:2c4:cafe::c) by BL1P223CA0007.outlook.office365.com
 (2603:10b6:208:2c4::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.15 via Frontend Transport; Fri,
 31 Jul 2026 07:08:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 07:08:01 +0000
Received: from arun-nv33.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 02:07:58 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <matthew.auld@intel.com>, <christian.koenig@amd.com>,
 <dri-devel@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v7 2/2] gpu/tests/buddy: add dirty tracker performance KUnit
 test
Date: Fri, 31 Jul 2026 12:37:41 +0530
Message-ID: <20260731070741.2654251-2-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731070741.2654251-1-Arunpravin.PaneerSelvam@amd.com>
References: <20260731070741.2654251-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|CH3PR12MB8073:EE_
X-MS-Office365-Filtering-Correlation-Id: f2b50d64-f4bc-47b1-b705-08deeed27596
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|56012099006|11063799006|5023799004|6133799003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Dy0rGx+ivv0FXoAiBraqJxegDdD/7wZ+L5ULD8TJz86jUgN9A9MNOg/EyLn0XU6DKM3mNrgo4bCBYtN14sNCs1E2C2BGrQTNjLFc90cm5vIzdapAlaXJ7vFMRJ+RUQq9vRNfZZr16H6wuB8jccXdVloiaBWZvTtbdLA0gQzHzewZA9YP7G2K7XiJBQkV3oPnOcKEpGrj1EMkZANyw0sa7YTPAWHoqb7/E+K4aT2BzKl1aWsCVkyWsF3hweaaDufgDkvMhjDw2Yy5H3oCi0u0tSP80rC1+8rlSoaHdiluzPRPoo5YJCwGja9By9QH0a3mT+91funj2Xgr3rIxcfpY1itWieUS4iZPGlKVqYkUPhXYUzlogaDdgM5Kla5SxMkGYYJeDGqtn74bYf8mkzuRsXfdKaITEBWnoUIGPfK71UAdoVC5T1XnuoXUcOPRF45kH2yszRFZCVph07trnC5mzm6GXvTdcqZ+23TqOKCS8GtRFZ7QIE9X9PW9fcmYS2MjNMVnC44+AheJ6Z319hSL9OZi5VYokAINTpTyy7t0aVd95CV3NcWPAGOgL3Shx8IRMNDwwkQJhoki0bqwtASuXtubBfTdQgvHsord/8M3KGqwUW+jV/rWKDp01TTqNuIUPuT3wgokE5K+EDzqPeypgpWGIie9rzPz9lf5t7UymkZTB9aM65jOIR/FmTu6bk9dcS4YsF1CF82DZHvOp2q7wA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(5023799004)(6133799003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: w+DInls7qqiYTh4Ck9u2U6Ttp0L19F5esdztUOc1bMmW+wOQQghidR/fo5UY1tTx2LtmxJ1FOhs/N5pFnpGKVtJy7F9mZhNWkHqMd6BQaluTy6D/TgpIo7RKfFaWmpAIoDVYjmXRQAgy6F+6vsCAzz9QpTUJGAThY/JeG0HQEIfWXrJpudB1oJqM792+XLG5Lyji3LrIVhkNS3nInspgMa3wD+JlEu7LrwVAHmEyNN6Wj+YuAL7S6pNkTddiRP4OEkMrAby+hMEVuG6PCYaQ5dOA5QrAG0KKhh85HX+F22vDN4ga0PsEm8ZVH+eCeGZ18aKRxfHrdTWTvmr3B+zmLsRI1FvMglY5xUGRbc7X62zzmlYYVolVvH1KoiWPzs1Z0/1BQWQcWAZt1qs3bDF7YsjVCkU/k8EYdhgGjcINQK1V7ebA1Mxlk15eLVBqDl3Y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 07:08:01.6113 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2b50d64-f4bc-47b1-b705-08deeed27596
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8073
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

Add gpu_test_buddy_dirty_tracker_performance to demonstrate the key
advantage of the decoupled dirty-tracker design over the old dual-tree
/ force_merge approach.

The test runs two scenarios on a 4 GiB pool after alternating
clear/dirty fragmentation at 4 KiB granularity:

  1. Contiguous 4 GiB alloc: the old design requires __force_merge()
     to rebuild max_order from scratch; the new design coalesces during
     free() so the alloc is O(log N).

       old (force_merge) - 71 ms
       dirty tracker design - 17 ms

  2. Repeated 256 KiB alloc throughput: the old design pays
     __force_merge() on every alloc; the new design does not.

       old (force_merge) - 95 ms
       dirty tracker design - 24 ms

Assisted-by: Claude:claude-opus-4-8
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/tests/gpu_buddy_test.c | 110 +++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/drivers/gpu/tests/gpu_buddy_test.c b/drivers/gpu/tests/gpu_buddy_test.c
index f8e56da5058e..3fc2bfa66ee1 100644
--- a/drivers/gpu/tests/gpu_buddy_test.c
+++ b/drivers/gpu/tests/gpu_buddy_test.c
@@ -283,6 +283,115 @@ static void gpu_test_buddy_fragmentation_performance(struct kunit *test)
 	gpu_buddy_fini(&mm);
 }
 
+static void gpu_test_buddy_dirty_tracker_performance(struct kunit *test)
+{
+	struct gpu_buddy_block *block, *tmp;
+	unsigned long elapsed_ms;
+	LIST_HEAD(clear_blocks);
+	LIST_HEAD(dirty_blocks);
+	LIST_HEAD(allocated);
+	struct gpu_buddy mm;
+	LIST_HEAD(results);
+	ktime_t start, end;
+	int i, count;
+
+	/*
+	 * Contiguous alloc latency after alternating clear/dirty fragmentation
+	 *
+	 * Fill a 4 GiB pool with 4 KiB allocations, partition them into
+	 * alternating cleared and dirty sets, then free both.  In the old
+	 * dual-tree design every adjacent buddy pair has one cleared half and
+	 * one dirty half, so the pair sits on opposite sides of the clear/dirty
+	 * merge barrier and cannot be coalesced at free() time.  The pool
+	 * stays fully fragmented and the subsequent contiguous 4 GiB allocation
+	 * has to invoke __force_merge() to climb back up to max_order before
+	 * it can succeed.  With the dirty-tracker design buddy pairs coalesce
+	 * unconditionally during free(), so the pool is already at max_order
+	 * before the timed alloc begins and __force_merge() is not needed.
+	 */
+	KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_init(&mm, SZ_4G, SZ_4K),
+			       "buddy_init failed\n");
+
+	for (i = 0; i < SZ_4G / SZ_4K; i++)
+		KUNIT_ASSERT_FALSE_MSG(test,
+				       gpu_buddy_alloc_blocks(&mm, 0, SZ_4G, SZ_4K, SZ_4K,
+							      &allocated, 0),
+				       "buddy_alloc hit an error size=%u\n", SZ_4K);
+
+	count = 0;
+	list_for_each_entry_safe(block, tmp, &allocated, link) {
+		if (count++ % 2 == 0)
+			list_move_tail(&block->link, &clear_blocks);
+		else
+			list_move_tail(&block->link, &dirty_blocks);
+	}
+
+	gpu_buddy_free_list(&mm, &clear_blocks, GPU_BUDDY_CLEARED);
+	gpu_buddy_free_list(&mm, &dirty_blocks, 0);
+
+	start = ktime_get();
+	KUNIT_ASSERT_FALSE_MSG(test,
+			       gpu_buddy_alloc_blocks(&mm, 0, SZ_4G, SZ_4G, SZ_4K,
+						      &results,
+						      GPU_BUDDY_CONTIGUOUS_ALLOCATION),
+			       "contiguous alloc failed\n");
+	end = ktime_get();
+	elapsed_ms = ktime_to_ms(ktime_sub(end, start));
+
+	kunit_info(test, "Contiguous alloc after fragmentation: %lu ms\n",
+		   elapsed_ms);
+
+	gpu_buddy_free_list(&mm, &results, 0);
+	gpu_buddy_fini(&mm);
+
+	/*
+	 * Repeated alloc throughput from a maximally fragmented pool
+	 *
+	 * Fill a 4 GiB pool with 4 KiB allocations, free even-indexed blocks
+	 * as cleared and odd-indexed blocks as dirty.  The alternating pattern
+	 * ensures every adjacent buddy pair has one cleared half and one dirty
+	 * half, so each pair lands on opposite sides of the old merge barrier.
+	 * Each of the 16 384 x 256 KiB allocations in the timed loop has to
+	 * pay the __force_merge() cost on the alloc path under the old design.
+	 * With the dirty-tracker design the pool collapses to one max_order
+	 * block during free(), so each alloc is a simple O(log N) split.
+	 */
+	KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_init(&mm, SZ_4G, SZ_4K),
+			       "buddy_init failed\n");
+
+	for (i = 0; i < SZ_4G / SZ_4K; i++)
+		KUNIT_ASSERT_FALSE_MSG(test,
+				       gpu_buddy_alloc_blocks(&mm, 0, SZ_4G, SZ_4K, SZ_4K,
+							      &allocated, 0),
+				       "buddy_alloc hit an error size=%u\n", SZ_4K);
+
+	count = 0;
+	list_for_each_entry_safe(block, tmp, &allocated, link) {
+		if (count++ % 2 == 0)
+			list_move_tail(&block->link, &clear_blocks);
+		else
+			list_move_tail(&block->link, &dirty_blocks);
+	}
+
+	gpu_buddy_free_list(&mm, &clear_blocks, GPU_BUDDY_CLEARED);
+	gpu_buddy_free_list(&mm, &dirty_blocks, 0);
+
+	start = ktime_get();
+	for (i = 0; i < SZ_4G / SZ_256K; i++)
+		KUNIT_ASSERT_FALSE_MSG(test,
+				       gpu_buddy_alloc_blocks(&mm, 0, SZ_4G, SZ_256K, SZ_4K,
+							      &results, 0),
+				       "buddy_alloc hit an error size=%u\n", SZ_256K);
+	end = ktime_get();
+	elapsed_ms = ktime_to_ms(ktime_sub(end, start));
+
+	kunit_info(test, "Repeated 256 KiB allocs from fragmented pool: %lu ms\n",
+		   elapsed_ms);
+
+	gpu_buddy_free_list(&mm, &results, 0);
+	gpu_buddy_fini(&mm);
+}
+
 static void gpu_test_buddy_alloc_range_bias(struct kunit *test)
 {
 	u32 mm_size, size, ps, bias_size, bias_start, bias_end, bias_rem;
@@ -1437,6 +1546,7 @@ static struct kunit_case gpu_buddy_tests[] = {
 	KUNIT_CASE(gpu_test_buddy_alloc_range),
 	KUNIT_CASE(gpu_test_buddy_alloc_range_bias),
 	KUNIT_CASE_SLOW(gpu_test_buddy_fragmentation_performance),
+	KUNIT_CASE_SLOW(gpu_test_buddy_dirty_tracker_performance),
 	KUNIT_CASE(gpu_test_buddy_alloc_exceeds_max_order),
 	KUNIT_CASE(gpu_test_buddy_offset_aligned_allocation),
 	KUNIT_CASE(gpu_test_buddy_subtree_offset_alignment_stress),
-- 
2.34.1

